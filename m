Return-Path: <linux-kernel+bounces-757389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 280F4B1C1A0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6932622BA4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 07:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9832721ABDB;
	Wed,  6 Aug 2025 07:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YP6vGYOu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9BC1FF7B4
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 07:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754466961; cv=none; b=NuVxLcRC5WrWi2lLOPHEYlJiZZ+4vUvZhmdj52cSqwuMdBIWCxpyyO5tBNqPUTl/inBIx4kT/77Uh4aVA3qotBIVeiYF/Iln6ww+cuxFgo4+STlgVn9jRLRyUizbs+csN4KIuaC4tiAz1KlpjfxmGjyBUF9h4/L22CpIoY/2780=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754466961; c=relaxed/simple;
	bh=zfW6IGBhWFhSkdQFqv74/PawrW0VnvxW1Wh9BkQa5bU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BQ0lnw0i9aF4fBwpLbXm+STGzZNCR9RF37dLA/b0olaoV+vDhf0cH9K/J/euhQgYFfn0ph7w/0hcPu+BePjLQ1bkoQN/ArngAoZmYLd+CBEOLPymgoZdFnS50kDF6PIsYvg2o+NxL5K4ncSrYpeY/Xas9EFoBIbqVspTYDkNv2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YP6vGYOu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754466959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DZLFNyU13X+JHer0jZ2QFk1zQ7UuPpmmQtBWGZ3YSq0=;
	b=YP6vGYOuYQqrplzQqFkVbAySYS4arJ1cAjmyd6rgX6WVV6m/XMSKDUSqCFsesH1pBd0fD9
	fO/56gU65czymqMmL9BI4coywYg5mc+Umqr7LdRdthNRBwl7+qVJ5VaS2e3c2olt7NDDOc
	iZOQWqequt+0C6XjDnzSVUNJy6fPkcQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-PdFbSUErMPqad8i6VG9mMw-1; Wed, 06 Aug 2025 03:55:57 -0400
X-MC-Unique: PdFbSUErMPqad8i6VG9mMw-1
X-Mimecast-MFC-AGG-ID: PdFbSUErMPqad8i6VG9mMw_1754466956
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-459db6e35c3so20445625e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 00:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754466956; x=1755071756;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZLFNyU13X+JHer0jZ2QFk1zQ7UuPpmmQtBWGZ3YSq0=;
        b=EO/hTxFJa/6/F1VxmLVmCL3pide/GHpBoDY56rK3VrPk6VmNZe8zLOlGGUQUraXPF3
         rEl914aQTY2UYk4+0Xv/frplMHIregScFby1W+TtXFWipDYUAcQJPLUGpuG1aqWZeH9+
         ON1plucbUjkIt+AuiBkJ983edvC0mSx3wen9Fg9K9dKDFHqqs54Vq6/moTxjqj78yVUj
         9ARuUYdvx89/jO7EIJgvaz+XDml0cbBPwsXBz6EUMyIBwElORPgnUkB8R4COEwLRKDu9
         2XulTSzLlJhR9YD2n4jlk/eff+2l/0bUZF94JtwsyjcZI+VRXj5sgRtcyjtpjHPNHvqx
         AQcw==
X-Forwarded-Encrypted: i=1; AJvYcCU5ChIek5ynk7fEUVoEvCzOT3bPS6mDHKAAQRQEU53pj1ounxNWTuu32+ZblMNdyqIbMlHZ15EXg+X65Qc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz1DetpAFsX+xA5/0CWuy8aYhKX/MtW08EOaE5N76ju2hoW/7h
	f0h54CTlN4lA9yCqQeh8Byfu7ksSbg+0svZGqffQ5TGU14wtykFiMMTC5DB3l9tmwaKSA+b10Fv
	PheZPnmj8molndzKRGn787m6VTUbFjKIBdVyvCqiyVE4j7/5sx7SXh5KTIQBRJj9K6g==
X-Gm-Gg: ASbGncvZfO7mgMcKxxF/wGeUWjxVTfMo1AF/G4YuLcmNMbZLK2I/T3edx1f82xMxiG3
	pvGnZBbHBrs+dhldi1Ca/EP7FWZoueal5ijRI0ymAlEkiKjexJI+cJ7AEDZEjvjqhirWjAqQl5B
	WJblZkZlEFyrViPie3Z+2y4I+5ZklYXsRu8SBvqvnfPjdF9p1j2coheYL8Vdmi5hs2ZQ9nOBlkb
	Dxwgq5yrhZgwRjhsoSkAE/0p/8raL57BEXKX4S5Lohd+AJ2j79SeJ6hLwwMFrzWoLsgBaZ44eHC
	yMECYrLrkUzJlItA1Q/n3YLIkMTs61gLLc2URl2H0BAfLTw6kOMdVJEIrFJ/IZOtUFnEIoY=
X-Received: by 2002:a05:600c:b8d:b0:458:6733:fb43 with SMTP id 5b1f17b1804b1-459e70d810amr15082745e9.19.1754466956364;
        Wed, 06 Aug 2025 00:55:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHreEm/o70R+4VZDPuQwDE7mdbv00ibKdg9EKpHj1ehYh9wMi6gBd79ZjCe60Nx7uWZ1VDZqg==
X-Received: by 2002:a05:600c:b8d:b0:458:6733:fb43 with SMTP id 5b1f17b1804b1-459e70d810amr15082535e9.19.1754466955963;
        Wed, 06 Aug 2025 00:55:55 -0700 (PDT)
Received: from [192.168.3.141] (p4fe0ffa9.dip0.t-ipconnect.de. [79.224.255.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e1cb7deesm11542751f8f.2.2025.08.06.00.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 00:55:55 -0700 (PDT)
Message-ID: <50ad6ed2-2f4b-44b1-8b78-8eb3993834f0@redhat.com>
Date: Wed, 6 Aug 2025 09:55:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING in follow_page_pte
To: syzbot <syzbot+57bcc752f0df8bb1365c@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, jgg@ziepe.ca, jhubbard@nvidia.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, peterx@redhat.com,
 syzkaller-bugs@googlegroups.com
References: <68930511.050a0220.7f033.003a.GAE@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <68930511.050a0220.7f033.003a.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.08.25 09:32, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7e161a991ea7 Merge tag 'i2c-for-6.17-rc1-part2' of git://g..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=16d385bc580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=75e522434dc68cb9
> dashboard link: https://syzkaller.appspot.com/bug?extid=57bcc752f0df8bb1365c
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13fa96a2580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1083c434580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/85ce789ac77a/disk-7e161a99.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/4d1fd8fed61a/vmlinux-7e161a99.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9bd5f709ed6f/bzImage-7e161a99.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+57bcc752f0df8bb1365c@syzkaller.appspotmail.com
> 
>   do_initcall_level+0x104/0x190 init/main.c:1331
>   do_initcalls+0x59/0xa0 init/main.c:1347
>   kernel_init_freeable+0x334/0x4b0 init/main.c:1579
>   kernel_init+0x1d/0x1d0 init/main.c:1469
>   ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5866 at mm/gup.c:869 follow_page_pte+0xe3c/0x13e0 mm/gup.c:868

That's the

	VM_WARN_ON_ONCE_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
			     !PageAnonExclusive(page), page);

[   89.134725][ T5866] page: refcount:507 mapcount:1 mapping:0000000000000000 index:0x200000009 pfn:0x70809
[   89.144633][ T5866] head: order:9 mapcount:505 entire_mapcount:0 nr_pages_mapped:505 pincount:2
[   89.153655][ T5866] memcg:ffff88801b6f8000
[   89.157938][ T5866] anon flags: 0xfff6000002007c(referenced|uptodate|dirty|lru|head|swapbacked|node=0|zone=1|lastcpupid=0x7ff)
[   89.170337][ T5866] raw: 00fff00000000000 ffffea0001c20001 dead000000000122 dead000000000400
[   89.179013][ T5866] raw: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[   89.188218][ T5866] head: 00fff6000002007c ffffea0001c52088 ffffea0001cc9988 ffff88807c250551
[   89.196996][ T5866] head: 0000000200000000 0000000000000000 000001fbffffffff ffff88801b6f8000
[   89.205866][ T5866] head: 00fff00000010a09 ffffea0001c20001 000001f9000001f8 00000002ffffffff
[   89.214719][ T5866] head: ffffffff000001f8 0000000000000015 0000000000000000 0000000000000200

So it's a pte-mapped THP, whereby the folio is pinned two times.

The warning indicates that we likely have !exclusive anon page that is mapped writable
into the page table.

xdp_umem_pin_pages calls pin_user_pages(FOLL_WRITE | FOLL_LONGTERM).

Let me dig, the reproducer seems to involve fork, io_uring, mprotect and setsockopt.

-- 
Cheers,

David / dhildenb


