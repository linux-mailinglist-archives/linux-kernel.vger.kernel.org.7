Return-Path: <linux-kernel+bounces-830086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EBAB98B28
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83571899DAF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35631FDE01;
	Wed, 24 Sep 2025 07:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="D3R2aYV/"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6D24502F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758700254; cv=none; b=jyN2DZFESOLTMKqFE7qtfAXE/zs5z8h4KNTJpGwDBJHYOUBOejqXR0HJOGofL/dTHbcAGvxgwW5kLKEcjjKOu+esjePGIeTy5Rq2PcKbKDKCOPfRV7PVrDGiu+TOKWLc2ynkUXdflTl/IXWF7/tIy47KM2tmVZuGpUyHf9Yzx6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758700254; c=relaxed/simple;
	bh=45ID2kuv0qFzfqDiZyEd9DoHC7kvx6ye7Wh2smi4EfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cbeDdHWZCYTeSRNyUU5gdvi8vrIXAhqxNAaMU/EkFV3WzfW2csCZ0YGxxrxEfP0nDm2Nltw9ApYaOUe7N1H7JsDcET8vQHqHK3dTetnXuU6LpuX5ibWWZhksqR9phm9kmcvOrc1x1XdS6bkOGs8IGjZAqz2b6T+SDXFmAFPtmwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=D3R2aYV/; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4f7053cc38so4729071a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 00:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758700251; x=1759305051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CV8Ezfn2saza8BjopllSPTGobi36DchCDdd90Jw4e3I=;
        b=D3R2aYV/E2VgUiaTXCyGZyOYBD0HiSit4mSb8GssohgxP40kNsfleMraXpc0XZAC++
         S0yn9ZlVzoKjoTNHS2PF+7/7XZcoJ6OZSuwxwbflSkA5azZB7cRsdgaWTHCg0rVS25A3
         Q+76runYZeLgnHgqpHIdDKWT98mHjZJLjeEIoUrtiIGZeZdPNoj9uzkFdft5d2QvqF6U
         3n7LD3wxSaNRq7Pp4bzoVEYkH0elXmApzlDGhE9cmJ16tFC/cRhXJejf4Jpf9ysHo2OQ
         2Il0WzNFFC6swZz+T6/2Ou4j8tHSJfdayS6N8NpgYGnxkKZk7jm8PFKu82nQCLVUzffZ
         j9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758700251; x=1759305051;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CV8Ezfn2saza8BjopllSPTGobi36DchCDdd90Jw4e3I=;
        b=m9kqO6vDg3prVtN3EFU1g9NE2UCVzYoK671v/xVncYYC0nkW7NO9R4FyhhjE3AghgM
         SgYaCqNHdETym4AMXXTE4AZqRayrz7nuY5til51Nmcb5dzJ5i9LcgU8n8TTgyqARHmc0
         t5TMuQwHcfGZbo68D8J/JcrOAHbC+0VYA/1R17wMmBOC3e0Y5HjLxrkwtGEh8MEKbwIJ
         9GjtYpZ+a0vCt0BGCpyLobgKqkldPLKO8LbeyZf8lRx1PYRLUrhVJ4Bk4hT2C/RFU/+z
         YR3908KNq8IlWR7SzV+SMNi5nqSQ4kERbpBFfrsMhUn+vNhJX17rGnokxSm9ezPz22jR
         D1aQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/D84vEM5Pr5Py/ASrx+lj9OLdiIdDBDN8cwNOfrDdO0d6bZXYNua7UfM70crVDPDlAY0bZsmwj4noOR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzIMzKjgIds7flPqQV6HrhKW8d3rBR+ONByrDsC4Vt8+RY/XfB
	u9WiHntOx41BWy/EdVav1SRvErtbPDmlbnvEepYWOl5r++UNx0D3OXNxgPGO7Fx9OTg=
X-Gm-Gg: ASbGncvYrBV68GEoLgE0zfblBlW0t1qJf9nSVB6NBxM+lCDSDxzoEyqjsGCBRrffvH+
	r2D9t1TZgt0FSrqxv2qcjj6orxFwFQOagaxbrFo5B+LXXK6TtFXqU+7+muBzMsiCWv7tq0b21oK
	hbEqzNF5ue9RBOsCHv8//kG/cFHSVvwwkIE+MJZZMwpnjy99tzfvLg9eB2ETEwQ1QRH7ENUB/3E
	Dxe+VplwGLh+bz0qxNIoaUkMs8zs3dZtjPkaxGQ+M8314siCjPEfep4DJtoZb2zx2GA47CVi+q/
	bK8XA5fN1o1qMTwOK6VA4ntpIm4o+pUQr+2b1JtAwiygdYC5smtAPwngpANymoULxB9HKg3k8qo
	9rSgZ9IJeVHRgqNlC6nRBfXo8XJBcre7y7EcxmHc+sFA53Eut5yeCw4nYVV7lFyXRNRiU1Q3xoQ
	==
X-Google-Smtp-Source: AGHT+IF/FsViDZnN1wC3bVBeDjfe2a1td3Uy9MTTTgmPfAiltbIpdnbAcEVw0Jdsi9BK/RiEHIqtzQ==
X-Received: by 2002:a17:903:4b4b:b0:279:a5bb:54e2 with SMTP id d9443c01a7336-27cc21fabc8mr69834335ad.20.1758700250705;
        Wed, 24 Sep 2025 00:50:50 -0700 (PDT)
Received: from [10.88.210.107] ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ec0a7f443sm13118355ad.105.2025.09.24.00.50.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 00:50:50 -0700 (PDT)
Message-ID: <37fd969e-3799-48d0-a8e0-1937e5a4ae38@bytedance.com>
Date: Wed, 24 Sep 2025 15:50:41 +0800
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
 muchun.song@linux.dev, tj@kernel.org
References: <20250924034100.3701520-1-sunjunchao@bytedance.com>
 <20250924034100.3701520-3-sunjunchao@bytedance.com>
 <20250924063219.GR4067720@noisy.programming.kicks-ass.net>
From: Julian Sun <sunjunchao@bytedance.com>
In-Reply-To: <20250924063219.GR4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/25 2:32 PM, Peter Zijlstra wrote:
> On Wed, Sep 24, 2025 at 11:41:00AM +0800, Julian Sun wrote:
>> Hung task warning in mem_cgroup_css_free() is undesirable and
>> unnecessary since the behavior of waiting for a long time is
>> expected.
>>
>> Use touch_hung_task_detector() to eliminate the possible
>> hung task warning.
>>
>> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
> 
> Still hate this. It is not tied to progress. If progress really stalls,
> no warning will be given.

Hi, peter

Thanks for your review and comments.

I did take a look at your solution provided yesterday, and get your 
point. However AFAICS it can't resolve the unexpected warnings here. 
Because it only works after we reach the finish_writeback_work(), and 
the key point here is, it *already* takes a long time before we reach 
finish_writeback_work(), and there is true progress before finish the 
writeback work that hung task detector still can not know.

If we want to make the hung task detector to known the progress of 
writeback work, we need to add some code within do_writepages(): after 
each finish of a_ops->writepages(), we need to make detector to known 
there's progress. Something like this:

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 3e248d1c3969..49572a83c47b 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2635,6 +2635,10 @@ int do_writepages(struct address_space *mapping, 
struct writeback_control *wbc)
                 else
                         /* deal with chardevs and other special files */
                         ret = 0;
+               /* Make hung task detector to known there's progress. */
+               if (force_wake)
+                       wake_up_all(waitq);
+
                 if (ret != -ENOMEM || wbc->sync_mode != WB_SYNC_ALL)
                         break;

which has a big impact on current code - I don't want to introduce this.

Yes, the behavior in this patch does have the possibility to paper cover 
the real warnings, and what I want to argue is that the essence of this 
patch is the same as the current touch_nmi_watchdog() and 
touch_softlockup_watchdog() - these functions are used only in specific 
scenarios we known and only affect a single event. And there seems no 
report that touch_nmi/softlockup_watchdog() will paper cover the real 
warnings (do we?).

Correct me if there's anything I'm missing or misunderstanding.


> 
>>   mm/memcontrol.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 8dd7fbed5a94..fc73a56372a4 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -63,6 +63,7 @@
>>   #include <linux/seq_buf.h>
>>   #include <linux/sched/isolation.h>
>>   #include <linux/kmemleak.h>
>> +#include <linux/nmi.h>
>>   #include "internal.h"
>>   #include <net/sock.h>
>>   #include <net/ip.h>
>> @@ -3912,8 +3913,15 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
>>   	int __maybe_unused i;
>>   
>>   #ifdef CONFIG_CGROUP_WRITEBACK
>> -	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
>> +	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
>> +		/*
>> +		 * We don't want the hung task detector to report warnings
>> +		 * here since there's nothing wrong if the writeback work
>> +		 * lasts for a long time.
>> +		 */
>> +		touch_hung_task_detector(current);
>>   		wb_wait_for_completion(&memcg->cgwb_frn[i].done);
>> +	}
>>   #endif
>>   	if (cgroup_subsys_on_dfl(memory_cgrp_subsys) && !cgroup_memory_nosocket)
>>   		static_branch_dec(&memcg_sockets_enabled_key);
>> -- 
>> 2.39.5
>>

Thanks,
-- 
Julian Sun <sunjunchao@bytedance.com>

