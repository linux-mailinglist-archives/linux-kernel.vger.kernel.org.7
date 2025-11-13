Return-Path: <linux-kernel+bounces-900031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAEEC59677
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 19:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102023A3914
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D156B342514;
	Thu, 13 Nov 2025 18:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zto6o8Cn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A7B241686
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 18:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763057346; cv=none; b=WbUM00xPYc4+KCix/5I/iXP7rBw7G3rvNFAJMRCB28zzguoIKzy8zbZsCXl+OlASLUWEXryQIX0yUGRpqBz/4xBUbswkkWCT+xInF+JG2HKsinvMOLrJirKzRCv7UfHqRY6pQaCYjMJbH5ZisSaan9hVAVtYCSQogHtWKS+PYIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763057346; c=relaxed/simple;
	bh=vhuveNoTpeCdeUIVXGVjujDkfoEU7mjaugMISpw7YLE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fQjTkCAJwTBP/hvujJE3UI7Za8B1ro3zeFGfxOLwHrGhsSHXNeuIAsGDb4Kz7S3NdHd/WvKLbYpvnhOUr1uQRno2H+8sgAdamVTo7qryPXkuBxrHoXErtBFc16NeVbPRv6KhIAUFvWEIXZ2HYOwqfXcAqjmS9tn31tEJ4F4ic68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zto6o8Cn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09986C4CEF8;
	Thu, 13 Nov 2025 18:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763057345;
	bh=vhuveNoTpeCdeUIVXGVjujDkfoEU7mjaugMISpw7YLE=;
	h=Date:From:To:Cc:Subject:From;
	b=Zto6o8Cnw8fuJYO1Zxjq4PXwHstwsM6AjlD3OO3O93hm7pmhVHquS9wuRsU/bCGOt
	 ZGmhghiW2Tx64EGY0mqn8zPPRUVgtGvSM9q9wAxOTjuRdJZZvK6JNJ44A5/Uh7MGA3
	 4i8c+SzFSFFSEJ556O4XbyivXfuiikHrK3rU7BL2vf2L8HI3HVjVAae+N1MoX2fQvq
	 EgiYEb1cl/c136Z4o/lTgzTzqsi5KOe3iDx61hMG8Nya1Q1F+V2FUdP/Hb0M81ji4m
	 UiF0czlEAFPz/ViSVyuUjWgqJ5z612caQc4KWA09zNeyUsckB5Qz4yZ3lZplcuae1x
	 gmY4it9hP6Xpg==
Date: Thu, 13 Nov 2025 15:09:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1] tools headers UAPI: Sync KVM's vmx.h with the kernel to
 pick SEAMCALL exit reason
Message-ID: <aRYevQjcXNCYVJRV@x1>
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

  9d7dfb95da2cb5c1 ("KVM: VMX: Inject #UD if guest tries to execute SEAMCALL or TDCALL")

The 'perf kvm-stat' tool uses the exit reasons that are included in the
VMX_EXIT_REASONS define, this new SEAMCALL isn't included there (TDCALL
is), so shouldn't be causing any change in behaviour, this patch ends up
being just addressess the following perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/x86/include/uapi/asm/vmx.h arch/x86/include/uapi/asm/vmx.h

Please see tools/include/uapi/README for further details.

Cc: Sean Christopherson <seanjc@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/uapi/asm/vmx.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/arch/x86/include/uapi/asm/vmx.h b/tools/arch/x86/include/uapi/asm/vmx.h
index 9792e329343e8715..1baa86dfe029329a 100644
--- a/tools/arch/x86/include/uapi/asm/vmx.h
+++ b/tools/arch/x86/include/uapi/asm/vmx.h
@@ -93,6 +93,7 @@
 #define EXIT_REASON_TPAUSE              68
 #define EXIT_REASON_BUS_LOCK            74
 #define EXIT_REASON_NOTIFY              75
+#define EXIT_REASON_SEAMCALL            76
 #define EXIT_REASON_TDCALL              77
 #define EXIT_REASON_MSR_READ_IMM        84
 #define EXIT_REASON_MSR_WRITE_IMM       85
-- 
2.51.1


