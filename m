Return-Path: <linux-kernel+bounces-838007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7376EBAE36A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B0007AFCB8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8308A30EF77;
	Tue, 30 Sep 2025 17:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2AW/0E4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DF130E0D3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759253744; cv=none; b=tc7SkCmQjAQ4jfumgWLxwHg/VDWqkZaMyz5SqInk9sw7K3TH9BDoVTSIzjBcOWj1GnB++QvJck384EFlKZa39O5BMeVe0EetvsDk8hD7maZxn9rcwddZqXnfOBF1Wi5a4Sw3rMiECGIdulsLmNRvabbOsVR9jmSmVkKKjfGeyDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759253744; c=relaxed/simple;
	bh=Kr9lL8MPYD++hHO2SQOsCrlv+4BTE9B+6nwdsuDh74M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o79QTQN8jqns2bfvmCHq4kKbAgPdvotkJoNVzHBW0sSd5s/DQvXq6NQnMNGa8O7bisN8CwnFKGdA8bIR1YQZ+5Y5G7xx/PfyAJu+hjifxmVTY3+k3mKu2xnJoM0x8QrXv/3ZEMBsmcXspTksVluS+od8AYx5PHtg1JzPhXDvRYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H2AW/0E4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759253742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nAOlRwezlVs7uHtFsxzOCLCSgmJ+8i9exw5LQNqEVpk=;
	b=H2AW/0E4jVkHvOl293+/Vk4XWJukirBXOrKx1XFs2tF+RFFgXQghU3KU3N+gaZHNKW+j74
	glhzJgzGb/Nq9ashcZYmoXzbK7ha4Odham/Y3kcPDl/OzuRAyAsZy0FmxVDX7R0eRCkvkw
	yrR3gZ6jO8xd+rIu/R8sVbKQGzfUPQc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-X-zxeyuYOLy3OAvm7-4NVQ-1; Tue, 30 Sep 2025 13:35:39 -0400
X-MC-Unique: X-zxeyuYOLy3OAvm7-4NVQ-1
X-Mimecast-MFC-AGG-ID: X-zxeyuYOLy3OAvm7-4NVQ_1759253737
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3eff3936180so2352030f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:35:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759253737; x=1759858537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAOlRwezlVs7uHtFsxzOCLCSgmJ+8i9exw5LQNqEVpk=;
        b=vtgbbF3JmsR/4VYw0dGMp0LN4+viaOx1+ag35j4t2AOFgsa2PXBSWy+vjnITgK3zLd
         sxHC87ai8LQqom9cDvORh8aUaInd7zaj6OKuoBtoefDIomvA9NDkQG6XcVIiBi6zgURr
         o9W6HVt57XxDbW3k/7wOkAU5I6RMMh/yE6+yZMMq8EGRfLkGlNH9D1g0YTBe8OBK8B5A
         H6CldEN4aUOzrbi60J6G7cmJxrI3JHiqxIrYq78Qtp+2LgqCDGiqMWZKJ8cLNPkhT5Gj
         9gfs9SSQ09xivVz5O2KstHIqmOfwp2kcvFhuiNaO5LTDU+BIczEPk53BaS5EdXv+izHJ
         NvhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMWAR9b5v1o3CXvjH8hJw5gYGwSJNKDGyjNPDZxIfnlwXDTSp9APCzfP/QUVqCaaXA4zGgbO9VnwhnzBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM7VwdPv533TuVg/8na0ZRMRyTwxnITbFCbmSrzo6Y+jHLVuR+
	6Fld6YWi33xKqsT3h8wGAfpxB4CO86I/bUAoQClUHOasqCBvJvPYAcGIjmicHrLFDCFWRac496j
	fGR9/KPgDPbSf0AQtVLvpYEtgBWb/KqRlMkEzqnzg9MsnVGT9MztKIg1HVtjewkKt7FVgTW27AF
	flHjClbZg5f1aqjFbvt0NJljJ9QzZpsL73iJ3er5b/+Hu3z7Xi
X-Gm-Gg: ASbGncthwetwVTYOclSwdUKpPquJof8hqLTQPkL2OJK2kE/gHF4SRZWEgGdQbBuTpD8
	9dE9HVfhRAmcb/JuGxn5uH5HcfDUTMLhApUYjFlBDiiyKzM8EfRoZemxeZAzvknQsi5XzkwgLzR
	FI03r0imHkAqCLaFmpxBI9e1/+6pAOr/Ka/7sx4d/jYokg/KtwbVFBrkSr6mjqKdgFCQ2aAhrpX
	XArn1MHqAhIAiurHfs/rPYuTR/qaiqt
X-Received: by 2002:a05:6000:2910:b0:414:6fe6:8fa1 with SMTP id ffacd0b85a97d-42557816e0emr466730f8f.38.1759253737028;
        Tue, 30 Sep 2025 10:35:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6TVsxQI34Dp7kOU8jNx//Q0S/KGutc1g4YAruoQR+npxJw0gJJPCstZowhYa8IRQqcxqafK/SpezDXSpRt0w=
X-Received: by 2002:a05:6000:2910:b0:414:6fe6:8fa1 with SMTP id
 ffacd0b85a97d-42557816e0emr466715f8f.38.1759253736539; Tue, 30 Sep 2025
 10:35:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927060910.2933942-1-seanjc@google.com> <20250927060910.2933942-7-seanjc@google.com>
In-Reply-To: <20250927060910.2933942-7-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 30 Sep 2025 19:35:24 +0200
X-Gm-Features: AS18NWAABlTX4B5mAf0Pk1jCGZIJlEn0c3GHGXy6pvjiDs_NPeIwncBjvsBeE24
Message-ID: <CABgObfYpkzNO-4XoCpEdoWGx_a9GiBpg=YjE0Y48T6OpvtPVrA@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: SVM changes for 6.18
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 8:09=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> The headliner here is to enable AVIC by deafult for Zen4+ if x2AVIC is
> supported.  The other highlight is support for Secure TSC (support for
> CiphertextHiding is coming in a separate pull request).
>
> The "lowlight" is a bug fix for an issue where KVM could clobber TSC_AUX =
if an
> SEV-ES+ vCPU runs on the same pCPU as a non-SEV-ES CPU.
>
> Regarding enabling AVIC by default, despite there still being at least on=
e
> known wart (the IRQ window inhibit mess), I think AVIC is stable enough t=
o
> enable by default.  More importantly, I think that getting it enabled in =
6.18
> in particular, i.e. in the next LTS, will be a net positive in the sense =
that
> we'll hopefully get more "free" testing, and thus help fix any lurking bu=
gs
> for the folks that are explicitly enabling AVIC.
>
> The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0=
b9:
>
>   Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)

Pulled, thanks.

Paolo

> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-svm-6.18
>
> for you to fetch changes up to ca2967de5a5b098b43c5ad665672945ce7e7d4f7:
>
>   KVM: SVM: Enable AVIC by default for Zen4+ if x2AVIC is support (2025-0=
9-23 08:56:49 -0700)
>
> ----------------------------------------------------------------
> KVM SVM changes for 6.18
>
>  - Require a minimum GHCB version of 2 when starting SEV-SNP guests via
>    KVM_SEV_INIT2 so that invalid GHCB versions result in immediate errors
>    instead of latent guest failures.
>
>  - Add support for Secure TSC for SEV-SNP guests, which prevents the untr=
usted
>    host from tampering with the guest's TSC frequency, while still allowi=
ng the
>    the VMM to configure the guest's TSC frequency prior to launch.
>
>  - Mitigate the potential for TOCTOU bugs when accessing GHCB fields by
>    wrapping all accesses via READ_ONCE().
>
>  - Validate the XCR0 provided by the guest (via the GHCB) to avoid tracki=
ng a
>    bogous XCR0 value in KVM's software model.
>
>  - Save an SEV guest's policy if and only if LAUNCH_START fully succeeds =
to
>    avoid leaving behind stale state (thankfully not consumed in KVM).
>
>  - Explicitly reject non-positive effective lengths during SNP's LAUNCH_U=
PDATE
>    instead of subtly relying on guest_memfd to do the "heavy" lifting.
>
>  - Reload the pre-VMRUN TSC_AUX on #VMEXIT for SEV-ES guests, not the hos=
t's
>    desired TSC_AUX, to fix a bug where KVM could clobber a different vCPU=
's
>    TSC_AUX due to hardware not matching the value cached in the user-retu=
rn MSR
>    infrastructure.
>
>  - Enable AVIC by default for Zen4+ if x2AVIC (and other prereqs) is supp=
orted,
>    and clean up the AVIC initialization code along the way.
>
> ----------------------------------------------------------------
> Hou Wenlong (2):
>       KVM: x86: Add helper to retrieve current value of user return MSR
>       KVM: SVM: Re-load current, not host, TSC_AUX on #VMEXIT from SEV-ES=
 guest
>
> Naveen N Rao (1):
>       KVM: SVM: Enable AVIC by default for Zen4+ if x2AVIC is support
>
> Nikunj A Dadhania (4):
>       KVM: SEV: Drop GHCB_VERSION_DEFAULT and open code it
>       KVM: SEV: Enforce minimum GHCB version requirement for SEV-SNP gues=
ts
>       x86/cpufeatures: Add SNP Secure TSC
>       KVM: SVM: Enable Secure TSC for SNP guests
>
> Sean Christopherson (15):
>       KVM: SVM: Move SEV-ES VMSA allocation to a dedicated sev_vcpu_creat=
e() helper
>       KVM: SEV: Move init of SNP guest state into sev_init_vmcb()
>       KVM: SEV: Set RESET GHCB MSR value during sev_es_init_vmcb()
>       KVM: SEV: Fold sev_es_vcpu_reset() into sev_vcpu_create()
>       KVM: SEV: Save the SEV policy if and only if LAUNCH_START succeeds
>       KVM: SEV: Rename kvm_ghcb_get_sw_exit_code() to kvm_get_cached_sw_e=
xit_code()
>       KVM: SEV: Read save fields from GHCB exactly once
>       KVM: SEV: Validate XCR0 provided by guest in GHCB
>       KVM: SEV: Reject non-positive effective lengths during LAUNCH_UPDAT=
E
>       KVM: SVM: Make svm_x86_ops globally visible, clean up on-HyperV usa=
ge
>       KVM: SVM: Move x2AVIC MSR interception helper to avic.c
>       KVM: SVM: Update "APICv in x2APIC without x2AVIC" in avic.c, not sv=
m.c
>       KVM: SVM: Always print "AVIC enabled" separately, even when force e=
nabled
>       KVM: SVM: Don't advise the user to do force_avic=3Dy (when x2AVIC i=
s detected)
>       KVM: SVM: Move global "avic" variable to avic.c
>
> Thorsten Blum (1):
>       KVM: nSVM: Replace kzalloc() + copy_from_user() with memdup_user()
>
>  arch/x86/include/asm/cpufeatures.h |   1 +
>  arch/x86/include/asm/kvm_host.h    |   2 +
>  arch/x86/include/asm/svm.h         |   1 +
>  arch/x86/kvm/svm/avic.c            | 151 ++++++++++++++++++++++++++++---=
---
>  arch/x86/kvm/svm/nested.c          |  18 ++---
>  arch/x86/kvm/svm/sev.c             | 160 +++++++++++++++++++++++++------=
------
>  arch/x86/kvm/svm/svm.c             | 126 +++++------------------------
>  arch/x86/kvm/svm/svm.h             |  40 ++++++----
>  arch/x86/kvm/svm/svm_onhyperv.c    |  28 ++++++-
>  arch/x86/kvm/svm/svm_onhyperv.h    |  31 +------
>  arch/x86/kvm/x86.c                 |   9 ++-
>  virt/kvm/guest_memfd.c             |   3 +-
>  12 files changed, 323 insertions(+), 247 deletions(-)
>


