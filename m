Return-Path: <linux-kernel+bounces-890258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5D0C3F9F9
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5FEE4ECF36
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A549031D75E;
	Fri,  7 Nov 2025 11:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="FT/csjbq"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715A431A07B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 11:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762513443; cv=none; b=Y4l1yXSeBa5ckzMszwQLgUrOyR78ipV4l7x+lJudzuN7THWJtyBfqJglprPBiWQwID9huRaA8fm7hL1rASeEYxVmkXSw2JTOe6h2YO/+NqTjJTYOyAKwaiRP8i3j1khtsKpJFZf0nPaZq4+ezeACE4qiw+vEGntbLTzU4qgg6eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762513443; c=relaxed/simple;
	bh=N00Ucd856bSWhiBAjcJFbc+enaLUyVUPZnhock7gOjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qeJmUAKUP6nkNEV8lWLguGfPi2RXPXXovanYaHKHMRl4EMm0IZtSBwXSofrIwSPt8hRiYZ5Mx3u3Im0038PhYDWofXyI1JZ8Ypep2oIqLEaW8+d5djiyac18CLty9ebB47kZMuUlY2vzu6OokCCwJQ+KruX4YBn1M/h9hNIW7aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=FT/csjbq; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-948733e7810so23031539f.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 03:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1762513440; x=1763118240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5VodCG3bTal5vrS9k2SlGtZ950F4z5chIAl+OKVPjk=;
        b=FT/csjbqPjXHu4j+S/opnVm2SNJGIq2x0f+HOOKEisK2soNU19trNmGfnEOyyymdON
         syXZ0NS+Z1BaEvgrTa3TDFzLOQJ/IeT7IMUwV4dTsHScPA9pKZwD5GwQRIdsBxtTMW5F
         1lOzZwN5m4AEAtn7Ez9eHZ7vjQVZ/xbL3OUDyxEGFYof/Csy30wj5XE4Jh49iw5kyU51
         yYiWpoAYUMO6016bfPRLrMJcr/DJuMObsaxtVKe12BoiwiYjWdEn3gC5VO5rxYaZoP5w
         vKpfFvLowsNDgnD1dodlW+31apQ3uhk0zJrFxO5bDp5Xmr0o4vSTRruVIj1/OA9Kw0ru
         xUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762513440; x=1763118240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L5VodCG3bTal5vrS9k2SlGtZ950F4z5chIAl+OKVPjk=;
        b=o0uPHDXC1j6B/k0njBkdMCjnSusgPKI0wxjj0zSVG1UngWWHkSiGJE3eGE8CK8tH9l
         Qh1e77QWNcB+Ysw09z7W2A1mJKAi4A8YJOl+/54YjXfs5cM/jU8QJyHcxSULXArA2pF0
         SGtTBwBI/mQJlPtknSYCQQBePgaDIFgx+urOwOpy7MqGoXIICg15WsZVWGaeJ0K4DEtx
         zKnzUveYxKw1JirLkZ6zcB6k5RZDk44s4msOoimeQSyI8LHEvNAF9zqmIQ8vBklGQju1
         pd/L1i/c4KbEpFa/gYa5MzeqFBkOat1j7DQLtamiY5wrUs/i5PE1dR4riNG963pxzoWK
         jrnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7iUnoTR6tkWb0j14ZYhIIGysRJj9AC/Vmn30rpeGORO4WM0v3Cg/9rAxdGJXA3r51rN+jiJN9beRKfb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSW8qu6NSaRRk1XTkGygNRuy7hPhe1d8et9OFD7hsOUaQ3d5/Q
	vqwNdswKmMH2t14aK0bO9QN1+CXB11h7fQuCDhYEO7lmkV77WnfpFCEB6gi67Zu4hixrZuvIxR+
	zSPKUNLgFv8EwHUz9tMizzOMcJ+cP1b2ZXDxJlKXK8g==
X-Gm-Gg: ASbGncsOnQ+hVGdwnFXpIlrPNKnIhcKIoOgIyklPyeIsxZlWaSFguzeAmcH7wcvK8MG
	Eg73CXruQZiO3epvvN8aX44ozTwkPqI032Le8Ksp1uPLdQ9AaWe7VODv6Nhsx3eI0zYzOiveOwY
	dDwWBc83l5s074Q6jbgnjAdwt9bAPxzOEqLpkr8oWRouZdshzIlmwtNaf5PMAb879BF0Fvw91OS
	rV7yZF3EKhLyCgzJYrqRW6lzbpVz1DZYDQkYlmmeJecz7cigoT7G7hb+TBqYPto+rhAPcsn
X-Google-Smtp-Source: AGHT+IEq9I1p8OP3yDbh00Mj9+qoqszlTYDSFXyp8DuqLQvxre/JkxTDPf1QjwQFRLpKChHb1al8+Tk6n1fWExeFbow=
X-Received: by 2002:a05:6e02:3044:b0:433:258e:5a92 with SMTP id
 e9e14a558f8ab-4335f479c79mr44021005ab.32.1762513440480; Fri, 07 Nov 2025
 03:04:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103062825.9084-1-dayss1224@gmail.com>
In-Reply-To: <20251103062825.9084-1-dayss1224@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 7 Nov 2025 16:33:48 +0530
X-Gm-Features: AWmQ_bktMTn5j_WJdcxCdJE6SpTHSxLvgVWZIkGAWguCXPvlqqDsCY8TuZP0sdM
Message-ID: <CAAhSdy01XGT6psT+3EgHbgyyOhuXP63Zv1K2acvDZKD0LxxQ=w@mail.gmail.com>
Subject: Re: [PATCH] KVM: riscv: Support enabling dirty log gradually in small chunks
To: dayss1224@gmail.com
Cc: ajones@ventanamicro.com, atishp@atishpatra.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, Quan Zhou <zhouquan@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 11:58=E2=80=AFAM <dayss1224@gmail.com> wrote:
>
> From: Dong Yang <dayss1224@gmail.com>
>
> There is already support of enabling dirty log gradually in small chunks
> for x86 in commit 3c9bd4006bfc ("KVM: x86: enable dirty log gradually in
> small chunks") and c862626 ("KVM: arm64: Support enabling dirty log
> gradually in small chunks"). This adds support for riscv.
>
> x86 and arm64 writes protect both huge pages and normal pages now, so
> riscv protect also protects both huge pages and normal pages.
>
> On a nested virtualization setup (RISC-V KVM running inside a QEMU VM
> on an [Intel=C2=AE Core=E2=84=A2 i5-12500H] host), I did some tests with =
a 2G Linux
> VM using different backing page sizes. The time taken for
> memory_global_dirty_log_start in the L2 QEMU is listed below:
>
> Page Size      Before    After Optimization
>   4K            4490.23ms         31.94ms
>   2M             48.97ms          45.46ms
>   1G             28.40ms          30.93ms
>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Dong Yang <dayss1224@gmail.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-6.19

Thanks,
Anup


> ---
>  Documentation/virt/kvm/api.rst    | 2 +-
>  arch/riscv/include/asm/kvm_host.h | 3 +++
>  arch/riscv/kvm/mmu.c              | 5 ++++-
>  3 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.=
rst
> index 57061fa29e6a..3b621c3ae67c 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -8028,7 +8028,7 @@ will be initialized to 1 when created.  This also i=
mproves performance because
>  dirty logging can be enabled gradually in small chunks on the first call
>  to KVM_CLEAR_DIRTY_LOG.  KVM_DIRTY_LOG_INITIALLY_SET depends on
>  KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE (it is also only available on
> -x86 and arm64 for now).
> +x86, arm64 and riscv for now).
>
>  KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 was previously available under the nam=
e
>  KVM_CAP_MANUAL_DIRTY_LOG_PROTECT, but the implementation had bugs that m=
ake
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/k=
vm_host.h
> index 4d794573e3db..848b63f87001 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -59,6 +59,9 @@
>                                          BIT(IRQ_VS_TIMER) | \
>                                          BIT(IRQ_VS_EXT))
>
> +#define KVM_DIRTY_LOG_MANUAL_CAPS   (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE=
 | \
> +       KVM_DIRTY_LOG_INITIALLY_SET)
> +
>  struct kvm_vm_stat {
>         struct kvm_vm_stat_generic generic;
>  };
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 525fb5a330c0..a194eee256d8 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -161,8 +161,11 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>          * allocated dirty_bitmap[], dirty pages will be tracked while
>          * the memory slot is write protected.
>          */
> -       if (change !=3D KVM_MR_DELETE && new->flags & KVM_MEM_LOG_DIRTY_P=
AGES)
> +       if (change !=3D KVM_MR_DELETE && new->flags & KVM_MEM_LOG_DIRTY_P=
AGES) {
> +               if (kvm_dirty_log_manual_protect_and_init_set(kvm))
> +                       return;
>                 mmu_wp_memory_region(kvm, new->id);
> +       }
>  }
>
>  int kvm_arch_prepare_memory_region(struct kvm *kvm,
> --
> 2.34.1
>

