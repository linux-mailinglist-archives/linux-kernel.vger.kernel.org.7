Return-Path: <linux-kernel+bounces-775416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C05E7B2BEE6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D5B91B6394A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D2832276A;
	Tue, 19 Aug 2025 10:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YssduXWz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F5831CA7C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755599278; cv=none; b=m1M2bkI/zvMpNqF3ODtCxW1zi0jqbNaFaP2JnYuzDxjtHg/DFbLM4lyMhxq7QRkikJufumL7VQbfGy24+YvUPILVnrDqgvAAvTmwRBSBy5ZndnkKztr7j6nzxz4+5MuNRkBYX+PmN/DKgKN/n/TLbZdEUp5DLRFDukdpffsnM5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755599278; c=relaxed/simple;
	bh=XO9D6AwhUNAnacAZyuMr3vcbzQlze7wwXSgBjm1UkaA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c87MWlcmbTJ8lSjXUSjDHuDsgA0RHF9tXZHh22/7t0JbuSSu9EgPhiIGbr3fi7R3y9AAs28FTf3pTKlFxhHUhYa7hgNds0voXJNhilzXQcajfl1shXsZLtQ54NPM0A1kUfBtBPvIiE5TgR3Aj23dejb3BTgMzXzQ0+jbYOGv/Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YssduXWz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90iHS021904
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:27:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cImJsAweHgFKioboFNl2oSzG/5IDjBZZwddm+qkdJKQ=; b=YssduXWzAuALRbLC
	WNing4pNcgkCNJIxh1kbSVqMUccako0b3Cj9gOHmeXLrd9g/88BdGdbOBN1Cmkn+
	xLs3u2uxbHCTwIQLWUrytmL4jWus7bcQi8ROVv7uIxRR1jjeZF9lNdSS5WO1K2nG
	Islk9TiLYy/wAZIG9IRNZMqFNVW3+9YigVg0XDyGbPDiI/kGjEJaF0wfNWPGZYLb
	VsbCcLz1MJu2JYga+uqzctvYR9ya858Gd4QzeV0i3A3pEdzaj1wcOMdLG1cVETHH
	0htPJBUx5V8HwLaicUHpvMel9NZ1X8DXGqOMCUJXkvhZCFMKEUSkuGaUiFVAvdws
	u298tA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48m71cjvrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:27:56 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4716fa1e59so4353143a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755599275; x=1756204075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cImJsAweHgFKioboFNl2oSzG/5IDjBZZwddm+qkdJKQ=;
        b=qx5GFfja/gWDMAEUkLzV0gBN6L07JAqIf4fZqYlbevn0D3UrPEggf+577Gi2txuCAz
         oYAVYUmKVwzj8oBfYYi0qcIGCe5HdyGOTFyQs0yYyDUYs83VD66hBYNo7NYFVDfu+i5A
         frxrOz59DuQZs99a1AQvF/lM1CR7TzmogCr4xqW4i3owVI2YDM0RA636YRw39I2G/dFZ
         7VwE7Q/79TbBFRW9wRbUB+tm+zY7kL1fOvrwt47Nv8xrSFF4aj0Ab3Aqj/b+ymzPhXUN
         tTz5yT0615NTTPvips5xrNv57zAhv0T0m/1Fc1Y9+h5AehyZUrzAm1oY6IiJrerh2r7U
         8FnA==
X-Forwarded-Encrypted: i=1; AJvYcCX48HcPGC/xx+392+EpjVBvM/LhdKVqVPPEXZy5tIbMeMwEq2qCc1vpZllkJRv406mcXXMIZxORBio/4IE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYcVMaBKKg4wJx6V950LUTOPKC2VWs3zQyaAuL+YmUq6rUenY9
	ITmH+bzQn2NC9Qqtm6nbjSL0RMxiUwnD92IaWORdYtnDE8947IWOxAZvi9mCjzaqt0Gsx8wJgF0
	f6kt69sKYG2B+D/4HweyJBbT/acU0c+6U7QswUloIYqbZ0F9BDMc48X0M4Fb3/EB49WE=
X-Gm-Gg: ASbGncvWnboyiLqhOZG98JguQLibqgrXbLV9HQ/WupfVdHwH0Inx0AkSM45NdtAs+k0
	p2Tm1yjpBBeXvnXAHjI8N+EFQi8Bnozf2eIaYtuCCMlY1zlxXxm/AqOwdvctvdmIorORKkfwfYa
	Cc0cp/okFo+JY/mI+dDOKWG/2W4ny/exWIfP3QmTz9B/hi99L+Jiygg99w4qrDpIynBJWB3QJUX
	4XK+a9T1LVRwToMTgI9Oaus5B/VVla3iYTorBmmuCpBaAJsLoYRq7APg5W5LnrigTsQUDP+bn08
	5RBJQFa7G92pibajyWIG3DfaDm3NvUXOb5Az2pMxcQt84uS5L8K0BiDlypvi29z/hNY1fcFB6Mk
	DifT6wbAP/M7azZ6+wNtpdQ==
X-Received: by 2002:a05:6a20:3d07:b0:23e:19fd:e18f with SMTP id adf61e73a8af0-2430d42de0fmr2739843637.35.1755599275485;
        Tue, 19 Aug 2025 03:27:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6GGIZhxrnmD9roD8ShgJeEsO3lov+BMPjiKwTc0CsQQuDH53U0AS/ChsScRIhHH/GKUGPgA==
X-Received: by 2002:a05:6a20:3d07:b0:23e:19fd:e18f with SMTP id adf61e73a8af0-2430d42de0fmr2739808637.35.1755599274967;
        Tue, 19 Aug 2025 03:27:54 -0700 (PDT)
Received: from hu-yuanfang-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3237e3eef8fsm2499643a91.18.2025.08.19.03.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:27:54 -0700 (PDT)
From: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 03:27:44 -0700
Subject: [PATCH v2 2/3] coresight-tnoc: add platform driver to support
 Interconnect TNOC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-itnoc-v2-2-2d0e6be44e2f@oss.qualcomm.com>
References: <20250819-itnoc-v2-0-2d0e6be44e2f@oss.qualcomm.com>
In-Reply-To: <20250819-itnoc-v2-0-2d0e6be44e2f@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: kernel@oss.qualcomm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755599271; l=7467;
 i=yuanfang.zhang@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=XO9D6AwhUNAnacAZyuMr3vcbzQlze7wwXSgBjm1UkaA=;
 b=ZlUiRoSRBBukIvPcZLBxJbhHLQf6Cy8WzWkVJGbcJBK/MhJvZpBxH4ihhyf9kUzrx3zgA7Nj/
 NV/v1ngkFWWApBZBipPi8XEIi33vZmbmYYirK25LZdBVXVv4eJQZjU0
X-Developer-Key: i=yuanfang.zhang@oss.qualcomm.com; a=ed25519;
 pk=9oS/FoPW5k0CsqSDDrPlnV+kVIOUaAe0O5pr4M1wHgY=
X-Proofpoint-ORIG-GUID: 5cbJovMzPtCPWRS86pMFdinTMGmg6JJl
X-Proofpoint-GUID: 5cbJovMzPtCPWRS86pMFdinTMGmg6JJl
X-Authority-Analysis: v=2.4 cv=IvQecK/g c=1 sm=1 tr=0 ts=68a451ac cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=vZzgk5nmo-DiXalhxAsA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDE0NyBTYWx0ZWRfX+UGUuKJ2em9x
 Buu8zPJqgLAgFI8ESk4D+yxjQikBl3DxyRtwx0M1bqYzSFs1oBhthT/N9izO2fMIo8z2ZjnFwpw
 PNbyM++txngCbVsTIpDwhc8pcIsjgELJDcmqh5aBisMbarhObfNIkTFW6rmhoSo0o2bBEOiMmNL
 mqmHwafhU4OoR9tBLumsOMyK9lvIfkQ1nhVzHfNC38U0YleMPc5+gnINedr9TdPkT3OYHSlU/LE
 gbCffE6TZNpySruWfzX/Q8WotTYaOgTsh0BBOWkvhko+JFS9Ftr5Gx26qn93TbBPKCU3wRRn4qc
 /ddkwDEpQOOQwnCbx29iPDStrXiZSBnzzCYuaVUCahLCT2AGJIRb/7NxYBn5EXnbPh/MF5QvWaS
 JrK2H4vz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508180147

This patch adds platform driver support for the CoreSight Interconnect
TNOC, Interconnect TNOC is a CoreSight link that forwards trace data
from a subsystem to the Aggregator TNOC. Compared to Aggregator TNOC,
it does not have aggregation and ATID functionality.

Key changes:
- Add platform driver `coresight-itnoc` with device tree match support.
- Refactor probe logic into a common `_tnoc_probe()` function.
- Conditionally initialize ATID only for AMBA-based TNOC blocks.

Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-tnoc.c | 124 +++++++++++++++++++++++----
 1 file changed, 107 insertions(+), 17 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tnoc.c b/drivers/hwtracing/coresight/coresight-tnoc.c
index d542df46ea39314605290311f683010337bfd4bd..407595e893096d8011dfcefd74cca742d9b96695 100644
--- a/drivers/hwtracing/coresight/coresight-tnoc.c
+++ b/drivers/hwtracing/coresight/coresight-tnoc.c
@@ -34,6 +34,7 @@
  * @base:      memory mapped base address for this component.
  * @dev:       device node for trace_noc_drvdata.
  * @csdev:     component vitals needed by the framework.
+ * @pclk:	APB clock if present, otherwise NULL
  * @spinlock:  serialize enable/disable operation.
  * @atid:      id for the trace packet.
  */
@@ -41,8 +42,9 @@ struct trace_noc_drvdata {
 	void __iomem		*base;
 	struct device		*dev;
 	struct coresight_device	*csdev;
+	struct clk		*pclk;
 	spinlock_t		spinlock;
-	u32			atid;
+	int			atid;
 };
 
 DEFINE_CORESIGHT_DEVLIST(trace_noc_devs, "traceNoc");
@@ -51,25 +53,30 @@ static void trace_noc_enable_hw(struct trace_noc_drvdata *drvdata)
 {
 	u32 val;
 
+	/* No valid ATID, simply enable the unit */
+	if (drvdata->atid == -EOPNOTSUPP) {
+		writel(TRACE_NOC_CTRL_PORTEN, drvdata->base + TRACE_NOC_CTRL);
+		return;
+	}
+
 	/* Set ATID */
 	writel_relaxed(drvdata->atid, drvdata->base + TRACE_NOC_XLD);
 
 	/* Set the data word count between 'SYNC' packets */
 	writel_relaxed(TRACE_NOC_SYNC_INTERVAL, drvdata->base + TRACE_NOC_SYNCR);
-
 	/* Set the Control register:
-	 * - Set the FLAG packets to 'FLAG' packets
-	 * - Set the FREQ packets to 'FREQ_TS' packets
-	 * - Enable generation of output ATB traffic
-	 */
+		* - Set the FLAG packets to 'FLAG' packets
+		* - Set the FREQ packets to 'FREQ_TS' packets
+		* - Enable generation of output ATB traffic
+		*/
 
 	val = readl_relaxed(drvdata->base + TRACE_NOC_CTRL);
 
 	val &= ~TRACE_NOC_CTRL_FLAGTYPE;
 	val |= TRACE_NOC_CTRL_FREQTYPE;
 	val |= TRACE_NOC_CTRL_PORTEN;
-
 	writel(val, drvdata->base + TRACE_NOC_CTRL);
+
 }
 
 static int trace_noc_enable(struct coresight_device *csdev, struct coresight_connection *inport,
@@ -124,6 +131,11 @@ static int trace_noc_init_default_data(struct trace_noc_drvdata *drvdata)
 {
 	int atid;
 
+	if (!dev_is_amba(drvdata->dev)) {
+		drvdata->atid = -EOPNOTSUPP;
+		return 0;
+	}
+
 	atid = coresight_trace_id_get_system_id();
 	if (atid < 0)
 		return atid;
@@ -149,8 +161,21 @@ static struct attribute *coresight_tnoc_attrs[] = {
 	NULL,
 };
 
+static umode_t trace_id_is_visible(struct kobject *kobj,
+				   struct attribute *attr, int idx)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct trace_noc_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	if (attr == &dev_attr_traceid.attr && drvdata->atid < 0)
+		return 0;
+
+	return attr->mode;
+}
+
 static const struct attribute_group coresight_tnoc_group = {
 	.attrs = coresight_tnoc_attrs,
+	.is_visible = trace_id_is_visible,
 };
 
 static const struct attribute_group *coresight_tnoc_groups[] = {
@@ -158,9 +183,8 @@ static const struct attribute_group *coresight_tnoc_groups[] = {
 	NULL,
 };
 
-static int trace_noc_probe(struct amba_device *adev, const struct amba_id *id)
+static int _tnoc_probe(struct device *dev, struct resource *res)
 {
-	struct device *dev = &adev->dev;
 	struct coresight_platform_data *pdata;
 	struct trace_noc_drvdata *drvdata;
 	struct coresight_desc desc = { 0 };
@@ -173,16 +197,20 @@ static int trace_noc_probe(struct amba_device *adev, const struct amba_id *id)
 	pdata = coresight_get_platform_data(dev);
 	if (IS_ERR(pdata))
 		return PTR_ERR(pdata);
-	adev->dev.platform_data = pdata;
+	dev->platform_data = pdata;
 
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
 		return -ENOMEM;
 
-	drvdata->dev = &adev->dev;
+	drvdata->dev = dev;
 	dev_set_drvdata(dev, drvdata);
 
-	drvdata->base = devm_ioremap_resource(dev, &adev->res);
+	ret = coresight_get_enable_clocks(dev, &drvdata->pclk, NULL);
+	if (ret)
+		return ret;
+
+	drvdata->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(drvdata->base))
 		return PTR_ERR(drvdata->base);
 
@@ -195,20 +223,31 @@ static int trace_noc_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.ops = &trace_noc_cs_ops;
 	desc.type = CORESIGHT_DEV_TYPE_LINK;
 	desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_MERG;
-	desc.pdata = adev->dev.platform_data;
-	desc.dev = &adev->dev;
+	desc.pdata = pdata;
+	desc.dev = dev;
 	desc.access = CSDEV_ACCESS_IOMEM(drvdata->base);
 	desc.groups = coresight_tnoc_groups;
 	drvdata->csdev = coresight_register(&desc);
 	if (IS_ERR(drvdata->csdev)) {
-		coresight_trace_id_put_system_id(drvdata->atid);
+		if (drvdata->atid > 0)
+			coresight_trace_id_put_system_id(drvdata->atid);
 		return PTR_ERR(drvdata->csdev);
 	}
-	pm_runtime_put(&adev->dev);
 
 	return 0;
 }
 
+static int trace_noc_probe(struct amba_device *adev, const struct amba_id *id)
+{
+	int ret;
+
+	ret = _tnoc_probe(&adev->dev, &adev->res);
+	if (!ret)
+		pm_runtime_put(&adev->dev);
+
+	return ret;
+}
+
 static void trace_noc_remove(struct amba_device *adev)
 {
 	struct trace_noc_drvdata *drvdata = dev_get_drvdata(&adev->dev);
@@ -236,7 +275,58 @@ static struct amba_driver trace_noc_driver = {
 	.id_table	= trace_noc_ids,
 };
 
-module_amba_driver(trace_noc_driver);
+static int itnoc_probe(struct platform_device *pdev)
+{
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	int ret;
+
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	ret = _tnoc_probe(&pdev->dev, res);
+	pm_runtime_put(&pdev->dev);
+	if (ret)
+		pm_runtime_disable(&pdev->dev);
+
+	return ret;
+}
+
+static void itnoc_remove(struct platform_device *pdev)
+{
+	struct trace_noc_drvdata *drvdata = platform_get_drvdata(pdev);
+
+	coresight_unregister(drvdata->csdev);
+	pm_runtime_disable(&pdev->dev);
+}
+
+static const struct of_device_id itnoc_of_match[] = {
+	{ .compatible = "qcom,coresight-itnoc" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, itnoc_of_match);
+
+static struct platform_driver itnoc_driver = {
+	.probe = itnoc_probe,
+	.remove = itnoc_remove,
+	.driver = {
+		.name = "coresight-itnoc",
+		.of_match_table = itnoc_of_match,
+		.suppress_bind_attrs = true,
+	},
+};
+
+static int __init tnoc_init(void)
+{
+	return coresight_init_driver("tnoc", &trace_noc_driver, &itnoc_driver, THIS_MODULE);
+}
+
+static void __exit tnoc_exit(void)
+{
+	coresight_remove_driver(&trace_noc_driver, &itnoc_driver);
+}
+module_init(tnoc_init);
+module_exit(tnoc_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Trace NOC driver");

-- 
2.34.1


