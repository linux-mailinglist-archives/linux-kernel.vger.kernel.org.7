Return-Path: <linux-kernel+bounces-786633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36293B35F59
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D863A4FFA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B8129D280;
	Tue, 26 Aug 2025 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ihBLUCYD"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F56B29ACC0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212154; cv=none; b=Yiqx2AgcHbUgQ2dw/vI5Entx1rwjHNiHXl8ZgHLpkO0nz3PPtxGqnuhxmGGhHvu30yEZ4J4wpgVEnm5mnALRhs+zZDk2vz76RI5ui/Q/GkoV/eVlkmK9NByrHzMcXwRC90JE80DZ16HJPYAbNOWyoVI2B8qDI9lyoTGEIKbppOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212154; c=relaxed/simple;
	bh=S0Bpq4OtfC8Cw6JaOppgM0dRbUEeZh7tZ/ZTZm1OrYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rvms8HqaTWMyImki71zn3xcmRr4gCyWAbVnOLd5lRYklylyg23eDnnA3TRByQbMdtLPcSjm68jfmICnRu8Z/nfVuwpTkLLM37E5jtxKjQblLIS41ZIRaVYinXd0NMH6shG86zm/p1D/5iFYGDJOymTbdJ/50yskRsq9xCyioeS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ihBLUCYD; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b4c29d2ea05so1115572a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 05:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756212152; x=1756816952; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ihIdRxo3zaCFTaaQOEAUMowWjAiYBG/G7mxYDcyFFLY=;
        b=ihBLUCYDzwULSF4TLow/lDM5TpUFw8h4oqEU5RBFZiDRMf16CSlb95UiCafJba/rIf
         ue+wQz6eNDcZBNsmdCkyz6HdHEQ+AcAFjPv9NOzQbu5N5LezfKA5KeLOw8YkuRkBoBy3
         fL6X5j8IiX2dGdzF8dQFa/Po4NSl/iwxfgNMWDl2rNWxqQT0UyvYRoTJAOTcj1aKBr0G
         FkrMAVtbdQTaDFrd9zkbiBwMeBm6JoYsKkfDFAj6A2XVakWc426ofPmarZMAewZPwwwU
         NcyskADqey3q1nyK+gvuTxipIsV9fXTDize3tvcoOLbKOAWjphFvRBe7jR7N6Jd2Edaa
         qdew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756212152; x=1756816952;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ihIdRxo3zaCFTaaQOEAUMowWjAiYBG/G7mxYDcyFFLY=;
        b=echaLDzb49wGx6ZOV2TMtjn0AWcALGLof+/3UbeAkdH75+yuvepvEqWSR9IOGHVqwz
         Qrs6HjxnGua+25EeEVU6zJDqexoZ2IZZD02t/MBwGvyx+Dkph0PUn88siV6BCEIRbI0t
         OZNqjcqmchZ3KLQ55jHNVV44lRqckwHBCOpK19txW2+w0uTzE0CiPVnSumrgPOdi9Yhl
         TZSP+raVXzsKperipVVcPjGv1MTJDeiAj0/fbcUMBJtl22n68qD/3MG959+uGEhP/RI8
         x+VnA0qO5cSZ9LIS9tMGcdYG4m8nLmSAXNFJj8l0fRhsiSh0qg+i56Q+Az+b626yPD3a
         cN/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWgXQribga2qX0QJsI0mzMZTzTCXNIzNTDV5vss59AKWVAL3US9zDTz74NMGTqIzv/JKPNXbPHrZruXtR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaDaIPf/MiVOzXHiyLdc5nCw/4QRvOZ4he8ehmdNNaL/VKdV+r
	HTwTNNRUYKONbtQkETPD936HnPjgaWGC05HEzaWMikOQPGxsW9kBfWyV3DM9zYLbJT23+OkfxZs
	urwNyCakTrMJBvM3NvoKMmSJxrHLLCn2n3cFJW07PHA==
X-Gm-Gg: ASbGncuAWi18C5VCSLOZINr3ORK4pEsT4KnY15jNsCo/8PX7Ka5SkjREwITpnZfevcH
	6u9MkFFkSnD+H8P8ehBzo8OZwBRomZhXErFxp4ZrV3THwk47CpGNKH3JOJRM/BNibEhUw5VdZCZ
	i2kXttGsre0gY80R2INydGyO5COPmGCW8m/sPZlpzD2LO3SMN+a2R9DqrtxygYeFgxE9plvE9LI
	Jghzyl7JjgUF/MxDUeN1mS4yUzHva5tU7kNcChf
X-Google-Smtp-Source: AGHT+IH4NyVaZSDy6n4rrA41KU9v9fWAF+kl8XT24+x2ai2ACAdw9OAw+btvXA9avZlDxdZPOwNmJ8qepSzZ92IMffg=
X-Received: by 2002:a17:902:dac3:b0:246:bba8:9b8e with SMTP id
 d9443c01a7336-24875397544mr14665275ad.21.1756212151245; Tue, 26 Aug 2025
 05:42:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuR9auMS=hg9Ri+A2SeCQ0jHkW7mN3k9RDG66vE5cfJdQ@mail.gmail.com>
In-Reply-To: <CA+G9fYuR9auMS=hg9Ri+A2SeCQ0jHkW7mN3k9RDG66vE5cfJdQ@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 26 Aug 2025 18:12:19 +0530
X-Gm-Features: Ac12FXxhveQA1vmrTzmCHnzem-lWe0TWCdRXPN4ReZjhi1Wfyu2PglXf3y83Y8w
Message-ID: <CA+G9fYuLx27WRsS185pDnCVOtsLhn_WQRY4EoDBU8dT-hm88Rw@mail.gmail.com>
Subject: Re: next-20250825: arc: seqlock.h:876:2: error: implicit declaration
 of function 'spin_lock' [-Werror=implicit-function-declaration]
To: Linux-Arch <linux-arch@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Waiman Long <longman@redhat.com>, Vineet Gupta <vgupta@kernel.org>, Ye Liu <liuye@kylinos.cn>, 
	Zi Yan <ziy@nvidia.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Dev Jain <dev.jain@arm.com>, 
	David Hildenbrand <david@redhat.com>, Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Aug 2025 at 12:05, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> The following build warnings / errors noticed with arc defconfig with
> gcc-9 toolchain.
>
> Regression Analysis:
> - New regression? yes
> - Reproducibility? yes
>
> Build regression: next-20250825 arc seqlock.h:876:2: error: implicit
> declaration of function 'spin_lock'
> [-Werror=implicit-function-declaration]
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> arc:
>   build:
>     * gcc-9-allnoconfig
>     * gcc-9-tinyconfig
>     * gcc-9-vdk_hs38_smp_defconfig
>     * gcc-9-defconfig
>     * gcc-9-axs103_defconfig
>
> ## Build log
> In file included from include/linux/mmzone.h:17,
>                  from include/linux/gfp.h:7,
>                  from include/linux/mm.h:7,
>                  from arch/arc/include/asm/arcregs.h:149,
>                  from arch/arc/include/asm/irqflags-arcv2.h:9,
>                  from arch/arc/include/asm/irqflags.h:13,
>                  from include/linux/irqflags.h:18,
>                  from include/linux/spinlock.h:59,
>                  from include/linux/sched.h:37,
>                  from arch/arc/kernel/asm-offsets.c:6:
> include/linux/seqlock.h: In function 'write_seqlock':
> include/linux/seqlock.h:876:2: error: implicit declaration of function
> 'spin_lock' [-Werror=implicit-function-declaration]
>   876 |  spin_lock(&sl->lock);
>       |  ^~~~~~~~~
> include/linux/seqlock.h: In function 'write_sequnlock':
> include/linux/seqlock.h:890:2: error: implicit declaration of function
> 'spin_unlock' [-Werror=implicit-function-declaration]
>   890 |  spin_unlock(&sl->lock);
>       |  ^~~~~~~~~~~
> include/linux/seqlock.h: In function 'write_seqlock_bh':
> include/linux/seqlock.h:902:2: error: implicit declaration of function
> 'spin_lock_bh' [-Werror=implicit-function-declaration]
>   902 |  spin_lock_bh(&sl->lock);
>       |  ^~~~~~~~~~~~
> include/linux/seqlock.h: In function 'write_sequnlock_bh':
> include/linux/seqlock.h:917:2: error: implicit declaration of function
> 'spin_unlock_bh' [-Werror=implicit-function-declaration]
>   917 |  spin_unlock_bh(&sl->lock);
>       |  ^~~~~~~~~~~~~~
> include/linux/seqlock.h: In function 'write_seqlock_irq':
> include/linux/seqlock.h:929:2: error: implicit declaration of function
> 'spin_lock_irq' [-Werror=implicit-function-declaration]
>   929 |  spin_lock_irq(&sl->lock);
>       |  ^~~~~~~~~~~~~
> include/linux/seqlock.h: In function 'write_sequnlock_irq':
> include/linux/seqlock.h:943:2: error: implicit declaration of function
> 'spin_unlock_irq'; did you mean 'write_sequnlock_irq'?
> [-Werror=implicit-function-declaration]
>   943 |  spin_unlock_irq(&sl->lock);
>       |  ^~~~~~~~~~~~~~~
>       |  write_sequnlock_irq
> include/linux/seqlock.h: In function '__write_seqlock_irqsave':
> include/linux/seqlock.h:950:2: error: implicit declaration of function
> 'spin_lock_irqsave' [-Werror=implicit-function-declaration]
>   950 |  spin_lock_irqsave(&sl->lock, flags);
>       |  ^~~~~~~~~~~~~~~~~
> include/linux/seqlock.h: In function 'write_sequnlock_irqrestore':
> include/linux/seqlock.h:981:2: error: implicit declaration of function
> 'spin_unlock_irqrestore'; did you mean 'write_sequnlock_irqrestore'?
> [-Werror=implicit-function-declaration]
>   981 |  spin_unlock_irqrestore(&sl->lock, flags);
>       |  ^~~~~~~~~~~~~~~~~~~~~~
>       |  write_sequnlock_irqrestore
> In file included from include/linux/sched.h:15,
>                  from arch/arc/kernel/asm-offsets.c:6:
> include/linux/rcupdate.h: In function 'rcu_read_lock_sched_held':
> include/linux/preempt.h:227:49: error: implicit declaration of
> function 'irqs_disabled' [-Werror=implicit-function-declaration]
>   227 | #define preemptible() (preempt_count() == 0 && !irqs_disabled())
>       |                                                 ^~~~~~~~~~~~~
>                           ^
> cc1: some warnings being treated as errors

Anders bisected this and found,
 # first bad commit:
   [7cf258e5720ffdd5505faa04ab5afa9732ef0f6e]
   mm-replace-20-page_shift-with-common-macros-for-pages-mb-conversion-fix

> ## Source
> * Kernel version: 6.17.0-rc3-next-20250825
> * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
> * Git describe: next-20250825
> * Git commit: 6c68f4c0a147c025ae0b25fab688c7c47964a02f
> * Architectures: arc
> * Toolchains: gcc-9
> * Kconfigs: defconfig
>
> ## Build
> * Build log: https://qa-reports.linaro.org/api/testruns/29652436/log_file/
> * Build details:
> https://regressions.linaro.org/lkft/linux-next-master/next-20250825/build/gcc-9-defconfig/
> * Build error details:
> https://regressions.linaro.org/lkft/linux-next-master/next-20250825/log-parser-build-gcc/gcc-compiler-include_asm-generic_getorder_h-error-implicit-declaration-of-function-ilog/
> * Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/31lrYki7MzYyqtJKnutAe2oawoq
> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/31lrYki7MzYyqtJKnutAe2oawoq/
> * Kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/31lrYki7MzYyqtJKnutAe2oawoq/config
>
> --
> Linaro LKFT
> https://lkft.linaro.org

