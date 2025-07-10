Return-Path: <linux-kernel+bounces-724911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E14DAFF870
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162BE1C4309C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48492284690;
	Thu, 10 Jul 2025 05:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Dqd7Y4cd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8805912CDA5;
	Thu, 10 Jul 2025 05:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752125294; cv=none; b=iZh9MJLHRX/QHLaUK/ZbJwHJFLS/jp7LVv5z0+YylOUhBXfYRKdQm680B+kg3HaQiVmYrC0v15ux51sKx6ORH6g9JudJtxpODkApUsFbK2gRQmd09z2xVPiUceH7kOkvF2ilbkt7AxnJAI6t5jh8Lnd+BU2uwjJVrzwxzgQG1Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752125294; c=relaxed/simple;
	bh=W+U1F+4JfkkXqZS98QAnzCRWpg7ZzqTqSjgMK3YVADA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kIKNbgxsxFu5x9TwoHVBzOhQ7qHDN7u15do0AcQZPlZyeKMycr8ywEPBuziM7saYYLETsXAybiFeFNrDr89l0CyoPFcBDM/SZpgkhF8Qg2si0ArwSuu2IUjRpJ+afj4d51FPNqJgH1flfIp0oumwtib7BIuJmCf7VKIuJTLD9kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Dqd7Y4cd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A0PYdl016804;
	Thu, 10 Jul 2025 05:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PQvhhexSpJsbTrtV+cECUbk1fyGPcDTHY/f3p6Bc6eA=; b=Dqd7Y4cdk0l10Yvp
	BRCKsq3CxkjcA6wDpAXfjDpUrEmL0GZ9Mf5OU5IX8zkRqPiPjkSNAhlSchAgoPQj
	+RjCr8dmk1dLwjSnWVV8fIflH3xRiCnjnx5P1yU38xf9Ww5+0SLx9VtARI7AFqu8
	O7cdKtA92v+A6DCPq8YsU2MxmUtnfl0kwMWYME7FE7b848SSV9JT9cDbwtIEtmWp
	nGrF5nYOZ1Jqr9Uny3P1tjl/2UqYvgXX+YnWjGaB2j8MKWbl/yyFlxLYDqVkaQJc
	WcTm2iclktYIKDgGwwV17JxEnfJ/ylyzK/OZjPyhSbn3CcGDHlszDQSyhUtR9PuZ
	kgXMzg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smbnukxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 05:28:02 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56A5S2Sl019584
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 05:28:02 GMT
Received: from yuanfang4-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 9 Jul 2025 22:27:57 -0700
From: Yuanfang Zhang <quic_yuanfang@quicinc.com>
Date: Thu, 10 Jul 2025 13:27:21 +0800
Subject: [PATCH v11 2/2] coresight: add coresight Trace Network On Chip
 driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250710-trace-noc-v11-2-f849075c40b8@quicinc.com>
References: <20250710-trace-noc-v11-0-f849075c40b8@quicinc.com>
In-Reply-To: <20250710-trace-noc-v11-0-f849075c40b8@quicinc.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
	<mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>
CC: <kernel@oss.qualcomm.com>, <linux-arm-msm@vger.kernel.org>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yuanfang Zhang
	<quic_yuanfang@quicinc.com>, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752125269; l=11620;
 i=quic_yuanfang@quicinc.com; s=20241209; h=from:subject:message-id;
 bh=W+U1F+4JfkkXqZS98QAnzCRWpg7ZzqTqSjgMK3YVADA=;
 b=zfVy2IXTTH0aIBaXgQ+NfCPZKzqqFMioszCL99aKDxp6EDlSAOKbHJMOYdJGJvFRZDtlfd5H5
 aKMC6+8LLaKB9k4vBXGQdkSpW2H2PvQeHeycN+RTp16gclfZRqIY3a5
X-Developer-Key: i=quic_yuanfang@quicinc.com; a=ed25519;
 pk=ZrIjRVq9LN8/zCQGbDEwrZK/sfnVjwQ2elyEZAOaV1Q=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA0NCBTYWx0ZWRfX6VfrtwyoqCIN
 rWvfanZ4COMnBbgaaBLA8oDdVFcTi3VykH0qxBnK7I1hQsD0fS5e6+IlwmIvX0tUcuOGOSZyoFb
 uwPeKi3Uni2rn/MvXkBSzJa9bnaJ0i0tnNSz/mjVRxek2YbyCGGtkGkYZi4p9ZqWzPOc2DM+1Sq
 QRjDbvRnQccNTX19tZZ4smhEHrlG0ZReT9KKE1J6bLrYU4OVPsVJkSI/ajTaNb7hm7TA8NTyW/j
 WgI4SmjXTd6Rre2qEraKWfkYOY0nu51//khh5m1kghLyOMrgH0M9Ddej5X5APsfk+GVQvoNRYtx
 u+TyHASjS9lvi4haUYd/iTgtZNGJlHBaNiyRKLGDty/gnx4EKl4wdALFAvwPt155NbFqUJLrkyb
 KCoUgH7eV+HRwgltfVDJCzOCHVEx7fPKYOPcLmc14ByR5YFmGb9nAu+wd2aNAO6WxbXYbcTR
X-Authority-Analysis: v=2.4 cv=QM1oRhLL c=1 sm=1 tr=0 ts=686f4f63 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=7CQSdrXTAAAA:8
 a=COk6AnOGAAAA:8 a=kfjrt-ETKUMyBX4eaP0A:9 a=QEXdDO2ut3YA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: k3Ke-XBgBA8mo-mhPmIquEVA4vNb_inx
X-Proofpoint-GUID: k3Ke-XBgBA8mo-mhPmIquEVA4vNb_inx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507100044

Add a driver to support Coresight device Trace Network On Chip (TNOC),
which is an integration hierarchy integrating functionalities of TPDA
and funnels. It aggregates the trace and transports to coresight trace
bus.

Compared to current configuration, it has the following advantages:
1. Reduce wires between subsystems.
2. Continue cleaning the infrastructure.
3. Reduce Data overhead by transporting raw data from source to target.

  +------------------------+                +-------------------------+
  | Video Subsystem        |                |Video Subsystem          |
  |       +-------------+  |                |       +------------+    |
  |       | Video TPDM  |  |                |       | Video TPDM |    |
  |       +-------------+  |                |       +------------+    |
  |            |           |                |              |          |
  |            v           |                |              v          |
  |   +---------------+    |                |        +-----------+    |
  |   | Video funnel  |    |                |        |Video TNOC |    |
  |   +---------------+    |                |        +-----------+    |
  +------------|-----------+                +------------|------------+
               |                                         |
               v-----+                                   |
+--------------------|---------+                         |
|  Multimedia        v         |                         |
|  Subsystem   +--------+      |                         |
|              |  TPDA  |      |                         v
|              +----|---+      |              +---------------------+
|                   |          |              |   Aggregator  TNOC  |
|                   |          |              +----------|----------+
|                   +--        |                         |
|                     |        |                         |
|                     |        |                         |
|              +------v-----+  |                         |
|              |  Funnel    |  |                         |
|              +------------+  |                         |
+----------------|-------------+                         |
                 |                                       |
                 v                                       v
      +--------------------+                    +------------------+
      |   Coresight Sink   |                    |  Coresight Sink  |
      +--------------------+                    +------------------+

       Current Configuration                            TNOC

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Yuanfang Zhang <quic_yuanfang@quicinc.com>
---
 drivers/hwtracing/coresight/Kconfig          |  12 ++
 drivers/hwtracing/coresight/Makefile         |   1 +
 drivers/hwtracing/coresight/coresight-tnoc.c | 242 +++++++++++++++++++++++++++
 3 files changed, 255 insertions(+)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index f064e3d172b3d630515bb3a11450e883a6b5b4bf..6a4239ebb582e95f0ebe8e9c8738a726f27f60a1 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -268,4 +268,16 @@ config CORESIGHT_KUNIT_TESTS
 	    Enable Coresight unit tests. Only useful for development and not
 	    intended for production.
 
+config CORESIGHT_TNOC
+	tristate "Coresight Trace Network On Chip driver"
+	help
+	  This driver provides support for Trace Network On Chip (TNOC) component.
+	  TNOC is an interconnect used to collect traces from various subsystems
+	  and transport to a coresight trace sink. It sits in the different
+	  tiles of SOC and aggregates the trace local to the tile and transports
+	  it another tile or to coresight trace sink eventually.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called coresight-tnoc.
+
 endif
diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index 4e7cc3c5bf994d4066adc3b6c203edd19e88a823..ab16d06783a572ea1308dfb3a30c96df9e5ffdb7 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_CORESIGHT_SINK_TPIU) += coresight-tpiu.o
 obj-$(CONFIG_CORESIGHT_SINK_ETBV10) += coresight-etb10.o
 obj-$(CONFIG_CORESIGHT_LINKS_AND_SINKS) += coresight-funnel.o \
 					   coresight-replicator.o
+obj-$(CONFIG_CORESIGHT_TNOC) += coresight-tnoc.o
 obj-$(CONFIG_CORESIGHT_SOURCE_ETM3X) += coresight-etm3x.o
 coresight-etm3x-y := coresight-etm3x-core.o coresight-etm-cp14.o \
 		     coresight-etm3x-sysfs.o
diff --git a/drivers/hwtracing/coresight/coresight-tnoc.c b/drivers/hwtracing/coresight/coresight-tnoc.c
new file mode 100644
index 0000000000000000000000000000000000000000..0e4164707eea974e6f34d2de01693354d6eefdcd
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-tnoc.c
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+ #include <linux/amba/bus.h>
+ #include <linux/coresight.h>
+ #include <linux/device.h>
+ #include <linux/io.h>
+ #include <linux/kernel.h>
+ #include <linux/module.h>
+ #include <linux/of.h>
+ #include <linux/platform_device.h>
+
+#include "coresight-priv.h"
+#include "coresight-trace-id.h"
+
+#define TRACE_NOC_CTRL      0x008
+#define TRACE_NOC_XLD       0x010
+#define TRACE_NOC_FREQVAL   0x018
+#define TRACE_NOC_SYNCR     0x020
+
+/* Enable generation of output ATB traffic.*/
+#define TRACE_NOC_CTRL_PORTEN   BIT(0)
+/* Sets the type of issued ATB FLAG packets.*/
+#define TRACE_NOC_CTRL_FLAGTYPE BIT(7)
+/* Sets the type of issued ATB FREQ packet*/
+#define TRACE_NOC_CTRL_FREQTYPE BIT(8)
+
+#define TRACE_NOC_SYNC_INTERVAL	0xFFFF
+
+/*
+ * struct trace_noc_drvdata - specifics associated to a trace noc component
+ * @base:      memory mapped base address for this component.
+ * @dev:       device node for trace_noc_drvdata.
+ * @csdev:     component vitals needed by the framework.
+ * @spinlock:  serialize enable/disable operation.
+ * @atid:      id for the trace packet.
+ */
+struct trace_noc_drvdata {
+	void __iomem		*base;
+	struct device		*dev;
+	struct coresight_device	*csdev;
+	spinlock_t		spinlock;
+	u32			atid;
+};
+
+DEFINE_CORESIGHT_DEVLIST(trace_noc_devs, "traceNoc");
+
+static void trace_noc_enable_hw(struct trace_noc_drvdata *drvdata)
+{
+	u32 val;
+
+	/* Set ATID */
+	writel_relaxed(drvdata->atid, drvdata->base + TRACE_NOC_XLD);
+
+	/* Set the data word count between 'SYNC' packets */
+	writel_relaxed(TRACE_NOC_SYNC_INTERVAL, drvdata->base + TRACE_NOC_SYNCR);
+
+	/* Set the Control register:
+	 * - Set the FLAG packets to 'FLAG' packets
+	 * - Set the FREQ packets to 'FREQ_TS' packets
+	 * - Enable generation of output ATB traffic
+	 */
+
+	val = readl_relaxed(drvdata->base + TRACE_NOC_CTRL);
+
+	val &= ~TRACE_NOC_CTRL_FLAGTYPE;
+	val |= TRACE_NOC_CTRL_FREQTYPE;
+	val |= TRACE_NOC_CTRL_PORTEN;
+
+	writel(val, drvdata->base + TRACE_NOC_CTRL);
+}
+
+static int trace_noc_enable(struct coresight_device *csdev, struct coresight_connection *inport,
+			    struct coresight_connection *outport)
+{
+	struct trace_noc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	scoped_guard(spinlock, &drvdata->spinlock) {
+		if (csdev->refcnt == 0)
+			trace_noc_enable_hw(drvdata);
+
+		csdev->refcnt++;
+	}
+
+	dev_dbg(drvdata->dev, "Trace NOC is enabled\n");
+	return 0;
+}
+
+static void trace_noc_disable(struct coresight_device *csdev, struct coresight_connection *inport,
+			      struct coresight_connection *outport)
+{
+	struct trace_noc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	scoped_guard(spinlock, &drvdata->spinlock) {
+		if (--csdev->refcnt == 0)
+			writel(0x0, drvdata->base + TRACE_NOC_CTRL);
+	}
+	dev_dbg(drvdata->dev, "Trace NOC is disabled\n");
+}
+
+static int trace_noc_id(struct coresight_device *csdev, __maybe_unused enum cs_mode mode,
+			__maybe_unused struct coresight_device *sink)
+{
+	struct trace_noc_drvdata *drvdata;
+
+	drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	return drvdata->atid;
+}
+
+static const struct coresight_ops_link trace_noc_link_ops = {
+	.enable		= trace_noc_enable,
+	.disable	= trace_noc_disable,
+};
+
+static const struct coresight_ops trace_noc_cs_ops = {
+	.trace_id	= trace_noc_id,
+	.link_ops	= &trace_noc_link_ops,
+};
+
+static int trace_noc_init_default_data(struct trace_noc_drvdata *drvdata)
+{
+	int atid;
+
+	atid = coresight_trace_id_get_system_id();
+	if (atid < 0)
+		return atid;
+
+	drvdata->atid = atid;
+
+	return 0;
+}
+
+static ssize_t traceid_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	unsigned long val;
+	struct trace_noc_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	val = drvdata->atid;
+	return sprintf(buf, "%#lx\n", val);
+}
+static DEVICE_ATTR_RO(traceid);
+
+static struct attribute *coresight_tnoc_attrs[] = {
+	&dev_attr_traceid.attr,
+	NULL,
+};
+
+static const struct attribute_group coresight_tnoc_group = {
+	.attrs = coresight_tnoc_attrs,
+};
+
+static const struct attribute_group *coresight_tnoc_groups[] = {
+	&coresight_tnoc_group,
+	NULL,
+};
+
+static int trace_noc_probe(struct amba_device *adev, const struct amba_id *id)
+{
+	struct device *dev = &adev->dev;
+	struct coresight_platform_data *pdata;
+	struct trace_noc_drvdata *drvdata;
+	struct coresight_desc desc = { 0 };
+	int ret;
+
+	desc.name = coresight_alloc_device_name(&trace_noc_devs, dev);
+	if (!desc.name)
+		return -ENOMEM;
+
+	pdata = coresight_get_platform_data(dev);
+	if (IS_ERR(pdata))
+		return PTR_ERR(pdata);
+	adev->dev.platform_data = pdata;
+
+	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	drvdata->dev = &adev->dev;
+	dev_set_drvdata(dev, drvdata);
+
+	drvdata->base = devm_ioremap_resource(dev, &adev->res);
+	if (!drvdata->base)
+		return -ENOMEM;
+
+	spin_lock_init(&drvdata->spinlock);
+
+	ret = trace_noc_init_default_data(drvdata);
+	if (ret)
+		return ret;
+
+	desc.ops = &trace_noc_cs_ops;
+	desc.type = CORESIGHT_DEV_TYPE_LINK;
+	desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_MERG;
+	desc.pdata = adev->dev.platform_data;
+	desc.dev = &adev->dev;
+	desc.access = CSDEV_ACCESS_IOMEM(drvdata->base);
+	desc.groups = coresight_tnoc_groups;
+	drvdata->csdev = coresight_register(&desc);
+	if (IS_ERR(drvdata->csdev)) {
+		coresight_trace_id_put_system_id(drvdata->atid);
+		return PTR_ERR(drvdata->csdev);
+	}
+	pm_runtime_put(&adev->dev);
+
+	return 0;
+}
+
+static void trace_noc_remove(struct amba_device *adev)
+{
+	struct trace_noc_drvdata *drvdata = dev_get_drvdata(&adev->dev);
+
+	coresight_unregister(drvdata->csdev);
+	coresight_trace_id_put_system_id(drvdata->atid);
+}
+
+static struct amba_id trace_noc_ids[] = {
+	{
+		.id     = 0x000f0c00,
+		.mask   = 0x00ffff00,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(amba, trace_noc_ids);
+
+static struct amba_driver trace_noc_driver = {
+	.drv = {
+		.name   = "coresight-trace-noc",
+		.suppress_bind_attrs = true,
+	},
+	.probe          = trace_noc_probe,
+	.remove		= trace_noc_remove,
+	.id_table	= trace_noc_ids,
+};
+
+module_amba_driver(trace_noc_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Trace NOC driver");

-- 
2.34.1


