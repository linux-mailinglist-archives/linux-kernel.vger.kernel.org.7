Return-Path: <linux-kernel+bounces-822214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F0CB834E8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7816A16A53C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07342E974E;
	Thu, 18 Sep 2025 07:24:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D802236A73
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758180254; cv=none; b=Y1IYEYAkV38Qu+cWy4rOhFNmL5vLnJdvaVBjDodjw4zBghoaiBbD8k9Xr5X+o3Xv7JOLKbbWRT8UYtvWT55/XhsLGVbVA0A1lsTbVhMyWs+CM1kLEuxv/U6/zQ7nYSp6hDvxLDt75r77DEePO7/JqMPaXliFsjn68ODHFB3IuxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758180254; c=relaxed/simple;
	bh=n74wAqwgiO0syKbdD+ecePKpzNA6k2nx2V93GwGFwoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHmeLXuxcHUIDJy34pUc+IZH5b72DGPb8cKjjTm4aYlqVJGuSrKomWlvn7WoVdPoVjr+PDxHmxXNM5VJZAGswBy1jFN1e65PQcOICDBHpxKUGbj7J8M01MZyfvwW98MD7yL7cLKGxExVUUDcEKxtizIlrectHf61R4ncMx17D/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4DA1176C;
	Thu, 18 Sep 2025 00:24:02 -0700 (PDT)
Received: from [10.57.71.56] (unknown [10.57.71.56])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 111D83F66E;
	Thu, 18 Sep 2025 00:24:08 -0700 (PDT)
Message-ID: <ddc84d24-8bb6-48ca-9cab-cee8d4e0eca6@arm.com>
Date: Thu, 18 Sep 2025 09:24:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: mm: Move KPTI helpers to mmu.c
To: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Ryan Roberts <ryan.roberts@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Kees Cook <kees@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Yeoreum Yun <yeoreum.yun@arm.com>
References: <20250912073908.404924-1-kevin.brodsky@arm.com>
 <aMrVOmOro930Bgob@willie-the-truck>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <aMrVOmOro930Bgob@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/09/2025 17:35, Will Deacon wrote:
> Hey Kevin,
>
> On Fri, Sep 12, 2025 at 08:39:08AM +0100, Kevin Brodsky wrote:
>> create_kpti_ng_temp_pgd() is currently defined (as an alias) in
>> mmu.c without matching declaration in a header; instead cpufeature.c
>> makes its own declaration. This is clearly not pretty, and as commit
>> ceca927c86e6 ("arm64: mm: Fix CFI failure due to kpti_ng_pgd_alloc
>> function signature") showed, it also makes it very easy for the
>> prototypes to go out of sync.
>>
>> All this would be much simpler if kpti_install_ng_mappings() and
>> associated functions lived in mmu.c, where they logically belong.
>> This is what this patch does:
>> - Move kpti_install_ng_mappings() and associated functions from
>>   cpufeature.c to mmu.c, add a declaration to <asm/mmu.h>
>> - Remove create_kpti_ng_temp_pgd() and just call
>>   __create_pgd_mapping_locked() directly instead
>> - Mark all these functions __init
>> - Move __initdata after kpti_ng_temp_alloc (as suggested by
>>   checkpatch)
>>
>> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
>> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
>> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>> ---
>> v1..v2:
>> * Removed create_kpti_ng_temp_pgd() instead of making it a wrapper
>>   [Ryan's suggestion]
>> * Added Reviewed-by's.
>> ---
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Ard Biesheuvel <ardb@kernel.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Kees Cook <kees@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Yeoreum Yun <yeoreum.yun@arm.com>
>> ---
>>  arch/arm64/include/asm/mmu.h   |  6 +++
>>  arch/arm64/kernel/cpufeature.c | 97 ----------------------------------
>>  arch/arm64/mm/mmu.c            | 96 +++++++++++++++++++++++++++++----
>>  3 files changed, 93 insertions(+), 106 deletions(-)
> Thanks, this looks fine to me. However, it conflicts with ceca927c86e6
> ("arm64: mm: Fix CFI failure due to kpti_ng_pgd_alloc function
> signature") which landed after -rc1 so I'll either queue this late
> (after merging in for-next/fixes to for-next/core) or we can defer it to
> -rc1.

Ah yes, this patch is based on -rc5 so it depends on that commit (also
mentioned in the commit message above). Didn't realise it caused trouble
for merging!

> If we get to -rc2 and it's not in Linus' tree, then please repost
> because it means I forgot about it :)

Sure I'll prod you if I don't see it by then - I don't think I'll need
to repost a new version though, unless that code changes again in the
meantime.

- Kevin

