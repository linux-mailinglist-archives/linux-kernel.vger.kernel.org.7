Return-Path: <linux-kernel+bounces-866019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE4EBFE9C9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 01:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729FC19A0895
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 23:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D5C2C0F6C;
	Wed, 22 Oct 2025 23:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LDY4Y5G1"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F892749E6
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 23:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177220; cv=none; b=RWQdraxW3u5msO6MC6hYiV9Ar7zSORROrNmcGkt+TtA6IY9ukEekIxufJTYAeErAvfEo7nsCLW93TKBxtc4pfpBgyyLL47m9cdx74xx85rQOPID2IsX37gbd1ao1lIDBbn67Y4o2ZDE2USvOxylo6oF42SOGfOwo2HDJLmEGH/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177220; c=relaxed/simple;
	bh=dXGJg55z319BaRh8eIcvDWHKkFigImfGEQ+PW6DNC2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QcqYrPdkBNHYFSEJDGgoU8Z2kIRBPlfYfiNooh/zkNcnZB7RubM/FcfEIp0V1fWM4MhMtE7qj0LCvwXUDE9phd7HwKQ/9IYpvUd9zuAGYWau68PcZLN+1eUpwMDp6omgwBoF/iksCD/ONqLSEpu1VPV//evNegyGPZXUqNeb4go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LDY4Y5G1; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-290d48e9f1fso54015ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761177218; x=1761782018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Obj7jZG40UIPnvQc/KbD4aeaaOQUqRSXMKvdt/p0pk=;
        b=LDY4Y5G1oIakxWqsVh+9r8bTgn4yGdEon7gMw4cbeG3VLxXTrO1cc/gjeuO+uechsO
         bRLFs1a0j9k1c8SRuhPMhEpD90lpUKzIif43LO0HCfLdwQf99HtAVn5/ZsXzHh2X1IFa
         mmKJLdlp2FCvVlvdvzDje46LdQdA6X8dJWjwXSkHkLtfAm/+S1oFiTbvMS2qfLKFpYZA
         XVwBSGU+5rtiZQUUTYStyYi6g/LxlgqVHNEBGo8rDqLLlng0IrIOR2vUg7raZjar1u1l
         OvNXt5N+hbDshDHTsQJq/hYCoag2mNGby/CegBcomlObbNAOMmLF649/fkTQomDwtDvw
         u+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761177218; x=1761782018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Obj7jZG40UIPnvQc/KbD4aeaaOQUqRSXMKvdt/p0pk=;
        b=HCaH23nq0DrTyQPol9FHkUVFSEaFLArdZ7ASBF7EWSkMCaOYB59omJBUfhHnVbpJUX
         KAI6cEozl2JoZY6pGPZ63cw/LehpEPx8c7UbCIEJmvZ30ohf4x3deqrMjO2c27K32/Ph
         hJl0+PoqKXxFUljZ3tKdBkS8CRy/G2uJ9Up6QKQucGKCQFBLf+NgXyBRIsCUZ/z9st4u
         ntXgSKP32ZBiVpalhD8jQcP32j8YQISg2USoHh5RVZwAf8OjtMCnYT10zHIqVrAIevOV
         wGFsDHRP8iIgMrua16nzo4R4w52xdEEC1gSVWHSQSOdUKaftchDIo3WV0BcchwcsgRvm
         wrKw==
X-Forwarded-Encrypted: i=1; AJvYcCV4cTliyH6EcUQV75TNNPsOWiuLz4uWsF3jYRg+DUB6qOXKPFSKZMvrjKCNtqQ12c9tQZ7DvbqCFUBWntY=@vger.kernel.org
X-Gm-Message-State: AOJu0YysIUVCszaZ0iQ/Av9gkRAiDz5NX2L0fLdJl80E+9ddqV3hcOP7
	g/sN3HewRKWROTtlQNyNbQk7H7Ewo0FxkeyEyZTiZAIb7ePv3LpufAmkqEClLPXqzbfPUlociuK
	XaBoACkFulx6/cskBBRiZKoa0YJczUJ36AyIlUPVq
X-Gm-Gg: ASbGnctIzsTFjrl2IO4NiNuZHSGABqPH13mCBF226YVk2EM8kWX9x4zCL7ojFdaVkA9
	ZAxd0+ZuDluhCdMqNM5s75n/hecKSxjCHD+HyxT9HVJuq6q9DkC8ZO2iUG1Kzh2fiPIT6j32/0S
	3yMno930b5rT4bsA87vfRzSoYVasw+j6ubBRcAaJAS8cQSmjAlHt9nNeQ2y0ocdIyH0HQnHsfEM
	qHxpRRID5u+emPVrbE6RvYmCKHGz5ugt5Ko1zHdvPyQ9p0TBibSEGeKr/gX8BOkU+U+
X-Google-Smtp-Source: AGHT+IFNPTwEDxtRk5uZyv09/FDmi3+zRyMJQdocUYvH7ZYfTsZM6sefaV9+uPsqQ0QJzkWD3cR3a5k6W1Em95CqZm0=
X-Received: by 2002:a17:903:18e:b0:292:b6a0:80df with SMTP id
 d9443c01a7336-29469cc35dbmr2247785ad.10.1761177217352; Wed, 22 Oct 2025
 16:53:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013-x86-fix-clear_page-cfi-full-lto-errors-v1-1-d69534c0be61@kernel.org>
In-Reply-To: <20251013-x86-fix-clear_page-cfi-full-lto-errors-v1-1-d69534c0be61@kernel.org>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 22 Oct 2025 16:53:00 -0700
X-Gm-Features: AS18NWAtS6OPxJw_IdyJfidxnXUpDl59IPZyOYj6RjHP9Gf5hzvEO4B2w_JxTT0
Message-ID: <CABCJKucLzfs99ssROzj4pt_1jy860vkJutqS-CCo=LW-PwnmqA@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Ensure clear_page() variants always have
 __kcfi_typeid_ symbols
To: Nathan Chancellor <nathan@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nathan,

On Mon, Oct 13, 2025 at 2:27=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> When building with CONFIG_CFI=3Dy and CONFIG_LTO_CLANG_FULL=3Dy, there is=
 a
> series of errors from the various versions of clear_page() not having
> __kcfi_typeid_ symbols.
>
>   $ cat kernel/configs/repro.config
>   CONFIG_CFI=3Dy
>   # CONFIG_LTO_NONE is not set
>   CONFIG_LTO_CLANG_FULL=3Dy
>
>   $ make -skj"$(nproc)" ARCH=3Dx86_64 LLVM=3D1 clean defconfig repro.conf=
ig bzImage
>   ld.lld: error: undefined symbol: __kcfi_typeid_clear_page_rep
>   >>> referenced by ld-temp.o
>   >>>               vmlinux.o:(__cfi_clear_page_rep)
>
>   ld.lld: error: undefined symbol: __kcfi_typeid_clear_page_orig
>   >>> referenced by ld-temp.o
>   >>>               vmlinux.o:(__cfi_clear_page_orig)
>
>   ld.lld: error: undefined symbol: __kcfi_typeid_clear_page_erms
>   >>> referenced by ld-temp.o
>   >>>               vmlinux.o:(__cfi_clear_page_erms)
>
> With full LTO, it is possible for LLVM to realize that these functions
> never have their address taken (as they are only used within an
> alternative, which will make them a direct call) across the whole kernel
> and either drop or skip generating their kCFI type identification
> symbols.
>
> clear_page_{rep,orig,erms}() are defined in clear_page_64.S with
> SYM_TYPED_FUNC_START as a result of commit 2981557cb040 ("x86,kcfi: Fix
> EXPORT_SYMBOL vs kCFI"), as exported functions are free to be called
> indirectly thus need kCFI type identifiers.
>
> Use KCFI_REFERENCE with these clear_page() functions to force LLVM to
> see these functions as address-taken and generate then keep the kCFI
> type identifiers.
>
> Fixes: 2981557cb040 ("x86,kcfi: Fix EXPORT_SYMBOL vs kCFI")
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2128
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> Alternatively, these functions could move back to SYM_FUNC_START with a
> comment that they need to be exported to be called via the alternative
> in clear_page() but they are never expected to be called indirectly.

Right, this might be a cleaner solution if we don't actually expect
these to be indirectly called.

> ---
>  arch/x86/include/asm/page_64.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_6=
4.h
> index 015d23f3e01f..53f4089333f2 100644
> --- a/arch/x86/include/asm/page_64.h
> +++ b/arch/x86/include/asm/page_64.h
> @@ -43,6 +43,9 @@ extern unsigned long __phys_addr_symbol(unsigned long);
>  void clear_page_orig(void *page);
>  void clear_page_rep(void *page);
>  void clear_page_erms(void *page);
> +KCFI_REFERENCE(clear_page_orig);
> +KCFI_REFERENCE(clear_page_rep);
> +KCFI_REFERENCE(clear_page_erms);

In any case,

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami

