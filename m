Return-Path: <linux-kernel+bounces-859846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2F2BEEBC6
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 21:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 758F84E2010
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 19:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2F92288F7;
	Sun, 19 Oct 2025 19:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="Zu89BxtU"
Received: from sonic316-54.consmr.mail.gq1.yahoo.com (sonic316-54.consmr.mail.gq1.yahoo.com [98.137.69.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C48354AE4
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 19:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.69.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760901614; cv=none; b=R1PMBE0w2TPRXnG2iMUlyVyhydocreWVzpp8148cBwQaDtMncaM9IXyg9eRpqeX1iD3lXm9EL1FNkJs7okk2Zc/QPoicknJeIxJVT4/SuVLWaCH7R2wIFQ6gTGjaWZYWDYFinlqiMfQp6+++WRAqSvbo33WzoG6oDzS60ELaKV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760901614; c=relaxed/simple;
	bh=PXReM+TD59LE92KgViZWcS2SQNZnXlAtv4rJN/14Kr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=OcvXUwKU1pKY8XeDhRRyJiH2V70itzw0vgP2qPdc7YW0JZvEHKYZ9Egt2VY6nTv58ikSXQDwKy94g9LD4gCzPDtcaam8i+lRZlPjZN5UO7UidF6XALzQyMLJNG8I+D5MFg5QxOCOALNEiDEe4G0RNNy3MXR28oFgFKvhjkVOjXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=Zu89BxtU; arc=none smtp.client-ip=98.137.69.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1760901604; bh=YHPBx3499LOsnw+xWczKHUVNbwb3wogW8BPwpY/euag=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=Zu89BxtUxghOMc0D9AlSmizFP4by4l0oBvmvQqw8If7BrviNb17vkIDOuVVlFqcEUckK/3xfZUPXJfUPRPvmGOtJU7zSEaRoJRI4govpn3oiX+E136JYk23fexdIa14FaeUdyCkVsZEtqtPmUhi162NBdL/ueR3VHQMaww/GYKtMZF66kW4yguKQaQpsQJFLSjbNWQ43v0H8Qhbw5D2YZc1ab+UuVs3rER5dAFELiGME6UASI6OMO01U/hBCMvYxDh7Ce0j4hCvyGlp52bm9vHQ3lZizSvTyVhXk1P2DlZtn1kInXHp5+alDIH1b1oCpbggRear26wOnUyZ1DUx1XQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1760901604; bh=2O3MSnLiH8hsAulVT7vBRcmNqr23jXXU2RF3Nzg+IKK=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=tg3c/ZRAbwMZozExpMSiXvNbTFuBYtBclCmjdmINNpitWNI/S4tt4hvjW2VYiHnc17TqWN6VkTVSxEqt/80iZNS3goARqWYooByvuTg94xJ74rv/v1wwZC51Pznh3mbuA0B3AkENR0zTeNmml6SWvHHWhb7HCNSkkdhYF/dLUJoQKvHdNe8otIaGTOtjIz2hAHt4bQYwi613/2WDyLBiip45I4TwTpb19xqg0QMpB9bklU5incErbVyNu2Vl3e99JfJKoTzxh6pKmlRjK9Bh00N2n32r4Q9g3FsWw/xapdPe3LWPSUEbHCTPUvnAUDOl4pqIFbfTdmm/mIcpNGXm7Q==
X-YMail-OSG: LgNV5DMVM1kH1cp.M3z9M91NI6p6fSKvh5UAqHiF3sjAl7W4P_KRG0tdCc.mknU
 5IeK6.rnKjrpkfA3eJ_wxDJM3pGkIwubweVAN1knQOKOLHO9DqgOxUGgHcHe2E2RllbmgQ5RCUB_
 HLEMIXZuHgAIWoNhSFmXNot1WvUfoce3W5aKfe7HrbdmKeMd8AkrV8UvBlGcwYV_s44tFe6_hlGR
 IUw2mM5ht3kqKDafZIt28tLTS1_8WtQb9dSpFO4rYJQ0V9XvuJq2lHTuQ5GMHZTTczItQKkJXjr5
 Z6NysMPwC_9TOeVvi4s3JpsvPNesHed3EQ7AwTHBfMYBmRcM4H1WMFDMlvOE.nfvO3tWER0yaIQ.
 urOSlCAWT3PmMybg25.GugffkZqnZaCaAX8CNjI0enX6Vmq3mNE6oPjRyLe7mBsavXqzrWjkHrLV
 E1.FcxwKXkBq3jeoPgdxcJ5tbMotNb0MVEZ7AeD1qmjSUDWtIurJr9bCS0vmq_p48VPiUNVXzZxg
 VNX6YyeFYiMzQ7Pmj0JDAS4eSzRJ8P0YJvDymClhSeLxfJ4h1K_OacdOckc4ZpjsHC_xmEozuSOo
 R81P4NaNo2VFhqXGDd1obZtK6EaqOewdArRswAHKBGnS62PWiJu_Xq_.Av2qtZyz4z_969nacDhM
 .EJE7n2L9yl3Ydr.7UOufDda7tYZVvzLoMik1Tk9ndrILa6L41fbMK3fdqsNRhz4OqP11Y.LqdQQ
 e7Fsbq8ImkEBgLlPn1t0lpIQOU74rQYnF0dKiNnxPDFrXI_61N72jDC08Zwzy9.dKCVFHBXZzBkz
 CQiUUcb7dHC8yIcY.ZuVtKeqrdTfudOB69wb_iW_EQMckqHK0ID9dFwWHRSA6H0XvY_c.sIPrrou
 JNiKnNXWJKE6wFCTZBW.oBb5hJ6Nz7yhhZfiZcNmoRHmdaimHuCN3EZuj5lsFlGinH8ZX_vdTOQ4
 8bczbFoPJ_kZ__tEQfPtXNo4KQQJWR._jvU_1.Awp0TYYU8I8vdgsXslM_ZRImPgsKY66wBdvwyv
 Ub13p0T_xUjdRaJDpR_ZtJsS5FWBNer8_YSloFZ6B0FzuQB.dS893gL2zzdhWpqnTHvWIMEazm_G
 iJ3llmlLIlx2y9VSf8JtTav3IE7L4qbEJelIJUymG7ZKOtp1J6OyMBSMkVMV0hE_lXcsU2NcU56P
 zdfs9GEJaLxe15e4myRly7wH.WOBWnxFqyUz4CREs.YjaOYkUmEAwNRwuymdIRBvRRN49o.fGau2
 zjqtb9jdMzjUb2lMXQg74ZdX2Frx.4HTll7Ja9HM2vLL5479r_HU.R0QJ120cxpw.EpymYKSZJ92
 Fz3DnWqln.6yoCZyN8EMH7_DNCVqL3Td6tDsFhiB9wGutFjq6h8CT0WXpPuH5pyZEV.RMllz8MvM
 B7xRKi7mdhDs.isDAS9wkSFDwug0d3TZftFeCsgDTxOUS3LjcGR5H9CnrQ7Jn2m8tfDuQcNL3DAM
 KRI79AhMHt4GVirKZvvYhPU7yQAvQFD_esmaBDB2hxTHv8AEy2_hCRZubXsxLjXDbmsrD0oGQVWG
 AXY3nOfzVRIOKUVK5x8hKxJ_n4fCurEoFaBIQs.Es2HzpRFTZBgDZej_xL8wGFcVSaWxk92vryDY
 uXV4FvZEHeLoHubpn.7y6ZZWgIJXORi5vHO8iLqKCY3xn9WHgI1_76TUeFc.YU.S_UKmnLjwxdMm
 dJd_P6POH0a6XlCjxklIhh.7loxNlUabdflh6yXRncokiyCvyGyHbE1mVqL9fPfSikgaKxRgOtDG
 LMheq5hryVDrzmSxCGUqaaqN1aenZ4.huEbXdxw53C1bBXfub8vSbjimECzCEaiD0UVzjVFJaYzj
 v8Yvvnm_QG6h24SGanWadNCIjOupSh6GfvZl8jRHZjeHUh1pLwib263iwHu0gl28reMaN0w3r0mz
 PUOB6vJY7bNYtAsFgIbIaAOi8UceIlzF_ar9cFTIetQzRrCp3vVhukRAOGCYQoG8YP_TGrZM5VyA
 a5EJfjlwetINU8kwcT7HpKjiDOpHk1tgsNT.PVY2OT4JsylrRQmmuAB7cqwRI49DyoAxFMP5HnGA
 hSqTU01tZwQMyKHuoStAYoEnNFKw_hk2WOkfewNmLWCnnFaOewtjAcoeIzRXXwdSYrHYEieAQBtL
 IKE3cWvJ.frjN00nPInwcNOLj7DbWGkI5xn6.SRen.xV8OCtQLUfbZnN8uHYO0iq2fttfHuwVrbH
 jiajLwin5kSJI4cecHTIhoZl00iSnGxPY1UM_qkGd
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: d59c9510-0251-42a6-92ae-8953e64a1015
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Sun, 19 Oct 2025 19:20:04 +0000
Received: by hermes--production-ir2-cdb597784-phg5h (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b23e1a914437bdc8f5bc6926d5f840c3;
          Sun, 19 Oct 2025 18:59:46 +0000 (UTC)
From: Ruben Wauters <rubenru09@aol.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Ruben Wauters <rubenru09@aol.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/gud: rearrange gud_probe() to prepare for function splitting
Date: Sun, 19 Oct 2025 19:53:48 +0100
Message-ID: <20251019185642.14266-2-rubenru09@aol.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20251019185642.14266-2-rubenru09.ref@aol.com>

gud_prove() is currently very large and does many things, including
pipeline setup and feature detection, as well as having USB functions.

This patch re-orders the code in gud_probe() to make it more organised
and easier to split apart in the future.

Signed-off-by: Ruben Wauters <rubenru09@aol.com>
---
I wanted to move mode config to just before pipeline init, however mode
config is edited in feature detection so I was unsure how to go about it
exactly.
Further untangling of this may be required before splitting it out
---
 drivers/gpu/drm/gud/gud_drv.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.c
index b7345c8d823d..583f7f8f4c00 100644
--- a/drivers/gpu/drm/gud/gud_drv.c
+++ b/drivers/gpu/drm/gud/gud_drv.c
@@ -463,10 +463,6 @@ static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
 		return PTR_ERR(gdrm);
 
 	drm = &gdrm->drm;
-	drm->mode_config.funcs = &gud_mode_config_funcs;
-	ret = drmm_mode_config_init(drm);
-	if (ret)
-		return ret;
 
 	gdrm->flags = le32_to_cpu(desc.flags);
 	gdrm->compression = desc.compression & GUD_COMPRESSION_LZ4;
@@ -483,11 +479,18 @@ static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	if (ret)
 		return ret;
 
+	/* Mode config init*/
+	ret = drmm_mode_config_init(drm);
+	if (ret)
+		return ret;
+
 	drm->mode_config.min_width = le32_to_cpu(desc.min_width);
 	drm->mode_config.max_width = le32_to_cpu(desc.max_width);
 	drm->mode_config.min_height = le32_to_cpu(desc.min_height);
 	drm->mode_config.max_height = le32_to_cpu(desc.max_height);
+	drm->mode_config.funcs = &gud_mode_config_funcs;
 
+	/*Format init*/
 	formats_dev = devm_kmalloc(dev, GUD_FORMATS_MAX_NUM, GFP_KERNEL);
 	/* Add room for emulated XRGB8888 */
 	formats = devm_kmalloc_array(dev, GUD_FORMATS_MAX_NUM + 1, sizeof(*formats), GFP_KERNEL);
@@ -587,6 +590,7 @@ static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
 			return -ENOMEM;
 	}
 
+	/*Pipeline init*/
 	ret = drm_universal_plane_init(drm, &gdrm->plane, 0,
 				       &gud_plane_funcs,
 				       formats, num_formats,
@@ -598,15 +602,6 @@ static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	drm_plane_helper_add(&gdrm->plane, &gud_plane_helper_funcs);
 	drm_plane_enable_fb_damage_clips(&gdrm->plane);
 
-	devm_kfree(dev, formats);
-	devm_kfree(dev, formats_dev);
-
-	ret = gud_get_properties(gdrm);
-	if (ret) {
-		dev_err(dev, "Failed to get properties (error=%d)\n", ret);
-		return ret;
-	}
-
 	ret = drm_crtc_init_with_planes(drm, &gdrm->crtc, &gdrm->plane, NULL,
 					&gud_crtc_funcs, NULL);
 	if (ret)
@@ -621,6 +616,13 @@ static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	}
 
 	drm_mode_config_reset(drm);
+	drm_kms_helper_poll_init(drm);
+
+	ret = gud_get_properties(gdrm);
+	if (ret) {
+		dev_err(dev, "Failed to get properties (error=%d)\n", ret);
+		return ret;
+	}
 
 	usb_set_intfdata(intf, gdrm);
 
@@ -638,7 +640,8 @@ static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	if (ret)
 		return ret;
 
-	drm_kms_helper_poll_init(drm);
+	devm_kfree(dev, formats);
+	devm_kfree(dev, formats_dev);
 
 	drm_client_setup(drm, NULL);
 
-- 
2.51.0


