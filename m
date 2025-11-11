Return-Path: <linux-kernel+bounces-894556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48003C4B4BB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 04:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7367C3B2BFB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 03:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708BB34A764;
	Tue, 11 Nov 2025 03:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h2cHmdpY"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0022230FC24
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 03:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762831104; cv=none; b=c+LjweRpFM5joZNO4uye5BReVS/NG394nN5RPikH0bPvz9KmVXfAZUUKepkF1sWRvabZlCgpA4t18f59kClwuPF28Su1g+9fLeoHBIEjwJgianqh+mpHX1b/WvJiKHzPDdQj5pPgjx1zwWV6SqsVDiXnqaO2tPeaZzchs5qCcus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762831104; c=relaxed/simple;
	bh=pCXkJegjuRcItgOkKeQjVBrasAklm08f730oR1mmvoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iK/Ju09FjVKKPvoEaf6f4sK7cvqj4SqiVQBDgkKZdtt0GuILHy9T5aRum5tUJbNV37xDWAXYBTIiFOFnOJvdSsjTVR2lzMPSo0nLJDuNVyOCNecYhWkE43IWmxF1zQtgjCVDm5J+jBp3YfgK0Ofp8g2Zb7phUtfJsVwO0v5OO4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h2cHmdpY; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762831100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ho3VRKU3eH3eGL2Jbykm8Aw0VkpNiJyYt4cL5izQMs4=;
	b=h2cHmdpYo9lnYmkJDxQErlRaEHTGVwPYKTV1a/tE3JPoz+r4zzxj4HFS/UFrlUM/XhZ4pg
	fFBCXi0JO5PkR4rHHn33LKygrlNZxVQNaMXOZnQq4LzJWcWwSjc2OwZrSBOQS09QnP46MW
	K7My15UwrrCtOGa9xNOiLP/YHSpK6Ww=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>, Song Liu <song@kernel.org>
Cc: ast@kernel.org, song@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, jiang.biao@linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH bpf] bpf: handle the return of ftrace_set_filter_ip in
 register_fentry
Date: Tue, 11 Nov 2025 11:17:55 +0800
Message-ID: <2243551.irdbgypaU6@7950hx>
In-Reply-To: <2806193.mvXUDI8C0e@7950hx>
References:
 <20251110120705.1553694-1-dongml2@chinatelecom.cn>
 <CAHzjS_vj26p7SwVupAb0XyTZs__NProJ+CN6DKy+-E1R+Wk33Q@mail.gmail.com>
 <2806193.mvXUDI8C0e@7950hx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/11/11 08:59, Menglong Dong wrote:
> On 2025/11/10 23:49, Song Liu wrote:
> > On Mon, Nov 10, 2025 at 4:07=E2=80=AFAM Menglong Dong <menglong8.dong@g=
mail.com> wrote:
> > >
> > > The error that returned by ftrace_set_filter_ip() in register_fentry(=
) is
> > > not handled properly. Just fix it.
> > >
> > > Fixes: 00963a2e75a8 ("bpf: Support bpf_trampoline on functions with I=
PMODIFY (e.g. livepatch)")
> > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > > ---
> > >  kernel/bpf/trampoline.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > LGTM. Thanks for the fix!
> >=20
> > Acked-by: Song Liu <song@kernel.org>
> >=20
> > Can we add a test for this code path?
>=20
> I think it can be done by attach a fentry to a notrace function and
> check the error number.

Hmm...it's a little difficult to trigger this problem, as attaching a
notrace function won't go to this code patch ;|

>=20
> Let me have a try.
>=20
> >=20
> > Song
> >=20
> >=20
>=20
>=20
>=20
>=20
>=20
>=20





