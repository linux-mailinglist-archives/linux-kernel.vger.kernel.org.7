Return-Path: <linux-kernel+bounces-798818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F0DB42365
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FAF01644CC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9DC3093C4;
	Wed,  3 Sep 2025 14:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5aiZRvn"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67205309DD8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756909127; cv=none; b=H/o6g3sfie3LAqE/E1GXcO2c5Uh7Wi9YPmqxiXtoP02IIL4ETV0UWBwRUDU/NSx8Czlhc+U4SWG2o3ZPRZ/2HkH0daq4yZG8ZTL9xTFnjFnN7yE3A7aKlBeQZFt+ed0REJTcP3FfgDwUZZheQjyQOWH25kBXQVLPODZvbBN3KG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756909127; c=relaxed/simple;
	bh=5EKM1P4x06LwVEjOAy6ALEdD4PBI8WGaUOZa39K0e0M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ski139Ms+XDJK1DWcxpm7uXXFfW8YZmPdnUR+v5Yh3qaCJS0b2s+GJr5AgLcdU9kFl76nki2e5lZAw6kLXtuP3e0bwRlVFgrFjd5oCFrnnbYfsfnv81gMVxe7st8fx5mgb0LxJjhZFgwvJE6k4feV0v9W+6eOLI+q6xsuGWFzbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5aiZRvn; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45b7722ea37so6083955e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 07:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756909124; x=1757513924; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1tH95Juuh1rXl0JBiJjZ+pvaXEYbkUC7vChoclECFQ=;
        b=B5aiZRvnJlEOQ5pAMVo75eYHMWTSo6g9n/8BwxgHntMWyA6lRVqMLXExTTNdUPLnc/
         Ejl47FPP9IAKMnqGWvuskW1qBV88oAfJsp3OPhLe0BP4BRhpwBPoiMGeCzFkJUEmWps1
         ZjFfARAvaKtAO1shy9SOqgSjGL4WlN0nN9C+KiuBLBZ25IsHvj0MyR/Gu9f1Ia4O4m9A
         42dv/jt/aEXW1CI1fPmA4Ws1r7wSp8fuQbLhT5PWUSJg0esDC6UF/sylhGACKUVfqeeU
         PJJSQD/UiqPBddZ4Ds/Mg3M5xQA8UvFF428cTkxVUBEhHibRLFCGyOYxX6VrvXJAJbkx
         BRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756909124; x=1757513924;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1tH95Juuh1rXl0JBiJjZ+pvaXEYbkUC7vChoclECFQ=;
        b=S+QfaDHHeVPUUGd7mGRbioGUK+nXK1aXNFOuBXx/Tex5TSGGHLybSo6lGfrdMkbcuk
         5GwE97sm0iASPv7CDxdM0xo3xrm3zX/EvZ3OY2vE+yNxTMw56qN3Koam+HC4YhItXiK6
         o2Yf/PSpoBpYwgKIm/GwQeZIaV4dZgmc31grEpDB/FMUqC3g5aPONmxfjV2Ls/n/vRoZ
         Z58qpzy0FppVaOrpAlG47YMXIEniS38ZExvh+KYi1thfo6FJGbuwvwCf29zEwYRXiiCA
         U+60cZ27aDzBXm92RoJJzfksgl0uBg0+NvfmCLrGw2e1w4pIiwcmPDE/LAd/jb6WHiqq
         P68g==
X-Forwarded-Encrypted: i=1; AJvYcCXiO5ubXs515+9MX8dKH19mjuM0zcekb7Vf5tFVUuxaly6NMeirGU6H9a8F8UFGqqrq1KBMCgw3fe5QIrw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxid8u2SeN2CJIU02PzgfDkdg2OqR2y/2pcWvTc/Mw+rU8J7lss
	CSjihyzRhk6SHDWpp7o8oHx/N3ASfAlQ0CWkL1jjKbMb/WNHHZtYyzMB
X-Gm-Gg: ASbGncsNnbJ9MJ6wcce/WRthKniTyJZsjY4+7R/rzqNXlhzoUN+QtCzVv5ytJSzexun
	61efpSuoradg75MZmKoNbuFSmDUCDtgZIPjuK+HwfOmSiyRQx5b7eiAb0FpNVwUxOOMuCncL/sp
	GpL24wO1pDfqHOdcui4IaJ3Ih8dCj+2tS1dDxlOn0iPtKoZqEvywuqiNV8LJ2Ek0U8t5jc62EcJ
	guuJqKjmto0Kt2lHNxXQj1NHcY2DmTQMD6mORigcdTW81CobuJxEwZN3JulxWe6d3jYdfN7Ly6P
	pl6f2Uei+QSgHRl0+ZiyLuiCnChlTNJzp+06WCyLV7ekZJhUhkkiNr19BGTGBY7CMkaYpQk9B+H
	D+GiXAG93KP4BIvIiHI7VpnOH5h3Nk0PBCvFhjg==
X-Google-Smtp-Source: AGHT+IGxeY1z+y0/N2JQWJRsW96745IalLmq/FAayUobFdSig7XcZQ3JpsZDzaXf8TTCBRgdaspBrQ==
X-Received: by 2002:a05:600c:c105:b0:45b:9c79:6612 with SMTP id 5b1f17b1804b1-45b9c796832mr35338115e9.1.1756909123431;
        Wed, 03 Sep 2025 07:18:43 -0700 (PDT)
Received: from smtpclient.apple ([132.68.46.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d701622b92sm12542740f8f.58.2025.09.03.07.18.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Sep 2025 07:18:42 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [BUG] x86/mm: regression after 4a02ed8e1cc3
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CAG48ez1q_Sgk5nr7Bngyt0UB3FkYb6e0cHv18wqD=sLEdrZkmw@mail.gmail.com>
Date: Wed, 3 Sep 2025 17:18:29 +0300
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Rik van Riel <riel@surriel.com>,
 the arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Borislav Petkov <bp@alien8.de>,
 peterz@infradead.org,
 Dave Hansen <dave.hansen@linux.intel.com>,
 zhengqi.arch@bytedance.com,
 thomas.lendacky@amd.com,
 kernel-team@meta.com,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 jackmanb@google.com,
 mhklinux@outlook.com,
 andrew.cooper3@citrix.com,
 Manali.Shukla@amd.com,
 Ingo Molnar <mingo@kernel.org>,
 Dave Hansen <dave.hansen@intel.com>,
 baolu.lu@intel.com,
 david.guckian@intel.com,
 damian.muszynski@intel.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <920DC212-880C-4688-A577-2589CABEED75@gmail.com>
References: <20250226030129.530345-1-riel@surriel.com>
 <20250226030129.530345-2-riel@surriel.com>
 <aLcQ3UCXXNcByW1O@gcabiddu-mobl.ger.corp.intel.com>
 <CAG48ez1q_Sgk5nr7Bngyt0UB3FkYb6e0cHv18wqD=sLEdrZkmw@mail.gmail.com>
To: Jann Horn <jannh@google.com>
X-Mailer: Apple Mail (2.3826.700.81)

I just noticed few things need clarification

> On 2 Sep 2025, at 19:05, Jann Horn <jannh@google.com> wrote:
>=20
> On Tue, Sep 2, 2025 at 5:44=E2=80=AFPM Giovanni Cabiddu
> <giovanni.cabiddu@intel.com> wrote:
>>=20

[snip]

>> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
>> index 39f80111e6f1..e66c7662c254 100644
>> --- a/arch/x86/mm/tlb.c
>> +++ b/arch/x86/mm/tlb.c
>> @@ -1459,7 +1459,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, =
unsigned long start,
>>=20
>>        put_flush_tlb_info();
>>        put_cpu();
>> -       mmu_notifier_arch_invalidate_secondary_tlbs(mm, start, end);
>> +       mmu_notifier_arch_invalidate_secondary_tlbs(mm, info->start, =
info->end);
>> }
>=20
> I don't see why the IOMMU flush should be broadened just because the
> CPU flush got broadened.

Agreed (as Rik also indicated now)

>=20
> On x86, IOMMU flushes happen from arch_tlbbatch_add_pending() and
> flush_tlb_mm_range(); the IOMMU folks might know better, but as far as
> I know, there is nothing that elides IOMMU flushes depending on the
> state of X86-internal flush generation tracking or such.
>=20
> To me this looks like a change that is correct but makes it easier to
> hit IOMMU flushing issues in other places.

This change is not correct. Do not reference info after calling
put_flush_tlb_info().

>=20
> Are you encountering these issues on an Intel system or an AMD system?

I would note that on AMD IOMMUs there is some masking functionality
that allows to make large yet selective flushes.

This means both that we should not force IOMMU flush range to be large
just because we decided to do so for the CPU (as you correctly said)
and that there might be an unrelated bug, like in the mask computation.


