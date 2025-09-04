Return-Path: <linux-kernel+bounces-800475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B82AB4381E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26B7F7A1ADF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375022FD7A0;
	Thu,  4 Sep 2025 10:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xsw5Mi9X"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7337B2FA0E5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 10:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756980683; cv=none; b=ZyfsZgY247GUd2Spq20HdjBaKUzvS1+U0lPCQaH1v/rdUiUcFKWG817QjOQdXxl0sE8E01W0NpoQgeNXvfiwHi6Iv6KiDg3eEn/IJy8Rm8O7HhOqj45PWmY3e+EhzlNQsn4rDKI0zZr81GjJ2bYd2yxVEUClq/WOVn8uDv5IkTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756980683; c=relaxed/simple;
	bh=a2nRJ/sx5oGDicI/+6fFtCKBETNZV44mOdtpRgTEzWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=spVWT5ubEWQkpJ/0Nweiv7irZDUQlVKp5V9MTX6yvyy484yBA0HVl4tg/bIcQi+FSI/HiQ1FrNxttc8HFrpt8JCsCW9Hqf8cQFMXd7fKLhZTjvmPFjunOZBa3dKaJtZ1eAgqSscGydvwsR1OnKD6s6cwRq3TYj8q4VR3H4eRTnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xsw5Mi9X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756980680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wer6AdnyPuzKc/3mex250QgaFlSlOoyoixBdkTMFff0=;
	b=Xsw5Mi9XxvfrISweGTFFUtGXxuPr+TGcIFtrF4Unig6qCEtaD0MZEvu0W2/sJ/mrIsMewz
	OjLr58UVoEhATVscCEEPY+BehtvusRdaA0CsUu+oQ9gB6/IDYJDoa3Y2DTFykj1gKLcjtZ
	+S8XsvdREn6+JLNmZbu291lNF2elmDg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-JizBMQFNOwevowRrFVFduw-1; Thu, 04 Sep 2025 06:11:17 -0400
X-MC-Unique: JizBMQFNOwevowRrFVFduw-1
X-Mimecast-MFC-AGG-ID: JizBMQFNOwevowRrFVFduw_1756980676
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b8f4c2f7fso6674295e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 03:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756980676; x=1757585476;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wer6AdnyPuzKc/3mex250QgaFlSlOoyoixBdkTMFff0=;
        b=qFF7U0Oi2J5b7/aGx1bNMzKso5OALVLZryyDWfOhHhlohTYQes11WxLpDZPUXuGgjG
         VgoRM77OfqHlUgdLX4vDW3qAoTEiK5yiadV4XXNudmRPXzNbQaP3DGM1HMeOJBgVkFCX
         4bfSsVeMlRdFN+lEqjsbjcS+P1pBnYxf3Mu8urYTwsR+Iv1oCyx71CYQRas+hsf7UsAr
         WepzK4ix7LJA+VTQoc9xNCee4dlxOR/Rfl3xkAT0wEg4RCCtgeX5YjbcQAW1OPmx9v2D
         /oEA9ZuoNPJs1my7ZpshuGM/nDdDLJrjL1cN7gYqSvCGY+MTOI863EcHOSB0hsmFodiI
         kc+A==
X-Gm-Message-State: AOJu0YyK/jnzn5Wz+pLlUbnuqxWhIBcWkKafWT32u+ao7dn2db5Wr9qF
	ifiudbKVuNUuCBgqmnauM9ka6woN7nkDO7aQ2kJ+jjadbie4uIZ13N9BX/8ktKTWGZmf9NMpalc
	wSCbDkEiQ2F74n0XzeM17U/lGVrb7sIthB+XVI5z/z23yN4f0HX6E3ejKdsGOTM5KiQ==
X-Gm-Gg: ASbGnctz1fGjcxEj0rxa46N6UTBeJxu1mMxgaCOWP13GoVGOzvOwCLE7U0dhvOW01eU
	sOfxHi1ic41i+c4tfw5nuCkk59YEJUW1Objkigcbl7Zv7WqqejK3BwQSY8wFuZPKSrruELeYnUG
	stcx2ZgnGAlghffgFcZIxIGUC0oDrB+ZFwTVnmtmmaeH3tY6dDbr9Ubqr4XGUKYnJVi+1OFvRnx
	+yUK0ASBtdCKLVhcssm43PPIesa+kUz0VQ+60/CziSJLL4AAE8lQ/cAJND2qJX6GARSndhVD7tc
	2qtBkA74Ci1efAe5Uhj2igvCIer+xN4GUeKmCyvfIiyNJMoL3z1fytacVCf7wmBWyEMZJolTary
	3sbEw8IKoTo9XyPGCnfRfkb+Bou2XQWjrRZpX/vHBdJVpm5gYbyozxNfuGBXWrCzg
X-Received: by 2002:a05:600c:c4ac:b0:45b:76c6:cfb8 with SMTP id 5b1f17b1804b1-45b8555c585mr167062525e9.9.1756980675744;
        Thu, 04 Sep 2025 03:11:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzGOJzi2aENDJJt0ZVdjKlhBTp7D5WQuKkO1HkqG0ky4yXo3VOnWS7xXiXzSOprc5hMxrM7w==
X-Received: by 2002:a05:600c:c4ac:b0:45b:76c6:cfb8 with SMTP id 5b1f17b1804b1-45b8555c585mr167062225e9.9.1756980675229;
        Thu, 04 Sep 2025 03:11:15 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:1e00:ce4c:be3:97b3:6587? (p200300d82f251e00ce4c0be397b36587.dip0.t-ipconnect.de. [2003:d8:2f25:1e00:ce4c:be3:97b3:6587])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dcfc3e11esm16569715e9.0.2025.09.04.03.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 03:11:14 -0700 (PDT)
Message-ID: <2b681fea-555a-46f2-84b1-9d729cc3b0e2@redhat.com>
Date: Thu, 4 Sep 2025 12:11:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] huge_memory: return -EINVAL in folio split functions
 when THP is disabled
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Zi Yan <ziy@nvidia.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>
Cc: linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org,
 mcgrof@kernel.org, gost.dev@samsung.com, Pankaj Raghav <p.raghav@samsung.com>
References: <20250904095129.222316-1-kernel@pankajraghav.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250904095129.222316-1-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.09.25 11:51, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> split_huge_page_to_list_[to_order](), split_huge_page() and
> try_folio_split() return 0 on success and error codes on failure.
> 
> When THP is disabled, these functions return 0 indicating success even
> though an error code should be returned as it is not possible to split a
> folio when THP is disabled.
> 
> Make all these functions return -EINVAL to indicate failure instead of
> 0. As large folios depend on CONFIG_THP, issue warning as this function
> should not be called without a large folio.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


