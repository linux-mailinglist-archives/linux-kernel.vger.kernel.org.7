Return-Path: <linux-kernel+bounces-870821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7EBC0BC35
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 04:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 615C634AA18
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 03:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF362C0295;
	Mon, 27 Oct 2025 03:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="1pdv+HQ4"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2208D4D8CE
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 03:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761536313; cv=none; b=OfzvfppY7/5vd/X4GNH50t3iJ4z4Hte418JMLPcBSXz8AQIdAXx1w0LswkXOjD1MoOa5YRnG35CSKILUXRm0AsGelrbXR2MmY/pOmCFF0nq1oMw5fxkeIy3pMcsHMVpztRFaDPqCRyWmKJzSY7xTu2NiPZ4ONyCmhlNURL6qxvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761536313; c=relaxed/simple;
	bh=ykqsBz7ltNcPXKuQY9/QTGVQNnJRyRhhtKcA12vcA/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZ/h5csdvK9crPCwXmedz1nuBkIBxu+/YuJh9X3hKAShSG5LrvPa7pN74NqopNLwG2I1WwurnRq5ch2OeujUgQF24lcJf3CW6rt7afwC8oO6iEcQI8JxdyoS26vjbG0KvRRKkii4z/VLD72vY6bcfRnryZkZly8UNkr1vnE/rAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=1pdv+HQ4; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-92aee734585so178979039f.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 20:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1761536311; x=1762141111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLv/abQqhTrjCuxnsZKW6XWrZqaImCMO0bBeDuN7Ur0=;
        b=1pdv+HQ4aRXCgsmvJPnow+5C4Cz+nYqKSF84oWDwNrqZkzWOgY1vJpCSBoUQHvFaKb
         qTeZTgwpuIlaowcY9aganZJuJFKxNGadAK3y0Jr1vdnPJIH67l+oipfUDPeWoa3YJHo+
         AJzJkeRMGpzaC3+MSNgzg8RR71I/mVIRpFRUTH/Ikk3yaoT3FhmIdpeg7U7g8kqk7UGb
         xWMoIprbGVhBpwuAWutla9g0ZXsoGRsGgpHMn4g4afs5QHwKw3VfanFz9wihmHestkJl
         Vhj5bbfVt/2rTDFHgambTncdd5iKkWp3Jkzk+ahYDuyv3/cuR9uBScjGYrn7TVB6SffO
         DRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761536311; x=1762141111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLv/abQqhTrjCuxnsZKW6XWrZqaImCMO0bBeDuN7Ur0=;
        b=d5vSrV4W6GN9tULcI4bXECDVpZgGRrZ4TdLkglGfTfQFK9kAOUJnju3IeSChTIFIWX
         EQAg/PeXTw+FCK155c4DRSMzceKYUd1ZYkT9le33e1ToF/FYipRMXwsXDaUfDWLR1oDH
         EvVW7FTam6eAalJqPn7uKAWN7F/wX+K+coVkXnuB4X9I5hRlMbkEYJaxur9KxnHCQttE
         2dJUU8W3EitxzdoT4iwXM09QqjG+6LP+XQcuhTU3msabyA93Zr6H8MY5VptpKUFvLy5T
         dEipu+jGVghemrtnQlavC41TeUPKpH3T6nC2L4ZLC6RAAaebhyksk2gk9SvCQUzjHN6h
         ZVZA==
X-Forwarded-Encrypted: i=1; AJvYcCXJia5AhYpww2nEMQB6DodLISvFJ6w6e78DTbTZM2pvmXm/hRxzKDrPKl+EXIwLzKqs3JEoLLu8D4bciao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5DJgC0M3LFE5C7Ut37dp88OhO2IPDvUwiVgvUuJxqGIdLgL6h
	AmBmaP4SjADWfu1DUbsunAdAB4j6+UohemZZ00cCKBbiUrVGSlw/5z/YAaeLJsf83oLqzxBAPeT
	JncJk804drxFpSAloeLmhdzhhft3eQ7KDOI23JUKKvA==
X-Gm-Gg: ASbGncuB6IuX6YBjnNA1VfinZjKrsw0/cArBJM3Q37pRnwGeSNMovtVQDpedECx45Dn
	ftslyOFy3815+68Fy0GUWwd9IQgL8sXUPCEbBAb6zu8k7djRqTAYdLhntEV5/QQaNx2g7wYuRw6
	9+qVZ6pu3QtX00Lom1fBEzRsUpE/fHbhjj6J7nw6JLb1CjHXj5inlU7Iy4B1CPbBjvHXA/+EVew
	oXzcaSl2BRV8GWoAMtnWiRi9NahzowIn3eriVHTXqWiBm2YfGPSBpIMaCv3M1+dolWy86MIUf2c
	mvmolO7+igSIEY01465KDiXJ4688dDcKDmGcxV4wOFVHe6cErMP8gwj8cRcb
X-Google-Smtp-Source: AGHT+IFXk1YUaLAdhvo8rgPkIKe5gLo/c+djIhEIA40LWqKcizzRXoBKOFj4cyggO2AuZkgxTRXbB8jToGSbWYc3oMw=
X-Received: by 2002:a05:6e02:190c:b0:42f:9eb7:759b with SMTP id
 e9e14a558f8ab-430c5306894mr466704455ab.28.1761536310727; Sun, 26 Oct 2025
 20:38:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017155925.361560-1-apatel@ventanamicro.com>
In-Reply-To: <20251017155925.361560-1-apatel@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 27 Oct 2025 09:08:19 +0530
X-Gm-Features: AWmQ_bleYZ_iePePDvRC5d6Pe5JA_nbAbhQUpFmow4pTKUmpRz54E4-TMp1PLS4
Message-ID: <CAAhSdy1+AFQepjrfKrcQvC8cxDpjOHfF500O6FXTYzf-iksCfw@mail.gmail.com>
Subject: Re: [PATCH 0/4] SBI MPXY support for KVM Guest
To: Anup Patel <apatel@ventanamicro.com>
Cc: Atish Patra <atish.patra@linux.dev>, Andrew Jones <ajones@ventanamicro.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 9:29=E2=80=AFPM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> This series adds SBI MPXY support for KVM Guest/VM which will
> enable QEMU-KVM or KVMTOOL to emulate RPMI MPXY channels for the
> Guest/VM.
>
> These patches can also be found in riscv_kvm_sbi_mpxy_v1 branch
> at: https://github.com/avpatel/linux.git
>
> Anup Patel (4):
>   RISC-V: KVM: Convert kvm_riscv_vcpu_sbi_forward() into extension
>     handler
>   RISC-V: KVM: Add separate source for forwarded SBI extensions
>   RISC-V: KVM: Add SBI MPXY extension support for Guest
>   KVM: riscv: selftests: Add SBI MPXY extension to get-reg-list
>
>  arch/riscv/include/asm/kvm_vcpu_sbi.h         |  5 ++-
>  arch/riscv/include/uapi/asm/kvm.h             |  1 +
>  arch/riscv/kvm/Makefile                       |  1 +
>  arch/riscv/kvm/vcpu_sbi.c                     | 10 +++++-
>  arch/riscv/kvm/vcpu_sbi_base.c                | 28 +--------------
>  arch/riscv/kvm/vcpu_sbi_forward.c             | 34 +++++++++++++++++++
>  arch/riscv/kvm/vcpu_sbi_replace.c             | 32 -----------------
>  arch/riscv/kvm/vcpu_sbi_system.c              |  4 +--
>  arch/riscv/kvm/vcpu_sbi_v01.c                 |  3 +-
>  .../selftests/kvm/riscv/get-reg-list.c        |  4 +++
>  10 files changed, 56 insertions(+), 66 deletions(-)
>  create mode 100644 arch/riscv/kvm/vcpu_sbi_forward.c
>

Queued this series for Linux-6.19

Thanks,
Anup

