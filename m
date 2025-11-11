Return-Path: <linux-kernel+bounces-896047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36643C4F8BC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5463B7AB6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5C62F6923;
	Tue, 11 Nov 2025 19:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hp2bCvsp"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBAC2E6CAF
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 19:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762888276; cv=none; b=dJiWnd8VqrEQSZ4fVImLrznTs2rf1P/DvDR2QeDqdpLRHB+DiEpFW6fbap2JLYy7AY1qS416xnrVoYjjVr665XfyFdSiUBB1c7m+FTlsnw4P8CRZCETXWRdxpxFu3cmimIGlP7BYlGdDLq/s5UpP/jM2PuqIsekzOQf4o/pA31Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762888276; c=relaxed/simple;
	bh=jNH2fJ71qQRiQ1m/kFpJOrX2OTqiqu9bjj+0u+pKvVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iShFXGbAjMvHB6o5DWN9TJKoke3m/Rs26UfeGVjo2nE6NOLrOC4ojFoYmr4H+IRp4DTRso3j4LUirXPDes4TMOY/cKhyHQn6haJQOjxzpDUrFhFu8Z3z3OA9wtAfaSuWYCn7DV3ZXW6o3y5pTADkzdo7x8LwoHj/zxXwXqk/zXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hp2bCvsp; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762888272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rD/qVcQBNj5BMdd/JGH5QWU4GRzayYWuBZ3jY097n6I=;
	b=Hp2bCvspqKegkBmzTB5W29PKBTqH4FuPDjEUhWPmxZwE/nz16DJcGVcutV4zfW6pyxorIM
	txuDBLO9dIS+Pf78mQ/QKtAd2AAJAJvLbSVYjkCBST/7pANPl3fZ1UQF3KJ11vWu6ohF1i
	GoJBGyII+yPudjjKHJOpjfnEVNfpHLw=
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	"Hans de Goede" <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Limonciello, Mario" <mario.limonciello@amd.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Alok Tiwari" <alok.a.tiwari@oracle.com>,
	"Derek John Clark" <derekjohn.clark@gmail.com>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	porfet828@gmail.com,
	"Denis Benato" <benato.denis96@gmail.com>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH 2/2] platform/x86: asus-armoury: add support for FX507VV
Date: Tue, 11 Nov 2025 20:11:04 +0100
Message-ID: <20251111191104.1401105-2-denis.benato@linux.dev>
In-Reply-To: <20251111191104.1401105-1-denis.benato@linux.dev>
References: <20251111191104.1401105-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add TDP support for the ASUS TUF FX507VV model.

Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/platform/x86/asus-armoury.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/platform/x86/asus-armoury.h b/drivers/platform/x86/asus-armoury.h
index 8f7e5da087a6..2f05a2e0cab3 100644
--- a/drivers/platform/x86/asus-armoury.h
+++ b/drivers/platform/x86/asus-armoury.h
@@ -671,6 +671,33 @@ static const struct dmi_system_id power_limits[] = {
 			.requires_fan_curve = true,
 		},
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "FX507VV"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 28,
+				.ppt_pl1_spl_def = 115,
+				.ppt_pl1_spl_max = 135,
+				.ppt_pl2_sppt_min = 28,
+				.ppt_pl2_sppt_max = 135,
+				.nv_dynamic_boost_min = 5,
+				.nv_dynamic_boost_max = 25,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			},
+			.dc_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 25,
+				.ppt_pl1_spl_max = 45,
+				.ppt_pl2_sppt_min = 35,
+				.ppt_pl2_sppt_max = 60,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			},
+			.requires_fan_curve = true,
+		},
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "FX507Z"),
-- 
2.51.2


