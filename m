Return-Path: <linux-kernel+bounces-853584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEB1BDC0A1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E5C44F15DF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC1A2FFDE1;
	Wed, 15 Oct 2025 01:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7fqHehj"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372DA2FCBF5
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760492986; cv=none; b=QA3/20NDbbvN2LpXEUX5Omh8+pTGQwB7QJkU8cgUjeInza4omO9onkVg75SxZwUN9zxMgY3UgKKzT9CG09mZhzvx9G4nm8nvfowntPDSRB74depj/pZwPWJXQ8NDqhbAUcn3klHItHPN8YDkvJ+ywPdoyMW2tRM7eQgyC2zdW4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760492986; c=relaxed/simple;
	bh=q/EU7lSWeXS/l60j+bgP/a6Vbvr7aGyHaBwtx3X4MxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGS9GeDcWOP/Y0cS6qb81wGDtFRWDTvIyEQBcuI2cIPuoTvmd+7DvFjsqOQRhGrSIRcBgGLTyr4BGHmLB/ZZsO0QFWci9+TcYMV4YQ/XLwfRCFNXUXcOz9NY/jyzgmfW4U895iaGaXFf8NFmz/cGYG8tlS3NZVqIFaBRxti0hWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7fqHehj; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e6c8bc46eso39772465e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 18:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760492982; x=1761097782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ADb/Xn7/h9pdMbRXBw0B+VvtgUC71nJ/4n9TIxqgDg=;
        b=L7fqHehj9LRh7qWvAorLQEyjmQu1EMFsvakIHCx2b5B6OYgFWoIFxXPkO43URVY/EF
         m551W5FxtlLRumdDkIlElbfjs8tWUApzyu8RK2VhDpBsDDvAmK39O9/A+f0JGaIxR6wu
         1mZtr2qCc58NZ6bCHGjn1D2VMFXj7KzkDLpxxhot+t52duES6xaPCn5Kr28ub61gUn6j
         hcheUFZzB0zNBxVauzjnkZZOffqcrvsobvvVt2uoPpxjNy4KtxxWtVG3E62e2LDoj2Y6
         KFbsC2ydtP605whLQJD8q82bn4rnWyXWUhDqj0lS2Car5BZt9NYuxgcKL018aNCqwO0B
         cquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760492982; x=1761097782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ADb/Xn7/h9pdMbRXBw0B+VvtgUC71nJ/4n9TIxqgDg=;
        b=ncVUo2f0uO0cGAcgmPzjPd/jw3BQdaqwCn9oiWGTj62fDesIff6rPjEY2M6/8KAYtA
         hpMFlIE+aQCZOV2vvKyM3HsBoYLiUDIj4wNRvW7HE9iBmOkFXYO9PtwaVa1zpfk+Y3Jn
         IxOl7hxZ7098FJ6ay1V+a6B2Lvuj7txVsPYMPj1ltrN7ZOdy0ub0Y+2YhcC7mdUX5hLM
         ws59dKH/eXBu/BEAY1X0tzgHk3qaP2vEjmaqBet0pQFJT5QQWLNBMk9renUIY07YykD/
         JYdGvynb56eST5TcIZfIbYDaFUt1m+0oMHZZUmxOnKnDSmD/kc3Yoaci9n+/ujfKknlD
         w6Ww==
X-Gm-Message-State: AOJu0YxAGG6iKnCWxv414Tx3AOwKWwjeBDxg1oTftIf1yLzDAhB13tAo
	EX89QC0f/xtqtWM46vVBjZ1FtmYzqn4aT4lLztXQ7MLNu5q4vHdUvwqOLTz01Q==
X-Gm-Gg: ASbGncsStut3PN3QNQMEPqHbZcnjuWXPCc5h6laVXj5wlN1ymgfj6i2o5PaBvQQCbRb
	IA21wZ4NjuO8i35HO5cLSlphmCIFO2/MhYCmsUDCUA2vDQ+DLUomPGMImiWk17ZsBdmoLovm0p0
	oQpKnydpH8lwo6/WkKe7t5JKYpDu0GMMFrNZNKjJwUtDyKdzCAM09Er4c0TV3yOziEZsykBJM0n
	xSyB0oHu4Lrf7VuxU7UQ9e32dEjH1M1hQldY7rBbiEeVCVRIJzxi9c1sR6ml7V6i3Ii14mWRFjy
	lBGI9Coz5TTIEXMvDyIDcRmatdvcHFNRYnwvfFvGVgWQcF3Rkg6xCEP8BHQzThvpNT+a9NsLULK
	/qhOogbtGCqy+M7uaVWxeQO1gPHzlrEN7VnHTQnsOiiEfrg==
X-Google-Smtp-Source: AGHT+IHtnJJvqvTlB6dTJyJLwdEbvLwZPN2hLkWi4mvxf/sdRLfS2GKYYjax96m/EWTUBBGMtLRVJg==
X-Received: by 2002:a05:600c:c4ab:b0:470:fcdf:418 with SMTP id 5b1f17b1804b1-470fcdf04bbmr7202705e9.27.1760492982329;
        Tue, 14 Oct 2025 18:49:42 -0700 (PDT)
Received: from denis-pc ([176.206.100.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57d49bsm27368995f8f.10.2025.10.14.18.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 18:49:42 -0700 (PDT)
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
Subject: [PATCH v14 4/9] platform/x86: asus-armoury: add apu-mem control support
Date: Wed, 15 Oct 2025 03:47:31 +0200
Message-ID: <20251015014736.1402045-5-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015014736.1402045-1-benato.denis96@gmail.com>
References: <20251015014736.1402045-1-benato.denis96@gmail.com>
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


