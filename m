Return-Path: <linux-kernel+bounces-850959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA18DBD4CBB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC53918A60B2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDD5309F02;
	Mon, 13 Oct 2025 15:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RyOQ9Qal"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF29309F13
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370832; cv=none; b=b7Lq0VD/9F5kx6dtVuo2xr6n0b8OeIHRXZgE5nYC9R6isP0Wn0lVEzfpLnOUZYSAl1t88FN/m5zamndXR6WCD3XxeVqwD7uGVr8R+AEKSS5Jjeydfy6THC4Ch1Vn7mExLkUKdintUYoOqrFUUA2jPLghaeXwBaoFi0Bw4Jc2d+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370832; c=relaxed/simple;
	bh=lLIUAqr0+VuHd6KHKbhGUblt54EZGY1Y3RBmYK81RS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FOoApvMzvhjtoVTzH400Y/HQrWr2Q9wskJA8HUBdxEhngM+UDMjkr9i8xRO9mlv28X1fT4qMlgmTNFXwr+KgZV+2CTkfXX0x4npRdouYIFRWLLiknHSNFfKVqq3CtLQepyPz2MdzoTz3yTI+HdkNu/HOMHnQmLDgL4xAcrj+U/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RyOQ9Qal; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760370829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r8xaHK5ucYWJx0wIBjNag7nRJMXc3u1z7Mp1ncrTJMM=;
	b=RyOQ9Qal4ykqsFZ+Fy7ptpgeNtzKjJsfQe0/e7qUCM8Cq//S5cCRnPlMggDFbMJbXMUlZf
	r0j25AqFZNy9MjaMeod90Mg+W2AROrbVrfzf4bZluW0mtSzX3yzM8O1rEMl9dvb41PvrT9
	ndZJ2U5vH/t9MJVF1pJM62itCb/x+Fo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-KY1WLjYaOviwLUXPYcFRgg-1; Mon,
 13 Oct 2025 11:53:45 -0400
X-MC-Unique: KY1WLjYaOviwLUXPYcFRgg-1
X-Mimecast-MFC-AGG-ID: KY1WLjYaOviwLUXPYcFRgg_1760370822
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 60DE71956094;
	Mon, 13 Oct 2025 15:53:41 +0000 (UTC)
Received: from chopper.lan (unknown [10.22.81.1])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 74D363000382;
	Mon, 13 Oct 2025 15:53:38 +0000 (UTC)
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
Subject: [PATCH v13 00/17] Refcounted interrupts, SpinLockIrq for rust
Date: Mon, 13 Oct 2025 11:48:02 -0400
Message-ID: <20251013155205.2004838-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This is the latest patch series for adding rust bindings for controlling
local processor interrupts, adding support for spinlocks in rust that
are acquired with local processor interrupts disabled, and implementing
local interrupt controls through refcounting in the kernel.

The previous version of this patch series can be found here:

https://lkml.org/lkml/2025/5/27/1219

This patch series applies on top of the rust-next branch.

There's a few big changes from the last time. Mainly that we've
addressed all(?) of the open questions on this patch series:

* Thanks to Joel Fernandes, we now have a seperate per-CPU counter for
  tracking NMI nesting - which ensures that we don't have to sacrifice
  NMI nest level bits in order to store a counter for refcounted IRQs.
  These patches have been included at the start of the series.
* We've been able to prove that being able to convert the kernel over to
  this new interface is indeed possible, more on this below.
* Also thank to Joel, we also now have actual benchmarks for how this
  affects performance:
  https://lore.kernel.org/rust-for-linux/20250619175335.2905836-1-joelagnelf@nvidia.com/
* Also some small changes to the kunit test I added, mainly just making
  sure I don't forget to include a MODULE_DESCRIPTION or MODULE_LICENSE.

Regarding the conversion plan: we've had some success at getting kernels
to boot after attempting to convert the entire kernel from the
non-refcounted API to the new refcounted API. It will definitely take
quite a lot of work to get this right though, at least in the kernel
core side of things. To give readers an idea of what I mean, here's a
few of the issues that we ended up running into:

On my end, I tried running a number of coccinelle conversions for this.
At first I did actually try simply rewiring
local_irq_disable()/local_irq_enable() to
local_interrupt_enable()/local_interrupt_disable(). This wasn't really
workable though, as it causes the kernel to crash very early on in a
number of ways that I haven't fully untangled. Doing this with
coccinelle on the other hand allowed me to convert individual files at a
time, along with specific usage patterns of the old API, and as a result
this ended up giving me a pretty good idea of where our issues are
coming from. This coccinelle script, while still leaving most of the
kernel unconverted, was at least able to be run on almost all of kernel/
while still allowing us to boot on x86_64

@depends on patch && !report@
@@
- local_irq_disable();
+ local_interrupt_disable();
...
- local_irq_enable();
+ local_interrupt_enable();

There were two files in kernel/ that were exceptions to this:

* kernel/softirq.c
* kernel/main.c (I figured out at least one fix to an issue here)

The reason this worked is because it seems like the vast majority of the
issues we're seeing come from "unbalanced"/"misordered" usages of the
old irq API. And there seems to be a few reasons for this:

* The first simple reason: occasionally the enable/disable was split
  across a function, which this script didn't handle.
* The second more complicated reason: some portions of the kernel core
  end up calling processor instructions that modify the processor's
  local interrupt flags independently of the kernel. In x86_64's case, I
  believe we came to the conclusion the iret instruction (interrupt
  return) was modifying the interrupt flag state. There's possibly a few
  more instances like this elsewhere.

Boqun also took a stab at this on aarch64, and ended up having similar
findings. In their case, they discovered one of the culprits being
raw_spin_rq_unlock_irq(). Here the reason is that on aarch64
preempt_count is per-thread and not just per-cpu, and when context
switching you generally disable interrupts from one task and restore it
in the other task. So in order to fix it, we'll need to make some
modifications to the aarch64 context-switching code.

So - with this being said, we decided that the best way of converting it
is likely to just leave us with 3 APIs for the time being - and have new
drivers and code use the new API while we go through and convert the
rest of the kernel.


Boqun Feng (6):
  preempt: Introduce HARDIRQ_DISABLE_BITS
  preempt: Introduce __preempt_count_{sub, add}_return()
  irq & spin_lock: Add counted interrupt disabling/enabling
  rust: helper: Add spin_{un,}lock_irq_{enable,disable}() helpers
  rust: sync: lock: Add `Backend::BackendInContext`
  locking: Switch to _irq_{disable,enable}() variants in cleanup guards

Joel Fernandes (2):
  preempt: Track NMI nesting to separate per-CPU counter
  preempt: Reduce NMI_MASK to single bit and restore HARDIRQ_BITS

Lyude Paul (9):
  irq: Add KUnit test for refcounted interrupt enable/disable
  rust: Introduce interrupt module
  rust: sync: Add SpinLockIrq
  rust: sync: Introduce lock::Backend::Context
  rust: sync: lock/global: Rename B to G in trait bounds
  rust: sync: Add a lifetime parameter to lock::global::GlobalGuard
  rust: sync: Expose lock::Backend
  rust: sync: lock/global: Add Backend parameter to GlobalGuard
  rust: sync: lock/global: Add BackendInContext support to GlobalLock

 arch/arm64/include/asm/preempt.h     |  18 ++
 arch/s390/include/asm/preempt.h      |  10 +
 arch/x86/include/asm/preempt.h       |  10 +
 include/asm-generic/preempt.h        |  14 ++
 include/linux/hardirq.h              |  17 +-
 include/linux/irqflags.h             |  39 ++++
 include/linux/irqflags_types.h       |   6 +
 include/linux/preempt.h              |  23 ++-
 include/linux/spinlock.h             |  50 +++--
 include/linux/spinlock_api_smp.h     |  27 +++
 include/linux/spinlock_api_up.h      |   8 +
 include/linux/spinlock_rt.h          |  15 ++
 kernel/irq/Makefile                  |   1 +
 kernel/irq/refcount_interrupt_test.c | 109 +++++++++++
 kernel/locking/spinlock.c            |  29 +++
 kernel/softirq.c                     |   5 +
 rust/helpers/helpers.c               |   1 +
 rust/helpers/interrupt.c             |  18 ++
 rust/helpers/spinlock.c              |  15 ++
 rust/helpers/sync.c                  |   5 +
 rust/kernel/alloc/kvec.rs            |   5 +-
 rust/kernel/cpufreq.rs               |   3 +-
 rust/kernel/interrupt.rs             |  86 +++++++++
 rust/kernel/lib.rs                   |   1 +
 rust/kernel/sync.rs                  |   5 +-
 rust/kernel/sync/lock.rs             |  69 ++++++-
 rust/kernel/sync/lock/global.rs      |  91 ++++++---
 rust/kernel/sync/lock/mutex.rs       |   2 +
 rust/kernel/sync/lock/spinlock.rs    | 272 +++++++++++++++++++++++++++
 29 files changed, 894 insertions(+), 60 deletions(-)
 create mode 100644 kernel/irq/refcount_interrupt_test.c
 create mode 100644 rust/helpers/interrupt.c
 create mode 100644 rust/kernel/interrupt.rs


base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.51.0


