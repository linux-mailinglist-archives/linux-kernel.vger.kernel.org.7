Return-Path: <linux-kernel+bounces-634157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D178AAAC95
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 04:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EC2B1653FC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 02:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4C22FEB78;
	Mon,  5 May 2025 23:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BRYIDiiS"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E972F47BB
	for <linux-kernel@vger.kernel.org>; Mon,  5 May 2025 23:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486956; cv=none; b=rSsII4FzJi5/ZzzFmIyEPoVmc/oNDCvsAfee9EcW6aDbC8Nb35xrEMBBAveDqjMlanwOK3w8IOeeiDuQI07okTwAQJTAIyP94fueOAnE13NgdJoqtEVPhzPLPuxSKM3HBK7sYXjLaaBFRat5qruy9saL+QDt42oFxcr4Lk+haBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486956; c=relaxed/simple;
	bh=FOf0phkAo0jTZUx4cTd2EAquLqa9kmlIuubRcG1DIvA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EaTOYhu9Cmh09tOSQbwEXr5/oogcD/hVcWQZz7BFy4+MNzwgRWbxvsodDgtsrlLliohmAazZp61HrfeLTHXjs6KwPkAulekIi5mB2nmDLMsEqvvKraRvpRAmflZZQBmwm8ttKkUQNU5kJZp3SffZJbZSciPS1ANEnChKYVyT9FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BRYIDiiS; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-736cd36189bso7040489b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 May 2025 16:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746486953; x=1747091753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rzmWvtp9U4UZ+ZB+aWa866i4TSOZqljMe82DBGfpzvc=;
        b=BRYIDiiSMISLAFnT9Hqm3UjlZMNW89iG6gN2iTNoVNJ5azPXbx9+aOwJC/wvKKGzL2
         GAlMja3u1UwRmTYwMGDYKJZREDXfpLxhg4OTktoVGsViHt37+Tn0LF3ElFM0/JXCh1UJ
         DHvm6E8Fki039PPVGRysyCtv2+3PMb+LurHRWyN5S5lnLk12rZWfV4yrQYLCCqjQ+CJe
         AgDpwJIqLLZlomCTbZrBuPaKH0BlFOkSX5coTOhf8T5ytgYtiWBcjCN2+WK/+paw7LjU
         o9XD8P6kA4L1xUS9g0MfNbzV9lf9We8O2NX7x2aYUvdQE6Rjk4le7R9uF+UGgS5/VRV6
         fIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746486953; x=1747091753;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rzmWvtp9U4UZ+ZB+aWa866i4TSOZqljMe82DBGfpzvc=;
        b=YvqQFNq2Pq81GTdWOiFraC8jYrVixSmVzNcy9uiP/YRhpkDj9cmil8EnVVz4/cyVx3
         7CVC545lQNhurWPSU4FVMKwQp+QK1UpdWL661nXI74r6X6jdRu2m6RDRavBASyZd9zKA
         pIJyWExR40JYEKo7tG6coV5p02ZkfNEgzaGQn00Z49FDdqtpvJPvDGZsiHBdDpOBCTKt
         V+ZsBipsViPWDqXr4YMJ6ncsQDo2aunY0jzzmW1cdcq12C4gQb3JJyPtOpxikzrl2DDB
         FgjR6hn2qfqkfj1swI9Oz6CbSQCbh5f8dd5OS8yFhHuFcL2WXO5qiYfhnsxIBL/oSNBo
         m0zQ==
X-Gm-Message-State: AOJu0YxvEQeGggqwPAwAT1yF3k55myXuKJ8tOFpaBE4F2Y5KqKJCn7pH
	HKV/dc01LBH3/yaL1S4vDpy29EDnlSpiMOqDsdm14KAv3qi2KxH7TcPziY2fry2l3gpiElA7Yy0
	acA==
X-Google-Smtp-Source: AGHT+IHeMOXp2eUqIo91Z2v4BMrNwcYqIw4g1PHvTLgYii5R2aPOJF8QNAZePSzs6Tddg5PSxQIyvzZa0UY=
X-Received: from pfbde4.prod.google.com ([2002:a05:6a00:4684:b0:740:41eb:5856])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2793:b0:736:5c8e:baaa
 with SMTP id d2e1a72fcca58-740919b43a1mr1231292b3a.2.1746486952976; Mon, 05
 May 2025 16:15:52 -0700 (PDT)
Date: Mon, 5 May 2025 16:15:51 -0700
In-Reply-To: <b1cc7366-bd30-46ee-ac6e-35c2b08ffdb5@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250305230000.231025-1-prsampat@amd.com> <174622216534.881262.8086472919667553138.b4-ty@google.com>
 <b1cc7366-bd30-46ee-ac6e-35c2b08ffdb5@amd.com>
Message-ID: <aBlGp8i_zzGgKeIl@google.com>
Subject: Re: [PATCH v8 00/10] Basic SEV-SNP Selftests
From: Sean Christopherson <seanjc@google.com>
To: "Pratik R. Sampat" <prsampat@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, pbonzini@redhat.com, thomas.lendacky@amd.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, shuah@kernel.org, pgonda@google.com, 
	ashish.kalra@amd.com, nikunj@amd.com, pankaj.gupta@amd.com, 
	michael.roth@amd.com, sraithal@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 05, 2025, Pratik R. Sampat wrote:
> Hi Sean,
>=20
> On 5/2/25 4:50 PM, Sean Christopherson wrote:
> > On Wed, 05 Mar 2025 16:59:50 -0600, Pratik R. Sampat wrote:
> >> This patch series extends the sev_init2 and the sev_smoke test to
> >> exercise the SEV-SNP VM launch workflow.
> >>
> >> Primarily, it introduces the architectural defines, its support in the
> >> SEV library and extends the tests to interact with the SEV-SNP ioctl()
> >> wrappers.
> >>
> >> [...]
> >=20
> > Applied 2-9 to kvm-x86 selftests.  AIUI, the KVM side of things should =
already
> > be fixed.  If KVM isn't fixed, I want to take that discussion/patch to =
a
> > separate thread.
> >=20
>=20
> Thanks for pulling these patches in.
>=20
> For 1 - Ashish's commit now returns failure for this case [1].
> Although, it appears that the return code isn't checked within
> sev_platform_init()[2], so it shouldn't change existing behavior. In the
> kselftest case, if platform init fails, the selftest will also fail =E2=
=80=94 just as
> it does currently too.

Argh, now I remember the issue.  But _sev_platform_init_locked() returns '0=
' if
psp_init_on_probe is true, and I don't see how deferring __sev_snp_init_loc=
ked()
will magically make it succeed the second time around.

So shouldn't the KVM code be this?

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index e0f446922a6e..dd04f979357d 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3038,6 +3038,14 @@ void __init sev_hardware_setup(void)
        sev_snp_supported =3D sev_snp_enabled && cc_platform_has(CC_ATTR_HO=
ST_SEV_SNP);
=20
 out:
+       if (sev_enabled) {
+               init_args.probe =3D true;
+               if (sev_platform_init(&init_args))
+                       sev_supported =3D sev_es_supported =3D sev_snp_supp=
orted =3D false;
+               else
+                       sev_snp_supported &=3D sev_is_snp_initialized();
+       }
+
        if (boot_cpu_has(X86_FEATURE_SEV))
                pr_info("SEV %s (ASIDs %u - %u)\n",
                        sev_supported ? min_sev_asid <=3D max_sev_asid ? "e=
nabled" :
@@ -3067,12 +3075,6 @@ void __init sev_hardware_setup(void)
=20
        if (!sev_enabled)
                return;
-
-       /*
-        * Do both SNP and SEV initialization at KVM module load.
-        */
-       init_args.probe =3D true;
-       sev_platform_init(&init_args);
 }
=20
 void sev_hardware_unsetup(void)
--

Ashish, what am I missing?

> Regardless of what we decide on what the right behavior is, fail vs skip =
(I
> don't mind the former) we can certainly do that over new patches rebased =
over
> the new series.

FAIL, for sure.  Unless someone else pipes up with a good reason why they n=
eed
to defer INIT_EX, that's Google's problem to solve.

