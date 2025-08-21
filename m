Return-Path: <linux-kernel+bounces-780408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66763B30182
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48DDC172E09
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFC3341672;
	Thu, 21 Aug 2025 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="eiXt+pRp"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B548830E830;
	Thu, 21 Aug 2025 17:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755798889; cv=none; b=EGCzssBXJSDZOMQ1P5ahW+PqWpHTJGLY3L8gfJPnjiwAkWNFWoR0c+xioMozypl0YOzEDKahPtWlUM4IimmY2EebuqwLQcp1sywoxUUvzLsPT4mCHFHwh8jZet0uPGVCguAfwZjWKV1DrWnVCjPJV0JvlYiIm799qWV4TsqqVB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755798889; c=relaxed/simple;
	bh=V5L8h3sX5rEqLSjnCWbcr6Qxa6m6MIuwEc8H917RD3k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VzKPYY7v6rMc+FhlioUo39RwCMJZrRK1JCMreFZoeGROhCigmAXyCh8DLamLaUEKgng0Ym2VYG01voTeWRVpT6/PUPXw3UKB58rWRaeONTWThIw5CpyH/hJ9ukhW6ODVggQFuFwHw/eZrnaF/KR7MP32FwQnZ6w/HCiv0RsWDwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=eiXt+pRp; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DD2EA40AB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755798887; bh=nbApuhoFJodGrDTSe1CPU4IgkEt8JKZP/RWZWlCog44=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eiXt+pRp8x+i1QVLG+MFD3RdRU75d8htKOiZzHwhdCH0epyHz33u49+IHHXh/hgAZ
	 sUFmuG1kf6bzje7PR2cZiiD9PEyD9XcJyMqK1wRH1/Oaw1pKH+ypBfDNcvBMrAh0HI
	 mMgg9MnPw+dExJ57Gx75OhU1nUAtKsoBYKxqT4oFz41O3niL8gm1rRJL1zBrsFlWpH
	 SDGTIIxYgiIMvjlq7arpBfTeNolNkdOu8vwo5i7LNh+nuzzXQ37HidjAZORT/wIftk
	 QbvlW+oo79lB/7gYltoe0XISXqQEVRqD6cZDKM5rsOipPnkDta7/MqhYrT+MbdqAXz
	 gTz+bdbVHiBcA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id DD2EA40AB4;
	Thu, 21 Aug 2025 17:54:46 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Nikil Paul S <snikilpaul@gmail.com>, linux-doc@vger.kernel.org
Cc: skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, snikilpaul@gmail.com,
 "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v4] docs: rcu: Replace multiple dead OLS links in RTFP.txt
In-Reply-To: <20250819180545.3561-2-snikilpaul@gmail.com>
References: <20250819180545.3561-2-snikilpaul@gmail.com>
Date: Thu, 21 Aug 2025 11:54:45 -0600
Message-ID: <87h5y07e6y.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nikil Paul S <snikilpaul@gmail.com> writes:

> This patch updates several dead OLS links in RTFP.txt, replacing them
> with working copies hosted on kernel.org.
>
> Originally posted as part of a 2-patch series, this is now being sent
> as a standalone v4 patch to avoid confusion.
>
> Changes since v3:
>  - No change in content, only resubmitted as a single patch instead of
>    "2/2" from the earlier series.
>
> Signed-off-by: Nikil Paul S <snikilpaul@gmail.com>
> ---
>  Documentation/RCU/RTFP.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

So this looks good to me, but it should really be run past the RCU folks
(and Paul in particular) as well; adding him to the CC.

Thanks,

jon

> diff --git a/Documentation/RCU/RTFP.txt b/Documentation/RCU/RTFP.txt
> index db8f16b392aa..8d4e8de4c460 100644
> --- a/Documentation/RCU/RTFP.txt
> +++ b/Documentation/RCU/RTFP.txt
> @@ -641,7 +641,7 @@ Orran Krieger and Rusty Russell and Dipankar Sarma and Maneesh Soni"
>  ,Month="July"
>  ,Year="2001"
>  ,note="Available:
> -\url{http://www.linuxsymposium.org/2001/abstracts/readcopy.php}
> +\url{https://kernel.org/doc/ols/2001/read-copy.pdf}
>  \url{http://www.rdrop.com/users/paulmck/RCU/rclock_OLS.2001.05.01c.pdf}
>  [Viewed June 23, 2004]"
>  ,annotation={
> @@ -1480,7 +1480,7 @@ Suparna Bhattacharya"
>  ,Year="2006"
>  ,pages="v2 123-138"
>  ,note="Available:
> -\url{http://www.linuxsymposium.org/2006/view_abstract.php?content_key=184}
> +\url{https://kernel.org/doc/ols/2006/ols2006v2-pages-131-146.pdf}
>  \url{http://www.rdrop.com/users/paulmck/RCU/OLSrtRCU.2006.08.11a.pdf}
>  [Viewed January 1, 2007]"
>  ,annotation={
> @@ -1511,7 +1511,7 @@ Canis Rufus and Zoicon5 and Anome and Hal Eisen"
>  ,Year="2006"
>  ,pages="v2 249-254"
>  ,note="Available:
> -\url{http://www.linuxsymposium.org/2006/view_abstract.php?content_key=184}
> +\url{https://kernel.org/doc/ols/2006/ols2006v2-pages-249-262.pdf}
>  [Viewed January 11, 2009]"
>  ,annotation={
>  	Uses RCU-protected radix tree for a lockless page cache.
> -- 
> 2.43.0

