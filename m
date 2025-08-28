Return-Path: <linux-kernel+bounces-789613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52844B3983F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FE531C26467
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809FC2EFD9E;
	Thu, 28 Aug 2025 09:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cqPaEDs3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61542EA480
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 09:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756373253; cv=none; b=kl4e/2rcpabQUnHyryRXGs9Az6f0OHIarMpo490S4cFh2fMEcRYLLo9bsJCOrwCA3ArtdRxqpA66TUAD7OZpYkNEtmillFXGKUEeyavpOaPu2kzO5bHGLG3F3fuo85XYioudGSS+RtQ/ItOz7TlB32DZwsc3iCeU/3fxKferDB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756373253; c=relaxed/simple;
	bh=Z1eZnevWYnpyIWyKbJ9mcPze0cP6MZDj2l5bPS/eoB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sg5IuxonvAFhE/HfwZal4ZbS8a6si5geHXIy+BCZlGV3jZO1VA6UEjWHCALbKbh/H85aI2gmaU/dEqvh1uMWUVil43/b5334ONqWGrx+dn5tUv5rWTA1wzIu9uOkc1bJ2zgTVh08CDk7Yp6ksgoo9BGHFguBU/HIKsCpyFkV+dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cqPaEDs3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S2hFUD002200
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 09:27:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wKIdXBVxutyc8Yt4qrD8SDHqVrhzt82FltAq6xGnVQ0=; b=cqPaEDs3JrHzjMkU
	S6HU1E20b4XpzBlBTHrY+mEBv4YUG0NqhHeEhOYzxxCmYC1qo7LsDH1Gc07iAEws
	z/rrgIuzz7FXeMM9Le8+vE04S7iKXnINpVG+zwvJV6+JhFwonMG5zpIL2Z8X6H7E
	19LojccQOcLSYviTshB+fEaZaoSFmVtXQ3wLd2iPQoewNi/QCfmqsnLaa9f/MqLX
	9MDxEsWunOqbjNlLC+vcw3bcOqEh9y3fQO367n2qFZumXFqNuwS8MBJwupwLh9hj
	aUGqg/ndzHbdEMJpfpecIvCKlbalbXWzrYd2/vcMxvhj8IRWYE4Fb9B9enS4BCrO
	lKRV2w==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5y5qg1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 09:27:30 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b471737e673so1304432a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 02:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756373249; x=1756978049;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKIdXBVxutyc8Yt4qrD8SDHqVrhzt82FltAq6xGnVQ0=;
        b=pDpxrYv4KIdDs9yDYIsU824/wn8eV4qZFL418NueCE1H6vgs1bZkOow5sGFY73eH6w
         suvaLa7oTVOakeYJtCtWnQXafv7O5IgS6AlAAneYISpvW2Uz4WhWLPKEBUu66jwyU7Q6
         e5EA3nq/LoB2Kp4vR1locmctgkuULLP5st6ee1S7GDiWUBcL6ZlzYxDx5m12bK/7l4UY
         2MooAnitYYSJzr37HVtciVgupezFECEa8yLaBXY7JKg8r/Mj2oORHg3HyzTmNMX+Iz0P
         +0Lm0XKRtFL0RIFydaCoBAnYrSgDSNo7FD2nNQvbUjjxBRO61ZqkWxjC06QJl/g1uSlq
         cZHg==
X-Forwarded-Encrypted: i=1; AJvYcCWXyDZLGzLr//GTB2R9BaZSeQD69FBx+3wXNOtMONNYWEogtrhGV0g/lG8rxjtFEY0+0G05VbBpKoGJyQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpsokR4uLwnxe5tWtxTjelwNG+MNBsultqf5jB0j5rK5ZkOjAr
	PT116KVWx18aK5CLPkMjYIduHMSLeDEWh2fes19q6Gde4NZIbH55Q2frNfkYkMuuW9Qq4JLeWgP
	if+oqVgqly6Sza/2uODObHvrb/rXCrVtS7SVFjWN4GDFhDahAOeHD9kxfRMnp9RgIEm4=
X-Gm-Gg: ASbGncvb1oRWBw27uq3Yy0BvSdKfCyEkCSq3X+SOkq6vsvWbASIYEpXnluiL0KW7f2R
	Oo0/RPqLAtY9XP4OrB05KcAbaFz3MXghpJENcrKZbt1Bxxx5RHY6MxQZ1JvRyXJQIhRvN+pJfc9
	+HRKNb59QlSdUGtTtlOddUZNBU9zX5LwnGUUNt7B24iPoriPgFxkTeUIXGyLFNyspAZXxhet0w3
	NRHNeeaHYeCUUeLZHos9RM7gF01Z7fMCKdvIysrXiM6jzi0aynhjhe/8JWs9ke0viWdavLIPIB/
	NnnLfw+V33Rg5ofaGZS9nD/T6KHqgJAvht4RP6DVzy/TBTzUyxPSG5gtz40Lav5ULKgB6ECWD4l
	p6JwE4Pp+oFODVY0Cpj5uCw==
X-Received: by 2002:a17:903:943:b0:234:b743:c7a4 with SMTP id d9443c01a7336-2462eeb75edmr278218585ad.38.1756373249436;
        Thu, 28 Aug 2025 02:27:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8bhrS/FHtm9K9UqNFSs1oYSrwJND1nV5qQFHIBImBkF0Oz12krvGLgAxPoglax5tDS/693g==
X-Received: by 2002:a17:903:943:b0:234:b743:c7a4 with SMTP id d9443c01a7336-2462eeb75edmr278218465ad.38.1756373248954;
        Thu, 28 Aug 2025 02:27:28 -0700 (PDT)
Received: from hu-yuanfang-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246ed91ee20sm92497015ad.136.2025.08.28.02.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 02:27:28 -0700 (PDT)
From: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 02:27:23 -0700
Subject: [PATCH v3 2/3] coresight-tnoc: add platform driver to support
 Interconnect TNOC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-itnoc-v3-2-f1b55dea7a27@oss.qualcomm.com>
References: <20250828-itnoc-v3-0-f1b55dea7a27@oss.qualcomm.com>
In-Reply-To: <20250828-itnoc-v3-0-f1b55dea7a27@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756373245; l=7284;
 i=yuanfang.zhang@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=Z1eZnevWYnpyIWyKbJ9mcPze0cP6MZDj2l5bPS/eoB8=;
 b=nAWlBA6HM/gtRZPVJfqqW6BAai6jca5mXaH+6xDBN0pEgZT/mWyyMrmD1X74QIykxkiSoeO4b
 6NLb6TAq4fkBvCmg8WgK4KpBzdjqQFLGLen0v53MUOx6H/VABzcfQnB
X-Developer-Key: i=yuanfang.zhang@oss.qualcomm.com; a=ed25519;
 pk=9oS/FoPW5k0CsqSDDrPlnV+kVIOUaAe0O5pr4M1wHgY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX1ljwNVua8pq/
 YieY7ZZ0GVrtx0QrTzGpOeZAbZVL0jYXGXk+50rhS+JCKhCYWVH+mb973Vp4hfZfWfWjIUqVNmj
 tjGa2mgXIG7JXVZ8Mg5uBbkIntew91tu+NH6FtOQt3i5KPIQmtewJev/Nf1tJyH7pcK96mBiAsZ
 MT9Y4FBiN6JNO5pyvWZXCfPnW44BnEpEOWAB5dqNSgM+vcUrFbn0ieynFcsZcy4qKILEYHeUUbb
 jLpUTkhNQ65/SICHb+M5PUcw4ORWvb0FM7vFf1KHqaC3LPQyYRHMUWn9Y0HBU9b1XRSXyQaozLr
 wy1V1qYZ1LfUp/+m0kOdIkvf1OzAD97vZVaotj9rUDiV6xZrlhK0G28Uo+6up4NyGd03XjwuO+x
 4uluCntl
X-Authority-Analysis: v=2.4 cv=Lco86ifi c=1 sm=1 tr=0 ts=68b02102 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=YgsqhSH9U0MoioIrZkcA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: edNyshiXAguNbz29mOgcJKp80OSMpUbI
X-Proofpoint-ORIG-GUID: edNyshiXAguNbz29mOgcJKp80OSMpUbI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

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
 drivers/hwtracing/coresight/coresight-tnoc.c | 116 ++++++++++++++++++++++++---
 1 file changed, 103 insertions(+), 13 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tnoc.c b/drivers/hwtracing/coresight/coresight-tnoc.c
index d542df46ea39314605290311f683010337bfd4bd..ca96c3e66d683d6c1d1215b1b48d2f7b7f58d5b0 100644
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
@@ -51,12 +53,17 @@ static void trace_noc_enable_hw(struct trace_noc_drvdata *drvdata)
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
 	 * - Set the FLAG packets to 'FLAG' packets
 	 * - Set the FREQ packets to 'FREQ_TS' packets
@@ -68,8 +75,8 @@ static void trace_noc_enable_hw(struct trace_noc_drvdata *drvdata)
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


