Return-Path: <linux-kernel+bounces-863346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A54EBF79A6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 012D54E67A6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44739345CBA;
	Tue, 21 Oct 2025 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eRqFA7nx"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA32E340D87
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761063251; cv=none; b=cGXT8bI2MzLexA2J59BxFUim1ea8Gy0ayCnPsce9I7/HI0IObhIb87l8ppNbFmc1xfXsYxOHvX8H0NzDMQvQ0pae2PPbDC5+1O1GbxXu39utsHQ3tt0Ac9jfXhiG+dfX8tn9sGAD/FqlR3jPyc54ybKI98oda89thJ+m+SmPIlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761063251; c=relaxed/simple;
	bh=jwALCPRFruFeYmRfrp9Ri+SEZYzWo8ADyILKji9+IIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kv6ZFQbz1TMjoYSp9ILSRfQnRTGzRU8VDMdkng1W5KLosR1yLTu9ziCqdnmFjROBoJVH7bT8iWeryp1ir1rwi7KtnMh/4kuM1JYifcTF+EXE9eUzgGa/q4W1L6d3ujP5uzjNBj0uXqB9Fxak0jphA+zMo5ynqfu5phphVJE2rQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eRqFA7nx; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-471005e2ba9so69965e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761063247; x=1761668047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzW2rY1I2AKLs/LU+wRizdzQ22+SHdlJ/3qusxmFBDE=;
        b=eRqFA7nxiXlxzFYyinrIjOWTfDELwsBV1AoSpBTUDGBy0te9x+pKr07ARmFVjeYxfI
         izlXOK933UZb5MVMGBpJ0ruVHZmx6+cwFAbwGtyVoKu8iUl/TyyCKt00HY2i2apYwgpe
         qRcuVS3SJxTNpJeqSl/JEK2CQOG/eyh7HuxBG0WCQkw5v7X687un532/lAwiCWq+OkjR
         N5dMASSffNPpOlAjMR3tBv0amjaWbC3btwEGFFodZ0qz0QF9VljRtEGmpE8jai/0HuAB
         ANtRKE+yxZmA/jBiE+BfdjV+AXAxcqKgObe/CcATfkxBbS4IJN9Mq1iwKc9673U3fFaX
         1aKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761063247; x=1761668047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzW2rY1I2AKLs/LU+wRizdzQ22+SHdlJ/3qusxmFBDE=;
        b=QCz00HDELX85vlzdkgX+THBq2oWhujON5B3mi/yWRu7zdoto6ik3Ynj1kUhM56ZZJB
         WSJqkASHfFUlKm0lid7KMKBvnMnmrsfCUm6YYoRIHO47GKk4Oj+M9GePy9xyApoT/dMp
         pM5SzK4/6YE5W2cLSdLwui86qHwX6QivkUbyfFtLafYaFxG0iL+mFMiU9tEilxMZ25a8
         leB+kDsU8XJRYdU2jqQWI3omWvNqgKjpJOOG8bkxNQIHWEsD5qtF/4tKmQ97TgC9PtH8
         EjN8sfiQ7m6ZVCT6Q/X4GMQCcp1oJV605/2zM9L+0ujOWY+odX5XWRMvqliSaoewsb83
         NVpg==
X-Forwarded-Encrypted: i=1; AJvYcCWZbxgJt/dwK9YjiQzgykM+xCqdZi258Hy3TncheadIagq6CVQJZPEVQQaCM1Me8S8I08zQJ6v+QiCCMcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHrMLtpvSSJUDLa/m9hilBCiAKblqYJihe1N9x/88bG44PdmUM
	8WnE8+sxAHLyX1MLKCTpHhTVUpZ4Syoh6W3jPSxA6Lgw6HRhlT+BCkXH6pcLiIw0BQUR4FLg31t
	Wn/tQxlQK+kUmccMvLuGyBWOikAKVTKtaWmt0QYub
X-Gm-Gg: ASbGncsassTArHQ4uR4Rn/qBQopHmmhitzY8kFHakY6cZqcUKgSOY9D+nSkqWhLOCEG
	sNsD6mv9Eh4bD5bp+U+vVvBcY+fwnmVWCWZfinGYDi5g6KgAi1zHSTZUu5D/4LvhpMjZ+2obtLy
	8L+x8Z8Gmkbk/kdGr/xaU+khAZAc+QmwvCoeu00XfeG4IcpidmRjFqJkx9tdIc1yaej6F6+DAY8
	sRPnj9yPZeLAujODvIqnkL3QIxYJoFC9F+/UiVHbu1rHDz5FaCHT1reaO0ibIe06BHTKN/OoyOj
	kB6x/pjv7ThU8b4q
X-Google-Smtp-Source: AGHT+IE14qTEBghQgzjgcliX4306euS6iolIBF3AxWlF2cEnTAIMms5VkABvdFJelKcvqwketyvRe6yUthJZ0L6j/JI=
X-Received: by 2002:a05:600c:8719:b0:46f:aa9f:e345 with SMTP id
 5b1f17b1804b1-47497744bccmr724965e9.7.1761063246555; Tue, 21 Oct 2025
 09:14:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013185903.1372553-1-jiaqiyan@google.com> <20251013185903.1372553-4-jiaqiyan@google.com>
 <3efcf624-58f1-4390-b6e2-a0aa5e62a9a3@infradead.org>
In-Reply-To: <3efcf624-58f1-4390-b6e2-a0aa5e62a9a3@infradead.org>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Tue, 21 Oct 2025 09:13:55 -0700
X-Gm-Features: AS18NWBrgiqcwjUkY7yriOgg09EsrU9gzSKpZPzp6diSIUTDX5ipeIw05uqw6vQ
Message-ID: <CACw3F53cqiwtGyeJw+baS23sK3byenC8R5ddzW6Q1e_Bzk8tJA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] Documentation: kvm: new UAPI for handling SEA
To: Randy Dunlap <rdunlap@infradead.org>
Cc: maz@kernel.org, oliver.upton@linux.dev, duenwen@google.com, 
	rananta@google.com, jthoughton@google.com, vsethi@nvidia.com, jgg@nvidia.com, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	shuah@kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 6:51=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
>
>
> On 10/13/25 11:59 AM, Jiaqi Yan wrote:
> > Document the new userspace-visible features and APIs for handling
> > synchronous external abort (SEA)
> > - KVM_CAP_ARM_SEA_TO_USER: How userspace enables the new feature.
> > - KVM_EXIT_ARM_SEA: exit userspace gets when it needs to handle SEA
> >   and what userspace gets while taking the SEA.
> >
> > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > ---
> >  Documentation/virt/kvm/api.rst | 61 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 61 insertions(+)
> >
> > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/ap=
i.rst
> > index 6ae24c5ca5598..43bc2a1d78e01 100644
> > --- a/Documentation/virt/kvm/api.rst
> > +++ b/Documentation/virt/kvm/api.rst
> > @@ -7272,6 +7272,55 @@ exit, even without calls to ``KVM_ENABLE_CAP`` o=
r similar.  In this case,
> >  it will enter with output fields already valid; in the common case, th=
e
> >  ``unknown.ret`` field of the union will be ``TDVMCALL_STATUS_SUBFUNC_U=
NSUPPORTED``.
> >  Userspace need not do anything if it does not wish to support a TDVMCA=
LL.
> > +
> > +::
> > +             /* KVM_EXIT_ARM_SEA */
> > +             struct {
> > +  #define KVM_EXIT_ARM_SEA_FLAG_GPA_VALID   (1ULL << 0)
> > +                     __u64 flags;
> > +                     __u64 esr;
> > +                     __u64 gva;
> > +                     __u64 gpa;
> > +             } arm_sea;
> > +
> > +Used on arm64 systems. When the VM capability KVM_CAP_ARM_SEA_TO_USER =
is
> > +enabled, a VM exit is generated if guest causes a synchronous external=
 abort
> > +(SEA) and the host APEI fails to handle the SEA.
> > +
> > +Historically KVM handles SEA by first delegating the SEA to host APEI =
as there
> > +is high chance that the SEA is caused by consuming uncorrected memory =
error.
> > +However, not all platforms support SEA handling in APEI, and KVM's fal=
lback
> > +is to inject an asynchronous SError into the guest, which usually pani=
cs
> > +guest kernel unpleasantly. As an alternative, userspace can participat=
e into
>
>                                                                          =
  in
>
> > +the SEA handling by enabling KVM_CAP_ARM_SEA_TO_USER at VM creation, a=
fter
> > +querying the capability. Once enabled, when KVM has to handle the gues=
t
>
>                                                                      gues=
t-
> > +caused SEA, it returns to userspace with KVM_EXIT_ARM_SEA, with detail=
s
> > +about the SEA available in 'arm_sea'.
> > +
> > +The 'esr' field holds the value of the exception syndrome register (ES=
R) while
> > +KVM taking the SEA, which tells userspace the character of the current=
 SEA,
>    KVM takes
>
> > +such as its Exception Class, Synchronous Error Type, Fault Specific Co=
de and
> > +so on. For more details on ESR, check the Arm Architecture Registers
> > +documentation.
> > +
> > +The following values are defined for the 'flags' field
>
> Above needs an ending like '.' or ':'.
> (or maybe "::" depending how it is processed by Sphinx)
>
> > +
> > +  - KVM_EXIT_ARM_SEA_FLAG_GPA_VALID -- the faulting guest physical add=
ress
> > +    is valid and userspace can get its value in the 'gpa' field.
> > +
> > +Note userspace can tell whether the faulting guest virtual address is =
valid
> > +from the FnV bit in 'esr' field. If FnV bit in 'esr' field is not set,=
 the
> > +'gva' field hols the valid faulting guest virtual address.
>
>                holds (or contains)> +
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
> > +caused the SEA. Userspace may also emulate the SEA to VM by itself usi=
ng the
> > +KVM_SET_ONE_REG API. In this case, it can use the valid values from 'g=
va' and
> > +'gpa' fields to manipulate VCPU's registers (e.g. FAR_EL1, HPFAR_EL1).
> > +
> >  ::
> >
> >               /* Fix the size of the union. */
> > @@ -8689,6 +8738,18 @@ This capability indicate to the userspace whethe=
r a PFNMAP memory region
> >  can be safely mapped as cacheable. This relies on the presence of
> >  force write back (FWB) feature support on the hardware.
> >
> > +7.45 KVM_CAP_ARM_SEA_TO_USER
> > +----------------------------
> > +
> > +:Architecture: arm64
> > +:Target: VM
> > +:Parameters: none
> > +:Returns: 0 on success, -EINVAL if unsupported.
> > +
> > +This capability, if KVM_CHECK_EXTENSION indicates that it is available=
, means
> > +that KVM has an implementation that allows userspace to participate in=
 handling
> > +synchronous external abort caused by VM, by an exit of KVM_EXIT_ARM_SE=
A.
> > +
> >  8. Other capabilities.
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
>
> --
> ~Randy
>

Thanks for your quick review, Randy. I have queued fixes and am
waiting for reviews on other commits in this PATCH.

