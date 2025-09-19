Return-Path: <linux-kernel+bounces-824351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3638DB88BF4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5F4816D6F2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0962EC55D;
	Fri, 19 Sep 2025 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7o6dHTX"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F5F23C4FF
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758276256; cv=none; b=j8C30Jlp8aTykAozEofYwEhp3ITQqBqXQMXIdOb4eVptnU5XUIhjn+douIHzAVG8mCC27t9mAUl23YFMaamyTh4aDdifiN1OPpXCpb8ljhD7LB7Ckqe7rkGLUJFRKokSSQmlTTnJE0vhL+/svWrnCKR+aM4UJzHj7NrdWODloUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758276256; c=relaxed/simple;
	bh=MIxBc+wC/cmWNfba7NJKwLPOOs4c9e3k+S+2+58b6Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TyoQMXFw3YaObf3aOFhMlyc3kuZtplzokYYlJSfDb/6sx2tfymf6CLfrNdlYkFkDYvA4+SumgMIMaeQTBF9XHvTbWZUY3y1bNNGi/ooImLRQ1/+37uWgYapur+/b2NlOk1sZBfSUenLfNy3cM1LVHL/pmzGiNzu4RgMn8IujMZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7o6dHTX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45dcff2f313so11952295e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 03:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758276253; x=1758881053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cwSJqMLbkr+n3h9atzHQFhMdHOFSLWWZIBI6hzjzDlU=;
        b=g7o6dHTX/jKHUK07jvyCoY6ajcxb8/0bRLC2sulEeTiYYmsNUrN/qQ/Kx+x8TGrH09
         xXtmOl/GW/IoqmUA5L8WmpnY/Ry4Mac8F62gy298XaBuGkf30NMiGOVgxuDU0wMvEgog
         9fICTRwDWsQqioLOic49O/qJycH1rVfrSrPZTNghHMFyjkvgtcfZAArPlykxj6LRAgIn
         /z+2cdKAoSMYYHGcHTJUF11WeWwvX1KLS9ZNV0FO83Q74Nm2sLgb/jDzNEhIoab1YNJW
         mPjeFOktVP7AS7KpiFHPoxoBQ7ou9utiKL5FYJ9mpyFQ+LBfTNx7acGRLaPFBHksBDK+
         /N9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758276253; x=1758881053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwSJqMLbkr+n3h9atzHQFhMdHOFSLWWZIBI6hzjzDlU=;
        b=eZr379MGK6mmlj9lauY65LIoTz3uP9m3eioZKJBrt9IGzlU6m0ILcPtaTnugCC4gRG
         BtsPKxbMfgvF+IkHgyKe/WHpxbPLjaN5+M+t6OPRJrFwSdpz4c5etWDDSSrUrYhy+Svl
         uEpQ9t5Zl8tdp8hAb9HD9NxJMzsr/qRW4Yl05G60rGBJANJ6oZ4IPBYwQHUEsWrTOETv
         vM+1D8WNbq6fZbiD3hddda7YDMRIBl1i+uWKmwFodJfiRhGUCxNHmmlOpMrzy0pNdJsT
         EuJgXWy8YafPYVjTgk6ZY0tfZADew9tSQiS9fG2/nRTxscK7XoYkQhy1aLDRwWiSmBKe
         +Wrw==
X-Forwarded-Encrypted: i=1; AJvYcCVoIu5BFlZJdx+221N5utiCJhwLcrTp1wCWxXhWlbR+haraIIKYL1BOzFl3T+lonU0bKmTorJMTGwxdfs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDBPTW6fhCXROTPGLo206KvPBbvYCc5l5LTl+KryyGSHYf2E8Y
	ckNniBa+Cubnvx89iBV9/+Ve4SKzLZKaD10v6xn+rj4g2qjOx6r9C4pz
X-Gm-Gg: ASbGncscV42EFjLFnxS5/PCKux5GdMs99m8Xhi0af3vn0YcYe+sH6AtApn1wTtOxgHN
	bUwILuPKp+cwYTefltVVut2OguWLtZ8jFA+EMDLz65/rs5Jg9u7VltsQw+4zIBp+FQFBy5LpuIv
	UmLKQDvqCLfslPLA4ze9qITVbblmMArGrG+fCfzFnK5y+emRlf3bREvjt8XpRj8yv+KqF2gRguP
	6m0zLttUaSXkcWVAHaDurs0fBUiKOPlPFB4zBOGi2BejfNUwbYQ4yd/Fr2fbKiYG+yWAdIQdZV9
	uC4xugnRY8WO6Fr2cDeFMgQ6X//aa3faKEGm/EwpLAIJwm9RiUGhvnWVmxtJFGoS2p1eaeObUSc
	QoNcfWW3Bfxrenm1YT9Th
X-Google-Smtp-Source: AGHT+IHvZMGRRNi+u2pMIpVVRpaJCUA/81PZdTy1q3wdlCcos410V3il5VvXKBDg1PnvbPEV8rv3lQ==
X-Received: by 2002:a05:600c:6305:b0:45b:868e:7f7f with SMTP id 5b1f17b1804b1-467ee8c56d6mr28084075e9.17.1758276252440;
        Fri, 19 Sep 2025 03:04:12 -0700 (PDT)
Received: from andrea ([176.201.192.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f5a286edsm90295055e9.16.2025.09.19.03.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 03:04:12 -0700 (PDT)
Date: Fri, 19 Sep 2025 12:04:05 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: corbet@lwn.net, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, will@kernel.org,
	peterz@infradead.org, boqun.feng@gmail.com, mark.rutland@arm.com,
	ajones@ventanamicro.com, brs@rivosinc.com, anup@brainfault.org,
	atish.patra@linux.dev, pbonzini@redhat.com, shuah@kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, apw@canonical.com, joe@perches.com,
	linux-doc@vger.kernel.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/8] riscv: Add Zalasr ISA extension support
Message-ID: <aM0qlTNPiaQRY2Nv@andrea>
References: <20250919073714.83063-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919073714.83063-1-luxu.kernel@bytedance.com>

On Fri, Sep 19, 2025 at 03:37:06PM +0800, Xu Lu wrote:
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
> Xu Lu (8):
>   riscv: add ISA extension parsing for Zalasr
>   dt-bindings: riscv: Add Zalasr ISA extension description
>   riscv: hwprobe: Export Zalasr extension
>   riscv: Introduce Zalasr instructions
>   riscv: Use Zalasr for smp_load_acquire/smp_store_release
>   riscv: Apply acquire/release semantics to arch_xchg/arch_cmpxchg
>     operations
>   RISC-V: KVM: Allow Zalasr extensions for Guest/VM
>   KVM: riscv: selftests: Add Zalasr extensions to get-reg-list test
> 
>  Documentation/arch/riscv/hwprobe.rst          |   5 +-
>  .../devicetree/bindings/riscv/extensions.yaml |   5 +
>  arch/riscv/include/asm/atomic.h               |   6 -
>  arch/riscv/include/asm/barrier.h              |  91 ++++++++++--
>  arch/riscv/include/asm/cmpxchg.h              | 136 ++++++++----------
>  arch/riscv/include/asm/hwcap.h                |   1 +
>  arch/riscv/include/asm/insn-def.h             |  79 ++++++++++
>  arch/riscv/include/uapi/asm/hwprobe.h         |   1 +
>  arch/riscv/include/uapi/asm/kvm.h             |   1 +
>  arch/riscv/kernel/cpufeature.c                |   1 +
>  arch/riscv/kernel/sys_hwprobe.c               |   1 +
>  arch/riscv/kvm/vcpu_onereg.c                  |   2 +
>  .../selftests/kvm/riscv/get-reg-list.c        |   4 +
>  13 files changed, 242 insertions(+), 91 deletions(-)

I wouldn't have rushed this submission while the discussion on v2 seems
so much alive;  IAC, to add and link to that discussion, this version
(not a review, just looking at this diff stat) is changing the fastpath

  read_unlock()
  read_lock()

from something like

  fence rw,w
  amodadd.w
  amoadd.w
  fence r,rw

to

  fence rw,rw
  amoadd.w
  amoadd.w
  fence rw,rw

no matter Zalasr or !Zalasr.  Similarly for other atomic operations with
release or acquire semantics.  I guess the change was not intentional?
If it was intentional, it should be properly mentioned in the changelog.

  Andrea

