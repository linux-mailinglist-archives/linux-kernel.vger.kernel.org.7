Return-Path: <linux-kernel+bounces-849198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 46437BCF7CF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 17:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E51B64E48B2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 15:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CACE27E7DF;
	Sat, 11 Oct 2025 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a87k1XjB"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310C925394C
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 15:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760195407; cv=none; b=sEFrOcjWlgZAM/cTyX5ynpTiJ0ISo/5fORAGKKh2CuGYltpjmhchgToAefCdhSi/0jGNu0tXGHONJTAODXEmOilz2a3GGuynSYdKNgqnKa94RJgXA6225AiuasF3PZPo4A8lTWjT8BZPtdUXVP/mvjChNjKHdeGSxoiDNUEnqGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760195407; c=relaxed/simple;
	bh=B9H6A8H7sBLSRT0XPrP4eKlzyZjEL7QhCJoTByvxMfQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hwyZuQ1iZsS4rpwjFp4xOOirqYgdYN7VeWLhR+hvhjglKXVU+lKmA9gROczuFkjH5aQzL8IC0+rikYl9r9uQQJz7DW5tbQy8T6xrgZJONLKIJ49E+i8PlsqOyb0zsQbKSSrFo0gMVRElLRKb6NLTXWDbJhrME1//Cj1NNIpSJOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a87k1XjB; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2cf1e3614241abf51a0db5ac435b2f673895a607.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760195393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B9H6A8H7sBLSRT0XPrP4eKlzyZjEL7QhCJoTByvxMfQ=;
	b=a87k1XjBGpn98bcxHAjARTXzdyuS1CxB59y+TnyAq5tHaWuVf5qJ0gxjULzvWRLveRPHAd
	wWGHCG2lcDFKtbRld99KktELa/6qNbXZCzWwG/zRnulpaqDNBAaCxAeL9oB3VmXkt4vGqF
	a613lZKu3PTItMS4x35bZ4lO0Srlumc=
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Add test for unpinning htab
 with internal timer struct
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Shuah Khan <shuah@kernel.org>, Toke
 =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>, LKML
 <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, "open
 list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Date: Sat, 11 Oct 2025 23:09:40 +0800
In-Reply-To: <CAADnVQJL0FuK1oodJrLOFrtEFyVbYV1PP9S5VZm-_imztkocgg@mail.gmail.com>
References: <20251008102628.808045-1-kafai.wan@linux.dev>
	 <20251008102628.808045-3-kafai.wan@linux.dev>
	 <CAADnVQJL0FuK1oodJrLOFrtEFyVbYV1PP9S5VZm-_imztkocgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Fri, 2025-10-10 at 10:28 -0700, Alexei Starovoitov wrote:
> On Wed, Oct 8, 2025 at 3:27=E2=80=AFAM KaFai Wan <kafai.wan@linux.dev> wr=
ote:
> >=20
> > Add test to verify that unpinning hash tables containing internal timer
> > structures does not trigger context warnings.
> >=20
> > Each subtest (timer_prealloc and timer_no_prealloc) can trigger the
> > context warning when unpinning, but the warning cannot be triggered
> > twice within a short time interval (a HZ), which is expected behavior.
>=20
> It was difficult to decipher the above paragraph.
> I think you're referring to throttling logic in __might_resched().
>=20
> I kept it as-is while applying, but in the future either skip
> such low level implementation detail or expand it.
> Here you could have said that the error is printed by __might_resched()
> which prints it once a HZ.

OK, I understand. Thanks for your feedback and guidance.

--=20
Thanks,
KaFai

