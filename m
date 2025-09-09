Return-Path: <linux-kernel+bounces-807438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C45B4A45A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BACE21645B3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC9824166D;
	Tue,  9 Sep 2025 07:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3MbyjrJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FC624113D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 07:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757404662; cv=none; b=tkoDDz+ZOp+wCwmSE0zCAQS+m/H5y3GZ2h0vpOFWG+OheG5CJs6uUICfbzXNAhTgJhyOHgBBC7DdNtCKbBcSbvuzVWZwsG0JH7SEn5M4skZ36Oz0HFMCFBulEnRKZBuvn6SV5y7idNtawZwudfH7ayeg0Bkzh9/v5htcplArhvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757404662; c=relaxed/simple;
	bh=0/6w50Vzsg040lG2FwevMrGny9QxI5FZbzU8Y0LpgQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rph2YTY+sx1OELjQHklPufQJqdstmf3h8B7saW4prd277F6zcomVv8Xuiicq/EXDsG6dduuaOl7SR+MBw7ciB9QondfoD36/p6RDMbzbo22fFCKFKyJ2+xDoQVLYInhLbG92VF01ibAZAcRGrEpacDnIn3grq3L+T3gKTUAA0B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L3MbyjrJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757404660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Nz/Nnga3bgBDy+B5bmnzvxd8xQwqo970wjUWVvIv2CI=;
	b=L3MbyjrJpWW3fEaN9bkyryM22BuPHVrHsRfUQUPHxKbq1flj6HOWhMtyOis2TMdXa/z5hh
	KiIOtzlpLKGNOLrTYxZ9OwWksCIKJH/rfnBInuuXjUaKEjL2a3irq5Gb9J1Sgna43JZ1yl
	ynt9DXHj/lddWr+fVhofaZh1RnStrhs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-veGA0FtcMT6cOmT9mZEkkw-1; Tue, 09 Sep 2025 03:57:38 -0400
X-MC-Unique: veGA0FtcMT6cOmT9mZEkkw-1
X-Mimecast-MFC-AGG-ID: veGA0FtcMT6cOmT9mZEkkw_1757404658
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45dd5c1b67dso27569175e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 00:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757404657; x=1758009457;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nz/Nnga3bgBDy+B5bmnzvxd8xQwqo970wjUWVvIv2CI=;
        b=Wtf/8LNpjSEaUp5np1nCYhczXtaCJeh2KhVvEEEPPxTxzD4bKNjJ16Qqs73XZDFAVS
         RebUFQDeDVMVS0zjlNrqwnJmeQfwvqJnbk91YHrpkRW9kDSvl/gjF7wtsVpffC2Guy8W
         3YRwvbZlOws0MoGoNGj2K1EU07RTUr1nOayHnfdtfPkwj1gaKY0Rh0vXldI4ZQSFXj+Q
         2mACflowl0wHAk7If2CY77y9Cp6lszPKl+EhIbGYCc7D6vLvuwwgckp9merjDXsu6si6
         xQSOpur498LP1o3QDI5l3jtN2dlN3rcLvknCJQZiWeJY59QYWEdQ7l5jgwvYLJa8rdiu
         CYIA==
X-Forwarded-Encrypted: i=1; AJvYcCXAA40c77fps+Ye3om3zshzkb/w5D2qDAnPW1FuV3AVw5GDnGJRsoOqE4CIA9fx6iFCjaUnnhcZ0MOTfOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqwqBsLmJyWs5D9xhL4jT2mzEMC+e+Y8ZfgOGzZmmh+XG48Mcu
	6fAL5jvAhG9oWBihv18yBIFfA5BZzoiOh9j7TCocOLW4zhMAK87Ucbk1O2jmT9n9qj16AuOzBqO
	VmYDMg/Mu9rKFasXzto+3UkNUj0KpNK9nl44oa0N/Do/l2lcZjHGKGhnyyNmy5LVKHQ==
X-Gm-Gg: ASbGnctypP+XTYMuDqFSaMsH/+ustgin+xFiazw2PvNv4YeLcCzqTUTECMKyy+aNi5O
	m0XWQiRzsUWMl04GC0dFPXBo1WqGvKw9JseX7N3Tnwm7zim9VBHmZ1NwGB6afk11/kH6rgfNlrH
	CwsRpR6oyZjCvruZW9x8q7LQWzdz/aL3cDBUBB83cfIsF8oYtWYfgkRNZFDkGLGdH5o77K4W0Ng
	u315LmIoxlJsBa0l29jqR1CctQvkyZouwQcQvewcL14qm61aWhS0qMyfQNth6npvf4AVh4r7PFF
	XzAhDCX9diMnBM3bPNIXvOrcdBwy2P2yFar/NE4dDtL5FjZzzC7w19M2y2D1jN0XPs4TVTttGxE
	wolirM6ni38WY110N96CDBHGL0flHrCd+CfmyowKeEe3gCmy58qt3MqJvpIOYrBAbRQM=
X-Received: by 2002:a05:600c:3505:b0:45d:d88d:9ed9 with SMTP id 5b1f17b1804b1-45dddee3abemr86694765e9.34.1757404657618;
        Tue, 09 Sep 2025 00:57:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy8IpTKompJEw5Cp+BpGsqDaOuHZDLRhJVkeyf3lzVmd5Slf6SPOjM0LhmYZFhOowVPnP1/Q==
X-Received: by 2002:a05:600c:3505:b0:45d:d88d:9ed9 with SMTP id 5b1f17b1804b1-45dddee3abemr86694645e9.34.1757404657170;
        Tue, 09 Sep 2025 00:57:37 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f23:9c00:d1f6:f7fe:8f14:7e34? (p200300d82f239c00d1f6f7fe8f147e34.dip0.t-ipconnect.de. [2003:d8:2f23:9c00:d1f6:f7fe:8f14:7e34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e752238760sm1503339f8f.34.2025.09.09.00.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 00:57:36 -0700 (PDT)
Message-ID: <789863b8-dff2-4fe7-b708-7b0c65c7b843@redhat.com>
Date: Tue, 9 Sep 2025 09:57:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] mm: folio_may_be_lru_cached() unless
 folio_test_large()
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Krabler <Alexander.Krabler@kuka.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>, Chris Li <chrisl@kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Frederick Mayle <fmayle@google.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Johannes Weiner <hannes@cmpxchg.org>,
 John Hubbard <jhubbard@nvidia.com>, Keir Fraser <keirf@google.com>,
 Konstantin Khlebnikov <koct9i@gmail.com>, Li Zhe <lizhe.67@bytedance.com>,
 Matthew Wilcox <willy@infradead.org>, Peter Xu <peterx@redhat.com>,
 Rik van Riel <riel@surriel.com>, Shivank Garg <shivankg@amd.com>,
 Vlastimil Babka <vbabka@suse.cz>, Wei Xu <weixugc@google.com>,
 Will Deacon <will@kernel.org>, yangge <yangge1116@126.com>,
 Yuanchu Xie <yuanchu@google.com>, Yu Zhao <yuzhao@google.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <41395944-b0e3-c3ac-d648-8ddd70451d28@google.com>
 <57d2eaf8-3607-f318-e0c5-be02dce61ad0@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <57d2eaf8-3607-f318-e0c5-be02dce61ad0@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.09.25 00:23, Hugh Dickins wrote:
> mm/swap.c and mm/mlock.c agree to drain any per-CPU batch as soon as
> a large folio is added: so collect_longterm_unpinnable_folios() just
> wastes effort when calling lru_add_drain[_all]() on a large folio.
> 
> But although there is good reason not to batch up PMD-sized folios,
> we might well benefit from batching a small number of low-order mTHPs
> (though unclear how that "small number" limitation will be implemented).
> 
> So ask if folio_may_be_lru_cached() rather than !folio_test_large(), to
> insulate those particular checks from future change.  Name preferred
> to "folio_is_batchable" because large folios can well be put on a batch:
> it's just the per-CPU LRU caches, drained much later, which need care.
> 
> Marked for stable, to counter the increase in lru_add_drain_all()s
> from "mm/gup: check ref_count instead of lru before migration".
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


