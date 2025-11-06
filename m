Return-Path: <linux-kernel+bounces-888218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D280FC3A3CF
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7818A463193
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8216C30EF6F;
	Thu,  6 Nov 2025 10:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eoW8jiVE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E3130CDB5;
	Thu,  6 Nov 2025 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762424073; cv=none; b=kmXazm7nctjVX4hCcE0XDQ9jlcWFQZsg5Qw9IWdSAd1bSnYgU4FjmOphX92BRR9XaEO09tEy9eerFAbank7Ik6zLgCZHhFQMQmMnQHOyOlnvp9nraKbKXnoItLRYTH7EwJWDvZlNw/a9uXU6jBFzhW0g1C8FGt8izqfphPIRyM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762424073; c=relaxed/simple;
	bh=D0c1o0g+7l5tANzTq/Aq54JsjXTAfQD9PUNnw6N4PWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZZbVao4rxvQk82Or/cCZoKdmY1B9Z7oCV1ZF9Tmr6OedlaN6MzH8mbZWLWKxG/vz4QzTCi9427kpJMIyhBAZ9LlvjndJm3rBLSXkFZLB3tudCc8s0NTIU5AWLsVFGhf9E/bJ1XD+iANC4zS/tCWhHI0m3t7PNGC9FFqTDgvL/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eoW8jiVE; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762424072; x=1793960072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D0c1o0g+7l5tANzTq/Aq54JsjXTAfQD9PUNnw6N4PWo=;
  b=eoW8jiVEXVSzR++Ay3h4QdDSvyJ19LiFoEtYADK7q4lmKjXnzh7vgoO9
   qQks1MgsOonADkmuAaqghmy458xcSByAjZm4syEKhYddmwnpEuH6YUd3V
   S6jfUazNzo5hGAnMdH2D81BiGWQNvniVfWZ50BO172rdMMKp5d+fDk7VL
   Eg9rMAakOG3+0ofSKCXs5muIgxfJMw6xNRhSzVNn7yzwu901ObO+1n/6V
   jSa0i+WAQEmm5cq9YAqEzO+g1iMQlsqCxtXM5XX4bkH8fUktevZ68335G
   +LOQwoespR34kh1v7MIGhvdlz0d/snEzY8RW6HncGCcKHyXvIdCJT4tf4
   w==;
X-CSE-ConnectionGUID: bdCLBNAbQeiP20qTtreFGA==
X-CSE-MsgGUID: Ul6g1DssTpqWLjop+dveGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="67169488"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="67169488"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 02:14:30 -0800
X-CSE-ConnectionGUID: M0RsptvdT+yGoSfhNVBi+A==
X-CSE-MsgGUID: irFrkxs/S46QYNqXPSNB4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="192891391"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 06 Nov 2025 02:14:27 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 8797097; Thu, 06 Nov 2025 11:14:26 +0100 (CET)
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
Subject: [PATCH v1 2/2] x86/apic: Update kernel-doc to avoid warnings
Date: Thu,  6 Nov 2025 11:12:26 +0100
Message-ID: <20251106101416.1924707-3-andriy.shevchenko@linux.intel.com>
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

Validator is not happy about some of the kernel-doc descriptions:

Warning: arch/x86/kernel/apic/apic.c:245 No description found for return value of 'lapic_get_maxlvt'
Warning: arch/x86/kernel/apic/apic.c:2145 function parameter 'error_code' not described in 'spurious_interrupt'

Update them accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/apic/apic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 680d305589a3..4675d1a07fc9 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -241,6 +241,8 @@ u64 native_apic_icr_read(void)
 
 /**
  * lapic_get_maxlvt - get the maximum number of local vector table entries
+ *
+ * Return: the maximum number of local vector table entries
  */
 int lapic_get_maxlvt(void)
 {
@@ -2136,7 +2138,7 @@ static noinline void handle_spurious_interrupt(u8 vector)
 /**
  * spurious_interrupt - Catch all for interrupts raised on unused vectors
  * @regs:	Pointer to pt_regs on stack
- * @vector:	The vector number
+ * @error_code:	The vector number
  *
  * This is invoked from ASM entry code to catch all interrupts which
  * trigger on an entry which is routed to the common_spurious idtentry
-- 
2.50.1


