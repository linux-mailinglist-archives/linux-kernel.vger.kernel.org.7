Return-Path: <linux-kernel+bounces-882226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA02C29EBF
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 04:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E931D3B2A0A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 03:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C812F28852B;
	Mon,  3 Nov 2025 03:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VB2f0Mec"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7EA2F56
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 03:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762139301; cv=none; b=pjV/qdul0MYitouf7fOGNvYZuUDtvgnahiqnQ72IgbhypIVX4aX0P+84XQHwtXTVo0TaKNys/A4peATZx3ggxlzVQicvEeK77FYk4CW9NMF/4EZHWpGTNp0S+qdFtS411vr/5u21liNBLAcwerGnGm4GtB+CiQyVAHcwKrc6HPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762139301; c=relaxed/simple;
	bh=fpeRd9SjN9d/rxoDNU/bQoDH2p98act5ducntFs8E7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XhatpQxMGgu+5IgSA84TNqefHBPKjT4BppOzZbSTRv2fhpqqpxhFsPSVBxlPRYvGFxLM8LIJ8/zRDxt1OviI2tZir8AsAZBjWhFB4H8hkkMGZTI8oreyL5A7ya00DA96+jWB91Qs2LZJoJSUmEbBX8rMtQLm8VsrTDqK7QRY6iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VB2f0Mec; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762139298; x=1793675298;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=fpeRd9SjN9d/rxoDNU/bQoDH2p98act5ducntFs8E7k=;
  b=VB2f0MecV80w6VuGsYLt5g6RYWmEylApjqiP797ZdrvvFKP5iexfZ9o4
   35kPmkwMkj6HGtXBi7DyZFZApRR6FIjDfbBq+NwuqJMJ0ZRAOaKlC+3ln
   oHlAKk13l1mwfr7qhrz5a7hsxl8oW/wcgSuK4/b7b5OAPLS8QzH9f+jag
   /RCQs19DGJKvmBqSTigDd6R3c1sngtmSr52w5cwnauL+erLb7WGwwQPXD
   sYUL5dKvVNbBZwGtTp9m/bGlJ1L0dNzmKYbeIeP7WR0xUx3VO+hPn65sS
   gCo5DS/nr8c0Kt7jDzauszCm48knjXKmwhoLNT1gpHGG/sgTkfxBiWaMW
   g==;
X-CSE-ConnectionGUID: no6KyW+ARVi2vdGZI/IROA==
X-CSE-MsgGUID: yFlVDzxBTSK4pOxP+iiYkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="63416808"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="63416808"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2025 19:08:17 -0800
X-CSE-ConnectionGUID: CTIzcpnsRKiYQ6U7y/kEwA==
X-CSE-MsgGUID: 1IfrXUg0R1aFkb7mZYvkYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="186038984"
Received: from unknown (HELO hyperion.local) ([10.243.61.29])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2025 19:08:18 -0800
From: Marc Herbert <marc.herbert@linux.intel.com>
Date: Mon, 03 Nov 2025 03:08:11 +0000
Subject: [PATCH v2] x86/msr: add CPU_OUT_OF_SPEC taint name to
 "unrecognized" pr_warn(msg)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-tainted-msr-v2-1-abc074bd6d16@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAJscCGkC/1XMQQ6CMBCF4auQWVsyxdagK+9hWNR2kEmgkBYbD
 OHuFly5/CfzvhUiBaYIt2KFQIkjjz5HdSrAdsa/SLDLDRVWWuIZxWzYz+TEEINQrSJbG+uu2kJ
 eTIFaXg7t0eTuOM5j+Bx4kvv150iUf06SQgpCvOj6aVA5de/Zv5dy/+hLOw7QbNv2BYHnqZOsA
 AAA
X-Change-ID: 20251030-tainted-msr-4f4ec8acd95c
To: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, 
 Marc Herbert <marc.herbert@linux.intel.com>
X-Mailer: b4 0.15-dev

While restricting access, commit a7e1f67ed29f ("x86/msr: Filter MSR
writes") also added warning and tainting. But the warning message never
mentioned tainting. Moreover, this uses the "CPU_OUT_OF_SPEC" flag which
is not clearly related to MSRs: that flag is overloaded by several,
fairly different situations, including some much scarier ones. So,
without an expert around (thank you Dave Hansen), it would have been
practically impossible to root cause the tainting from just the log file
at hand.  Fix this by simply appending the CPU_OUT_OF_SPEC flag to the
warning message.

This readability issue happened when staring at logs involving the
Intel Memory Latency Checker (among many other things going on in that
log). The MLC disables hardware prefetch.

Signed-off-by: Marc Herbert <marc.herbert@linux.intel.com>
---
Changes in v2:
- Don't use tainted_flags[] which is not exported to modules
- Link to v1: https://patch.msgid.link/20251101-tainted-msr-v1-1-e00658ba04d4@linux.intel.com
---
 arch/x86/kernel/msr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index e17c16c54a37..4469c784eaa0 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -98,7 +98,7 @@ static int filter_write(u32 reg)
 	if (!__ratelimit(&fw_rs))
 		return 0;
 
-	pr_warn("Write to unrecognized MSR 0x%x by %s (pid: %d).\n",
+	pr_warn("Write to unrecognized MSR 0x%x by %s (pid: %d), tainting CPU_OUT_OF_SPEC.\n",
 	        reg, current->comm, current->pid);
 	pr_warn("See https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/about for details.\n");
 

---
base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
change-id: 20251030-tainted-msr-4f4ec8acd95c

Best regards,
--  
Marc Herbert <marc.herbert@linux.intel.com>


