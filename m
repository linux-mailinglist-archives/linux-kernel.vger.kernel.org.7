Return-Path: <linux-kernel+bounces-824763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC25B8A1A3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5865A6928
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DFD314D16;
	Fri, 19 Sep 2025 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A3SvdodX"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252C726056E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293533; cv=none; b=GyHPx0cQN+tNsgtbmjqzp5ZwV0KJZJoTCRVBkUFNcNEuxoOi5cm/LmkUrIGBz2e/U4tlV4qXfdl10NWHj551Bvw+oXYf4LT8TsEyvEY67vhMRMllCA4cnWYstitmYDOniRaQ0PpXzacQS3P7UJ54PsrMYHGHhAyhhDBxu1lUTP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293533; c=relaxed/simple;
	bh=6D6SqMtWSKtJDdKIrSRZDRoPnNK05sin8tyieroXLRU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SlMBfQ6ALCfvhNGnudr3eqV2xPbxvcJwAz6JYYJocPVQC+cbEeoL225ejMsrIop5WbyL5751Ec11Ltc6yOSmOWhVmOft5//N+i3pPU5yCT24ho83uuxu+hZPzC9wLiQ6QOCECrQXf8/GI+XPK/yvB/pKAO81razToaQITqV8EVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A3SvdodX; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32ec69d22b2so2184545a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758293531; x=1758898331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A0jOGknmtzmPM6thoivlUjTeAw6e5thM0wJjij/rXoU=;
        b=A3SvdodXw2HqdQqaCvXBuvAT1NC9lsTG7N4yRi1VY8wNx0DkSZ8R9Ut3P1N8bbAuw+
         EVbQAgphTQTmzmHkaA8ayu4VV3lfyYAKUead7IA3h89zWGfEsytwtw+K2R99w2L4EzRP
         2qIYqswNGLSZLM5w6pBBboEEV1OGET1smVXD3nZuVvp7aeo9G5xauugqNbPGtr9FK/+2
         pHvVb39dEkZoQPuomivXGY3O4ioXhuPtBOLaKmTfh24a0hCbufXclElDnorS61USrsB1
         rmk00Q9BWI3bPWEPP4aNrXRurmD7I9y3jdg/3D52RKEC+c9LVWhweS6HI0/AgxNhRbuk
         1FTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758293531; x=1758898331;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A0jOGknmtzmPM6thoivlUjTeAw6e5thM0wJjij/rXoU=;
        b=IQ/LwhYd5FJLsUvU4iLFJ+Fuqa8D4FWUadH9P2hzviWuNqPXytqTkuBPNQEIWH39C/
         WizohlCXxd6yOndo7IYLPBNw/9Fr5k5jH0YD/0HgKhg+ujXVvlnAfbJjDtrzLOVJGar0
         4HDS+tYEQYrBOG7AqzthfVN+DHL31B4bUrnw9llSxqSyEq29Zc0RQ8A6sdW26ggMMvbe
         3hYimWdwqfS8DspS+JNKQUvrS5L9/RLcbRVmoyBXaxC/LYMtD0F+iUr3p5tVPleo5QjN
         QQRHGB9yORUwmILsLg63PMa+f2BTP1GWC52hFPAtrnBOE9NzbQ6witImUkAoaqDml0WL
         OghQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRLoXZ42OUvDSimxfTzk18+zMWfTVRfpM/JEw5r3qnKBsNTs4r4CcwO+8oQy+37XoAS+Iky47cI3YwNZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt3nTEJZNG922MF9G6Piy4QfUZDy94/s6O0CpW0w8zopG2CB6l
	wBaCi3N+erVJfxoWeLUmEJnXnJTB8ICokZTghdfKFLqqn/eAOnEg2FNbEUk0sgYqOoDvaJOPF1L
	qK6OrxQ==
X-Google-Smtp-Source: AGHT+IH7xV4CB5Pc7bAH+u0niGppj+PVAa20/47KqsHH1XqnVxnjS8UrBbz6leuLo1f1C7Eedl4woFqVh9c=
X-Received: from pjbpw13.prod.google.com ([2002:a17:90b:278d:b0:32e:ca6a:7ca9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d:b0:327:9e88:7714
 with SMTP id 98e67ed59e1d1-3309838b4e0mr5064433a91.37.1758293531478; Fri, 19
 Sep 2025 07:52:11 -0700 (PDT)
Date: Fri, 19 Sep 2025 07:52:10 -0700
In-Reply-To: <8e3faa80-7091-454b-8ac6-1aa431185c06@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919004512.1359828-1-seanjc@google.com> <20250919004512.1359828-3-seanjc@google.com>
 <8e3faa80-7091-454b-8ac6-1aa431185c06@linux.intel.com>
Message-ID: <aM1uGrlftd589vLd@google.com>
Subject: Re: [PATCH v3 2/5] KVM: selftests: Track unavailable_mask for PMU
 events as 32-bit value
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yi Lai <yi1.lai@intel.com>, dongsheng <dongsheng.x.zhang@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025, Dapeng Mi wrote:
> On 9/19/2025 8:45 AM, Sean Christopherson wrote:
> > diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tool=
s/testing/selftests/kvm/x86/pmu_counters_test.c
> > index 8aaaf25b6111..cfeed0103341 100644
> > --- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
> > +++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
> > @@ -311,7 +311,7 @@ static void guest_test_arch_events(void)
> >  }
> > =20
> >  static void test_arch_events(uint8_t pmu_version, uint64_t perf_capabi=
lities,
> > -			     uint8_t length, uint8_t unavailable_mask)
> > +			     uint8_t length, uint32_t unavailable_mask)
> >  {
> >  	struct kvm_vcpu *vcpu;
> >  	struct kvm_vm *vm;
> > @@ -320,6 +320,9 @@ static void test_arch_events(uint8_t pmu_version, u=
int64_t perf_capabilities,
> >  	if (!pmu_version)
> >  		return;
> > =20
> > +	unavailable_mask =3D GENMASK(X86_PROPERTY_PMU_EVENTS_MASK.hi_bit,
> > +				   X86_PROPERTY_PMU_EVENTS_MASK.lo_bit);
>=20
> Should be "unavailable_mask &=3D"? Otherwise the incoming argument
> "unavailable_mask" would be overwritten unconditionally.=C2=A0

/facepalm

Yes, definitely supposed to be &=3D.

