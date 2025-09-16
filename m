Return-Path: <linux-kernel+bounces-817959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E601B589C9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D232A3EBE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F37D15665C;
	Tue, 16 Sep 2025 00:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lfczR8kW"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DE819F40B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 00:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983118; cv=none; b=D7A/bOSJgEXe6JmN0zzoo6eYyK20GOpePJIQA1f9dM6JxdlT/1HF4W52rzFcsfa+y5D4OUg6/I8aH6Q++r9ePbX/1E8i8KlC4SigvSglM8Y8RN/BpPyYKPUObo6sCp/b3bRBc8bbztIXhBtkalcLCv11oVx2jNYbFvA5mPjhyjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983118; c=relaxed/simple;
	bh=lY8GwaCMi3yL6eor2HIlNkytFZaiNvCLkZjHU1cmdGQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HUGOdbdPgNQzsayMGo5Wi/Ub+kKHbnaIRmPiOFAShbh0m38pZaWXaEhrld4PFCwa/Lfvwt8/CD3O6TXzzXlyfcGgsV/Yqfo1Qvh0//M23LAaW6nuEtuwhZKQSA7LGN4CEVKoGrQjUuQUNVUaD5KH1o2SLyybYhoit1Gnynbl1U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lfczR8kW; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2445806b18aso46206155ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757983116; x=1758587916; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYW48A8ZfmbRdubUzd99a/MPRiGKsics+FOUrVX4GOY=;
        b=lfczR8kWgPhX2xOp1UlIy+rQhh+ctbSFy0BpPjfU4CD7tmpeNNKFcu1YL9ngAjLW6o
         DOGCoGCJOjKjYuIGu1qY3yquqlUs1lRejoxaTHCszWykFu8eP2ygP4lfKhcDL7O0sz5T
         klK6fQaDEOZsDHZlhnpnj1ToV3+nxjKwik5DhyktBH1kwJJXl2SW8CwO7JIbNWy/pDjG
         fZ3f+hoUTKfrye8hU/DLA8AhHrMyR//eye1oZ6A5tmAnEvfr59cVssANIPGTO6g10vSC
         Sxo+eF71HbFVmE2qSWMmMkIU8e3sIsIL3ODXKrAOlBZf/jKd1NjNK0JN1bHfDNqmvdKo
         JIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757983116; x=1758587916;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DYW48A8ZfmbRdubUzd99a/MPRiGKsics+FOUrVX4GOY=;
        b=pfcTt+4hfLLPrHNnNaTck4leeVAgzAXkBqAnV751syXOXwoQ4PxatxbAUganKXlEIs
         YeRnHhpgKXWVPrLrQMfS3AJKyKPZE/0BKhvSvyUmFKqogchBhYiOZ42j6OpnKm0oxo9G
         uQGLfUAmfe6RTsel0ct1ZLUd6oAY2nQnFkVDh3jKMoNa6gro9XhIQTRKsSH0Rk5rHLt/
         O2utFVz9I/viDDHriFvmKGUGa06FEoInhPvveWipI17mH4DYCe4ILEfFlq/UVnrtyxcK
         P77pIeJKZzYSXMobRSkxHYEbRMs3i8/rj95Qf/E9zMmsNLek51lYSh8Ad0zQGf7V3nxl
         Afag==
X-Forwarded-Encrypted: i=1; AJvYcCXUkdQ2M/D2uY85GYIW/twP4AFX60T1SEbXrYvdQQ5xeu0TWoNQbS9cWfsdJ60ec7n7sMxsSnJF5J3TI4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3riq2iknNO11WZq2yzPqwR6ycIO3Xi+q4yXpE4EDzQdxNo2B2
	32UMhF18JAYv5MvWQj5g6R/M55727/MlJq0sJ9aNsZo/xrhvQ2ycnK6/4WEQZSBQiH1dfX4uYzb
	43EhtBg==
X-Google-Smtp-Source: AGHT+IEEJtqj7LGKOGahSkhskOAxGFYu/wYgOwkvODUB3Ot1p+obyCbsuwmeiSpa2Wc5Jmgj4+aKlGFYyWY=
X-Received: from pjbsz7.prod.google.com ([2002:a17:90b:2d47:b0:329:b272:45a7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19e5:b0:267:d14d:3b31
 with SMTP id d9443c01a7336-267d14d3dcemr5897695ad.49.1757983115877; Mon, 15
 Sep 2025 17:38:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 15 Sep 2025 17:38:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250916003831.630382-1-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: AVIC vTPR fix for 6.17
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Please grab a single fix for 6.17.  The bug has existed for some time, so it's
not super critical that it get into 6.17, but it'd be nice to get this on its
way to LTS kernels sooner than later.  Thanks!

The following changes since commit 42a0305ab114975dbad3fe9efea06976dd62d381:

  Merge tag 'kvmarm-fixes-6.17-1' of https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD (2025-08-29 12:57:31 -0400)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-fixes-6.17-rcN

for you to fetch changes up to d02e48830e3fce9701265f6c5a58d9bdaf906a76:

  KVM: SVM: Sync TPR from LAPIC into VMCB::V_TPR even if AVIC is active (2025-09-10 12:04:16 -0700)

----------------------------------------------------------------
KVM x86 fix for 6.17-rcN

Sync the vTPR from the local APIC to the VMCB even when AVIC is active, to fix
a bug where host updates to the vTPR, e.g. via KVM_SET_LAPIC or emulation of a
guest access, effectively get lost and result in interrupt delivery issues in
the guest.

----------------------------------------------------------------
Maciej S. Szmigiero (1):
      KVM: SVM: Sync TPR from LAPIC into VMCB::V_TPR even if AVIC is active

 arch/x86/kvm/svm/svm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

