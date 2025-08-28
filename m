Return-Path: <linux-kernel+bounces-789591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08241B397BD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E4A363C70
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33E2218ADD;
	Thu, 28 Aug 2025 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KKmHf0Y8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39817DF58
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756371612; cv=none; b=KiuHpnn/Fm6ofF1DMTu+B0PaTOM+5+croRPABRr8w6scsB+yLBqjmChz0S13JocP9N8yMmWbYvaA4D2Qn468L5Lh0o8dAzqhivNF9f0Pu4B+PSzJvn2nPHwkeckYt2NrS8r7wO+KtC0I5mWg3r0CbFg2WKZwlNjkOBP3M0BNxyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756371612; c=relaxed/simple;
	bh=v0om4jDSPSBL39d1MkwU0Qib+2cpdw/90S8KoJo/BHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NatqCCvK19rZlBx0aEgWn3crva0QK5VxN0SRrIzjl/9iRE2z3XhMoK0Ao3HHsfVTgPKHEce3x3HJvHkzDXjcDbSeRl+ouY+gID54XV7aTYdtoPkRdGlBGW+Yq6hq+hwiSn6jICyFSK3vOkZ+tndwReS8Y3zEE9KK0Oh7A96KKxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KKmHf0Y8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756371609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=B+eUQDQFyI827IMsBZ4ENEU8Lk0pMUb22YeE9OodMQU=;
	b=KKmHf0Y85ifd0C08uVNrEDcF7b9mdEK4IXijnZ8sKIKLxuAIdK3DKp9aZuRjUykTrJa1AJ
	4B76n+BKsj2MYXKEC4yhqz/TAMzYFYFihYsibgYcr+kknKwSJ9TIiLBbKdhy4WhkzPV13Z
	0l2kqPUV1YeUuTR+0Zjo7IiMG6kS1k4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-HOUvN1RONf-NdNQZ45Ytgg-1; Thu, 28 Aug 2025 05:00:02 -0400
X-MC-Unique: HOUvN1RONf-NdNQZ45Ytgg-1
X-Mimecast-MFC-AGG-ID: HOUvN1RONf-NdNQZ45Ytgg_1756371601
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a15f10f31so11903125e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 02:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756371601; x=1756976401;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B+eUQDQFyI827IMsBZ4ENEU8Lk0pMUb22YeE9OodMQU=;
        b=tPBJ+JRct9ed+q3UlQ9Zp0pNhZhXYuPPPlpfLAubw7Pih5MvTgHA3cnVTERZZJcf1t
         vojK4Dx3Pl7Q19fgpdQaKGlZ9Bw5q6tGG8lsxUcEhDyVEVO3MW+zzqgba4bwKy+iMy6d
         fHrOOqsOCiTqB/1p11DiFcFcXVDDWGENuKHBBI9lBf8kvXNY42bu8cgmaXZ7iJ06arXb
         rnY4JRx+p5KXAaXu8DvfCoQXCjCkIB9OF6LNP+o9Z8CgaWE+VKTJQQ0KKDOO5+wcmFvU
         J2U8TaIt6UrKo05Rzx0+9g6YfiMaEWelW4U+fPhZe+AUjkFFpgDLEN2vHNPaRK5nB/Nf
         FMhg==
X-Forwarded-Encrypted: i=1; AJvYcCXFjNPaNMV5k9lIg8J8OvgTzKJmLeYhdRrRZ1K34wiK2/Xd2p9nXosMVg12D+zRDWovkqLh2u+Hw6m8kzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkpeQ2L37yUbojl5FABS6xcZ//unc6XZader+gJ+YqTeGYeLCM
	sWAygRPjeTnfJEUzu3XctX/f46kD0M4tFcAxAc+vO04WSNQyUllHpsaZ49V3E0XVou9v/NYdL6n
	/AA4Nmsm8nAYMZ8KLNbg0gHiZ7yGfld3E1Omj+Wk7VapDDSaDi5srIfiQZge0iLllcWPQjSrf8L
	FRdIw=
X-Gm-Gg: ASbGncvEWdVUaHFVMc3syRdFKFL7+Z3bIErBbMLzMMeGJWMmwLGP68itz6kkcKCtTeP
	4OLNu0k4qugOv2aqdfa/iE5WCHJllwX/S0pGsuaASblBGoLeDxyjp9c2PJkwRbngASjId8f5BZ6
	JWEsohGfBSmm8kdzlrLgjlelkP2DM+bgm02zMXdMOn96np40bpgFGkDzx549xaNGIprkuXDbnxo
	tZS4uTIremblqhGhe+L5ISBiOwaIBnA9dBsoDjmmWki1K3T7IqvfJ88MWm2pAIKeJ2C8r6abmKd
	2nED8m830pt7YXpiSf1fkwEhNsIiuD2nxyyR/xsOxuc0dULls0VGnP2j93XZNch11ocS4J6ZSvI
	hY0yrKLk9v48qa8EXQ9GwnMcc4mMh/9UW2tTQcqtbuCKxjOeCtzeYlIyqkYfpylB6dDA=
X-Received: by 2002:a5d:5f45:0:b0:3ca:239:a035 with SMTP id ffacd0b85a97d-3cbb15ca238mr6207347f8f.19.1756371600737;
        Thu, 28 Aug 2025 02:00:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvwQCgZ8qwfbAqaBgA/aLm0dXyJcnKm4aS+HC66ZpgjjAawtJHBXG0suiuLiXZ7k/g7a1tkQ==
X-Received: by 2002:a5d:5f45:0:b0:3ca:239:a035 with SMTP id ffacd0b85a97d-3cbb15ca238mr6207326f8f.19.1756371600241;
        Thu, 28 Aug 2025 02:00:00 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:c100:2225:10aa:f247:7b85? (p200300d82f28c100222510aaf2477b85.dip0.t-ipconnect.de. [2003:d8:2f28:c100:2225:10aa:f247:7b85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cc50050c4esm7308849f8f.25.2025.08.28.01.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 01:59:59 -0700 (PDT)
Message-ID: <8a0e1bb1-ab6f-4ba0-952f-e540ac5bd55d@redhat.com>
Date: Thu, 28 Aug 2025 10:59:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm/memory-failure: fix
 VM_BUG_ON_PAGE(PagePoisoned(page)) when unpoison memory
To: Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc: nao.horiguchi@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250828024618.1744895-1-linmiaohe@huawei.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250828024618.1744895-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.08.25 04:46, Miaohe Lin wrote:
> When I did memory failure tests, below panic occurs:
> 
> page dumped because: VM_BUG_ON_PAGE(PagePoisoned(page))
> kernel BUG at include/linux/page-flags.h:616!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 3 PID: 720 Comm: bash Not tainted 6.10.0-rc1-00195-g148743902568 #40
> RIP: 0010:unpoison_memory+0x2f3/0x590
> RSP: 0018:ffffa57fc8787d60 EFLAGS: 00000246
> RAX: 0000000000000037 RBX: 0000000000000009 RCX: ffff9be25fcdc9c8
> RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff9be25fcdc9c0
> RBP: 0000000000300000 R08: ffffffffb4956f88 R09: 0000000000009ffb
> R10: 0000000000000284 R11: ffffffffb4926fa0 R12: ffffe6b00c000000
> R13: ffff9bdb453dfd00 R14: 0000000000000000 R15: fffffffffffffffe
> FS:  00007f08f04e4740(0000) GS:ffff9be25fcc0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000564787a30410 CR3: 000000010d4e2000 CR4: 00000000000006f0
> Call Trace:
>   <TASK>
>   unpoison_memory+0x2f3/0x590
>   simple_attr_write_xsigned.constprop.0.isra.0+0xb3/0x110
>   debugfs_attr_write+0x42/0x60
>   full_proxy_write+0x5b/0x80
>   vfs_write+0xd5/0x540
>   ksys_write+0x64/0xe0
>   do_syscall_64+0xb9/0x1d0
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f08f0314887
> RSP: 002b:00007ffece710078 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 00007f08f0314887
> RDX: 0000000000000009 RSI: 0000564787a30410 RDI: 0000000000000001
> RBP: 0000564787a30410 R08: 000000000000fefe R09: 000000007fffffff
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000009
> R13: 00007f08f041b780 R14: 00007f08f0417600 R15: 00007f08f0416a00
>   </TASK>
> Modules linked in: hwpoison_inject
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:unpoison_memory+0x2f3/0x590
> RSP: 0018:ffffa57fc8787d60 EFLAGS: 00000246
> RAX: 0000000000000037 RBX: 0000000000000009 RCX: ffff9be25fcdc9c8
> RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff9be25fcdc9c0
> RBP: 0000000000300000 R08: ffffffffb4956f88 R09: 0000000000009ffb
> R10: 0000000000000284 R11: ffffffffb4926fa0 R12: ffffe6b00c000000
> R13: ffff9bdb453dfd00 R14: 0000000000000000 R15: fffffffffffffffe
> FS:  00007f08f04e4740(0000) GS:ffff9be25fcc0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000564787a30410 CR3: 000000010d4e2000 CR4: 00000000000006f0
> Kernel panic - not syncing: Fatal exception
> Kernel Offset: 0x31c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> ---[ end Kernel panic - not syncing: Fatal exception ]---
> 
> The root cause is that unpoison_memory() tries to check the PG_HWPoison
> flags of an uninitialized page. So VM_BUG_ON_PAGE(PagePoisoned(page)) is
> triggered. This can be reproduced by below steps:
> 1.Offline memory block:
>   echo offline > /sys/devices/system/memory/memory12/state
> 2.Get offlined memory pfn:
>   page-types -b n -rlN
> 3.Write pfn to unpoison-pfn
>   echo <pfn> > /sys/kernel/debug/hwpoison/unpoison-pfn
> 
> This scene can be identified by pfn_to_online_page() returning NULL.
> And ZONE_DEVICE pages are never expected, so we can simply fail if
> pfn_to_online_page() == NULL to fix the bug.
> 
> Fixes: f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded memory to zones until online")
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


