Return-Path: <linux-kernel+bounces-790478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1609B3A7D5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 19:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD333BF109
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 17:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205E2338F2E;
	Thu, 28 Aug 2025 17:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RE/f1H9k"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A143375C3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756401786; cv=none; b=JgUuCdEHySQzvwFbuYwlX210mqhhCZehYWoXXCYK+sxAqKEOfBNrdzFWhbVY1IiwYRvLlY2Cqt22w4fqrci2QUQOV6PhK+cYSGhdPkTjObmhUYY5EQcsIDStpSQ9EDAnkbCqpa16aNzkq/G49s1kkzFpSZKMMeQVqW14CowjcvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756401786; c=relaxed/simple;
	bh=PIkJ88v/rWhFS/73xkNPVcZuqlvNrxm7/GaT7di8kBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LKPo5IJzdjpcVuFw9CSqOGkgUgZevU/Oa/JbVybj0iA1ll6W3Gs0l1Z6Z2EchyCAVJAJNMpKozanNVtjqE0ZqbJBIvHpb4386mDZuO7NCtl39aYZq2unI76baa2uRhlRevWuoZU0pJ0x53HQh392/zrexyCL33lNYDquPqideCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RE/f1H9k; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-88432e31bdbso101295639f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756401783; x=1757006583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=faB7+0wEnxlytj0j3NjoS8kIpLPCrl/7qWqnqZfuOnY=;
        b=RE/f1H9kzizMoFoZIjXqiW3Z+56198CHKUdoYckn1vIFvCxvt/TZlRzvEkW2RioDaB
         ef318fd0Lr7GSl9LAGEjIp7m9sUsqFnAZe0c462ryWSn11i1EeZ/CSJ8jeKquEi2cOyQ
         ID1WuV6qzhFTlFB2B5WNiTRCROQAVx7goIO3LtOK0/NbJPHhqaXP+gz/B0k7/bYeuEaK
         sKueuRzXhnEu55hAjySpk3r9JzIid7WBWaSbOaYpSXsnQf6zeAXb/mmNP+kIx0qH92Tn
         v//ICuaXEW1eadwLTE1smgvrmogNoIPsTYOfRmcibqbM4ocZBNMa1NdmUZZ8BJkDL7YB
         16gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756401783; x=1757006583;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=faB7+0wEnxlytj0j3NjoS8kIpLPCrl/7qWqnqZfuOnY=;
        b=TLrAD/WeDDLGo1KkC5Jm7AZamdmEz0+mJKTergWXzpUJNcR5Z0311k1IIW4Pi91uGg
         3lMHQtL7cyOYK7N+BxXHczvk+TdvBEolJ15xR0JxIfjPBR+ShgnEk0m/8pWDsB80b5M2
         tuqUXLsnBC196xpkVfldf6IAzjcPKNb4n4gcZGRVMMVHpj1iVVIS7VDT3T1293oc+1ns
         R8zFtB2m42HyRxDRUP1YgI+Dcb9dfmdJyg4ICZziSwor4SGjxhGDzmHtwBzizI0SSjWB
         bNc7iQPRwER5wkbCAIEg67ZY5R64Nn2JRSYJjWJYW+bAp5FeCt4jtJVM9duGMlayUE2u
         Xy7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUbv+DxKEFMp5Jle6oG+rIV7K/gq459karwTtuVzXkL+PrbBO+Jn79KBpkM0ZxB0I6lDgh3dTXIBIQHdi8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4KlfaTH59L2zh2AJP1hMBQeG13f9lvuepk5wxXGt7LeRWzNPH
	9bX/DgGJGceYa5yu21FD9ShfJNvkABjmtWI8y+YPg77pf/PMy1t1x034nPFzim4gUv0=
X-Gm-Gg: ASbGncv5bYDUT5ZXb19rgMGW/HowcFbrd2JakdP8ELGI+hoMHwW/wsz0JlGPNDBDDYo
	Y5njFJs+p8Rn2CpNK1aIRcMKbDX0cYG4eXRGUwBeXIh3rZX+hK/IlS9+z2hWl54WWPCuLC/JTV3
	gOdNt1V49tfXMXmgNzUmQkqks7ALvvgDvluaEtLB/9ugWT3drrLcQODZGKGDZL6wZnh7dnEAfLy
	nSBQvMvs6rS7UQZiX2vPek7z6XV2dnCEsqwAG9KT/FgkynH35ORVmOlZ8VvZSv11sQgLtRLDzbv
	cdlBU9lhRi2D2G546nqPPPsK5/98FdHcWOBmq0+7gbP8ws//sTWt0jsfR/OYH6OIYZsFqDK3Wmy
	KfNmtKmWUcvwjVXEHATE=
X-Google-Smtp-Source: AGHT+IGJmJ+AmlVL6jjEUvzlT8b+frHT/Ep0NJyOaYxeNs5moY5J0oGj9ITEux9+cmWM4+WTZLO0Qw==
X-Received: by 2002:a05:6e02:1789:b0:3f0:62bf:f28 with SMTP id e9e14a558f8ab-3f062bf10bcmr77229915ab.30.1756401783246;
        Thu, 28 Aug 2025 10:23:03 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3f2753736e9sm482965ab.32.2025.08.28.10.23.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 10:23:02 -0700 (PDT)
Message-ID: <a74495d4-27ea-4996-abd2-9239b941f221@kernel.dk>
Date: Thu, 28 Aug 2025 11:23:01 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: check kobject state_in_sysfs before deleting in
 blk_mq_unregister_hctx
To: Li Nan <linan666@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, jianchao.w.wang@oracle.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com, yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250826084854.1030545-1-linan666@huaweicloud.com>
 <aK5YH4Jbt3ZNngwR@fedora>
 <3853d5bf-a561-ec2d-e063-5fbe5cf025ca@huaweicloud.com>
 <aK5g-38izFqjPk9v@fedora>
 <b5f385bc-5e16-2a79-f997-5fd697f2a38a@huaweicloud.com>
 <aK69gpTnVv3TZtjg@fedora>
 <fc587a1a-97fb-584c-c17c-13bb5e3d7a92@huaweicloud.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <fc587a1a-97fb-584c-c17c-13bb5e3d7a92@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/25 3:28 AM, Li Nan wrote:
> 
> 
> ? 2025/8/27 16:10, Ming Lei ??:
>> On Wed, Aug 27, 2025 at 11:22:06AM +0800, Li Nan wrote:
>>>
>>>
>>> ? 2025/8/27 9:35, Ming Lei ??:
>>>> On Wed, Aug 27, 2025 at 09:04:45AM +0800, Yu Kuai wrote:
>>>>> Hi,
>>>>>
>>>>> ? 2025/08/27 8:58, Ming Lei ??:
>>>>>> On Tue, Aug 26, 2025 at 04:48:54PM +0800, linan666@huaweicloud.com wrote:
>>>>>>> From: Li Nan <linan122@huawei.com>
>>>>>>>
>>>>>>> In __blk_mq_update_nr_hw_queues() the return value of
>>>>>>> blk_mq_sysfs_register_hctxs() is not checked. If sysfs creation for hctx
>>>>>>
>>>>>> Looks we should check its return value and handle the failure in both
>>>>>> the call site and blk_mq_sysfs_register_hctxs().
>>>>>
>>>>>   From __blk_mq_update_nr_hw_queues(), the old hctxs is already
>>>>> unregistered, and this function is void, we failed to register new hctxs
>>>>> because of memory allocation failure. I really don't know how to handle
>>>>> the failure here, do you have any suggestions?
>>>>
>>>> It is out of memory, I think it is fine to do whatever to leave queue state
>>>> intact instead of making it `partial workable`, such as:
>>>>
>>>> - try update nr_hw_queues to 1
>>>>
>>>> - if it still fails, delete disk & mark queue as dead if disk is attached
>>>>
>>>
>>> If we ignore these non-critical sysfs creation failures, the disk remains
>>> usable with no loss of functionality. Deleting the disk seems to escalate
>>> the error?
>>
>> It is more like a workaround by ignoring the sysfs register failure. And if
>> the issue need to be fixed in this way, you have to document it. >
>> In case of OOM, it usually means that the system isn't usable any more.
>> But it is NOIO allocation and the typical use case is for error recovery in
>> nvme pci, so there may not be enough pages for noio allocation only. That is
>> the reason for ignoring sysfs register in blk_mq_update_nr_hw_queues()?
>>
>> But NVMe has been pretty fragile in this area by using non-owner queue
>> freeze, and call blk_mq_update_nr_hw_queues() on frozen queue, so it is
>> really necessary to take it into account?
> 
> I agree with your points about NOIO and NVMe.
> 
> I hit this issue in null_blk during fuzz testing with memory-fault
> injection. Changing the number of hardware queues under OOM is
> extremely rare in real-world usage. So I think adding a workaround and
> documenting it is sufficient. What do you think?

Working around it is fine, as it isn't a situation we really need to
worry about. But let's please not do it by poking at kobject internals.

-- 
Jens Axboe

