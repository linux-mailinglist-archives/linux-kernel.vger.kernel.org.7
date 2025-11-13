Return-Path: <linux-kernel+bounces-898407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 09633C5537E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0C85E34A0DC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7061621257B;
	Thu, 13 Nov 2025 01:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FhycNzt8"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF61C1F4176;
	Thu, 13 Nov 2025 01:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762996362; cv=none; b=kBWLNzqDApfXQAXNChpGXyntx7+npS3UOdI/V+DaTSaa6nAMYmuiLOrsd/fgurHcqlwwR2v/rSP7yJqNojdcI34Z9p9uoFhoYdppWT2i/4oaNVwCGXmY0AtgYzMRVvulUluDz7sgLqvE8GourV03xrEaoEnGIrxylXllRCGGR8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762996362; c=relaxed/simple;
	bh=H14iQElD4We1Q1OQxTfhSx4h+vYO6CdXfMRw4P04YUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HPr1LKJraCC7MxQPBQozTMyKqpdClPX67Xh2evY2U//U0pqsp8rsroB7twXUGp3nS4J+uB7EaE4mAYVejxCTHny/F0FYlS2pgHtwUL2roJsjasvoFG3sNrd1DcFIvb/vFS+6fcehyOtgAwHG9QgjetbVTA7kmJ0f4KWZf6qxPR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FhycNzt8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=RKTSMLYSeyrt6jn7Y+qct2dy/kvt5BumsPGDoW38KaE=; b=FhycNzt8kW3A4uplXf9/Hxd1Tq
	tqJnSU3/65mmcG+fH/lC7hhZLLJhDotwOo9SWAmp/AUKNCPL2cg7t+aqvnNggN+qY3rw6U8+n/oOY
	xSRx3RUiTnGd1ZfR7vhRL7zA/oYI4yCdVj8w1PW2rPLyhtuMz/RNLo43Pd4f/qNzR5R3MNOvSAXB/
	RP6P9qhVXrP7TVBqnVcGvhXampqKYAhXnyv8R9Wm3iHW/P83VqD9Ong9/ONX2BYipNJUJR3bswi/M
	fkf02rmxi5TU5DHsVMa+C6JBLaxY5brbvvy3U1cvPlzdTlzUwzKq/ktJeEJfgqvdeoC75I3vPBBzQ
	V2ugHnlA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJLt6-00000009hqW-1ICs;
	Thu, 13 Nov 2025 01:12:36 +0000
Message-ID: <00ea9ddc-0a71-4c93-95e2-656374b0719b@infradead.org>
Date: Wed, 12 Nov 2025 17:12:35 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/kernel-parameters: Move the kernel build
 options
To: Borislav Petkov <bp@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>
References: <20251112114641.8230-1-bp@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251112114641.8230-1-bp@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11/12/25 3:46 AM, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> Move the kernel build options abbreviations to the .txt file so that
> they are together instead of one having to go hunt them in the .rst
> file.
> 
> Tweak the formatting so that the inclusion of kernel-parameters.txt
> still keeps the whole thing somewhat presentable in the html output too.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  .../admin-guide/kernel-parameters.rst         | 97 +-----------------
>  .../admin-guide/kernel-parameters.txt         | 98 +++++++++++++++++++
>  2 files changed, 99 insertions(+), 96 deletions(-)
> 

[snip]

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 6c42061ca20e..e85a91e63f48 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1,3 +1,101 @@

[snip]

> +	X86_UV	SGI UV support is enabled.
> +	XEN	Xen support is enabled
> +	XTENSA	xtensa architecture is enabled.
> +
> +In addition, the following text indicates that the option
> +
> +	BOOT	Is a boot loader parameter.
> +	BUGS=	Relates to possible processor bugs on the said processor.
> +	KNL	Is a kernel start-up parameter.
> +
> +
> +Kernel parameters
> +
>  	accept_memory=  [MM]
>  			Format: { eager | lazy }
>  			default: lazy

WorksForMe although I prefer to highlight the "Kernel Parameters" line somehow,
e.g., all caps or underline with "======================" (yes, that's still a
literal underline, not a Sphinx doc. heading).


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy

