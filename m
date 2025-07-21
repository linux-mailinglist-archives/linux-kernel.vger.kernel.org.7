Return-Path: <linux-kernel+bounces-739762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC32AB0CA94
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8A2A7AE332
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 18:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07872E3399;
	Mon, 21 Jul 2025 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZgPjvW91"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A607A2E0B55
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753122612; cv=none; b=f4D0M7y4yo2CuZjts2Eq1lb7u/H3I9sZusF2ADMW7x30v1ja/hT/uvwb22szTT+jevhwYx8KEEcitX0F8VmSJGVDTQaGYUnvBsBsbk4AKbBA8iYvFPtzuNsCj4964uSAZr0cQfZZhIhyNmuvvWSTCzR87ekVbGphFsDJTChX6xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753122612; c=relaxed/simple;
	bh=WRonUOFFWFBCm1rQa5vJx+BF5lvxtARn9QwJcpcG7rc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jJ02oloExaOgK34/GxPWLN4CoCX24UZ+VNyPrtJCVZH6ll1P7EcfWKX7iYDd8b4mkif8Ta+fWN9C13w8DS2pit9+AZne8Y/+S8ei+X+mY2shM63lt3ESoEJLgCOliXJ1A97PJ324l7rOYEBx9iWSUsS6G+2hCAq38HoYgROmSM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZgPjvW91; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LGPG9K016262
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 18:30:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IEmpumKrhaODJMwEzzkAX1UibK4n47hwRLwgIiszPOo=; b=ZgPjvW91SwqWnmVM
	7faHGCv2Nd/EQxZ2UQ88t66pvS6Q1Owj9obnZyrWbzM/Ix6tWV95FIIg96TEmwJG
	AdyfnLGOZZMq5Blxdyn0bsa/j5VKRgbFAWwJHyrCm+zapDwcnhMeRkyENJUYs9Fp
	+kr4Mi7iao0Lh88B1ysSQEh32j/Ag2WMzMpvf6DnqT1sARgtS6FfhjpGrwQYR5tS
	HvDMFPo37PmuRF5nfHG0EknFYGxQO+6CR02MpY8LxAhe+IlxvLE+G72YI/P3TpjY
	eS+N+kFwNhdBaUvBYLgs5NrfzromZWGOShHDG+xehVwgZ/69U4kTDhLbraMzTYjA
	a9dKhQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048rxv68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 18:30:09 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-235e1d66fa6so36185545ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 11:30:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753122608; x=1753727408;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEmpumKrhaODJMwEzzkAX1UibK4n47hwRLwgIiszPOo=;
        b=YjsFCAg5qrEWf6jqifeVEERtpOepZJL6M12//wXk2FmltBbe0sMYNcuMNTQHgsMyi+
         che7CNkSkDK4Y6fTsbXtXmfAoi4Ayd8YgygFtoVTyD9lOwlhhIqYoc9OP/OySYOyLlEe
         ghgCYqxC7btlHas2R10ZQVYWiZOFndrsBQckGDSkNirU4hp3xS94PLNsTOpfr8r98e/M
         ExsK28UOs4lybEuImJG2Ym8uUAR8xtCRipKnWhrk9iMiqGv7BmQLiVUlL3d60A5LOaUb
         X8PtBaGuXZVfYuXjB+xicdp+CRR8/Epc3HSdAO4k7MYzDt60Kiz0ZEGzcjmm/doVLaoS
         YzTA==
X-Forwarded-Encrypted: i=1; AJvYcCUt8FSYnrjRP8y8pnN+dKoZAyL5s2uUzZ+roU7Yqv9D9NxrfFJ4xZXUPMU5GRE96fhY3pod0/KPkwy3vbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSdKmk+Ap4sxqeru3QXmmyCsbd4H3i6e81fSiTIymNB8TacY1y
	DTHc07ZOD5HBd3x3DEmtm0bYhNsk2gDkQBeK17Lz5H0P0uw3vuzNSiVmQNUgTAArbsAMCncvC6M
	JFB0nODNC7Pbar+6TyGwXh8+PnATF88+xO90IU88ziwYm0sPV9nFVBa8hqmZlTr/wRrU=
X-Gm-Gg: ASbGncti7iqccuU1oIR947OQ8Lv8+AX80g9ROvzB8B2SuiXWwKINSGPaX+Hjzy2VcqD
	3dnQ0PRQMUy0ajZTo+yHdyaXeJXt5A8uokH+OQpDiRAzOfILZF8QYgRFQ17PPm1MYTvLZ2V5GcF
	0/dAKuLYiNWgQCOWYYGsiN2JEjkIWFYVu62Pusn9vorxciJR1FsIJqIvCrNOQvi7cecS8wen9kD
	9xPnjGiPO/vjIjMZTAUqRC0IwJ3NAU8uUte2suVGCEK+ldpv96RLPf2lOnNSh88c0cV6xoKAGFs
	NCRK83iKnHp8SP7biaXXTpvmYINLS8jMQt5lO57LQOh36cON6mLFjRVoc2IoWNU+PNySDih+Pw3
	6
X-Received: by 2002:a17:903:3c6c:b0:235:f51f:c9e4 with SMTP id d9443c01a7336-23e24f49430mr332444855ad.12.1753122608205;
        Mon, 21 Jul 2025 11:30:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzc5T8auyleKAM78gdw7nHnOP+rs5jlCWnnod/hDPSNKGt7NKcw2Z+61prVl/mK5+bZSi2RA==
X-Received: by 2002:a17:903:3c6c:b0:235:f51f:c9e4 with SMTP id d9443c01a7336-23e24f49430mr332444305ad.12.1753122607738;
        Mon, 21 Jul 2025 11:30:07 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6ef4b8sm61414545ad.194.2025.07.21.11.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 11:30:07 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 21 Jul 2025 23:58:55 +0530
Subject: [PATCH v12 8/8] power: reset: reboot-mode: Expose sysfs for
 registered reboot_modes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-arm-psci-system_reset2-vendor-reboots-v12-8-87bac3ec422e@oss.qualcomm.com>
References: <20250721-arm-psci-system_reset2-vendor-reboots-v12-0-87bac3ec422e@oss.qualcomm.com>
In-Reply-To: <20250721-arm-psci-system_reset2-vendor-reboots-v12-0-87bac3ec422e@oss.qualcomm.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753122539; l=8348;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=WRonUOFFWFBCm1rQa5vJx+BF5lvxtARn9QwJcpcG7rc=;
 b=9+F1OboddRi/w7XhvUe0uUkbbtNToE1ZUmtWBNgqJFlLCQJTdSKDU8SJT9yHw4UaPJOQlMa+H
 49ExLAETNSpBfJ+T/ydBKw6NwtFqX4kK7Hc9yXeVs1ZEly2/24D38Vj
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE2NCBTYWx0ZWRfX4VjgGwFzTxZE
 Y5jKcjf59RCeITfvBqwE/Ta1TsHlvs1EUt7VS3+SRlPSMlKdGlg1UKxUv5OR2apRA0+TZbaerUs
 rbpcUe9Y2e7xIXYCGVvwcHKtWRay2sl+KHVgsuSi1xsqwNpX7aq9NdRJBKy9irB7xnPjXaVPH8g
 qzFBybuERK80XuGfLXl4TZXLU1XDdRQgmGSlr4K27R+8X8su403J9Pt7kCdq1MabnWzmCwKr12z
 VQUxxxaE1dSY3mJK8dVmceEaE0rXJI8dIJJ63nh7tuLBJEMRX5G5JIKlkVrizo2tiwB4F07MYGA
 5LNuEpg64yoK4Jesjf4u1YSfFvwCnqVa1q9E4tfv2x2FswitDzWft4JPaghNZRqF06y1QGUgNaL
 FLQbKznp4bRe2cZyEOui41iU6GxJ0/G9Ere0syWGyVAfiRzFxloU91zMiG0XohqHQVX51EI2
X-Proofpoint-ORIG-GUID: aWePyZ5gBWCxdx2qAh54akAokOZQzJG9
X-Proofpoint-GUID: aWePyZ5gBWCxdx2qAh54akAokOZQzJG9
X-Authority-Analysis: v=2.4 cv=OPUn3TaB c=1 sm=1 tr=0 ts=687e8731 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=K9ZbaieeY_mUnl2nlUwA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210164

Currently, there is no standardized mechanism for userspace to
discover which reboot-modes are supported on a given platform.
This limitation forces tools and scripts to rely on hardcoded
assumptions about the supported reboot-modes.

Create a class 'reboot-mode' and a device under it to expose a
sysfs interface to show the available reboot mode arguments to
userspace.

Create the device using the node name of the driver that
registers with reboot mode driver.

This results in the creation of:
  /sys/class/reboot-mode/<driver>/reboot_modes

This read-only sysfs file will exposes the list of supported
reboot modes arguments provided by the driver, enabling userspace
to query the list of arguments.

Align the clean up path to maintain backward compatibility for
existing reboot-mode based drivers.

Add ABI documentation for /sys/class/reboot-mode/*/reboot_modes.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 .../testing/sysfs-class-reboot-mode-reboot_modes   |  38 +++++++
 drivers/power/reset/reboot-mode.c                  | 110 +++++++++++++++++----
 include/linux/reboot-mode.h                        |   1 +
 3 files changed, 128 insertions(+), 21 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes b/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes
new file mode 100644
index 0000000000000000000000000000000000000000..63b3ef1ecc66c73744fc831fa9864592c514bd56
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes
@@ -0,0 +1,38 @@
+What:		/sys/class/reboot-mode/<driver>/reboot_modes
+Date:		July 2025
+KernelVersion:	6.16
+Contact:	linux-pm@vger.kernel.org
+		Description:
+		This interface exposes the reboot-mode arguments
+		registered with the reboot-mode framework. It is
+		a read-only interface and provides a comma
+		separated list of reboot-mode arguments supported
+		on the current platform.
+		Example:
+		 normal,recovery,fastboot,bootloader
+
+		The exact sysfs path may vary depending on the
+		driver that registers the arguments.
+		Example:
+		 /sys/class/reboot-mode/reboot-mode/reboot_modes
+		 /sys/class/reboot-mode/pon/reboot_modes
+
+		The supported arguments can be used by userspace
+		to invoke device reset using the reboot() system
+		call, with the "argument" as string to "*arg"
+		parameter along with LINUX_REBOOT_CMD_RESTART2.
+		Example:
+		 reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2,
+		        LINUX_REBOOT_CMD_RESTART2, "bootloader");
+
+		A driver can expose the supported arguments by
+		registering them with the reboot-mode framework
+		using the property names that follow the
+		mode-<argument> format.
+		Example:
+		 mode-bootloader, mode-recovery.
+
+		This attribute is useful for scripts or initramfs
+		logic that need to programmatically determine
+		which reboot-mode arguments are valid before
+		triggering a reboot.
diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index a17851a303171fd04a47e240f80687541cc85a24..c22d296c9549a1be10523cd11bb0b77a86e53b09 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -6,6 +6,7 @@
 #define pr_fmt(fmt)	"reboot-mode: " fmt
 
 #include <linux/device.h>
+#include <linux/err.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -23,6 +24,8 @@ struct mode_info {
 	struct list_head list;
 };
 
+static struct class *rb_class;
+
 static u64 get_reboot_mode_magic(struct reboot_mode_driver *reboot, const char *cmd)
 {
 	const char *normal = "normal";
@@ -67,6 +70,83 @@ static int reboot_mode_notify(struct notifier_block *this,
 	return NOTIFY_DONE;
 }
 
+static void release_reboot_mode_device(struct device *dev, void *res);
+
+static ssize_t reboot_modes_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct reboot_mode_driver **devres_reboot;
+	struct reboot_mode_driver *reboot;
+	struct mode_info *info;
+	ssize_t size = 0;
+
+	devres_reboot = devres_find(dev, release_reboot_mode_device, NULL, 0);
+	reboot = *devres_reboot;
+	mutex_lock(&reboot->rb_lock);
+	list_for_each_entry(info, &reboot->head, list) {
+		size += sprintf(buf + size, "%s,", info->mode);
+	}
+	mutex_unlock(&reboot->rb_lock);
+
+	if (size) {
+		size += sprintf(buf + size - 1, "\n");
+		return size;
+	}
+
+	return -ENODATA;
+}
+static DEVICE_ATTR_RO(reboot_modes);
+
+static void release_reboot_mode_device(struct device *dev, void *res)
+{
+	struct reboot_mode_driver *reboot = *(struct reboot_mode_driver **)res;
+	struct mode_info *info;
+	struct mode_info *next;
+
+	unregister_reboot_notifier(&reboot->reboot_notifier);
+
+	mutex_lock(&reboot->rb_lock);
+	list_for_each_entry_safe(info, next, &reboot->head, list) {
+		list_del(&info->list);
+		kfree_const(info->mode);
+		kfree(info);
+	}
+	mutex_unlock(&reboot->rb_lock);
+
+	device_remove_file(reboot->dev, &dev_attr_reboot_modes);
+}
+
+static int create_reboot_mode_device(struct reboot_mode_driver *reboot,
+				     const char *dev_name)
+{
+	struct reboot_mode_driver **dr;
+	int ret = 0;
+
+	if (!rb_class) {
+		rb_class = class_create("reboot-mode");
+		if (IS_ERR(rb_class))
+			return PTR_ERR(rb_class);
+	}
+
+	reboot->reboot_dev = device_create(rb_class, NULL, 0, NULL, dev_name);
+	if (IS_ERR(reboot->reboot_dev))
+		return PTR_ERR(reboot->reboot_dev);
+
+	ret = device_create_file(reboot->reboot_dev, &dev_attr_reboot_modes);
+	if (ret)
+		return ret;
+
+	dr = devres_alloc(release_reboot_mode_device, sizeof(*dr), GFP_KERNEL);
+	if (!dr) {
+		device_remove_file(reboot->reboot_dev, &dev_attr_reboot_modes);
+		return -ENOMEM;
+	}
+
+	*dr = reboot;
+	devres_add(reboot->reboot_dev, dr);
+
+	return ret;
+}
+
 /**
  * reboot_mode_register - register a reboot mode driver
  * @reboot: reboot mode driver
@@ -77,7 +157,6 @@ static int reboot_mode_notify(struct notifier_block *this,
 int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *np)
 {
 	struct mode_info *info;
-	struct mode_info *next;
 	struct property *prop;
 	size_t len = strlen(PREFIX);
 	u32 magic_arg1;
@@ -87,6 +166,10 @@ int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *
 	if (!np)
 		return -EINVAL;
 
+	ret = create_reboot_mode_device(reboot, np->name ? np->name : "reboot-mode-dev");
+	if (ret)
+		return ret;
+
 	INIT_LIST_HEAD(&reboot->head);
 	mutex_init(&reboot->rb_lock);
 
@@ -136,13 +219,8 @@ int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *
 	return 0;
 
 error:
-	list_for_each_entry_safe(info, next, &reboot->head, list) {
-		list_del(&info->list);
-		kfree_const(info->mode);
-		kfree(info);
-	}
-
 	mutex_unlock(&reboot->rb_lock);
+	device_unregister(reboot->reboot_dev);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(reboot_mode_register);
@@ -153,26 +231,16 @@ EXPORT_SYMBOL_GPL(reboot_mode_register);
  */
 int reboot_mode_unregister(struct reboot_mode_driver *reboot)
 {
-	struct mode_info *info;
-	struct mode_info *next;
-
-	unregister_reboot_notifier(&reboot->reboot_notifier);
-
-	mutex_lock(&reboot->rb_lock);
-	list_for_each_entry_safe(info, next, &reboot->head, list) {
-		list_del(&info->list);
-		kfree_const(info->mode);
-		kfree(info);
-	}
-	mutex_unlock(&reboot->rb_lock);
-
+	device_unregister(reboot->reboot_dev);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(reboot_mode_unregister);
 
 static void devm_reboot_mode_release(struct device *dev, void *res)
 {
-	reboot_mode_unregister(*(struct reboot_mode_driver **)res);
+	struct reboot_mode_driver *reboot = *(struct reboot_mode_driver **)res;
+
+	device_unregister(reboot->reboot_dev);
 }
 
 /**
diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
index 370228b5161963aac1d75af752ada0e8282b1078..d5ffc36272ba776a6bca4e61356714e07a5b0501 100644
--- a/include/linux/reboot-mode.h
+++ b/include/linux/reboot-mode.h
@@ -7,6 +7,7 @@
 
 struct reboot_mode_driver {
 	struct device *dev;
+	struct device *reboot_dev;
 	struct list_head head;
 	int (*write)(struct reboot_mode_driver *reboot, u64 magic);
 	struct notifier_block reboot_notifier;

-- 
2.34.1


