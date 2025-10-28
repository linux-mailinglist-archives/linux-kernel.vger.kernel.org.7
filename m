Return-Path: <linux-kernel+bounces-873115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB85C13294
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C51E586DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCDF2C158F;
	Tue, 28 Oct 2025 06:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IvbUDwi0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E9C29E110
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761632899; cv=none; b=re2hA7NAwDLdjf15vQ7U5/E/hTJ14i29YkEi3z89E46GY2wuc5ti8ZgtrQM3eNzFf5Y7xK0zuuUPyUCCeubEInPDVf6ZGKeE7fXAnAqwjdqjwxx6xtKzH7JZSPxppmCbQKRoNCuUZMY9lLWY2J/lV8V5khKlz1aNTGktm4xEFkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761632899; c=relaxed/simple;
	bh=0zJwLJ/CbFy+0o+vHzhKVbidP9iIvwNMjcD10+y0AC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nQPQuw6NjHoca9FPN35x/waEGjl4V3rh1mqmTJus82hxvINkFbIT5ItefRqoHEG0RF/BlkX8IZ3VMyDh/VDY/eHngFT+S0tSRI0JR49WsMwML/oaYQrOuYmfBCoXuJOXtUV+ii77sotIxqs3Ww7cM4yyLesotsHJO6XUBN/sSVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IvbUDwi0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59S39Eir2232100
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ihaICepOH/H2KF61P/KWnAMH4iJmI07j1aiDcVn4nw0=; b=IvbUDwi0+gLPIW6t
	Mshh+4EJYSr23lTAw9NvhaANgTOIaAtyoJCiPlkqfhcRKuKjYXyZWqTHRWdy51tv
	H3DCHnhNHqtnr/z3J9nEu9xHo4tsTisPJOcQCy5m94CvWWNFIPmSthJPdhpvFrcq
	FlEVRKXCfmHgFGtXIe5GxOup55tLgMNKlFYshsBYtzrrJ1JsXw1BPcwqoxt3PEIV
	JbzIgmpPx/HvGQC88CAK1YwjQvJYMnCjhXhNGbOkg9nCZmeSF9Gi82jQwUGzgluk
	g1EJs7d45yb5Z/ySldH3Pmq0CJtfKBZEkrzr0qKgDI56jdHA1C6WVwMueVzNNoTI
	cM53tQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a24wnbmv1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:28:16 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-27c62320f16so54423555ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761632895; x=1762237695;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihaICepOH/H2KF61P/KWnAMH4iJmI07j1aiDcVn4nw0=;
        b=lwOJ9uGllAJNUgX0ovynFi3l8ZnKtdBnBZhhBaCGIhXYjON5RaEp1LeaIXqGrmYwBx
         xSWOrvP5WiLc2Xqot20PXZvE/uzEh4xD1QAyRxaXyGw3jHRwa+1+k3CE8heZOC4uA4fl
         HjMF3azD/FpOwzBjlgqz6D2M3fQm3nKNwTcv0EU00uR1eS9cwo///gczzHdK7PAYuU+u
         P8dRvYmFxDoRSJ1HXMCJM9MxwPHhVRKgnc1pqjk6gu4N2bc1Qcdly8DJKwCx4y8Yrt7G
         IzUOY+J71QOubUatotT5fuK77i8yQf+Kr1t+udi5Q1FXlNqcYGd36vMgeLYT8Ne7ahex
         Jqow==
X-Forwarded-Encrypted: i=1; AJvYcCW/1hfGDgrNO3vceG7Dz2RGxE91RMcNsAPT/RerttHDmoo5ejGEdqCfh71Yghe86yVxIXazkX/O3mXullc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxED/AQW5CEU1d2pKOWEFRWLdhWK33/quWoqnXSP4c1/kR24QqG
	TkdBJHOUHJXucFUihuPt+o/MWU1sRfFB+bd2mVyWr0Z4lrG8O0YFEBv7Vt9QISmLbM0uDQrbYLv
	y6GzoUE+vhajjpV9W4wKeiLZyyG53OO2OhM1EtvSq6qoeaUaSkeGpK0lbhwN/eHF9OnA=
X-Gm-Gg: ASbGncvnDXXI6LJ8PcDkbFdKpXF54XSOl4dZbqjgK8g1VjNwKqQDymG1VpRFS4juBRF
	9wt8beTjt+MvEoU7b4D041fKWnlg6N697SihUcvSOVGQcQ6xrkNivJZ8xDsSTOnUcX3I18L/f3x
	WWz4moEP1ueqlHzgKRiCNZHr3H7uHnxOcOeDTUlQRLgXYUPDHZLK/N0ODU7w6AcAyMgeehxD3C8
	h5y+OQrxxAKPLjC2GySsK06S2bl+/U+DsCylFn68IVmVV0MDLDu8i3zmtKsxQDrD5bnTZ2yjTmz
	DkfIsS216NoDS912gYh5g6WI4T5NsurMPIZu/EdHynaTne+EnmikyGUOulK8afTd2mCtNwXIIcD
	99Fz2tr9AVDF4v5EVirdocxWHf30CAQy8lgLL5tHeA9J8ikTPj+4IQpni
X-Received: by 2002:a17:902:ea08:b0:246:7a43:3f66 with SMTP id d9443c01a7336-294cb37a907mr28947295ad.7.1761632895361;
        Mon, 27 Oct 2025 23:28:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJKoZD7Rgv3OxbONxnAhm8PnP+RQwsXfsBy50pNztScJdWZVZNyqy9yffWSj3S68WVbYCEfQ==
X-Received: by 2002:a17:902:ea08:b0:246:7a43:3f66 with SMTP id d9443c01a7336-294cb37a907mr28946905ad.7.1761632894825;
        Mon, 27 Oct 2025 23:28:14 -0700 (PDT)
Received: from hu-yuanfang-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf359asm102503265ad.12.2025.10.27.23.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 23:28:14 -0700 (PDT)
From: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 23:28:04 -0700
Subject: [PATCH 02/12] coresight-funnel: Add support for CPU cluster funnel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-cpu_cluster_component_pm-v1-2-31355ac588c2@oss.qualcomm.com>
References: <20251027-cpu_cluster_component_pm-v1-0-31355ac588c2@oss.qualcomm.com>
In-Reply-To: <20251027-cpu_cluster_component_pm-v1-0-31355ac588c2@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linux.dev>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: kernel@oss.qualcomm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761632890; l=9298;
 i=yuanfang.zhang@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=0zJwLJ/CbFy+0o+vHzhKVbidP9iIvwNMjcD10+y0AC0=;
 b=MKYeSZfllSCAj//ygPXLgxpCdpi1CxWUmnZ5rZenRMYxbbKXHdYy2Pm2qzgHEvBd4YeaO4lre
 AT5ZZPRozVGCbZfkKhuPkacdE22frWOA+U+QXk8mMa7fpA8SlfitfSt
X-Developer-Key: i=yuanfang.zhang@oss.qualcomm.com; a=ed25519;
 pk=9oS/FoPW5k0CsqSDDrPlnV+kVIOUaAe0O5pr4M1wHgY=
X-Authority-Analysis: v=2.4 cv=XIY9iAhE c=1 sm=1 tr=0 ts=69006280 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=mZjCGalVderqEPr0BrkA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: NfeEUHFMoGNpLvl9xVdWEnXD9guhtdxu
X-Proofpoint-ORIG-GUID: NfeEUHFMoGNpLvl9xVdWEnXD9guhtdxu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA1NCBTYWx0ZWRfX6XfI/lK/+/2R
 xrkeXqEg21ZVSviPkklBeanZNoZpPliBoRm1ZrFm0X8PQrLDN9avrAWVqcrt06HyN1cMMeGDFvn
 PdkX/v/8+kWUEBCQFKy1+XCcsUD9CTe8siLMcex6FRNPeRbqfGr5+8zaEou8tcXoyE3xFTjnM9p
 hapzqBg8uoT4anMWYlNfehIqbgg20ySwh70qqkHwIrixuBSYDUTSyFq/h7ZCbvq5NTvBauhvbRS
 5FjyCTEoPyZuKynwwj1GF15lpTESFy3NV6qMDdmeEG/gDXJsuJVaEusQBay+qJ7OfosrHTTF1H8
 R+dFfDyWErGM91k4yHsGmXaNPDXCluZE7Gg91Qc3HhDdHUkY+44wDEDVS8WlzahrfkNTGNUXvWA
 Z7SIOyW2hXolAweKglxeTuNpkPBRtw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510280054

The CPU cluster funnel is a type of CoreSight funnel that resides inside
the CPU cluster's power domain. Unlike dynamic funnels, CPU funnels are
coupled with CPU clusters and share their power management characteristics.
When the CPU cluster enters low-power mode (LPM), the funnel's registers
become inaccessible. Moreover, runtime PM operations alone cannot bring
the CPU cluster out of LPM, making standard register access unreliable.

This patch enhances the existing CoreSight funnel platform driver to
support CPU cluster funnels by:
- Add cpumask to funnel_drvdata to store CPU cluster's mask for CPU
  cluster funnel.
- Retrieving the associated CPU cluster's cpumask from the power domain.
- Using smp_call_function_single() to do clear self claim tag operation.
- Refactoring funnel_enable function. For cluster funnels, use
  smp_call_function_single() to ensure register visibility.
- Encapsulating coresight registration in funnel_add_coresight_dev().
- Reusing the existing platform driver infrastructure to minimize
  duplication and maintain compatibility with static funnel devices.

This ensures funnel operations are safe and functional even when the CPU
cluster is in low-power mode.

Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-funnel.c | 185 ++++++++++++++++++++-----
 1 file changed, 154 insertions(+), 31 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 3b248e54471a38f501777fe162fea850d1c851b3..12c29eb98b2122a3ade4cbed9a0d91c67ec777ed 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/coresight.h>
 #include <linux/amba/bus.h>
@@ -40,6 +41,7 @@ DEFINE_CORESIGHT_DEVLIST(funnel_devs, "funnel");
  * @csdev:	component vitals needed by the framework.
  * @priority:	port selection order.
  * @spinlock:	serialize enable/disable operations.
+ * @cpumask:	CPU mask representing the CPUs related to this funnel.
  */
 struct funnel_drvdata {
 	void __iomem		*base;
@@ -48,6 +50,13 @@ struct funnel_drvdata {
 	struct coresight_device	*csdev;
 	unsigned long		priority;
 	raw_spinlock_t		spinlock;
+	struct cpumask		*cpumask;
+};
+
+struct funnel_smp_arg {
+	struct funnel_drvdata *drvdata;
+	int port;
+	int rc;
 };
 
 static int dynamic_funnel_enable_hw(struct funnel_drvdata *drvdata, int port)
@@ -76,6 +85,33 @@ static int dynamic_funnel_enable_hw(struct funnel_drvdata *drvdata, int port)
 	return rc;
 }
 
+static void funnel_enable_hw_smp_call(void *info)
+{
+	struct funnel_smp_arg *arg = info;
+
+	arg->rc = dynamic_funnel_enable_hw(arg->drvdata, arg->port);
+}
+
+static int funnel_enable_hw(struct funnel_drvdata *drvdata, int port)
+{
+	int cpu, ret;
+	struct funnel_smp_arg arg = { 0 };
+
+	if (!drvdata->cpumask)
+		return dynamic_funnel_enable_hw(drvdata, port);
+
+	arg.drvdata = drvdata;
+	arg.port = port;
+
+	for_each_cpu(cpu, drvdata->cpumask) {
+		ret = smp_call_function_single(cpu,
+					       funnel_enable_hw_smp_call, &arg, 1);
+		if (!ret)
+			return arg.rc;
+	}
+	return ret;
+}
+
 static int funnel_enable(struct coresight_device *csdev,
 			 struct coresight_connection *in,
 			 struct coresight_connection *out)
@@ -86,19 +122,24 @@ static int funnel_enable(struct coresight_device *csdev,
 	bool first_enable = false;
 
 	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
-	if (in->dest_refcnt == 0) {
-		if (drvdata->base)
-			rc = dynamic_funnel_enable_hw(drvdata, in->dest_port);
-		if (!rc)
-			first_enable = true;
-	}
-	if (!rc)
+
+	if (in->dest_refcnt == 0)
+		first_enable = true;
+	else
 		in->dest_refcnt++;
+
 	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	if (first_enable)
-		dev_dbg(&csdev->dev, "FUNNEL inport %d enabled\n",
-			in->dest_port);
+	if (first_enable) {
+		if (drvdata->base)
+			rc = funnel_enable_hw(drvdata, in->dest_port);
+		if (!rc) {
+			in->dest_refcnt++;
+			dev_dbg(&csdev->dev, "FUNNEL inport %d enabled\n",
+				in->dest_port);
+		}
+	}
+
 	return rc;
 }
 
@@ -188,15 +229,39 @@ static u32 get_funnel_ctrl_hw(struct funnel_drvdata *drvdata)
 	return functl;
 }
 
+static void get_funnel_ctrl_smp_call(void *info)
+{
+	struct funnel_smp_arg *arg = info;
+
+	arg->rc = get_funnel_ctrl_hw(arg->drvdata);
+}
+
 static ssize_t funnel_ctrl_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
 	u32 val;
+	int cpu, ret;
 	struct funnel_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct funnel_smp_arg arg = { 0 };
 
 	pm_runtime_get_sync(dev->parent);
-
-	val = get_funnel_ctrl_hw(drvdata);
+	if (!drvdata->cpumask) {
+		val = get_funnel_ctrl_hw(drvdata);
+	} else {
+		arg.drvdata = drvdata;
+		for_each_cpu(cpu, drvdata->cpumask) {
+			ret = smp_call_function_single(cpu,
+						       get_funnel_ctrl_smp_call, &arg, 1);
+			if (!ret)
+				break;
+		}
+		if (!ret) {
+			val =  arg.rc;
+		} else {
+			pm_runtime_put(dev->parent);
+			return ret;
+		}
+	}
 
 	pm_runtime_put(dev->parent);
 
@@ -211,22 +276,68 @@ static struct attribute *coresight_funnel_attrs[] = {
 };
 ATTRIBUTE_GROUPS(coresight_funnel);
 
+static void funnel_clear_self_claim_tag(struct funnel_drvdata *drvdata)
+{
+	struct csdev_access access = CSDEV_ACCESS_IOMEM(drvdata->base);
+
+	coresight_clear_self_claim_tag(&access);
+}
+
+static void funnel_init_on_cpu(void *info)
+{
+	struct funnel_drvdata *drvdata = info;
+
+	funnel_clear_self_claim_tag(drvdata);
+}
+
+static int funnel_add_coresight_dev(struct device *dev)
+{
+	struct coresight_desc desc = { 0 };
+	struct funnel_drvdata *drvdata = dev_get_drvdata(dev);
+
+	if (drvdata->base) {
+		desc.groups = coresight_funnel_groups;
+		desc.access = CSDEV_ACCESS_IOMEM(drvdata->base);
+	}
+
+	desc.name = coresight_alloc_device_name(&funnel_devs, dev);
+	if (!desc.name)
+		return -ENOMEM;
+
+	desc.type = CORESIGHT_DEV_TYPE_LINK;
+	desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_MERG;
+	desc.ops = &funnel_cs_ops;
+	desc.pdata = dev->platform_data;
+	desc.dev = dev;
+
+	drvdata->csdev = coresight_register(&desc);
+	if (IS_ERR(drvdata->csdev))
+		return PTR_ERR(drvdata->csdev);
+	return 0;
+}
+
+static struct cpumask *funnel_get_cpumask(struct device *dev)
+{
+	struct generic_pm_domain *pd;
+
+	pd = pd_to_genpd(dev->pm_domain);
+	if (pd)
+		return pd->cpus;
+
+	return NULL;
+}
+
 static int funnel_probe(struct device *dev, struct resource *res)
 {
 	void __iomem *base;
 	struct coresight_platform_data *pdata = NULL;
 	struct funnel_drvdata *drvdata;
-	struct coresight_desc desc = { 0 };
-	int ret;
+	int cpu, ret;
 
 	if (is_of_node(dev_fwnode(dev)) &&
 	    of_device_is_compatible(dev->of_node, "arm,coresight-funnel"))
 		dev_warn_once(dev, "Uses OBSOLETE CoreSight funnel binding\n");
 
-	desc.name = coresight_alloc_device_name(&funnel_devs, dev);
-	if (!desc.name)
-		return -ENOMEM;
-
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
 		return -ENOMEM;
@@ -244,9 +355,6 @@ static int funnel_probe(struct device *dev, struct resource *res)
 		if (IS_ERR(base))
 			return PTR_ERR(base);
 		drvdata->base = base;
-		desc.groups = coresight_funnel_groups;
-		desc.access = CSDEV_ACCESS_IOMEM(base);
-		coresight_clear_self_claim_tag(&desc.access);
 	}
 
 	dev_set_drvdata(dev, drvdata);
@@ -258,23 +366,37 @@ static int funnel_probe(struct device *dev, struct resource *res)
 	dev->platform_data = pdata;
 
 	raw_spin_lock_init(&drvdata->spinlock);
-	desc.type = CORESIGHT_DEV_TYPE_LINK;
-	desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_MERG;
-	desc.ops = &funnel_cs_ops;
-	desc.pdata = pdata;
-	desc.dev = dev;
-	drvdata->csdev = coresight_register(&desc);
-	if (IS_ERR(drvdata->csdev))
-		return PTR_ERR(drvdata->csdev);
 
-	return 0;
+	if (is_of_node(dev_fwnode(dev)) &&
+	    of_device_is_compatible(dev->of_node, "arm,coresight-cpu-funnel")) {
+		drvdata->cpumask = funnel_get_cpumask(dev);
+		if (!drvdata->cpumask)
+			return -EINVAL;
+
+		cpus_read_lock();
+		for_each_cpu(cpu, drvdata->cpumask) {
+			ret = smp_call_function_single(cpu,
+						       funnel_init_on_cpu, drvdata, 1);
+			if (!ret)
+				break;
+		}
+		cpus_read_unlock();
+
+		if (ret)
+			return 0;
+	} else if (res) {
+		funnel_clear_self_claim_tag(drvdata);
+	}
+
+	return funnel_add_coresight_dev(dev);
 }
 
 static int funnel_remove(struct device *dev)
 {
 	struct funnel_drvdata *drvdata = dev_get_drvdata(dev);
 
-	coresight_unregister(drvdata->csdev);
+	if (drvdata->csdev)
+		coresight_unregister(drvdata->csdev);
 
 	return 0;
 }
@@ -341,6 +463,7 @@ static void funnel_platform_remove(struct platform_device *pdev)
 
 static const struct of_device_id funnel_match[] = {
 	{.compatible = "arm,coresight-static-funnel"},
+	{.compatible = "arm,coresight-cpu-funnel"},
 	{}
 };
 

-- 
2.34.1


