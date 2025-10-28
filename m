Return-Path: <linux-kernel+bounces-874855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6381C17423
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D2854F6A16
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3370E36A60B;
	Tue, 28 Oct 2025 22:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rg5BM50R"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88259369997
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 22:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761692335; cv=none; b=lTaRJ5M0fsr5mNQCk7gYxkH7gnJk/tUxnIksw7bwYYUvdzNMpsJdIS2HL2p0zYkmFSh6HtRbfbXNWz/MelKNvxSXqOwDlQRnYCJv3FxVzEMS8EBlusbH2kb6o2hkjXgTFgKKQwBWeLBAYfpTkBB3Lo/N5/1fa3LIPNN8ZkQVL08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761692335; c=relaxed/simple;
	bh=NmfTEh2w90Vx1EUJhCoQ1DnPlLs96QxCb3TH8vg/crY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=Xlj+IvCKJxBRzYAVMdrcl3WaZnvFr9IQFtb9/974WvSn7rlP2t9evOGdEHwLSiZlt+mN0YZUmAl7387sZbkOz3nOx/a81y4MjgoU64NWVQxUTu19zLihfpnVaTWU+5JrZSXjglUxorCWDMyFzofs5Urp4rpmzcj4HU+h34FaU7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rg5BM50R; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-26983c4d708so49624595ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761692332; x=1762297132; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bafyIACgjKK14wqI7+UpK/XBf9Tl8hwNLLXvm7vBUiQ=;
        b=rg5BM50RbDfzDUoax+0Rg/P1gDZJHGNwZo+CuD7g5t4F0GRiwLg66Hy4/obTCnfM/8
         p2i1WBzwE5OR1dfm9erzIPV4PNgQzq0Z9+/OYVJQDGnYZYCiLOfqArpB4iTke4edxBOi
         /GWhXs8sa5RITns1Pu4+qo+eUpC3LKSKKHlJnFigfjyOqW4oYELByesmYjOzfYLQwYMp
         D0YyQO//FfiiHS52u/zh+LmI8o1Dnjg+jqUGYRGgG3olOFyGc/ONGVPLm2/No/FAzdqK
         Zyuxrnp4/oxOQ7E4Qb1tQXUWFdyBVK57loc9EY/y01FOGGRAfWQ76UFE+Yuef6xEg2dJ
         Op1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761692332; x=1762297132;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bafyIACgjKK14wqI7+UpK/XBf9Tl8hwNLLXvm7vBUiQ=;
        b=mhDGfEKbvNj+6zQv391QEvDVei07sIz8nhg3Jw8CLevlouy2/cTostjxonFmeyjrcJ
         vAljwLHalDU+tT0/VZuw+SDBGtC0Y6wSEXiQkQq4yM70Bia2YWE3tyyx1TtfVhChH1U/
         gJVlZ212k8KwqtXDQ5rTP3gKeEKkS7YO9ozpyO9B/FaivDFZuyCMAxGP/z/zNBkYKOld
         lW14cnyGpq0sMp1Fc2c2sGEpSYvtGCL+2n+gioEs73v+V/J8FGxA8niCwF0zzRFHgdRz
         z9StVyExwIpxZaUaneAanNOgpSOYoASYz5+IGD5QYxNoVGkna0oGUZUXtOm9OH0ouxDE
         a0Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWJ2NdjILVrw1Tf1wp60dY2iKMJQtoqTVfh+WG0EJtq9rAbsb9JywxBiriHO+Kmzd/DRORHH5wstOpNVIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC1Met4PwdWi+s1KMrDeHiig8eBh0J5P4+ZV5IfD9MKenklTk7
	J3MSM3FMld8hcqt/WxLdy9zUQrzIAHWzsn7+fzkherIyr2+fmr4h3EqwbpJHjK0CWX8pjWmRwnX
	Fug0m7fkn+0gX3A==
X-Google-Smtp-Source: AGHT+IHKY2pClvohg4IWDjCOvNKT01DkzF2lTStYT3sIYIsj1O8Psfszn4vksBsANMyqzlJojr3dGZ1p5DLaig==
X-Received: from pjbgq17.prod.google.com ([2002:a17:90b:1051:b0:33d:acf4:5aac])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e847:b0:293:e5f:85d7 with SMTP id d9443c01a7336-294def69091mr8641645ad.55.1761692331928;
 Tue, 28 Oct 2025 15:58:51 -0700 (PDT)
Date: Tue, 28 Oct 2025 15:30:38 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028225827.2269128-1-jmattson@google.com>
Subject: [PATCH v2 0/4] KVM: selftests: Test SET_NESTED_STATE with 48-bit L2
 on 57-bit L1
From: Jim Mattson <jmattson@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Bibo Mao <maobibo@loongson.cn>, Jim Mattson <jmattson@google.com>, 
	"Pratik R. Sampat" <prsampat@amd.com>, James Houghton <jthoughton@google.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Prior to commit 9245fd6b8531 ("KVM: x86: model canonical checks more
precisely"), KVM_SET_NESTED_STATE would fail if the state was captured
with L2 active, L1 had CR4.LA57 set, L2 did not, and the
VMCS12.HOST_GSBASE (or other host-state field checked for canonicality)
had an address greater than 48 bits wide.

Add a regression test that reproduces the KVM_SET_NESTED_STATE failure
conditions. To do so, the first three patches add support for 5-level
paging in the selftest L1 VM.

v1 -> v2
  Ended the page walking loops before visiting 4K mappings [Yosry]
  Changed VM_MODE_PXXV48_4K into VM_MODE_PXXVYY_4K;
    use 5-level paging when possible                       [Sean] 
  Removed the check for non-NULL vmx_pages in guest_code() [Yosry]

Jim Mattson (4):
  KVM: selftests: Use a loop to create guest page tables
  KVM: selftests: Use a loop to walk guest page tables
  KVM: selftests: Change VM_MODE_PXXV48_4K to VM_MODE_PXXVYY_4K
  KVM: selftests: Add a VMX test for LA57 nested state

 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../testing/selftests/kvm/include/kvm_util.h  |   4 +-
 .../selftests/kvm/include/x86/processor.h     |   2 +-
 .../selftests/kvm/lib/arm64/processor.c       |   2 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    |  30 ++--
 .../testing/selftests/kvm/lib/x86/processor.c |  80 +++++------
 tools/testing/selftests/kvm/lib/x86/vmx.c     |   6 +-
 .../kvm/x86/vmx_la57_nested_state_test.c      | 134 ++++++++++++++++++
 8 files changed, 197 insertions(+), 62 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/vmx_la57_nested_state_test.c

-- 
2.51.1.851.g4ebd6896fd-goog


