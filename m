Return-Path: <linux-kernel+bounces-830345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D03B99715
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE8EB1B20810
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D117A2DFA25;
	Wed, 24 Sep 2025 10:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lOat5XcY"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BFD2DF71D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758710225; cv=none; b=JSldw1NoWVtAGW9cTXLju/iC9lraSHpSkIU0HU27H3tyau09sHm7alWQ5tmnxmlXpRf28Ds+IDDEsVfqfOxdvZjLcPqzRreJWbo10MyVCH3PLsSHsUa2Q/z1GlHsVwHp3WHa1lQ15DVKnBoEMOSQBOUehE+ZNLYq/ouHwobQih4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758710225; c=relaxed/simple;
	bh=dRYlXXkB2uJmdz7xtD6gE7x4EFJTzXqpZbsUDTyd8c4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R6JePArK+FZyqIkxr0vFmdWHsfQfbLhDeCTN450gW38+t/pmsmyLYQiMBJsyzER+/9gVQQLDEL1JCls3vhFJrlSwLXtPZvB9CKrIXus+ftFE6RW4K0ulpnhnp1Y8uQBn52+fGFlfSNW8De8mzG0Gko6uhsLrB3Wi3iB1mtOAbxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lOat5XcY; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-269639879c3so64214365ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758710222; x=1759315022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mz/QbJ4toKNKlZAJuEgAp+fvEFXAqbuxTuvTTDNq1Jo=;
        b=lOat5XcYibFTSQvkP0tr06i+EOUFBhTE0lzdpUWflDlzQox9LXotkg4wzzuIu2LH6+
         uMKggXIwsMQbjp+hcNGP2RySbqSNRsyhPwFNA1S85BLqNzxzl+R17Joov+PvtZZyT1VK
         x4Ki9+L1xQa+bHUPrinJ3IPplBQg7GGZwale4oWzsExuwOMvv9dQ4jVR1B7PWhYxtrbp
         6nuGmLMJTJURSLwHCGjR6SQOYcbTTRtMO0puvgiehNdbeYGJh+II6nb635wJgjM6Hput
         aUsL+ehlzPKuiKVUXTT5KCFAV6U7hiFjYTZK8WW5fcHa1vye+RsOpvJ5BYCITwAvF8KB
         etKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758710222; x=1759315022;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mz/QbJ4toKNKlZAJuEgAp+fvEFXAqbuxTuvTTDNq1Jo=;
        b=TazN5vFRtZdV2/o1a5BluKfCQjhaFxyBr0MMg6XO+3veeAJmAPjIm6hWsg6Gi2RqD9
         ZkeM1Zf0I7cSSpJNI+SVl4nwnKlRfmRM7LIvqkGdEjHhN3k/l/cX9y+X7Onhp8DiKG0T
         J8VdzfqOXdp7O8SKBCiPtGXlVTOP44p3rNOC7AasYpXE9u4EtrK6VawocXX7pzwVqH+O
         QxNy0wZy48vI1k7Xn8Mp42PMj7SPXPyc0WTBuGj4XXdEnqEzf1T/bKFx2yl1gXRkmEat
         vuKsCm2RIF57tl6/c25scmvaImfcbUROWIe4RClcuMbbptshx56uS9+kHdf+mTNzeksa
         PW3w==
X-Forwarded-Encrypted: i=1; AJvYcCUwcOSha8izcPJlnAQUgNVyDnMhYJgTxxzKdhGUHumbbQbX07xWh4xuyD5EsXSn1XNZUckUKFf1ER2VEgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrGFa4aFeBVDKY1+v/bLZx83nYYJea9mNDnv5R95X9e+qM4Hiu
	ExRIdi0jUBsPxWM2nN0ftV/fMpSp00TOV3rAFqoTQ2pRCIN3N/lR/3gU0DafxSEFWWo=
X-Gm-Gg: ASbGncvvG4p0heYGnWG1HSXwrpnmpika2WJdyXH8ufQdTW6aDoUBxD0jqHQPPnXJU8S
	Vfqf9mR3cA7LWa3zb4iZ45x/u3w3rSdMLogwaoiouL7O1nhxuvMG7DjG5/GQB1YpKGwZXkNcJyo
	xC5/xZjOSBLOY8eMQhzwzGFGL/1MKzTM23PdTo5BBXkF7fdIlpLNDULm1/hqI2eGhMtXr2BVcpp
	vpZfrc1Vvp7P67KwF9daeGXgd80cCzoxTIekIeT3/3DNWNUMmb+VUSAMr7Oylpmzd2Y5Du1TOUv
	8PV9qh87XCSgyrx3/O12ymFKxJ3jeQgfqxYgp09rgxLnUG+LjpWfaLMqXt+Yag9hhNmVXOIJbKh
	wg7e86VU1weudqBne6thxKCDqWlZUqKQ+LfKsleEf33H08yL80WhSAokiZ5R9OGLl3lIVLTAsvg
	==
X-Google-Smtp-Source: AGHT+IGcpm4z7o8NO6ljSagepQnFIpP0uGIzZYuk92q1VZe5grt2PvNSZ7U+YZG86LFac+Jm4g+HMQ==
X-Received: by 2002:a17:902:d484:b0:25c:d4b6:f119 with SMTP id d9443c01a7336-27cc09e3c46mr79698515ad.12.1758710222141;
        Wed, 24 Sep 2025 03:37:02 -0700 (PDT)
Received: from [10.88.210.107] ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053dbdsm188309915ad.9.2025.09.24.03.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 03:37:01 -0700 (PDT)
Message-ID: <b9fd9738-f4bd-4b34-88fd-7dfb7ed0c043@bytedance.com>
Date: Wed, 24 Sep 2025 18:36:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH v2 2/2] memcg: Don't trigger hung task
 warnings when memcg is releasing resources.
To: Peter Zijlstra <peterz@infradead.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, lance.yang@linux.dev, mhiramat@kernel.org,
 yangyicong@hisilicon.com, will@kernel.org, dianders@chromium.org,
 mingo@kernel.org, lihuafei1@huawei.com, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, tj@kernel.org, brauner@kernel.org
References: <20250924034100.3701520-1-sunjunchao@bytedance.com>
 <20250924034100.3701520-3-sunjunchao@bytedance.com>
 <20250924063219.GR4067720@noisy.programming.kicks-ass.net>
 <37fd969e-3799-48d0-a8e0-1937e5a4ae38@bytedance.com>
 <20250924082823.GV3245006@noisy.programming.kicks-ass.net>
From: Julian Sun <sunjunchao@bytedance.com>
In-Reply-To: <20250924082823.GV3245006@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/24/25 4:28 PM, Peter Zijlstra wrote:

Hi,
> On Wed, Sep 24, 2025 at 03:50:41PM +0800, Julian Sun wrote:
>> On 9/24/25 2:32 PM, Peter Zijlstra wrote:
>>> On Wed, Sep 24, 2025 at 11:41:00AM +0800, Julian Sun wrote:
>>>> Hung task warning in mem_cgroup_css_free() is undesirable and
>>>> unnecessary since the behavior of waiting for a long time is
>>>> expected.
>>>>
>>>> Use touch_hung_task_detector() to eliminate the possible
>>>> hung task warning.
>>>>
>>>> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
>>>
>>> Still hate this. It is not tied to progress. If progress really stalls,
>>> no warning will be given.
>>
>> Hi, peter
>>
>> Thanks for your review and comments.
>>
>> I did take a look at your solution provided yesterday, and get your point.
>> However AFAICS it can't resolve the unexpected warnings here. Because it
>> only works after we reach the finish_writeback_work(), and the key point
>> here is, it *already* takes a long time before we reach
>> finish_writeback_work(), and there is true progress before finish the
>> writeback work that hung task detector still can not know.
> 
> But wb_split_bdi_pages() should already split things into smaller chunks
> if there is low bandwidth, right? And we call finish_writeback_work()
> for each chunk.

AFAICS, wb_split_bdi_pages() will only be invoked in the sync scenarios, 
and not in the background writeback scenarios - which is exactly the 
case here.

And I noticed that there's something similar in background writeback, 
where writeback_chunk_size() will split all pages into several chunks, 
the min chunk size is 1024(MIN_WRITEBACK_PAGES) pages. The difference 
from wb_split_bdi_pages() is that we don't report progress after 
finishing the writeback of a chunk.
> 
> If a chunk is still taking too long, surely the solution is to use
> smaller chunks?

Yeah it still takes a long time, I checked the write_bandwidth and 
avg_write_bandwidth when warning was triggered:

	>>> wb.write_bandwidth
	(unsigned long)24
	>>> wb.avg_write_bandwidth
	(unsigned long)24
	>>> wb.write_bandwidth
	(unsigned long)13
	>>> wb.write_bandwidth
	(unsigned long)13

At this bandwidth, it will still takes a lot of seconds to write back 
MIN_WRITEBACK_PAGES pages.

So it might be a solution, but given the fact that the current minimum 
chunk size (1024) has been in place for over ten years, and that making 
it smaller would probably have a negative impact on performance. I'm 
afraid the filesystem maintainers will not accept this change.
If we don’t modify this part but can report progress after finishing the 
chunk writeback, it should probably eliminate most of the unexpected 
warnings.
> 
>> If we want to make the hung task detector to known the progress of writeback
>> work, we need to add some code within do_writepages(): after each finish of
>> a_ops->writepages(), we need to make detector to known there's progress.
>> Something like this:
>>
>> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
>> index 3e248d1c3969..49572a83c47b 100644
>> --- a/mm/page-writeback.c
>> +++ b/mm/page-writeback.c
>> @@ -2635,6 +2635,10 @@ int do_writepages(struct address_space *mapping,
>> struct writeback_control *wbc)
>>                  else
>>                          /* deal with chardevs and other special files */
>>                          ret = 0;
>> +               /* Make hung task detector to known there's progress. */
>> +               if (force_wake)
>> +                       wake_up_all(waitq);
>> +
>>                  if (ret != -ENOMEM || wbc->sync_mode != WB_SYNC_ALL)
>>                          break;
>>
>> which has a big impact on current code - I don't want to introduce this.
> 
> You sure? It looks to me like the next level down is wb_writeback() and
> writeback_sb_inodes(), and those already have time based breaks in and
> still have access to wb_writeback_work::done, while do_writepages() no
> longer has that context.

Yeah, exactly. What I mean is report progress within the whole writeback 
work, either writeback_sb_inodes() or do_writepages() is ok.
> 
>> Yes, the behavior in this patch does have the possibility to paper cover the
>> real warnings, and what I want to argue is that the essence of this patch is
>> the same as the current touch_nmi_watchdog() and touch_softlockup_watchdog()
>> - these functions are used only in specific scenarios we known and only
>> affect a single event. And there seems no report that
>> touch_nmi/softlockup_watchdog() will paper cover the real warnings (do we?).
>>
>> Correct me if there's anything I'm missing or misunderstanding.
> 
> The thing with touch_nmi_watchdog() is that you need to keep doing it.
> The moment you stop calling touch_nmi_watchdog(), you will cause it to
> fire.
> 
> That is very much in line with the thing I proposed, and rather unlike
> your proposal that blanket kill reporting for the task, irrespective of
> how long it sits there waiting.
> 

Thanks for clarification. So how about the following solution?

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index a07b8cf73ae2..e0698fd3f9ab 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -14,6 +14,7 @@
   *             Additions for address_space-based writeback
   */

+#include <linux/sched/sysctl.h>
  #include <linux/kernel.h>
  #include <linux/export.h>
  #include <linux/spinlock.h>
@@ -213,7 +214,7 @@ static void wb_queue_work(struct bdi_writeback *wb,
  void wb_wait_for_completion(struct wb_completion *done)
  {
         atomic_dec(&done->cnt);         /* put down the initial count */
-       wait_event(*done->waitq, !atomic_read(&done->cnt));
+       wait_event(*done->waitq, (done->stamp = jiffies; 
!atomic_read(&done->cnt)));
  }

  #ifdef CONFIG_CGROUP_WRITEBACK
@@ -1975,6 +1976,11 @@ static long writeback_sb_inodes(struct 
super_block *sb,
                  */
                 __writeback_single_inode(inode, &wbc);

+               /* Report progress to make hung task detector know it. */
+               if (jiffies - work->done->stamp >
+                   HZ * sysctl_hung_task_timeout_secs / 2)
+                       wake_up_all(work->done->waitq);
+
                 wbc_detach_inode(&wbc);
                 work->nr_pages -= write_chunk - wbc.nr_to_write;
                 wrote = write_chunk - wbc.nr_to_write - wbc.pages_skipped;

Instead of waking up all waiting threads every half second, we only wake 
them up if the writeback work lasts for the value of 
sysctl_hung_task_timeout_secs / 2 seconds to reduce possible overhead.

Hi, Jan, Christian, how do you think about it?

Please correct me if there's anything I'm missing or misunderstanding.

Thanks,
-- 
Julian Sun <sunjunchao@bytedance.com>

