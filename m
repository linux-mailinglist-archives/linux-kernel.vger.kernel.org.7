Return-Path: <linux-kernel+bounces-747161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92ABDB13085
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 18:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D13E73A4650
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 16:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB63C221269;
	Sun, 27 Jul 2025 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="enerPKAI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225EF220F49
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753633545; cv=none; b=O+lilgwDDqxs7lONDgtLfp9BqBOM7TmvmIoZemzEEVI+BGkkJrwDdDX3ra7NUd17QvM7/t9aJbyudAqUAPy0kXNFSKxNwVgZzN64Fo4giksFryZmjOMr6egKq3NKHc3I55pIMxQKX9DB3oO8DPGxFM+94ib+1xSesuROP78ZoRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753633545; c=relaxed/simple;
	bh=UwAuk0mKb9rcWWrnqsEINzklGj3BCiY6oFtAQLs8bEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V5fIA3JJcEE7SORBcXmTHnZfR8npxIHhFZQKeLwd2IwUIakpUGwYNY1TcodqwE200nQlHdYUdHtNVvGCIx/CQzW01S2+PjT42Fqe9XVFwKvOcNthEJ5KbAWefFQQxNYb7xfZ3dTA72vHg+9JI/eydlLPkqfnnoJa99tfZXLr57c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=enerPKAI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56RDcfOv002055
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 16:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kjg+v7QmECaMK4O0WsmDewSJVWQyUa1xzMTrttC4DDk=; b=enerPKAIDY9iQur+
	upaFxsO25ySiMDPy3qQArSQxC+I2irkVoo4+2300XOd9qzQ2YHaeA81CvKi4ZX69
	9L9Z/yGrQhgbhK7E4/XYg/GNIyii7W1W+JHQ+TbjrH+HXyDTQao2CmA9I3RpZGjP
	8zsTgesorYKkKON7WCPI3HcPdaEXaYMdAzN9k0OPhpMRwQRsBzrUkl59I8yA7gOo
	J82r72GwebN3IZ4cC3nFZ4MJBHUOzD8Y9BSyncgK01e+ApQzwvZ7LuX7hZNyiKr0
	fo36EHW/rQhN5HKdkngLyzTYLZtbVY+KdT95Ua9wRa5jPzLkFmmEgkdQ8x6jA0Aj
	dVyQWw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q3xjath-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 16:25:42 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23ffd934201so5497455ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 09:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753633542; x=1754238342;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjg+v7QmECaMK4O0WsmDewSJVWQyUa1xzMTrttC4DDk=;
        b=qh6eVF1rIp6OApCKV/n9htobNTEAtIs5F7FgQWu+Uwg9kkrLwqn+Adhxxta5IABHhj
         HIQOAf8X/K8Fchvo2SpomLs0H4Cl8JaSMsU/PfZOUVA8QrT5jNpA4EwSFpSQa8B1ABW/
         bAB9UeywSiXr+8bbAoRrhgGTErrWRKuzTlDsPtwye7KCo/JsAFrjh/lQBLDsXC+qHfcr
         5qzS8KLHxS1YM+gxY5CNGJYYmwmd+Y7bMUccCHy263752kSyA9vrkj5gQfdef2YY6FHq
         Au2gbqM876ffuFGCdpEKo4WKo73qSn+a9N60z9cjWrfi/JpJVkOYNgEM8mh6vjdahvZ5
         KA+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUcTgEoJ+c1mlfZwSP/N7JSixfLdyA5XziS0SC2pMw0aw+77PrPVUEJFoHJ2dVeK7yEtmd8BDKj+oFyK9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8hHmVdvFuytnaNUMs7vcBscVZTTdLUiEAnFKkAFP7BHbSrbPW
	SlwLPc6UYY9vcBbFa69o2DXUOk+DoYn2g//bfsb7ZEFpqKcQisCrpoynS3Qmaaj0nWNfiyXKjXQ
	TxsItIwkVkQBoKE2lD58PTDJKz8MS5pqfJad5HBL/rW4PpuTWD1latFRzT11np9mlwbA=
X-Gm-Gg: ASbGncsavVL5b8IWcObN5wRmr7o3gTWFQg9Xqoe1rP1wY83TdZ73CpSnOjyAP9/Upnf
	AS4KGpqmy9jWTq6x2oM7JcmmoO2BqrjIunFz1p7KhOu7ucGSyAsM6L6q/73LEIKYIhAQB6iKdIJ
	yFIlrlhJ0bYhfawKCdKDAV2uJxy2g4igEllb0PIMlzhG/BrC17mdv69FFdq3UtnA1PHxLPmJIK3
	uzSWlx6CgYAH1lChrC28QtHrcSC6/dpLCcQ2ghmI2s8cw5e7XkMeWQnG/tLpoo//cUlLCOMc6vz
	xwiYzdL5il6op/1iQV76RMkW9Ut0TnHzLd201WtfGed0iwakpelUU94+Av6b/uhBdYQlegMLUEe
	G
X-Received: by 2002:a17:902:d4d2:b0:240:11cd:8502 with SMTP id d9443c01a7336-24011cd8924mr21873835ad.13.1753633541676;
        Sun, 27 Jul 2025 09:25:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF64zD926zPgoLnZHbfxHUg9o9btJVPhQIA8eXNOi4vpCwnfXohmuBfaMQGx77pfDBk/lpsfA==
X-Received: by 2002:a17:902:d4d2:b0:240:11cd:8502 with SMTP id d9443c01a7336-24011cd8924mr21873545ad.13.1753633541102;
        Sun, 27 Jul 2025 09:25:41 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fd9397ebbsm29110325ad.210.2025.07.27.09.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 09:25:40 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sun, 27 Jul 2025 21:54:48 +0530
Subject: [PATCH v13 05/10] power: reset: reboot-mode: Expose sysfs for
 registered reboot_modes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250727-arm-psci-system_reset2-vendor-reboots-v13-5-6b8d23315898@oss.qualcomm.com>
References: <20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com>
In-Reply-To: <20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753633495; l=7789;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=UwAuk0mKb9rcWWrnqsEINzklGj3BCiY6oFtAQLs8bEM=;
 b=5nCCrPxu1hs4B4gaNuJable+RSLEjWkwStVjMUm8ziF5OEvY3BzxS5O31XsXPhhUfGLthjPmW
 eujejMPAi+jAogRbdwDQd0+i/4GzTqmLR3CE7VsSLtixoLYokKDmMLb
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Authority-Analysis: v=2.4 cv=JovxrN4C c=1 sm=1 tr=0 ts=68865307 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=I4qJSSq-i-5ETPqSmjYA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: o2rVGBGeWhKC2zxoQXiSS5h5hBxUQm8i
X-Proofpoint-GUID: o2rVGBGeWhKC2zxoQXiSS5h5hBxUQm8i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI3MDE0MSBTYWx0ZWRfXxzw9tQxJmsl4
 dh9sgb63+ZCGFtF9wBIFEaqxW3cUXz/RvP2eeuPd+HaA0cdfVy5ye9Ah4oFFIOTmryOWKcXoHHG
 yBLrV/QHqArZvzaD/GjHruq+2VQuZJGg4KlH8EY7udbz4v25yOyQvPvPMf5N2/u2RIwi+xionjE
 lDkov4viijqvtgy/XsPH0Yd8rWgRddC7zndLxjjYOMdpLDjJBcZD1LBTICFBL9iTaEkET3oVt6j
 diRz9B2sSAh8yegZ9gktOQ2M1y6IU1oS9p6KxzlbuZsgkDOY40Kzw6k7VzTTkEEpQotR7Fw1AT7
 b/rHArzH/oTDJSTxOEuX+U2Hdrr6S09dzZ23bhRmT29jtGl1eWEG3QkonCxiu/KUO1854ra06b4
 9Hw+1O61lmw0Qpe2dFWBoxlhMMjgB2vzojbUvs8KfutJBXthc9jxxt1bH0icyNdagoG/dkbC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-27_05,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507270141

Currently, there is no standardized mechanism for userspace to
discover which reboot-modes are supported on a given platform.
This limitation forces tools and scripts to rely on hardcoded
assumptions about the supported reboot-modes.

Create a class 'reboot-mode' and a device under it to expose a
sysfs interface to show the available reboot mode arguments to
userspace.

Provision the register function with an additional parameter to
get an explicit driver_name. Create the device using this
driver_name. For platform drivers, use the driver_name configured
in dev node.

This results in the creation of:
  /sys/class/reboot-mode/<driver>/reboot_modes

This read-only sysfs file will exposes the list of supported
reboot modes arguments provided by the driver, enabling userspace
to query the list of arguments.

Align the clean up path to maintain backward compatibility for
existing reboot-mode based drivers.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/power/reset/reboot-mode.c | 126 ++++++++++++++++++++++++++++++--------
 include/linux/reboot-mode.h       |   4 +-
 2 files changed, 105 insertions(+), 25 deletions(-)

diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index ac81b8b0a9b7fc31f8ef21024333a050087ce90f..4c23ff912fc6afbc6949bfdd6607781eccb4e85e 100644
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
@@ -75,26 +78,116 @@ static int reboot_mode_notify(struct notifier_block *this,
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
+	devres_reboot = devres_find(dev, release_reboot_mode_device, NULL, NULL);
+	if (!devres_reboot || !(*devres_reboot))
+		return -ENODATA;
+
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
+	device_remove_file(reboot->reboot_dev, &dev_attr_reboot_modes);
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
  * @np: Pointer to device tree node
+ * @driver_name: Name to use when exposing the sysfs interface
+ *
+ * Registers a reboot mode driver and sets up its sysfs entries
+ * under /sys/class/reboot-mode/<driver_name>/ to allow userspace
+ * interaction with available reboot modes. The DT node is used
+ * for parsing reboot-mode arguments.
  *
  * Returns: 0 on success or a negative error code on failure.
  */
-int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *np)
+int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *np,
+			 const char *driver_name)
 {
 	struct mode_info *info;
-	struct mode_info *next;
 	struct property *prop;
 	size_t len = strlen(PREFIX);
 	u32 magic_arg1;
 	u32 magic_arg2;
 	int ret;
 
-	if (!np)
+	if (!np || !driver_name)
 		return -EINVAL;
 
+	ret = create_reboot_mode_device(reboot, driver_name);
+	if (ret)
+		return ret;
+
 	INIT_LIST_HEAD(&reboot->head);
 	mutex_init(&reboot->rb_lock);
 
@@ -144,13 +237,8 @@ int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *
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
@@ -161,26 +249,16 @@ EXPORT_SYMBOL_GPL(reboot_mode_register);
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
@@ -200,7 +278,7 @@ int devm_reboot_mode_register(struct device *dev,
 	if (!dr)
 		return -ENOMEM;
 
-	rc = reboot_mode_register(reboot, reboot->dev->of_node);
+	rc = reboot_mode_register(reboot, reboot->dev->of_node, reboot->dev->driver->name);
 	if (rc) {
 		devres_free(dr);
 		return rc;
diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
index 370228b5161963aac1d75af752ada0e8282b1078..0b9844a71224b3e4bcc0d1e396d6c9cb11ad8c97 100644
--- a/include/linux/reboot-mode.h
+++ b/include/linux/reboot-mode.h
@@ -7,6 +7,7 @@
 
 struct reboot_mode_driver {
 	struct device *dev;
+	struct device *reboot_dev;
 	struct list_head head;
 	int (*write)(struct reboot_mode_driver *reboot, u64 magic);
 	struct notifier_block reboot_notifier;
@@ -14,7 +15,8 @@ struct reboot_mode_driver {
 	struct mutex rb_lock;
 };
 
-int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *np);
+int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *np,
+			 const char *driver_name);
 int reboot_mode_unregister(struct reboot_mode_driver *reboot);
 int devm_reboot_mode_register(struct device *dev,
 			      struct reboot_mode_driver *reboot);

-- 
2.34.1


