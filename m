Return-Path: <linux-kernel+bounces-808911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A880B50665
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343041BC35FB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100CD34DCE1;
	Tue,  9 Sep 2025 19:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Qfd3jhlS"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93FC1531F9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 19:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757446031; cv=none; b=aJ7SCc1ZHa89v7AG88a3Y9FEDr3yPEy7aavt+L6BLUBBw7czL5VnRj51HWwtCixzmoswhqNYPI0iHbA2RnbOsBxl1zHTA/UtXqvbhFIyhNg+yBm4sbcSeeVIUbzBuIo6r2glW7z8zD6tVtwSfI7a0W9Fvjd757Q2Znw0M9uev2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757446031; c=relaxed/simple;
	bh=VYA+vinZJTCo3MxWBdo6Kkp5fxblRE63PTBfl2gqpwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TxSpgOcLhGMoSh7V4MftfuMbU1dGh6Vj7GQYLWD/AAN3LyxyoygzbHrYPHvoQQUIrjLZZ42URsGVDmcze83c9lsypislseAVy/wtMKhy8yrdY1znCEJVXuE89beEDFfqjDWvqbu7uMkB2MTjNmkBU+mliuGwKHfd2tG1Amdv354=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Qfd3jhlS; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-408929699eeso12449985ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 12:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757446026; x=1758050826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kk6ys450gxJ4lTVOQzfCmrKei8xzjGcxa9u9XRsdIcg=;
        b=Qfd3jhlSLD9mSvrQRbR91l0/D+B6XKAvD9H1InWTQp3tMQz3wEtd56KTlLSwUN2at+
         EbC8qOdziJzeXpvFOa60AlkftUNnSzPc8eyR5hLWc7Yk6fLDCBCe3DCog4iKW6j2PZ2E
         yyO2cGDMwWWmPZp6AO9+6uC7Dz0FPyw0OFAgAvmRTAU8bLDKbW7YdernZWt5+Yguio8K
         PSdzWmerILfU5mr6omcYbtUmlEsGIpfOSmlOKYN2d3VoQzb8/EFAO9X1QGYrqNBNkQIS
         XhI7SnZMrKrS25WAGlVzOvBestTEnmBoHJsKvujEGJD0IEZY6/p4BbSTTnEtQpWg/Va7
         WzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757446026; x=1758050826;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kk6ys450gxJ4lTVOQzfCmrKei8xzjGcxa9u9XRsdIcg=;
        b=EmXNd9/rhAyOJtRmP1VuN9UhTR3YAdlre0Uzw0Ri6Ys3kYBlDIRUCHYzrfMW/p5Gg3
         vB5f371u7ReLT6fxQgjN1eXyM/QSD+T/hJEYzSZgd5Yzl/5RLStTy4NJCStvRj/5tFOS
         sdFI6WJBgKgyaEXXJHFI4ws9sN/1YFwV9u1aOqG/Y/sbE6+zgqxF/7hkzNbd+LR1GV9K
         Hn7XIw7SkRIfa79eFyEaxPJETfZGDcl5zhlv0shItm4WN6kQve9e0CSPaxs4B5qc2208
         sn1tepzV6mNtLhj2DMlaZkFE0WO5gYTHJ8Sye74aKBOg+jDUacdfY/N4Pr8IRKs8XP6j
         CLjg==
X-Forwarded-Encrypted: i=1; AJvYcCXSvMq6XbY7dJ40KCvGt3znveKpgYjVukM2NgEcp+8AX96mIe0eeo3wm0oIhTzDkcQ0oj9RdToTpaz+fyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcrPwG7C1laxoRWPoREPL30UbvlypW0kJayx/2Q4+kgr85v0Jd
	eobzk1R2ohrkKr5bzu2CzTnWJlaLK2890fBbbX/WkFuQqlVddU3jFm1Y70fovXJOUAc=
X-Gm-Gg: ASbGnctmxwpzmAx2Jcq5zhGI85PxniUs3V7EGXLanFncc6pAfOT0gBCnhPRHeDdaEFP
	+2GNlRBWYGnydYFIEFP0UAF0CyHtwaqOwbQtsAVFemyYi+jDXAR8nQJFVFib0sq10n0PixL5TKL
	QrJNZMWN4pkMBhf40aiQJJtt1OJKvUDW8X8+I41DEiB0x/AeKg/bM1NEw1Uyc1QHyAxi+DWz0ho
	27/sv5t8k/k/UxDThRW93M8ZpwkeLR3DsKMZgwaubhdqOPd5KH59wHFa7rZZDCs6kKzXNG1oxvb
	1Ko74f1LqGGwbkIn/QPUKmzt6iBlEDHilBEJfj9yP+n2kzn/LbN52bXcHA3Z7CeP6TLPiR/ViNp
	mZDWKmSRrueIvsdoyZtw=
X-Google-Smtp-Source: AGHT+IG2xdLWcwrKZbGGLt1EZFURQEk31YgRmy27WISlH99paYhB8KK782zuKR/plop6xaTwVwbH8Q==
X-Received: by 2002:a05:6e02:16ce:b0:408:c77b:a7ea with SMTP id e9e14a558f8ab-408c77ba949mr130763765ab.22.1757446026524;
        Tue, 09 Sep 2025 12:27:06 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-51076c4a18csm3003320173.55.2025.09.09.12.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 12:27:06 -0700 (PDT)
Message-ID: <4918e983-9964-46a2-aee0-59c91a9c6b35@kernel.dk>
Date: Tue, 9 Sep 2025 13:27:05 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kernel?] general protection fault in try_to_wake_up (3)
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
 syzbot <syzbot+034246a838a10d181e78@syzkaller.appspotmail.com>,
 andrealmeid@igalia.com, dave@stgolabs.net, dvhart@infradead.org,
 linux-kernel@vger.kernel.org, mingo@redhat.com,
 syzkaller-bugs@googlegroups.com, tglx@linutronix.de
References: <68b75989.050a0220.3db4df.01dd.GAE@google.com>
 <20250902214628.GL4067720@noisy.programming.kicks-ass.net>
 <20250903130712.br0G6lOq@linutronix.de>
 <a1808501-559e-4762-b0ea-f1fffd2e7f19@kernel.dk>
 <20250904162820.NS1U-oZp@linutronix.de>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250904162820.NS1U-oZp@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/25 10:28 AM, Sebastian Andrzej Siewior wrote:
> On 2025-09-03 12:51:09 [-0600], Jens Axboe wrote:
>>> The syz-reproducer lists only:
>>> | timer_create(0x0, &(0x7f0000000080)={0x0, 0x11, 0x0, @thr={0x0, 0x0}}, &(0x7f0000000000))
>>> | timer_settime(0x0, 0x0, &(0x7f0000000240)={{0x0, 0x8}, {0x0, 0x9}}, 0x0)
>>> | futex(&(0x7f000000cffc), 0x80000000000b, 0x0, 0x0, &(0x7f0000048000), 0x0)
>>> | futex(&(0x7f000000cffc), 0xc, 0x1, 0x0, &(0x7f0000048000), 0x0)
>>>
>>> and that is probably why it can't come up with C-reproducer.
>>> The whole log has (filtered) the following lines:
>>>
>>> | io_uring_setup(0x85a, &(0x7f0000000180)={0x0, 0x58b9, 0x1, 0x2, 0x383})
>>> | syz_io_uring_setup(0x88f, &(0x7f0000000300)={0x0, 0xaedf, 0x0, 0x0, 0x25d}, &(0x7f0000000140)=<r0=>0x0, &(0x7f0000000280)=<r1=>0x0)
>>> | syz_memcpy_off$IO_URING_METADATA_GENERIC(r0, 0x4, &(0x7f0000000080)=0xfffffffc, 0x0, 0x4)
>>> | syz_io_uring_submit(r0, r1, &(0x7f00000001c0)=@IORING_OP_RECVMSG={0xa, 0x8, 0x1, r2, 0x0, &(0x7f0000000440)={0x0, 0x0, 0x0}, 0x0, 0x40000020, 0x1, {0x2}})
>>>
>>> This should explain the how the waiter got NULL. There is no private
>>> flag so that is how they interact with each other.
>>> Do we want this:
>>>
>>> diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
>>> index c716a66f86929..0c98256ebdcb7 100644
>>> --- a/kernel/futex/requeue.c
>>> +++ b/kernel/futex/requeue.c
>>> @@ -312,6 +312,8 @@ futex_proxy_trylock_atomic(u32 __user *pifutex, struct futex_hash_bucket *hb1,
>>>  	if (!top_waiter->rt_waiter || top_waiter->pi_state)
>>>  		return -EINVAL;
> 
> I've been poking at this today and I have one problem with my
> explanation:
> The io_uring code initializes its futex_q with futex_q_init. At this
> point futex_q::rt_waiter is set to NULL and never set to something else.
> We should bail out here instead of going further.
> Only the PI bits set rt_waiter. Only io_uring sets task to NULL.
> I'm hopeless, this makes no sense.

Was on the road, and now back at least for a day or two... So I took a
gander at this one too. One thing that puzzles me is the io_uring traces
in that syzbot log - if they are to be trusted, it only ever submits an
io_uring RECVMSG request? IOW, no futex usage on the io_uring side at
all?

Going to try and download the disk image and kernel and see if I can
actually run this locally.

-- 
Jens Axboe

