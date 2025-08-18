Return-Path: <linux-kernel+bounces-773431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36477B29FF1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9ACD1796B5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E222C2377;
	Mon, 18 Aug 2025 11:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RWsMSE70"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D172C234D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 11:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514997; cv=none; b=dv/MOHmS+SnC80+2o7eaHTq5/6Zo5pI4IoDCmZ0GGpTtnCs2/+g+xCpRZ4uIl2YMp09AtPaYVnUohzeKIrcm7O437CIcI+fa5sriLvjTnelpeNYhhg9EgvEhcb3XlS/a0duFhzdfE+UDlVRIQO3JPGAq6n9ahPCrY9tcLO6hyQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514997; c=relaxed/simple;
	bh=Jq97YFMSkfqEPO2hnYJmrO69wEVR70Pg+RH1yZge4sE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=T6SRGjFdx+PXHkHp7L57nBDxywdAqdp5fPM++40kA9n947qf0oT0LQzmxtaOyXCqOtJkcBqJoZiKC1bL1osHMvCNlphvKwMIpTbyoyYVkIWl81VbsvNqTMs+f+DWG10HNL1dzwR2j3i00iqPRM/nXNj468TI7WVqdCkbzjHv+wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RWsMSE70; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755514993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jR1+iDORHzD/2awTkVG9xaSKRiRjCiMSIKpDIjWMyO8=;
	b=RWsMSE70UIACg6PzPqMBOrSZqJrNhTwh0S7SNwl3hOVym+E844QH6bLE4ClF5GQguWt4iO
	ZPD3wt4hcw5gc3PC+ZVZdb1CiOdF207wGfhEg3fmJEk4dLCdsKc7gNYDubgyG9L9BRAM/Q
	2UtVekbDwObJ5Kw/epzU3DqAPzLYzHg=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] kdb: Replace deprecated strcpy() with strscpy()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <CAD=FV=W1tgwvajXD6mcggHKy=Q7EN8wLx4nSJgy0NJBzHLBnSg@mail.gmail.com>
Date: Mon, 18 Aug 2025 13:02:59 +0200
Cc: Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 Zhang Heng <zhangheng@kylinos.cn>,
 linux-hardening@vger.kernel.org,
 kgdb-bugreport@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A627E42A-1F2C-4807-B2AD-089D94FCB210@linux.dev>
References: <20250718213725.348363-2-thorsten.blum@linux.dev>
 <CAD=FV=W1tgwvajXD6mcggHKy=Q7EN8wLx4nSJgy0NJBzHLBnSg@mail.gmail.com>
To: Doug Anderson <dianders@chromium.org>
X-Migadu-Flow: FLOW_OUT

Hi Doug,

On 19. Jul 2025, at 00:48, Doug Anderson wrote:
> On Fri, Jul 18, 2025 at 2:40=E2=80=AFPM Thorsten Blum wrote:
>>=20
>> strcpy() is deprecated; use strscpy() instead.
>>=20
>> Link: https://github.com/KSPP/linux/issues/88
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
>> kernel/debug/kdb/kdb_support.c | 4 +++-
>> 1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> nit: Since this only covers things in the file `kdb_support.c` and not
> everything in kernel/debug/kdb, perhaps that should be in the subject
> line? Maybe "kdb: Replace deprecated strcpy() with strscpy() in
> kdb_strdup()"?
>=20
> Other than that, this looks fine to me.
>=20
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

I'm preparing a patch series for Daniel with my kdb changes.

For this one here, I initially used:

	strscpy(s, str, n);
	return s;

to replace 'return strcpy(s, str);', but now prefer:

	memcpy(s, str, n);
	return s;

because we already know the string length 'n'.

Can I keep your Reviewed-by: tag when making this change and submitting
it as part of a patch series?

Thanks,
Thorsten


