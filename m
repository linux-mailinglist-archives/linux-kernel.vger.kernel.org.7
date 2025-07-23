Return-Path: <linux-kernel+bounces-743018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFE5B0F990
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E74067A2DC2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662D1221714;
	Wed, 23 Jul 2025 17:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xZ0e1Yx4"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BF082C60
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 17:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753292890; cv=none; b=Yjm3+Dq6qYy1AJe42F8KsmYBbGPgXAfwLhkQtGzlPQCCN2kiSviDW+Kfu5BZvvi72s70kNb9d17bwZnyXUYzT0H0ykRPGs+QH32GqcHKaynAmYbPRYyDk4k8Ijp9+Gz9VAsaq9twb7CBmuS3/uyuGdJdpvnaqq5kZ82mBQUC5BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753292890; c=relaxed/simple;
	bh=7ZDsF+RzE2dg/23aYgkjRXFwK+8IUwygnYna1KJWmTA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aNAn+nmY822Qmry54+UixFStERSCtkX2Nhi/PMx2QYTgSFsFMXTCmsvAmVW7M18PEv9VqhluPBSCIuViDrv2YZvLhvWmzNo7UGeD2Q0Re+pSIVbeW/RR4nohwf0jUjA/HrFDyJfYkFeMvw90MIEOlm4RErseYtHXyAzelhUSlB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xZ0e1Yx4; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311a6b43ed7so97079a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753292888; x=1753897688; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uaYBRl0EE4KRkLgolaKNDBtU6vVnp/5Paw/stFPZacI=;
        b=xZ0e1Yx4z12f5reqCUmxKYYhNKBF7Gy6yDRVrihBmvFIPQ1AtUU1EaflyFatT/DBaj
         1iibSJReVpJiENqU1p8QLTcZ11qIn4SiQNcRe4HBdMQfvQaESq/RXWGoemy0HmOsTOM9
         N5Wf77fzRehqrI/CcAolkfhhVaOBqh/V9q6DFlHvn0JYNI3NN6QEpyVG6hSMNIDv/ibk
         TQNWGApFSNt3UG8AwaDNwNi/D/F9CdoliPdkyaSBxbSd/Wtup+3HDRqp8WRxtgChTixp
         NqIKtG6otSde+qVgVX6hg12mi7MqFIby8dBuOrCkNyNAPEBnWDa5gv72xWmyRghO03yc
         ITxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753292888; x=1753897688;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uaYBRl0EE4KRkLgolaKNDBtU6vVnp/5Paw/stFPZacI=;
        b=OCb0X281Fsp05GIYxxQ77+wzEOdfoAWirXc816Kt8u0uq43lcI9tjvmkrdqsBx97gO
         4oL/Ak4U9DIjpc484Ks8hthX7dsvIXVknkBd2dkgXCc0iNXqYsvqwRSLjMB8FgPm0TCk
         6KaAs4uGLPgEJ6oiciB5Y6w9YUpAF+uwxs+512J0JMSqVerzzkap8BclHhsi97SvPa7x
         NkXSKLXsy9yJBqlYVuPUNPZR9wYUdpztWIPSxJ+gNJ0s+mEO9pJW8Vce0vDyKqCHXh81
         pQti0DVbDFmbmpPdrb5T5pnPU3y6wmypr5IcCLH1Nq9eAYUtnJeTPxLLfj8tzojWY9eZ
         +eEQ==
X-Gm-Message-State: AOJu0Yx74jrGFiSGObIqsHpkefDCgh6wGYcMcvkjeA0abx29vD7+stT/
	Q3A0C3+NUiTxWQngb/hfHZuOaM5mKa5M86h10pCQqHqiX6ke2eJyWZ5VGEwILEbV2lkQdC94SWF
	MOKkypA==
X-Google-Smtp-Source: AGHT+IEATEGW2kmWHPmig6zPQ7Er+eTMngsfX//TWVAGu1HfHbe2AgPbsCxKvxu3rVqMiRcwPfBUdtVKczQ=
X-Received: from pjbsh5.prod.google.com ([2002:a17:90b:5245:b0:311:e71e:3fb9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2f10:b0:31e:4111:fd8c
 with SMTP id 98e67ed59e1d1-31e50818accmr6212363a91.16.1753292887969; Wed, 23
 Jul 2025 10:48:07 -0700 (PDT)
Date: Wed, 23 Jul 2025 10:48:06 -0700
In-Reply-To: <20250422161304.579394-2-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250422161304.579394-1-zack.rusin@broadcom.com> <20250422161304.579394-2-zack.rusin@broadcom.com>
Message-ID: <aIEgVpjXDR0BXgHq@google.com>
Subject: Re: [PATCH v2 1/5] KVM: x86: Centralize KVM's VMware code
From: Sean Christopherson <seanjc@google.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: linux-kernel@vger.kernel.org, Doug Covelli <doug.covelli@broadcom.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 22, 2025, Zack Rusin wrote:
> Centralize KVM's VMware specific code and introduce CONFIG_KVM_VMWARE to
> isolate all of it.

I think it makes sense to split this into two patches: one to move code around,
and then one to add CONFIG_KVM_VMWARE.  And move _all_ of the code at once, e.g.
enable_vmware_backdoor should be moved to vmware.c along with all the other code
shuffling, not as part of "Allow enabling of the vmware backdoor via a cap".

> Code used to support VMware backdoor has been scattered around the KVM
> codebase making it difficult to reason about, maintain it and change
> it. Introduce CONFIG_KVM_VMWARE which, much like CONFIG_KVM_XEN and
> CONFIG_KVM_VMWARE for Xen and Hyper-V, abstracts away VMware specific
> parts.
> 
> In general CONFIG_KVM_VMWARE should be set to y and to preserve the
> current behavior it defaults to Y.
> 
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> Cc: Doug Covelli <doug.covelli@broadcom.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Zack Rusin <zack.rusin@broadcom.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: kvm@vger.kernel.org
> ---
>  MAINTAINERS               |   9 +++
>  arch/x86/kvm/Kconfig      |  13 ++++
>  arch/x86/kvm/emulate.c    |  11 ++--
>  arch/x86/kvm/kvm_vmware.h | 127 ++++++++++++++++++++++++++++++++++++++

My vote is to drop the "kvm" from the file name.  We have kvm_onhyperv.{c,h} to
identify the case where KVM is running as a Hyper-V guest, but for the case where
KVM is emulating Hyper-V, we use arch/x86/kvm/hyperv.{c,h}.

>  arch/x86/kvm/pmu.c        |  39 +-----------
>  arch/x86/kvm/pmu.h        |   4 --
>  arch/x86/kvm/svm/svm.c    |   7 ++-
>  arch/x86/kvm/vmx/vmx.c    |   5 +-
>  arch/x86/kvm/x86.c        |  34 +---------
>  arch/x86/kvm/x86.h        |   2 -
>  10 files changed, 166 insertions(+), 85 deletions(-)
>  create mode 100644 arch/x86/kvm/kvm_vmware.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 00e94bec401e..9e38103ac2bb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13051,6 +13051,15 @@ F:	arch/x86/kvm/svm/hyperv.*
>  F:	arch/x86/kvm/svm/svm_onhyperv.*
>  F:	arch/x86/kvm/vmx/hyperv.*
>  
> +KVM X86 VMware (KVM/VMware)
> +M:	Zack Rusin <zack.rusin@broadcom.com>
> +M:	Doug Covelli <doug.covelli@broadcom.com>
> +M:	Paolo Bonzini <pbonzini@redhat.com>
> +L:	kvm@vger.kernel.org
> +S:	Supported
> +T:	git git://git.kernel.org/pub/scm/virt/kvm/kvm.git
> +F:	arch/x86/kvm/kvm_vmware.*
> +
>  KVM X86 Xen (KVM/Xen)
>  M:	David Woodhouse <dwmw2@infradead.org>
>  M:	Paul Durrant <paul@xen.org>
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index ea2c4f21c1ca..9e3be87fc82b 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -178,6 +178,19 @@ config KVM_HYPERV
>  
>  	  If unsure, say "Y".
>  
> +config KVM_VMWARE
> +	bool "Features needed for VMware guests support"
> +	depends on KVM

Make this depend on KVM_x86.  See:

https://lore.kernel.org/all/20250723104714.1674617-3-tabba@google.com

> +	default y
> +	help
> +	  Provides KVM support for hosting VMware guests. Adds support for
> +	  VMware legacy backdoor interface: VMware tools and various userspace
> +	  utilities running in VMware guests sometimes utilize specially
> +	  formatted IN, OUT and RDPMC instructions which need to be
> +	  intercepted.
> +
> +	  If unsure, say "Y".
> +
>  config KVM_XEN
>  	bool "Support for Xen hypercall interface"
>  	depends on KVM
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index 60986f67c35a..b42988ce8043 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -26,6 +26,7 @@
>  #include <asm/debugreg.h>
>  #include <asm/nospec-branch.h>
>  #include <asm/ibt.h>
> +#include "kvm_vmware.h"

Please sort includes as best as possible.  KVM's loose rule is to organize by
linux => asm => local, and sort alphabetically within each section, e.g.

#include <linux/aaaa.h>
#include <linux/blah.h>

#include <asm/aaaa.h>
#include <asm/blah.h>

#include "aaaa.h"
#include "blah.h"

> @@ -2565,8 +2563,8 @@ static bool emulator_io_port_access_allowed(struct x86_emulate_ctxt *ctxt,
>  	 * VMware allows access to these ports even if denied
>  	 * by TSS I/O permission bitmap. Mimic behavior.
>  	 */
> -	if (enable_vmware_backdoor &&
> -	    ((port == VMWARE_PORT_VMPORT) || (port == VMWARE_PORT_VMRPC)))
> +	if (kvm_vmware_backdoor_enabled(ctxt->vcpu) &&

Maybe kvm_is_vmware_backdoor_enabled()?  To make it super clear it's a predicate.

Regarding namespacing, I think for the "is" predicates, the code reads better if
it's kvm_is_vmware_xxx versus kvm_vware_is_xxx.  E.g. is the VMware backdoor
enabled vs. VMware is the backdoor enabled.  Either way is fine for me if someone
has a strong preference though.

> +	    kvm_vmware_io_port_allowed(port))

Please separate the addition of helpers from the code movement.  That way the
code movement patch can be acked/reviewed super easily, and then we can focus on
the helpers (and it also makes it much easier to review the helpers changes).

E.g.

  patch 1: move code to vmware.{c,h}
  patch 2: introduce wrappers and bury variables/#defines in vmware.c
  patch 3: introduce CONFIG_KVM_VMWARE to disasble VMware emulation

I mention that here, because kvm_vmware_io_port_allowed() doesn't seem like the
right name.  kvm_is_vmware_io_port() seems more appropriate.

Oh, and also relevant.  For this and kvm_vmware_is_backdoor_pmc(), put the
kvm_vmware_backdoor_enabled() check inside kvm_is_vmware_io_port() and
kvm_is_vmware_backdoor_pmc().


