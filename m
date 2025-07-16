Return-Path: <linux-kernel+bounces-733319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5BDB07323
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB7518838C9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836322F3655;
	Wed, 16 Jul 2025 10:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iSI+KC0g"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772EC2F2376
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661084; cv=none; b=J0Qp7kBEkrWTWhM2s1dK47kZx/Fp7DeG1u3ofhnEEaZoC+ssB+OkSRRHhnYxNqip8Y15d84JWeLzqSusPHnZOCpkbydcbhB4yajrmcwMivprhKtXNH0zva9e7Kyi3/qgFhnW+kDYVnojooUYzpcVnyLxKPdtWAA+Ofal5dV5v30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661084; c=relaxed/simple;
	bh=+BCYy39AMqDzITOXNSdgjp3a5gMUSkDRbIjVq17oaME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ckZa3Xlr5Y0UOxkR94eCx7H4w3bLmfnl/VxqID3tUo5v5ohU7yfoYBln4NbtbPzmwVMNfCsg1xNjgdAFZcOCFBv4L+xo4MJcXE27EAij7y0Ib3dK68UZ1cHRzkLJDGrsRoRRnFjtqu22DisHPaqokMRYBuD9zKI0YcKpO8OFOso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iSI+KC0g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752661081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YsseQyL5Dd2+9JOaCaQgdNo4nNbYGDsqRx5aE6mZR5s=;
	b=iSI+KC0gLa/txwF+9ddl4OiOV6f8uiVx20yKdGp+9yTLxAIhD0QcJNvnJQE1EQKWE2CGdI
	JNMzfzU7IUpvzOUyQExcjOX1fhJgVSfZxapIEuF+93jqSP1bdUPZ+WpDg1u36hSZyoWx8f
	Ze5+iBSHz/VH0Hh8qYJx8Q8Sg7+ljB4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-9VQ3nRyHPJe1PALDZLKOFw-1; Wed, 16 Jul 2025 06:18:00 -0400
X-MC-Unique: 9VQ3nRyHPJe1PALDZLKOFw-1
X-Mimecast-MFC-AGG-ID: 9VQ3nRyHPJe1PALDZLKOFw_1752661079
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f6ba526eso3515390f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752661079; x=1753265879;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YsseQyL5Dd2+9JOaCaQgdNo4nNbYGDsqRx5aE6mZR5s=;
        b=NjDjep/FoX0XERN0YsiqNGjVRmBfXitNEuG6i14OrX6O9tKRMats4f1+wWOwOnu30C
         bHTUFgraVaRkIGj5lcvjhVviNh3nrLOSGxLF42/GFWrM0anr5cLlT56PsskGlj5J2PVY
         JbLHgB8D1rbVg/z7cqGFY7memfrMa48LZFEaXUYk4RFxRXNW4JJ4BidA9w3R84GevJBb
         R+gn6+AYbvldYPtFkRKen7048soVaRqJ0kbQjrYGdZBtSzwha2YM4GI9RxQXbcYk3QQJ
         8clVmgpO09PX85/bLWwTal0iP+2LRIJL9UykRjIqhRNyAd11v/J37yiMgDi+EWMM85I0
         qWhw==
X-Gm-Message-State: AOJu0Ywrbxz7AKGrb8PCjh+KqI9af8PhiJp/2CbBVaUarKClOIRpVOP4
	UiDVNY0wBdzX1SqaVGsGPM7djV1H5eHF9/nHPpyjG5LizH+/eLJ8fpaa/IqQ9QIc7vQ/OjlX8MO
	5r6jLf8G6ExMuOgLc/n8zrTxu9Zg4dwnuzQibdFcxFZvft3P42vQ35vt4MN4jbwh5Kw==
X-Gm-Gg: ASbGncuTZJoLZOuDhjpUEqF0ZSLKLaBdPwNpSCODmc/XfAWbyEl8lZQJru+uF784i7t
	vzGKbLA9NFAtz+4JyYFaEqnx+8AdiiLmLUyfetFHmRoOn6hgCEIwrazg69E99i18j0e7B0+/79M
	pvWhus3Y+C6QHoshjx8O/HztqY2PE20ndAErj9c4CDrMvz3RIx7pQxrFqvdyYz974fFRzGeh5RF
	IPOlCWR7SETw/N1KO6OiUQBKoAw7G3C8fjZrwGs/Ro8L1AnCef35zPT8c1KaIAC2dZWw7LwHhDF
	awSLC3lxG6wkyZf9x31Jdpmkx576fDBWqgF7xj/t5SylEHXs1vKoF7rIEPHLOykgRVfqnr/iygq
	6TbRHdoyk9pggELvQybEkTvT7l5hQqobtvy+atfHQQlqmOiOiHtBkHjim1geY3BC1yFg=
X-Received: by 2002:a05:6000:2507:b0:3a5:2cf3:d6ab with SMTP id ffacd0b85a97d-3b60e518456mr1757053f8f.39.1752661078705;
        Wed, 16 Jul 2025 03:17:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcIjq6zIO/gkSy7gzh0GKTNEgsx/xu2oJMLtckw/u72G5qCwoltWW+38N9T7JRkvurAUbazA==
X-Received: by 2002:a05:6000:2507:b0:3a5:2cf3:d6ab with SMTP id ffacd0b85a97d-3b60e518456mr1757019f8f.39.1752661078166;
        Wed, 16 Jul 2025 03:17:58 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:ed00:1769:dd7c:7208:eb33? (p200300d82f1ded001769dd7c7208eb33.dip0.t-ipconnect.de. [2003:d8:2f1d:ed00:1769:dd7c:7208:eb33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e89bfecsm16561425e9.27.2025.07.16.03.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 03:17:57 -0700 (PDT)
Message-ID: <af63e731-d08b-4557-89c4-ae48f7545943@redhat.com>
Date: Wed, 16 Jul 2025 12:17:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] proc: kpagecount: use snapshot_page()
To: Luiz Capitulino <luizcap@redhat.com>, willy@infradead.org,
 akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, shivankg@amd.com,
 sj@kernel.org, harry.yoo@oracle.com
References: <cover.1752499009.git.luizcap@redhat.com>
 <1c05cc725b90962d56323ff2e28e9cc3ae397b68.1752499009.git.luizcap@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <1c05cc725b90962d56323ff2e28e9cc3ae397b68.1752499009.git.luizcap@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.07.25 15:16, Luiz Capitulino wrote:
> Currently, the call to folio_precise_page_mapcount() from kpage_read()
> can race with a folio split. When the race happens we trigger a
> VM_BUG_ON_FOLIO() in folio_entire_mapcount() (see splat below).
> 
> This commit fixes this race by using snapshot_page() so that we
> retrieve the folio mapcount using a folio snapshot.
> 
> [ 2356.558576] page: refcount:1 mapcount:1 mapping:0000000000000000 index:0xffff85200 pfn:0x6f7c00
> [ 2356.558748] memcg:ffff000651775780
> [ 2356.558763] anon flags: 0xafffff60020838(uptodate|dirty|lru|owner_2|swapbacked|node=1|zone=2|lastcpupid=0xfffff)
> [ 2356.558796] raw: 00afffff60020838 fffffdffdb5d0048 fffffdffdadf7fc8 ffff00064c1629c1
> [ 2356.558817] raw: 0000000ffff85200 0000000000000000 0000000100000000 ffff000651775780
> [ 2356.558839] page dumped because: VM_BUG_ON_FOLIO(!folio_test_large(folio))
> [ 2356.558882] ------------[ cut here ]------------
> [ 2356.558897] kernel BUG at ./include/linux/mm.h:1103!
> [ 2356.558982] Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
> [ 2356.564729] CPU: 8 UID: 0 PID: 1864 Comm: folio-split-rac Tainted: G S      W           6.15.0+ #3 PREEMPT(voluntary)
> [ 2356.566196] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
> [ 2356.566814] Hardware name: Red Hat KVM, BIOS edk2-20241117-3.el9 11/17/2024
> [ 2356.567684] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [ 2356.568563] pc : kpage_read.constprop.0+0x26c/0x290
> [ 2356.569605] lr : kpage_read.constprop.0+0x26c/0x290
> [ 2356.569992] sp : ffff80008fb739b0
> [ 2356.570263] x29: ffff80008fb739b0 x28: ffff00064aa69580 x27: 00000000ff000000
> [ 2356.570842] x26: 0000fffffffffff8 x25: ffff00064aa69580 x24: ffff80008fb73ae0
> [ 2356.571411] x23: 0000000000000001 x22: 0000ffff86c6e8b8 x21: 0000000000000008
> [ 2356.571978] x20: 00000000006f7c00 x19: 0000ffff86c6e8b8 x18: 0000000000000000
> [ 2356.572581] x17: 3630303066666666 x16: 0000000000000003 x15: 0000000000001000
> [ 2356.573217] x14: 00000000ffffffff x13: 0000000000000004 x12: 00aaaaaa00aaaaaa
> [ 2356.577674] x11: 0000000000000000 x10: 00aaaaaa00aaaaaa x9 : ffffbf3afca6c300
> [ 2356.578332] x8 : 0000000000000002 x7 : 0000000000000001 x6 : 0000000000000001
> [ 2356.578984] x5 : ffff000c79812408 x4 : 0000000000000000 x3 : 0000000000000000
> [ 2356.579635] x2 : 0000000000000000 x1 : ffff00064aa69580 x0 : 000000000000003e
> [ 2356.580286] Call trace:
> [ 2356.580524]  kpage_read.constprop.0+0x26c/0x290 (P)
> [ 2356.580982]  kpagecount_read+0x28/0x40
> [ 2356.581336]  proc_reg_read+0x38/0x100
> [ 2356.581681]  vfs_read+0xcc/0x320
> [ 2356.581992]  ksys_read+0x74/0x118
> [ 2356.582306]  __arm64_sys_read+0x24/0x38
> [ 2356.582668]  invoke_syscall+0x70/0x100
> [ 2356.583022]  el0_svc_common.constprop.0+0x48/0xf8
> [ 2356.583456]  do_el0_svc+0x28/0x40
> [ 2356.583930]  el0_svc+0x38/0x118
> [ 2356.584328]  el0t_64_sync_handler+0x144/0x168
> [ 2356.584883]  el0t_64_sync+0x19c/0x1a0
> [ 2356.585350] Code: aa0103e0 9003a541 91082021 97f813fc (d4210000)
> [ 2356.586130] ---[ end trace 0000000000000000 ]---
> [ 2356.587377] note: folio-split-rac[1864] exited with irqs disabled
> [ 2356.588050] note: folio-split-rac[1864] exited with preempt_count 1
> 
> Reported-by: syzbot+3d7dc5eaba6b932f8535@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67812fbd.050a0220.d0267.0030.GAE@google.com/
> Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
> ---
>   fs/proc/page.c | 21 +++++++++++++++++----
>   1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/proc/page.c b/fs/proc/page.c
> index 999af26c7298..936f8bbe5a6f 100644
> --- a/fs/proc/page.c
> +++ b/fs/proc/page.c
> @@ -43,6 +43,22 @@ static inline unsigned long get_max_dump_pfn(void)
>   #endif
>   }
>   
> +static u64 get_kpage_count(const struct page *page)
> +{
> +	struct page_snapshot ps;
> +	u64 ret;
> +
> +	snapshot_page(&ps, page);

Curious, if the snapshot is not faithful, maybe we simply want to return 
0 or sth. like that?

In any case

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


