Return-Path: <linux-kernel+bounces-813014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CEBB53F9C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 03:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32BE8A000AC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 01:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6926F35965;
	Fri, 12 Sep 2025 01:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCFrRBKN"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16894168BD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757639124; cv=none; b=k1ERDxz6P3AM3gb+7bXpJFNUveFVKUN+X7+6Vg+o025PAWOPdOTGtKHHDWGNNd0cqMpcAKmIq5yXuSsmVDTYMjKhJ90yVtaMvy+pSsJDayidQMcYkXqOwrdmyVV2R0pNFMF9btFPqV+LGYRx8tKDCk2ZJmya2uc4EkJAg+3v8/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757639124; c=relaxed/simple;
	bh=9lJzn+itqID29kEdUdzBfBMpzUgt9SdFodtR/JzWcB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbQC2D5V+R+zCzKDnMFo8halzGy/e8+KJUc0fw/MdCQBDH+jFs+WwAp0lPNPAceOpXv7LtoKcTPQzzOogBlLBcg7dibdCSuyfnsPwKmvkakCpK2sQM0VbJ4eHk/IPJtbbTgVfsbJC7YTp+1aCBdk4vuvB7uNRHdzUu8UwAUvIT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCFrRBKN; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-25669596921so12724105ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 18:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757639122; x=1758243922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hbYmMIs+/4yMUw9lg/R3ZdC/yxr5eXq4wDbIYDDjtE4=;
        b=jCFrRBKNraxdgqipmEF9fRgOdSAj/80RIZOzt4yyJkn81pVS8i7j1FP91rKodLwMH8
         RLMdeOInbOe+smaN8wCFFKEAx2GCTNUdPi60jpibE4PXyZtqU5n3OnXMEiNxdjd5YbRQ
         o+QeWHhXXONSnimJtqcWNcXehtFIQBiALIF/FtAlYSJnYGpWn2uz7L488g4eJRLiLzig
         I0CbEf4RqxvZk6fcx1ksq7DTZK5wDPORKJax04jlFF+P6NiSociUImlC7sg8/kHAuZFt
         DuHuSVAFpKKErh+Oo1zOBOu3jTwHtnpRZlDCgNywaKrsSc/9A+AIHnBRu9KPYzq2ebV3
         4v2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757639122; x=1758243922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbYmMIs+/4yMUw9lg/R3ZdC/yxr5eXq4wDbIYDDjtE4=;
        b=rEXKUdWzV8rT6qL3CRIIphMdKDFM8kvGowFHD6h9jzwqO6ze4FiQ2Ghsgjs+CmZX4g
         hgkG16iwnWytINeRTIRsy9xG/eYXt5bg6CURBINJJiJYoHNEjRuGLr0M5jMpmw0b+sCy
         rVYJp7itiUe85a6JOxVFMuppz6umewgO792XozBBYuEmdDVFyWsxpY+b9JCPdkJ5cFtN
         lbjOeB5Snz7AqC3UnwSUFyEuWJdSoC9Ku4kayAZzdpuABZsD6atek6Bn4XAsiJJhO2gt
         htxrTxuQQlPgRU+RdCW/fr5P8Woez6+Y7/LTRvvgxeIqNTzHAesVWqWHwkWJF6cJym01
         wrNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3wOJe6XUBgTcQUxv1bQ6HWgE9pCV09XuaU8nrA5coDYrgcrs/0K7oifo/+au/dy+agjLYQea7ZHcrUvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMyNXfLNeY5QhlwiZAUYpqQnW77zVavJxMWIJJD4NObBHTQgpk
	aAjlAU909oH78w5JYOtC7RDk9etfG7Gh2Xn5XezvzKxALgttPwp3jf8o
X-Gm-Gg: ASbGncszjMA+y6H+13c/13yGU6DiBzE08O2MmznR9KXREfoxGCTz5hkM23cXqYjeMfq
	td7Yv7Ji5g/0RIXW9hDZyp8dNv2AQwQxJmoJG643iAcfMy1BL/IgUI6U+dVA0a6dfvtZcjEO+b1
	NUTQ0gnqSF2rUTWIyXqtkEVS85iui/yj9YK2TsWFEbJi/u4OgL6eqJ1PKJhSJyigf4A5vlezZb7
	2lo6VrRPBuv/bJwnGQNeDuITSZFcqiVvBnVwkEXAfDieYo6gfaZRuqax9hlSsMiJfLzQuR+9dBe
	2W8SbkQkqNJN3iUEuWWHLYImdqN1GigC0LtKzfBoPWfyWRfwHKttkWBEvuQ9A9+5tO06g68sp5L
	X3oEzKhB0sxj/QJXEA+fiYUUpQpVhqFaFeY0=
X-Google-Smtp-Source: AGHT+IFSN+MBg51ax1+Sm6whZztszcgJF+OA3CQXmlICHV8OLSi9h1nLs77AdjLPvKOaSFSq2WdFVw==
X-Received: by 2002:a17:902:ebc1:b0:240:9dd8:219b with SMTP id d9443c01a7336-25d2703a588mr16160945ad.49.1757639121815;
        Thu, 11 Sep 2025 18:05:21 -0700 (PDT)
Received: from localhost ([45.90.208.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84a767sm32069995ad.67.2025.09.11.18.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 18:05:21 -0700 (PDT)
Date: Fri, 12 Sep 2025 09:05:15 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/hw_breakpoint: Unify breakpoint install/uninstall
Message-ID: <aMNxyx3RADiosttf@mdev>
References: <20250910093951.1330637-1-wangjinchao600@gmail.com>
 <20250911170345.80169f37b3964eb9c9475c41@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911170345.80169f37b3964eb9c9475c41@kernel.org>

On Thu, Sep 11, 2025 at 05:03:45PM +0900, Masami Hiramatsu wrote:
> On Wed, 10 Sep 2025 17:39:34 +0800
> Jinchao Wang <wangjinchao600@gmail.com> wrote:
> 
> > Consolidate breakpoint management into a single helper function to
> > reduce code duplication. This introduces new static helpers for
> > slot management and debug register manipulation.
> > 
> > Also, add `<linux/types.h>` to the header file to fix a build
> > dependency.
> 
> Looks good to me. Just some nitpicks.
> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> > 
> > Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> > ---
> >  arch/x86/include/asm/hw_breakpoint.h |   7 +-
> >  arch/x86/kernel/hw_breakpoint.c      | 151 ++++++++++++++++-----------
> >  2 files changed, 96 insertions(+), 62 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
> > index 0bc931cd0698..bd437a30dbf2 100644
> > --- a/arch/x86/include/asm/hw_breakpoint.h
> > +++ b/arch/x86/include/asm/hw_breakpoint.h
> > @@ -3,8 +3,8 @@
> >  #define	_I386_HW_BREAKPOINT_H
> >  
> >  #include <uapi/asm/hw_breakpoint.h>
> > -
> 
> nit: Why this line is removed?
sharp eye, will restore to its original state.
> 
> >  #define	__ARCH_HW_BREAKPOINT_H
> > +#include <linux/types.h>
> >  
> >  /*
> >   * The name should probably be something dealt in
> > @@ -18,6 +18,11 @@ struct arch_hw_breakpoint {
> >  	u8		type;
> >  };
> >  
> > +enum bp_slot_action {
> > +	BP_SLOT_ACTION_INSTALL,
> > +	BP_SLOT_ACTION_UNINSTALL,
> > +};
> > +
> >  #include <linux/kdebug.h>
> >  #include <linux/percpu.h>
> >  #include <linux/list.h>
> > diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
> > index b01644c949b2..1736063a82b7 100644
> > --- a/arch/x86/kernel/hw_breakpoint.c
> > +++ b/arch/x86/kernel/hw_breakpoint.c
> > @@ -48,7 +48,6 @@ static DEFINE_PER_CPU(unsigned long, cpu_debugreg[HBP_NUM]);
> >   */
> >  static DEFINE_PER_CPU(struct perf_event *, bp_per_reg[HBP_NUM]);
> >  
> > -
> 
> Ditto.
There were double-space lines, so delete one.
> 
> >  static inline unsigned long
> >  __encode_dr7(int drnum, unsigned int len, unsigned int type)
> >  {
> > @@ -84,54 +83,115 @@ int decode_dr7(unsigned long dr7, int bpnum, unsigned *len, unsigned *type)
> >  	return (dr7 >> (bpnum * DR_ENABLE_SIZE)) & 0x3;
> >  }
> >  
> > -/*
> > - * Install a perf counter breakpoint.
> > - *
> > - * We seek a free debug address register and use it for this
> > - * breakpoint. Eventually we enable it in the debug control register.
> > - *
> > - * Atomic: we hold the counter->ctx->lock and we only handle variables
> > - * and registers local to this cpu.
> > - */
> > -int arch_install_hw_breakpoint(struct perf_event *bp)
> > +static int manage_bp_slot(struct perf_event *bp, enum bp_slot_action action)
> >  {
> > -	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
> > -	unsigned long *dr7;
> > -	int i;
> > +	struct perf_event *old_bp;
> > +	struct perf_event *new_bp;
> > +	int slot;
> > +
> > +	switch (action) {
> > +	case BP_SLOT_ACTION_INSTALL:
> > +		old_bp = NULL;
> > +		new_bp = bp;
> > +		break;
> > +	case BP_SLOT_ACTION_UNINSTALL:
> > +		old_bp = bp;
> > +		new_bp = NULL;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> >  
> >  	lockdep_assert_irqs_disabled();
> >  
> > -	for (i = 0; i < HBP_NUM; i++) {
> > -		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
> > +	for (slot = 0; slot < HBP_NUM; slot++) {
> > +		struct perf_event **curr = this_cpu_ptr(&bp_per_reg[slot]);
> >  
> > -		if (!*slot) {
> > -			*slot = bp;
> > -			break;
> > +		if (*curr == old_bp) {
> > +			*curr = new_bp;
> > +			return slot;
> >  		}
> >  	}
> >  
> > -	if (WARN_ONCE(i == HBP_NUM, "Can't find any breakpoint slot"))
> > -		return -EBUSY;
> > +	if (old_bp) {
> > +		WARN_ONCE(1, "Can't find matching breakpoint slot");
> > +		return -EINVAL;
> > +	}
> >  
> > -	set_debugreg(info->address, i);
> > -	__this_cpu_write(cpu_debugreg[i], info->address);
> > +	WARN_ONCE(1, "No free breakpoint slots");
> > +	return -EBUSY;
> > +}
> >  
> > -	dr7 = this_cpu_ptr(&cpu_dr7);
> > -	*dr7 |= encode_dr7(i, info->len, info->type);
> > +static void setup_hwbp(struct arch_hw_breakpoint *info, int slot, bool enable)
> > +{
> > +	unsigned long dr7;
> > +
> > +	set_debugreg(info->address, slot);
> > +	__this_cpu_write(cpu_debugreg[slot], info->address);
> > +
> > +	dr7 = this_cpu_read(cpu_dr7);
> > +	if (enable)
> > +		dr7 |= encode_dr7(slot, info->len, info->type);
> > +	else
> > +		dr7 &= ~__encode_dr7(slot, info->len, info->type);
> >  
> >  	/*
> > -	 * Ensure we first write cpu_dr7 before we set the DR7 register.
> > -	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
> > +	 * Enabling:
> > +	 *   Ensure we first write cpu_dr7 before we set the DR7 register.
> > +	 *   This ensures an NMI never see cpu_dr7 0 when DR7 is not.
> >  	 */
> > +	if (enable)
> > +		this_cpu_write(cpu_dr7, dr7);
> > +
> >  	barrier();
> >  
> > -	set_debugreg(*dr7, 7);
> > +	set_debugreg(dr7, 7);
> > +
> >  	if (info->mask)
> > -		amd_set_dr_addr_mask(info->mask, i);
> > +		amd_set_dr_addr_mask(enable ? info->mask : 0, slot);
> > +
> > +	/*
> > +	 * Disabling:
> > +	 *   Ensure the write to cpu_dr7 is after we've set the DR7 register.
> > +	 *   This ensures an NMI never see cpu_dr7 0 when DR7 is not.
> > +	 */
> > +	if (!enable)
> > +		this_cpu_write(cpu_dr7, dr7);
> > +}
> > +
> > +static int arch_manage_bp(struct perf_event *bp, enum bp_slot_action action)
> > +{
> > +	struct arch_hw_breakpoint *info;
> > +	bool install = true;
> > +	int slot;
> > +
> > +	if (action == BP_SLOT_ACTION_UNINSTALL)
> > +		install = false;
> 
> This looks a bit unnecessary. 
> 
> > +
> > +	slot = manage_bp_slot(bp, action);
> > +	if (slot < 0)
> > +		return slot;
> > +
> > +	info = counter_arch_bp(bp);
> > +	setup_hwbp(info, slot, install);
> 
> since you can do
> 
> 	setup_hwbp(info, slot,
> 		   action != BP_SLOT_ACTION_UNINSTALL);
> 
> Thank you,
Thanks, I will follow your advice in the next patch.
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

-- 
Jinchao

