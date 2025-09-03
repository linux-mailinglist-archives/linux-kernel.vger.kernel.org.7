Return-Path: <linux-kernel+bounces-799252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4C0B4290A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D1A1BC1E0E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC46D3629B3;
	Wed,  3 Sep 2025 18:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wsEPc7dp"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D8A322C78
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 18:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925477; cv=none; b=tBBhMWX3lbtiVdFRx6/rQ2eUaJkN5HjWWL6wBOlRMN2eoqMBxzYvYwVgmbox50eNw6R+WWms+cQd0JzcBWvj7zpNfQRlVhiWXtdgx317NCIu47vy2k6NmevC3Nuq7YsmMgl99MasiUq6fRvlYPEUUxTs/fGvceQ2yg3ObR7cJQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925477; c=relaxed/simple;
	bh=Fj3/dkzc4gxvcEO/NfY2p7ht/BFeHD4blx0uM0Drg10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kYUO2iX5F+bQkhwCmgavR9E069spKXh6EBYVs4LB2AROlNTI1PmNh47OM429oDswYsX9s5K/0qi2CSvkVXtYqWtNqTde/xOqTTtDCurcVdwN55/H4wlI/RGk67XNttA/aj2KYbVC0yqKQH57nUQqHAar+xzJ++w8LIEZgl6M9+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wsEPc7dp; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-88432cbdb8bso5703639f.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 11:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756925472; x=1757530272; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q/Uv+KqzSIFPonxLueFv7yH94Tg+4KugFLzAnuLOv0I=;
        b=wsEPc7dpJGyCxnDHuhVVk17ytc3D4u7HhdA8VS1MwrlAwbt0lwrdbjSp2+4QpF8Nqn
         9N7lINHKQfG2eu9uP2MjRaTPKLwuGl+cAEGmmF4LUT90XAWB8sye2/wwNA0x6FdkPBMr
         OTRK/RnlJ5hpHeNe6SXrxopSfCl1HowBKiPbAvrIyDJDMIhq/D4qpH0fZuNv+S/2fs4v
         SsVq0LkKJ+rOnZeplzLllCAv21+e0sGhRAPfS8oN1kZGjceqscZpbv2secMD2inQoM5J
         Mmmms4y5fIYNKDqB1X47qx7McH8aegEU3OQGozenlwGLH19rzHCRc7iEowbNx3u6SAb7
         8LSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756925472; x=1757530272;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/Uv+KqzSIFPonxLueFv7yH94Tg+4KugFLzAnuLOv0I=;
        b=gI3km7q/aGtyx1tnvBzq53l+HShzWaVSJoxI1jqeppvKp1bKJ4xPLNfm5DrmTb9nxW
         I5wp0Rq8ZxNVdnThmnffQwmbqTT+fDgqSrF06rVho9J3qp/4UUi9NIK+t2LJMwAolw9s
         +YiX+QSioL06UJz3FHknA+50cjs8jzMni1i89B6ec2p4gwjfK9Wkf0P72ryQnOfFCYaK
         USCccVn8fJajdCAFZCA9mVOCWbNPJUc9nUml0tFelIT6KMegmBt9JmAyl6wSWIgu46Ib
         6KaxubUZjARU1Iwbkg6ef/ElFaSdsvVnYa4oHht0R/m9ucWMLxp25MJ+TOYYehS81FOQ
         uCmg==
X-Forwarded-Encrypted: i=1; AJvYcCW0EydgZvF1y4L/o3fpfsvW60KSIXoh/GJtM4zy45wBS/PctUL/URx5vb/DdUfYD5OzdrBSc/yqnw8snbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH4pcMMI/0vmUc//pS83IuM5ESzUsldEaJS6HOu8k46MS+5LcB
	DQUm5NDAjoU1Ndyy+UkzRN+ggnMlkybnzjxXXB8PSAMGacO1Bs3yxQW4e/jwFDLErxk6s37l51o
	W/ejR
X-Gm-Gg: ASbGncvEHSlR3HghcsUGGNAoKq2BRgHmzz6xXhYPaCweSf/vdzzkEC0vgyn15sqixvN
	F7CPodZ5w1V60S/eAARnOTre9UhVxfJkYxOtW4Hoo1XHEa7z4f8/kIQO5v9IqvmGDGYXOD61yJ4
	l4IItdcyWJ+SIN+EfNFhgbKEZHKaaU//eS8tGHD32dKTNZrq35XcXAuJWDitzxOTvKbPadhInOd
	8AjEhJ5qzsXcoVzg6OnF7GKkVMSWPcVlUbODBmVPX5FAR0tHN0qKoliX1MwTgkgTor+bw+L3+Wi
	UhSoUy+0MhTzd8rtEhAKUtodYyhu3wWsLYjsNAOBzVb9tBZRm6Aq5L4EwLGWBHHI5JA81mE8eHN
	AS28TcDlGFevGEqS2C6MeBR9Ra2bY
X-Google-Smtp-Source: AGHT+IEqD2v2lFt4snU/cxc0e5xCQiIMpGN7gxH1tVoPHEU7igpPBcFcycJHUsE6Oq57mxlCUo4amg==
X-Received: by 2002:a5d:8d02:0:b0:887:c7d:c6ea with SMTP id ca18e2360f4ac-8871f4d19d7mr2442903839f.15.1756925471704;
        Wed, 03 Sep 2025 11:51:11 -0700 (PDT)
Received: from [172.20.0.68] ([70.88.81.106])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8871e3d8247sm420645939f.16.2025.09.03.11.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 11:51:11 -0700 (PDT)
Message-ID: <a1808501-559e-4762-b0ea-f1fffd2e7f19@kernel.dk>
Date: Wed, 3 Sep 2025 12:51:09 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kernel?] general protection fault in try_to_wake_up (3)
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>
Cc: syzbot <syzbot+034246a838a10d181e78@syzkaller.appspotmail.com>,
 andrealmeid@igalia.com, dave@stgolabs.net, dvhart@infradead.org,
 linux-kernel@vger.kernel.org, mingo@redhat.com,
 syzkaller-bugs@googlegroups.com, tglx@linutronix.de
References: <68b75989.050a0220.3db4df.01dd.GAE@google.com>
 <20250902214628.GL4067720@noisy.programming.kicks-ass.net>
 <20250903130712.br0G6lOq@linutronix.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250903130712.br0G6lOq@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/25 7:07 AM, Sebastian Andrzej Siewior wrote:
> +Jens
> 
> On 2025-09-02 23:46:28 [+0200], Peter Zijlstra wrote:
>> When I build the provided .config with clang-20, that a58 offset is
>> exactly task_struct::pi_lock::lockdep_map, which nicely corresponds with
>> the below stacktrace, and seems to suggest someone did:
>> try_to_wake_up(NULL).
> 
> correct.
> 
>>>  try_to_wake_up+0x67/0x12b0 kernel/sched/core.c:4216
>>>  requeue_pi_wake_futex+0x24b/0x2f0 kernel/futex/requeue.c:249
>>
>> Trouble is, we've not changed the requeue bits in a fair while... So I'm
>> somewhat confused on how this happens now ?!
> 
> This means syzkaller managed to invoke futex_wait_setup(?, NULL) in
> order to get futex_q::task assigned to NULL. All users use current
> except for io_futex_wait().
> 
> The syz-reproducer lists only:
> | timer_create(0x0, &(0x7f0000000080)={0x0, 0x11, 0x0, @thr={0x0, 0x0}}, &(0x7f0000000000))
> | timer_settime(0x0, 0x0, &(0x7f0000000240)={{0x0, 0x8}, {0x0, 0x9}}, 0x0)
> | futex(&(0x7f000000cffc), 0x80000000000b, 0x0, 0x0, &(0x7f0000048000), 0x0)
> | futex(&(0x7f000000cffc), 0xc, 0x1, 0x0, &(0x7f0000048000), 0x0)
> 
> and that is probably why it can't come up with C-reproducer.
> The whole log has (filtered) the following lines:
> 
> | io_uring_setup(0x85a, &(0x7f0000000180)={0x0, 0x58b9, 0x1, 0x2, 0x383})
> | syz_io_uring_setup(0x88f, &(0x7f0000000300)={0x0, 0xaedf, 0x0, 0x0, 0x25d}, &(0x7f0000000140)=<r0=>0x0, &(0x7f0000000280)=<r1=>0x0)
> | syz_memcpy_off$IO_URING_METADATA_GENERIC(r0, 0x4, &(0x7f0000000080)=0xfffffffc, 0x0, 0x4)
> | syz_io_uring_submit(r0, r1, &(0x7f00000001c0)=@IORING_OP_RECVMSG={0xa, 0x8, 0x1, r2, 0x0, &(0x7f0000000440)={0x0, 0x0, 0x0}, 0x0, 0x40000020, 0x1, {0x2}})
> 
> This should explain the how the waiter got NULL. There is no private
> flag so that is how they interact with each other.
> Do we want this:
> 
> diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
> index c716a66f86929..0c98256ebdcb7 100644
> --- a/kernel/futex/requeue.c
> +++ b/kernel/futex/requeue.c
> @@ -312,6 +312,8 @@ futex_proxy_trylock_atomic(u32 __user *pifutex, struct futex_hash_bucket *hb1,
>  	if (!top_waiter->rt_waiter || top_waiter->pi_state)
>  		return -EINVAL;
>  
> +	if (!top_waiter->task)
> +		-EINVAL;
>  	/* Ensure we requeue to the expected futex. */
>  	if (!futex_match(top_waiter->requeue_pi_key, key2))
>  		return -EINVAL;
> 
> ?
> 
> Sebastian

Yep that looks reasonable to me. And agree that this futex must've been
setup on the io_uring side, which is why you end up with ->task == NULL.

-- 
Jens Axboe

