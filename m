Return-Path: <linux-kernel+bounces-892143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F41C44708
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 22:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 114924E3425
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 21:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2153F23EA98;
	Sun,  9 Nov 2025 21:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HH9+AFMb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42A934D385
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 21:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762722091; cv=none; b=FEhQ4Uc/UupLNGCUbnDBEKAnLOICQDYdQEealvJa6mooUFHIehLwjwISTedjThDz2Gsmnp1kdy/tfNDSjaaEuxo3sB+dXbNCwDeXQeDLkCciSoucBfCXa2Qh4aO/dzogJSzT0a9vDpHIXjKdGJzdJlBnzXDBZx6gFJ2+g/6TBpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762722091; c=relaxed/simple;
	bh=BAGNnUT7J5tXw/6KAZ5oNJi+Rq2nH9XCGPCsOi6O/Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gM8O8AUEF4ng3AKdau5N7UrbXjTOLwVckOwP/UVk7ZXkDCqXeOvdPYTp9dR6DWJ3iObijQu0nj9Xygv4h+bjrXqd8Tp/6M2qdvaw+7xivSgZD3JA+kIWB9+uLKmb8TR4iXv++0bi76GXMoGfj7M7QB6v8OU6nyzOXWk7OrR2ep4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HH9+AFMb; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762722089; x=1794258089;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BAGNnUT7J5tXw/6KAZ5oNJi+Rq2nH9XCGPCsOi6O/Ck=;
  b=HH9+AFMbsbjHlBJha5Wx0idpKyeBPf7cRNu2GQ28ySq0g4TXhM5VBbbW
   4nJSFXKD3XR2HkgJvIltH5FfFdQZILLnY9+pxAyca9JbnxevsynofllOj
   /e4netfnxYoFvfpwin2catn+9QNkEX7X89eZH4hv77uGY7g6eTFSvhfaI
   qNGvkf5/CCYUUh1o/4eniuDXCU8ftlM/irMnv3m39D7H1C17JOSGPv5vw
   V/jARPRFUiQO25VNGpg9cIVxUug3RbOI8sIJG3W7147PI8qJEERUKqZdv
   wIJF89YsrKkzoeDWWHW3TQq3pAUWhBZsLCYzEAvY1AoT2cZTO72u7Oens
   A==;
X-CSE-ConnectionGUID: IR9ySn0oSMOrc4+bVOGhLQ==
X-CSE-MsgGUID: 4LtlA6xiQy6oENukh6enEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="68629208"
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="68629208"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 13:01:28 -0800
X-CSE-ConnectionGUID: 96d81ZniSlSvNHh8msx9tg==
X-CSE-MsgGUID: BukOQNUZTjSlgvTTmLA60w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="211924517"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 09 Nov 2025 13:01:27 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 48B9B95; Sun, 09 Nov 2025 22:01:26 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH v2 1/1] logic_pio: Use RESOURCE_SIZE_MAX definition
Date: Sun,  9 Nov 2025 22:00:55 +0100
Message-ID: <20251109210054.3220666-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a predefined limit instead of hard coding it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: Cc:ed more people

 lib/logic_pio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/logic_pio.c b/lib/logic_pio.c
index e29496a38d06..6d6a7498dbe5 100644
--- a/lib/logic_pio.c
+++ b/lib/logic_pio.c
@@ -175,7 +175,7 @@ resource_size_t logic_pio_to_hwaddr(unsigned long pio)
 	if (range)
 		return range->hw_start + pio - range->io_start;
 
-	return (resource_size_t)~0;
+	return RESOURCE_SIZE_MAX;
 }
 
 /**
-- 
2.50.1


