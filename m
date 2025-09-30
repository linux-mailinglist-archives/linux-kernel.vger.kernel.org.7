Return-Path: <linux-kernel+bounces-837563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE51BAC973
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6933B192687C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A6C2FB97D;
	Tue, 30 Sep 2025 11:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xKBOP4yR"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F682FB612
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 11:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759230009; cv=none; b=uJwDY1mUOmpGivrvsZ/LV2atY+XEHtRhRqbhcJp5o2DIY/qPXdVvw+tK1NzfVwYTGjbPmffC+B91UOMQpVGuXz6a+WyTo0Q1KEURaSw4MvaC2N/o0eWVruzBvtd7shipjC6iye0hv6Xiz0Ttlx/jybwnsvcmbBo2oDWR+Ddxe7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759230009; c=relaxed/simple;
	bh=wFnoy4QXjxAmYJyA1+5t7l0ikN0i8PEuNczTcDuAws4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rZei607N8kLC18Fx64grYgPrbuS/tQMvQetYC27SdQ1grMRdgmsejVYlyEnqy09lSVLLfW+ngI4kOtjByZNgY7nKAmgtUl8rIXKfOap/IBPv0rD5xjdI7UIm8dHDSYpfwmhWXSWNNXDZ/VAwGRRFV0tV+zBMHE//wOtFXutDL2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xKBOP4yR; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b556284db11so5572962a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 04:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759230007; x=1759834807; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BW2Qtj+KVSZo32MbcvWapFjwhM8eljdM2/EMaeJKXfU=;
        b=xKBOP4yRxXeQil4xoiFV+ATZKn67HZHAjxJfuvQGgoRXgpCMdYKCA3S3w43F/bqs31
         NYQcTDCvo43m1wkVYVNiR+VuX+kGghzsyEsFZJyL8jFvektUCnmjYluMrvzL7lEZFZ2C
         uwgtkLshxchhEWbdowqd2bh/lEuxRgumxZZCTQDOg5w8A601g9qQyVLRczBrWRGr8gUt
         Kn9/M+jJ9lkyVhAjmxm6khjaq2EerP4nvaOG/A0j1BpQYkZw1vXmL5+/tBH/+4H7v2ts
         HdLh3I977Ot2w2S3S/DoFgB3Dmacp8unEUH3rE9pZ2i5yUi5bhd6BRQljyQ5WOGTvFYJ
         8WnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759230007; x=1759834807;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BW2Qtj+KVSZo32MbcvWapFjwhM8eljdM2/EMaeJKXfU=;
        b=IzPRbzRju2w+jeODGDYPz0RthIncLfIRPGGfVu2+FRgxFfWyh/J4ZYOCcyq3Nh1ul/
         wZvGPS0bK4IKR/EiEIK2mEoRE0nbU2HvUIyAscKYXq67xZFJj3i5AUYmX2SENaOC1z2v
         gB0VDTan27g8JLlEsMjjcnybi6FW5kQOeOaICmp0zOfbh2lPWqxvpgItYI4PdLJ/khjQ
         lu8TtTWPBVza6X/GOM9FcBWhBkT3aCdwUPdcuP2OJPV6Km8ydC+1ZD82v4ZyMboqAc5X
         XV2KRRrWyqffDyM5/BzOy3kS9m6SjDTBLpgjLqZVxJskL2OJaLhBYyILj7a8lun1iC5m
         LohA==
X-Forwarded-Encrypted: i=1; AJvYcCXSabs7EqrQkBWbJCnFevjxaF+qa9/LUV2XQVoeGjJbKifJnh62Lb+YJs4qFIQMmGZmJYcnQstxDO7O1I0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsR5kY4Bztg+ijdqq4B6fg9+u5OmnLghWNMZkTkEb8Ldz8aABM
	kA5XG5s1lNqgiK5mXLu30oUKWyuyHGgcm6fG/Ac0BHOoXkfCOA5FxnlW2eqIagx+Da3QrFhsNrj
	Uhq/XLIC9jRTy+CQuo8z0KLcD0YlC7dpWvW44i6iWaw==
X-Gm-Gg: ASbGnctC0mxWqsgk0cdq9khgfbPy+lYtpzg6R0jtPSELCacxfxRsYosevUPoNpzKePc
	UuE9kNsbPBHfE8Frdk9u+aHDvPXf9M3cBIFVcB7iJA4OhTn7PAWVdNgvUgMz+llGHuWk+EYM1Jm
	J6/FbVfPoCcao8QxVtaJigI5kn+6opUgJr05rYssJsPYby1nHiXrpm/e+jCox+/o5w1f4rkLN5O
	L7YppPQ4zohWAY/ZjaeoqUHZr4LN1xZ3MwKeD5VQwQX4CdjMw4HKTY2WZgg0y6MLqjY8pLac+cc
	VpSdLqJb40j30FiR3JjAsRDKStpljA==
X-Google-Smtp-Source: AGHT+IHtPuZgSVMGlUzaI5vj/KwcQ6zTwdUWSWUwa6mgNiKsVgXu8raJbRpSbZR/+jnNv3jtSjo9LDhitaHxBXunC00=
X-Received: by 2002:a17:902:e809:b0:24e:3cf2:2453 with SMTP id
 d9443c01a7336-27ed4a89ac5mr212915705ad.61.1759230006932; Tue, 30 Sep 2025
 04:00:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 30 Sep 2025 16:29:54 +0530
X-Gm-Features: AS18NWA_909avJZvTE7jLbzzAOBb2Sb9YrnKfuZvYcjUAeZSImH28wlpR68IqJ4
Message-ID: <CA+G9fYuUcs_-SKWSbiAgyzuhE9-oqSAGDQOU6pTPfwq57+cWSw@mail.gmail.com>
Subject: selftests: kvm: irqfd_test: KVM_IRQFD failed, rc: -1 errno: 11
 (Resource temporarily unavailable)
To: "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kvmarm@lists.linux.dev, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: kvm list <kvm@vger.kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The selftests: kvm: irqfd_test consistently fails across all test platforms
since its introduction in Linux next-20250625. The failure occurs due to
a KVM_IRQFD ioctl returning errno 11 (Resource temporarily unavailable).
This has been observed from day one and is reproducible on all test runs.

Reproducibility: 100% failure on all test platforms since
next-20250625..next-20250929

Test fails on the below list
 * graviton4
 * rk3399-rock-pi-4b

## Initial Observations:
The test is attempting to register an IRQFD but fails with EAGAIN (errno 11).
This likely indicates resource exhaustion or unsupported behavior on
affected ARM-based platforms.

Could you please advise on the way forward for this test?
Should we treat this as an unsupported case on ARM platforms,
or is there a missing implementation/configuration that needs to be addressed?

## Test log
selftests: kvm: irqfd_test
Random seed: 0x6b8b4567
==== Test Assertion Failure ====
  include/kvm_util.h:527: !ret
  pid=721 tid=721 errno=11 - Resource temporarily unavailable
     1 0x000000000040250f: kvm_irqfd at kvm_util.h:527
     2 0x000000000040222f: main at irqfd_test.c:100
     3 0x0000ffffbd43229b: ?? ??:0
     4 0x0000ffffbd43237b: ?? ??:0
addr2line:      5 0x000000000040206f: DWARF error: mangled line number
section (bad file number)
addr2line: DWARF error: mangled line number section (bad file number)
_start at ??:?
  KVM_IRQFD failed, rc: -1 errno: 11 (Resource temporarily unavailable)
not ok 4 selftests: kvm: irqfd_test exit=254

## Links
   * https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250929/testrun/30048394/suite/kselftest-kvm/test/kvm_irqfd_test/log
   * https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250929/testrun/30048394/suite/kselftest-kvm/test/kvm_irqfd_test/details/

