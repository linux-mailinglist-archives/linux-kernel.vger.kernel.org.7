Return-Path: <linux-kernel+bounces-827327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4084B9170D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3CF2A3F07
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FED30EF6E;
	Mon, 22 Sep 2025 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DuVykh36"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD56D283FE9
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758548454; cv=none; b=ipCxawmJgI/3Uag3zF1GtCqfZ2Y0xRvWHMtCQU9Vl+QPF+PVluC1xqC0a+Xx39w6joxw1QZsoEwVvwvTNRkVvp5u8h40oXcDzdIN/pr4CX7QOwbVknZ1tod1wRGiyVJbxceKT93p/IZLefDXsjgNyEwUCjoKutwa+Ds1S1sXAhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758548454; c=relaxed/simple;
	bh=OtVs7gPtVXV3AbZFz+D50jHX3+pXlZ1jHuc0GH75ZNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TH19FqOpajQ2pLUD2RcbYqgfun8K93mnhau0gAv46Di91kZ39/qF7od+nAlCW41ACTDeHSzStGjh3uXBxRo84PEow1vfbWw4vp2W2Q/I6If9I5Ag7OQiZC044cAIvvW/4C0KCXA4fTCn5eaho0JeuyPJUI/9Pq34a/cqA3riROQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DuVykh36; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M8ni2S032343
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vmMn16oiZkqxnrWnAxeSCVdi+UZd2TgsHXVJWSGcec8=; b=DuVykh362S2jWEPu
	VTCMgw+s3yPEUcqJbNuWF8UgPsjfw+tzK/Tq+UfvfPjDq7Lo5rlMyBvbJv8qX+7Q
	oGfv0C/ZnfgvZ3/PnBjvtZugsWcbcwK9MlpzB02e4dxqofoASE3OwGrmYiLePxac
	zfmgSxDc0LgXIyJaaOZb/0SV7krdoIPX2kJiOA+4GTSIH8mvvLpbP1tPa3omNZgp
	IaGdyFcaicTxsJJptt3+7KCztquUJkHhqS+lJpA6A/GsgFprQA8utXIH13UBdsQk
	3w6ZjB8jverOSmq/vUXa0YEcmQFwLmXxegs7zecip8sey8T9dWVs11OV0LwoMQP6
	p+Fmaw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499mn7cwhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:40:51 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-25bdf8126ceso88711365ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758548450; x=1759153250;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vmMn16oiZkqxnrWnAxeSCVdi+UZd2TgsHXVJWSGcec8=;
        b=vP3v4QGz0r47G2UcQG2YAv8aLfKHGK/mCWnJBYsHgLzfBEaUGnPXXbZhsRVnurL02k
         Z4x6Ar14yXEGAH5nTNEDzxCjQBlF2q4tCcTzYOA7X7vjHKfHLfiNe/2JIyc4M8Qiw7wb
         CexJpoXzvxK7CVnQh7L40ioTX2jmk8bS4zau0bGGsYzzOTdbQ7z5UFxfXRACvGMiyw4M
         P+Orrd9qqf/71nmEmjLGSZ4/GVEl7mI/PKxF2q7ujdDdENdsZ5HU31mthwDananc9iSZ
         qVG8h9oO4FH8XpvArAJlejRi5va+57xr6qs+ExIVeXFiA9/fYsM4XAH83roQM1T0rIWJ
         BAEw==
X-Forwarded-Encrypted: i=1; AJvYcCWldbadaqJrsrm8Wnu0qqY1Qpya6543C6aBNLezf3xIsAD+phFzfr4UwEkyGHVtTZYHFUIAIUkjW0Oz0Bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOX/2f1wij9D3P/+RN5bJAOg4Sk/iZyfLECl1hVWmWyf77gtSM
	8YF0Gfr5dQxSq1vMzs/F93Btj5Rta5+BXE5uwJKrGFvHqTfgmlxCPbTH6nj57Z0chATPCh3Ln4f
	jiXNlXY7iGKY83oEDat0DtYLcW2VcnG2y4vjHeCEl9aNAjTpDTsbbHeuyQ2Ir9EDUNMA=
X-Gm-Gg: ASbGncvfLav6D2bmwlO8uBzR4w/e97tM64AG31MnJ70y20HIKK2YuhKx7he5505U5Wd
	Gls59reVqPafTc0bfjijWLOlBwDdbbsc+q/dgaHw35XgwYYQA0UBCS1nq5TOdqpWOWoRsYvbq7I
	1c3ovXLzw5kHCKwvEOKAIctn1tVLtI6Kz+ueHApSUqgscnS+tPhqup04OyOII52P66Z0Ju/1Kjs
	LAMHhKjjh806jEWutqXEMqJfqumFHS1jY/P/rqyZmwn+YwSaH5LbMaU6XXZnM7LGurBWW3FGIjz
	e54CRh5xYCFspue5NPPW5U7AH9hZSIdAHS/yUP5F8FKcIoXc6CQFX36hGV/sPKju6xqehsGdnH8
	b
X-Received: by 2002:a17:902:f54e:b0:271:49f:eaf5 with SMTP id d9443c01a7336-271049ff060mr102463075ad.30.1758548450160;
        Mon, 22 Sep 2025 06:40:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJLarzGKvKl9HgTKxpDtBRtb2AXq2ZCgS3r1CAksTaBDdckn/+MrwC4zD485alAKlinWboPw==
X-Received: by 2002:a17:902:f54e:b0:271:49f:eaf5 with SMTP id d9443c01a7336-271049ff060mr102462645ad.30.1758548449690;
        Mon, 22 Sep 2025 06:40:49 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016c13asm134246755ad.46.2025.09.22.06.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 06:40:48 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 19:10:12 +0530
Subject: [PATCH v15 02/14] power: reset: reboot-mode: Add device tree
 node-based registration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-arm-psci-system_reset2-vendor-reboots-v15-2-7ce3a08878f1@oss.qualcomm.com>
References: <20250922-arm-psci-system_reset2-vendor-reboots-v15-0-7ce3a08878f1@oss.qualcomm.com>
In-Reply-To: <20250922-arm-psci-system_reset2-vendor-reboots-v15-0-7ce3a08878f1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758548419; l=5376;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=OtVs7gPtVXV3AbZFz+D50jHX3+pXlZ1jHuc0GH75ZNs=;
 b=gJ1mwrSZZc5KYCfmG7idToZL91Qco+UvkVqPCmh2hbufifqTgfLagRbsAws6bAWcUYAEU81PP
 hHIaDeYiIR2BvRQ+7HSFlwYrGlgA12jbO0CNQDNACk9eGuCbFy+Crmq
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMyBTYWx0ZWRfXynpPFynzDmGr
 hKqSAu4ONtBpEP/3tBftvkcsQN5556l9wq5OsoxPgsvqYnFMfMZJD+D4RYBxKkz6gBeNROmCpAr
 HZUrmO5jNtjjQrkZtNUl6knHvqyJ+wYgBLl47LDVRGf17LzP7bnliAKZm5lbwzn5ugweIaNJyJE
 31WT53x04JUChNaBAbUEZXcgZkFikpV8j88GxgZirqNdP6SrdRXgGxsMAjLb3o0/qmyU/FLJmMK
 zy6rIRdfmDS2SIvRIccZ/YpBWK4Gq5QQqC6FuvGWgs5A7pRonQ31x0LjGFMuCEPY8uCNCB0E6by
 47AiITUi4Gj29KtQfcwpkFeJUDeWHrfyVn7k1vfsz641AJ0sMc4G+tiaqcCOQRH5iyXeD+ojxII
 PtZ3f5us
X-Proofpoint-GUID: 1RgE_8jEQw9fWG8Tf3khAHhZ7YiQW0Ni
X-Proofpoint-ORIG-GUID: 1RgE_8jEQw9fWG8Tf3khAHhZ7YiQW0Ni
X-Authority-Analysis: v=2.4 cv=EZrIQOmC c=1 sm=1 tr=0 ts=68d151e3 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=239sejjMsMoxT4pUUhgA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200033

The reboot-mode driver does not have a strict requirement for
device-based registration. It primarily uses the device's of_node
to read mode-<cmd> properties and the device pointer for logging.

Remove the dependency on struct device and introduce support for
firmware node (fwnode) based registration. This enables drivers
that are not associated with a struct device to leverage the
reboot-mode framework.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/power/reset/reboot-mode.c | 45 +++++++++++++++++++++++++++++----------
 include/linux/reboot-mode.h       |  3 ++-
 2 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index 8fc3e14638ea757c8dc3808c240ff569cbd74786..c8f71e6f661ae14eb72bdcb1f412cd05faee3dd9 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -3,13 +3,17 @@
  * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
  */
 
+#define pr_fmt(fmt)	"reboot-mode: " fmt
+
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/reboot.h>
 #include <linux/reboot-mode.h>
+#include <linux/slab.h>
 
 #define PREFIX "mode-"
 
@@ -69,17 +73,26 @@ static int reboot_mode_notify(struct notifier_block *this,
 /**
  * reboot_mode_register - register a reboot mode driver
  * @reboot: reboot mode driver
+ * @fwnode: Firmware node with reboot-mode configuration
  *
  * Returns: 0 on success or a negative error code on failure.
  */
-int reboot_mode_register(struct reboot_mode_driver *reboot)
+int reboot_mode_register(struct reboot_mode_driver *reboot, struct fwnode_handle *fwnode)
 {
 	struct mode_info *info;
+	struct mode_info *next;
+	struct device_node *np;
 	struct property *prop;
-	struct device_node *np = reboot->dev->of_node;
 	size_t len = strlen(PREFIX);
 	int ret;
 
+	if (!fwnode)
+		return -EINVAL;
+
+	np = to_of_node(fwnode);
+	if (!np)
+		return -EINVAL;
+
 	INIT_LIST_HEAD(&reboot->head);
 
 	mutex_init(&reboot->rb_lock);
@@ -89,28 +102,28 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 			if (strncmp(prop->name, PREFIX, len))
 				continue;
 
-			info = devm_kzalloc(reboot->dev, sizeof(*info), GFP_KERNEL);
+			info = kzalloc(sizeof(*info), GFP_KERNEL);
 			if (!info) {
 				ret = -ENOMEM;
 				goto error;
 			}
 
 			if (of_property_read_u32(np, prop->name, &info->magic)) {
-				dev_err(reboot->dev, "reboot mode %s without magic number\n",
-					info->mode);
-				devm_kfree(reboot->dev, info);
+				pr_err("reboot mode %s without magic number\n", info->mode);
+				kfree(info);
 				continue;
 			}
 
 			info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
 			if (!info->mode) {
 				ret =  -ENOMEM;
+				kfree(info);
 				goto error;
 			} else if (info->mode[0] == '\0') {
 				kfree_const(info->mode);
+				kfree(info);
 				ret = -EINVAL;
-				dev_err(reboot->dev, "invalid mode name(%s): too short!\n",
-					prop->name);
+				pr_err("invalid mode name(%s): too short!\n", prop->name);
 				goto error;
 			}
 
@@ -123,8 +136,11 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 		return 0;
 
 error:
-		list_for_each_entry(info, &reboot->head, list)
+		list_for_each_entry_safe(info, next, &reboot->head, list) {
+			list_del(&info->list);
 			kfree_const(info->mode);
+			kfree(info);
+		}
 	}
 
 	return ret;
@@ -138,12 +154,16 @@ EXPORT_SYMBOL_GPL(reboot_mode_register);
 int reboot_mode_unregister(struct reboot_mode_driver *reboot)
 {
 	struct mode_info *info;
+	struct mode_info *next;
 
 	unregister_reboot_notifier(&reboot->reboot_notifier);
 
 	scoped_guard(mutex, &reboot->rb_lock) {
-		list_for_each_entry(info, &reboot->head, list)
+		list_for_each_entry_safe(info, next, &reboot->head, list) {
+			list_del(&info->list);
 			kfree_const(info->mode);
+			kfree(info);
+		}
 	}
 
 	return 0;
@@ -168,11 +188,14 @@ int devm_reboot_mode_register(struct device *dev,
 	struct reboot_mode_driver **dr;
 	int rc;
 
+	if (!reboot->dev || !reboot->dev->of_node)
+		return -EINVAL;
+
 	dr = devres_alloc(devm_reboot_mode_release, sizeof(*dr), GFP_KERNEL);
 	if (!dr)
 		return -ENOMEM;
 
-	rc = reboot_mode_register(reboot);
+	rc = reboot_mode_register(reboot, of_fwnode_handle(reboot->dev->of_node));
 	if (rc) {
 		devres_free(dr);
 		return rc;
diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
index b73f80708197677db8dc2e43affc519782b7146e..7f05fd873e95ca8249bc167c21aa6b76faba7849 100644
--- a/include/linux/reboot-mode.h
+++ b/include/linux/reboot-mode.h
@@ -2,6 +2,7 @@
 #ifndef __REBOOT_MODE_H__
 #define __REBOOT_MODE_H__
 
+#include <linux/fwnode.h>
 #include <linux/mutex.h>
 
 struct reboot_mode_driver {
@@ -13,7 +14,7 @@ struct reboot_mode_driver {
 	struct mutex rb_lock;
 };
 
-int reboot_mode_register(struct reboot_mode_driver *reboot);
+int reboot_mode_register(struct reboot_mode_driver *reboot, struct fwnode_handle *fwnode);
 int reboot_mode_unregister(struct reboot_mode_driver *reboot);
 int devm_reboot_mode_register(struct device *dev,
 			      struct reboot_mode_driver *reboot);

-- 
2.34.1


