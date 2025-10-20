Return-Path: <linux-kernel+bounces-861103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6886BF1CC3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3EAB18A74F0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3042324B16;
	Mon, 20 Oct 2025 14:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0VyKf3r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F28E321F2A
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969916; cv=none; b=jyWxQj50R/SM+HiWtUWFvDcuiXt0q2+Hom6ipSDsH1BhT30wmBC5htolua3bAQxiVCEwNm1bVf3Hdzemcjf3bQaLJJq/Er5UNdJ5I/R5wbmoOCr1Enc9BYrSgax6oD8EjsN7GStPD9+70J0+u36LfRb0ITL4i4aZTkTwNqxXLd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969916; c=relaxed/simple;
	bh=aIPru0uvHuAPEIsOeAja3hKsFILc2tBOVKf9Zn7f52c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPsvtEhlJT4zu9CFcIHZIDprhvzcTFEf+kqa9/qa9QPTiIjUTkyYISZ58P6b+MdKryXkpSs5bFhjWTJy5HdAjdttTxYl1UPExAcjRcnaqhR/rA+Il4xzRFzjkjL0CAM5McogJ7iagLm5D5Y/83dpUpc133R5BuuVAap3CF4pY4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X0VyKf3r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760969913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CbmQBy23LCiuOfKHlXWD6EvZKXrnsYz2+mUVkRTJKTc=;
	b=X0VyKf3rRg2VG8vd9aEnEbCDy75e3Z9nxHMQ8pyVkRT3oY6yfWOqTaALdSjr/QeMMOxSI/
	soESww9Dgr8GjnN6oXd78rIz3GHMt4z7puN8myesxLkIuFIWGKBBdQKRU6HJtS+5iusZ3L
	RmrSc/MHRvsnWQY2wsr3rwL5D+/NDN0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-fA4Qgo7gMZGaparUDn8jsA-1; Mon, 20 Oct 2025 10:18:31 -0400
X-MC-Unique: fA4Qgo7gMZGaparUDn8jsA-1
X-Mimecast-MFC-AGG-ID: fA4Qgo7gMZGaparUDn8jsA_1760969910
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e47d14dceso26125645e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760969910; x=1761574710;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CbmQBy23LCiuOfKHlXWD6EvZKXrnsYz2+mUVkRTJKTc=;
        b=t2mujZPKmqplMnB8X/BpSqxXtzmrsxMH+3NCA+COpuNuK4w93osIJ5FL+q93PkBTN/
         5xbZQW2qAh0qK1+jEYv8//+sTvpovISXd87VeObEGMA+ApDzo+jY4TQ8wiQ+7sQNpJXa
         6GsWby8tnyz/JzJYvwQ+hwCIYLtdN13s++Kq9e6ykc3n1U8JJYaWdj/Fv6RP86nS7JBE
         dUvyrKYcRMFvg4H6TzBzP/GFr/XYFGmTeh6Xn7tN3OaouDQf305sVKe4odgYFhuKRu2m
         4u9658I1F9VeJHNm+/hW+ck0RbepPxI11vvWlXZMKivhPxCcSYB4Vpi63Wg/pUZECp7p
         0cuw==
X-Forwarded-Encrypted: i=1; AJvYcCUL49pkOfKZyfjw+3AP6AGsuAWjf3K1k87p32QBnltg6up86/NSHeaBi+4b1ybKLVlapgl8MGGW9MTGXCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx01vNs2pjUhFo/4JqOROiqcktAQJ446Tjt3lr8ilRYJ35YDEdy
	uNrjo7IjL9mvK6ebiJFzaSOhcYajlHvTXUlRB2ji+OKX027A0yU/ANODWqqjMe+Og1UVL+bypaw
	7rC/eSSL13exIuRbsLUQV2aRJUjk6lZxYirBJYaRcy7O6aDay6TFWIOIxVSD1jQVsYg==
X-Gm-Gg: ASbGncsdaV4BN1wcJXDGmqtYn0BzIfmVbvvsmpgOBRMJp527Au2/BlW3Gnjp/mHFmYu
	BrTPr/OuoC8osilDpLeLAx+8NCxQU+RytoYZeJqgk5yj1hQXVXIx5U1rUq3B+FwrBJT/jWnnNbn
	KaJLIO0hFaDKAf3o5tnRjRS1X0cc5LF6LiYnPUCI9joS2+bZUN6LGAln/b9AWT8Q5BiyA1ryPtp
	YKSA5upNzmXL9+2zmzff/U+LnUfN8ROSBnt/lBDAN/FiiqmSE4UERuzSTNVXkXTjOqQeSuJB7Pn
	SR148wXnNnn9psdkxaMXFpY4+fbSTkMRiEVoYiGWYivk5CPk6Ir1KHPDPEyxnAhvkZfECgBlHnD
	cibAzRrgG7/0dJ4NkSmKo1Yiysi9nwk6dpx532V8+PK+seBnzX+plvTlMo3calZPi1GFU3pIeXb
	xOApX0goiFkGz2i39YOMZnA1pXzv4=
X-Received: by 2002:a05:600c:548c:b0:468:9e79:bee0 with SMTP id 5b1f17b1804b1-471177bc126mr92534055e9.0.1760969910136;
        Mon, 20 Oct 2025 07:18:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsUGz0BXOz2SLK8Dd2l9Tdy62O6DxEOlun4H0tXQ0zb/7yzsBhRuSpLJ8u49cmf7DLc1dFkw==
X-Received: by 2002:a05:600c:548c:b0:468:9e79:bee0 with SMTP id 5b1f17b1804b1-471177bc126mr92533795e9.0.1760969909687;
        Mon, 20 Oct 2025 07:18:29 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144b5c91sm232102995e9.11.2025.10.20.07.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 07:18:29 -0700 (PDT)
Message-ID: <5dac6df9-2d47-4322-89eb-65a88d237c35@redhat.com>
Date: Mon, 20 Oct 2025 16:18:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] mm: Introduce vm_uffd_ops API
To: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 Nikita Kalyazin <kalyazin@amazon.com>, Vlastimil Babka <vbabka@suse.cz>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 James Houghton <jthoughton@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Hugh Dickins
 <hughd@google.com>, Michal Hocko <mhocko@suse.com>,
 Ujwal Kundur <ujwal.kundur@gmail.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Oscar Salvador <osalvador@suse.de>, Suren Baghdasaryan <surenb@google.com>,
 Andrea Arcangeli <aarcange@redhat.com>
References: <20251014231501.2301398-1-peterx@redhat.com>
 <20251014231501.2301398-2-peterx@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251014231501.2301398-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.10.25 01:14, Peter Xu wrote:
> Currently, most of the userfaultfd features are implemented directly in the
> core mm.  It will invoke VMA specific functions whenever necessary.  So far
> it is fine because it almost only interacts with shmem and hugetlbfs.
> 
> Introduce a generic userfaultfd API extension for vm_operations_struct,
> so that any code that implements vm_operations_struct (including kernel
> modules that can be compiled separately from the kernel core) can support
> userfaults without modifying the core files.
> 
> With this API applied, if a module wants to support userfaultfd, the
> module should only need to properly define vm_uffd_ops and hook it to
> vm_operations_struct, instead of changing anything in core mm.
> 
> This API will not work for anonymous memory. Handling of userfault
> operations for anonymous memory remains unchanged in core mm.
> 
> Due to a security concern while reviewing older versions of this series
> [1], uffd_copy() will be temprorarily removed.  IOW, MISSING-capable memory
> types can only be hard-coded and implemented in mm/.  It would also affect
> UFFDIO_COPY and UFFDIO_ZEROPAGE.  Other functions should still be able to
> be provided from vm_uffd_ops.
> 
> Introduces the API only so that existing userfaultfd users can be moved
> over without breaking them.
> 
> [1] https://lore.kernel.org/all/20250627154655.2085903-1-peterx@redhat.com/
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


