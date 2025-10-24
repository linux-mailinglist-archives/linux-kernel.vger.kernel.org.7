Return-Path: <linux-kernel+bounces-869602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 135B4C0848A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 01:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37CCC4E5304
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949C12727EB;
	Fri, 24 Oct 2025 23:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBB4Ed4e"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200AB1990A7
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 23:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761347848; cv=none; b=c3tDw44K5MPJr2kef0hz6laEiy/tiFPGsWEFKF3iJi2wUBHmUAQrGh22ThVGTwqWLCb4GB/lLG2sIrQDKdWqN49bpiRSXAaGtzcWeXBQzGpwZJiiR+4ep21Bw29tk72wA+2cbIFI+PCzeyQc4WuoPsQQJjV4dpftbXUn3jllBVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761347848; c=relaxed/simple;
	bh=+NEftr7VWmliQcXUqkaO9sJG2DgzF/Yaw8WY6cHdu/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBTd7O6HrSAxjdZEBHZRlzeDLES3dlCmh+ej5PTCcHRNRpCRlt6GIXQxD+i901uebWJfEQggMDj8nkkyNCl37DUMA89o5E3reaO4o4WUMuTjLJRKXwlTPXLyVPqxbhHNiUwOiYUIQnVqFw0vkzD17Q0MusManGAKsrmuV6jt0nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBB4Ed4e; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b4539dddd99so526867566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 16:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761347845; x=1761952645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4qshgmZlkIM4+vcn2er+R5ZwtdRF9Gko5Hx8ZyCDhMI=;
        b=aBB4Ed4e9nyMko0RU91OcIOb9HCioQMGbmrLsvVBL+VUnrV++i1s0dh/Tk+LnjDLHC
         JBWz9173oT25WaWpxTdBRGooFUEUVMXOeYSy35BCaemNOf/YbA6D7HDvToFQMQxHwZ2z
         W61tvQeVRNBID0jLN6p9MdSnMQR1kztXtedb3fMVlrrt1bA9yk8agFe9TrI4q0gacepr
         WzhZOlCSEBwKSdaT6GLWQ3Uv+XvekUFJfoi1m/mYHpZaFAbw7v82cOFmwJ7+48DavOeA
         fX7FHVH4zDzKr/kNRV+jsW/cPzXLI5uu/FUJa1S/zNq8YGLa6p3rfl5N+24ME2lBW6vy
         Nabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761347845; x=1761952645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qshgmZlkIM4+vcn2er+R5ZwtdRF9Gko5Hx8ZyCDhMI=;
        b=VTCWu48lZYBdL5PZxyNEvguhVjiZ3Voe1/U/T1xNzCU+phPW2PKVIi75Cz8DFIgrv5
         e5q7xH9wzM+boKbrx5nWn5dl80iMF0ZR/CXYa9fpN4h/m+WTAyCkWU8voCvfE0wtmZ9f
         Eqasq6djdajnv/ohQaraqNtQ1gfYRv46xttsxGRds2hxud0296sn3zKKUcEj9xQ1RAvR
         jakSGnVtVkjrP6dgLFHcUdznPMdFSrRDl1JAsFCj0oxwbVUiFyigb1mDgiy0Zmr6Hm9w
         HN1W+TrfWCoxzcIpWqQmtGROYnhtk13S9viuXRYRxxNvhmeyTTWBgkiS+vPmFFR3mXbr
         1S4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxjLYg4OsrheoI4VlYV1hU+rkZWotAsOUCvftu5ZJ5LAEc2r1OE1aQ/hMnjzXBWVN1AxH+ke4PO86GBtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg8rQVg6KVlpDFkhQj+xs+VOFVNOQce2x+JGSA/w8u74TOqtjo
	N9yF4HIaBeOAocVe0Njvxln9JnJb4/P5fkT2zuA49ED49g1VrLErwTqUjq6wgA==
X-Gm-Gg: ASbGncti3CZ4xSdaan7yqQyA7nPG1ZpvjX2IQDbvpTczdyDPjeJQfW84QsrnCDbALEE
	yItAAM6E6QX+TeAJO4yNNu5dmBJkqQYiOdiliPh/DbCAQ9Fb1QbQAGjqisTHCK4eKqz/qxqNZnf
	LiPjm1EIV1uyxRqlMhXxLmw4YmxmI71Myx87cTK+mU7qRW5SuV2+SXMq83pXoNs9Zn1Q85rHp8N
	xdnwZOZUI3SO6zrF8I68tS9yDcI/ClK8v6PN9bSkhNjc9837PsbmnXroxox/rXOiCnwSwcKjYqu
	aKpR32I8nJNUooo7SZxk2D/UmHKKxGqU7/5pGXzsN6VxmbI5VqvPU6swIJVkXKClDGSnOhme7Z6
	A6U6w7LfRAikqnSofH16EyC3DVCi8AFmVetiLkAoB4cxA1kLRFhbgqasXzBz2bmlQpGa8rrI=
X-Google-Smtp-Source: AGHT+IEQw0TA1CC7no4fMAMA9oQRoUt9Lgbn+Uft1azRKrTnyGz7lCiyNuO6p2GHKFOC05VVJ/iKvw==
X-Received: by 2002:a05:600c:4f89:b0:471:a98:99a6 with SMTP id 5b1f17b1804b1-475cafae164mr64272055e9.11.1761342429974;
        Fri, 24 Oct 2025 14:47:09 -0700 (PDT)
Received: from andrea ([31.189.53.175])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496d4b923sm89676705e9.14.2025.10.24.14.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 14:47:09 -0700 (PDT)
Date: Fri, 24 Oct 2025 23:47:04 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: corbet@lwn.net, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, will@kernel.org,
	peterz@infradead.org, boqun.feng@gmail.com, mark.rutland@arm.com,
	anup@brainfault.org, atish.patra@linux.dev, pbonzini@redhat.com,
	shuah@kernel.org, ajones@ventanamicro.com, brs@rivosinc.com,
	guoren@kernel.org, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
	apw@canonical.com, joe@perches.com, lukas.bulwahn@gmail.com
Subject: Re: [PATCH v4 00/10] riscv: Add Zalasr ISA extension support
Message-ID: <aPvz2Pb6RuWnw9Ht@andrea>
References: <20251020042056.30283-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020042056.30283-1-luxu.kernel@bytedance.com>

On Mon, Oct 20, 2025 at 12:20:46PM +0800, Xu Lu wrote:
> This patch adds support for the Zalasr ISA extension, which supplies the
> real load acquire/store release instructions.
> 
> The specification can be found here:
> https://github.com/riscv/riscv-zalasr/blob/main/chapter2.adoc
> 
> This patch seires has been tested with ltp on Qemu with Brensan's zalasr
> support patch[1].
> 
> Some false positive spacing error happens during patch checking. Thus I
> CCed maintainers of checkpatch.pl as well.
> 
> [1] https://lore.kernel.org/all/CAGPSXwJEdtqW=nx71oufZp64nK6tK=0rytVEcz4F-gfvCOXk2w@mail.gmail.com/
> 
> v4:
>  - Apply acquire/release semantics to arch_atomic operations. Thanks
>  to Andrea.

Perhaps I wasn't clear enough, sorry, but I did mean my suggestion
(specifically, the use of .aq/.rl annotations) to be conditional on
zalasr.  Same observation for xchg/cmpxchg below.  IOW, I really
expected this series to introduce _no changes_ to our lowerings when
!zalasr.  If any !zalasr-changes are needed, I'd suggest isolating
/submitting them in dedicated patches.

But other than that, this looks pretty good to me.  Perhaps something
else to consider for zalasr is our lowering of smp_cond_load_acquire()
(can't spot an actual bug now, but recall the principle "zalasr -> use
.aq/.rl annotations ..."): riscv currently uses the "generic", fence-
based implementation from include/asm-generic/barrier.h; compare that
with e.g. the implementation from arch/arm64/include/asm/barrier.h .

  Andrea


> v3:
>  - Apply acquire/release semantics to arch_xchg/arch_cmpxchg operations
>  so as to ensure FENCE.TSO ordering between operations which precede the
>  UNLOCK+LOCK sequence and operations which follow the sequence. Thanks
>  to Andrea.
>  - Support hwprobe of Zalasr.
>  - Allow Zalasr extensions for Guest/VM.
> 
> v2:
>  - Adjust the order of Zalasr and Zalrsc in dt-bindings. Thanks to
>  Conor.
> 
> Xu Lu (10):
>   riscv: Add ISA extension parsing for Zalasr
>   dt-bindings: riscv: Add Zalasr ISA extension description
>   riscv: hwprobe: Export Zalasr extension
>   riscv: Introduce Zalasr instructions
>   riscv: Apply Zalasr to smp_load_acquire/smp_store_release
>   riscv: Apply acquire/release semantics to arch_xchg/arch_cmpxchg
>     operations
>   riscv: Apply acquire/release semantics to arch_atomic operations
>   riscv: Remove arch specific __atomic_acquire/release_fence
>   RISC-V: KVM: Allow Zalasr extensions for Guest/VM
>   RISC-V: KVM: selftests: Add Zalasr extensions to get-reg-list test
> 
>  Documentation/arch/riscv/hwprobe.rst          |   5 +-
>  .../devicetree/bindings/riscv/extensions.yaml |   5 +
>  arch/riscv/include/asm/atomic.h               |  70 ++++++++-
>  arch/riscv/include/asm/barrier.h              |  91 +++++++++--
>  arch/riscv/include/asm/cmpxchg.h              | 144 +++++++++---------
>  arch/riscv/include/asm/fence.h                |   4 -
>  arch/riscv/include/asm/hwcap.h                |   1 +
>  arch/riscv/include/asm/insn-def.h             |  79 ++++++++++
>  arch/riscv/include/uapi/asm/hwprobe.h         |   1 +
>  arch/riscv/include/uapi/asm/kvm.h             |   1 +
>  arch/riscv/kernel/cpufeature.c                |   1 +
>  arch/riscv/kernel/sys_hwprobe.c               |   1 +
>  arch/riscv/kvm/vcpu_onereg.c                  |   2 +
>  .../selftests/kvm/riscv/get-reg-list.c        |   4 +
>  14 files changed, 314 insertions(+), 95 deletions(-)
> 
> -- 
> 2.20.1
> 

