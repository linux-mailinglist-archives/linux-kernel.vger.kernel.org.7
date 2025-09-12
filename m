Return-Path: <linux-kernel+bounces-814686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F6AB5574E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 22:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF5E16F0EB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 20:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8B229AB12;
	Fri, 12 Sep 2025 20:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b5GjGF39"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4214318FC97
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 20:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757707290; cv=none; b=ZYSOFjQn3+LtYCVPA2HOX4QxFLIQHuROG4NwuLVqIvKJcJj/TNG/GNnzc3fiIZi6RYLR7Yel7ROBM4GgtDLmg4+6spSVjL78EBafQZ/ziWBdQ5XXdGBTCM1g8jacY7f+Z57oc1W4/EuU3ckVO7uBzj31txhv5Gc8JJYlAbo7fUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757707290; c=relaxed/simple;
	bh=2tUKl+8kzS9h12P8LQQ2md4UQEjQWSngkh1BZ76TGlU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=CZ5+wD0CEmBn4xQVotRmKIe0MXKhYUm9myyNz5r65RuFlcnkXKKoVOlcFKt7tS5zON+41jAIkYSX9vQxa9TIA6BmtYnzCeJOwe5Ol2KAwNCs4OqNEnLas2e4v2yD15isQpJV8yFlCV8LVLJCL6vDU1Q+JfsA1LO/oj9JtZbB2As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b5GjGF39; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <691d3ecd-7960-46bb-b41e-be223e320d33@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757707279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hteSQ5La1a1bnjrdYMX9ISKonmrqjcqnGCeh/pREnv4=;
	b=b5GjGF39cCzB8ZzlBCuOdwy71z2ykNjKiiPKPkYzf1A/xvQZfYojHT9loWLTMdFvoSWP4f
	Dvl6LYX7lrqRlEpFeFtO0l0cDApobx7EkXuRoDwPDIFUHNbNgbETuo/UkejNi9CODGWwLO
	suC8CfLbfOjEW4MTKLfGjfZ+NTQAEik=
Date: Fri, 12 Sep 2025 13:01:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
To: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>,
 edwards@nvidia.com, hdanton@sina.com, jgg@ziepe.ca, leon@kernel.org,
 leonro@nvidia.com, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <68c3a49a.a70a0220.3543fc.0031.GAE@google.com>
 <6f3b9149-2a2d-4532-b38f-946b98e72000@linux.dev>
Content-Language: en-US
In-Reply-To: <6f3b9149-2a2d-4532-b38f-946b98e72000@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 9/12/25 12:38 PM, yanjun.zhu wrote:
> On 9/11/25 9:42 PM, syzbot wrote:
>> syzbot has bisected this issue to:
>>
>> commit a92fbeac7e94a420b55570c10fe1b90e64da4025
>> Author: Leon Romanovsky <leonro@nvidia.com>
>> Date:   Tue May 28 12:52:51 2024 +0000
>>
>>      RDMA/cache: Release GID table even if leak is detected
> 
> Maybe this commit just detects ref leaks and reports ref leak.
> Even though this commit is reverted, this ref leak still occurs.
> 
> The root cause is not in this commit.
> 
> "
> GID entry ref leak for dev syz1 index 2 ref=615
> "
> 
> Ref leaks in dev syz1.
In this link: https://syzkaller.appspot.com/x/log.txt?x=157dab12580000

"
[  184.209420][ T6164] infiniband syz1: set active
[  184.215960][ T6164] infiniband syz1: added syz_tun
[  184.222514][ T6001] veth0_macvtap: entered promiscuous mode
[  184.231935][   T42] wlan0: Created IBSS using preconfigured BSSID 
50:50:50:50:50:50
[  184.239777][   T42] wlan0: Creating new IBSS network, BSSID 
50:50:50:50:50:50
[  184.256962][ T6001] veth1_macvtap: entered promiscuous mode
[  184.276479][ T6164] syz1: rxe_create_cq: returned err = -12 < -- 
rxe_create_cq failed, the test should not continue.

[  184.288430][ T6008] veth0_vlan: entered promiscuous mode
"

err = -12, is -ENOMEM.

It means that memory allocation fails.

Zhu Yanjun

> 
> Zhu Yanjun
> 
>>
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt? 
>> x=13fc9642580000
>> start commit:   5f540c4aade9 Add linux-next specific files for 20250910
>> git tree:       linux-next
>> final oops:     https://syzkaller.appspot.com/x/report.txt? 
>> x=10029642580000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=17fc9642580000
>> kernel config:  https://syzkaller.appspot.com/x/.config? 
>> x=5ed48faa2cb8510d
>> dashboard link: https://syzkaller.appspot.com/bug? 
>> extid=b0da83a6c0e2e2bddbd4
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz? 
>> x=15b52362580000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b41642580000
>>
>> Reported-by: syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com
>> Fixes: a92fbeac7e94 ("RDMA/cache: Release GID table even if leak is 
>> detected")
>>
>> For information about bisection process see: https://goo.gl/ 
>> tpsmEJ#bisection
> 


