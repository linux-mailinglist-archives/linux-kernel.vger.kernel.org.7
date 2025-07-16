Return-Path: <linux-kernel+bounces-733831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B3FB07994
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DEA23BE06D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164892F5472;
	Wed, 16 Jul 2025 15:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jgs5PavY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D339F2F532E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679252; cv=none; b=dkLZEP1dqt/hGmBx5SuXYeTyNBcRbhzgXyuZFNAVemDMOJrji1a4qRwx17LuSzsxwMyV4p3IianTN1mxxSa2gGeWzYgBv5NiH9QoFzXwD6ZUJq8kRDmDZ/YHF39GGBjr4z8PdmMO7kpCSnvS8ReaLd7d9ksIZpWiKI+1wymLkTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679252; c=relaxed/simple;
	bh=YSCk/mhRrH4zzs6WIB4+cLd/DQ9I0q09f/8YYnhuS3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W6OFg6ir6bBBbHpVoCAd/MQOlbx4GiOtq3jWrUFJZhO0pTyxwPY30zyArmX6IWIvrxCVoVfydo9ghW/zxfa4g3M+glw+i8pp7sOfQXZa0vNztnxdFZH6BEn0aUfJVJ904r5O3vFwiWAfUssMbpuLD9AOeEHp6oxiNp0HEH8eGH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jgs5PavY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752679245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lYqVcGPl98IorByiIq9slG84y9r+OvSPRKagz1QeHjs=;
	b=Jgs5PavY58h8EuvfA8s+fe6GdsZK6++QpayCCEdXum4QfdJkTGcR12YnSJ46dvQYRrzndU
	DDgYl4Q2WftYGZe58fKzB/aKC77qJfgEVdo7MNOEsDs65UTrjD+PiiWrpvzUobfkuhxSnl
	aE44CE2FV0q0+9Hk72IV1C3xUh7Izv4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-N6kWVEYdOMW3w3WjCSwf6g-1; Wed, 16 Jul 2025 11:20:43 -0400
X-MC-Unique: N6kWVEYdOMW3w3WjCSwf6g-1
X-Mimecast-MFC-AGG-ID: N6kWVEYdOMW3w3WjCSwf6g_1752679242
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4561c67daebso38365e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752679242; x=1753284042;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYqVcGPl98IorByiIq9slG84y9r+OvSPRKagz1QeHjs=;
        b=rWyvnfP6qWPKVqkWSm+6LfYCpnT5Xsp8dDVhams89ii/4Kd/VTGxaORGp4TLayFgXW
         IlOsY4mJjlZf0kT0EHE6JExwBBNVen03jCOaB2ZHL9nBM5xulhZsTtgV0bLE2AF65TA+
         Qy9eRbIGkug7ZcadzsS8GKNOHxkYAoZVR3iZCtiHvqRGq+Y/dl1j+R1d7zfHLAjAYCn5
         M3PvQIuRkSPaK1YkIfH+GLt4GMCiS08flxwFr57MJ87QR3uL4tQ8/jzSzh/nx+tN/R1r
         gfAXG6ypjNI3buuuHMz5CWxuoRaMZlvzdDh/hfIhsQrAVKyeTTs/fAfQUlnHE0plv3eS
         CnrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHVnl3mVltijkGNd54Hohnxb4R9WyUQkPeZNZdy9vOfWWfy/P96Pud8/cTZFxCzksp+/M+DrQ81IpLjM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnv/lIFM/BDWaki0eYWI5c+f9zvai0yPKadhovZu+8i/yHVaLW
	oQOBOsZDd2J/ir6ffPMYORSdEb6DFDj5lHulwyOo0yzOZwrUDtaCC/AZxgQKs5MEZdBs4boRpIB
	dZuiNkHsgqN3ySveHVy6a8jpMgNs+ciSvetsxrsJ+Jh8gMs6Hh5jMneRpP8uQXRoH+Q==
X-Gm-Gg: ASbGncvY5rhJh/8PyVHPFVqIaWcn/7Wg12ncD2RsuxwAe+RWQX6PhDbZ16tAXD2oDLE
	JgZ6+tksQ377Fw80v/NAHwNgsjqI4L4QgAKL/S+YdsUTjxFVWjwhGZdJApk8frQArqUe/3378vB
	8PIfT2k//gebZ9MzWQC5FEjwQUeH30a4dhVoQe/mZEMhLAO78V1yD96M2Nh0lPC55AxMTLhovaW
	GGSQe/D+7LtwwwDczzybjvxdJ3fTDc2316mY6saKiqNd73LB2OxOwlHDmUkxgMd6p0jeAegtEor
	56baCDaOGoSIRVkEWxvBS+eb/ijhiNvkn0uaGfEURuVzSExFbWZ5Lo61Dt04BxFnTNoK8MFSqsu
	unlA4Uosgy7E3j4ACE81qG/VIqp8zp9+hRFzie6YpMqZQPwiji18glWM9GYf6Awx182A=
X-Received: by 2002:a05:600c:a11:b0:456:15a1:9ae0 with SMTP id 5b1f17b1804b1-4562dcc3596mr35066235e9.13.1752679241208;
        Wed, 16 Jul 2025 08:20:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRHERGcHpUYU+MGs4am6EvrtyXKGQ5MGu0qRLwnbuyH0kti86o4gVaDAAU7LSNJMHdUEg2ZA==
X-Received: by 2002:a05:600c:a11:b0:456:15a1:9ae0 with SMTP id 5b1f17b1804b1-4562dcc3596mr35065725e9.13.1752679240699;
        Wed, 16 Jul 2025 08:20:40 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:ed00:1769:dd7c:7208:eb33? (p200300d82f1ded001769dd7c7208eb33.dip0.t-ipconnect.de. [2003:d8:2f1d:ed00:1769:dd7c:7208:eb33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45627898725sm36468085e9.1.2025.07.16.08.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 08:20:40 -0700 (PDT)
Message-ID: <68b99621-31a1-4c80-b409-5557ffd9631b@redhat.com>
Date: Wed, 16 Jul 2025 17:20:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/14] khugepaged: rename hpage_collapse_* to
 collapse_*
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org,
 peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
 sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com
References: <20250714003207.113275-1-npache@redhat.com>
 <20250714003207.113275-2-npache@redhat.com>
 <qgcvsfhoq3pnvxhdn73dopbtvi75oghbaydg27atqfp556u6sa@ixwdwi73lgkl>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <qgcvsfhoq3pnvxhdn73dopbtvi75oghbaydg27atqfp556u6sa@ixwdwi73lgkl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.07.25 16:29, Liam R. Howlett wrote:
> * Nico Pache <npache@redhat.com> [250713 20:33]:
>> The hpage_collapse functions describe functions used by madvise_collapse
>> and khugepaged. remove the unnecessary hpage prefix to shorten the
>> function name.
>>
>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Signed-off-by: Nico Pache <npache@redhat.com>
> 
> 
> This is funny.  I suggested this sort of thing in v7 but you said that
> David H. said what to do, but then in v8 there was a discussion where
> David said differently..

Me recommending something that doesn't make sense? That's unpossible!

-- 
Cheers,

David / dhildenb


