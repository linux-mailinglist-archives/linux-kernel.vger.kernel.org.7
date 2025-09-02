Return-Path: <linux-kernel+bounces-796072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D806B3FB8D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E68C32C364B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D072E9ED8;
	Tue,  2 Sep 2025 09:57:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDF427AC2E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756807067; cv=none; b=AiTQ0eh5goXKB5tQNFyUTykvO8eWicRNGGKCDqtw5zDDDeV2fLWcTHRa5x2TFf9eBsARNgkbnIhKXoAQ6XkA5GstEwMcCYyuyKpu3V54nmFjSPvtYMSmODxZsfU4NRXrGv7x2g8y96k7aVwvACWhoBrRu2TX/OIfUpBZ/pqgoRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756807067; c=relaxed/simple;
	bh=Li6EfaLwRAUdcLAO4m4C43tblVZFRyFCrpiLEwzJ7tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEM3gx8GaSXbWgWabTgmUsHFf4k6b5WgFNifUnvXsgFwvamPe11AftwYXgLmwKzfunyM4y+AVVZQtDKOd0jjVykjha7hTlu0Gk1HDMpduC/cHg0llO9pLOf5INKXzQix+5r+k/icNroT07svdUTFC5/BNzCPRXATO9T0D12FQf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7989B169C;
	Tue,  2 Sep 2025 02:57:35 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AD343F6A8;
	Tue,  2 Sep 2025 02:57:42 -0700 (PDT)
Date: Tue, 2 Sep 2025 10:57:36 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Add command-line override for
 ID_AA64ISAR0_EL1.ATOMIC
Message-ID: <aLa_kHdeBjoUX0cz@J2N7QTR9R3>
References: <20250902-topic-arm64-pi-aa64isar0-atomic-v1-1-125f9538a230@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-topic-arm64-pi-aa64isar0-atomic-v1-1-125f9538a230@linaro.org>

Hi Neil,

On Tue, Sep 02, 2025 at 11:28:45AM +0200, Neil Armstrong wrote:
> Implement overriding AA64ISAR0_EL1 to set the ATOMIC feature bits,
> allowing booting with LSE Atomic disabled in case the feature
> is badly advertised as implemented or incorrectly masked by
> the hypervisor.

Can you say a bit more about where you intend to use this?

We had a similar request in the past:

  https://lore.kernel.org/linux-arm-kernel/20230710055955.36551-1-quic_aiquny@quicinc.com/

... but IIRC in that case the CPU was just mis-configured (to emit
atomic transactions to interconnect when the interconnect did not
support those), and since there are no traps for LSE atomics, hiding
them isn't a complete workaround.

Any more detail on this would be helpful.

Mark.

> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/include/asm/cpufeature.h   | 1 +
>  arch/arm64/kernel/cpufeature.c        | 4 +++-
>  arch/arm64/kernel/image-vars.h        | 1 +
>  arch/arm64/kernel/pi/idreg-override.c | 9 +++++++++
>  4 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index bf13d676aae2cc9903c83e9a3c4be0ad4bc86204..74fa9efd6938905a6397c78aeddb03a134d4d8c9 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -963,6 +963,7 @@ extern struct arm64_ftr_override id_aa64pfr0_override;
>  extern struct arm64_ftr_override id_aa64pfr1_override;
>  extern struct arm64_ftr_override id_aa64zfr0_override;
>  extern struct arm64_ftr_override id_aa64smfr0_override;
> +extern struct arm64_ftr_override id_aa64isar0_override;
>  extern struct arm64_ftr_override id_aa64isar1_override;
>  extern struct arm64_ftr_override id_aa64isar2_override;
>  
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index ef269a5a37e12c53e8e825e947b910f6d3efd296..1084475c479b0101e151ff7dfc12c7b79506cbed 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -778,6 +778,7 @@ struct arm64_ftr_override __read_mostly id_aa64pfr0_override;
>  struct arm64_ftr_override __read_mostly id_aa64pfr1_override;
>  struct arm64_ftr_override __read_mostly id_aa64zfr0_override;
>  struct arm64_ftr_override __read_mostly id_aa64smfr0_override;
> +struct arm64_ftr_override __read_mostly id_aa64isar0_override;
>  struct arm64_ftr_override __read_mostly id_aa64isar1_override;
>  struct arm64_ftr_override __read_mostly id_aa64isar2_override;
>  
> @@ -832,7 +833,8 @@ static const struct __ftr_reg_entry {
>  	ARM64_FTR_REG(SYS_ID_AA64DFR1_EL1, ftr_raz),
>  
>  	/* Op1 = 0, CRn = 0, CRm = 6 */
> -	ARM64_FTR_REG(SYS_ID_AA64ISAR0_EL1, ftr_id_aa64isar0),
> +	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64ISAR0_EL1, ftr_id_aa64isar0,
> +			       &id_aa64isar0_override),
>  	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64ISAR1_EL1, ftr_id_aa64isar1,
>  			       &id_aa64isar1_override),
>  	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64ISAR2_EL1, ftr_id_aa64isar2,
> diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
> index 714b0b5ec5ac4a64037834545b0246eb04fb2bce..10deaa63ce7f801fb96d69fc97ae033bcea73fb1 100644
> --- a/arch/arm64/kernel/image-vars.h
> +++ b/arch/arm64/kernel/image-vars.h
> @@ -46,6 +46,7 @@ PROVIDE(__pi___memcpy			= __pi_memcpy);
>  PROVIDE(__pi___memmove			= __pi_memmove);
>  PROVIDE(__pi___memset			= __pi_memset);
>  
> +PI_EXPORT_SYM(id_aa64isar0_override);
>  PI_EXPORT_SYM(id_aa64isar1_override);
>  PI_EXPORT_SYM(id_aa64isar2_override);
>  PI_EXPORT_SYM(id_aa64mmfr0_override);
> diff --git a/arch/arm64/kernel/pi/idreg-override.c b/arch/arm64/kernel/pi/idreg-override.c
> index bc57b290e5e7bab51a9de90d23fe36e1640e4b6b..326fa7d69b6df044d840164be3b504af6d8e8482 100644
> --- a/arch/arm64/kernel/pi/idreg-override.c
> +++ b/arch/arm64/kernel/pi/idreg-override.c
> @@ -160,6 +160,14 @@ static const struct ftr_set_desc pfr1 __prel64_initconst = {
>  	},
>  };
>  
> +static const struct ftr_set_desc isar0 __prel64_initconst = {
> +	.name		= "id_aa64isar0",
> +	.override	= &id_aa64isar0_override,
> +	.fields		= {
> +		FIELD("atomic", ID_AA64ISAR0_EL1_ATOMIC_SHIFT, NULL),
> +		{}
> +	},
> +};
>  static const struct ftr_set_desc isar1 __prel64_initconst = {
>  	.name		= "id_aa64isar1",
>  	.override	= &id_aa64isar1_override,
> @@ -222,6 +230,7 @@ PREL64(const struct ftr_set_desc, reg) regs[] __prel64_initconst = {
>  	{ &mmfr2	},
>  	{ &pfr0 	},
>  	{ &pfr1 	},
> +	{ &isar0	},
>  	{ &isar1	},
>  	{ &isar2	},
>  	{ &smfr0	},
> 
> ---
> base-commit: 33bcf93b9a6b028758105680f8b538a31bc563cf
> change-id: 20250902-topic-arm64-pi-aa64isar0-atomic-8fdd47558eee
> 
> Best regards,
> -- 
> Neil Armstrong <neil.armstrong@linaro.org>
> 
> 

