Return-Path: <linux-kernel+bounces-835434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 286E0BA7153
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 15:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E17E18959B8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 13:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F651E9B1A;
	Sun, 28 Sep 2025 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKjQnmZj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBDA17597
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 13:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759067912; cv=none; b=aJtITBbS5XOJXV/DNr5nvdymqL2pwPaETo9vR0r7X3W6MExScpqAnofNjNA90G5pX1ElUa0EU8RMriA5sC50AFnTsURdfiG1gwSdkZ49KibkHX/K5PHPe6ipvTNNT8H2dDE/B4UQGX4UUoOe/Ftijz6GL8l2kv3nWKYcz1UW/Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759067912; c=relaxed/simple;
	bh=RrHTkPkJ9KxjQHnavmnJvqPxNotZNOveUTg85TUYacM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owr7Fwn+7YaDbjLFIY9URYr+0oF4Lj+TB2izauHKP1n3XM/FGLmzHQspvdfa7js+xei8zoRt91eNPwcILhzmJkLTwmtN2EEzg6vWZ4XAjQy6d2ERUzaq1+35EbCI/myLrJPUFPUhf0p+VqRW2blt7SNrXFdnJoxMoTkNSAZLXKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKjQnmZj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C6BC4CEF0
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 13:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759067911;
	bh=RrHTkPkJ9KxjQHnavmnJvqPxNotZNOveUTg85TUYacM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PKjQnmZj3fCkD3MWVEG+KERvYDGC5glGHO5U1iSEA8SLxZj4YKcoVQLfDwqnsgTGb
	 g7UEVDkkFdDZOAh3da7i9zwLZR0i+8PCoiwFZaBmyUL8XHWQ0WpvZZ77plpxN23DrL
	 SIlDsh9wDdg2uBb981l5OyAdwB9g0ywpKYQXRDxRHcxC6luVM3k7CznTicX1dTIT/b
	 wNzKpZCCxvSedYJzhl0x/E8eIbUR7J5ivVthMZO6g29i9+3+7ij5qNczxwxvuBUNyx
	 8G/eQ8suDiawrmCETdsGi6ivSTdMJZDOPn1+kbWMgvlpPgcTknHlCV0P8xLB8G729k
	 9JeixuPDo5dwQ==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-631787faf35so7546681a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 06:58:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV0qRlyV4AKvbCxbleoJIBAnxj4hAY6Q8kXaO+hlnhZ/Esv76Y7vslorQ6xWKFY7pfY3lww+Ki9iuBk2zM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzicakHwtpAMpwywhY9cL20s/MIdvxXIdbmchPeAO750trzd7WG
	VE+xDNUNmOnOmBMb5NUjM9ZyY04rLHJ56W3GP9LfAW3wZ5m0zgzlKzEKGgRpGJFN+bqotDpWC3m
	GTwoXX270mW3+xsYFMAT7Hk11oh04btc=
X-Google-Smtp-Source: AGHT+IGvCaXEaCCGJHQTjwko5ijQWG9wboug0FNJB/iFsDT+joLcDSwsGEgrpDHptK2NwMwDEBf4VrRUfqQe1ZGaJD8=
X-Received: by 2002:a17:906:c141:b0:b04:5895:fe8e with SMTP id
 a640c23a62f3a-b34bb9e9b51mr1496780366b.36.1759067910449; Sun, 28 Sep 2025
 06:58:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925092902.1366058-1-guanwentao@uniontech.com>
In-Reply-To: <20250925092902.1366058-1-guanwentao@uniontech.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 28 Sep 2025 21:58:10 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5ny_e9G5qRUMYW-d5LqjXv8rvsGMz9BQPt6+npyPmCOA@mail.gmail.com>
X-Gm-Features: AS18NWC547i7JUcuDNSIYAe0E_ay43qn0jlubReLFKEmkn6ebN_O807Utlh1SZ8
Message-ID: <CAAhV-H5ny_e9G5qRUMYW-d5LqjXv8rvsGMz9BQPt6+npyPmCOA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: mm: try VMA lock-based page fault handling first
To: Wentao Guan <guanwentao@uniontech.com>
Cc: kernel@xen0n.name, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	zhanjun@uniontech.com, niecheng1@uniontech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Wentao,

Thanks for you patch, but it is full of bugs...

On Thu, Sep 25, 2025 at 5:33=E2=80=AFPM Wentao Guan <guanwentao@uniontech.c=
om> wrote:
>
> Attempt VMA lock-based page fault handling first, and fall back to the
> existing mmap_lock-based handling if that fails.
>
> The "ebizzy -mTRp" on 3A6000 shows that PER_VMA_LOCK can
> improve the benchmark by about 20.7%.
>
> This is the loongarch variant of "x86/mm: try VMA lock-based page fault
> handling first".
>
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> ---
> ebizzy-0.3(can download by phoronix-test-suite):
> before patch:
> 97800 records/s
> real 10.00 s user  0.25 s sys  13.54 s
> 97835 records/s
> real 10.00 s user  0.27 s sys  13.51 s
> 97929 records/s
> real 10.00 s user  0.26 s sys  13.53 s
> 97736 records/s
> real 10.00 s user  0.31 s sys  13.48 s
> 97914 records/s
> real 10.00 s user  0.30 s sys  13.50 s
> 97916 records/s
> real 10.00 s user  0.31 s sys  13.48 s
> 97857 records/s
> real 10.00 s user  0.28 s sys  13.51 s
> 97927 records/s
> real 10.00 s user  0.24 s sys  13.55 s
> 97962 records/s
> real 10.00 s user  0.41 s sys  13.39 s
> 97501 records/s
> real 10.00 s user  0.20 s sys  13.53 s
> after patch:
> 117645 records/s
> real 10.00 s user  0.31 s sys  23.17 s
> 118207 records/s
> real 10.00 s user  0.37 s sys  23.18 s
> 118426 records/s
> real 10.00 s user  0.32 s sys  23.14 s
> 118172 records/s
> real 10.00 s user  0.44 s sys  23.07 s
> 118548 records/s
> real 10.00 s user  0.45 s sys  23.04 s
> 118011 records/s
> real 10.00 s user  0.32 s sys  23.15 s
> 118143 records/s
> real 10.00 s user  0.41 s sys  23.09 s
> 118181 records/s
> real 10.00 s user  0.42 s sys  23.12 s
> 117721 records/s
> real 10.00 s user  0.34 s sys  23.17 s
> 118138 records/s
> real 10.00 s user  0.42 s sys  23.04 s
> ---
> ---
>  arch/loongarch/Kconfig    |  1 +
>  arch/loongarch/mm/fault.c | 49 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 0631a6b11281b..1c517954157c0 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -69,6 +69,7 @@ config LOONGARCH
>         select ARCH_SUPPORTS_LTO_CLANG_THIN
>         select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
>         select ARCH_SUPPORTS_NUMA_BALANCING
> +       select ARCH_SUPPORTS_PER_VMA_LOCK
>         select ARCH_SUPPORTS_RT
>         select ARCH_USE_BUILTIN_BSWAP
>         select ARCH_USE_CMPXCHG_LOCKREF
> diff --git a/arch/loongarch/mm/fault.c b/arch/loongarch/mm/fault.c
> index deefd9617d008..d2dc3e194dd76 100644
> --- a/arch/loongarch/mm/fault.c
> +++ b/arch/loongarch/mm/fault.c
> @@ -215,6 +215,53 @@ static void __kprobes __do_page_fault(struct pt_regs=
 *regs,
>                 flags |=3D FAULT_FLAG_USER;
>
>         perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
> +       if (!(flags & FAULT_FLAG_USER))
> +               goto lock_mmap;
> +
> +       vma =3D lock_vma_under_rcu(mm, address);
> +       if (!vma)
> +               goto lock_mmap;
> +
> +       if (write) {
> +               flags |=3D FAULT_FLAG_WRITE;
> +               if (!(vma->vm_flags & VM_WRITE)) {
> +                       vma_end_read(vma);
> +                       si_code =3D SEGV_ACCERR;
Need count_vm_vma_lock_event(VMA_LOCK_SUCCESS) here.

> +                       goto bad_area_nosemaphore;
> +               }
> +       } else {
> +               if (!(vma->vm_flags & VM_EXEC) && address =3D=3D exceptio=
n_era(regs)){
> +                       vma_end_read(vma);
> +                       si_code =3D SEGV_ACCERR;
The same.

> +                       goto bad_area_nosemaphore;
> +               }
> +               if (!(vma->vm_flags & (VM_READ | VM_WRITE)) && address !=
=3D exception_era(regs)){
> +                       vma_end_read(vma);
> +                       si_code =3D SEGV_ACCERR;
The same.

> +                       goto bad_area_nosemaphore;
> +               }
> +       }
> +
> +       fault =3D handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LO=
CK, regs);
> +       if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
> +               vma_end_read(vma);
> +
> +       if (!(fault & VM_FAULT_RETRY)) {
> +               count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
> +               goto done;
> +       }
> +       count_vm_vma_lock_event(VMA_LOCK_RETRY);
> +       if (fault & VM_FAULT_MAJOR)
> +               flags |=3D FAULT_FLAG_TRIED;
> +
> +       /* Quick path to respond to signals */
> +       if (fault_signal_pending(fault, regs)) {
> +               if (!user_mode(regs))
> +                       no_context(regs, write, address);
> +               return;
> +       }
> +lock_mmap:
lock_mmap is exactly the same as retry, but since other architectures
are also like this, let's keep it as is...

> +
>  retry:
>         vma =3D lock_mm_and_find_vma(mm, address, regs);
>         if (unlikely(!vma))
> @@ -292,6 +339,8 @@ static void __kprobes __do_page_fault(struct pt_regs =
*regs,
>         }
>
>         mmap_read_unlock(mm);
> +done:
We need error handling here.

> +       return;
>  }
>
>  asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
I think the whole correct patch is like this:
diff --git a/arch/loongarch/mm/fault.c b/arch/loongarch/mm/fault.c
index deefd9617d00..c87e7d38090d 100644
--- a/arch/loongarch/mm/fault.c
+++ b/arch/loongarch/mm/fault.c
@@ -215,6 +215,58 @@ static void __kprobes __do_page_fault(struct pt_regs *=
regs,
                flags |=3D FAULT_FLAG_USER;

        perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
+
+       if (!(flags & FAULT_FLAG_USER))
+               goto lock_mmap;
+
+       vma =3D lock_vma_under_rcu(mm, address);
+       if (!vma)
+               goto lock_mmap;
+
+       if (write) {
+               flags |=3D FAULT_FLAG_WRITE;
+               if (!(vma->vm_flags & VM_WRITE)) {
+                       vma_end_read(vma);
+                       si_code =3D SEGV_ACCERR;
+                       count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
+                       goto bad_area_nosemaphore;
+               }
+       } else {
+               if (!(vma->vm_flags & VM_EXEC) && address =3D=3D
exception_era(regs)){
+                       vma_end_read(vma);
+                       si_code =3D SEGV_ACCERR;
+                       count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
+                       goto bad_area_nosemaphore;
+               }
+               if (!(vma->vm_flags & (VM_READ | VM_WRITE)) && address
!=3D exception_era(regs)){
+                       vma_end_read(vma);
+                       si_code =3D SEGV_ACCERR;
+                       count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
+                       goto bad_area_nosemaphore;
+               }
+       }
+
+       fault =3D handle_mm_fault(vma, address, flags |
FAULT_FLAG_VMA_LOCK, regs);
+       if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
+               vma_end_read(vma);
+
+       if (!(fault & VM_FAULT_RETRY)) {
+               count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
+               goto done;
+       }
+
+       count_vm_vma_lock_event(VMA_LOCK_RETRY);
+       if (fault & VM_FAULT_MAJOR)
+               flags |=3D FAULT_FLAG_TRIED;
+
+       /* Quick path to respond to signals */
+       if (fault_signal_pending(fault, regs)) {
+               if (!user_mode(regs))
+                       no_context(regs, write, address);
+               return;
+       }
+lock_mmap:
+
 retry:
        vma =3D lock_mm_and_find_vma(mm, address, regs);
        if (unlikely(!vma))
@@ -276,8 +328,10 @@ static void __kprobes __do_page_fault(struct pt_regs *=
regs,
                 */
                goto retry;
        }
+       mmap_read_unlock(mm);
+
+done:
        if (unlikely(fault & VM_FAULT_ERROR)) {
-               mmap_read_unlock(mm);
                if (fault & VM_FAULT_OOM) {
                        do_out_of_memory(regs, write, address);
                        return;
@@ -290,8 +344,6 @@ static void __kprobes __do_page_fault(struct pt_regs *r=
egs,
                }
                BUG();
        }
-
-       mmap_read_unlock(mm);
 }

 asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,

Huacai

> --
> 2.20.1
>

