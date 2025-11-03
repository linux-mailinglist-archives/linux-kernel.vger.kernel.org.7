Return-Path: <linux-kernel+bounces-883350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9E5C2D210
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B76D4EA7DB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB573161A4;
	Mon,  3 Nov 2025 16:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYqMFosC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4467027FB0E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187347; cv=none; b=eg7WXCSZg1gwkkhqW5nDUDyVe331oa5z34or5lzdijIbdpaddDZtp1/zWIgGHkFTf54Nw9lukmStfIUkFECeY3kAwBoXURA39QItEkOeg1w0EMOY2/CoIDoHK+AGOiFsavXaqB0sNzrsUOuldyV+Ecz7J+wqrY97ziMatWobPeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187347; c=relaxed/simple;
	bh=tJ1aCc5FD8FQmguy5+eKjYi/Fu66ZyNzxgDX3Zu2pW0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sZGPw1f2VfGaV7DmJ6HEUYBmiEoMggA64iGJ50JX+fQTOxS1OR7SPX/fwSUlu9IGgh2QD4d5t5tt87qjYl7y7ZHVIwcdiTMmrbG/sqgGByo99E1TReu6AeoHSLWwONV1RE+Ij7LzoWtbXH5e+DuF5pWGypE5eX2dBfLAHBAD8DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYqMFosC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B304CC4CEFD;
	Mon,  3 Nov 2025 16:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762187347;
	bh=tJ1aCc5FD8FQmguy5+eKjYi/Fu66ZyNzxgDX3Zu2pW0=;
	h=Date:From:To:Cc:Subject:From;
	b=SYqMFosCgkxuDRR7A5lnlV85aIMTxp/B9vs2l2hGmF663hgF9FmdLgS3cyBsQ21AE
	 NrQmruK480KcHyhvkcy70leBAFJng6x7X6UC+fzAkTomp2SHizNkJAwxj0fVrdLXGU
	 HTA/tpLOkwc15CuA3T0DgpYlQC+26C5j8FX2xzvD4EWeFsfGwZwbPhC49j7YMONIvX
	 bCQS0jPQK1E+ymwydkkAzdf726MC/sC3B+LGW0Doe5FKxP3c6ccBri1O/hbfepa6a4
	 skQXu/klsHbgGcfboxdNLG6L5EeA7yDqJGinzwXnBoXRm2xxADr+BfB1QR5sRjHJdG
	 thDaT7A3PL/zw==
Date: Mon, 3 Nov 2025 13:29:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>, Xin Li <xin@zytor.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1] tools headers UAPI: Sync KVM's vmx.h header with the
 kernel sources to handle new exit reasons
Message-ID: <aQjYUNV37bAvFNks@x1>
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

  885df2d2109a60f8 ("KVM: x86: Add support for RDMSR/WRMSRNS w/ immediate on Intel")
  c42856af8f70d983 ("KVM: TDX: Add a place holder for handler of TDX hypercalls (TDG.VP.VMCALL)")

That makes 'perf kvm-stat' aware of these new TDCALL and
MSR_{READ,WRITE}_IMM exit reasons, thus addressing the following perf
build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/x86/include/uapi/asm/vmx.h arch/x86/include/uapi/asm/vmx.h

Please see tools/include/uapi/README for further details.

Cc: Sean Christopherson <seanjc@google.com>
Cc: Xin Li <xin@zytor.com>
Cc: Isaku Yamahata <isaku.yamahata@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/uapi/asm/vmx.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/arch/x86/include/uapi/asm/vmx.h b/tools/arch/x86/include/uapi/asm/vmx.h
index f0f4a4cf84a7244e..9792e329343e8715 100644
--- a/tools/arch/x86/include/uapi/asm/vmx.h
+++ b/tools/arch/x86/include/uapi/asm/vmx.h
@@ -94,6 +94,8 @@
 #define EXIT_REASON_BUS_LOCK            74
 #define EXIT_REASON_NOTIFY              75
 #define EXIT_REASON_TDCALL              77
+#define EXIT_REASON_MSR_READ_IMM        84
+#define EXIT_REASON_MSR_WRITE_IMM       85
 
 #define VMX_EXIT_REASONS \
 	{ EXIT_REASON_EXCEPTION_NMI,         "EXCEPTION_NMI" }, \
@@ -158,7 +160,9 @@
 	{ EXIT_REASON_TPAUSE,                "TPAUSE" }, \
 	{ EXIT_REASON_BUS_LOCK,              "BUS_LOCK" }, \
 	{ EXIT_REASON_NOTIFY,                "NOTIFY" }, \
-	{ EXIT_REASON_TDCALL,                "TDCALL" }
+	{ EXIT_REASON_TDCALL,                "TDCALL" }, \
+	{ EXIT_REASON_MSR_READ_IMM,          "MSR_READ_IMM" }, \
+	{ EXIT_REASON_MSR_WRITE_IMM,         "MSR_WRITE_IMM" }
 
 #define VMX_EXIT_REASON_FLAGS \
 	{ VMX_EXIT_REASONS_FAILED_VMENTRY,	"FAILED_VMENTRY" }
-- 
2.51.1


