Return-Path: <linux-kernel+bounces-654373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA3AABC77F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 20:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D23B27A784A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 18:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38CC2116E0;
	Mon, 19 May 2025 18:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MQLPdmGG"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73EF21D5A2
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 18:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747680940; cv=none; b=Jn68ftPd2kg9a71FSGSs0rYVgUYXx2DDvfd8k3dxH1rCsJXySxHYhFMgKtwl99o7fgOT1lJQd8p53hTjDNGQsQe9bI/fXgSv17dd2csrVVDNmd2VysKCpWrPExpRnjYvsyvgLs9BE8DkMh0q7u2YEaBjwECrArt3M2oJqXZDolc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747680940; c=relaxed/simple;
	bh=02DhIDJiTY5SN586FcWil6j3M7CNOC2X358tokby4WI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qK7bXhbVPksnSvgtpICH0tnDkovMQLrIIltAhWKJWgfuJG5tWjvuat6yMZSqIiEhYf53ooFiwkOmqsqzI2BFBAR5de1OawiC9wEsj6+zz83k6L0b5Mkxf9cPb6llpqlkrQFCGCFt/VgzdM3x1iXok/nLs5x8hmWDdoab4SXOw1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MQLPdmGG; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30a39fa0765so7235407a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 11:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747680938; x=1748285738; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=OKVb/rjt7xbg7iGYLrHxAz9ea9MJSgJFrfmn1LPAXvg=;
        b=MQLPdmGGNrurKK9Z76ndvFmSq/po1e8tqpkQfF319JrfT5pSrhOlFB66LQRT+SvzZr
         9k77+XBCHjGsR9G6qtdArqASdCekVOSuv1pzyIs3tPtnB4B4kVFGqaXM3DNvHhyI/eKo
         4HncYAjYVR8UILzZBeomjMxwaY3Bd9zyp/1qVXH+c4FPM+RWg2glq8+k+a9UWqt6iDrP
         bn5Kd+4eixnVzknvw/qfBcpv+vx3QiLCVUPSkhatdR3VsneW0+nc/NMD8p5bDXZICoK9
         Ome9qK1UdMnD0pcX/l1QGRkRhutUfxn34pBGnT5l9QvtYCnxXrq4ZPYMUl9aXsewGH1D
         lLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747680938; x=1748285738;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OKVb/rjt7xbg7iGYLrHxAz9ea9MJSgJFrfmn1LPAXvg=;
        b=Jp7GRZREkgyb+CGqDcQNZlaMYJhcVPRwrQB04MRjAO+PyzOaAWeLKcwqfIPIpr2PJC
         j7OJQlqlxSiA9Xxhv6V12uYqFZvoi3/3Z4NPmNim6GgAYy/B8PndMrUKHAQx5IutrzjL
         /gaHk6/3cBJpxlALW/8EP6tx/f9i9m4+DD7tLYBzUFfn1kD9lY6ULq87eK/fqa/25bAP
         v8ODu/R/oiglKG9b4j8r7Qya4NibPYP3z0LAmoTm1zOMC+b+fbsM9ny0srEPbp/NyzO/
         uJzvsne1OlqhIGvHnfiLwdBWcUkQBrEnnYEOZK+s146t+3NjnrW08X86cgAmtrpPrLWu
         pcTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGC6ql9bh66DictphIlxa3i9RP+TbNev1CY7XvA+nRwsCXX+1zZa6xejMw1x0DLSQxN0fs4Q5ya6Gwls8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLVVHS7D846kNizDc7Mdy7VdXuHsEVL7PBx4zwJIoN7Y2DnUDV
	ZIkMDo533yRCYvxTvgDjbTSXKUIBJZ+KQF3TFi73m5NYJewnJPaV9omJqT1JbB5H0kkBRKtvz0s
	yTDnBmg==
X-Google-Smtp-Source: AGHT+IEj2WzLh67Ixl+YoFxokm7fFAzAUdnIzgu7IZZuNo0LIfTZvWOpLGE1fjEGyPSa8CLIT1wrF7Tf+5Y=
X-Received: from pjbqa8.prod.google.com ([2002:a17:90b:4fc8:b0:30e:85f1:6fa5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c08:b0:30e:6a10:bb41
 with SMTP id 98e67ed59e1d1-30e7d5a85c1mr21316229a91.27.1747680938275; Mon, 19
 May 2025 11:55:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 19 May 2025 11:55:13 -0700
In-Reply-To: <20250519185514.2678456-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250519185514.2678456-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250519185514.2678456-12-seanjc@google.com>
Subject: [PATCH v2 11/12] KVM: selftests: Add utilities to create eventfds and
 do KVM_IRQFD
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	K Prateek Nayak <kprateek.nayak@amd.com>, David Matlack <dmatlack@google.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Content-Type: text/plain; charset="UTF-8"

Add helpers to create eventfds and to (de)assign eventfds via KVM_IRQFD.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/arm64/vgic_irq.c  | 12 ++----
 .../testing/selftests/kvm/include/kvm_util.h  | 40 +++++++++++++++++++
 .../selftests/kvm/x86/xen_shinfo_test.c       | 18 ++-------
 3 files changed, 47 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/vgic_irq.c b/tools/testing/selftests/kvm/arm64/vgic_irq.c
index f4ac28d53747..a09dd423c2d7 100644
--- a/tools/testing/selftests/kvm/arm64/vgic_irq.c
+++ b/tools/testing/selftests/kvm/arm64/vgic_irq.c
@@ -620,18 +620,12 @@ static void kvm_routing_and_irqfd_check(struct kvm_vm *vm,
 	 * that no actual interrupt was injected for those cases.
 	 */
 
-	for (f = 0, i = intid; i < (uint64_t)intid + num; i++, f++) {
-		fd[f] = eventfd(0, 0);
-		TEST_ASSERT(fd[f] != -1, __KVM_SYSCALL_ERROR("eventfd()", fd[f]));
-	}
+	for (f = 0, i = intid; i < (uint64_t)intid + num; i++, f++)
+		fd[f] = kvm_new_eventfd();
 
 	for (f = 0, i = intid; i < (uint64_t)intid + num; i++, f++) {
-		struct kvm_irqfd irqfd = {
-			.fd  = fd[f],
-			.gsi = i - MIN_SPI,
-		};
 		assert(i <= (uint64_t)UINT_MAX);
-		vm_ioctl(vm, KVM_IRQFD, &irqfd);
+		kvm_assign_irqfd(vm, i - MIN_SPI, fd[f]);
 	}
 
 	for (f = 0, i = intid; i < (uint64_t)intid + num; i++, f++) {
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index a1fc52bbdf7a..befa3d8ea84c 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -18,6 +18,7 @@
 #include <asm/atomic.h>
 #include <asm/kvm.h>
 
+#include <sys/eventfd.h>
 #include <sys/ioctl.h>
 
 #include "kvm_util_arch.h"
@@ -496,6 +497,45 @@ static inline int vm_get_stats_fd(struct kvm_vm *vm)
 	return fd;
 }
 
+static inline int __kvm_irqfd(struct kvm_vm *vm, uint32_t gsi, int eventfd,
+			      uint32_t flags)
+{
+	struct kvm_irqfd irqfd = {
+		.fd = eventfd,
+		.gsi = gsi,
+		.flags = flags,
+		.resamplefd = -1,
+	};
+
+	return __vm_ioctl(vm, KVM_IRQFD, &irqfd);
+}
+
+static inline void kvm_irqfd(struct kvm_vm *vm, uint32_t gsi, int eventfd,
+			      uint32_t flags)
+{
+	int ret = __kvm_irqfd(vm, gsi, eventfd, flags);
+
+	TEST_ASSERT_VM_VCPU_IOCTL(!ret, KVM_IRQFD, ret, vm);
+}
+
+static inline void kvm_assign_irqfd(struct kvm_vm *vm, uint32_t gsi, int eventfd)
+{
+	kvm_irqfd(vm, gsi, eventfd, 0);
+}
+
+static inline void kvm_deassign_irqfd(struct kvm_vm *vm, uint32_t gsi, int eventfd)
+{
+	kvm_irqfd(vm, gsi, eventfd, KVM_IRQFD_FLAG_DEASSIGN);
+}
+
+static inline int kvm_new_eventfd(void)
+{
+	int fd = eventfd(0, 0);
+
+	TEST_ASSERT(fd >= 0, __KVM_SYSCALL_ERROR("eventfd()", fd));
+	return fd;
+}
+
 static inline void read_stats_header(int stats_fd, struct kvm_stats_header *header)
 {
 	ssize_t ret;
diff --git a/tools/testing/selftests/kvm/x86/xen_shinfo_test.c b/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
index 34d180cf4eed..23909b501ac2 100644
--- a/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
+++ b/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
@@ -547,11 +547,8 @@ int main(int argc, char *argv[])
 	int irq_fd[2] = { -1, -1 };
 
 	if (do_eventfd_tests) {
-		irq_fd[0] = eventfd(0, 0);
-		TEST_ASSERT(irq_fd[0] >= 0, __KVM_SYSCALL_ERROR("eventfd()", irq_fd[0]));
-
-		irq_fd[1] = eventfd(0, 0);
-		TEST_ASSERT(irq_fd[1] >= 0, __KVM_SYSCALL_ERROR("eventfd()", irq_fd[1]));
+		irq_fd[0] = kvm_new_eventfd();
+		irq_fd[1] = kvm_new_eventfd();
 
 		irq_routes.info.nr = 2;
 
@@ -569,15 +566,8 @@ int main(int argc, char *argv[])
 
 		vm_ioctl(vm, KVM_SET_GSI_ROUTING, &irq_routes.info);
 
-		struct kvm_irqfd ifd = { };
-
-		ifd.fd = irq_fd[0];
-		ifd.gsi = 32;
-		vm_ioctl(vm, KVM_IRQFD, &ifd);
-
-		ifd.fd = irq_fd[1];
-		ifd.gsi = 33;
-		vm_ioctl(vm, KVM_IRQFD, &ifd);
+		kvm_assign_irqfd(vm, 32, irq_fd[0]);
+		kvm_assign_irqfd(vm, 33, irq_fd[1]);
 
 		struct sigaction sa = { };
 		sa.sa_handler = handle_alrm;
-- 
2.49.0.1101.gccaa498523-goog


