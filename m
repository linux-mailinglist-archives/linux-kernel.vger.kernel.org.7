Return-Path: <linux-kernel+bounces-883212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E363C2CF73
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D0B0462190
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBE332C930;
	Mon,  3 Nov 2025 15:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPHXyoKT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32514329E51
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182921; cv=none; b=ddUwaPPRAd+/ZDSMl5rAdKJKIYAKTaCK0hyJi9xnRiYBufmQ/HDRK2E+Fnvl65cmduNURquR8HQ/+yQTxY6lDvhi/inIvJfcY5jFPf/18BaQV67RTJt9lN2ra28NnQyoxG4aZ0W4EvIS7SP63P+/Dkpt6LiYJ1YMXh9gSnkZx9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182921; c=relaxed/simple;
	bh=RonmCY/g3g2ajug217LDcsL+qF/MLKQoyvWwQC4pCvE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m7SleuzSx8L4aEeFG5x6HL8w3vLD9VRJwaRTbTJzIcrKEfzarE0Yimj6V6SMizf137epteD5NGzu4EjyxBclbIng2F/6BhbrTL1VFxx2CTV1imTaVHplR1BrAV6FW6udr89TnqAbCnQiT7M+psxfEo7BhZrO9bvjjjk2o3+lyRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPHXyoKT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0598AC2BCFA;
	Mon,  3 Nov 2025 15:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762182920;
	bh=RonmCY/g3g2ajug217LDcsL+qF/MLKQoyvWwQC4pCvE=;
	h=Date:From:To:Cc:Subject:From;
	b=nPHXyoKTnWu5StYm8lVPAZGPq3IUj9iL8vUjyFEXzt+6EM0jA6Ej2J62G3SfFllma
	 VWY8xvCvI7E8oCC0OjzIDgwWsteD62UmEGq7c7hGAG188yYhBBVT2+xlgBjx0vUePb
	 aGjAELA/WqL3iTsHaRhwaubTjnrk6n3V4age4+E2gJKZPUJ79bnI81kXdhI2/jpB/W
	 rXETYTmUIcvodPS0mPRgmQuiWugrQeGJ+EpFvHAfG8zdHWIihwCiHKhNGE3Kklu8/Q
	 tlq7qI/ANjofJVQPpDwrnOzRiGgspimHQqsCJBvKxPV4V/oxZZM0vm6CBmVLU5ZmzZ
	 k8dr9cPyBfQuA==
Date: Mon, 3 Nov 2025 12:15:16 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Yang Weijiang <weijiang.yang@intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1] tools headers UAPI: Sync x86's asm/kvm.h with the kernel
 sources
Message-ID: <aQjHBMAslfvIksxs@x1>
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

  fddd07626baa419c ("KVM: x86: Define AMD's #HV, #VC, and #SX exception vectors")
  f2f5519aa4e3ec4e ("KVM: x86: Define Control Protection Exception (#CP) vector")
  9d6812d415358372 ("KVM: x86: Enable guest SSP read/write interface with new uAPIs")
  06f2969c6a1237f0 ("KVM: x86: Introduce KVM_{G,S}ET_ONE_REG uAPIs support")

That just rebuilds kvm-stat.c on x86, no change in functionality.

This silences these perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/kvm.h

Please see tools/include/uapi/README for further details.

Cc: Sean Christopherson <seanjc@google.com>
Cc: Yang Weijiang <weijiang.yang@intel.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/uapi/asm/kvm.h | 34 +++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/arch/x86/include/uapi/asm/kvm.h b/tools/arch/x86/include/uapi/asm/kvm.h
index 0f15d683817d6a77..d420c9c066d48c98 100644
--- a/tools/arch/x86/include/uapi/asm/kvm.h
+++ b/tools/arch/x86/include/uapi/asm/kvm.h
@@ -35,6 +35,11 @@
 #define MC_VECTOR 18
 #define XM_VECTOR 19
 #define VE_VECTOR 20
+#define CP_VECTOR 21
+
+#define HV_VECTOR 28
+#define VC_VECTOR 29
+#define SX_VECTOR 30
 
 /* Select x86 specific features in <linux/kvm.h> */
 #define __KVM_HAVE_PIT
@@ -411,6 +416,35 @@ struct kvm_xcrs {
 	__u64 padding[16];
 };
 
+#define KVM_X86_REG_TYPE_MSR		2
+#define KVM_X86_REG_TYPE_KVM		3
+
+#define KVM_X86_KVM_REG_SIZE(reg)						\
+({										\
+	reg == KVM_REG_GUEST_SSP ? KVM_REG_SIZE_U64 : 0;			\
+})
+
+#define KVM_X86_REG_TYPE_SIZE(type, reg)					\
+({										\
+	__u64 type_size = (__u64)type << 32;					\
+										\
+	type_size |= type == KVM_X86_REG_TYPE_MSR ? KVM_REG_SIZE_U64 :		\
+		     type == KVM_X86_REG_TYPE_KVM ? KVM_X86_KVM_REG_SIZE(reg) :	\
+		     0;								\
+	type_size;								\
+})
+
+#define KVM_X86_REG_ID(type, index)				\
+	(KVM_REG_X86 | KVM_X86_REG_TYPE_SIZE(type, index) | index)
+
+#define KVM_X86_REG_MSR(index)					\
+	KVM_X86_REG_ID(KVM_X86_REG_TYPE_MSR, index)
+#define KVM_X86_REG_KVM(index)					\
+	KVM_X86_REG_ID(KVM_X86_REG_TYPE_KVM, index)
+
+/* KVM-defined registers starting from 0 */
+#define KVM_REG_GUEST_SSP	0
+
 #define KVM_SYNC_X86_REGS      (1UL << 0)
 #define KVM_SYNC_X86_SREGS     (1UL << 1)
 #define KVM_SYNC_X86_EVENTS    (1UL << 2)
-- 
2.51.1


