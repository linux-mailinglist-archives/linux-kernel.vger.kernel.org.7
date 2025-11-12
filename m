Return-Path: <linux-kernel+bounces-898076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5079EC54411
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F108B34AA9C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C060E34DCC1;
	Wed, 12 Nov 2025 19:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="oeqMmQNp"
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com [209.85.166.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CD921ABB9
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762976516; cv=none; b=Aj7TVV3kcT5vWcRtVf5zFd40CsRa3Ba7Ee8/TJhxVADDlwwV8YXtVHGpAe9SUSLCv46Tssz7JVXt775sYpao00pv1pQu4WUmYcww78/Zv6vGtTClYpPFLgofwaoB8js6hHYxGz1qeXiT90A8xJSwXCFFVYRtzxiG+5VhcCUvU2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762976516; c=relaxed/simple;
	bh=LvSKt7c6mL8j8v/P5egpE2oTKtVtd4/mWnD8LCylupc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXapbhl3OCZex2Pzlqruy2ma/xL6ersjtndqQmxMS3V0oCZV7aQiOR66IBTWeuUSv74B/nzI3dSgnnhBWnLn+jt0Cr0XTLbeHIkhqKmVAwpWH92AlTeEzCfeY8id6R6uXDzbXZmX6+vqAe404/EhBUMvOF9wP3KLSJu2cn5x858=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=oeqMmQNp; arc=none smtp.client-ip=209.85.166.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f65.google.com with SMTP id ca18e2360f4ac-94895f6b144so4639839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1762976513; x=1763581313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMA7umxa7M13/2nnsYuaSzmg/6tAsRTTmHWEbgAOFwA=;
        b=oeqMmQNp2G7B7awpJxwx9TyEav5vYLLjZe+1rxzhtyljNUc8ICp8T+rO5SlFH+mIOz
         lVD1cCmKbFWkkBV4NgvK9mj0M85gGTmIiB9QjXXIK12E+OS7RyE2AwM5L0OLJEpHdH2e
         CDF7Z1Pb8CU3g0Aj820Xo3A3lqA3f9aCuO4vAD6YL9tyz38DvZUNkYY4rLeayC5ivCki
         G+P/xYkojZ8Ut9Ijpcz83D7TgCp5ywpC5n4/WCOdkcRw8kG0ajmjjm4ve0Pcj+PCquf7
         PgGl/3Bnq5t+75m12d6o/Enva555DwKx4oy601mgTm8qC40r+7xgEYFc3G1Y+ZPWm5+6
         Rjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762976513; x=1763581313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZMA7umxa7M13/2nnsYuaSzmg/6tAsRTTmHWEbgAOFwA=;
        b=CzUaVF+KuJ/kVaJh4/+Zd+w2gTSC+BtFVYYJc+NPf3Fpf55BGaDaQOq8/Dd1ACOj0h
         VVQbNgg6o910gXlarywhey8b8mwWqO5O/xl5ao8RYmAad2Ug3qmNZrK8c4pUx8q03PCY
         xjjhMQ8uPTKLA9aUdyQOjOkjbVEQJmjp9TUDDyEpYVTTOZbJQaLNbxsCQ+f/eO53b4PX
         qbny9K91eOl8KzSwzHSGCyfYEtSLkkEPuvrQsQOcsib8vnUAzFkoOQ5UzvDmnGCZST5D
         A63bEDD46Htcfz3SP2Fy1Oz94u4YWGz6cQlcrv+IsReIIQL8UCFukJNab6eIvgVSJXH1
         U3YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPImiag2Q+MJTgwyceJ4Rs/1y+rUmx0JlmqdPkpdJxvqEMCqEI0WqoUKPBSq6Q4eYF0kIS6OEFBuQ3gMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw114YMCUlPk8yMZu2vdhd0G9tCscFRtCVZ6zGOEZSH9zori1N8
	00b5o2jfs7vUxqxyMXM7SuStvZGIUR7Qk0VLdFwOIA9QDAp0+J7Y8FyVfp/MPtdii6I=
X-Gm-Gg: ASbGncs118cprJhguiIUCt+oJ6evLwNrGbiN1tXMojjQDPZJt6gGhy8ISNPL/DToMqw
	JU52PKaQTEXpHw4scbO/zVJTf3h0qgcHiWhcHGVhfb/sD/NghcmzEXvPN93kCMDrdU6iqqFswv4
	9iCiMuDOZLhgBed/RYspfXQB2FW7zx4a+jPg/o/pCVTIGwbtbyqW3ZgCEDyIMBLeJKq2tVtC8fF
	9OiYdRbCx2PDZDqdRbKpBKcBPzQ+dB2gZldx4eVH8X9fIjYNvM01mYf/4PlXmWQKxtPzSNcX6Ds
	1EKqxPUQ6+5qJh5BRDGskqG8RFdmSPqIH14s5kCbIt0CiAqvKX11avdnsFfgARjU4DTXHOWNpke
	nP9rNnU5q1/R5lPol2xbFYMxnGRva1J9Y7t4cjZujL3Ak6MUCsRyhvxTE2YTTAbtCbN6cTLApKs
	tMXPRdpig5a8rN
X-Google-Smtp-Source: AGHT+IGh8DCFt1oIqqCbGQ0wsRQiBXjDUEe509PqSzAj7qQEM67Tz6IzQ/QYjRBR31SonG3aigsETg==
X-Received: by 2002:a05:6e02:1561:b0:431:d7da:ee29 with SMTP id e9e14a558f8ab-43473da5e33mr49322955ab.28.1762976513477;
        Wed, 12 Nov 2025 11:41:53 -0800 (PST)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7aaf78752sm1340522173.15.2025.11.12.11.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 11:41:52 -0800 (PST)
Date: Wed, 12 Nov 2025 13:41:51 -0600
From: Andrew Jones <ajones@ventanamicro.com>
To: fangyu.yu@linux.alibaba.com
Cc: anup@brainfault.org, atish.patra@linux.dev, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, guoren@kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RISC-V: KVM: Fix guest page fault within HLV*
 instructions
Message-ID: <20251112-ae882e7fd8d1fcbb73d87c6c@orel>
References: <20251111135506.8526-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111135506.8526-1-fangyu.yu@linux.alibaba.com>

On Tue, Nov 11, 2025 at 09:55:06PM +0800, fangyu.yu@linux.alibaba.com wrote:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> 
> When executing HLV* instructions at the HS mode, a guest page fault
> may occur when a g-stage page table migration between triggering the
> virtual instruction exception and executing the HLV* instruction.
> 
> This may be a corner case, and one simpler way to handle this is to
> re-execute the instruction where the virtual  instruction exception
> occurred, and the guest page fault will be automatically handled.
> 
> Fixes: b91f0e4cb8a3 ("RISC-V: KVM: Factor-out instruction emulation into separate sources")
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> 
> ---
> Changes in v2:
> - Remove unnecessary modifications and add comments(suggested by Anup)
> - Update Fixes tag
> - Link to v1: https://lore.kernel.org/linux-riscv/20250912134332.22053-1-fangyu.yu@linux.alibaba.com/
> ---
>  arch/riscv/kvm/vcpu_insn.c | 39 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
> index de1f96ea6225..a8d796ef2822 100644
> --- a/arch/riscv/kvm/vcpu_insn.c
> +++ b/arch/riscv/kvm/vcpu_insn.c
> @@ -323,6 +323,19 @@ int kvm_riscv_vcpu_virtual_insn(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  							  ct->sepc,
>  							  &utrap);
>  			if (utrap.scause) {
> +				/**
> +				 * If a g-stage page fault occurs, the direct approach
> +				 * is to let the g-stage page fault handler handle it
> +				 * naturally, however, calling the g-stage page fault
> +				 * handler here seems rather strange.
> +				 * Considering this is an corner case, we can directly
> +				 * return to the guest and re-execute the same PC, this
> +				 * will trigger a g-stage page fault again and then the
> +				 * regular g-stage page fault handler will populate
> +				 * g-stage page table.
> +				 */
> +				if (utrap.scause == EXC_LOAD_GUEST_PAGE_FAULT)
> +					return 1;
>  				utrap.sepc = ct->sepc;
>  				kvm_riscv_vcpu_trap_redirect(vcpu, &utrap);
>  				return 1;
> @@ -378,6 +391,19 @@ int kvm_riscv_vcpu_mmio_load(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  		insn = kvm_riscv_vcpu_unpriv_read(vcpu, true, ct->sepc,
>  						  &utrap);
>  		if (utrap.scause) {
> +			/**
> +			 * If a g-stage page fault occurs, the direct approach
> +			 * is to let the g-stage page fault handler handle it
> +			 * naturally, however, calling the g-stage page fault
> +			 * handler here seems rather strange.
> +			 * Considering this is an corner case, we can directly
> +			 * return to the guest and re-execute the same PC, this
> +			 * will trigger a g-stage page fault again and then the
> +			 * regular g-stage page fault handler will populate
> +			 * g-stage page table.
> +			 */
> +			if (utrap.scause == EXC_LOAD_GUEST_PAGE_FAULT)
> +				return 1;
>  			/* Redirect trap if we failed to read instruction */
>  			utrap.sepc = ct->sepc;
>  			kvm_riscv_vcpu_trap_redirect(vcpu, &utrap);
> @@ -504,6 +530,19 @@ int kvm_riscv_vcpu_mmio_store(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  		insn = kvm_riscv_vcpu_unpriv_read(vcpu, true, ct->sepc,
>  						  &utrap);
>  		if (utrap.scause) {
> +			/**
> +			 * If a g-stage page fault occurs, the direct approach
> +			 * is to let the g-stage page fault handler handle it
> +			 * naturally, however, calling the g-stage page fault
> +			 * handler here seems rather strange.
> +			 * Considering this is an corner case, we can directly
> +			 * return to the guest and re-execute the same PC, this
> +			 * will trigger a g-stage page fault again and then the
> +			 * regular g-stage page fault handler will populate
> +			 * g-stage page table.
> +			 */
> +			if (utrap.scause == EXC_LOAD_GUEST_PAGE_FAULT)
> +				return 1;
>  			/* Redirect trap if we failed to read instruction */
>  			utrap.sepc = ct->sepc;
>  			kvm_riscv_vcpu_trap_redirect(vcpu, &utrap);
> -- 
> 2.50.1
>

To avoid repeating the same paragraph three times I would create a
helper function, kvm_riscv_check_load_guest_page_fault(), with the
paragraph placed in that function along with the utrap.scause
exception type check.

Thanks,
drew

