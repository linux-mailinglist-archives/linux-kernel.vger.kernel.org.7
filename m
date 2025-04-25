Return-Path: <linux-kernel+bounces-620455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A322A9CAD1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 15:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4FF717432A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 13:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0F523371B;
	Fri, 25 Apr 2025 13:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="UFof23l2"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84556F30C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745589032; cv=none; b=hdM6xY/MmvN/zgkmOS8puskI85oZh0R+0UdGpqW0/5vG3l4tizrunlWRfDVpmUxsL5gumBKYhlXu93N5/mesXOA/730DXGKAOX338Lm66RjKzg5Nw/NwwCeOdN09dZwHJZVEYU7helcQny4JtnKevXFO12q0z+YShNGxmUc46ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745589032; c=relaxed/simple;
	bh=D+DjpJkVY50DCH/EIM2jyo+5APpyBQvmmE9jeNvI0IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ci0PwQwrIMBbnw3gW9SLD91RzNxzjsQP6Hx1rX/lBVH0mj2DEgzDIhJJYES2c7zMllENJGA09r3O048LDi9hZuOE55ZJ9FhrWy+F99r5q8owzdmDrqBr2iZaDj/9j1/hA+3q5Y4JEvA1YQ4PGlUsBI8eq0fmf2HypfQuaWO7Kok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=UFof23l2; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso16087225e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 06:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1745589029; x=1746193829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUA/m6gOa249NNOmchovOHq5LELqOzlt/ubdwJUo+cU=;
        b=UFof23l2l5NNuW4SRlxc5RyBLx3foa/OACM0JNkbNkWglyp3NrALdiOP13LBxFEOCY
         DPBjBTbQVDK9MRRXCDl+/ikzUejmImiGShFwlLTR9KjMeGVGjUDgPmrGVxx36kAHJI+q
         roV1RMdHSja37GodK2QFW8/zVz/p/La0UoeVyKWJk4OxA2Cl/5MBhwH7lJBd4QDOC+sd
         uxiw5iZiJYfD8+ki7R2gZg5oBsyrV8iYm+H/7Ef+3PGWoyzH4H95+ELGn7+KzQgVvXqc
         lOT0lAYw1Zi17Z8e+bqQHCGjHOZgIrPgH9NfITuXRe1qHX7xWZe3AcvXHP9I2MH/+kAF
         wKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745589029; x=1746193829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUA/m6gOa249NNOmchovOHq5LELqOzlt/ubdwJUo+cU=;
        b=RvDT6vP5TKsTCOG9pcQWz26w7vLOB05K874DU0BYDUpuJvGXLpSMQ17Omter5h2wvy
         BmHSCoTE7X07YZtmW/dtG6crMw2fHPNg7kFOcHqWkKITih4Dmd7/QIPn0dB5e8v3df6W
         d19dEMUGaLoCgm0dC/RG2CQViWLMiE+Npr6tOqFUEJ4ifJSIejF03TVtVHisbQ2P5wt6
         hOVfl00s+fCACB1Vo3qXWLywbvkRrqbS+41pdLW3WbU5vZ+DSz0ilztq1FtbORgFPXpa
         5RpORYZ5Of9sM0gtYtycRga1q+wcGzmy9jct/ClwzKxDmTz5SBEOc98OF5v2+lSXwMxe
         F51A==
X-Forwarded-Encrypted: i=1; AJvYcCXI7xxPe3gPhM+4Ie/M4Ht85rWVxisav8envIvuUyStdProdWukBygw/T0H+MTHq5y5scRUh9G5NqJ4els=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxoXxjiChKgRniVqR84ny7uqRGNRSwkrIbrEGbH2jLZAd2kvbl
	jd64/Lo670/pNx+Q2jvXYCi58C/cHD8tZpyDFmvl8CEgeCWKA11FZHBH6AQTVRk=
X-Gm-Gg: ASbGncsbxskPsgkPzqAmxqLs/qOrbJC38gDWQ7EQLwRvr68tD7EH5Vm1Q53ULEWwJ1i
	ffU9LzBnXzwOtwdRMk3jVag5AFHTaaCaBsmwldJ5eW/LzBjrRr92FTRccdAOW0iGVbSPaLsKFkH
	D0sOkf/sBZRso3FhwCwNJNFTu5rbfR/olUNvA5veCTbLf097s/7sPNxlPtNsruXccVLKWUu+kIk
	0WNrX+WUW4Gn8ENu4y48RcOir9MpMvqKpqwF1AQ344JPBs+aqaA/Co3dsOMB7J2szAHV5JGE1j6
	xhxDhw7KvX73PIATCvOnYC/Nz6MG
X-Google-Smtp-Source: AGHT+IF/LMdkzYLBWPyT5ztxJyzb+GPhFh3GxsY5b8ixWQQMljvmNbliBGV7ZjWkl9GsiErnAoI9/g==
X-Received: by 2002:a05:600c:1f82:b0:43d:934:ea97 with SMTP id 5b1f17b1804b1-440a66ab23bmr18288315e9.27.1745589028834;
        Fri, 25 Apr 2025 06:50:28 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::f716])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073c8cab5sm2480265f8f.10.2025.04.25.06.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 06:50:28 -0700 (PDT)
Date: Fri, 25 Apr 2025 15:50:27 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] KVM: riscv: selftests: Add stval to exception
 handling
Message-ID: <20250425-dc44cb547ab5e2f994c94e80@orel>
References: <20250324-kvm_selftest_improve-v1-0-583620219d4f@rivosinc.com>
 <20250324-kvm_selftest_improve-v1-1-583620219d4f@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324-kvm_selftest_improve-v1-1-583620219d4f@rivosinc.com>

On Mon, Mar 24, 2025 at 05:40:29PM -0700, Atish Patra wrote:
> Save stval during exception handling so that it can be decoded to
> figure out the details of exception type.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  tools/testing/selftests/kvm/include/riscv/processor.h | 1 +
>  tools/testing/selftests/kvm/lib/riscv/handlers.S      | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
> index 5f389166338c..f4a7d64fbe9a 100644
> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> @@ -95,6 +95,7 @@ struct ex_regs {
>  	unsigned long epc;
>  	unsigned long status;
>  	unsigned long cause;
> +	unsigned long stval;
>  };
>  
>  #define NR_VECTORS  2
> diff --git a/tools/testing/selftests/kvm/lib/riscv/handlers.S b/tools/testing/selftests/kvm/lib/riscv/handlers.S
> index aa0abd3f35bb..2884c1e8939b 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/handlers.S
> +++ b/tools/testing/selftests/kvm/lib/riscv/handlers.S
> @@ -45,9 +45,11 @@
>  	csrr  s0, CSR_SEPC
>  	csrr  s1, CSR_SSTATUS
>  	csrr  s2, CSR_SCAUSE
> +	csrr  s3, CSR_STVAL
>  	sd    s0, 248(sp)
>  	sd    s1, 256(sp)
>  	sd    s2, 264(sp)
> +	sd    s3, 272(sp)

We can't add stval without also changing how much stack we allocate at the
top of this macro, but since we need to keep sp 16-byte aligned in order
to call C code (route_exception()) we'll need to decrement -8*36, not
-8*35. Or, we could just switch struct ex_regs to be the kernel's struct
pt_regs which has 36 unsigned longs. The 'badaddr' member is for stval and
the additional long is orig_a0.

>  .endm
>  
>  .macro restore_context

I guess we should restore stval too.

Thanks,
drew

> 
> -- 
> 2.43.0
> 
> 
> -- 
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv

