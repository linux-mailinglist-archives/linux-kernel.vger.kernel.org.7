Return-Path: <linux-kernel+bounces-783133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C037B329E3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 17:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08AD4177F62
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 15:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620161FF7DC;
	Sat, 23 Aug 2025 15:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eCsSXpLT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2268A2E8DE0
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964344; cv=none; b=iDcGJKRNvskSIOSvsE2FBIUrWHybaZrJ+6SGr/2P1cTsA/A+IhCa0IBIbY1zpIGiaRe4wChKan7k5e8w68j//iO+e3igubbTpBTdzbX9R0lia9ddg26lfoD1BSbeU1UkzvNA6h/zIBd4wjowdGQsfAz/KibGZhKv77MPH0Mj1Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964344; c=relaxed/simple;
	bh=U3WZe67KVW53Wrj061ZZoAB+Wiwidzdr71kt/hN+IVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rZR8GueWbwI4IcbM/FxpqxNbX96EQJBU85csyD4pJAOGDbciFbDhVWEktcKiNeVsP/XYw8LY1P7RGNHdbVBxXYZ+tWMyLhlMyZ6GnvNZEHjVOXfwCSN7EadUCF7gWwrbbBkYFh63sVFZjPvcgQfyhNrl1slQewGPweGgwtl+oo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eCsSXpLT; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755964343; x=1787500343;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U3WZe67KVW53Wrj061ZZoAB+Wiwidzdr71kt/hN+IVE=;
  b=eCsSXpLTUzXTj5K6q0bnnO8rFOmegWP/Z0HKJQWUS1c7LmUGIs7SOAAO
   6eMDSA4i11tUCdIvCcSjW/pU35FrENALq+OoPsXZ/VuYGpUvfeZvj0UXW
   iKYCtBLu6Sw4NkihbDqGt/vm5dpkwGnfeY+MBLRAPLGaOO1sF95pwseNj
   x718R6FkYZDPNF/729dzoKQhwaX5epG/uZQTlXQMOzWj0M1UfyGG7JIxp
   Jq26SwJLq3Fd6RXG6ohTm1390wKiTJDvjZ4gsy7P3AsPxPxREt5+QTEkg
   q2Vj5xotM8T+oNoUliEoefEdQokaHvO0eOmwgavMFYNkU4pVFRJu+wQWI
   A==;
X-CSE-ConnectionGUID: BHyGT22pRA651PLpBI10Zw==
X-CSE-MsgGUID: imz5YIQpTQy/0iM3Dcgy7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="75832812"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="75832812"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2025 08:52:22 -0700
X-CSE-ConnectionGUID: eRX3GnGVRDWa+sbcQXIVgQ==
X-CSE-MsgGUID: s3aJnEWhTj6Dd458dJAR2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="169748234"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.85.190])
  by fmviesa010.fm.intel.com with ESMTP; 23 Aug 2025 08:52:22 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chao.gao@intel.com,
	abusse@amazon.de,
	chang.seok.bae@intel.com
Subject: [PATCH v5 4/7] x86/microcode/intel: Define staging state struct
Date: Sat, 23 Aug 2025 08:52:07 -0700
Message-ID: <20250823155214.17465-5-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250823155214.17465-1-chang.seok.bae@intel.com>
References: <20250813172649.15474-1-chang.seok.bae@intel.com>
 <20250823155214.17465-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To facilitate a structured staging handler, a set of functions will be
introduced. Define staging_state struct to simplify function prototypes
by consolidating relevant data, instead of passing multiple local
variables.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Tested-by: Anselm Busse <abusse@amazon.de>
---
V4 -> V5: Drop the ucode_ptr field (Dave)
V1 -> V2: New patch

Prior to V2, local variables were used to track state values, with the
intention of improving readability by explicitly passing them between
functions. However, given feedbacks, introducing a dedicated data
structure looks to provide a benefit by simplifying the main loop.
---
 arch/x86/kernel/cpu/microcode/intel.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index d309fb1f058f..3ca22457d839 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -54,6 +54,25 @@ struct extended_sigtable {
 	struct extended_signature	sigs[];
 };
 
+/**
+ * struct staging_state - Tracks the current staging process state
+ *
+ * @mmio_base:		MMIO base address for staging
+ * @ucode_len:		Total size of the microcode image
+ * @chunk_size:		Size of each data piece
+ * @bytes_sent:		Total bytes transmitted so far
+ * @offset:		Current offset in the microcode image
+ * @state:		Current state of the staging process
+ */
+struct staging_state {
+	void __iomem		*mmio_base;
+	unsigned int		ucode_len;
+	unsigned int		chunk_size;
+	unsigned int		bytes_sent;
+	unsigned int		offset;
+	enum ucode_state	state;
+};
+
 #define DEFAULT_UCODE_TOTALSIZE (DEFAULT_UCODE_DATASIZE + MC_HEADER_SIZE)
 #define EXT_HEADER_SIZE		(sizeof(struct extended_sigtable))
 #define EXT_SIGNATURE_SIZE	(sizeof(struct extended_signature))
-- 
2.48.1


