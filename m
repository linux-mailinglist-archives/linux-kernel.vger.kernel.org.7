Return-Path: <linux-kernel+bounces-648507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00D5AB77FA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 23:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422D3171BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 21:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D85296D0C;
	Wed, 14 May 2025 21:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ev23C4K3"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B0229673B
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 21:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747258165; cv=none; b=N3/v4ewPkEg6Ppt8+mNf/5VO7uauUqMHfAndMwtcY6BrXllR+IkfsKdCcaKfIVZrkLPbtMkyZLmxSmgIM8idmouYP14AojwH/0OvhZpXEhgS3tG7oR97oJ/XFgiCkN+IvAj9DkScCJdptDdOmmTEKxmA2D+ZSKwy921skkUVFd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747258165; c=relaxed/simple;
	bh=H6nUZsxGjiOGVIHyxpf5q9mNTETzbow/hvE9WPbCWeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sl/GFaTiK0SeQLzyr6uwSBdybJ673RvmCwhrc7P1IBMjA3nMmRwOnXZ+g1dp944N2LmR+OZXSL0o1g1/MM+JRUiSDidX6ejGnF6dop7j2rHtUjskz066/EcaBcd4I6WpT9IV9RglTu8dLP6fc4rKWnOim9d9wVvrQ+mqdgsDeUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ev23C4K3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d5f10e1aaso20715e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 14:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747258161; x=1747862961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Slx4ccuRWaY0rxsjL8o0FXzUV7zpEZYUBzQCDU2r9rQ=;
        b=ev23C4K3cx39RmZ7a/Ml4F3SHeZixJ9kznNd//fgs+z31texeYxXFV0jXmzjOmVBWz
         OQoX49nvDQdCgIQHDaCORqsnKTpsWPe6ZhD51N+DXK6aBsJIKiADXVFPmkmHPVD/McEq
         HKgDbVYEoSM8/rZF1k1F3QSgLgTjPPbiQQKkDL1IXa4J5bt9ooytLeuGP84fQ09GTZv1
         daQW+NIZbzDii/7Y/42pxpdIpMF9+yhfu514aOJ643+FqSWBaIoHctwanr4yWAKKI6VY
         q/4KRUUvM9D6Z1VLUDhsti9JonVn9NYzKBUSPilO+4+r8lt/n2YOGEohHJ+f8uXsF8x5
         RSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747258161; x=1747862961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Slx4ccuRWaY0rxsjL8o0FXzUV7zpEZYUBzQCDU2r9rQ=;
        b=ghzSWfhdBUnEz3025dQGTmpX1QF90IxSRVie7RwWXGfw6h2/JomYFzw+zHqVaTPI8M
         TRh6d3IJ4PQDED8tZbKckoth2KODAPQOVg2DhOrnoqbEwe+d8Fw+F5/wrlcrE3fz6zU3
         WYzq/Tqd8l8cVf289LltgKNFTU03nrzTVyFqbswbETHyDzd9jz0ZsI8QcGjRQHm4/9Q9
         AeGWWWgPCPe1QxQnB4mOBwpfVxnQr0RprJ2xA2vYnzRZIMHCBaR6MeWWTuprgZaWFZdb
         8DkiqFGiRZ3YU52i9pNlGIP2CCX5Z+8wB+AGBybzCnWCF89i74AiUPYFigVzViKeF6Mr
         zGDw==
X-Forwarded-Encrypted: i=1; AJvYcCVirZShOFXfA2NmG7viUX4m1PBVENN6Xhj/9ZdbIx17Fr2AQMpOmPaf4zMi7nelDvyqiwpjVTdmPPMM9ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKQlg5iCDb1bfneYtseDdDbOzTU1KGtPdAmYWX6/MyIRYC6Lhu
	a8tgry8d0yTKXw391J+dTnsTmUoEqDaLVAucGnmkDyHdFWqr9onsTWTRS8XN/nh8ArtwERv9R9H
	Mv2miZ3GuXaE4N3Ntw/cVFafhTRkDSUGmX1ui42Xl
X-Gm-Gg: ASbGncv2GYHXJckor+dJffPxwBoFM23nN6cqy7hhHqSh+FEW3Zub1JQT7ltPHvNSOOM
	UCFv8aK3ZG6gL+klrKvYLlmhgwoaTt816nY8zAPcCZew10g+qc/NMh0RqwBBx8EWLZt1vSThE+D
	8VosR2CwD8aViD52zFAaYm0QD18zFO/OZ3vrNG2FsrLxYbc5BA7zacUj2giJ0taw==
X-Google-Smtp-Source: AGHT+IHtyqQCkUrNJiUCv4rKrRfdaVNrxqYbN3dpp1JTn37YnHa0lc60bhCiTqHmnbfcp5FYiIwPf8xUOcF9xc4J1CY=
X-Received: by 2002:a7b:cb0b:0:b0:439:9434:1b66 with SMTP id
 5b1f17b1804b1-442f96918d2mr1145e9.1.1747258160984; Wed, 14 May 2025 14:29:20
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505161412.1926643-1-jiaqiyan@google.com> <20250505161412.1926643-7-jiaqiyan@google.com>
 <830ecd3d-13d4-4f12-9fea-e20cc69d0a5c@oracle.com>
In-Reply-To: <830ecd3d-13d4-4f12-9fea-e20cc69d0a5c@oracle.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Wed, 14 May 2025 14:29:09 -0700
X-Gm-Features: AX0GCFsv8ezjBmFZxLF3RCnN2B0FNrLKw7sWOsaJ5KQNDume-9PaaiuTEgpZ5b8
Message-ID: <CACw3F53-SaPccosPqYcXWGEpwfKj-VbSJ5nJa3f82oFMbHAy2Q@mail.gmail.com>
Subject: Re: [PATCH v1 6/6] Documentation: kvm: new uAPI for handling SEA
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, pbonzini@redhat.com, corbet@lwn.net, shuah@kernel.org, 
	kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	duenwen@google.com, rananta@google.com, jthoughton@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks ALOK, for pointing out the typos! Queued the fixes to V2 while
awaiting for reviews on other patches.

On Wed, May 7, 2025 at 12:25=E2=80=AFPM ALOK TIWARI <alok.a.tiwari@oracle.c=
om> wrote:
>
> ...
> > +Inject SError
> > +~~~~~~~~~~~~~
> > +
> >   Set the pending SError exception state for this VCPU. It is not possi=
ble to
> >   'cancel' an Serror that has been made pending.
> >
> > -If the guest performed an access to I/O memory which could not be hand=
led by
> > -userspace, for example because of missing instruction syndrome decode
> > -information or because there is no device mapped at the accessed IPA, =
then
> > -userspace can ask the kernel to inject an external abort using the add=
ress
> > -from the exiting fault on the VCPU. It is a programming error to set
> > -ext_dabt_pending after an exit which was not either KVM_EXIT_MMIO or
> > -KVM_EXIT_ARM_NISV. This feature is only available if the system suppor=
ts
> > -KVM_CAP_ARM_INJECT_EXT_DABT. This is a helper which provides commonali=
ty in
> > -how userspace reports accesses for the above cases to guests, across d=
ifferent
> > -userspace implementations. Nevertheless, userspace can still emulate a=
ll Arm
> > -exceptions by manipulating individual registers using the KVM_SET_ONE_=
REG API.
> > +Inject SEA (synchronous external abort)
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +- If the guest performed an access to I/O memory which could not be ha=
ndled by
> > +  userspace, for example because of missing instruction syndrome decod=
e
> > +  information or because there is no device mapped at the accessed IPA=
.
> > +
> > +- If the guest consumed an uncorrected memory error, and RAS extension=
 in the
> > +  Trusted Firmware choose to notify PE with SEA, KVM has to handle it =
when
> > +  host APEI is unable to claim the SEA. For the following types of fau=
lts,
> > +  if userspace enabled KVM_CAP_ARM_SEA_TO_USER, KVM returns to userspa=
ce with
> > +  KVM_EXIT_ARM_SEA:
> > +
> > +  - Synchronous external abort, not on translation table walk or hardw=
are
> > +    update of translation table.
> > +
> > +  - Synchronous external abort on translation table walk or hardware u=
pdate of
> > +    translation table, including all levels.
> > +
> > +  - Synchronous parity or ECC error on memory access, not on translati=
on table
> > +    walk.
> > +
> > +  - Synchronous parity or ECC error on memory access on translation ta=
ble walk
> > +    or hardware update of translation table, including all levels.
> > +
> > +For the cases above, userspace can ask the kernel to replay either an =
external
> > +data abort (by setting ext_dabt_pending) or an external instruciton ab=
ort
>
> typo instruciton -> instruction
>
> > +(by setting ext_iabt_pending) into the faulting VCPU. KVM will use the=
 address
> > +from the exiting fault on the VCPU. Setting both ext_dabt_pending and
> > +ext_iabt_pending at the same time will return -EINVAL.
> > +
> > +It is a programming error to set ext_dabt_pending or ext_iabt_pending =
after an
> > +exit which was not KVM_EXIT_MMIO, KVM_EXIT_ARM_NISV or KVM_EXIT_ARM_SE=
A.
> > +Injecting SEA for data and instruction abort is only available if KVM =
supports
> > +KVM_CAP_ARM_INJECT_EXT_DABT and KVM_CAP_ARM_INJECT_EXT_IABT respective=
ly.
> > +
> > +This is a helper which provides commonality in how userspace reports a=
ccesses
> > +for the above cases to guests, across different userspace implementati=
ons.
> > +Nevertheless, userspace can still emulate all Arm exceptions by manipu=
lating
> > +individual registers using the KVM_SET_ONE_REG API.
> >
> >   See KVM_GET_VCPU_EVENTS for the data structure.
> >
> > @@ -7151,6 +7184,55 @@ The valid value for 'flags' is:
> >     - KVM_NOTIFY_CONTEXT_INVALID -- the VM context is corrupted and not=
 valid
> >       in VMCS. It would run into unknown result if resume the target VM=
.
> >
> > +::
> > +
> > +    /* KVM_EXIT_ARM_SEA */
> > +    struct {
> > +      __u64 esr;
> > +  #define KVM_EXIT_ARM_SEA_FLAG_GVA_VALID   (1ULL << 0)
> > +  #define KVM_EXIT_ARM_SEA_FLAG_GPA_VALID   (1ULL << 1)
> > +      __u64 flags;
> > +      __u64 gva;
> > +         __u64 gpa;
> > +    } arm_sea;
> > +
> > +Used on arm64 systems. When the VM capability KVM_CAP_ARM_SEA_TO_USER =
is
> > +enabled, a VM exit is generated if guest caused a synchronous external=
 abort
> > +(SEA) and the host APEI fails to handle the SEA.
> > +
> > +Historically KVM handles SEA by first delegating the SEA to host APEI =
as there
> > +is high chance that the SEA is caused by consuming uncorrected memory =
error.
> > +However, not all platforms support SEA handling in APEI, and KVM's fal=
lback
> > +handling is to inject an async SError into the guest, which usually pa=
nics
> > +guest kernel unpleasantly. As an alternative, userspace can participat=
e into
> > +the SEA handling by enabling KVM_CAP_ARM_SEA_TO_USER at VM creation, a=
fter
> > +querying the capability. Once enabled, when KVM has to handle the gues=
t
> > +caused SEA, it returns to userspace with KVM_EXIT_ARM_SEA, with detail=
s
> > +about the SEA available in 'arm_sea'.
> > +
> > +The 'esr' filed holds the value of the exception syndrome register (ES=
R) while
>
> 'esr' filed holds -> 'esr' field hold
>
> > +KVM taking the SEA, which tells userspace the character of the current=
 SEA,
> > +such as its Exception Class, Synchronous Error Type, Fault Specific Co=
de and
> > +so on. For more details on ESR, check the Arm Architecture Registers
> > +documentation.
> > +
> > +The 'flags' field indicates if the faulting addresses are available wh=
ile
> > +taking the SEA:
> > +
> > +  - KVM_EXIT_ARM_SEA_FLAG_GVA_VALID -- the faulting guest virtual addr=
ess
> > +    is valid and userspace can get its value in the 'gva' field.
>
> the 'gpa' filed -> the 'gpa' field.
>
> > +  - KVM_EXIT_ARM_SEA_FLAG_GPA_VALID -- the faulting guest physical add=
ress
> > +    is valid and userspace can get its value in the 'gpa' filed.
> > +
> > +Userspace needs to take actions to handle guest SEA synchronously, nam=
ely in
> > +the same thread that runs KVM_RUN and receives KVM_EXIT_ARM_SEA. One o=
f the
> > +encouraged approaches is to utilize the KVM_SET_VCPU_EVENTS to inject =
the SEA
> > +to the faulting VCPU. This way, the guest has the opportunity to keep =
running
> > +and limit the blast radius of the SEA to the particular guest applicat=
ion that
> > +caused the SEA. If the Exception Class indicated by 'esr' field in 'ar=
m_sea'
> > +is data abort, userspace should inject data abort. If the Exception Cl=
ass is
> > +instruction abort, userspace should inject instruction abort.
>
>
> Thanks,
> Alok

