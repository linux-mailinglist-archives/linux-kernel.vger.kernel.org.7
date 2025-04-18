Return-Path: <linux-kernel+bounces-610075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 781A1A92FFE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 04:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7363F46804F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 02:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED3B267F47;
	Fri, 18 Apr 2025 02:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dOigykst"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20041267AF2
	for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 02:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744943436; cv=none; b=A6OPCdZ3htYQHxjpFCPUfdmYE8s7tOs48C2PEOJ3S+jVHMjobw4iYxXVLTvCXKEtHY2oTITmfj55ZAYh4DRqBHFzzfpVXitYFvUhsOc+RlOWJj1tVhD+KLIiZkVJZosaBLeScI5PR1CwxVhp9OnTw15wHnW3G8Zbxz9umi7oEkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744943436; c=relaxed/simple;
	bh=Dd7R3WHb1uxVnekOUpen1sbswsRODZZSYfeRkRcwmWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hAp6AqWv2FRrSGyfUTO2LR9UQOw/oEgbobyvCdts7by1v5yiXDsJYSvmLh58Xeh7uHGKoqbUlBbywFAeHSvCFjrvEjZegMlge9mK2pvj1dzGDYoR7a3fmWx9lg8iLnF9efeZcliSIpNysAuaAAoHxTIbi4arZjprEsolfKxaoiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dOigykst; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d8020ba858so13066235ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 19:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744943432; x=1745548232; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KtO6op49z44/ebWGqhUaeKIrduOhCMbLk/MWlbQrcZU=;
        b=dOigykstWkt6ai10kDMiqr5P0TA5BE6FhkKgTBz7xpa5/loFVr2ZM791NczAu0nLLX
         LjJLW+Vf1TZIkb2dkuzt8hS0BimuQpcrbCAuEyd+jTUR21f0aCLmRLlUr3QNY5b17j/l
         y3ecEgk8keZctdYxAVb8apUosK7o0aXso6pvLOOrosTPJbhnbqVx/H9TdEgOadXtCriJ
         pwUjaduFhyPtmgJPFZlh08tEgvv9B7+Poqhi1afZDJOod3lFSC4KWmuFljRRTSJSH7E0
         wjL33q09fJXzuKiQMeHeaaauQavOVN1uTC7Os1ceUAVwE/IF9NOgBt78PvBJnBBoLlRP
         Q+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744943432; x=1745548232;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KtO6op49z44/ebWGqhUaeKIrduOhCMbLk/MWlbQrcZU=;
        b=ZYd27N4tlnFkBPHr1XZmcYKgdjQAr7YkWZuGkpBvdZlIm1/SbK+0IsmvoKj0Z2Vfn2
         1HQSrbEe0RtK2+L3DU5rSlz8UCy9Kbc2KkZBpPnhayMfkXpCjku4gVg4ONge0Cuq9ER4
         JFT356mMyY9h4hnzslTM5heJdQVh+4aLe2XeLcFGoSY6He4IYYVYNckeAkqyg8r10Y27
         VjOSIvz8zetWDIxIFYycbL28UdpuPva8j7wfGdiLCOMXnrCitHToud6ZRAFqysq27Mc0
         +e37uyIwnV9aLwxcEUeumVgTfeW4ACLH9DzM4zLFvaP41kVLA9P7tOtfDTsCimhNUD2c
         CnkA==
X-Forwarded-Encrypted: i=1; AJvYcCWUvHw3qw7/lc/wItALeuCG5ayz+M534d8sj+pMMMrwiM+sY1mi/wtkH8wZZEl/OisU06xVdPoGH5VRoek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz27uA942JxGMKKl7aBdhLtQ2CXI4/OD68iZtniB/O+0n2F4zfH
	kTEN6JhhbNMtjHXs3cLK3/vnkRh7MG4h+V33yCKvauOddOv8v4ND8CdP0CeAszk=
X-Gm-Gg: ASbGncspoi8ZQje8uQZG8MnL0usfhCYE9g/BJoa6onnGJ5oVlbEj9SPYwQUpp4qjNsV
	UzQNO01P+meryYUju/xjAyMARrIWmhnj1eGRglPp9RTk1FonHr8v1jMgO/QrF7JqXG+ln22B9kh
	moMScNuRIQRC4VAeOEFJTRRdBYX+bxJHRDZYjKuxbKl61VpRoGcc07rjIN19kDToMf97h7zfCIM
	3AF0zBi2Ht0VmeLF4vnyFyu5gn9neaf2avQGz7VYCaoQefrChd9LMG/d/OkG98OkrSWD3BknA0O
	rvvSIZKkSyKwIH8Sj5Xo0iZ9woU43PTxL4VYOsDAIhIhVIoK
X-Google-Smtp-Source: AGHT+IFqjPw6U5NtQE2k8IsIj8gExrzTiktu9UJd6PwwstPaGPPXrHJprgjk5kqM0YZvIsoxVHvZIg==
X-Received: by 2002:a05:6e02:3102:b0:3d3:d067:73f8 with SMTP id e9e14a558f8ab-3d88ed9fbf7mr12814555ab.11.1744943431784;
        Thu, 17 Apr 2025 19:30:31 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d821d377d6sm2441395ab.22.2025.04.17.19.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 19:30:31 -0700 (PDT)
Message-ID: <5b2bb7aa-43f5-4c25-af79-5f8c896254d3@kernel.dk>
Date: Thu, 17 Apr 2025 20:30:30 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] ublk: require unique task per io instead of unique
 task per hctx
To: Ming Lei <ming.lei@redhat.com>, Uday Shankar <ushankar@purestorage.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250416-ublk_task_per_io-v5-0-9261ad7bff20@purestorage.com>
 <20250416-ublk_task_per_io-v5-1-9261ad7bff20@purestorage.com>
 <aAGrI8wqLLCWzqNe@fedora>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <aAGrI8wqLLCWzqNe@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/25 7:30 PM, Ming Lei wrote:
> On Wed, Apr 16, 2025 at 01:46:05PM -0600, Uday Shankar wrote:
>> Currently, ublk_drv associates to each hardware queue (hctx) a unique
>> task (called the queue's ubq_daemon) which is allowed to issue
>> COMMIT_AND_FETCH commands against the hctx. If any other task attempts
>> to do so, the command fails immediately with EINVAL. When considered
>> together with the block layer architecture, the result is that for each
>> CPU C on the system, there is a unique ublk server thread which is
>> allowed to handle I/O submitted on CPU C. This can lead to suboptimal
>> performance under imbalanced load generation. For an extreme example,
>> suppose all the load is generated on CPUs mapping to a single ublk
>> server thread. Then that thread may be fully utilized and become the
>> bottleneck in the system, while other ublk server threads are totally
>> idle.
>>
>> This issue can also be addressed directly in the ublk server without
>> kernel support by having threads dequeue I/Os and pass them around to
>> ensure even load. But this solution requires inter-thread communication
>> at least twice for each I/O (submission and completion), which is
>> generally a bad pattern for performance. The problem gets even worse
>> with zero copy, as more inter-thread communication would be required to
>> have the buffer register/unregister calls to come from the correct
>> thread.
>>
>> Therefore, address this issue in ublk_drv by requiring a unique task per
>> I/O instead of per queue/hctx. Imbalanced load can then be balanced
>> across all ublk server threads by having threads issue FETCH_REQs in a
>> round-robin manner. As a small toy example, consider a system with a
>> single ublk device having 2 queues, each of queue depth 4. A ublk server
>> having 4 threads could issue its FETCH_REQs against this device as
>> follows (where each entry is the qid,tag pair that the FETCH_REQ
>> targets):
>>
>> poller thread:	T0	T1	T2	T3
>> 		0,0	0,1	0,2	0,3
>> 		1,3	1,0	1,1	1,2
>>
>> Since tags appear to be allocated in sequential chunks, this setup
>> provides a rough approximation to distributing I/Os round-robin across
>> all ublk server threads, while letting I/Os stay fully thread-local.
>>
>> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
>> Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
>> ---
> 
> I guess this patch need to rebase against yesterday Jens's merge.

Given the set of changes on both the io_uring and block side, I'm going
to rebase those trees on -rc3 once that is out. So yeah, I think
rebasing and reposting this series against block-6.15 now would probably
be a good idea, and should then apply directly for the 6.16 tree.

> Given this change is big from ublk serer viewpoint, it should aim at
> v6.16

Agree.

-- 
Jens Axboe

