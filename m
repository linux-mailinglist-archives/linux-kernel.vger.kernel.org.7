Return-Path: <linux-kernel+bounces-895342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2AEC4D8AD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC331898D2A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2646635770E;
	Tue, 11 Nov 2025 11:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="folMIwpP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696F3355028;
	Tue, 11 Nov 2025 11:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762862067; cv=none; b=tUyQO/Ssl8AesNuqFfZkZNOSWlLiNpAjdvp96Gplcyu5xRx0PF2ZlqHZGd+hNB1KC58XFLazv5TIWXrPB/o3ct8KJNmzC70voaNWD5gVqeuGg84PciZWg7OJpAFZyeNIkvUjCatwH7ac9A9rkQCcA8ikOi4RhLNRptp+a031FcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762862067; c=relaxed/simple;
	bh=iv+F62RMJYJhksSfYQqP6498EgmrEbAkvJ3B3DxrSW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PXgT3qCbEwGvRzpRqNnUPa/j4y+333pgqfMRaA+fZsveUmkVYH70GctQ2iJuvnJpnqnzCw7xCqVZwVeiekJUeHsI+KpwodJNfTTigzamIj/BT6cC4zOQiYDBJx46GzztSMj0mVwgBfsy5vRXzpPRZIH4IvyVvn3Htp1LdPw+MKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=folMIwpP; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762862065; x=1794398065;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iv+F62RMJYJhksSfYQqP6498EgmrEbAkvJ3B3DxrSW0=;
  b=folMIwpPChOcOpEGnGNKkdIb3IDPCfrIvosYPW72p25zMctnRV1gdL9p
   K9jJcMtZJJepqG2mLewAkKkFxX7iUckDT16St5LBHVjKIR7CHXA1W1Q0x
   pBeVqx7Z4ByoKceXMQYUv/r+FIIoo8OhktqfgujnFsC9ANtDWVp0TtgcI
   D6c4Pt8gTpBsBHBWPi27KaAHvgbXTNHdg94KXz2KyTCwnhHqY44hn28dx
   p1mphv8t5JLhRA55NJl77pjMbqIO7fgH3NXNgmwifrRAjEr2ep34aso9N
   YEjeHCLCJ9szAzOmVZbRhuDjR+tKZeM7rzGk2haiXN1acTfmZ6XrLuxct
   g==;
X-CSE-ConnectionGUID: oY2Ubp6vRLeugifnc972+Q==
X-CSE-MsgGUID: AO3yBGm2Q0yjdo/qxtThuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="67525254"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="67525254"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 03:54:25 -0800
X-CSE-ConnectionGUID: LjpDYG46Q1mpKPZcDG7Tyg==
X-CSE-MsgGUID: FNqviYrvS2GBsUGu8fXm2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="219667753"
Received: from yungchua-desk.itwn.intel.com ([10.227.8.136])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 03:54:23 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH] soundwire: dmi-quirks: add mapping for Avell B.ON (OEM rebranded of NUC15)
Date: Tue, 11 Nov 2025 19:54:12 +0800
Message-ID: <20251111115413.245828-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

Avell B.ON is an OEM re-branded NUC15 'Bishop County' LAPBC510 and
LAPBC710.

Link: https://github.com/thesofproject/linux/issues/5529
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/dmi-quirks.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/soundwire/dmi-quirks.c b/drivers/soundwire/dmi-quirks.c
index 91ab97a456fa..5854218e1a27 100644
--- a/drivers/soundwire/dmi-quirks.c
+++ b/drivers/soundwire/dmi-quirks.c
@@ -122,6 +122,17 @@ static const struct dmi_system_id adr_remap_quirk_table[] = {
 		},
 		.driver_data = (void *)intel_tgl_bios,
 	},
+	{
+		/*
+		 * quirk used for Avell B.ON (OEM rebrand of NUC15 'Bishop County'
+		 * LAPBC510 and LAPBC710)
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Avell High Performance"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "B.ON"),
+		},
+		.driver_data = (void *)intel_tgl_bios,
+	},
 	{
 		/* quirk used for NUC15 'Rooks County' LAPRC510 and LAPRC710 skews */
 		.matches = {
-- 
2.43.0


