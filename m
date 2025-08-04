Return-Path: <linux-kernel+bounces-755616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE2BB1A94A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 20:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8BC17EAC6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 18:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE18822E3FA;
	Mon,  4 Aug 2025 18:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUyjlQjU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA6042A82
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754333407; cv=none; b=KKPdJbaR4dzRRXLZyCjAktM5hgizq2HgbPSw9xpDpjVcBw1A3JHQLLuoEHJd6NPLx1AVGHVbOvVQ8sBi3AZlmFDCbKfE0mA0GuOlFZd31lR552R2kbZcrqSISoiIFPbrGEXyy4LONUKe5Q5rq5+B1MFHHEIYHP0DTdW4Rt03Iok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754333407; c=relaxed/simple;
	bh=jHrIF7fBrQjx1WYOv08IkMlgG0qiq/c3w6QVOToHheg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ABM0ta2ejFAT0bZFQE0NhXu2ap6FgrX+PoJKMXO4jTzpF0HA+Fl753svL2smgqXU1c07U04WE9caZsEhiAFb89x4zByEnSsOn96BXweUBo1Q8r8OFb5sWYHm+dV2mpeHNGlGnQOJNhD/HVqx77WVUzvn7Qm391ERsl6O4ydnEZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iUyjlQjU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754333404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T7UUfiKeOYlsuGZHT7CWAZbKMNooPk/lkfRZ63Id3bE=;
	b=iUyjlQjUfkfrZONjTtzR75EqjG7NdQjqLYN5VEhXK1va1Zsx6OU/+4dKxWHZSAkxlRsrpq
	dhmuqrrWjule8Oz01sFI/TdxkMlDHTKCf8ExPkR9leFnDiaq0wCsIIqCOr2zNS9tqp3p/1
	COko4aC1apeEMRq1Rv4VOGxzSabBuPs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-ohHcdPggNeyLinStahAfmg-1; Mon, 04 Aug 2025 14:50:01 -0400
X-MC-Unique: ohHcdPggNeyLinStahAfmg-1
X-Mimecast-MFC-AGG-ID: ohHcdPggNeyLinStahAfmg_1754333400
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-459d3abb2b5so6331105e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 11:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754333399; x=1754938199;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T7UUfiKeOYlsuGZHT7CWAZbKMNooPk/lkfRZ63Id3bE=;
        b=NU8GCV2n4hAWI8xTp+Wp9U+FXHsZLO2Yul3/FcyyzkHXdofK5hDlX8C8kuoUJOByg6
         4M7ZVHHwI86ylkYmtoXTaxDiQ3YXpvTXSMx9L0/8agz4QOytyYBpjwzFpG3KU8ctVUWg
         p8qyi2FldtOzQY/TN26PIjb6oP3lPHFiMhxu0xVdoU2J0vKYv48w7BvkMGhs9PkHspdF
         VxOypSC1PUGGaIk8t/ZJA4rFt3F6cUPEqkezxCnDox3WWNd6v0ACsSA+pCYmP2L0LSZh
         uw6s0oyk/SBYsn7BV+meMfSBz3w68R4tivhQmrHjOVwXis7vS66FgayezGR7w099RsYf
         H5yg==
X-Forwarded-Encrypted: i=1; AJvYcCXVPq3Pb0tKxI8UHPAMVbElOGSxFrnjKtIYxoHVeIazyAdBLr4/yWdYQF1Sd8dR/veryWDQaQnxWuT8RC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykgqqburtb4MSeF3q1s+yUHVVqQWuYbO+mKODQ35XEPhBhbr/N
	VQa+r3k94+iw9PVotKCLCn5A2FLE6or4lvDMSN3yfgNDmdHHKVPmoSXj6Y/NOMJ4FeHDJ9wyWpL
	L7UvazCK5ueRNev3SZ1icGe0UJ5Jm8nvIVA1nvE1poNbZzM/R9xCjRywey6p7J8igLQ==
X-Gm-Gg: ASbGncsq70NknYcnxIFziZWRzTotcK0flYujpKhi+NRFnKW4kIIuv42wrQJeHrXzKpn
	84noHIi5ed5vnRGFSaYdw9j3khTkVmta1SVZ0lKwObSt/T8UVlskf1NxtxfM/DLsoBF7zJihhFx
	QSu5kH3T07AVUz4LPxwhqbymxZYW4o8aIBxTridRsGQSeTMRSnN/Ta8//dZMCXR3cMTzNJnD5aN
	oOUjoVVuRsnDJvFm3suY10byuzfAp+Qcttez2QSlbI1t0KGXgRN83IB0vch5TNL4uuIDJTtOdZw
	Xy0ZdeLyaGVN7bWXCustS2vZvpygJFqdmtvzDMSll8mWUqRKjAKHf+K4urg+E5XzY0HqI9c=
X-Received: by 2002:a05:600c:4e10:b0:459:443e:b180 with SMTP id 5b1f17b1804b1-459443eb330mr58589105e9.8.1754333399547;
        Mon, 04 Aug 2025 11:49:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEP5GKxPERgMzvVb32ee5lNTwOD6PwhOAZJzd+FoxhfvfxFD7V+1+8Wo8Q6qFIfAKQ4FNeWAg==
X-Received: by 2002:a05:600c:4e10:b0:459:443e:b180 with SMTP id 5b1f17b1804b1-459443eb330mr58588875e9.8.1754333399118;
        Mon, 04 Aug 2025 11:49:59 -0700 (PDT)
Received: from [192.168.3.141] (p4ff1f1eb.dip0.t-ipconnect.de. [79.241.241.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c47b10asm16101568f8f.60.2025.08.04.11.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 11:49:58 -0700 (PDT)
Message-ID: <d395b14a-9a84-4f25-b4f0-45e8500fc5fe@redhat.com>
Date: Mon, 4 Aug 2025 20:49:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm/page_alloc: Add PCP list for THP CMA
To: Juan Yescas <jyescas@google.com>
Cc: akash.tyagi@mediatek.com, Andrew Morton <akpm@linux-foundation.org>,
 angelogioacchino.delregno@collabora.com, hannes@cmpxchg.org,
 Brendan Jackman <jackmanb@google.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Linux Memory Management List <linux-mm@kvack.org>, matthias.bgg@gmail.com,
 Michal Hocko <mhocko@suse.com>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, wsd_upstream@mediatek.com,
 Zi Yan <ziy@nvidia.com>, Kalesh Singh <kaleshsingh@google.com>,
 "T.J. Mercier" <tjmercier@google.com>,
 Isaac Manjarres <isaacmanjarres@google.com>
References: <CAJDx_rgzkZognxWzOXJ-ZxdTtUaM3FT6bmpkwxMz03XiX3fKAQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <CAJDx_rgzkZognxWzOXJ-ZxdTtUaM3FT6bmpkwxMz03XiX3fKAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.08.25 20:20, Juan Yescas wrote:
> Hi David/Zi,
> 
> Is there any reason why the MIGRATE_CMA pages are not in the PCP lists?
> 
> There are many devices that need fast allocation of MIGRATE_CMA pages,
> and they have to get them from the buddy allocator, which is a bit
> slower in comparison to the PCP lists.
> 
> We also have cases where the MIGRATE_CMA memory requirements are big.
> For example, GPUs need MIGRATE_CMA memory in the ranges of 30MiB to 500MiBs.
> These cases would benefit if we have THPs for CMAs.
> 
> Could we add the support for MIGRATE_CMA pages on the PCP and THP lists?

Remember how CMA memory is used:

The owner allocates it through cma_alloc() and friends, where the CMA 
allocator will try allocating *specific physical memory regions* using 
alloc_contig_range(). It doesn't just go ahead and pick a random CMA 
page from the buddy (or PCP) lists. Doesn't work (just imagine having 
different CMA areas etc).

Anybody else is free to use CMA pages for MOVABLE allocations. So we 
treat them as being MOVABLE on the PCP.

Having a separate CMA PCP list doesn't solve or speedup anything, really.

I still have no clue what this patch here tried to solve: it doesn't 
make any sense.

-- 
Cheers,

David / dhildenb


