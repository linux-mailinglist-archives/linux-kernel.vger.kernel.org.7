Return-Path: <linux-kernel+bounces-836151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCE0BA8E15
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16F3C3B07F2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD842FB99F;
	Mon, 29 Sep 2025 10:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YtMQXGic"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53762F99B5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 10:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759141339; cv=none; b=jhVnBbb8AOs0Wbhw2r+WZ35TraJLswkVDnCyCCbZeZhnBAA1DYjxhzBnTwx/lULfDwnOzyZKYJUHzpVUVZrKSOacUEdtpwVSnmLGkBT21exg3Pc97CKypgBjP4IH1wmxZ2ZzBJB5luUyg/hF8cvidmRmc6Qmr2ZB5SCq80rvRQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759141339; c=relaxed/simple;
	bh=YJjG7q3oPFCJAUZOA6f3h4dExpYvsQPN2rafoNzBl5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kMuXTpGDJluy7f9MUfr+hrjXldCDANaFUzflhOMBY+UNSWVZ4G02pLP+hHdA0bQAHnO3JxnkDsOMLig8RnU/yIQtOpzOJiemQ4dRvovWvZIMEYxVUZa5zAStfqznd4zRSb+r6XAb4WXPMQbX68Xd9RmlWzujYihdgr4MrkAn5hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YtMQXGic; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759141336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gTfF/9tS74v6KOk7XL7uKXLPFCkMs1I/RkhQW/KFaXg=;
	b=YtMQXGic0zcUWMy5w9ZygH5nzY6ZG086HjQAYfVmgpA12ON/Xy+ilCouQJSLVwwePXchSn
	iZsGmkmo/jxjJoC64g7hJjNReKkcuPnw9774t61JPqIyh2w4h53jB0kZE+F9K5JC5u9lCM
	8BDgormXZocdyBSq65uvs9VRVwhPAD4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-wIsvcuDUNneXwx4DHJdCqQ-1; Mon, 29 Sep 2025 06:22:15 -0400
X-MC-Unique: wIsvcuDUNneXwx4DHJdCqQ-1
X-Mimecast-MFC-AGG-ID: wIsvcuDUNneXwx4DHJdCqQ_1759141334
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e44b9779eso12429495e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 03:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759141334; x=1759746134;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gTfF/9tS74v6KOk7XL7uKXLPFCkMs1I/RkhQW/KFaXg=;
        b=FqFkNyf0AIybaB4v4AsQgnHQzDj795ExqlkGl4GSCkjUmv48TpFQt0e7E6Zaui0LsG
         8EuitFWqAXUpXWZsh/z7x008jUNBuregDM9juZA2+Am4YLea78+IemV+JXJYHoQILokH
         PQOzuMSTaCPkR2EV9VOiESHX8d0jb8ww9ubzgHTmslGub0ftBODX68jKA1YP+mIkqZUC
         faYD9I9TPrxW7zXk/YhRE5+jj/t/92k8PAJpMngxcvWAoTGkvEGDLm/Wr4yK8HNQvii3
         mTIHgiSW3/77X5QOL0p1p3+whZ9h7ZHA+r+84TMkNWDlTkegK5MYLp3+c9g1V0YNcqW+
         ARuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc3gWUquVGUd/fsR7Tsm9iSkpjmvelnMtCtyEn1qCJyy748dZnfc5R9lP/vwbOTpKuFWZc4Cw9XHaCPZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl0fpn3OWGZWOeX+d3CXV8nWDYDt5eIiIFHG25emEvgjDEGt+4
	3i4iMjkse599cQO4IptvmyHcR1gXmLX2KRUOQCOibG0UTSR0MULpGZPpH1i/bQlnJmgWcI+U2Ef
	CkXRI7BzY6cs9xb+GFeBcYE3SNL5L4FgiLiVS/UwnImJO35+yk202ZGScXzV6xQJnoA==
X-Gm-Gg: ASbGncur0x/9nAiH8B7o/FTqrSogkethvBHybOeepFOGp7dZ2G3uYvvbT2u2MyrHuMF
	UEzxy6cq33WoXuru5KNM6Rb7BWODU/dBztLIzfTfnusdHq2zC6QWcTs8LAk0PP/jBBHyhHvjywH
	tgnxTgyLkLS/Keuarv9+WW0pFe2vQZ5Ae6olvugM8x98OVcnJMzonT1VXHJVTOszjtD6P1QK3r5
	MlmZx+6GJ+eK/TRllIBape36DHuw+y2w0hxmxR96JgvU9OWkPD7iJAePUzwH7yCS64SOg0RQoB2
	VL8jTZ4z7NdGzzmoAA2xhLcdxZ7FUFtuFUcXihG8B+WtSZRhpqbda0e6FTfR2SXplkYAm6Kr
X-Received: by 2002:a05:600c:1e85:b0:45d:d5df:ab2d with SMTP id 5b1f17b1804b1-46e32a03456mr153455625e9.26.1759141334042;
        Mon, 29 Sep 2025 03:22:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcPTC0WN8sznaK2VhvNvPmXdMZ5tY9SOo2+KWlJ8c8Cfvq/5YcnNrrC/JndZbTtN7rU24FIw==
X-Received: by 2002:a05:600c:1e85:b0:45d:d5df:ab2d with SMTP id 5b1f17b1804b1-46e32a03456mr153455355e9.26.1759141333625;
        Mon, 29 Sep 2025 03:22:13 -0700 (PDT)
Received: from [192.168.3.141] (p4ff1fa94.dip0.t-ipconnect.de. [79.241.250.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb985e080sm17624009f8f.24.2025.09.29.03.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 03:22:13 -0700 (PDT)
Message-ID: <d2fa49af-112b-4de9-8c03-5f38618b1e57@redhat.com>
Date: Mon, 29 Sep 2025 12:22:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] KVM: guest_memfd: Add DEFAULT_SHARED flag, reject
 user page faults if not set
To: Patrick Roy <patrick.roy@linux.dev>, Ackerley Tng
 <ackerleytng@google.com>, Fuad Tabba <tabba@google.com>,
 Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Kalyazin, Nikita" <kalyazin@amazon.co.uk>,
 shivankg@amd.com
References: <20250926163114.2626257-1-seanjc@google.com>
 <20250926163114.2626257-2-seanjc@google.com>
 <CA+EHjTzdX8+MbsYOHAJn6Gkayfei-jE6Q_5HfZhnfwnMijmucw@mail.gmail.com>
 <diqz7bxh386h.fsf@google.com>
 <a4976f04-959d-48ae-9815-d192365bdcc6@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <a4976f04-959d-48ae-9815-d192365bdcc6@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

                          GUEST_MEMFD_FLAG_DEFAULT_SHARED;
>>>
>>> At least for now, GUEST_MEMFD_FLAG_DEFAULT_SHARED and
>>> GUEST_MEMFD_FLAG_MMAP don't make sense without each other. Is it worth
>>> checking for that, at least until we have in-place conversion? Having
>>> only GUEST_MEMFD_FLAG_DEFAULT_SHARED set, but GUEST_MEMFD_FLAG_MMAP,
>>> isn't a useful combination.
>>>
>>
>> I think it's okay to have the two flags be orthogonal from the start.
> 
> I think I dimly remember someone at one of the guest_memfd syncs
> bringing up a usecase for having a VMA even if all memory is private,
> not for faulting anything in, but to do madvise or something? Maybe it
> was the NUMA stuff? (+Shivank)

Yes, that should be it. But we're never faulting in these pages, we only 
need the VMA (for the time being, until there is the in-place conversion).

-- 
Cheers

David / dhildenb


