Return-Path: <linux-kernel+bounces-880076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB791C24CF4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9CD642025E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E511346796;
	Fri, 31 Oct 2025 11:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t9EEJv51"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2D032ABDB
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761910632; cv=none; b=aqtdWngaHp4hIShYEokzXSp+hKemWpHnb0KnS1EEPcHcGfjVmO6gn06YjBJPcG8W/Jh/xkyOJPOkQXIFUa9uGR3iHujp+yHexnHcLNKsltnQSXHSRoH4Zkwu51vhyT0TbIrlCaqXgREC834US8QAbE/R93BvqdP6B6swOme1m2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761910632; c=relaxed/simple;
	bh=b9hOx9bbMTHGqCo+KZl35DUQeFrmASN/Vli882wjP+Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E8ZDEq4pQe7UsYcoT2AXzQRjz+hliFa4oKJK70f0dEyz4lhXBRopB15UaWkivM1vo9JQY1gktWHqjW14XRmj5lgivpjn6BJswPlEjATzWTnI5w7wMpu4zqUuCdUh+K7UjFjEWBVJ84tr7Th3dmDrMECAl9/vp2FynjT+UHQkeKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t9EEJv51; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-477124f7c00so12316355e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761910629; x=1762515429; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eSeAaB+reCzUqLEz535KqqYFPha39z1XYyNrGH461U8=;
        b=t9EEJv51xv7+iOFxSCE0XfYHQlSdVPnQgJr2rVj7Pd/f8wFNPExiR5GswBIOAOfZ9F
         SAKQ9DgqCKqb1/6Z81qZZcuhm+QIrjmComZFR9grBnNeyz53dvX03we1uij2+aNOSX/U
         JNFacc+vT6KFpbAV0YKuBBemvBW2Uf5xaS4QPpITNEuIaFWBWXWR4fqTDWG5k7oeSTVH
         RLfxMFU38WZbx6Kgo/tRA2N7OxzSUl+/GbwEZkjJeSaeEJKK/qAb6sHWL5LSjyGJKotN
         RbVN7VEFC2aPkJTVuE3Buk0g2knM41MzXrqv3+S9ZNRVpxDh1GC/LD8GGzTPDqeiiANu
         shdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761910629; x=1762515429;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eSeAaB+reCzUqLEz535KqqYFPha39z1XYyNrGH461U8=;
        b=ZEN1896yKEDtitBcEr6b5NGjXZCbcXR8CcrCDlKoiQ2BALbpWPyV4IRWQPUFuXABBM
         0oK7BtObMUKltWv6HFjr04hJJgIVPuejH5s5uUdfVTrcFTPlzS7xaGGv1lDSWqLPQiZf
         9J7beBZwpzBRVvKKXmBIW62a/4NhA1B/w8oRYlXDSeSets5CFCRvICqoyoJylP9CU+te
         +ULwfYO+6VGrq5msrPuVTTsT3DQXfidRcR5gxAxuaE2GTHS0wMvjIM5wcG7e1VRkxVzr
         oQBXAuvUrrSNUAFwr7EM5EjGuOwDhaHnbu4GOkHSjR5K2KcrQH/0il8jjQ0B/RPj/6JK
         97cg==
X-Forwarded-Encrypted: i=1; AJvYcCXiD8qPBe43CTp7Voxnx6RGIw/Y2d0jxSk72vpi1/HK4fC0nLlWx4/qaVD4Ms8c00wyKQTl+pJ+FEptoXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOWzUqPedvuR7/VY0O20Rwd6LCj0kNsMkVMFkumvSJPRkCaP3B
	GL3kTvIlNHoV5Au2WaYP6UmZkEhWKs0j/WaOZHEbGb+8HNmMvwBqYaouWE58F3z3+lRHtAP9JLE
	3vE55AqTDKk/t5Q==
X-Google-Smtp-Source: AGHT+IH3q2msESLIXku56gOgSX7w7vxpimVKvAA5rKp0lFFIMd4G+rmyMp8FMWkYqa0L9DddFTF2IxRw3vicJw==
X-Received: from wmaw2.prod.google.com ([2002:a05:600c:6d42:b0:475:e0a3:4679])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:468e:b0:458:a7fa:211d with SMTP id 5b1f17b1804b1-477308b2222mr29693175e9.29.1761910629010;
 Fri, 31 Oct 2025 04:37:09 -0700 (PDT)
Date: Fri, 31 Oct 2025 11:37:08 +0000
In-Reply-To: <20251031003040.3491385-3-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251031003040.3491385-1-seanjc@google.com> <20251031003040.3491385-3-seanjc@google.com>
X-Mailer: aerc 0.21.0
Message-ID: <DDWH6WN6G64S.22FTEH7M615YJ@google.com>
Subject: Re: [PATCH v4 2/8] x86/bugs: Decouple ALTERNATIVE usage from VERW
 macro definition
From: Brendan Jackman <jackmanb@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"

On Fri Oct 31, 2025 at 12:30 AM UTC, Sean Christopherson wrote:
> Decouple the use of ALTERNATIVE from the encoding of VERW to clear CPU
> buffers so that KVM can use ALTERNATIVE_2 to handle "always clear buffers"
> and "clear if guest can access host MMIO" in a single statement.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/include/asm/nospec-branch.h | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> index 08ed5a2e46a5..923ae21cbef1 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -308,24 +308,23 @@
>   * CFLAGS.ZF.
>   * Note: Only the memory operand variant of VERW clears the CPU buffers.
>   */
> -.macro __CLEAR_CPU_BUFFERS feature
>  #ifdef CONFIG_X86_64
> -	ALTERNATIVE "", "verw x86_verw_sel(%rip)", \feature
> +#define CLEAR_CPU_BUFFERS_SEQ	verw x86_verw_sel(%rip)
>  #else
> -	/*
> -	 * In 32bit mode, the memory operand must be a %cs reference. The data
> -	 * segments may not be usable (vm86 mode), and the stack segment may not
> -	 * be flat (ESPFIX32).
> -	 */
> -	ALTERNATIVE "", "verw %cs:x86_verw_sel", \feature
> +/*
> + * In 32bit mode, the memory operand must be a %cs reference. The data segments
> + * may not be usable (vm86 mode), and the stack segment may not be flat (ESPFIX32).
> + */
> +#define CLEAR_CPU_BUFFERS_SEQ	verw %cs:x86_verw_sel
>  #endif
> -.endm
> +
> +#define __CLEAR_CPU_BUFFERS	__stringify(CLEAR_CPU_BUFFERS_SEQ)

Maybe CLEAR_CPU_BUFFERS_SEQ should just be defined as a string in the
first place? But meh, that's a very bikeshed comment. I can see the
aeshetic appeal of the separate __stringify().

Reviewed-by: Brendan Jackman <jackmanb@google.com>

>  
>  #define CLEAR_CPU_BUFFERS \
> -	__CLEAR_CPU_BUFFERS X86_FEATURE_CLEAR_CPU_BUF
> +	ALTERNATIVE "", __CLEAR_CPU_BUFFERS, X86_FEATURE_CLEAR_CPU_BUF
>  
>  #define VM_CLEAR_CPU_BUFFERS \
> -	__CLEAR_CPU_BUFFERS X86_FEATURE_CLEAR_CPU_BUF_VM
> +	ALTERNATIVE "", __CLEAR_CPU_BUFFERS, X86_FEATURE_CLEAR_CPU_BUF_VM
>  
>  #ifdef CONFIG_X86_64
>  .macro CLEAR_BRANCH_HISTORY


