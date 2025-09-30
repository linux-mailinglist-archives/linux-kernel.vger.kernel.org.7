Return-Path: <linux-kernel+bounces-837779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E17C6BAD2AE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744861927CAA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E532F616B;
	Tue, 30 Sep 2025 14:24:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA201CAA79
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759242287; cv=none; b=GG8VVNbIVCRAZb9KippLE0B9aGvL4lwBvNtsKY0ci9eUp3kZ3X+2JOxdqXAdGzZqC2sWi9KohqeK5HPJ118DUnedgCOKUK2aXrgEMIUbV3QiCA7h0g4MpC5ebteM4qWf7jXOc3IPPyEwSo/l0L1FygZHCku569FY5cppvPsSXWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759242287; c=relaxed/simple;
	bh=Gw1Z57EQU6aM/WuaPtqf2DXNkOuE0LF4ynXATfwG6Ok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZyEl/CxmLnZvmoWX/FzDuQRhVe8VMuSld1KFXierS+YWTn5Ut60PchZpIeckmWZKyUsLOjHJd+J5mhzyR+FmmxAqe7HrXD5pAOTJSSdN/HrewdGbm5Iu3mcmPeRCc/8AGVVDI3AS7cRAq8eKj3x8TS17TxczXWsU0SjkpMdUwEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BCE61424;
	Tue, 30 Sep 2025 07:24:36 -0700 (PDT)
Received: from [10.44.160.83] (e126510-lin.lund.arm.com [10.44.160.83])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D938C3F66E;
	Tue, 30 Sep 2025 07:24:41 -0700 (PDT)
Message-ID: <db8b48d3-6885-4d1b-b97b-e2beb23100d4@arm.com>
Date: Tue, 30 Sep 2025 16:24:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: mm: Move KPTI helpers to mmu.c
To: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org, Ryan Roberts <ryan.roberts@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Kees Cook <kees@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Yeoreum Yun <yeoreum.yun@arm.com>
References: <20250912073908.404924-1-kevin.brodsky@arm.com>
 <175880703970.3419388.13372770098169657486.b4-ty@kernel.org>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <175880703970.3419388.13372770098169657486.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/09/2025 17:32, Will Deacon wrote:
> On Fri, 12 Sep 2025 08:39:08 +0100, Kevin Brodsky wrote:
>> create_kpti_ng_temp_pgd() is currently defined (as an alias) in
>> mmu.c without matching declaration in a header; instead cpufeature.c
>> makes its own declaration. This is clearly not pretty, and as commit
>> ceca927c86e6 ("arm64: mm: Fix CFI failure due to kpti_ng_pgd_alloc
>> function signature") showed, it also makes it very easy for the
>> prototypes to go out of sync.
>>
>> [...]
> Applied to arm64 (for-next/core), thanks!
>
> Please check that I resolved the conflicts correctly...
>
> [1/1] arm64: mm: Move KPTI helpers to mmu.c
>       https://git.kernel.org/arm64/c/200b0d25084d

Looks good, thanks!

- Kevin

