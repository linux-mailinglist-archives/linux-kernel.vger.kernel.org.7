Return-Path: <linux-kernel+bounces-757823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE21B1C717
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863D21898384
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 13:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F061328D857;
	Wed,  6 Aug 2025 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4gGkOos"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5850C28C84B;
	Wed,  6 Aug 2025 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754488438; cv=none; b=XNnxg4DBgD3lcdG1bOsiaUGRjqIE4JyuKXyCeRTi+3j4HMuTCXCD0TmTJVf35xQoVdOcJGSrVHzdiD4+rnl22rzUgBqmxDt82df8o0LhLgNosqJj+4Gi6yakt/tl9Je4hojVZoBy52Cbu39M3I7h2O6j6NWfxnA4an+TtRlDAxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754488438; c=relaxed/simple;
	bh=90RMMBjibEGt8GZYiDvTxOAOpHgjBdvIYHYsAqX6AEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNz3kEOu/NhJzIAu7baCHr1tbPDd7HrS/lKrR4PCzudJK6XSm35OGBMNjE7zA9f1/gFdg1XmI6934AKV5f3XkmQdxX5ZDmQ5ulJXD8+OJU7opM1FwohOl8JfpnwNdT3uMzJcA+BAK0UQ42pUeLBZKQLlQGb95C/DFT67plFc/FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4gGkOos; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-458b2d9dba5so31760685e9.1;
        Wed, 06 Aug 2025 06:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754488435; x=1755093235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NHWDngrAm/+zA0LnuSxz03WMYZ9UMxw00FDXT0iChU=;
        b=U4gGkOos+XkpHTooEFCCiWHiMlP0iedlziMtFyEjJzCn9Z9eN4cDS5ffWizyAXuF2g
         qSFB0wZpLQencAebx8SamrL6cSn4SieZ+PJVkKKhabp2Yvn5XECEIqffQ3DQZf/zJNk1
         2TODM/2CM0p28veoct9CKFAZN6ew7HCCJPet2YZTCV4djG5UkDtwItm7Q3XFpMHtveJh
         WLiKY2eG+XEqoLj7smYxvPbgZu28WOyS1hHQtio1iXv1tyvvbPr7w5c7pSneBMsAzHW6
         Rb4LbvFQX1XS44PEzsTJZ4Lmy1ZcMsVYzZTVzSXUyFXROylwUo/ozAFthpiOmUEqYIY1
         nK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754488435; x=1755093235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NHWDngrAm/+zA0LnuSxz03WMYZ9UMxw00FDXT0iChU=;
        b=fFs5xM0PR2vTMH09Z2eER7sa9hXcjZ/s0Bk3uv2SQh8v0voCNHxEwX/wVwr4GWl/pT
         ip8c30PNqmAez2pT2zYzBZuhasSS/yWVM6F1MmbSJv0rC3a1LfXPund/Rqx01ZNq5iwM
         pQDfbNP9Yet3lXtO9ZO3oBM1eTn9cRW1XsfWBRLcA+gEK1JTayYv2ZhfSzH0batLYaeU
         NiQ0gEAMFigRheb/9suRzqSDhfRMULOsy6+vR6K/GnFQ7/r4HsXShM1m0xjotFr4AGEP
         KYKWpM3FrZ11PlXYTHo86/DtYIhOBQ/tgwgus55i/zmySDKSP3kberF3j4gsom9uEIty
         Wz8w==
X-Forwarded-Encrypted: i=1; AJvYcCWyLogoWNMafatJQgzCcRLoJS5r29J9nHWWpRbXHP67l4Jkvhr3Zsr1l3Aja2H2ZhetmA621Er6FeZlmYucswsCuBgQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3f4PeqDjAR0Bl9Xi4evJw7J+s7feGj4zLEt9D2oGfLbZnd2FA
	G8Vo9OiEtbaf+0D3wkm3DdFsrBr+wuv7rhFuPv5W/6I2oMsuQQjax8xIiOsLHA==
X-Gm-Gg: ASbGncspo4Xu2BV22teSKQ7hiW/ejIEdp2G4MJOiO5vzbAaIwB/pBlJn2WfrWL23Yxd
	O7RTgwmTiooYlN8muxnjTU4nFQdRQhW70CnT0o2c6u8+495skuWx8OZXM9VVKR9cjuezNfd+8si
	qlwPQDiEWFPYu7fEdsukbMJrjLK8X9b5w2MfvbgZ1y+a2YdXxBtSg1LhFSKzUVyJe5GxF5wwK/0
	yONcU0jH8r4l/QmaO6Mi11DNVhDVbwUGEj8EvoSjDIUUcmWf0FfIIVVMq0YX9X8qq+cl0vJhrQN
	yQPkWdDG3PfJRZ9VP76P68Asxa38TxLbvvyVksYwFSUGI18bHjSDx0RuiX5In4TCPt1QA7LfFzB
	wlFbtDIfL6vfhnStBT3B63Ak8
X-Google-Smtp-Source: AGHT+IH5OQWwWaaGVRjkdkVPkU+/fXpOv7iUPGPHF1gfcu6sEvrDpqyZB+NLmDJXgBhzSErKnSafHw==
X-Received: by 2002:a05:600c:310b:b0:459:dde3:1a27 with SMTP id 5b1f17b1804b1-459e7103893mr25716755e9.26.1754488434422;
        Wed, 06 Aug 2025 06:53:54 -0700 (PDT)
Received: from denis-pc ([151.49.205.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3bc12csm23646087f8f.28.2025.08.06.06.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 06:53:54 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	mario.limonciello@amd.com,
	"Luke D . Jones" <luke@ljones.dev>,
	Denis Benato <benato.denis96@gmail.com>
Subject: [PATCH v10 4/8] platform/x86: asus-armoury: add apu-mem control support
Date: Wed,  6 Aug 2025 15:53:15 +0200
Message-ID: <20250806135319.1205762-5-benato.denis96@gmail.com>
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

Implement the APU memory size control under the asus-armoury module using
the fw_attributes class.

This allows the APU allocated memory size to be adjusted depending on
the users priority. A reboot is required after change.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
Signed-off-by: Denis Benato <benato.denis96@gmail.com>
---
 drivers/platform/x86/asus-armoury.c        | 81 ++++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |  2 +
 2 files changed, 83 insertions(+)

diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
index 68ce2c159ae1..e458d23d020d 100644
--- a/drivers/platform/x86/asus-armoury.c
+++ b/drivers/platform/x86/asus-armoury.c
@@ -394,6 +394,86 @@ static ssize_t egpu_enable_current_value_store(struct kobject *kobj, struct kobj
 WMI_SHOW_INT(egpu_enable_current_value, "%d\n", ASUS_WMI_DEVID_EGPU);
 ATTR_GROUP_BOOL_CUSTOM(egpu_enable, "egpu_enable", "Enable the eGPU (also disables dGPU)");
 
+/* Device memory available to APU */
+
+/* Values map for APU memory: some looks out of order but are actually correct */
+static u32 apu_mem_map[] = {
+	[0] = 0x000, /* called "AUTO" on the BIOS, is the minimum available */
+	[1] = 0x102,
+	[2] = 0x103,
+	[3] = 0x104,
+	[4] = 0x105,
+	[5] = 0x107,
+	[6] = 0x108,
+	[7] = 0x109,
+	[8] = 0x106,
+};
+
+static ssize_t apu_mem_current_value_show(struct kobject *kobj, struct kobj_attribute *attr,
+					  char *buf)
+{
+	int err;
+	u32 mem;
+
+	err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_APU_MEM, &mem);
+	if (err)
+		return err;
+
+	if ((mem & ASUS_WMI_DSTS_PRESENCE_BIT) == 0)
+		return -ENODEV;
+
+	mem &= ~ASUS_WMI_DSTS_PRESENCE_BIT;
+
+	/* After 0x000 is set, a read will return 0x100 */
+	if (mem == 0x100)
+		return sysfs_emit(buf, "0\n");
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(apu_mem_map); i++) {
+		if (apu_mem_map[i] == mem)
+			return sysfs_emit(buf, "%u\n", i);
+	}
+
+	pr_warn("Unrecognised value for APU mem 0x%08x\n", mem);
+	return sysfs_emit(buf, "%u\n", mem);
+}
+
+static ssize_t apu_mem_current_value_store(struct kobject *kobj, struct kobj_attribute *attr,
+					   const char *buf, size_t count)
+{
+	int result, err;
+	u32 requested, mem;
+
+	result = kstrtou32(buf, 10, &requested);
+	if (result)
+		return result;
+
+	if (requested > ARRAY_SIZE(apu_mem_map))
+		return -EINVAL;
+
+	mem = apu_mem_map[requested];
+
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_APU_MEM, mem, &result);
+	if (err) {
+		pr_warn("Failed to set apu_mem: %d\n", err);
+		return err;
+	}
+
+	pr_info("APU memory changed to %uGB, reboot required\n", requested+1);
+	sysfs_notify(kobj, NULL, attr->attr.name);
+
+	asus_set_reboot_and_signal_event();
+
+	return count;
+}
+
+static ssize_t apu_mem_possible_values_show(struct kobject *kobj, struct kobj_attribute *attr,
+					    char *buf)
+{
+	BUILD_BUG_ON(ARRAY_SIZE(apu_mem_map) != 9);
+	return sysfs_emit(buf, "0;1;2;3;4;5;6;7;8\n");
+}
+ATTR_GROUP_ENUM_CUSTOM(apu_mem, "apu_mem", "Set available system RAM (in GB) for the APU to use");
+
 /* Simple attribute creation */
 ATTR_GROUP_ENUM_INT_RO(charge_mode, "charge_mode", ASUS_WMI_DEVID_CHARGE_MODE, "0;1;2",
 		       "Show the current mode of charging");
@@ -414,6 +494,7 @@ static const struct asus_attr_group armoury_attr_groups[] = {
 	{ &egpu_connected_attr_group, ASUS_WMI_DEVID_EGPU_CONNECTED },
 	{ &egpu_enable_attr_group, ASUS_WMI_DEVID_EGPU },
 	{ &dgpu_disable_attr_group, ASUS_WMI_DEVID_DGPU },
+	{ &apu_mem_attr_group, ASUS_WMI_DEVID_APU_MEM },
 
 	{ &charge_mode_attr_group, ASUS_WMI_DEVID_CHARGE_MODE },
 	{ &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index adbc4e0e7576..d5f4b1de6d54 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -137,6 +137,8 @@
 /* dgpu on/off */
 #define ASUS_WMI_DEVID_DGPU		0x00090020
 
+#define ASUS_WMI_DEVID_APU_MEM		0x000600C1
+
 /* gpu mux switch, 0 = dGPU, 1 = Optimus */
 #define ASUS_WMI_DEVID_GPU_MUX		0x00090016
 #define ASUS_WMI_DEVID_GPU_MUX_VIVO	0x00090026
-- 
2.50.1


