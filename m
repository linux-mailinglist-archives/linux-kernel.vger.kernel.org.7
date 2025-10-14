Return-Path: <linux-kernel+bounces-852851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B6ABDA165
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1256E4F2AA0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CB52ECD0E;
	Tue, 14 Oct 2025 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hF4VKzYT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FEF2F56
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452695; cv=none; b=o7u06UnsRaFLMaOD1JnccMEIm5GhMmnHiCDS77nCnNNTvDHqW+9ObG5q4+Xy2MILshiiGwVXdnhIX5BWsGyeNT1MVUA+GJ5UFhbgm7Y9vAHNz1NI/8CBiNqPkYCe1/d6UtbTHBq1kuf6PsNvvdWDRdj1bW8Tgrwee3Jp1SVZrZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452695; c=relaxed/simple;
	bh=v/gjhMkuCIQEoBzUpSlz6vilaayoG7cyY31KFqrfLvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FyNabhFuB8+8mJuRa2bK8ehhnomBzbAEuJew+jCFxkQZrN3Aj1/17CBP6cRWETXWvBLsqNDzvd9VfuZKjiTURQJYwCkmNcsRzAg1AmCmwzTKdkzCXDCTE9eeJX3aGqwTpyAl5KfmyxsmYK0is3xVU9u7lizkZlEQvtr4VNKE4AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hF4VKzYT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760452692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Y2/pl56RibYUoklQ5dQ8O9eQmT//+IdeeagASCrWmlc=;
	b=hF4VKzYT2CflAcqE5OOu6KeI0kulm41C5aAxhmEAI8cBWqFAfMWY10iHnaqcbNK6MqmN0Q
	q1DCk83TKf5p4zvVHc7oiEjAd2SuLnUE3dihkM1yl8nA+OOmU5Ltt8Xg5WZxVEpAf3zWeK
	HxijEookEZIbuwkgaoSb5aG8HODKA/I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-s8BVB2rwMheFKQTUfK2b4Q-1; Tue, 14 Oct 2025 10:38:10 -0400
X-MC-Unique: s8BVB2rwMheFKQTUfK2b4Q-1
X-Mimecast-MFC-AGG-ID: s8BVB2rwMheFKQTUfK2b4Q_1760452688
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e2d845ebeso35882395e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760452688; x=1761057488;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y2/pl56RibYUoklQ5dQ8O9eQmT//+IdeeagASCrWmlc=;
        b=QQ4k1iqEtAlg/VsMQhl/4TsPfHZob7f/MxgC2zWBy/hQ/tpuEm5q1s0z23xelc8oQd
         4p+PawS/wKng15CxYFLZkFtN7CLQbxlyewmMK/gsULfpAK2DjF2e4qExETGB9XRFTc8H
         R1x2uRIPQqz4pSn5vN/oPx49rFy7tutR2ijnHlvadamsjG1T5gMe+3a0vbLh9uae1mJz
         O28ncz5tDy2bfx9ZdSKiqA6rqdlNeu36wki6dXEFa58bkD4HI8Wo2yVyyO/uXspiGnVr
         br38Pwzdeo0GLw1B+qkyHgyT8LcP2CxBIVFq6qNw3HEW5t2vFr9bEpXfEPO3icr6oVdh
         +1TA==
X-Forwarded-Encrypted: i=1; AJvYcCUb3/QImL3hkuUvl5vhCUTCE7vSGUUxnkn++tX0uA9XsgxmwyDLk15Z47ipAtXbttms6o+Vc0Pzui7iA0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDfrHg4UKO4buxNkV4C+MzLDMNGCVhMIcqf2WBTSxnOhZRvNb7
	fnaARIGdMurP+9+u5kzuy8QLaA4gzV9knJvctjwKbij14LXUR4QqZjcMEEhdeLgFHrj+df+Ailx
	LmFbaeVeVhQGsdYF8o+EZBg3Wp58cbe+I7/hidRDjFvdltx0eCYdoqtdOvKgDBSu9cA==
X-Gm-Gg: ASbGncvj7ziiwFOxFChqlN69/BPiyOtBbbhjfZ/qR5tnIcMHSpa/IGBh3MMlLbpP9Eu
	kJe6TKwPSQy5tok7d1T24MjBbDdn4cVUycg7b54KucxX1p2eOW7aL3pEalBYkj3ggkgRfpdUFlf
	m10RtgoCcLrXyW6xisYu8WTSKydviuOmGBfutKlH3U5pb6xuoD6yCEQwb4+AtBPkJalEAxRFG68
	55J9qArrYHmZYGj5+Ej3v445oJ4rQz/yd/3mVWL7gEY9Nk7OMGK3VcyxNC0VdbpIfxU03x6c3yp
	EEBFIjRmDLrHGA1KfovRVlkonn4J5UvE08HGbQbbfprzj/6c6LHjxzzaPmm6UpLZUsG3s7ykjA=
	=
X-Received: by 2002:a05:600c:c083:b0:46f:b32e:5292 with SMTP id 5b1f17b1804b1-46fb32e5338mr100816125e9.8.1760452687896;
        Tue, 14 Oct 2025 07:38:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+85bHywL95AGPc4rVVpN4sLObPxyXn+eTRLQq0mKm3kp+YVI++XU9krnHNWQYv6fsnjY3Ng==
X-Received: by 2002:a05:600c:c083:b0:46f:b32e:5292 with SMTP id 5b1f17b1804b1-46fb32e5338mr100815935e9.8.1760452687519;
        Tue, 14 Oct 2025 07:38:07 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb4982b25sm246894965e9.7.2025.10.14.07.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 07:38:07 -0700 (PDT)
Message-ID: <2861a35d-4f8e-4ee1-bd11-b915580c9ce3@redhat.com>
Date: Tue, 14 Oct 2025 16:38:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -v2 1/2] mm: add spurious fault fixing support for huge
 pmd
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Huang Ying <ying.huang@linux.alibaba.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Yang Shi <yang@os.amperecomputing.com>,
 "Christoph Lameter (Ampere)" <cl@gentwo.org>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Anshuman Khandual
 <anshuman.khandual@arm.com>, Yicong Yang <yangyicong@hisilicon.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>,
 Yin Fengwei <fengwei_yin@linux.alibaba.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20251013092038.6963-1-ying.huang@linux.alibaba.com>
 <20251013092038.6963-2-ying.huang@linux.alibaba.com>
 <4c453dcc-2837-4f1a-905b-3462270f5e31@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <4c453dcc-2837-4f1a-905b-3462270f5e31@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> 
> 		/* Skip spurious TLB flush for retried page fault */
> 		if (vmf->flags & FAULT_FLAG_TRIED)
> 			goto unlock;
> 		/*
> 		 * This is needed only for protection faults but the arch code
> 		 * is not yet telling us if this is a protection fault or not.
> 		 * This still avoids useless tlb flushes for .text page faults
> 		 * with threads.
> 		 */
> 		if (vmf->flags & FAULT_FLAG_WRITE)
> 			flush_tlb_fix_spurious_fault(vmf->vma, vmf->address,
> 						     vmf->pte);
> 
> 
> So I don't see why it's so egregious to have the equivalent here, or actually
> ideally to abstract the code entirely.

Let's definitely not duplicate such comments whereby one instance will 
end up bitrotting.

When talking about spurious faults I assume the educated reader will 
usually find the right comments -- like you easily did :P

However I agree that ...

> 
> In commit b22cc9a9c7ff ("mm/rmap: convert "enum rmap_level" to "enum
> pgtable_level"") David introduced:
> 
> 	enum pgtable_level {
> 		PGTABLE_LEVEL_PTE = 0,
> 		PGTABLE_LEVEL_PMD,
> 		PGTABLE_LEVEL_PUD,
> 		PGTABLE_LEVEL_P4D,
> 		PGTABLE_LEVEL_PGD,
> 	};
> 
> Which allows for sensible abstraction.

... if there is an easier way to just unify the code and have the 
comments at a central place, even better.

-- 
Cheers

David / dhildenb


