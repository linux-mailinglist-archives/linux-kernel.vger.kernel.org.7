Return-Path: <linux-kernel+bounces-843240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF0CBBEB8C
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 18:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA2C54EF9C0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 16:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9892367AC;
	Mon,  6 Oct 2025 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGDBjT2Y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17F7222566
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759769121; cv=none; b=SveHtVv2LWE0wThkrQK0Pkh2ybeXzCUdy3dHgQT2GVyd/oE1IUKD3sPHVSg+IxVV9wtswmNEAAVftY34n/L8pnf8tvIgE5eEGHm4a3f7TwSG47VkinYOnKvXXqLABZZUj+8IClg8tqaUs6WCvF2PaQUdmH2gFCIOFK0hdXTXd7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759769121; c=relaxed/simple;
	bh=0vqOV+yiR3YhWnUlQVmauRIpZio0g3YQWl/jJ65omis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KSVktlQwNr4WP1eQLtEFIlvzjBUvgDXlm8JTgfEV2OtYPdVxVXQvt/4uZ4nWJO4QMjt0rSV6t2514PzBaJLjenPP5/oLv1nU5RAdGD/F+r2RqHBI7KX2dAyKWpe2VnLXTbPSbkpcVtl+DrnZiXbAYKXlQozmxmPuOFeHujX+FQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FGDBjT2Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759769118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S1zkgvROQPB9KO98BQ/Xir7j7NOcJi9fySuExxZFR9I=;
	b=FGDBjT2Ye2bJJVe4PO42DRPAaeeR9hHK2USVyiB314p6pmL1ZVOmylFpiZbo4ZJMPQ/LTw
	sVWqaOCyooH9j0poFro+LGufULHSJPcDnPtoSEZiYrgn94ZyaOxG3Dpg8mZUHofNIRg/ms
	bUopLm6FAW930wXxA3rEpGscicr5H8Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-71P_VCIPP3eXzHBN2EMemw-1; Mon, 06 Oct 2025 12:45:16 -0400
X-MC-Unique: 71P_VCIPP3eXzHBN2EMemw-1
X-Mimecast-MFC-AGG-ID: 71P_VCIPP3eXzHBN2EMemw_1759769115
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e4cb3e4deso15960185e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 09:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759769115; x=1760373915;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S1zkgvROQPB9KO98BQ/Xir7j7NOcJi9fySuExxZFR9I=;
        b=LpFSgtf1VvuNsbfSxFXSD//mpSgwnofxdLk85eh8w9McDj1sxH2vOfZT+6VOySVB8F
         /QmLE9FR3te8TgNVA2fN4NyYRINcn48rjoUxmEIlnS9FmHdCJFc/KVYBSNalYoQ0Jqvf
         qsieX9R1BG+Dm4zICQsQQ0y2ZmgtqDmzzbGkRlNxX3IfsdhhY80zRJSI4DrAOfUW9qpH
         mZpyUpOYLLnkAC2jW1Fe+h/v9DwdhG6XXhkBmw0Vea7NQ4LcHsB1TRkn0KnTPx/2AT0A
         quiUYYUFeJzJzdTYjqeG2Q3T8zVaHb/UNzcGp//VYMWMxssdQWQcXvxxzcuwo6HEQgw7
         5LAw==
X-Forwarded-Encrypted: i=1; AJvYcCXrrA3HTe9Jf7vSRWUwSpqkRRs4V0VtUrbRiUShAVJdRLuE/CdUD5SxecGfRKhgFyFRIcu75PQvZ4lMf9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7PFgDuOG91rTNj9ibjPJYsdH77HlNmDkhdJiH10ATSp+gq/o1
	AFlQk7KslpJRumt2bxpRiWxlSzkzMr4YgjzMGl+xbmjQT7KLsr7YAghJhW6Ai9g9WuZ8Nyxaxbv
	9MoNysvdEwpRVLi1PNsWxYFsqHDyQ258lqdo/WOwygB0nTyCNcXFLPrU0P5FAPSQIMQ==
X-Gm-Gg: ASbGncuAHLprLURFGDQ0Xf9GsGDuxZIbi83B9Vp3cMnjD3OJij0t3sbICgo6GG/l9FN
	3QpYjGs9sT6utnPSlBH+/HQvkRz0KJNq9wTOWe7ODCcSxOJxLNOxM4cZGtW76P2JEvRpgtAGcYC
	F1ADB6ELN/3OwX9ZFYZRyI6FGYWSdssGsP/qdxOZEoakNb49rNnzqLreLs0Ix8BRJVrNEEWXYdN
	g865z7X96sLgwfc2x8hUzvx+BYQ0NQOIMhnfezINHvOEKHMv7RrqL9VPUhkTo4UkXXd+jA+Hneo
	DeHZdmOXMY+w4r/fmMnwbOPt1E9xObl1s+mM16mnqIm++MG39ReXWz03GwpWYe+gO/zYMt7/IU9
	0ccBZEt37zpZo
X-Received: by 2002:a05:600c:6610:b0:46e:711c:efe9 with SMTP id 5b1f17b1804b1-46fa29c82f3mr2420555e9.13.1759769115308;
        Mon, 06 Oct 2025 09:45:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtCTJxXouzehZZZSHbIIjnOfoG74tnDFyVirErdt4lQ1cDyHjbGNh4RIvx+jcKsiY2ad2sLA==
X-Received: by 2002:a05:600c:6610:b0:46e:711c:efe9 with SMTP id 5b1f17b1804b1-46fa29c82f3mr2420135e9.13.1759769114734;
        Mon, 06 Oct 2025 09:45:14 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-110.customers.d1-online.com. [80.187.83.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e72374b8dsm184375445e9.19.2025.10.06.09.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 09:45:14 -0700 (PDT)
Message-ID: <2e35b6dd-56dd-47e6-8dac-54f446f763f0@redhat.com>
Date: Mon, 6 Oct 2025 18:45:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] kdump: crashkernel reservation from CMA
To: Breno Leitao <leitao@debian.org>, kas@kernel.org
Cc: Jiri Bohac <jbohac@suse.cz>, riel@surriel.com, vbabka@suse.cz,
 nphamcs@gmail.com, Baoquan He <bhe@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, akpm@linux-foundation.org,
 Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>,
 Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
 linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.cz>
References: <aEqnxxfLZMllMC8I@dwarf.suse.cz>
 <vojlxf5pelxlr6omsfsccd4e4cdzn5qyxpgiqajorkgmgd7ruh@e5wwhkmvntpb>
 <26ae6b04-3beb-47e9-9639-b081003dc9bb@redhat.com>
 <f7x2flir2c5zpkusgiyk7qnrdqo4dek3iksyldw6w22r55s4vy@4b47lrcv3fag>
From: David Hildenbrand <dhildenb@redhat.com>
Content-Language: en-US
In-Reply-To: <f7x2flir2c5zpkusgiyk7qnrdqo4dek3iksyldw6w22r55s4vy@4b47lrcv3fag>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06.10.25 18:25, Breno Leitao wrote:
> On Mon, Oct 06, 2025 at 10:16:26AM +0200, David Hildenbrand wrote:
>> On 03.10.25 17:51, Breno Leitao wrote:
>>> Hello Jiri,
>>>
>>> On Thu, Jun 12, 2025 at 12:11:19PM +0200, Jiri Bohac wrote:
>>>
>>>> Currently this is only the case for memory ballooning and zswap. Such movable
>>>> memory will be missing from the vmcore. User data is typically not dumped by
>>>> makedumpfile.
>>>
>>> For zswap and zsmalloc pages, I'm wondering whether these pages will be missing
>>> from the vmcore, or if there's a possibility they might be present but
>>> corrupted—especially since they could reside in the CMA region, which may be
>>> overwritten by the kdump environment.
>>
>> That's not different to ordinary user pages residing on these areas, right?
> 
> Will zsmalloc on CMA pages be marked as "userpages"?

No, but they should have the zsmalloc page type set.

> 
> makedump file iterates over the pfns and check for a few flags before
> "copying" them to disk.
> 
> In makedumpfile, userpages are basically discarded if they are anonymous
> pages:
> 	#define isAnon(mapping, flags, _mapcount) \
> 		(((unsigned long)mapping & PAGE_MAPPING_ANON) != 0 && !isSlab(flags,
> 		_mapcount))
> 
> 	https://github.com/makedumpfile/makedumpfile/blob/master/makedumpfile.h#L164
> 
> 	called from:
> 	https://github.com/makedumpfile/makedumpfile/blob/master/makedumpfile.c#L6671
> 
> For zsmalloc pages in the CMA, The page struct (pfn)) is marked with old
> page struct (from the first kernel), but, the content has changed
> (replaced by kdump environment - 2nd kernel).
> 
> So, whatever decision makedumpfile does based on the PFN, it will dump
> incorrect data, given that the page content does not match the data
> anymore.

Right.

> 
> If my understanding is valid, we don't want to dump any page that points
> to the PFN, because they will probably have garbage.

My theory is that barely anybody will go ahead and check compressed page 
content, but I agree. We should filter them out.

> 
> That said, I see two options:
> 
>   1) Ignore the CMA area completely in makedump.
>      - I don't think there is any way to find that area today. The kernel
>        might need to print the CMA region somewhere (/proc/iomem?)

/proc/iomem in the newkernel should indicate the memory region as System 
RAM (for the new kernel). That can just be filtered out in any case: 
dumping memory of the new kernel does not make sense in any case.

> 
>   2) Given that most of the memory in CMA will be anonymous memory, and
>      already discard by other rules, just add an additional entry for
>      zsmalloc pages.
> 
>      Talking to Kirill offline, it seems we can piggy back on MovableOps
>      page flag.

We should likely check the page type instead if we go down that path.

-- 
Cheers

David / dhildenb


