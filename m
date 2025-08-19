Return-Path: <linux-kernel+bounces-775417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D16CB2BEE8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1CB31B6393B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4A3322A03;
	Tue, 19 Aug 2025 10:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CgRXPRg6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6929B322549
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755599279; cv=none; b=k698Q4aoLEjoNqxx9XVee7knvNMBqjhR5fOAsLyqGFd3XjINT7K4GSwipjCGEPOaErUPF7AxexIqi+ifoBSPbkWJlCHE/VFvfftvlnIU50c5534CJy1uMTW9LcH0jli4e7fN0G2+zBpH4cHHnWZ9loAnMVOMseU9U1WiR38DVHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755599279; c=relaxed/simple;
	bh=aeb1HeIqyluMB5Tc3xSFFSxmbMvpqRevsC6opdMzqIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iSWohj+5T7oDORAEHOXvDD9lNl+fxbfKu8Crfcqrry3ASUByMR9oacaMrwfRwx+xWDXqrHRQgpgr2ImexL39RnqdkTlF8qr5f18X4E0jrqGKn3ftbooAZwgd1nxs1W6+g8RV4Q9KSYPAcucyPMiwaYGa1sU3XRxGDZ502hlifqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CgRXPRg6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90YsD023038
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p+qsoxEYY18mT+CkjNKfZowUvZ+FdImgNxba8OIq4rg=; b=CgRXPRg6ua8etHru
	KaOK84emkqdNBHG72yoi+fz74E2bkKu36T3AQY5W1RxGrW1FT/VtHUxpDgnydBoE
	DSerWDaTUCjvfAgdGONcCXKcXnfq5JbhYlQFXF5v7oTfsziXGlpwR3NVo3iR1sqB
	9UvCI3MFBJQ4eGW8mmoZLnLRJDn5CclMEyds+Xf7wR1/Xj/2/SrOkTE1aDeq03Tv
	Z0STm9KdzXHUyJKQmbdZBSysf4VSd9vYwPv/uJyH8AY2/aYqsRW8YDxCj09fDOs9
	Hupwea6omyOfG0AlpVjZmp7yeZhSfsV5kOLT9zeYDTcDT2b3RkbRMkfWj2Hs50/P
	Chvmzw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48mca5huve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:27:57 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32326e46a20so9824017a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755599277; x=1756204077;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+qsoxEYY18mT+CkjNKfZowUvZ+FdImgNxba8OIq4rg=;
        b=YXLrxwj00R+c0EPsrEWw/O46Ar44pQ+QiVpaWkATcqeXo3jVy/OVxySOOysh6Vb/nx
         u8gIZTriZ3CwfOzlgXYNApFl4j/ozKk3yqd0RaTe93FBSyqOiWUvSeiBMCHeDF2dxupY
         gz7M3SAc2B4J0gaheeKmLb4RZrKjS6CatEb+oYs6rwywPPpY2IVi7sQVv0ZtB/wuoNRM
         XWFE+ykrlSZkyywZi6TWzIW4efO97MDF/R+gECwuzQm/93xw8JpAS0wDnKQjP7/vnLRS
         58/MCXzkLrCKzi0KrWa0JT7rV3HsMz2ZTqfSgnTs3iV+zXv0tSDT0NAls2tdlhxQqZMy
         hL2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhnL8WisyyxyCYaLxSLs34+znKrnAr4Gx2bwsMwvNE/iiq6fB0h5UicKlDB7QOx4AiwRwkCwpEMrX466g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqQ6oldZpEbfZWarxIwZs/1lQAJPRMjmPv1EEgNgs/opi60CDv
	mRW4jkw+BqP3rFFyGS6+Z7I+odYh53vfJQnvPxljf4YZh90u7ggUQ1PrLtAaBzY0NqvZZTsaddI
	dayFABczRgX7iv48dhwWh9fx8hKvJD0HlwdHHioof5QlfHKN+GKLeO6UMlP8LYShWiWg=
X-Gm-Gg: ASbGncvbfw7g6KNY1L0DjfT8e1Dbi51MteRJkI0DmXNzoIDmfkRMxw8Q3wks+I1uGwc
	2oTQ9pLcBfVa9Q/RsbaTrAY9IKOMtBtLMpCN3oerJd5Xj5MDOwScpJeh1j7vjmJShhzwRie59gD
	n6QlhM2BmLZkXKmhLA/LCZ/b5/DmbhUZ+Vrdfr75wVCjLZTw1us6odIDDDEWuYak1/WUqEnIeht
	uQzpX4zG7oM4veGSmzmzH3WKyCMS+6uqs6p7l/Gi+PrXXqMnxKa31ZZnEVT+nSa1sK+EfFqKq2z
	lJMcq67HRSUi5rOeQTwhkB66O2bY49qwFdjD0vExr0uyfqkJKPyqG/DMuoCLfUFNr5w5j8Qw+/8
	7L9BOIzjagjF8uxneYHAK1A==
X-Received: by 2002:a17:90b:224d:b0:323:7e80:23e3 with SMTP id 98e67ed59e1d1-32476ab8382mr2941626a91.36.1755599276628;
        Tue, 19 Aug 2025 03:27:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXJDwBsD8GSfAUtZj4btl83QcxNgu3y5FrH+g2NMjl/MsNUZaffIO4c6+IrNg1Dkk3M4rs9w==
X-Received: by 2002:a17:90b:224d:b0:323:7e80:23e3 with SMTP id 98e67ed59e1d1-32476ab8382mr2941594a91.36.1755599276086;
        Tue, 19 Aug 2025 03:27:56 -0700 (PDT)
Received: from hu-yuanfang-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3237e3eef8fsm2499643a91.18.2025.08.19.03.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:27:55 -0700 (PDT)
From: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 03:27:45 -0700
Subject: [PATCH v2 3/3] coresight-tnoc: Add runtime PM support for
 Interconnect TNOC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-itnoc-v2-3-2d0e6be44e2f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755599271; l=1698;
 i=yuanfang.zhang@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=aeb1HeIqyluMB5Tc3xSFFSxmbMvpqRevsC6opdMzqIE=;
 b=7Xr7Ler6KXi3Pi0R7YwkGnLWV3b2IUBIUyPeg9SgySlabcH0jxo4isQ1KyhuLimOBIhhRYOFf
 DFE+AHOldXoAV6KvsAzhjEoB2OXbdZ80vGWw7qdS4ZLpis0fHUGAfTQ
X-Developer-Key: i=yuanfang.zhang@oss.qualcomm.com; a=ed25519;
 pk=9oS/FoPW5k0CsqSDDrPlnV+kVIOUaAe0O5pr4M1wHgY=
X-Authority-Analysis: v=2.4 cv=FdU3xI+6 c=1 sm=1 tr=0 ts=68a451ad cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=qearADheJa7ujHrKWl4A:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: PlluLWO15GTSq2Svkax6Ryk7VXYPeEhA
X-Proofpoint-GUID: PlluLWO15GTSq2Svkax6Ryk7VXYPeEhA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDIwMiBTYWx0ZWRfX9S5WW+fbu/aq
 JNIseM3y5dWmV10Z/XGnUqKCl6GeFqlEuvMBFy9qEdIa1oSUgg+Y6fMZJDCyPHhh2v48qWrJrM5
 cCcopCQEjX4Fm5YNjwd/xNmjE46P5Ve+tKVIxLRJaBttyEZUiBwc8B8i/nwl4vcoHCAJ/HJzqCI
 KQZRMYZsGvGbiqEh5zjAUEMY/sdXvRiK2QZOssKqCpo6ZeVpwo8ctrjbGpT/f9TH6J6gPwj/pma
 64cYD3Udx4x4CSkixcr5mylOAgwJvZOR4VAp6/hV9iC9PV+4HVMzWTgfQ4vOBNAZdbQGO/FW7R2
 lZ0PuTfc6Txu1Sy04NySXeMZp8aKW5cxiva6kNLKhzlxDzWQyfaNcbUxbdGBgYZBiXfvPdP/egO
 lsOz6M4e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508180202

This patch adds runtime power management support for platform-based
CoreSight Interconnect TNOC (ITNOC) devices. It introduces suspend and
resume callbacks to manage the APB clock (`pclk`) during device runtime
transitions.

Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-tnoc.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tnoc.c b/drivers/hwtracing/coresight/coresight-tnoc.c
index 407595e893096d8011dfcefd74cca742d9b96695..d57de1ee8b1e378c76cd90faae2c45fcf4069741 100644
--- a/drivers/hwtracing/coresight/coresight-tnoc.c
+++ b/drivers/hwtracing/coresight/coresight-tnoc.c
@@ -300,6 +300,28 @@ static void itnoc_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
 
+#ifdef CONFIG_PM
+static int itnoc_runtime_suspend(struct device *dev)
+{
+	struct trace_noc_drvdata *drvdata = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(drvdata->pclk);
+
+	return 0;
+}
+
+static int itnoc_runtime_resume(struct device *dev)
+{
+	struct trace_noc_drvdata *drvdata = dev_get_drvdata(dev);
+
+	return clk_prepare_enable(drvdata->pclk);
+}
+#endif
+
+static const struct dev_pm_ops itnoc_dev_pm_ops = {
+	SET_RUNTIME_PM_OPS(itnoc_runtime_suspend, itnoc_runtime_resume, NULL)
+};
+
 static const struct of_device_id itnoc_of_match[] = {
 	{ .compatible = "qcom,coresight-itnoc" },
 	{}
@@ -313,6 +335,7 @@ static struct platform_driver itnoc_driver = {
 		.name = "coresight-itnoc",
 		.of_match_table = itnoc_of_match,
 		.suppress_bind_attrs = true,
+		.pm = &itnoc_dev_pm_ops,
 	},
 };
 

-- 
2.34.1


