Return-Path: <linux-kernel+bounces-891824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD37C439B0
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 08:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34CC84E30AB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 07:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48197245014;
	Sun,  9 Nov 2025 07:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e2sPnDco";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MEmCpwKH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983AE4C6D
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 07:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762672295; cv=none; b=OqQh1L5FRczE6tjTBcvQRVZC3bH8J3jQjzko8gIKcclbPduW2UdEh7sR4pDk7L77w/ow4CKi+cPiIhGp86P9xgoZyXVmfsZVGtJyL0KdVFfiboh93pKagA84beA9tmQjaCp+mgWdlDjCcap0Sys43463DG5k4v+8AKy3PDoCfi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762672295; c=relaxed/simple;
	bh=kleNJia2ZTeXUE4bhGdB2ccT09E5r2iOyKfFmRXgabs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FrxL1t+ZdlH/gMVVuLQB0TlNzGGlwGZzmvo/xA/cyq5LaIr+uvaTUDLanZCRGw7lC7orA4iG7YBfxTBJnW4ZYw7LGCaL/PYABTuZh1qX9KbGZ+sXDB7Cg9VSPYnaQbl5TiABwLZn/BNrHGZ6wPXzhdtLwP9/H1N7TJe5D02shDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e2sPnDco; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MEmCpwKH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762672292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V+85GBZrlaHqL20i3KHw/1cHlp67Sb2lFeW9i8R8xCw=;
	b=e2sPnDcoDeAOFzzbM03597JormQ8ztCA2nv9d+SYooFt2acM9i51J+rQWgYiwVScMRBr2t
	+NqkQ3bYERGQryJsl8wRzqM1q2D9dRRa9W2xlbsm1MYBD+qA/vA1gZlOYWIE93Zin8TkrA
	3Q2t3fBGiviZV9Dkz986WxqTUJ14JEQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-KWTqpDxWO_WXnJw976e_Ew-1; Sun, 09 Nov 2025 02:11:31 -0500
X-MC-Unique: KWTqpDxWO_WXnJw976e_Ew-1
X-Mimecast-MFC-AGG-ID: KWTqpDxWO_WXnJw976e_Ew_1762672290
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47754c0796cso18131515e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 23:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762672290; x=1763277090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+85GBZrlaHqL20i3KHw/1cHlp67Sb2lFeW9i8R8xCw=;
        b=MEmCpwKHN0SZqKMPbXnJAfJ2uAeSn3Xt7wli2Dei0RlHcGq38rVhoOk8eZQY0KV8Fg
         pelio/WQ5c2XzxUDQkz7IuwQHceMU79dkDaPjevMNILS07TAddVIFGeks1GSZEBuQ9A4
         9TLYpONFlZS2ozz2XNQb5Y8Un1nJC3Zb3qEljg36KIA5bTgC+fD/5yekDUCNL2JfK9FP
         XWOxcekTYMRoYXR6MgSGx0IhXbD9S0SAMA343jDMuCc35tbTzza9gIcxIrbtS6Mw+LBF
         PklKusXbiOTOtH24lruBhV+xOPXJIukr9FFngd0jbHT5oy2HC3bSf/GEdJpNdInXUjYT
         tTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762672290; x=1763277090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V+85GBZrlaHqL20i3KHw/1cHlp67Sb2lFeW9i8R8xCw=;
        b=GTYBlSau0LEEKC/m8vAbNkiXevi/9grDIzkTdN882T+nJXhfah2hu7UwZgLyV/0mac
         UeKMzt7gHErliHi5Fl/vWKvsJItxMeL8gKXsFdOJEYu7L3/Y3fo7MlV5fBwzrOzcPbjq
         UYYmsbL2tGvfug9tfXJNJoGo96n5tay9u95QvRGMRRVuPMGMog4QBEBF5fFJEi4RX9up
         VDpceiKBiEAO7I/bjKmCeafUV/d8u+Gm5xY19EoUDHGBJvj3stKngzj05MxqOE6FXhno
         8nwwxsRUQbK+YZNr0wJA931PqkxmVbES2lrlKzYonXbsyBuoNPdY6dYZlo7OESO3FHsS
         7TCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUziTiqgOhV8yxhQv2A1N8qdY1YaYiLC5+q0Mg2K/qlwY/ERtlsZ5Tob5zYwUqjeEh8wLFStJGuDYVngHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwildFzsYBGEJmOwUgKOm8vm2YXl8ucZtRDO7oMACfreMKS6d/E
	0sf7BoIaC+7LIoK+6lFHUhYX+Pnje+hnZEK1/PI/SLfc2TX2w+pK4BR07zrbgkxxBeGH+0tB5Sf
	zRZqNLGv2g7L0gwF6KNZS2V9zdaffZNld+oCH3A0+yF+qE/TIGVGUvGC3C/919qXwyZcxWvgUF+
	P0F69PUNCfuSI6drYgYyDO9JOnoJwvXjmjij7mWXAI
X-Gm-Gg: ASbGncu1WvO5XsVtzmZ3Y+urPJ5AWWRhv1BgxnqXcw0dFyidC/9NAi1U/fr93/LVZBx
	nspqQVNaJFOZo7X6KyTh6i/PVLOhbqgO9zevsdUfqvmWX+W7pgAJ6Uh6ZtadWcLGJnLVHEIYLS1
	dtlyGkZw5377hpC/SIdu0FuNFOpnFr/ENpRMaJoH/K8ykAcNvACoYd1RefO9p7AuXNVY+FWkTJE
	8J9A5IHoTlQ93mCKxnbjmOs9K7QhhH4MvVdwy04ai5PGcIuWBAzrtLdQ6nh
X-Received: by 2002:a05:600c:1914:b0:477:7b30:a6fd with SMTP id 5b1f17b1804b1-4777b30a840mr1842415e9.38.1762672289802;
        Sat, 08 Nov 2025 23:11:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUFy4A1I/UPZ2nCm19XoNW1F5K3uGFA9JHRDZe/xv09ho4lieokZsvPaPy5utqacw8PSloKPY5EuSkJ/fvkvo=
X-Received: by 2002:a05:600c:1914:b0:477:7b30:a6fd with SMTP id
 5b1f17b1804b1-4777b30a840mr1842195e9.38.1762672289330; Sat, 08 Nov 2025
 23:11:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107223807.860845-1-seanjc@google.com>
In-Reply-To: <20251107223807.860845-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 9 Nov 2025 08:11:17 +0100
X-Gm-Features: AWmQ_bm_eiQTIYBQ-UlzSUD1gfohxPiaw1pLYc8l92GaGGAHuetyCO9czoSArXo
Message-ID: <CABgObfZD_twm6hgP6BuHt39pK0M6nShVFFszA8SaT8c1h-2N+A@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86 fixes and a guest_memd fix for 6.18
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 11:38=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Please pull a variety of fixes that fall into one of three categories:
>
>  - Recent-ish TDX-induced bugs (VM death on SEAMCALL/TDCALL, and my
>    paperbag GVA_IS_VALID goof).
>
>  - Long-standing issues that were exposed and/or are made releavnt by
>    6.18 (guest_memfd UAF race, GALog unregister and ir_list_lock from AVI=
C).
>
>  - Bugs introduce in 6.18 (splat when emulating INIT for CET XSTATE).

Pulled, thanks.

Paolo

> The following changes since commit 4361f5aa8bfcecbab3fc8db987482b9e08115a=
6a:
>
>   Merge tag 'kvm-x86-fixes-6.18-rc2' of https://github.com/kvm-x86/linux =
into HEAD (2025-10-18 10:25:43 +0200)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-fixes-6.18-rc5
>
> for you to fetch changes up to d0164c161923ac303bd843e04ebe95cfd03c6e19:
>
>   KVM: VMX: Fix check for valid GVA on an EPT violation (2025-11-06 06:06=
:18 -0800)
>
> ----------------------------------------------------------------
> KVM x86 fixes for 6.18:
>
>  - Inject #UD if the guest attempts to execute SEAMCALL or TDCALL as KVM
>    doesn't support virtualization the instructions, but the instructions
>    are gated only by VMXON, i.e. will VM-Exit instead of taking a #UD and
>    thus result in KVM exiting to userspace with an emulation error.
>
>  - Unload the "FPU" when emulating INIT of XSTATE features if and only if
>    the FPU is actually loaded, instead of trying to predict when KVM will
>    emulate an INIT (CET support missed the MP_STATE path).  Add sanity
>    checks to detect and harden against similar bugs in the future.
>
>  - Unregister KVM's GALog notifier (for AVIC) when kvm-amd.ko is unloaded=
.
>
>  - Use a raw spinlock for svm->ir_list_lock as the lock is taken during
>    schedule(), and "normal" spinlocks are sleepable locks when PREEMPT_RT=
=3Dy.
>
>  - Remove guest_memfd bindings on memslot deletion when a gmem file is dy=
ing
>    to fix a use-after-free race found by syzkaller.
>
>  - Fix a goof in the EPT Violation handler where KVM checks the wrong
>    variable when determining if the reported GVA is valid.
>
> ----------------------------------------------------------------
> Chao Gao (1):
>       KVM: x86: Call out MSR_IA32_S_CET is not handled by XSAVES
>
> Maxim Levitsky (1):
>       KVM: SVM: switch to raw spinlock for svm->ir_list_lock
>
> Sean Christopherson (7):
>       KVM: VMX: Inject #UD if guest tries to execute SEAMCALL or TDCALL
>       KVM: x86: Unload "FPU" state on INIT if and only if its currently i=
n-use
>       KVM: x86: Harden KVM against imbalanced load/put of guest FPU state
>       KVM: SVM: Initialize per-CPU svm_data at the end of hardware setup
>       KVM: SVM: Unregister KVM's GALog notifier on kvm-amd.ko exit
>       KVM: SVM: Make avic_ga_log_notifier() local to avic.c
>       KVM: guest_memfd: Remove bindings on memslot deletion when gmem is =
dying
>
> Sukrit Bhatnagar (1):
>       KVM: VMX: Fix check for valid GVA on an EPT violation
>
>  arch/x86/include/uapi/asm/vmx.h |  1 +
>  arch/x86/kvm/svm/avic.c         | 24 +++++++++++++--------
>  arch/x86/kvm/svm/svm.c          | 15 +++++++------
>  arch/x86/kvm/svm/svm.h          |  4 ++--
>  arch/x86/kvm/vmx/common.h       |  2 +-
>  arch/x86/kvm/vmx/nested.c       |  8 +++++++
>  arch/x86/kvm/vmx/vmx.c          |  8 +++++++
>  arch/x86/kvm/x86.c              | 48 +++++++++++++++++++++++++----------=
------
>  virt/kvm/guest_memfd.c          | 47 ++++++++++++++++++++++++++++-------=
-----
>  9 files changed, 106 insertions(+), 51 deletions(-)
>


