Return-Path: <linux-kernel+bounces-732972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEBDB06E53
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC9C93B3F89
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBE4288C38;
	Wed, 16 Jul 2025 06:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NgS+M/+p"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DFF288C2C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 06:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752649047; cv=none; b=B8lbKB3u//V0U77USgZXBtLeG7vJBjsp7y9Sb3EBQ/eaPr+IZrZ9CC3XHBh2pv4G3FdVSePEoX3+2/W0+tvDGoPCPj7DWJQzIQrwIw6O++hCibdb3aJxE1iY6ut32QjQGsShwpNqLJMjm8V1eXK1Y1MLN/j5JoUnQFQRge8deaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752649047; c=relaxed/simple;
	bh=TD0ab6RBX+aJCk6XqnHSMUyK4zPatG+3Dk/SNSvok+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5PLwM6OJflyITPeXANuu9UIFhxelUmoElCVPjlLLbSarpdX7wZNPs7RfOmDW0QK7gXoRCKvM3EcqlG3mRzk5YEP3Oxwdi207ERMfybtuEfVep7IR08Ew/msQuMzx8vKFk7B7zYOARp+YuHzAJj4nc319YK0mnrljKXY/ve9NjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NgS+M/+p; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23dc5bcf49eso76837305ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 23:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1752649045; x=1753253845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V/rdVFfglErJuT3RW1dM62UVhSgtAT4/g/1LUeyUznw=;
        b=NgS+M/+pwOaB5JoC3nsIejafXZKKBlnz9YZa/GlUn89Ullyi2TA19ae50M8AOPF8/x
         1WYTWx/eYFG/35G2n82PFFl+3CHDB348J9LqTAvDMzanUZpFGbo0cbjRI1KFU6HvQm/2
         904SFnV9mOeNqBgUGClJPAwxegk+cESCLiF7VNzBsN+Zav/m/sbeLgum0SB9FqejfL01
         I3QxrV8ZgJPgutNxnu2Te18w9ypJhDf0QPqgNq6e2i8W+qpJ/TRhwPTdvqW9y0oqiefB
         lvID4bzDkT60QDGu6IUqth3JAZUbYoAeKfmu3aJbwotWaQCal29RKw3rOe26TpoAvywY
         rYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752649045; x=1753253845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/rdVFfglErJuT3RW1dM62UVhSgtAT4/g/1LUeyUznw=;
        b=sqXF7iZjvIJY785OSUY/pvEqNMWBd4kZKH4AWFm3qtU3f7HbzPniWH8K1S8O/Bmozt
         2LGER6GmzmkYQkbUHsiNpymNKUA6hFp4fdYF05UU++9vT5udPLSm5byPr+UKM62lnjRz
         K4uyxtptfFhvAe22mVFE+097r1lDWaeeGV/gm66dI74OcdmXwQbJhsksPY/jQcYu/fgJ
         2KQ7JmOzXLyGf/oPUAQIJtXrMe/0/mWbGVgWmibPW2LZ2t/DMkDyS+d5idM1c0aA0ZTL
         EIO/Xfns9BH6+IQkOtrvkb3X5J+bsEUgnzTlJ2x/gWEXLYl6neOf0WDZL8hIhxSgAXgp
         Kd5w==
X-Forwarded-Encrypted: i=1; AJvYcCUnJJctKAhHPW3jGT8r+vG/L5konRK9ae+3/+vaUZQcpz9RUQNN3UkrBpHOtupSgv45LrIUfWSxDshL4gw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8CK0tP8Yrp8VD1P+kyrCj0br+zkRSSQ51zpBM7PhSfXb/dBV2
	WdqXqNUubgfn6nN3kUyyKHABDe2SR/KTrl0OQsCU65jjKN4W5/xLx52ezphbVg+Naw==
X-Gm-Gg: ASbGncsFrBnvWAQsPp50prc7vaWW6sHpm444HSCG4Eio1Pv1E6qFE2MgYv62V55WLR2
	1PrhWgoCp8Fj6ad/iMidE9Z5NQ6bND477SueCYxfONpaxZpBuAjMj2LvZpsRvqM27MSUADyaQlt
	lvE2VlE7lSD0vgQJcmH4YmURHiWOUeIEcjcFROQp78hJg4rDuz4A6jB1SueCPyh+63txo2+nHuH
	OxbVKpm9JO9E6lD2mN3JZr8GyEm3cnV7+EUCZ09RCV1TCfNS7bTaOk3rGTyjmpPI6ddqHi5hrOC
	OdPTRU/2PAJISOMz+ifE1BEpXsRjg/1Imkys6oNSrCgLXQWL7IZpX6ZNGpeLqffvhVlmDKPoa+A
	gf7RTeWzplS+fgvJl0LLjyarerr95MHErrXf0vfAMPOo=
X-Google-Smtp-Source: AGHT+IH9AkRL1S5ovVTdxJDiJDBqDKVqpO2CT21Px6+WwZDjPWtWfdrh5Sv/eFYSidv/uHK58P+1JA==
X-Received: by 2002:a17:902:ea0c:b0:234:c549:da14 with SMTP id d9443c01a7336-23e24f47557mr28595105ad.29.1752649044756;
        Tue, 15 Jul 2025 23:57:24 -0700 (PDT)
Received: from bytedance ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f2b522csm741680a91.47.2025.07.15.23.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 23:57:24 -0700 (PDT)
Date: Wed, 16 Jul 2025 14:57:07 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: kernel test robot <lkp@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>
Subject: Re: [PATCH v3 3/5] sched/fair: Switch to task based throttle model
Message-ID: <20250716065707.GA32@bytedance>
References: <20250715071658.267-4-ziqianlu@bytedance.com>
 <202507160730.0cXkgs0S-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202507160730.0cXkgs0S-lkp@intel.com>

On Wed, Jul 16, 2025 at 07:29:37AM +0800, kernel test robot wrote:
> Hi Aaron,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on tip/sched/core]
> [also build test WARNING on next-20250715]
> [cannot apply to linus/master v6.16-rc6]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Aaron-Lu/sched-fair-Add-related-data-structure-for-task-based-throttle/20250715-152307
> base:   tip/sched/core
> patch link:    https://lore.kernel.org/r/20250715071658.267-4-ziqianlu%40bytedance.com
> patch subject: [PATCH v3 3/5] sched/fair: Switch to task based throttle model
> config: i386-buildonly-randconfig-006-20250716 (https://download.01.org/0day-ci/archive/20250716/202507160730.0cXkgs0S-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250716/202507160730.0cXkgs0S-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202507160730.0cXkgs0S-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> kernel/sched/fair.c:5456:33: warning: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Wsingle-bit-bitfield-constant-conversion]
>     5456 |                         cfs_rq->pelt_clock_throttled = 1;
>          |                                                      ^ ~

Thanks for the report.

I don't think this will affect correctness since both cfs_rq's throttled
and pelt_clock_throttled fields are used as true(not 0) or false(0). I
used bitfield for them to save some space.

Change their types to either unsigned int or bool should cure this
warning, I suppose bool looks more clear?

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index dbe52e18b93a0..434f816a56701 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -737,8 +737,8 @@ struct cfs_rq {
 	u64			throttled_clock_pelt_time;
 	u64			throttled_clock_self;
 	u64			throttled_clock_self_time;
-	int			throttled:1;
-	int			pelt_clock_throttled:1;
+	bool			throttled:1;
+	bool			pelt_clock_throttled:1;
 	int			throttle_count;
 	struct list_head	throttled_list;
 	struct list_head	throttled_csd_list;

Hi LKP,

I tried using clang-19 but couldn't reproduce this warning and I don't
have clang-20 at hand. Can you please apply the above hunk on top of
this series and see if that warning is gone? Thanks.

Best regards,
Aaron

>    kernel/sched/fair.c:5971:32: warning: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Wsingle-bit-bitfield-constant-conversion]
>     5971 |                 cfs_rq->pelt_clock_throttled = 1;
>          |                                              ^ ~
>    kernel/sched/fair.c:6014:20: warning: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Wsingle-bit-bitfield-constant-conversion]
>     6014 |         cfs_rq->throttled = 1;
>          |                           ^ ~
>    3 warnings generated.
> 
> 
> vim +/int +5456 kernel/sched/fair.c
> 
>   5372	
>   5373	static bool
>   5374	dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>   5375	{
>   5376		bool sleep = flags & DEQUEUE_SLEEP;
>   5377		int action = UPDATE_TG;
>   5378	
>   5379		update_curr(cfs_rq);
>   5380		clear_buddies(cfs_rq, se);
>   5381	
>   5382		if (flags & DEQUEUE_DELAYED) {
>   5383			WARN_ON_ONCE(!se->sched_delayed);
>   5384		} else {
>   5385			bool delay = sleep;
>   5386			/*
>   5387			 * DELAY_DEQUEUE relies on spurious wakeups, special task
>   5388			 * states must not suffer spurious wakeups, excempt them.
>   5389			 */
>   5390			if (flags & DEQUEUE_SPECIAL)
>   5391				delay = false;
>   5392	
>   5393			WARN_ON_ONCE(delay && se->sched_delayed);
>   5394	
>   5395			if (sched_feat(DELAY_DEQUEUE) && delay &&
>   5396			    !entity_eligible(cfs_rq, se)) {
>   5397				update_load_avg(cfs_rq, se, 0);
>   5398				set_delayed(se);
>   5399				return false;
>   5400			}
>   5401		}
>   5402	
>   5403		if (entity_is_task(se) && task_on_rq_migrating(task_of(se)))
>   5404			action |= DO_DETACH;
>   5405	
>   5406		/*
>   5407		 * When dequeuing a sched_entity, we must:
>   5408		 *   - Update loads to have both entity and cfs_rq synced with now.
>   5409		 *   - For group_entity, update its runnable_weight to reflect the new
>   5410		 *     h_nr_runnable of its group cfs_rq.
>   5411		 *   - Subtract its previous weight from cfs_rq->load.weight.
>   5412		 *   - For group entity, update its weight to reflect the new share
>   5413		 *     of its group cfs_rq.
>   5414		 */
>   5415		update_load_avg(cfs_rq, se, action);
>   5416		se_update_runnable(se);
>   5417	
>   5418		update_stats_dequeue_fair(cfs_rq, se, flags);
>   5419	
>   5420		update_entity_lag(cfs_rq, se);
>   5421		if (sched_feat(PLACE_REL_DEADLINE) && !sleep) {
>   5422			se->deadline -= se->vruntime;
>   5423			se->rel_deadline = 1;
>   5424		}
>   5425	
>   5426		if (se != cfs_rq->curr)
>   5427			__dequeue_entity(cfs_rq, se);
>   5428		se->on_rq = 0;
>   5429		account_entity_dequeue(cfs_rq, se);
>   5430	
>   5431		/* return excess runtime on last dequeue */
>   5432		return_cfs_rq_runtime(cfs_rq);
>   5433	
>   5434		update_cfs_group(se);
>   5435	
>   5436		/*
>   5437		 * Now advance min_vruntime if @se was the entity holding it back,
>   5438		 * except when: DEQUEUE_SAVE && !DEQUEUE_MOVE, in this case we'll be
>   5439		 * put back on, and if we advance min_vruntime, we'll be placed back
>   5440		 * further than we started -- i.e. we'll be penalized.
>   5441		 */
>   5442		if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) != DEQUEUE_SAVE)
>   5443			update_min_vruntime(cfs_rq);
>   5444	
>   5445		if (flags & DEQUEUE_DELAYED)
>   5446			finish_delayed_dequeue_entity(se);
>   5447	
>   5448		if (cfs_rq->nr_queued == 0) {
>   5449			update_idle_cfs_rq_clock_pelt(cfs_rq);
>   5450	#ifdef CONFIG_CFS_BANDWIDTH
>   5451			if (throttled_hierarchy(cfs_rq)) {
>   5452				struct rq *rq = rq_of(cfs_rq);
>   5453	
>   5454				list_del_leaf_cfs_rq(cfs_rq);
>   5455				cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
> > 5456				cfs_rq->pelt_clock_throttled = 1;
>   5457			}
>   5458	#endif
>   5459		}
>   5460	
>   5461		return true;
>   5462	}
>   5463	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

