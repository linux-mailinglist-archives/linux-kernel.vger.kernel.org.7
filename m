Return-Path: <linux-kernel+bounces-887406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB90C38253
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 23:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A161A2069F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 22:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A81E2EF65C;
	Wed,  5 Nov 2025 22:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuzTvvau"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796AD2ECD2E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 22:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762380534; cv=none; b=UPeZ6IYRkR99UUQ7KKiRdcJqvUwAX5Jfu3Lp5dnhiXDYLXlwXQUEJsrnGXvT/1JMIC0ansPzNSdeXHdc3JegFwuCrvTkf65XNut2OSOw0Bv0af7lzKT+SBMjJCtvWEAgNS8dl92fv2RBp+DVJ0fka9y8iPZpqXBXEtSE4IPt3Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762380534; c=relaxed/simple;
	bh=V0/4LMEQqLF2yl5mIVJKhC4q1kmRpoVSyzvqC/CD7YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5rqg3Hwwo/fgVWLOckA/g+7aK7SbDiC/9V6vddGPqyP5ztDeN7Lm3/oqv2S1pIrh9KJ7iKi5iUpf6JgkVvuSiCU/IUhFTEW3Rfd2pcxQNBMAuTPsMDsk/vhRpvzS4bPu0B09KzTkvieM7UvIjAZ1lTtmNBHVots4tQJxb66uWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZuzTvvau; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-295f937d4c3so2676515ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 14:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762380533; x=1762985333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EeAE9TWlCe7Bgnu8xk3HUgUd+4rmdoqy7XlGmj4hRfU=;
        b=ZuzTvvau0+25KUiVWzRltWYmOayfBgs6v3zuezgfpMmtGe6orEIU8BqucevBLgbKV4
         pRdvmtU8wjXsIU4KuQ+MmwM4G0KadmRNOvbcFsPOEtZuUOOSrFmnbohHJ7Bw9ezYSASY
         tz6EfFwKAIb0/DMx0Tl/3LJjiQCSypfahCXibHKdw6oSZAfkvNsZQe+7HqiXJivMHIrC
         QvDSJdipdcwDiQLYpKwZb0tJgjGE8S0NCH3WnHZb3q2orcRR0vqdv4vHy/W7mxpSl/Qz
         QLmlQd2xFFnt8Bzr4Blf03Z3IYM/iXD2bSjt551M+dpOzCURDdvoGGICi/jk+bWwKXQx
         G1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762380533; x=1762985333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeAE9TWlCe7Bgnu8xk3HUgUd+4rmdoqy7XlGmj4hRfU=;
        b=d4OUFu6B6jce1K1ZCfshO6oPZNBtK3sIaQQuaqIJFUvtK+F7f4hBjO7NwNYCmlyf6E
         gpduBMiiGRhJ3GTPYKIPOjkZM3Ez50z8G7PCd3AOVXue7cKGQFHPVVxujssyGFqRAOMz
         DTE1LPihn5gTFjqtLluePFiwDhMAfb7pknnE0J8ZT2JNEpE0130lcPhmyVLngpk4cZfi
         AG0bAy2TyOOsrm27HFKCiiJ5dW1eVIjyuyzcMSTqg2nNGZ47RfNfi/yhplSfzF2Smaya
         3V0F+d7CvLIOcZ72YMo0FWTJa8hpzI25zy7iKBZFMf+MtxXAJciaAKB/+pd5597RkrIE
         bR5w==
X-Gm-Message-State: AOJu0YySASgMrdtAditt5Nq6DsBOP2iR0XBQ1JUbxfsvBjruohpy1dv9
	BpDd6ywGpJ2zNF62MglqOh9j2BhkMtO5ulUxrgeWrI90dm5+aVX8cxTy
X-Gm-Gg: ASbGncsXpDETxy6RvJu8Kq8Cv+sU5fC4gaVVw8SR0T3bCPrIpvriawDv5jeecNuzzex
	CXCVS05lPT3SUURD9JhNNCFmfr52wpLCSXyq8xttfhs+pp46uxZRvQ+6YeyM1ql2Fj+h6fKbBLa
	Q45SXx5w6zixRdhi+j8g2lbVD07so3bVfQFO8GM3Jwcxd0suVByrukhz34eWHa4/zxTUXKvr668
	6aqTEyCZdtrR0Yu7HRSiWTRalb2RrYBeO1by/WZrczKdEf0xyeiecNLza3l8NjPnyG9oLMKHDUX
	/7UWRKDIG7lfodQhgQC8Wac19m4dkDvHri87+avIHSGkGaSNlxPQuSwaktb2rcQsK+tiiaR+ppF
	+QUHuUxiHugBaYsH6mnxjQBaVCpEf0BQMQSdcpIOFiblRY+YNveGjTWhCWTXONMPf7OmSwBhSDA
	foqWVkobYYvpQQSMwf8QDNiBFsK7g5hg+0JLb9JCPhDQ==
X-Google-Smtp-Source: AGHT+IGpDqCQ7uz7BDDzSdTdMKF9K0Lqi2UCONpFEXHzAzmBkfXTFSJUaXVOnXLxgtg3uh96KSsmbg==
X-Received: by 2002:a17:903:1247:b0:290:dc5d:c0d0 with SMTP id d9443c01a7336-2962adb293bmr62585825ad.49.1762380532773;
        Wed, 05 Nov 2025 14:08:52 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:35dd:7def:e1d1:adfe])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d121cc68sm53191a91.9.2025.11.05.14.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 14:08:52 -0800 (PST)
Date: Wed, 5 Nov 2025 14:08:49 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 0/4] replace system_wq with system_percpu_wq, added
 WQ_PERCPU to alloc_workqueue
Message-ID: <wmsyc3b55efl6wiouxtk6bqwdfeqso35ngv7aaqi6es7vph5xj@u5rwq6cggp6s>
References: <20251105103523.103622-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105103523.103622-1-marco.crivellari@suse.com>

Hi Marco,

On Wed, Nov 05, 2025 at 11:35:19AM +0100, Marco Crivellari wrote:
> Hi,
> 
> === Current situation: problems ===
> 
> Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
> set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.
> 
> This leads to different scenarios if a work item is scheduled on an
> isolated CPU where "delay" value is 0 or greater then 0:
>         schedule_delayed_work(, 0);
> 
> This will be handled by __queue_work() that will queue the work item on the
> current local (isolated) CPU, while:
> 
>         schedule_delayed_work(, 1);
> 
> Will move the timer on an housekeeping CPU, and schedule the work there.
> 
> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> 
> This lack of consistency cannot be addressed without refactoring the API.
> 
> === Recent changes to the WQ API ===
> 
> The following, address the recent changes in the Workqueue API:
> 
> - commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
> - commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> 
> The old workqueues will be removed in a future release cycle.
> 
> === Introduced Changes by this series ===
> 
> 1) [P 1-2-3]  Replace uses of system_wq and system_unbound_wq
> 
>     system_wq is a per-CPU workqueue, but his name is not clear.
> 
>     Because of that, system_wq has been replaced with system_percpu_wq.
> 
> 2) [P 4] add WQ_PERCPU to alloc_workqueue()
> 
>     This change adds a new WQ_PERCPU flag to explicitly request
>     alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

So neither of these 4 need percpu workqueue and instead are fine to use
"whatever is free". Maybe we can switch them to use unbound workqueues
instead?

Thanks.

-- 
Dmitry

