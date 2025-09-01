Return-Path: <linux-kernel+bounces-793981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A31B3DB1D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B574D189BD92
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 07:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4401EEC0;
	Mon,  1 Sep 2025 07:33:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C2926F289;
	Mon,  1 Sep 2025 07:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756712021; cv=none; b=WASfvwRsStu0m1a0d9P9HzOKgEE9xE6/JEN0F1DFd5Iwttk3NVGV/Oup4ICM/F/UjJaRIRBhPY7pQeZWoOsEwjC8qXqo2/lJy1q0SBGZiOAGRnXB+YdI/2I78q24SFYe4Omdwk0+6TLM3y6MuHhd37Ds0s8j4rCq4YdKSYfvwV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756712021; c=relaxed/simple;
	bh=PhB8WeDv969rq0BPBCTCg6VsNaonzWIUuJ0Js3niOjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sTMImjRf16BvB6M+RNRCtEbibbqX1+6GLimF/rTzUC/WaGIWesKevuIYia/cKdMnnGowRhCNpJjoRxRzvv1Kig3O8oqAcunP0FEaVFnDAS0kTa2VWWhmFGElP8Lr1StBb/mudTZp++VPLXfLpU5kbviaygRnHCoNdOf7wqLgIws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32F3B1A25;
	Mon,  1 Sep 2025 00:33:31 -0700 (PDT)
Received: from [10.57.57.17] (unknown [10.57.57.17])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 856B43F63F;
	Mon,  1 Sep 2025 00:33:34 -0700 (PDT)
Message-ID: <ca30a6f6-f636-4d6f-9ec6-d6e02ef70852@arm.com>
Date: Mon, 1 Sep 2025 09:33:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: mm: Fix CFI failure due to kpti_ng_pgd_alloc
 function signature
To: Mark Rutland <mark.rutland@arm.com>, Kees Cook <kees@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Yue Haibing <yuehaibing@huawei.com>, Marc Zyngier <maz@kernel.org>,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Ryan Roberts <ryan.roberts@arm.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Joey Gouly <joey.gouly@arm.com>, Yeoreum Yun <yeoreum.yun@arm.com>,
 James Morse <james.morse@arm.com>,
 Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Zhenhua Huang <quic_zhenhuah@quicinc.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Dev Jain <dev.jain@arm.com>,
 Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250829154913.work.943-kees@kernel.org>
 <aLHP-TG3a1Im3kpa@J2N7QTR9R3>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <aLHP-TG3a1Im3kpa@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/08/2025 18:06, Mark Rutland wrote:
> The actual fix looks fine, though I suspect we should move more of this
> logic into mmu.c.

Agreed, I'll look into that. Having two separate declarations in
cpufeature.c and mmu.c is ugly and leads to the kind of mistake that I made.

The fix looks perfectly fine FWIW - not adding my Reviewed-by as I saw
Catalin took v2 already :)

- Kevin

