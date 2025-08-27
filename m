Return-Path: <linux-kernel+bounces-788622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC63EB3876B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E6744E319B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFB52C2358;
	Wed, 27 Aug 2025 16:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XBUSXGrU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B202DFA3C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 16:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310949; cv=none; b=h5OSpdGYuuOHxlE5yMUwk4V0eOq+GNURr0/+3f7JUkQGQ5R3mu3LmnVtkb9lELlaJ9jaEW10ERFxztAw39UZLI9FYSCngnb6pgF9LZnl6VOC4MHnsEX5M8Rv8ENDuXafEvjKOlwZetqZKNFS4/84m0P9cFInsneBOhK6BI34Vgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310949; c=relaxed/simple;
	bh=wlTH+5UGUT9Xvxi73T4MXazMDiYu+KQldwNPj3NcMc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URoqyrs1NBvP/gKmV5Ax3dJ+VIp5IrGfZ3Xb2gwagLX+SL/6tEnS/0dlxC6DL17aRTwoqzn+G4qLqmb99LCg3ZUvz3kRHWopYYHDFwpkYII33QiMy1kQ9H1aQUpKnS2IScuwAyEeEctB5sOGnroOcz9y6AFlUAPFVtq1irkWhkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XBUSXGrU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756310946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aziSJBo5W0zZFPc57AR4Qia1md3fUN9PvjS7bGiGW2g=;
	b=XBUSXGrUBChLdZ4+Tfx2FOQVoP3m57MiKVLagmk7s9+rPN6oljNCkPFSS7Lf1dpGIQJkPj
	7BULTBzB1/0ml19rSohnUeRmnHRIheAxX5l7X6+5/m+IEV4fqYMAE70CbFmSfC8Z4gu/hb
	O87oTUs5p6Oduyi+DV2l7ItcbQKpa2I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-7Z2RFrZ2N_e3HuJUHp_Qcg-1; Wed, 27 Aug 2025 12:09:04 -0400
X-MC-Unique: 7Z2RFrZ2N_e3HuJUHp_Qcg-1
X-Mimecast-MFC-AGG-ID: 7Z2RFrZ2N_e3HuJUHp_Qcg_1756310944
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b71fe31ffso5236845e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 09:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756310944; x=1756915744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aziSJBo5W0zZFPc57AR4Qia1md3fUN9PvjS7bGiGW2g=;
        b=kbFSwtkSV+Gv5F43HYqanbV9x3IrxVdhA/CXbRRtyZOSru72awZaZw5SJJ5v7JSAON
         iSZIojRoRjG6fzlAc2BQVX3yUG/OiHv36XOPGJZ6NVnfx86JXYg08J8ejS1SCkcgM+rL
         utOAS6JCvUv+FvU8E+3RknO0TEPRElysF9RZHHNQwebJCyGRmoq+DJ+724voLn4/i4VD
         kLLyXvLY/g1Hls2/32jTJvQovR1Gpg+3AEW/PWfrO4tJsa+Yq3Qp7Klv9PMulFNRF1P6
         34vGFa12T7cUlzL9F77SIs7QCUcM2mB1bWwEc4U1pRojPiQ1E73fC+dqrH3MoXJ/9BYd
         Yrng==
X-Forwarded-Encrypted: i=1; AJvYcCVskbjnZD/MclhkH+Zr3PSzgMnUy2/NcycN0VrMzp2+y1iQxvcAlVCgXfYeqMH7tFrK9mIVs5qwhxU7wRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKNslexzk/RaWsB7CyMMi9sZSSGledkByT/TigE1ciGMEEFSy7
	NdAbp1t0AFVFIunqe7VP8PDAmJB3U6M8b8zxKB1WOgVXzJZhwrkvUPkAgRsje1TF2cKjTLZq1um
	wIvKcbk5PcF3BrZFSRPl/MoPRPAp08QStn6pJvaxnAKIi2HXjT3Al6WHf9HjKp98nQLrVAcARQw
	8lzDufGV5LvwwXNb6JxF71Dzlt21EiVa5sz6ccHUoy
X-Gm-Gg: ASbGncvbIvLPY8i1q4wlxeELr3sT2TpT8HvfCzNdiIHTsGZ2pnjqbA7ZM6K8fa5FL1Z
	mMaIoJiXq7G0y/qd9ey6V4OpurQz3Cla/DpWoGzWKtNJ0OC6Vvgfr/Uk2pwAWZ563QAtshVo8MF
	gII/B+y7WrJRO11k2lJCJZ2qE5AFyd7tDqLtHDTrL7UZScnZhbaDr8FMR2eIjbVnTMFXE+Kt2fT
	DxpLmDxg2xaAdLMU+TEUb7v
X-Received: by 2002:a05:6000:4283:b0:3ca:3206:292 with SMTP id ffacd0b85a97d-3ca3206064fmr8023184f8f.48.1756310943665;
        Wed, 27 Aug 2025 09:09:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyzruEFQtE9U3R7B7rCEUd8qatzIadAOnmk2mQCbEKGI0DFr7kcsvt9yS7Q0qnfidsQFJAmgRQ1SijtcNlzA4=
X-Received: by 2002:a05:6000:4283:b0:3ca:3206:292 with SMTP id
 ffacd0b85a97d-3ca3206064fmr8023149f8f.48.1756310943213; Wed, 27 Aug 2025
 09:09:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827152754.12481-1-lifei.shirley@bytedance.com> <aK8r11trXDjBnRON@google.com>
In-Reply-To: <aK8r11trXDjBnRON@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 27 Aug 2025 18:08:51 +0200
X-Gm-Features: Ac12FXyXHiiKVDGGLGUulr7kfdt9R7TiAvRQk5lVCccDer67HJTPi0VyzHtDREc
Message-ID: <CABgObfYqVTK3uB00pAyZAdX=Vx1Xx_M0MOwUzm+D1C04mrVfig@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Latch INITs only in specific CPU states in KVM_SET_VCPU_EVENTS
To: Sean Christopherson <seanjc@google.com>
Cc: Fei Li <lifei.shirley@bytedance.com>, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, liran.alon@oracle.com, 
	hpa@zytor.com, wanpeng.li@hotmail.com, kvm@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 6:01=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, Aug 27, 2025, Fei Li wrote:
> > Commit ff90afa75573 ("KVM: x86: Evaluate latched_init in
> > KVM_SET_VCPU_EVENTS when vCPU not in SMM") changes KVM_SET_VCPU_EVENTS
> > handler to set pending LAPIC INIT event regardless of if vCPU is in
> > SMM mode or not.
> >
> > However, latch INIT without checking CPU state exists race condition,
> > which causes the loss of INIT event. This is fatal during the VM
> > startup process because it will cause some AP to never switch to
> > non-root mode. Just as commit f4ef19108608 ("KVM: X86: Fix loss of
> > pending INIT due to race") said:
> >       BSP                          AP
> >                      kvm_vcpu_ioctl_x86_get_vcpu_events
> >                        events->smi.latched_init =3D 0
> >
> >                      kvm_vcpu_block
> >                        kvm_vcpu_check_block
> >                          schedule
> >
> > send INIT to AP
> >                      kvm_vcpu_ioctl_x86_set_vcpu_events
> >                      (e.g. `info registers -a` when VM starts/reboots)
> >                        if (events->smi.latched_init =3D=3D 0)
> >                          clear INIT in pending_events
>
> This is a QEMU bug, no?

I think I agree.

> IIUC, it's invoking kvm_vcpu_ioctl_x86_set_vcpu_events()
> with stale data.

More precisely, it's not expecting other vCPUs to change the pending
events asynchronously.

> I'm also a bit confused as to how QEMU is even gaining control
> of the vCPU to emit KVM_SET_VCPU_EVENTS if the vCPU is in
> kvm_vcpu_block().

With a signal. :)

Paolo


