Return-Path: <linux-kernel+bounces-887988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7C1C39852
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 09:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298CA188EF80
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 08:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC16F3002B0;
	Thu,  6 Nov 2025 08:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CCo/bYlq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6C32FA0F6
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762416439; cv=none; b=r5eKsnXb40OW9ZmIeafQd9LOo2a7SRrE2doqJAB/v8XNCct+LGsGjXP2jgMHNYwoLl2Zs4fj9XIfEa0mD9DDiI/n5rTNYcqtBP2BhavNXPVccRZOgkieG13uiUv4UaDbYjIoDaJ5d3vbWNeLapSYgS8tkdUmIuLYESA1pVTyNDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762416439; c=relaxed/simple;
	bh=Cm086I6RocV1KL6WtPfWQVrc3uZLfoZOcPD7FHvKPRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/Z6fmFL8/SXYuId1z86mkb0pXms20OAw4G6vyhoh5Ti8DW3WUQd7lExZmCSc3rkIPrqW4Gd/HbWHCcKJyPMHhTUP9Z9WpRPr3ZldRumFpJO1B1j+1YLt34gzQNLA6r+eRy6zHgP1vnR9WYtK07zvLdEL9lwPcigEhT2p+UyujI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CCo/bYlq; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762416437; x=1793952437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cm086I6RocV1KL6WtPfWQVrc3uZLfoZOcPD7FHvKPRQ=;
  b=CCo/bYlq0ilvACOqdkTDEfX+ph3AN1MRdBZaPuH9QTTNbhE0sbbk/+dx
   7+YQS6lLnGyU36RkmjWhE658+eV5vU+fkA9/vIpGKmGckigg2E/6EM3lY
   /OE9iWxa/B6szP15T/JZFpUeirX5I2jLCEW8M5aT/qeuEaX/VqIXamzry
   FZBGbHLqmsyHSciyJg5bUr9HpzN3e49s1jmhfUBaZk4JbJDly1+ZfjpEi
   amiMViZm1x8CowThvJ2FT2HmZvbVUU3p7+fjFsxB2om6b3FqyrlLbXhGZ
   HeFtzCstc89i4pmfUeBfQPGTew7doW1BPBaq3yL3VEmiy8qq1JFwzx1ol
   w==;
X-CSE-ConnectionGUID: 1ikjrk8lStivyCOoYlkUKQ==
X-CSE-MsgGUID: zCPNn9B7QLa64aUbgd74uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="75230937"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="75230937"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 00:07:17 -0800
X-CSE-ConnectionGUID: VcQe+4yPTM2xmGVLKE8sIw==
X-CSE-MsgGUID: w3nbegk0SDWix+nMgAzOtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="186945021"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 06 Nov 2025 00:07:15 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id DF25797; Thu, 06 Nov 2025 09:07:14 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 2/2] bitops: Update kernel-doc in hweight.c to fix the issues with it
Date: Thu,  6 Nov 2025 09:02:51 +0100
Message-ID: <20251106080712.1885074-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251106080712.1885074-1-andriy.shevchenko@linux.intel.com>
References: <20251106080712.1885074-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel-doc in lib/hweight.c is global to  the file and
currently has issues:

Warning: lib/hweight.c:13 expecting prototype for hweightN(). Prototype was for __sw_hweight32() instead
Warning: lib/hweight.c:13 function parameter 'w' not described in '__sw_hweight32'

Update it accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/hweight.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/hweight.c b/lib/hweight.c
index c94586b62551..0dfcafc3fd39 100644
--- a/lib/hweight.c
+++ b/lib/hweight.c
@@ -4,8 +4,8 @@
 #include <asm/types.h>
 
 /**
- * hweightN - returns the hamming weight of a N-bit word
- * @x: the word to weigh
+ * DOC: __sw_hweightN - returns the hamming weight of a N-bit word
+ * @w: the word to weigh
  *
  * The Hamming Weight of a number is the total number of bits set in it.
  */
-- 
2.50.1


