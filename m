Return-Path: <linux-kernel+bounces-790959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBFDB3B059
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D745B987B24
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 01:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBED1DFE26;
	Fri, 29 Aug 2025 01:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HgvntEyI"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279DD54262
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 01:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756430436; cv=none; b=Q+mYW005TNzFY4qjiFESJC8Us90S8jPVwLfsgnSmKoXLkC0lld+SXqq71+SOYbqCeBoodANU8F8XNvXo8avsHkpcV+7/t1gF+swZR+y5KtX8NwEv7KTALQjT5Hi8MQR5xbGUz7cVpAcoqzxA+HTYAy+kVggmdAUklFbcN7aKkCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756430436; c=relaxed/simple;
	bh=9RmhSx2AkhkbCRNUPSXLjYr76O902bSKnr+UBgiihlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fnUtuOh2iDi36fHd4cBgZ9An4Pyqbr34XQOHhrGvJeQuX3FSo9LRvMd2uWlLaFLgmihiHDsvMVHfY/JFchUL+mnekegoqk0g+hfophYs8T1T1Tmv0Z0NpO0djg52fwBRjC+/UY0ounJ3uxTRIDygRfrcJHPSq9GrGImE0gX5VUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HgvntEyI; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2465cb0e81bso12598125ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 18:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756430432; x=1757035232; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7QRqN4HfiQy+iwir6klZDolNcN7H5KoQUCyOlgErwp0=;
        b=HgvntEyIOwiPisEyn8L5H1hu6fiOINXu1x9QS9pih73CAPqmv5671o/uR+fV5uOto0
         U8WnloVIu1+NQfSB6rSALfed9ogC7cG3ibaniOddQLDGccy4yORFxGhkgSYEFyj8YSmj
         Y9THj1wwwWkEf9RslBNIpB7tpXdkbATF+kTO/W4t8DM9B14JTkHTMO+4WgwN+eALR08s
         6MU/OznZKMqyTrIX3uq+W21vg8elD7KjgTvlRVRIzsYFxpnTrJBqKYarvBrkgX/LnohS
         sx7fQtYKCYAoZ7MkjqQJsW4QGc69oBR10dO6VyRWhykY2Gmb9HmkR/c351NXridW68XT
         swEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756430432; x=1757035232;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7QRqN4HfiQy+iwir6klZDolNcN7H5KoQUCyOlgErwp0=;
        b=dUdkz9XN3yzbUekaTODENc7xs+3qvOD90hsQxOEQCE18dSBRVlHYu2SJLkXq5gxXJh
         gfkW03Z1jIGtjbo0qpf0NpLrD4TLs1065+qnH6k5939Mg28hoATxOoQpEaeap1XBq03y
         YDtS2QJbOwyogSn/5C/WFdZ7PajkPv+MWdbIv+zdNq7WhGQZvlbrr4ZEpcS4Vw3S3mwn
         ihy1KhqdGlv2qrzbbRdhHM22hhYVPLGhL3o1l6YeRMkJ/s9bKGBzmdvuEKyLmyboR+Un
         CjhBNgES3vSjRHQB6XzwO9SCSJ8ZvJ48xoMbG42zhHLXTxeD/0Dd9yJBmmauJx4nyj84
         C41w==
X-Forwarded-Encrypted: i=1; AJvYcCVx8cmJi7q501fHTY5FRP/0fbGLtE49fQFh1fcjEUs3cU5RiXWiWpjoE2ibXpDit0O7pY55WHKU0LhS9UU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmEX4XWL32+KC0CvYdcgUMB5AlxMy1rBFCVlabYfPit8RL1olE
	sL8habF71/Xe+Ne8AlNO4fg0ItHfGc6jz0agq0I29pi3V8IhdoD7YH5Wh01dB8cyToU=
X-Gm-Gg: ASbGncvKVBdwTYNwasZmYyp2VJ3Aur/4xRzrOm3FKSXrYSlW87O3cdE6DrWV49Jb26s
	aEVSFcdgURHKkKVr88DwCecgu00nDnWpyKJEFl3TkheLCNStXUpb7mCnI6dnV6njqxqDO/ZBa/y
	ca5BA7ZsbOTPQqdIiG1KfA00VPdahsWS4S2vpgmp3DeV58VNIZN/pIS1eTR7S5wRNyiC3BRCXJY
	lCr2c+L65OthXbLTVf+Lm33toDjayICEFOCS3vrjJAsY0tX597HQAMkwX7PsEvBP2JbMUh9ZJGs
	/J8ST7YQyo5DSUUJqx72WJrf3NVbsS1rYsuoIaUUeOc5pVkgFVYph+5nbR3pIa8G3u+RYVx5PVE
	Ylq6CQ0tyDFNdjxyB/YBy
X-Google-Smtp-Source: AGHT+IG3nnAKV+tLfG9sHZEI3jAwfZpV+/J5awDHhzsmZLCuEhrp+Dc7VpdlLZSEtJ1janEw01qjiQ==
X-Received: by 2002:a17:903:3546:b0:246:d703:cf83 with SMTP id d9443c01a7336-246d703e19fmr239098615ad.17.1756430432059;
        Thu, 28 Aug 2025 18:20:32 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327d932f802sm972333a91.1.2025.08.28.18.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 18:20:31 -0700 (PDT)
Message-ID: <6424f720-9eaa-4642-9186-c0a148995e02@kernel.dk>
Date: Thu, 28 Aug 2025 19:20:30 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: check kobject state_in_sysfs before deleting in
 blk_mq_unregister_hctx
To: Yu Kuai <yukuai1@huaweicloud.com>, Li Nan <linan666@huaweicloud.com>,
 Ming Lei <ming.lei@redhat.com>
Cc: jianchao.w.wang@oracle.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, yi.zhang@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250826084854.1030545-1-linan666@huaweicloud.com>
 <aK5YH4Jbt3ZNngwR@fedora>
 <3853d5bf-a561-ec2d-e063-5fbe5cf025ca@huaweicloud.com>
 <aK5g-38izFqjPk9v@fedora>
 <b5f385bc-5e16-2a79-f997-5fd697f2a38a@huaweicloud.com>
 <aK69gpTnVv3TZtjg@fedora>
 <fc587a1a-97fb-584c-c17c-13bb5e3d7a92@huaweicloud.com>
 <a74495d4-27ea-4996-abd2-9239b941f221@kernel.dk>
 <5adb469d-9e4b-e2d9-a77c-a1a4d11a49d5@huaweicloud.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <5adb469d-9e4b-e2d9-a77c-a1a4d11a49d5@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/25 7:09 PM, Yu Kuai wrote:
> Hi,
> 
> ? 2025/08/29 1:23, Jens Axboe ??:
>> On 8/28/25 3:28 AM, Li Nan wrote:
>>>
>>>
>>> ? 2025/8/27 16:10, Ming Lei ??:
>>>> On Wed, Aug 27, 2025 at 11:22:06AM +0800, Li Nan wrote:
>>>>>
>>>>>
>>>>> ? 2025/8/27 9:35, Ming Lei ??:
>>>>>> On Wed, Aug 27, 2025 at 09:04:45AM +0800, Yu Kuai wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> ? 2025/08/27 8:58, Ming Lei ??:
>>>>>>>> On Tue, Aug 26, 2025 at 04:48:54PM +0800, linan666@huaweicloud.com wrote:
>>>>>>>>> From: Li Nan <linan122@huawei.com>
>>>>>>>>>
>>>>>>>>> In __blk_mq_update_nr_hw_queues() the return value of
>>>>>>>>> blk_mq_sysfs_register_hctxs() is not checked. If sysfs creation for hctx
>>>>>>>>
>>>>>>>> Looks we should check its return value and handle the failure in both
>>>>>>>> the call site and blk_mq_sysfs_register_hctxs().
>>>>>>>
>>>>>>>    From __blk_mq_update_nr_hw_queues(), the old hctxs is already
>>>>>>> unregistered, and this function is void, we failed to register new hctxs
>>>>>>> because of memory allocation failure. I really don't know how to handle
>>>>>>> the failure here, do you have any suggestions?
>>>>>>
>>>>>> It is out of memory, I think it is fine to do whatever to leave queue state
>>>>>> intact instead of making it `partial workable`, such as:
>>>>>>
>>>>>> - try update nr_hw_queues to 1
>>>>>>
>>>>>> - if it still fails, delete disk & mark queue as dead if disk is attached
>>>>>>
>>>>>
>>>>> If we ignore these non-critical sysfs creation failures, the disk remains
>>>>> usable with no loss of functionality. Deleting the disk seems to escalate
>>>>> the error?
>>>>
>>>> It is more like a workaround by ignoring the sysfs register failure. And if
>>>> the issue need to be fixed in this way, you have to document it. >
>>>> In case of OOM, it usually means that the system isn't usable any more.
>>>> But it is NOIO allocation and the typical use case is for error recovery in
>>>> nvme pci, so there may not be enough pages for noio allocation only. That is
>>>> the reason for ignoring sysfs register in blk_mq_update_nr_hw_queues()?
>>>>
>>>> But NVMe has been pretty fragile in this area by using non-owner queue
>>>> freeze, and call blk_mq_update_nr_hw_queues() on frozen queue, so it is
>>>> really necessary to take it into account?
>>>
>>> I agree with your points about NOIO and NVMe.
>>>
>>> I hit this issue in null_blk during fuzz testing with memory-fault
>>> injection. Changing the number of hardware queues under OOM is
>>> extremely rare in real-world usage. So I think adding a workaround and
>>> documenting it is sufficient. What do you think?
>>
>> Working around it is fine, as it isn't a situation we really need to
>> worry about. But let's please not do it by poking at kobject internals.
>>
> 
> There is already used in someplaces like sysfs_slab_unlink().
> 
> Do we prefre add a new hctx->state like BLK_MQ_S_REGISTERED?

If it's already used in a few spots, then I guess we should just be
using it as well rather than have a state around it. So I guess it's
fine. I'll just grab the patch.

-- 
Jens Axboe

