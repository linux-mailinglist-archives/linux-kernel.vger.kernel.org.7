Return-Path: <linux-kernel+bounces-853842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D893BDCBEC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF41619274B6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2F2311C1D;
	Wed, 15 Oct 2025 06:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJzKPCMB"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E11830F933
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760509903; cv=none; b=AXJKXN8XNFEXDp/CjKdvwkw2PGpnW/6NqK4PUZUUSLBncC8f23F/QXF/hHyG5Yefhf1xQoiu/rYML3hyK+ES6nMSKixIGMn3ysWKJIRytD+91T7RPFsV6mgWmJQ4N0xJxAbQuUWNv+DWZbCa+vhVRtzQEey0sirs2u5SnkAxtDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760509903; c=relaxed/simple;
	bh=17F9U2UgiKYPf6wYF52Q4TIKXZnhLj9+olqtNPYZDFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EVfe8rsTm2Yz+p32LbxJmd721f5dQo4b3bNvQxlA3XWuhZoBoNJwzQ1ahZzfMBcpO0GDP0ikIT6caN+d7P+gI8OWLqv3MsRjvMdXaiG0/farkO4+6WIdyZOCTABr5wNt351WqYik9eG9EhCNdXO3avFgr+bMI+yRaZte3itUDmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJzKPCMB; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-330631e534eso6437886a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 23:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760509902; x=1761114702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfnpnwV8KKjsro9nT3C1YnZZZr2ULkad4laMgUYFndo=;
        b=GJzKPCMBEhrpnzwXUjT8hkxOgnQB/kjwCz6MYlm+sTdgn0RdxVvqLqjvapilIJ/JM2
         oCfGiaAJogy0tTys9YNuNJ/UwXaC5tFbRtU9PydyRiIt/C2tNC+JlD0QIEkrGXFn21cY
         PZRX60HClfeewzZqYVQgClPsyX3h974iU949YDgmv7r9LBRLbtFgfnizlvFHZ0zgnPBh
         VmPeoigg0k6X36l8EXRLj1zf2nWYMpk3JpHQGCrR9tdMRD8QHteJNTzbJirRoFOpQuUK
         Qq9QVpnrDf6XCL4M83FCTq3lfyD67NaDIhnz92MGcJf8nxh3wraVNzYPRRmULeNMQQ0i
         xXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760509902; x=1761114702;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TfnpnwV8KKjsro9nT3C1YnZZZr2ULkad4laMgUYFndo=;
        b=vAqL51J37wifMKEu5sB1NNoxlrAUq4uXtbme4tAlvnVXVenylAFtIvsShQDUgPVSaO
         iXaXO5e0N7+HgLgvbCfRMRVwRcdu7lRWxVD7SsmGW+NwKvSClSFwwPXMq9tiigCCAbxk
         sw8sqDuwYxKsVp2mNgTXZP2PIZDSATsbLU6ONJcJt2T5ROH9hnRbBm35hPTtHhpL3F+j
         Obf4dFy1ImKwlUhUcnZijjYZG11+T932KZfhmNPUgh0yvN31JxU/B8NCkEOfCCseDHHM
         o+JlPei4+rM9FHdZGgvMD3jPMTs3XsBehRs9qtvoNCWhE89Qh9Ba7O9iB3LmatR4+x4s
         /G7A==
X-Forwarded-Encrypted: i=1; AJvYcCXbbuRxFhpvjoM1gmhooG4owlVFEj6ujENKM6X3ayqbUpKZ6N32r6cwykZI/BcVIkWrsTPxvSGwLZnsr4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9x4Pls27rf1vlUVugObjKJz2GxHtCJkYGEQDetzzXplzURl64
	/TIi9mp4LhRveRQCjdnrnsmbrA/yCY292gAHr/0hGQ78js1IE3eWM6bu
X-Gm-Gg: ASbGncsaxWFL2Do02jSgTZXbcX8vcIZ58HPELawDt3Ul08wpNGw6+RWL0B/zW4gnfI5
	9fm3kUn8w0Oqe7nkRfQ+COmsuUWE0jg9F/sZaCCasGui/v52lG6oQYuJObOE2If/nE6gbT7wZcb
	DLwmlQ66OeOy/G1/eV/fgbENwlM3VWBud8s6TqutyLdaHanwkR6B+ZcpiMCI1b7QtdImef90ovm
	qNMSNgqa3G0fEe2xM9QvyHq/lfAflTNdLfXh/oOO3wDD2cF6nHsOZtszgp+l+76HEKNFl5eAU4c
	466w9WBF4FlZoer1oLP4oIZcC5FQ85dEX5H5+tfxZlZtKiG4r4OXFXetPTj6eSVDtV5iTvTQyjL
	D+PyilPiCmrg7gKkXp9ditqmYP2lm7Odr6g3pEGd+eP5oT858QagB3fvrrjf6JuOFf/c0wxVQ0g
	f/OPseXbc=
X-Google-Smtp-Source: AGHT+IFKM4y4U23c29hYgRMPY9Vk3kATF2i4YFPNCWy3sq56GEIjVq1aubZx3vmrGcr8c/G5igkaxQ==
X-Received: by 2002:a17:90b:4b85:b0:32b:6eed:d203 with SMTP id 98e67ed59e1d1-33b5127b3bdmr40949256a91.24.1760509901432;
        Tue, 14 Oct 2025 23:31:41 -0700 (PDT)
Received: from [10.125.192.72] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b9786f693sm1132547a91.15.2025.10.14.23.31.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 23:31:40 -0700 (PDT)
Message-ID: <4902f7d4-c6ee-bc29-dd7f-282d19d0b3b2@gmail.com>
Date: Wed, 15 Oct 2025 14:31:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] sched/fair: Prevent cfs_rq from being unthrottled with
 zero runtime_remaining
To: Aaron Lu <ziqianlu@bytedance.com>
Cc: Valentin Schneider <vschneid@redhat.com>, Ben Segall
 <bsegall@google.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Chengming Zhou <chengming.zhou@linux.dev>, Josh Don <joshdon@google.com>,
 Ingo Molnar <mingo@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Xi Wang <xii@google.com>,
 linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
 Chuyi Zhou <zhouchuyi@bytedance.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 Songtang Liu <liusongtang@bytedance.com>, Chen Yu <yu.c.chen@intel.com>,
 Matteo Martelli <matteo.martelli@codethink.co.uk>,
 =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20250929074645.416-1-ziqianlu@bytedance.com>
 <c4a1bcea-fb00-6f3f-6bf6-d876393190e4@gmail.com>
 <20251014090728.GA41@bytedance>
 <84382429-02c1-12d5-bdf4-23e880246cf3@gmail.com>
 <20251014115018.GC41@bytedance>
 <ded8b9bf-c9bb-8a41-541d-1bef354e4296@gmail.com>
 <20251015025154.GA35@bytedance>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <20251015025154.GA35@bytedance>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/10/15 10:51, Aaron Lu wrote:
> On Wed, Oct 15, 2025 at 09:43:20AM +0800, Hao Jia wrote:
> ... ...
>> Yes, I've already hit the cfs_rq->runtime_remaining < 0 condition in
>> tg_unthrottle_up().
>>
>> This morning, after applying your patch, I still get the same issue.
>> However, As before, because cfs_rq->curr isn't NULL,
>> check_enqueue_throttle() returns prematurely, preventing the triggering of
>> throttle_cfs_rq().
>>
>>
>> Some information to share with you.
> 
> Can you also share your cgroup setup and related quota setting etc. and
> how to trigger it? Thanks.

I ran some internal workloads on my test machine with different quota 
settings, and added 10 sched messaging branchmark cgroups, setting their 
cpu.max to 1000 100000.

perf bench sched messaging -g 10 -t -l 50000 &

I'm not sure if the issue can be reproduced without these internal 
workloads.

Thanks,
Hao

