Return-Path: <linux-kernel+bounces-796755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F44CB406C7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C38B5403C1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CC23093D8;
	Tue,  2 Sep 2025 14:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHAB2UcX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AC22AE77;
	Tue,  2 Sep 2025 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823371; cv=none; b=Ctw5lnVRThj0MR/lYLmbhIL+26Cv835WHS5bitXWmgjfMvcHGzZKr3gB+KAo8LrbBxyBxCBDJ7R0VkZwCu5b82QVGoXXCk4RApmxOZKMzuqz6Y/BAwWs5tFFaAcIJLsyFArrZfJEQrLrgPDBlB1rEYSLuumZH1d4euA1q6Eunws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823371; c=relaxed/simple;
	bh=towmWD69esaJqnZV3uUJDGf/VPUYTwRI0JJJB9URGUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpc2qD/bZdhd5XtINitGZNdMHhxhs+xpFExsKEq3xv1uO/DiZidhzXtPKF1u2UrsMz5ypItA3pe03CdArkAdHythOTX8y9uh3ysThGPzsxtNm+Co4tA1Xvf6nMHl0FHKpxo5A0oJ6cee/Pa5sDyL4bOQQElN3cldUuqlqD+xtzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHAB2UcX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13062C4CEED;
	Tue,  2 Sep 2025 14:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756823371;
	bh=towmWD69esaJqnZV3uUJDGf/VPUYTwRI0JJJB9URGUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qHAB2UcXUdDKgT0v3+t1pIRYvmpiagwkDCzdtNT0YCrH/F8msrYMRNGmInScisWMb
	 GcXRAcATup2M76BMKSMXMtOGAh5PDJfcTgGrInuPtFwO4lxPxXlDxWL/AQLC1FMqRV
	 1XeLkisGgxQthCgqYCRxnDUgzNqya9QE21ER53Me5HBdfrpIw44UKxYXJWaeGTRNvg
	 sJdmPZcYxmecTx0vdHr/Hak8eUe64PANPU6f+e3xAH6WvdpKXvZ5IQ0nRdkLcFca4o
	 kOUT8E/uYNrSLo0Q7xPqhSatW+PxCEwm8SWTr0tSMMHJakYUOx2Pn/vpb592YRyQ9L
	 gs+ellHkOZa8w==
Date: Tue, 2 Sep 2025 16:29:28 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Sehee Jeong <sehee1.jeong@samsung.com>
Cc: anna-maria@linutronix.de, tglx@linutronix.de, corbet@lwn.net,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: timers/migration: add 'notmigr' kernel parameter to disable
 timer migration
Message-ID: <aLb_SJ2MYefD4JuN@localhost.localdomain>
References: <CGME20250807064855epcas2p3079c241a4da07d478e713021ca488d13@epcas2p3.samsung.com>
 <20250807064849.3988-1-sehee1.jeong@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250807064849.3988-1-sehee1.jeong@samsung.com>

Le Thu, Aug 07, 2025 at 03:48:49PM +0900, Sehee Jeong a écrit :
> On heterogeneous systems with big.LITTLE architectures, timer migration
> may cause timers from little cores to run on big cores, or vice versa,
> because core type differences are not taken into account in the current
> timer migration logic. This can be undesirable in systems that require
> strict power management, predictable latency, or core isolation.
> 
> This patch does not attempt to solve the structural limitation,
> but provides a workaround by introducing an optional early boot parameter:
> 
>     notmigr
> 
> When specified, timer migration initialization is skipped entirely.

It's a shame we couldn't solve your problem yet but at least such an
option can be nice for general testing beyond big.LITTLE situations.

> 
> Signed-off-by: Sehee Jeong <sehee1.jeong@samsung.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  2 ++
>  kernel/time/timer_migration.c                   | 14 ++++++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 85c27c97b826..4bb10ac574e5 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4132,6 +4132,8 @@
>  	no_timer_check	[X86,APIC] Disables the code which tests for
>  			broken timer IRQ sources.
>  
> +	notmigr 	[KNL,EARLY] Disable timer migration.
> +
>  	no_uaccess_flush
>  	                [PPC,EARLY] Don't flush the L1-D cache after accessing user data.
>  
> diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
> index 72538baa7a1f..7636a1b3ae6b 100644
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
> @@ -1854,3 +1859,12 @@ static int __init tmigr_init(void)
>  	return ret;
>  }
>  early_initcall(tmigr_init);
> +
> +static int __init notmigr(char *str)
> +{
> +	tmigr_enabled = false;
> +
> +	return 0;
> +}
> +
> +early_param("notmigr", notmigr);

This immediately reads like "not migr", which doesn't ring a bell.
no_tmigr would be better. I would even prefer tmigr=off (with default on)
so that the arguments can be further extended in the future if needed.

Thanks

> -- 
> 2.49.0
> 

-- 
Frederic Weisbecker
SUSE Labs

