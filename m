Return-Path: <linux-kernel+bounces-728520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A36B02962
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 06:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8973B71AF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 04:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA691F8BA6;
	Sat, 12 Jul 2025 04:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBRfS+bO"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30E41F418B;
	Sat, 12 Jul 2025 04:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752295407; cv=none; b=BOE14wha4uucH8qNOySCAz9FeVBeCakOpOewW7Hdp9P3+PdvTBQhifVvGKrsjZj+rblPguHrRIP1NO6NWAnUFJvOFfSxp8xLDu+lOxhJNncgYrYb/mU63oIxNC/FK8pbA6MdKQeGD4YYRETxhetqEYPWBilDHhoQrctLDBES4+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752295407; c=relaxed/simple;
	bh=YX1tTIv7h97r6dYWf4jCPFMrqE3ihA1uQrM5xBqYQqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kI5tG23i4FJp3EI0E2uOFdKzNNkMY0B/BJSeP0SGgESdx3W5j4CJ/kYt6qLnXa4lZRsGP+MrUwqPz+q9Px12I+OPnucgq9wtoePhATnEe6B6kks6BOWDes302fe9NtPjukE/u/HwMtJmBIzpxKMSs9vt7U9KEmvdkqGkcYmHV/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBRfS+bO; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2350b1b9129so20452025ad.0;
        Fri, 11 Jul 2025 21:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752295395; x=1752900195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=389ubXDWjSsBgW6cSsbIZL+y0UMtvyOFSOtKGJNoZUg=;
        b=TBRfS+bOLLVHmVK/kTReZhIyZQhvfe6QU038isQ+kA3ORSmbJNM1iHuFtwEzzZ8YTN
         aBj0QMUU/XtjwlDFXtpuKHDShQqCSQQM0gDGtuuYBeOGG+n6IU+8N1n2wWbXtrzOe4rF
         VCI8vGgN0M5PPzGq+0S14JvWsGJVNSYp+5cuB+4YjLZnUN/l1XjW1nsghhrU0iQSMvoV
         z68COgPROwyoKE8JOabOLVXBcagom2mNQZXQ1mqul5GAK3hV58p4101WTgaonUcHqYZ9
         PjLtIsC0K/PZc+hxmYHAd3S4BLse1LamUOSZ601ZpsSUtQt2dxpXa50F3zKI2OjBuSOP
         44Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752295395; x=1752900195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=389ubXDWjSsBgW6cSsbIZL+y0UMtvyOFSOtKGJNoZUg=;
        b=lLgZHqXMHPYI+oRWNNVlpjkWW2L52buzU5wbGvP4+sQ1vaX/2kZgQmQB6hLpuHfs88
         eAVNz5CjyIIZ7Bfil9jSi3O8MGDxDTAqE+mNf+ijwZEsv4s1J1NHmzpMLuSTnafpyt+7
         fHAXoRZyj7FkYTiyA1HS6Ialu37MmTc0OT9U6hG9K1FrzS6/0k6RgrE5fCQMvvO2ewAc
         QC0LtK6+dpEssRrYV9eU9As1mxW1QKE6xFxuU2fVvp5e9KSvKMygse9MvX1TnsbtH2gS
         KZ3R3XTStgG5MC3RteCg2CC9RgXirPZ1cg1tGSI3RWCCg6jlrD8x6K71fl5E90AdckXr
         pwMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp69h+gBhDGvi3/jpf9MGns0CJCeiqadoLm8qxiwtJ3yrD5HatBzxAoXQvn1OAhJitDexBtdeORttlIOs=@vger.kernel.org, AJvYcCVCH42UQSUWEHrt5Vp7DvfrJ3uCaWY8YzmwuQ2zzbnzXoV6dR/2MPTwMXmGwuTCQYu1q0WVfm8s4ZcnJOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YztaTv7y3fgW+6CJIrjCfXk08Y7lR/gOz43UC7p4fpXVbOGWhgO
	WK8fcBTpOKt8XCg0YNLImtE859Y/0fH8slTFrIjHRKAEdLfnxQCfFbs+5h11pS2Q
X-Gm-Gg: ASbGncvqIX4baMcnf//r0kqMvepCjy9CWghTNNtuZ7ipIdnLVGJxQ3bzQB/1+SM4u/3
	6dGxIAB+Y+IB+fX5U2tfJ5YqNanBlHFvcjRbohvDaBU6LuwTrpzoTVby4/8Cn01Hxro1YpJCTBn
	zUm3OQi8cfZmO3AzUqUvcGwsmQ0uHX34x15YyrSVRPREGcoSHJFgtcnrgLBWmU3YCrx+ZS0npdz
	rgXHAZF/CLSmGoyjn+6FtHdSGzGZybHF3E1MQnesXNvkFHXnjfjSzMJxNb8Cbocq6OsX+TRcrDP
	pYjc178L5pLo0PvynRmj7gvQ6uXFmvfsOkUDjy/y4EwT95MDbAnsxsgxhe70WOvBykZ2jXEYhkF
	Pm3pem3J0PdKvjZcwcMcuK6g=
X-Google-Smtp-Source: AGHT+IEiH8GsTJYPn3mNQMbGTw2Cokc7ryrlujn1TJFFFF0pOvrulOmd16qE0gZzSYQy54IXmzYoCg==
X-Received: by 2002:a17:903:4511:b0:235:ed02:288b with SMTP id d9443c01a7336-23dee0b4b31mr64088955ad.30.1752295394197;
        Fri, 11 Jul 2025 21:43:14 -0700 (PDT)
Received: from skc-Dell-Pro-16-Plus-PB16250.. ([132.237.156.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4286b4asm62256365ad.46.2025.07.11.21.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 21:43:13 -0700 (PDT)
From: Suresh K C <suresh.k.chandrappa@gmail.com>
X-Google-Original-From: Suresh K C
To: vkoul@kernel.org,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	sanyog.r.kale@intel.com
Cc: shuah@kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Suresh K C <suresh.k.chandrappa@gmail.com>
Subject: [PATCH] soundwire: replace scnprintf() with sysfs_emit() for sysfs consistency
Date: Sat, 12 Jul 2025 10:13:02 +0530
Message-ID: <20250712044302.6952-1-suresh.k.chandrappa@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Suresh K C <suresh.k.chandrappa@gmail.com>

Replace scnprintf() with sysfs_emit() or sysfs_emit_at() in SoundWire driver files
to align with the guidelines outlined in Documentation/filesystems/sysfs.rst.

This change improves the safety and correctness of sysfs attribute handling,
ensures consistency across the kernel codebase, and simplifies future maintenance.

Tested by enabling CONFIG_DEBUG_FS and confirming that /sys/kernel/debug/soundwire is correctly populated

Signed-off-by: Suresh K C <suresh.k.chandrappa@gmail.com>
---
 drivers/soundwire/cadence_master.c      | 23 +++++++++++------------
 drivers/soundwire/debugfs.c             | 22 +++++++++++-----------
 drivers/soundwire/intel.c               | 17 ++++++++---------
 drivers/soundwire/intel_ace2x_debugfs.c | 14 +++++++-------
 4 files changed, 37 insertions(+), 39 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 21bb491d026b..668a111c66c8 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -319,8 +319,7 @@ EXPORT_SYMBOL(sdw_cdns_config_update_set_wait);
 static ssize_t cdns_sprintf(struct sdw_cdns *cdns,
 			    char *buf, size_t pos, unsigned int reg)
 {
-	return scnprintf(buf + pos, RD_BUF - pos,
-			 "%4x\t%8x\n", reg, cdns_readl(cdns, reg));
+	return sysfs_emit_at(buf, pos,"%4x\t%8x\n", reg, cdns_readl(cdns, reg));
 }
 
 static int cdns_reg_show(struct seq_file *s, void *data)
@@ -334,42 +333,42 @@ static int cdns_reg_show(struct seq_file *s, void *data)
 	if (!buf)
 		return -ENOMEM;
 
-	ret = scnprintf(buf, RD_BUF, "Register  Value\n");
-	ret += scnprintf(buf + ret, RD_BUF - ret, "\nMCP Registers\n");
+	ret = sysfs_emit(buf, "Register  Value\n");
+	ret += sysfs_emit_at(buf, ret,"\nMCP Registers\n");
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
@@ -377,13 +376,13 @@ static int cdns_reg_show(struct seq_file *s, void *data)
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
index 3099ea074f10..ccc98f449658 100644
--- a/drivers/soundwire/debugfs.c
+++ b/drivers/soundwire/debugfs.c
@@ -42,9 +42,9 @@ static ssize_t sdw_sprintf(struct sdw_slave *slave,
 	value = sdw_read_no_pm(slave, reg);
 
 	if (value < 0)
-		return scnprintf(buf + pos, RD_BUF - pos, "%3x\tXX\n", reg);
+		return sysfs_emit_at(buf , pos, "%3x\tXX\n", reg);
 	else
-		return scnprintf(buf + pos, RD_BUF - pos,
+		return sysfs_emit_at(buf , pos,
 				"%3x\t%2x\n", reg, value);
 }
 
@@ -64,21 +64,21 @@ static int sdw_slave_reg_show(struct seq_file *s_file, void *data)
 		return ret;
 	}
 
-	ret = scnprintf(buf, RD_BUF, "Register  Value\n");
+	ret = sysfs_emit(buf, "Register  Value\n");
 
 	/* DP0 non-banked registers */
-	ret += scnprintf(buf + ret, RD_BUF - ret, "\nDP0\n");
+	ret += sysfs_emit_at(buf , ret, "\nDP0\n");
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
@@ -86,7 +86,7 @@ static int sdw_slave_reg_show(struct seq_file *s_file, void *data)
 		ret += sdw_sprintf(slave, buf, ret, i);
 
 	/* SCP registers */
-	ret += scnprintf(buf + ret, RD_BUF - ret, "\nSCP\n");
+	ret += sysfs_emit_at(buf, ret, "\nSCP\n");
 	for (i = SDW_SCP_INT1; i <= SDW_SCP_BUS_CLOCK_BASE; i++)
 		ret += sdw_sprintf(slave, buf, ret, i);
 	for (i = SDW_SCP_DEVID_0; i <= SDW_SCP_DEVID_5; i++)
@@ -110,18 +110,18 @@ static int sdw_slave_reg_show(struct seq_file *s_file, void *data)
 	for (i = 1; SDW_VALID_PORT_RANGE(i); i++) {
 
 		/* DPi registers */
-		ret += scnprintf(buf + ret, RD_BUF - ret, "\nDP%d\n", i);
+		ret += sysfs_emit_at(buf , ret, "\nDP%d\n", i);
 		for (j = SDW_DPN_INT(i); j <= SDW_DPN_PREPARECTRL(i); j++)
 			ret += sdw_sprintf(slave, buf, ret, j);
 
 		/* DPi Bank0 registers */
-		ret += scnprintf(buf + ret, RD_BUF - ret, "Bank0\n");
+		ret += sysfs_emit_at(buf , ret, "Bank0\n");
 		for (j = SDW_DPN_CHANNELEN_B0(i);
 		     j <= SDW_DPN_LANECTRL_B0(i); j++)
 			ret += sdw_sprintf(slave, buf, ret, j);
 
 		/* DPi Bank1 registers */
-		ret += scnprintf(buf + ret, RD_BUF - ret, "Bank1\n");
+		ret += sysfs_emit_at(buf , ret, "Bank1\n");
 		for (j = SDW_DPN_CHANNELEN_B1(i);
 		     j <= SDW_DPN_LANECTRL_B1(i); j++)
 			ret += sdw_sprintf(slave, buf, ret, j);
@@ -317,7 +317,7 @@ static int read_buffer_show(struct seq_file *s_file, void *data)
 		return -EINVAL;
 
 	for (i = 0; i < num_bytes; i++) {
-		scnprintf(buf, MAX_LINE_LEN, "address %#x val 0x%02x\n",
+		sysfs_emit(buf, "address %#x val 0x%02x\n",
 			  start_addr + i, read_buffer[i]);
 		seq_printf(s_file, "%s", buf);
 	}
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 9db78f3d7615..aa7aa7126c47 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -65,8 +65,7 @@ static ssize_t intel_sprintf(void __iomem *mem, bool l,
 		value = intel_readl(mem, reg);
 	else
 		value = intel_readw(mem, reg);
-
-	return scnprintf(buf + pos, RD_BUF - pos, "%4x\t%4x\n", reg, value);
+	return sysfs_emit_at(buf, pos, "%4x\t%4x\n", reg, value);; 
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
index fda8f0daaa96..c733d455af6c 100644
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
@@ -65,19 +65,19 @@ static int intel_reg_show(struct seq_file *s_file, void *data)
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
 
 	if (sdw->link_res->mic_privacy) {
-		ret += scnprintf(buf + ret, RD_BUF - ret, "\nVS PVCCS\n");
+		ret += sysfs_emit_at(buf, ret, "\nVS PVCCS\n");
 		ret += intel_sprintf(vs_s, false, buf, ret,
 				     SDW_SHIM2_INTEL_VS_PVCCS);
 	}
-- 
2.43.0


