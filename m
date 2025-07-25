Return-Path: <linux-kernel+bounces-745185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7715BB11649
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 04:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D49D1CE223A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 02:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2717123236D;
	Fri, 25 Jul 2025 02:16:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EF61FFC7B
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 02:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753409777; cv=none; b=ZWdFy+MNq62uymDIbqcddM4iFgtZ0CT9yHtz7zDSj7OrqMnhUp8KD5+ZP+soD2rsbbMuHP0zxTWBUJEfTkCEMTO2mH2eiVayEnaGdWTBpyCVMnPCt1kaICCDd0UeXg3Tfe/HRKS3qcI73alwjrktRCsjlIvEl1ei4Y/DzS/apIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753409777; c=relaxed/simple;
	bh=0vmeIDkaiq1z2hAicDXYFW3N5Ep3oCj9Tm8KCVC9LFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dHvi/eWlgFpAzY7GhLJ6Yq8GyUm0qwKwC9v2hAvyirplEntr7rAkFubIQO2qvMyfV/W5D5j+WAUvS3lvpnee/+y21xucbcdZRS9xByZ1KifMQgUB454UHU5spSA3nF9acgp3agoUE/s1ex/zltEMNc4YX2PHNV7Xvp4BGw5qDkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 548881A00;
	Thu, 24 Jul 2025 19:16:07 -0700 (PDT)
Received: from [10.164.146.15] (unknown [10.164.146.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A3693F5A1;
	Thu, 24 Jul 2025 19:16:11 -0700 (PDT)
Message-ID: <90864bf5-2edb-4901-9566-c89431c6d717@arm.com>
Date: Fri, 25 Jul 2025 07:46:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: allow NR_CPUS=1 for non-SMP and adjust default
 accordingly
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>,
 catalin.marinas@arm.com, will@kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250724165639.13926-1-suchitkarunakaran@gmail.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250724165639.13926-1-suchitkarunakaran@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/07/25 10:26 PM, Suchit Karunakaran wrote:
> The arm64 Kconfig for NR_CPUS previously required a minimum of 2 CPUs.
> This patch changes the minimum allowed CPUs to 1, enabling single-core
> non-SMP configurations.
> 
> Additionally, the default value for NR_CPUS is now conditional:
> - Defaults to 1 if SMP is not selected (non-SMP systems)
> - Defaults to 512 if SMP is enabled

Just curious - what actually prompted this change ?

> 
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> ---
>  arch/arm64/Kconfig | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 393d71124f5d..9b2970f7c5ec 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1528,9 +1528,10 @@ config SCHED_SMT
>  	  places. If unsure say N here.
>  
>  config NR_CPUS
> -	int "Maximum number of CPUs (2-4096)"
> -	range 2 4096
> -	default "512"
> +	int "Maximum number of CPUs (1-4096)"
> +	range 1 4096
> +	default "1" if !SMP
> +	default "512" if SMP
>  
>  config HOTPLUG_CPU
>  	bool "Support for hot-pluggable CPUs"



