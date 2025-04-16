Return-Path: <linux-kernel+bounces-607518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 210CCA90765
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 17:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C01B444E68
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 15:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C7E202C30;
	Wed, 16 Apr 2025 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CnPjaQs8"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C268A201113
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744816237; cv=none; b=G7PMtiRpwq//8RncttmWPELr3j5yXF5KcNvexrj5aPsa7rA9VU3+rwVEvyy7KBWTH6qk8ip21iWK1wKWfOR/E3F06N5gFP+2akljAiNzQlFdKJ0b9MHY0vgwfDrUKD2IuFwEX5hAjjmLH4hkCF0cFHoouVuA201d5TJixw7A5Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744816237; c=relaxed/simple;
	bh=Ide8UYFDeeWAs1T/7pbZuBK8NGXCkQz+pW9bPws632E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OkY3MVsa1hZj0iB0Qv9KyoN/pOft9vlJeyE3Z7Wd3parAtLiRlD+bXKc/kwpm4yUmvVICmoSuwN/1re6/RNA7PIMq4JCTNWm3WNxkMYkn1URejH79kifeInY/sXSWUl1yJ3WYwWKoeVn4wRVXEKGd017sti8KUZvfYsMOgmDRHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CnPjaQs8; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-85d9a87660fso571867739f.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 08:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744816235; x=1745421035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j0/VAqjkF1TxpYnRhzPRlf8Ce1qx0Jj3f5VBhpm09qo=;
        b=CnPjaQs8v1ri2+WVSKVVXv98MygiHAkQzAirhP8FmKogh13uREmw1MhfJmSl9ujtCR
         V4AdODbbSq1Fzg80LJHIeHwSBecFERYIvjT6ZxaVr4drJZhrpUg1pyIlQ/8LjHpXWA3p
         sk3900V9k0QOa7LFMI2Bp/ElzE1A65Fal8XdEhIEMNRUItoQw3iNH4OOxwqpnJQUEGRN
         R3tfDjRj/Q5363DEZhNsx0hlbyflEWbCiam4W0fyQKso9SGoaVOnx2hYovemL0CpsEkY
         +slwJn4f9duRv66PXNWK28ii8n03Wrrgp6wpgRUrggke7MxKe74O2TtDW6tDEOzg9fx0
         EIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744816235; x=1745421035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j0/VAqjkF1TxpYnRhzPRlf8Ce1qx0Jj3f5VBhpm09qo=;
        b=NdZJ4CeDx5EJehKF/m8NNITYF055T4ULui/5i0PyUOR4lni7tFTDx3y1qrazjbk/no
         3ZuI5R21GALzxScIrWHnt+I5dj60MgGP+SGVnSA7aAblse/LR7g4qr+wAqoBkXRnSD0c
         3NkgNq/aD+nxw1LKcA3s8CgOdWopKSxeB9SHII7iUh8FmfJ8QTpYt/Gfj8bfT9JsgI88
         rCEWlUX+U18Arp9nOVjZINW8TIVGKhXi18X9rzoThZnYDAXkx7nzReUr+k+dS++RkCf7
         tw8JyT5ViY4kIX3HfQK82wEq/pnenl1uNjWtq5dX2aZwjPpBfBWICvQF5PoQskNdjoeW
         IzgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLIq8+y3Ye3O74Bv1yMhXGccCXX21Qo7TWgcutJq4L6oDtdMavC8HsOzORg+kRWZwG0+sJE8Xcq3+a7pM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIynZIe9dFm8yT2gcPzAyPD8Rkxc0rE+ndZuBtNSkrOlkPJpom
	zqI/OBrP8/lv6j3fJ1mmFQW8jMsxDHQ3TPODaw4FVomRWRcKhs4mC/f/gmbTLVU=
X-Gm-Gg: ASbGncuwajU+AjoAQgVjAZKsUda5xbVzuPF1/YpuYJ0g78tmst1SgRKHhJjuJ+NOroS
	hzLmgT9SXouCFHuS3Pv8C3JkyLV3LXOA2zcItMlcSDN/wnZ5sJkNeKTJGheTG2b/beDxrPkuaOW
	5voezrQwlqGFOqazP9WMTYnGJ6onFI50WWyIi4hg4mpqLKqhIModb2SI16gF0HmNxWvpuvktdfY
	bPjRwe2O37yF9eQeKazry3Gh5IQpSGWqU7/j79xjXTS+Mi61RvXab03StX94O8m7I/26R3o0tWH
	JemrUyF3sCm+wRCA3CMjK+wWa9twdmxmv/84
X-Google-Smtp-Source: AGHT+IG9lQIK5sXneDabYlnfRgSCtZ39ELSyEdyUKJIaRYq5uFV6x1HjDv9FC0Ieo/MZkxOXm+Y0Vw==
X-Received: by 2002:a05:6602:398c:b0:85b:35b1:53b4 with SMTP id ca18e2360f4ac-861c57e6f93mr262149139f.12.1744816234774;
        Wed, 16 Apr 2025 08:10:34 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505dfd731sm3641805173.88.2025.04.16.08.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 08:10:34 -0700 (PDT)
Message-ID: <d3231630-9445-4c17-9151-69fe5ae94a0d@kernel.dk>
Date: Wed, 16 Apr 2025 09:10:33 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/11] pcache: Persistent Memory Cache for Block
 Devices
To: Dongsheng Yang <dongsheng.yang@linux.dev>,
 Dan Williams <dan.j.williams@intel.com>, hch@lst.de,
 gregory.price@memverge.com, John@groves.net, Jonathan.Cameron@huawei.com,
 bbhushan2@marvell.com, chaitanyak@nvidia.com, rdunlap@infradead.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-bcache@vger.kernel.org,
 nvdimm@lists.linux.dev
References: <20250414014505.20477-1-dongsheng.yang@linux.dev>
 <67fe9ea2850bc_71fe294d8@dwillia2-xfh.jf.intel.com.notmuch>
 <15e2151a-d788-48eb-8588-1d9a930c64dd@kernel.dk>
 <07f93a57-6459-46e2-8ee3-e0328dd67967@linux.dev>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <07f93a57-6459-46e2-8ee3-e0328dd67967@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/25 12:08 AM, Dongsheng Yang wrote:
> 
> On 2025/4/16 9:04, Jens Axboe wrote:
>> On 4/15/25 12:00 PM, Dan Williams wrote:
>>> Thanks for making the comparison chart. The immediate question this
>>> raises is why not add "multi-tree per backend", "log structured
>>> writeback", "readcache", and "CRC" support to dm-writecache?
>>> device-mapper is everywhere, has a long track record, and enhancing it
>>> immediately engages a community of folks in this space.
>> Strongly agree.
> 
> 
> Hi Dan and Jens,
> Thanks for your reply, that's a good question.
> 
>     1. Why not optimize within dm-writecache?
> From my perspective, the design goal of dm-writecache is to be a
> minimal write cache. It achieves caching by dividing the cache device
> into n blocks, each managed by a wc_entry, using a very simple
> management mechanism. On top of this design, it's quite difficult to
> implement features like multi-tree structures, CRC, or log-structured
> writeback. Moreover, adding such optimizations?especially a read
> cache?would deviate from the original semantics of dm-writecache. So,
> we didn't consider optimizing dm-writecache to meet our goals.
> 
>     2. Why not optimize within bcache or dm-cache?
> As mentioned above, dm-writecache is essentially a minimal write
> cache. So, why not build on bcache or dm-cache, which are more
> complete caching systems? The truth is, it's also quite difficult.
> These systems were designed with traditional SSDs/NVMe in mind, and
> many of their design assumptions no longer hold true in the context of
> PMEM. Every design targets a specific scenario, which is why, even
> with dm-cache available, dm-writecache emerged to support DAX-capable
> PMEM devices.
> 
>     3. Then why not implement a full PMEM cache within the dm framework?
> In high-performance IO scenarios?especially with PMEM hardware?adding
> an extra DM layer in the IO stack is often unnecessary. For example,
> DM performs a bio clone before calling __map_bio(clone) to invoke the
> target operation, which introduces overhead.
> 
> Thank you again for the suggestion. I absolutely agree that leveraging
> existing frameworks would be helpful in terms of code review, and
> merging. I, more than anyone, hope more people can help review the
> code or join in this work. However, I believe that in the long run,
> building a standalone pcache module is a better choice.

I think we'd need much stronger reasons for NOT adopting some kind of dm
approach for this, this is really the place to do it. If dm-writecache
etc aren't a good fit, add a dm-whatevercache for it? If dm is
unnecessarily cloning bios when it doesn't need to, then that seems like
something that would be worthwhile fixing in the first place, or at
least eliminate for cases that don't need it. That'd benefit everyone,
and we would not be stuck with a new stack to manage.

Would certainly be worth exploring with the dm folks.

-- 
Jens Axboe

