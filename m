Return-Path: <linux-kernel+bounces-841656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D947BB7EE8
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 20:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79AFF3BA666
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 18:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA152DF14E;
	Fri,  3 Oct 2025 18:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5E4x7le"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4CF2DEA89
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 18:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759517739; cv=none; b=NYT+UC/tI48cM58kf3UaX2T9XzcCUhpX9IynPtwZkL2V7yFdHiwX5HsCJjSYM0TYUBop3krcdZYXIm8ruES80c4i074oxJTRdvMY2ev3Hyug2/K8YoeQf5OfZEjPOgmvG824xiBd2aSOpUCWEyunxzwlucVHsTmGlSxLAd6dMOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759517739; c=relaxed/simple;
	bh=N2ZXUZbekSyi2QUa5AhmczgUZDM3XEWCe9o7oZmLxSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JSLi3MJgwvROAXQvIrduO42zo+zpWoBELB0IWaUqtu6UDSCjehkgGBr/+ehQxuvQO4q11xGsRdD8An6/XO+ZoNgOt6is/y8pJeg/t2TxxbP23p/o5CobpXap6msadmyfEy4jUvFi+xGg+cE8asyuyEmkUpD8izb6XByy9sHwZ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5E4x7le; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so2423969f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 11:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759517736; x=1760122536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAfg/MBoirlA9xSB1hCJrMdG5U1jpf80VoCLnIdIJws=;
        b=N5E4x7leRUsLXckET8vly/pYSZixIGYd5Qkk4YQGcQeYy89Bb/fj6/z9PU849LqUNu
         lYOig0pHyJ5VNN70aXizMBAGDWRrC8IDG7SK3Ijs6tnevCwm1dxLu3NpashQb6QL+2lx
         3w//COvntYwF/RBprVUpFOUsCW12bMwMiiM7Cf4xp/frZsSBLG1voyj3lZ2Aw7cd6VHu
         +g5MiN88J5qfB4ZPNLa3YrravPWi1cb099DpFOa3Hob00fi51yN2CgJLW+67kuELUWQ1
         YvRK8XHEaHZBb3uNkasUpzUJ8N47dj/0u0U3h05orB/HJYCyjV3rpuqGKWP36JywPWld
         glgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759517736; x=1760122536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAfg/MBoirlA9xSB1hCJrMdG5U1jpf80VoCLnIdIJws=;
        b=fnrUITb+wEI0zbKgUI/sGNn8A9iPak4J9ugYz5x+QZVn5l85M0Sw95gRgO5wC/8Seb
         Yow39y00G1Vy+v56/3W4VjDWCU9zBGObR72OUmGBZ1oUZepHJK5hhqBuHFcLoiFXXpaI
         /FqcP95OHbAoXA7YFszI4C75+WeLSefItyElEiZZjn5uWCdmA6WW3uM9UOUMbPAadLYi
         +2Stc9Z4ocHo2SJxT6SAzuH3px48yrJH2A3PxYwZJaqdm5SntVGbkHnqZ3fcNFqwggHr
         SWJyvjQSYXZR2Jv+IpHZLweMDGnPNfZVs783+HcAR2IoEzg6/Mc82cF4+GkjK80ULtAv
         kyUA==
X-Gm-Message-State: AOJu0YzsOJfAFdJwrV4O8YkUdDjTuBMXWdrjvjQYyLPkl7iCSD54qYtA
	Xk9ILZqKmBGytCIJbifGhofFIHGpNvg9KsiX0WZLWjhDFh2Cnssx5m1M1rrNZzOs
X-Gm-Gg: ASbGnctEJtpRGG87kwAIC0CxnsV1GqOxKUMzOyAyth93jOTq9EhHUDGcKI1KGK87ZVJ
	gM+rKtdKnV2snkBFu9EMwD71T0LkBPZd5p6slgB6z++vC0chTJURLcsnZKmN4knpjrUL2pTrD0D
	wygmKJAbmtsNFiqknWELhhkbWW7oi8buQBk5YySvxjRRcz3tcfqxMss6ocY+6I98zIQZ5G0yDg3
	wTTRrrPsk6QIqFhaUDhmSHXbxDkFUtD/rLi6NSulUyOkjTQYGjg32ncabLAVGqUo4QqNQoFfVw7
	Pa9TJSzKjfUMcKLQc8Uq+pL44uc+ZqaT2D1RAPNYQeGGY25uGUg0uvxknGPGprn2URoqYbTBS+1
	SoTafzzegQMvOrlGeoTD23wxFz7S+KwnjoN0uTKCE6IEI5ay3MNLCLneAymAL4Q==
X-Google-Smtp-Source: AGHT+IHSDPkUOEz2UT7aQlYiPocEemISwJfvL6QJuuYJ8ih8sI991uu/dhvmWK1BFMOQ8fnS5epEzg==
X-Received: by 2002:a05:6000:2311:b0:3b7:8da6:1bb4 with SMTP id ffacd0b85a97d-425671c54bamr2826496f8f.58.1759517735928;
        Fri, 03 Oct 2025 11:55:35 -0700 (PDT)
Received: from denis-pc ([176.206.100.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e9762sm8946927f8f.38.2025.10.03.11.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 11:55:35 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	"Hans de Goede" <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Limonciello, Mario" <mario.limonciello@amd.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Alok Tiwari" <alok.a.tiwari@oracle.com>,
	"Derek John Clark" <derekjohn.clark@gmail.com>,
	"Denis Benato" <benato.denis96@gmail.com>
Subject: [PATCH v12 1/8] platform/x86: asus-wmi: export symbols used for read/write WMI
Date: Fri,  3 Oct 2025 20:55:13 +0200
Message-ID: <20251003185520.1083875-2-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003185520.1083875-1-benato.denis96@gmail.com>
References: <20251003185520.1083875-1-benato.denis96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Luke D. Jones" <luke@ljones.dev>

Export symbols for reading/writing WMI symbols using a namespace.
Existing functions:
- asus_wmi_evaluate_method
- asus_wmi_set_devstate
New function:
- asus_wmi_get_devstate_dsts

The new function is intended for use with DSTS WMI method only and
avoids requiring the asus_wmi driver data to select the WMI method.

Signed-off-by: Denis Benato <benato.denis96@gmail.com>
Signed-off-by: Luke D. Jones <luke@ljones.dev>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/asus-wmi.c            | 40 ++++++++++++++++++++--
 include/linux/platform_data/x86/asus-wmi.h |  5 +++
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index e72a2b5d158e..38ab5306e05a 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -390,7 +390,7 @@ int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *retval)
 {
 	return asus_wmi_evaluate_method3(method_id, arg0, arg1, 0, retval);
 }
-EXPORT_SYMBOL_GPL(asus_wmi_evaluate_method);
+EXPORT_SYMBOL_NS_GPL(asus_wmi_evaluate_method, "ASUS_WMI");
 
 static int asus_wmi_evaluate_method5(u32 method_id,
 		u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4, u32 *retval)
@@ -554,12 +554,46 @@ static int asus_wmi_get_devstate(struct asus_wmi *asus, u32 dev_id, u32 *retval)
 	return 0;
 }
 
-int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param,
-				 u32 *retval)
+/**
+ * asus_wmi_get_devstate_dsts() - Get the WMI function state.
+ * @dev_id: The WMI method ID to call.
+ * @retval: A pointer to where to store the value returned from WMI.
+ * @return: 0 on success and retval is filled.
+ * @return: -ENODEV if the method ID is unsupported.
+ * @return: everything else is an error from WMI call.
+ */
+int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval)
+{
+	int err;
+
+	err = asus_wmi_evaluate_method(ASUS_WMI_METHODID_DSTS, dev_id, 0, retval);
+	if (err)
+		return err;
+
+	if (*retval == ASUS_WMI_UNSUPPORTED_METHOD)
+		return -ENODEV;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(asus_wmi_get_devstate_dsts, "ASUS_WMI");
+
+/**
+ * asus_wmi_set_devstate() - Set the WMI function state.
+ * @dev_id: The WMI function to call.
+ * @ctrl_param: The argument to be used for this WMI function.
+ * @retval: A pointer to where to store the value returned from WMI.
+ * @return: 0 on success and retval is filled.
+ * @return: everything else is an error from WMI call.
+ *
+ * A asus_wmi_set_devstate() call must be paired with a
+ * asus_wmi_get_devstate_dsts() to check if the WMI function is supported.
+ */
+int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param, u32 *retval)
 {
 	return asus_wmi_evaluate_method(ASUS_WMI_METHODID_DEVS, dev_id,
 					ctrl_param, retval);
 }
+EXPORT_SYMBOL_NS_GPL(asus_wmi_set_devstate, "ASUS_WMI");
 
 /* Helper for special devices with magic return codes */
 static int asus_wmi_get_devstate_bits(struct asus_wmi *asus,
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 8a515179113d..dbd44d9fbb6f 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -166,6 +166,7 @@ enum asus_ally_mcu_hack {
 #if IS_REACHABLE(CONFIG_ASUS_WMI)
 void set_ally_mcu_hack(enum asus_ally_mcu_hack status);
 void set_ally_mcu_powersave(bool enabled);
+int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval);
 int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param, u32 *retval);
 int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *retval);
 #else
@@ -179,6 +180,10 @@ static inline int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param, u32 *retval)
 {
 	return -ENODEV;
 }
+static inline int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval)
+{
+	return -ENODEV;
+}
 static inline int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1,
 					   u32 *retval)
 {
-- 
2.51.0


