Return-Path: <linux-kernel+bounces-737228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD772B0A981
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 19:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65A09165D60
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA8A2E6D0A;
	Fri, 18 Jul 2025 17:29:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A091C7017
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752859743; cv=none; b=tKE8cmwNxrbMDZwDh1J+wzo+PLwJhBp1aJi3VD7m2j2NNTyicNvjZD3omj50dM3hGJbRyQUUL3iCEopsTwn+fSrW5jyM1e2nQas8eVvcx2xt3GTSnZV4kmVbtgWZdhGdg/kSAACSxKapdg709KRXgxpupQtiFtvf6ZKKnPrWnUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752859743; c=relaxed/simple;
	bh=G6BIEU5YI4uX2ERGmKEn1ipL1ZqqIQl7jbcziXhrriw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VEwJr6C/bKU8dEA6Z+5oniQOJ3t8huvUCJdHAilMnL8XTsFjsbuzpYxsdYwEzJkmnFnml0Eif4jc3ezEW8wCxKqzJC4RN2NsapfQkf05TC8nGUmHYipb6JY4NPVPHLuT0JIqPcWj/w2N7NP6H8pGtBdeoJhnhQDIwGsJQoOvkFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C7EE16A3;
	Fri, 18 Jul 2025 10:28:53 -0700 (PDT)
Received: from [10.57.52.232] (unknown [10.57.52.232])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9E303F6A8;
	Fri, 18 Jul 2025 10:28:57 -0700 (PDT)
Message-ID: <4b010cc5-9244-450d-9a03-4ff6bf5c9a20@arm.com>
Date: Fri, 18 Jul 2025 18:28:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] SCTLR_EL1.TIDCP toggling for performance
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: linux-kernel@vger.kernel.org,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, catalin.marinas@arm.com,
 will@kernel.org, mark.rutland@arm.com, sashal@kernel.org,
 yangjiangshui@h-partners.com, zouyipeng@huawei.com, justin.he@arm.com,
 zengheng4@huawei.com, yangyicong@hisilicon.com,
 ruanjinjie <ruanjinjie@huawei.com>
References: <24afb8de-622a-4865-bd8e-8e89ccfff8f4@huawei.com>
Content-Language: en-US
From: =?UTF-8?Q?Kristina_Mart=C5=A1enko?= <kristina.martsenko@arm.com>
In-Reply-To: <24afb8de-622a-4865-bd8e-8e89ccfff8f4@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Chang,

On 18/07/2025 03:32, Liao, Chang wrote:
> Hi, Kristina
> 
> I've reviewed your patch [1] for FEAT_TIDCP1 support, which by default traps EL0
> accesses to implementation-defined system registers and instructions at EL1/EL2.
> 
> Do you have any plans to add support for toggling the SCTLR_EL1.TIDCP1 bit? I'm
> encountering performance degradation on CPU where certain implementation-defined
> registers and instructions are designed for EL0 performance use. The trapping
> overhead is substantial enough to compromise any benefits, and it's even worse
> in virtualization. Therefore, I'm hoping there's a way to clear the SCTLR_EL1.TIDCP1
> bit on such platforms, perhaps via a kernel config option or command-line parameter.
> Alternatively, do you have a better solution for gracefully toggling this bit on
> and off?
> 
> Thanks
> 
> [1] https://lore.kernel.org/linux-arm-kernel/Yrw3NWkH6D0CgRsF@sirena.org.uk/T/#m5cfdb27b48d9d7e30db73e991fc6c232ba8a7349

I don't have any plans to add support for toggling it. You could try sending a
patch for a Kconfig option or kernel command-line parameter. I'm not really
sure what the maintainers' view on supporting IMP-DEF features is.

Thanks,
Kristina


