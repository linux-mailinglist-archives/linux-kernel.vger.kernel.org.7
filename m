Return-Path: <linux-kernel+bounces-860506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06710BF04AB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEFFD4F416B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE272F7446;
	Mon, 20 Oct 2025 09:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSewt6+F"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14592F744A
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953331; cv=none; b=QQvXgwWawA3ljavdzdMEaRx7wRk1iUml/GhBUeLWHO+mCTaDhieweFLW9mlp+K+2HH8aVFwD2k3CM9gYcpXJhHLOMf+Gy52S703/Yj50Hh6uXtrcn3mF8GJlqMQntsx5AEWLZssBmJTymsycKMAMh4qLpaSDLdslq3i8y3UjZoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953331; c=relaxed/simple;
	bh=RVTPrB80lKWEGsmuqpwnmhsICyacnpzQ61NitW4p0VA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s1sTtZ2PY45hczkcJY/1pcYsQKonFXZNR8HOAOV5tBcFKOsiGXWUvvI8pgJR28e8EoyGykNP4AgBEb+qNSy9v5m3ymhIPPHZOjfujA+b5YBwhk0k7J9QdMvlKiQ+nuCONIljkDPV95BeTCzNmeiHnl/I9snDwhGqpbV1ZZT9eM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSewt6+F; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-78125ed4052so5170742b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760953329; x=1761558129; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+/kS6CxBIRQj4J5Q4nEC3UkDzwEypj3lIgBGlN4WRQ=;
        b=VSewt6+FCtCiNPvXzOzFhMVMgcPJFwsM5U3w+u4o4EalS7sI8W7kARBw4C/wgUMsV9
         o39F5AzycXqEMUd9kXOAkxJBAxf3hxZkfs2jwlkgp+A7u0Gh2qMwO5xI4dWNpeIMyDaD
         wPEDdBcqa0EFWR71DzXSu0JjmECpfur69BihhddqBVvGRe3sJtIqgdnO4jeJJlXMTB+h
         HWtgorCjqwbpWoZ87czI/E7LHS2rEtX/xY45ya1kRZvSFCwDER8km9y0YpDEp6pjUN+2
         CanuOSPxtQlJASsifBxlsmz3IvQS6hy6VwlHG4PEAwSGN0ts0fSU5KMc+Ls+jgj40Mjk
         E31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760953329; x=1761558129;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1+/kS6CxBIRQj4J5Q4nEC3UkDzwEypj3lIgBGlN4WRQ=;
        b=v4e9jAxlapXohoIdtKyZiZf9IBa10h5MkmTHJrM3Ts68sJ8a2JykSpEvvQNPA72u5u
         ydFgNUTDkwz8YTJXNdaF5Ej/2vRoNILP8Anc9Zun1QGOf424QgWNPAWUscLVqj9yIJpe
         LaVboT24ccGTGxTXomLidZiJdjUdqZCMt1lmneLXN4erLnEAMV8LN12X1fEcOSap3yo2
         vtvaW4+nHiLAsGPnpOShpSmQlldBI2+HN4LWsAHxNlxQVqtXfcy4jHtXOF1J7iEy8cc4
         OhPz596sdHMGyJe7NWKg9kuIPuwNVdgQwHzzVokHUr/AZ6RWe16QsVWQJCxBMdVMP3vQ
         ufCA==
X-Forwarded-Encrypted: i=1; AJvYcCWjyEKfCM+K0onqukA8rX9k1s0ZrauSV9gXfwPHWSUID/DDnbRTDyl1LBnHkqRCNwTmsRCnLGZUtn7YQtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQeUeW3K3wF7RUSwd90QnuFQxZhgX4Z9lGNzq3uukfs+f9zj9p
	p55R+NW5WZ9e8Hh5RMsNqGmM3KR7EUYjHxC/aI9/rxuTXD1wBD+M5Tir
X-Gm-Gg: ASbGncuLKKJIDy7eFMHpLz9xKVN8NV7q67nUXbftWsoJu8Mfvrf/bkU/OUnuBtqhChm
	4WnfcqcD0GM461w1T6qJrvINptsrbyja2+OaEO3BOYGS7XOlf4h0exPe2MkJwkSoMq2agZo1QVF
	zKZM/BsZclccBcr7K9kT/lNAKwL697/AAoiu28j2nEcUx+Eb5KEOSnYYvvNTghYnqzp429+qwoh
	7I2cIrBqGPhKCFREZlyxduFMOkRzSZZIw4cL7o+yFeV6e1JoVckokaDcjsnUe6fgz0Rq3f60gJs
	Ph4q9ck16kSBCNw8dYX85ZDcEytBIUdRJjTSIqPMCGunFR/o/03m//0rlputIyII/0jeMnPZOGV
	giS2yq6TrxtTnYt2KhSdHwy/gg1gtpG7eNVrrUBtyL68i0gVwRaZd5TTZRJaAIIYBwwhE3EkBVl
	W23Dvo5vyvKpOIMaLt1332AsIP22Y=
X-Google-Smtp-Source: AGHT+IFj+kZThsI8QP8qdUS+mgmScYR4Q/utj7nfP7LJYcrpJ+Tv5cbb9yZmSNgMEVow8yoc3dekhw==
X-Received: by 2002:a05:6a20:7f8d:b0:2c7:55a3:6168 with SMTP id adf61e73a8af0-334a8617472mr15913092637.30.1760953328784;
        Mon, 20 Oct 2025 02:42:08 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b349b2sm7419946a12.23.2025.10.20.02.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 02:42:08 -0700 (PDT)
Message-ID: <03fccf9d-50b7-4a7a-a7c2-21dcc06f235a@gmail.com>
Date: Mon, 20 Oct 2025 17:41:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/19] sched/fair: Assign preferred LLC ID to processes
To: "Chen, Yu C" <yu.c.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>, Vern Hao
 <vernhao@tencent.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 Hillf Danton <hdanton@sina.com>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 Jianyong Wu <jianyong.wu@outlook.com>, Yangyu Chen <cyy@cyyself.name>,
 Tingyin Duan <tingyin.duan@gmail.com>, Len Brown <len.brown@intel.com>,
 Aubrey Li <aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Chen Yu <yu.chen.surf@gmail.com>, Adam Li <adamli@os.amperecomputing.com>,
 Tim Chen <tim.c.chen@intel.com>, linux-kernel@vger.kernel.org
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <cfa266cd6ea6fa30cbf7b07573992f18f786955e.1760206683.git.tim.c.chen@linux.intel.com>
 <3df5a8c1-7074-4fcf-adf8-d39137314fd6@intel.com>
 <20251015111542.GQ3289052@noisy.programming.kicks-ass.net>
 <4ec19969-831c-4d9e-b585-fc02db31b343@intel.com>
From: Vern Hao <haoxing990@gmail.com>
In-Reply-To: <4ec19969-831c-4d9e-b585-fc02db31b343@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2025/10/17 12:50, Chen, Yu C wrote:
> On 10/15/2025 7:15 PM, Peter Zijlstra wrote:
>> On Tue, Oct 14, 2025 at 01:16:16PM +0800, Chen, Yu C wrote:
>>
>>> The question becomes: how can we figure out the threads that share
>>> data? Can the kernel detect this, or get the hint from user space?
>>
>> This needs the PMU, then you can steer using cache-miss ratios. But then
>> people will hate us for using counters.
>>
>>> Yes, the numa_group in NUMA load balancing indicates
>>> that several tasks manipulate the same page, which could be an
>>> indicator. Besides, if task A frequently wakes up task B, does it
>>> mean A and B have the potential to share data? Furthermore, if
>>> task A wakes up B via a pipe, it might also indicate that A has
>>> something to share with B. I just wonder if we can introduce a
>>> structure to gather this information together.
>>
>> The wakeup or pipe relation might be small relative to the working set.
>> Consider a sharded in memory database, where the query comes in through
>> the pipe/socket/wakeup. This query is small, but then it needs to go
>> trawl through its memory to find the answer.
>>
>> Something we *could* look at -- later -- is an interface to create
>> thread groups, such that userspace that is clever enough can communicate
>> this. But then there is the ago old question, will there be sufficient
>> users to justify the maintenance of said interface.
>
> I did not intend to digress too far, but since this issue has been 
> brought
> up, a wild guess came to me - could the "interface to create thread 
> groups"
> here refer to something like the filesystem for memory cgroup
> v2 thread mode? I just heard that some cloud users might split the 
> threads
> of a single process into different thread groups, where threads within 
> each
> group share data with one another (for example, when performing K-V 
> hashing
> operations). 

Yes, in our internal business, we encountered similar issues. The actual 
scenario is on AMD virtual machines,

where businesses would spawn multiple concurrent threads, for example, 
around 900 threads, with over 600 threads

handling hash or key-value computations, more than 100 threads dealing 
with network transmission, and some others handling

background logging or monitoring. These threads do not share same hot L3 
cache data. so concentrating these threads would only

exacerbate contention.


Can we differentiate these types of threads? It's obvious that the 
current configuration approach cannot meet the requirements

and will only cause more L3 cache race. Can we use cgroup or other 
methods, or configure through system calls to make

distinctions (the application may not be willing to modify the code) ?

> Using cgroup for this purpose might be a bit overkill, though,
> considering that cgroup itself is designed for resource partitioning 
> rather
> than identifying tasks sharing data. Meanwhile, the hierarchy of cgroup
> could also cause some overhead. If there were a single-layer thread 
> partitioning
> mechanism - similar to the resctrl filesystem - wouldn’t that allow us 
> to avoid
> modifying too much user business code while minimizing coupling with 
> existing
> kernel components?



> thanks,
> Chenyu

