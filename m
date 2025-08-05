Return-Path: <linux-kernel+bounces-756640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 409EDB1B721
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F126624F97
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F712798E1;
	Tue,  5 Aug 2025 15:06:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E8113B58A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754406408; cv=none; b=RmjuHRWgGwNH5cEUKyW/Fr+wqNIkpi1pwgoCn3qp7cOrr4Vsdn2gxoBdAr35xo2KpN+yYMebHP4sSzoj229QjtUk4gl9qDrrkcqOZvdiUKR2+tvRJrGW6sOsnp/jYHJbWchF8zCUNsiTuy5FIQRzZlemN+Hik4y9gMz0zwI8ddY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754406408; c=relaxed/simple;
	bh=OUqSC25SIAF7Vamaz5rAhqLs7oY6ccTAsBPaZ0Q9oxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=NzKBfwKrBj3YWEmHFGxC3fFMbm/SNESC5m1IS1QKWx13IpCrV/chaO0kKoelt4PvsZCRZCG+95T5I36isJWyrnBqu8MoGlOna0FZo9IahZnGvEG0HToBCoAtzEaRo+i4yKyuvYROpFhiRCBYZ9w1zjkFYlV31G3ry12MA5sCHEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7B542BCD;
	Tue,  5 Aug 2025 08:06:38 -0700 (PDT)
Received: from [10.1.29.177] (e137867.arm.com [10.1.29.177])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7233B3F673;
	Tue,  5 Aug 2025 08:06:42 -0700 (PDT)
Message-ID: <3fd74c08-2950-46a9-a191-a635f379a8f7@arm.com>
Date: Tue, 5 Aug 2025 16:06:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v7 4/7] arm64: entry: Use preempt_count() and
 need_resched() helper
To: Jinjie Ruan <ruanjinjie@huawei.com>
References: <20250729015456.3411143-1-ruanjinjie@huawei.com>
 <20250729015456.3411143-5-ruanjinjie@huawei.com>
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Content-Language: en-US
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>, will@kernel.org,
 oleg@redhat.com, sstabellini@kernel.org, mark.rutland@arm.com,
 puranjay@kernel.org, broonie@kernel.org, mbenes@suse.cz,
 ryan.roberts@arm.com, akpm@linux-foundation.org, chenl311@chinatelecom.cn,
 anshuman.khandual@arm.com, kristina.martsenko@arm.com,
 liaochang1@huawei.com, ardb@kernel.org, leitao@debian.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 xen-devel@lists.xenproject.org, catalin.marinas@arm.com
Organization: Arm Ltd.
In-Reply-To: <20250729015456.3411143-5-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/07/2025 02:54, Jinjie Ruan wrote:

> The generic entry code uses preempt_count() and need_resched() helpers to
> check if it should do preempt_schedule_irq(). Currently, arm64 use its own
> check logic, that is "READ_ONCE(current_thread_info()->preempt_count == 0",
> which is equivalent to "preempt_count() == 0 && need_resched()".
>
> In preparation for moving arm64 over to the generic entry code, use
> these helpers to replace arm64's own code and move it ahead.
>
> No functional changes.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>


