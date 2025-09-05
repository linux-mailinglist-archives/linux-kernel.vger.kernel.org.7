Return-Path: <linux-kernel+bounces-803710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A9BB463FC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333295E059A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF9828136C;
	Fri,  5 Sep 2025 19:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wKsSzsBx"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C18275AE3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 19:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757101964; cv=none; b=FO6O5QuJBeon9gj8F/p2HWbQZ3x4XV4EQJj0zFvd2xBg7obdQyE0LPXpYPX4PNoCGq75aBBrbJ4PqtVZ48a8xaj6KJxaEkOx3jKFkDn8VzYaM1qTNok8SiOhkoIrZjCP86rK+lvZhmxcsgef/kWdcbVIzpGpoPoihw7Lz+HrlO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757101964; c=relaxed/simple;
	bh=2bnmXoFq8hT07977Bt8V37gyvrBp2WvBZT/P/9TkDN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e2Cfbk8lmTngXRjL/YXP2OREFldbACSwb4BFrj3trvHQFePyMquL+vFKBVtQ/x9C0JimYbBDpi15jRfWIUAS12E0OUnIr9frHtq0u8bigzMut9M1b7F6AGmnlYze5gGEhtYjPTHC563CmizG0jbF5TNNQeloZvZEhjw2Rm18G+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wKsSzsBx; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-723bc91d7bbso29311247b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 12:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757101960; x=1757706760; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4HSKMhFHnXL4om4k6tLAqbvEJ0fBQx5JXzb5/1sEFd8=;
        b=wKsSzsBxAqegFKINgKpx1VtTvmOMhaasEQkbYKTZM6icWw5vFFL79beYX9IlWGzhlJ
         LGjiJvKFXtbq/BcRW45Etn8ewNuHda11BAvBdzT4BK4+9vXBvFRygMfq+VCSomBbqrDN
         /ph66V2UIFGmamobZMRqlNWQl+K4kJYZgthAsU1C50Eeo+AiK6acRpmIvPUY6XMkjk6c
         1o5j4jVeFwu1sA/lJ0qZrCaG327aVyj+09y45Qa6QtGRgiTEyCk0fFkIdPxMQd7NhK6J
         R+2kPvRWzZosQ964uJDV6VO1yVIv3kQLzENbP5ekkeP+Vr1YocicpbwIY1gBHrlSCu7K
         HLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757101960; x=1757706760;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4HSKMhFHnXL4om4k6tLAqbvEJ0fBQx5JXzb5/1sEFd8=;
        b=Q6/j5OraEvga9GcRlLKPJ4bdIqCcq5eH2VIJsYb8TqTUz0InYVdTWKjFcwaAXfP2GY
         6RVSeuZaEVFNnw4Rhy9ewZLg1MKCOFPxMaYetRb6svMHPA2ajsR7hluG9KSjSjAEmzAd
         lt7xfhFSt4I2S5o3nLZrp8gjUoVbf6M39AxdNxwZAV/HKEVNLMgg0TKwc/Ki3I1agZaT
         bFV+8T6gU/siiyYRV4tkhnMqbDO306hKbK4+B9qiUI9gwit4nbGCMrjGanmR/xztFPa0
         RDWgGb4k2fcM3csgkGWevqZLsKHWYACL4I/4P1LybxJDW7gQH+3x1iWKyvexOCrWeSH3
         5nLw==
X-Forwarded-Encrypted: i=1; AJvYcCUxCCaKy8t99NHWcV8c3uHRRISemkWVCzNLxE02GsfURXm2icHNfYB+kiRj6MfYyIxS5sP08rJwHqbmsP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqvBMweJQiiDDQbw72IYOOewfmlkO0WAwgXVg2j8nsttYQHuCE
	gKf2RnBsZpzrIrcOi/Etp6hqkfUvFsrFF0Y43bMCddnlAsrKa9/9sTUgYwhAC36jags=
X-Gm-Gg: ASbGnctbEysSZvJX7dvoxdDQkrrPASTbl8W2W91/XBx09qUgB/a4lfalcv3G9KeHv+l
	s7qFRSuAdjZWdmTZ3jSrw7MNVWX3YXHD3faxfL/aRZKYz/xQwX7BYCZKQOR3XI1Yez4cz/7YTT7
	nReQiGs2XRnBSqZSJPCe1NScnjOo7axJLeWQXRDuZCYxcpy1OhJm81UTFzcskC81gJQKXmdTKWF
	CtIXngrPNW6Yv/pSXjqzYCouJQ34pdwcx6gOToXC3Gqypn3mt+Euq21oVw+gNHzlPAwIdaxpTyl
	GBgv9m8j9CekjFcRtfmlAxSPT3nKsJaYg1IerDixrcMe59JQTOd+uho+fapIT73LJ6iMlmZ6ahP
	+CrCEneHXZdO1eZoP/eo=
X-Google-Smtp-Source: AGHT+IFdsFDBwdpPG1DdzDrJ6wvtu1VxG7NloPK+qUtgvUQ5KzDXlITM6YW8RLXwJZuYT9usxfwmIg==
X-Received: by 2002:a05:690c:6411:b0:721:5880:6b2 with SMTP id 00721157ae682-727f5e3b124mr925857b3.51.1757101960514;
        Fri, 05 Sep 2025 12:52:40 -0700 (PDT)
Received: from [172.17.0.109] ([50.168.186.2])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-609d205c24dsm1361503d50.0.2025.09.05.12.52.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 12:52:40 -0700 (PDT)
Message-ID: <e15833f9-c18b-4783-af01-42f44a9cecb3@kernel.dk>
Date: Fri, 5 Sep 2025 13:52:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] blk-mq: fix update nr_requests regressions
To: Yu Kuai <yukuai1@huaweicloud.com>, bvanassche@acm.org,
 ming.lei@redhat.com, nilay@linux.ibm.com, hare@suse.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250821060612.1729939-1-yukuai1@huaweicloud.com>
 <95389918-b809-f81b-5fd0-2e350154ca01@huaweicloud.com>
 <f4231a7f-cc73-c506-e30b-b2bfa9d98dba@huaweicloud.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <f4231a7f-cc73-c506-e30b-b2bfa9d98dba@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/25 1:20 AM, Yu Kuai wrote:
> Hi, Jens
> 
> ? 2025/08/26 14:27, Yu Kuai ??:
>> Hi, Jens
>>
>> ? 2025/08/21 14:06, Yu Kuai ??:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> Changes in v3:
>>>   - call depth_updated() directly in init_sched() method in patch 1;
>>>   - fix typos in patch 2;
>>>   - add review for patch 2;
>>> Changes in v2:
>>>   - instead of refactor and cleanups and fix updating nr_requests
>>>   thoroughly, fix the regression in patch 2 the easy way, and dealy
>>>   refactor and cleanups to next merge window.
>>>
>>> patch 1 fix regression that elevator async_depth is not updated correctly
>>> if nr_requests changes, first from error path and then for mq-deadline,
>>> and recently for bfq and kyber.
>>>
>>> patch 2 fix regression that if nr_requests grow, kernel will panic due
>>> to tags double free.
>>>
>>> Yu Kuai (2):
>>>    blk-mq: fix elevator depth_updated method
>>>    blk-mq: fix blk_mq_tags double free while nr_requests grown
>>>
>>>   block/bfq-iosched.c   | 22 +++++-----------------
>>>   block/blk-mq-sched.h  | 11 +++++++++++
>>>   block/blk-mq-tag.c    |  1 +
>>>   block/blk-mq.c        | 23 ++++++++++++-----------
>>>   block/elevator.h      |  2 +-
>>>   block/kyber-iosched.c | 19 +++++++++----------
>>>   block/mq-deadline.c   | 16 +++-------------
>>>   7 files changed, 42 insertions(+), 52 deletions(-)
>>>
>>
>> Friendly ping, please consider this set in this merge window.
>>
>> BTW, I see that for-6.18/block branch was created, however, I have
>> a pending set[1] for the next merge window that will have conflicts with
>> this set, not sure if you want to rebase for-6.18/block with block-6.17
>> or handle conflicts later for 6.18-rc1.

I think we're just a bit late on this one, given that they'd go into
-rc6 at this point. Going to queue this up for 6.18 and then we just get
it into stable instead, that gives us a lot more time to shake out any
potential issues.

-- 
Jens Axboe

