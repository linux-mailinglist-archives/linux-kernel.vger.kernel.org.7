Return-Path: <linux-kernel+bounces-887990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3990FC3986D
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 09:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC4714FE0F4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 08:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8006B30147E;
	Thu,  6 Nov 2025 08:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XPSth0XI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361CC3002D1
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762416439; cv=none; b=slrzXRDgZAePMGInQUcND1hJTr+8KRr24aK/Fof7Dfo8nxTBb8143EQau6dx4YBbl7L4KB9iugIGiuM9+QE5zYUNxfYBaVDUMHKpQ3LaxN/CGB2FCZ44j/dKWYinsWFsQ+ybWUM88W3dIS6GX0XMcDUThL49RVqwXCaeDaT5nmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762416439; c=relaxed/simple;
	bh=kxe/RILnhgXr/mWG1b8G1jIoSxpgFuKTmqyaxMsnz5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HcAGk0veX2/TefCSLwwtoKlMW5B1k8Ptj83vaOoqJgqFBqSDqRxB4nJ9MUyFvazaXnJFR7Wur5osW0Tw1tTs/PmqZrPNdx3ZkRvxPCzgSAYl/nFZFUO2F04zgTCMvau/wRIgvOfSS+C+JCzyaPxTOpt3akHQKK3+ofVddJAPP34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XPSth0XI; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762416436; x=1793952436;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kxe/RILnhgXr/mWG1b8G1jIoSxpgFuKTmqyaxMsnz5g=;
  b=XPSth0XIeJMlzQ2FiLce+E3Vav+YAX1xvUWQrG/3RMfcmuvP9beNy7S9
   tlubKgHVujSWd06rQm8iT5M/DxWJ60mY80qgyqi9wBgfhZOzgT8LgoaBv
   kGf8Y0REVLJSBbZW3031T91aKYTzBTEpYCWs4as80aQz09czmYVye8HEz
   B1emApd0xnF2OmIW3vZcJjW75+w+URQ83ZZvKzAUXVyv3R1k1jgC9Y5lC
   2Y6FrVZAhawV688Riyv6kfoiRwLTMWCuq+lgiMs3Mn9yx56yp4bKQNgA+
   MvEyUFYN/VEl5l0XYw7E6M1aw9ozhXCKvPKeb5gEd0atGeafibEmIKXY4
   Q==;
X-CSE-ConnectionGUID: Bxbdu0PUQBSMULhBFELbAw==
X-CSE-MsgGUID: w6qaiJ32T1aTpSkjTHqF5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64428990"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="64428990"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 00:07:15 -0800
X-CSE-ConnectionGUID: sYZnzp3RRpiZgz7pufYCqw==
X-CSE-MsgGUID: 8fSXO8nsRWutglUTkKCjDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="188415225"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 06 Nov 2025 00:07:16 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id DA94096; Thu, 06 Nov 2025 09:07:14 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 1/2] bitops: Add missed file to MAINTAINERS
Date: Thu,  6 Nov 2025 09:02:50 +0100
Message-ID: <20251106080712.1885074-2-andriy.shevchenko@linux.intel.com>
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

In accordance with the history and nature of the operation
add lib/hweight.c to the BITOPS record in MAINTAINERS.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3d599e8b8b00..a27b48ddfe6c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4393,6 +4393,7 @@ F:	arch/*/lib/bitops.c
 F:	include/asm-generic/bitops
 F:	include/asm-generic/bitops.h
 F:	include/linux/bitops.h
+F:	lib/hweight.c
 F:	lib/test_bitops.c
 F:	tools/*/bitops*
 
-- 
2.50.1


