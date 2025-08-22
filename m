Return-Path: <linux-kernel+bounces-782768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D727B3251D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 00:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CC627B6F79
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C84E2C158F;
	Fri, 22 Aug 2025 22:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R3eSLrW0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543A32BF01D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 22:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755902392; cv=none; b=Lpl4BDXCQOCXN4BulmWcBqUC1IxaWoanpqF/PXwyvmClhHGZtbxqbjolY0GNMkwNYzvapgbfOwB+pAMFKdc0n2UZsLHoil8Ot2bv/D6LhWj9+ouMZoVCZH5bc4JnTjEhsuDZg0DKHqN3Plu2lF9xYWSHhxm6ty/VStynQYM7ba8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755902392; c=relaxed/simple;
	bh=YrqBmk7yFUwxva71+5gpE5I6hjY+YCx+VfzpupfPkms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNs0N1dg7X//2rs8h84umTT1kdRFppb0jbTX8knq6I88ib/YzVLI3sjYC6RC9qYuRp/unp88wF59E1LWZzrmc4F/+NOFFi9pXwy4loN0nmDWFcLFQBSPFhJojb2EqKrrg21z0DftPXInsLVg6+FXE1H2AD1PYQxyer+RpT4TDDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R3eSLrW0; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755902391; x=1787438391;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YrqBmk7yFUwxva71+5gpE5I6hjY+YCx+VfzpupfPkms=;
  b=R3eSLrW0+3ceNl4QRfYEwzTnLb5scbRmAmMxd1rEpt4YGhMPuJ7nIIGu
   k8tk9Nw39zEsoFKZ/N+O0sCo3RKnQ/rkmYQxnOYIX7ScxNFmv00acPDD3
   awCgu7JKQJ7paso8T9dqhD5Jhe1ZLiwdhiYGxUMdh6RQhup4osTSAj3Lz
   ZN5ETbdNgBh2v7O2EmjpSdVLS8aCGIGmTds55PdsLPZnRwjQ0FPUHVtyw
   jaoM5kR9Y3Y6s3lu0cJBo+VNKUXhHXFmbzFegHr8s6aAP+65yUkEFi4Kd
   CpFjSlabCxjTC3kJyqYL5HhCILZLEWfaajA/Gfm5UGAN1H1Mz0UJCws6j
   w==;
X-CSE-ConnectionGUID: brdp0u60TTquknvx3zu6Mw==
X-CSE-MsgGUID: ZWP8t6rjSY21TabqjRcMNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="75800181"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="75800181"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 15:39:51 -0700
X-CSE-ConnectionGUID: NBKEijKuSP2ZGDVqsz20uQ==
X-CSE-MsgGUID: OQ7NMjU1RZ2gjHlWyno3rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="168716271"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.135.148])
  by orviesa007.jf.intel.com with ESMTP; 22 Aug 2025 15:39:49 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: dave.hansen@linux.intel.com,
	x86@kernel.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	colinmitchell@google.com,
	chao.gao@intel.com,
	abusse@amazon.de,
	chang.seok.bae@intel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4a 3/6] x86/microcode/intel: Define staging state struct
Date: Fri, 22 Aug 2025 15:39:48 -0700
Message-ID: <20250822223948.12522-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <0c7c6704-9f66-469b-b55c-462f66965450@intel.com>
References: <0c7c6704-9f66-469b-b55c-462f66965450@intel.com>
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
V4 -> V4a: Drop the ucode_ptr field (Dave)
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


