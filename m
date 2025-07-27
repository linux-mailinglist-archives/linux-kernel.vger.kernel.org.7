Return-Path: <linux-kernel+bounces-747107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 210F5B12FBA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 15:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235721898545
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 13:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EDA2116E7;
	Sun, 27 Jul 2025 13:29:53 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEC426ADD
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753622993; cv=none; b=mdNAMXGQeOHSdA7p0JF7HfINHxNC13M9vsk9ACRZbkT3j3bLn8JlaDBvYGhutVc9nBa/ISfzR+8UZ9LkBS6tzDrqz6iO+0Jk+2cMy6OHVWbM3avb0I0lk76q+wSvXxHKjkY+SRaU+PuKRB+KnCkq+jiTW8/iCc6Z9zUqqluAW+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753622993; c=relaxed/simple;
	bh=mA3FrVL5kqLlXP1MOOsWxnpgNBBlmtbrTt27IrS2OKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oz4jBOLI5Rq9oFvIzyM491oFdwiNjLvFbzLtHl+1ZR1QnilVW/qrjUOf8c38eZtTfabdVsonkJn2OHgEmDCC7ZbSuMq9Kig9cz/KMWP532mCdInGqtXJuf7eUFm4xAdh3igu2TpOxlDNjfDSn+0FTOgso5pSGvESi7ZR1IdMsU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8995E43A03;
	Sun, 27 Jul 2025 13:29:38 +0000 (UTC)
Message-ID: <271c2d08-4ebd-45db-a019-f8f04725904d@ghiti.fr>
Date: Sun, 27 Jul 2025 15:29:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] riscv: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 header files
To: Thomas Huth <thuth@redhat.com>, linux-riscv@lists.infradead.org,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Atish Patra <atish.patra@linux.dev>, Anup Patel <anup@brainfault.org>,
 linux-kernel@vger.kernel.org
References: <20250606070952.498274-1-thuth@redhat.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250606070952.498274-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekleegudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhepvedvieehuedtvdevgeetlefghffhtdeihfevvdfgtdeivdevfefhuefhleelueejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpshhtrggtkhhovhgvrhhflhhofidrtghomhdprhgrshhpsggvrhhrhihpihdrtghomhdpghhithhhuhgsrdgtohhmnecukfhppedvrgdtgeemtggvtgdtmegttddvkeemrggvfedvmeefsgekvdemtggtsgdumeeffhdtleemiegugeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtdegmegtvggttdemtgdtvdekmegrvgefvdemfegskedvmegttggsudemfehftdelmeeiugegkedphhgvlhhopeglkffrggeimedvrgdtgeemtggvtgdtmegttddvkeemrggvfedvmeefsgekvdemtggtsgdumeeffhdtleemiegugeekngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeekpdhrtghpthhtohepthhhuhhthhesrhgvughhrghtr
 dgtohhmpdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtoheprghtihhshhdrphgrthhrrgeslhhinhhugidruggvvhdprhgtphhtthhopegrnhhuphessghrrghinhhfrghulhhtrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: alex@ghiti.fr

Hi Thomas,

On 6/6/25 09:09, Thomas Huth wrote:
> The kernel Makefiles define the __ASSEMBLY__ macro to provide
> a way to use headers in both, assembly and C source code.
> However, all the supported versions of the GCC and Clang compilers
> also define the macro __ASSEMBLER__ automatically already when compiling
> assembly code, so some kernel headers are using __ASSEMBLER__ instead.
> With regards to userspace code, this seems also to be constant source
> of confusion, see for example these links here:
>
>   https://lore.kernel.org/kvm/20250222014526.2302653-1-seanjc@google.com/
>   https://stackoverflow.com/questions/28924355/gcc-assembler-preprocessor-not-compatible-with-standard-headers
>   https://forums.raspberrypi.com/viewtopic.php?p=1652944#p1653834
>   https://github.com/riscv-software-src/opensbi/issues/199
>
> To avoid confusion in the future, it would make sense to standardize
> on the macro that gets defined by the compiler, so this patch series
> changes all occurances of __ASSEMBLY__ into __ASSEMBLER__.
>
> I split the patches per architecture to ease the review, and I also
> split the uapi headers from the normal ones in case we decide that
> uapi needs to be treated differently from the normal headers here.
>
> The x86 and parisc patches already got merged via their specific
> architecture tree:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=24a295e4ef1ca8
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8a141be3233af7
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cccaea1d66e94b
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e2b6a188625a2b
>
> So I assume the riscv patches should also go via the riscv tree.
>
> v2:
> - Split the riscv patches from the global series
>    (see https://lore.kernel.org/all/20250314071013.1575167-1-thuth@redhat.com/)
> - Rebased the patches on linux-next and fixed the conflicts
>    and new occurances of __ASSEMBLY__
>
> Thomas Huth (2):
>    riscv: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
>    riscv: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
>
>   arch/riscv/include/asm/alternative-macros.h   | 12 ++++++------
>   arch/riscv/include/asm/alternative.h          |  2 +-
>   arch/riscv/include/asm/asm-extable.h          |  6 +++---
>   arch/riscv/include/asm/asm.h                  | 10 +++++-----
>   arch/riscv/include/asm/assembler.h            |  2 +-
>   arch/riscv/include/asm/barrier.h              |  4 ++--
>   arch/riscv/include/asm/cache.h                |  4 ++--
>   arch/riscv/include/asm/cpu_ops_sbi.h          |  2 +-
>   arch/riscv/include/asm/csr.h                  |  4 ++--
>   arch/riscv/include/asm/current.h              |  4 ++--
>   arch/riscv/include/asm/errata_list.h          |  6 +++---
>   arch/riscv/include/asm/ftrace.h               |  6 +++---
>   arch/riscv/include/asm/gpr-num.h              |  6 +++---
>   arch/riscv/include/asm/image.h                |  4 ++--
>   arch/riscv/include/asm/insn-def.h             |  8 ++++----
>   arch/riscv/include/asm/jump_label.h           |  4 ++--
>   arch/riscv/include/asm/kasan.h                |  2 +-
>   arch/riscv/include/asm/kgdb.h                 |  4 ++--
>   arch/riscv/include/asm/mmu.h                  |  4 ++--
>   arch/riscv/include/asm/page.h                 |  4 ++--
>   arch/riscv/include/asm/pgtable.h              |  4 ++--
>   arch/riscv/include/asm/processor.h            |  4 ++--
>   arch/riscv/include/asm/ptrace.h               |  4 ++--
>   arch/riscv/include/asm/scs.h                  |  4 ++--
>   arch/riscv/include/asm/set_memory.h           |  4 ++--
>   arch/riscv/include/asm/thread_info.h          |  4 ++--
>   arch/riscv/include/asm/vdso.h                 |  4 ++--
>   arch/riscv/include/asm/vdso/getrandom.h       |  4 ++--
>   arch/riscv/include/asm/vdso/gettimeofday.h    |  4 ++--
>   arch/riscv/include/asm/vdso/processor.h       |  4 ++--
>   arch/riscv/include/asm/vdso/vsyscall.h        |  4 ++--
>   arch/riscv/include/uapi/asm/kvm.h             |  2 +-
>   arch/riscv/include/uapi/asm/ptrace.h          |  4 ++--
>   arch/riscv/include/uapi/asm/sigcontext.h      |  4 ++--
>   tools/arch/riscv/include/asm/csr.h            |  6 +++---
>   tools/arch/riscv/include/asm/vdso/processor.h |  4 ++--
>   36 files changed, 81 insertions(+), 81 deletions(-)


Applied for 6.17,

Thanks,

Alex


