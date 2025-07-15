Return-Path: <linux-kernel+bounces-732329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 566A3B06529
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 19:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43D0417B849
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DEC2853F8;
	Tue, 15 Jul 2025 17:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MaReNlTW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A552CCC0
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752600649; cv=none; b=CINVQCT7o3/cyzggiSewiTUFiwd0MR3lFtZs3AflcAkYs9UsMvczVT604YGdgf6cdvHVt8qbipFUJHs8QpXgYeOvkftr5JhmTxKKgx4BYYmaPdh7pILwEKdrhCUf52LS9L6AhTTIphi3wChPYoiqF27c5FgXxL9H40hpUjRa26w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752600649; c=relaxed/simple;
	bh=OicMDYwkIxFtbCHm2GkQKVqKCEIne5yDeXU4/6B5SLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SPe9WEKJQbyLEl9s6d9EddmtIKOsBXxTs9n6WYcpCTuEAiYKULfTo7WLhxiIeEG/5MjFDTEqBrGtSyfUsGKAMd1LVsvsV3YRaLOUwMJV63VdRgZRD7BblZwou51kZ8cFdyDUD8N1rSnepmM2IKmZCvqMdYKwXMI/RMsICjDHSBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MaReNlTW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752600646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qeaioDV5y+/M11cE3dFJNrEA7V3W8i3+YqsMbWa6FZM=;
	b=MaReNlTW6pQCBpfgw47ZhhSQBT1knp5+4jVybPjMpqhqeMHhOZq8R7ZgsK1//NSSg5f5kC
	gVAnyudro10ruQLS7f3EdxFCUQZfZtv0ZGM2ZwKAcNoM/OPtGVnbfmT/nXbtKI2h5M+U1+
	7DKyCdbKCP7mv2PFCWGbJXuf046iZc4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-4REdj7viMRSOkmSJCGL1bA-1; Tue, 15 Jul 2025 13:30:45 -0400
X-MC-Unique: 4REdj7viMRSOkmSJCGL1bA-1
X-Mimecast-MFC-AGG-ID: 4REdj7viMRSOkmSJCGL1bA_1752600644
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f858bc5eso4366214f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 10:30:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752600643; x=1753205443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qeaioDV5y+/M11cE3dFJNrEA7V3W8i3+YqsMbWa6FZM=;
        b=J9CKJUdUak8Y56qn5YWhd9cMLarXb4L4jpa9MCbHdE08F3MoczK8Q3RG2C+hy0ZfiB
         Xvo6Zf5ekUML/8AK9aDs8draRB7I6vLuWCuXv1DU6LZ8FKPifr8LS+QiOXWSiypKimzI
         2jjPaObjz8PeLaKKtoZJEFakF+Xz9exq0GHJziKKRai/KBq/dqmYdyDWGaTrnQ1/7gyM
         6TYxWloPOYb0WsXqjCFhrC3yGqnkIsmN6LzNcv9WaZgEowbnfU3yPqJVc90gyh5r3Wvd
         nNFmtQTQy5J4LOFn+7GUmeXtW6Bp4uHg7/nvrzVkkJfGYgKkaALdRpGSxntD3ejm57lw
         Q3Vg==
X-Gm-Message-State: AOJu0Ywd1CmLdp84dxJH8QIU0uMjSFFDhwaN3NFJCb/6EApbF7uLnp8t
	NiHxsz/27nOmdqXC1Nyp2nGlCsC5BMcBflN5i/Zd2xKQY9GIH4DmBSROQTUcI0PI7RjVoGdOb+f
	mgyFTLCxR+kPXLJnG6rMGqQQLLt2ZH/i0lLVqJdGpJqDTSc5Wz/ZO7r+giRM+06VbcSTK0ZdK7r
	R8HDbPm80XBDD2QTmD/Hd1A3lGjkie8MnqOasohs3ilTXXhkb0Pw==
X-Gm-Gg: ASbGncvF9/Wrf7a+sHSv+ZVU8H+R4KpjyseefFMg9GFollPnxoN5VwKruL60iEpmVQw
	AAxio/0roCYk3gZCBJOpiVEqslfBNlJcgQc9MqbFWHLzm6LgQ22b3xtLi8QIiOSTSmPHr3frv/R
	SrDDCuk21Py6KLp5MnAcbPUGSgJ/J3hIKARcbhLT58FZgbB3zmH10UQCulYitVf1WT4oRCzved8
	4LCAfTv0Sgx4dFChLTrKBOdoJfVfbI38KLWINHz3cm+D3lxC5dF3HOatuSCd03Mt92vb65Aozid
	lPrOGFwpPRBr8uzm1b1y+E+irav+t3SresxEvLJ0A5A=
X-Received: by 2002:a05:600c:5024:b0:456:1611:cea5 with SMTP id 5b1f17b1804b1-4561611d3d6mr93534225e9.18.1752600642560;
        Tue, 15 Jul 2025 10:30:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgdfzHMYKo96xJPVD8XmG2KZ3Hiiv3pnWqQBgJmnGsb7o44GvKpXjabolY14F3WHgvp7NY0g==
X-Received: by 2002:a05:600c:5024:b0:456:1611:cea5 with SMTP id 5b1f17b1804b1-4561611d3d6mr93533785e9.18.1752600642060;
        Tue, 15 Jul 2025 10:30:42 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.73.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1e8cfsm15224072f8f.80.2025.07.15.10.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 10:30:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@redhat.com,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v2] KVM: Documentation: document how KVM is tested
Date: Tue, 15 Jul 2025 19:30:40 +0200
Message-ID: <20250715173040.209885-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Proper testing greatly simplifies both patch development and review,
but it can be unclear what kind of userspace or guest support
should accompany new features. Clarify maintainer expectations
in terms of testing expectations; additionally, list the cases in
which open-source userspace support is pretty much a necessity and
its absence can only be mitigated by selftests.

While these ideas have long been followed implicitly by KVM contributors
and maintainers, formalize them in writing to provide consistent (though
not universal) guidelines.

Suggested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Documentation/virt/kvm/review-checklist.rst | 90 +++++++++++++++++++--
 1 file changed, 85 insertions(+), 5 deletions(-)

diff --git a/Documentation/virt/kvm/review-checklist.rst b/Documentation/virt/kvm/review-checklist.rst
index 7eb9974c676d..debac54e14e7 100644
--- a/Documentation/virt/kvm/review-checklist.rst
+++ b/Documentation/virt/kvm/review-checklist.rst
@@ -21,8 +21,7 @@ Review checklist for kvm patches
 6.  New cpu features should be exposed via KVM_GET_SUPPORTED_CPUID2,
     or its equivalent for non-x86 architectures
 
-7.  Emulator changes should be accompanied by unit tests for qemu-kvm.git
-    kvm/test directory.
+7.  The feature should be testable (see below).
 
 8.  Changes should be vendor neutral when possible.  Changes to common code
     are better than duplicating changes to vendor code.
@@ -37,6 +36,87 @@ Review checklist for kvm patches
 11. New guest visible features must either be documented in a hardware manual
     or be accompanied by documentation.
 
-12. Features must be robust against reset and kexec - for example, shared
-    host/guest memory must be unshared to prevent the host from writing to
-    guest memory that the guest has not reserved for this purpose.
+Testing of KVM code
+-------------------
+
+All features contributed to KVM, and in many cases bugfixes too, should be
+accompanied by some kind of tests and/or enablement in open source guests
+and VMMs.  KVM is covered by multiple test suites:
+
+*Selftests*
+  These are low level tests that allow granular testing of kernel APIs.
+  This includes API failure scenarios, invoking APIs after specific
+  guest instructions, and testing multiple calls to ``KVM_CREATE_VM``
+  within a single test.  They are included in the kernel tree at
+  ``tools/testing/selftests/kvm``.
+
+``kvm-unit-tests``
+  A collection of small guests that test CPU and emulated device features
+  from a guest's perspective.  They run under QEMU or ``kvmtool``, and
+  are generally not KVM-specific: they can be run with any accelerator
+  that QEMU support or even on bare metal, making it possible to compare
+  behavior across hypervisors and processor families.
+
+Functional test suites
+  Various sets of functional tests exist, such as QEMU's ``tests/functional``
+  suite and `avocado-vt <https://avocado-vt.readthedocs.io/en/latest/>`__.
+  These typically involve running a full operating system in a virtual
+  machine.
+
+The best testing approach depends on the feature's complexity and
+operation. Here are some examples and guidelines:
+
+New instructions (no new registers or APIs)
+  The corresponding CPU features (if applicable) should be made available
+  in QEMU.  If the instructions require emulation support or other code in
+  KVM, it is worth adding coverage to ``kvm-unit-tests`` or selftests;
+  the latter can be a better choice if the instructions relate to an API
+  that already has good selftest coverage.
+
+New hardware features (new registers, no new APIs)
+  These should be tested via ``kvm-unit-tests``; this more or less implies
+  supporting them in QEMU and/or ``kvmtool``.  In some cases selftests
+  can be used instead, similar to the previous case, or specifically to
+  test corner cases in guest state save/restore.
+
+Bug fixes and performance improvements
+  These usually do not introduce new APIs, but it's worth sharing
+  any benchmarks and tests that will validate your contribution,
+  ideally in the form of regression tests.  Tests and benchmarks
+  can be included in either ``kvm-unit-tests`` or selftests, depending
+  on the specifics of your change.  Selftests are especially useful for
+  regression tests because they are included directly in Linux's tree.
+
+Large scale internal changes
+  While it's difficult to provide a single policy, you should ensure that
+  the changed code is covered by either ``kvm-unit-tests`` or selftests.
+  In some cases the affected code is run for any guests and functional
+  tests suffice.  Explain your testing process in the cover letter,
+  as that can help identify gaps in existing test suites.
+
+New APIs
+  It is important to demonstrate your use case.  This can be as simple as
+  explaining that the feature is already in use on bare metal, or it can be
+  a proof-of-concept implementation in userspace.  The latter need not be
+  open source, though that is of course preferrable for easier testing.
+  Selftests should test corner cases of the APIs, and should also cover
+  basic host and guest operation if no open source VMM uses the feature.
+
+Bigger features, usually spanning host and guest
+  These should be supported by Linux guests, with limited exceptions for
+  Hyper-V features that are testable on Windows guests.  It is strongly
+  suggested that the feature be usable with an open source host VMM, such
+  as at least one of QEMU or crosvm, and guest firmware.  Selftests should
+  test at least API error cases.  Guest operation can be covered by
+  either selftests of ``kvm-unit-tests`` (this is especially important for
+  paravirtualized and Windows-only features).  Strong selftest coverage
+  can also be a replacement for implementation in an open source VMM,
+  but this is generally not recommended.
+
+Following the above suggestions for testing in selftests and
+``kvm-unit-tests`` will make it easier for the maintainers to review
+and accept your code.  In fact, even before you contribute your changes
+upstream it will make it easier for you to develop for KVM.
+
+Of course, the KVM maintainers reserve the right to require more tests,
+though they may also waive the requirement from time to time.
-- 
2.50.1


