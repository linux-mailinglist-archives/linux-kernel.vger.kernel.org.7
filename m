Return-Path: <linux-kernel+bounces-798804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AD3B42329
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4C1B172284
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D3A305051;
	Wed,  3 Sep 2025 14:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="Gb2fAwLM"
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C4C2FF64B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 14:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908496; cv=none; b=CUeo9jc1w/zdDlQc48B5mIWtXxtPDoS3LI70hXJWGh4bLw0DbtG3DZGYYFJKAt9NcUoeYwPqx7WQRXaA6nZtzDjBI0UOi93IVhWtrX09gSTdr73fDqQ0zfRER08Zct0ggVXwrcsAQxaDMYXxf0+2sq2RL1F2HStJG6wi2D6yfv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908496; c=relaxed/simple;
	bh=k9af2vJYNOv9Ad+WHvcoDXbJbU4NfCe6GSoBa2KBYBg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PILwSCvaU5rzHvhLmm6IHd1szO0uBtsN1WhEkomV96xM8BJOlZaQmhlrfVelN0QzgQASGFAHfbqIQfImdzMUEtUagEk3ouk2movLwHTa/2OYdI6QquuNUFDeMAa2l9g2jCbP0g9Mvw62/AFeSjFeshMn8ROsTUw1PxFNXksluRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=Gb2fAwLM; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=MywEynYNUb/+vviy4Gt34/JK2ggRg79daM+ma7Rs1DE=; b=Gb2fAwLMTtymMLa7ezoFfLhSpS
	u1sDrLJZmp5PAtqVxy0YMI0UTXeBzWzUcr7lHjAnImbU3dlfXlHzRl/Xucj3+YoAfx2GyQwBWHpuR
	liEjR+KCRhUOAwctQBJJkX1DU1wcO9l90tbTfIpKFNcGR7X6lbIVdcRHK+QhZqy53jVmOtm4VAvK3
	iv6Poz6xSKgnerY7XlnNM22ysjWf0/DoOSviiAXdZGSAdPYWcOZaMl31ClSL3mtlhAE7w00R9gPrM
	ElZ/15hOBqiJVJ75N/RdDELHMI0bVBnJruPCWJ4JipggYDYB+yAJiaV78QiTfDTTkK4Xty9eVnVK9
	yguwjVaA==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1uto2H-000000004Ed-2uVr;
	Wed, 03 Sep 2025 10:00:29 -0400
Message-ID: <59f1b1b6e1ef24b0d514a9885a08400c76b0eeec.camel@surriel.com>
Subject: Re: [BUG] x86/mm: regression after 4a02ed8e1cc3
From: Rik van Riel <riel@surriel.com>
To: Dave Hansen <dave.hansen@intel.com>, Giovanni Cabiddu
	 <giovanni.cabiddu@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de, 
	peterz@infradead.org, dave.hansen@linux.intel.com,
 zhengqi.arch@bytedance.com, 	nadav.amit@gmail.com, thomas.lendacky@amd.com,
 kernel-team@meta.com, 	linux-mm@kvack.org, akpm@linux-foundation.org,
 jackmanb@google.com, 	jannh@google.com, mhklinux@outlook.com,
 andrew.cooper3@citrix.com, 	Manali.Shukla@amd.com, mingo@kernel.org,
 baolu.lu@intel.com, 	david.guckian@intel.com, damian.muszynski@intel.com
Date: Wed, 03 Sep 2025 10:00:28 -0400
In-Reply-To: <913a509d-d985-4520-a879-538a1198b946@intel.com>
References: <20250226030129.530345-1-riel@surriel.com>
	 <20250226030129.530345-2-riel@surriel.com>
	 <aLcQ3UCXXNcByW1O@gcabiddu-mobl.ger.corp.intel.com>
	 <913a509d-d985-4520-a879-538a1198b946@intel.com>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-02 at 08:50 -0700, Dave Hansen wrote:
> On 9/2/25 08:44, Giovanni Cabiddu wrote:
> > diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> > index 39f80111e6f1..e66c7662c254 100644
> > --- a/arch/x86/mm/tlb.c
> > +++ b/arch/x86/mm/tlb.c
> > @@ -1459,7 +1459,7 @@ void flush_tlb_mm_range(struct mm_struct *mm,
> > unsigned long start,
> > =C2=A0
> > =C2=A0	put_flush_tlb_info();
> > =C2=A0	put_cpu();
> > -	mmu_notifier_arch_invalidate_secondary_tlbs(mm, start,
> > end);
> > +	mmu_notifier_arch_invalidate_secondary_tlbs(mm, info-
> > >start, info->end);
> > =C2=A0}
>=20
> That does look like the right solution.
>=20
> This is the downside of wrapping everything up in that 'info' struct;
> it's not obvious that the canonical source of the start/end
> information
> moved from those variables into the structure.
>=20
> Rik, is that your read on it too?
>=20
In flush_tlb_mm_range(), we only need to flush from
start to end. The same should be true for the mmu notifier.

The only reason info->start and info->end can be modified
is because a global TLB flush can be faster than a ranged
one.

I can't think of any reason why that should affect the
range the mmu notifier needs to flush.

--=20
All Rights Reversed.

