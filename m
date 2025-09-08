Return-Path: <linux-kernel+bounces-805862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C247B48E84
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 349CC1883D70
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE972307AFC;
	Mon,  8 Sep 2025 13:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="e6LZlfYV"
Received: from smtp153-165.sina.com.cn (smtp153-165.sina.com.cn [61.135.153.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974BA12DDA1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 13:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757336640; cv=none; b=aQn5/j1zZYW/UZUIYPAyLNzxWWvms2B8v5ggu1wAJgligH2sk+vctfKx34V8rKGafF3WCs4lPjlxTEaT+N3IHqmnleO+ky7dmmPqIj9JUlBxEkfH2u1MgpKPAQdyL3gD/lVwEy2F6X1XicDEDua17ycOIr1shUXZnAF0Zsomx0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757336640; c=relaxed/simple;
	bh=d0EszQpJE6gAdN9Ihx9jMPY5A+jVDaOLs+dRF4mke6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sgt3T2w5vRvvf4Ro6RuoEsF44F+NZs41Oxq2mvbTwdWHF4x8DpGdatBiybrbok8hDbqS3KCmZYKbao3IAk80lIvJ9pXmckI5WdbjL9VYDr/ngdXRtvFEBeGnEbLoig8wv6GdriGFVUSUULWlkViqPyuGQdc04+K5KcXmlV4O4h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=e6LZlfYV; arc=none smtp.client-ip=61.135.153.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1757336633;
	bh=b7esB1XJNn+nodpKtUsgf1GD+n4bl86RWHbZIZQz81c=;
	h=From:Subject:Date:Message-ID;
	b=e6LZlfYVLHRQQaU+xfLVOsj8RN4Y9dERovYPAtJOf/oQY3tgYfkwVFKUxU+z/jgC3
	 /FEJ/aPiwv6zinipYuyFqA0mypylppTuXLueRWEUjSRTfsgn+MI651w8mHKyA0x+i8
	 zbsYqcZYgDu8+eWl1qaoG61MSY0DxIHX4nIZYFaU=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68BED41100004D02; Mon, 8 Sep 2025 21:03:15 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4560234456895
X-SMAIL-UIID: F0DE01F4424740A48DFDD88220311495-20250908-210315-1
From: Hillf Danton <hdanton@sina.com>
To: Eric Dumazet <edumazet@google.com>,
	Yu Kuai <yukuai1@huaweicloud.com>
Cc: syzbot <syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	thomas.hellstrom@linux.intel.com
Subject: Re: [syzbot] [net?] possible deadlock in inet_shutdown
Date: Mon,  8 Sep 2025 21:03:00 +0800
Message-ID: <20250908130303.6609-1-hdanton@sina.com>
In-Reply-To: <CANn89iKVbTKxgO=_47TU21b6GakhnRuBk2upGviCK0Y1Q2Ar2Q@mail.gmail.com>
References: <68bb4160.050a0220.192772.0198.GAE@google.com> <CANn89iLNFHBMTF2Pb6hHERYpuih9eQZb6A12+ndzBcQs_kZoBA@mail.gmail.com> <CANn89iJaY+MJPUJgtowZOPwHaf8ToNVxEyFN9U+Csw9+eB7YHg@mail.gmail.com> <c035df1c-abaf-9173-032f-3dd91b296101@huaweicloud.com> <CANn89iKVbTKxgO=_47TU21b6GakhnRuBk2upGviCK0Y1Q2Ar2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

在 2025/09/08 17:07, Eric Dumazet 写道:
> On Mon, Sep 8, 2025 at 1:52 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>> 在 2025/09/06 17:16, Eric Dumazet 写道:
>>> On Fri, Sep 5, 2025 at 1:03 PM Eric Dumazet <edumazet@google.com> wrote:
>>>> On Fri, Sep 5, 2025 at 1:00 PM syzbot
>>>> <syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com> wrote:
>>>
>>> Note to NBD maintainers : I held about  20 syzbot reports all pointing
>>> to NBD accepting various sockets, I  can release them if needed, if you prefer
>>> to triage them.
>>>
>> I'm not NBD maintainer, just trying to understand the deadlock first.
>>
>> Is this deadlock only possible for some sepecific socket types? Take
>> a look at the report here:
>>
>> Usually issue IO will require the order:
>>
>> q_usage_counter -> cmd lock -> tx lock -> sk lock
>>
> 
> I have not seen the deadlock being reported with normal TCP sockets.
> 
> NBD sets sk->sk_allocation to  GFP_NOIO | __GFP_MEMALLOC;
> from __sock_xmit(), and TCP seems to respect this.
>
Only if ffa1e7ada45 is missed, given the __correct__ locking order
enforced in ffa1e7ada45 ("block: Make request_queue lockdep splats
show up earlier"), GFP_NOIO does not help to cure any case that
reverses that order, while __GFP_MEMALLOC looks like a paperover,
at least because __GFP_MEMALLOC does not match lock_sock().

-> #0 (sk_lock-AF_INET6){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       lock_sock_nested+0x48/0x100 net/core/sock.c:3733
       lock_sock include/net/sock.h:1667 [inline]
       inet_shutdown+0x6a/0x390 net/ipv4/af_inet.c:905
       nbd_mark_nsock_dead+0x2e9/0x560 drivers/block/nbd.c:318
       nbd_send_cmd+0x11ec/0x1ba0 drivers/block/nbd.c:799
       nbd_handle_cmd drivers/block/nbd.c:1174 [inline]
       nbd_queue_rq+0xcdb/0xf10 drivers/block/nbd.c:1204

