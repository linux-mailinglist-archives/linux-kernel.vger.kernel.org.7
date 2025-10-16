Return-Path: <linux-kernel+bounces-855632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02123BE1D31
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0C13424457
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 06:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D482F1FDA;
	Thu, 16 Oct 2025 06:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="aVpngrnT"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6341AF0BB
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 06:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760597705; cv=none; b=KM+CT3hTvAxGO/EB3rZLhAsuAvRQDSxyrh49DrMeEItruqpK5HexTWw6mKoIMwLrxzbt4mwGV/w1i9j/N915vPtcpQDKLPimGAjSlyh8kWIyVQ730fPhMpIElDDzvfk4xr5GrxisUjR12o7+H5Fu3aGSKXspyqm9KnMKD5VDDhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760597705; c=relaxed/simple;
	bh=FswksY2w4qfDWehUgB20Gql/cqSO7rNQQjzEPLbIeLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQkoy1HNvlPRz/ljUZGmF8PLasDNJT/66Quz5Km5GjjsRjxXY3s9AlZ+BmxhsV9W5OZZc+A/4HxPQ7KxO6L5cPbN9v6by5BY6MRs0oUrHR3qUFqLxQzsywCYb/p/+9vHcDyiwWhuR6vaeBEtBaqwW4EZsvRR22DhFgCzs7EuPAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=aVpngrnT; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-789fb76b466so394430b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 23:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760597702; x=1761202502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h7OTCRE1rj8UAVICNN5Q1s3HfYeFGt50wghYz0Xd6fI=;
        b=aVpngrnT74oXU3fBd5O4fDOmuyxhfS+YdJrZg0KMJk864pyQGVDP+pymJUgaFv2Ku5
         XkF2N/DNSyXHe0MTcbwmzMfCpxpuBz+cZ95wNPj4MCmhNyXWYkDk04fay/Gv0fdOkn+r
         TBzgFKKKMOmSJ4gQHoLvIFBSZ8ex7IIMsMTaJKe/L2mrUCp++vMDtZS55aEgLm0Rwh1b
         I39w9EuKOf0IrMvhi9pRCBVzI/t8c3uaIRXWhnxwdzgEyBjhuNSESKV/sVJhoL02BEnO
         SrPVmoT1oKmhk/38r+WpGU5pUvH7emPXDhI7ARuAOfyls0ypGlPPehrSRjpVbHwCLW7t
         L5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760597702; x=1761202502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7OTCRE1rj8UAVICNN5Q1s3HfYeFGt50wghYz0Xd6fI=;
        b=irShaiKWed24VEQjjwWvHIfyEmNfGmEF/011rAxvjDUSa2TVaZ37uLhZf/AKhQWLsm
         1ZMVp0pzT62HQsYhGpn4GBRe0dArZJISKeN5QMViy9fdR9DStVycgrjrS3NwdL02Jnhd
         7ERPRpKQXxtMYwMCBRBhHHM+4VA1qrGwXFyuHQ1cHshpPh0WltTdXwme2z9cfvbAx7n/
         2bxZ0EAu0G1Um+1knK8Ja3iEg56XNsxMyjLmHcJh3PdCf683sCwT0HQxDQTqEIHfFVwV
         EUo28E2NjjZITVjVskzW6U/1WR8f2hcKIpZd4maQXGh1BiOoq2Fn3V+Bv1t9+qOOaD1X
         xbSw==
X-Forwarded-Encrypted: i=1; AJvYcCXc12Te8gQDww0+kFUqAZFL2QL9667VSls5IqO7j/COsjuzraf+rX2b9+6ALFe3ES2TfvH4W5MS1WqmVjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdVNMUXpBq70IJ8AStkq8ViUVriOp476JMWrTNvGx7/lBefhaf
	2GeYCIS3BMpLiIKl78QWnHvztiwPCPRLIdDCh9tP2x+ESXkXHbbcRuO2I257ZPCaUA==
X-Gm-Gg: ASbGncucwWvyPltDzxdyRCsrAjZYZZMzfCO5egacWJkVSzl+dmatpaADf1NvztzgFfd
	eGTHeJAakWnpozu5W1yfQmPEbGu8WiVde0TGQ0iwT/I3WY1Rp/ozDShP5R71J1PUnYGhCKSgjzh
	5KzJl/34JL4ctHhMtD5oF6sd305NUw9Twdl9QGBvJZfpJMkLXO+Go1lYw5+zKQrseTBcKbYzzK6
	QGTthqXWGP8zpsQ5R8v2GJsZ68VosgKVkM3MJ9mvXLx+oFhxRKYLDsVDC1sbOsUror/cnF3cFx/
	pNQN8b/d03xgiaDbrZvh14voJ0oy+1uRAYUvNhONPxU81MQ+FDYG1Rsk0sAKN6t4smpJHRTcoVj
	ohCa5aKUlswXJLZY0sDP1Vy1TwMOaXKtQKWMTA0JEAjIwJAS+lcPvXfE8bmZBNGddLvHQeJoLKP
	MM2dUaN5GV6WyCFjBZ1z4mHIfvMqsNIE7nTsvH
X-Google-Smtp-Source: AGHT+IFFEE0yDW1Kd1JfK3CIXSudLbpYc+AZpGDEQ3x+wtsIv/aOu5HWkgQZJxWD9eO1Qk/yMprR3A==
X-Received: by 2002:a05:6a00:1827:b0:781:261b:7524 with SMTP id d2e1a72fcca58-79385ed1603mr42293554b3a.14.1760597701811;
        Wed, 15 Oct 2025 23:55:01 -0700 (PDT)
Received: from bytedance ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992bc13543sm21069213b3a.35.2025.10.15.23.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 23:55:01 -0700 (PDT)
Date: Thu, 16 Oct 2025 14:54:38 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Matteo Martelli <matteo.martelli@codethink.co.uk>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] sched/fair: Prevent cfs_rq from being unthrottled with
 zero runtime_remaining
Message-ID: <20251016065438.GA32@bytedance>
References: <20250929074645.416-1-ziqianlu@bytedance.com>
 <c4a1bcea-fb00-6f3f-6bf6-d876393190e4@gmail.com>
 <20251014090728.GA41@bytedance>
 <84382429-02c1-12d5-bdf4-23e880246cf3@gmail.com>
 <20251014115018.GC41@bytedance>
 <ded8b9bf-c9bb-8a41-541d-1bef354e4296@gmail.com>
 <20251015025154.GA35@bytedance>
 <4902f7d4-c6ee-bc29-dd7f-282d19d0b3b2@gmail.com>
 <20251015084045.GB35@bytedance>
 <6bcc899c-a2a5-7b77-dcff-436d2a7cc688@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bcc899c-a2a5-7b77-dcff-436d2a7cc688@gmail.com>

On Wed, Oct 15, 2025 at 06:21:01PM +0800, Hao Jia wrote:
> On 2025/10/15 16:40, Aaron Lu wrote:
... ...
> > Hao Jia,
> > 
> > Do I understand you correctly that you can only hit the newly added
> > debug warn in tg_unthrottle_up():
> > WARN_ON_ONCE(cfs_rq->runtime_enabled && cfs_rq->runtime_remaining <= 0);
> > but not throttle triggered on unthrottle path?
> > 
> 
> yes. but I'm not sure if there are other corner cases where
> cfs_rq->runtime_remaining <= 0 and cfs_rq->curr is NULL.
> 

Right, I'm not aware of any but might be possible.

> > BTW, I think your change has the advantage of being straightforward and
> > easy to reason about. My concern is, it's not efficient to enqueue tasks
> > to a cfs_rq that has no runtime left, not sure how big a deal that is
> > though.
> 
> Yes, but that's what we're doing now. The case described above involves
> enqueue a task where cfs_rq->runtime_remaining <= 0.
> 
> I previously tried adding a runtime_remaining check for each level of task
> p's cfs_rq in unthrottle_cfs_rq()/tg_unthrottle_up(), but this made the code
> strange and complicated.

Agree that adding a runtime_remaining check for each level in
unthrottle_cfs_rq() looks too complex.

So I think you approach is fine, feel free to submit a formal patch.
With your change, theoretically we do not need to do those
runtime_remaining check in unthrottle_cfs_rq() but keeping that check
could save us some unnecessary enqueues, so I'll leave it to you to
decide if you want to keep it or not. If you want to keep it, please
also change its comments because the current comments will be stale
then.

Thanks.

