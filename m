Return-Path: <linux-kernel+bounces-734036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EF2B07C36
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30F5F7AA331
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228852F273C;
	Wed, 16 Jul 2025 17:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLuYNTDw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9F01DE2C9
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 17:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752687699; cv=none; b=F+Ly0EvpOsU4uo2iyRXbyGeiZgnwVVzGQgPFsOCcrl4vxMeX6ct8lkIbgVQIyA/fqdvxxCLF+tgGpGn4AoBGbPD/vkf/ff/wfn99OuIETkYFYFFqORUpKuI+2hpBx8pzj6bea8xRyLbI34aZw2RDRcBoC3asLFg8VKQsRRvT6U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752687699; c=relaxed/simple;
	bh=4U2Oh5j6+1l+8llmBUYo0pFXjVIBf9uuk67jGHlOark=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=noXndb+4SHY4xhwz39wi5seM+DgbC4LONPG/VWLPqcLss3r69ohip2s9P0KwsF3Bi95tKt+olrc2uMQNJuQVwrxkgEqJd51JFbyCz6vYXgc1+P1R/wcpBVfq4gF2I/mqzR2Tg/00LoWSvD3/61hLTu7TTqmTPLLl8M3wpLyqULw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aLuYNTDw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752687693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gz0sK/5v9SZNPL4ZcHETgu2NgiRODS/MSlGwinGMW78=;
	b=aLuYNTDwdbzG6lTII5glNMWwXp3gjeEIXW0QmvQxBBv12CydNbcN1wUHUAqPdPtgEiNVi6
	1x9xmGREQKsU+8JhkcDUVY9zXZ5Kgs1iesgJcRR+6Sw6nHZbUq7heic4+3CN/BG4I1p+tM
	vGzOH/iBuyRdsEpD5vkxbfv7GOVg5hE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-6m5nDh_LPbWe9dd8fCUY7w-1; Wed, 16 Jul 2025 13:41:31 -0400
X-MC-Unique: 6m5nDh_LPbWe9dd8fCUY7w-1
X-Mimecast-MFC-AGG-ID: 6m5nDh_LPbWe9dd8fCUY7w_1752687691
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab99d1a223so2647071cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752687691; x=1753292491;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gz0sK/5v9SZNPL4ZcHETgu2NgiRODS/MSlGwinGMW78=;
        b=FrJTuUiDMiaDyIsix97BKA4xIiUxsYwJXFfpBrj9qPY31PLmzJngjNL+nWYXZj+l1f
         Yx8vYuZ7elJEG0xHdwOUbDWxjTTJx9XMg4j1j1Yq3RexpuiWDgnsy4idsjIxFe9T7kwx
         PSd0lTuYT7hvfcfyk3uZtuhRL7OgJEjsiTPCs2CBzkjesM+/M8vPhLjViNK75hCVTq9+
         5A3+i98QJUcfvg3lcb6HQzH5mewrd+ezZHkKnLlW9ggtx+UeB/6sQlSBH+u8mJNpkIeU
         4xXCFAjb+uOE22KZL3ChE2BAxNSzBlv5qgOIu7TMp8AhFS24/ZAzafh634TCfmbeQXdu
         OnXA==
X-Gm-Message-State: AOJu0Yz32J5dxIkRMIM0/oUK7hA9/XUjwdncHzBbdF6lWpjhYhGHEjKu
	8CkhICbvO9HhVcIdU13J61olksX8GCd3V+7VkJHi7WbENO6pTcZTzYH2vriwSLdmpXTegfutgKf
	SDLZ/vvkI9QZkDE8epRkcF3jsvHjj+a+Vgm1FNcrs4q8ejmxeoYvawvN0Z04NFU6eTQ==
X-Gm-Gg: ASbGnct5kXhcCI9lKtUHKpq55srbVvtR0C/Cx3eWw9YKWeYMUbVmJQrqGmAr/2sVhVS
	M38bJT8igcaBcrW3NJ7H2tfnUi/BdBKDaDLxcFjl9O2wjpMyIMzC4lP3j2FkQD8oogdt096jsxt
	BdOUb8V1kXahQE0iMS1+sojVdOaTmItc/a8OToPpGad5I/yhiRw8OghSRKhXGuk8yxlFYxMtrVS
	D9/7iA9Oj6+Mcik7mBGz8kBj4MednnVr4bXuB8qY+t6AcDqtb6M7DYGlCpIc0LI4Zz4JGEzXlzs
	q1wLQwgpAco6dgkSTFNpB8dwZ3O63j4y6UrIiLjJKzTNw9KbGhN6VM2FjWu1m1aevmv3GDAzpta
	gzC7aKzfYl10POKLEQpBpy+4SQrw=
X-Received: by 2002:a05:622a:5a8c:b0:4ab:9586:bdd7 with SMTP id d75a77b69052e-4ab9586c4b7mr46458741cf.54.1752687691185;
        Wed, 16 Jul 2025 10:41:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwFG92bZhz3XcuCPtvH+cLYhqDTsLqOnZ1eUKRT/LVywceMAdoG9EQQQ3i3wdnFWaFOVESTQ==
X-Received: by 2002:a05:622a:5a8c:b0:4ab:9586:bdd7 with SMTP id d75a77b69052e-4ab9586c4b7mr46458171cf.54.1752687690487;
        Wed, 16 Jul 2025 10:41:30 -0700 (PDT)
Received: from [192.168.2.110] (bras-base-aylmpq0104w-grc-59-70-29-229-84.dsl.bell.ca. [70.29.229.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab6a00c48fsm37096711cf.10.2025.07.16.10.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 10:41:30 -0700 (PDT)
Message-ID: <16a6a7c6-518a-4558-a8aa-698e24f2e189@redhat.com>
Date: Wed, 16 Jul 2025 13:41:20 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] proc: kpagecount: use snapshot_page()
To: David Hildenbrand <david@redhat.com>, willy@infradead.org,
 akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, shivankg@amd.com,
 sj@kernel.org, harry.yoo@oracle.com
References: <cover.1752499009.git.luizcap@redhat.com>
 <1c05cc725b90962d56323ff2e28e9cc3ae397b68.1752499009.git.luizcap@redhat.com>
 <af63e731-d08b-4557-89c4-ae48f7545943@redhat.com>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <af63e731-d08b-4557-89c4-ae48f7545943@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-07-16 06:17, David Hildenbrand wrote:
> On 14.07.25 15:16, Luiz Capitulino wrote:
>> Currently, the call to folio_precise_page_mapcount() from kpage_read()
>> can race with a folio split. When the race happens we trigger a
>> VM_BUG_ON_FOLIO() in folio_entire_mapcount() (see splat below).
>>
>> This commit fixes this race by using snapshot_page() so that we
>> retrieve the folio mapcount using a folio snapshot.
>>
>> [ 2356.558576] page: refcount:1 mapcount:1 mapping:0000000000000000 index:0xffff85200 pfn:0x6f7c00
>> [ 2356.558748] memcg:ffff000651775780
>> [ 2356.558763] anon flags: 0xafffff60020838(uptodate|dirty|lru|owner_2|swapbacked|node=1|zone=2|lastcpupid=0xfffff)
>> [ 2356.558796] raw: 00afffff60020838 fffffdffdb5d0048 fffffdffdadf7fc8 ffff00064c1629c1
>> [ 2356.558817] raw: 0000000ffff85200 0000000000000000 0000000100000000 ffff000651775780
>> [ 2356.558839] page dumped because: VM_BUG_ON_FOLIO(!folio_test_large(folio))
>> [ 2356.558882] ------------[ cut here ]------------
>> [ 2356.558897] kernel BUG at ./include/linux/mm.h:1103!
>> [ 2356.558982] Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
>> [ 2356.564729] CPU: 8 UID: 0 PID: 1864 Comm: folio-split-rac Tainted: G S      W           6.15.0+ #3 PREEMPT(voluntary)
>> [ 2356.566196] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
>> [ 2356.566814] Hardware name: Red Hat KVM, BIOS edk2-20241117-3.el9 11/17/2024
>> [ 2356.567684] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [ 2356.568563] pc : kpage_read.constprop.0+0x26c/0x290
>> [ 2356.569605] lr : kpage_read.constprop.0+0x26c/0x290
>> [ 2356.569992] sp : ffff80008fb739b0
>> [ 2356.570263] x29: ffff80008fb739b0 x28: ffff00064aa69580 x27: 00000000ff000000
>> [ 2356.570842] x26: 0000fffffffffff8 x25: ffff00064aa69580 x24: ffff80008fb73ae0
>> [ 2356.571411] x23: 0000000000000001 x22: 0000ffff86c6e8b8 x21: 0000000000000008
>> [ 2356.571978] x20: 00000000006f7c00 x19: 0000ffff86c6e8b8 x18: 0000000000000000
>> [ 2356.572581] x17: 3630303066666666 x16: 0000000000000003 x15: 0000000000001000
>> [ 2356.573217] x14: 00000000ffffffff x13: 0000000000000004 x12: 00aaaaaa00aaaaaa
>> [ 2356.577674] x11: 0000000000000000 x10: 00aaaaaa00aaaaaa x9 : ffffbf3afca6c300
>> [ 2356.578332] x8 : 0000000000000002 x7 : 0000000000000001 x6 : 0000000000000001
>> [ 2356.578984] x5 : ffff000c79812408 x4 : 0000000000000000 x3 : 0000000000000000
>> [ 2356.579635] x2 : 0000000000000000 x1 : ffff00064aa69580 x0 : 000000000000003e
>> [ 2356.580286] Call trace:
>> [ 2356.580524]  kpage_read.constprop.0+0x26c/0x290 (P)
>> [ 2356.580982]  kpagecount_read+0x28/0x40
>> [ 2356.581336]  proc_reg_read+0x38/0x100
>> [ 2356.581681]  vfs_read+0xcc/0x320
>> [ 2356.581992]  ksys_read+0x74/0x118
>> [ 2356.582306]  __arm64_sys_read+0x24/0x38
>> [ 2356.582668]  invoke_syscall+0x70/0x100
>> [ 2356.583022]  el0_svc_common.constprop.0+0x48/0xf8
>> [ 2356.583456]  do_el0_svc+0x28/0x40
>> [ 2356.583930]  el0_svc+0x38/0x118
>> [ 2356.584328]  el0t_64_sync_handler+0x144/0x168
>> [ 2356.584883]  el0t_64_sync+0x19c/0x1a0
>> [ 2356.585350] Code: aa0103e0 9003a541 91082021 97f813fc (d4210000)
>> [ 2356.586130] ---[ end trace 0000000000000000 ]---
>> [ 2356.587377] note: folio-split-rac[1864] exited with irqs disabled
>> [ 2356.588050] note: folio-split-rac[1864] exited with preempt_count 1
>>
>> Reported-by: syzbot+3d7dc5eaba6b932f8535@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/all/67812fbd.050a0220.d0267.0030.GAE@google.com/
>> Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
>> ---
>>   fs/proc/page.c | 21 +++++++++++++++++----
>>   1 file changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/proc/page.c b/fs/proc/page.c
>> index 999af26c7298..936f8bbe5a6f 100644
>> --- a/fs/proc/page.c
>> +++ b/fs/proc/page.c
>> @@ -43,6 +43,22 @@ static inline unsigned long get_max_dump_pfn(void)
>>   #endif
>>   }
>> +static u64 get_kpage_count(const struct page *page)
>> +{
>> +    struct page_snapshot ps;
>> +    u64 ret;
>> +
>> +    snapshot_page(&ps, page);
> 
> Curious, if the snapshot is not faithful, maybe we simply want to return 0 or sth. like that?

I chose the flag because it's not exactly that the snapshot failed as it
tries to return something. But it's not a big deal to return failure
instead.

> 
> In any case
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 


