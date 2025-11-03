Return-Path: <linux-kernel+bounces-883083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B98DCC2C739
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 15:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C84763B7480
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 14:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E614281503;
	Mon,  3 Nov 2025 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcgRrtfe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2FA27FB26
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762180852; cv=none; b=g/UTOTOFutjs0Bydsxy3zM/DBz8D3MvZNK6piPZccG5lemKB9QQPbD846zrYOMqa8gl05nkpjuomeB0N7dZiOoBeTx4WEUonAgs6udXKuZ2jJgfdxHN8SeISjboYT0xYk2SAd6JgqDAFcwuOook/qkZwZH1ZxqvwY5CFwkNh560=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762180852; c=relaxed/simple;
	bh=6+pA0xLGF1dPFTrzGqXqXrg449YCinBLwlhFlOUKDhs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NCr/Y7x0ceBpr6h50b9jYbzgQdQl53s9STHN6vrtLlM9JHuvEHOPupoAcH3FMsppNpHqqU/zSUmW1sp65XHpRp4EiQi3j3lW+2Z2aHN58h2H3U8d8wfDewveIir4yvs8SLtamKp73KqYBKAIbNogUZZWvuZjf1kwenHosIAn2z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcgRrtfe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACDFC116B1;
	Mon,  3 Nov 2025 14:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762180851;
	bh=6+pA0xLGF1dPFTrzGqXqXrg449YCinBLwlhFlOUKDhs=;
	h=Date:From:To:Cc:Subject:From;
	b=pcgRrtfe7VvROrYxHHSbobP4gAXgq1jy6vBV+BYP9IkvskVUWpmBGXX37LoIvY3q3
	 o3f+r/YmAlVvVlxWHLcoL7gmrpdRZi8jfxt3So1V2XiAociSGreSYlan04UmewZ6j6
	 PollcdhMEZa5kzZeoEOQ3pyXrsEQ5NeNtbAaRyKILo8ZrOKD2Elfz5VAqWIAq/65TM
	 YJo9TVa5vSUD4CX3nQilcCG8C4wAxHZ+KD0/Yyn2DzMPoLNYL46rknwJVYd9GbECm3
	 8LOgZGN7QPtI9ejuF/Nlve0/cC6js/UCK2zEmNHb57ZbWnXEAdjkarBoU4jCup/WIg
	 uAEQPP8zyhKpA==
Date: Mon, 3 Nov 2025 11:40:48 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>, Fuad Tabba <tabba@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1] tools headers UAPI: Sync linux/kvm.h with the kernel
 sources
Message-ID: <aQi-8IuAQ8CIPZuL@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tldr; Just FYI, I'm carrying this on the perf tools tree.

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

See further details at:

 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/include/uapi/README

To pick the changes in:

  fe2bf6234e947bf5 ("KVM: guest_memfd: Add INIT_SHARED flag, reject user page faults if not set")
  d2042d8f96ddefde ("KVM: Rework KVM_CAP_GUEST_MEMFD_MMAP into KVM_CAP_GUEST_MEMFD_FLAGS")
  3d3a04fad25a6621 ("KVM: Allow and advertise support for host mmap() on guest_memfd files")

That just rebuilds perf, as these patches don't add any new KVM ioctl to
be harvested for the the 'perf trace' ioctl syscall argument
beautifiers.

This addresses this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h

  Please see tools/include/uapi/README for further details.

Cc: Sean Christopherson <seanjc@google.com>
Cc: Fuad Tabba <tabba@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/kvm.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index f0f0d49d25443552..52f6000ab020840e 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -962,6 +962,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_ARM_EL2_E2H0 241
 #define KVM_CAP_RISCV_MP_STATE_RESET 242
 #define KVM_CAP_ARM_CACHEABLE_PFNMAP_SUPPORTED 243
+#define KVM_CAP_GUEST_MEMFD_FLAGS 244
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1598,6 +1599,8 @@ struct kvm_memory_attributes {
 #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
 
 #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
+#define GUEST_MEMFD_FLAG_MMAP		(1ULL << 0)
+#define GUEST_MEMFD_FLAG_INIT_SHARED	(1ULL << 1)
 
 struct kvm_create_guest_memfd {
 	__u64 size;
-- 
2.51.1


