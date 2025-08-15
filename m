Return-Path: <linux-kernel+bounces-770926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A90B28086
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2BD75C84C2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A237A304961;
	Fri, 15 Aug 2025 13:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B1ksNejU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF2A302767
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755263914; cv=none; b=MYdjY1dNt+caJnaNGqhT217d2p5NkAoUixul7Kge9tJ5aWKSvCLLZxMuIGmEFSHwUd2N9OdrpNyopkmzJa+nVNGsk/pKKN8gzokGfRNz67HZijo6QDlChxOX73UiXBYjP7DprMOxh7m3vkh7J7NFGKb+Z87Di4NQugkAr0tu40Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755263914; c=relaxed/simple;
	bh=VoTULuM+qkKhtoH0VvVKv4xTl4Eg+ARh+llu8sbZdVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hb9v6Kd0YX7Trid4QY0KtzfLsWd/PYqZaQpVkKrc5YyD2nQevD1Q710pJDSf78vkmTiuCYQW0vY8vt89HjfUigYkXcJigMYjLbQpnHGxtJJG5iS1FqijSXcb+mz5A2bwVT+mNIbsvNdq5U319FjuyzdbV09eOdaLC2YKAK9C32Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B1ksNejU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57F9m3Kl026763
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 13:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vQ39sVnBu3AnUGDBD9Y+etDVOR4WonIweoaJdoEd/3o=; b=B1ksNejU1/oTR2bI
	IyTfE8LLxAO8brGS6HftzkFm+AcA6HK1lhqW2ds10RpuyV5kyJSYtPM6KTSVRAMn
	fqaWW83itbGukW7+hPxAzSjr5sFt1lS9vkMd3w6I3wfjs6BfI9lMDBbAmOq3MQrc
	LWjH9biFw5rNdx2uH4GyUKuGjvc7yCHyLz3Oq8BH8ajwBpj+izI4XL1rKPiXlZ11
	XxbjWQCRNQ2/AbFzpA2Q0tFa+I4PjbNyKCsyHBLRtwKYnzvGoiic7uAL9MYyXbvC
	R/PWYNv+LazIN/xNFn1bHrKKRvo7ovA+JvpZ6TUUtfkY8V0je3GZ7yJM3RJ+jO3X
	IpuOMw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffq6y114-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 13:18:32 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e2eac9faaso1664261b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 06:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755263912; x=1755868712;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQ39sVnBu3AnUGDBD9Y+etDVOR4WonIweoaJdoEd/3o=;
        b=gW40YB9StfHKM6+2EnYX9wc0ruLZjDR2uje5NlpuOLhGs0Y2b8YbGv2nBUwLPATb3h
         cJ2wmBsthNT7xxGk9YGkLW/UUPyHpfEhNwDn7Vk40dqLt1uGeSwx06jY6BtHDufQK2K3
         JjIx8eQazMbo22FrHWg3pC1z8Fg+IsR4sgznXirtxGX0UXuGmn2E+fPqOylN9LdDyyJn
         jR6j9zPxEwaODz8byAD+54cO3pUOj2TY1fBONzjURK7xTHs8wPoBkK4S5VVft8Yuy/7n
         QW2mWZQTELmlmJa7iNZFFt/Tpom9W77OGH9m7S7WlKzTahbUO34b180H7Nykci7KgBam
         Rl/Q==
X-Forwarded-Encrypted: i=1; AJvYcCULNctOTy2hkux9+by4hKa57z27LSQ6rPXsD7nGhHr5nZp6VqAzL326nFuFbb10PbyRgkf+It70LJZcZyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWRU9VkeXNsB1heKimBZvFb9yC3ydsrx5IswGJDqJbQA7VlUCO
	6Mahv+ctvZi5IHHwM3bzi/5+0/MhnaIyKpOWjmZGGIj+pCzX60qdC5pbhGmgDqEddcT9Cn7NT6f
	u1jN8TlHEgkDKVfB18h6VXJTY11It4/MpgB2uTTMHEbyHBRafYTDE2BQZYHsz+2Cod+g=
X-Gm-Gg: ASbGncvWF4RGtNmxXGIxMjU2s3J9MqYOYBD5WZ2WTyMf/KRWCwbf7JPzMV3J+Fk0Y2w
	d+5KCNeREzUDHioF+/pgDFDbvZY2iTv/ExjmW8W1QSShJ7RXQS/PauM4+f5J0n3Kufk70Aj//h1
	o0o1uHmZ/wVcIeE78EyR/hrVZ3qadBbTAcUaL80wbkGm9g9A6R4KkaFdof9PNT3IasX18YZh+H0
	NSm1Xpwg+fpwIucxwmQA8CR+XOfyjvWmH3p31pTWkub2Uzb23NHOtQiaCy6B6l8ulM6hGMpmjHK
	ZIfuNh96XPRFMY40TD+Eyur7qTusgzC4L4JL0PwbsrYTqegjv79iMqQ+JhEdU2hrBWgcDNuyzKf
	ZfX9xI9tlJ8cdwx3fKMhbpA==
X-Received: by 2002:a05:6a20:72a3:b0:240:1dc:490d with SMTP id adf61e73a8af0-240d2ff81cbmr2983362637.33.1755263911790;
        Fri, 15 Aug 2025 06:18:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwO4qMRcWknkv/xc7pVetHC86gYOaCiXH6wSiHoLp7Gi12ttJB5qBzekm/5OTOZq+axFjvmA==
X-Received: by 2002:a05:6a20:72a3:b0:240:1dc:490d with SMTP id adf61e73a8af0-240d2ff81cbmr2983316637.33.1755263911339;
        Fri, 15 Aug 2025 06:18:31 -0700 (PDT)
Received: from hu-yuanfang-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d7944e6sm1256386a12.54.2025.08.15.06.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 06:18:31 -0700 (PDT)
From: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Date: Fri, 15 Aug 2025 06:18:14 -0700
Subject: [PATCH 3/3] coresight-tnoc: Add runtime PM support for
 Interconnect TNOC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-itnoc-v1-3-62c8e4f7ad32@oss.qualcomm.com>
References: <20250815-itnoc-v1-0-62c8e4f7ad32@oss.qualcomm.com>
In-Reply-To: <20250815-itnoc-v1-0-62c8e4f7ad32@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755263906; l=1712;
 i=yuanfang.zhang@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=VoTULuM+qkKhtoH0VvVKv4xTl4Eg+ARh+llu8sbZdVU=;
 b=MHmjSyMQH6lM1Al6lYIb9qEiX3Qzsc1kPylcTrr93fPHLt1T9KqS817xd/cNgObqMEKfE9h8q
 xkchO8pLcdeCb6jAMpw0wM3goJapo5eM5bZbfxP4fvBMDdKDJIcLZvH
X-Developer-Key: i=yuanfang.zhang@oss.qualcomm.com; a=ed25519;
 pk=9oS/FoPW5k0CsqSDDrPlnV+kVIOUaAe0O5pr4M1wHgY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NSBTYWx0ZWRfX8rwuvXKN4Vpc
 NkzgukGwYxmKCZM1VkMAQYnicVuBJnxrxuRn6Asmr3LlOm++AGkWIeExLGzscOBwqP8eyMAlkcf
 NLRkloUI03Id4Af2kLZCxA0cQOUtWb9GblDhzgrrwYDgXMpWvS0MfQJkDPf4bayW5vu3XiprYiS
 33uYkrqxfPZvtNsE0Z9egW8GbCP4iCf1jyzmDSoLkOWP7jVoCA8jBDzBQ2uZGUplZegS93/SUCU
 bk1xOsZpYKjs//z4kV7Pj9vDoK6IcVcVca1OumFRnQeYyKZIG5wQ0W30bsGOcT2paeNKoW23tca
 KVeHnly/bb6pEVNhpf5aa8dLM/0bCxiRHR1G6CXkOfuX4qJ5cqZeRAr0WuUgZLWWRsjg0G062qR
 Wimm6hXI
X-Authority-Analysis: v=2.4 cv=TLZFS0la c=1 sm=1 tr=0 ts=689f33a8 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=txXwn6EqYov8MDno8JkA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: cegZVOT0Yxgd43Xt7jVpc65lTysoz1eJ
X-Proofpoint-ORIG-GUID: cegZVOT0Yxgd43Xt7jVpc65lTysoz1eJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110075

This patch adds runtime power management support for platform-based
CoreSight Interconnect TNOC (ITNOC) devices. It introduces suspend and
resume callbacks to manage the APB clock (`pclk`) during device runtime
transitions.

Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-tnoc.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tnoc.c b/drivers/hwtracing/coresight/coresight-tnoc.c
index aa6f48d838c00d71eff22c18e34e00b93755fd82..f12a1698824bc678545319a3f482fd27e67a7352 100644
--- a/drivers/hwtracing/coresight/coresight-tnoc.c
+++ b/drivers/hwtracing/coresight/coresight-tnoc.c
@@ -270,6 +270,31 @@ static void itnoc_remove(struct platform_device *pdev)
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
+	int ret;
+
+	ret = clk_prepare_enable(drvdata->pclk);
+
+	return ret;
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
@@ -282,6 +307,7 @@ static struct platform_driver itnoc_driver = {
 	.driver = {
 		.name = "coresight-itnoc",
 		.of_match_table = itnoc_of_match,
+		.pm = &itnoc_dev_pm_ops,
 	},
 };
 

-- 
2.34.1


