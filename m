Return-Path: <linux-kernel+bounces-609781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A534A92B8E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 21:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC5DA1B62781
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 19:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC9F2010F5;
	Thu, 17 Apr 2025 19:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="hIoxVSbO"
Received: from sonic301-22.consmr.mail.gq1.yahoo.com (sonic301-22.consmr.mail.gq1.yahoo.com [98.137.64.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5D81FBCB5
	for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 19:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.64.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744917232; cv=none; b=XjIPKRYMN5pZUFYpuD2Qg4/I4ACVb06MfMWunKDtn9A3pSEs8AkLffbJxzCzWS0F+OjRfri56nJdnEl7gvRluMkDgwLTEAHhG3FxdQ+ZewGqJLmKS0rdt4l5nOWKnJLo+n5hf2knI4edJ4xEr1JtEi6PI1RQoXZQuS1BnEpbve0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744917232; c=relaxed/simple;
	bh=L6SdPOd2Ssp0R8bFUEdZpFt0iTf0baqjd0GM0QfWXWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WU7++lqIhv9mks9nk2OXQL4OlIYbpYJ+Rvdp9SPLBYbpqVbLsj6miOZhUtOxAnouTZ63XayigGLL0C5O0HfIrFGB5sPAtwoHrXB6yieudsnNaiamApxfwlGNH2Ywu2uhfmkDvtsBeIqJcQIFzTlwQRzU14Q10cSd/ZF7YLnawhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=hIoxVSbO; arc=none smtp.client-ip=98.137.64.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1744917230; bh=RxCvByeLEbOiitcXU2m12OSRo5AUDmJRbM2o07h4ujc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=hIoxVSbO7vjK9Quw99SHyvpyXjYoERXtqhJvawKxxwIpCNzYn2a6ZiNVwRsBROcKSzFtT3Ji4IsAop6lsnu13uAiHXxxavpDaaQDLwGrRwVshctLmNsqT7qo0HkRUTw527tHjOigSCbWvtxZhTsXj2QZabqbQ8Q7duaQXIY2ewMamTWozffAEoEy7mSrY4zFTIQr9IhPxk7AjtKDNnXu3q4ySYq5cJ8w6CVwQWft+uQ4GDwVSwJxCLAz1LAxI0LB8IEcPAJm4y5X99tWa4UgkQhiJwQwGzYfoUZnBdx+7zfBNVI74bAPjjRste/o3eNYahtIpInAy2uh4+PUop7Dvg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744917230; bh=SFESFOuAvHidhDaFm4MAwN6+s4Q4qTIfM/kSyDal1mh=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=muUnxrlNQiwOG2qqmvxSdpGX9pVn+/6wAaxIcG1ICYv7omRuvJKjhcUmjfSWAiYGg9q8AGLJdi0OpBaYCT5OFEbsPKOL+OA0rB4cB4lNFLf8ergBe4xbaeTBY7F+Pn8plAdiPBozTF3AyaCbHRPJtzSSxy6PX2zpl4uHHcuMB9m5O3mnK59cAUv3otXn8xetxaFy6mUe4jgZEJd8qO6FAJ4v4EU27nigR791IJYgZ4mLirjuNanLS0oicQSQ5TQZ+b5QS7hB7BbmOOwlvgRt6XlZKz81MD+l24vA36+B2Li7GneqCeRGt5CDarQICzKKMgGgh3Kghhx1tRR3d0rLTA==
X-YMail-OSG: Bsn1QboVM1k.CXjKOD9a40GJDxZ_pa6I7oUPAOlqB1eczFCm6dI2ne.YbUPEwfC
 PRITJHlXTzxlrI_.YLzdN.VbbR7AdXuFLxvuox1CYYTNuBxZ1kQgGK_ezo878SYScLqQTtBLD_Ky
 2IIIAtYjOSSUA5X2AQleqDZT8LxZMF0dElT99yxqfdB8PJGNY6WyLzsB0EuJu_mffCntSj8mEUiJ
 RgY3Op7cJ190pH1nU2DgehYD3kFs0atW4yesNEfjZzOv_opKHYXrv8RChCQ5AcdpQg4UVFFHlYwe
 EAjzwNOHCT5WVFu9Fgjsw.AVzrrABZz3OfnNpJX3qitwwCr18yvI_grLVoXzIVoWpBXN40DbR8qB
 9vKaPP8ke8jQXz6ALwaO5nUeBEYz8wYF3hoawdoLvBKoduH7nJc2w5u3oK_j1Lbtumk.i99Wb9Md
 4ANIdz04YvzBk8XYtvCaOXUlStM9qmOKaWU.ctEGtAdrkfZ79mlS4iCUQwVxdCCltfKseHONQoVt
 JK4npKFVRCyo0jaX6skI4HviOVGix.x0H3OB_mfdk1sOHvuDhWGXF9FYMiyz.pv4NeyBo3KOHz9O
 8kxTtEooN3tHFEB5aJzFRfYb6ZaF37rVfRhWkTEZXjOvX0G.I_C2fIOTnxtdviGNUkfVAx9gDc6s
 Tw1U_kI7NoX.cQ4umZG44ZNSx_QR8omn2EJ2UV27v4s.O1_MNwo9d_GngUxwIF2Eyx9fDXMK87sZ
 Zy6fSttMcB.mZYOu.w.qMT6kVZ1.2PbGGtCNK2iyAa0Va9WMyVJbJiYzMVMUwAgAS6w7hPLR41R3
 i4D7FzE25Tr_Cv0lzWerQpnL1.3vOpzV2rB1RpyU.C0wetvai.XT2jzafqGueUZm1PgbbTNjT1DB
 _vEzZ6P.mJedEDyiBqDRo5_SlZXc01.9SE3Yy7d9Rf8g._TF39FJn.4gyYjpbPyvnox9xwouxcvF
 1Cr4wNB0k74hNU9Dr646b4yFrm0rYdIoQI6bd8.v9bnWLu62ANPljaC3TS2thyZmLlLZs_c60g3L
 ImrP3uB.5d_AfvVrMn5AixMQQL2K8PDUtTgZsxpONYVorBzhMytFnud.bAGNojr_OYU_g7b7NXJM
 VyZuLlqsfoT5j4Ml4Jmn9ooVswjgofAPJ0j_Dal_06DU2arnh55Vif7rXVEj20TxX2cEeu93Wt1O
 aGJRQGXlF4uplvUx4pgsDx1Z2MqpVND3TODFZAogPc9WYc3LQgDez7R7tI1cCmSUgsXWK3hN3fr0
 P73M8PxvsB2TR7.xZKJIkGNTLkbb17Eq0_oAYzUMGD_wPFgZkMiX0Hru4U8YWwGeDehPKWqdmtLB
 Kvtyy6272zyGXLkANWjYUGUrEJeU0R8QneSa8KFMqrdTRwhzd4z9cWiClLzuMR.uv9ACQZHCuVUx
 MQF7PbF_TyqJixNcnjLHhBenGAoaTu9dJvopYV_JFXJEQzkJvmiSAonjE9obgl7Fxeb1Snhq2AW1
 AC3Aq2GdS0E8EX9D15Xm4ZxK4pSaNmUYSe2ktwvF77YtgxgJzLm9HpZBpDnjqpFDLa0UosoZIT_o
 tVIof9cX4i4xCdC0rrKnQPOkNKucBFyrcmuCXb0iaUD2Y_zk7DPo8m8Z5IehrwQukyWheG5mZi04
 R7jYIDWQanr3N5l9PX8vLVAD8mM8Hy60_niC4i.iCFyS5ZKzTsmE435yps9rxuWJzKQo0IdmwoLb
 Vt96yjmpy0KhlQIFmonk3KDbF20n9gEn6ZCCsFhKK7paBXkfzbq43q85CKWYloSLX3sEo7fuURpn
 Ae.VlLb9iIpAGTC231hc7Ftm.zRDMVqqzWLonCCaCJ8lJI2a3NlpiXztbGu9.BBST39qH7LtXoEN
 eFYKEHlrI.v.H3Tv50ZbsI9aiXCC3Ah9kMCcJ5vAhUuzD36atV7YuYulG_Z0X7jODxduoDz7xfUS
 F6FnPB0VpYMFXVi8neAoc55dI903DvOVsjpSTvZj1Bx07EdS3WkYk.VsFDWbe_C6lQpxtv.M._tK
 HxIfxtUFLfhIqL4L.ksPSrbV06hn59ObWMQezzvs8Zgjz6lvIslhqN1dcw3Y4XKeBKhqXIi8odyF
 2ni1ufGuvg_v1ZnFJWUuEHIowo0RzdZMu_bcZzfGhL_ziC9yhaVOTjMyMMKUELK9Iv5rgP5wGucC
 Rwa5CnFiuyJtK39Li4aB013WSH6xNi.7uakZ3lWGsCuvupQHC5D7IPof8x52wW2v3KJJlmr4oK.8
 3egxJ2xnSnWlwiFKV6G2o2AUXpKuJLzJgehrgD6MJnBCUUVtHz2JaYyzaUWL.5jhZM591FRHyTBc
 VLo4BRquFQsYxJ2EF
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: 70cf2c66-89ab-47da-9f45-34579a8c2829
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.gq1.yahoo.com with HTTP; Thu, 17 Apr 2025 19:13:50 +0000
Received: by hermes--production-ir2-858bd4ff7b-9r9sx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6040ee699aaf3d3f072b53831b62751d;
          Thu, 17 Apr 2025 19:03:38 +0000 (UTC)
From: Ruben Wauters <rubenru09@aol.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Cc: Ruben Wauters <rubenru09@aol.com>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] staging: sm750fb: rename sii164SelectHotPlugDetectionMode
Date: Thu, 17 Apr 2025 20:02:54 +0100
Message-ID: <20250417190302.13811-7-rubenru09@aol.com>
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

Renames sii164SelectHotPlugDetectionMode to
sii164_select_hot_plug_detection_mode, and the param
hotPlugMode to hot_plug_mode.

This fixes checkpatch.pl's camel case check.

Signed-off-by: Ruben Wauters <rubenru09@aol.com>
---
 drivers/staging/sm750fb/ddk750_sii164.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index e2da110fab81..2ca72bfc67f2 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -283,17 +283,17 @@ void sii164_set_power(unsigned char power)
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
 	unsigned char detectReg;
 
 	detectReg = sm750_hw_i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT) &
 		    ~SII164_DETECT_MONITOR_SENSE_OUTPUT_FLAG;
-	switch (hotPlugMode) {
+	switch (hot_plug_mode) {
 	case SII164_HOTPLUG_DISABLE:
 		detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_HIGH;
 		break;
@@ -329,9 +329,9 @@ void sii164_enable_hot_plug_detection(unsigned char enable_hot_plug)
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
-- 
2.45.2


