Return-Path: <linux-kernel+bounces-747698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A5EB136EB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 781C73AB674
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F0F22538F;
	Mon, 28 Jul 2025 08:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z7aI8LO7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DFD2AE68
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753692261; cv=none; b=G32hNsnCRw7XBEBCJRoiea3VccLKti9z0mH6spw7FinZQH/ZgUqWxZ1WJ5kc4feHcXTVGf9Bt/YoMOBLinysJvXAWtRftNGCUDYk+pmX1Oxq9F5xl9z+h6YyyCWIZqo/ZXRDGyMKzd2eJ1wAeFQn4OZsjU6L0nqLiGlPB7p3xsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753692261; c=relaxed/simple;
	bh=EiKn87jOIjGLXIOVof4Wp8gCZH8OZNLgi51jQhfE0CU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CUmAWYODbTwvhohJn/9pnFzDSpJmbThAdQYMPV4Ajd0einLnYwva4Z66XyDOwzw6RZdGCYuZKDlQNI916F5TI5Zb5UpXuM1lhmmC7LV77XOyN4fUvT6CmoQ1ZJGoUhWzElcnJ43yjlMlaaHgQe0LOWGB3b7i2oqkeIJHxpD3jQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z7aI8LO7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753692258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5z3VFCWPYn+gmTSxxeyfj7eJ1ITAoaTTjNvudffwKO0=;
	b=Z7aI8LO7JwauPGPdl4A6R6xRloruLiNcXTXq2a/viUAsBDd+7pcO0fSjaxHZxg1CbAESd5
	5XoDsLIn9uke81dJGO3YYt0eLztQ+CG3M17gu2+IVWWtTMGLTLfz9uChZaEkoTO1tk9bDt
	jLdkB1TTOQ5RPVZM+I7Rh+6h4OsdRtU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-t0Xyv0RvM9quj_z_RayobA-1; Mon, 28 Jul 2025 04:44:16 -0400
X-MC-Unique: t0Xyv0RvM9quj_z_RayobA-1
X-Mimecast-MFC-AGG-ID: t0Xyv0RvM9quj_z_RayobA_1753692255
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b7886bfc16so467492f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 01:44:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753692255; x=1754297055;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5z3VFCWPYn+gmTSxxeyfj7eJ1ITAoaTTjNvudffwKO0=;
        b=kbYhiDMcneDjMYJFlOSoVtsd8/26bBBBcMrLAB750JSiPy+Rweqd15Bb75aLQh+vBR
         vPnEm+zG41YTOQux8kBIix3zMg7LCx84cT4H9PD9cn0B62rTR3TqlHuotTlxrmT7M/LQ
         gtIit2GDcHDIJJVH85CsIqPu65cjG2n2OMipmka+V0HUMBDmvk3vYIMEOCGbsaf5r02q
         b+DmngTO+HcqE2xsOwUiB+2GAVIJGvwM/LqWqdv10osHnh4hFjOlgBKR3M6y8jMAAAzC
         GAiT7MHthX16dx+FgPnwaQ4Z8Ux9NNxWZfr36xVOtzD2p4tDPmbl9gi/opj78/hSPP8K
         ZOUg==
X-Forwarded-Encrypted: i=1; AJvYcCVID9ymg7yVUVb6AYk6bcgjsF/4xgfNQkXJU/BI3JuVQNwb0VuTz9tVYEt3nyEUxkPCUbSPYxlo2ZwN7Rs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/s9xCTeO56s7Vw0ESEFGwT/2gUJYZSXyAuMaSO4WCQWrfyZyz
	6LyvzYBUMRyER8ydxipaXi0dMhl0GJgM9xLnT8Sc8YKP7+9v+SCHosz44m523oXsvj4a8Z9DLmz
	Jf2lu2g5W1CmuOrfWjEiH1hk0Qa9lPh+17xskajBfwwyCBgP+19qZ9lpC5fqyty5tnJ3sU3mRr+
	TZ
X-Gm-Gg: ASbGncvI2Ku2dhpmtGwFMvTDxruMdDIGkjOGs8VBjbrIKoVy1ci4w0B7bSrstmUHISG
	yz0WgVv4ElY2P/0UqKrDLBxB6PqxQFnErnOikG0kHd5s1Ruz9mWr2sgshH8XFZSa4PG5htv7ied
	hIVQ2pvwJPDwOx34DdIYM04k6Ftfpwes1IM3dO+zesZEFd2GeEz+Qt++Zwh/FwZl5p/JWhH1zu7
	bb+8fO3wZdWA3PYPbgaWEuMWTd+CD+shf+eK9jgkuVmoKzkmZua4OKjBuwJIU0/1zszD5tbujP/
	cPpKUmRxwK7x9pWM2MNHbEU/TfjzdmPP28Xi3/TrmbCdra276Db+hltNEBINtcnqqnALjNoFz59
	feSFkQtHI+NQXt7v3WZ4/+bDKTcG0Gv3+lmKd+UK09WCvS7AN6FHbyPxRD2wmRNyzrBE=
X-Received: by 2002:a05:6000:3111:b0:3b7:6828:5f71 with SMTP id ffacd0b85a97d-3b7767269f8mr7807410f8f.9.1753692255083;
        Mon, 28 Jul 2025 01:44:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHd6G4uLhKMUYr/Rv5FJNEPLTk3+fMSTOpDvXYMNFZlfI0HQaNGucKbuqA4Wirb9CWkg7bKLQ==
X-Received: by 2002:a05:6000:3111:b0:3b7:6828:5f71 with SMTP id ffacd0b85a97d-3b7767269f8mr7807386f8f.9.1753692254590;
        Mon, 28 Jul 2025 01:44:14 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f47:2b00:c5f3:4053:2918:d17c? (p200300d82f472b00c5f340532918d17c.dip0.t-ipconnect.de. [2003:d8:2f47:2b00:c5f3:4053:2918:d17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b7811b82c6sm6510602f8f.49.2025.07.28.01.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 01:44:14 -0700 (PDT)
Message-ID: <4057479d-6ece-49a2-b823-99748e8c9c35@redhat.com>
Date: Mon, 28 Jul 2025 10:44:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Disable auto_movable_ratio for selfhosted memmap
To: Oscar Salvador <osalvador@suse.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Michal Hocko <mhocko@suse.com>, Hannes Reinecke <hare@kernel.org>
References: <aIcxs2nk3RNWWbD6@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <aIcxs2nk3RNWWbD6@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.07.25 10:15, Oscar Salvador wrote:
> Hi,

Hi,

> 
> Currently, we have several mechanisms to pick a zone for the new memory we are
> onlining.
> Eventually, we will land on zone_for_pfn_range() which will pick the zone.
> 
> Two of these mechanisms are 'movable_node' and 'auto-movable' policy.
> The former will put every single hotpluggled memory in ZONE_MOVABLE
> (unless we can keep zones contiguous by not doing so), while the latter
> will put it in ZONA_MOVABLE IFF we are within the established ratio
> MOVABLE:KERNEL.

It's more complicated, because we have the concept of memory groups.

Dynamic memory groups allow for a mixture of MOVABLE vs. NORMAL within 
the group, static memory groups want a single type.

Hotplugging a large DIMM would online it either as MOVABLE or NORMAL. 
Similarly with CXL.

> 
> It seems, the later doesn't play well with CXL memory where CXL cards hold really
> large amounts of memory, making the ratio fail, and since CXL cards must be removed
> as a unit, it can't be done if any memory block fell within
> !ZONE_MOVABLE zone.

So, user space configured a ratio and the kernel does exactly that: obey 
the ratio.

> 
> One way to tackle this would be update the ratio every time a new CXL
> card gets inserted, but this seems suboptimal.
> Another way is that since CXL memory works with selfhosted memmap, we could relax
> the check when 'auto-movable' and only look at the ratio if we aren't
> working with selfhosted memmap.

The memmap is only a small piece of unmovable data we require late at 
runtime (a bigger factor is user space page tables actually mapping that 
memory). The zone ratio we have configured in the kernel dates back to 
the highmem times, where such ratios were considered safe. Maybe there 
are better defaults for the ratios today, but it really depends on the 
workload.

One could find ways of subtracting the selfhosted part, to account it 
differently in the kernel, but the memmap is not the only consumer that 
affects the ratio.

I mean, the memmap is roughly 1.6%, I don't think that really makes a 
difference for you, does it? Can you share some real-life examples?


I have a colleague working on one of my old prototypes (memoryhotplugd) 
for replacing udev rules.

The idea there is, to detect that CXL memory is getting hotplugged and 
keep it offline. Because user space hotplugging that memory (daxctl) 
will explicitly online it to the proper zone.

Things like virtio-mem, DIMMs etc can happily use the auto-movable 
behavior. But the auto-movable behavior doesn't quite make sense if (a) 
you want everything movable and (b) daxctl already expects to online the 
memory itself, usually to ZONE_MOVABLE.

So I think this is mostly a user-space problem to solve.

-- 
Cheers,

David / dhildenb


