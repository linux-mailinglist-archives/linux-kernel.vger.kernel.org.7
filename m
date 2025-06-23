Return-Path: <linux-kernel+bounces-698013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D0BAE3BCF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 12:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57A651881E54
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 10:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEC0238C19;
	Mon, 23 Jun 2025 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bw9ZdiP5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674F71DA23
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750673429; cv=none; b=OT5N8L48/FNkjT0pBAUNdrCnU6jdQzj/eDZR3BzR/P2y+NntxRabUzs5QGQbbI1AEjuTL+mldrilVuOE8q3bEFAwOmtxOB+OsnKYHcdO3PCkD1SY47ByVJYKnNvrEA/Vfdp6MgiJy7FZQFCntCzbCarT+NPQK5eWX95SGf0KdTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750673429; c=relaxed/simple;
	bh=3ZUFpokQoSvgZvhh8ue+5cuzKIWcZegvvPFyEZdALS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQoIV9sKcWL0Ekdeq+zhlqYPFpHRZgINyHBKbgR4O1enbAMmHCmRSg0zI2kWTV2EN8rCcIFqGqL4+3W7XFj2fvJ8ByoRc/PcI3Y5dENHPTn5fS0qJSkrqg3mSBCgtrBcGPesm8Bm1F2CyJiehPNp4kyimdg3u9S/abOJmKbaHuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bw9ZdiP5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750673426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ETVG0JoOYSiEcX7weCnSYJvPswL0KYtxaM6qJiyeiUU=;
	b=Bw9ZdiP5o08vu34mHNadGljIX8KBIr2U5yl/4YZ4UObtEjhLjluBdMvzYyOSBl6p0yxxNa
	NdHS4+nMbTGS4KQF9J/IZlk+hZ7aHml6lS8N3YDpPHgPTX97qQjuCzt4rlj6synADngoQP
	rxPqxRitV8JfQmMYMSULViU77mqbAmQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-riNv-8yKMK6cSHDj3yNolQ-1; Mon, 23 Jun 2025 06:10:25 -0400
X-MC-Unique: riNv-8yKMK6cSHDj3yNolQ-1
X-Mimecast-MFC-AGG-ID: riNv-8yKMK6cSHDj3yNolQ_1750673424
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso21838955e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 03:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750673424; x=1751278224;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ETVG0JoOYSiEcX7weCnSYJvPswL0KYtxaM6qJiyeiUU=;
        b=AjqAHX619iUuKVIwfdDEz+exo8dO7MjHaPvsNGKLlYTQ56Gt8MMt7tHLz0qtEETl0L
         3b7gXvOPxcxyfY0OEJjSBLcQ6Ohv7mVRxIxxjOQMwRL2FVtw6OkI4jHWKGEMIoE6QzDQ
         Y4TqDpgcXdXOtc46ZK5YF0iyFwweoY41leMOChjZe1m+YadPIZQXDPwvRrNECELEurEd
         FNuHVxzufY+2N2aM7YxmV40udzydTFWWONWrOQ0QailU9UzlKBPORfANeb63OeU55kmS
         VeYxKITz6H5/XGYIe7veDBbBfNxmI/IjSKNO8WiuZfpQ8xW0Nidwfjk2s28RZ/OGDnOf
         ZEdA==
X-Forwarded-Encrypted: i=1; AJvYcCUrI8hEbbYihhaN+pgRw3NnpAEEAWMG9uB9If1+ceJFbJIZt8Sd49Kv6yRj80302hPe2KuyV4Y7cND4e2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzllaxbQwxBsflCJBK6m0axxRHI1ePr6NbtV6Cpd6DYkQJ5qPXr
	HZej5wMyS7D0deH98bMKpQSPWQpkzfFHVLkZR5Ff4RKiT69a1MGhL8GytcM6tGDCbASmfD7k7XW
	qcZc05X5XJN32VmWPTt20pHpZeKsXzOwMcE4OOuiO7vOb5lPfIHfc4djsixWEuFRITA==
X-Gm-Gg: ASbGnctHjvxtcVWPFww8wtCksS6bMm2bbc/QfsW7NVLuYSj2d/inNZi5wzsX1o64ZpJ
	W2J+yfB3SSWi4OygMsgaj6d0Owc0kAy6lE2RZk/Naqm8DH6Tmdmy72c3KAAU+y/4ur+vlHwREt/
	CUjU3pUYAPZZF9/h/wYzv0GjbPLn+lcKf3bjV8OujZO/yctLNyxcSF4qbKW7LwZOZ5jTSxW3OkK
	gKLPBxJipKVQfQqXo4b6OokuoPEVKbvqOQCyO1HujGXmpoxds9cm4wtJQxbYklC1fzE/GREmIcP
	bFRXV527f0OpEEkmisDsdnvLNEtIxF58B/ecmAQ3lEnmIv75Gnd8WWe1z/XWMwMfzZw/Q9utJTh
	ui0aEhBN1whgnfnl8rhQ/G7N++s39NcL+UM2Di/jOjDEyXIVAWQ==
X-Received: by 2002:a05:600c:8588:b0:43c:f3e1:a729 with SMTP id 5b1f17b1804b1-45365e7b390mr79916065e9.12.1750673423764;
        Mon, 23 Jun 2025 03:10:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY7uPe04dho/W1TbrYuasoWSwlBGpD2SCy2IZOjzGhmcksEQk+lccG0ZP2nipj6wv61YR+8g==
X-Received: by 2002:a05:600c:8588:b0:43c:f3e1:a729 with SMTP id 5b1f17b1804b1-45365e7b390mr79915805e9.12.1750673423384;
        Mon, 23 Jun 2025 03:10:23 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159? (p200300d82f4efd008e13e3b590c81159.dip0.t-ipconnect.de. [2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f10a8csm9188410f8f.13.2025.06.23.03.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 03:10:22 -0700 (PDT)
Message-ID: <56862a1d-71c0-4f07-9c1a-9d70069b4d9e@redhat.com>
Date: Mon, 23 Jun 2025 12:10:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] kernel BUG in sanity_check_pinned_pages
To: Alexander Potapenko <glider@google.com>
Cc: syzbot <syzbot+1d335893772467199ab6@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, axboe@kernel.dk, catalin.marinas@arm.com,
 jgg@ziepe.ca, jhubbard@nvidia.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, peterx@redhat.com, syzkaller-bugs@googlegroups.com
References: <6857299a.a00a0220.137b3.0085.GAE@google.com>
 <b5aa34ed-d7d4-4445-b8bb-6187b4100682@redhat.com>
 <CAG_fn=WBBwkZZZzBMp0SO3=POgKzNaJGkU_YJKcAKRVQdEYPqw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAG_fn=WBBwkZZZzBMp0SO3=POgKzNaJGkU_YJKcAKRVQdEYPqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23.06.25 11:53, Alexander Potapenko wrote:
> On Mon, Jun 23, 2025 at 11:29 AM 'David Hildenbrand' via
> syzkaller-bugs <syzkaller-bugs@googlegroups.com> wrote:
>>
>> On 21.06.25 23:52, syzbot wrote:
>>> syzbot has found a reproducer for the following issue on:
>>>
>>> HEAD commit:    9aa9b43d689e Merge branch 'for-next/core' into for-kernelci
>>> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1525330c580000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=27f179c74d5c35cd
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=1d335893772467199ab6
>>> compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
>>> userspace arch: arm64
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d73370580000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160ef30c580000
>>
>> There is not that much magic in there, I'm afraid.
>>
>> fork() is only used to spin up guests, but before the memory region of
>> interest is actually allocated, IIUC. No threading code that races.
>>
>> IIUC, it triggers fairly fast on aarch64. I've left it running for a
>> while on x86_64 without any luck.
>>
>> So maybe this is really some aarch64-special stuff (pointer tagging?).
>>
>> In particular, there is something very weird in the reproducer:
>>
>>     syscall(__NR_madvise, /*addr=*/0x20a93000ul, /*len=*/0x4000ul,
>>             /*advice=MADV_HUGEPAGE|0x800000000*/ 0x80000000eul);
>>
>> advise is supposed to be a 32bit int. What does the magical
>> "0x800000000" do?
> 
> I am pretty sure this is a red herring.
> Syzkaller sometimes mutates integer flags, even if the result makes no
> sense - because sometimes it can trigger interesting bugs.
> This `advice` argument will be discarded by is_valid_madvise(),
> resulting in -EINVAL.

I thought the same, but likely the upper bits are discarded, and we end 
up with __NR_madvise succeeding.

The kernel config has

	CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y

So without MADV_HUGEPAGE, we wouldn't get a THP in the first place.

So likely this is really just like dropping the "0x800000000"

Anyhow, I managed to reproduce in the VM using the provided rootfs on 
aarch64. It triggers immediately, so no races involved.

Running the reproducer on a Fedora 42 debug-kernel in the hypervisor 
does not trigger.

-- 
Cheers,

David / dhildenb


