Return-Path: <linux-kernel+bounces-746418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0325B1267F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41C295879C2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D36265288;
	Fri, 25 Jul 2025 22:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uZw+M0+g"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA97D2641FC
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 22:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753481254; cv=none; b=GyRsgeoS5jZPiM/5fLBXgIacMX6Iuu2sKG4tXOVXac8Vbu77jxEcG8bQ52csP0dSWZPP85WEHxwTjJKADCLdZ5dn4WrxNDGCOSA0pEfDS+Y11R6aaUObn7FPNEra1nln03LZfaAj+lEqh7V47uG/2IC/gBW3IVVwUFeOUroZXlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753481254; c=relaxed/simple;
	bh=abLpqvJxSIZbPdFo1BTzkz/diu6mfiCRjLClhqyjwxc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GT9lExtdDkiiEWVbCmsi1c6rCN9PtStVoJ+dCuJHduVH8f2c7bcZ6S1/eTKwpYq37bV89ym/oKKmbMKtQi9BIjr5Y8GxPKdIaxNsFMyL8A1CoAifBXaQFpLFTdXUuesGnyo0nH+qijpOJjojp8SL/v9BvNaD5ksB/0rvATDOoN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uZw+M0+g; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-313d346dc8dso4112868a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753481252; x=1754086052; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=X6X3zbgFRSWQOltzrYJm8357YkjydV/3raX+xE2R1uo=;
        b=uZw+M0+ghvyLAE/wR2EFaNJFvMY7PKzyvB8/A1l43pDnWPE6OGx/QErdm99DRD6hx5
         qpNlAm4ixUeQh3DLtsQX/UrBycsasQOcLBv47OODUuiiGGHK6EbUqzS2Zkv3ukD1dazC
         kVc7OIQL1QsKpiXELk6x/FXCuMzbTdjprzRmk8a9FlP7WXRKkGd5XAAdkXXWCHT4/2Oo
         kDffF2ufIgkrqaLcKZ5Vd87m56F1kR0tzCnBZM5dyKP0yIPwnAcwo16MfabaXtjkoCrX
         gKLc8h7sg5FeU3J1RyRHrUbHqK9tX4lVdOABbtiTMiVOwU8PI5xCDzxESu7iQdhW1lHB
         nemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753481252; x=1754086052;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X6X3zbgFRSWQOltzrYJm8357YkjydV/3raX+xE2R1uo=;
        b=MWG35d9X8wT0KI4YrvKqFuMzV94dvlZuidcyQmiVe3MLxpxHKp/3Y9HYD7khnpr3l5
         gFwyuYAvo2yUrzcYZyEjchzHsEsbLVUFlM8U+4/mhPunAln56GN5T2DpOrSGmEzSsLAr
         GIF0BnDFy6yeyUWSHvD2ZX9KxVK48tJDsDIOOme3hJrcZ8yh94qSNAHFxEMNjPPlrUch
         MHOEz+837+zVw9WrAycIkStlXnYrRW56UsABPsXDT76vc1gNor3iODdaoW3xKotQyoJD
         9GK1oyVnTlPOW/R+yu2j4mBCWBOQd3r6icyHMMMWESCLSX5HBXpzVVPzCLfKRvE5BfhA
         iMtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwPl8pMz5rNonyTuht7S9nVaJEGiQPcPZP9Od6QwDyjHr6DCiqRK7TbkKeI+fgTn2Y+grBkOJEvOBh2eU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPL3Tgf+DPQr1iioC+pfZ6CHlPbrZxZU7+bc3esBkw2mRJZ6hL
	iXv0iC56tqetCAnvKU3PEMSdeKt+JKwLMWsfqEJsh+5ZNrbfA4w57LW8d7EYNAOYva6l347bl/R
	TO+nALw==
X-Google-Smtp-Source: AGHT+IGjJsB588IbCOEdRsmckCBkD5eL2L0y/a+t6/hjC8Qz2NcIIuOXcPkqe96FVTpXiYitH3r4tm1Yzrs=
X-Received: from pjbsl3.prod.google.com ([2002:a17:90b:2e03:b0:312:1e70:e233])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d0e:b0:315:7ddc:4c2a
 with SMTP id 98e67ed59e1d1-31e778594bcmr5096051a91.12.1753481252222; Fri, 25
 Jul 2025 15:07:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 25 Jul 2025 15:07:09 -0700
In-Reply-To: <20250725220713.264711-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725220713.264711-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250725220713.264711-10-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: Selftests changes for 6.17
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Minor "quality of user life" selftests cleanups.

The following changes since commit 28224ef02b56fceee2c161fe2a49a0bb197e44f5:

  KVM: TDX: Report supported optional TDVMCALLs in TDX capabilities (2025-06-20 14:20:20 -0400)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-selftests-6.17

for you to fetch changes up to 71443210e26de3b35aea8dced894ad3c420d55d5:

  KVM: selftests: Print a more helpful message for EACCESS in access tracking test (2025-06-20 13:39:11 -0700)

----------------------------------------------------------------
KVM selftests changes for 6.17

 - Fix a comment typo.

 - Verify KVM is loaded when getting any KVM module param so that attempting to
   run a selftest without kvm.ko loaded results in a SKIP message about KVM not
   being loaded/enabled, versus some random parameter not existing.

 - SKIP tests that hit EACCES when attempting to access a file, with a "Root
   required?" help message.  In most cases, the test just needs to be run with
   elevated permissions.

----------------------------------------------------------------
Rahul Kumar (1):
      KVM: selftests: Fix spelling of 'occurrences' in sparsebit.c comments

Sean Christopherson (4):
      KVM: selftests: Verify KVM is loaded when getting a KVM module param
      KVM: selftests: Add __open_path_or_exit() variant to provide extra help info
      KVM: selftests: Play nice with EACCES errors in open_path_or_exit()
      KVM: selftests: Print a more helpful message for EACCESS in access tracking test

 .../selftests/kvm/access_tracking_perf_test.c      |  7 ++-----
 tools/testing/selftests/kvm/include/kvm_util.h     |  1 +
 .../testing/selftests/kvm/include/x86/processor.h  |  6 +++++-
 tools/testing/selftests/kvm/lib/kvm_util.c         | 23 ++++++++++++++++++----
 tools/testing/selftests/kvm/lib/sparsebit.c        |  4 ++--
 tools/testing/selftests/kvm/lib/x86/processor.c    | 10 ----------
 .../x86/vmx_exception_with_invalid_guest_state.c   |  2 +-
 7 files changed, 30 insertions(+), 23 deletions(-)

