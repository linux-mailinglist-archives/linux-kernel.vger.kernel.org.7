Return-Path: <linux-kernel+bounces-742668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D943CB0F520
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C30617AE58B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4302DECC6;
	Wed, 23 Jul 2025 14:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nxOP/11K"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACAF2DEA89
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753280538; cv=none; b=jEM7Wnbv/LqlgN/DYUPVnuvIk1Qp6CY1n5XAth768TcsoSAirF4mV8ijcNTNN5az43SHNTAkD9b0nzLBTw4OEgVUxD+rDTY9k2i3T64NlKdGsdcxlTZc+1YpyO77gRZvUXQGG2zTmqgTsUCTui+WcMPrQiANBeRDDGnkM34+Vko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753280538; c=relaxed/simple;
	bh=7FIhhnZ8N41qRo3DWI6Nxd1ct9+CqQ9isgpuBH/ie5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQ9H5BoG7KCPQw+f+HEvZnv/i6dVxe8cc1uZHd+t3WjUsKT8wivfQNxipVOYSYYtoMGVJY+I5u5dUzOUlPJ+rNp4a84BDVe8YnF9GLMJ2px58CxwMXDfTqo+DzKSgeB+BlryULsosgzrA7LSn4Lpc1QDIk3rQxrhlz+GiP3DsEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nxOP/11K; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b1fd59851baso4701422a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753280536; x=1753885336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TciU/i1TkWOg/dQpfTDJLSYQg3K8H+HAUNonVNlXDxc=;
        b=nxOP/11KsnIWHC+4/WV2j2raVK5w5H89ZjNjXJKMRRzrYwB/rFFieik0c/4l8WekRO
         P6OPIKghY73L0xZsOzOaTJjfjfyY6xxBnxGaLaoAIh8Jk4LMWXk0Zu+Xpmzug15Nz/68
         nWoxBG2cdy6I/MTASzkMJFxwcjK2fRVYmKwz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753280536; x=1753885336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TciU/i1TkWOg/dQpfTDJLSYQg3K8H+HAUNonVNlXDxc=;
        b=N7Q+4PLc9CDd0MaqEUEJUe4VtBmx52UWQMa1xhweea/GxYDtXa7Q1BoZ1i04e1TDY9
         LZ2kpEPXQlXcyeJKO1hyNlWLpE2UXoKxEKM/5LawjsxZbSFuBuCdtv0O3i9HmgCP4qYL
         /R1esm7arExz06nVqBcouSUPhPWk0u2joJuICcj2B1Gto00gEymnGnFXm6ZxMBq6LYuq
         RHdS9WxPj4sEk7SkDl0ofO8Fg4dRyrCD4e6wyrqqtzpdJt8aAksWSaeDxiYZ3bpJEzBd
         nF6KvVNwFkrEjPNPD2sKLibyI2zEXnJcKvxm+QjCMpd7vdqIKEdQC3uAOkUW6iY907aS
         ffgg==
X-Forwarded-Encrypted: i=1; AJvYcCWyzG9HM/r7gxBEqOUM0tXIrDkw1rxt1K54qU2oyZD7zef1nSdNbCOOJx8ijSW1XifGo+UfaX4xiPtwbBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys4+/LI6zgL+nWmq6VErfm3GSo8B3yzatpzzu0797QW0HWyIE7
	G8HduRu7A/CyrJphj+3tPAIIMgWugoDEO1Nqw1jub3mEyMlzSsc8p9ZCo6F/iOU7PQ==
X-Gm-Gg: ASbGncvOYyr6iDQ1O6ebtZARic289JzY5rfD2qzw8OQuDoYbETj2Sb4pvXYdkfd1MdK
	G6/vJB5ipBnD0PF9y8u/+fIxkGJARA0vCLnCzqECKuVESmHOJYWNAbipaOwgm6eQuhgC2TEfqMJ
	xemhjKDem17QUYmQskTHGn2bo/BnCneCHP/nTzv9xv6ndXTgzJ4pv66RYK3aLBkeo25MpANb0fZ
	PI7gYUqxO13HC0i5Rra9jaSzXcNnQkwvP5x7ZdQe5QkJsweuKNZWUvoz+gvCLS+7m3aHUTJXNKO
	aFLTEL3zDicS6FRyTJ0qxWpfEwCpd+yZEqYaIrZ4snYrFuOdGOqegwjFKbVqRF4YkrqACCHRDMT
	dcGojcPwJbOhaExWKTNQ2G1Y6yA==
X-Google-Smtp-Source: AGHT+IFHehEww7cuBGUSII6CaKL6VEu7S2bFVQoy4PwX8YkO74OJ6Bx6SiRgLGsBvkFTCiEe4F8f3w==
X-Received: by 2002:a17:902:c409:b0:234:c8f6:1b05 with SMTP id d9443c01a7336-23f9824cb15mr37151315ad.52.1753280536415;
        Wed, 23 Jul 2025 07:22:16 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:23e0:b24b:992e:55d2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b48f2sm96955735ad.90.2025.07.23.07.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:22:15 -0700 (PDT)
Date: Wed, 23 Jul 2025 23:22:12 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Tomasz Figa <tfiga@chromium.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] PM: dpm: add module param to backtrace all CPUs
Message-ID: <pc5azqvv6bxpq4zuocjha7cmlmtowlwjapbo6uyb7pfp62fapf@lvgkhnt5vuap>
References: <20250723035955.486688-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723035955.486688-1-senozhatsky@chromium.org>

On (25/07/23 12:59), Sergey Senozhatsky wrote:
> Add dpm_all_cpu_backtrace module parameter which controls
> all CPU backtrace dump before DPM panics the system.  This
> is expected to help understanding what might have caused
> device timeout.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/base/power/main.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index dbf5456cd891..9fb943afe246 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -34,6 +34,7 @@
>  #include <linux/cpufreq.h>
>  #include <linux/devfreq.h>
>  #include <linux/timer.h>
> +#include <linux/nmi.h>
>  
>  #include "../base.h"
>  #include "power.h"
> @@ -517,6 +518,9 @@ struct dpm_watchdog {
>  #define DECLARE_DPM_WATCHDOG_ON_STACK(wd) \
>  	struct dpm_watchdog wd
>  
> +static bool __read_mostly dpm_all_cpu_backtrace;
> +module_param(dpm_all_cpu_backtrace, bool, 0644);
> +
>  /**
>   * dpm_watchdog_handler - Driver suspend / resume watchdog handler.
>   * @t: The timer that PM watchdog depends on.
> @@ -532,8 +536,12 @@ static void dpm_watchdog_handler(struct timer_list *t)
>  	unsigned int time_left;
>  
>  	if (wd->fatal) {
> +		unsigned int this_cpu = smp_processor_id();
> +
>  		dev_emerg(wd->dev, "**** DPM device timeout ****\n");
>  		show_stack(wd->tsk, NULL, KERN_EMERG);
> +		if (dpm_all_cpu_backtrace)
> +			trigger_single_cpu_backtrace(this_cpu);

This is silly, I do apologize.  This should be

			trigger_allbutcpu_cpu_backtrace(this_cpu);

We want to backtrace all CPUs, except the current one.  A silly
copy-paste mistake.

