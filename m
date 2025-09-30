Return-Path: <linux-kernel+bounces-837966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E75BAE257
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16EE1942645
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C1C30595D;
	Tue, 30 Sep 2025 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bd8U0MNj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EA11684B0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759252638; cv=none; b=lmbpS7w240FL8nxQU3qnZuWtAk1Cymbuh4M8DDOe33aKEOTN8We7sWKJuS+bcNUDTcJBukdmSO11uXJxu6TOoBv3Rm2HySTN6aPaLTG6I1ZyZzMIRnq6kTjY6EZzDvmPVkfJVcThJYN4535s6T605QAoyfRZNqWdWTx+QRykLec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759252638; c=relaxed/simple;
	bh=2TA85JhG88MKTbU/gfG3nGwNs6z1JUIysIQJJDXAdOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tjQbjP84tEMP1wIgddhMLjKT/dBgt1bG0CJLdzDSIPHlRbSADPcQw9V9oEYG9wAblfv0jQwIRgAg1YgCsU39FFZ1Td7NYIv2KOuQUm2Oe2kLySyLNlV/KCv2JqErdYjhoXy4CxQmerJBdeGFzxHJrOIDXdyhXxRLYp1GHIhivR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bd8U0MNj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759252635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2C3tUWszDTmoiAk0dwZyFPIXw5qdDN0uqN1IQdkVOiw=;
	b=Bd8U0MNjm51ErcWlYyDV4VsMT+k9/dwtLvNA4DLaJE78NTsnduU5XiBWCjk6Lqspv/KhK8
	r+BiudE/gmHuJYOPRdPycNOE7eWCFs7qb7Sf9aeIZvO5FYeDlXa1d9yjgkIxj8YK7PTwxE
	Po+3oPHfMWCYHFLHED1eYDzT4m4+NaA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-T_0Or4HtNdSriKjgDl0tpg-1; Tue, 30 Sep 2025 13:17:13 -0400
X-MC-Unique: T_0Or4HtNdSriKjgDl0tpg-1
X-Mimecast-MFC-AGG-ID: T_0Or4HtNdSriKjgDl0tpg_1759252632
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ef9218daf5so5740765f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759252632; x=1759857432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2C3tUWszDTmoiAk0dwZyFPIXw5qdDN0uqN1IQdkVOiw=;
        b=n3vtgsXDjbKJ0m4M7yFQXaGQWKukJ5LwuPr14MFM2IBIcwvMuZ2uZK+KIN4hqNP+J6
         GLuxp4jSbgj8hA/fMFXGJwpvVurkklSZwiiuOWJkXrv3mBym95p+9eqo5NSWUYQ9OhS+
         Qh5Wr8K5+/Mmijw1oR4ZkBJqGazFJJT+wLeH37tNxXlfhM8NuFgIv3x8IjB7DgFETEQ7
         +dc4UQnn3sPQ1h4vdpAPeDqSMm7I/2onqMO9ND3B+6h2rKPnPgkROXjiVuGUzAa9pMjP
         ie+E8UFzw+uS15vhSI5M4X3H5li5QzamfTB/yMQEOnypUs+cgy9/CU1J5eFWHCk/E/HN
         E2BQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3FsTn6ecGv5WXeq89oGYUHtpMVEWPqYow/K/uNQGQdxPIGoQRFerscUg6JtQYRhw7auyiQuW2N26rriM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFSiWrLOBabvRcv9z538qScsTjfovA1oroj89inplrTRzmK9tH
	D7n7RKoh8T/BxEN+uUIdIMFu0j+0pXaJJYfRPQTx6Rp/nTucmzAUCzHP/vCG1MkkmlMybXiw14F
	NPGEXGtjm7l6vspnWAqoMwuobadWrDG2Fu/PIwshqwUNkXDzuzNX4Xo+sLqiNKxW/zQt2itOd6O
	b0ORbiVxmPtfbOdn/DNuV0mlKM3BZVYeeN/XSZWi4S
X-Gm-Gg: ASbGncugcf//kpjfzTqO2OBsiV95gVFl2pHwaFxO7d8hNisR4vJP+gHOU8l1z58qrG7
	gLmu3dvFk/o6ng/gVZ7TnjGgQFd/vzY6e+zrwkRU5iZ5n1UyX8G8LF6ezUYM5oHGydN9beR/wuA
	vIzT8Cjxg5voD2qIB4q441EKnFhO8kk5zU2TLeFf9Yf3rPl0u6gxks/VSPV6h9MwpfL7iN/HYpq
	46ckdaaN586N0xHXiDP4YsheI1IE1mJ
X-Received: by 2002:a05:6000:3103:b0:3ec:7583:3b76 with SMTP id ffacd0b85a97d-425577f3212mr441488f8f.22.1759252632256;
        Tue, 30 Sep 2025 10:17:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlWCVGpeAZLUKs0K+oxbN18oiVm08xlLaObPt5b2kGu4QXgX8tqNJMKW9uG4wk/tLSn8ve7rDKzfDZGh7oUUo=
X-Received: by 2002:a05:6000:3103:b0:3ec:7583:3b76 with SMTP id
 ffacd0b85a97d-425577f3212mr441456f8f.22.1759252631740; Tue, 30 Sep 2025
 10:17:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924081305.3068787-1-chenhuacai@loongson.cn>
In-Reply-To: <20250924081305.3068787-1-chenhuacai@loongson.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 30 Sep 2025 19:16:59 +0200
X-Gm-Features: AS18NWCIAUHM6q-f3EVvW3Rf6Uwq0MmF38t06GUExmaXllterNGLylxJXrEqQ8Y
Message-ID: <CABgObfZvdkAR6YGx7HKT+aVaE06w=FG7Jus=3B6nxadDiv5c_Q@mail.gmail.com>
Subject: Re: [GIT PULL] LoongArch KVM changes for v6.18
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 10:15=E2=80=AFAM Huacai Chen <chenhuacai@loongson.c=
n> wrote:
>
> The following changes since commit 07e27ad16399afcd693be20211b0dfae63e061=
5f:
>
>   Linux 6.17-rc7 (2025-09-21 15:08:52 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson=
.git tags/loongarch-kvm-6.18
>
> for you to fetch changes up to 66e2d96b1c5875122bfb94239989d832ccf51477:
>
>   LoongArch: KVM: Move kvm_iocsr tracepoint out of generic code (2025-09-=
23 23:37:26 +0800)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> LoongArch KVM changes for v6.18
>
> 1. Add PTW feature detection on new hardware.
> 2. Add sign extension with kernel MMIO/IOCSR emulation.
> 3. Improve in-kernel IPI emulation.
> 4. Improve in-kernel PCH-PIC emulation.
> 5. Move kvm_iocsr tracepoint out of generic code.
>
> ----------------------------------------------------------------
> Bibo Mao (9):
>       LoongArch: KVM: Add PTW feature detection on new hardware
>       LoongArch: KVM: Add sign extension with kernel MMIO read emulation
>       LoongArch: KVM: Add sign extension with kernel IOCSR read emulation
>       LoongArch: KVM: Add implementation with IOCSR_IPI_SET
>       LoongArch: KVM: Access mailbox directly in mail_send()
>       LoongArch: KVM: Set version information at initial stage
>       LoongArch: KVM: Add IRR and ISR register read emulation
>       LoongArch: KVM: Add different length support in loongarch_pch_pic_r=
ead()
>       LoongArch: KVM: Add different length support in loongarch_pch_pic_w=
rite()
>
> Steven Rostedt (1):
>       LoongArch: KVM: Move kvm_iocsr tracepoint out of generic code
>
> Yury Norov (NVIDIA) (1):
>       LoongArch: KVM: Rework pch_pic_update_batch_irqs()
>
>  arch/loongarch/include/asm/kvm_pch_pic.h |  15 +-
>  arch/loongarch/include/uapi/asm/kvm.h    |   1 +
>  arch/loongarch/kvm/exit.c                |  19 +--
>  arch/loongarch/kvm/intc/ipi.c            |  80 ++++++-----
>  arch/loongarch/kvm/intc/pch_pic.c        | 239 +++++++++++++------------=
------
>  arch/loongarch/kvm/trace.h               |  35 +++++
>  arch/loongarch/kvm/vcpu.c                |   2 +
>  arch/loongarch/kvm/vm.c                  |   4 +
>  include/trace/events/kvm.h               |  35 -----
>  9 files changed, 211 insertions(+), 219 deletions(-)
>


