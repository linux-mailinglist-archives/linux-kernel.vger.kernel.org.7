Return-Path: <linux-kernel+bounces-722922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB236AFE0AF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1215C1C2731C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BB526B757;
	Wed,  9 Jul 2025 07:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ees+XgtX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0761321ABAC;
	Wed,  9 Jul 2025 07:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752044472; cv=none; b=VoV+44FJ/sr1Lkdx4V4ENkOoNa2RsJui9pRJ5GVRDIBwepDiTDlhKeGPNTJ2G6ydXSgrZuSczRig6DEHiih41fz9XTWl+cXxI14Lcxy/NzBBQYocY8o+xTEEMgka6TuiUPavWKH8Tul8qKFl7p1HtMoo+dmstJs50rYnqO6xdGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752044472; c=relaxed/simple;
	bh=hxPSyY5k5W1yAZvXq3K3ryc/SwkGUc1a7pKy7EuahwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p1WcWaqCewtRA5Q0AhsXTp6yTi4hFJqD0HDvi2Wg4Orvasq/LiOUaJI30hk+fYlQejomxc2JT4FfZ6JryBtYa65xYGIrLMGVM0E7tq5zS1+pheRPqgLhui7+ZkAJSDSi8Yz1sEcNJO/Q2y0rua9gHKG7+QNczTsWX9G2y8sh4lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ees+XgtX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D0FC4CEF0;
	Wed,  9 Jul 2025 07:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752044471;
	bh=hxPSyY5k5W1yAZvXq3K3ryc/SwkGUc1a7pKy7EuahwQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Ees+XgtXV73RpRtZCFqm9jbRNdg4BDEX7Uiy+Eu+Id3eisjdRXsK/U1Tr1fiJOijY
	 F8HRS0MzuijbA8Cy2H8dq68eMOFCJYyH/qxkoSBUDfgwAJ2IZOhbOzcnb2nF7yLH09
	 CFCNVCi7Uclc8E2PVv3DMBdSVdlSl39uqJ3uOKlmCS66NGRIiLkEVoBuFNAc7v++H0
	 yIKT4wp9ELfwpBTMV4zyXHeXrbWCfTnsY81Cprk3+SF54OzS3UmG9T4vFB9HvI5mXs
	 mDQ7Z28pxa7OqFcwIR1aCWcmOu+iCtJ2/m5yD7RR3esVmdPcludLijl25xEcQsKiTL
	 mBJZ7lV0NIsKg==
From: Arnd Bergmann <arnd@kernel.org>
To: Sudeep Holla <sudeep.holla@arm.com>,
	Peng Fan <peng.fan@nxp.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: arm_scmi: convert to SYSTEM_SLEEP_PM_OPS
Date: Wed,  9 Jul 2025 09:01:01 +0200
Message-Id: <20250709070107.1388512-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The old SET_SYSTEM_SLEEP_PM_OPS() macro leads to a warning about an
unused function:

drivers/firmware/arm_scmi/scmi_power_control.c:363:12: error: 'scmi_system_power_resume' defined but not used [-Werror=unused-function]
  363 | static int scmi_system_power_resume(struct device *dev)

The proper way to do this these days is to use SYSTEM_SLEEP_PM_OPS()
and pm_sleep_ptr().

Fixes: 9a0658d3991e ("firmware: arm_scmi: power_control: Ensure SCMI_SYSPOWER_IDLE is set early during resume")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/firmware/arm_scmi/scmi_power_control.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/scmi_power_control.c b/drivers/firmware/arm_scmi/scmi_power_control.c
index ab0cee0d4bec..955736336061 100644
--- a/drivers/firmware/arm_scmi/scmi_power_control.c
+++ b/drivers/firmware/arm_scmi/scmi_power_control.c
@@ -369,7 +369,7 @@ static int scmi_system_power_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops scmi_system_power_pmops = {
-	SET_SYSTEM_SLEEP_PM_OPS(NULL, scmi_system_power_resume)
+	SYSTEM_SLEEP_PM_OPS(NULL, scmi_system_power_resume)
 };
 
 static const struct scmi_device_id scmi_id_table[] = {
@@ -380,7 +380,7 @@ MODULE_DEVICE_TABLE(scmi, scmi_id_table);
 
 static struct scmi_driver scmi_system_power_driver = {
 	.driver	= {
-		.pm = &scmi_system_power_pmops,
+		.pm = pm_sleep_ptr(&scmi_system_power_pmops),
 	},
 	.name = "scmi-system-power",
 	.probe = scmi_syspower_probe,
-- 
2.39.5


