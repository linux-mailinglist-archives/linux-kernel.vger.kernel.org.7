Return-Path: <linux-kernel+bounces-871473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8845EC0D5E7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A59D1890DC3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130DC2EC57C;
	Mon, 27 Oct 2025 12:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HsYQPqiy"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FE1136E37
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761566543; cv=none; b=VNuMpFLeAgoTfJfnSM0cOcv5xeiO59kq0m3i7E9mortlOm6+YltjV+PFOC4PWQL9Y21WFpQiP9sNGMHR9BzwUh4iXepAzbJpoL4Bvdg3Azzo31GHll76gJ16/zwHj3cbYs+chL5a8dLNS/iKVSTX6/yInEjHmNfePxNjycfHJ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761566543; c=relaxed/simple;
	bh=4mgrq6ag+R9N/mGWWKX1NszMATZf7dG/fXnt2v+mszs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fi3FWZHaksbzlZleBkyHuiSrgO/O4YeD4pK3EpWPqxhYfBA2S3qik+87h+xYMtiv6k7Tj5WGD355kx+UeMrKHDdWKrp3qxMcnokKDHT+tk1CSCnO8JHHava2pQfCs6O3bNH7MfM2qo/Welya1xgjcTnR9qY3WzJ76rhFPiNuzic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HsYQPqiy; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a28c7e3577so2089821b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761566541; x=1762171341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eKJlnYlYO3fU0CS1UtOOUHTXHFlbUWjSsPsShxXVdPw=;
        b=HsYQPqiyMsNPWgM31p+m3MmBlqJmIslL1S0WlaUpxdd9KTyNt1Yvp7ZJRfCL8o3SGx
         1b/kCbDDyAHPHkHBBUEaOiYuDOtn6/6Llfc6EN2kHhhbrMH+5U4hN+NLVEqLIQLthjpE
         Cso7Qte1koiUQpv90srqilYUcaVHFV7n8QWsRgc99IqsyPsjVeB1QqjfvKJrtE/Xr/T+
         L3B0I9vNSOAvJTq9nvaQJipoWSw0ZieKjnTk/OLkj8hmExKDBMty/b/raycwUbPpGlYx
         8d38h4ocOCjFlhs3LICH1Ttb3k5hiRyHvhiU27IzkyXLW44/LuGi/iKMvDH8hl6tp4tS
         BOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761566541; x=1762171341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKJlnYlYO3fU0CS1UtOOUHTXHFlbUWjSsPsShxXVdPw=;
        b=H7EwoNvRED5Yn988P5aX0oWw3fOr3Q2tIfKIKM753fjMNvGqLwQaLsXDbwCqSylQzS
         nQElAYtx6DT+HHNgNi4q/55BZVtcMJCcQflSNTxSt6JYjwvvfkVhbkNJYbXDhQBgb4gc
         nSEe4d9DULfbVb+icULJhOJ5H+O84ylWhmd8OhpPV3hXzleMpov3SYnrFosUrntcvoGD
         lwwXRzQXTAxC6CFHRB7BZGG2bYYNuyZLGvn7O9DOIHZQMIyjbE6qzbZZVgiVXnjvk6DH
         VtQ8EsVQOUe2QhojktMonTszI39J+cBnlUh6Q+webyIAAG7v1YdbaSjqxp2o2ZgmPyaJ
         KznQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhSRPcAkjZ3TNEM7wwvqwNmJXc9H1EBCHcjocZN0kuaNTf3vf+muP8wiOo6ovk2rBD9pYg2MUbEUd+YHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV3xltqFS6aFmz0FyvDCl7q+8xqhe7X5TWWeumnSpZ9F3c9Zv3
	36HNO9dGlrEzYHYcPmaM9d+291JgMcgCGjmckAXaA6xtlXKuqldivCFP0xJ57EfOLg==
X-Gm-Gg: ASbGncsO9HLevq0sRAXpfI3nbaXPnqM6Hkt61Mwok5c1mtRbyJo3DhYJxY3d9HlIYVo
	5rx3YiY7gZr/tUiIfKtxguk/B9XDHqDscFjpQrkCU9n4UHrA1Adi7QSPr8m1pIZMU12qkIJExt0
	H7XVUTkLJrRA8OPGL17tDSKOQ2PqMSKY7DrnM/r5LZgIEzigNYgMiSAuDT/AUThc4eGDrlh7vo6
	UC3qR/4WL+/5RAvG2GQEPhdM/YJo6zMk0wRl5G4jLhleSAjhOcVYICh6SRpxHn2QISL9BK7sPud
	1DoMPBm6ke1sAA7C7ljBVU48IdBJbokSc144ObtfdiLG1WvptXWAycltDg0AjxSue9nCxyFGmnL
	ClYyP3HeYjMepapJtxRdiAwlGY2ZyUM4sRLHrx7lfRiYYHl2K9qGRG9KSuC004gTiNWIWd2XD4+
	KMFUZKffSAP5ID820Gy411
X-Google-Smtp-Source: AGHT+IHX5eFR8ku/9euMVg4sIMWtuo4iHDqxaW2x7WdhOceuzfT3VBDXNEKHn1wo17KZULC5UTVY+w==
X-Received: by 2002:a05:6a20:7485:b0:342:d58b:561c with SMTP id adf61e73a8af0-342d58b5986mr4644358637.27.1761566540155;
        Mon, 27 Oct 2025 05:02:20 -0700 (PDT)
Received: from bytedance ([61.213.176.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414049ee0sm7865827b3a.33.2025.10.27.05.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 05:02:19 -0700 (PDT)
Date: Mon, 27 Oct 2025 20:02:11 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
Subject: Re: [PATCH v2] sched/fair: Fix non-empty throttled_limbo_list
 warning in tg_throttle_down()
Message-ID: <20251027120211.GB33@bytedance>
References: <20251027090534.94429-1-jiahao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027090534.94429-1-jiahao.kernel@gmail.com>

On Mon, Oct 27, 2025 at 05:05:34PM +0800, Hao Jia wrote:
> @@ -6403,7 +6407,7 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
>   * expired/exceeded, otherwise it may be allowed to steal additional ticks of
>   * runtime as update_curr() throttling can not trigger until it's on-rq.
>   */
> -static void check_enqueue_throttle(struct cfs_rq *cfs_rq)
> +static void check_enqueue_throttle(struct cfs_rq *cfs_rq, int flags)
>  {
>  	if (!cfs_bandwidth_used())
>  		return;
> @@ -6418,6 +6422,13 @@ static void check_enqueue_throttle(struct cfs_rq *cfs_rq)
>  
>  	/* update runtime allocation */
>  	account_cfs_rq_runtime(cfs_rq, 0);
> +	/*
> +	 * Do not attempt to throttle on the cfs_rq unthrottle path.
> +	 * and it must be placed after account_cfs_rq_runtime() to
> +	 * prevent a possible missed start of the bandwidth timer.

Hi Prateek and Hao,

Does it matter to start the bw timer? If no cfs_rq gets throttled, the
timer doesn't look that useful. Also, account_cfs_rq_runtime() calls
assign_cfs_rq_runtime() and if assign failed, it will do resched_curr()
but since we do not throttle cfs_rq here, that resched would be useless.

> +	 */
> +	if (flags & ENQUEUE_THROTTLE)
> +		return;
>  	if (cfs_rq->runtime_remaining <= 0)
>  		throttle_cfs_rq(cfs_rq);
>  }
> @@ -6724,7 +6735,7 @@ static void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p)
>  
>  static void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec) {}
>  static bool check_cfs_rq_runtime(struct cfs_rq *cfs_rq) { return false; }
> -static void check_enqueue_throttle(struct cfs_rq *cfs_rq) {}
> +static void check_enqueue_throttle(struct cfs_rq *cfs_rq, int flags) {}
>  static inline void sync_throttle(struct task_group *tg, int cpu) {}
>  static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq) {}
>  static void task_throttle_setup_work(struct task_struct *p) {}
> @@ -6926,6 +6937,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	int h_nr_runnable = 1;
>  	int task_new = !(flags & ENQUEUE_WAKEUP);
>  	int rq_h_nr_queued = rq->cfs.h_nr_queued;
> +	int throttle_flag = flags & ENQUEUE_THROTTLE;
>  	u64 slice = 0;
>  
>  	if (task_is_throttled(p) && enqueue_throttled_task(p))
> @@ -6983,7 +6995,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  		if (cfs_rq_is_idle(cfs_rq))
>  			h_nr_idle = 1;
>  
> -		flags = ENQUEUE_WAKEUP;
> +		/* Ensure ENQUEUE_THROTTLE flag can be propagated through the hierarchy */
> +		flags = ENQUEUE_WAKEUP | throttle_flag;
>  	}
>  
>  	for_each_sched_entity(se) {
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index e7718f12bc55..468013d860a6 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2364,6 +2364,10 @@ extern const u32		sched_prio_to_wmult[40];
>   * CLASS - going to update p->sched_class; makes sched_change call the
>   *         various switch methods.
>   *
> + * THROTTLE - invoke in throttle_cfs_rq_work() to ensure task dequeue
> + *            during throttling, and in tg_unthrottle_up() to ensure
> + *            task enqueue during unthrottling.

Thanks for adding the comment for dequeue_throttle. One nit is:
dequeue_throttle is used for time accounting purpose so it would be
better if you can make that clear, maybe something like this:

invoked in throttle_cfs_rq_work() during throttle for accounting
purpose, and in tg_unthrottle_up() to avoid throttling when enqueuing
tasks.

> + *
>   * ENQUEUE_HEAD      - place at front of runqueue (tail if not specified)
>   * ENQUEUE_REPLENISH - CBS (replenish runtime and postpone deadline)
>   * ENQUEUE_MIGRATED  - the task was migrated during wakeup
> @@ -2381,9 +2385,9 @@ extern const u32		sched_prio_to_wmult[40];
>  #define DEQUEUE_MIGRATING	0x0010 /* Matches ENQUEUE_MIGRATING */
>  #define DEQUEUE_DELAYED		0x0020 /* Matches ENQUEUE_DELAYED */
>  #define DEQUEUE_CLASS		0x0040 /* Matches ENQUEUE_CLASS */
> +#define DEQUEUE_THROTTLE	0x0080 /* Matches ENQUEUE_THROTTLE */
>  
>  #define DEQUEUE_SPECIAL		0x00010000
> -#define DEQUEUE_THROTTLE	0x00020000
>  
>  #define ENQUEUE_WAKEUP		0x0001
>  #define ENQUEUE_RESTORE		0x0002
> @@ -2393,6 +2397,7 @@ extern const u32		sched_prio_to_wmult[40];
>  #define ENQUEUE_MIGRATING	0x0010
>  #define ENQUEUE_DELAYED		0x0020
>  #define ENQUEUE_CLASS		0x0040
> +#define ENQUEUE_THROTTLE	0x0080
>  
>  #define ENQUEUE_HEAD		0x00010000
>  #define ENQUEUE_REPLENISH	0x00020000
> -- 
> 2.34.1
> 

