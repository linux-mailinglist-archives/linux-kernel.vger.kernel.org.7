Return-Path: <linux-kernel+bounces-781739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B683B31617
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D93561D027AE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050352C029E;
	Fri, 22 Aug 2025 11:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Hjij+I5n"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0E020330
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755860837; cv=none; b=SGW/WHUhJIEgt4RsOljNvfbuacuQp1GqmMNdUA43LqLljpr5hZ7+cyp/bWJuF4kAopJeErIwWNqSr8+Dbug8lInV7onfZ1lNr8VXY/VwQsrRnaD5P4CvoRPn5PDrBa1Oht2d7+UfFQCSsMyNnok9K1iO6VYUfOuwSYFPE+s9zPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755860837; c=relaxed/simple;
	bh=fcyQNmM+AxZ9WnvmNXEBMQlEP47/8SfYBuu3gpv/Wk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCwoU7g0bO4HQykwaN86Emg9shD4jyYBsOMNk7Y/xhhPoRQ/OJE9f46oHV6MFT9ywloglKm5biig1+37mDZi+AVfTxyGrUlxUEDz4bbpk9eSra07sDqNQQC+qYCMOue0bFhIwwqSinMt50dhc7qSLrou+3jfm3XrvLUwcs5JwxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Hjij+I5n; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32326e09f58so2294806a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755860834; x=1756465634; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aXKH8QLfmVE5g1vVMm8j+DpUqgaAJYpsi69hloCXXHM=;
        b=Hjij+I5naKR1Sy/c/HIUCIbWJPrjPzb1U1pjjlyRM9AZfpHdaGj9ljTa8doNvLC+rm
         SjcvN+1iedw665uZSimk0Ajgn54LOWBJNZjbVFCNCOnAezxzndowDQavARhslA8eIcLo
         Qe/waeTEXRd9QPDPu2ejJMba6B6HXY2cejteaOvQLIZyzxGn/7xDo/T4SNjJd2ODXwhU
         OKrSGPIt5zMYQdERyQBK81rEmcl+U5L4BRN1gmVUh5iOu569/NoWlBFWr0qq75wQLy+f
         lwBhiD4DG/Wzd4wYDXtGvHPD4baixxiIN0AeEtr/0UHKPfcwGY9SQyQ0dY/Dz9RNb6e1
         YPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755860834; x=1756465634;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aXKH8QLfmVE5g1vVMm8j+DpUqgaAJYpsi69hloCXXHM=;
        b=Rcrh/EubDndQd0qz2RaXQkAc7NaEvzCrSStS863s8Vq0VZRnGNClQZUg8RPEJcdQ5m
         ksXqJpVqouP1ORJ63v2FWobBJJr1iYRMa15KxpZ8ZFV26HTEK1hDhwpsHMAT1fmasuvb
         fg+bhZCqOrQRsr9uP9qH//daOGciacYl1P+pRVLksiNWCfZhxPenfuroWRXKXakkNpNA
         nz1ZUB+uSfBU+iM9LDuLJci2paOMCR9BkzZVf3jJYMUM1dxdsJcwSEwW0eeX5fN6yjv3
         F/2BGrmK1jWtxHs6zCoEayrx8iS6TIN28QurUZqVcrzduZZp6TpBjlx6UKdl5W2SE9Ki
         /cnA==
X-Forwarded-Encrypted: i=1; AJvYcCUd4CZmn5pfaypOKKeT9iAT6w+wg7s8x+zSDDPyvsuv5/wOwtPSk7BP2zuO+1SzCUZjOCDG8C99J3BERfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkXOy4zveU6Sv84jyM5I2zoJrzx5U1NZlbFC2kSMVnrc1Qj7ia
	BIzwp5RFi9mWqaTzUSo2xg5D9KnXpI5ZHrpksEVzs9k46ZVv8EXzQh9LFIxjDrZpjg==
X-Gm-Gg: ASbGnctQb5GxMi6gINUn8i8/R6c0XpC54k6FCsUm/PAyTFSeguXkfs3kmHQ2SwtAKOv
	1Yvn4bHJT0emoOQ+PdwwjLgp3uq0OCet6Jax03Tm24ML3yua9+oHfB2Pn4CAr0BQx8RM8kawq3m
	kqqqexd23ULpjCyRt6QiRlwD4OOEUnHNG+CY1fKlK9VU4tWQXiisQAhr+qXTffGqMQ1BERPwZjz
	JzxBdKAjMepaF+ncpqf7TV4sLDF/wKNDvWbGjzEmQa6mGcvS4Fe10daD9LPLsjfJwMWUmJWQvMv
	GczrY8h4ABg1pKRmsOx1UgcRjiRxGoulUx4ibYY+/VMbZdrjbOUBqgk46RGBC4JOAEOg7y7rlp7
	SQw2fzQgsbb+4l8gZWxgeUp+aXAgW7qCEFLT3csQR3drWTTs=
X-Google-Smtp-Source: AGHT+IEuaYun3uRHRAbGrw3asa7BLUzt5VLWpj0XGZDjut8XTrLo65W08ZyKdAPYLNKT3I1W9nUdMw==
X-Received: by 2002:a17:90b:384c:b0:324:ec53:138f with SMTP id 98e67ed59e1d1-32515efa487mr4271695a91.15.1755860833716;
        Fri, 22 Aug 2025 04:07:13 -0700 (PDT)
Received: from bytedance ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d120528sm10623345b3a.35.2025.08.22.04.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 04:07:13 -0700 (PDT)
Date: Fri, 22 Aug 2025 19:07:01 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: Ben Segall <bsegall@google.com>,
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
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v3 3/5] sched/fair: Switch to task based throttle model
Message-ID: <20250822110701.GB289@bytedance>
References: <20250715071658.267-1-ziqianlu@bytedance.com>
 <20250715071658.267-4-ziqianlu@bytedance.com>
 <xhsmhv7myp46n.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20250808101330.GA75@bytedance>
 <xhsmhsei2ox4o.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20250812084828.GA52@bytedance>
 <xhsmhh5y9j3ut.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20250815092910.GA33@bytedance>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250815092910.GA33@bytedance>

On Fri, Aug 15, 2025 at 05:30:08PM +0800, Aaron Lu wrote:
> On Thu, Aug 14, 2025 at 05:54:34PM +0200, Valentin Schneider wrote:
... ...
> > I would also suggest running similar benchmarks but with deeper
> > hierarchies, to get an idea of how much worse unthrottle_cfs_rq() can get
> > when tg_unthrottle_up() goes up a bigger tree.
> 
> No problem.
> 
> I suppose I can reuse the previous shared test script:
> https://lore.kernel.org/lkml/CANCG0GdOwS7WO0k5Fb+hMd8R-4J_exPTt2aS3-0fAMUC5pVD8g@mail.gmail.com/
> 
> There I used:
> nr_level1=2
> nr_level2=100
> nr_level3=10
> 
> But I can tweak these numbers for this performance evaluation. I can make
> the leaf level to be 5 level deep and place tasks in leaf level cgroups
> and configure quota on 1st level cgroups.

Tested on Intel EMR(2 sockets, 120cores, 240cpus) and AMD Genoa(2
sockets, 192cores, 384cpus), with turbo/boost disabled, cpufreq set to
performance and cpuidle states all disabled.

cgroup hierarchy:
nr_level1=2
nr_level2=2
nr_level3=2
nr_level4=5
nr_level5=5
i.e. two cgroups in the root level, with each level1 cgroup having 2
child cgroups, and each level2 cgroup having 2 child cgroups, etc. This
creates a 5 level deep, 200 leaf cgroups setup. Tasks are placed in leaf
cgroups. Quota are set on the two level1 cgroups.

The TLDR is, when there is a very large number of tasks(like 8000 tasks),
task based throttle saw 10-20% performance drop on AMD Genoa; otherwise,
no obvious performance change is observed. Detailed test results below.

Netperf: measured in throughput, more is better
- quota set to 50 cpu for each level1 cgroup;
- each leaf cgroup run a pair of netserver and netperf with following
  cmdline:
  netserver -p $port_for_this_cgroup
  netperf -p $port_for_this_cgroup -H 127.0.0.1 -t UDP_RR -c -C -l 30
  i.e. each cgroup has 2 tasks, total task number is 2 * 200 = 400
  tasks.

On Intel EMR:
              base            head         diff
throughput    33305±8.40%     33995±7.84%  noise

On AMD Genoa:
              base            head         diff
throughput    5013±1.16%      4967±1.82    noise


Hackbench, measured in seconds, less is better:
- quota set to 50cpu for each level1 cgroup;
- each cgroup runs with the following cmdline:
  hackbench -p -g 1 -l $see_below
i.e. each leaf cgroup has 20 sender tasks and 20 receiver tasks, total
task number is 40 * 200 = 8000 tasks.

On Intel EMR(loops set to 100000):

         base             head              diff
Time     85.45±3.98%      86.41±3.98%       noise

On AMD Genoa(loops set to 20000):

         base             head              diff
Time     104±4.33%        116±7.71%        -11.54%

So for this test case, task based throttle suffered ~10% performance
drop. I also tested on another AMD Genoa(same cpu spec) to make sure
it's not a machine problem and performance dropped there too:

On 2nd AMD Genoa(loops set to 50000)

        base             head               diff
Time    81±3.13%         101±7.05%         -24.69%

According to perf, __schedule() in head takes 7.29% cycles while in base
it takes 4.61% cycles. I suppose with task based throttle, __schedule()
is more frequent since tasks in a throttled cfs_rq have to be dequeued
one by one while in current behaviour, the cfs_rq can be dequeued off rq
in one go. This is most obvious when there are multiple tasks in a single
cfs_rq; if there is only 1 task per cfs_rq, things should be roughly the
same for the two throttling model.

With this said, I reduced the task number and retested on this 2nd AMD
Genoa:
- quota set to 50 cpu for each level1 cgroup;
- using only 1 fd pair, i.e. 2 task for each cgroup:
  hackbench -p -g 1 -f 1 -l 50000000
  i.e. each leaf cgroup has 1 sender task and 1 receiver task, total
  task number is 2 * 200 = 400 tasks.

        base             head               diff
Time    127.77±2.60%     127.49±2.63%       noise

In this setup, performance is about the same.

Now I'm wondering why on Intel EMR, running that extreme setup(8000
tasks), performance of task based throttle didn't see noticeable drop...

