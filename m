Return-Path: <linux-kernel+bounces-723643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD4EAFE970
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF253BF9B5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240582D9ED8;
	Wed,  9 Jul 2025 12:53:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127022DC339
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 12:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752065622; cv=none; b=ZYtsmZHsKsEMeZnlcrUmdG6WMPTSnYwuWkUL04Jt7kvmcEdZM7m/A7uP6jHXbhHkuvYfBtVdai1XT9a5m/rpMQRA5HUAp9xWd/qiUYpErn3GGrmPQ3keMOE/iLaG6KFaHrSjt0ZZ6KDuenOi8JtN3hilE+6NMEFAuqa2ZGKk8Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752065622; c=relaxed/simple;
	bh=LzXzz6/CZT/GYHVvLYx1iDwGudYqdPFmGlooDcDehm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y8eUqs0QFQceU8jQMPR9Eg53Rr4xMXkteop60SwVIzT0rCEwN0vAL7x6/EtwHl9TJumh1Tzl+md/Jp87ZKeTzb2cProYmJaNt0OzfWbNGVi3Eg5kN2MgKuGukVI86JMMO5VEjvXnESPWwrG9dBE0CquNQ7PrWsTQOy1uNRVo/pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74C22152B;
	Wed,  9 Jul 2025 05:53:28 -0700 (PDT)
Received: from [10.1.32.47] (Suzukis-MBP.cambridge.arm.com [10.1.32.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 99A4C3F738;
	Wed,  9 Jul 2025 05:53:38 -0700 (PDT)
Message-ID: <1251d0ab-b0a9-4113-8e92-8f94fe9ee9d6@arm.com>
Date: Wed, 9 Jul 2025 13:53:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] arm64: realm: Add support for encrypted data from
 firmware
To: linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, catalin.marinas@arm.com, sami.mujawar@arm.com,
 aneesh.kumar@kernel.org, steven.price@arm.com, linux-kernel@vger.kernel.org,
 sudeep.holla@arm.com
References: <20250613111153.1548928-1-suzuki.poulose@arm.com>
Content-Language: en-GB
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250613111153.1548928-1-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/06/2025 12:11, Suzuki K Poulose wrote:
> Confidential compute firmware may provide secret data via reserved memory regions
> (e.g., ACPI CCEL, EFI Coco secret area). These must be ioremap'ed() as encrypted.
> As of now, realm only maps "trusted devices" (RIPAS = RSI_RIPAS_DEV) as encrypted.
> This series adds support for mapping areas that are protected
> (i.e., RIPAS = RSI_RIPAS_RAM) as encrypted. Also, extrapolating that, we can map
> anything that is not RIPAS_EMPTY as protected, as it is guaranteed to be "protected".
> 
> With this in place, we can naturally map any firmware provided area based on the
> RIPAS value. If the firmware provides a shared region (not trusted), it must have
> set the RIPAS accordingly, before placing the data, as the transition is always
> destructive.
> 
> Also enables the EFI Coco secret area support and Confidential Compute Event
> Log (CCEL) for arm64.
> 
> 
> Suzuki K Poulose (3):
>    arm64: realm: ioremap: Allow mapping memory as encrypted
>    arm64: Enable EFI secret area Securityfs support
>    arm64: acpi: Enable ACPI CCEL support
> 
>   arch/arm64/include/asm/io.h          |  6 +++++-
>   arch/arm64/include/asm/rsi.h         |  2 +-
>   arch/arm64/kernel/acpi.c             |  5 +++++
>   arch/arm64/kernel/rsi.c              | 26 ++++++++++++++++++++++----
>   drivers/virt/coco/efi_secret/Kconfig |  2 +-
>   5 files changed, 34 insertions(+), 7 deletions(-)
> 

Gentle ping

Kind regards
Suzuki

