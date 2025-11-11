Return-Path: <linux-kernel+bounces-896046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE684C4F8D1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CE994F51AB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DDA2EB875;
	Tue, 11 Nov 2025 19:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xs5okY7N"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F212E6CB8
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 19:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762888274; cv=none; b=Ok4hRx+E1XdINirQgIvIXtkAv0OP8VcgfoopSagmg158oQBvRSelQIABi4DHlTzP84g2B1qYWUA2vqosSnadzZwVlrimfKkjaEOJTTuSmz2f/ACGQ4VZuU3nOSeI5gVL+mRNjbN2Rb/NpUDOXfiC1+O+tHLHTudcQSIe+DkVwsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762888274; c=relaxed/simple;
	bh=+wvMnVxHrApSqeHBeS6IfxE1DB64obJH6I/jWS//pGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G0Fqnf50TVqhZW2iGOcTno+mMEjSc+e4O59O5UdvydNQOg9txNe0ZLHMFlD/vxIYahPScj4K0oJOfZ5kPivsmjjcIxBTfYqGNun8xIsDg23NKSMTquXK3jxaSCIH4yLI9WryvY8kdu/Sn9Le9xJIJOsQM0o8gYUgVXMnmKiN8oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xs5okY7N; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762888270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9CURJ2PNGNX1D25vJOg69mo8wMy4VTwdK2/mBMrUWVI=;
	b=Xs5okY7N4/7/PhBZmE2pVszYChbkIrUmdpew2AlgFZuvrk7rZx1t0KK8gAWxvwFjEh0k/R
	EvuE0q53veobLwiZqkLQr+GipHxBRo0NunDDm7WLda8oRD/0Tb4OYo6u3tEZV0ZbkafSgH
	0/E4V5qvF7YvotE1W1LYlVypI2A5dxo=
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	"Hans de Goede" <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Limonciello, Mario" <mario.limonciello@amd.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Alok Tiwari" <alok.a.tiwari@oracle.com>,
	"Derek John Clark" <derekjohn.clark@gmail.com>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	porfet828@gmail.com,
	"Denis Benato" <benato.denis96@gmail.com>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH 1/2] platform/x86: asus-armoury: remove unused macro parameter
Date: Tue, 11 Nov 2025 20:11:03 +0100
Message-ID: <20251111191104.1401105-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Increase consistency of macros used to get/set uint attributes: remove the unused _fmt macro parameter.

Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/platform/x86/asus-armoury.c | 4 ++--
 drivers/platform/x86/asus-armoury.h | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
index d57fbb5dc3d3..9f67218ecd14 100644
--- a/drivers/platform/x86/asus-armoury.c
+++ b/drivers/platform/x86/asus-armoury.c
@@ -527,7 +527,7 @@ static ssize_t gpu_mux_mode_current_value_store(struct kobject *kobj,
 
 	return count;
 }
-ASUS_WMI_SHOW_INT(gpu_mux_mode_current_value, "%u\n", asus_armoury.gpu_mux_dev_id);
+ASUS_WMI_SHOW_INT(gpu_mux_mode_current_value, asus_armoury.gpu_mux_dev_id);
 ASUS_ATTR_GROUP_BOOL(gpu_mux_mode, "gpu_mux_mode", "Set the GPU display MUX mode");
 
 static ssize_t dgpu_disable_current_value_store(struct kobject *kobj,
@@ -561,7 +561,7 @@ static ssize_t dgpu_disable_current_value_store(struct kobject *kobj,
 
 	return count;
 }
-ASUS_WMI_SHOW_INT(dgpu_disable_current_value, "%d\n", ASUS_WMI_DEVID_DGPU);
+ASUS_WMI_SHOW_INT(dgpu_disable_current_value, ASUS_WMI_DEVID_DGPU);
 ASUS_ATTR_GROUP_BOOL(dgpu_disable, "dgpu_disable", "Disable the dGPU");
 
 /* Values map for eGPU activation requests. */
diff --git a/drivers/platform/x86/asus-armoury.h b/drivers/platform/x86/asus-armoury.h
index 5e1ab729277a..8f7e5da087a6 100644
--- a/drivers/platform/x86/asus-armoury.h
+++ b/drivers/platform/x86/asus-armoury.h
@@ -81,7 +81,7 @@ ssize_t armoury_attr_uint_show(struct kobject *kobj, struct kobj_attribute *attr
 					_max, NULL, _wmi);			\
 	}
 
-#define ASUS_WMI_SHOW_INT(_attr, _fmt, _wmi)					\
+#define ASUS_WMI_SHOW_INT(_attr, _wmi)						\
 	static ssize_t _attr##_show(struct kobject *kobj,			\
 				    struct kobj_attribute *attr, char *buf)	\
 	{									\
@@ -101,7 +101,7 @@ ssize_t armoury_attr_uint_show(struct kobject *kobj, struct kobj_attribute *attr
 		__ASUS_ATTR_RO(_attrname, _prop)
 
 #define __ATTR_RO_INT_GROUP_ENUM(_attrname, _wmi, _fsname, _possible, _dispname)\
-	ASUS_WMI_SHOW_INT(_attrname##_current_value, "%d\n", _wmi);		\
+	ASUS_WMI_SHOW_INT(_attrname##_current_value, _wmi);		\
 	static struct kobj_attribute attr_##_attrname##_current_value =		\
 		__ASUS_ATTR_RO(_attrname, current_value);			\
 	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);		\
@@ -122,7 +122,7 @@ ssize_t armoury_attr_uint_show(struct kobject *kobj, struct kobj_attribute *attr
 #define __ATTR_RW_INT_GROUP_ENUM(_attrname, _minv, _maxv, _wmi, _fsname,\
 				 _possible, _dispname)			\
 	__WMI_STORE_INT(_attrname##_current_value, _minv, _maxv, _wmi);	\
-	ASUS_WMI_SHOW_INT(_attrname##_current_value, "%d\n", _wmi);	\
+	ASUS_WMI_SHOW_INT(_attrname##_current_value, _wmi);	\
 	static struct kobj_attribute attr_##_attrname##_current_value =	\
 		__ASUS_ATTR_RW(_attrname, current_value);		\
 	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);	\
@@ -227,7 +227,7 @@ ssize_t armoury_attr_uint_show(struct kobject *kobj, struct kobj_attribute *attr
 	}
 
 #define ASUS_ATTR_GROUP_INT_VALUE_ONLY_RO(_attrname, _fsname, _wmi, _dispname)	\
-	ASUS_WMI_SHOW_INT(_attrname##_current_value, "%d\n", _wmi);		\
+	ASUS_WMI_SHOW_INT(_attrname##_current_value, _wmi);		\
 	static struct kobj_attribute attr_##_attrname##_current_value =		\
 		__ASUS_ATTR_RO(_attrname, current_value);			\
 	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);		\
-- 
2.51.2


