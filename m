Return-Path: <linux-kernel+bounces-615275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1ACA97B0A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 01:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 305E93BBEA1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 23:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EF921505C;
	Tue, 22 Apr 2025 23:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d948haJQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F9B2144B6
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 23:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745364826; cv=none; b=csiC7Wx9UW22sIFVI5+mDY96DsQAF08IZpu3ntbi5w2PrYFu0tLJ46SbfQ/KjQIzv0R//coP//rot03dPwlohIYkAmO1JfaVJwUnrTpGt5yiXC3bCt7oS7mfv3wBnwmZJ2WIqcu4c5A1+qNcp0hiZkgxb71P1B1dH8I9ih0gtcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745364826; c=relaxed/simple;
	bh=Zm+0Vnd04bLna0H1tU+JPRUhjZEpd+vXGIhlF4JkvBM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZHw0GvmZ02maiC1aBtgQDwpF/06fUO+Fl1nnHKoDklt7sYzeCxJazo4A3T1DJ2sPk5LgJT4gXD9rEQ1+lBt8BP8ZKpVAKxEsO1HVgH/sRLzCE1tJ5YhuzA8GxzyIA22Ovg2HKH6g8nc1s3BQtaTHD3WAayns1fQ6oRBUdtwZEeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d948haJQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MKpuD2000896
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 23:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LbEEYSNZmbsDZ9eY95aJ2Y
	EJLr23jK+dOe3rnqzLKQY=; b=d948haJQ7yEQwbLXrdRPF4bymMnHcUv76kwe0g
	cGt9Uv7lIi/U4ED4A1PYv6qUMDAicVjSexJIyKjV3McTqeiH30tciF34f9Pmy9qE
	AwpMGmXNixLYJPqaHrPA8H5F+S0r66SRHMl+EnBAY463R57OZFHOxua3Rms5OQD2
	Gjp59jGpoaH8eRLMUJdux6oxaw1IoH/Mji38fDB6ZiBtsWwMo24w0p48LW5SPWhA
	qKihHzahJJTfH7EQONjSCEvyExefWH3dOqjMS9OgHU+0Pg5eEg9n3SccSPXgBxc5
	snpF65EMHHf9PhXQWxbXsVYT4zRQPGTV102nwXe7m7t6xJxw==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh2898s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 23:33:43 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-72ab21098efso267567a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 16:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745364822; x=1745969622;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LbEEYSNZmbsDZ9eY95aJ2YEJLr23jK+dOe3rnqzLKQY=;
        b=C1poQWyqH9JCPgBGX4ER2Kkg3AUHcwv95A6Nc4JfbLgeCFIC118SjMEdledgAcs00L
         PJgPU6yrAM5s0kCiRzKEVj3EFAMBqZu0/fW3SjGM4Hr6Kdk67yPSWkI3MO7CjcX4WNK+
         860vla6kQ+we9Le3xHVUizL2NIKLIglVq7Tc+9heaMWi9nOi6V72saQtsNf4urESXNVb
         Xn5XSOiYJYW0RSM85A2MC4zp4PTFtNRiNN8LonYPmNJgsuJLXcowQipz4do9Svh4Igpo
         koZZMFYR/v+IEk00+EzPWjOuK+ywV3/WZfTmBQ//CWD3Kdi+lSdDZadkemggmOHwGwvO
         6Fxg==
X-Forwarded-Encrypted: i=1; AJvYcCUD2xQOEC7teWmi6kLdbSJoYDXervPmB7gxR9xbdThYeN8oPtKgVAoW2ktICzOaWMWCzI8vy6dM5xoLKJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1hcvr7BY5BXIvd3sYQBbAFNasPf0gmkqTLehgV97hG3kKcYQ5
	qOd9eVu8zc9U8T7NMUlV8SC/2QzziqQJFq2L4W8NHDieaF5PkY1FGzt21baH5YSF5BPdS8w09X8
	IdMSVPY+Cz3uJoDNwK1X+GHBFznn/1nrzWFtpTWccG9WY0uB6p67AcIQ5vdkFQS53ZKsSb2A=
X-Gm-Gg: ASbGncvh1SCQEVZG/LvAd2UwjlNmpKoxvV77FXGZHksAcRWoE/K9MXeftQnWHP9OKDs
	TpKo926LsDQYkqVnZfcm30sMJBHP1IY1HVRt7aHUf7tPxzNAip0N5o9BJ4tjf3Q3PpI655o2YyB
	CDIlwluaJlVL+GD0AKueipeLCujB21a/8JVIEygYVFbX30jr/IAefdT0KQYawijxTcT/eyKH4fJ
	++nA3rv6iXKG0a+7UKqJ7UtijB+nPU6FjrtKQQW2BDSlZjcAWQYq8NJtikEvgrzhwn2h0C50U6l
	W2khBUitVklhCL9VXY2bpbfGXlZuKspesR6m0NHi5ApvV38v5gDr4+hOGfsuysWgjIzqLfe7v/E
	s8n0dpzNE7Q0=
X-Received: by 2002:a05:6830:12d2:b0:72b:8d2e:4825 with SMTP id 46e09a7af769-73041e9de56mr467630a34.11.1745364822403;
        Tue, 22 Apr 2025 16:33:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0t6cxJkJp59NTohJ5oLCCnmhskYwY9IBHFLPZrEh+ri7nRRRAj7gkP0LsYg//gp0mJqrbeg==
X-Received: by 2002:a05:6830:12d2:b0:72b:8d2e:4825 with SMTP id 46e09a7af769-73041e9de56mr467615a34.11.1745364822037;
        Tue, 22 Apr 2025 16:33:42 -0700 (PDT)
Received: from [192.168.86.65] (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-730047afc11sm2231478a34.25.2025.04.22.16.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 16:33:41 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Tue, 22 Apr 2025 18:33:31 -0500
Subject: [PATCH] usb: dwc3: qcom: Use bulk clock API and devres
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-dwc3-clk-bulk-v1-1-37c7c941330f@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAEonCGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDEyMj3ZTyZGPd5Jxs3aRSIGFpZpBoaZiaYpKYZKEE1FNQlJqWWQE2Lzq
 2thYAD+r1Xl8AAAA=
X-Change-ID: 20250422-dwc3-clk-bulk-960a91ed4ab8
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4868;
 i=bjorn.andersson@oss.qualcomm.com; h=from:subject:message-id;
 bh=Zm+0Vnd04bLna0H1tU+JPRUhjZEpd+vXGIhlF4JkvBM=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBoCCdVQtcnmQyH3hay44RXu8crJ1kkuop6qwCU/
 06dKNBFf0iJAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCaAgnVRUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcXyFQ//SZgCOv1ZJhibE8+OWqjEcDnZuaUCksK3oO1NdX0
 W9uy8oT7Xr+kfR2FLIvZ3aWQIIdZhUsCjDD+yASja4fZmfk9f0Egbj6ENzhJrMRFoEYiBaSseSJ
 N/ZkDrUCOHOLJiZXdlmzJeztbylNtSYxpe7e6BDRa57V/YDPytwOT5wQKwfQuzp3eEBFgFNgIz2
 qb9Ug7JLhmmHgBrrZleWGD1CLsnhLvqqf7B8Ht/mLH/g6qYawz0DE5pcs+yBeKlDNyYOSVW8dDR
 mLbi27iU6qLrmrlWYjXaQtb5P03YHC3orhNDKDEkxKh/shTncgD461cN8h7y5sWlH6h6BRJZ+cH
 u4MwZj6i8IZjSpM5nIXfAtUZQtC2dkrR1EeQss7fQnjeexeIxNnDyLAp3jWz8pjhuC5ID6kbWY4
 84gUy8KmekqeQrbuaxquX2nJ4Cy9i2EYdt43eU8yICxtzS0bGeuZ5lP4mcqjB3auU/yOaz9Oydv
 vlx4dcMVSYI2v3IrdN4X3KSto+HVJMv+j57HgfqT/F+qDZAilGD6wHh9sjP+qLZcis2elJmUxLj
 FX4XpNitCrdA1Lf3GmVTj2+nXgNNQlOqpe7nfGTCU7xFEVvmiHQEvB1kqqkQNuovi8uJMO3AAn/
 vIDy1GzxZtKbNh4jfsU+TLiFpxuNGD911FTtktyzarVA=
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Proofpoint-GUID: 9NYhFsX3krURMuRxmWxlkZr9clEz-GA0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIyMDE3NiBTYWx0ZWRfX/MiRVSwVdk1C z1oQWafp9FlaDx3Su/YYYjk3PTlNPxoNIFYQUmL1zhlVhq/vD4cWOBw/dfop9U9BhLGfWYlMZov KUznzmV+7cDlXPcP5Pt+cnBm2YpQDQTbuqED5kW7VGZ28RWrQa4fjAo1xsmu8PiopdWkpjkK5O0
 0Yv7qOGRS2/rDk/VRbd7jIFCLJSdR6Ke7yk9c727hfY2p7K3ESgb0ITlueYEFVIb36uuCk+Ygmn FOQBFEdMr0lq7FOmU/HtAwHyNMivRCJy4WQhQ4LItZYiiT6XTuqef3AQPc82UmoGYTtvAoXo+HU WUEg7U7gwXfe+IltADgYNTn64LGlkR6OD60l5BQ8D6cL4+IyESSR80Pc+pAPpYS7iebC3gjKuAH
 OpaHM0BrN0G6iLYPtoU2IfLhtB23VFV5odi6X92lvTxAXbpt0uBNJFgWNtSMUCzeb3OQH5nx
X-Authority-Analysis: v=2.4 cv=Tu/mhCXh c=1 sm=1 tr=0 ts=68082757 cx=c_pps a=z9lCQkyTxNhZyzAvolXo/A==:117 a=DaeiM5VmU20ml6RIjrOvYw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=gJd3tMjwVXm2S4jxaKMA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-ORIG-GUID: 9NYhFsX3krURMuRxmWxlkZr9clEz-GA0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_11,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504220176

The Qualcomm DWC3 glue driver duplicates the logic of the bulk clock
API to acquire, prepare, and unprepare the controller's clocks. It also
manages the life cycle of these handled explicitly.

Transition to the bulk clock API and manage the resources using devres,
to clean up the code.

Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 84 ++++++--------------------------------------
 1 file changed, 11 insertions(+), 73 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index d512002e1e88da9523ff82454e653bac55c1409d..ec6e197cfc32abf5ab8f9b23ba590bd1a126b500 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -73,7 +73,7 @@ struct dwc3_qcom {
 	struct device		*dev;
 	void __iomem		*qscratch_base;
 	struct dwc3		dwc;
-	struct clk		**clks;
+	struct clk_bulk_data	*clks;
 	int			num_clocks;
 	struct reset_control	*resets;
 	struct dwc3_qcom_port	ports[DWC3_QCOM_MAX_PORTS];
@@ -431,9 +431,7 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
 		if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
 			dev_err(qcom->dev, "port-%d HS-PHY not in L2\n", i + 1);
 	}
-
-	for (i = qcom->num_clocks - 1; i >= 0; i--)
-		clk_disable_unprepare(qcom->clks[i]);
+	clk_bulk_disable_unprepare(qcom->num_clocks, qcom->clks);
 
 	ret = dwc3_qcom_interconnect_disable(qcom);
 	if (ret)
@@ -465,14 +463,9 @@ static int dwc3_qcom_resume(struct dwc3_qcom *qcom, bool wakeup)
 	if (dwc3_qcom_is_host(qcom) && wakeup)
 		dwc3_qcom_disable_interrupts(qcom);
 
-	for (i = 0; i < qcom->num_clocks; i++) {
-		ret = clk_prepare_enable(qcom->clks[i]);
-		if (ret < 0) {
-			while (--i >= 0)
-				clk_disable_unprepare(qcom->clks[i]);
-			return ret;
-		}
-	}
+	ret = clk_bulk_prepare_enable(qcom->num_clocks, qcom->clks);
+	if (ret < 0)
+		return ret;
 
 	ret = dwc3_qcom_interconnect_enable(qcom);
 	if (ret)
@@ -648,62 +641,14 @@ static int dwc3_qcom_setup_irq(struct dwc3_qcom *qcom, struct platform_device *p
 	return 0;
 }
 
-static int dwc3_qcom_clk_init(struct dwc3_qcom *qcom, int count)
-{
-	struct device		*dev = qcom->dev;
-	struct device_node	*np = dev->of_node;
-	int			i;
-
-	if (!np || !count)
-		return 0;
-
-	if (count < 0)
-		return count;
-
-	qcom->num_clocks = count;
-
-	qcom->clks = devm_kcalloc(dev, qcom->num_clocks,
-				  sizeof(struct clk *), GFP_KERNEL);
-	if (!qcom->clks)
-		return -ENOMEM;
-
-	for (i = 0; i < qcom->num_clocks; i++) {
-		struct clk	*clk;
-		int		ret;
-
-		clk = of_clk_get(np, i);
-		if (IS_ERR(clk)) {
-			while (--i >= 0)
-				clk_put(qcom->clks[i]);
-			return PTR_ERR(clk);
-		}
-
-		ret = clk_prepare_enable(clk);
-		if (ret < 0) {
-			while (--i >= 0) {
-				clk_disable_unprepare(qcom->clks[i]);
-				clk_put(qcom->clks[i]);
-			}
-			clk_put(clk);
-
-			return ret;
-		}
-
-		qcom->clks[i] = clk;
-	}
-
-	return 0;
-}
-
 static int dwc3_qcom_probe(struct platform_device *pdev)
 {
 	struct dwc3_probe_data	probe_data = {};
-	struct device_node	*np = pdev->dev.of_node;
 	struct device		*dev = &pdev->dev;
 	struct dwc3_qcom	*qcom;
 	struct resource		res;
 	struct resource		*r;
-	int			ret, i;
+	int			ret;
 	bool			ignore_pipe_clk;
 	bool			wakeup_source;
 
@@ -733,11 +678,12 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 		goto reset_assert;
 	}
 
-	ret = dwc3_qcom_clk_init(qcom, of_clk_get_parent_count(np));
-	if (ret) {
+	ret = devm_clk_bulk_get_all(&pdev->dev, &qcom->clks);
+	if (ret < 0) {
 		dev_err_probe(dev, ret, "failed to get clocks\n");
 		goto reset_assert;
 	}
+	qcom->num_clocks = ret;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!r)
@@ -804,10 +750,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 remove_core:
 	dwc3_core_remove(&qcom->dwc);
 clk_disable:
-	for (i = qcom->num_clocks - 1; i >= 0; i--) {
-		clk_disable_unprepare(qcom->clks[i]);
-		clk_put(qcom->clks[i]);
-	}
+	clk_bulk_disable_unprepare(qcom->num_clocks, qcom->clks);
 reset_assert:
 	reset_control_assert(qcom->resets);
 
@@ -818,15 +761,10 @@ static void dwc3_qcom_remove(struct platform_device *pdev)
 {
 	struct dwc3 *dwc = platform_get_drvdata(pdev);
 	struct dwc3_qcom *qcom = to_dwc3_qcom(dwc);
-	int i;
 
 	dwc3_core_remove(&qcom->dwc);
 
-	for (i = qcom->num_clocks - 1; i >= 0; i--) {
-		clk_disable_unprepare(qcom->clks[i]);
-		clk_put(qcom->clks[i]);
-	}
-	qcom->num_clocks = 0;
+	clk_bulk_disable_unprepare(qcom->num_clocks, qcom->clks);
 
 	dwc3_qcom_interconnect_exit(qcom);
 	reset_control_assert(qcom->resets);

---
base-commit: 2c9c612abeb38aab0e87d48496de6fd6daafb00b
change-id: 20250422-dwc3-clk-bulk-960a91ed4ab8

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>


