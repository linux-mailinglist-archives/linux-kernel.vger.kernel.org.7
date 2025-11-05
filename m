Return-Path: <linux-kernel+bounces-887021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2687BC3717D
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53EA62744E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC45320CA3;
	Wed,  5 Nov 2025 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pFgwB4kY"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C362571A1
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762362901; cv=none; b=jP0NCE3/60z77tXplsen5kazTgX/krr9XlnHOlUVcC2Wc8sMONoWdSwAog/hcV1UFY0VjT2x5gggWWEwiCnZDv7HG+nxn6YMCMNVzF92JwXvWtFUMallV8dj+e1BdW019f9txJTsiCIOf2iTO9hKA4yJHbGHp/uSnBm2ICleedI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762362901; c=relaxed/simple;
	bh=17/R1DXTiowNeyp2ZqS40o7QRfjhMT9LH+O6OTTLRks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooWPvJGMJvv6UCtRqguaiwplpSo4vp/sNh9IgrlX3iEMaiE21O4XEqLiLZSAkiDuwjTh6OPXEh8dUl7oFwjCeMLs9sWPpOKReB62cZ1/2OuCqIQviXu7ZfVh544LMDHiInYcNAQI0sX39art+hv5dU7mfinpJtQCFYhK8KDvoEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pFgwB4kY; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b2148ca40eso5679185a.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762362898; x=1762967698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2G0KojyqghlZdLwZSzfyvK2C92Ii5Ek3WzjqkkuY1IE=;
        b=pFgwB4kYERam4Nt7oQSP6jv7nWGl4slvf6Yf5ERQ1j+v/0zCPhaC+kOgfy2br/8V2U
         736O8jY8kJ5Mt4w9r6I8fDUc1fd7crjpeD3Bx9w4QeiVJRdPnfW6c8VsEEZlEzpWu9i/
         HbIwE5coQna764qrxiLzttZ+DQF/LdcCUoAQKvKHCqKBEYKa2/UoAVnxS2VfTEMztxXh
         QjAzOle0ZHNiV8JzaVye+VqY/08d4VSDOmOunqBjZBiD94LVvVzGSf0Z6GkRgGWX86rL
         79b9cZS9IYaoBriRH1AQKFyN2dYO5V5KudcbjMR0hmeYkWqK1g8PDTaDotJekC4+ql40
         2h/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762362898; x=1762967698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2G0KojyqghlZdLwZSzfyvK2C92Ii5Ek3WzjqkkuY1IE=;
        b=oPJyYX/LA8by0X+xsU8T4GW0djxt4RT7PoOKJP3Bp444ABP6MsRj9EkBjuqT7jY6SJ
         3bt4+XABLf5xXrmdH1ScxeOP8JRHLF5shMJRAPT4HVZUhBvgpQXbkNrlJdpKzfBY7l/x
         92EmQ//7NZfIxpi2YnYZjvOvQwPdE79ClG4qMPihUCXb61/kEFQWbWBMevm3BRRTJGPJ
         H9uIW/7YQpnrde6LVp2NtE+FOdK5T38zNEDW/6jJHMg44IZfVKq9XCee7ywMjeI+Hco0
         9Q74m6RRaEbRrNphbT34rT8RZuxUvg/EYdylWNOvAygdhoHxReq1Vl7Ymdx6Yk6vl1hV
         UUog==
X-Forwarded-Encrypted: i=1; AJvYcCXwiKTd5PTJoevnDNaTBAgSCXIfMxwSSFtPQ8utuJaCVIDg7gyM7iZggfDywMT4UtaJgy/GUShvXLAmOaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhBcn1/0un5wBKKOuerSVqewbpL9SRnd41G07W+VWFbAZBlozM
	AVMrwFijqiVRdpDZUp3CVrfHoqB920RdQdr2+mJPBkQHQeksm3w8GMtHd+g2B0sY42+7rBRUu9K
	o9Oqx
X-Gm-Gg: ASbGncvE+fFoa8nGWtptrphCzZLONFn+0BLAjGi7CcCt7CqqmyDqs6DsTdWQEl6UA5d
	XpXcnpuMw9urxyVldZBcJw+jBGqnlJd+MV45cXd8PTNyx/4D6VYZo6URj85lA7ktWpuUbewTn/a
	WYZy0r78d3RJMUsGjzbUhp+W9cB/9qIymwvgV70EBPTs1MpZzClpZcrNSkLe2p1OrozamV7vdCc
	ljYE1zrqvWq+VcRLcNl1vEiZksEKQGdmjF8NYBt/4yuzc6Of1M5qhhFQM9MRjyyheUnAuRAQwE8
	ksm9MP4G9/SFxx1+/BbtJUcc/BwVwETW9qRhFNBQ1vXm9QjsdLQuMebnU+UqBZ4rY8uIw2SW4LV
	P6mlnNqeeH+f+yovfh23ZFG8b5Fqm8m3LiSJcUqWHyRnRnEmPpIEXAzxXc3Q3Wb5Bi4DPLZgV0a
	Cj2BKr6/v5/aeGWrmuHTN/A4FEbjCaCLfm1Eo0lz7sUWlS0Q==
X-Google-Smtp-Source: AGHT+IGz+gu1rdUbR+08P8Owh2JzHMCMyTsb5lYzBpBwcoY3Rc4F8rsWRJjZ+e+QKXf2W/IeYg2ZJQ==
X-Received: by 2002:a05:620a:7008:b0:890:492:cbc1 with SMTP id af79cd13be357-8b220b99c9cmr536718185a.67.1762362898189;
        Wed, 05 Nov 2025 09:14:58 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b23582b0c9sm2603585a.55.2025.11.05.09.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:14:57 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vGh61-00000007BsU-0tSD;
	Wed, 05 Nov 2025 13:14:57 -0400
Date: Wed, 5 Nov 2025 13:14:57 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
Cc: leon@kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, yanjun.zhu@linux.dev
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
Message-ID: <20251105171457.GO1204670@ziepe.ca>
References: <185e135e-0e17-4ef8-91a2-15e69897cd01@linux.dev>
 <690b83fc.050a0220.3d0d33.006c.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <690b83fc.050a0220.3d0d33.006c.GAE@google.com>

On Wed, Nov 05, 2025 at 09:06:04AM -0800, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> WARNING in gid_table_release_one
> 
> ------------[ cut here ]------------
> GID entry ref leak for dev syz1 index 2 ref=363, state: 3
> WARNING: CPU: 1 PID: 50 at drivers/infiniband/core/cache.c:827 release_gid_table drivers/infiniband/core/cache.c:824 [inline]
> WARNING: CPU: 1 PID: 50 at drivers/infiniband/core/cache.c:827 gid_table_release_one+0x5ae/0x6c0 drivers/infiniband/core/cache.c:904
> Modules linked in:
> CPU: 1 UID: 0 PID: 50 Comm: kworker/u8:3 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
> Workqueue: ib-unreg-wq ib_unregister_work
> RIP: 0010:release_gid_table drivers/infiniband/core/cache.c:824 [inline]
> RIP: 0010:gid_table_release_one+0x5ae/0x6c0 drivers/infiniband/core/cache.c:904
> Code: e8 03 0f b6 04 28 84 c0 0f 85 cc 00 00 00 44 8b 03 48 c7 c7 60 7c 2b 8c 48 8b 74 24 28 44 89 fa 8b 4c 24 50 e8 73 e7 35 f9 90 <0f> 0b 90 90 44 8b 74 24 04 4c 8b 7c 24 20 4c 8b 64 24 48 e9 15 fe
> RSP: 0018:ffffc90000bb78f8 EFLAGS: 00010246
> RAX: 124fa0acf3bf2700 RBX: ffff8880268c1990 RCX: ffff888020289e40
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
> RBP: dffffc0000000000 R08: 0000000000000003 R09: 0000000000000004
> R10: dffffc0000000000 R11: fffffbfff1b7a678 R12: ffff88802ed4e2d8
> R13: 00000000000001a8 R14: ffff88806a158010 R15: 0000000000000002
> FS:  0000000000000000(0000) GS:ffff88812646a000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005555712ce808 CR3: 000000006b6c8000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  ib_device_release+0xd2/0x1c0 drivers/infiniband/core/device.c:509
>  device_release+0x9c/0x1c0 drivers/base/core.c:-1
>  kobject_cleanup lib/kobject.c:689 [inline]
>  kobject_release lib/kobject.c:720 [inline]
>  kref_put include/linux/kref.h:65 [inline]
>  kobject_put+0x22b/0x480 lib/kobject.c:737
>  process_one_work kernel/workqueue.c:3263 [inline]
>  process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
>  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
>  kthread+0x711/0x8a0 kernel/kthread.c:463
>  ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> 
> 
> Tested on:
> 
> commit:         ad2cc78b RDMA/core: Fix WARNING in gid_table_release_one
> git tree:       https://github.com/zhuyj/linux.git v6.17_fix_gid_table_release_one
> console output: https://syzkaller.appspot.com/x/log.txt?x=11dfa17c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2c614fa9e6f5bdc1
> dashboard link: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

I think this disproves the theory that the the gid is sitting in a
work queue waiting to be cleaned up..

So we still need to find out what is holding on to the reference...

Jason

