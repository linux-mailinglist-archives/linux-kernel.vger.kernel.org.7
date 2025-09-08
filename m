Return-Path: <linux-kernel+bounces-805698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A44B48C71
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3F7C34204C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01E32EAD19;
	Mon,  8 Sep 2025 11:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CRR/+b1s"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B721D5150
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 11:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757331847; cv=none; b=t0LXMkHIVaNQ7GSBA6CGWk5axUiO18wNQASrjoRxFrYQVrMr08rN0dOzD23JujwWrEdrK52Nh1UbyI4qK2/UOEmza5F89JXrAUvrG+Jg5tGe/Ic+9YVoVeH/tqAXku1PY/ItDa1KuMDDHUX7q+vVMlWf3xFd6DC96hNuG36pipQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757331847; c=relaxed/simple;
	bh=gG/Eap0djU4gnQOXZdm0XhV2U6fmKYGUjrK2QDurOTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kghorkfuwdarycyOzmWen0pbhsp3zpoLif6dvNX8iLEY3igwaLf3ewJ3Mwx0Ut8kQx8VJXc4+j5J4uVtvQuUV8ApfoJnvqCPJCLdwEG2prFE2HuZVDUsMwGC6Rh74IMCUOpZxt/EMu43hhAYvX3MLjz5ogyNhJ6NJtHgag5KeLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CRR/+b1s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757331844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CmFdD4nxV6YC4HJPP8iLyH9DUD7av90TuxW2EMz1tUQ=;
	b=CRR/+b1sMkn3J3o77yQzYiODzPCRrbMWuiQUZGauLazEcy9d+Ux2U+DtyB5AMUIeEgT2Q3
	P/hywwecKjx1DWIEKuOUgoETvPYduM2AnL2KEuqbjg7tTX2W4xpl1luIVfU++Y+u8zsqZW
	CVwKwOh5S0svLyyGkJIFt29YPcQbx7Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-YzY2ySCqM2--v5EZ__oFGw-1; Mon, 08 Sep 2025 07:44:03 -0400
X-MC-Unique: YzY2ySCqM2--v5EZ__oFGw-1
X-Mimecast-MFC-AGG-ID: YzY2ySCqM2--v5EZ__oFGw_1757331842
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45de13167aaso13352595e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 04:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757331842; x=1757936642;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CmFdD4nxV6YC4HJPP8iLyH9DUD7av90TuxW2EMz1tUQ=;
        b=jksYMblOgCaZwGX6sIztuuaRTkQ2yraItHv3pQrtxxXchyii7yeZLRvf5gI+sf3EAq
         V1+2HPHUPR0kgVWZAlSgCTXYC5wa4FqzmATkjw0JbywfiaJBjVAktcMfccEOUAguGDJZ
         tLmakkIAAbMTy1YnV5WvcQrPvSm+I6FkQAhF5ZHzp9hEfQkkdA0GX8r7kKraqoUccrhM
         nWNabACCM1FMAv43kxf2kMSLlg1CRNsm14oJVY9c8rd+6vbps5kpt9plqVxrASqtDUEM
         5MiXrCpKkdJqDyVm+h2j/dRSFwix8ZSPh7Dk2jkFg2iZPI36w2HTjI11oKNtmXpnfRMB
         X++Q==
X-Forwarded-Encrypted: i=1; AJvYcCWeZPuPWHFyEuI7Ikh2x9B55K7lGa+XIF67+FJJnW8avA55zN4tQJ/89GVnlBKHd8cLS9CSWLbLVXFNEsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxaTORIwuVYpPre2zaqXpAUN13QZ7PcrfOUtab3ChUh0TkkeBC
	sf1sW73O+6Plb2DnGMlhUkkg+AoRFi72moXAMp+GLz28wWDy8W9U2rvniRAOj9HmUWJOpXuQu9x
	JbwW2j1i8Gpsr8jfIf3QK0EYXhG2iCuhTFU4O0eOelTtn4g99tHSCG8XRs/HvMo4qug==
X-Gm-Gg: ASbGncuCvFmk2QSzbCE01xcqYWj0ZphQuNegQW+IA5BQDHv4NGjCgOFz9vb17DZSgQv
	y+uDK3SI3A4Vh6ov5gjvK+3cRWpEAIDeCY2waWmDByJDCAl8ctTjw3L7Ku2oiXUa0tzm2WggEkB
	nCzbwP7wk3IfZL4FIYiSY5Erpib4GOtc6U+l9B06d2/uL6PulonktXxvHS/XRVM+ego0jPOTXW9
	D4VnER/SlA7YhtETTQGkNRrQFkViDE52Gxas0A2NsSVi6Pc8NMRInfiknFdRANrn2CHmEeMeiKc
	OWrF7iZWCrQb/biIgJ82vF0aUtKN3I21ksiPkS7llQQm8Sa9FaIWTsbQSqG20rCKpcOKOIJRw9m
	/S6vo9mjb/bLvpOYRLS7UGxvyT4WQ6AdcgxrZG8baVkdEdFm3fBA/p849JXPKYnjb
X-Received: by 2002:a05:600c:1f0e:b0:45d:e326:96ef with SMTP id 5b1f17b1804b1-45de5557e89mr35555135e9.15.1757331841960;
        Mon, 08 Sep 2025 04:44:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtBSAgOCpmqTXUYDC4XOAO5a81XVKsZONohNsCKy+e2Mdrkk9gBTpMEGZ9PIHtxa80WOMjqg==
X-Received: by 2002:a05:600c:1f0e:b0:45d:e326:96ef with SMTP id 5b1f17b1804b1-45de5557e89mr35554775e9.15.1757331841536;
        Mon, 08 Sep 2025 04:44:01 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:700:d846:15f3:6ca0:8029? (p200300d82f250700d84615f36ca08029.dip0.t-ipconnect.de. [2003:d8:2f25:700:d846:15f3:6ca0:8029])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3deb99d10a0sm19732644f8f.37.2025.09.08.04.44.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 04:44:01 -0700 (PDT)
Message-ID: <ca6c572f-e63d-4de9-895f-2da4a2658c46@redhat.com>
Date: Mon, 8 Sep 2025 13:43:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] mm, swap: use unified helper for swap cache look
 up
To: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Chris Li <chrisl@kernel.org>, Barry Song <baohua@kernel.org>,
 Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org
References: <20250905191357.78298-1-ryncsn@gmail.com>
 <20250905191357.78298-3-ryncsn@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250905191357.78298-3-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.09.25 21:13, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> The swap cache lookup helper swap_cache_get_folio currently does
> readahead updates as well, so callers that are not doing swapin from any
> VMA or mapping are forced to reuse filemap helpers instead, and have to
> access the swap cache space directly.
> 
> So decouple readahead update with swap cache lookup. Move the readahead
> update part into a standalone helper. Let the caller call the readahead
> update helper if they do readahead. And convert all swap cache lookups
> to use swap_cache_get_folio.
> 
> After this commit, there are only three special cases for accessing swap
> cache space now: huge memory splitting, migration, and shmem replacing,
> because they need to lock the XArray. The following commits will wrap
> their accesses to the swap cache too, with special helpers.
> 
> And worth noting, currently dropbehind is not supported for anon folio,
> and we will never see a dropbehind folio in swap cache. The unified
> helper can be updated later to handle that.
> 
> While at it, add proper kernedoc for touched helpers.
> 
> No functional change.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Acked-by: Chris Li <chrisl@kernel.org>
> Acked-by: Nhat Pham <nphamcs@gmail.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Barry Song <baohua@kernel.org>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


