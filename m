Return-Path: <linux-kernel+bounces-846165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C7FBC72D7
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 04:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 980754E6355
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 02:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E477519F12D;
	Thu,  9 Oct 2025 02:10:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7F513774D;
	Thu,  9 Oct 2025 02:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759975820; cv=none; b=AT+Jes0TLYNcfcMPNqbC9wwzJG4RTYSqU8f68cUvk/J8BDollIz4Zt+iYRgmYjog8+j8aAQYuL6mL2zm1uQ/7I/qozu8Nd4O8m3/a/JZsaF8OuTAy74oEIV0R135lKRoDPsbzCzTP6cC+Zzx0tz+oNurCBB4luQGeCayxXOxy9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759975820; c=relaxed/simple;
	bh=SSpt/ASKjRKVCeZU581gXig0KMsEtISDpf/x1oUdL60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oqH2vXzCnqRwwmVvyjVuUG/dx/1FAnfoN4HH4TiqiksnkqPCLnP2dTCKkz2fYLVLup8Go75aKbhV9xIo0KA8YHzfEk+T0gZJnhVM80XVZwN/BKQHZ3PcG0ZeN7saqXHsqREWs6QsybE+B2HZQliIh9aubP5YW8DP0r70/HWpoUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06F7422FC;
	Wed,  8 Oct 2025 19:10:09 -0700 (PDT)
Received: from [10.163.35.84] (unknown [10.163.35.84])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DDB43F738;
	Wed,  8 Oct 2025 19:10:13 -0700 (PDT)
Message-ID: <c6371fa1-af9c-47b0-988f-aae3d7fd58e7@arm.com>
Date: Thu, 9 Oct 2025 07:40:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/18] mm: Always use page table accessor functions
To: Samuel Holland <samuel.holland@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
 linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Conor Dooley <conor@kernel.org>,
 Alexandre Ghiti <alex@ghiti.fr>, Emil Renner Berthing <kernel@esmil.dk>,
 Andrew Morton <akpm@linux-foundation.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
References: <20251009015839.3460231-1-samuel.holland@sifive.com>
 <20251009015839.3460231-5-samuel.holland@sifive.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20251009015839.3460231-5-samuel.holland@sifive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 09/10/25 7:27 AM, Samuel Holland wrote:
> Some platforms need to fix up the values when reading or writing page
> tables. Because of this, the accessors must always be used; it is not
> valid to simply dereference a pXX_t pointer.
> 
> Fix all of the instances of this pattern in generic code, mostly by
> applying the below coccinelle semantic patch, repeated for each page
> table level. Some additional fixes were applied manually, mostly to
> macros where type information is unavailable.
> 
> In a few places, a `pte_t *` or `pmd_t *` is actually a pointer to a PTE
> or PMDE value stored on the stack, not a pointer to a page table. In
> those cases, it is not appropriate to use the accessors, because the
> value is not globally visible, and any transformation from pXXp_get()
> has already been applied. Those places are marked by naming the pointer
> `ptentp` or `pmdvalp`, as opposed to `ptep` or `pmdp`.
> 
> @@
> pte_t *P;
> expression E;
> expression I;
> @@
> - P[I] = E
> + set_pte(P + I, E)
> 
> @@
> pte_t *P;
> expression E;
> @@
> (
> - WRITE_ONCE(*P, E)
> + set_pte(P, E)
> |
> - *P = E
> + set_pte(P, E)
> )
> 
> @@
> pte_t *P;
> expression I;
> @@
> (
>   &P[I]
> |
> - READ_ONCE(P[I])
> + ptep_get(P + I)
> |
> - P[I]
> + ptep_get(P + I)
> )
> 
> @@
> pte_t *P;
> @@
> (
> - READ_ONCE(*P)
> + ptep_get(P)
> |
> - *P
> + ptep_get(P)
> )
> 
> Additionally, the following semantic patch was used to convert PMD and
> PUD references inside struct vm_fault:
> 
> @@
> struct vm_fault vmf;
> @@
> (
> - *vmf.pmd
> + pmdp_get(vmf.pmd)
> |
> - *vmf.pud
> + pudp_get(vmf.pud)
> )
> 
> @@
> struct vm_fault *vmf;
> @@
> (
> - *vmf->pmd
> + pmdp_get(vmf->pmd)
> |
> - *vmf->pud
> + pudp_get(vmf->pud)
> )
> 
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> This commit covers some of the same changes as an existing series from
> Anshuman Khandual[1]. Unlike that series, this commit is a purely
> mechanical conversion to demonstrate the RISC-V changes, so it does not
> insert local variables to avoid redundant calls to the accessors. A
> manual conversion like in that series could improve performance.
> 
> [1]: https://lore.kernel.org/linux-mm/20240917073117.1531207-1-anshuman.khandual@arm.com/

Portions of the changes proposed here are already in discussion
and fetched for testing via mm-new/everything.

https://lore.kernel.org/linux-mm/20251007063100.2396936-1-anshuman.khandual@arm.com/
https://lore.kernel.org/linux-mm/20251006055214.1845342-1-anshuman.khandual@arm.com/

