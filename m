Return-Path: <linux-kernel+bounces-821703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 882A5B8205D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 23:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1738C3BAAB6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE00530C110;
	Wed, 17 Sep 2025 21:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uTtD2/8g"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73962E6CCC
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 21:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758145872; cv=none; b=gw4Ts5ZYGlyV2zS4WQKuRcfmI0cA97/gouPYGmQqvJ7Oz9nKcM06VHl1Q7+Dqmtcv0AZ5NVKTS7QW82sTeRhGycYtQ8DY087K1VblyxmG9A5q+mQY3xM/kN4Gty23q8HqZRl8fPpSaqkUQ2mG3nY529ItwFpoHRNn4o4quSUXjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758145872; c=relaxed/simple;
	bh=7Kikigzj6v7xQLQkTso8DrWCMmvI9Q61cMxM45M2JCk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eMCVltz/e02QgpR1cHr1z/S917ai3J55RcdMTHJg5ht6cnQGFvG/YZMrbmiWgYBKScB38DGNA8nkoizvOccWL8IKdGLd7Lm0hA13PjkIMDQHOYOVd/1tJf7gO0p3qdG75Jzm6kFEz402qbf7Uu0k/dGnPQKzIzOgQ51KnT0tjBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uTtD2/8g; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32edda89a37so217151a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758145870; x=1758750670; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ajM88/oUy/Yl0c0O6x2AHxAgHs6Y/TSXT+30tD2YHi4=;
        b=uTtD2/8gWgJ7p0YrhfzpLA3sTUGCQuuGJ24bGofdsTBkQiYkbm9qpHhKvRmQGUsjtb
         gE1z9MqTgOJt+d6tII2srs3avatl49bEJ6QbEXrs6iO7p21pZXAdOHQ42h/xpXWrptmN
         9AaQAybRMuKrdmA/3mk1mGVok9sbzvJJX1fw+XNsR31sqSoEbqvQCYYCKLWHMkXs2klf
         EIl0eI1Bsr/ghcdDdNueV2D2xOfmAPRttF2h6gg3jXIizjFJYFUJzsXna/5r8/rktuHC
         bTxAliiaYPRKi8iMHezte7o3CIDJRaZecjmiF9vBLrxt7yjKM6vOCc849DKBzLxRLO8c
         Nxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758145870; x=1758750670;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ajM88/oUy/Yl0c0O6x2AHxAgHs6Y/TSXT+30tD2YHi4=;
        b=cBtBggSLwJwFaXDta0BDU3OWuThMYeOhmYQnKX0RkD1sZuaiX4A53Cx01KSEIS1IxT
         oRF0tjmiSRszqg4O2gc0oMQ7pQSEwpImFMAQCvIAVrQ40XmuWgHBb9k7W1tddYJ7bllV
         EZRaDqWAtKBYnUI2pydE++A4mqUPRTkdzaBJYJKSRd2bhWZRVXGLvHINA9/NuJDAyDQW
         19S92TvXTvC3YOzpzI2jZ9F3TMUwkP69VxcqHN/qPmhCJKy5qQ0Si+1FP9fgdsrcfF+V
         qSI4mvZJ7RjJZOomVIlBCKvDvwr/vXvZRfMApJTqNSB0BoCt5fqqYDUQBzNq6S3IfJ6V
         G6GA==
X-Forwarded-Encrypted: i=1; AJvYcCUm9PVU3VZelqCjuD/Wj0gFfVTjigWi7sj10/E4sx5Iw9P9NRvI1E2L6VD1PLdzwBfyNnZf9wxX+igez60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymp8cI7sd4e7gIZnwM8iAUZVMi8UXwYD4nto1U5wGE4wNHopdB
	zXG2hXeFakH6buVu7iSNi9Dlkd7HKMTk92qi/KFAgVelEgkJdljdQgyYg1D7bwFm3XlQ8hBzjV3
	4dUOMMXDg1LCoxw==
X-Google-Smtp-Source: AGHT+IGuJ6InU1uwz1vQZt4vJlEgwJ4Yf4LegHTymtlEqGFSXxcpP7nsg41o2ag4+s55H5sX67g9OdL22Qxqig==
X-Received: from pjbhl16.prod.google.com ([2002:a17:90b:1350:b0:32d:a0b1:2b03])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:264d:b0:329:e4d1:c20f with SMTP id 98e67ed59e1d1-32ee3e9047bmr4178903a91.9.1758145870033;
 Wed, 17 Sep 2025 14:51:10 -0700 (PDT)
Date: Wed, 17 Sep 2025 14:48:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250917215031.2567566-1-jmattson@google.com>
Subject: [PATCH 0/4] KVM: selftests: Add test of SET_NESTED_STATE with 48-bit
 L2 on 57-bit L1
From: Jim Mattson <jmattson@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Andrew Jones <ajones@ventanamicro.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Kai Huang <kai.huang@intel.com>, Eric Auger <eric.auger@redhat.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Prior to commit 9245fd6b8531 ("KVM: x86: model canonical checks more
precisely"), KVM_SET_NESTED_STATE would fail if the state was captured
with L2 active, L1 had CR4.LA57 set, L2 did not, and the
VMCS12.HOST_GSBASE (or other host-state field checked for canonicality)
had an address greater than 48 bits wide.

Add a regression test that reproduces the KVM_SET_NESTED_STATE failure
conditions. To do so, the first three patches add support for 5-level
paging in the selftest L1 VM.

Jim Mattson (4):
  KVM: selftests: Use a loop to create guest page tables
  KVM: selftests: Use a loop to walk guest page tables
  KVM: selftests: Add VM_MODE_PXXV57_4K VM mode
  KVM: selftests: Add a VMX test for LA57 nested state

 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../testing/selftests/kvm/include/kvm_util.h  |   1 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  21 +++
 .../testing/selftests/kvm/lib/x86/processor.c |  66 ++++-----
 tools/testing/selftests/kvm/lib/x86/vmx.c     |   7 +-
 .../kvm/x86/vmx_la57_nested_state_test.c      | 137 ++++++++++++++++++
 6 files changed, 195 insertions(+), 38 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/vmx_la57_nested_state_test.c

-- 
2.51.0.470.ga7dc726c21-goog


