Return-Path: <linux-kernel+bounces-888217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A70C3A36C
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497F41A481A9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B5630DD22;
	Thu,  6 Nov 2025 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S6tl+CfB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FD9268688;
	Thu,  6 Nov 2025 10:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762424072; cv=none; b=l5uLd1DdLJGvH7Az/mI/UjD+Pst2LNZhttehypdJgozFwC6SALA78uMCptWC1e+m7i/XHgmk9foJlukgmtFq14gIiJqQbT7VpHvMmoipzH5o5iDxkXtBO6slG/5bJFYMUcPRVC2FO1GNnVhvmVzjjlnc/vRJvPD4Ppk7pKMhtaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762424072; c=relaxed/simple;
	bh=l2b1j5/Yp/pqI4I8XHvVSJ5OwExUUHKNBWIajqYLZ74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTEysktfq3koqxn22otB/hBnGRWfglii2S0g7Ux49J66EygmfhxofLcAzBIVsD8dP6NQlklriPkiQVtFnZYErJs5eiscVusN/hfophB/PqFKyziNAe/mFU9BMuq9zLAmOECv5+WUJzetwtHwODTjJPRmLr2ANQYPb65l4YDD114=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S6tl+CfB; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762424071; x=1793960071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l2b1j5/Yp/pqI4I8XHvVSJ5OwExUUHKNBWIajqYLZ74=;
  b=S6tl+CfBy185pglcHYR9fFHo6+joK7lxyqMRkyJLW0gyX2mh1nFj8j1F
   DzV95SnAYxH8cR51DJ1fo5M+k+43NiYPYydAVpVfBcy/l2u0RgDy5RmAD
   wmLnS2gJtOcszU4L/CfJaOm+lRdYwzUlalrNB2drWbSoGGxSHFfSHIACx
   p0zNOmEc28f5tikxWeJQ9HHayycxoEKN4eBuWnA3uePUBMz9ilkB04+K/
   t3A+OUPkcpMot1cywQjhi6c+P9B7fBKYi0HzH3pFYji9hLtyofFvYs64t
   zhWdyNv2LvDGOU+LbWWnIFR5fOvn6Q9tWdOI7DqgMq5l0S7pF6EZLb+5r
   w==;
X-CSE-ConnectionGUID: Jzz/CaCMQSyXoaaQubVcjQ==
X-CSE-MsgGUID: CvdcVcUKR1aZVVANDnznVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="67169486"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="67169486"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 02:14:30 -0800
X-CSE-ConnectionGUID: rawiGsbdR9CzsDSoQMDFfQ==
X-CSE-MsgGUID: pBKL89GzQ62WPj+gdm+rnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="187385336"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 06 Nov 2025 02:14:27 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 831FE96; Thu, 06 Nov 2025 11:14:26 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] doc: kdoc: Handle DEFINE_IDTENTRY_*() cases
Date: Thu,  6 Nov 2025 11:12:25 +0100
Message-ID: <20251106101416.1924707-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251106101416.1924707-1-andriy.shevchenko@linux.intel.com>
References: <20251106101416.1924707-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have an unparsed kernel-doc for spurious_interrupt() IDTENTRY.
Update kdoc to handle that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 scripts/lib/kdoc/kdoc_parser.py | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index f7dbb0868367..b583edd80a52 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -1430,6 +1430,25 @@ class KernelDoc:
 
         return proto
 
+    def idtentry_munge(self, ln, proto):
+        """
+        Handle DEFINE_IDTENTRY_*() definitions
+        """
+
+        name = None
+
+        # Replace DEFINE_IDTENTRY_IRQ with correct return type & function name
+        r = KernRe(r'DEFINE_IDTENTRY_IRQ\((.*?)\)')
+        if r.search(proto):
+            name = r.group(1)
+
+        if not name:
+            self.emit_msg(ln, f"Unrecognized IDTENTRY format:\n{proto}\n")
+        else:
+            proto = f"static inline void {name}((struct pt_regs *regs, unsigned long error_code)"
+
+        return proto
+
     def tracepoint_munge(self, ln, proto):
         """
         Handle tracepoint definitions
@@ -1499,13 +1518,13 @@ class KernelDoc:
             # Handle special declaration syntaxes
             #
             if 'SYSCALL_DEFINE' in self.entry.prototype:
-                self.entry.prototype = self.syscall_munge(ln,
-                                                          self.entry.prototype)
+                self.entry.prototype = self.syscall_munge(ln, self.entry.prototype)
+            elif 'DEFINE_IDTENTRY' in self.entry.prototype:
+                self.entry.prototype = self.idtentry_munge(ln, self.entry.prototype)
             else:
                 r = KernRe(r'TRACE_EVENT|DEFINE_EVENT|DEFINE_SINGLE_EVENT')
                 if r.search(self.entry.prototype):
-                    self.entry.prototype = self.tracepoint_munge(ln,
-                                                                 self.entry.prototype)
+                    self.entry.prototype = self.tracepoint_munge(ln, self.entry.prototype)
             #
             # ... and we're done
             #
-- 
2.50.1


