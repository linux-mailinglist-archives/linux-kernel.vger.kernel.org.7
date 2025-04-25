Return-Path: <linux-kernel+bounces-620500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F892A9CB95
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 16:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70C2616E5C0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 14:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268A32571DF;
	Fri, 25 Apr 2025 14:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="L5vNjREB"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171912580F8
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745590812; cv=none; b=OL6ddh0vzIp9e8hSM5ygwF4nr9ETwjA8PeSS0QDO/genKpL0pvZ30grt31HpYn3koPZd8jEUOTLkc/srRSHg/J1+zFtj/Muw0Dis2JVR8FwvqhXlNtmU3gyS5rbFACDjPyaQ3BerNlnzm3rxi9ii1DONFHcAKZUM9B+CqNdORcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745590812; c=relaxed/simple;
	bh=K9FDg6mkXT+8bJP4wzORvmgE3i+qGooEdCt2vYUyTiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKEwRs97ABMBPYOiXuUb2dD6JRHWS1zEqk+nSfTBKoHocy2D5GDvAVmx/ImRsaSmTpT5VhXnFjBWcdhuJovfKW8qrlqexKEbZT4Cu3DslzWbJdZ4pIni5dsPHd/FN8eBsytf0DsoFQpWV/fmQOxvkOUmj2pZLgbVF840uqa7reo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=L5vNjREB; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39efc1365e4so1153028f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 07:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1745590808; x=1746195608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HzMPyDCfmZ5P+tmbLJqGtVcfwWooIgaMBHX7zeCawZE=;
        b=L5vNjREBLdzL6NySFls1dlDd9KDFGR4oo6tpmQVTJLHO8gCNFPg4DqLMerrd/PGvEs
         iFpUjj1xLnbRlDy/lUTkL2YrU+GiH8XhGHUaDd9ge2CnEJWrnHS7n20UUbtIEN8/pr64
         c3zfjAzcdtdg8apbuTVf+5mYbIpvMBXwj1+tU3Ds+qps9KNl34n+xMifqM8MWK/p6LeQ
         Mz21ajtRi0g2OpDxYq/E2zpSD/+HW+QeM+k089JxJ/OPi6ot+Xg65Nop/eI/UAYzOB4M
         9tqZT0+bUtoTZIXaqxdJRrj8k6jO1n3ILkOlKPGWiYi3YMlEa4b7kNwF4Xtm/Np33+fc
         famg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745590808; x=1746195608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzMPyDCfmZ5P+tmbLJqGtVcfwWooIgaMBHX7zeCawZE=;
        b=qsJ4qJkcfbEIJ3H15ooeLx68ELFL+Vjk83Z77ecUcv6Dk4clqVi6dpSYa3VsmpNVem
         8X1wdxZvzwIZejTnBF7I1U+aVAMSYoW7r8sftEzgk8iBK2+yhkd6/mlssTcuIW3+Aap7
         EfPUG9RdSffg8VykhLCEULNxFkiaOzkeOr1NDyayim1U8Ycq9FCl47hDVQx69jVhAxcb
         46EblHbYBbl7c0iga/YneSfTv2UZwkkG9z4ph0tLvhOmnGmf5rnsD7T0NTCm0Yb+nMQt
         NqZKxyZIvX5UmDn2gyTmN8YXf3xOPrRuHgAKij23Dwz4COh48cue9fk1IIn9WSh16OPr
         2Ehg==
X-Forwarded-Encrypted: i=1; AJvYcCWWdL6l8qoSMo1xjnh+ZX62doDorufp+WgYXbQD3MkpLeitbaOccGqYpwR/m183Q0MvIoJKmdMNtZRPvd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkEuzGIbB/FI/J4TIsZDzRvGQuJ7BsRQ30uwJTmw5mOoBc/yy2
	glenBy6PX0ZtnzhLyn9zs9HDCNWFLLeEaMAxdiegUstUSPDFQIpPSryXxJ3JZuk=
X-Gm-Gg: ASbGnctTzl6BrVgLxip7hu+iZ3PRtw6LhH7b9DNYbbKNalxie2GDI1DDYycXtMmqr0t
	xjglqo1/9lfGbPGm03xQ3Up/5nyh2a5D+pNqPbOWfkdsXcQqZ7gVPdkHCdfDosSdk+v8tLgFwsu
	/YoSshOmz85f7fQ9ey6m4EkwsMV+LI65nE7ifHM7FI3TTbsr3ePyE/1Er3PEK10xymBuYXcYnUC
	1hz30j6cBquP9u72jAT4T5QEbimgnHigyIJWpauYyTFO/CgmGM48F3oqgEMb6xvRnM+601k5hl9
	Q6KPHjnX9/gjeI82SZaRufKQBe14jhSLNoSx3f0=
X-Google-Smtp-Source: AGHT+IHJyNvS1zQ2yqE99jC6WN1IMb+zoFXeeKc94tYcW7I8Si86MaJJE5esTsQGeC56+CT3mVH95Q==
X-Received: by 2002:a05:6000:1ac9:b0:39f:e3b:406b with SMTP id ffacd0b85a97d-3a074e10480mr2287112f8f.5.1745590808165;
        Fri, 25 Apr 2025 07:20:08 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::f716])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4408d839711sm84525175e9.0.2025.04.25.07.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 07:20:07 -0700 (PDT)
Date: Fri, 25 Apr 2025 16:20:06 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] KVM: riscv: selftests: Add vector extension tests
Message-ID: <20250425-a2a40c6296018326cdcf7d24@orel>
References: <20250324-kvm_selftest_improve-v1-0-583620219d4f@rivosinc.com>
 <20250324-kvm_selftest_improve-v1-3-583620219d4f@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324-kvm_selftest_improve-v1-3-583620219d4f@rivosinc.com>

On Mon, Mar 24, 2025 at 05:40:31PM -0700, Atish Patra wrote:
> Add vector related tests with the ISA extension standard template.
> However, the vector registers are bit tricky as the register length is
> variable based on vlenb value of the system. That's why the macros are
> defined with a default and overidden with actual value at runtime.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  tools/testing/selftests/kvm/riscv/get-reg-list.c | 111 ++++++++++++++++++++++-
>  1 file changed, 110 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> index 8515921dfdbf..576ab8eb7368 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -145,7 +145,9 @@ void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
>  {
>  	unsigned long isa_ext_state[KVM_RISCV_ISA_EXT_MAX] = { 0 };
>  	struct vcpu_reg_sublist *s;
> -	uint64_t feature;
> +	uint64_t feature = 0;
> +	u64 reg, size;
> +	unsigned long vlenb_reg;
>  	int rc;
>  
>  	for (int i = 0; i < KVM_RISCV_ISA_EXT_MAX; i++)
> @@ -173,6 +175,23 @@ void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
>  		switch (s->feature_type) {
>  		case VCPU_FEATURE_ISA_EXT:
>  			feature = RISCV_ISA_EXT_REG(s->feature);
> +			if (s->feature == KVM_RISCV_ISA_EXT_V) {
> +				/* Enable V extension so that we can get the vlenb register */
> +				__vcpu_set_reg(vcpu, feature, 1);

We probably want to bail here if __vcpu_set_reg returns an error.

> +				/* Compute the correct vector register size */
> +				rc = __vcpu_get_reg(vcpu, s->regs[4], &vlenb_reg);

I see regs[4] is the encoding for vlenb, but I think we need a comment or
a define or something in order to reduce head scratching.

> +				if (rc < 0)
> +				/* The vector test may fail if the default reg size doesn't match */

I guess this comment should be below the break. We could probably use some
blank lines in this code too. But, more importantly, what does this
comment mean? That things may not work despite what we're doing here? Or,
I think it means that we're doing this just in case the default size we
already have set doesn't match. Can we reword it?

> +					break;
> +				size = __builtin_ctzl(vlenb_reg);
> +				size <<= KVM_REG_SIZE_SHIFT;
> +				for (int i = 0; i < 32; i++) {
> +					reg = KVM_REG_RISCV | KVM_REG_RISCV_VECTOR | size |
> +					      KVM_REG_RISCV_VECTOR_REG(i);
> +					s->regs[5 + i] = reg;
> +				}
> +				__vcpu_set_reg(vcpu, feature, 0);

Switch this to vcpu_set_reg() since we want to assert it worked.

> +			}

This if (s->feature == KVM_RISCV_ISA_EXT_V) block can go above the switch
since it's not dependent on feature_type. I'd probably also create a
function for it in order to keep finalize_vcpu() tidy and help with the
indentation depth.

>  			break;
>  		case VCPU_FEATURE_SBI_EXT:
>  			feature = RISCV_SBI_EXT_REG(s->feature);
> @@ -408,6 +427,35 @@ static const char *fp_d_id_to_str(const char *prefix, __u64 id)
>  	return strdup_printf("%lld /* UNKNOWN */", reg_off);
>  }
>  
> +static const char *vector_id_to_str(const char *prefix, __u64 id)
> +{
> +	/* reg_off is the offset into struct __riscv_v_ext_state */
> +	__u64 reg_off = id & ~(REG_MASK | KVM_REG_RISCV_VECTOR);
> +	int reg_index = 0;
> +
> +	assert((id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_VECTOR);
> +
> +	if (reg_off >= KVM_REG_RISCV_VECTOR_REG(0))
> +		reg_index = reg_off -  KVM_REG_RISCV_VECTOR_REG(0);
> +	switch (reg_off) {
> +	case KVM_REG_RISCV_VECTOR_REG(0) ...
> +	     KVM_REG_RISCV_VECTOR_REG(31):
> +		return strdup_printf("KVM_REG_RISCV_VECTOR_REG(%d)", reg_index);
> +	case KVM_REG_RISCV_VECTOR_CSR_REG(vstart):
> +		return "KVM_REG_RISCV_VECTOR_CSR_REG(vstart)";
> +	case KVM_REG_RISCV_VECTOR_CSR_REG(vl):
> +		return "KVM_REG_RISCV_VECTOR_CSR_REG(vl)";
> +	case KVM_REG_RISCV_VECTOR_CSR_REG(vtype):
> +		return "KVM_REG_RISCV_VECTOR_CSR_REG(vtype)";
> +	case KVM_REG_RISCV_VECTOR_CSR_REG(vcsr):
> +		return "KVM_RISCV_VCPU_VECTOR_CSR_REG(vcsr)";
> +	case KVM_REG_RISCV_VECTOR_CSR_REG(vlenb):
> +		return "KVM_REG_RISCV_VECTOR_CSR_REG(vlenb)";
> +	}
> +
> +	return strdup_printf("%lld /* UNKNOWN */", reg_off);
> +}
> +
>  #define KVM_ISA_EXT_ARR(ext)		\
>  [KVM_RISCV_ISA_EXT_##ext] = "KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_" #ext
>  
> @@ -635,6 +683,9 @@ void print_reg(const char *prefix, __u64 id)
>  	case KVM_REG_SIZE_U128:
>  		reg_size = "KVM_REG_SIZE_U128";
>  		break;
> +	case KVM_REG_SIZE_U256:
> +		reg_size = "KVM_REG_SIZE_U256";
> +		break;
>  	default:
>  		printf("\tKVM_REG_RISCV | (%lld << KVM_REG_SIZE_SHIFT) | 0x%llx /* UNKNOWN */,\n",
>  		       (id & KVM_REG_SIZE_MASK) >> KVM_REG_SIZE_SHIFT, id & ~REG_MASK);
> @@ -666,6 +717,10 @@ void print_reg(const char *prefix, __u64 id)
>  		printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_FP_D | %s,\n",
>  				reg_size, fp_d_id_to_str(prefix, id));
>  		break;
> +	case KVM_REG_RISCV_VECTOR:
> +		printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_VECTOR | %s,\n",
> +		       reg_size, vector_id_to_str(prefix, id));
> +		break;
>  	case KVM_REG_RISCV_ISA_EXT:
>  		printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_ISA_EXT | %s,\n",
>  				reg_size, isa_ext_id_to_str(prefix, id));
> @@ -870,6 +925,54 @@ static __u64 fp_d_regs[] = {
>  	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_D,
>  };
>  
> +/* Define a default vector registers with length. This will be overwritten at runtime */
> +static __u64 vector_regs[] = {
> +	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_VECTOR |
> +	KVM_REG_RISCV_VECTOR_CSR_REG(vstart),
> +	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_VECTOR |
> +	KVM_REG_RISCV_VECTOR_CSR_REG(vl),
> +	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_VECTOR |
> +	KVM_REG_RISCV_VECTOR_CSR_REG(vtype),
> +	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_VECTOR |
> +	KVM_REG_RISCV_VECTOR_CSR_REG(vcsr),
> +	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_VECTOR |
> +	KVM_REG_RISCV_VECTOR_CSR_REG(vlenb),

Let these lines stick out to be easier to read and ensure one register
encoding per line (we don't care about line length at all in this file :-)

> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(0),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(1),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(2),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(3),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(4),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(5),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(6),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(7),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(8),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(9),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(10),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(11),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(12),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(13),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(14),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(15),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(16),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(17),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(18),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(19),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(20),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(21),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(22),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(23),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(24),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(25),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(26),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(27),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(28),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(29),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(30),
> +	KVM_REG_RISCV | KVM_REG_SIZE_U128 | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(31),
> +	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE |
> +	KVM_RISCV_ISA_EXT_V,

should also stick out

> +};
> +
>  #define SUBLIST_BASE \
>  	{"base", .regs = base_regs, .regs_n = ARRAY_SIZE(base_regs), \
>  	 .skips_set = base_skips_set, .skips_set_n = ARRAY_SIZE(base_skips_set),}
> @@ -894,6 +997,10 @@ static __u64 fp_d_regs[] = {
>  	{"fp_d", .feature = KVM_RISCV_ISA_EXT_D, .regs = fp_d_regs, \
>  		.regs_n = ARRAY_SIZE(fp_d_regs),}
>  
> +#define SUBLIST_V \
> +	{"v", .feature = KVM_RISCV_ISA_EXT_V, .regs = vector_regs, \
> +		.regs_n = ARRAY_SIZE(vector_regs),}

I'd also let this stick out since it won't even be 100 chars.

> +
>  #define KVM_ISA_EXT_SIMPLE_CONFIG(ext, extu)			\
>  static __u64 regs_##ext[] = {					\
>  	KVM_REG_RISCV | KVM_REG_SIZE_ULONG |			\
> @@ -962,6 +1069,7 @@ KVM_SBI_EXT_SIMPLE_CONFIG(susp, SUSP);
>  KVM_ISA_EXT_SUBLIST_CONFIG(aia, AIA);
>  KVM_ISA_EXT_SUBLIST_CONFIG(fp_f, FP_F);
>  KVM_ISA_EXT_SUBLIST_CONFIG(fp_d, FP_D);
> +KVM_ISA_EXT_SUBLIST_CONFIG(v, V);
>  KVM_ISA_EXT_SIMPLE_CONFIG(h, H);
>  KVM_ISA_EXT_SIMPLE_CONFIG(smnpm, SMNPM);
>  KVM_ISA_EXT_SUBLIST_CONFIG(smstateen, SMSTATEEN);
> @@ -1034,6 +1142,7 @@ struct vcpu_reg_list *vcpu_configs[] = {
>  	&config_fp_f,
>  	&config_fp_d,
>  	&config_h,
> +	&config_v,
>  	&config_smnpm,
>  	&config_smstateen,
>  	&config_sscofpmf,
> 
> -- 
> 2.43.0
>

Thanks,
drew

