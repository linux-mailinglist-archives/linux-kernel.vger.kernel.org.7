Return-Path: <linux-kernel+bounces-875650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74568C197D5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCD851899CF7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BB531AF25;
	Wed, 29 Oct 2025 09:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UVGIRTeP"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E647930C378
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731497; cv=none; b=Bkowy9HHEABs+4Mc0JoednZW5q6CktpK/kOH0Tv3d28bwJV2tCVVM1UJcq5OYNVOheJV14tCiLH1tPmlAzKnxgnIonkul1uuMBYptq4eB62WHjJMRJsOqjv+IE2bU1c8MrtF80ChlMpnNJGDoLmNzRtcV2hpfCbtroGHdQB56Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731497; c=relaxed/simple;
	bh=9o8f2QPsHB29PhlPOfpuhRMcLB8kVSzBEgAs8oiMhrw=;
	h=References:In-Reply-To:From:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQL5QbxWRNHxvNuKAak0kD/WKlF+VRn4CJV3+dKJw3HfjCcDjRAVmdBGYRMVr2k6SPzLAK27cCOQq3Ogrr5WW+MsKq5XBdny3ZjE2tJqRBNz72K7rT5SKCJFv6bR8brttjMSRVfYw0VLJ2otM+fqxG2xGMz0txcAYPgJXYd7X78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UVGIRTeP; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63c21467e5bso5180572a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761731493; x=1762336293; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:from:in-reply-to
         :references:from:to:cc:subject:date:message-id:reply-to;
        bh=XUmz5Wl9yfT1FobYM412c0HSZzBiDUV4FimmeLGj8uc=;
        b=UVGIRTeP7HVSsixLHH5Xyu0M76udZnING5yq5VxvF+iMkmA61Dks5xkcwCGbStWGmo
         /7RxM6puMeWCLra5IbPMDN2h6kUU4vNaKDuY+ijVQA4DoDkOvSNTV1/xJeT1Dc1Wg9SH
         B4qAzFKn0Xc7xOKjGtUn4ZTQE4t3adVOy1NX5cgKjnO7SA66TD3YrlIhyyAVvMG64ixy
         vIDtt9Pan9+vnc5sCbc9PtvrMkktFAA3d87ESseqZCl9BwaCEPVspM2q/i3fZ2VBYBQm
         f6Cp3MCfTsEJzzs265QGqjdz9CUKz1k8lWXU8/T/8ndyDBE8upMBaPlkTT6vKvfw4YEQ
         dn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761731493; x=1762336293;
        h=cc:to:subject:message-id:date:mime-version:from:in-reply-to
         :references:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XUmz5Wl9yfT1FobYM412c0HSZzBiDUV4FimmeLGj8uc=;
        b=R9Vta2TP+A/VYeqIQCs2AzdNN4OuPOMXkuzWPJd73sALXxlSH9grL63TTzQjWweIcG
         +IwZkvoc7BWrFGoXyHysZqHbRXqmAFGAPP5xKvtdCTpzLuuUsSqXHcw1531+LfHfD99q
         gYfotnDoLcGTyBuPynwL+9HRR4v90UkM5y4uHe+P8ShKS03Rho91AxWqfqrX66XXSFTh
         xAJR7GiCTyZJuMzcbd6HLSTx7oe+/IaVGt8CHiv/X+To8jEQgeAkLpVTHz7+noalozMp
         cEl59XsnIbr+219nyzt5g4eTTlc66uKdV9LZavx6cFQkF3fjn8XoI8MVNtBKOyoTV5kR
         B1OQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNSZSGRXPtpLnthepBW315QP3joFIRMHlkfi2D2MbcwEmwuyisQEXlx+g7eUmUwRwzRbbjVCpbLCEcEl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPnpZCLmzVHu+4X8MFX9eTUQCZPsTQ1JhTmeyeCSJhcid+5o0g
	pj5J188OqEGwADbgHERjHbwxUvmQfTELeu9HlauVhCgP5ylFws/LNQuk0J2nDAHpbfFvxiwr0ID
	CkS71xt9rPCCJ8nhSoV7yvYkgVxcSefWwwn34mZ1x
X-Gm-Gg: ASbGncv4gMJ1iO6hFXVo56BE58896bNSPEhuSuwWY/xFk742WtvjIauAqQOVam7zaPC
	DEjFwOMZh3De2HFo+kLjmIQ5D6L/2FqWt+JzNX5A2kuIgFuzad9Oe5eWFUYBxzitz2Wf2lEmfTR
	UVl81J91vWPcc+Fz23m1WK9OQTfsB0vbJr5BP4JwxMG8GOjrnSutIfnZPtwSE/993JcndbzCKEX
	1MOZHo/C8czsSkFlavKZ3lMe1/tAsxybCr5qXdwhzh2e3xU8eC3xrg4AqaaxQ==
X-Google-Smtp-Source: AGHT+IE6gf/2RPFdgrMbFHjLjryoV3+l5B6OMa04r8DuNPFjjzuUhXH5NGIvrh0WsHKiuCElPRosHWTO4sXcv9YjMkw=
X-Received: by 2002:a05:6402:1598:b0:62f:2f9f:88bf with SMTP id
 4fb4d7f45d1cf-64044380388mr1628399a12.38.1761731493186; Wed, 29 Oct 2025
 02:51:33 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 29 Oct 2025 05:51:32 -0400
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 29 Oct 2025 05:51:32 -0400
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <ca1946de63ad9f0ae99e079a74d70c55879cc0b6.1760206683.git.tim.c.chen@linux.intel.com>
 <20251024093258.GA1630077@bytedance> <cc8284e8-c8f2-4f2c-bcab-4920b80a5a87@intel.com>
In-Reply-To: <cc8284e8-c8f2-4f2c-bcab-4920b80a5a87@intel.com>
X-Original-From: Aaron Lu <ziqianlu@bytedance.com>
From: Aaron Lu <ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Wed, 29 Oct 2025 05:51:32 -0400
X-Gm-Features: AWmQ_bmY94Q-iUIgJ17BVXAq76T8_WTyyJr0aSN_4vibhw8FSNtbG_LGYXNh6xQ
Message-ID: <CANCG0GdR-0Yh16nuAWq477RyWXhzbo_ppDsH9hQrbkxRqw1+-g@mail.gmail.com>
Subject: Re: [PATCH 10/19] sched/fair: Prioritize tasks preferring destination
 LLC during balancing
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Madadi Vineeth Reddy <vineethr@linux.ibm.com>, 
	Hillf Danton <hdanton@sina.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Jianyong Wu <jianyong.wu@outlook.com>, Yangyu Chen <cyy@cyyself.name>, 
	Tingyin Duan <tingyin.duan@gmail.com>, Vern Hao <vernhao@tencent.com>, 
	Len Brown <len.brown@intel.com>, Aubrey Li <aubrey.li@intel.com>, 
	Zhao Liu <zhao1.liu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>, 
	Libo Chen <libo.chen@oracle.com>, Adam Li <adamli@os.amperecomputing.com>, 
	Tim Chen <tim.c.chen@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Oct 27, 2025 at 10:00:52AM +0800, Chen, Yu C wrote:
> Hi Aaron,
>
> On 10/24/2025 5:32 PM, Aaron Lu wrote:
> > Hi Tim,
> >
> > On Sat, Oct 11, 2025 at 11:24:47AM -0700, Tim Chen wrote:
> > > @@ -10849,11 +10849,45 @@ static void record_sg_llc_stats(struct lb_env *env,
> > >   	if (unlikely(READ_ONCE(sd_share->capacity) != sgs->group_capacity))
> > >   		WRITE_ONCE(sd_share->capacity, sgs->group_capacity);
> > >   }
> > > +
> > > +/*
> > > + * Do LLC balance on sched group that contains LLC, and have tasks preferring
> > > + * to run on LLC in idle dst_cpu.
> > > + */
> > > +static inline bool llc_balance(struct lb_env *env, struct sg_lb_stats *sgs,
> > > +			       struct sched_group *group)
> > > +{
> > > +	struct sched_domain *child = env->sd->child;
> > > +	int llc;
> > > +
> > > +	if (!sched_cache_enabled())
> > > +		return false;
> > > +
> > > +	if (env->sd->flags & SD_SHARE_LLC)
> > > +		return false;
> > > +
> > > +	/* only care about task migration among LLCs */
> > > +	if (child && !(child->flags & SD_SHARE_LLC))
> > > +		return false;
> > > +
> > > +	llc = llc_idx(env->dst_cpu);
> > > +	if (sgs->nr_pref_llc[llc] > 0 &&
> > > +	    can_migrate_llc(env->src_cpu, env->dst_cpu, 0, true) == mig_llc)
> >
> > llc_balance() is called from update_sg_lb_stats() and at that time,
> > env->src_cpu is not determined yet so should not be used here?
> >
>
> You are right, I think we should check the candidate group's first
> CPU rather than the env->src_cpu. Will fix it in the next version.

Looks like can_migrate_llc() doesn't care an exact cpu but any cpu in the
same LLC should do, so either the candidate group's first cpu or any
other cpus in that group should make no difference.

It might be more intuitive to prototype can_migrate_llc() with sd_shared
as param than using cpu, just a thought.

