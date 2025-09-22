Return-Path: <linux-kernel+bounces-827208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D98B9127F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EC1518A3DE0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64CB30AAAD;
	Mon, 22 Sep 2025 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JIWNC9vW"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB14308F1C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758544829; cv=none; b=Ilifr3gJx13SAc//40+JHDionOoss07zYvnHVNtUgkWYy4AOZ8Ucormd9DfmDMTJoXsy77db3KIgdNN84BLZy0Mg4OI34cvS9AFopVXrpO4rtzIYS9gyiua8KFSyR8gsPeOBwlHxyY02Y9ZxBdEkVcsJUfiZmgiOVPMzWMmMcrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758544829; c=relaxed/simple;
	bh=oLCLpX2jtMBtuMbPjtYboKL7moJwuIOjpinv3gJLa8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOlYj3gGEcZIT+httFXMDDGhNjsFhISrZrIPDbvvi0J+4lIuJZ1q49ZFcR44oBE+16kAZRBZXxvgN6nklsnQ1vtfvywFvdN+ObiSP33UL5N8M5dChuC3Hfh7mK/mGMdXdqPn67eajHyUtx8OJtKf9XkbSTHtNQPV3IE90PrKvCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JIWNC9vW; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-267dff524d1so31666665ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 05:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758544827; x=1759149627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RdyyD1EXBlvIemsVmbrmNlfheta51vslsx7KshN1DY=;
        b=JIWNC9vWKgq4nJ4XGZi+fLxUA7972ER4xbpiw1wdSiQt/xQVsbuRznugYEUa90+ucv
         0ZSR4QsJq3Sp4n1xMAsuO1vsritkMSfdJVWafay0mc5hgnbakceN5gFTQfyoFqy0RFNb
         DfIgEmgLxplEHXMsXO7QYFRBq0GInJYD6bne/Z46WhrtK1PvhS6oNcgXaiM2xC9HOUPK
         rX5hSgfZ05NPDxUeCOCYj293GRgxjwdMuchbVNcQA5CmYxAdVjbAVRGEmrbCzKeTdRsm
         UThbeKOw1xZ15eo5ca+hyFN2152Y/VvHdhOFSLUP/2nnPkijbwbgtKOmeNYiwHBeASWO
         3nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758544827; x=1759149627;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/RdyyD1EXBlvIemsVmbrmNlfheta51vslsx7KshN1DY=;
        b=Kp0zYXLLn3/kFq9gE/TXC5v9Qk1rZCru30Z6UN7M8z/9NLHJ449vNeRXUdoroVOVdF
         uP069TfnCU0yPNd7JJIZmEahObOya6qysp2UpbmEeTKIQnr+8w9rL/Hy+xoqBmzIcu+E
         iLV3TrghFpPR+7MEPrwYnEU3xe+ICYi0oS1aRaRi/bqOCmwNEaMCiG8DHp0cHRctsVsf
         rTnk66Ai9hFuPeKe3InaQO53QDdSaYV3NDsZz3iIxdMOK5FZSiJsIGfJd4GCsm1Cx2g3
         cG1qiRJNXEDZ+8UvqMKWmrDH7vqjBE66m16/yAfDavaJInBbk++43mZe10oBOsUFqRU1
         uUdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQqprzXLD7aWeFHkurNnwUFvKVJXcFMOkJtXNWuYP3m5+4VfwU4sHFG9fqRJ8TXHDrsY0c2Lkb+ShZGcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxZWn6xtKD3Y7wHbuxyQIimz73h6qA8zcMdScvWumxwNVNnfdh
	JLW8eH5egPYiut+sEAFvn0ByjG87/anLGUdLzZjDl58n0xfUEs/niPqXcVZuAaYlw4E=
X-Gm-Gg: ASbGncvDlGbFYHqJejRFxtWEKxTZQssI5/Md1HhQXJhtBJcZbQrsaJM/sRPQ3i8HSD9
	fTrXViZzBV2eZZN8ydcSJYLQ4AhId06yxfa7cwv/axEjXW9Dqh8zkRXxeY5xgQryevcdKVX0he1
	GcJtoUcejd0P3Oud5lfE7aV4UzI3y1ZOlekkceLVRCzCARIfhNAJPTqUVfJar25FEc5Vvv2MKGc
	6m2WX6DJw7r6ckrFsW/Ya+SNWoS/TZSLfE1ch8N8GUycsLUqFU2jcOyPdvD7ecP8VUiNI83iK0m
	X3iVR2sV/6ySXKx7ORBpvaxK36tLJGxXAZrMy1bkx/irwFVdjb28mAyJ89W4drw3v1yUKSBWutC
	bdDqbXih8vBjwVbSsa5/yd4S0EyTXDMQ9oSepuIp3KyCAvvIul+v7oNrD+RY73+x1yrwmrdBLDG
	XgpA==
X-Google-Smtp-Source: AGHT+IEGBrT3SnJhTkV8mglXja6cN7Am5iY4FgOJYWx37m7MRPV6ezOU1/PoiKvENYX09R5NpTy6hA==
X-Received: by 2002:a17:902:bd87:b0:250:5ff5:3f4b with SMTP id d9443c01a7336-269ba467e97mr116112925ad.15.1758544826621;
        Mon, 22 Sep 2025 05:40:26 -0700 (PDT)
Received: from [10.88.210.107] ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980179981sm131280655ad.54.2025.09.22.05.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 05:40:26 -0700 (PDT)
Message-ID: <fd12dd70-5de8-43bb-a4d8-610b5f5251fa@bytedance.com>
Date: Mon, 22 Sep 2025 20:40:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Suppress undesirable hung task warnings.
To: Lance Yang <lance.yang@linux.dev>, mhiramat@kernel.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 akpm@linux-foundation.org, agruenba@redhat.com, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20250922094146.708272-1-sunjunchao@bytedance.com>
 <b31a538a-c361-4e3e-a5b6-6a3d2083ef3b@linux.dev>
From: Julian Sun <sunjunchao@bytedance.com>
In-Reply-To: <b31a538a-c361-4e3e-a5b6-6a3d2083ef3b@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/22/25 7:38 PM, Lance Yang wrote:

Hi, Lance

Thanks for your review and comments.

> Hi Julian
> 
> Thanks for the patch series!
> 
> On 2025/9/22 17:41, Julian Sun wrote:
>> As suggested by Andrew Morton in [1], we need a general mechanism
>> that allows the hung task detector to ignore unnecessary hung
> 
> Yep, I understand the goal is to suppress what can be a benign hung task
> warning during memcg teardown.
> 
>> tasks. This patch set implements this functionality.
>>
>> Patch 1 introduces a PF_DONT_HUNG flag. The hung task detector will
>> ignores all tasks that have the PF_DONT_HUNG flag set.
> 
> However, I'm concerned that the PF_DONT_HUNG flag is a bit too powerful
> and might mask real, underlying hangs.

The flag takes effect only when wait_event_no_hung() or 
wb_wait_for_completion_no_hung() is called, and its effect is limited to 
a single wait event, without affecting subsequent wait events. So AFAICS 
it will not mask real hang warnings.>
>>
>> Patch 2 introduces wait_event_no_hung() and 
>> wb_wait_for_completion_no_hung(),
>> which enable the hung task detector to ignore hung tasks caused by these
>> wait events.
> 
> Instead of making the detector ignore the task, what if we just change
> the waiting mechanism? Looking at wb_wait_for_completion(), we could
> introduce a new helper that internally uses wait_event_timeout() in a
> loop.
> 
> Something simple like this:
> 
> void wb_wait_for_completion_no_hung(struct wb_completion *done)
> {
>          atomic_dec(&done->cnt);
>          while (atomic_read(&done->cnt))
>                  wait_event_timeout(*done->waitq, !atomic_read(&done- 
>  >cnt), timeout);
> }
> 
> The periodic wake-ups from wait_event_timeout() would naturally prevent
> the detector from complaining about slow but eventually completing 
> writeback.

Yeah, this could definitely eliminate the hung task warning complained here.
However what I aim to provide is a general mechanism for waiting on 
events. Of course, we could use code similar to the following, but this 
would introduce additional overhead from waking tasks and multiple 
operations on wq_head—something I don't want to introduce.

+#define wait_event_no_hung(wq_head, condition) \
+do {                   \
+       while (!(condition))    \
+               wait_event_timeout(wq_head, condition, timeout); \
+}

But I can try this approach or do not introcude wait_event_no_hung() if 
you want.>
>>
>> Patch 3 uses wb_wait_for_completion_no_hung() in the final phase of memcg
>> teardown to eliminate the hung task warning.
>>
>> Julian Sun (3):
>>    sched: Introduce a new flag PF_DONT_HUNG.
>>    writeback: Introduce wb_wait_for_completion_no_hung().
>>    memcg: Don't trigger hung task when memcg is releasing.
>>
>>   fs/fs-writeback.c           | 15 +++++++++++++++
>>   include/linux/backing-dev.h |  1 +
>>   include/linux/sched.h       | 12 +++++++++++-
>>   include/linux/wait.h        | 15 +++++++++++++++
>>   kernel/hung_task.c          |  6 ++++++
>>   mm/memcontrol.c             |  2 +-
>>   6 files changed, 49 insertions(+), 2 deletions(-)
>>
> 

Thanks,
-- 
Julian Sun <sunjunchao@bytedance.com>

