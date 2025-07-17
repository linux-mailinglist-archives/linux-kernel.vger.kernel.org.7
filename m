Return-Path: <linux-kernel+bounces-735811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7962B09421
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA2CD3A2634
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E990421170D;
	Thu, 17 Jul 2025 18:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQGQ3s4a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B135C20E334
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 18:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777682; cv=none; b=fk2dyPGMVc80E8KSwqFRrKNZdhuS+BVgFJu7GvN1wtoYI3IiMguuGqcKmqVelWfRIH0R9HZArVv2W3TImwWbyKrBRIC9I0qXgoqPCx1sY/d1VzGl52bcvdM9jVXZgBYMlA3rPgta05VTQsFyf/tHajLW7bbS/OBUT9mXQh5qsoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777682; c=relaxed/simple;
	bh=nro6gm+zDiHSB8q7rj7XXjAICkwCHUQqjW6cmhSPta0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NPNtmULbZJMcFMTjPNcTB4KFA/N3304H9xUCDzAMU2eIZMZpZHIIQYbUIPUKAjOLQXeRUGYdLITYyH0qHY0beimAlpZ4tc8nuSMPLqcjOQC4mmu5PjTX4Bs+glHtyDJVVX5fXkpjDk1UYy76jjYNcMTP7Og+DDkVlgYBrliMq3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IQGQ3s4a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752777679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U+AfXX0y9f9hE0A//sYkWB7cfoLM/vRxUUjyHHcWA8E=;
	b=IQGQ3s4aOUHJjLGirZTlazAzyGr9xWXsV3iev78P3XvfUl83zs+61ReZMQbthl3QtDVcsy
	1UJs5SrKFvDtK+OuNLktHLGtkU1+ikUlE/u2C9NMcewquk0ulk8/3l3szPN/g6qIlJePIX
	SrZ8ANcZvOJd++UDxUUaNVGeoxV8EA0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-uvg_ls5aONi7fDHIbBmOlA-1; Thu,
 17 Jul 2025 14:41:13 -0400
X-MC-Unique: uvg_ls5aONi7fDHIbBmOlA-1
X-Mimecast-MFC-AGG-ID: uvg_ls5aONi7fDHIbBmOlA_1752777670
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73D8D1800C36;
	Thu, 17 Jul 2025 18:41:10 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.66.69])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 991EF1956089;
	Thu, 17 Jul 2025 18:41:07 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v11 00/14] Refcounted interrupts, SpinLockIrq for rust
Date: Thu, 17 Jul 2025 14:37:52 -0400
Message-ID: <20250717184055.2071216-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

This is the latest patch series for adding rust bindings for controlling
local processor interrupts, adding support for spinlocks in rust that
are acquired with local processor interrupts disabled, and implementing
local interrupt controls through refcounting in the kernel.

The previous version of this patch series can be found here:

https://lkml.org/lkml/2025/5/27/1219

This patch series applies on top of the rust-next branch.

Boqun Feng (6):
  preempt: Introduce HARDIRQ_DISABLE_BITS
  preempt: Introduce __preempt_count_{sub, add}_return()
  irq & spin_lock: Add counted interrupt disabling/enabling
  rust: helper: Add spin_{un,}lock_irq_{enable,disable}() helpers
  rust: sync: lock: Add `Backend::BackendInContext`
  locking: Switch to _irq_{disable,enable}() variants in cleanup guards

Lyude Paul (8):
  irq: Add KUnit test for refcounted interrupt enable/disable
  rust: Introduce interrupt module
  rust: sync: Add SpinLockIrq
  rust: sync: Introduce lock::Backend::Context
  rust: sync: Add a lifetime parameter to lock::global::GlobalGuard
  rust: sync: Expose lock::Backend
  rust: sync: lock/global: Add Backend parameter to GlobalGuard
  rust: sync: lock/global: Add BackendInContext support to GlobalLock

 arch/arm64/include/asm/preempt.h     |  18 ++
 arch/s390/include/asm/preempt.h      |  10 +
 arch/x86/include/asm/preempt.h       |  10 +
 include/asm-generic/preempt.h        |  14 ++
 include/linux/irqflags_types.h       |   6 +
 include/linux/preempt.h              |  20 +-
 include/linux/spinlock.h             |  88 +++++++--
 include/linux/spinlock_api_smp.h     |  27 +++
 include/linux/spinlock_api_up.h      |   8 +
 include/linux/spinlock_rt.h          |  15 ++
 kernel/irq/Makefile                  |   1 +
 kernel/irq/refcount_interrupt_test.c | 108 +++++++++++
 kernel/locking/spinlock.c            |  29 +++
 kernel/softirq.c                     |   3 +
 rust/helpers/helpers.c               |   1 +
 rust/helpers/interrupt.c             |  18 ++
 rust/helpers/spinlock.c              |  15 ++
 rust/helpers/sync.c                  |   5 +
 rust/kernel/interrupt.rs             |  86 +++++++++
 rust/kernel/lib.rs                   |   1 +
 rust/kernel/sync.rs                  |   5 +-
 rust/kernel/sync/lock.rs             |  69 ++++++-
 rust/kernel/sync/lock/global.rs      |  91 ++++++---
 rust/kernel/sync/lock/mutex.rs       |   2 +
 rust/kernel/sync/lock/spinlock.rs    | 272 +++++++++++++++++++++++++++
 25 files changed, 871 insertions(+), 51 deletions(-)
 create mode 100644 kernel/irq/refcount_interrupt_test.c
 create mode 100644 rust/helpers/interrupt.c
 create mode 100644 rust/kernel/interrupt.rs


base-commit: 23b128bba76776541dc09efaf3acf6242917e1f0
-- 
2.50.0


