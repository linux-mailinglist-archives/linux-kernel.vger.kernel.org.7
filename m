Return-Path: <linux-kernel+bounces-846281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F67BC7774
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 07:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67E9B4E94AB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 05:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D28C25B1D2;
	Thu,  9 Oct 2025 05:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEbyj9tl"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04999AD4B
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 05:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759989249; cv=none; b=gA8FqV/DuRA3lDLhZHBjeJN8Zzm+9qqD07dyxYRNOQJJeuMCmlxt0UY9hxAl4pSrIOBGfEWjWstR7paKVcAP6yylbkFQjhZkS4vKtKDjgqOIg6CCEWFDpbFJDlS1Ybcc7BDXdkfcM5qf5OVKG6K+AtW1kHrzi4pJqeeFnvR1aj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759989249; c=relaxed/simple;
	bh=5Nb8rf3yk+t4vTVfFxs4xcB1HqmeFe7n4StAAlkIHPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZhMT73EErRCptnepjFKe+732/TcUZGlaA84/cxTxjxWb13lOeNZes1KssssyjFfCNa5ttsd5BP0EitQSGM8oJnxrrssgDbj+xDmvs3wMCvhIaHSWJqCXS3JNnWp5Un/ZECmKIpDajQtUrKMQZON87b/+3bglv42XBN8tYqqLmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEbyj9tl; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e4473d7f6so3154935e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 22:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759989246; x=1760594046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQwWvvs0ghZq8zc4r9h5lIan/PtlkEVYSWj9AFivA18=;
        b=aEbyj9tlGbGlHcja9+xpG3g4dYKMTc8i86GTdY/zWcOh2+LcH3hJ6n9VHZi1PLroJs
         V2aJZxnq63v/HkKcZIPnDZzyeY6lemGW7dJ2p4No1X9NDdERCCPsYaw64WsKlun+f0Zu
         KO03qOKThA57kbxunulhK4a9AOMLS067APxysc9sR17fC83B3FD2+bCJ0ktbIxlJhgw8
         i8IgR9kRK0YKbTjI6H6ls3HASPZAHoTKdCV7DrEmgd0VkSUyJPVmBxG3hxnrNHZcgHTK
         i+zyEugZFs0MxzwHd/V9JS0BzPqyet55cx0Gnf/l5KsMl07RWDSyn0LdNErl0ozL64b8
         yPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759989246; x=1760594046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQwWvvs0ghZq8zc4r9h5lIan/PtlkEVYSWj9AFivA18=;
        b=fqHzMmiKftvDlVkJG28Tmigj9oxZP7nektRKsHCDFek25I/eaAurQx+CSPxR2hSUP8
         rZqOTa9whOZlMOBQgq15W9s4iBoFgZUlWmbZYxhOomCzdylGN52gSlqIoOo0VsCMV5JD
         VixKGtojiL3Y7PuFXBPMxuQR1QhQoFCWREPc7lwnJeHTcg2+WoFOvKTDYHVFSjv/GH3H
         74ugsRHOUSsHJxp/oO+qzRPQomCyzz+FTc+NahI9aMMb/jJ97B/+HMOrMDnpKkyTFFq3
         K4CQGtdMAxsWAMWb9QyDM6hcFJJYlfG88maS2LnX3w+7E7nBpEotHQqa0imLFNQzo/aQ
         gCkg==
X-Gm-Message-State: AOJu0Yxl5cWoZDsHxNtV5a149q1j23iiqHnGi7CVUE+BadgCloAJceVR
	Z/hUTrfsk/K9VIqOyWA3cj3YSNQonHn1GRg+oYCy65440LKrdmAvqd1j
X-Gm-Gg: ASbGncsKfIdM4LFTW/WE2f7IFPBid0ZrFMNRMunPlK6hEK/ULUKHTjsbetdI6j0QTlf
	BuyJdcH/+izuVjDs9s+7729fIwiQwEJGrP01wTOci2h0OXVw1qD/o4zVRDbNV0HOODCFu7dxju7
	/LFhnvFORdEm9a5MG+L1ZfCjuijeB0WiEtnM98NBoGlNCnpBqi27yPUSwkO03T/vmkzo8d0c1Us
	BtPl18TdD27T+tyZ1WL6SZXp402DDp2a+VyNyETJ1zuzo1ieh+sUprrg7kWbO1CXvlHAQeubsaL
	70F1Ml6XlWFgNGsTYjPh7TokQ++dXJRNrdQ178SyIHqX8I27JjzaKI0dwriv1iZ/qIb34TGK57A
	TXa9gAEBx/6kKuIT95CzfL/SIKteIyxeiKw9e4wIh2XYkqg==
X-Google-Smtp-Source: AGHT+IFD0icIVhoTNWR3ZSoy0958G+47lHMZ4if/obpZ13INzMYnCQpoDVT+IeNh0q0RioLY0f7rhg==
X-Received: by 2002:a05:600c:6212:b0:46e:27f7:80ce with SMTP id 5b1f17b1804b1-46fa9af8f39mr41575065e9.23.1759989246026;
        Wed, 08 Oct 2025 22:54:06 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([2a09:0:1:2::3086])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9d629casm66416825e9.16.2025.10.08.22.54.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Oct 2025 22:54:05 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	urezki@gmail.com,
	yadong.qi@linux.alibaba.com,
	ying.huang@linux.alibaba.com
Subject: Re: [PATCH] mm: vmalloc: BUG_ON if mapping size is not PAGE_SIZE aligned
Date: Thu,  9 Oct 2025 13:54:01 +0800
Message-ID: <20251009055401.94174-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251008211714.5a8b9fbb57dbe454cd4a9c6d@linux-foundation.org>
References: <20251008211714.5a8b9fbb57dbe454cd4a9c6d@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> In mm/vmalloc.c, the function vmap_pte_range() assumes that the
>> mapping size is aligned to PAGE_SIZE. If this assumption is
>> violated, the loop will become infinite because the termination
>> condition (`addr != end`) will never be met. This can lead to
>> overwriting other VA ranges and/or random pages physically follow
>> the page table.
>> 
>> It's the caller's responsibility to ensure that the mapping size
>> is aligned to PAGE_SIZE. However, the memory corruption is hard
>> to root cause. To identify the programming error in the caller
>> easier, check whether the mapping size is PAGE_SIZE aligned with
>> BUG_ON().
>> 
>> ..
>>
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -100,6 +100,8 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>>  	struct page *page;
>>  	unsigned long size = PAGE_SIZE;
>>  
>> +	BUG_ON(!PAGE_ALIGNED(end - addr));
>> +
>>  	pfn = phys_addr >> PAGE_SHIFT;
>>  	pte = pte_alloc_kernel_track(pmd, addr, mask);
>>  	if (!pte)
>
>We try to avoid adding BUG()s - deliberately crashing the kernel is
>pretty cruel to the user.  It's far better to WARN and to continue in
>some fashion so the user can at least gather logs, etc.
>
>How about
>
>	if (WARN_ON(!PAGE_ALIGNED(end - addr)))
>		return -ENOMEM;
>
>?
>
>(Or VM_WARN_ON)

I agree with Andrew. Using WARN_ON/VM_WARN_ON and returning an error is
the way to go.

AFAIK, we are moving away from BUG_ON() in MM whenever an error can be
handled gracefully.

Cheers,
Lance

