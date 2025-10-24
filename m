Return-Path: <linux-kernel+bounces-869527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B6527C08113
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 22:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 036154EE791
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C534F2F547D;
	Fri, 24 Oct 2025 20:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYb4K6AT"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F152F4A10
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 20:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761337868; cv=none; b=SslrFJDNM6kFvFH/YPfGE9KWiWxPWhQVfF+AcUXEvDQl6TrGHybQowbU7SCu7iJpzlbWezXuWs4D4i/MPymQJzD+SXJbX41POFaD+PBFnfnr4aOT6u8PVaXhyUHh8o6N5ZnfE8k6iA+7SbF2wgdmQR/D63zM2pJVr1kO2wvHZps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761337868; c=relaxed/simple;
	bh=xJtwGFmgtaU6iZWPKPQwz0rRnnmShy5v7UuQ8AmKrW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hNZuG0wzN7jbTUuGgeS2Q0Z0NbnQ9sH/fq2nG2z0VImdSFtbKrgD/OixRvQ1ZOXAG68kP1C0ZBH9y2PH8j46L6yDy0+nvIoigObUSXnJnxYv0/11+Y68eewX/gtfGfUmWn/sdyr/pxJNBIPIKnNnXbtypOI6v7zlttOSqZyW4Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYb4K6AT; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-781206cce18so2649173b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761337864; x=1761942664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V5tOUaj5VV1BEYhc/rWHWJcsKQ0Ib+ABYORFUkcDOxk=;
        b=UYb4K6ATI2oYlzgpCr3sPw133dpRvDGAD1BD5Pjl5rKCgDDDy1kKCNlLSawqhqux1k
         K56HedUowwBt/Vhw0VLIf+TmRTpQItOoGmkkG4mRCMIXxwkHasHKGnc7iExsWhiYzz+6
         KUxe8oxiyBSi12NcPWa3VZKg3qIhBvEHWtu/+U9W3BT/YNduCfiJueHgH5StGTCb5zcy
         h8U83kx0PamaUccO3u5IRwXOhyuKjsAIHfypZSbKjyW2OK4o9H7pYxStPTjGwRxNw7V2
         v0v6VEn27gxrrX7fV9fXM5EmtM/o07qcjFpOgieRFHKq9y8lVewPuyc7N8ej7VI/7COV
         uMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761337864; x=1761942664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V5tOUaj5VV1BEYhc/rWHWJcsKQ0Ib+ABYORFUkcDOxk=;
        b=amLBL0VOFRRj8BMgosgUpQ01ZGUbWk1OmRAcKP1/+9f2tAfA4fvpd+QzdzZdSG6Era
         os1S710i694JFTGYNApVfz1nUus+MDRx2v6XD6sKcmbxe3n/H2wTlWcIiQVKnvR66hNw
         Ju6WGAdbPVFpIYMv4KJwPTLv6jheIkti3twBaVXXDCkod2yPuKaeiXcLSGLpGlZEeRBd
         jfAFlT63gIG8XAJ6lpW/WUA0P9Q+8rffSLh4zEjLPBKM9c3xfvW3vbbyAP9yaGl/FzyY
         eYoB+I/owrGibuXEQRep9Hs9iZYYYDOBvcb44P0xS2jJTlnohonXJCMb2hx3YxS0T/BZ
         7bVg==
X-Forwarded-Encrypted: i=1; AJvYcCUUyxJdKcoJjAEig1HZRZEDixT2/plcUYdWsHYVe0T8p5G6tUCvE9W6/xxZtSll+EkU7eJHuKMc+76tGvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkgmGqNJknwgOsdgyvSni5NSfvAp3aV/6490/fCbFzyHQovUBF
	lNW4/jPt3j1Ohi3Tx4Wr4me5Gh9m3ywX87FauhKcQqWgZ4j9qcjp+6tTPIOTXA==
X-Gm-Gg: ASbGncttZDBd6rFSzjhf2scWliJOBG9v3Lkwz+iaP10jAJjEymGKgAE6fkmCPDNK+Qx
	nZ2EAwSQwnDfxrSpGVz1ocbGro5MCfVn/1mxp+ScKvhR1aOTKksVpUmb+ABtmA7QEGzX89g6ooK
	X3VN6G+3xv4NzFfgQ4FI1xxS7bcxafiuvVEGEmPedZATYda7p+z624yiFQ4/1171tbPSDfwyKcA
	MhA1QGjStar/nPcSPGGD5DtqzC6hw6yypgQwIreHY0XfuKjtRQuGGIyI9Qv/bRzvXZPii2jHB2A
	srIVL/NeqAeZkm80gJclQlsGNoX5P6wKMRrGO35+xTcTTF09Tn3w6L+JgRCOtlktclg/t9HgyOx
	Ag9vYa0mlg9Dy7hEH1uTLcSBzR9CKo8ad+sLcnMezusWKEa5VM59WSskOKX/oItQ5Ehp1by47h4
	ot18rT3iQSlfxhW4iGDrNKehkC2+cBD8nY
X-Google-Smtp-Source: AGHT+IGVhdsP8QTOQ18jvLJ4RAz9BWt5s+cwCt2z98ZkChyhoIbvucYAMe2Lu+MzsPCuii/xH164Fg==
X-Received: by 2002:a05:6a00:2c4:b0:78a:f4e6:847f with SMTP id d2e1a72fcca58-7a284c4bb71mr3428596b3a.6.1761337863656;
        Fri, 24 Oct 2025 13:31:03 -0700 (PDT)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414068cdcsm98552b3a.47.2025.10.24.13.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 13:31:03 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Stanislaw Gruszka <stf_xl@wp.pl>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] wifi: rt2x00: add nvmem eeprom support
Date: Fri, 24 Oct 2025 13:30:46 -0700
Message-ID: <20251024203046.42275-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some embedded platforms have eeproms located in flash. Add nvmem support
to handle this. Support is added for PCI and SOC backends.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../net/wireless/ralink/rt2x00/rt2800lib.c    | 31 +++++++++++++++++++
 .../net/wireless/ralink/rt2x00/rt2800lib.h    |  2 ++
 .../net/wireless/ralink/rt2x00/rt2800pci.c    |  3 ++
 .../net/wireless/ralink/rt2x00/rt2800soc.c    |  6 +++-
 4 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index af19153697ed..f0d8b5140e1a 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -24,6 +24,7 @@
 #include <linux/clk.h>
 #include <linux/crc-ccitt.h>
 #include <linux/module.h>
+#include <linux/nvmem-consumer.h>
 
 #include "rt2x00.h"
 #include "rt2800lib.h"
@@ -10961,6 +10962,36 @@ int rt2800_read_eeprom_efuse(struct rt2x00_dev *rt2x00dev)
 }
 EXPORT_SYMBOL_GPL(rt2800_read_eeprom_efuse);
 
+int rt2800_read_eeprom_nvmem(struct rt2x00_dev *rt2x00dev)
+{
+	struct device_node *np = rt2x00dev->dev->of_node;
+	unsigned int len = rt2x00dev->ops->eeprom_size;
+	struct nvmem_cell *cell;
+	const void *data;
+	size_t retlen;
+
+	cell = of_nvmem_cell_get(np, "eeprom");
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	data = nvmem_cell_read(cell, &retlen);
+	nvmem_cell_put(cell);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	if (retlen != len) {
+		dev_err(rt2x00dev->dev, "invalid eeprom size, required: 0x%04x\n", len);
+		kfree(data);
+		return -EINVAL;
+	}
+
+	memcpy(rt2x00dev->eeprom, data, len);
+	kfree(data);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rt2800_read_eeprom_nvmem);
+
 static u8 rt2800_get_txmixer_gain_24g(struct rt2x00_dev *rt2x00dev)
 {
 	u16 word;
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.h b/drivers/net/wireless/ralink/rt2x00/rt2800lib.h
index 620a3d9872ce..a3c3a751f57e 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.h
@@ -248,6 +248,8 @@ void rt2800_disable_radio(struct rt2x00_dev *rt2x00dev);
 int rt2800_efuse_detect(struct rt2x00_dev *rt2x00dev);
 int rt2800_read_eeprom_efuse(struct rt2x00_dev *rt2x00dev);
 
+int rt2800_read_eeprom_nvmem(struct rt2x00_dev *rt2x00dev);
+
 int rt2800_probe_hw(struct rt2x00_dev *rt2x00dev);
 
 void rt2800_get_key_seq(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800pci.c b/drivers/net/wireless/ralink/rt2x00/rt2800pci.c
index 8c2e7b388832..c7b853195722 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800pci.c
@@ -274,6 +274,9 @@ static int rt2800pci_read_eeprom(struct rt2x00_dev *rt2x00dev)
 {
 	int retval;
 
+	if (!rt2800_read_eeprom_nvmem(rt2x00dev))
+		return 0;
+
 	if (rt2800pci_efuse_detect(rt2x00dev))
 		retval = rt2800pci_read_eeprom_efuse(rt2x00dev);
 	else
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
index 24549072e324..4952afe02b62 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
@@ -89,8 +89,12 @@ static int rt2800soc_set_device_state(struct rt2x00_dev *rt2x00dev,
 
 static int rt2800soc_read_eeprom(struct rt2x00_dev *rt2x00dev)
 {
-	void __iomem *base_addr = ioremap(0x1F040000, EEPROM_SIZE);
+	void __iomem *base_addr;
 
+	if (!rt2800_read_eeprom_nvmem(rt2x00dev))
+		return 0;
+
+	base_addr = ioremap(0x1F040000, EEPROM_SIZE);
 	if (!base_addr)
 		return -ENOMEM;
 
-- 
2.51.1


