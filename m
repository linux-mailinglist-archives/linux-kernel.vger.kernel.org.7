Return-Path: <linux-kernel+bounces-851140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2353BD5A4E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD94189B1B8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11E92D24BF;
	Mon, 13 Oct 2025 18:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6cu5Els"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0152D12F5
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760378766; cv=none; b=fwod6WpBYh/Zl3m0YZ9s1FdDi0gacHe+XwOoqfXZ7LIdTNDiubce05fc8avCz/FYwBCe8vl8WBeC3P3aghZG0W1Hdx1fzAuHV0zJjKuev8QHJp8JruXpF0Y4qOGGq+0h1peK7NsCNSBlkycZHURwEKZDP5gN1AZgFrAUc9Ea9Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760378766; c=relaxed/simple;
	bh=q/EU7lSWeXS/l60j+bgP/a6Vbvr7aGyHaBwtx3X4MxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gA0YnXhiSXeGkaFvPWeojgZWpNLMdk5cF5xzH7L/1ssC3WEBCkOzTVvyfzsopoPWDl53Gk1w9L5dzIOtrsCdzwkVYHjCEt6yTpvT2oWwPwQAHYg3vy2InRvJLrPgIWYWfGmo7JwhjGFp0G8eD+B7LLn8Vq7NjJ0EabBWA6cubZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6cu5Els; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so3765724f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760378762; x=1760983562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ADb/Xn7/h9pdMbRXBw0B+VvtgUC71nJ/4n9TIxqgDg=;
        b=J6cu5Els1PGmHtaulzN+m3UGbigTvyxPKCTPkGWd/iRZykBf13q+jJWLwdw6oL8vdD
         BMWnRXZxxhuIuk0a7DU6e7kH8bTnyGSPRlO0ztv8tumfe/PoNLQMPMGIR/vXiDVJnQ9C
         yqYKUKUoYR2wTHZV6POYDETUS4bpxaL5G/+lNXk5HfZRBBmMcP0JPs7lxaf58U1f9sSo
         VggvI8EWBjodbbtVYZ4oMH2LE8iYV+0X26eiyT3goBnNMLLkt1HonftZ383CL2932Lea
         fvbxPoZl2HvSDgrBQbxAo76nLwW08KvocJxLdxGj2rm1DRPlU1fU+/iAL80hmooQJs5O
         c+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760378762; x=1760983562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ADb/Xn7/h9pdMbRXBw0B+VvtgUC71nJ/4n9TIxqgDg=;
        b=HBHIyxhPbc+IRUi4L6lf0sxVOPUMqbv3YHmL+BDi6rqqOL0pPK7KGQIgtJB8rvwXMo
         KC62/nb/Z3/vB3hTOqerZodMRDoO41DoXQV+W8Gzta7PEcmVfQJJ4CgBPXv7wjWvS9Rd
         JkunC9dHMZbV8fiPQcL/IpD7GMpA9NHzgm2oPpG+UVQHGkLkqMTwFOM2SB5VgFzvOlUw
         rJo+FpnfgSdqfN3EAmLuwkX5WIQ1JXh+u3Kb3TgqjawgQnC+0iADtMvd5R+RtTOFlqpQ
         mzn8FVP7BxP4oWoF7jOdObbbFX1q7HHvUCKF15ULTVHZdBuPnr2nQLTI1z7EvaG9D8jA
         iXUQ==
X-Gm-Message-State: AOJu0Yz3rZOEXBf+gyJUdS4ZTZmGNi1Ir8AK0gCTKQk6flPM5a+XquaB
	i0Yo9HHo3v6onhbPRt808ku11O3HxCsGJs7GpJmUJ2zUxU82E74hYdPQ3dbkiQ==
X-Gm-Gg: ASbGncuYypwwtZj8diIuJfm56Oh/D5w+I30Nfk1M5XADdntm1oM8tHsx8KvfHwmh8C/
	FVENC8zow0kHReDsdDYCznWUnbeVbtmIc2tjNa028scVAM/sbikooVZXALlMUnzwXdVoYQnm4nI
	AO+CZxBkvSjPEVcpwd8BuOqQ3aeyE4CtgaIGpxrgGYjpz8r36iNh7f8OI36kLij6Lj9b3Qe/S5X
	BL1vY/uFtQ9OeOaVTJ2pteo6O8QuGyJZ8QkwSa8ONpay+vMMz0aDYI9+NxuR6FMNZOYdUhYi4SR
	EfkucV+cSfZcwIcszhcOd9amPD/UIeB1AzSJ0jjRb8/rmRle6xoIL7a1yG9voz6RSOzsykmBKQB
	D6EyDPPaz+GYnQXZTVhsAnWLznSknEH8PJaX8SPq2WpO3zfutE5SA5Eq3
X-Google-Smtp-Source: AGHT+IEKmPlcTvYER448tFCZNUAmAkBTquXTa+SftxeAMIbr1QS03sKoftqWg6i6tEKdqiam1GZO9w==
X-Received: by 2002:a05:6000:24ca:b0:3f3:3c88:505e with SMTP id ffacd0b85a97d-4266e7dfcb8mr14275571f8f.29.1760378762190;
        Mon, 13 Oct 2025 11:06:02 -0700 (PDT)
Received: from denis-pc ([176.206.100.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce589b3dsm19933428f8f.24.2025.10.13.11.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 11:06:01 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	"Hans de Goede" <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Limonciello, Mario" <mario.limonciello@amd.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Alok Tiwari" <alok.a.tiwari@oracle.com>,
	"Derek John Clark" <derekjohn.clark@gmail.com>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	porfet828@gmail.com,
	Denis Benato <benato.denis96@gmail.com>
Subject: [PATCH v13 4/8] platform/x86: asus-armoury: add apu-mem control support
Date: Mon, 13 Oct 2025 20:05:30 +0200
Message-ID: <20251013180534.1222432-5-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013180534.1222432-1-benato.denis96@gmail.com>
References: <20251013180534.1222432-1-benato.denis96@gmail.com>
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
index 68ce2c159ae1..3b49a27e397d 100644
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
+	if (requested >= ARRAY_SIZE(apu_mem_map))
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
index 10acd5d52e38..a4f6bab93a6f 100644
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
2.51.0


