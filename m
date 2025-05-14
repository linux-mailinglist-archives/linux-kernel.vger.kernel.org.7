Return-Path: <linux-kernel+bounces-647275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10949AB666C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 10:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8090719E62EC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 08:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3808A221541;
	Wed, 14 May 2025 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IrmkGGU0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1DE21D5BB
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747212605; cv=none; b=YT4Ys3lto3bwTRT3fCIuYK+wL0l4Z/aYLvgQenglh1tXVaaK2rLuzFFensMG1uPIWNMFE53K776wwu9PWCDOBZNeW/LJzjWgpfyyEysoIDKORbXrl4+ePpoKwlGZqIIS2aVvp+J0YWTQLHh6rAAJS5L9P+X4JFXvu1s4LM/dblo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747212605; c=relaxed/simple;
	bh=nVb+I93pTRD6pmzE0Fh/NKI8QUpr2Ya891vzBBxxhfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sh1OFW/MYMBxYN0EHQ4oygrmglk39TMIymGD/e7ZmG7U/QASOizbrOvx3novU95KrwR0ffEFXJPspSP9cxZstF/uw9U9iHoARufGecYjGeZlUFU/wzzCpDANqcUFVxWLKvrGo2T9c/7PgedGH3KRpG5wGaA0Biu2JUHYxBrzYZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IrmkGGU0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747212602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XGCYzGq+10U52uzl5GrK9QGPWD9+panpGcBnB5BqM6M=;
	b=IrmkGGU03UbzRTe8sV8iYhYuepN4V4fHuo/NXMkwpEB/nlD8le2MbM4a90BCepS9NFvNNH
	vzpObk01kvze/alzRvq1zHgEC9+zunRwOj4vGdAl+MHewm0kqMKDw8fB6YXZLmrv9HFCQt
	40ha7sHQSHkW/B/2U+wn7OfjIMqQlBc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-gKjsDlxiNX2H4HW6GkkclQ-1; Wed, 14 May 2025 04:50:01 -0400
X-MC-Unique: gKjsDlxiNX2H4HW6GkkclQ-1
X-Mimecast-MFC-AGG-ID: gKjsDlxiNX2H4HW6GkkclQ_1747212600
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-442e0e6eb84so24359265e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 01:50:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747212600; x=1747817400;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XGCYzGq+10U52uzl5GrK9QGPWD9+panpGcBnB5BqM6M=;
        b=T8z0HyIjySyNdZ3QO4Ufw+PE/+9vqEeshAy8W+Y3meu3RRurcwQeaOHSKq3+Bs0BGB
         93BxO1ZkFhGxD/LrKBkIiYrsycVHSVPaDQnJbRjo4DqsRPux6RlyBeksI7Ym2dVLAXcM
         T+NFPrjnoadLS9gd3azKmuM27WJ0vIuEWSTx3fXeahh/mGnClLeMRPlpNDOrnqCDBhEt
         b0by1hUtTsSMgxUVYWrq+cELX7kudBdffUOP9RzQcSbBMyfqz2pNsEm3Kvs7KTbnmrqY
         GzWtGenTgir7+B32TZKFToKgI27IiMfcElA+I38jnPEWo87zcBZ1qrz59c5m4tN6oDFm
         bKPg==
X-Forwarded-Encrypted: i=1; AJvYcCVfZNUAmYgDbvKazUsSSDb0mVJd82h0dh9rW/H3G0j4gw3KfReOjFPZdv1Ocn5AjLRJjbOFEcnaYGiG/ow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLlyX9Re9GJk7I4FzJSWn4o/s1Fe1Frp8IUi8xm3y8gIdXKCpA
	cDJgY9DR+ZJDtL6w4HUVD5e3b3aa4vOUQLmZah8xCEwLsBeDBVm7dCOH01i/65RwvqxtTjkLq/x
	1iWGmmtxL4WSKHs6wLfcD+7jzqy2cO65rWd6mSfIfA8sk4OGGrVr0c6RHfo5RzQ==
X-Gm-Gg: ASbGncsD/sSUMRPcQU/+z7RVmMvdUcprjI2DMhLy5BS2HqRQFwKnOz8N+5JvTewOzvL
	u8GVff2sho5npomjS9XOLwlx1NlO4yBMlFkaZTfYAM7PmCrPijoZoll0IrtLGafvvPV2rvWwWxp
	TGgGLezkTaZcTOjJjqNUh9UnLMNKC8KQ+G+RDGxo1UIDPiGD1GDo/+Zw/3sliSRkUChEn+PgrYq
	XdeX6t8EkfgKy3vARCrw4qlkeKxu6mxEaNaK4h+0Qu5Ub8/gEcu0doZzR/GVzqsyzDrWqrn8dvN
	Dj6zde9ZYmTX2C/8qQaENyLur7QdRsRVFbaF4NfUDLLrOMN6f0F2h/+FjTHxdVhou6EDGmvqXxU
	0f3xOm/vRHyT7rlPerq/8P2LzR7rLU5dlPovQNEQ=
X-Received: by 2002:a05:600c:4f45:b0:440:6a37:be09 with SMTP id 5b1f17b1804b1-442f210dd4bmr22236985e9.16.1747212600032;
        Wed, 14 May 2025 01:50:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqK/FLQvs6m1u6MPRybA3SYVWQ7b8xgB1l5R/aMzznMPMuEHXl7NkRRFQ8qBzehy5+ltlr+Q==
X-Received: by 2002:a05:600c:4f45:b0:440:6a37:be09 with SMTP id 5b1f17b1804b1-442f210dd4bmr22236685e9.16.1747212599683;
        Wed, 14 May 2025 01:49:59 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f15:6200:d485:1bcd:d708:f5df? (p200300d82f156200d4851bcdd708f5df.dip0.t-ipconnect.de. [2003:d8:2f15:6200:d485:1bcd:d708:f5df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57ddfbesm19239910f8f.10.2025.05.14.01.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 01:49:59 -0700 (PDT)
Message-ID: <357de3b3-6f70-49c4-87d4-f6e38e7bec11@redhat.com>
Date: Wed, 14 May 2025 10:49:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: remove WARN_ON_ONCE() in file_has_valid_mmap_hooks()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>
References: <20250514084024.29148-1-lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250514084024.29148-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.05.25 10:40, Lorenzo Stoakes wrote:
> Having encountered a trinity report in linux-next (Linked in the 'Closes'
> tag) it appears that there are legitimate situations where a file-backed
> mapping can be acquired but no file->f_op->mmap or file->f_op->mmap_prepare
> is set, at which point do_mmap() should simply error out with -ENODEV.
> 
> Since previously we did not warn in this scenario and it appears we rely
> upon this, restore this situation, while retaining a WARN_ON_ONCE() for the
> case where both are set, which is absolutely incorrect and must be
> addressed and thus always requires a warning.
> 
> If further work is required to chase down precisely what is causing this,
> then we can later restore this, but it makes no sense to hold up this
> series to do so, as this is existing and apparently expected behaviour.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202505141434.96ce5e5d-lkp@intel.com
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
> 
> Andrew -
> 
> Since this series is in mm-stable we should take this fix there asap (and
> certainly get it to -next to fix any further error reports). I didn't know
> whether it was best for it to be a fix-patch or not, so have sent
> separately so you can best determine what to do with it :)

A couple more days in mm-unstable probably wouldn't have hurt here, 
especially given that I recall reviewing + seeing review yesterday?

Fixes: c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback")

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


