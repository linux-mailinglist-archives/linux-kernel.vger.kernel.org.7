Return-Path: <linux-kernel+bounces-858427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4802CBEAD8E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A51A5C5266
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A8C2C2ABF;
	Fri, 17 Oct 2025 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="RE5ZjTxH"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76F82C0F93
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718048; cv=none; b=CY/U5YYldzasqbr65wHus9dlx2NYmEa+oFL4sRuwwYtl5haZYGPQyNIzdWR14zKAeHVEzf21WX4sXNhumKY8AI5Bka5wQMGpKfIYaoL9gAd7J2OJ/jCMtzmJO36EHG5u/dx78k70ZEeMqambPQm+wRYz30CfxO/9E3SCp6JXGmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718048; c=relaxed/simple;
	bh=jPnIBNXjWFgFyMR6aOnBqBJY3wZ36RIzhFnOSbYyl8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lucJ9G9ChuchhNwJVWhE/4cvjeJOMgj9FjZAfCGoXLP/Vyy0I12WKFfnHVvD0qjnDocLNB5djGKpxNvvHrnoQgXiXxLj44x7C1E+ec5MFJpwFFHJXJAKVxqKmv/M8DxDOUH+yP0nVm/sMlqXjBktvJ7KR+75a8mGSoA4CSvRs54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=RE5ZjTxH; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-887764c2868so208678039f.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760718045; x=1761322845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uHcp/aWTKuBzfOH84Xc834di52qmuKsQVMyFNNeyUD0=;
        b=RE5ZjTxHWpSyS/gTIOEr2E0b7TshmBK12gGzmFK0QIG0wYfT0dODRDAFZUnQ35Qase
         KmfBGSzd98vsvsQxzaG7aD+k14XvjaL6GtvjUXuWULC257CxoaF6wElyIq9OqCz+e0ey
         HiyCHuysunF6Ez722nAYzZjEm0Xa/y424Sudb85AEegBkdICvAlSt3noNPUgH/j+rvYe
         33TfzSB0TjvrsfLvViSFk3OaVMksWcGQuMe3nKaGdk8a2dCHdeVEWJqQRtdIgcDB1X2z
         i7V1mQ+9/94No048cacCi2C9BJEjCI/p5y7vV98ESjikw/L/l1B8zFrjNNP/+omSPnas
         fBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760718045; x=1761322845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHcp/aWTKuBzfOH84Xc834di52qmuKsQVMyFNNeyUD0=;
        b=G3/CxnZLeAscRjnJI8qGCwA56hvZOjOGXnS9ccXRVsmTZNVWWpWLdVoO8VEUN5XKCb
         8DlnaKeoArlZr7oMMB1uDD5bDhUFRgB94c9PfRtBFVIgeCSCIMe1UUH09PtJLjOf+SKZ
         WIomGGRwpnywWVlZiag54pN3T0QTOG84x4JZNYJOei0uECFfqwuoED5KqINBV8U7uKOp
         /b512AAE5/1OHiaNhtGzz0+3RFEbbaGDjKx1oKwxiEx9p4rJe5290vcS2XodKE1b4G6x
         s3HLEDpRi/9hPgkmK+nrprbSDgHCGGlf9yF/zzDQNk2khywRyU0KZ8v4znriEs6qPuBy
         9JrA==
X-Forwarded-Encrypted: i=1; AJvYcCULiaGipSIFmiWNNNkSiEShcmIJyMf2VLDfuQcq8xKKgPVPPqp8INzgdyLJ1p/cVCkJymGZp5EtQQE08g4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzh8ivKqM55PkZw2+pYJvE1t7T17ipxuije0pMoEwIYv+uGjow
	9gzgoeOjTNk+mRe7fUM86913QIvK4mI8RCWUM6oxzRHAhzMfoRKZHL9P6stWxXyD6OM=
X-Gm-Gg: ASbGncsH5grQD2rIhg8J3CqiI8FrygxhVcP2YN5zcIBNjSNs7rD9+JmrbGXPhndoYXo
	DLRVuwJ2tQihVtR4GRbJMWmLUcVsXIP6FECE6MnAgDHIof4cbhnCp0PptMlpQBJPQmEX6PlacBL
	sFYcpjpOKkithTKPYPNjqJlw1b1fh5lEbTQJRHmsF9lMOg8MOsGAA2YKJzTfbADE6gxTFcY63H+
	Hprfv93KjRB9AHw+2iL0VrRkNz4PQPA/ZnAvyZP+So4FJh8Txzyn+82Q+7yo5YUxCAoek2ewYeI
	WbiR3+gWep2lE8nNPGQ3biGI62igXc0GFDkQ4POtPGEJ2lyEP169UEBOqFSAkJvcfkaHMgabpwZ
	PZqR79neSLSX0rXtARQidJvIhvdiqa1BYj/Cpe+802q7lMY9IP+Kj/U+wKGBtouf1kSZyGpq5XV
	KMsA==
X-Google-Smtp-Source: AGHT+IGb7WVIYEXYDolygsCFth05K0mPGRPpQvAMXm74hPFwBGeILraMt8hiRJ5jXXj3KN04uw/DDg==
X-Received: by 2002:a05:6e02:1905:b0:42f:9e54:76d0 with SMTP id e9e14a558f8ab-430c52ac0d8mr55233645ab.23.1760718044856;
        Fri, 17 Oct 2025 09:20:44 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430d07a874csm804025ab.19.2025.10.17.09.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:20:44 -0700 (PDT)
Date: Fri, 17 Oct 2025 11:20:43 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Atish Patra <atish.patra@linux.dev>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 4/4] KVM: riscv: selftests: Add SBI MPXY extension to
 get-reg-list
Message-ID: <20251017-7e149a197ad3d9d99bd45a4b@orel>
References: <20251017155925.361560-1-apatel@ventanamicro.com>
 <20251017155925.361560-5-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017155925.361560-5-apatel@ventanamicro.com>

On Fri, Oct 17, 2025 at 09:29:25PM +0530, Anup Patel wrote:
> The KVM RISC-V allows SBI MPXY extensions for Guest/VM so add
> it to the get-reg-list test.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  tools/testing/selftests/kvm/riscv/get-reg-list.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> index 705ab3d7778b..cb54a56990a0 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -133,6 +133,7 @@ bool filter_reg(__u64 reg)
>  	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_SUSP:
>  	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_STA:
>  	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_FWFT:
> +	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_MPXY:
>  	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_EXPERIMENTAL:
>  	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_VENDOR:
>  		return true;
> @@ -639,6 +640,7 @@ static const char *sbi_ext_single_id_to_str(__u64 reg_off)
>  		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_SUSP),
>  		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_STA),
>  		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_FWFT),
> +		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_MPXY),
>  		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_EXPERIMENTAL),
>  		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_VENDOR),
>  	};
> @@ -1142,6 +1144,7 @@ KVM_SBI_EXT_SUBLIST_CONFIG(sta, STA);
>  KVM_SBI_EXT_SIMPLE_CONFIG(pmu, PMU);
>  KVM_SBI_EXT_SIMPLE_CONFIG(dbcn, DBCN);
>  KVM_SBI_EXT_SIMPLE_CONFIG(susp, SUSP);
> +KVM_SBI_EXT_SIMPLE_CONFIG(mpxy, MPXY);
>  KVM_SBI_EXT_SUBLIST_CONFIG(fwft, FWFT);
>  
>  KVM_ISA_EXT_SUBLIST_CONFIG(aia, AIA);
> @@ -1222,6 +1225,7 @@ struct vcpu_reg_list *vcpu_configs[] = {
>  	&config_sbi_pmu,
>  	&config_sbi_dbcn,
>  	&config_sbi_susp,
> +	&config_sbi_mpxy,
>  	&config_sbi_fwft,
>  	&config_aia,
>  	&config_fp_f,
> -- 
> 2.43.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

