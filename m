Return-Path: <linux-kernel+bounces-780294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4331CB2FFFF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF9A2179F75
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBEE2DCF4C;
	Thu, 21 Aug 2025 16:24:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA2F29BD85
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 16:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755793494; cv=none; b=k9pedZzUJtG4BJ8jCgs19oI4d3WNJL1Q4TtzO1QAXe/nIreGyMJKfifKQ/+eZwKahvsFiAD2mVUGcbXLf/xA0Z2FhtLMkr8srcwknUeFLM8Q7QBgumHvck01tsPoLoUjtOvKC5gGPXB1jeNqdmPtm4qq6TOMwjU5XjVvUq6Xsxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755793494; c=relaxed/simple;
	bh=SK6pdVXXgTrIO6AQ+wg2W+1eAPL1axxmRmBtGCo/yAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=pw4veBwLzkT3tFItInklUYHlxhD2oScsQ6WCwvsdghFHVVL12irRq/m/0OlZVPpP3oI5Jo4REACyQsp8TAsdnYKiBg5EWNzP7zgWQkcIVU4T3L0TZw+DgLHgrvSM2k8ENkCefkUBPqNSteL8Nqz0pKnX9tjbDNW8S/WiGbPXqq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4A32152B;
	Thu, 21 Aug 2025 09:24:43 -0700 (PDT)
Received: from [10.57.1.220] (unknown [10.57.1.220])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 595D03F738;
	Thu, 21 Aug 2025 09:24:48 -0700 (PDT)
Message-ID: <9974c597-cc03-42d2-ba3a-3dd05f1a782c@arm.com>
Date: Thu, 21 Aug 2025 17:24:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/8] entry: Add arch_irqentry_exit_need_resched() for
 arm64
To: Jinjie Ruan <ruanjinjie@huawei.com>
References: <20250815030633.448613-1-ruanjinjie@huawei.com>
 <20250815030633.448613-6-ruanjinjie@huawei.com>
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oleg@redhat.com,
 sstabellini@kernel.org, mark.rutland@arm.com, mbenes@suse.cz,
 broonie@kernel.org, anshuman.khandual@arm.com, ryan.roberts@arm.com,
 chenl311@chinatelecom.cn, liaochang1@huawei.com, kristina.martsenko@arm.com,
 leitao@debian.org, ardb@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
 Ada Couprie Diaz <ada.coupriediaz@arm.com>
Content-Language: en-US
Organization: Arm Ltd.
In-Reply-To: <20250815030633.448613-6-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 15/08/2025 04:06, Jinjie Ruan wrote:
> Compared to the generic entry code, ARM64 does additional checks
> when deciding to reschedule on return from interrupt. So introduce
> arch_irqentry_exit_need_resched() in the need_resched()
> condition of the generic raw_irqentry_exit_cond_resched(), with
> a NOP default. This will allow ARM64 to implement the architecture
> specific version for switching over to the generic entry code.
>
> Suggested-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Suggested-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
Looks good to me, thanks for the changes ! Reviewed-by: Ada Couprie Diaz 
<ada.coupriediaz@arm.com>

