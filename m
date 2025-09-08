Return-Path: <linux-kernel+bounces-804978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBEDB4828F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 04:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20066164E39
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 02:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15721E5B60;
	Mon,  8 Sep 2025 02:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIlsqLqu"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54271B87F2
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 02:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757298161; cv=none; b=FWEhsZxPjy/zuN8rJu+fjfN5JKANSL5e4WhifMdnLV1JvQ0vSeUKX6nnDGOf3pInVpcsDnxp8lz9ABn9Kh4AgNG5xKs1ZiivQFJjWBgO4MwPOolrEQ+1SUKpL8QWP6aW0itdiL4poueUgBugWt6IAn9adnXcSvdDeUgDXNfuCw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757298161; c=relaxed/simple;
	bh=AP7DCAwxSP7Qfa1iIAAo3yMJur9zniQqgWIVyOQdSsw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ys1oX9xj9JuukCtwcjeWrIeq0ILdG4Z/ZycENAVycs3gDYsh1l9IQdVrfBGeWj/aikTRo1QVsUYLR8rLJarNCbrqgR228AQEZsnwbFRbuLkH5KcJduTGzy3fmh0NVM8CDWuhEuq51Q+1I1a3paO2x4ZrZKDV7Iotyl1hbfpnLVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIlsqLqu; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24b21006804so39686495ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 19:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757298159; x=1757902959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zgit50PMT8trJxBKxf6xHc2MsdgHHdU62IVEwkntQtI=;
        b=OIlsqLqu8Cogj5bfVWc3zGWrolwfFSDz40tjBshVPD3mMiE3EhgHgXw3d/6It8pr1S
         yPqXA08QdMEka77dQFF3jTBEsopZR6hEQb7EYoVQBz7SPocj8ZkD+1fvnFmGLrtoQ931
         sDSj5rk9F0K9fwJadsjrfjjBTE9eNJdtEy6hk4sK0r/o2H4ABBVAPfPcwp6Fj8Qn8BZ3
         vpwevKHF/pbQQWwbwUbvh5gQRF+Q2FdlxrBNabkwNNAXTkAGdLvoIzco9Hok0y2NiVYz
         +mqnJwBLUGfPIjzgFyEWN54XyqBURODXGQeKfMRg5RABB96jtRVqDqj9wQl5owwJEtKi
         hL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757298159; x=1757902959;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zgit50PMT8trJxBKxf6xHc2MsdgHHdU62IVEwkntQtI=;
        b=D3uIqL0AD7+mvfax8A1LvA9KoNc9+kmvxgaiwNtCaApCgdza7bk2s+Rjx2osjc2ZU1
         U7SHbZwR0IOSbaJn4erlWVjvUrOj3twUktEncULK664naJRVxzGNwtZtrV1OCsu46vt1
         h70BROPR7qluZT5dDuFd74lWksgiOdIc/++zdGuuH5Q08XTj5rgJk8yJJtS6e+sN/JJN
         fxEv4RRfeh0qQ229bwMo59n0FZjrbe20McqpdlYZHERNNIe0ELGynFNJucmfA51zMrlC
         68YjtbWsCzuUgUNtwcAdd+zmUAhCWxqg0z8aOomVbqVh669fDNyTEKUGA+lk0D35YJYJ
         HMUA==
X-Forwarded-Encrypted: i=1; AJvYcCXE+goil2TMS0fpCZjBbkY4UEXJoyXyqpzwv8iwaSFS8N8jE/Z463E7RSPb55c5pBLH5NIMIOatlbN5rdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJWU6QEaONEfgODrsadG1dsof4Lft52+x8gn0ivhkZRqM4pPIM
	UTinewsqvNPCRL9iJW2xuv3eJX5Ycl4QRiyWT2Ue2aD0vSaCudZHmG7698qTQA==
X-Gm-Gg: ASbGncu/IPj97k3Z+SgjBfTzNoPvCArGynHpzt3JL6mRxgMm1gEY9nddu/thuUwtl4z
	pcQy8QjdDLBai1fGyE+ziKMjidsNfUvOI21PbFq/GcEeXwH2l9LJSm4lVNc6ucsd0Fv5bazecxN
	k3Kn4KVUHDJ5SUZJDomVdEYS834bE0W/LJRYe55UBWUIEIq6UgLAi81CcwHqp1TgYurDZDLwbGJ
	eI16itc39VzCGTvZhrlLKRkhuCDj704/z5Ye64OFFQBqHSLT8vfDSYPtdI6KdX39880j8q5ZYX7
	LCmAU6rGjW+iuxrZhSTp9UUVv2w7z5cWLx3sPyHgXCj3MiBWkyWd0nlO5I7vC4ZlB0F3tZw4RlM
	+rTanNsy1jukHDWA53T6nJND+AJBvgbzqrtjP1tjOIB1zWuCYc9N6QoE=
X-Google-Smtp-Source: AGHT+IGETwtbkZFB2BfpD/cD+SllbmFjJVv1g0HxgqC7Iv/KWnOWu68ePxWYDxELw7uFHmyni+3kvA==
X-Received: by 2002:a17:903:234a:b0:251:493c:43e3 with SMTP id d9443c01a7336-2517330a5f2mr112379165ad.31.1757298158846;
        Sun, 07 Sep 2025 19:22:38 -0700 (PDT)
Received: from [10.125.192.100] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c9e39094dsm123841375ad.84.2025.09.07.19.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 19:22:38 -0700 (PDT)
Message-ID: <33cac97d-d73c-98e7-3a8b-852460cb1909@gmail.com>
Date: Mon, 8 Sep 2025 10:22:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: sched: observed instability under stress in 6.12 and mainline
From: Hao Jia <jiahao.kernel@gmail.com>
To: Chris Friesen <chris.friesen@windriver.com>,
 LKML <linux-kernel@vger.kernel.org>, hanguangjiang@lixiang.com
Cc: osandov@fb.com, Peter Zijlstra <peterz@infradead.org>
References: <87254ef1-fa58-4747-b2e1-5c85ecde15bf@windriver.com>
 <7cd74213-5654-aac0-54d0-4f4b1a7f0fef@gmail.com>
In-Reply-To: <7cd74213-5654-aac0-54d0-4f4b1a7f0fef@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/9/8 09:51, Hao Jia wrote:
> 
> 
> On 2025/9/5 00:33, Chris Friesen wrote:
>> Hi,
>>
>> I'd like to draw the attention of the scheduler maintainers to a 
>> number of kernel bugzilla reports submitted by a colleague a couple of 
>> weeks ago:
>>
>> 6.12.18:
>> https://bugzilla.kernel.org/show_bug.cgi?id=220447
>> https://bugzilla.kernel.org/show_bug.cgi?id=220448
>>
>> v6.16-rt3
>> https://bugzilla.kernel.org/show_bug.cgi?id=220450
>> https://bugzilla.kernel.org/show_bug.cgi?id=220449
>>
>> There seems to be something wrong with either the logic or the 
>> locking. In one case this resulted in a NULL pointer dereference in 
>> pick_next_entity().  In another case it resulted in 
>> BUG_ON(!rq->nr_running) in dequeue_top_rt_rq() and 
>> SCHED_WARN_ON(!se->on_rq) in update_entity_lag().
>>
>> My colleague suggests that the NULL pointer dereference may be due to 
>> pick_eevdf() returning NULL in pick_next_entity().
>>
>> I did some digging and found that 
>> https://gitlab.com/linux-kernel/stable/-/commit/86b37810 would not 
>> have been included in 6.12.18, but the equivalent fix should have been 
>> in the 6.16 load.
>>
>> We haven't yet bottomed out the root cause.
>>
>> Any suggestions or assistance would be appreciated.
>>
>> Thanks,
>> Chris
>>
>>
> 
> Maybe this patch can be useful for your problem.
> https://lore.kernel.org/all/tencent_3177343A3163451463643E434C61911B4208@qq.com/
> 
> If I understand correctly, we may dequeue_entity twice in 
> rt_mutex_setprio()/__sched_setscheduler(). cfs_bandwidth may break the 
> state of p->on_rq and se->on_rq.
> 

Perhaps the "Defer throttle when task exits to user" patch set from the 
sched/core branch can also fix this bug.

https://lore.kernel.org/all/20250829081120.806-4-ziqianlu@bytedance.com/

Thanks,
Hao

