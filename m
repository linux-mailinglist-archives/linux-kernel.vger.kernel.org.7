Return-Path: <linux-kernel+bounces-852508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D3ABD9266
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D1054FFE09
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC7E3112B6;
	Tue, 14 Oct 2025 11:55:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BA53101D8;
	Tue, 14 Oct 2025 11:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760442933; cv=none; b=KTodhBn2xoC0ZfRGoUkKC1an6n9R6/HohkOxQY22MdEaO7iPnc8m0avAgczJAtsMax5py5EpX4gUXH7TF1IeiFkWGvkZ0uN30H1oxc6fJogVZIed+IEieU+8bkyUHnLOTEf/fk6UmKDzXokZSdeqPK4f3xoGwoKsXRjoqdQPiBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760442933; c=relaxed/simple;
	bh=M/h7yA1/0CWU4mKG7DjMv0EcM+/hxCquNl2FDa9kBIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5pR1nW4enOgpEth+tx9bsQg210iGThos0BwzguqpKTqffRZTjvShlVYBS4JFGdXzZPdcadQwbpxQRf+KCzsZww+nHveWqrp6sIuWWw5BBa7JfHpQ3Hp+WY+0gMqsOsPxLq1NZixnlDzJQk1Y5LnNBqoRRVXq+k7/30DeSztjzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 413CB2008;
	Tue, 14 Oct 2025 04:55:23 -0700 (PDT)
Received: from pluto.guest.local (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E9603F6A8;
	Tue, 14 Oct 2025 04:55:29 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	philip.radford@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 3/3] firmware: arm_scmi: Skip RAW initialization on failure
Date: Tue, 14 Oct 2025 12:53:46 +0100
Message-ID: <20251014115346.2391418-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014115346.2391418-1-cristian.marussi@arm.com>
References: <20251014115346.2391418-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid attempt to initialize RAW when the debug subsystem itself failed to
initialiaze as a whole since it is useless and emits misleading error
messages.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 1cd15412024c..eb46694cb14b 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -3028,9 +3028,6 @@ static int scmi_debugfs_raw_mode_setup(struct scmi_info *info)
 	u8 channels[SCMI_MAX_CHANNELS] = {};
 	DECLARE_BITMAP(protos, SCMI_MAX_CHANNELS) = {};
 
-	if (!info->dbg)
-		return -EINVAL;
-
 	/* Enumerate all channels to collect their ids */
 	idr_for_each_entry(&info->tx_idr, cinfo, id) {
 		/*
@@ -3202,7 +3199,7 @@ static int scmi_probe(struct platform_device *pdev)
 		if (!info->dbg)
 			dev_warn(dev, "Failed to setup SCMI debugfs.\n");
 
-		if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT)) {
+		if (info->dbg && IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT)) {
 			ret = scmi_debugfs_raw_mode_setup(info);
 			if (!coex) {
 				if (ret)
-- 
2.51.0


