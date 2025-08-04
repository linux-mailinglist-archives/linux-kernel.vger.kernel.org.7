Return-Path: <linux-kernel+bounces-755620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45280B1A962
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 21:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 649CF1807B3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 19:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B0024886A;
	Mon,  4 Aug 2025 19:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGfMYjlG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06C910942
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754334625; cv=none; b=PT11Q58j/dOVKwm5dRf0PyFX2vfEhvIvmtc1ytLJ+2xpMB2GCCXLXdL1u3WvtTRk6ZFniAghtQX+H3Nbj4gltFXI4YEPjXc2s0XZR50VBjlaBH5mmq5YsRg6uTztCup1csz5czSqw824It7lGZtfZTPQulwTW2OPG7kFt1ykSSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754334625; c=relaxed/simple;
	bh=wmAutgvfAoIJXrYAP7NF/AxpLz1MDD9ep3qFSB78OdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cE8eltWrU8V5T5J2y/3x7ohkT1mWPL4QJbROmcidQvNMGJM2dnGUSjvZ3fsjxh9dwHEhoojiGUMIR0vl1tJbfjevMkTpRByY2JIACeJ8Gvh+sHA+N4AAQFLkTUkhDAWQHd1HFEM+XF8G0pxIIve7L/+f4U3SdoPCoaqyWQVskWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XGfMYjlG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754334619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QpzbDczQOWTEz8VKaqJRRztpG2xgJNR5kMd2gtLvEkQ=;
	b=XGfMYjlGBt7vQ1ZCifeLGf/PI2EgDovlzWn0NwJ3bc/29Q78iMZ4gbTwWpxlySxImczUwd
	qYLKqiMHm1Ny0oxd9rVchEB8/AiH7V5e57IlKOe9xSINEeiyMEoblgUXlktLhrcNk3GDfd
	c5WlwdGlUxa9Xpp/wnG0gdRTha1aKlA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-lpuOqk-rMY2murg-rA9mwg-1; Mon, 04 Aug 2025 15:10:18 -0400
X-MC-Unique: lpuOqk-rMY2murg-rA9mwg-1
X-Mimecast-MFC-AGG-ID: lpuOqk-rMY2murg-rA9mwg_1754334616
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-458bf93f729so9774315e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 12:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754334616; x=1754939416;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QpzbDczQOWTEz8VKaqJRRztpG2xgJNR5kMd2gtLvEkQ=;
        b=oo9D/4HvNcXrn9oDZx1T3EuGjHtI+sGyDHrOYvlQ/yPnWblmhBjr2ebU0MH0PUqx/8
         qNUtsdfO89uLyb5vb4a9bAI3N91Ybpaj+4nL7BpPHLuQyqAWcOylZ2riE0Vw7Hf5yuHq
         aH3vPLrU/Jpv7EKjUGPePPk5vH/m24Nv7x33SmOq/svezLM13U+XiEwP7P4SsOQoEzq9
         ACWM+Fi0JwDgAupHNa0ji6raHiFsRaR5lUBtp42kcyz5pRcCa9ZEqVf34WTMhuqSwWLD
         PmRQVog2jg/pp3fcj7BbjqekaL0C1WtDKmN0x4cAKyOQV3/i5+3VP6uKRR3iHUNP9ffr
         YjLw==
X-Forwarded-Encrypted: i=1; AJvYcCW3MEMPw8b4ODYYPCixtTExve/BapZj6W4T1v0zUBJTfGXQA0zzKOK3j/DgyLxA1S6RJqkWv6HzpijZRDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaa6xJSBAloXFHPmNu22lvjtMGoc4DGXEH/8sG1lVX3HJhhbyx
	BLy2ChyvjvsqRkgzDNgBn7YuaWh4Z3C+4/IfGgiSctBeXHP8w2vO3YtW74LSxkMpH/7rg1kn4KH
	54REV7RxYHOB+lOZYURZjBLk2iGUzGtt1SEnL4fH2WMVFmnaskSGlWONtkBeaSsR9Fw==
X-Gm-Gg: ASbGncvbMBX+j5CNTPhaDCaMtbYYtF9JrwmLcOxMeHbkNc6nPN1GmYLU+ULrEfRfYyu
	mAYSyXJpTwXuYslxPBzsfscF//1g6W5SX/FSrMqI7/dtTKJOukjDg67GEUnghPOb0rZ9czAcCRE
	JGMTAOJ2/X5Vwa9x8lGZvmuWDdA3IaqFRFSbUqM1Q1+ZXHIks3B2CB+r5VtnRBXB1jbPBCgZCzg
	H8TXEiPQqd0OpgCBpaF67KrBNp2J9QF+L5UEIyOL41tFmsH7Z5FqiscuOr7Z7wcPCRuT9dTlFPk
	VRYi2wATbo8vP/pFU4xdFYNFT58D1qktn6l+HAdIKhXleVebavvUdZpG5oBnnilGhq5tFIqcyeZ
	VwuLTq5ojT5uGdOrgHaxEOAyeLZj6+Ien+67Dcd1ZfbzXYz76zQWGK3Lp9yh8+ck1N8c=
X-Received: by 2002:a05:600c:3ba5:b0:459:d616:25c5 with SMTP id 5b1f17b1804b1-459d6162762mr52351865e9.12.1754334616364;
        Mon, 04 Aug 2025 12:10:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqKOc0puZuFe2BKSfXuUO51+TKPaxeerEzpJWBflJeShfRYpvNjoQBexxKd7V/4fPDOXF5Ng==
X-Received: by 2002:a05:600c:3ba5:b0:459:d616:25c5 with SMTP id 5b1f17b1804b1-459d6162762mr52351565e9.12.1754334615920;
        Mon, 04 Aug 2025 12:10:15 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0e:2c00:d6bb:8859:fbbc:b8a9? (p200300d82f0e2c00d6bb8859fbbcb8a9.dip0.t-ipconnect.de. [2003:d8:2f0e:2c00:d6bb:8859:fbbc:b8a9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459c58ececdsm45294775e9.1.2025.08.04.12.10.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 12:10:15 -0700 (PDT)
Message-ID: <5bf65002-8d2f-4b9b-8f22-3ba69124335c@redhat.com>
Date: Mon, 4 Aug 2025 21:10:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm/page_alloc: Add PCP list for THP CMA
To: Zi Yan <ziy@nvidia.com>
Cc: Juan Yescas <jyescas@google.com>, akash.tyagi@mediatek.com,
 Andrew Morton <akpm@linux-foundation.org>,
 angelogioacchino.delregno@collabora.com, hannes@cmpxchg.org,
 Brendan Jackman <jackmanb@google.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Linux Memory Management List <linux-mm@kvack.org>, matthias.bgg@gmail.com,
 Michal Hocko <mhocko@suse.com>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, wsd_upstream@mediatek.com,
 Kalesh Singh <kaleshsingh@google.com>, "T.J. Mercier"
 <tjmercier@google.com>, Isaac Manjarres <isaacmanjarres@google.com>
References: <CAJDx_rgzkZognxWzOXJ-ZxdTtUaM3FT6bmpkwxMz03XiX3fKAQ@mail.gmail.com>
 <d395b14a-9a84-4f25-b4f0-45e8500fc5fe@redhat.com>
 <8A3D2D44-DCE9-48FC-A684-C43006B3912F@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <8A3D2D44-DCE9-48FC-A684-C43006B3912F@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.08.25 21:00, Zi Yan wrote:
> On 4 Aug 2025, at 14:49, David Hildenbrand wrote:
> 
>> On 04.08.25 20:20, Juan Yescas wrote:
>>> Hi David/Zi,
>>>
>>> Is there any reason why the MIGRATE_CMA pages are not in the PCP lists?
>>>
>>> There are many devices that need fast allocation of MIGRATE_CMA pages,
>>> and they have to get them from the buddy allocator, which is a bit
>>> slower in comparison to the PCP lists.
>>>
>>> We also have cases where the MIGRATE_CMA memory requirements are big.
>>> For example, GPUs need MIGRATE_CMA memory in the ranges of 30MiB to 500MiBs.
>>> These cases would benefit if we have THPs for CMAs.
>>>
>>> Could we add the support for MIGRATE_CMA pages on the PCP and THP lists?
>>
>> Remember how CMA memory is used:
>>
>> The owner allocates it through cma_alloc() and friends, where the CMA allocator will try allocating *specific physical memory regions* using alloc_contig_range(). It doesn't just go ahead and pick a random CMA page from the buddy (or PCP) lists. Doesn't work (just imagine having different CMA areas etc).
> 
> Yeah, unless some code is relying on gfp_to_alloc_flags_cma() to get ALLOC_CMA
> to try to get CMA pages from buddy.

Right, but that's just for internal purposes IIUC, to grab pages from 
the CMA lists when serving movable allocations.

> 
>>
>> Anybody else is free to use CMA pages for MOVABLE allocations. So we treat them as being MOVABLE on the PCP.
>>
>> Having a separate CMA PCP list doesn't solve or speedup anything, really.
> 
> It can be slower when small CMA pages are on PCP lists and large CMA pages
> cannot be allocated, one needs to drain PCP lists. This assumes the code is
> trying to get CMA pages from buddy, which is not how CMA memory is designed
> to be used like David mentioned above.

Right. And alloc_contig_range_noprof() already does a 
drain_all_pages(cc.zone).

-- 
Cheers,

David / dhildenb


