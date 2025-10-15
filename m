Return-Path: <linux-kernel+bounces-853745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6107EBDC826
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A7724FF636
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D5F2FF175;
	Wed, 15 Oct 2025 04:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oMke+GiA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A311C2FDC4E
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760503166; cv=none; b=D/m2aRo5/9r//EcIw2D0ASplK00xQ1gzYzDb7gkaMc1o+cwisAzd8if7j2+amxFhARfbOShKgN0A82FBoR5kuiBAh8ur1qqML7v7lXVo7QtuQWUXSrgDAIcDLSsS0s2Lqaz40ZrA0Z92Gtc+fCdGt97prQrMwCNrMic98QpVFq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760503166; c=relaxed/simple;
	bh=8AcG56zSaj2lb+5LiiVME4iAOJl8Jy9RSPWY/3KevJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tfNc0N/cRWOmCvHmG/52ej8G+If8yCaE5P5Ay1Oog3RywC5DrRWpXUwkYClYE5ckXoSaW2HHwstd5tfJOra/nzBZcrrB1HXLcDx1ij1k9d2ctwKTsN2L1Vzg/NoNvcEcU7kpSVnU9bVuNE/447AV6SEZRqmUbp8GcnAvbktFODk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oMke+GiA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2s7vN024770
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2Bdm4klfKmI9KtujwTAZDFlBBRS0qX6qK7HSOvDmFEM=; b=oMke+GiAFO7Cwfgu
	qyZ3JD51wJqMEuG3eyQ17e7NoiwOuZZiMnmgt3/x0AqubPl6imwjIZKa52RfK7Xu
	Zz1vvIfDLUXbdWytwC/SVguc9nONfpCIwmloQ1sRoi0a+swDEsoMP9zG2UKnWZOi
	rArAioL+FTOjl/tQkCq5M1qjFgI5wBXOCBdzORQY5Z98dGBxDGnplhb6WUgJq+ax
	72ez3J3RfdgiCjB7hzusyFqOtwax2EBc7Zh2uTMslsKejg3K+ht5pjwg8IbAvrgF
	e2v8W14y0Tu3oPp3u7cvRJ8jWlxi+B0OffWxDSMdxeqnYu0LULzwVLm/5WqlBryP
	thLJ5g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qff0u1ht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:39:24 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32ee4998c50so10151402a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 21:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760503163; x=1761107963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Bdm4klfKmI9KtujwTAZDFlBBRS0qX6qK7HSOvDmFEM=;
        b=rQTt+P1R37lrrlWdbr1QQJ//DYfboAKpBWNN92H/71CiLZBen+l3IXt1TrYKU4+NYu
         TbqkJ6Gwau241s2/fPA0rDFl6bGP9BD4/v0G5cM6dOOeVN4mll3DXqijtdFlmUV7aq/i
         Dx0ZFwx9W4SbEqouuUPp+ofeMtn76udgZVM91+J8mq/brXJHPO4gCiqERJNkUNpQ3t3j
         0i4BCAyxctgORCmzA8CleX0kQU2wdMwQ9ObuCGj9h7vIQvEWOEzfNF+6LovJK2rIra+r
         bCsDjyIpCXfkDfkUtXXXcbZvNkP6mkohrlnsge46N/Sk7biOt3Q2A+V+agChLpSwAJMb
         ktXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXlSDjy3LsXqb6Gwi4HrJNhNqtHLF4ovn7jHcIb8P+lDM9ObbbcZgE43wvw3vc7aoyc6kAZc6Z3Beqn0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtzWQp79472y+x/Kn4TOJ7KuUBet/rgP/QTeQCJU9t8GqwN3vY
	u2m3GOTcopob/H0AmSRXYQbSvAqznmAjAeKmoRc5PxKsIS2u8gYjE+X864bZ9ijlQtPRcETKEBz
	+MgqTd/NFCKWJYOyXTLmDpi+LgF0I09i23LQmk3/shVkOSGzpGBdP5GIvTcZbTE9NOeU=
X-Gm-Gg: ASbGncv1BUFvikCeMn83kZOmUV+lN/ijbKoUpxjQI8Y2mAi7M/UsO9DjeZ+iU4uKyDc
	PsW05qP8NzJQTvrgB7CC5kmqQm8HkwFzH101o1P2DR3IEai5r+g7J9FN5tgrrs7XjtXdIiWRl9G
	OX5vUm6HKUpd1PZCWGHHpl08kyUC1K29O6oyTyLelORATKzbOs4VVk+j2kn3J0QY1CINCJnKbDe
	K4DHgFcPE0pGlq/RubjOjP+PI2SpaHZMCwsT07O6ZCSI0kDQZ4Tu0Ug9RcBLN5s2/Cctj/P6TYt
	58KUzyDIHSersvfSUtTJP3/5jrYJq6blg6zNIGX0w+uA1MprVvZrTbKGlCxlxnfqy8phw361Itz
	F
X-Received: by 2002:a17:90b:3ecb:b0:336:9e78:c4c1 with SMTP id 98e67ed59e1d1-33b5111580emr38598238a91.15.1760503162941;
        Tue, 14 Oct 2025 21:39:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBkK+NiykobnCG3bWTEK1vwo/Tixei5xALFMexfZlmErkfY9V/XJttVGTpCHIhloygGQKJvA==
X-Received: by 2002:a17:90b:3ecb:b0:336:9e78:c4c1 with SMTP id 98e67ed59e1d1-33b5111580emr38598192a91.15.1760503162352;
        Tue, 14 Oct 2025 21:39:22 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b9787af5asm705406a91.20.2025.10.14.21.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 21:39:21 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 10:08:20 +0530
Subject: [PATCH v16 05/14] power: reset: reboot-mode: Expose sysfs for
 registered reboot_modes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-arm-psci-system_reset2-vendor-reboots-v16-5-b98aedaa23ee@oss.qualcomm.com>
References: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
In-Reply-To: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
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
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760503106; l=7370;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=8AcG56zSaj2lb+5LiiVME4iAOJl8Jy9RSPWY/3KevJU=;
 b=F+ABZJAmqdzEeh37h5YIzUWAPnWH1l70KDEJ6TYBKxBmDBSbKGc60FieOGIhiVT7o1tAjn4bd
 VhHdkn3bHpnBN+ohs3uJyoWvlwFJPwN47tR1qT1aREij+bKdg6GUKgs
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX49xGjAK3MJwd
 1LqdCqMBttK8P+UCkBVXrdqH5MVp43PnU/8MDJucbkFxOY4fvZLoBgvupZZOyDfacc2u8ouB6ve
 4s4uZz/GHY1VFtUwn42HeSsICyqm182RMPYGpDD52LRPDeNYQdteqlvEe+niv8+H0h+laWAcGOp
 JdIP70Pizop6SB1OI4Vxw+LDV5QwL2BnLjVEcyhzz8Q9UBz89zGf6Xw4dxTw/IYLwAdc5iHYDPK
 QTCPUThkKSrxe200qZHGOyetv0vCdsLz2bjgVSs81G38VwfBP9NeEXupce4+MiKZQwT3U8rHc/2
 3t+5q0BT8P4Uk+oWPXgVAMs9EylV8cQa60fDI7cag==
X-Proofpoint-GUID: ElMnu8vgL51KmqvELWCJc9QVFgKRaeRC
X-Authority-Analysis: v=2.4 cv=PriergM3 c=1 sm=1 tr=0 ts=68ef257c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=I4qJSSq-i-5ETPqSmjYA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: ElMnu8vgL51KmqvELWCJc9QVFgKRaeRC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

Currently, there is no standardized mechanism for userspace to
discover which reboot-modes are supported on a given platform.
This limitation forces tools and scripts to rely on hardcoded
assumptions about the supported reboot-modes.

Create a class 'reboot-mode' and a device under it to expose a
sysfs interface to show the available reboot mode arguments to
userspace. Use the driver_name field of the struct
reboot_mode_driver to create the device. For device-based
drivers, configure the device driver name as driver_name.

This results in the creation of:
  /sys/class/reboot-mode/<driver>/reboot_modes

This read-only sysfs file will exposes the list of supported
reboot modes arguments provided by the driver, enabling userspace
to query the list of arguments.

Align the clean up path to maintain backward compatibility for
existing reboot-mode based drivers.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/power/reset/reboot-mode.c | 127 ++++++++++++++++++++++++++++++--------
 include/linux/reboot-mode.h       |   2 +
 2 files changed, 103 insertions(+), 26 deletions(-)

diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index 79763a839c9b0161b4acb6afb625f50a880971cc..1e78eb3d0fe513c934b37bf7f0829e1f9f4634f0 100644
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
@@ -69,6 +72,89 @@ static int reboot_mode_notify(struct notifier_block *this,
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
+	scoped_guard(mutex, &reboot->rb_lock) {
+		list_for_each_entry(info, &reboot->head, list)
+			size += sysfs_emit_at(buf, size, "%s ", info->mode);
+	}
+
+	if (size) {
+		size += sysfs_emit_at(buf, size - 1, "\n");
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
+	scoped_guard(mutex, &reboot->rb_lock) {
+		list_for_each_entry_safe(info, next, &reboot->head, list) {
+			list_del(&info->list);
+			kfree_const(info->mode);
+			kfree(info);
+		}
+	}
+
+	device_remove_file(reboot->reboot_dev, &dev_attr_reboot_modes);
+}
+
+static int create_reboot_mode_device(struct reboot_mode_driver *reboot)
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
+	reboot->reboot_dev = device_create(rb_class, NULL, 0, NULL, reboot->driver_name);
+	if (IS_ERR(reboot->reboot_dev))
+		return PTR_ERR(reboot->reboot_dev);
+
+	ret = device_create_file(reboot->reboot_dev, &dev_attr_reboot_modes);
+	if (ret)
+		goto create_file_err;
+
+	dr = devres_alloc(release_reboot_mode_device, sizeof(*dr), GFP_KERNEL);
+	if (!dr) {
+		ret = -ENOMEM;
+		goto devres_alloc_error;
+	}
+
+	*dr = reboot;
+	devres_add(reboot->reboot_dev, dr);
+	return ret;
+
+devres_alloc_error:
+	device_remove_file(reboot->reboot_dev, &dev_attr_reboot_modes);
+create_file_err:
+	device_unregister(reboot->reboot_dev);
+	return ret;
+}
+
 /**
  * reboot_mode_register - register a reboot mode driver
  * @reboot: reboot mode driver
@@ -79,7 +165,6 @@ static int reboot_mode_notify(struct notifier_block *this,
 int reboot_mode_register(struct reboot_mode_driver *reboot, struct fwnode_handle *fwnode)
 {
 	struct mode_info *info;
-	struct mode_info *next;
 	struct device_node *np;
 	struct property *prop;
 	size_t len = strlen(PREFIX);
@@ -87,13 +172,17 @@ int reboot_mode_register(struct reboot_mode_driver *reboot, struct fwnode_handle
 	u32 magic_arg2;
 	int ret;
 
-	if (!fwnode)
+	if (!fwnode || !reboot->driver_name)
 		return -EINVAL;
 
 	np = to_of_node(fwnode);
 	if (!np)
 		return -EINVAL;
 
+	ret = create_reboot_mode_device(reboot);
+	if (ret)
+		return ret;
+
 	INIT_LIST_HEAD(&reboot->head);
 
 	mutex_init(&reboot->rb_lock);
@@ -136,20 +225,15 @@ int reboot_mode_register(struct reboot_mode_driver *reboot, struct fwnode_handle
 
 			list_add_tail(&info->list, &reboot->head);
 		}
+	}
 
-		reboot->reboot_notifier.notifier_call = reboot_mode_notify;
-		register_reboot_notifier(&reboot->reboot_notifier);
+	reboot->reboot_notifier.notifier_call = reboot_mode_notify;
+	register_reboot_notifier(&reboot->reboot_notifier);
 
-		return 0;
+	return 0;
 
 error:
-		list_for_each_entry_safe(info, next, &reboot->head, list) {
-			list_del(&info->list);
-			kfree_const(info->mode);
-			kfree(info);
-		}
-	}
-
+	device_unregister(reboot->reboot_dev);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(reboot_mode_register);
@@ -160,26 +244,16 @@ EXPORT_SYMBOL_GPL(reboot_mode_register);
  */
 int reboot_mode_unregister(struct reboot_mode_driver *reboot)
 {
-	struct mode_info *info;
-	struct mode_info *next;
-
-	unregister_reboot_notifier(&reboot->reboot_notifier);
-
-	scoped_guard(mutex, &reboot->rb_lock) {
-		list_for_each_entry_safe(info, next, &reboot->head, list) {
-			list_del(&info->list);
-			kfree_const(info->mode);
-			kfree(info);
-		}
-	}
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
@@ -202,6 +276,7 @@ int devm_reboot_mode_register(struct device *dev,
 	if (!dr)
 		return -ENOMEM;
 
+	reboot->driver_name = reboot->dev->driver->name;
 	rc = reboot_mode_register(reboot, of_fwnode_handle(reboot->dev->of_node));
 	if (rc) {
 		devres_free(dr);
diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
index 3a14df2ddd1db4181ea76f99ef447ed8368a3594..c68a671f6947f2346e1e6a0ce3c6ebc18722b98e 100644
--- a/include/linux/reboot-mode.h
+++ b/include/linux/reboot-mode.h
@@ -8,6 +8,8 @@
 
 struct reboot_mode_driver {
 	struct device *dev;
+	struct device *reboot_dev;
+	const char *driver_name;
 	struct list_head head;
 	int (*write)(struct reboot_mode_driver *reboot, u64 magic);
 	struct notifier_block reboot_notifier;

-- 
2.34.1


