Return-Path: <linux-kernel+bounces-792718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A31B3C800
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 06:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 723C83BC7DD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 04:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B319327D77B;
	Sat, 30 Aug 2025 04:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CuXsOfuk"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4BB46447
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 04:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756529974; cv=none; b=Mu2PnyJJqouERpZd+VUf6R0INJoJKZHU32jJBz6KtdppRXyjQm43sG2Vw8Wgu/bOH/F9PIfnAXqGu4TaF7tDWzfSc1CY76VbyYkOrT1jUwa+SNSd1XZ1SPj21uo1qqn0d1HaSkoknnhLoFz6DcW6bWW9uIOM4+AvpScfieTOJdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756529974; c=relaxed/simple;
	bh=7QGll4Vou9HVMFQX7+oMS9QdkntTQkhDXdgNhD4IQQI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=Itqi3fn1VG4Eh4AD/NJph1Qvkkw1fChaeUcTZQz8KBSw+E2v3kkfA8Riw4rrCHq5pk6Wqjeyu5xuGeo1EH5EpWP4iDtjjCltZQPLMQH2b+USOMjy3iXV3AOE9K3DETCI8C+0E6IZblzkb1Qwpaoe8He4SO0o7F/CrksNhm5+3eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CuXsOfuk; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77201f3d389so3003870b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 21:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756529972; x=1757134772; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ECUtRIXM/m3p0uCZ6iejxUu4ieJmp6wy4rmOCxQvy0I=;
        b=CuXsOfukHZkSO7YoHQl3TUS5TKl6QAxGJErZZW+Fi36F4nDOBFBkAKGYRaUAScthRO
         YM5O2wvik7aXptT3yZByxo7/O0qqYWFwpdrl9FpY7ucDsHwqaeCL6KQbFTB/focGiql6
         rXuDP2fyet9BL1Yh5xJe1ryRSF5rB89bk+s0BhfGPEBgCATqXOLTqq5hu3sCJvb0sAvN
         9o4xWvaCuFtcBI7hxjfHQR1p3XXy6C6Qn1L+d5ApiVgZ5Hov8WoN6G5m2+McofIpUDv2
         jKD74n/UdbOBbh+H8mEE/fTygCznZ0TmdNJ3DJUuzH31ejVZmZi2Ne/83Nyk7l/U1R1y
         qucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756529972; x=1757134772;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ECUtRIXM/m3p0uCZ6iejxUu4ieJmp6wy4rmOCxQvy0I=;
        b=t9Yi78MJ28pVsZKtUEXIj1ebomUoqFlzFEC+rl3ZVoGoryg28tK/3scj+dk1XFb64u
         ciOWbdl9IjiIAOTEgqRO30iKnGa6o4XTqgqt2f0p7VIpjAbwdWY21XkFkEKDJ8AQe92h
         qmkjHhMx7CljPAfSxK5YAGHbrSgW0fIR4bRtYGtPT7D1p22aB0VI9wgsmF5MZKYH1QNQ
         VG9wAlA9bHZ9cSYr2xDF+N99GJH2hdwhDMrcLDcA9ffIlbqqX8zrLzifsLnUVMgpv1DL
         eNulwHyIRSZ1PO7NAHXPpGhI5KUKFkfSIpABoRSEV1haXKPoEHwmuvQBVs5J6qVOEdoY
         01qw==
X-Forwarded-Encrypted: i=1; AJvYcCX31i8PLCLJR000Bnap+0WuGxcrkHT30Bhd5JxIz5F+Rrq3txIvwbbjHIxzqS247YcftU03/YykrFJTmeY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3/tZdWPQw/s7XZExWo9k3ZR0BLDDDpayYFcckUQDQ7g3mL+Ak
	N15Us7js3PKuxv8HEve1Oj6GKFrXveAo/KLVIh1H/gZNLGogrbF7yvff
X-Gm-Gg: ASbGnct3rJgzAxrG+Q4wg1+Dg74bY0JRpH5kkjxEH/qv47KKb46LBbA7yuFaoB066n1
	tHdr66MsKmwVTjITDBNMlJpLNzY5GiTvY/UKvAMwPmL1gBW+fixQ15LsPLCH9JqvcCO02MLn3J9
	l6kzwb3lGdDuPt7BvUL4SWf0X8Fg2EggDGOac+nn23XwVeV3aldfUKgoZNVkoHwqzQBdS4rN9KN
	z+NHjiICv5v+FVvnaynyfjNQUWvy+B1UBCNBMvO+KGGOl2vnjmSWG7bDMprppXDo+RUgZ+vhbsh
	2SD5Thr4wXGc2WG7a55+RN9At0Evc65DoExE6y7wEc7kWlKkwrL86ERxsBG/LDMvxHsMLd8Syah
	ouDEnrjzy0/m1Ytg=
X-Google-Smtp-Source: AGHT+IFocOUBHixe2wv+gU96RrWRxGPvxKCNnqco4rS/r7Pe4pX8vYeeFZ0tFygY5WYh3POLg7pdfg==
X-Received: by 2002:a05:6a20:728b:b0:243:bfc4:463c with SMTP id adf61e73a8af0-243d6e5b012mr1543524637.25.1756529971878;
        Fri, 29 Aug 2025 21:59:31 -0700 (PDT)
Received: from dw-tp ([171.76.86.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4de04a9ea7sm1557942a12.16.2025.08.29.21.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 21:59:31 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Donet Tom <donettom@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC 8/8] powerpc/book3s64/slb: Add slb faults to vmstat
In-Reply-To: <20250830144542.6ba0e774@canb.auug.org.au>
Date: Sat, 30 Aug 2025 10:26:45 +0530
Message-ID: <87y0r1jtki.fsf@gmail.com>
References: <cover.1756522067.git.ritesh.list@gmail.com> <e05ac86618d8a52feccf5bac99da44b11871382c.1756522067.git.ritesh.list@gmail.com> <20250830144542.6ba0e774@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi Ritesh,
>
> On Sat, 30 Aug 2025 09:21:47 +0530 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com> wrote:
>>
>> diff --git a/mm/vmstat.c b/mm/vmstat.c
>> index 71cd1ceba191..8cd17a5fc72b 100644
>> --- a/mm/vmstat.c
>> +++ b/mm/vmstat.c
>> @@ -1464,6 +1464,11 @@ const char * const vmstat_text[] = {
>>  	[I(DIRECT_MAP_LEVEL2_COLLAPSE)]		= "direct_map_level2_collapses",
>>  	[I(DIRECT_MAP_LEVEL3_COLLAPSE)]		= "direct_map_level3_collapses",
>>  #endif
>> +#ifdef CONFIG_PPC_BOOK3S_64
>> +	"slb_kernel_faults",
>> +	"slb_user_faults",
>> +#endif
>> +
>>  #ifdef CONFIG_PER_VMA_LOCK_STATS
>>  	[I(VMA_LOCK_SUCCESS)]			= "vma_lock_success",
>>  	[I(VMA_LOCK_ABORT)]			= "vma_lock_abort",
>
> Should you be using explicit indexes and the I() macro?

Aah yes, I guess the branch where I developed the patches was not
upstream tip and when I rebased and tested, I missed to see the I()
macro change in mm/vmstat. 

Thanks Stephen for pointing it out. I will fix that in the next revision.

-ritesh

>
> -- 
> Cheers,
> Stephen Rothwell

