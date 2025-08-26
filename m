Return-Path: <linux-kernel+bounces-786210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E485B35690
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98FCC242238
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 08:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EB02F745C;
	Tue, 26 Aug 2025 08:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WtMtKhBF"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4308E2F7453
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 08:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756196356; cv=none; b=WHO2KxD0KiamUQoUVZ8klqdzB90+2kp9x2IWwP7VEzTjjSZnapI8/tr6F0hVpH+VSdWR/FdXT9Nu0427X2/Ug/HMHpva6+GRYMkzbI9H9RHih/SIeOZvrgcJJorZM2kZYhYTRbL8m7X87vEIcPOZTL5Xxfmw0ntyk/2QUP5QGgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756196356; c=relaxed/simple;
	bh=JyZj+v7cjT+GKrDjqAL2pG7uhTQOzD4kZ8yNl3Oc02o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaS74tZaThdKm8S3WU+bvvjoWbsU8MK1pPf9lS9hoRtzNH6PNtzJa5nmu3juQ3da3qy8WpK7ciGCXPMIpMk3utncdOFThmVnurxN+XuKrVnINzY5FvXCZrw5Dv62gNZxsMNQ3ao+zTjnhQ8clpkcD/9O6R/Kj3RRJHu4CQECQog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WtMtKhBF; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24639fbdd87so28531515ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 01:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756196353; x=1756801153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cMS0r+u2h/iTEEDa2JnG40IneRDk2Rmyb1TjG2qsrak=;
        b=WtMtKhBFG4/YlQPBlmUl2778f7BfIuEGoZPMhJvfFGrUhBpzAb3e7nIFuDcIzfgkDI
         b6fjuRrGjLsCXXQDciC5M4IQ3Teqzx4wVS3Dc46W4lJS1NL4k3XF7eaJ0ooVcTnIHfry
         Bg2MN4IOsM9ZujhWxlMpvkisFtMo8kny7foNqGj/KNNv0xwmKJ1+iC4wMIaGVsNmb1p1
         J/U63uKL6+lFAY6V0qF9QdOEbUsusnpfHOqX9mjE5H+mAgAGQBKIaROftfWggu5vNQ81
         V19JqJ3mItHYQ5mNEhn5uhk72a5jSgkzu9LN5y5uzBuINvrAXVgDO2X//E5oHd87JG0D
         +R8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756196353; x=1756801153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMS0r+u2h/iTEEDa2JnG40IneRDk2Rmyb1TjG2qsrak=;
        b=GlkfErEgq6Rlib35FL0mkrSSLb63o9iacdZTKuiSxhS6iUusJG2RhG7823Gz6YuJIn
         6HMjDDLx8U+x/+xWadq2TAS3TdX2KPw+UCnOWqkTLofD4SZv4XTcCYi89tualMaZGNhO
         ZWgQhPMj9YkIzfODRv22BAn7BzF+iSD8oG6wf94TxW/PvfxsHGPKrbxQ1G9r30cQogYP
         uxe8DeyuseoZv8zqWe7mSKf3aLHSWXZuv57HXylDUWedRGZEuS9AqcLe5p5UHHzfKbrh
         H1RSJxpgnRoFQpmCFwp1E81+TefGdExgAM3UTwg36KLtvU8Lmgc9RtwsNiTXT/xjJIXI
         0mzw==
X-Forwarded-Encrypted: i=1; AJvYcCUU/Fj/oaA4MO2EuhluPjWm7h6PBdz7ZYQP3nWTWd8BTFwszkInVu3T31l2owS7ruWJhhy+5lcJhk63riI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRpDleE5LTLc5+nLXfO2jsorq+wswEc5RI1bJyAdrUosVUmycp
	6pwg21wr4rxwVqpDhrAsHTM6gvE2/GjpNAuLUWUHjuB8yGidNBUlYc9IDknNEuHEpXrB371DNWt
	YGQA=
X-Gm-Gg: ASbGncuyB6b4/dtUXZCZpoNe5oDB4369f+HFhJbZTNaHth65vDoqbGBMKUCk0Y+phBC
	oRAyzjG7DcJbG11jpinxEjz2N9pjXkcUHvCMxbQ+SZpRfb9DF1uOX7jZ1GOvgxjk1Ohrjyxmh22
	ZZF97RYAoGCppvyMLDRTATzkyI4UYaL40rr04Ml1IJaxarWtDcAIjKQXOSgvsoN8XboGpxRB7ON
	6EMNJll9acdtBtIOl/VGcP91O83dVSQ/0exd3ATnQfzycENB36PGofMxIpnBkFaAJu7fpcVFHvA
	5RIhd80KJJjPyqAko6+nLMUlti2eLSoQFVSzLbsXq4YRsR7+QcVHukjfIznLP2q97xElJXgqAd7
	HHkaFjl36233bBNrZyPJjrSYY9NjwW2DOX0OncjnS33IbNSo=
X-Google-Smtp-Source: AGHT+IERq7IbHI6i6QAceI8ZDKCRkfwD5BJDAiSoHTiLHlJxaHzCN4KTQ0KZLaUUWxCjumc1sgN4Gg==
X-Received: by 2002:a17:902:da84:b0:246:80ef:8808 with SMTP id d9443c01a7336-248753ada95mr7807865ad.3.1756196353414;
        Tue, 26 Aug 2025 01:19:13 -0700 (PDT)
Received: from bytedance ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687b0b04sm89237675ad.44.2025.08.26.01.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 01:19:12 -0700 (PDT)
Date: Tue, 26 Aug 2025 16:19:04 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: xupengbo <xupengbo@oppo.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	David Vernet <void@manifault.com>, Aaron Lu <aaron.lu@intel.com>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	xupengbo1029@163.com
Subject: Re: [PATCH v3] sched/fair: Fix unfairness caused by stalled
 tg_load_avg_contrib when the last task migrates out.
Message-ID: <20250826081904.GB87@bytedance>
References: <20250826075743.19106-1-xupengbo@oppo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826075743.19106-1-xupengbo@oppo.com>

On Tue, Aug 26, 2025 at 03:57:42PM +0800, xupengbo wrote:
> When a task is migrated out, there is a probability that the tg->load_avg
> value will become abnormal. The reason is as follows.
> 
> 1. Due to the 1ms update period limitation in update_tg_load_avg(), there
> is a possibility that the reduced load_avg is not updated to tg->load_avg
> when a task migrates out.
> 2. Even though __update_blocked_fair() traverses the leaf_cfs_rq_list and
> calls update_tg_load_avg() for cfs_rqs that are not fully decayed, the key
> function cfs_rq_is_decayed() does not check whether
> cfs->tg_load_avg_contrib is null. Consequently, in some cases,
> __update_blocked_fair() removes cfs_rqs whose avg.load_avg has not been
> updated to tg->load_avg.
> 
> I added a check of cfs_rq->tg_load_avg_contrib in cfs_rq_is_decayed(),
> which blocks the case (2.) mentioned above.
> After some preliminary discussion and analysis, I think it is feasible to
> directly check if cfs_rq->tg_load_avg_contrib is 0 in cfs_rq_is_decay().
> So patch v3 was submitted.
> 
> Fixes: 1528c661c24b ("sched/fair: Ratelimit update to tg->load_avg")
> Signed-off-by: xupengbo <xupengbo@oppo.com>

With the below typo fixed:

Tested-by: Aaron Lu <ziqianlu@bytedance.com>
Reviewed-by: Aaron Lu <ziqianlu@bytedance.com>

> ---
> Changes:
> v1 -> v2: 
> - Another option to fix the bug. Check cfs_rq->tg_load_avg_contrib in 
> cfs_rq_is_decayed() to avoid early removal from the leaf_cfs_rq_list.
> - Link to v1 : https://lore.kernel.org/cgroups/20250804130326.57523-1-xupengbo@oppo.com/
> v2 -> v3:
> - Check if cfs_rq->tg_load_avg_contrib is 0 derectly.
> - Link to v2 : https://lore.kernel.org/cgroups/20250805144121.14871-1-xupengbo@oppo.com/
> 
> Please send emails to a different email address <xupengbo1029@163.com>
> after September 3, 2025, after that date <xupengbo@oppo.com> will expire
> for personal reasons.
> 
> Thanks,
> Xu Pengbo
> 
>  kernel/sched/fair.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b173a059315c..df348cb6a5f3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4062,6 +4062,9 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
>  	if (child_cfs_rq_on_list(cfs_rq))
>  		return false;
>  
> +	if (cfs_rq->tg_laod_avg_contrib)
                       ~~~~
typo: tg_load_avg_contrib

> +		return false;
> +
>  	return true;
>  }
>  
> 
> base-commit: fab1beda7597fac1cecc01707d55eadb6bbe773c
> -- 
> 2.43.0
> 

