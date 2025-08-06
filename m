Return-Path: <linux-kernel+bounces-757821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDF1B1C714
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BDDF189500A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 13:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B951128C866;
	Wed,  6 Aug 2025 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JW+qeBp3"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4914228C2AF;
	Wed,  6 Aug 2025 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754488436; cv=none; b=pYUOhOpMNWjM27szJiH0A6D1NjrGzb2+Rlfq1YcnjCp4jaRw0qClT00ebZL13tpIspLv5L3E477bfNWhx9EU0EyDnnU7Cr0ag1/11njVobH6kt18x8Qp9MG5KOXMlhb2ziqfbvlXB3HFa9GW/34f1tzn265bhdBHW4k5enAGezI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754488436; c=relaxed/simple;
	bh=/MXUHVu4SjGsnCzUU6TgwBqYmyeo1SwjIbmUQZU/rGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nuqVCnTIhOiTCDaJvc3AJGmFzArr9eXAO5VWo5kBgHAFc+yuJCjAUqNBEoV2oD7blgT1bRVmrjvwCerB7ZcsqZx9Zlb1xi44t61U3zwZnIzEML4KroQY6FFGLEOxxixnEco500yzEE+u+rsQoo64JWjXYWQX/o+GlNQVow+xc7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JW+qeBp3; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4589b3e3820so65862815e9.3;
        Wed, 06 Aug 2025 06:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754488432; x=1755093232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tndjvhti5T2Zl4Ol7qDiEmHOBsRTv/ll2I8LWQdmTvM=;
        b=JW+qeBp3UfdxaBSCek7Q77bFnOGs/z932zDO17l6Rdevl5dFmspW1T9NC17B36jLfy
         38x83wjXYsH8tPcN3IyT801oKcqET0nF97CqH5QpW3+8kpfkE7M+qizvVAKiKz6IndHe
         o7ji8O0QOLvkzSmQZiOfXyWwbDIpagkxOWHER9RIW75Ch6xresz2DLv5iUG0CpVG0z6U
         Q5y3Gj5mg3oyHxYCNjAJ+/zjItaNAwjdPHnLWh4FosKstLntHNkBM3/JV/3jebm5IH6D
         8z4bQbx92nZEwuzMhMVvs53osLHUlbJYW1DPX2tMSgs3ozOFohr6Jc1ZSRzPamn2QK6S
         iSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754488432; x=1755093232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tndjvhti5T2Zl4Ol7qDiEmHOBsRTv/ll2I8LWQdmTvM=;
        b=F9YS4fMG8eP+x0g22w+MdsXkZiL5KXfcbvu3PUzjwpPUnJVvef+6fS1kXJEuY4eR4Q
         dLVTbbJP5bwGQE71u6l6ckXdnU/oaEMwwQqE0LPhNnDZQjAFlFoxKPtJZ47qr3g/TQRx
         QwB+nDYR9o/vG4oMktNbq0cPGXj+A1AG6yXn6cZx5vEWKdY8N+etxT/kVvd9qVfkh9pG
         KBlS+XQ+Mc4++Yvy7EcHYLiPxbKWlThXxiPONN7bFgEuP8Iiv9k/mf3m/3gkhr/bNZ1K
         BkK/NkuuwQFltIKQ3o/1yEe+ubKH7q3aYf6Azj3QJ/ED7v8qQNvj5SLKNyTgZ1OICdmz
         3qFw==
X-Forwarded-Encrypted: i=1; AJvYcCXZVcR9zkGKhHpjuaaZbTVB3VZOM5zqXQIBZ1IQu+Yx7NAe9m72uWaV6zqnpTyowzzRcz2rixh3asEe1xq9MB1l/1eD@vger.kernel.org
X-Gm-Message-State: AOJu0YwnDVjNgz9rxsbaXuDqDWAcqU6eMFJRdnxq30azCRQvcY6Xu3TX
	1V4BiMjwRpruHjsUWDUHZl7OP2IkcTV82xv0/FiYqndX/0XPFzp/NhyGhPOpqA==
X-Gm-Gg: ASbGncukpSPuBg8xIjKEsVXEV0OiPI1Eu+oqiOFQqX9NHPiFpMAVWJC/SXlUvSBaQO9
	qnezXvL3L0W2UBCfVW+kQU53MW4YUSb2pW7VmpGwLjljUnjMyqcecEpx+nPSl9g7xmwxbqZBlYG
	feYYYmlibP/UW/uuZl2BY4NNZwoqOlk6Ip4cp4wRxY0dMpucUMMfXDwm8beds+bClIUfjd4IXlz
	0jbsFYgDDIq5pfjIYk+62v2rDcBRWeo/FrBaNaE2msv2lDMjIq0HEknrmB6jP8qah5ulV1mWHhu
	pOc/igczpKFxlifEw5ZKEC0Ef/+yeliwrnJ/a3zBGs9HUkRrfE2LkH5JZ0jVx68+g6wCItBlEWj
	FqUTPkbodZxTEBPsjesYxp+c5
X-Google-Smtp-Source: AGHT+IECcfE/931pKMPlTRE6iP9MtGOn+1MoMn/GD56zWy4bt2r2s/pS5Yxce4OoQuB5tSgAsRrXvQ==
X-Received: by 2002:a05:600c:a06:b0:456:1dd2:4e47 with SMTP id 5b1f17b1804b1-459eb738ba4mr14403255e9.15.1754488432077;
        Wed, 06 Aug 2025 06:53:52 -0700 (PDT)
Received: from denis-pc ([151.49.205.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3bc12csm23646087f8f.28.2025.08.06.06.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 06:53:51 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	mario.limonciello@amd.com,
	"Luke D . Jones" <luke@ljones.dev>,
	Denis Benato <benato.denis96@gmail.com>
Subject: [PATCH v10 1/8] platform/x86: asus-wmi: export symbols used for read/write WMI
Date: Wed,  6 Aug 2025 15:53:12 +0200
Message-ID: <20250806135319.1205762-2-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250806135319.1205762-1-benato.denis96@gmail.com>
References: <20250806135319.1205762-1-benato.denis96@gmail.com>
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
index f7191fdded14..e31e0264a160 100644
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
2.50.1


