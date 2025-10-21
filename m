Return-Path: <linux-kernel+bounces-863275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 025E3BF7729
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9A81888E76
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE038343D9B;
	Tue, 21 Oct 2025 15:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTGN/hAJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F7D20F067
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061384; cv=none; b=CVQzeSrXNL9JhubX3jVsJO7qgXDs7H4Hc4ez/Wi+JjozrudaMMrjaVQQpWnGZ7VGjioTlaZA5HyN8t9Bi4UP1YiQp2xMyFpg98eEkjvbhoDaCaYWxu2zA2m1mSH8e0wRm7QiIg4z2nIbzv4P1l7rW43TxqSd3uNss8UuYbM7es8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061384; c=relaxed/simple;
	bh=N21AliblMPWaA0AUzxTZ6Nv7AA/MfaFCoxuvbrLNL1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jRxf5YZUGZEJy4I6ww/cLDbtQXtYKLOJ7fFYoxM6ndBnK8DGmtkkrEbqMMKIcH6kHsbqo/qsO5+jBGWp28s+rk6mSpfPkMHhJJJJ7BRyNXqacwTuLKcAiofbphk78BZX5eLv8ik8VH66GukbccM3JKf+ucyd8Ys4EauN1/ARF0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VTGN/hAJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761061379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jNcno7kT0irEzub8Roey9W2mYI7FYUplQutZ5yVhFdg=;
	b=VTGN/hAJOBSJcTJauTp4ofUKLmTo6xvlzF5ZRU5cIRmsfdPpRD1DZRm7PHuK2oWkK+TYsg
	3tL5kTucR/uR+J/S1CfrA6jEgJEnDhgFEMKQwq3BDDRyFu4jXgNDzd+sT1rFw919l9z61U
	WBSTHwJwKHJsDBbuAt+dXHRItfNxLxM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-gnXriHshM2-zL_DfRLigKw-1; Tue, 21 Oct 2025 11:42:57 -0400
X-MC-Unique: gnXriHshM2-zL_DfRLigKw-1
X-Mimecast-MFC-AGG-ID: gnXriHshM2-zL_DfRLigKw_1761061376
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4711899ab0aso44347255e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761061376; x=1761666176;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jNcno7kT0irEzub8Roey9W2mYI7FYUplQutZ5yVhFdg=;
        b=Zr0KCvaN0DHXtnlmicUy1rde9NUodm9tdBRJuCZpcN0n5lJz04rdpt5U0V2FVHvRSg
         7daBoRAJTNQThZqd4oAhSAxMDDrvWUdEfUgrUihBugr/cCuqLCh1kXO5N9wVZVbt0IR4
         FSPGGfEMbxk6tn4973R/uhjCTq+5NPqTU6sVpIr4rAsRcFpd/PP5F96WQlArnHg/U2u0
         34HWVgV3yRwHNqcWAIVt2xvx2PgWOWBbMManbZMDhcSXpzyHf698u5imFxVAuuXKIHGq
         QT6CdtWNrpYZp8GbUdnbRu6gmi6342IxRMB88+cEomNYXhnzZswz2uQpSEZTsIksQGKW
         lQkA==
X-Forwarded-Encrypted: i=1; AJvYcCW/+u4ZZAeYYd/Kw0ur2RCZjqc44sDq40dMtdavdy9oaoESKsnauLMova/a7yMzZISAGRUPI0u5VriqKWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSiSxU9jsX35v2PB/MTmPQ2wmLd0ux2Uq/5h0T0YuMKxPqamlE
	WN9F8p9Mld2nwOLqxx8tSWaghXXRqkxZjiUlVa/B1D+WGlrBxOW3cNXCiUuHRES0YKbvQ0049oe
	fSDvLT86NSi0iPpfsMck3cgTezlF1pCi6WuQc6Sd8+Ygtbdz3chFATin/mh047ruRiH91/xa95A
	==
X-Gm-Gg: ASbGncuHbEJhhM74L/U4/H5ga2aSrWRuVyAX60U+BEYeZkvgkL6lmCMUFC9W15rz7L9
	h+RAeJThapdLSY3h7j/0lbTJl9ixD+G6o6WnIaHUqD2rx5E7Md56IbR7FoewtVw8g64LbwDKA5q
	fvDnZLmpESeIncD8cC9ze158dAmb9H2GATfcaoG/2ENEtaq8pLCooPkcC6Oo86lw5QH6S6eWRfM
	l1j90mdEM3MIZgQsqXh2ve4Bgt8khLu666jh7xHx/+Hjj0d49FnFTJFYVkFty0BLSBHk7+zMcP7
	JKwYiYncyORo8NUSlHkAV9+fAiK8yMQ7xvfnbJcqwKtO65+xXLwwAw6x4YWeRLmj5ECPeDeZHwh
	CFSONO+AuIXiAhYJhOyiXaxWh5qNAVQpcxql1swX4jlhmcmYCzZgnIs7YXdvjrh2s5+BzszXr3L
	MB/h6sTJd4Gpob+ocB+zVOgbOXk+8=
X-Received: by 2002:a05:600c:870b:b0:46f:b42e:e366 with SMTP id 5b1f17b1804b1-4711791fa34mr125576295e9.40.1761061376002;
        Tue, 21 Oct 2025 08:42:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAXCpx0sJcyJNfRiKm2dYACcXvFmWjsvuh2uNond6HHIL7tB74zy8IJxnnZIUjSnynaOrehQ==
X-Received: by 2002:a05:600c:870b:b0:46f:b42e:e366 with SMTP id 5b1f17b1804b1-4711791fa34mr125575985e9.40.1761061375574;
        Tue, 21 Oct 2025 08:42:55 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4714fb1b668sm232749515e9.0.2025.10.21.08.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 08:42:55 -0700 (PDT)
Message-ID: <88f8477b-5898-4d7e-8583-9d769a34645f@redhat.com>
Date: Tue, 21 Oct 2025 17:42:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/huge_memory: do not change split_huge_page*()
 target order silently.
To: Zi Yan <ziy@nvidia.com>, linmiaohe@huawei.com, jane.chu@oracle.com,
 kernel@pankajraghav.com,
 syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
Cc: akpm@linux-foundation.org, mcgrof@kernel.org, nao.horiguchi@gmail.com,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Wei Yang <richard.weiyang@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org,
 Pankaj Raghav <p.raghav@samsung.com>
References: <20251017013630.139907-1-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251017013630.139907-1-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.10.25 03:36, Zi Yan wrote:
> Page cache folios from a file system that support large block size (LBS)
> can have minimal folio order greater than 0, thus a high order folio might
> not be able to be split down to order-0. Commit e220917fa507 ("mm: split a
> folio in minimum folio order chunks") bumps the target order of
> split_huge_page*() to the minimum allowed order when splitting a LBS folio.
> This causes confusion for some split_huge_page*() callers like memory
> failure handling code, since they expect after-split folios all have
> order-0 when split succeeds but in reality get min_order_for_split() order
> folios and give warnings.
> 
> Fix it by failing a split if the folio cannot be split to the target order.
> Rename try_folio_split() to try_folio_split_to_order() to reflect the added
> new_order parameter. Remove its unused list parameter.
> 
> Fixes: e220917fa507 ("mm: split a folio in minimum folio order chunks")
> [The test poisons LBS folios, which cannot be split to order-0 folios, and
> also tries to poison all memory. The non split LBS folios take more memory
> than the test anticipated, leading to OOM. The patch fixed the kernel
> warning and the test needs some change to avoid OOM.]
> Reported-by: syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68d2c943.a70a0220.1b52b.02b3.GAE@google.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> ---

With Lorenzos comments addressed, this looks good to me, thanks for 
taking care of this!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


