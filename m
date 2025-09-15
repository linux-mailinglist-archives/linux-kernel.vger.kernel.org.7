Return-Path: <linux-kernel+bounces-817478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4DFB582AC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 852A61893828
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859AC2773F2;
	Mon, 15 Sep 2025 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="VzvGeyL8"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6C71B0F23
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757955709; cv=none; b=oveqnQqdT2fqIfBHAEqj1t/dCoRljt5exFq6NbTbqAY2E/TBfLJm3bGic2TAbuaYIq5S7967zNF7Ru4+5AJPks7emg5M4RBMM/N/O5K7snL30eM5zQ8mqIfLl1A5IJN6OnRTWNUc2HJ0M9C/ZDcFbPO4Jmx1o4wwt8SkQoD5wdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757955709; c=relaxed/simple;
	bh=q4Gi0ntxWm1QrtAeAhkAa/jv924QF60CECMU0fW1MPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qjx7/9LDxM0aUr9NQ24lRhsTaWImmF1ERr5MSrVw8uxkpPblXNmYdswResutws0UAm1Vyj9iZSKrZeU+Ve388YeWwkK7voLXZpUo4J2CGe64tyqkWjG10e6qU0fctpiCy6VxW1QopsXZQ4bh4GOZo1F9goM3Q+d/Sd+WivFBOGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=VzvGeyL8; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-4240784860bso4694355ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1757955707; x=1758560507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k8pxyW/bjpXpmupAYzyp4FH4PZi8lnxP+pKqyf7C5o8=;
        b=VzvGeyL8FXrgpliKhFD8q1r79DEdkAuho8nbsnNm8Trwrb5GOe1PZkwq4x1+RKTBpt
         0YAh8PZrGQgcUYxtpsDYbLUrU65pbT7n37PzbexTZ08IxG2Zx/8XQGw+eMs35QGy/fQm
         NQXp+TtKK5rU4z0fbJA7Am+ByzEmz3TYe4MlOVFCgf231Jk3vIWAAZJyCHMItR7FOXxE
         NdWG0KwRvJrnKODY34i59lzWIxK/srFNBJawzFWEfHZDVsssR3D3oTCNJhx5EP3r1uvn
         QuqWNlmCYx/EWRXrDcJe+WVPO6R5kGpPE1gn/5qqLkNWpq5Zx+J9j120NllSG0W5aV6K
         XA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757955707; x=1758560507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8pxyW/bjpXpmupAYzyp4FH4PZi8lnxP+pKqyf7C5o8=;
        b=REwlbdO/2zorjGYA7Lc2AuDqkiLwSYX13HwcB9UgOxfl1KYaUFdKGNMBLxqqxzv5Gv
         bawo8+1WCb2BzLc0I+PaQlzFSuzsjl37HyGNgzIUlc8aEYZu1DvFUMl3HoRp/DJEn+Ct
         /5Tyglt1tmT41GQHYjLpc5zE421UrnEWZ4NgiAarloYWz8AKW1GG603XBICGWu+vAxgT
         q3t5BuLmE+qks/AP/E4xBIOq7UArW+/wisvAFn4S+6bDY4raGR9MszHPhN8pFo5jsQ5h
         K4JOEnpGPQGfOhJ7TZDHoQ1xwPS0uwhvGTCdkDBYVO8fLW/pELCFwWoXdFMq/m0qej7V
         AHWQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9rW3Pwk1lCQcBm7DH25j7kO63TQ1sIlTNRf8bsKkcG86ZQqbgGOCYK+L11yVghsfP0Z3KEVCZPDER79M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdJz2JfBJodHHkNdXNHo7i1l/AYebCGV9cxwSY1I1T7agINSpr
	G+P38IEGu8fsI2h6vnkrhrjCOD/+6ECh41ZmWMc9Tzejq1MIcNHXgmwXlts5DUj047Q=
X-Gm-Gg: ASbGnctmGL2hNyxKsyWqcuJBllBzOilfaWvJWKrcRUcDgiyH/qry7yduZSrk+DZtTwi
	z0CTBRfTI1iRwkQFO0hBn80qPnVA/Z0n4NOGx3EvymjkZX5G8EONlpkMaQwFyl+7lAt1rtsGfXH
	/umW7HTFI8HvPPd2WdvF16lL5qFvtz5aZ0NB25ok2OShR1mkO1lmCYBVkOfE1Q5656BRKfG+P/W
	GN3c03gXuS7ST1QOO0RF0QSyVMTVrNeAlZUaBTYmI3vCgeQIOaZutV5EpbFL7S7rAXpGabDcZcK
	W7rlmVO3lLSFD63VnKDzC5y//CAokO5B97ibH2fdFujT1lojrKbfggkBNwBHMZLarM+habfR2GF
	TiTaoJioaispjuiOaGUUlsi2S
X-Google-Smtp-Source: AGHT+IFi6vqzi7uBigrs1rkZ7BYQA7tKMwkaIff57LL4Wv+ao8W4QcMhs/+e22hjK6NK5HxClZr37A==
X-Received: by 2002:a05:6e02:188d:b0:3eb:5862:7cef with SMTP id e9e14a558f8ab-420a4173bb3mr104487445ab.22.1757955706965;
        Mon, 15 Sep 2025 10:01:46 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-41dfb240f4fsm58897935ab.43.2025.09.15.10.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 10:01:46 -0700 (PDT)
Date: Mon, 15 Sep 2025 12:01:45 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Jinyu Tang <tjytimi@163.com>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
	Conor Dooley <conor.dooley@microchip.com>, Yong-Xuan Wang <yongxuan.wang@sifive.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Nutty Liu <nutty.liu@hotmail.com>, 
	Radim Krcmar <rkrcmar@ventanamicro.com>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Tianshun Sun <stsmail163@163.com>
Subject: Re: [RFC PATCH] kvm/riscv: Add ctxsstatus and ctxhstatus for
 migration
Message-ID: <20250915-ad649bd2a0c0b9e98b63c5f4@orel>
References: <20250915152731.1371067-1-tjytimi@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915152731.1371067-1-tjytimi@163.com>

On Mon, Sep 15, 2025 at 11:27:31PM +0800, Jinyu Tang wrote:
> When migrating a VM which guest running in user mode 
> (e.g., executing a while(1) application), the target 
> VM fails to run because it loses the information of 
> guest_context.hstatus and guest_context.sstatus. The 
> VM uses the initialized values instead of the correct ones.

Does https://lore.kernel.org/all/20250915070811.3422578-1-xb@ultrarisc.com/
fix this?

Thanks,
drew

> 
> This patch adds two new context registers (ctxsstatus and 
> ctxhstatus) to the kvm_vcpu_csr structure and implements 
> the necessary KVM get and set logic to preserve these values 
> during migration.
> 
> QEMU needs to be updated to support these new registers.
> See https://github.com/tjy-zhu/qemu
> for the corresponding QEMU changes.
> 
> I'm not sure if adding these CSR registers is a right way. RISCV
> KVM doesn't have API to save these two context csrs now. I will
> submit the corresponding QEMU patch to the QEMU community if
> KVM has API to get and set them.
> 
> Signed-off-by: Jinyu Tang <tjytimi@163.com>
> Tested-by: Tianshun Sun <stsmail163@163.com>
> ---
>  arch/riscv/include/asm/kvm_host.h |  2 ++
>  arch/riscv/include/uapi/asm/kvm.h |  2 ++
>  arch/riscv/kvm/vcpu_onereg.c      | 16 ++++++++++++++++
>  3 files changed, 20 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
> index d71d3299a..55604b075 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -161,6 +161,8 @@ struct kvm_vcpu_csr {
>  	unsigned long vsatp;
>  	unsigned long scounteren;
>  	unsigned long senvcfg;
> +	unsigned long ctxsstatus;
> +	unsigned long ctxhstatus;
>  };
>  
>  struct kvm_vcpu_config {
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
> index ef27d4289..cd7d7087f 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -81,6 +81,8 @@ struct kvm_riscv_csr {
>  	unsigned long satp;
>  	unsigned long scounteren;
>  	unsigned long senvcfg;
> +	unsigned long ctxsstatus;
> +	unsigned long ctxhstatus;
>  };
>  
>  /* AIA CSR registers for KVM_GET_ONE_REG and KVM_SET_ONE_REG */
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index cce6a38ea..284ee6e81 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
> @@ -489,6 +489,12 @@ static int kvm_riscv_vcpu_general_get_csr(struct kvm_vcpu *vcpu,
>  	if (reg_num >= sizeof(struct kvm_riscv_csr) / sizeof(unsigned long))
>  		return -ENOENT;
>  
> +	if (reg_num == KVM_REG_RISCV_CSR_REG(ctxsstatus))
> +		csr->ctxsstatus = vcpu->arch.guest_context.sstatus;
> +
> +	if (reg_num == KVM_REG_RISCV_CSR_REG(ctxhstatus))
> +		csr->ctxhstatus = vcpu->arch.guest_context.hstatus;
> +
>  	if (reg_num == KVM_REG_RISCV_CSR_REG(sip)) {
>  		kvm_riscv_vcpu_flush_interrupts(vcpu);
>  		*out_val = (csr->hvip >> VSIP_TO_HVIP_SHIFT) & VSIP_VALID_MASK;
> @@ -515,6 +521,16 @@ static int kvm_riscv_vcpu_general_set_csr(struct kvm_vcpu *vcpu,
>  
>  	((unsigned long *)csr)[reg_num] = reg_val;
>  
> +	if (reg_num == KVM_REG_RISCV_CSR_REG(ctxsstatus)) {
> +		if (csr->ctxsstatus != 0)
> +			vcpu->arch.guest_context.sstatus = csr->ctxsstatus;
> +	}
> +
> +	if (reg_num == KVM_REG_RISCV_CSR_REG(ctxhstatus)) {
> +		if (csr->ctxhstatus != 0)
> +			vcpu->arch.guest_context.hstatus = csr->ctxhstatus;
> +	}
> +
>  	if (reg_num == KVM_REG_RISCV_CSR_REG(sip))
>  		WRITE_ONCE(vcpu->arch.irqs_pending_mask[0], 0);
>  
> -- 
> 2.43.0
> 
> 
> -- 
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv

