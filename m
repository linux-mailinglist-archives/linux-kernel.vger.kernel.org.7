Return-Path: <linux-kernel+bounces-826455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B85AB8E931
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 00:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF908189BCA7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 22:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9257C2D7812;
	Sun, 21 Sep 2025 22:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EInM3IKk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD842D12EC
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 22:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758494930; cv=none; b=GzifEZnYHHfBCqmFPq4EovmIHEBi1Pmg8jDvEB+DSQCHjP6ZSvmt1j8o7ZJ/WNumD2qS0L+1mjAW0qgSJtmDBpPCOK9NvTFCuDFlT1envu2Ro3BlLMO028VTDJYewYRmxLHYvug91jgg2218epodsPVjWtpRG7vlQ+4U0cXN8OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758494930; c=relaxed/simple;
	bh=Zp0ROmh2MaLRi6APN8D8kT67BMDXMSnCy8eIffIvCVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mC8/l+oSnTwKusJzbT44AT0lP63FuzLPn0W4LNn/AQiZUHXd7jxKfuQJDwy5pCGcOH1NBS6G1OBRtzXo0MFvEZsi634jWSD8TITZjI3dPX4CvhkSBJhIGmSpcQMKnewGRmkuF1Xac72GBereDigXqcc5Jzta47I258OHWhlVe2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EInM3IKk; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758494930; x=1790030930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zp0ROmh2MaLRi6APN8D8kT67BMDXMSnCy8eIffIvCVU=;
  b=EInM3IKk0nAXfB/0ERh9YiLAkghjcGbLWhoNlpgtUxILzkNYylq5HCxI
   C8ecVv8udxR6sU0wo4QRTct1sw9IPiSKCu5yPHA3pBgFrbQHrTl6UwtTu
   9iISkLLU4vhP8WsABzKymb2NgmnMdc7adF/J58BXJYsubT0yBuP5ZH4f1
   hb8Go8fVPWpCChwielZOzqg7T1oixDWFYUrSsaAv6+PUf9gZe9FfXTQlF
   9lONOs+mXE3jEiehnhDxfdXXtemEtPv/LsiuFpPiyUdd5XHF3CKw04vO1
   BlU0io2n2N4PPDROIOF/q117cDyZQhPybntff+Sc0Sk2sRZAyHwTV2yCi
   A==;
X-CSE-ConnectionGUID: +URvUFMPSRGs24/Nt4c00g==
X-CSE-MsgGUID: P2C1Ky+4QCuht1dc37DtXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64562356"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64562356"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2025 15:48:49 -0700
X-CSE-ConnectionGUID: vcuHsDSfSxCaJttgN9ZdGA==
X-CSE-MsgGUID: 2jHBS9alSEy2u7N0O7va4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,283,1751266800"; 
   d="scan'208";a="177129800"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.135.148])
  by fmviesa010.fm.intel.com with ESMTP; 21 Sep 2025 15:48:48 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chao.gao@intel.com,
	abusse@amazon.de,
	tony.luck@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v6 4/7] x86/microcode/intel: Define staging state struct
Date: Sun, 21 Sep 2025 15:48:38 -0700
Message-ID: <20250921224841.3545-5-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250921224841.3545-1-chang.seok.bae@intel.com>
References: <20250921224841.3545-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define staging_state struct to simplify function prototypes by
consolidating relevant data, instead of passing multiple local variables.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Tested-by: Anselm Busse <abusse@amazon.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
V5 -> V6:
* Trim the changelog (Boris)
* Drop the state field
* Collect review tag

V4 -> V5: Drop the ucode_ptr field (Dave)
V1 -> V2: New patch

Prior to V2, local variables were used to track state values, with the
intention of improving readability by explicitly passing them between
functions. However, given feedback, introducing a dedicated data
structure looks to provide a benefit by simplifying the main loop.
---
 arch/x86/kernel/cpu/microcode/intel.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index daae74858347..b9f6bfbc7fea 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -54,6 +54,23 @@ struct extended_sigtable {
 	struct extended_signature	sigs[];
 };
 
+/**
+ * struct staging_state - Track the current staging process state
+ *
+ * @mmio_base:		MMIO base address for staging
+ * @ucode_len:		Total size of the microcode image
+ * @chunk_size:		Size of each data piece
+ * @bytes_sent:		Total bytes transmitted so far
+ * @offset:		Current offset in the microcode image
+ */
+struct staging_state {
+	void __iomem		*mmio_base;
+	unsigned int		ucode_len;
+	unsigned int		chunk_size;
+	unsigned int		bytes_sent;
+	unsigned int		offset;
+};
+
 #define DEFAULT_UCODE_TOTALSIZE (DEFAULT_UCODE_DATASIZE + MC_HEADER_SIZE)
 #define EXT_HEADER_SIZE		(sizeof(struct extended_sigtable))
 #define EXT_SIGNATURE_SIZE	(sizeof(struct extended_signature))
-- 
2.48.1


