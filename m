Return-Path: <linux-kernel+bounces-878486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9023EC20CE5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21EAE1A60451
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088E8280CFC;
	Thu, 30 Oct 2025 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eDtade+B"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50EF27F759
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761836104; cv=none; b=N7rwxyeIH8QgOT5uRZ6rm6GdPZYb4qsbMgDMzDdwcU6mge3msZepoZUvieI12oncdMkPpWj9vJIkvgYiwzxW/4R6WbfdsSpBtMZO+504grxkiJsi+EzuN9gevN2jJQTq1/DZIelxhwzsQoTjR/PkuHyvuHORR6l9wmefP7jv1Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761836104; c=relaxed/simple;
	bh=6lxVUIxaRRatI3B3ucLOQH6Kg/459cGXOT+RzzrcHYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CelMRBwCqxkCsbOKydqrE7Ha9a18B5aTX5OtYG5RrI1LXN8idCaSaGZ5+NTDn6rHFfwc4f98uE2KHkYKoQPs2gVDWIKs7ut1TJ6l4d8AxtM3eRVJtbJJ1rUXYEP4+XEYg9ZOFvmeqjHMMCM1znuh984GlsuqS55xXliUHJKdQHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eDtade+B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761836101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2W3chW7pcnMqJOQDxC26D0D4sbrWuL2m2Kca3x2i3PY=;
	b=eDtade+B/E64nMgCvXxsrcwB16yBsINB0LnGgWpYnK9zyeoyTEd5v18RzJCfM/a+CNE877
	KjusIIl5kdHWOud71q3n541Ndk7m8S9B4psby13eK70/PwD2SXcLQYytAiwJZdqFd2wMpi
	CTg4PnE2q4HO+JFZLo9eKnticU116aU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-sG5HtqL6OYOVst63XdZEmw-1; Thu, 30 Oct 2025 10:55:00 -0400
X-MC-Unique: sG5HtqL6OYOVst63XdZEmw-1
X-Mimecast-MFC-AGG-ID: sG5HtqL6OYOVst63XdZEmw_1761836100
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ecfa212e61so66587991cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761836100; x=1762440900;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2W3chW7pcnMqJOQDxC26D0D4sbrWuL2m2Kca3x2i3PY=;
        b=aoB2UAwgNnmVRysTry+XNwM1+CSayJ2VqrgVBCCKstOsy3dqrZUx1ECWNs08FODzd7
         kFzptqtyEUlustAVYGIbPNg2UquNut7rhYdu0l2M/zUqUF9CQAnt34SsyiCWfDs6M9xP
         uD+RQRBVHTm8ozqJT3NGJHLtR4snrDXi98Q5QvQlu93fRpheAYwf6mJyUmgVXDIceTos
         tfKFOBrBd1TJzIDdS5OcLlzcXgR6kXZtNCtT5Y5vjBwLhHtDGtkwYhLKKN4lCFHRtTkn
         xAJqoEs7EnUu8UOApGSBQlyzjO991dNpu/vhADX0p8Giq/OQHNJjtCFD4uDHZ0lJabXU
         xxKA==
X-Forwarded-Encrypted: i=1; AJvYcCUooO+w5QRZb/NjdU7tCKih0TCSO/WoBFaClNe+h8NAJ67sV72Nyas2SV6ZQzA2rHEFcv1B+kcH7HhnHq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrtC3GWJ5sjkdKEQYf3FukJNT/20JzGmtZcylrYup78BS4qZv3
	oKbIsvvccVfUPNuOjwAAq2TXh/2j4+PF5G5tAk7pKpCn85Bx/gqQh8NqDMaaJpgeYyC6Oeh4w9M
	IZ2owN3cCrrWG9RQVVYCFODbMS8ThU2Vp5+syh5bsjCr5syHQbnwYqKG5iaJWpSnyxw==
X-Gm-Gg: ASbGncu8IeJH9BoAkVarCZ3e+B5Lk7yN1OIMsH4J8d9Y3/TPls6eUCnf0v4wOdp2WIC
	Vmj5XIK19oWzgBgca31O65A0z+s1tY36hSO52oKuD+S58+b5CjdffehHHyA8G03g7AOhF3khDQd
	FCeXuM2+Wo+Gmas8hflddTGHE+gzUA41mrRnns1H7F6ovqWbitkTNl75z+iMr7VJp04nOBEXLKL
	Fij3VFIZlpA4mo6EP5+ONVULz2mIKr2D7IEfOjUfmJl/DfpPxwaEc/SZrEs6uwpNKyoOWvl0WcY
	fuVuY0zZgj/hiEAFu2l0eFu2MDjCX4H9eDm7ULRI/6mW54nGMQnn+4JdK68Ncr+HNyhgftE3Hz7
	W8Q==
X-Received: by 2002:a05:622a:155:b0:4eb:a094:9711 with SMTP id d75a77b69052e-4ed30329abbmr840371cf.29.1761836099669;
        Thu, 30 Oct 2025 07:54:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDZb2Jtln8mUUIX/hROLSOtY5G4JrM/X3Ba6JkpA3dXWxKYmihpqbJsP81IQR1GIA8Uox8Og==
X-Received: by 2002:a05:622a:155:b0:4eb:a094:9711 with SMTP id d75a77b69052e-4ed30329abbmr839911cf.29.1761836099092;
        Thu, 30 Oct 2025 07:54:59 -0700 (PDT)
Received: from [192.168.2.110] ([70.49.125.126])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba386b695sm110232221cf.34.2025.10.30.07.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 07:54:58 -0700 (PDT)
Message-ID: <bdd4ea3a-f326-4eb8-866a-52b1ea2bdc5a@redhat.com>
Date: Thu, 30 Oct 2025 10:54:47 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390: fix HugeTLB vmemmap optimization crash
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, borntraeger@linux.ibm.com,
 joao.m.martins@oracle.com, mike.kravetz@oracle.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, gor@linux.ibm.com, agordeev@linux.ibm.com,
 osalvador@suse.de, akpm@linux-foundation.org, aneesh.kumar@kernel.org
References: <20251028211533.47694-1-luizcap@redhat.com>
 <6bbdf4ce-10e3-429b-89fc-ef000f118fec@redhat.com>
 <20251029104457.8393B96-hca@linux.ibm.com>
 <9a8254b9-92f8-4530-88e8-fca3b7465908@redhat.com>
 <20251029124953.8393Cc7-hca@linux.ibm.com>
 <20251030153807.0a835fee@thinkpad-T15>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <20251030153807.0a835fee@thinkpad-T15>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-30 10:38, Gerald Schaefer wrote:
> On Wed, 29 Oct 2025 13:49:53 +0100
> Heiko Carstens <hca@linux.ibm.com> wrote:
> 
>> On Wed, Oct 29, 2025 at 01:15:44PM +0100, David Hildenbrand wrote:
>>> BTW, I'm staring at s390x's flush_tlb() function and wonder why that one is
>>> defined. I'm sure there is a good reason ;)
>>
>> Yes, I stumbled across that yesterday evening as well. I think its only
>> purpose is that it wants to be deleted :). I just didn't do it yet since I
>> don't want to see a merge conflict with this patch.
>>
>> I also need to check if the only usage of flush_tlb_page(), which is also a
>> no-op for s390, in mm/memory.c is not indicating a problem too.
>>
>>>> Changing active entries without the detour over an invalid entry or using
>>>> proper instructions like crdte or cspg is not allowed on s390. This was solved
>>>> for other parts that change active entries of the kernel mapping in an
>>>> architecture compliant way for s390 (see arch/s390/mm/pageattr.c).
>>>
>>> Good point. I recall ARM64 has similar break-before-make requirements
>>> because they cannot tolerate two different TLB entries (small vs. large) for
>>> the same virtual address.
>>>
>>> And if I rememebr correctly, that's the reason why arm64 does not enable
>>> ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP just yet.
>>
>> Ok, let's wait for Gerald. Maybe there is a non-obvious reason why this works
>> anyway.
> 
> No, using pmd_populate_kernel() on an active/valid PMD in vmemmap_split_pmd()
> should violate the architecture, as you described. So this would not work
> with current code, and also should not have worked when I did the change,
> or only by chance.
> 
> Therefore, we should disable ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP again, for
> now. Doing it right would most likely require common code changes and
> CRDTE / CSPG usage on s390. Not sure if this feature is really worth the
> hassle, reading all the drawbacks that I mentioned in my commit 00a34d5a99c0
> ("s390: select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP").

OK, let's do the right thing. Do you plan to post a patch? I can do it
if you would like.


