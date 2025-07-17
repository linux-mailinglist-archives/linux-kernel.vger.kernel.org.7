Return-Path: <linux-kernel+bounces-734674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E42F0B084AB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22E504A805C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79862080E8;
	Thu, 17 Jul 2025 06:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="POSIvSUp"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97037206F23
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752732750; cv=none; b=hWQQIoGPjPoujCNvvfY4Nc3ywTLVFHjNvrRNTizRORuqGOxF1a7HNLIN/k/n7TjwtYmZgTAulh/EM1LELxe1vqgHcX+Ewib2MawzU/EKm+dVoxYZXLznK57jzSLJWuoLLKq6pXIGNBvuMFWqDrTVV37JgMiFpQAMg3mcnQ6zhbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752732750; c=relaxed/simple;
	bh=YIN35DRD/aoz21n489sIa+7GtdG3TmvZGAd7pBytAGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dqMk7S/Tsh1ERswY7ylVgVsLaQxCbzMuuf16pWfc+5Cwd2/OTOr7zlj355Yxmg3AlNk16FYtv7wlNJQra13/4mLqQCNFOt9QYa+zgKDY31PsWF2ni4k16/o558S3CpF97DqQtDI1aoTAO2or7quUTicCU2FMp2M+UGvTLT8so74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=POSIvSUp; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-876231b81d5so45712739f.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 23:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1752732748; x=1753337548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uee3oli5059CdqjZMZ5JHaAC2Fn9BWMJg270zgvkJfM=;
        b=POSIvSUp3l5h4Leq2yJJJTgh97mR+l74y8VWWbBefPwRQ6fxAEUs2DXqBflxE/Orup
         VliZjA5vPauaDf+nBHP+YCMaRvuCiFJkk4m4bnfdgpu4YO7Ik1JsJfdOsC5uC3c04RDM
         OpoTqNTHrY6Edu4pGpi2L8Oz7G7sAW5RmmZH/Abps18K+QloRhPh0SWwjZQFQor6tj2l
         m2VybY6sHd6JINUQkFHRhdjBZ3w8BYk/xtfGaDP7WUs+PFAIdu296tcEoKj24Fb+5FeA
         s9kz0fLkicEVkXr/PTH4cnME0iY/ly+WvGsMz6cH4Q2WwO02YGkuhx5MgPYy9WhdnC1s
         X1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752732748; x=1753337548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uee3oli5059CdqjZMZ5JHaAC2Fn9BWMJg270zgvkJfM=;
        b=oFYUMhp1DBf2trG+iua30fcj6hVJ2AfT4dsdNj5UkJ52q90PLSGpgrAYh3fvGQZ3gS
         txAXOPw3XqLZEdG6VfsXOnDB2MOW+tJEHb3x9Vtr/ezHnU8kS/Yhe2D76p8EuN+jTo2a
         2jlJwnIFvDkvN7RI9arBYvjXok8QLtYg98veBWrZM86FlY5vyk+tkcZpGswHcwdihxIN
         Ihoe9pUoP+yQe7EK5OaiNXNBEttELJcPFzbfRujkdmob0NGI2Gxrg6S65SDh95fWVtRm
         v9dOobaavwQGSdXYF0dBAUerDZQbIVJS8f0wzLpnvpgagXThdu3Tc0r5br11aMo4dUdo
         unjA==
X-Forwarded-Encrypted: i=1; AJvYcCVRriCaqDv0x+q+YnfxtvSg/9aa8r+7kTKgAQ/Nqa5XKVg58vxlkE+iNmlzWWtPMxv7YEAlhHSVktkksmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK4RFfpkGqCtajqHsoGdYuiP5R12mHCNugZ0xYJ9roob7k2HdW
	+TxUZSQeE64MwiBFEqziPuEhZNUJvZhWhMFpp9Pic/co//wLL372bgGvo4FM+wiS2+63M/d7W5r
	ZA772sUXkYhj+pq2y/GOL14LzIbyZ98Qq9n+RezLMfNEAOiySkl9P
X-Gm-Gg: ASbGnct7KgQhzChKxeQceQ98DZtMpNrjGQa0rNSTU+Ayb+bK6P+rUPRJy2cjf4U+qg9
	Ng0Y4NAeGqKaGokfB5pfVtKHDGah15tQRpQ2oWtEwAF1dJaAApRNV63ZBHKWk/VnhQjWfjaORDk
	VwZvt4vbPbhtWll5eErTHunyp5+aIzMV7BfFk0dRkUa99FS2XOAgiLfECUXNdbc+UUuEzN+Kdqh
	EzvqA==
X-Google-Smtp-Source: AGHT+IH8xcNIaMtG75XYnMN8W4vb5d0fFUQvseJHaY/XTWiJuHa1nEHEzpAjdB6OHrz4d8cQ5sLqYX8b9sjCFjfim50=
X-Received: by 2002:a05:6602:2d95:b0:875:b7b6:ae55 with SMTP id
 ca18e2360f4ac-879c08a1821mr619706139f.5.1752732747574; Wed, 16 Jul 2025
 23:12:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749810735.git.zhouquan@iscas.ac.cn> <7e8f1272337e8d03851fd3bb7f6fc739e604309e.1749810736.git.zhouquan@iscas.ac.cn>
In-Reply-To: <7e8f1272337e8d03851fd3bb7f6fc739e604309e.1749810736.git.zhouquan@iscas.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 17 Jul 2025 11:42:16 +0530
X-Gm-Features: Ac12FXxFyh1m_BsXZWN_jEHg_S_aVC3xq_tjAkTkzVkv4CVtzyvdpf1MklQXrzM
Message-ID: <CAAhSdy3aj_x02cpgxZDfn7tNu5HRfKA8VSZHpE1xJpY_2fABUw@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: riscv: selftests: Add common supported test cases
To: zhouquan@iscas.ac.cn
Cc: ajones@ventanamicro.com, atishp@atishpatra.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 5:08=E2=80=AFPM <zhouquan@iscas.ac.cn> wrote:
>
> From: Quan Zhou <zhouquan@iscas.ac.cn>
>
> Some common KVM test cases are supported on riscv now as following:
>
>     access_tracking_perf_test
>     demand_paging_test
>     dirty_log_perf_test
>     dirty_log_test
>     guest_print_test
>     kvm_binary_stats_test
>     kvm_create_max_vcpus
>     kvm_page_table_test
>     memslot_modification_stress_test
>     memslot_perf_test
>     rseq_test
>     set_memory_region_test
>
> Add missing headers for tests and fix RISCV_FENCE redefinition
> in `rseq-riscv.h` by using the existing macro from <asm/fence.h>.
>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>

Please address Drew's comments and send v2 of only this patch.
The first patch of this series is already queued.

Regards,
Anup

> ---
>  tools/testing/selftests/kvm/Makefile.kvm             | 12 ++++++++++++
>  .../testing/selftests/kvm/include/riscv/processor.h  |  2 ++
>  tools/testing/selftests/rseq/rseq-riscv.h            |  3 +--
>  3 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/sel=
ftests/kvm/Makefile.kvm
> index 38b95998e1e6..565e191e99c8 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -197,6 +197,18 @@ TEST_GEN_PROGS_riscv +=3D arch_timer
>  TEST_GEN_PROGS_riscv +=3D coalesced_io_test
>  TEST_GEN_PROGS_riscv +=3D get-reg-list
>  TEST_GEN_PROGS_riscv +=3D steal_time
> +TEST_GEN_PROGS_riscv +=3D access_tracking_perf_test
> +TEST_GEN_PROGS_riscv +=3D demand_paging_test
> +TEST_GEN_PROGS_riscv +=3D dirty_log_perf_test
> +TEST_GEN_PROGS_riscv +=3D dirty_log_test
> +TEST_GEN_PROGS_riscv +=3D guest_print_test
> +TEST_GEN_PROGS_riscv +=3D kvm_binary_stats_test
> +TEST_GEN_PROGS_riscv +=3D kvm_create_max_vcpus
> +TEST_GEN_PROGS_riscv +=3D kvm_page_table_test
> +TEST_GEN_PROGS_riscv +=3D memslot_modification_stress_test
> +TEST_GEN_PROGS_riscv +=3D memslot_perf_test
> +TEST_GEN_PROGS_riscv +=3D rseq_test
> +TEST_GEN_PROGS_riscv +=3D set_memory_region_test
>
>  TEST_GEN_PROGS_loongarch +=3D coalesced_io_test
>  TEST_GEN_PROGS_loongarch +=3D demand_paging_test
> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tool=
s/testing/selftests/kvm/include/riscv/processor.h
> index 162f303d9daa..4cf5ae11760f 100644
> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> @@ -9,7 +9,9 @@
>
>  #include <linux/stringify.h>
>  #include <asm/csr.h>
> +#include <asm/vdso/processor.h>
>  #include "kvm_util.h"
> +#include "ucall_common.h"
>
>  #define INSN_OPCODE_MASK       0x007c
>  #define INSN_OPCODE_SHIFT      2
> diff --git a/tools/testing/selftests/rseq/rseq-riscv.h b/tools/testing/se=
lftests/rseq/rseq-riscv.h
> index 67d544aaa9a3..06c840e81c8b 100644
> --- a/tools/testing/selftests/rseq/rseq-riscv.h
> +++ b/tools/testing/selftests/rseq/rseq-riscv.h
> @@ -8,6 +8,7 @@
>   * exception when executed in all modes.
>   */
>  #include <endian.h>
> +#include <asm/fence.h>
>
>  #if defined(__BYTE_ORDER) ? (__BYTE_ORDER =3D=3D __LITTLE_ENDIAN) : defi=
ned(__LITTLE_ENDIAN)
>  #define RSEQ_SIG   0xf1401073  /* csrr mhartid, x0 */
> @@ -24,8 +25,6 @@
>  #define REG_L  __REG_SEL("ld ", "lw ")
>  #define REG_S  __REG_SEL("sd ", "sw ")
>
> -#define RISCV_FENCE(p, s) \
> -       __asm__ __volatile__ ("fence " #p "," #s : : : "memory")
>  #define rseq_smp_mb()  RISCV_FENCE(rw, rw)
>  #define rseq_smp_rmb() RISCV_FENCE(r, r)
>  #define rseq_smp_wmb() RISCV_FENCE(w, w)
> --
> 2.34.1
>

