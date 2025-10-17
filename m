Return-Path: <linux-kernel+bounces-857405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D217BE6B42
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 639A25001D4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0ED30F94B;
	Fri, 17 Oct 2025 06:34:28 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9C21D6187;
	Fri, 17 Oct 2025 06:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760682867; cv=none; b=DWSrKhUpL7Lr+fzetuZRMXtk+2LFI90m6EurYmSCQJ1al+n0ld+tOqP3CjjqeTPZNcFzC1txfCpFWjGjnzcvO8U8z8X9eykeF6DpllpF1hRSk2APqszl/wzJHDf/5qqd1Pjhhyqjk22haBD2FuCW0MBjxhgfDz9Cgd1hN+cMOF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760682867; c=relaxed/simple;
	bh=a2MEDxES9W8vsM6/5WwPkLqU8ko9tfiblUn+G4lVHSg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p6zmB50ZsreZmVdGrTp0so4sFf7DaSKJiMDL6SNgOTj1PSPBHl3Kjs+0gc7p6/sednhb+SseqFuHfC1LwdUiQ0TwMOCUNSvTzJv0LR1oUdOivQeMU2iStUO1POBb/bzwBtQ6oCnbIV8PEsZ8iYdMEjh8L2bFUyKD73BPz3lxraU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4ebf941aab2311f0a38c85956e01ac42-20251017
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:212548fa-5c9c-40d1-ac31-9805130070f0,IP:0,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:25
X-CID-META: VersionHash:a9d874c,CLOUDID:03d98ff859956578efd0fda194d07da7,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|50,EDM:5,IP:nil
	,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4ebf941aab2311f0a38c85956e01ac42-20251017
X-User: liqiang01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liqiang01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1799036817; Fri, 17 Oct 2025 14:34:18 +0800
From: Li Qiang <liqiang01@kylinos.cn>
To: thomas.richard@bootlin.com,
	linux@roeck-us.net
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Qiang <liqiang01@kylinos.cn>
Subject: [PATCH] hwmon: cgbc-hwmon: Add missing NULL check after devm_kzalloc()
Date: Fri, 17 Oct 2025 14:34:14 +0800
Message-Id: <20251017063414.1557447-1-liqiang01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver allocates memory for sensor data using devm_kzalloc(), but
did not check if the allocation succeeded. In case of memory allocation
failure, dereferencing the NULL pointer would lead to a kernel crash.

Add a NULL pointer check and return -ENOMEM to handle allocation failure
properly.

Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
---
 drivers/hwmon/cgbc-hwmon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwmon/cgbc-hwmon.c b/drivers/hwmon/cgbc-hwmon.c
index 772f44d56ccf..3aff4e092132 100644
--- a/drivers/hwmon/cgbc-hwmon.c
+++ b/drivers/hwmon/cgbc-hwmon.c
@@ -107,6 +107,9 @@ static int cgbc_hwmon_probe_sensors(struct device *dev, struct cgbc_hwmon_data *
 	nb_sensors = data[0];
 
 	hwmon->sensors = devm_kzalloc(dev, sizeof(*hwmon->sensors) * nb_sensors, GFP_KERNEL);
+	if (!hwmon->sensors)
+		return -ENOMEM;
+
 	sensor = hwmon->sensors;
 
 	for (i = 0; i < nb_sensors; i++) {
-- 
2.25.1


