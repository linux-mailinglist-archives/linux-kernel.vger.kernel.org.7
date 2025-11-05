Return-Path: <linux-kernel+bounces-886571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 58653C35F79
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 15:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DBA3434C4ED
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3B2328B6D;
	Wed,  5 Nov 2025 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exJ196Dv"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C911E217F24
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762351684; cv=none; b=Kzg3Rp5ybOEvvGKL746WEz/o53090swAVBLpgbAfhh7C0t3A2q43OzhWYiULvn41+2wcSDDmTQYfiyYlxhjlkS3iAEb0W3AWGBjHBFEP25r9loD7lszdyoYdWHckhMnpPbLX7U4DbiP8GeamrFGAyZ3M+LXTxQpWcLUy629WjO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762351684; c=relaxed/simple;
	bh=D1e3PqsDgSVg01Y56yPEgBksv7OMvfjXdZ87PsO9sg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=doSv2kDnytIy1MFRlOW5Bqh8liHYcqzF9CoFjSkE+ijE6vM1D/qi6LSdI8fckqJ8GmBbwjVbXTBstmpE/CkKqeDyHjMvHCOVZisHiwbuEZhH5y2HNsY8liQ+hTHiNmpXEldVduIvJAg7Sj4PcBh/OQU/YzzPgPm/mQv6CedmRXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exJ196Dv; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-33292adb180so7108268a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 06:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762351682; x=1762956482; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e9k6YZPdseL2nMqrpcpE66trirUONOvdRAtp5r/05CA=;
        b=exJ196DvqhSwCvti0ZKN8EWMFmXfW4SNa8+XBRjzamlRwHzgbyRwKFv5sp6rNL76SQ
         PjIFH3M3gtt7ONsH46+fL3FNONRXaeyy7kj7lyv5nHkDNZaElt4Vh75GA5Xul3GZkatB
         3aHDgcWfgsdKT1c6BdSpJJ34JvUWBXg7DWxyeOCi1LHE/aSp7y3HdbqLgZXsLcYrvIu/
         hc+IvSRAW2/fwDg29fSnl+/uK5toNe9jt/+Iu6iaInMwX5VnDZijryUhLUWXUVxXgfxF
         0IGxPvMTaOiea6s5EQN0u/VVAI+iZr6rIbeGhnnb4eH1QK2DIotnEUlg/8CUQ8u+cGVo
         1BFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762351682; x=1762956482;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e9k6YZPdseL2nMqrpcpE66trirUONOvdRAtp5r/05CA=;
        b=wE5J6ylrno75gmOZnIEv2suaqIozlRogNmUQp/WWIaFnMRhG3Um+JDOz11iiOyRODX
         0XfWMnxfgxjTxykrHG4Fc74/LftBtRkbeOJ7cn1zevDd9Axee7JObvHFJ31KBjh0nMf8
         gDZI/0l1cmcF320dbvx9G+c5DQMquG8qJHf9x9OrHUhK5mPVVje4yZpD9ze9sFgJmqUJ
         2pofyo0W6+n6RkeV5HS0E9wizD57LzqlWMe17TB/mCj8Qyg96M7Q2PVrNIoYyoau88Wa
         Y8BHDjYLARKWhqQvoaY1MRX/x9CDHSrHVc9up3SZ+VnPeCsrYHl04COpxrNbfBqpiBon
         ca6A==
X-Forwarded-Encrypted: i=1; AJvYcCWFL4nnYDF3/Q+CQi75+76T23Wlw9Alc46fepdoymxXNncaP+2+boVauaUdhPqTw5DJpWmglqYnDFDZDNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy32go4CN8TZiGGopo8UWH9FKnxkxycEq6fOgYZCkSQuenltGjE
	QFhiAgpbKqDIX+SrphaG7yfOF4y+RriPL8oc8iPF6LMV9dvTFdF/JgUe
X-Gm-Gg: ASbGnctDAXT+tF29ORIf7W4tQY5+1mBW/ekM/lNhKsn9ZlgA8z6fYf+4B0Qqa3HyIYm
	M30Buw/7NFAaPRdWWQT5HP5GnTd2zHdgu6TujvPu9QDZe3zTWhFo/7puL4NJhADSttC8KplnRXX
	d3QOcntYHKEjZdZRcQgicQSauNsXuba5e8zdLJMjvB8KoerB3m2+2W5Re+shnnetAAG2rXFymi6
	HfU8ZKTbo7oV2CDLjyD/OMZAYKfJNH6SZNnws/XHUQYOoj0+musZfu31e0SgtQhOlmNMLg8/c96
	qk7fLXLXjHwCO9FXZbdmCqkEJjoArsEXBIZB4EZuVeq3wuNf6z0eN5G4qbJC0dffIYGOMBOA904
	wGuT5Jl/o/Ma8rV89uwZfGkMX4LG2rRCn3HA5bxTJgG0bULuJA008kNCdcTWlWEyZ7tyB9iJIEp
	xR5hLJmhm9cQ==
X-Google-Smtp-Source: AGHT+IGLooWGceuU3Xy6pREqs4jHf5ahAGLwUS3xj0A3y7lHHK9M4p0Qnju+mGSRH4RzUh8au2cYpA==
X-Received: by 2002:a17:90b:2751:b0:340:dd2c:a3f5 with SMTP id 98e67ed59e1d1-341a6c006bemr3407374a91.3.1762351682042;
        Wed, 05 Nov 2025 06:08:02 -0800 (PST)
Received: from aheev.home ([2401:4900:88f4:f6c4:1d39:8dd:58db:2cee])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68bf37bsm3090217a91.7.2025.11.05.06.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:08:01 -0800 (PST)
From: Ally Heev <allyheev@gmail.com>
Date: Wed, 05 Nov 2025 19:37:52 +0530
Subject: [PATCH] arm: fix uninitialized pointers with free attr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-aheev-uninitialized-free-attr-arm-v1-1-f7b6cb5d3361@gmail.com>
X-B4-Tracking: v=1; b=H4sIADdaC2kC/x3NQQrCQAxG4auUrA00lSnFq4iL2P5jA+0ombGIp
 Xd3cPlt3tspww2ZLs1Ojs2yPVOFnBoaZ00PsE3V1LVdEGkD6wxs/E6WrJgu9sXE0QHWUpzVVx7
 jOUh/V1EZqHZejmif/+N6O44f/b3z4XMAAAA=
X-Change-ID: 20251105-aheev-uninitialized-free-attr-arm-cf3516ba1a18
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
 Ally Heev <allyheev@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1778; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=D1e3PqsDgSVg01Y56yPEgBksv7OMvfjXdZ87PsO9sg8=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDK5o+xMm3Z0aui/S9/z7Ir3feess6XdV76fPH47JeTKk
 Wb9rT1FHaUsDGJcDLJiiiyMolJ+epukJsQdTvoGM4eVCWQIAxenAEzkeT8jwypbxilsfDmrTTov
 mQvry+3dZ9U8W08wLrL/EcOBaRvvVTEyNPfc3PBtS/uyvu1tH1Q8ZI4fOvtfYKrlwb7uO4U7dqu
 /ZwIA
X-Developer-Key: i=allyheev@gmail.com; a=openpgp;
 fpr=01151A4E2EB21A905EC362F6963DA2D43FD77B1C

Uninitialized pointers with `__free` attribute can cause undefined
behaviour as the memory assigned(randomly) to the pointer is freed
automatically when the pointer goes out of scope

arm doesn't have any bugs related to this as of now, but
it is better to initialize and assign pointers with `__free` attr
in one statement to ensure proper scope-based cleanup

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/aPiG_F5EBQUjZqsl@stanley.mountain/
Signed-off-by: Ally Heev <allyheev@gmail.com>
---
 drivers/firmware/arm_scmi/shmem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/shmem.c b/drivers/firmware/arm_scmi/shmem.c
index 11c347bff766763c61100f884432c2e4669e5918..dadb37557f8aee25465e1a423dfcb4a889852434 100644
--- a/drivers/firmware/arm_scmi/shmem.c
+++ b/drivers/firmware/arm_scmi/shmem.c
@@ -196,7 +196,6 @@ static void __iomem *shmem_setup_iomap(struct scmi_chan_info *cinfo,
 				       struct resource *res,
 				       struct scmi_shmem_io_ops **ops)
 {
-	struct device_node *shmem __free(device_node);
 	const char *desc = tx ? "Tx" : "Rx";
 	int ret, idx = tx ? 0 : 1;
 	struct device *cdev = cinfo->dev;
@@ -205,7 +204,9 @@ static void __iomem *shmem_setup_iomap(struct scmi_chan_info *cinfo,
 	void __iomem *addr;
 	u32 reg_io_width;
 
-	shmem = of_parse_phandle(cdev->of_node, "shmem", idx);
+	struct device_node *shmem __free(device_node) = of_parse_phandle(cdev->of_node,
+		"shmem", idx);
+
 	if (!shmem)
 		return IOMEM_ERR_PTR(-ENODEV);
 

---
base-commit: c9cfc122f03711a5124b4aafab3211cf4d35a2ac
change-id: 20251105-aheev-uninitialized-free-attr-arm-cf3516ba1a18

Best regards,
-- 
Ally Heev <allyheev@gmail.com>


