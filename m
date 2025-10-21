Return-Path: <linux-kernel+bounces-861974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9A6BF42E1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 02:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A9CD3AD204
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 00:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C281F9F51;
	Tue, 21 Oct 2025 00:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vqqqYEUo"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C58E1E7C19
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761007807; cv=none; b=ngds/x+8F6bhRsGPaVnZNsgR/W2awYSVYjbtWPEPr8CGtYrXnWYB46Mpif+xlwv8GocNEdoGHfctMxCbBChLLy2etiJHcOMPR7ASaT+ukYhczfORgtyfM3OKINvnPckYkJ6soA8d1yUEv4VkCIwShk/CVqkUlkbiBLOMCnXoWn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761007807; c=relaxed/simple;
	bh=ZGWivTpUYnZX7sHhix36ODIkKD97NtBaXgMM9UW09Z8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fg78E5tYp5qgn3EoOWXOLjHcUV9kf0e6QsTtxOKiecJNZUva9Eqwlnbtdwd1ehFJ3s+STK9CPFfrccqQXCENyEqzfup6OjbnO8q3nEYGpZz9ODOR6bKxJ0uhT2/sy3dod90vrR9KuqNslgiiwFsl4x1zjeCYQykycn8q58P4gCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vqqqYEUo; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3304def7909so4097286a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 17:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761007804; x=1761612604; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jElfUXW8wCp0wFBdm2MwcKv7Fj5XfZurPdvK1+KQDTc=;
        b=vqqqYEUownZ2z6Ypt5XH4CVoBf7enyfOJwR9OhqkRecLQySA+B0N/Hdu+e0RiQvLmq
         OXwanivrzyF8lfBqFOAGj6rUMP9Iu9dbjEe4gbS/1+DCnAgaydwqb6wvg2eI9wvba+i7
         XSuPHeFrdgIJxL3Sv1s2n6IKdHkU1RMTLBNzSi/k68GwI98XpXVtg9naT/dv19Qg673q
         cN8UVIhVozpr9FvsiHOMtzfe/3YSpqBckVCjCXhsFkexdttn7lVbsRC/YiqxhA0ZMl/x
         hLsCr1HeQzChHJaDeDgcNEEwV0lq0xuRJTCxidEPadtV3Q80dF5m1DMmg5PIv9XmrItZ
         kiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761007804; x=1761612604;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jElfUXW8wCp0wFBdm2MwcKv7Fj5XfZurPdvK1+KQDTc=;
        b=l1Gez6H12r9101ims2QC9MSxjd2v4CI/93UA3xlXNjXQAhrruLSH1utYy/OmM5s9D0
         y7YDKSv4ZveMbdiR4B/gkruPAzpNsIORhiv5e8/ZZwVcKqCZilw/sJbkAgeVpeQIocnD
         tATV4wzYcuDs4SYnpOS9HeIO43kgdWTdJ99gG6z/dTpvFXp5MtghabbBTismW5tuXmcp
         VSilg2IJtk0FOB5zkksCLr0chz+BvWRLLCCKiN9JvGqdFDF9Le39HjRigOLxPo3q9B2J
         55dKQADFgTA3aKisvjYqTz8rVLsP9QfAqGAI/lr1ps3WrWL3/tlck6TDLXDfw6Mq5d75
         ZFAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEbvi+O57g2/F7sDj9QSVegLidYHl8SbF7gAf/nMYuVRrFmVB4CdHfNd5ElxGZYl3qilzuRPmOcB7lOv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSuDp2LG4Hj2fzibR2WS4eW5N0Wsg8lFEMf9PHFPPj/HcM4S5v
	ysDfpJA0XAciNRqNpUfbjgfoMZIaQPMTuwfX24OnylFKlZ5V3Jp2tGKl5jIn4x8qMqF9IaSYkUt
	M0C334g==
X-Google-Smtp-Source: AGHT+IHdLNrdOSrC/dgKGwuDlIyF6hKyTRHuSK/jL8AhomiAuV/wuXp+VqpnA+jc5SjQ69PU54+FpTq2Rlc=
X-Received: from pjbnc11.prod.google.com ([2002:a17:90b:37cb:b0:33b:caf7:2442])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:28c4:b0:32e:5646:d43f
 with SMTP id 98e67ed59e1d1-33bcf8e96d3mr20061024a91.19.1761007804269; Mon, 20
 Oct 2025 17:50:04 -0700 (PDT)
Date: Mon, 20 Oct 2025 17:50:02 -0700
In-Reply-To: <23072856-6b8c-41e2-93d1-ea8a240a7079@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251007160704.1673584-1-sascha.bischoff@arm.com> <23072856-6b8c-41e2-93d1-ea8a240a7079@sirena.org.uk>
Message-ID: <aPbYuvlLzLENTCcP@google.com>
Subject: Re: [PATCH] KVM: arm64: gic-v3: Only set ICH_HCR traps for v2-on-v3
 or v3 guests
From: Sean Christopherson <seanjc@google.com>
To: Mark Brown <broonie@kernel.org>
Cc: Sascha Bischoff <Sascha.Bischoff@arm.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, nd <nd@arm.com>, 
	"maz@kernel.org" <maz@kernel.org>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>, Joey Gouly <Joey.Gouly@arm.com>, 
	Suzuki Poulose <Suzuki.Poulose@arm.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Aishwarya.TCV@arm.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 21, 2025, Mark Brown wrote:
> On Tue, Oct 07, 2025 at 04:07:13PM +0000, Sascha Bischoff wrote:
> > The ICH_HCR_EL2 traps are used when running on GICv3 hardware, or when
> > running a GICv3-based guest using FEAT_GCIE_LEGACY on GICv5
> > hardware. When running a GICv2 guest on GICv3 hardware the traps are
> > used to ensure that the guest never sees any part of GICv3 (only GICv2
> > is visible to the guest), and when running a GICv3 guest they are used
> > to trap in specific scenarios. They are not applicable for a
> > GICv2-native guest, and won't be applicable for a(n upcoming) GICv5
> > guest.
> 
> v6.18-rc2 introduces a failure in the KVM no-vgic-v3 selftest on what
> appears to be all arm64 platforms with a GICv3 in all of VHE, nVHE and
> pKVM modes:
> 
> # selftests: kvm: no-vgic-v3
> # Random seed: 0x6b8b4567
> # ==== Test Assertion Failure ====
> #   arm64/no-vgic-v3.c:66: handled
> #   pid=3469 tid=3469 errno=4 - Interrupted system call
> #      1	0x0000000000402ff7: test_run_vcpu at no-vgic-v3.c:128
> #      2	0x0000000000402213: test_guest_no_gicv3 at no-vgic-v3.c:155
> #      3	 (inlined by) main at no-vgic-v3.c:174
> #      4	0x0000ffff7fca7543: ?? ??:0
> #      5	0x0000ffff7fca7617: ?? ??:0
> #      6	0x00000000004023af: _start at ??:?
> #   ICC_PMR_EL1 no read trap
> not ok 25 selftests: kvm: no-vgic-v3 # exit=254
> 
> introduced by this patch, which is commit 3193287ddffb and which never
> appeared in -next prior to being merged into mainline.
> 
> It didn't appear in -next since the arm64 KVM fixes tree is not directly
> in -next and it was only pulled into Paolo's tree on Saturday, a few
> hours before Paolo sent his pull request to Linus, so there was no
> opportunity for it to be picked up.  As I've previously suggested it
> does seem like it would be a good idea to include the fixes branches for
> the KVM arch trees in -next (s390 is there, but I don't see the others),

FWIW, "kvm-x86 fixes" is in -next (unless I've screwed up recently), it just gets
routed in via "kvm-x86 next" via an octopus merge.

> and/or to have more cooking time between things being pulled into the
> main KVM fixes branch and being sent to Linus.

