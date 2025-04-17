Return-Path: <linux-kernel+bounces-609780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D49A92B8D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 21:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162B18A4615
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 19:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FBB1F91E3;
	Thu, 17 Apr 2025 19:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="iZqKjfnk"
Received: from sonic316-54.consmr.mail.gq1.yahoo.com (sonic316-54.consmr.mail.gq1.yahoo.com [98.137.69.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA981F585C
	for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 19:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.69.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744917227; cv=none; b=SGyVzUI9lzFJ11MoasyXi9vPbaLW8VsIgp4nmI5sTv7gZd64SmVshoWaXhbqX05IoE/miRFWa+4Pyn9rSWIXnOmy9vBLk9WZKfvpl2/VFGuibLprJ6kODZohYUTSKoSGkZ0sxV/iMHpqyP05+7JxkZdmV1QPxKhg2U2sjzuWd6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744917227; c=relaxed/simple;
	bh=l+faO+RgsbGAeTKrc0X2D9Jjpr9SfV8kocsGn6s2wdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eq0odp54clsQLmdXv/KeC1f1YEakE+BuHwVjfCnkg86p3o2p5lDB43HgWArtb9b3tGEoNUFs+jDhyyd6H+9sp5W80BdHx4uTZJIP57fLIaVB7pvRDN69HZd1vy3amOyMxvn6Y/joy/JYfjPEFluOcrZwcc96sfvjzlHs5Y0fe3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=iZqKjfnk; arc=none smtp.client-ip=98.137.69.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1744917226; bh=tviXDqZ3qgAM4ss81QBX4Z4ntCgva3sRNImNRAnb3Ac=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=iZqKjfnkn/l7tylikZIC05vVQa3tTpP3pHzaEIwadHdxHJ5kV7pYSFpBYB8R+BZAcT98EaDvVQ7wAHA4ZBG86WwWNPYG35EYtY8WP0E/PDsnZjT+erT1E4Y5KZ/4vK56kC845bf3Gs+8SrNX8ch+ei2YzKQemFLEYWcqKXUWT4DjxHimZAZfR6VHAY8asam3/IHXZGVC/klsPU2gQKs9SxaBIzcrrzZHmsqMdwi6zgcpgrGu0/IC3qctP5PtQfrywjZuVR2TsKDoyD3gBPY4QQGu+EvSgQZhcheRm7xsJ+75SEwKQUG9KPLXSkhAY5fM/Ts1gBSWKE9+GzO2XLbnqQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744917226; bh=pkrpMg8p2HhY//jzutMB6bAvwmlyxci74EkWV4E/JNQ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=VHhE0od4ZoJwlX5cIR4x7iw70VNaGTNkP+7vOseT4tQGEN6BVJLK87e4tA8X22I1Itbdpd0vjnmtqB9kXrz8ZbT/Dyd3+qbE3usxV0Q+wS0GOq4lfNX8D7aqFoHSRBPJQ+iUR9Lcjtsa1b1qtImAgkNhJRdwzOLcgHawowjiY4SqiQfzU4jR9AkoWGLLv72G1jECYDx7tMSQlpUjjTFQjEyHS56hheyDVx2tjAGyUzqhLslxMqPF4xDWfxOG/EsuBNQN5JDtkLwDPDOEU59Gh/TTQDn1rDGJ18KcRgmgML+lL3FJtN68P4YAs/AOibZHbF8wWF9w3IkreSaWFJ6WRQ==
X-YMail-OSG: rHms8LQVM1kMnFCLH01LtvprEuoyScfccxV891YyvBDVpR27PvO6sZlIInSsn1J
 Cj6PCG1NxJHsoqgSC73lpO5atacUABAm4iAuxcWYySdpNtgqAjfy9ZR8YHZTxpILA.6rn_aZqjgF
 GHZDTu8Qkh9JEh1j5V_9bK..UhFOo9QeQE5CFYw0BZIuJq181TDwr9ZprwAFsl5aiQ0B359pBWKs
 tVd42bXHXkqGW3mdq9LRGBRHmCnYfdpmSpRBf9Uu4vamqRaByZMZ2l7A_jd_rH1u294IVvPNT.L5
 MqAW9EnvSX2VcMaLt8a6FczDerWlKtYEEXClLoE2zUwuqu.xRITHnxc13tEF7eRSkltMhdBwCl7A
 fpaC2e26bqxvn2KBX8Vg9jMJYH45Zs7lt2vn_e65x8IRa9YnuoVgOw6eBYFAzgBywMarJh16vwGt
 X8ticGBuM9Yk78pei7b43RHS6.YgB_3ZP_a4khpeYwskHQByRX7LP7SKlcjibixznV0gUZvvbF.F
 GXeunmasYwPtEYIqbL75g3LYoUCOkZWl9uzjFzWx.Yyxlxp8ovhhZLDLluKOj_oPVgUUbRGVXFVK
 TXDXzA7f7pRqG.GS1IAF0hqp722SvJp2msj.BMW.c_Gg9Fzh5Warlawd1B6PYYBnWZoOrSWrAFCg
 cTDSvb10RtpVYVoRAOpkNy11HqEfVQI0ZJeW6tiUdM.VtCtz_qrCJQmaMMZqMT5ReJ3FnaVOUh9Y
 2lHKZpqWSZPEALDRYfpJ9ES9WIo2GrJF5n3QF8VyPzRBjMVRYIXc.iJNAG0Fx9uF89xkQIvMuKko
 Y4xpz2GiX.ZEntjg51AbymhQ4ziI_dDbM_AmAemQk9eT3qFJ2ZnqZY00LMf7Xo1NtEWuS0e5dDSl
 moUDEKg0MqAgBIgkcxi1a0vIGWQkxBlhIc77j5vQ4FX4JQV_yoq31e8RSLmmfcDU9WElYb9QbpfS
 JIeXsY0wUPOVg38cR1Moa8ojjL2WBfST6iK9kd2tYdOSvwVlekAee2Ijs1lBzQxW1KpgNmOA88pt
 6g6rjN5limOvS8iqecOa20aBjAgkBrcfd76xqRzv2tH._oC_xJlcW2yPIhvY4wzHqWeHRuOey3iy
 DEcSB00e2SiMvycqzqS3kwNyE5rana7bZvEQXBbIgxzyb5bMjhVtIBjUL1rvwZ40X5KGBxyZpVNV
 hO.p2u2xOlD1i.p0HPkKdhf0l5aifL7_fV2oMvP5lTvjvInzF1SwNALKk3fPlgO1PAfExOwsaZnb
 j30r2zeQpZQK4ecwutuvbwvSDlXrRgzYj4fz1dTbnzCxLb6tG6EcO.ABXMNUz2XqCfoOg_0grqqH
 URhJpYtqGrvgMODWy0RTI2LJpoIS4QlDCoZL37yvZ57kSqSgE.TaEeCvIFYiI21910IuK5KovE4x
 fCi77530HCFGSzrCEP_YzySHZWe6HUuAmC_XpNkQCCepPFg_bzs3uEW.WlkmWbY3JiRfyMCM74hX
 AN3wRVvEbeLG0jhnNP9MVjfKSEu8YCtIjLp8arCSpcLgpdCJ_TJWkjZmUQ8mw_GNVNjyzY9J9c8n
 5zbm.gPFZo1STJe.en9aizn2vpu5jlM7ZqxxTAY2bw5Migw9UoI9L_nyi0Mrbhobvf.03PDP11LK
 404fA1kyKqbV9I8HHGOyBN7Ogzlbe3YFC36BPPZFgTsdsjHk93q9nnnrUbRhAmh.H6L8tRDnLyrs
 JI5f3SVO7HqihGnqGTJVglmnd.AV1avof01tLjw9iYUWP9fgENln6SpWzyb6_urkspjLREYvRdoe
 TkEm6Q10pXJr7KqkoiHMPd9iMTj2evC6iNbk451G8vi.DMy54FT91uKMi6wc8lIJih4J22NOG8.J
 lCtoZwC5Xn1iz3pkrXY0DlNFci7UdovoCBX326Xo72qh7ufGl5qtvFlDJFHhkpX_zzlEhu5jrbmx
 aWZglSN1KvKTeHTqzgsSxfjrkpaqwAuRgz_GZEwoVlO5b7ye6jPHXJm_QaIz8wBM5QW3uham0cTr
 Y5OUJV6YfZ0dJFACg3WCEgVKPDqNQN0LmMk6h0kTmyIAFFRqsNVgqOZ850O0vgs.bJFQtH7NkuhP
 _.6ET4Y3Hom0.cEfupmzYlb6lB20LcMOk3d9jIGZeQ3jsGEkZN8pA5xnYzUnk.H84R8C66CULnDL
 I7Gkw6hd_jj0gk5E_xF3ABRM44a0JBzcp2dwyXA5CNQ7qVhcRJM_Nsal2xNQ2onRjkWdKq9rsIj_
 vslS6fhf4_u..MxyG8pGuVcqIQ3MMItI4BLKJXnlS.GBz_1aIYOvD.vWWhPCjW4iy0QOnUyVSpw-
 -
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: 66a68990-e52b-47ad-aab4-4f8a9e40fee4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Thu, 17 Apr 2025 19:13:46 +0000
Received: by hermes--production-ir2-858bd4ff7b-9r9sx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6040ee699aaf3d3f072b53831b62751d;
          Thu, 17 Apr 2025 19:03:36 +0000 (UTC)
From: Ruben Wauters <rubenru09@aol.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Cc: Ruben Wauters <rubenru09@aol.com>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] staging: sm750fb: rename sii164_set_power's param
Date: Thu, 17 Apr 2025 20:02:53 +0100
Message-ID: <20250417190302.13811-6-rubenru09@aol.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250417190302.13811-1-rubenru09@aol.com>
References: <20250417190302.13811-1-rubenru09@aol.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Renames sii164_set_power's param from powerUp to power

This fixes checkpatch.pl's camel case check

Signed-off-by: Ruben Wauters <rubenru09@aol.com>
---
 drivers/staging/sm750fb/ddk750_sii164.c | 6 +++---
 drivers/staging/sm750fb/ddk750_sii164.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index 9f660a9be5d6..e2da110fab81 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -262,14 +262,14 @@ char *sii164_get_chip_string(void)
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
 
 	config = sm750_hw_i2c_read_reg(SII164_I2C_ADDRESS, SII164_CONFIGURATION);
-	if (powerUp == 1) {
+	if (power == 1) {
 		/* Power up the chip */
 		config &= ~SII164_CONFIGURATION_POWER_MASK;
 		config |= SII164_CONFIGURATION_POWER_NORMAL;
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index 465631d3868a..1730c2116b72 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -33,7 +33,7 @@ unsigned short sii164_get_device_id(void);
 #ifdef SII164_FULL_FUNCTIONS
 void sii164_reset_chip(void);
 char *sii164_get_chip_string(void);
-void sii164_set_power(unsigned char powerUp);
+void sii164_set_power(unsigned char power);
 void sii164_enable_hot_plug_detection(unsigned char enable_hot_plug);
 unsigned char sii164_is_connected(void);
 unsigned char sii164_check_interrupt(void);
-- 
2.45.2


