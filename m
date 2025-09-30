Return-Path: <linux-kernel+bounces-837498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C26BAC721
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4881B1924A70
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5932F83D9;
	Tue, 30 Sep 2025 10:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4kvOLcd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EECE220687
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759227526; cv=none; b=HJS6srGxgArk/Y2e65r8gQuTWIPoD0Ug+p7PE/iwnFBKyxedabp6hpfDcaYa2fI6G0Xg/JdTlKzMSRqTaHVPHWwCZz0K+SKz3Jk2YfOntN/K8jkWj4rQz9GTZZR5F3XGnPaBLPsce8/sNjgeEmQAJuOrzpLy8oVEcHLM8okcHm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759227526; c=relaxed/simple;
	bh=gHjnkf3vqrU3mez0Ad8z6Qt5sdnlepvVxXCq9Rmck3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JHVFGsxNpR7J3T0vQPWo5ZfA7klzzipGklhkpbEsF47Ukstk3yH5cKFos9GPBLo2Qj6L5NuVQilUMaUUbL8vOBJugy06JfuLo5lsguPmmTEP4+X5huSDodywAytOeM/ZMqSu3YND3L+bpadQr+8Wqt25qX9F7tap1dfA37quCHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U4kvOLcd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759227523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SGQmqTN9UVzJt5VlxNDbtC1eGMpZyThEwsqWNCnufmI=;
	b=U4kvOLcdLjEb8q4ljFeR2G0mXJgP3gnzs4DTLiD7RYPIm/K1CxcA0Qp7ewqYG11Wnm8gyB
	u5++HyRzEIQ0feIoc6+DqXMypr+Pg2KKKdNmX1lG3KTNjXLXLGgyeRgu82ILLYXAI9eFMw
	VLqyAr7T0cwRO2kffH48FrMT8JYCa5g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-kYxxdpCMNgaflajVL6HdcQ-1; Tue, 30 Sep 2025 06:18:42 -0400
X-MC-Unique: kYxxdpCMNgaflajVL6HdcQ-1
X-Mimecast-MFC-AGG-ID: kYxxdpCMNgaflajVL6HdcQ_1759227521
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e3d9bf9e1so23218085e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 03:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759227521; x=1759832321;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SGQmqTN9UVzJt5VlxNDbtC1eGMpZyThEwsqWNCnufmI=;
        b=rN5/x+kovtv73EJJ5mafce2zSZQRA0VUMbwVdCHXvAr1LiT11kX1mKJmDnm9XOl+Rb
         qSYKDLMbtINzh2hjl/vEqDu62mZVF/Zom6U+URb+AuEggzJyMAN95KIlW4wFt7fdGhFN
         zDwD5I+sbPSP3fNZ58HYaGjQ0svsw9IZcnG8BqZjWBpZxbHy4eA8Qpum1skzvniGdOaA
         YoR9vPqjTubh2G4iYd8t/3QF+BaxXMZ1yjnkrv8Ar/op0JoQXm5jTjIhp3aIrfF9yTF3
         1J1iYTu2hhSVCqF9U9K64nkFd2gXw7cgFn8Txic3+1WLT4WFSn9XGwlF8Y5JwzkxaT8x
         iUwA==
X-Forwarded-Encrypted: i=1; AJvYcCV2Z3bGL1Z5PoUt6t3ormo9rEWY1sE4fuqBhsVYpvVfnwSicUpJcrAVzubs6BYPLz2JpCpCv/guVKOZ6XQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxufhHEF9qx/SziMyqeTZ8wBLHy6WQBN04CCfnzQ0jQNqSJZAW/
	XECRFvTChkZzN477cAlLdN2Nafieih3pH5h8pXmbHyeyI6dc+ixXM1o4bqiDIjScJmVIRozpD0E
	a8dD+aA3lVdElYto0DdDgEiHi34I2BRawGFWnUHBQTfcOq0y32spN7A8LZ2BSbLrVwctzI2O1cA
	==
X-Gm-Gg: ASbGnctAyFt8hV7RJdezehrUXY7Na/xxWQv7c+dkyvrVnfmqOwa1KAgHEr+tPbtfvj/
	BOu4F/0Bw9WaBHs35nplRNLzVflsV7u7YEdCNs4Z9tpKbpEvCamm2pZv/ENb3oxL5wI2D81R8bA
	/XH2O/53LhKd66t2Qr020ZfWep6PJwyAG1UVxnbMfNFWMuoREPqMr42NKF68/nmwFKy/rVJl4YC
	T+kAgKHoceyyXtSDm+B+phtfdnm+eGKMZht3B8XFmVk7CuouZ7gq2aPyRVVFAFNuh0lzBGW7AND
	TEmk5YzucpyqgrPwgiMvJU7ocX9m1ksi1anAmD/FdC9h97zDLoa2alJNqx4DuCW/MHGEN1+2ZnE
	1j5SgQ3/3
X-Received: by 2002:a05:600c:3145:b0:46c:d6ed:2311 with SMTP id 5b1f17b1804b1-46e329f9d06mr159524555e9.19.1759227521236;
        Tue, 30 Sep 2025 03:18:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFznNgdi9tc1XwBIaCPvR9T1IUai6bfy8CZ4nfYKaSegh3zkEHoAxrSeANzdq09JMiPpJO5fg==
X-Received: by 2002:a05:600c:3145:b0:46c:d6ed:2311 with SMTP id 5b1f17b1804b1-46e329f9d06mr159524365e9.19.1759227520813;
        Tue, 30 Sep 2025 03:18:40 -0700 (PDT)
Received: from [192.168.3.141] (tmo-080-144.customers.d1-online.com. [80.187.80.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e56f64d06sm48925495e9.12.2025.09.30.03.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 03:18:40 -0700 (PDT)
Message-ID: <186ef2e5-bd0a-46e1-a88d-2fc5448c1c72@redhat.com>
Date: Tue, 30 Sep 2025 12:18:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] mm: Introduce vm_uffd_ops API
To: Mike Rapoport <rppt@kernel.org>
Cc: Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Axel Rasmussen <axelrasmussen@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, James Houghton <jthoughton@google.com>,
 Nikita Kalyazin <kalyazin@amazon.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Ujwal Kundur <ujwal.kundur@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andrea Arcangeli <aarcange@redhat.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, Hugh Dickins <hughd@google.com>,
 Suren Baghdasaryan <surenb@google.com>
References: <20250926211650.525109-1-peterx@redhat.com>
 <20250926211650.525109-2-peterx@redhat.com>
 <f1da3505-f17f-4829-80c1-696b1d99057d@redhat.com>
 <aNur9nbdnlykqbU7@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aNur9nbdnlykqbU7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.09.25 12:07, Mike Rapoport wrote:
> On Tue, Sep 30, 2025 at 11:36:53AM +0200, David Hildenbrand wrote:
>> On 26.09.25 23:16, Peter Xu wrote:
>>> +	/**
>>> +	 * uffd_get_folio: Handler to resolve UFFDIO_CONTINUE request.
>>
>> Just wondering if we could incorporate the "continue" / "minor" aspect into
>> the callback name.
>>
>> uffd_minor_get_folio / uffd_continue_get_folio
>>
>> Or do you see use of that callback in the context of other uffd features?
> 
> If someone picks the gauntlet of refactoring the loop in mcopy_atomic()
> we'd need a similar callback for uffd copy. And as I see it it would be
> different enough to warrant emphasizing minor/continue in the name here.
> 
> I also think we can drop uffd_ prefix for the callback, as it's called as
> uffd_ops->get_folio() or whatever it's be called.

Agreed. I got annoyed yesterday when typing vma->vm_mm often enough 
(vma->mm! ).

-- 
Cheers

David / dhildenb


