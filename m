Return-Path: <linux-kernel+bounces-767268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A80B25221
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5332E887818
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C2328C84F;
	Wed, 13 Aug 2025 17:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gyKH0Tko"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5283288514
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755106034; cv=none; b=DI2sdPr+Pi1BN39ZuuOIlFfNXhKpIiyp+HJ1oNihujt3SCDdAfXdYGK0w6A2R0dVZN1xJJOe5ZnJEDutyUXsJ6m7aVs4ilDHNdVEzAKi5HGjvAWd42IviyMjHBMUrgahEo1HxoL1R4rb6ZgmhU6KrWp3PsBrQuyjpXSraza7k9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755106034; c=relaxed/simple;
	bh=bfbBVGoL1hUlUhbhKKduZgkj0HMRd8m5y/Epw1ScV7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mLEJW8Lgj3fpOVlhWLrT5VM0dkrQN4tbeS/EhXVX713iDHvsa+DIRiYFf9W3nKTa2dPnl9tlh/IaPssxkXpJWLsRXPJ5FarhTBE3HLWqPP9xBwtOLwUBM4gEfWGt5WMtprAeUyE1BDpIqmYhhBdjg7iW8cpSCQTwpYvtlbxUPQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gyKH0Tko; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755106033; x=1786642033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bfbBVGoL1hUlUhbhKKduZgkj0HMRd8m5y/Epw1ScV7s=;
  b=gyKH0TkoHhyDV3XK3DuVrkXnJDup4e4LVnSkrMtqnCjrdAfFSGxqPHsJ
   LtU3reFF2kzY//aFl8hs4T0xFuWj+T3o3gnLEoHym2pg3JWR0/wDTpyaD
   KgESjXSl1MMzeUqEl02hfAi2DsFfNU6gtzAGCx89Dzryqsm1ghtMpGq6V
   Kml6Td784uSxz+ztCVP1gby57It4piR9D4SLMILTqOUDiuTK1D8R2AZI6
   FCjf+DeFpG86UT7NJmE4pPlqx2s8d8UOkf9wgvTtXZllbgXGXCZ1b1270
   z8f9Hf5hrYUzUL+aCh9SAmFIZ9P7Lejbp3KvLb1i75xjSu/vzXyH/F2Yv
   A==;
X-CSE-ConnectionGUID: j6Da0a80RB+r01GI9lta8A==
X-CSE-MsgGUID: CpYt9RQoTGyqa70LHJiW1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="61255227"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="61255227"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 10:27:13 -0700
X-CSE-ConnectionGUID: 5vgHypc3T6qobLCqFJI75A==
X-CSE-MsgGUID: WRebu1ZQSmiQb6Y1qxYkJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="167329709"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.161.193])
  by fmviesa010.fm.intel.com with ESMTP; 13 Aug 2025 10:27:12 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: x86@kernel.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	colinmitchell@google.com,
	chao.gao@intel.com,
	abusse@amazon.de,
	chang.seok.bae@intel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/6] x86/microcode/intel: Define staging state struct
Date: Wed, 13 Aug 2025 10:26:46 -0700
Message-ID: <20250813172649.15474-4-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250813172649.15474-1-chang.seok.bae@intel.com>
References: <20250409232713.4536-1-chang.seok.bae@intel.com>
 <20250813172649.15474-1-chang.seok.bae@intel.com>
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
V1 -> V2: New patch

Prior to V2, local variables were used to track state values, with the
intention of improving readability by explicitly passing them between
functions. However, given feedbacks, introducing a dedicated data
structure looks to provide a benefit by simplifying the main loop.
---
 arch/x86/kernel/cpu/microcode/intel.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 468c4d3d5d66..36b426a90844 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -54,6 +54,27 @@ struct extended_sigtable {
 	struct extended_signature	sigs[];
 };
 
+/**
+ * struct staging_state - Tracks the current staging process state
+ *
+ * @mmio_base:		MMIO base address for staging
+ * @ucode_ptr:		Pointer to the microcode image
+ * @ucode_len:		Total size of the microcode image
+ * @chunk_size:		Size of each data piece
+ * @bytes_sent:		Total bytes transmitted so far
+ * @offset:		Current offset in the microcode image
+ * @state:		Current state of the staging process
+ */
+struct staging_state {
+	void __iomem		*mmio_base;
+	void			*ucode_ptr;
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


