Return-Path: <linux-kernel+bounces-769162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65234B26AEB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE5605627C4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2C121ABA4;
	Thu, 14 Aug 2025 15:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TWqBnJjQ"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22D92746C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184877; cv=none; b=p2b1Q3otJUUmssnq2ihnwEpOx1S1RwTtFW/gmuwWSSDVLN9DgjOXWE90X897+KZsz+YhA2Cspv1zgT6ndA5YvzK6/cxJOgO002e6ZL4i5PjX6+CaPEFqNQHBbRn3BszM2NnFtd74TcL/qIp1HOzr7hCAAbhw6+iLUUstoGoRT/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184877; c=relaxed/simple;
	bh=YtibqpvfqC3LfxytTglBuRG0EuqfsV4YgreHLTN+6a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRDlwpmPzWeszPcQCoO08I5kIo2unU35LZXWELeTBh5/AZc9K4Hnn7NQwhUPNB7/3DlzAOUCBOpwnvlLnUJLoPF4AXjvUetxQLEiJkFKyku2eF8I+AQopcP81H5szlSQs+fA8UPz5Ss6U7dljPam+GGv9qedWO92VU+MCQ3+PiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TWqBnJjQ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6188b657bddso1984122a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755184873; x=1755789673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3dgPDA3rgAIgMF4EheoIVvO5tKarS0jmBC9SraOljyw=;
        b=TWqBnJjQ18r4AtKOR/IdnGdA9TIp5pkCJjrcCD14YcsJnxZSttxD7peWOLYm2h1Tfq
         /I1+qH1pm/k4we+BKOaJQbtZgPPCPUwfSWzUwE/Es5jI1UE5VogCGgYPdYta8diNIF11
         2UzVmHuEv6Aib3jLGO5nvZ9jw1RUjoYB35c3V+ynZwHzMJukY0IQwuDX7yFUKKJuwRTk
         bCjZbQzNt7VBdBcV6F1L7Gjxpb7oRWmxO0PoFjSbBQYpWGyDU9u/HkK1gw2pxA80DmUB
         8/3aaWbKIFPrMv5+rV3XhlR0z+8SFKw5Y+9wOJOoxEzBt1lf8YdszEWrxlivfhSpdbRR
         ObWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755184873; x=1755789673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dgPDA3rgAIgMF4EheoIVvO5tKarS0jmBC9SraOljyw=;
        b=M11/3z6SCLFJJAGTQNXAFK5C/1wVG0IJS3c3BuRg4nvTH+1Or0mX/4dtZien62Yj1x
         TcM7rtiYU96K9FzFLaczIUilOkhKoR34cQ54OUM+F9FRdHdySxwYn0y5bDyjbbn13w1U
         Fq93He5n40ZwhA7JHs1160vpaNXIlkrZvC3Egns91zPeVl94tWq9UXtoxT+4hySv3lIW
         UsRKau9qJVYMdm46synttE21BqIn2oZKYGeRfVcgnKo3miZX75G43dTh/JPWnU0rraLX
         yWG6LYXWUDIxCiPQ3GTk777a3sXnu85Ee8Qc2sIyumAhj+0e0N+bIismKy0ehtCrJlPA
         DuOg==
X-Forwarded-Encrypted: i=1; AJvYcCXRrYzzRoFIdgY0DdDW7rFx0L9k2k7KNGIoFxw1X05omr0IvYrOLSni4mqs8vRM745xZ1oc7M7Prcso+2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyGBtEmzopaBftbfR/t9rC+dMRT1JRpfmBGdraEedGUwc6/4RS
	vsif+C6BVaoborKgJwMXnRuLvhi53eK+hHndu3jXTfg+TSIzaxM9gLu0fORfvMMfEt0=
X-Gm-Gg: ASbGncuPp/xPvjDl3PYSr1rU+DD+q0zhCd7vZtfez/cjsGx165dxYWj4jljhQfxISf+
	BTdx1s8FR7BP0CIFuyqtlmrybTU+J8tm/LCBs2nmkzxbOX8bMHaLqohH4LmFkn/htBxQ42SO1/y
	MzFJRCQCcVfDq5Dx5Cd7Mmg/f427zpHWh0D41eODNU4NZpPk5h4jXuOPTzGM7dip/c7TJpu7RKF
	pQIBv2Xcj1RjCBSuNOD47FL4F7TJHWI1opehUKJjjbcHgHPW3wtc+U/D20nAC3N0tDDCtVnqxKr
	q6QXvw+qo5Nz30Nu2KL3lBuNsZw0ZGbBc2PrEwhoPYGXJeHkVbat2Rhb7IaGYFHTGkoQcQyNCYT
	zmNhBFp2hs159Ew==
X-Google-Smtp-Source: AGHT+IG0dndym1ylaT+8YI1Ye6c9nuVWlCv2UtObhVYRq2yk69h5K4kg7N4JhDWaFIAS3CKJEY6z4Q==
X-Received: by 2002:a17:907:da7:b0:ade:44f8:569 with SMTP id a640c23a62f3a-afcb98f8816mr333424666b.42.1755184873216;
        Thu, 14 Aug 2025 08:21:13 -0700 (PDT)
Received: from pathway ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af928c84154sm2525183966b.84.2025.08.14.08.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 08:21:12 -0700 (PDT)
Date: Thu, 14 Aug 2025 17:21:10 +0200
From: Petr Mladek <pmladek@suse.com>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lance Yang <lance.yang@linux.dev>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, paulmck@kernel.org,
	john.ogness@linutronix.de
Subject: Re: [PATCH v3 5/5] panic: add note that panic_print sysctl interface
 is deprecated
Message-ID: <aJ3-5mSqEu4kegx4@pathway>
References: <20250703021004.42328-1-feng.tang@linux.alibaba.com>
 <20250703021004.42328-6-feng.tang@linux.alibaba.com>
 <aJsrGgTYxtEhZ7jX@pathway>
 <aJvk2ti-D3t3EUsX@U-2FWC9VHC-2323.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJvk2ti-D3t3EUsX@U-2FWC9VHC-2323.local>

On Wed 2025-08-13 09:05:30, Feng Tang wrote:
> On Tue, Aug 12, 2025 at 01:52:58PM +0200, Petr Mladek wrote:
> > On Thu 2025-07-03 10:10:04, Feng Tang wrote:
> > > Add a dedicated core parameter 'panic_console_replay' for controlling
> > > console replay, and add note that 'panic_print' sysctl interface  will
> > > be obsoleted by 'panic_sys_info' and 'panic_console_replay'.  When it
> > > happens, the SYS_INFO_PANIC_CONSOLE_REPLAY can be removed as well.
> > > 
> > > --- a/kernel/panic.c
> > > +++ b/kernel/panic.c
> > > @@ -77,6 +78,13 @@ ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
> > >  EXPORT_SYMBOL(panic_notifier_list);
> > >  
> > >  #ifdef CONFIG_SYSCTL
> > > +static int sysctl_panic_print_handler(const struct ctl_table *table, int write,
> > > +			   void *buffer, size_t *lenp, loff_t *ppos)
> > > +{
> > > +	pr_info_once("Kernel: 'panic_print' sysctl interface will be obsoleted by both 'panic_sys_info' and 'panic_console_replay'\n");
> > > +	return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
> > > +}
> > 
> > This warning is printed "only" when the value is accessed via the
> > procfs. It would be great to print it also when it is set
> > via the command line parameter.
> 
> Yes, this is indeed a remaining issue to be solved, as mentioned in
> the cover letter.

I see now.

> > It would require replacing
> > 
> > core_param(panic_print, panic_print, ulong, 0644);
> > 
> > with
> > 
> > core_param_cb(panic_print, &panic_print_ops, &panic_print, 0644);
> 
> When testing the change, I found  a problem:  'core_param_cb' is not
> the real counterpart of 'core_param', that it is a module parameter
> instead of kernel/core parameter, and adds the module.prefix to the
> parameter, say, the effective cmdline parameter is changed to
> 'panic.panic_print=' instead of 'panic_print='.

I see. It is pity that it is messed like this.

> While below patch of adding a new 'kernel_param_cb' can work without
> the "panic" prefix, but I'm not sure if it is worth the change:

I think that it is worth adding. IMHO, the parameter will primary be used
from the command line. So, this is an important path how to make people
aware of the obsoleting.

> ---
> diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
> index bfb85fd13e1f..71053d078cea 100644
> --- a/include/linux/moduleparam.h
> +++ b/include/linux/moduleparam.h
> @@ -194,6 +194,9 @@ struct kparam_array
>  #define core_param_cb(name, ops, arg, perm)		\
>  	__level_param_cb(name, ops, arg, perm, 1)
>  
> +#define kernel_param_cb(name, ops, arg, perm) \
> +	__module_param_call("", name, ops, arg, perm, -1, 0)
> +

I would call it __core_param_cb(). And I move the definition
down to the section where core_param() and core_param_unsafe()
are defined. Also it would deserve a comment explaining
why the "__" prefix is used.

>  /**
>   * postcore_param_cb - general callback for a module/cmdline parameter
>   *                     to be evaluated before postcore initcall level

Best Regards,
Petr

