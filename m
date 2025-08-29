Return-Path: <linux-kernel+bounces-792113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52829B3C04F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2181016A75F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFE732C33A;
	Fri, 29 Aug 2025 16:06:15 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBEC3218C6;
	Fri, 29 Aug 2025 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756483575; cv=none; b=erK5bpTICS4h2R9CvH8JentZK5njo3R8DC12Z3p3yC/mZ/uy8wBiRUl7DaQn03rnRLazgLXVZCZyz7gkZ9xNxVbLDPbFH1xCKUmjgavvIpEDJi76Bx3yXh8CKvrCOqanD2/0TPfyWfLp5jjtqiQmMdfrN/IzBbv4ldcaGHLhZSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756483575; c=relaxed/simple;
	bh=VmJBa+4m+0rUZPWAD3Gyee+a7V7U9qElmS6Q6lZRMq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BL1aYca3hL0snaRGe6bvzLVB3l4XC+gQrepLdsW7xAAsVSRi5iHJrr7Jneis56/180w0or6V9jajDRl3hRH+yn97d1k8cuqvfN6uGGQNQUcHcqW+bg8HkLOtR0MqCtdf7hdMQe28YGrc+IUYn6w402/UtOviD7eshSRUHK3oPXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b694d5.dsl.pool.telekom.hu [::ffff:81.182.148.213])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000088D59.0000000068B1CFED.0023A914; Fri, 29 Aug 2025 18:06:04 +0200
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
  alsa-devel@alsa-project.org, Gergo Koteles <soyer@irl.hu>,
  stable@vger.kernel.org
Subject: [PATCH 2/2] ALSA: hda: tas2781: reorder tas2563 calibration variables
Date: Fri, 29 Aug 2025 18:04:50 +0200
Message-ID: <20250829160450.66623-2-soyer@irl.hu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829160450.66623-1-soyer@irl.hu>
References: <20250829160450.66623-1-soyer@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

The tasdev_load_calibrated_data() function expects the calibration data
values in the cali_data buffer as R0, R0Low, InvR0, Power, TLim which
is not the same as what tas2563_save_calibration() writes to the buffer.

Reorder the EFI variables in the tas2563_save_calibration() function
to put the values in the buffer in the correct order.

Fixes: 4fe238513407 ("ALSA: hda/tas2781: Move and unified the calibrated-data getting function for SPI and I2C into the tas2781_hda lib")
Cc: <stable@vger.kernel.org>
Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
index 1eac751ab2a6..83eb19bb9bce 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
@@ -300,7 +300,7 @@ static int tas2563_save_calibration(struct tas2781_hda *h)
 {
 	efi_guid_t efi_guid = tasdev_fct_efi_guid[LENOVO];
 	char *vars[TASDEV_CALIB_N] = {
-		"R0_%d", "InvR0_%d", "R0_Low_%d", "Power_%d", "TLim_%d"
+		"R0_%d", "R0_Low_%d", "InvR0_%d", "Power_%d", "TLim_%d"
 	};
 	efi_char16_t efi_name[TAS2563_CAL_VAR_NAME_MAX];
 	unsigned long max_size = TAS2563_CAL_DATA_SIZE;
-- 
2.51.0


