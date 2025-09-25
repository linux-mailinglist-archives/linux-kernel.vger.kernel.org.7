Return-Path: <linux-kernel+bounces-832138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B49DB9E706
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33A13859E7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9B52DE71A;
	Thu, 25 Sep 2025 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LmWnD79Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592102877CB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758793128; cv=none; b=P4vhNdzLfVxXcvjz2cPl4EUMW9EQQTkvgmQZuP80pR91q6awglmq6YAra1xOpoLgHof861Zp4lgUhhFW1ZsYRM9DjqmgsdNxLubXOpr9sfE5zwbFVBLoIZRMwDBU3vm0XYAkBnnd4NIc1sYJfPNp5rimlsY2eUDGKB9tX21O2qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758793128; c=relaxed/simple;
	bh=AubXrgkgOmfHsWMsEcFlCsAkz8PzOlSkqLFn0EXVhYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PIcfH+1EgwFvmunICNohNLqay4vglocKN1Fx2w3aVrHHA7fi9ejwQdKlD761Ehl66Vgm3Ih7Rm3KMuWeKjccgyv6x5JcNklGVKk+98CrJ3ZyQXLpzCH5Osqo7dAMsyMGFdXMYDLGwNLDp69O0grgJFW3YXoXsScr7qs75j7i1Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LmWnD79Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758793125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=it1xa6zCsSImRY+xGhkMLXcJ8czGI9ZV2cO7XzXjMBU=;
	b=LmWnD79QMX//6h8MG1gcxG9ReTbGAuwuD1E1yjwXayDmIj1vSL1mcbmp0qEXmrVKHZ8dJc
	9JamP+EqFLTqggTMlsogF2LpBQXqBoPyULKGrOO5XfnLKhCZLDlsph9IVZnBkFcHJ1ZP3r
	ejg8O/dEofXo5GwoIpXe5lpMjqm3y20=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-0M_H2wFkOVG2vGz_3rGCOg-1; Thu, 25 Sep 2025 05:38:43 -0400
X-MC-Unique: 0M_H2wFkOVG2vGz_3rGCOg-1
X-Mimecast-MFC-AGG-ID: 0M_H2wFkOVG2vGz_3rGCOg_1758793122
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e375dab7dso1321285e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758793122; x=1759397922;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=it1xa6zCsSImRY+xGhkMLXcJ8czGI9ZV2cO7XzXjMBU=;
        b=TBSkD13esHIlFhGMyr01r4eFWarDldbzZYc0DM6wANfHqF2xEVSLI/LwZ8b15ZdKz3
         +IcGVonEqKKac1yDbs9iKrpKDwOvLlSPte23Vicq+w6QXLznDvw3gPyQPSajmMGA62AP
         W4MlRacDonvUL8RcNkyhgKRWkZoEKa6Nq7NmIBtYuYsQPvoEHTiNDLZwbdNV0LsGhcxD
         AsAl5vnpYeERq1ZFS4lOz0+xtNX2d29Ygjsib73DvZvMLZ4JZmfINn+Tghk/DFu3Ww8P
         bMjVxtzqc5fy2+FE5k4+hjQ3EHylwaOQtOtTMQmH0vmbM5qARHbmTVBgrGz+KXTwdSga
         P16Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRGW43fPU/8eDMFAeKGm7aHMUdIeU2ln46hFZifcpfFZA6zV3xdFFGBOr+E7HkpkT6xIVGN8wIGs/51sE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaT+bBPYn6Q/RwfjYWKzvfeHnLTFhnZkx1lTbQwcu/DTm9Bdr8
	+wJ3ZDs70f4elSfY+OGByAi4kQN6pvyOv0CIeoT5HjWm25zniWpNiDK1l6Ei5ITRHQIeQckPnaW
	aFXd1L9QTAJPBJbHXsc7Y6pY5iRS5G8ESJ3xU4VrUIyDgWCKUW88bIQ3fj0qsXSUOsA==
X-Gm-Gg: ASbGncsCpluxEclYakvVvoL1ZUHs4fJcdGfMxkOnvriEaKsibEaMG8ZpZ2i9oM9a0OH
	PXF4/v2s3GgkS+0HtrzBQWtN6z+Qp+Ipldx7GY5WNHS2/HxeRRAsQXYLZ5n2zzPfP/DF764t+nu
	c6Si+CGUJne28zXI/QEaNVh46JgMd79Uvqy4N3GrHbW6kxCygo1uiKZshw/EkHI9yLf5HXKXjDj
	KF+NW23D1aoARth5r8x6BYvpQx0EGsIS8f6kqPksDL1su31W+gjTT9B4FOd9FVklGZs+z4uGoy6
	GMt+1DQjLvJ9165DnO51VWbne2hlmMnt0ot3P34TjFKuQG88Q4Hzrz1QoqASiLl00n6RsCtMuue
	5pQUcDjPpNechWmdMadGx/dA4QOl2FI+R/Pe8wssoXafxoTezqIHEXxrtKPl8O0r/Vyat
X-Received: by 2002:a05:600c:8a1a:20b0:45d:f7f9:9822 with SMTP id 5b1f17b1804b1-46e329b27c2mr24051085e9.12.1758793122217;
        Thu, 25 Sep 2025 02:38:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVxkfcKZdBRrn77cRbQGAcPMp2dfiwtZjiOl6HprH7JU8Dt7NVvFTN8NqQoWgRk2N1EMDfHw==
X-Received: by 2002:a05:600c:8a1a:20b0:45d:f7f9:9822 with SMTP id 5b1f17b1804b1-46e329b27c2mr24050635e9.12.1758793121780;
        Thu, 25 Sep 2025 02:38:41 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08? (p200300d82f3ff800c1015c9f3bc93d08.dip0.t-ipconnect.de. [2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5602dc2sm2225863f8f.32.2025.09.25.02.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 02:38:41 -0700 (PDT)
Message-ID: <54195a6a-7cc6-4df1-a787-45d8f564c0bd@redhat.com>
Date: Thu, 25 Sep 2025 11:38:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] mm: add PMD-level huge page support for
 remap_pfn_range()
To: Yin Tirui <yintirui@huawei.com>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, catalin.marinas@arm.com,
 will@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, anshuman.khandual@arm.com,
 yangyicong@hisilicon.com, ardb@kernel.org, willy@infradead.org,
 apopple@nvidia.com, samuel.holland@sifive.com, luxu.kernel@bytedance.com,
 abrestic@rivosinc.com, yongxuan.wang@sifive.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org
Cc: wangkefeng.wang@huawei.com, chenjun102@huawei.com
References: <20250923133104.926672-1-yintirui@huawei.com>
 <20250923133104.926672-3-yintirui@huawei.com>
 <f8571506-30c0-4dc8-9995-41a6469f8fc7@redhat.com>
 <8313b0c1-bf62-4257-951c-fd7e29193ae2@huawei.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <8313b0c1-bf62-4257-951c-fd7e29193ae2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.09.25 03:43, Yin Tirui wrote:
> 
> 
> On 9/24/2025 5:50 PM, David Hildenbrand wrote:
>>> Introduce pfnmap_max_page_shift parameter to control maximum page
>>> size and "nohugepfnmap" boot option to disable huge pfnmap entirely.
>>
>> Why? If an arch supports it we should just do it. Or what's the reason
>> behind that?
>>
> There's no specific reason for this - it was just intended to provide an
> additional option. I'll remove it in the next version.

Good, then let's keep it simple :)

-- 
Cheers

David / dhildenb


