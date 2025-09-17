Return-Path: <linux-kernel+bounces-821160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D09C7B809C5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C470622948
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474B3335954;
	Wed, 17 Sep 2025 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpeLMcZV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DBC3054F1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123328; cv=none; b=XoeeMEEsrz3Ebr9e0sataISXwKduE9Q6zukypb4OnyDCgxmHRD1qWg5ekQts70kISC4MKb88bk/5NYcTxfkIwHiAgw4zcLdR1zpbDh8c7cQRedasdPml4xVlF2dC1m5kpAlZQ+VZPoHec5gumX500r/IunfPqs0I3R2vGI9uP04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123328; c=relaxed/simple;
	bh=epbbumuF/07bqlEvab2zERySAUlqgpP+5wWIA0A9XNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chyOcUJWqhL0z8F55aXWlOS6AyeL2e/5LaMqbxnIllNDoajnehw3qak9YI/8AxTjx/z9n0/4mF/W4vSGgJezwRAA9l7K1zuNgy8yokNsdbNx85i7MbcUpmMfJROpFl2O1iX1R0eDo8TGL0PQOVQ66lwPh3zOpFcYQEc44lc+agQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpeLMcZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7E0C4CEE7;
	Wed, 17 Sep 2025 15:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758123327;
	bh=epbbumuF/07bqlEvab2zERySAUlqgpP+5wWIA0A9XNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kpeLMcZVPYDp1xvxWCy55CjA/XKfFCmX2ara8/Vy+b3Jd4a2X/3dcUBHqoHadEWfK
	 QDv4J1KaklWoVTnmoRmrnM+GHey6bj1+y0expTrF2H2jMchRmwzVzl6E3Ggxad+GtY
	 zXnbc2N/w77qf8OWEBz67i0PaXADA1s6Ckp9+soQuPxlVEfBw4tFDZTbkVzswbgrmv
	 Gn3CSnNZmtprYsr7isogRoy8iyHrpVL1zjy7ryqXbOdlwqex83DAw6PLhBbbua8qFR
	 WYyjtTJBaZYZURHN3ZSROOFbzca1QX3OOVkx/ZBTxdi0WyyyW+35vpFPO74Np3xSk8
	 9ytuTYzZiI0xw==
Date: Wed, 17 Sep 2025 16:35:22 +0100
From: Will Deacon <will@kernel.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Ryan Roberts <ryan.roberts@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Kees Cook <kees@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: Re: [PATCH v2] arm64: mm: Move KPTI helpers to mmu.c
Message-ID: <aMrVOmOro930Bgob@willie-the-truck>
References: <20250912073908.404924-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912073908.404924-1-kevin.brodsky@arm.com>

Hey Kevin,

On Fri, Sep 12, 2025 at 08:39:08AM +0100, Kevin Brodsky wrote:
> create_kpti_ng_temp_pgd() is currently defined (as an alias) in
> mmu.c without matching declaration in a header; instead cpufeature.c
> makes its own declaration. This is clearly not pretty, and as commit
> ceca927c86e6 ("arm64: mm: Fix CFI failure due to kpti_ng_pgd_alloc
> function signature") showed, it also makes it very easy for the
> prototypes to go out of sync.
> 
> All this would be much simpler if kpti_install_ng_mappings() and
> associated functions lived in mmu.c, where they logically belong.
> This is what this patch does:
> - Move kpti_install_ng_mappings() and associated functions from
>   cpufeature.c to mmu.c, add a declaration to <asm/mmu.h>
> - Remove create_kpti_ng_temp_pgd() and just call
>   __create_pgd_mapping_locked() directly instead
> - Mark all these functions __init
> - Move __initdata after kpti_ng_temp_alloc (as suggested by
>   checkpatch)
> 
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
> v1..v2:
> * Removed create_kpti_ng_temp_pgd() instead of making it a wrapper
>   [Ryan's suggestion]
> * Added Reviewed-by's.
> ---
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  arch/arm64/include/asm/mmu.h   |  6 +++
>  arch/arm64/kernel/cpufeature.c | 97 ----------------------------------
>  arch/arm64/mm/mmu.c            | 96 +++++++++++++++++++++++++++++----
>  3 files changed, 93 insertions(+), 106 deletions(-)

Thanks, this looks fine to me. However, it conflicts with ceca927c86e6
("arm64: mm: Fix CFI failure due to kpti_ng_pgd_alloc function
signature") which landed after -rc1 so I'll either queue this late
(after merging in for-next/fixes to for-next/core) or we can defer it to
-rc1.

If we get to -rc2 and it's not in Linus' tree, then please repost
because it means I forgot about it :)

Will

