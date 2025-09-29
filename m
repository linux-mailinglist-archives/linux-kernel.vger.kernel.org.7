Return-Path: <linux-kernel+bounces-835913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE7CBA8525
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D540B3A3539
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB73261594;
	Mon, 29 Sep 2025 07:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TeiXwJtB"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B31335C7
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759132339; cv=none; b=SZBHJTYM6aHxJVDpqQMUxKZte9IcdEdUb59iJIlxFEN9IhU0lsDeTXVh2ezK7YVnsPhTYnq7KtLxF+lDmzdwWgkrqC+v8hr5NrxRzl7nT3SVA9v+xIGdrwLwPai6wWl7x99JxA31hUhw/EHqrbwV0X9En8unSD//9785XT89Qjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759132339; c=relaxed/simple;
	bh=ES4hhc+ld1WK0a/S+SJ90qbVHcpQKNMwVy3DDCnZohc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orh8noi1qLkO9QC1i3t3Iq+J7UcQaIn67bv+OHUajtyFnndm3ey0U8iRBhcCR/xPZOv5cwxdu7rDcvIgDQeT4vOsGZFUxXjrzE6eo1sD+UJu6xrHtTxs+poED9vWrOgl1HvubvzM45+2ooKRmpmaqPTN8YBlMNsjFg5K3NTjqB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TeiXwJtB; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7835321bc98so1218123b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 00:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759132337; x=1759737137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hOFUAiKbLt8ElDBCyo6IazXGg8zZTs68l8YmXMtlomU=;
        b=TeiXwJtBCsd+s9+CX3reMapIT6D4gMyoef6KoQSkzc2TAhdPv65OP18Bwp8svz8FaH
         hFOkvC93LLWttqnM1XJPCwfdZGwDUMYastmbRBCPfTPGxvNrfcmHrMKDpaanzHh2h9sg
         5Qf0SHPkcGazws4CZKP00uMj4k301Tw3jiM1M/ocikV+JgZgAZ+6Mu0l5of38dd1+kEC
         uAUD+VYSBZjhBwCAbudRTA5rxS0DITVdiZCbt/ZMebGyrljeq3fv1j8dLI6irMofHIC9
         C4Qo5knUrI1+npl1RD39WUqgurELeC94wal6Q58S75yZqhCLqBzYx4ye1TEA949Jysh4
         0E4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759132337; x=1759737137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOFUAiKbLt8ElDBCyo6IazXGg8zZTs68l8YmXMtlomU=;
        b=G2NssZcvhLh/+HghR3rMJ9LxWZgRcjbwRpBPIrlTbbiv5Dch2IBjtzK4YHxMEcYQK7
         1pyO4LJgNXW7SrU/zjmqCeLwJ2CO7ZMAAtVANCZGjK6QOCRA/suVgTFAPbifcITLULCa
         6TB4F1G88zcI/OgHznc4QnvzvLGV0EF/jMDq+ET8cGGcb29TuuXRsjKddKZKk5Su+hsW
         lqqjxwFNCjXE9+eHCf+CX+JYcYDOnfgrCoTfLSkJijLhyy716VvF3sF3okAGnNzzEk16
         w3Z2MFDgx+trC6BLrmi16tLUW0PIlI7ebID2M0rsFx1CALexdN26hajTK5i85/207gEM
         H+aw==
X-Forwarded-Encrypted: i=1; AJvYcCXoQbJ4X3OVeDk9XM9J16y4j7Ee82GmSs20idA+nkNOQA3hgy4BsHY8LkNMVhwx/4SRiXpZNOACKmUO8kA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW4pxWL78sxRaz1eVR2KHg3xegLlXbcaczrVFgZSIMUE9tBSE9
	8xZSm9X601UVTO4f4xV2JDndMQHxBzrolUDVXo7bNhqJWytyLY9Qk/+3UElNIUqoTw==
X-Gm-Gg: ASbGnctc5ty/a3rCKsJmvDSNjFUB/7UqgihfoSytv/Z3PDHgwfctgGY+kbnWK+oo5jm
	VKVWrKbHo2IhJKyaL/a/mdnzl02oYDatF73c53IpUlny/G88/8iHHqd8UI7j6qlm6lscrV4cbbG
	9YWgWIIbVi/wgBrdyhaV+xa0c0E6vFzxq1BYqt2vEG3CbJk+6Zi9NJL05aEjh7WTXCslpqd6u/9
	Q+E5bjk617yrzVCgNfnuyyrOrdEEKYhlVwfMQBy9uCj1ARucBIQPba/VrpkSY5LPfAQ0CwG97HQ
	lMbeWwAguRJhyQBNGGzFp+4Hiiv0hXE+8jA4nHX4sUMu5/bS7g7XTd9YmDHy82BqfivNj4TgP/K
	24z9i+FvfwLjMPy2CyRz9K6ShrbTB4y82GNY0d9/kgvrBV6tuysxoQODl7tt5
X-Google-Smtp-Source: AGHT+IHS6NofW0WYxi3TV2AhPFpwdgjA6EDUnQjgbdMjDy5XZkM/36ALxK3pR9VP+K3j4Rz5KHThMQ==
X-Received: by 2002:a05:6a00:2e97:b0:781:171f:df6f with SMTP id d2e1a72fcca58-781171fe2a6mr12619263b3a.18.1759132336800;
        Mon, 29 Sep 2025 00:52:16 -0700 (PDT)
Received: from bytedance ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b27ae1sm10623808b3a.65.2025.09.29.00.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 00:52:16 -0700 (PDT)
Date: Mon, 29 Sep 2025 15:51:58 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Matteo Martelli <matteo.martelli@codethink.co.uk>
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
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/4] sched/fair: Propagate load for throttled cfs_rq
Message-ID: <20250929075158.GA426@bytedance>
References: <20250910095044.278-1-ziqianlu@bytedance.com>
 <20250910095044.278-2-ziqianlu@bytedance.com>
 <58a587d694f33c2ea487c700b0d046fa@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58a587d694f33c2ea487c700b0d046fa@codethink.co.uk>

On Tue, Sep 23, 2025 at 03:05:29PM +0200, Matteo Martelli wrote:
> Hi Aaron,
> 
> On Wed, 10 Sep 2025 17:50:41 +0800, Aaron Lu <ziqianlu@bytedance.com> wrote:
> > Before task based throttle model, propagating load will stop at a
> > throttled cfs_rq and that propagate will happen on unthrottle time by
> > update_load_avg().
> > 
> > Now that there is no update_load_avg() on unthrottle for throttled
> > cfs_rq and all load tracking is done by task related operations, let the
> > propagate happen immediately.
> > 
> > While at it, add a comment to explain why cfs_rqs that are not affected
> > by throttle have to be added to leaf cfs_rq list in
> > propagate_entity_cfs_rq() per my understanding of commit 0258bdfaff5b
> > ("sched/fair: Fix unfairness caused by missing load decay").
> > 
> > Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
> > ---
> 
> I have been testing again the patch set "[PATCH v4 0/5] Defer throttle
> when task exits to user" [1] together with these follow up patches. I
> found out that with this patch the kernel sometimes produces the warning
> WARN_ON_ONCE(rq->tmp_alone_branch != &rq->leaf_cfs_rq_list); in
> assert_list_leaf_cfs_rq() called by enqueue_task_fair(). I could
> reproduce this systematically by applying both [1] and this patch on top
> of tag v6.17-rc6 and also by directly testing at commit fe8d238e646e
> from sched/core branch of tip tree. I couldn't reproduce the warning by
> testing at commmit 5b726e9bf954 ("sched/fair: Get rid of
> throttled_lb_pair()").

Just a note that while trying to reproduce this problem, I noticed a
warn triggered in tg_throttle_down() with one setup. It's a different
problem and I've sent a patch to address that:
https://lore.kernel.org/lkml/20250929074645.416-1-ziqianlu@bytedance.com/

