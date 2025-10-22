Return-Path: <linux-kernel+bounces-864616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0AABFB2FB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F74E4E37E9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2563E295DB8;
	Wed, 22 Oct 2025 09:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPK+dzsm"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DA928488D
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761125889; cv=none; b=CBYMAiEJOB0pQmmX74PRsj76CsKnQ6w8/3XwuqD44iJpIz/FCYCuiSSztBj4erjtTmdzxz9J9iUWIUOR6Nb/c8E/9LnXFLxWpLysb42sXOtU2GBeaRxU2vNLENIfOE6qxGJa2eo6x1JxmjK5i4hgOMldkocf9AxDETybDTmDGG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761125889; c=relaxed/simple;
	bh=y+I/LwqqDB9pXpDXKCV/nv/6aZw2Lg2pKBs/RJwW6Gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nrn4VenGyoBgzfzTzS+tKt2iOIpAtTJX9eoYO6mJuxYlast+UsyMUzUT3hvRLGrVbBCOuoEGxF2OilFSZBt5JAylKWUGVpxGYoYv5MVmpLQeMMB0f3mily8h1X0qbetUFZCiGYObhZvIP0b38Y31OwKCAuU0vBWBdujuYoGo8W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPK+dzsm; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4e89de04d62so8353441cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761125886; x=1761730686; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HJdPu+39G4lB6AuXLRBW7mSkqYwO4pjl1bYy6jRlyTM=;
        b=iPK+dzsmqqwd8Dm05OY+3GPj7Fjm4DLGbG0b18ba96l42j3aNvj9I+Y8yVXFL4230Z
         QIeyKJLcHyUJTaVwrVBxMr3Otufe20Ihp7WmD9g4VIN1SD8dNu5QR40ecMP2HYA+Dadk
         nJCCUqlZg68KwCf+XkfBGfu15ohmm4iPLRd9mKbybSqeoS9/y/3pvFaWIZgjDdvetvrk
         jhociuFMRNPrqq5ysJjyZENMpfy3pGrxMfhr1tmzxGoV/+1b7D0+H+ILtOCaw4GJPmAD
         XQ74iLzaIMOA+K/7YnjZ6x7VVYECW+a9U+stkPK6W80xHOzsUJVSiKgwggxvSHzbcjGo
         meUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761125886; x=1761730686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJdPu+39G4lB6AuXLRBW7mSkqYwO4pjl1bYy6jRlyTM=;
        b=vDldlZ5eMgDcoc3AT41SHL+xO+xWWhJWqQQajQYzjCj0xyuQobINOZmYULVWyNjndU
         dZmvsr41jRPGOE22R8iUrocZLcRlbrYnNgbxt+Y5Jf2BKZ4X+NZrbmqe1Ggm6EgLlZWT
         BZm+zQWgNyMAAh24Yc4WcZ+YQvERQuf/CRUL+b17G03ByDOjgaPgy9stwi4jOZ81kw4J
         utyBcSI9agC8OHfNo5DMhF3YEfKsNPHjQPc9gKsWXXt/ysZ+m45kXh09AF+YWqgiaqde
         LI7BTf42Dm+hfEXY6XXW0wRAy2YCO59+0rsXYNq7FOBaVuOvE4leZxlJAzosySPlu+Uk
         tBAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqDluRPL/KlXPWoVqI9+Lf32AcUAKs/Wr869lUkAEhaZ0BnIFqkg+s4pCwGPO6P/mKJuC3vVQLd21cAKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOWFev8XtDpG4wXYqAVEWZEQeZiZ5BiDW308gRkvumwOLVadUP
	WoMj/j4cydmXxRbuVrG2KmjISCIaYZ3ad9Q79mc40FJSeQnq64EVPDkjwrT6Q3oLFoGq93Wb5VW
	kfZphQapDcJ/KriIOCnF+MZDfIUFqqjf+Vts6
X-Gm-Gg: ASbGncs+NUUXF/55tm6MsozXF/NWKW05MM5EeDA41Cbhao9xChHwiZ/TXwJxR0qhLeq
	gSDGSJDsKmGkvpNrMAAz/gK3wKkMPHMQM8vv0LrsTARuaAI7bWguJPEn+32/KIKPYhmVGrEJf14
	RSEreLvbLtuWz3LMhKFEkQFoOhdq2ECHt+YlGZ+jMobcBnuFyM1AbKmXo9uZz6U9HhEBoHTp+hi
	7EnmL92XSSBVPkJnnLQUYDvTjcvP5LSizyOvbP0AxCUytkzIHsLWAw6zBpoTNIsH3hDB81ZQ7xA
	d5OG5HxNKV1avQT6FvLLy+AnEDY=
X-Google-Smtp-Source: AGHT+IG7gcxDomeEPXSQvywf68coWtEHDrJFLjeKkKBNT49t32BEMq0zgoHm8kjhpWZ3V5AxfkOg+1IItd2+7snHvHM=
X-Received: by 2002:ac8:588d:0:b0:4e8:a2e8:3473 with SMTP id
 d75a77b69052e-4e8a2e8360amr228927981cf.13.1761125885712; Wed, 22 Oct 2025
 02:38:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013092038.6963-1-ying.huang@linux.alibaba.com>
 <20251013092038.6963-3-ying.huang@linux.alibaba.com> <CAGsJ_4xaA8QRjP9H=n1hQfEfGop7vOd5Y=J+KQzuOyfa8GK-kQ@mail.gmail.com>
 <87a51jfl44.fsf@DESKTOP-5N7EMDA> <CAGsJ_4zPH0fwBOLQwh1y6jG3tCXHLGRCTyVVSCWb+NfLCEMV0Q@mail.gmail.com>
 <871pmv9unr.fsf@DESKTOP-5N7EMDA> <CAGsJ_4zW6ogVdi=t9JCuvGD9N21mA_ORXRCakw4Av68d9n+DDw@mail.gmail.com>
 <875xc78es0.fsf@DESKTOP-5N7EMDA>
In-Reply-To: <875xc78es0.fsf@DESKTOP-5N7EMDA>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 22 Oct 2025 22:37:54 +1300
X-Gm-Features: AS18NWA2mUCn-m7yzg54mG9Xj4DEjFUtxQVduHJ8uk8kWT6HeuKAOvMULXrelik
Message-ID: <CAGsJ_4zKGS-Xd-58ufXGoyRfaZWd8wTgv0b6ibHJ2aS14mQqtw@mail.gmail.com>
Subject: Re: [PATCH -v2 2/2] arm64, tlbflush: don't TLBI broadcast if page
 reused in write fault
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Yang Shi <yang@os.amperecomputing.com>, "Christoph Lameter (Ampere)" <cl@gentwo.org>, Dev Jain <dev.jain@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Yin Fengwei <fengwei_yin@linux.alibaba.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

>
> With PTL, this becomes
>
> CPU0:                           CPU1:
>
> page fault                      page fault
> lock PTL
> write PTE
> do local tlbi
> unlock PTL
>                                 lock PTL        <- pte visible to CPU 1
>                                 read PTE        <- new PTE
>                                 do local tlbi   <- new PTE
>                                 unlock PTL

I agree. Yet the ish barrier can still avoid the page faults during CPU0's PTL.

CPU0:                                                                  CPU1:

lock PTL

write pte;
Issue ish barrier
do local tlbi;


    No page fault occurs if tlb misses


unlock PTL


Otherwise, it could be:


CPU0:                                                                  CPU1:

lock PTL

write pte;
Issue nsh barrier
do local tlbi;


    page fault occurs if tlb misses


unlock PTL


Not quite sure if adding an ish right after the PTE modification has any
noticeable performance impact on the test? I assume the most expensive part
is still the tlbi broadcast dsb, not the PTE memory sync barrier?

Thanks
Barry

