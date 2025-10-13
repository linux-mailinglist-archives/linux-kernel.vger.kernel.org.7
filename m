Return-Path: <linux-kernel+bounces-851174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E8BBD5B03
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7F1A18A6A04
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82ECE2D3A6F;
	Mon, 13 Oct 2025 18:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=josie.lol header.i=@josie.lol header.b="HSaSN1J5"
Received: from mail-108-mta207.mxroute.com (mail-108-mta207.mxroute.com [136.175.108.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A0726D4D4
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379705; cv=none; b=XmcZrzTH9zo9N+8sUjDgs0QS6+VmucuX1WfyZqyDZQKOFDGZtAMPwzJy8Ob/zwNrLxkFm0JEb2xyTXzhgtRozza6O8vaaxqPF5lAVir616UcwA5noAm3jWtCZTJY5mhRRDdrzJE/6pC9bJB+OQ2cgpORjTaPY3d2K+8sgaZU0ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379705; c=relaxed/simple;
	bh=RKQn7v1YbHESUH365vSK2lrD4VbVPAX6P/GcOpG95Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VsynBi3cDNHyxJYAloYdNx+hGIdnQJ0yxYrD8KmhhQASIWZ/TlStY6Q7lig+XAPJwAafp2+bEpf6cWq0Z6k9rY2JPL3qx9tq3grn5FM84oapBaC2Yt7XtAqKL29UUpEQaVhZEjPlt452vrdFjd7hUCPjm3HDIR8sIyQSo1hwxAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=josie.lol; spf=pass smtp.mailfrom=josie.lol; dkim=pass (2048-bit key) header.d=josie.lol header.i=@josie.lol header.b=HSaSN1J5; arc=none smtp.client-ip=136.175.108.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=josie.lol
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=josie.lol
Received: from filter006.mxroute.com ([140.82.40.27] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta207.mxroute.com (ZoneMTA) with ESMTPSA id 199dec9bf33000d597.005
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 13 Oct 2025 18:16:27 +0000
X-Zone-Loop: 472f913da313fb3118b6cece6af75dcfa77b80491536
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=josie.lol;
	s=x; h=Content-Transfer-Encoding:MIME-Version:Date:Subject:Cc:To:From:Sender:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References;
	bh=oOaIP4PXPZ8f4MFafQwb1jy9OdKZ3lVY4r0RmSBbOYc=; b=HSaSN1J5I8FNryB3n37i1G5Nj3
	9Ur9+osRIP5M1fIYe9kiT0lauaT0li9zLudc/B0yWggsFhVgVwIf95raG53xexIzoC2PESdFyG3MH
	GGxfTSvazj1fOJ8VFEe6ftEd5ef1vTYElL4sZJnUxFHQNGraSh/RWtzBzVv9y4grZeT4IZk/TlgGC
	LZMYKM0p+BrlMgbJIeagqUISQH0Fgep+11kB64L0j+0cyiL+WzgN6U538MsPibGyAz8lpfNz/G5he
	WbjNgEt/DWpnlsHEAerndc3yCx3HZSTWIF4nDWmq+kepJ63lx0hZ/YT/K0tkCCFxrtIP0/mAX3rBY
	UDNmQzLw==;
From: Josephine Pfeiffer <hi@josie.lol>
To: Koby Elbaz <koby.elbaz@intel.com>,
	Konstantin Sinyuk <konstantin.sinyuk@intel.com>
Cc: Oded Gabbay <ogabbay@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] accel/habanalabs: Replace sprintf with snprintf for buffer safety
Date: Mon, 13 Oct 2025 20:16:20 +0200
Message-ID: <20251013181620.2026326-1-hi@josie.lol>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: hi@josie.lol

Replace unbounded sprintf() calls with snprintf() in the RAZWI error
handler function gaudi2_ack_module_razwi_event_handler() to prevent
potential buffer overflows. The initiator_name buffer has a fixed size
of 64 bytes, and using snprintf() ensures writes cannot exceed this
boundary.

This change affects error reporting for different accelerator components
(TPC, MME, EDMA, PDMA, NIC, DEC, ROT, ARC_FARM) when Router AXI Write
Initiator errors occur on the Gaudi2 AI accelerator.

All 8 sprintf() calls in the switch statement have been converted to use
snprintf() with sizeof(initiator_name) as the size parameter.

Signed-off-by: Josephine Pfeiffer <hi@josie.lol>
---
 drivers/accel/habanalabs/gaudi2/gaudi2.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index b8c0689dba64..367902ac17a9 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -8479,7 +8479,7 @@ static void gaudi2_ack_module_razwi_event_handler(struct hl_device *hdev,
 
 	switch (module) {
 	case RAZWI_TPC:
-		sprintf(initiator_name, "TPC_%u", module_idx);
+		snprintf(initiator_name, sizeof(initiator_name), "TPC_%u", module_idx);
 		if (hdev->tpc_binning) {
 			binned_idx = __ffs(hdev->tpc_binning);
 			if (binned_idx == module_idx)
@@ -8490,7 +8490,7 @@ static void gaudi2_ack_module_razwi_event_handler(struct hl_device *hdev,
 		lbw_rtr_id = gaudi2_tpc_initiator_lbw_rtr_id[module_idx];
 		break;
 	case RAZWI_MME:
-		sprintf(initiator_name, "MME_%u", module_idx);
+		snprintf(initiator_name, sizeof(initiator_name), "MME_%u", module_idx);
 		switch (module_sub_idx) {
 		case MME_WAP0:
 			hbw_rtr_id = gaudi2_mme_initiator_rtr_id[module_idx].wap0;
@@ -8533,20 +8533,20 @@ static void gaudi2_ack_module_razwi_event_handler(struct hl_device *hdev,
 		lbw_rtr_mstr_if_base_addr = mmSFT0_LBW_RTR_IF_MSTR_IF_RR_SHRD_HBW_BASE +
 								dcore_id * SFT_DCORE_OFFSET;
 		via_sft = true;
-		sprintf(initiator_name, "EDMA_%u", module_idx);
+		snprintf(initiator_name, sizeof(initiator_name), "EDMA_%u", module_idx);
 		break;
 	case RAZWI_PDMA:
 		hbw_rtr_id = gaudi2_pdma_initiator_hbw_rtr_id[module_idx];
 		lbw_rtr_id = gaudi2_pdma_initiator_lbw_rtr_id[module_idx];
-		sprintf(initiator_name, "PDMA_%u", module_idx);
+		snprintf(initiator_name, sizeof(initiator_name), "PDMA_%u", module_idx);
 		break;
 	case RAZWI_NIC:
 		hbw_rtr_id = gaudi2_nic_initiator_hbw_rtr_id[module_idx];
 		lbw_rtr_id = gaudi2_nic_initiator_lbw_rtr_id[module_idx];
-		sprintf(initiator_name, "NIC_%u", module_idx);
+		snprintf(initiator_name, sizeof(initiator_name), "NIC_%u", module_idx);
 		break;
 	case RAZWI_DEC:
-		sprintf(initiator_name, "DEC_%u", module_idx);
+		snprintf(initiator_name, sizeof(initiator_name), "DEC_%u", module_idx);
 		if (hdev->decoder_binning) {
 			binned_idx = __ffs(hdev->decoder_binning);
 			if (binned_idx == module_idx)
@@ -8558,12 +8558,12 @@ static void gaudi2_ack_module_razwi_event_handler(struct hl_device *hdev,
 	case RAZWI_ROT:
 		hbw_rtr_id = gaudi2_rot_initiator_hbw_rtr_id[module_idx];
 		lbw_rtr_id = gaudi2_rot_initiator_lbw_rtr_id[module_idx];
-		sprintf(initiator_name, "ROT_%u", module_idx);
+		snprintf(initiator_name, sizeof(initiator_name), "ROT_%u", module_idx);
 		break;
 	case RAZWI_ARC_FARM:
 		lbw_rtr_id = DCORE1_RTR5;
 		hbw_rtr_id = DCORE1_RTR7;
-		sprintf(initiator_name, "ARC_FARM_%u", module_idx);
+		snprintf(initiator_name, sizeof(initiator_name), "ARC_FARM_%u", module_idx);
 		break;
 	default:
 		return;
-- 
2.51.0


