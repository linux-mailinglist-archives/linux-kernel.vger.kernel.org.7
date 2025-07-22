Return-Path: <linux-kernel+bounces-740316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4494BB0D2A2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AFF95607EF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318D42D23BC;
	Tue, 22 Jul 2025 07:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HVwvqOUK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5D81A256B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753168827; cv=none; b=CiJs6oymKN3oyM6BVkKVFnfOdCLQlXTesaZ//yZ5MQgJEzaJnEMwWig7ULUUI0iXHmqPTUDgMoihicIzMfLA9AoIUO/38rf3muVPDtG6yjMNhDElJ2rf9iKaOxXPrHTK6iu5yu0ZMvwmR0Q4tfY0ykN5Wa+nWd/FH4KudQPeZqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753168827; c=relaxed/simple;
	bh=nCpIqVdZh7fGOYFEF4LEq73KsSCNn+qV8uSC5B8wVGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xstdc0wBxOwwVLko8I0n99e8s2+s/NLeQUHZw/Ba7WdHCYLpQn2Xsr9vPZw4bYNpUBO+4Yh828OvgIP49w17knENbBH6hvGdhdrYwQfGyrj3shny9O6ksOgBxEC3rSqwiOgjShJkU3EivsjWtBBAVVksU+zJwNO1X3TnJAhzwx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HVwvqOUK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753168824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CozW1E5VHLpIUqBBRyUZDnDHcxpaM139xWKAC4+LRyk=;
	b=HVwvqOUKf7AaRUWge7X8sKy+XT8DswL8tV/+xmBGlXO2C/Vgl5etcJOWVi/wcKiX+2PW3q
	9UG8dpCibT+zTtUi7JAMxs/L36TcJw76OG6Dph1Ewq3L8uh4bmtzT7mPqhnrmtzkSTlAlF
	mkBsDXP5zo3YU84Cq13bEkVGFE6ALtY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-FAQoERJ1P2-OFjX_KISDhQ-1; Tue, 22 Jul 2025 03:20:23 -0400
X-MC-Unique: FAQoERJ1P2-OFjX_KISDhQ-1
X-Mimecast-MFC-AGG-ID: FAQoERJ1P2-OFjX_KISDhQ_1753168822
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4562985ac6aso52542625e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753168822; x=1753773622;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CozW1E5VHLpIUqBBRyUZDnDHcxpaM139xWKAC4+LRyk=;
        b=pS17lcsggQ18CfL+NlIDXqpd/BA4cEpHW6S2eeKMl0jySNzRqJGXlC/JavoCjZ+b3d
         6jSzxt75otYajbzbxW5ZeNomZpZDQph6chA1PPgdQxyeFqIAaXrM2qScseIp3aR0SlsP
         5LC2E8HhOk8xfiYyeCRIOUE3RBzOD1oz/DQzbz8bCNpPPb0QhvcV+ijSbfaRY5UqPzq0
         DioHOQ8hVURtcjh23cnLHYnyYvtkLbMhVNJdQQBxMM5zySCyV3a+bDxzRmb5TubGuuNu
         MwrkgjObvt3Uuy664QbALulsZ6thEKUF9Z+RvHqr/jrAZeVz9JjE26MF78SDjr8XRy37
         b4Iw==
X-Forwarded-Encrypted: i=1; AJvYcCVVXIL3NzG/GUVpuc/cEL8Y5R84UqeA2dHyzW2B3bGbtJghxmvjD470gii7MTEs8wUKxYrGlBFfRSYH44A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyjw1vEEzfYIvw6dLd9lbkFa0cx9qWigZNMGRezTPW1wpJ4WLA
	fBMQLxmYuNeP7E/LEOaarsiFkgZ18N+UieKG7ZxU5ZSpQGTu1PXENNVZCiaMcZCR5QSflzlrZB2
	GiM4nBiRnsomoltjQurtxXLi4f52BkpVWHXRbMgzyPt/gqdi8iOFy73qBmWT9oWyEWw==
X-Gm-Gg: ASbGncs3FLZZf87kYhmxMK2ssyrSIdKxDYVaJeJ25AvU4HFDgKmvLSpUQLUtNdzFFNo
	veVDTn7DQu9cFdESt3Ybb7Ru6KI6ClmXNh2k6Wihgo4Zi4tBFOnjkkCrl20xTdSuRpfQw8x91wh
	ACBprkZlBHfkQTPSfkORSfvfQ/3E3KmjnRfhzztCCgtqX+r2JdhQMWC7XY/t7RamADFnIKLCu9o
	PQ0iJ4nc4HFNzZxgkqG2TLzGGJ9AFcHqQz+l9q64QdzozRrzEZtkPgsOMfaD9Yt/vfVR9jmMMkl
	Nnzu7i+ywuczd4CdQZGwKPRF8JargrIN22eiR3H0629/7IFA2pmKaX11jVPbyq+U+ssxADM=
X-Received: by 2002:a05:600c:3e0e:b0:456:2ce8:b341 with SMTP id 5b1f17b1804b1-4562f88ae8fmr231946035e9.17.1753168821971;
        Tue, 22 Jul 2025 00:20:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9aY+RfSXeUZQOme3p3eEvdvpsM+HvGTuV3xDyatmqQO926XAYqBAK0UL30IswRl+02loPhg==
X-Received: by 2002:a05:600c:3e0e:b0:456:2ce8:b341 with SMTP id 5b1f17b1804b1-4562f88ae8fmr231945585e9.17.1753168821260;
        Tue, 22 Jul 2025 00:20:21 -0700 (PDT)
Received: from [192.168.3.141] (p4fe0f597.dip0.t-ipconnect.de. [79.224.245.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e88474fsm185479545e9.22.2025.07.22.00.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 00:20:20 -0700 (PDT)
Message-ID: <39a75435-5fea-4816-b484-477d400c3564@redhat.com>
Date: Tue, 22 Jul 2025 09:20:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: update THP documentation to clarify sysfs "never"
 setting
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250721155530.75944-1-lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250721155530.75944-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.07.25 17:55, Lorenzo Stoakes wrote:
> Rather confusingly, setting all Transparent Huge Page sysfs settings to
> "never" does not in fact result in THP being globally disabled.
> 
> Rather, it results in khugepaged being disabled, but one can still obtain
> THP pages using madvise(..., MADV_COLLAPSE).
> 
> This is something that has remained poorly documented for some time, and it
> is likely the received wisdom of most users of THP that never does, in
> fact, mean never.
> 
> It is therefore important to highlight, very clearly, that this is not the
> ase.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---

Can we also somehow tone down or clarify the "entirely disabled"?

Something as simple as

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index bd49b46398c92..2267d22277238 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -107,7 +107,7 @@ sysfs
  Global THP controls
  -------------------
  
-Transparent Hugepage Support for anonymous memory can be entirely disabled
+Transparent Hugepage Support for anonymous memory can be mostly disabled
  (mostly for debugging purposes) or only enabled inside MADV_HUGEPAGE
  regions (to avoid the risk of consuming more memory resources) or enabled
  system wide. This can be achieved per-supported-THP-size with one of::


-- 
Cheers,

David / dhildenb


