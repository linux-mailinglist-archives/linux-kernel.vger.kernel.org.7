Return-Path: <linux-kernel+bounces-729469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 528DDB03723
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAD207AB82C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 06:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B507223DEC;
	Mon, 14 Jul 2025 06:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NSslthU7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E87222F389
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752474702; cv=none; b=qonnnSmKShRTdSI7s4/COMUs1A29uSeN+XH9OJgtU4g7vzDlrGjO/Gv3/R4RZDxOYuBWm36d2Z8dtmnMWh6umN1D2dZmhHQ4m6dgIre9Vp1aV2jDhO7MlSwC56Z1E/TmQAEbR0f7MrbfMCtewlTWSc/nDBNV6iCjetqKbgCGuvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752474702; c=relaxed/simple;
	bh=PRIVevQOxUAJzyHlFYHzHNrnfVvigJiIK7Z755LXWvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OgpwY3rcDyovO463Jm9HEBDKm/49L7fqr8dKZzcSBLeGAUadRGrYDX1IPf1EpGErfI90Uq0387dRLAPzsugaRvfbPOhZ4uQMBt45B2l9u5V8vFOmJ3PSjunbP+1eQLozfxzsXWVJGOcpGlSdHuTGVGM+rkPMErBYr/3ivkuCpzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NSslthU7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DKe2EM004487
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=gAq6ngWtr3O
	nM2ymzvbQ7ccvNmzVKPrDk2Q62biIPKk=; b=NSslthU72kqOCdH4hbOd+QBCrp5
	3/O0TfCFGsj9ACow11MoedOn9RVRlYmqR3/hahsX4heARZ7ydOZVgp8P2oJYv0Z8
	rW+UWtSSLLssGbEzPl7lNDT/OVhkhKlesxhMeA6oP7lsiAVL34BeDW3vXwALrxM/
	CuiPF6ysilR6mDzVVV2DPdgUANxxGB70SrLhN405wr4pMYrdr1sEz7gIX07vpZlr
	6vGdQlwir8ymlYDQqCbRDSCoIKXK7NTa55zhIzJ/Vqj+/3qgPmRFDwmFGruTVPug
	kQr1MoJqfU7CdyJs07GMowuCWyUCET6xivvdStRTh6nUv13rthKyJljg2rw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufu83edr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:31:39 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23689228a7fso58333585ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 23:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752474698; x=1753079498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gAq6ngWtr3OnM2ymzvbQ7ccvNmzVKPrDk2Q62biIPKk=;
        b=uOASubsjvL4/jTrKvgSfnGFSXmxO21Lnv5uQb3pSIk/uKSE8YwVhNqP12qgsHkoVbo
         2p/OuBj8pA45kyn1cammSY7dmbLW0435Uoy5C9/UUpU+hNtvBrdX/u5ZShEYNfONjtQQ
         /llwkGVMSEOWbmDOafxCbba9w2qcxvfudX1/m8pBbG+ubPRHB23BQ4adCUX7FT0uG4Qg
         6npxL4Ktp0E13z88xAfRqwUMksr5osKSI+ewojiooxWMvDh1/Ng1XrTyn34rER5uPv4Q
         TQqenhpxsDH9l6ozAInpLvC/JugXBtgGlKEwdRwFTP979DNGsb5YwnmZEDk/63DtMbrh
         /pYA==
X-Forwarded-Encrypted: i=1; AJvYcCUaPUkOwUIl52577PEUHrEuownIf3AhVqefPSZUODZ/ajTqiQIUPwse9qdQOunE5M7YPCabwYG+amSeFY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU3cqfi7Z3Xkg0U7P+Y7vKk2nfAv4a6bFJUx4MLIgAVYRe+DhW
	5jEhew3SXRl8fRHzGOnR6USV573Ia/zwP9gUxMogZ8+HFtn5uuBjg4+djakUoyWC20/LeIijgT7
	tmnQnKemo90gjhGs8tSV9c6BDk5CjxKnYWi2rNeJ80MJVy+gimpnnrm4JaAHP2HMI1J8=
X-Gm-Gg: ASbGncsF0fmyXRHgJvnGQdAsOp1lOUQFOgCQK8vC1PKgHzu3eoLflFPVGfRmpAiwdgX
	bFZxVfMkC3EyHjeVU21lWaFs7P2ivaZVYqoknHF6eQeZowr3dQyjhaMnXVc6+dAK9AYILMjkfgn
	qQlrHp9MjM32rTHO+ikAfopSOtMv2NMa3Y0iiLgKzymf8Gxay6i3enb8H0aZmO0i4BF1syOfFJI
	9CuPH2vqK3U1cCH4th9j9JUiU1/obP4eKPjwO2jRI5BwXEZ3Elo/DTQsCyNncp2J5WKqOmUJom0
	8JsRdPJbMZhj4vOWkjYG68GiSSkqD4eW4da7duu+8UhqcEzGgSXRpF4KX535gVTKLLTOFZCuSdm
	qXejzKWbY4U5o/WeUsENQ
X-Received: by 2002:a17:902:e5cb:b0:236:8df9:ab38 with SMTP id d9443c01a7336-23dede81d81mr187145285ad.34.1752474697578;
        Sun, 13 Jul 2025 23:31:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBu4/EjSuBipjbx1suRpzXpkeCva0P3NwNqCB9O7Ggwqx25v6C62U+SeFlHiKnKFlatczguA==
X-Received: by 2002:a17:902:e5cb:b0:236:8df9:ab38 with SMTP id d9443c01a7336-23dede81d81mr187144715ad.34.1752474697016;
        Sun, 13 Jul 2025 23:31:37 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4334005sm86138255ad.158.2025.07.13.23.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 23:31:36 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Jie Gan <quic_jiegan@quicinc.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 RESEND 04/10] coresight: ctcu: enable byte-cntr for TMC ETR devices
Date: Mon, 14 Jul 2025 14:31:03 +0800
Message-Id: <20250714063109.591-5-jie.gan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250714063109.591-1-jie.gan@oss.qualcomm.com>
References: <20250714063109.591-1-jie.gan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAzNyBTYWx0ZWRfXyCUnAy8biAIB
 a0aCPhMp6KuvXPWEdtdo9ACwLMNiX5Q4itbKKZ7eA+qyLoU1ZtkxQyoUxsmRf0lsjvsxaWnZEbq
 2VYQ8psjzEcsWvS+L5d8c8xIA5Srg9EPjvpaYvXESMoVh/HnwSttB9dk3d5gf8ZCiH/e5nmNuAg
 WCocMuCUa06hNnWTquXU06rqyY0jJwNWJZIcojU0olUjKL1mAUrSO96tXK/564M6rk+Eg2GZo/e
 j4E6njfY1OegmYRAg41URIY5czv0/xmFpu8VoYzsaLEZ6nJCyYqjr4vZur15cruPEMCjV8/JwZr
 sfQ1tbiKrIQb0az98300g/TgMgNNLVXNpm4A0noT5n0OrsyXV3Nf7LsCTEW7eklqwJP0oQeOUMD
 32S3FuiEzZtTFDB+b1Zmb/ec6RsrcxMeE5m4UP7i9TxBdLoGYPn3p9efN4LK0Eea8cizEYzv
X-Proofpoint-ORIG-GUID: r4t4YxN2zCwox_Lf_RgDD_E_caWHRJZo
X-Proofpoint-GUID: r4t4YxN2zCwox_Lf_RgDD_E_caWHRJZo
X-Authority-Analysis: v=2.4 cv=f59IBPyM c=1 sm=1 tr=0 ts=6874a44b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=QXWqZSVT-t1lZVDuzqIA:9
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140037

The byte-cntr function provided by the CTCU device is used to transfer data
from the ETR buffer to the userspace. An interrupt is triggered if the data
size exceeds the threshold set in the BYTECNTRVAL register. The interrupt
handler counts the number of triggered interruptions and the read function
will read the data from the ETR buffer.

Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 .../testing/sysfs-bus-coresight-devices-ctcu  |   5 +
 drivers/hwtracing/coresight/Makefile          |   2 +-
 .../coresight/coresight-ctcu-byte-cntr.c      | 102 ++++++++++++++++++
 .../hwtracing/coresight/coresight-ctcu-core.c |  94 +++++++++++++++-
 drivers/hwtracing/coresight/coresight-ctcu.h  |  49 ++++++++-
 5 files changed, 246 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-ctcu
 create mode 100644 drivers/hwtracing/coresight/coresight-ctcu-byte-cntr.c

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-ctcu b/Documentation/ABI/testing/sysfs-bus-coresight-devices-ctcu
new file mode 100644
index 000000000000..e21f5bcb8097
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-ctcu
@@ -0,0 +1,5 @@
+What:           /sys/bus/coresight/devices/<ctcu-name>/irq_val
+Date:           June 2025
+KernelVersion:  6.16
+Contact:        Tingwei Zhang (QUIC) <quic_tingweiz@quicinc.com>; Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>; Jie Gan <jie.gan@oss.qualcomm.com>
+Description:    (RW) Configure the IRQ value for byte-cntr register.
diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index 4e7cc3c5bf99..3568d9768567 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -54,5 +54,5 @@ coresight-cti-y := coresight-cti-core.o	coresight-cti-platform.o \
 obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
 obj-$(CONFIG_CORESIGHT_DUMMY) += coresight-dummy.o
 obj-$(CONFIG_CORESIGHT_CTCU) += coresight-ctcu.o
-coresight-ctcu-y := coresight-ctcu-core.o
+coresight-ctcu-y := coresight-ctcu-core.o coresight-ctcu-byte-cntr.o
 obj-$(CONFIG_CORESIGHT_KUNIT_TESTS) += coresight-kunit-tests.o
diff --git a/drivers/hwtracing/coresight/coresight-ctcu-byte-cntr.c b/drivers/hwtracing/coresight/coresight-ctcu-byte-cntr.c
new file mode 100644
index 000000000000..d3b6eb7a89fb
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-ctcu-byte-cntr.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/coresight.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/interrupt.h>
+#include <linux/of_irq.h>
+#include <linux/uaccess.h>
+
+#include "coresight-ctcu.h"
+#include "coresight-priv.h"
+#include "coresight-tmc.h"
+
+static irqreturn_t byte_cntr_handler(int irq, void *data)
+{
+	struct ctcu_byte_cntr *byte_cntr_data = (struct ctcu_byte_cntr *)data;
+
+	atomic_inc(&byte_cntr_data->irq_cnt);
+	wake_up(&byte_cntr_data->wq);
+
+	byte_cntr_data->irq_num++;
+
+	return IRQ_HANDLED;
+}
+
+/* Start the byte-cntr function when the path is enabled. */
+void ctcu_byte_cntr_start(struct coresight_device *csdev, struct coresight_path *path)
+{
+	struct ctcu_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct coresight_device *sink = coresight_get_sink(path);
+	struct ctcu_byte_cntr *byte_cntr_data;
+	int port_num;
+
+	if (!sink)
+		return;
+
+	port_num = coresight_get_port_helper(sink, csdev);
+	if (port_num < 0)
+		return;
+
+	byte_cntr_data = &drvdata->byte_cntr_data[port_num];
+	/* Don't start byte-cntr function when threshold is not set. */
+	if (!byte_cntr_data->thresh_val || byte_cntr_data->enable)
+		return;
+
+	guard(raw_spinlock_irqsave)(&byte_cntr_data->spin_lock);
+	byte_cntr_data->enable = true;
+	byte_cntr_data->reading_buf = false;
+}
+
+/* Stop the byte-cntr function when the path is disabled. */
+void ctcu_byte_cntr_stop(struct coresight_device *csdev, struct coresight_path *path)
+{
+	struct ctcu_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct coresight_device *sink = coresight_get_sink(path);
+	struct ctcu_byte_cntr *byte_cntr_data;
+	int port_num;
+
+	if (!sink || coresight_get_mode(sink) == CS_MODE_SYSFS)
+		return;
+
+	port_num = coresight_get_port_helper(sink, csdev);
+	if (port_num < 0)
+		return;
+
+	byte_cntr_data = &drvdata->byte_cntr_data[port_num];
+	guard(raw_spinlock_irqsave)(&byte_cntr_data->spin_lock);
+	byte_cntr_data->enable = false;
+}
+
+void ctcu_byte_cntr_init(struct device *dev, struct ctcu_drvdata *drvdata, int etr_num)
+{
+	struct ctcu_byte_cntr *byte_cntr_data;
+	struct device_node *nd = dev->of_node;
+	int byte_cntr_irq, ret, i;
+
+	for (i = 0; i < etr_num; i++) {
+		byte_cntr_data = &drvdata->byte_cntr_data[i];
+		byte_cntr_irq = of_irq_get_byname(nd, byte_cntr_data->irq_name);
+		if (byte_cntr_irq < 0) {
+			dev_err(dev, "Failed to get IRQ from DT for %s\n",
+				byte_cntr_data->irq_name);
+			continue;
+		}
+
+		ret = devm_request_irq(dev, byte_cntr_irq, byte_cntr_handler,
+				       IRQF_TRIGGER_RISING | IRQF_SHARED,
+				       dev_name(dev), byte_cntr_data);
+		if (ret) {
+			dev_err(dev, "Failed to register IRQ for %s\n",
+				byte_cntr_data->irq_name);
+			continue;
+		}
+
+		byte_cntr_data->byte_cntr_irq = byte_cntr_irq;
+		disable_irq(byte_cntr_data->byte_cntr_irq);
+		init_waitqueue_head(&byte_cntr_data->wq);
+	}
+}
diff --git a/drivers/hwtracing/coresight/coresight-ctcu-core.c b/drivers/hwtracing/coresight/coresight-ctcu-core.c
index 28ea4a216345..721836d42523 100644
--- a/drivers/hwtracing/coresight/coresight-ctcu-core.c
+++ b/drivers/hwtracing/coresight/coresight-ctcu-core.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
+#include <linux/sizes.h>
 
 #include "coresight-ctcu.h"
 #include "coresight-priv.h"
@@ -45,17 +46,23 @@ DEFINE_CORESIGHT_DEVLIST(ctcu_devs, "ctcu");
 
 #define CTCU_ATID_REG_BIT(traceid)	(traceid % 32)
 #define CTCU_ATID_REG_SIZE		0x10
+#define CTCU_ETR0_IRQCTRL               0x6c
+#define CTCU_ETR1_IRQCTRL               0x70
 #define CTCU_ETR0_ATID0			0xf8
 #define CTCU_ETR1_ATID0			0x108
 
 static const struct ctcu_etr_config sa8775p_etr_cfgs[] = {
 	{
-		.atid_offset	= CTCU_ETR0_ATID0,
-		.port_num	= 0,
+		.atid_offset		= CTCU_ETR0_ATID0,
+		.irq_ctrl_offset	= CTCU_ETR0_IRQCTRL,
+		.irq_name		= "etr0",
+		.port_num		= 0,
 	},
 	{
-		.atid_offset	= CTCU_ETR1_ATID0,
-		.port_num	= 1,
+		.atid_offset		= CTCU_ETR1_ATID0,
+		.irq_ctrl_offset	= CTCU_ETR1_IRQCTRL,
+		.irq_name		= "etr1",
+		.port_num		= 1,
 	},
 };
 
@@ -64,6 +71,76 @@ static const struct ctcu_config sa8775p_cfgs = {
 	.num_etr_config	= ARRAY_SIZE(sa8775p_etr_cfgs),
 };
 
+static void ctcu_program_register(struct ctcu_drvdata *drvdata, u32 val, u32 offset)
+{
+	CS_UNLOCK(drvdata->base);
+	ctcu_writel(drvdata, val, offset);
+	CS_LOCK(drvdata->base);
+}
+
+static ssize_t irq_val_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct ctcu_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	int i, len = 0;
+
+	for (i = 0; i < ETR_MAX_NUM; i++) {
+		if (drvdata->byte_cntr_data[i].irq_ctrl_offset)
+			len += scnprintf(buf + len, PAGE_SIZE - len, "%u ",
+					 drvdata->byte_cntr_data[i].thresh_val);
+	}
+
+	len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
+
+	return len;
+}
+
+/* Program a valid value into IRQCTRL register will enable byte-cntr interrupt */
+static ssize_t irq_val_store(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t size)
+{
+	struct ctcu_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	u32 thresh_vals[ETR_MAX_NUM] = { 0 };
+	u32 irq_ctrl_offset;
+	int num, i;
+
+	num = sscanf(buf, "%i %i", &thresh_vals[0], &thresh_vals[1]);
+	if (num <= 0 || num > ETR_MAX_NUM)
+		return -EINVAL;
+
+	/* Threshold 0 disables the interruption. */
+	guard(raw_spinlock_irqsave)(&drvdata->spin_lock);
+	for (i = 0; i < num; i++) {
+		/* A small threshold will result in a large number of interruptions */
+		if (thresh_vals[i] && thresh_vals[i] < SZ_4K)
+			return -EINVAL;
+
+		if (drvdata->byte_cntr_data[i].irq_ctrl_offset) {
+			drvdata->byte_cntr_data[i].thresh_val = thresh_vals[i];
+			irq_ctrl_offset = drvdata->byte_cntr_data[i].irq_ctrl_offset;
+			/* A one value for IRQCTRL register represents 8 bytes */
+			ctcu_program_register(drvdata, thresh_vals[i] / 8, irq_ctrl_offset);
+		}
+	}
+
+	return size;
+}
+static DEVICE_ATTR_RW(irq_val);
+
+static struct attribute *ctcu_attrs[] = {
+	&dev_attr_irq_val.attr,
+	NULL,
+};
+
+static struct attribute_group ctcu_attr_grp = {
+	.attrs = ctcu_attrs,
+};
+
+static const struct attribute_group *ctcu_attr_grps[] = {
+	&ctcu_attr_grp,
+	NULL,
+};
+
 static void ctcu_program_atid_register(struct ctcu_drvdata *drvdata, u32 reg_offset,
 				       u8 bit, bool enable)
 {
@@ -143,6 +220,8 @@ static int ctcu_enable(struct coresight_device *csdev, enum cs_mode mode, void *
 {
 	struct coresight_path *path = (struct coresight_path *)data;
 
+	ctcu_byte_cntr_start(csdev, path);
+
 	return ctcu_set_etr_traceid(csdev, path, true);
 }
 
@@ -150,6 +229,8 @@ static int ctcu_disable(struct coresight_device *csdev, void *data)
 {
 	struct coresight_path *path = (struct coresight_path *)data;
 
+	ctcu_byte_cntr_stop(csdev, path);
+
 	return ctcu_set_etr_traceid(csdev, path, false);
 }
 
@@ -200,7 +281,11 @@ static int ctcu_probe(struct platform_device *pdev)
 			for (i = 0; i < cfgs->num_etr_config; i++) {
 				etr_cfg = &cfgs->etr_cfgs[i];
 				drvdata->atid_offset[i] = etr_cfg->atid_offset;
+				drvdata->byte_cntr_data[i].irq_name = etr_cfg->irq_name;
+				drvdata->byte_cntr_data[i].irq_ctrl_offset =
+					etr_cfg->irq_ctrl_offset;
 			}
+			ctcu_byte_cntr_init(dev, drvdata, cfgs->num_etr_config);
 		}
 	}
 
@@ -212,6 +297,7 @@ static int ctcu_probe(struct platform_device *pdev)
 	desc.subtype.helper_subtype = CORESIGHT_DEV_SUBTYPE_HELPER_CTCU;
 	desc.pdata = pdata;
 	desc.dev = dev;
+	desc.groups = ctcu_attr_grps;
 	desc.ops = &ctcu_ops;
 	desc.access = CSDEV_ACCESS_IOMEM(base);
 
diff --git a/drivers/hwtracing/coresight/coresight-ctcu.h b/drivers/hwtracing/coresight/coresight-ctcu.h
index e9594c38dd91..71266371591b 100644
--- a/drivers/hwtracing/coresight/coresight-ctcu.h
+++ b/drivers/hwtracing/coresight/coresight-ctcu.h
@@ -5,19 +5,27 @@
 
 #ifndef _CORESIGHT_CTCU_H
 #define _CORESIGHT_CTCU_H
+
+#include <linux/time.h>
 #include "coresight-trace-id.h"
 
 /* Maximum number of supported ETR devices for a single CTCU. */
 #define ETR_MAX_NUM	2
 
+#define BYTE_CNTR_TIMEOUT	(5 * HZ)
+
 /**
  * struct ctcu_etr_config
  * @atid_offset:	offset to the ATID0 Register.
- * @port_num:		in-port number of CTCU device that connected to ETR.
+ * @port_num:		in-port number of the CTCU device that connected to ETR.
+ * @irq_ctrl_offset:    offset to the BYTECNTRVAL register.
+ * @irq_name:           IRQ name in dt node.
  */
 struct ctcu_etr_config {
 	const u32 atid_offset;
 	const u32 port_num;
+	const u32 irq_ctrl_offset;
+	const char *irq_name;
 };
 
 struct ctcu_config {
@@ -25,15 +33,54 @@ struct ctcu_config {
 	int num_etr_config;
 };
 
+/**
+ * struct ctcu_byte_cntr
+ * @enable:		indicates that byte_cntr function is enabled or not.
+ * @reading:		indicates that its byte-cntr reading.
+ * @reading_buf:	indicates that byte-cntr is reading buffer.
+ * @thresh_val:		threshold to trigger a interruption.
+ * @total_size:		total size of transferred data.
+ * @byte_cntr_irq:	IRQ number.
+ * @irq_cnt:		IRQ count.
+ * @irq_num:		number of the byte_cntr IRQ for one session.
+ * @wq:			workqueue of reading ETR data.
+ * @read_work:		work of reading ETR data.
+ * @spin_lock:		spinlock of byte cntr data.
+ *			the byte cntr is stopped.
+ * @irq_ctrl_offset:	offset to the BYTECNTVAL Register.
+ * @irq_name:		IRQ name in DT.
+ */
+struct ctcu_byte_cntr {
+	bool			enable;
+	bool                    reading;
+	bool			reading_buf;
+	u32			thresh_val;
+	u64			total_size;
+	int			byte_cntr_irq;
+	atomic_t		irq_cnt;
+	int			irq_num;
+	wait_queue_head_t	wq;
+	struct work_struct	read_work;
+	raw_spinlock_t		spin_lock;
+	u32			irq_ctrl_offset;
+	const char		*irq_name;
+};
+
 struct ctcu_drvdata {
 	void __iomem		*base;
 	struct clk		*apb_clk;
 	struct device		*dev;
 	struct coresight_device	*csdev;
+	struct ctcu_byte_cntr   byte_cntr_data[ETR_MAX_NUM];
 	raw_spinlock_t		spin_lock;
 	u32			atid_offset[ETR_MAX_NUM];
 	/* refcnt for each traceid of each sink */
 	u8			traceid_refcnt[ETR_MAX_NUM][CORESIGHT_TRACE_ID_RES_TOP];
 };
 
+/* Byte-cntr functions */
+void ctcu_byte_cntr_start(struct coresight_device *csdev, struct coresight_path *path);
+void ctcu_byte_cntr_stop(struct coresight_device *csdev, struct coresight_path *path);
+void ctcu_byte_cntr_init(struct device *dev, struct ctcu_drvdata *drvdata, int port_num);
+
 #endif
-- 
2.34.1


