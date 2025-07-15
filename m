Return-Path: <linux-kernel+bounces-732220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E309B06393
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEBD54A8483
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFB625486D;
	Tue, 15 Jul 2025 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGhDjYoJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46569218589
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594942; cv=none; b=TsTBzY1uZ4Vq36Tjb02eP6YTqI/8m1QDH7oXJuUKhGfzqjhtr2lvGBhcDcVq62IJcks5rAs794jhvvr/PyqS3u8EywmJlMJK5icSXo72igAyf7nmxFSb3PfB072vj37jrhQqPfo80nX2NKt4hSab9KYs1999LfJWE4FuU3xnGIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594942; c=relaxed/simple;
	bh=cfxm7upyQPAVQ+Uo2q1SRfof7gmygRtzj5suTyQ+ELE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hdoAPNXJ0HiYkQfYMS0+CkfFbKX/wpUK4t0hMYQitm7xfr+QdieY6piY2FnpcG4uvvV0B89M7fvrRPJ0+dGOZeauBjH8BDNOSaUsLm8zSdMq39iH7XA+wHifg3A8OIkFAC+FV4Nna+Ryt69YKvpBYhdVpuW4bnprNcZVCmG+PLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gGhDjYoJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752594940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vw5r3Akmq7xXxayfvhNmSDNFarBdqUJD1u86wPfqyi0=;
	b=gGhDjYoJ+FftzxxEHxEt65sdxxkjYaWCN+Y8XrynmkFkm3O3LoSi1QB5/eGJAGEFOXovoc
	7u3Khya7ImR4uh3wBEN9cqPR43pwgypywJTCX5IlRl3EUiLxJbV4n09OgmLKv6d1cDWgYI
	YPhwoMVwgiNKiS+89hwaftD6K9U3FHw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-nkbuFX9HNO2jMR-24l_nnw-1; Tue, 15 Jul 2025 11:55:39 -0400
X-MC-Unique: nkbuFX9HNO2jMR-24l_nnw-1
X-Mimecast-MFC-AGG-ID: nkbuFX9HNO2jMR-24l_nnw_1752594938
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-453817323afso35209925e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752594938; x=1753199738;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vw5r3Akmq7xXxayfvhNmSDNFarBdqUJD1u86wPfqyi0=;
        b=YJQmxPodS2jd9E0vCb2sHeZMzC8pRh5pHqxEeHAjL4Xy9PAnuuPMME0MKR5smuq3V9
         YQusOhyTRig4YryCwwVoeaYZcR6ZunNKtv50P3Q93U8pOvrJTbp1Rus2PprdXm3PUK4w
         S1sPlHXXHgfYn3r7lAjKxHRlo7Ul8WmWPFs9GoKGNCHLz3BaeSq0OGpsQKX62lzL9T7J
         4HXfitBf8NlpknbFtGWBlBWiEP5Ff8lM/TOjxPAO0I1O+YPOltd6qPsjPlEZsiBJLEwT
         MGk2XysQJPjPggcUXsB/IuwDeaD66wUpkT5YhQzfUMvwJou8SKxN+vfB4oY2nI9n6IXc
         bbsg==
X-Forwarded-Encrypted: i=1; AJvYcCVpPl4wcW6mSOw58LAyX0MXjuFsDzZCIh9JbyEhnThhlkrJo/lPZ768FHIjmutSk0892yyHkbMZSObU/H4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9hZY9M5vaJCnbQSHZamXY9klMEenhkDA0SfkfhUe6pHnndAXS
	AMYdsZC33GSkBLlQwNCMJ8U6+ltghgdclmKdRUaitzbhGZAMc6hWhe3JjB7n3fIaqwGrZtmbRLD
	AG6xLzvrMJShFMAiFvEZQwTGDBjybeynQqDxmKiMR6vN6gYs8occR12vuwtLytSHQxg==
X-Gm-Gg: ASbGnctZHCsoUidao7SPTzf0PxKuG4zpogpOtmD87VDUYBwn9OiHmmz2oYBwbNLdnZ+
	+REKqwPvl/BJ3hi4UjGVCQMEVSJB6R7dKMdFlh9Ya18PIdAmgSAy5N8/tds+9giRIYqj/ke2pTu
	QVklhX4LGoOgDcsB3Tl9GOx7Lynwfax4YPV985RD/U6OqxvB31lN6EeQot8Kt0/RYYrUhCq5UU7
	rK+D5SS9OhUzjge0CWbdgQhuT4TCsvDzwFOnPQ7HWuPq/+dn3A3Ry/QQXRS3K5omOcJPptb53mX
	N9AH0wzBQp+bGjwGHRf6AEaKdsCc73h7ErXC984qv8ynEHo2gvoLZ3PWEipylgFXSk8XTfbxb97
	EWSU28mhZwEtiRENhXZx1L2obkU63Wro1OkQvfZvbsjfVIzcABncMuWw9f3EDuJe3aM8=
X-Received: by 2002:a05:600c:6304:b0:43d:46de:b0eb with SMTP id 5b1f17b1804b1-454ec16cb2emr185559795e9.12.1752594937751;
        Tue, 15 Jul 2025 08:55:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGLH6MyR+39m02QpxgDnQgYYuOtc5KV6pEpu//wpsb2B99jrq4K5jhW1A3aeu/+1h6XLLeFA==
X-Received: by 2002:a05:600c:6304:b0:43d:46de:b0eb with SMTP id 5b1f17b1804b1-454ec16cb2emr185559125e9.12.1752594937251;
        Tue, 15 Jul 2025 08:55:37 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4900:2c24:4e20:1f21:9fbd? (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45611651008sm87611505e9.9.2025.07.15.08.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 08:55:36 -0700 (PDT)
Message-ID: <e70399bd-6aa0-4e65-8695-f45ae70dabbc@redhat.com>
Date: Tue, 15 Jul 2025 17:55:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 03/14] khugepaged: generalize hugepage_vma_revalidate
 for mTHP support
To: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com,
 aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
 dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com
References: <20250714003207.113275-1-npache@redhat.com>
 <20250714003207.113275-4-npache@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <20250714003207.113275-4-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.07.25 02:31, Nico Pache wrote:
> For khugepaged to support different mTHP orders, we must generalize this
> to check if the PMD is not shared by another VMA and the order is enabled.
> 
> To ensure madvise_collapse can support working on mTHP orders without the
> PMD order enabled, we need to convert hugepage_vma_revalidate to take a
> bitmap of orders.
> 
> No functional change in this patch.
> 
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Co-developed-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


