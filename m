Return-Path: <linux-kernel+bounces-794037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E24B3DBE3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CDBB7A76F4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E340D2E0903;
	Mon,  1 Sep 2025 08:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f4K5jZDZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D771F4E59
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756713993; cv=none; b=JNSg4l2jUq1UoIa55BlizRPd+sspnfqYHewwt8qwRrUIuIYML4jTvERFNX+eVPE3hOWkuhnJasDPom+wtg7vCmuVcDCeJsKhQYCEW2tPhKCgh3pPsvnrnqB2hZ6vIz/rCHZMKLXoHYWOkLLWgFNJkIKuf8XiDrsRtkmJMElgei0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756713993; c=relaxed/simple;
	bh=ExmwPrzZScnFZIS78hPudj/C7RVVHMF99ottmy5B0oE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O/YD/zOrkbQo0LZU98NLGZiRSoTK8+AV1BsKMJoOSniomq7YJ7/FWDMKq8x6hLKPmmU4ySLDBaMsp70B+u0uO3afVFrWlEB3uocPPiMQ7alwgap50K3iOKbYZyIYSzT0n1idI/VYO+CroeeS6IuKHwn/L/lRIX3RL/dt4N/t/Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f4K5jZDZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756713990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=36asoDc0iHyCQaqJQKzsY9OSxCtFiTj85FzevifIki8=;
	b=f4K5jZDZSiN9yLIqqem6CyLv5Yj4fLteo7hHjE8hQCPMHI3ZSwoZNXf4lPbNqkTt2UkWCk
	SjPRMBx45LxjUnnEtTJ6ZZ2BToxpVhR2wAY0bt7Xcw2pNO8RAVx9Z+r/a5miJo+cP89r7n
	RJc1DDZCPY1yfPo/aqKBEJFqRB9QQ0M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-O1yiPvtRNY2PNtTTxm_elg-1; Mon, 01 Sep 2025 04:06:27 -0400
X-MC-Unique: O1yiPvtRNY2PNtTTxm_elg-1
X-Mimecast-MFC-AGG-ID: O1yiPvtRNY2PNtTTxm_elg_1756713986
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b8b51b20eso6122205e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 01:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756713986; x=1757318786;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=36asoDc0iHyCQaqJQKzsY9OSxCtFiTj85FzevifIki8=;
        b=FDU82kgTB3s9YhSrauf5XDhFvgWkM+iuZdArTKuCuj+542vIw2S9SMruSflMfcgFbJ
         rFtyrjuybQbblUlyxLi4DLz5fyI9Y5+AgTPzpd4Q/+pnJn+P4COHiUk6AW5FmMBIeXjb
         Ind/LrmZoe1gbW8qlCJ2oyxRAI9pBuiQ5Sl9avCzTpG1nw7a5O3x3J0+D9TWDI2QqXWl
         mK31ZqTjhj+e6LCkIkdcFf+cBVOiheWbDHdkLsI+Zhb+Q7LEfPk56dRFyH5lUwjpbm5E
         V+B6m7orqfnq6dd7BDqdSo67L9eQADfQBP2354JuX4Y1+nwQGc0K5dQatR1qSe88Dvcz
         9Teg==
X-Forwarded-Encrypted: i=1; AJvYcCWHDJUTVfn/zoKsJ8khwuffJ+JKri6t77bAgALB1CeI0UDUq1KSifMrDTK01kAhPhviKoehkhHa7F3E2Ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOV//Cj6VZju0DGlY4Iw111S/YnLNQbu0573E2kvS6Lo7EeD05
	kCnY04+ImGFKqWYsM9NyDvVEgVH6hoan49A3QFwvB6NJfvQpx53U/++SAPJ/0M1oFZE8VNrEaPH
	eokzt7k2rT1TPVtsxlk211KbtbwZaTeWGxU5q48iVZssr/f6mJ+7bazmaGuDqCFUQ6g==
X-Gm-Gg: ASbGncvcKGhcrfY/LwseEqP3ucLlSb1pIgf0E30Nqkk8h+6XGisQ4XWs4jRB6EBZaQH
	faYz1avQ+4XZeBDAC/CzjlTlyS8GGS1XjyBiKPcAkxrzxTZtvxz8kvIWs6PYFalI9HnyW+fhdcC
	FVqm4D1VTgSgllCdKOVlR/qVEg2B2bT2t30U7RLTduZ6N1WKPJjRejcoRid3e9K/8JnhD9aYoNX
	cD/yv1fQ4KsS1eH+nvBjbCGay2uEzHJic/KJCIzgGDoK18WioIbFYcBjth59leK28dXi8DaTBQg
	7JAN6SMMBjaQYhVRDtOgyPUiE2nOlVmOsfDusOCyuVCHjOYcilQwTTeGcFoqL4BFb57g9ZtF/A8
	m1RXAJw/juJJAP9PLuByA8Er+k1kbrDuil+B3Cm03wKrog2EddF9l6QPbK7l1A4agKB0=
X-Received: by 2002:a05:600c:4f0b:b0:459:d821:a45b with SMTP id 5b1f17b1804b1-45b87bf56e3mr53425355e9.9.1756713985959;
        Mon, 01 Sep 2025 01:06:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgMgZX2cNh35Rid9shheD+9ZZm5Gk0eOcu6r6LL5Iv12JAtT5v9c2Wsf6vZmmcbbRWjzq7zw==
X-Received: by 2002:a05:600c:4f0b:b0:459:d821:a45b with SMTP id 5b1f17b1804b1-45b87bf56e3mr53425135e9.9.1756713985516;
        Mon, 01 Sep 2025 01:06:25 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e8ab093sm150530455e9.22.2025.09.01.01.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 01:06:25 -0700 (PDT)
Message-ID: <1431a00b-d68c-4f25-b075-5021e2faa9db@redhat.com>
Date: Mon, 1 Sep 2025 10:06:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] mm: Revert "mm/gup: clear the LRU flag of a page
 before adding to LRU batch"
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, Shivank Garg <shivankg@amd.com>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>,
 Keir Fraser <keirf@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 John Hubbard <jhubbard@nvidia.com>, Frederick Mayle <fmayle@google.com>,
 Peter Xu <peterx@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>,
 Alexander Krabler <Alexander.Krabler@kuka.com>, Ge Yang
 <yangge1116@126.com>, Li Zhe <lizhe.67@bytedance.com>,
 Chris Li <chrisl@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Konstantin Khlebnikov <koct9i@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <a28b44f7-cdb4-8b81-4982-758ae774fbf7@google.com>
 <0215a42b-99cd-612a-95f7-56f8251d99ef@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <0215a42b-99cd-612a-95f7-56f8251d99ef@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.08.25 11:11, Hugh Dickins wrote:
> This reverts commit 33dfe9204f29b415bbc0abb1a50642d1ba94f5e9:
> now that collect_longterm_unpinnable_folios() is checking ref_count
> instead of lru, and mlock/munlock do not participate in the revised
> LRU flag clearing, those changes are misleading, and enlarge the
> window during which mlock/munlock may miss an mlock_count update.
> 
> It is possible (I'd hesitate to claim probable) that the greater
> likelihood of missed mlock_count updates would explain the "Realtime
> threads delayed due to kcompactd0" observed on 6.12 in the Link below.
> If that is the case, this reversion will help; but a complete solution
> needs also a further patch, beyond the scope of this series.
> 
> Included some 80-column cleanup around folio_batch_add_and_move().
> 
> The role of folio_test_clear_lru() (before taking per-memcg lru_lock)
> is questionable since 6.13 removed mem_cgroup_move_account() etc; but
> perhaps there are still some races which need it - not examined here.
> 
> Link: https://lore.kernel.org/linux-mm/DU0PR01MB10385345F7153F334100981888259A@DU0PR01MB10385.eurprd01.prod.exchangelabs.com/
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


