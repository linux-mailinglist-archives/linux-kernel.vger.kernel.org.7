Return-Path: <linux-kernel+bounces-865838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF51BFE23E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9451D1A04F77
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7892FA0DB;
	Wed, 22 Oct 2025 20:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="emYQfEev"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CF726F46C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 20:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761164326; cv=none; b=n64L+GZ8OLvDLZ5jRzPq4Ag09dAt5nD4FSnGho1gi4LSdqaLSkfSeWM1JEsdDYQ7+xyAwhHRnjByMpthYZwwanoPX2Pz1xGQ4JhGwVkR2rdIwE90drDcUAh6WjHfQxMohuiNUuGF5VCEZV8f/KHhKDanZm2r+h5lJc/3VY0xjzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761164326; c=relaxed/simple;
	bh=Z459dht6gE8XeDgV1qENj3inkdPtfrSAdn9EtsTw0Ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGxgQaJBQsgN5+0ZuJlv0D9Cvd3McmhkfXCawsbcMKZB1O2J2v+Sg9NFxc3ZCr3M3RlJnRar3ACB5IxeDT+ogTfjcqsie2FuW6520GV8CsplTb6QmxAq3eALpBDShgEcofGjswswm4gQcSmFGxvuUYGxs5DKVW8Io2UK5Jpgku4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=emYQfEev; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761164323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qQBmXsw5V4eGrvR9Tz7wn2FNoM8/TbO0Z6U8kNgiKEk=;
	b=emYQfEevZtmx7vV6O5KDcA+Yf6XNM44lLZOzzGcPj5s+M1w1l6eklUhrvPBXTUOKQZ/T/0
	aNGlduCzqBUQcKYTVbXwKEPrNUXb7CBnO7oRLAl6Tt4uhtO2BZ7777IdI5/zsDLQAvnWv+
	k2IY5tFpLb44TRfWooUm3gqmfndxdBg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-zSAb0WuYNpmK6rfpC5VY4g-1; Wed, 22 Oct 2025 16:18:42 -0400
X-MC-Unique: zSAb0WuYNpmK6rfpC5VY4g-1
X-Mimecast-MFC-AGG-ID: zSAb0WuYNpmK6rfpC5VY4g_1761164321
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47107fcb257so207365e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:18:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761164321; x=1761769121;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qQBmXsw5V4eGrvR9Tz7wn2FNoM8/TbO0Z6U8kNgiKEk=;
        b=ZVID7HexMtnylkA5o9mCwnVNARbLGnUTo1vhmZOA+CiMOezdQfcg4COLwXV/BcLa3y
         THFtPa4zSmxu98Awe3GpeIXX8Y9fs2SdygUxSyN+Q2Fo9NOOnm0a07vTFvqd7DPsBDoz
         mQcjKgu3S/7F8qIxNfXH9axOFzlMtie1ivqr+pjiFqtQq8LrxngGZgLNgL4jYXEFjcjZ
         6rQfRzECG9k63SggLVa7VP0yb4VStJSw+ou1ikEf259i5CuD86CXWZz2fQW9Sly6743y
         Nwf20p1qlJ0p/JN8RI7YvBG1f2gDNaxkAqOSES0QLsHTi2ybc1LHUItghRn2S8LqEScu
         RY8A==
X-Forwarded-Encrypted: i=1; AJvYcCVHbcP+OWhgBFt1neVaz1fy+ilTmbowQKz18WIXuEtwC8vwjIJZ2khQhalwTgLdcgJW/bJqKu5RvSDjjZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP8LtQ1drAusBhAVZcobmMcpy8XfEe+seniz2POma8nDiFz5A8
	ltb6rnooDalNE38DRsvE10KhtXWDXmkRryQaswFSAAI0c4F6GDlXKqXDMTdzT8gTdv8LXArZWON
	zN9K4inpkQdgZ8EQaFQNY8TtbycnfvIpJQchmN/h97jb5cgnfmHnBP9rJmEzX9wrBIA==
X-Gm-Gg: ASbGncv+CFyXSNqkSmxDgsJSxD/S1x1RdLoqvhkJbp4bJdH4tODAOtZCWJu8ftyXO8m
	IITqv0piUS1NijNNVcUcJNA50x0iB2L2vEB6a7m2PlxDcx6sBr8RX+SOqKdwZ6dowyLcLDyE7Sr
	fViYvGE3PsaWJgNLRVvL/QMBrCSIAo8IdVDtsI3abTQq4lEmFNMaKCkggl6FYQurvjtiNiS4q9Z
	avJPdNdxEE8ZI/ZQEG9MRQ/n1Qn/AtfJ/qdKLAffTq3GMOyMHwTFBAS0SIqDwQMFNKIpVMuZu/m
	b9+x1fUxpgNoO1Lm3vGATRn8udP2AuDgW/albS/yWnRuX5wd8xP+e9nqtL4aHbOPEInz1wEoA3W
	3S7tD6LUcDG8xSkAHtxhMYa5t0HjNEOIRF/oT79/GkEApz3WfRfigl9hgwUF7H9ydynhD8hEPlI
	AdJqES7Zus1dOYv+o+IJwsWOG1+PM=
X-Received: by 2002:a05:600c:354a:b0:46e:59bd:f7d3 with SMTP id 5b1f17b1804b1-47117903f24mr147151245e9.20.1761164320903;
        Wed, 22 Oct 2025 13:18:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHv1MI1KgUeIM4e592xdEkhILAGzFJn2fdCT+0ozCWrbyg+uo/HqoutZfyrh7Unzhv5piUSA==
X-Received: by 2002:a05:600c:354a:b0:46e:59bd:f7d3 with SMTP id 5b1f17b1804b1-47117903f24mr147151025e9.20.1761164320417;
        Wed, 22 Oct 2025 13:18:40 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496be2eb6sm44115165e9.2.2025.10.22.13.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 13:18:39 -0700 (PDT)
Message-ID: <b2aa1edd-42f1-485d-b569-791a1e885487@redhat.com>
Date: Wed, 22 Oct 2025 22:18:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] mm/huge_memory: fix kernel-doc comments for
 folio_split() and related.
To: Zi Yan <ziy@nvidia.com>, linmiaohe@huawei.com, jane.chu@oracle.com
Cc: kernel@pankajraghav.com, akpm@linux-foundation.org, mcgrof@kernel.org,
 nao.horiguchi@gmail.com, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Wei Yang <richard.weiyang@gmail.com>, Yang Shi <shy828301@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20251022033531.389351-1-ziy@nvidia.com>
 <20251022033531.389351-5-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251022033531.389351-5-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.10.25 05:35, Zi Yan wrote:
> try_folio_split_to_order(), folio_split, __folio_split(), and
> __split_unmapped_folio() do not have correct kernel-doc comment format.
> Fix them.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


