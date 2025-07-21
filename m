Return-Path: <linux-kernel+bounces-738947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E15AEB0BF6B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 197A27A273F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6181628934C;
	Mon, 21 Jul 2025 08:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBmo1L60"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB2A288CA7;
	Mon, 21 Jul 2025 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753087664; cv=none; b=IkBUTUW8bGyhc3oEUS9iQHL+lD1o9tNqIt9EsdYYoeS/QhYWe703vlBFM0lDBS0g5b55b69AaGL31F495EJ1LVd1WQWg5ATLlyD6zndJ8zipUOvP1HmeC4b3ntijKJiCkiEQZSXGQjz7knyZEElrMEPnbUYHNGOxt6rGWN0Amw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753087664; c=relaxed/simple;
	bh=i7VVuYv+P4xRsoyjq1c/yRjV/hufkbOIz6TCTO4rLzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/AOqloq+68tr8JDNhG+PKSJ96CxqLnc1Wa2yZUFs48OK2Im1C+rJ5EfM2kXx2n/uDrb6jprVkYs0bmR2MczcWG25K1blBZtRR/o/X8sx3M6/CzRO447LeSZ1Czz3/RhFiiEP0nXCEq+CxssqqeHXtoueVOpJQlJYS58PvcY0H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBmo1L60; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-236192f8770so25887455ad.0;
        Mon, 21 Jul 2025 01:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753087661; x=1753692461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cbM67qGx5QSC1ipsVqXIeegdixDNC3ESXsKYI9auyc=;
        b=ZBmo1L60p3JF99QkMxk4SRlTHz/F46IrOjvSVgzB5ORjlL4BLgjm00LQVPWIljMMXF
         fyciWB9Dal5Z1NFwaCHFyK9J4VUtLNm2XZwa1HoZknj/HGHAp9R/z+HZj8a2SK8gSXgB
         Y9IgKGJL66dHv6uJpSbswpIYKw4qc3d7X6BVDmrtjy7x2FZp6mjlxMSXmOGhFLj7pj6y
         hlnO60bkcJNty3nm0pSUf0BlLoeXFrdAxR94VTBeoLf0QA0Qu+u6PGhn3Ff+piDihVBy
         g19gbwxZG7uChUgothTtTYkDNhJQ2ZzLZuUYWk27af46CYf19TYd9RMqoJ6nsBopMf3f
         UrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753087661; x=1753692461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cbM67qGx5QSC1ipsVqXIeegdixDNC3ESXsKYI9auyc=;
        b=wquQ0IP8LXweStcaeg4zW/5wmkTvfHd3l29zyvyhZjWmIjNpdAcHOu+pkBL5FPh4uM
         26ACQ60U/ZMPouwZpZ+rhpGAoTY99P2FZkjFcHTIl/7QKbSsmj4gCIXbkKdfRxsvJd/X
         Pmm0Ej7f3taov6Zsx2dp8COpq2FsG5Ahy36f+BHTcKQoYVG92IyAd3dbynpeFfl7dTUW
         L+v5LwstMnp3NEehw6XZXbIVdFKG1fH2xr5+TXTOuxcAhdpdxNnerVtN9pRZumxShEqD
         bMB+QhTTk8/kbiRSPwjc7EhzJ9rGV1DYrv3XcTc2N0Fy+cNyRKRlEtsWVd0PHzOFdAwI
         s0KA==
X-Forwarded-Encrypted: i=1; AJvYcCX3xP/s8m6DReMODZ5YjZot5TgXpPAPz9TRrMKXhZlwQVXEeht938UmWzVudOzGpwJuYyNjL1fyIGzmeg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhPssb6WDsgPAcdZAhjY955Q6mX1iosN58d2w6BieHfjaPNd/f
	u4oqiKXTN9td12fYXGwoeulcUt1y+i8+jPCb783gHUuOj39xT0+WhsXk
X-Gm-Gg: ASbGncsAPBI1gEVgnaXaOWRwRU38XhdwcEkMmHFcPXIcmlNMsUWXDo1al/CvlerFAqg
	MQ/lTKHRv1W7OVqUeXOqmI7YbFgnPG9WE3Hp8bODXyz3Y/zvRw3fFYNMTZqYTZ3IHV5zNgtJMW2
	r5FTdR9QG0x8sK7gPjmJRD3Qfe9ThrCqDlk1xZv0+WbbDSRT+qGdvp4yTMoHucqe+Hlq7ddF2ZD
	yRZSOEy/1ArkEhwmNvbHyxgGz/E1vA52R1bqjrjyYdIL/N9SEHhQNZvJFTWCAa+F/wLjBXgP9FJ
	arf33X5q6yRNDtF7YR31SJIs39z74MX3x4U1En2u/2GdDSQFdZO7oh6ZBPXpR6zCBs67+tAYCOv
	WxTIqR4qsT/WcfqkAklt5bUM=
X-Google-Smtp-Source: AGHT+IFiv9/4lKofAIAgSdYH4Vxrhb7X7wP/8eNQWmCuztPTRFiJAgugR5hrcWXoR1AeNz8xKN4WAw==
X-Received: by 2002:a17:902:f785:b0:23e:3911:433e with SMTP id d9443c01a7336-23e3911476bmr193791535ad.5.1753087661138;
        Mon, 21 Jul 2025 01:47:41 -0700 (PDT)
Received: from skc-Dell-Pro-16-Plus-PB16250.. ([132.237.156.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6d9504sm53240505ad.179.2025.07.21.01.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 01:47:40 -0700 (PDT)
From: Suresh K C <suresh.k.chandrappa@gmail.com>
X-Google-Original-From: Suresh K C
To: vkoul@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	sanyog.r.kale@intel.com,
	shuah@kernel.org,
	suresh.k.chandrappa@gmail.com,
	yung-chuan.liao@linux.intel.com
Subject: [PATCH v2] soundwire: replace scnprintf() with sysfs_emit() for sysfs consistency
Date: Mon, 21 Jul 2025 14:17:29 +0530
Message-ID: <20250721084729.102130-1-suresh.k.chandrappa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aH3LEmB3hafb3T8E@vaman>
References: <aH3LEmB3hafb3T8E@vaman>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Suresh K C <suresh.k.chandrappa@gmail.com>

Replace scnprintf() with sysfs_emit() or sysfs_emit_at()
in SoundWire driver files to align with the guidelines
outlined in Documentation/filesystems/sysfs.rst.

This change improves the safety and correctness
of sysfs attribute handling,ensures consistency across
the kernel codebase, and simplifies future maintenance.

Changes since v1:
- Removed unintended double semicolon (;;)
- Fixed trailing whitespace
- Ran checkpatch and resolved reported issues

Tested by enabling CONFIG_DEBUG_FS and confirming that
/sys/kernel/debug/soundwire is correctly populated

Signed-off-by: Suresh K C <suresh.k.chandrappa@gmail.com>
---
 drivers/soundwire/cadence_master.c      | 23 +++++++++++------------
 drivers/soundwire/debugfs.c             | 22 +++++++++++-----------
 drivers/soundwire/intel.c               | 17 ++++++++---------
 drivers/soundwire/intel_ace2x_debugfs.c | 12 ++++++------
 4 files changed, 36 insertions(+), 38 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index f367670ea991..555c1cc24ee9 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -317,8 +317,7 @@ EXPORT_SYMBOL(sdw_cdns_config_update_set_wait);
 static ssize_t cdns_sprintf(struct sdw_cdns *cdns,
 			    char *buf, size_t pos, unsigned int reg)
 {
-	return scnprintf(buf + pos, RD_BUF - pos,
-			 "%4x\t%8x\n", reg, cdns_readl(cdns, reg));
+	return sysfs_emit_at(buf, pos, "%4x\t%8x\n", reg, cdns_readl(cdns, reg));
 }
 
 static int cdns_reg_show(struct seq_file *s, void *data)
@@ -332,42 +331,42 @@ static int cdns_reg_show(struct seq_file *s, void *data)
 	if (!buf)
 		return -ENOMEM;
 
-	ret = scnprintf(buf, RD_BUF, "Register  Value\n");
-	ret += scnprintf(buf + ret, RD_BUF - ret, "\nMCP Registers\n");
+	ret = sysfs_emit(buf, "Register  Value\n");
+	ret += sysfs_emit_at(buf, ret, "\nMCP Registers\n");
 	/* 8 MCP registers */
 	for (i = CDNS_MCP_CONFIG; i <= CDNS_MCP_PHYCTRL; i += sizeof(u32))
 		ret += cdns_sprintf(cdns, buf, ret, i);
 
-	ret += scnprintf(buf + ret, RD_BUF - ret,
+	ret += sysfs_emit_at(buf, ret,
 			 "\nStatus & Intr Registers\n");
 	/* 13 Status & Intr registers (offsets 0x70 and 0x74 not defined) */
 	for (i = CDNS_MCP_STAT; i <=  CDNS_MCP_FIFOSTAT; i += sizeof(u32))
 		ret += cdns_sprintf(cdns, buf, ret, i);
 
-	ret += scnprintf(buf + ret, RD_BUF - ret,
+	ret += sysfs_emit_at(buf, ret,
 			 "\nSSP & Clk ctrl Registers\n");
 	ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_SSP_CTRL0);
 	ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_SSP_CTRL1);
 	ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_CLK_CTRL0);
 	ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_CLK_CTRL1);
 
-	ret += scnprintf(buf + ret, RD_BUF - ret,
+	ret += sysfs_emit_at(buf, ret,
 			 "\nDPn B0 Registers\n");
 
 	num_ports = cdns->num_ports;
 
 	for (i = 0; i < num_ports; i++) {
-		ret += scnprintf(buf + ret, RD_BUF - ret,
+		ret += sysfs_emit_at(buf, ret,
 				 "\nDP-%d\n", i);
 		for (j = CDNS_DPN_B0_CONFIG(i);
 		     j < CDNS_DPN_B0_ASYNC_CTRL(i); j += sizeof(u32))
 			ret += cdns_sprintf(cdns, buf, ret, j);
 	}
 
-	ret += scnprintf(buf + ret, RD_BUF - ret,
+	ret += sysfs_emit_at(buf, ret,
 			 "\nDPn B1 Registers\n");
 	for (i = 0; i < num_ports; i++) {
-		ret += scnprintf(buf + ret, RD_BUF - ret,
+		ret += sysfs_emit_at(buf, ret,
 				 "\nDP-%d\n", i);
 
 		for (j = CDNS_DPN_B1_CONFIG(i);
@@ -375,13 +374,13 @@ static int cdns_reg_show(struct seq_file *s, void *data)
 			ret += cdns_sprintf(cdns, buf, ret, j);
 	}
 
-	ret += scnprintf(buf + ret, RD_BUF - ret,
+	ret += sysfs_emit_at(buf, ret,
 			 "\nDPn Control Registers\n");
 	for (i = 0; i < num_ports; i++)
 		ret += cdns_sprintf(cdns, buf, ret,
 				CDNS_PORTCTRL + i * CDNS_PORT_OFFSET);
 
-	ret += scnprintf(buf + ret, RD_BUF - ret,
+	ret += sysfs_emit_at(buf, ret,
 			 "\nPDIn Config Registers\n");
 
 	/* number of PDI and ports is interchangeable */
diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
index c30f571934ee..e7de2cc9681a 100644
--- a/drivers/soundwire/debugfs.c
+++ b/drivers/soundwire/debugfs.c
@@ -41,9 +41,9 @@ static ssize_t sdw_sprintf(struct sdw_slave *slave,
 	value = sdw_read_no_pm(slave, reg);
 
 	if (value < 0)
-		return scnprintf(buf + pos, RD_BUF - pos, "%3x\tXX\n", reg);
+		return sysfs_emit_at(buf, pos, "%3x\tXX\n", reg);
 	else
-		return scnprintf(buf + pos, RD_BUF - pos,
+		return sysfs_emit_at(buf, pos,
 				"%3x\t%2x\n", reg, value);
 }
 
@@ -63,21 +63,21 @@ static int sdw_slave_reg_show(struct seq_file *s_file, void *data)
 		return ret;
 	}
 
-	ret = scnprintf(buf, RD_BUF, "Register  Value\n");
+	ret = sysfs_emit(buf, "Register  Value\n");
 
 	/* DP0 non-banked registers */
-	ret += scnprintf(buf + ret, RD_BUF - ret, "\nDP0\n");
+	ret += sysfs_emit_at(buf, ret, "\nDP0\n");
 	for (i = SDW_DP0_INT; i <= SDW_DP0_PREPARECTRL; i++)
 		ret += sdw_sprintf(slave, buf, ret, i);
 
 	/* DP0 Bank 0 registers */
-	ret += scnprintf(buf + ret, RD_BUF - ret, "Bank0\n");
+	ret += sysfs_emit_at(buf, ret, "Bank0\n");
 	ret += sdw_sprintf(slave, buf, ret, SDW_DP0_CHANNELEN);
 	for (i = SDW_DP0_SAMPLECTRL1; i <= SDW_DP0_LANECTRL; i++)
 		ret += sdw_sprintf(slave, buf, ret, i);
 
 	/* DP0 Bank 1 registers */
-	ret += scnprintf(buf + ret, RD_BUF - ret, "Bank1\n");
+	ret += sysfs_emit_at(buf, ret, "Bank1\n");
 	ret += sdw_sprintf(slave, buf, ret,
 			SDW_DP0_CHANNELEN + SDW_BANK1_OFFSET);
 	for (i = SDW_DP0_SAMPLECTRL1 + SDW_BANK1_OFFSET;
@@ -85,7 +85,7 @@ static int sdw_slave_reg_show(struct seq_file *s_file, void *data)
 		ret += sdw_sprintf(slave, buf, ret, i);
 
 	/* SCP registers */
-	ret += scnprintf(buf + ret, RD_BUF - ret, "\nSCP\n");
+	ret += sysfs_emit_at(buf, ret, "\nSCP\n");
 	for (i = SDW_SCP_INT1; i <= SDW_SCP_BUS_CLOCK_BASE; i++)
 		ret += sdw_sprintf(slave, buf, ret, i);
 	for (i = SDW_SCP_DEVID_0; i <= SDW_SCP_DEVID_5; i++)
@@ -109,18 +109,18 @@ static int sdw_slave_reg_show(struct seq_file *s_file, void *data)
 	for (i = 1; SDW_VALID_PORT_RANGE(i); i++) {
 
 		/* DPi registers */
-		ret += scnprintf(buf + ret, RD_BUF - ret, "\nDP%d\n", i);
+		ret += sysfs_emit_at(buf, ret, "\nDP%d\n", i);
 		for (j = SDW_DPN_INT(i); j <= SDW_DPN_PREPARECTRL(i); j++)
 			ret += sdw_sprintf(slave, buf, ret, j);
 
 		/* DPi Bank0 registers */
-		ret += scnprintf(buf + ret, RD_BUF - ret, "Bank0\n");
+		ret += sysfs_emit_at(buf, ret, "Bank0\n");
 		for (j = SDW_DPN_CHANNELEN_B0(i);
 		     j <= SDW_DPN_LANECTRL_B0(i); j++)
 			ret += sdw_sprintf(slave, buf, ret, j);
 
 		/* DPi Bank1 registers */
-		ret += scnprintf(buf + ret, RD_BUF - ret, "Bank1\n");
+		ret += sysfs_emit_at(buf, ret, "Bank1\n");
 		for (j = SDW_DPN_CHANNELEN_B1(i);
 		     j <= SDW_DPN_LANECTRL_B1(i); j++)
 			ret += sdw_sprintf(slave, buf, ret, j);
@@ -265,7 +265,7 @@ static int read_buffer_show(struct seq_file *s_file, void *data)
 		return -EINVAL;
 
 	for (i = 0; i < num_bytes; i++) {
-		scnprintf(buf, MAX_LINE_LEN, "address %#x val 0x%02x\n",
+		sysfs_emit(buf, "address %#x val 0x%02x\n",
 			  start_addr + i, read_buffer[i]);
 		seq_printf(s_file, "%s", buf);
 	}
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 9db78f3d7615..945dafac8d17 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -65,8 +65,7 @@ static ssize_t intel_sprintf(void __iomem *mem, bool l,
 		value = intel_readl(mem, reg);
 	else
 		value = intel_readw(mem, reg);
-
-	return scnprintf(buf + pos, RD_BUF - pos, "%4x\t%4x\n", reg, value);
+	return sysfs_emit_at(buf, pos, "%4x\t%4x\n", reg, value);
 }
 
 static int intel_reg_show(struct seq_file *s_file, void *data)
@@ -84,8 +83,8 @@ static int intel_reg_show(struct seq_file *s_file, void *data)
 
 	links = intel_readl(s, SDW_SHIM_LCAP) & SDW_SHIM_LCAP_LCOUNT_MASK;
 
-	ret = scnprintf(buf, RD_BUF, "Register  Value\n");
-	ret += scnprintf(buf + ret, RD_BUF - ret, "\nShim\n");
+	ret = sysfs_emit(buf, "Register  Value\n");
+	ret += sysfs_emit_at(buf, ret, "\nShim\n");
 
 	for (i = 0; i < links; i++) {
 		reg = SDW_SHIM_LCAP + i * 4;
@@ -93,7 +92,7 @@ static int intel_reg_show(struct seq_file *s_file, void *data)
 	}
 
 	for (i = 0; i < links; i++) {
-		ret += scnprintf(buf + ret, RD_BUF - ret, "\nLink%d\n", i);
+		ret += sysfs_emit_at(buf, ret, "\nLink%d\n", i);
 		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_CTLSCAP(i));
 		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_CTLS0CM(i));
 		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_CTLS1CM(i));
@@ -101,7 +100,7 @@ static int intel_reg_show(struct seq_file *s_file, void *data)
 		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_CTLS3CM(i));
 		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_PCMSCAP(i));
 
-		ret += scnprintf(buf + ret, RD_BUF - ret, "\n PCMSyCH registers\n");
+		ret += sysfs_emit_at(buf, ret, "\n PCMSyCH registers\n");
 
 		/*
 		 * the value 10 is the number of PDIs. We will need a
@@ -114,17 +113,17 @@ static int intel_reg_show(struct seq_file *s_file, void *data)
 			ret += intel_sprintf(s, false, buf, ret,
 					SDW_SHIM_PCMSYCHC(i, j));
 		}
-		ret += scnprintf(buf + ret, RD_BUF - ret, "\n IOCTL, CTMCTL\n");
+		ret += sysfs_emit_at(buf, ret, "\n IOCTL, CTMCTL\n");
 
 		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_IOCTL(i));
 		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_CTMCTL(i));
 	}
 
-	ret += scnprintf(buf + ret, RD_BUF - ret, "\nWake registers\n");
+	ret += sysfs_emit_at(buf, ret, "\nWake registers\n");
 	ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_WAKEEN);
 	ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_WAKESTS);
 
-	ret += scnprintf(buf + ret, RD_BUF - ret, "\nALH STRMzCFG\n");
+	ret += sysfs_emit_at(buf, ret, "\nALH STRMzCFG\n");
 	for (i = 0; i < SDW_ALH_NUM_STREAMS; i++)
 		ret += intel_sprintf(a, true, buf, ret, SDW_ALH_STRMZCFG(i));
 
diff --git a/drivers/soundwire/intel_ace2x_debugfs.c b/drivers/soundwire/intel_ace2x_debugfs.c
index 206a8d511ebd..c59686ac2cc6 100644
--- a/drivers/soundwire/intel_ace2x_debugfs.c
+++ b/drivers/soundwire/intel_ace2x_debugfs.c
@@ -31,7 +31,7 @@ static ssize_t intel_sprintf(void __iomem *mem, bool l,
 	else
 		value = intel_readw(mem, reg);
 
-	return scnprintf(buf + pos, RD_BUF - pos, "%4x\t%4x\n", reg, value);
+	return sysfs_emit_at(buf, pos, "%4x\t%4x\n", reg, value);
 }
 
 static int intel_reg_show(struct seq_file *s_file, void *data)
@@ -49,8 +49,8 @@ static int intel_reg_show(struct seq_file *s_file, void *data)
 	if (!buf)
 		return -ENOMEM;
 
-	ret = scnprintf(buf, RD_BUF, "Register  Value\n");
-	ret += scnprintf(buf + ret, RD_BUF - ret, "\nShim\n");
+	ret = sysfs_emit(buf, "Register  Value\n");
+	ret += sysfs_emit_at(buf, ret, "\nShim\n");
 
 	ret += intel_sprintf(s, true, buf, ret, SDW_SHIM2_LECAP);
 	ret += intel_sprintf(s, false, buf, ret, SDW_SHIM2_PCMSCAP);
@@ -65,14 +65,14 @@ static int intel_reg_show(struct seq_file *s_file, void *data)
 				SDW_SHIM2_PCMSYCHC(j));
 	}
 
-	ret += scnprintf(buf + ret, RD_BUF - ret, "\nVS CLK controls\n");
+	ret += sysfs_emit_at(buf, ret, "\nVS CLK controls\n");
 	ret += intel_sprintf(vs_s, true, buf, ret, SDW_SHIM2_INTEL_VS_LVSCTL);
 
-	ret += scnprintf(buf + ret, RD_BUF - ret, "\nVS Wake registers\n");
+	ret += sysfs_emit_at(buf, ret, "\nVS Wake registers\n");
 	ret += intel_sprintf(vs_s, false, buf, ret, SDW_SHIM2_INTEL_VS_WAKEEN);
 	ret += intel_sprintf(vs_s, false, buf, ret, SDW_SHIM2_INTEL_VS_WAKESTS);
 
-	ret += scnprintf(buf + ret, RD_BUF - ret, "\nVS IOCTL, ACTMCTL\n");
+	ret += sysfs_emit_at(buf, ret, "\nVS IOCTL, ACTMCTL\n");
 	ret += intel_sprintf(vs_s, false, buf, ret, SDW_SHIM2_INTEL_VS_IOCTL);
 	ret += intel_sprintf(vs_s, false, buf, ret, SDW_SHIM2_INTEL_VS_ACTMCTL);
 
-- 
2.43.0


