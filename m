Return-Path: <linux-kernel+bounces-732186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5ABB0632C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55893567CA2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE6F23BCEE;
	Tue, 15 Jul 2025 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mf+4EU1y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3E81FF7C5
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593955; cv=none; b=KwHuUpdPYpmt+qVBvlaDGOMBdbLsgizjhsKb09peqRlxU3zRWgiIb2mas/FBqC1lVHFDxyFRCxGUjaIbevErBcrtPhqxRzd7l8ieeWWrymJvaO2Klwtqnas8c0GZcxVROnwy79cs8dhplHi+VJkDCAHLbZsGRPDZOfWUMZu7Hxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593955; c=relaxed/simple;
	bh=dTz/J9wlC+nywxQTpGo4UF/Z0sNT7Lcm+tM61+gHrNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e+q5EtqtOKyiGtK+JIxtXkV61JoHIXAQqhKbXl5y+3P3q9k3RAj7qOymNuLPJGpkkfjhLHKNBnbR92MT0eCEv15zNkcRx8UkOpPXS+g4Tj19kNgEetm+eX37q/K2G1jYnOTVojxFEMZAX6xvi9DqrWsFPD2QK8b+9iXXbYFf+ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mf+4EU1y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752593951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UHM4gZNCeGPf0Dq25GgumpITXaeUKp0zRvBNhoIXd98=;
	b=Mf+4EU1ylWMaOu2sjZpP9WBuDOXofTRBvj0nfBSZt0d0nwO6D7MpbKc2eG9h9BEaN9TUe7
	KRGn7yKOnghnJZ9WElG0ebqE3x0NJJmCkQn0pv8dym5vfYRapfx2Y52uItF9gOt+ALVUlx
	nRCDeNEWKvDcZswUzhrn0h6BIBALHDw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-bhYby0nFM8u18m4XKAt3Dw-1; Tue, 15 Jul 2025 11:39:10 -0400
X-MC-Unique: bhYby0nFM8u18m4XKAt3Dw-1
X-Mimecast-MFC-AGG-ID: bhYby0nFM8u18m4XKAt3Dw_1752593949
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a54a8a0122so2925536f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752593949; x=1753198749;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UHM4gZNCeGPf0Dq25GgumpITXaeUKp0zRvBNhoIXd98=;
        b=P/5/6fW22kLZamLl16Hg+oVphe0Y4cW1cU7gJScU1UPvoyWow4u6HBnFXvuP1Pd/4R
         REu+t2McZGfXpXblO2eyf/TUOuIcIjc4uLXAiMxQOS4+A+5UOSJGOHhaddOs5O3mEHpY
         Fy/VSXHEWZ+WkkRJSApChnp1pjLfFcTpACDWo+hXpA+KVlVPHHCCim8a6pS5FRlzW9jU
         cveS+Crgnox7iVsaZmIwO3ZaTEQz3Akhya2w6xmrIzpRvLk/z1KHxpHiMj0kAFNH81rY
         txVujoKjzv06kD/Vf3PMsdKY4wcuaDRAHmN+TUeSl4xRb78OIgJzFRhG0WE4ABeMMdHb
         Z94w==
X-Forwarded-Encrypted: i=1; AJvYcCV/czU2amDz43EBMIaucgkpoaoSfRVbrVDdexlySbV0O9ryHlo1ls5r6h608vffxbSq5q26DALEnohBxK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/GlFFfQ6/9l7LKckrfMFpXBD0aDffGmzqzK6oG+8w8Bad+RrG
	vF4gbEb/Bwl8bwhLf/bg7j/Lu2wAfHW29/pVOYLZby1AzUl3EXpgdxD1uL6hhW0gp1VldpNoUye
	tf+Barh/DpQaVfmNl52U4rBU2n9KIEMzUYf9fFBcl7hzRzdEiZNS6yLkCNB7JX8vvmw==
X-Gm-Gg: ASbGncv9RE9q3cVVbuqAeNTNu2t0quLVt8IlcpTfBHMnqvY3zo9QCgCUADm8tLvABw+
	CIzSGRSVZaV8SzOkXTMp07j5vfx3ypZiJZWULRU5DU4iOrT/+HmQmVW6YGd+lbtCUx6uhriVj+q
	AFe+Y3y6aKthafQNKmJel8iRno6hcNZQPzfB+zbKt9auf3+QZ4oUol97ZbT9JHCQGDqxdPODu06
	gLS2Da1S3pqvD49PK/6L1c2SJoXjxsaXaoZcA2ZAwRHgct/qJRwZ5vMOh0u+KVkZ6ADbjZs3eGK
	7thBOpheNo/V0H0eWEO0gYesnH2iBfHgiH0Tjk0NkmCLmYj+3Te/m2PXxZ7m4YYvAShWm5GStGM
	FfuAHEMbVerd9rko9T//AurkYmm9HQZkDtskwL9duUPKV//gfqkTrl15a5evBHpFu48I=
X-Received: by 2002:a5d:54c1:0:b0:3b5:def6:4e4 with SMTP id ffacd0b85a97d-3b5f18dc957mr12722519f8f.46.1752593949284;
        Tue, 15 Jul 2025 08:39:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtrPZ5XjleiUjEdSdNotNWI9zAnnUxsYftwPbMASEv5sC7k861KNZN1awNoAXfH+5ERC81DA==
X-Received: by 2002:a5d:54c1:0:b0:3b5:def6:4e4 with SMTP id ffacd0b85a97d-3b5f18dc957mr12722472f8f.46.1752593948800;
        Tue, 15 Jul 2025 08:39:08 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4900:2c24:4e20:1f21:9fbd? (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1792sm15715844f8f.13.2025.07.15.08.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 08:39:08 -0700 (PDT)
Message-ID: <f51d923e-da89-46d7-8e3c-702f055b78ca@redhat.com>
Date: Tue, 15 Jul 2025 17:39:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/14] khugepaged: rename hpage_collapse_* to
 collapse_*
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
 <20250714003207.113275-2-npache@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <20250714003207.113275-2-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.07.25 02:31, Nico Pache wrote:
> The hpage_collapse functions describe functions used by madvise_collapse
> and khugepaged. remove the unnecessary hpage prefix to shorten the
> function name.
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


