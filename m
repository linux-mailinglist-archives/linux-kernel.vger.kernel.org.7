Return-Path: <linux-kernel+bounces-811732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E34B52D23
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 394B41BC05BC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53902E9753;
	Thu, 11 Sep 2025 09:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RXdYTtJo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9287C22126D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757582692; cv=none; b=IZE5yphK45LhpS1Bx0Rk0g/8JjlAQHzC5QDDV4ycY87cvLoT/wwlyz0G65NzK6kPXhjjc0KYy4zXK7gU2zu3QMiS83AzF65o6YT1umsDr9EIbruGYzRIky9nJ+jCXHE+zji92GCZoV+cY23D4SWKMwmVx4sII7Xs0DPABaOUOCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757582692; c=relaxed/simple;
	bh=8nRmDKu7oLPSchva3DTxsRv9dlRjqhheV02eyVGr20I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EPjTaaJxoiek1L2mngZjhraOLsB9Lg/moXSWaiiv/Sdj5n8ShirLB0/WsQgO0XOWCgk2e1ACHUr4mK4A/iDPAgbzPsGCBQx+iShIJ+xv5/GHaIVlsQ4DRAYnuPNCIkJsLkv4Gujl7KKS8Ki+VkW+rsIqDPlgxRkC16KgmvKGQQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RXdYTtJo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757582689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mPk7/S2bDhCXiWGOHhSRKWwJzJG6TH0qkWUBVK/uCX8=;
	b=RXdYTtJoLTjcQrao5KeriuLsVha84kyE62uydBIMXSp3APdwsalczrFEybn9IMAZFMXAyw
	SEMScLSDg2y1R1fBRTfms9m7jBCFAu4jLpbJyE4ipSRC6fWSvpFUZtj/nZvsbBfNAfCFJP
	gBiFA4oy653p5EghaY/LjOsUMWO3yFw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-_2X9TbQeNkeqwoN561O_tA-1; Thu, 11 Sep 2025 05:24:46 -0400
X-MC-Unique: _2X9TbQeNkeqwoN561O_tA-1
X-Mimecast-MFC-AGG-ID: _2X9TbQeNkeqwoN561O_tA_1757582686
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3df3e935ec8so269240f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 02:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757582680; x=1758187480;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mPk7/S2bDhCXiWGOHhSRKWwJzJG6TH0qkWUBVK/uCX8=;
        b=rwqCG5LC3t61RknDxdaDexiB5qzAAbCudCmhX+0b676hzS2xghIb1Cl+sH+P4Y/Nbp
         Txb8ZWqKFvDYcTTzsfZDWUr44SULZK9OVa32Yq9PaJsOcTVAkfK/b/hGlI8xyi6LmGvT
         u6XL4FJX2Yu6jPCM+gSbJfb8++7scbWzeIyBA23WdoZoy8XZ6uqKAPTBqrTxx1nIsF4x
         LvKwKuamOFiVldhpVn0T04h2J/C5IA6G8nEAE7CLexxch/m35ixuTAgcWcVg+DJP3vlk
         lI+/nJMVkmiG2bMXeM5N9g4jM4H2zfxHp+5cT4aK6UJnKlmryU60/uQwgQI0SLpBgVgU
         9gCA==
X-Forwarded-Encrypted: i=1; AJvYcCXS7P7ENjIk+vW0Th215XneZwWzTdne4Y8ZTDmB3AcQhQcorsQEliDE2ahN91LlcicHsKZbvwBKPCGefw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI3xST2VHemIG4HG7/lnxlKQxDUg66WYybisZCQG/cM01ghXui
	hBZ7G0HGhGY+QcI2FGicE85pWxKiS7Pf9/ELFMS8kebtUQs5RK6MNFXykCumPtGNSQlio+7TrGB
	AwE2GbYkBAO/xInqxdRBUdERsgUtXHILaOi49KFLt7G46lqkxDn5tuCFG3/DCFaBWUvDX4agICA
	==
X-Gm-Gg: ASbGncvqhPLGTWsaxef5I6tOsj8LaPUocUOnBKpRnZwts6aR4lHYPQRNelzsdUFSD2a
	0f7lukbjhoCIVadLTjiDymqHra63oh760UV4EQGGgwzBCP61ZhV81+iMtGQWfy2pWHkcCct6anm
	ZdVe+nx7rpBSaFZ+NYhF361ZgWOUx9gFAzHsPtf7J9VUD6SkbahJsHzr9M1A5hvjWhV2PC6Ieoi
	wr02Up7gkeaKFszZt0q+BpRmwropksFAWnBS+0eXuVICvJBkxv4P8kJXlvyrYX7/CpWClW/EZ1M
	VKqzpSAznyN1OakTv/EY2CmOBYJzZJGXYK/THtUDJJ8PIpbtPsHhNobwL9iAiFijCC2wckXRAQY
	DOtyOukiRIu83XYbZwgVsW2sL+shO3rfAmLCiDdpkf46oXH3kBo/rrLodsFzcU03Ejlc=
X-Received: by 2002:a5d:64c9:0:b0:3c9:b8b7:ea4e with SMTP id ffacd0b85a97d-3e637370e00mr14669018f8f.19.1757582680168;
        Thu, 11 Sep 2025 02:24:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtiYpUnGkJ/VVNrkyKsw+QSksGppEKMCiyAJAYnJlmmNayclRtWT8dXna7B1i/EoSa143PXA==
X-Received: by 2002:a5d:64c9:0:b0:3c9:b8b7:ea4e with SMTP id ffacd0b85a97d-3e637370e00mr14668996f8f.19.1757582679746;
        Thu, 11 Sep 2025 02:24:39 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f42:b000:db8b:7655:f60f:812b? (p200300d82f42b000db8b7655f60f812b.dip0.t-ipconnect.de. [2003:d8:2f42:b000:db8b:7655:f60f:812b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607e40a5sm1677749f8f.60.2025.09.11.02.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 02:24:39 -0700 (PDT)
Message-ID: <11f35ae6-2891-44cd-a670-92ef2151b885@redhat.com>
Date: Thu, 11 Sep 2025 11:24:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/9] mm/memory: Add tree limit to free_pgtables()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>,
 Charan Teja Kalla <quic_charante@quicinc.com>, shikemeng@huaweicloud.com,
 kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org,
 chrisl@kernel.org, Matthew Wilcox <willy@infradead.org>
References: <20250909190945.1030905-1-Liam.Howlett@oracle.com>
 <20250909190945.1030905-5-Liam.Howlett@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250909190945.1030905-5-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> +/*
> + * free_pgtables() - Free a range of page tables
> + * @tlb: The mmu gather
> + * @mas: The maple state
> + * @vma: The first vma
> + * @floor: The lowest page table address
> + * @ceiling: The highest page table address
> + * @tree_max: The highest tree search address
> + * @mm_wr_locked: boolean indicating if the mm is write locked

I'm sure there is a good reason why we don't call this stuff here

floor -> start
ceiling -> end
tree_max -> tree_end


-- 
Cheers

David / dhildenb


