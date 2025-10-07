Return-Path: <linux-kernel+bounces-844646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 497E3BC26A9
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 20:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1437A4F973B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 18:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669D12E973D;
	Tue,  7 Oct 2025 18:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gjf4YcM0"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987381E25F9;
	Tue,  7 Oct 2025 18:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759862339; cv=none; b=osB+GJZTpZM4VjVDimgelF76y+LF2fXxOb38QcjvYwt+cv2QefYG7SkYc5pU7bfJWFCChS5hL5NlhGwfFNyILaLXiPFSq0BscAh2rjBp1gXILx1rVHNSBRbTP06jjiNcNrMDj+fVrUInrw1mb44FlSICFpAQFStz489Pl+2lMs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759862339; c=relaxed/simple;
	bh=Si8WWiApqNonWNjwkAEhqOqQwGCpP7NpMGx8p41GNEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CUqyeHuKWl5aUMJZ9PR6oVvtOcBBNSWZOUtlYmEBocPIbr7sV38nFv2QOtAfp2KRN4vyN7BkrZA9qg5OyUxknmYDwtjGf/m996AsfGu67z46Xr5aO5PfZz5wlrPM7Xa/ixHfqByUo7ISnoN+1Z5rIixPMza/SABu+CekUzeY42A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Gjf4YcM0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=5Z46URuG68kQWJecMTlqu4UjK+nbHEPOS/pd6f9kPAs=; b=Gjf4YcM0g0Cr1BcnFApWo7d+wn
	URuSzP1W/82VlMRH4Vnb2sUKtlFCgarOldcvjaNYJyZ6gnIdQVqRvGNKTqarBGaPXTmOsf1VRU5pO
	fSU5Rnomun6KavRjsy4eRN5CIv0lj1m6Ql8o6VbwfZgUQTsqR4OY4AGici8LEcmacliLT1hDKiFK1
	aoWY6JXijdRblORdhKJ/nDB7XnPr/R2HT91imkiqjibOkPKbkOEekRevGZKA7uNtjfVXfvA3T04sB
	E8y8D9whL7wZ5/CiYB8aZHgMdgyaXIpS8/M853VeHt/gQwZnRt2EQR2wx/lfsX0xhAnzBapqSsYg8
	DAjywaIg==;
Received: from [50.53.43.113] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6CaM-00000002bbw-3N4n;
	Tue, 07 Oct 2025 18:38:54 +0000
Message-ID: <3b011d8c-33f7-4189-ac48-d298bf377988@infradead.org>
Date: Tue, 7 Oct 2025 11:38:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] timers/migration: add 'tmigr' kernel parameter to
 optionally disable timer migration
To: Sehee Jeong <sehee1.jeong@samsung.com>, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, corbet@lwn.net
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250910074251.8148-1-sehee1.jeong@samsung.com>
 <CGME20250910074259epcas2p294790d53f9e2c7a7b9ecea003ad66092@epcas2p2.samsung.com>
 <20250910074251.8148-2-sehee1.jeong@samsung.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250910074251.8148-2-sehee1.jeong@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/10/25 12:42 AM, Sehee Jeong wrote:
> On heterogeneous systems with big.LITTLE architectures, timer migration
> may cause timers from little cores to run on big cores, or vice versa,
> because core type differences are not considered in the current timer
> migration logic. This can be undesirable in systems that require
> strict power management.
> 
> For example, if timers are frequently migrated to a big CPU, it must
> handle callbacks that could have run on a little CPU. This reduces the
> big CPU's idle residency and increases overall energy consumption due to
> higher power draw on the big CPU.
> 
> To avoid this issue, introduce an early boot parameter to optionally
> disable timer migration:
> 
>     tmigr=on|off	(default: on)
> 
> When set to "off", timer migration initialization is skipped entirely.
> 
> Signed-off-by: Sehee Jeong <sehee1.jeong@samsung.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  4 ++++
>  kernel/time/timer_migration.c                 | 19 +++++++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index ab4c049faba9..0f5d42c046bb 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6783,6 +6783,10 @@
>  			Force threading of all interrupt handlers except those
>  			marked explicitly IRQF_NO_THREAD.
>  
> +	tmigr		[KNL,EARLY] Enable/disable timer migration

	tmigr=
please.

> +			Valid parameters: on, off
> +			Default: on
> +
>  	topology=	[S390,EARLY]
>  			Format: {off | on}
>  			Specify if the kernel should make use of the cpu
> diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
> index 72538baa7a1f..00e3740aec98 100644
> --- a/kernel/time/timer_migration.c
> +++ b/kernel/time/timer_migration.c
> @@ -422,6 +422,8 @@ static unsigned int tmigr_crossnode_level __read_mostly;
>  
>  static DEFINE_PER_CPU(struct tmigr_cpu, tmigr_cpu);
>  
> +static bool tmigr_enabled = true;
> +
>  #define TMIGR_NONE	0xFF
>  #define BIT_CNT		8
>  
> @@ -1790,6 +1792,9 @@ static int __init tmigr_init(void)
>  
>  	BUILD_BUG_ON_NOT_POWER_OF_2(TMIGR_CHILDREN_PER_GROUP);
>  
> +	if (!tmigr_enabled)
> +		return 0;
> +
>  	/* Nothing to do if running on UP */
>  	if (ncpus == 1)
>  		return 0;
> @@ -1854,3 +1859,17 @@ static int __init tmigr_init(void)
>  	return ret;
>  }
>  early_initcall(tmigr_init);
> +
> +static int __init tmigr_setup(char *str)
> +{
> +	if (!str)
> +		return 0;
> +
> +	if (!strcmp(str, "off"))
> +		tmigr_enabled = false;
> +	else if (!strcmp(str, "on"))
> +		tmigr_enabled = true;
> +
> +	return 0;
> +}
> +early_param("tmigr", tmigr_setup);


