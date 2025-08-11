Return-Path: <linux-kernel+bounces-763288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A99B2B212BC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64FF9622AAB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3213C212B05;
	Mon, 11 Aug 2025 17:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="CfpGLflX"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C78C311C08;
	Mon, 11 Aug 2025 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754931749; cv=none; b=CziM1hSWdvmc+q1oUbtyHfRm1gZDbjdAG8CQBz+U2UfiELhRIS5FJD/sg+9PrZaV8UwBTUtmUib07l1qNPFTauW0tFdvg38Q25QKd4JEvUOKC/F+MNswgnN3vGMzGbmRYU4r2ZTXTVloHM7wG/Ugh44cm/Jj34GNwA1izIdeZLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754931749; c=relaxed/simple;
	bh=3sAW5use/d0p4JMBeqh7v8J0A8eAIYwi2D9eCjvPVIg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iegnjRJotouOfOg+mFq0er7346bWyP/pwLBUMIdVaH1RX+jVqGU/+yf9we6sS7QRgfynyu2+xhQs/ZrHF3IDvwAIm+nzCYeKTrUVG7t3J79y/QiP6tOWkYbH7A50cX0MyQvx9WLczqCxwUdyIROySWdp3GfqqZhD6iZ1dwXWyUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=CfpGLflX; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9225A40AD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754931747; bh=HyJNv4Iqb/QlTf75BWxUsaGQi8lW5NbyDX/ljSnu+ek=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CfpGLflXSD/qosQDjst1ov6KrIJsSSmkstzDHxJTH6syyDpkF4bsdhYsN2bIT8r5N
	 0SdHQyoiF1hPGpiwx1cXoB0DH1Pa6T040w1bjFSqMVF1Uzd19J7JUOmRnwibDiYngk
	 CbaOcwhe75sPBiDdqI5cAJGZvbglF+pKgZTqCMPHHQMF33qak6c7EiZwF4rsp/mY4H
	 cRxLY88zIfzdak5hDD6Ss0xhu2NWd55/fjhMtZcInoHJhJB8QX9km2xARYU40QbflQ
	 sEjMFGKL6nNOuZoIghusr3BsX4gWXr3y5kSYxkfVIxymE6pTj/5dzu1LddWC8Oq+ck
	 P3UCs5Ig3zETA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 9225A40AD2;
	Mon, 11 Aug 2025 17:02:27 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Osama Albahrani <osalbahr@gmail.com>, Justin Sanders
 <justin@coraid.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Osama Albahrani <osalbahr@gmail.com>
Subject: Re: [PATCH] docs: aoe: Remove trailing whitespace
In-Reply-To: <20250804152516.16493-1-osalbahr@gmail.com>
References: <20250804152516.16493-1-osalbahr@gmail.com>
Date: Mon, 11 Aug 2025 11:02:26 -0600
Message-ID: <87h5ydeqql.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Osama Albahrani <osalbahr@gmail.com> writes:

> Fix `ERROR: trailing whitespace` errors from scripts/checkpatch.pl
>
> Signed-off-by: Osama Albahrani <osalbahr@gmail.com>
> ---
>  Documentation/admin-guide/aoe/udev.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/admin-guide/aoe/udev.txt b/Documentation/admin-guide/aoe/udev.txt
> index 5fb756466bc7..d55ecb411c21 100644
> --- a/Documentation/admin-guide/aoe/udev.txt
> +++ b/Documentation/admin-guide/aoe/udev.txt
> @@ -2,7 +2,7 @@
>  # They may be installed along the following lines.  Check the section
>  # 8 udev manpage to see whether your udev supports SUBSYSTEM, and
>  # whether it uses one or two equal signs for SUBSYSTEM and KERNEL.
> -# 
> +#
>  #   ecashin@makki ~$ su
>  #   Password:
>  #   bash# find /etc -type f -name udev.conf
> @@ -13,7 +13,7 @@
>  #   10-wacom.rules  50-udev.rules
>  #   bash# cp /path/to/linux/Documentation/admin-guide/aoe/udev.txt \
>  #           /etc/udev/rules.d/60-aoe.rules
> -#  
> +#
>  
>  # aoe char devices
>  SUBSYSTEM=="aoe", KERNEL=="discover",	NAME="etherd/%k", GROUP="disk", MODE="0220"
> @@ -22,5 +22,5 @@ SUBSYSTEM=="aoe", KERNEL=="interfaces",	NAME="etherd/%k", GROUP="disk", MODE="02
>  SUBSYSTEM=="aoe", KERNEL=="revalidate",	NAME="etherd/%k", GROUP="disk", MODE="0220"
>  SUBSYSTEM=="aoe", KERNEL=="flush",	NAME="etherd/%k", GROUP="disk", MODE="0220"
>  
> -# aoe block devices     
> +# aoe block devices
>  KERNEL=="etherd*",       GROUP="disk"

I have applied this.  Congratulations on your first kernel patch; I do
hope you can move on from checkpatch-driven fixes for future work,
though!

Thanks,

jon

