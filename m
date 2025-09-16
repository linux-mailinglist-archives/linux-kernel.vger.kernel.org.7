Return-Path: <linux-kernel+bounces-819294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2C2B59E20
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E17057B8DC0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3972FFFA5;
	Tue, 16 Sep 2025 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="LwC2ioLA"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5FD2FFFB1;
	Tue, 16 Sep 2025 16:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758041236; cv=none; b=XWlbZl9zOiYNHG3/zMrFNryFtSkvdfMYYat7rU31yX/4D2ouNNIIC0GF10xidgShfMgXuo7PIU3/T1JtExunor1+7faCbXkaSq0WigUl6qLMWamzgQXdgKrRwON7zTRMKm3OqAlUA6DCNIg2ZR/esbRHOdY2GDbVS/ZGej9B4Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758041236; c=relaxed/simple;
	bh=PdygDpqinwiu7NLHrrvG06Dc92n3RgdLT0rkuoGXPsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dUROxtib5/RIKgb1tnF97rlSqaiBHxSL7utkLIOHjSqHEZ04VUTvrrwPIqmZycN27M4s291EpUtjG5BG02uKnhv3xHZlh9UaKCXrmyMuruBZXsU82QkcQLdiiZE17nMSoQdgr/uz/Afv5puIJyVBzZA+KVX7qph9NLCKXambwOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=LwC2ioLA; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from wse-pc.fritz.box (p5de4594b.dip0.t-ipconnect.de [93.228.89.75])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id A0BD82FC0047;
	Tue, 16 Sep 2025 18:47:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1758041225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R3S2dc7LozPZhcQ1Khc9koI/dHElluQu2d1WDUXt38g=;
	b=LwC2ioLAnWMG4O1H0Vp8pkgk/wnoOao1ziAW1VUzF/dqvzeSGn+/LN0skQXicCBB6W8u6m
	UQ56n4ElpsPGvKLcwuKVq3TOdbM0Rx/m/JpLcePLXovFPyeX7pMBw+Wvo6kAaWGH/FUnXo
	xD/OCjFA8ZDDDsW0qH/T3JCRJes35gM=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Christoffer Sandberg <cs@tuxedo.de>,
	Werner Sembach <wse@tuxedocomputers.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] platform/x86/amd/pmc: Add Stellaris Slim Gen6 AMD to spurious 8042 quirks list
Date: Tue, 16 Sep 2025 18:46:49 +0200
Message-ID: <20250916164700.32896-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoffer Sandberg <cs@tuxedo.de>

Prevents instant wakeup ~1s after suspend

Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 drivers/platform/x86/amd/pmc/pmc-quirks.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86/amd/pmc/pmc-quirks.c
index 18fb44139de25..837f23217637d 100644
--- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
+++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
@@ -248,6 +248,13 @@ static const struct dmi_system_id fwbug_list[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Lafite Pro V 14M"),
 		}
 	},
+	{
+		.ident = "TUXEDO Stellaris Slim 15 AMD Gen6",
+		.driver_data = &quirk_spurious_8042,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GMxHGxx"),
+		}
+	},
 	{
 		.ident = "TUXEDO InfinityBook Pro 14/15 AMD Gen10",
 		.driver_data = &quirk_spurious_8042,
-- 
2.43.0


