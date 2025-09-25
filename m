Return-Path: <linux-kernel+bounces-832248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3547BB9EBD2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0F764276D4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15F72FB615;
	Thu, 25 Sep 2025 10:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kwfj5MQ5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CD62FB611
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796669; cv=none; b=SZ7jNxpb4D4rAqQTjdV4d72XunrSNhE1Ps/45QD2dMoDS0Jr62IlEsGZ3d6v3GXhyxCdE4Uv+pn1TabqgSeaAORzM0g7M2CQ5OdZ/kBHF6HQIvJ5qKy3iInZu+oIRYykl1Qqgt7Q6HwNThTiatPfE5xokhRspfm51Z9z0uhib1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796669; c=relaxed/simple;
	bh=Io3ZZhW/jRY5gsxF86AGxksSXk2L/zIvjDuNOuW/AUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJMoPzYGCLc5qKDIWJaM58BU4iTPzl1d/wuwponrThttrXdbZNO0nGIhrPavU+c2rUFXaAoNG09DDFXhgLxJE8nSi3Du36+porj7C04DgivUYQJpAmmu2LTKjQloPIV/KuGWScXAJWaEFzSO41o1t4NotEooPWgb3o8O/+YGb44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kwfj5MQ5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758796667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=j86z+a2ydPFGKyipLjb7n06yXseJDAiv3r2xG+2GDrE=;
	b=Kwfj5MQ5kqazne/fpA+e4okLTRQg6n9yWLqrWpby2pSxbQ4eBUmqQS8iKLE1oZPNJIS9+T
	btrWR/4Hl+NLnwJlhCdu7AcmlC3uJ22NYxbvp06C2XrNRjdyiianeskjdVHEWG3RMrlsMQ
	rYNSoj9XF9mu6bD6oBfbfkgJNOPaBQg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-1wxqEmPQPEKipaex5JHQUw-1; Thu, 25 Sep 2025 06:37:46 -0400
X-MC-Unique: 1wxqEmPQPEKipaex5JHQUw-1
X-Mimecast-MFC-AGG-ID: 1wxqEmPQPEKipaex5JHQUw_1758796665
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45f2a1660fcso6907425e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758796665; x=1759401465;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j86z+a2ydPFGKyipLjb7n06yXseJDAiv3r2xG+2GDrE=;
        b=JhbtBElonV0yNXmOvs+76xrTiIuTdly/8YWPS7vDrUNf0IQJfpJuSO8ctxUEDRG/P3
         rEsBrTO0RH6mxle1WnnhZBVuENKQSx1lFPPM8l97AOu5/Z5J5f3yrrKufhAVCFQK0ILg
         MZyaIEoCeRPKV4pOpd5zUzUQBBJEHgRzBYuvwK+O5kyMPbs6dHLdSl4N1T1ET5Z8hv7o
         7GXWBJzUFHJu4IW8GUXik+upozGwYQbgmOVVg/LXawrF8epwsFuOvcRxdXU758Evzt2v
         QWqsG1V10PRePRxIT2Keud8JYJewgb+HjS/hpqu5cV0uxDFpTlJwemkmVyB3J3tuXhCa
         Jgyg==
X-Forwarded-Encrypted: i=1; AJvYcCX9n/MGCUR/xQUuWPnL4MVmJakzLeGv5ZKunZqZh7I/rqP0YzwL1Ezrb2DDLhfyYxsmczrZhIkjsC5aIpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGW39dF7apyTOyhC/YZgdUBioQdFkF5zTeCbJ5F1F3lZ7vyU9H
	jm9SYSqJY1FKmuBxNBlDb7XpFI7v1pokzoep5a1iMHBd3XEOtis7zL7wHZrqiSc965tzG4AgJNi
	UV1fKLWHTl9lGMHfg8GVO0YlCfV8IH/czqwRV2VgkAiOiN0dIq149giRWI+4iJJi80w==
X-Gm-Gg: ASbGncsaSF3SmVSAbq+Bqtayr68h/iHrr1yGiNatmumi/YF4TQhk/4/ypJvf3orjjDx
	3p/kWrXmfMxP+/kGrD5ng8A9gTZDjvkWZQYBpc18D8fQEapaEEymwdJjeYeKtrkelIADSvo0OO1
	VDwkdF9orI43Mae8laN18jzWU2IXM+LS4oLqilJvnoWYrFSZvaC5CREQRTUZyC6iQylJP8QCUbs
	iAqaWvskh931gR/khXUEznAa3eFWTRbL2/T3Tz4VrWgyY2h4QsB6g9dKFS4G413YLAsAk/rf4/3
	Ni+hIiLacWTHOg3A5jsCvwAh2heFOyLMzc82NrntcBfRmBaMKGHC8hiBI/Dt3IZh6KTn8Guoggr
	4gVEOKTIDQmuquA54NfnTI0zkLzYZtrsMKaej2p/TgRfFCwBVcyAgWfKAuntHJin6kP+2
X-Received: by 2002:a05:600c:1c88:b0:45f:2919:5e6c with SMTP id 5b1f17b1804b1-46e329c5735mr46281035e9.16.1758796664673;
        Thu, 25 Sep 2025 03:37:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1OlhgrIXCfTLwvyk//rFgoAATxq8ZwsqL2id63TzVhr9sBS+YiTsV2if4gGtZKmkB76cyew==
X-Received: by 2002:a05:600c:1c88:b0:45f:2919:5e6c with SMTP id 5b1f17b1804b1-46e329c5735mr46280635e9.16.1758796664213;
        Thu, 25 Sep 2025 03:37:44 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08? (p200300d82f3ff800c1015c9f3bc93d08.dip0.t-ipconnect.de. [2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33105e0bsm14956875e9.5.2025.09.25.03.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 03:37:43 -0700 (PDT)
Message-ID: <462bb4e3-7a38-4155-9f95-52fbb4b6d464@redhat.com>
Date: Thu, 25 Sep 2025 12:37:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: move rmap of mTHP upon CoW reuse
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Lokesh Gidra <lokeshgidra@google.com>
References: <20250925085429.41607-1-dev.jain@arm.com>
 <072b8684-47fe-4a2a-bf69-f6d348f0489b@redhat.com>
 <45e08ee0-c85e-469e-a3eb-4ca2e8b7ec0c@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <45e08ee0-c85e-469e-a3eb-4ca2e8b7ec0c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.09.25 12:33, Dev Jain wrote:
> 
> On 25/09/25 2:46 pm, David Hildenbrand wrote:
>> On 25.09.25 10:54, Dev Jain wrote:
>>> At wp-fault time, when we find that a folio is exclusively mapped, we
>>> move
>>> folio->mapping to the faulting VMA's anon_vma, so that rmap overhead
>>> reduces. This is currently done for small folios (base pages) and
>>> PMD-mapped THPs. Do this for mTHP too.
>>
>> I deliberately didn't add this back then because I was not able to
>> convince myself easily that it is ok in all corner cases. So this
>> needs some thought.
> 
> Thanks for your detailed reply.
> 
> 
>>
>>
>> We know that the folio is exclusively mapped to a single MM and that
>> there are no unexpected references from others (GUP pins, whatsoever).
>>
>> But a large folio might be
>>
>> (a) mapped into multiple VMAs (e.g., partial mprotect()) in the same MM
> 
> I think we have the same problem then for PMD-THPs? I see that
> vma_adjust_trans_huge() only does a PMD split and not folio split.

Sure, we can end up in this reuse function here for any large anon 
folio, including PMD ones after a PMD->PTE remapping.

-- 
Cheers

David / dhildenb


