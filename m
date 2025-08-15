Return-Path: <linux-kernel+bounces-770620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD67B27D29
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAF4218951D5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D536C2E6133;
	Fri, 15 Aug 2025 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CZVbRzZ/"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25412877D8
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 09:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755250224; cv=none; b=k2+7/aooQZX9c6FNn2N8HgW4FzFjcDAAJZhJeEVLTiRGSZiapcQcIrDKru1cIU7kHuXcjUHgXJAAUscBVyG6xlG0vuppEaj8asUqLhNqgvnEhPjGn1OTgX5S2EslPs6o1PvHRtWWwIRCRzmk0U5uUHcUcYMS6inIAJtsiSDytJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755250224; c=relaxed/simple;
	bh=mw2d4nz4sSWJimZjUhLQRVQ31lJfTbzen5k4OeFFgGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzL852j4HVEVQUaq1w+QoV+6IDZNs2oEv4Qhdsvwj4hJxgyhndwDlgql74tnyXIyRETX/beNZvv7lXCtB6GXxUic6shQb7VUJSUMHwd95hycRmTHoxmZZG2SSrTPixePttOMSb72z8UqiEbvNM8z8Jyeiy61Gva3P9oQ9bIneNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CZVbRzZ/; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32326de9f4eso1740079a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 02:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755250222; x=1755855022; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/hiGDZSpvdXgGnBCX8CvR334ywvPtBE87nCdQSVn9cc=;
        b=CZVbRzZ/Ek1PrtYifdisjYgttuAfV/QQGhju8XD1Cosf3KFRsp3KLZ7MqGMpXZalhF
         I4BKaZZO6aKfMQjDJvxH4bUpLi565NVjeb9dHU3SxhvunY7pAKElPHASKrvWQlqfJwx5
         0NIAhca+SLAd2xFEmE8pdPAkqnhtHYpv27suputCaRiIqfrZXVPVZ9gHJZfdxMQ24DaU
         agppZwrFzXPn1yYoRHbBojY5fmiD0WFoRiQvmUVYTHgRcp4x6WGiP8Jm4LMRX8hqIkFM
         kLLXcFz10rpKip3YIT9pryL16J5JLVyfFD/6ewdsYeX0vhSQ452r4ElrdEIbmD7dRs/S
         2n8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755250222; x=1755855022;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/hiGDZSpvdXgGnBCX8CvR334ywvPtBE87nCdQSVn9cc=;
        b=GJxeNVQ7qVGvDOyfLyh1g7uX1vGBSYKpBxrJ64NZd/jHUrm4hxD1lVYrpSlKFjmYYS
         tmV7qJsNbtJMNNGnZZhrvGnG35yl72iQ8h1DoeVPktokHFYxPgHP2fJSgUDhQR9IqTQo
         S3im3T3Oq2R5hU+yXQLceHp8bENnD4bOPp6elJaJDpjDL5zwx+wREr3BBtbozAwRDu7G
         ptDhtbXj1IGsZbI8Vuotor3QGtvcLXfEbOZ1HkNWUx49N8P+NtTPX1UV2pDQRTrdH0jO
         xvBiQJAuyloLuYzxUblg96gArfZuHD5AADiSilJwQdPxi+IdZTHIIwFOB+kPuPNz/jCj
         1YtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSHLZ9mLMcqkGm4CjvZy5cnfkMZEutVGZVjnmp2XuXvut1fDvgGMXewkUCb1uNkSc1iwQJXWhlA/ax2Xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPurq0nV7TXR+Q2hZmDONx/CrNw6OTWwCaFdAkt+x5lQgbUwAI
	zDtjbn42S22vM7cMODzW/OXrRE6eNjT2oOopdau+SvIJyhhOs9JpMoeYoHpb7BAwBg==
X-Gm-Gg: ASbGncv8jP7Ri8RpSKOKTqmL1A5WvUvvCfNyAV2Rq4fe8VnZg0P4SjYlcfOvrynaU+z
	iCcYIp9TPAZMuGGyeQM3iHLCdpxwAO8gTJmDTQCX/B2hg+IaVSqdmtLo17E6UFFR1PBtu/36YzA
	ZjDtAi71cRAP62Ug2WAOYG4v5GiXWoFbsEk+ZV5kv/kRKLH3a6hNAatvutsIFJA2ANtaBgM5xMv
	D7FIrnBnG/Ls9+w1BhsyJFXmEEVACt3Nuy8Yq3AfVEZoK1ZdbiMiUD8IC0pgPUpPDkeBV/J+FKR
	1hnku1pSbh9SoWKgP2B0nDvsivJ21cZ1GQyYDfMnE0kL4L+Ihv01m7QRsiKKfqmr/7MSwsvkz5T
	5Tu/lP2De/PkLgbDN3MsfnWPDrwLerPNFE9PKSTYldTRdPFc=
X-Google-Smtp-Source: AGHT+IH1pVAWTUCVVn0aVpmaQszYktxXuN095TLMzkbKArVIEmCjhK0kiy8ZPy1Qn+zFtZNnWRQDlQ==
X-Received: by 2002:a17:90b:3e4f:b0:31f:253e:d34f with SMTP id 98e67ed59e1d1-32342226abbmr2127000a91.19.1755250221862;
        Fri, 15 Aug 2025 02:30:21 -0700 (PDT)
Received: from bytedance ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32331166f03sm3916871a91.25.2025.08.15.02.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 02:30:21 -0700 (PDT)
Date: Fri, 15 Aug 2025 17:30:08 +0800
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
	Songtang Liu <liusongtang@bytedance.com>
Subject: Re: [PATCH v3 3/5] sched/fair: Switch to task based throttle model
Message-ID: <20250815092910.GA33@bytedance>
References: <20250715071658.267-1-ziqianlu@bytedance.com>
 <20250715071658.267-4-ziqianlu@bytedance.com>
 <xhsmhv7myp46n.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20250808101330.GA75@bytedance>
 <xhsmhsei2ox4o.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20250812084828.GA52@bytedance>
 <xhsmhh5y9j3ut.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xhsmhh5y9j3ut.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On Thu, Aug 14, 2025 at 05:54:34PM +0200, Valentin Schneider wrote:
> On 12/08/25 16:48, Aaron Lu wrote:
> > On Fri, Aug 08, 2025 at 01:45:11PM +0200, Valentin Schneider wrote:
> >> On 08/08/25 18:13, Aaron Lu wrote:
> >> > Let me run some scheduler benchmark to see how it impacts performance.
> >> >
> >> > I'm thinking maybe running something like hackbench on server platforms,
> >> > first with quota not set and see if performance changes; then also test
> >> > with quota set and see how performance changes.
> >> >
> >> > Does this sound good to you? Or do you have any specific benchmark and
> >> > test methodology in mind?
> >> >
> >>
> >> Yeah hackbench is pretty good for stressing the EQ/DQ paths.
> >>
> >
> > Tested hackbench/pipe and netperf/UDP_RR on Intel EMR(2 sockets/240
> > cpus) and AMD Genoa(2 sockets/384 cpus), the tldr is: there is no clear
> > performance change between base and this patchset(head). Below is
> > detailed test data:
> > (turbo/boost disabled, cpuidle disabled, cpufreq set to performance)
> >
> > hackbench/pipe/loops=150000
> > (seconds, smaller is better)
> >
> > On Intel EMR:
> >
> > nr_group          base             head          change
> >  1              3.62±2.99%      3.61±10.42%      +0.28%
> >  8              8.06±1.58%      7.88±5.82%       +2.23%
> > 16             11.40±2.57%     11.25±3.72%       +1.32%
> >
> > For nr_group=16 case, configure a cgroup and set quota to half cpu and
> > then let hackbench run in this cgroup:
> >
> >                  base             head           change
> > quota=50%      18.35±2.40%     18.78±1.97%       -2.34%
> >
> > On AMD Genoa:
> >
> > nr_group          base             head          change
> >  1             17.05±1.92%     16.99±2.81%       +0.35%
> >  8             16.54±0.71%     16.73±1.18%       -1.15%
> > 16             27.04±0.39%     26.72±2.37%       +1.18%
> >
> > For nr_group=16 case, configure a cgroup and set quota to half cpu and
> > then let hackbench run in this cgroup:
> >
> >                   base             head          change
> > quota=50%      43.79±1.10%     44.65±0.37%       -1.96%
> >
> > Netperf/UDP_RR/testlen=30s
> > (throughput, higher is better)
> >
> > 25% means nr_clients set to 1/4 nr_cpu, 50% means nr_clients is 1/2
> > nr_cpu, etc.
> >
> > On Intel EMR:
> >
> > nr_clients     base                 head             change
> >   25%       83,567±0.06%         84,298±0.23%        +0.87%
> >   50%       61,336±1.49%         60,816±0.63%        -0.85%
> >   75%       40,592±0.97%         40,461±0.14%        -0.32%
> >  100%       31,277±2.11%         30,948±1.84%        -1.05%
> >
> > For nr_clients=100% case, configure a cgroup and set quota to half cpu
> > and then let netperf run in this cgroup:
> >
> > nr_clients     base                 head             change
> >  100%       25,532±0.56%         26,772±3.05%        +4.86%
> >
> > On AMD Genoa:
> >
> > nr_clients     base                 head             change
> >  25%        12,443±0.40%         12,525±0.06%        +0.66%
> >  50%        11,403±0.35%         11,472±0.50%        +0.61%
> >  75%        10,070±0.19%         10,071±0.95%         0.00%
> > 100%         9,947±0.80%          9,881±0.58%        -0.66%
> >
> > For nr_clients=100% case, configure a cgroup and set quota to half cpu
> > and then let netperf run in this cgroup:
> >
> > nr_clients     base                 head             change
> > 100%         4,954±0.24%          4,952±0.14%         0.00%
> 
> Thank you for running these, looks like mostly slightly bigger variance on
> a few of these but that's about it.
> 
> I would also suggest running similar benchmarks but with deeper
> hierarchies, to get an idea of how much worse unthrottle_cfs_rq() can get
> when tg_unthrottle_up() goes up a bigger tree.

No problem.

I suppose I can reuse the previous shared test script:
https://lore.kernel.org/lkml/CANCG0GdOwS7WO0k5Fb+hMd8R-4J_exPTt2aS3-0fAMUC5pVD8g@mail.gmail.com/

There I used:
nr_level1=2
nr_level2=100
nr_level3=10

But I can tweak these numbers for this performance evaluation. I can make
the leaf level to be 5 level deep and place tasks in leaf level cgroups
and configure quota on 1st level cgroups.

I'll get back to you once I finished collecting data, feel free to let
me know if you have other idea testing this :)

