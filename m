Return-Path: <linux-kernel+bounces-827319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F6CB916B3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF8962A17FB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4190B30AAA9;
	Mon, 22 Sep 2025 13:35:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FA530C619
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758548103; cv=none; b=gQWloPUV62fKNcLAu5lS7GmNdtbr3USvUAOj6fcNFcjmk7vhROUxgdYn6lAWz5dyQiG3NwhZxc/oTsDiy178pArxlP9wUszR2jnTXEhjYEXoq6gYHprcI0OiY5H4BsEdsazGBh9QeTPEigKemBzqcauHkrN6uxcazE+0nssOLVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758548103; c=relaxed/simple;
	bh=5Kuft22jcHacAd/PnZDYwGuo47sxJlDHMqwtTcjtZ7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t55aVRA0+zQN2spovwQ5lEU6mTRDD8gw6QpnNfANhjD+mAVgFMyPvfTmDrSXeUubQa/tEza6NLWseXirOVpN4FiDZkjxf6jnlRdLoC3IUbnX0jMkP8HEuIWGH0HmhS/a/JMNy8o9TvFmoSpbwtlzGt+P6aNYiQYNtDk5BAsLobI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B46191424;
	Mon, 22 Sep 2025 06:34:52 -0700 (PDT)
Received: from [10.57.95.38] (unknown [10.57.95.38])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BDFD3F694;
	Mon, 22 Sep 2025 06:34:59 -0700 (PDT)
Message-ID: <6c8a2900-cec8-4994-892a-3ef157d89a26@arm.com>
Date: Mon, 22 Sep 2025 14:34:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] Workarounds and optimizations for Neoverse-V3AE
Content-Language: en-GB
To: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>
Cc: kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250919145832.4035534-1-ryan.roberts@arm.com>
 <175853683592.1350681.8237584408369869851.b4-ty@kernel.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <175853683592.1350681.8237584408369869851.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/09/2025 14:14, Will Deacon wrote:
> On Fri, 19 Sep 2025 15:58:27 +0100, Ryan Roberts wrote:
>> I know it's late in the cycle, but I thought I'd try my luck at sneaking this
>> in.
>>
>> Neoverse-V3AE has a different MIDR value to Neoverse-V3, but qualifies for the
>> same workarounds and optimizations ("SSBS not fully self-synchronizing" and
>> BBML2_NOABORT) so this just adds Neoverse-V3AE wherever Neoverse-V3 appears.
>> Details in the commits.
>>
>> [...]
> 
> Applied to arm64 (for-next/cpufeature), thanks!
> 
> [1/3] arm64: cputype: Add Neoverse-V3AE definitions
>       https://git.kernel.org/arm64/c/3bbf004c4808
> [2/3] arm64: errata: Apply workarounds for Neoverse-V3AE
>       https://git.kernel.org/arm64/c/0c33aa1804d1
> [3/3] arm64: cpufeature: add Neoverse-V3AE to BBML2 allow list
>       https://git.kernel.org/arm64/c/8fca3852e33d
> 
> Cheers,

Thank you!

