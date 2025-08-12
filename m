Return-Path: <linux-kernel+bounces-764704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8A3B2263A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D697425383
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14352EE61D;
	Tue, 12 Aug 2025 11:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QUga3taB"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189252E716C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 11:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754999978; cv=none; b=VkH5yD12APxwq+SwB4wobf3buTKD7bB+OPUgYMM9eHtdtdEEY+liCkKPNoKY4HBH1cpYakq/usQ04Y+6m+JGUW6lj2qwxm47mvzil15+HToZ7F1RBaRbXSI0o54alYPxs6SusUztFzg5DitA7uvBw6Z+pSm/lRlq9McMwv8KP+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754999978; c=relaxed/simple;
	bh=JZZNGG31V3kJLzMHEUF6/xniPr6gR5xv179L5PweeAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kjj06YKdwCPq9VcH9Xt2XTswMX2l4qS/p0kU1p6Z2oOtd2N4ir1ptqdRY9Cw85jI5txl2s5o1of9RPNvFv+r5SAKlvD8r5nhk2ml9jWMEwYSA8U2X47KFK3zdwKmap0skp36n/30V18Gevk2yW7thsymRbbYttCq0UIJiX+z6Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QUga3taB; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61568fbed16so8411190a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 04:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754999974; x=1755604774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=67A9vrkSTXv7oh0rsvEOh9ZvdiV8B/o1XgYa59BiXUA=;
        b=QUga3taBkJpU2q5SHIQ+X33MRKLSUUs/+kpjvH2JwR28O8nHPJKUv84F4BzwFo1v32
         a8yNN2IwKFR6ePUYr8u5zVLByYw9aopDdm8MRMMqcmSP7iQz0iKl1VV3xKpi1D2KPW3e
         pzzI8TEKZcUBChrWP8nHU8+QIVMxO2NlQMjdmsnAyqGUYnHxT5GrUwuZGJJLi4WtA2wY
         zt4PTENygXtPOwUOHjiGrDb/uBeaVUtdq9uQNd24Oc45mkzKvzuQsGWqAP8stHSDu8IS
         2+UsLoAjLGL4kiv0m0nnAWPTG1p6y4vn9WQLKRlAp43q8EA06+SUeP7BcKKCLZLNrlDm
         NA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754999974; x=1755604774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67A9vrkSTXv7oh0rsvEOh9ZvdiV8B/o1XgYa59BiXUA=;
        b=WDTcyo2SkdVxvxcf/4xpFseK5S3sUoEs9+133UCMkeL6STVqImg3AfCIB4aaAsTNgu
         OUrCEFI5z0p1TOCyumupR+WA+DC6VjFZGmgQaQAXIC8DOsBpaK7ZN9X3NKYBqGpPQF2X
         tz1Tc5i4CcQ+W3npTcJeDz9VdQB3wV6wqM8D08NasYDP+Qlb24v0cWnQYNMHl8lvxU5G
         rgABUBzkCv78lpGLxikbAbIAKIIFfV5rLWTJnfON7G3MhpxkqOwEyTK3hOvMdHWWOEc2
         I6oAXL1GBvZtWG+zCcOqypGOKl4KAQBcluf/AhNWNGY+vVeucwRjdbIFOPJ+6O/Ii0Jp
         YDZA==
X-Forwarded-Encrypted: i=1; AJvYcCUsdPbo1Fb5jJdHBwDHpc0xgTLqp3Aw4YZIvGyyMWmF68XwdCdnHmROINMhyyPUPGZEdV6/uSom/gT1A64=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxVucb3HnZvY/qBmrpducMYj8P3lf2aKHaLtLa5Ku0cuJyRgZB
	GE2A3t/vBNbLpY2M4irY8QLeHnO0uyPKiaPM5E515MDH23K8fy4VfM2bIIRLFfN4t4U=
X-Gm-Gg: ASbGncsjAP53zRNV3VbJtk67tEYGyaRIIdk8O7lS6pb7CtjSJvrni6+cz7g7ndnhb8S
	SMOOC6hL9WHfRGGOzQAsbQYiEjQRT+a3Z4fedk50SNis0Kl0mw9tLGwEmuk4GzMNlUZ3fBeERY8
	7KAfhwFKlWYakJP0ASRfSYCouJYHh1vPjwrsd/jA6WqCxQNzcXJQh9RZUhN5EaVIXP18nPrpoNP
	k2a8o8fNO5Wl/E81olHFBd5qqtXqXnaSO4zjSAYbbfb/XSfyfTPK1E8I9DPf6EZF9Z05bjChJRz
	W07vwVme5GNQNkl/hiVWZICrsSZSbobiZY2Jdpqzqw+X/LBzsADrrQdCRRQaQfqsSSuewkIf6nM
	CFAprZ1ea9jbLpokTWhKZkTKT
X-Google-Smtp-Source: AGHT+IEYdnO36bGTRDTE6/ceFvXjPdeqww/IObB1oCT0gIweSh44S6QYfyjia7Z2A5fVkG27oSR3PA==
X-Received: by 2002:a05:6402:40d3:b0:612:bd30:d326 with SMTP id 4fb4d7f45d1cf-617e2c4d76fmr13177873a12.22.1754999974271;
        Tue, 12 Aug 2025 04:59:34 -0700 (PDT)
Received: from pathway ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8feaf2fsm19866798a12.38.2025.08.12.04.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 04:59:33 -0700 (PDT)
Date: Tue, 12 Aug 2025 13:59:32 +0200
From: Petr Mladek <pmladek@suse.com>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Askar Safin <safinaskar@zohomail.com>, akpm <akpm@linux-foundation.org>,
	corbet <corbet@lwn.net>, "john.ogness" <john.ogness@linutronix.de>,
	"lance.yang" <lance.yang@linux.dev>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	paulmck <paulmck@kernel.org>, rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 1/5] panic: clean up code for console replay
Message-ID: <aJsspG0JdxyRLNte@pathway>
References: <20250703021004.42328-2-feng.tang@linux.alibaba.com>
 <20250714210940.12-1-safinaskar@zohomail.com>
 <aHWliJhyIZnq97Mm@U-2FWC9VHC-2323.local>
 <1980ba9224c.11f5e5a9635585.8635674808464045994@zohomail.com>
 <aHWwL7TdabnGna3D@U-2FWC9VHC-2323.local>
 <1980bfc17f1.122b80ffe36544.5266293070616137570@zohomail.com>
 <aHXKuiqELS1tmchE@U-2FWC9VHC-2323.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHXKuiqELS1tmchE@U-2FWC9VHC-2323.local>

On Tue 2025-07-15 11:27:54, Feng Tang wrote:
> On Tue, Jul 15, 2025 at 06:48:47AM +0400, Askar Safin wrote:
> > 
> >  ---- On Tue, 15 Jul 2025 05:34:39 +0400  Feng Tang <feng.tang@linux.alibaba.com> wrote --- 
> >  > I see. How about changing the patch to: 
> >  > 
> >  > -            bit 5: print all printk messages in buffer
> >  > +            bit 5: replay all kernel messages on consoles at the end of panic
> > 
> > Yes, I agree!
> 
> Hi Andrew,
> 
> Could you help to squash below patch to 1/5 patch "panic: clean up code
> for console replay" in the nonmmu-unstable branch? Thanks!
> 
> - Feng
> 
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f34de9978a91..a84d3f7f5bbf 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4533,7 +4533,7 @@
>  			bit 2: print timer info
>  			bit 3: print locks info if CONFIG_LOCKDEP is on
>  			bit 4: print ftrace buffer
> -			bit 5: replay all messages on consoles at the end of panic
> +			bit 5: replay all kernel messages on consoles at the end of panic
>  			bit 6: print all CPUs backtrace (if available in the arch)
>  			bit 7: print only tasks in uninterruptible (blocked) state
>  			*Be aware* that this option may print a _lot_ of lines,

Yes, this looks better.

It sees that this change is missing in the mainline.
Fang, could you please send it as a followup fix, please?

Best Regards,
Petr

