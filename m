Return-Path: <linux-kernel+bounces-769238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE43EB26BB0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF8A188A62D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB6F24502D;
	Thu, 14 Aug 2025 15:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MgEuEiGZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334DA24167F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186884; cv=none; b=TJhdJOkhIEyhzPy0o3eqnvoDjxV1dEieoJ6+uvks2qNwsodcmxDgk1OT3mj8wbWaqNZz+FRzBoQA/BUb5NbWEOihVX+LJ7GVu4/juiMtpqSCk7iyPK1+Cz2o6XxFvau4CLGIPfc2fJY4UtQHwTC0ZlxTZb07CIKkczt6wkYhoOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186884; c=relaxed/simple;
	bh=vxbUBZLeqSaZmAih4KWD9p4o6a+gjkGNgT8HqQYq2xQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JA4v2fTxXddhvgTo8mcMAOghJymX6wi58wEi04sgX/E4EEAoCZ/Cpxd3KqoewkdbbRt2RFmpGHZ4sbcwTA3qLajMlGohcZjuPkSnApL4EO1h49E5IERu9vH4ZgSE+pw3g7h+9qXUkwPHyE+G7vNTrDx0JdT4gB3dlW+u2m6QlSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MgEuEiGZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755186882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pw6J7G4lublkYHd4TwpQ/RsLsKwRDz0RFjIsgsnVAJk=;
	b=MgEuEiGZIeodFneBLYiOp4jEwrsJqEekpycfW+3WKpxtdB3bR9QoAeXvOnM08alEhuy1Jy
	4nGVWsYNUWpAWdCXGQ+jiYvEI/j3COu85oIYssuM+DJgZZVUryvwv8T7cTYfGeAOK5DD+9
	qrgDZefnPJeCirwiI98k21RwwTd+Pf0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-ig0ngxLWOlmZsnHpAVxLWQ-1; Thu, 14 Aug 2025 11:54:40 -0400
X-MC-Unique: ig0ngxLWOlmZsnHpAVxLWQ-1
X-Mimecast-MFC-AGG-ID: ig0ngxLWOlmZsnHpAVxLWQ_1755186880
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e8705feefaso292444085a.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755186880; x=1755791680;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pw6J7G4lublkYHd4TwpQ/RsLsKwRDz0RFjIsgsnVAJk=;
        b=JbCDwy0GiOSzqjkjrLDNTOicw5f6zxt1ePxF8kFtTcKAzdOSfB9EoaUpyQvgnw8ihg
         4WoC02gZNdCoQUcyuRix66i+BUN+8ETKugT6IH06X9Gt6NbE1Pogq+4ahEjHR3RtxCkM
         Z48tsooA1MVafbJZWg70TV0I1jKUvrO8PPSjRYMBMFC8qkRJXFTBOXkx1hsQ2+KZ5c/V
         SANe6qWuVXmnJh2nhaiCQck2wp5xD3uLI/ashQSTTqa9oNanSyahwXAtW2MqORjhbi8s
         KBAwotkn4ieEtVq1e3LPfa2vGe51laBPcF1YPf6nGiO+seaGcJbX2D5bme06TRAFvtu+
         NJVw==
X-Forwarded-Encrypted: i=1; AJvYcCV+mU00EHH2+7yL8/2zKNe95c1OQGX0zk9FCHMMcFk4nSqxESIS2UQ6taNiuX2QfGYWmobJSAvMWDsHsXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa2fSkY+pBv3Zkl0pvW6wTHfpAQJTPmlnsSF3slvQ0L5bgnloz
	31CubVupr1CMvBv3AzcYL9xp2PVFq9j6lwDr2Wzp7tZeAwbcqr9M02w2bc3KGABc9xJ1ijBr/Qu
	lbQSfM0BH5eUJ7afO51owyVl0qHYWLiCyn5JwbV8any2MOlk85qEbVZmCnKmoB/H4EQ==
X-Gm-Gg: ASbGncuwBgUFIMpXIl+CH+qYBPzwQOY7xutPGVakLHVgA8t4GUSL8IJJ7kPQMOdJiJn
	RjWqZR/IZp9prd9NnkVLJXKZjl10Yf5xBR+9ZJ7IEHdm7YHBolyfOV1WwEbl0Iw9inFapyCRcjC
	YMxidSpqoHZUoXFhSn1S6F3M9mtqI+cjjK+pTXNZ/TgsfZEODrtu+5NF/nv2PK1eEHm5zfXCk97
	zZbdQonn2m0Bd2C3gYzMINnTAwvFsye/JXE4sTOSUn0mbatLlmiLcLYzACLuTYi6CUe84Wwu1rn
	nQG/K+17gqjiKa0spQdKzufEjOg5wMT2/Hlrtmo2RPKT2mE9AsryVsvi1dGNimtunD3n9x+SOBi
	v7je9UCga2vGAO+ev9rjmAxmx
X-Received: by 2002:a05:620a:1a11:b0:7e8:61b4:fe76 with SMTP id af79cd13be357-7e8705952a3mr476264385a.42.1755186880135;
        Thu, 14 Aug 2025 08:54:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9+hBPLWupIDIUMUZR0Os1k/8GAxJxAOwMDTb1NQNNmHkqSzifuYkAWsXjuU/YaLeCdE0qtA==
X-Received: by 2002:a05:620a:1a11:b0:7e8:61b4:fe76 with SMTP id af79cd13be357-7e8705952a3mr476259785a.42.1755186879671;
        Thu, 14 Aug 2025 08:54:39 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e84a217627sm813482685a.32.2025.08.14.08.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 08:54:38 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Aaron Lu <ziqianlu@bytedance.com>
Cc: Ben Segall <bsegall@google.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Peter Zijlstra <peterz@infradead.org>, Chengming
 Zhou <chengming.zhou@linux.dev>, Josh Don <joshdon@google.com>, Ingo
 Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Xi Wang <xii@google.com>, linux-kernel@vger.kernel.org, Juri Lelli
 <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Chuyi
 Zhou <zhouchuyi@bytedance.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>, Songtang Liu
 <liusongtang@bytedance.com>
Subject: Re: [PATCH v3 3/5] sched/fair: Switch to task based throttle model
In-Reply-To: <20250812084828.GA52@bytedance>
References: <20250715071658.267-1-ziqianlu@bytedance.com>
 <20250715071658.267-4-ziqianlu@bytedance.com>
 <xhsmhv7myp46n.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20250808101330.GA75@bytedance>
 <xhsmhsei2ox4o.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20250812084828.GA52@bytedance>
Date: Thu, 14 Aug 2025 17:54:34 +0200
Message-ID: <xhsmhh5y9j3ut.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/08/25 16:48, Aaron Lu wrote:
> On Fri, Aug 08, 2025 at 01:45:11PM +0200, Valentin Schneider wrote:
>> On 08/08/25 18:13, Aaron Lu wrote:
>> > Let me run some scheduler benchmark to see how it impacts performance.
>> >
>> > I'm thinking maybe running something like hackbench on server platform=
s,
>> > first with quota not set and see if performance changes; then also test
>> > with quota set and see how performance changes.
>> >
>> > Does this sound good to you? Or do you have any specific benchmark and
>> > test methodology in mind?
>> >
>>
>> Yeah hackbench is pretty good for stressing the EQ/DQ paths.
>>
>
> Tested hackbench/pipe and netperf/UDP_RR on Intel EMR(2 sockets/240
> cpus) and AMD Genoa(2 sockets/384 cpus), the tldr is: there is no clear
> performance change between base and this patchset(head). Below is
> detailed test data:
> (turbo/boost disabled, cpuidle disabled, cpufreq set to performance)
>
> hackbench/pipe/loops=3D150000
> (seconds, smaller is better)
>
> On Intel EMR:
>
> nr_group          base             head          change
>  1              3.62=C2=B12.99%      3.61=C2=B110.42%      +0.28%
>  8              8.06=C2=B11.58%      7.88=C2=B15.82%       +2.23%
> 16             11.40=C2=B12.57%     11.25=C2=B13.72%       +1.32%
>
> For nr_group=3D16 case, configure a cgroup and set quota to half cpu and
> then let hackbench run in this cgroup:
>
>                  base             head           change
> quota=3D50%      18.35=C2=B12.40%     18.78=C2=B11.97%       -2.34%
>
> On AMD Genoa:
>
> nr_group          base             head          change
>  1             17.05=C2=B11.92%     16.99=C2=B12.81%       +0.35%
>  8             16.54=C2=B10.71%     16.73=C2=B11.18%       -1.15%
> 16             27.04=C2=B10.39%     26.72=C2=B12.37%       +1.18%
>
> For nr_group=3D16 case, configure a cgroup and set quota to half cpu and
> then let hackbench run in this cgroup:
>
>                   base             head          change
> quota=3D50%      43.79=C2=B11.10%     44.65=C2=B10.37%       -1.96%
>
> Netperf/UDP_RR/testlen=3D30s
> (throughput, higher is better)
>
> 25% means nr_clients set to 1/4 nr_cpu, 50% means nr_clients is 1/2
> nr_cpu, etc.
>
> On Intel EMR:
>
> nr_clients     base                 head             change
>   25%       83,567=C2=B10.06%         84,298=C2=B10.23%        +0.87%
>   50%       61,336=C2=B11.49%         60,816=C2=B10.63%        -0.85%
>   75%       40,592=C2=B10.97%         40,461=C2=B10.14%        -0.32%
>  100%       31,277=C2=B12.11%         30,948=C2=B11.84%        -1.05%
>
> For nr_clients=3D100% case, configure a cgroup and set quota to half cpu
> and then let netperf run in this cgroup:
>
> nr_clients     base                 head             change
>  100%       25,532=C2=B10.56%         26,772=C2=B13.05%        +4.86%
>
> On AMD Genoa:
>
> nr_clients     base                 head             change
>  25%        12,443=C2=B10.40%         12,525=C2=B10.06%        +0.66%
>  50%        11,403=C2=B10.35%         11,472=C2=B10.50%        +0.61%
>  75%        10,070=C2=B10.19%         10,071=C2=B10.95%         0.00%
> 100%         9,947=C2=B10.80%          9,881=C2=B10.58%        -0.66%
>
> For nr_clients=3D100% case, configure a cgroup and set quota to half cpu
> and then let netperf run in this cgroup:
>
> nr_clients     base                 head             change
> 100%         4,954=C2=B10.24%          4,952=C2=B10.14%         0.00%

Thank you for running these, looks like mostly slightly bigger variance on
a few of these but that's about it.

I would also suggest running similar benchmarks but with deeper
hierarchies, to get an idea of how much worse unthrottle_cfs_rq() can get
when tg_unthrottle_up() goes up a bigger tree.


