Return-Path: <linux-kernel+bounces-742279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51885B0EF69
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379451882F8A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C3128C2AA;
	Wed, 23 Jul 2025 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EfA3J+9v"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39102288C24
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753265362; cv=none; b=Q3MikuQuMv0OVel8dfH85HD/iJp7Q6sdzxq+T07APIt5fzEEeqWjzAUTqFrMaiTpPpVa0kMKDoudUCxmGCoXdLcx7P/he5UG/TsK3v30dn/xLU3R7TbSnEB2VrRX9ije4kRmGiSA52kn0e3G/BCCJ94Wcy9c90CYq3TQGmogf+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753265362; c=relaxed/simple;
	bh=Y43MVgoYCK2w9pwminAGbFyUqf3DeM14oCsnDjRobHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jksigMGSlQ0Eo6vuxzRyFjWSravm2IoNTjzIdzow0HKNkDDu+/ZF5XwjUIUcAmwuFiwA/d08ukLPp68NZJuJN2iksmAgSvdo7TbACL9WmYwspM66SokzyH1PgiiBaqFqgoCuVJAJu3LLFSDcBsgs+FRSKGj+7wgfVvhnzNk6XGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EfA3J+9v; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b31d489a76dso5623955a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1753265359; x=1753870159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7QfdjgPzUCQA0b0bQ/jSwtPcxuHgkS9Iiqt4tSnO/IQ=;
        b=EfA3J+9vqF3bOUoz0Vs+DZU0mggMRLXq2qVwnRwDRfVyPKY8towOuhcUAv2xbw7YmD
         m1W6o+2m/fOZYODxUu9mlKbc9diW51L1R5m7SXWIhhQfTtDBjNa/LSY24dA6XceRgy+l
         dV+oJ3GMrjLScfSr4H+jo/RvQFcrcUaZxV5KvXcStl85OUJG2myd+fyx8n2NuDlO3vNp
         QztvHAZ4RL/0ix4eaagDIh4tfST+rBc2MeCAECY2oLePMzR02IyqF0fRixuTKG0YrbUV
         RSInhfcONi04NEXWOB89xFKDtw7OJqU/K72h6xwAdgFVLKKAJ1mNzazPXuC0HNJQL83b
         QnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753265359; x=1753870159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QfdjgPzUCQA0b0bQ/jSwtPcxuHgkS9Iiqt4tSnO/IQ=;
        b=wXuzsMN/e57r1+OIiDbeRqgRgAYLSpqIFtjvBPF7iTjmntFMdedAmbWu+DolMtJzT+
         8jg+uRShZVZv5uBMfDzgBdAV1rxvBL+jrbJuKhjxJ6smTqqUE987g8EgWIu+/Ndg3jU6
         Z2Txr5gqTPi+oAnm4FYXgDQVCakh0aK/sLsL25xaxGjFVJbfdwyy3izHjUIlKbLZC27z
         PTakQF/H2SIgscSFM1nR7kEzoyII1cYLFjsCVyolCDM3weH6w/jTLEh9q0Eesk2O4aGI
         RERxrdAoVwqJTDxoox3uKR4+n3/U+kKD77yAmZwF2dDkd5NtVhZG3inuKl9JjdNq7BXy
         MiHA==
X-Forwarded-Encrypted: i=1; AJvYcCXS5xJkMdcC/r8c3UTJWYngF9B5CJdZOVV9XFtXR60QkymTpAbPgYr18T9Oszipzh1dYKv4nr4/Ymi7Knk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl/2monXzzUmHzD+p/A0MGI2OCAD3yyQ8Z/uw1BaWAziR9ywLP
	MJMuEd6uF6Xt1RCiHjsVRbYwpvOEQ/8fyfzwbB2Iz/z2B4sMzIreQdLeqq38/c2F2A==
X-Gm-Gg: ASbGnct8fvsmXOQEm8B4k+ZSNom1uBmqRjFt8dfClepmxPihzYpCc8/hBWz1d+yWOBT
	fPW65kSBlqotJJAyu3IY/M3TuRvHI3MI5+bHi3QmE2qZHr/ItMwJei6VhAZ1YcbEj4l1Gy4lJ3L
	Qa1IwCw4iVSxE1t2DRxe4eYDTFfcVSAwVkm2MlGJFeKUXdm7a9/Fb+L4WXI50hzE6dR6bDooEMI
	wRzBLiCpegPjK3X2IVNHi30KsSKpL7SVdY+qUJGcL3sY1KGRcoIughN18zR0vNmTsHCCKMBYpjp
	1udJkCOV7eD0saGZCcl1E6bb5o/IuniSb6kdmqBo/klYzL/76DPqGqQP3WoNosSoJd31Lnf9unn
	qjjXlB42lSIL8WDh3q9siqE+9k8B3YYy7Ow==
X-Google-Smtp-Source: AGHT+IEUKbvODSjekeF5b2WIPYBxcQtVjL9BpBkd+wvWjE0rRVo3cAawMq8sREm28HfrlePoCNtbyQ==
X-Received: by 2002:a05:6a21:3995:b0:232:1668:848d with SMTP id adf61e73a8af0-23d49122195mr4025470637.27.1753265359325;
        Wed, 23 Jul 2025 03:09:19 -0700 (PDT)
Received: from bytedance ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e244fsm9439934b3a.20.2025.07.23.03.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 03:09:18 -0700 (PDT)
Date: Wed, 23 Jul 2025 18:08:59 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Oliver Sang <oliver.sang@intel.com>
Cc: kernel test robot <lkp@intel.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>
Subject: Re: [PATCH v3 3/5] sched/fair: Switch to task based throttle model
Message-ID: <20250723100859.GA25@bytedance>
References: <20250715071658.267-4-ziqianlu@bytedance.com>
 <202507162238.qiw7kyu0-lkp@intel.com>
 <20250717035243.GC32@bytedance>
 <aICbpytNfGRRrqq3@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aICbpytNfGRRrqq3@xsang-OptiPlex-9020>

Hi Oliver,

On Wed, Jul 23, 2025 at 04:21:59PM +0800, Oliver Sang wrote:
> hi, Aaron,
> 
> On Thu, Jul 17, 2025 at 11:52:43AM +0800, Aaron Lu wrote:
> > On Wed, Jul 16, 2025 at 11:20:55PM +0800, kernel test robot wrote:
> > > Hi Aaron,
> > > 
> > > kernel test robot noticed the following build warnings:
> > > 
> > > [auto build test WARNING on tip/sched/core]
> > > [also build test WARNING on next-20250716]
> > > [cannot apply to linus/master v6.16-rc6]
> > > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > > And when submitting patch, we suggest to use '--base' as documented in
> > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > > 
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Aaron-Lu/sched-fair-Add-related-data-structure-for-task-based-throttle/20250715-152307
> > > base:   tip/sched/core
> > > patch link:    https://lore.kernel.org/r/20250715071658.267-4-ziqianlu%40bytedance.com
> > > patch subject: [PATCH v3 3/5] sched/fair: Switch to task based throttle model
> > > config: xtensa-randconfig-r121-20250716 (https://download.01.org/0day-ci/archive/20250716/202507162238.qiw7kyu0-lkp@intel.com/config)
> > > compiler: xtensa-linux-gcc (GCC) 8.5.0
> > > reproduce: (https://download.01.org/0day-ci/archive/20250716/202507162238.qiw7kyu0-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202507162238.qiw7kyu0-lkp@intel.com/
> > > 
> > > sparse warnings: (new ones prefixed by >>)
> > >    kernel/sched/core.c: note: in included file (through arch/xtensa/include/asm/bitops.h, include/linux/bitops.h, include/linux/thread_info.h, ...):
> > >    arch/xtensa/include/asm/processor.h:105:2: sparse: sparse: Unsupported xtensa ABI
> > >    arch/xtensa/include/asm/processor.h:135:2: sparse: sparse: Unsupported Xtensa ABI
> > >    kernel/sched/core.c: note: in included file:
> > > >> kernel/sched/sched.h:741:44: sparse: sparse: dubious one-bit signed bitfield
> > 
> > Same problem as last report.
> > 
> > I've downloaded this compiler from kernel.org and confirmed there is no
> > such warnings after using bool.
> 
> 
> want to confirm, do you mean you can reproduce the build sparse error
> > kernel/sched/sched.h:741:44: sparse: sparse: dubious one-bit signed bitfield
>

Right.

> 
> then after doing below change:
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 3c3ea0089b0b5..6eb15b00edccd 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -738,7 +738,7 @@ struct cfs_rq {
>         u64                     throttled_clock_pelt_time;
>         u64                     throttled_clock_self;
>         u64                     throttled_clock_self_time;
> -       int                     throttled:1;
> +       bool                    throttled:1;
>         int                     pelt_clock_throttled:1;
>         int                     throttle_count;
>         struct list_head        throttled_list;
> 
> 
> the issue will disappear?
> 

Yes, that's correct.

