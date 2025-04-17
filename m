Return-Path: <linux-kernel+bounces-609448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADF7A92261
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 18:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55A891889621
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 16:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D91347B4;
	Thu, 17 Apr 2025 16:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="UZ8xef+B"
Received: from sonic304-24.consmr.mail.gq1.yahoo.com (sonic304-24.consmr.mail.gq1.yahoo.com [98.137.68.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA9525484F
	for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 16:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.68.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744906321; cv=none; b=M67D42IeARskYSlnhhBEsfs5qRmr4nClCQDr9L/IUVoa8YqkKGPuxbEJdZy/2mz3sf0VVdL+K84EsqcvgVUz6qC0/R62qmWSkZTcJiUnF4u7dliadkq0KlF78OT8t7bwUe1WVDpyt9J08uXGDCATXUrT+Mn3WmVaBi+m//h+xGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744906321; c=relaxed/simple;
	bh=UvqnwqnGdD/9z9EflgvFM/Q+MdhEM2w9jrGuQSyvirA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=r5uhZqL5mcauggl6kGbzgs8OcYz4IlyrT48gaV/2i4YKumBoCqQIDg3T2vBteb2ao6zPvEbKSgZs6VtxHXeKFRCdSBaWncR6Pl5pEQVWYwp2TE6pmQtz0GnvwMAuXqWsN4TAwriIUMWHzFZJ9UMmqm13ZKrynOIiemrKY8ZLo8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=UZ8xef+B; arc=none smtp.client-ip=98.137.68.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1744906319; bh=IdspP1uLAsDPhuzcloYB7Vnh3ih/ScvNYJPeSj4AN28=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=UZ8xef+BqW7Jp3w1OmfkVEWfur92M9ufz8mTchkFC5DdVVCxKM6w1V5mSn2i8TUhtwX3CC94PwCHMENZUaCShJIeMvrveIj2UKLExoEEtO5AdaWcQJtYoje3LguJ7ojY9wpZjLcKEVxjgTUsnlRS7briBgtCDbZ60PwkqVGkC9VCQNR8tJ+06YWvrsccJ9Ntl6+xtNHaycy74IVNcMkmJTEryU6SilB5OiY6fDKNDorxH4zpdhFTULwlGQL+KlRzWvrFPwT/Mho1xCxQP0Eli452k2Jwiu5/qoWxBeh5c8ThibMIw6ylWVmP/HhxuANkXCft6GGVFrPuJ8w1acpJbQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744906319; bh=kBY3HOMYdx+Y/iByZexp43CWORkp70tPjMKxA3vV8om=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=h0RJub2FfSIHq/hf6U5oIugTB2G5xKhjGHAdQe3VJu9vbIED8lOxS2ch/Twg/2Giw11UnWs32x7+AX4tQWe/QbeRUnvGPXZza7hlU/ZsW8yyPWV6gdCsPiiuXbJfTvbgvF1okl4bHS9giUEYjJ2nB8bkCJL669cjtMxGWZDneq9teCyZsWJZIflR32++iG3z44HyEO3TRqLpDd+Itn/wFRQ1o6KBunzvXzF5Q8+uFWK0O4h1V/DsS9Wyz6szpdWQ+H/XwmvK7TobjGfqx2hLt7IYEUy5acMQ2uL6qTP0BclPXKvpAa6Dk8x+WcyFbrLdCu6F7H2eQkp6H2Ty+MFkag==
X-YMail-OSG: 4tVckTQVM1kiawe2eQfdAzLDBiqz3Rqwm6kbKAObdA7Unjx8UZ1OX367ZCmyio1
 5Zks3RXcSynFn8OgsLv4VurIjcpp_ev6b6tUxAcKc1LdErPmMuuG_JIAq_2dk3FyeoepXJbk8_Ia
 uZVuIlec2PlHssdyEd27XOrV4Kq7t92UGj5izG1XR6dfD5uMFPHEvdu5TfU8wLJDX.fBdFhGAd3d
 k8w8ZwaZW81WyN3oJTZ8FUZERFwq1b5oQL_EkK7wZVzVt9o.txsLdmRvbXxNsUU3Xdf_AfP65mUp
 y6G4IRXMw1tuFFQjwUvUx7MVMiPi9jiFxKfefmYDND2SBK7FLoofh_U25.WxeOnAXIllWPs6fo8N
 GLcYb8JAY6mzC5KkXVIVE98UPLhWqra4lU2yf694OgTaas2DUuFy5UIrHlsaFUkDNDju8R.7uPDG
 6PkraCL6Ofg6um2lIT3.BAQfaG29glauSAnEfDvS33ZcA6cn4C09GXhFZs32DJIUt3wiEZgiz28t
 F67GT8J7oH3P_AeBOWclWpTJiwTi6rWOcJ9dD04Qf0JtPLWciMkSDjfikSTFvKgwa9UXLgKQ6S.V
 YVaG06DvKqgQFzXpKFcFURRbWXSk1gKjCUKmXfqXMMbD4CP6eQ1IHOIgWhWBuweWvRWxAD5cfgk6
 YuHS5dAM_4ki8wx7B2zVzDgpfPinzyRCrxSZDLMeLpnC_.hjuYJTiE6t6S9kvx6PHmTlAKGNgmcT
 8yGHo62EHHba0L.5ag2iMHSDlPvXY8SQ14mXiX7dyhLpAJkWE6886kZlUEsfdYDqxKZSRQyoignE
 srm7pZQjMqd.TGvSBSFuG1NFkHZx32dhKpRLg4qmUvCbhqLI3RFtgGsj6Radz576wF47Otj0UsUl
 XP2Yw2g3iNzdI6QXH3v5rfa5zbd8AJn4CMVGW6SYT8BHDtUV5Du6EpEYzXwHuP1BiqLyKJClx75A
 aJisHFnNS7ZZd_LvVCLNanmy0XqlZAK_cth.qdX1H_CbFdw31ZB8pvqlJEcYYsmBU.Yo1eKA9jSj
 ctZKjcfdq7EVpMVO5o0UCD6K9D708SO2LoT7m9PfjRiGIUNoZR3n1rSzEIAqsmEWShPcC0Ch6OYp
 EDXuHNNqm_o8GIHNY.HgjbZFfIay3Vucp0HYSSobvFluQ2btiST7dbR7wTKF6uXldLbz1ftXfFbg
 9Y5yalpPOxKx37xUxariIXzJodMT0EJKIT0qba4N71RUp75eWvI3NupkRg4h9y.5zCLNRvqKitzy
 x4tzwHLG3exsccZM2xTT1kQ_NLqxdTUuzBKiZK_Z9ea8kEqZfYs20Txo60kcePSEF2UwhHPnkNNV
 TlY.eFxLqzdV2G32t4cu3QF7JFjaVF0_6_L6TG5zVZ.n7lqEYs3IUg4Z_xD9UpWG2493B7ks0RR1
 KEIW7I6S_FASdgm699F48UYfXf2ktcpYdGbbpyN7TQFhMkPjGU8eBzHPzA5u3QEqEEyi4O_G89wq
 FsIV7f1N_e.gW4WPbPGWzcKRTS4m9AMpSQzrKZH8.Y89LEIvvqBXmskYi2wRdSnEuBUx5n80FyUq
 LyycTviYuNrzxzlHyyoCYnqko.Z5KQzBDpHMwNkGi6mYIpBlcdnH7xhT2_Zm0cvuCC9gBrkvGaeK
 rPlLzPfGI0XzooiRiiDr8Ll7kLRt0khJwRfvNQJE3xrBOcHus8CSpA59AYpQ97PoBtiFP0XHF.cQ
 q9cJW5qpkItu2hJfVt4vqFaR_GZpuotb8.EZiAJNfld0EQ.OFxSCqR_fdkqksLGN2i3rYpO232s6
 8A9ylYsS0GpMToar.7.FEfVc7S1m6tTWKNzgrLM7YWGIxFqASoqongrQRPwOJSzb05JXqWefHEVz
 Y645glPSC5l0aEDrCXmHtxFtjT5h50HGGdjIFpBDH8qTi1pK7xGkgMMg5dRUfPVFQx8dyQQWOifX
 bZTLsRMtUE9M6xSNS9cAowyXAksNJ5AK29XOCwPoUdiLAyXGH5SJ5ovIUEyC2k.n2uJQJhQDMl9r
 EF.ELkxHBDWgttqQE2wgS6Zu197TaRdp.oQEbDu7eW3obRK.Nl7vSLLklGP5qseKQvHkezC_xn3H
 QUd0H2Vi374uV1uXm9Y98Cj2x0tlQFS2mNQJbKQI5fVCJb1PYt2Mo_5dt.ySVXzTA8ijHjyk23mS
 Bq9wvPOM8NBm2P0j0kTRLUK2E6TGRdZpfL10m4KXQvlysrUVqx2PjkanRzZg2H0k3EloM_Bit6Fz
 6ZjqsEARgMY1u0zFzJTPkwzQRISUUZVi9DkE0_hmOX6zddhom_FdYeCRmG_xtV0MaKLvzzstcLlG
 LnhU1bA--
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: df3badcd-dd4f-4c1a-bbea-060f06b558e8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.gq1.yahoo.com with HTTP; Thu, 17 Apr 2025 16:11:59 +0000
Received: by hermes--production-ir2-858bd4ff7b-8nkx2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a4dccec8c978f5f5395780c77064ab33;
          Thu, 17 Apr 2025 15:31:28 +0000 (UTC)
From: Ruben Wauters <rubenru09@aol.com>
To: Greg Korah-Hartman <gregkh@linuxfoundation.org>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Cc: Ruben Wauters <rubenru09@aol.com>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: sm750fb: fix instances of camel case
Date: Thu, 17 Apr 2025 16:27:47 +0100
Message-ID: <20250417153101.353645-1-rubenru09@aol.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250417153101.353645-1-rubenru09.ref@aol.com>

As per the kernel style guidelines, and as reported by checkpatch.pl,
replaced instances of camel case with snake_case where appropriate and
aligned names in the header with those in the c file.

Signed-off-by: Ruben Wauters <rubenru09@aol.com>
---
 drivers/staging/sm750fb/ddk750_sii164.c | 113 ++++++++++++------------
 drivers/staging/sm750fb/ddk750_sii164.h |  26 +++---
 2 files changed, 69 insertions(+), 70 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index 89700fc5dd2e..20c2f386220c 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -12,11 +12,11 @@
 #define USE_HW_I2C
 
 #ifdef USE_HW_I2C
-    #define i2cWriteReg sm750_hw_i2c_write_reg
-    #define i2cReadReg  sm750_hw_i2c_read_reg
+    #define I2C_WRITE_REG sm750_hw_i2c_write_reg
+    #define I2C_READ_REG  sm750_hw_i2c_read_reg
 #else
-    #define i2cWriteReg sm750_sw_i2c_write_reg
-    #define i2cReadReg  sm750_sw_i2c_read_reg
+    #define I2C_WRITE_REG sm750_sw_i2c_write_reg
+    #define I2C_READ_REG  sm750_sw_i2c_read_reg
 #endif
 
 /* SII164 Vendor and Device ID */
@@ -25,7 +25,7 @@
 
 #ifdef SII164_FULL_FUNCTIONS
 /* Name of the DVI Controller chip */
-static char *gDviCtrlChipName = "Silicon Image SiI 164";
+static char *dvi_controller_chip_name = "Silicon Image SiI 164";
 #endif
 
 /*
@@ -37,14 +37,14 @@ static char *gDviCtrlChipName = "Silicon Image SiI 164";
  */
 unsigned short sii164_get_vendor_id(void)
 {
-	unsigned short vendorID;
+	unsigned short vendor;
 
-	vendorID = ((unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
+	vendor = ((unsigned short)I2C_READ_REG(SII164_I2C_ADDRESS,
 					       SII164_VENDOR_ID_HIGH) << 8) |
-		   (unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
-					      SII164_VENDOR_ID_LOW);
+		  (unsigned short)I2C_READ_REG(SII164_I2C_ADDRESS,
+					       SII164_VENDOR_ID_LOW);
 
-	return vendorID;
+	return vendor;
 }
 
 /*
@@ -56,14 +56,14 @@ unsigned short sii164_get_vendor_id(void)
  */
 unsigned short sii164_get_device_id(void)
 {
-	unsigned short device_id;
+	unsigned short device;
 
-	device_id = ((unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
+	device = ((unsigned short)I2C_READ_REG(SII164_I2C_ADDRESS,
 					       SII164_DEVICE_ID_HIGH) << 8) |
-		   (unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
-					      SII164_DEVICE_ID_LOW);
+		  (unsigned short)I2C_READ_REG(SII164_I2C_ADDRESS,
+					       SII164_DEVICE_ID_LOW);
 
-	return device_id;
+	return device;
 }
 
 /*
@@ -176,7 +176,7 @@ long sii164_init_chip(unsigned char edge_select,
 		else
 			config |= SII164_CONFIGURATION_VSYNC_AS_IS;
 
-		i2cWriteReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
+		I2C_WRITE_REG(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
 
 		/*
 		 * De-skew enabled with default 111b value.
@@ -214,7 +214,7 @@ long sii164_init_chip(unsigned char edge_select,
 			config |= SII164_DESKEW_8_STEP;
 			break;
 		}
-		i2cWriteReg(SII164_I2C_ADDRESS, SII164_DESKEW, config);
+		I2C_WRITE_REG(SII164_I2C_ADDRESS, SII164_DESKEW, config);
 
 		/* Enable/Disable Continuous Sync. */
 		if (continuous_sync_enable == 0)
@@ -231,12 +231,12 @@ long sii164_init_chip(unsigned char edge_select,
 		/* Set the PLL Filter value */
 		config |= ((pll_filter_value & 0x07) << 1);
 
-		i2cWriteReg(SII164_I2C_ADDRESS, SII164_PLL, config);
+		I2C_WRITE_REG(SII164_I2C_ADDRESS, SII164_PLL, config);
 
 		/* Recover from Power Down and enable output. */
-		config = i2cReadReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION);
+		config = I2C_READ_REG(SII164_I2C_ADDRESS, SII164_CONFIGURATION);
 		config |= SII164_CONFIGURATION_POWER_NORMAL;
-		i2cWriteReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
+		I2C_WRITE_REG(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
 
 		return 0;
 	}
@@ -269,7 +269,7 @@ void sii164_reset_chip(void)
  */
 char *sii164_get_chip_string(void)
 {
-	return gDviCtrlChipName;
+	return dvi_controller_chip_name;
 }
 
 /*
@@ -277,55 +277,55 @@ char *sii164_get_chip_string(void)
  *      This function sets the power configuration of the DVI Controller Chip.
  *
  *  Input:
- *      powerUp - Flag to set the power down or up
+ *      power - Flag to set the power down or up
  */
-void sii164_set_power(unsigned char powerUp)
+void sii164_set_power(unsigned char power)
 {
 	unsigned char config;
 
-	config = i2cReadReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION);
-	if (powerUp == 1) {
+	config = I2C_READ_REG(SII164_I2C_ADDRESS, SII164_CONFIGURATION);
+	if (power == 1) {
 		/* Power up the chip */
 		config &= ~SII164_CONFIGURATION_POWER_MASK;
 		config |= SII164_CONFIGURATION_POWER_NORMAL;
-		i2cWriteReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
+		I2C_WRITE_REG(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
 	} else {
 		/* Power down the chip */
 		config &= ~SII164_CONFIGURATION_POWER_MASK;
 		config |= SII164_CONFIGURATION_POWER_DOWN;
-		i2cWriteReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
+		I2C_WRITE_REG(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
 	}
 }
 
 /*
- *  sii164SelectHotPlugDetectionMode
+ *  sii164_select_hot_plug_detection_mode
  *      This function selects the mode of the hot plug detection.
  */
 static
-void sii164SelectHotPlugDetectionMode(enum sii164_hot_plug_mode hotPlugMode)
+void sii164_select_hot_plug_detection_mode(enum sii164_hot_plug_mode hot_plug_mode)
 {
-	unsigned char detectReg;
+	unsigned char detect_reg;
 
-	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) &
+	detect_reg = I2C_READ_REG(SII164_I2C_ADDRESS, SII164_DETECT) &
 		    ~SII164_DETECT_MONITOR_SENSE_OUTPUT_FLAG;
-	switch (hotPlugMode) {
+	switch (hot_plug_mode) {
 	case SII164_HOTPLUG_DISABLE:
-		detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_HIGH;
+		detect_reg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_HIGH;
 		break;
 	case SII164_HOTPLUG_USE_MDI:
-		detectReg &= ~SII164_DETECT_INTERRUPT_MASK;
-		detectReg |= SII164_DETECT_INTERRUPT_BY_HTPLG_PIN;
-		detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_MDI;
+		detect_reg &= ~SII164_DETECT_INTERRUPT_MASK;
+		detect_reg |= SII164_DETECT_INTERRUPT_BY_HTPLG_PIN;
+		detect_reg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_MDI;
 		break;
 	case SII164_HOTPLUG_USE_RSEN:
-		detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_RSEN;
+		detect_reg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_RSEN;
 		break;
 	case SII164_HOTPLUG_USE_HTPLG:
-		detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_HTPLG;
+		detect_reg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_HTPLG;
 		break;
 	}
 
-	i2cWriteReg(SII164_I2C_ADDRESS, SII164_DETECT, detectReg);
+	I2C_WRITE_REG(SII164_I2C_ADDRESS, SII164_DETECT, detect_reg);
 }
 
 /*
@@ -336,17 +336,18 @@ void sii164SelectHotPlugDetectionMode(enum sii164_hot_plug_mode hotPlugMode)
  */
 void sii164_enable_hot_plug_detection(unsigned char enable_hot_plug)
 {
-	unsigned char detectReg;
+	unsigned char detect_reg;
 
-	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT);
+	detect_reg = I2C_READ_REG(SII164_I2C_ADDRESS, SII164_DETECT);
 
-	/* Depending on each DVI controller, need to enable the hot plug based
+	/*
+	 * Depending on each DVI controller, need to enable the hot plug based
 	 * on each individual chip design.
 	 */
 	if (enable_hot_plug != 0)
-		sii164SelectHotPlugDetectionMode(SII164_HOTPLUG_USE_MDI);
+		sii164_select_hot_plug_detection_mode(SII164_HOTPLUG_USE_MDI);
 	else
-		sii164SelectHotPlugDetectionMode(SII164_HOTPLUG_DISABLE);
+		sii164_select_hot_plug_detection_mode(SII164_HOTPLUG_DISABLE);
 }
 
 /*
@@ -359,11 +360,11 @@ void sii164_enable_hot_plug_detection(unsigned char enable_hot_plug)
  */
 unsigned char sii164_is_connected(void)
 {
-	unsigned char hotPlugValue;
+	unsigned char hot_plug;
 
-	hotPlugValue = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) &
-		       SII164_DETECT_HOT_PLUG_STATUS_MASK;
-	if (hotPlugValue == SII164_DETECT_HOT_PLUG_STATUS_ON)
+	hot_plug = I2C_READ_REG(SII164_I2C_ADDRESS, SII164_DETECT) &
+				SII164_DETECT_HOT_PLUG_STATUS_MASK;
+	if (hot_plug == SII164_DETECT_HOT_PLUG_STATUS_ON)
 		return 1;
 	else
 		return 0;
@@ -379,11 +380,11 @@ unsigned char sii164_is_connected(void)
  */
 unsigned char sii164_check_interrupt(void)
 {
-	unsigned char detectReg;
+	unsigned char detect_reg;
 
-	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) &
-		    SII164_DETECT_MONITOR_STATE_MASK;
-	if (detectReg == SII164_DETECT_MONITOR_STATE_CHANGE)
+	detect_reg = I2C_READ_REG(SII164_I2C_ADDRESS, SII164_DETECT) &
+				  SII164_DETECT_MONITOR_STATE_MASK;
+	if (detect_reg == SII164_DETECT_MONITOR_STATE_CHANGE)
 		return 1;
 	else
 		return 0;
@@ -395,12 +396,12 @@ unsigned char sii164_check_interrupt(void)
  */
 void sii164_clear_interrupt(void)
 {
-	unsigned char detectReg;
+	unsigned char detect_reg;
 
 	/* Clear the MDI interrupt */
-	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT);
-	i2cWriteReg(SII164_I2C_ADDRESS, SII164_DETECT,
-		    detectReg | SII164_DETECT_MONITOR_STATE_CLEAR);
+	detect_reg = I2C_READ_REG(SII164_I2C_ADDRESS, SII164_DETECT);
+	I2C_WRITE_REG(SII164_I2C_ADDRESS, SII164_DETECT,
+		      detect_reg | SII164_DETECT_MONITOR_STATE_CLEAR);
 }
 
 #endif
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index ebc173658f0e..028327816f7f 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -16,16 +16,16 @@ enum sii164_hot_plug_mode {
 };
 
 /* Silicon Image SiI164 chip prototype */
-long sii164_init_chip(unsigned char edgeSelect,
-		      unsigned char busSelect,
-		      unsigned char dualEdgeClkSelect,
-		      unsigned char hsyncEnable,
-		      unsigned char vsyncEnable,
-		      unsigned char deskewEnable,
-		      unsigned char deskewSetting,
-		      unsigned char continuousSyncEnable,
-		      unsigned char pllFilterEnable,
-		      unsigned char pllFilterValue);
+long sii164_init_chip(unsigned char edge_select,
+		      unsigned char bus_select,
+		      unsigned char dual_edge_clk_select,
+		      unsigned char hsync_enable,
+		      unsigned char vsync_enable,
+		      unsigned char deskew_enable,
+		      unsigned char deskew_setting,
+		      unsigned char continuous_sync_enable,
+		      unsigned char pll_filter_enable,
+		      unsigned char pll_filter_value);
 
 unsigned short sii164_get_vendor_id(void);
 unsigned short sii164_get_device_id(void);
@@ -33,7 +33,7 @@ unsigned short sii164_get_device_id(void);
 #ifdef SII164_FULL_FUNCTIONS
 void sii164_reset_chip(void);
 char *sii164_get_chip_string(void);
-void sii164_set_power(unsigned char powerUp);
+void sii164_set_power(unsigned char power);
 void sii164_enable_hot_plug_detection(unsigned char enable_hot_plug);
 unsigned char sii164_is_connected(void);
 unsigned char sii164_check_interrupt(void);
@@ -96,9 +96,7 @@ void sii164_clear_interrupt(void);
 #define SII164_CONFIGURATION_VSYNC_FORCE_LOW        0x00
 #define SII164_CONFIGURATION_VSYNC_AS_IS            0x20
 
-/*
- * Detection registers
- */
+/* Detection registers */
 #define SII164_DETECT                               0x09
 
 /* Monitor Detect Interrupt (MDI) */
-- 
2.45.2


