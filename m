Return-Path: <linux-kernel+bounces-705128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 314CFAEA595
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 20:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8A4562FA0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 18:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612AA2EE61F;
	Thu, 26 Jun 2025 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LaXtqg08"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6052EBBBC
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 18:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750963468; cv=none; b=hM74yCtJ47kXYZsQcv6qLp+MZF2vacA+SRVv7R6sA03NL5ZB1oKXdpj5E3jeTXx1uorzbu/U66tNP1Dw3AekFwlhnjABU0qJh8oNgp/fETwLaRQx9N1xsaDiUfpcExLDdTMjlWHVSiXYBkFYUru85cODxSkMkrar693FQb+FYFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750963468; c=relaxed/simple;
	bh=JyTS+06VLQe5FPi+0LanxE8IVMUh3zptQIYBOWpFOu8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=giah2Cq6+TFp/2d1G3y+Dv83qhTpn9rp1CCiteD8KFI1xfhKAZK3tkVY+b27zZsk3XilKGOrCqy8AhhkYwYLlL1ck/GI4SQgGzeRQrY0zcd/bEpcSR+mQtek8MkzeJ/lpCR0IEwEEMIpzN3/9pW63fFf8VSBkhkobBELOsqfY4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LaXtqg08; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748cf01de06so2774067b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 11:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750963466; x=1751568266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rYHNg9a3gIVUjA4Cylf2v5jfM7ZB7rRrRd59AiQQkX0=;
        b=LaXtqg08THFF4B9+IJn6CgFwxOWm8U1qc49NAtmzchEGo7diasnsWAl2o7tVoWfddW
         qHsLDFxybjefnqRPB0oUNGm4H19T/1A7xHfGxOs+ftApb3rVExAmBOtbN+ScabqMpAfW
         xk+gvMvCyYTbmEIpi667JnHzhaIHk2svfY5eHIDhQlW1E0Gy1OX1fN0f3CHqqAPNQTIi
         FWGXuMvP7hsdnUS0vpbDDbyGHRSkGf2AU6FJqHNvJW8SmMHMqfMyZMpTQ1lz9dO4+P0B
         WQlsSEKBgNNSqdpfV3p7jv543vv+nOV6rjTjnrRxsRYO3Wsa+W0LABR5QR6h1EsW0Lns
         lydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750963466; x=1751568266;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rYHNg9a3gIVUjA4Cylf2v5jfM7ZB7rRrRd59AiQQkX0=;
        b=kWMCqvTlCGruriF8jBTQr1oHIvKCo5q1aJpYdRSHP6ypjgbY6SedRraXBHZpP0AMqF
         FRwkiDpxyNwKebCykApGLy8YVtgsSqotaUNRkY7cKQlbFiLCOuI1przijENIZgpwA4MT
         iStGDkOJx6kUFqZZISIJI+POzHzVOUZlQnnZqVHo1MIv/y5e010MjjzQZ8iraNXzuWRc
         5VrJZcXz9cOYbc5ndR+wFAwK8T4EECTD6Csa35xgnfGyGsuix/PLEfI81Nf//4iWO/m1
         +x/BNXtzuWfBB1DOJzXWYj6E3Z4d0506CEZY83tokBcE4uGf0eNU6TlJJPtThj6T4YvW
         akrg==
X-Forwarded-Encrypted: i=1; AJvYcCX9sxWmpS6MGSweiW0x07HAT1bAaADK/ViNW5QJRK7VfheHKP8iCSbJOc4vWVxMXoznz+YC6VlVQBVS7CA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNzuf9ZSxe4nu1vhYIN5+xcxXBF3nLfBjRfnzd4AOy1wIT7i4I
	5P+pBYQlbgduUpouyC8dVxNLc5wjfEGLrZEFra20WM/y19xJTqCH9cXvODfSu4pSND4kr4QFehr
	WxppGZg==
X-Google-Smtp-Source: AGHT+IEYJRRZR59sGhz8SndjbIqbuWIXmEdW2Kvif7SOvuRK4bSfQeoPF2lrIW6C0GWykGSGi5V8FJZQPaY=
X-Received: from pfblx5.prod.google.com ([2002:a05:6a00:7545:b0:748:ec4d:30ec])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9194:b0:20b:a75e:fa32
 with SMTP id adf61e73a8af0-220a17e135fmr70596637.40.1750963466630; Thu, 26
 Jun 2025 11:44:26 -0700 (PDT)
Date: Thu, 26 Jun 2025 11:44:25 -0700
In-Reply-To: <66bab47847aa378216c39f46e072d1b2039c3e0e.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250626145122.2228258-1-naveen@kernel.org> <66bab47847aa378216c39f46e072d1b2039c3e0e.camel@redhat.com>
Message-ID: <aF2VCQyeXULVEl7b@google.com>
Subject: Re: [EARLY RFC] KVM: SVM: Enable AVIC by default from Zen 4
From: Sean Christopherson <seanjc@google.com>
To: mlevitsk@redhat.com
Cc: "Naveen N Rao (AMD)" <naveen@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vasant Hegde <vasant.hegde@amd.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025, mlevitsk@redhat.com wrote:
> On Thu, 2025-06-26 at 20:21 +0530, Naveen N Rao (AMD) wrote:
> > This is early RFC to understand if there are any concerns with enabling
> > AVIC by default from Zen 4. There are a few issues related to irq windo=
w
> > inhibits (*) that will need to be addressed before we can enable AVIC,
> > but I wanted to understand if there are other issues that I may not be
> > aware of. I will split up the changes and turn this into a proper patch
> > series once there is agreement on how to proceed.
> >=20
> > AVIC (and x2AVIC) is fully functional since Zen 4, and has so far been
> > working well in our tests across various workloads. So, enable AVIC by
> > default from Zen 4.
> >=20
> > CPUs prior to Zen 4 are affected by hardware errata related to AVIC and
> > workaround for those (erratum #1235) is only just landing upstream. So,
> > it is unlikely that anyone was using AVIC on those CPUs. Start requirin=
g
> > users on those CPUs to pass force_avic=3D1 to explicitly enable AVIC go=
ing
> > forward. This helps convey that AVIC isn't fully enabled (so users are
> > aware of what they are signing up for), while allowing us to make
> > kvm_amd module parameter 'avic' as an alias for 'enable_apicv'
> > simplifying the code.=C2=A0 The only downside is that force_avic taints=
 the
> > kernel, but if this is otherwise agreeable, the taint can be restricted
> > to the AVIC feature bit not being enabled.
> >=20
> > Finally, stop complaining that x2AVIC CPUID feature bit is present
> > without basic AVIC feature bit, since that looks to be the way AVIC is
> > being disabled on certain systems and enabling AVIC by default will
> > start printing this warning on systems that have AVIC disabled.
> >=20
>=20
> Hi,
>=20
>=20
> IMHO making AVIC default on on Zen4 is a good idea.
>=20
> About older systems, I don't know if I fully support the idea of hiding
> the support under force_avic, because AFAIK, other that errata #1235
> there are no other significant issues with AVIC.

Agreed, force_avic should be reserved specifically for the case where AVIC =
exists
in hardware, but is not enumerated in CPUID.

> In fact errata #1235 is not present on Zen3, and I won't be surprised tha=
t
> AVIC was soft-disabled on Zen3 wrongly.

FWIW, the Zen3 systems I have access to don't support AVIC / APIC virtualiz=
ation
in the IOMMU, so it's not just AVIC being soft-disabled in the CPU.

> IMHO the cleanest way is probably:
>=20
> On Zen2 - enable_apicv off by default, when forced to 1, activate
> the workaround for it. AFAIK with my workaround, there really should
> not be any issues, but since hardware is quite old, I am OK to keep it di=
sabled.
>=20
> On Zen3, AFAIK the errata #1235 is not present, so its likely that AVIC i=
s
> fully functional as well, except that it is also disabled in IOMMU,
> and that one AFAIK can't be force-enabled.
>=20
> I won't object if we remove force_avic altogether and just let the user a=
lso explicitly=C2=A0
> enable avic with enable_apicv=3D1 on Zen3 as well.

I'm not comfortable ignoring lack of enumerated support without tainting th=
e
kernel.

I don't see any reason to do major surgery, just give "avic" auto -1/0/1 be=
havior:

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ab11d1d0ec51..4aa5bec0b1e7 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -158,12 +158,9 @@ module_param(lbrv, int, 0444);
 static int tsc_scaling =3D true;
 module_param(tsc_scaling, int, 0444);
=20
-/*
- * enable / disable AVIC.  Because the defaults differ for APICv
- * support between VMX and SVM we cannot use module_param_named.
- */
-static bool avic;
-module_param(avic, bool, 0444);
+/* Enable AVIC by default only for Zen4+ (negative value =3D default/auto)=
. */
+static int avic =3D -1;
+module_param(avic, int, 0444);
 module_param(enable_ipiv, bool, 0444);
=20
 module_param(enable_device_posted_irqs, bool, 0444);
@@ -5404,6 +5401,9 @@ static __init int svm_hardware_setup(void)
                        goto err;
        }
=20
+       if (avic < 0)
+               avic =3D boot_cpu_data.x86 > 0x19 || boot_cpu_has(X86_FEATU=
RE_ZEN4);
+
        enable_apicv =3D avic =3D avic && avic_hardware_setup();
=20
        if (!enable_apicv) {

