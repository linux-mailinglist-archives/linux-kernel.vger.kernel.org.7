Return-Path: <linux-kernel+bounces-745866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ADBB11FD0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4DEC17C975
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748D21E834F;
	Fri, 25 Jul 2025 14:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="SHsKMy4W"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4F41DFE09
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753452627; cv=none; b=MkAYrfM/XCN8ctqRIzo28ZbWmMD8ixZLRExjQsVbhixQi5Sf8vKxnWcTeUhn9MZstBrLPezS4HMceyA5GhpM0xe3uhoAjCyV3As6g26QBDwd3F5jhc42/kMcuJ2v9HCF8aUwAOQc3JGWLaIqDB8RJ0kfweg6CaICZVEVnehSFA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753452627; c=relaxed/simple;
	bh=XXwJERhTFmbWjCdF0fhV0tx9/bF8PCxbGdYEPIf/O3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5GkfN59dxFSInFriFj/6vir3wXylZUgQ07IwRGnq3qI8D9U136EYehXFmNDtpcKNq8bQxry7shinXNsuVfYpn5qQNVkvnFubn40F8RTRJd6Cp1bSIUAhwgkkb/4LSqRNGymeteMOgSFhF0xfdbnJRdF/nFQObayBpuUcBOeQzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=SHsKMy4W; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7490acf57b9so1565043b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 07:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1753452625; x=1754057425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jf/mOhm/oVbqNLjepUkvAGKUCLK5QqEVSdfRhcGCSHg=;
        b=SHsKMy4WYL1r4bQ+4ZRJdxoomTxGIAq3YxVM+WeUAfmYwSd3UPYPx1ZNnPAXlRJw1+
         7+YSTZeorZqqEpTYk3kZ9wzWE0tLO29169fOStE1chrqaaNpjr28/zaWTjkAWqLDjSJt
         fd3z1GZENrwiM3iLb2OQhpx+N1GTKXMRRTdoVU2ZOm4+/A19LWiOe7C3iyzlRfhvdrqs
         ZwrHUhmvonlh/fbJJQx03R9U4YJ6aQDGygfQSOHmw26rld/b5eOj5M1T/RTh3R+wQG8P
         1obIwJZloKCNiHdVKG/pGEfRSnrjBjKmV9Ed4Ksgq74a7Tyc8fSx9xU+EYlyQrAmUB+V
         gbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753452625; x=1754057425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jf/mOhm/oVbqNLjepUkvAGKUCLK5QqEVSdfRhcGCSHg=;
        b=A5qw6HYQebjtXWD/Es6Kd7xCMeDnKd71BWgKewLGRMElK2fIQ1tgMtMVjlNkSXXD3R
         J2CP7+XA09jYUPVRD/FrFD1aiwQwgMoxVMkdHklk0aOfVzIUft+u+t/OUv53keZ4lhGl
         wztiEUvIzpTe5kSNDA0KC4pbh3RqGnTEz+BNExhIaMqC6jjaPAjt3G0/dcoHkJ+nEk4I
         n4tvKmDNx8Nza1CfJNf4FUwXKt/YbCOZjXKr/1pkdt5cyFYlmH3ou1Pa6WHNPybgWdn/
         HEybcJVa7gB79h0fZ2MQhK2Nnh1jQ04u3LpOmey6xOqY8jruVhDUeZLnczZdMuNlK2+k
         kVfg==
X-Forwarded-Encrypted: i=1; AJvYcCXcJD4lzQwDwRLEmdhmaRgbX3Z2vEcgDfqEJOaShEzPW6ZSpd2YYa5cKaKzEkFjUw3fYhdfdHqkWdY39DE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB0CFnwRBXo9/XFwDzOJsVnhCF4lkkLNW1akBoxzW8AkxEhNx/
	0xtpaqh6K46JwTkMew8VDJfGeiMoyuPpQA9/Y82sKnF8ecXU0CxxK/Z6LM4A9VpKZjE=
X-Gm-Gg: ASbGncuuUE2Z/bUMveymCFkFqRBY2nTk9RuupmtImWf8e9NgJbdvO6HrOBHXrEBh13l
	CugIqdihcM37uSfEgK66PGheipuRMVjivxLqoDzP2rTkojB2mHz+1dt/lSTw29WSa9ULbz+Z9X/
	kjp5S3e4xCji0Ail/4LZjpZLeMcWgNZnEgQJThytyrP3kX6U5hZ9U1WcKRZEpElu8F9sOk1Vfyi
	HFuaKldX6whem4c5q9KtagOJe4g2CqO5FicwetseN0sUY6oo4KzxjTCbAKq35QxeLv1tu4sc+sY
	YjsMthEIUz/Ld5f44t0xlBRkwFGYvmBw2imznrKGXAwTJBhBt1NacpUBYA5Cb597lZeRdA6hB9b
	oT37u4wBtj4+22xAvHpjSAYQTESwneB4wfd/kpi4Dfsc=
X-Google-Smtp-Source: AGHT+IHNN/h9IcORot4a3xhdjrHaAp7ln5/qPNI4g6XxmpxQs89n8kgWy8jMRw30pgwpyInfWpB5eg==
X-Received: by 2002:a05:6a00:1142:b0:749:456:4082 with SMTP id d2e1a72fcca58-76335849218mr3090044b3a.1.1753452625116;
        Fri, 25 Jul 2025 07:10:25 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761b0615d7fsm3945846b3a.105.2025.07.25.07.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 07:10:24 -0700 (PDT)
Date: Fri, 25 Jul 2025 07:10:21 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-mm@kvack.org,
	llvm@lists.linux.dev, rick.p.edgecombe@intel.com,
	broonie@kernel.org, cleger@rivosinc.com, samitolvanen@google.com,
	apatel@ventanamicro.com, ajones@ventanamicro.com,
	conor.dooley@microchip.com, charlie@rivosinc.com,
	samuel.holland@sifive.com, bjorn@rivosinc.com, fweimer@redhat.com,
	jeffreyalaw@gmail.com, andrew@sifive.com, ved@rivosinc.com,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Monk Chiang <monk.chiang@sifive.com>,
	Kito Cheng <kito.cheng@sifive.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH 01/11] riscv: add landing pad for asm routines.
Message-ID: <aIOQTSVNkC1RztDW@debug.ba.rivosinc.com>
References: <20250724-riscv_kcfi-v1-0-04b8fa44c98c@rivosinc.com>
 <20250724-riscv_kcfi-v1-1-04b8fa44c98c@rivosinc.com>
 <2ba0c09d-2783-4dce-a889-06e16abbde61@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2ba0c09d-2783-4dce-a889-06e16abbde61@canonical.com>

On Fri, Jul 25, 2025 at 08:13:29AM +0200, Heinrich Schuchardt wrote:
>On 25.07.25 01:36, Deepak Gupta wrote:
>>SYM_* macros are used to define assembly routines. In this patch series,
>>re-define those macros in risc-v arch specific include file to include
>>a landing pad instruction at the beginning. This is done only when the
>>compiler flag for landing pad is enabled (i.e. __riscv_zicfilp).
>>
>>TODO: Update `lpad 0` with `lpad %lpad_hash(name)` after toolchain
>>support.
>>
>>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>>---
>>  arch/riscv/include/asm/linkage.h | 42 ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 42 insertions(+)
>>
>>diff --git a/arch/riscv/include/asm/linkage.h b/arch/riscv/include/asm/linkage.h
>>index 9e88ba23cd2b..162774b81158 100644
>>--- a/arch/riscv/include/asm/linkage.h
>>+++ b/arch/riscv/include/asm/linkage.h
>>@@ -6,7 +6,49 @@
>>  #ifndef _ASM_RISCV_LINKAGE_H
>>  #define _ASM_RISCV_LINKAGE_H
>>+#ifdef __ASSEMBLY__
>>+#include <asm/assembler.h>
>>+#endif
>>+
>>  #define __ALIGN		.balign 4
>>  #define __ALIGN_STR	".balign 4"
>>+#ifdef __riscv_zicfilp
>>+/*
>>+ * A landing pad instruction is needed at start of asm routines
>>+ * re-define macros for asm routines to have a landing pad at
>>+ * the beginning of function. Currently use label value of 0x1.
>
>Your code below uses label value 0 which disables tag checking. As 
>long as we don't have tool support for calculating function hashes 
>that is an appropriate approach.
>

Yes I made the fix at other place where function prototype was determined
to be static (see `call_on_irq_stack` in entry.S)

In this patch, it wasn't possible.

>%s/Currently use label value of 0x1./Label value 0x0 disables tag checking./
>

Thanks its lingering from earlier. Will fix it.

>Best regards
>
>Heinrich
>
>>+ * Eventually, label should be calculated as a hash over function
>>+ * signature.
>>+ */
>>+#define SYM_FUNC_START(name)				\
>>+	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)	\
>>+	lpad 0;
>>+
>>+#define SYM_FUNC_START_NOALIGN(name)			\
>>+	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE)	\
>>+	lpad 0;
>>+
>>+#define SYM_FUNC_START_LOCAL(name)			\
>>+	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)	\
>>+	lpad 0;
>>+
>>+#define SYM_FUNC_START_LOCAL_NOALIGN(name)		\
>>+	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE)	\
>>+	lpad 0;
>>+
>>+#define SYM_FUNC_START_WEAK(name)			\
>>+	SYM_START(name, SYM_L_WEAK, SYM_A_ALIGN)	\
>>+	lpad 0;
>>+
>>+#define SYM_FUNC_START_WEAK_NOALIGN(name)		\
>>+	SYM_START(name, SYM_L_WEAK, SYM_A_NONE)		\
>>+	lpad 0;
>>+
>>+#define SYM_TYPED_FUNC_START(name)				\
>>+	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)	\
>>+	lpad 0;
>>+
>>+#endif
>>+
>>  #endif /* _ASM_RISCV_LINKAGE_H */
>>
>

