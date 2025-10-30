Return-Path: <linux-kernel+bounces-878267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A215EC2023A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7811C4EA6E9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FF6346E7F;
	Thu, 30 Oct 2025 13:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fEVzPE2P"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31B82E9EA0
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761829414; cv=none; b=lDnpXWjnDKZmJFF8QxdrSFLsvgrOq3ktzO/Dy9klzlQUN3AVSuqnDK0vPwvyd0nsQdMV6eF+mHFXM/1y4nIfJEd5ReVx5MGexWO7bJ5H1QbGv0PCgQySvZlugC6OClg1Ek4w4TctR6vYrdKyMzPXJKDB7zRd7oVXJkC10Job/gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761829414; c=relaxed/simple;
	bh=R775RbbRNLEfj9HOIS+utZQnt0MZztHOU4GczwBLvKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=keLs13ZPHG34Jjk16SVLr1zWXrjAOXPvHYmiXezvE/9j813xK9c+8FLFFwd3Uj2vehMuZldsNpDyix6WtLBrF8m5ZZ6nbc17OVE5rPKDmFaqLV/5wwXR3UUajfEBpUI8Ns7Yr5dxCqs3IV5IVthAwu0rSDQUfPmK+F8gkzfywB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fEVzPE2P; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761829409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2bW5Lixhn8DqnxY2a2XosMQ9BFafeoOUC56dKRfdU7Q=;
	b=fEVzPE2PH7U+xsrId8PQaGgCcxEgv3IefAaGclWzi3ngHutaWbol+rZsr+8K53RH/pC984
	LtC1KkZHMbyoWJLDNOsAGTVms93b1fmKsTFHLamO3PCPksjR26P2vYHU734zm98auv+KnH
	FcSCK17RVdfPlJSX/xG9eL1FGtjgmiw=
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	"Hans de Goede" <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Limonciello, Mario" <mario.limonciello@amd.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Alok Tiwari" <alok.a.tiwari@oracle.com>,
	"Derek John Clark" <derekjohn.clark@gmail.com>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	porfet828@gmail.com,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v16 1/9] platform/x86: asus-wmi: export symbols used for read/write WMI
Date: Thu, 30 Oct 2025 14:03:12 +0100
Message-ID: <20251030130320.1287122-2-denis.benato@linux.dev>
In-Reply-To: <20251030130320.1287122-1-denis.benato@linux.dev>
References: <20251030130320.1287122-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: "Luke D. Jones" <luke@ljones.dev>

Export symbols for reading/writing WMI symbols using a namespace.
Existing functions:
- asus_wmi_evaluate_method
- asus_wmi_set_devstate
New function:
- asus_wmi_get_devstate_dsts

The new function is intended for use with DSTS WMI method only and
avoids requiring the asus_wmi driver data to select the WMI method.

Co-developed-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Luke D. Jones <luke@ljones.dev>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/asus-wmi.c            | 46 ++++++++++++++++++++--
 include/linux/platform_data/x86/asus-wmi.h |  5 +++
 2 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index e72a2b5d158e..c3e90517ce0f 100644
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
@@ -554,12 +554,52 @@ static int asus_wmi_get_devstate(struct asus_wmi *asus, u32 dev_id, u32 *retval)
 	return 0;
 }
 
-int asus_wmi_set_devstate(u32 dev_id, u32 ctrl_param,
-				 u32 *retval)
+/**
+ * asus_wmi_get_devstate_dsts() - Get the WMI function state.
+ * @dev_id: The WMI method ID to call.
+ * @retval: A pointer to where to store the value returned from WMI.
+ *
+ * Returns:
+ * * %-ENODEV	- method ID is unsupported.
+ * * %0			- successful and retval is filled.
+ * * %other		- error from WMI call.
+ */
+int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval)
+{
+	int err;
+
+	err = asus_wmi_evaluate_method(ASUS_WMI_METHODID_DSTS, dev_id, 0, retval);
+	if (err)
+		return err;
+
+	if ((*retval & ASUS_WMI_DSTS_PRESENCE_BIT) == 0x00)
+		return -ENODEV;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(asus_wmi_get_devstate_dsts, "ASUS_WMI");
+
+/**
+ * asus_wmi_set_devstate() - Set the WMI function state.
+ *
+ * Note: an asus_wmi_set_devstate() call must be paired with a
+ * asus_wmi_get_devstate_dsts() to check if the WMI function is supported.
+ *
+ * @dev_id: The WMI function to call.
+ * @ctrl_param: The argument to be used for this WMI function.
+ * @retval: A pointer to where to store the value returned from WMI.
+ *
+ * Returns:
+ * * %-ENODEV	- method ID is unsupported.
+ * * %0			- successful and retval is filled.
+ * * %other		- error from WMI call.
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
2.51.2


