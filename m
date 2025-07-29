Return-Path: <linux-kernel+bounces-749513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F02B5B14F5A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 211B618A16D7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237CB1DE3DF;
	Tue, 29 Jul 2025 14:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tgFHkjL1"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F6C51022
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753799856; cv=none; b=XWaqllS+g6Q94p1/BNETmpplllyRhU9eatkjOiIJ4jHo5ApwZUhL9l3X5b/Cpg4sqaIIiSf/FxYtMOf5LoimbxnaArkl8dxyTuiMMQeR983aTRn6epa6TqX1TiFoH0Zz6ROfi9U/saiz4lkP4zwdpUxNqbYM/jIBRD4/Nxhu2Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753799856; c=relaxed/simple;
	bh=WcDBo56fYFqGtT23Tt4aeeploWz/hK7E2/sMoK4Evsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lig1avkR8NFGXm73YqHTyUCshojr0TsaEnj82aB10B11ex2YXuXpClMj2KjZgUoA4R8HWMcGk1apLiH7EAVrmCmB/up9rEXqwAeBRjf3jE7IsCYiOw3q8JcX6KYqEjfagrUkaBzmtuzhE7cLvXA15ol+rvC2dEA+ovOc4/Bu8HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tgFHkjL1; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 29 Jul 2025 07:37:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753799842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7SkkcDNglAXfu0FPaIefArcN3O7d7Q9M6mkwEnU1wYQ=;
	b=tgFHkjL1MUAkN7dMrvMKdcStfjJYcM4ebAA5sAdTDjfvIQEWiHLGWCSUsWvL0uV28S7XQ1
	eIgJ5E1Qt1cTbsiu7xjOB+1Is3P/keuM343viJH8dUcSreCBvbbf71iiZ15IFVZ4/ZwNAn
	N5QIg5/aQUhNFUpZfk3nhd91z6higeU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Set/unset vGIC v4 forwarding if direct IRQs
 are supported
Message-ID: <aIjcmquPNOdE5l4K@linux.dev>
References: <20250728223710.129440-1-rananta@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728223710.129440-1-rananta@google.com>
X-Migadu-Flow: FLOW_OUT

Hi Raghu,

Thanks for reporting this so quickly :)

On Mon, Jul 28, 2025 at 10:37:10PM +0000, Raghavendra Rao Ananta wrote:
> diff --git a/arch/arm64/kvm/vgic/vgic-v4.c b/arch/arm64/kvm/vgic/vgic-v4.c
> index e7e284d47a77..873a190bcff7 100644
> --- a/arch/arm64/kvm/vgic/vgic-v4.c
> +++ b/arch/arm64/kvm/vgic/vgic-v4.c
> @@ -433,7 +433,7 @@ int kvm_vgic_v4_set_forwarding(struct kvm *kvm, int virq,
>  	unsigned long flags;
>  	int ret = 0;
>  
> -	if (!vgic_supports_direct_msis(kvm))
> +	if (!vgic_supports_direct_irqs(kvm))
>  		return 0;
>  
>  	/*
> @@ -533,7 +533,7 @@ int kvm_vgic_v4_unset_forwarding(struct kvm *kvm, int host_irq)
>  	unsigned long flags;
>  	int ret = 0;
>  
> -	if (!vgic_supports_direct_msis(kvm))
> +	if (!vgic_supports_direct_irqs(kvm))
>  		return 0;

I'm not sure this is what we want, since a precondition of actually
doing vLPI injection is the guest having an ITS. Could you try the
following?

Thanks,
Oliver

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index a3ef185209e9..70d50c77e5dc 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -50,6 +50,14 @@ bool vgic_has_its(struct kvm *kvm)
 
 bool vgic_supports_direct_msis(struct kvm *kvm)
 {
+	/*
+	 * Deliberately conflate vLPI and vSGI support on GICv4.1 hardware,
+	 * indirectly allowing userspace to control whether or not vPEs are
+	 * allocated for the VM.
+	 */
+	if (system_supports_direct_sgis() && !vgic_supports_direct_sgis(kvm))
+		return false;
+
 	return kvm_vgic_global_state.has_gicv4 && vgic_has_its(kvm);
 }
 
diff --git a/arch/arm64/kvm/vgic/vgic.h b/arch/arm64/kvm/vgic/vgic.h
index 1384a04c0784..de1c1d3261c3 100644
--- a/arch/arm64/kvm/vgic/vgic.h
+++ b/arch/arm64/kvm/vgic/vgic.h
@@ -396,15 +396,7 @@ bool vgic_supports_direct_sgis(struct kvm *kvm);
 
 static inline bool vgic_supports_direct_irqs(struct kvm *kvm)
 {
-	/*
-	 * Deliberately conflate vLPI and vSGI support on GICv4.1 hardware,
-	 * indirectly allowing userspace to control whether or not vPEs are
-	 * allocated for the VM.
-	 */
-	if (system_supports_direct_sgis())
-		return vgic_supports_direct_sgis(kvm);
-
-	return vgic_supports_direct_msis(kvm);
+	return vgic_supports_direct_msis(kvm) || vgic_supports_direct_sgis(kvm);
 }
 
 int vgic_v4_init(struct kvm *kvm);

