Return-Path: <linux-kernel+bounces-873120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD634C1328E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFB731AA6EB7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498ED2D8798;
	Tue, 28 Oct 2025 06:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WQZeDMtM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9740C2D59F7
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761632909; cv=none; b=NUHTZ2wAU3OjcCU/axFNAwwMzRVkTDuWWAOyhgiBTUPt68qIzYAbse/KG33eZUNT5nHrur2YYJaKL2rFflNiamev4ES0J4nzy6+guffcLTH4DOuvabII383IvQYqAf1ReLuVVoiCOZznVhYW4DgOhGZnku4x1f9oyUqNxsmpSrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761632909; c=relaxed/simple;
	bh=bsUoTDGB8Bei1YOrLoXxgoY5Y6GaCFBJ2zNDknL+Cf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U45wJ/5/WyWWbuXs6wRksnlILGsDE4WhNbWPW938YrsQ4KGk4RUb+952b51d8QajiloMP0hWE0zXaNUPEVK3/IvJtL+5cQ/YtwbJDu61A0M6XuD3QubRQLYG3qb1nonEj7BaLUuKALxBHwDxufgz/Nl0BQMPlReWwJun0cWn65s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WQZeDMtM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59S32Gbc353842
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sKE09VxaVzUpPLetM83B2Xv7yChLQ7TS6ugh7H6buVQ=; b=WQZeDMtMbiGVxxY1
	/XzGpBISC+cWQt0mhnva6VFP/wyiTsh5Sqr6dFf3/GCZP8iAXYAArH69O3WEXXRe
	entSM9RVeKU3ojexm5Rwvsc3eg5iatb5dCYlDlDr5zSQbCmXVZQu7flGtBAeRjgw
	18hrly0WTXXJv5t7a80UhS8TUn29vIFjCEENp2zZXgpQXSUPKYO8nJppfdssTSpg
	RMKM8ufB8WGAfVUBPitICaYI96OkL/CunWcKkle4sXcTv8h63cMyNhvg/QqpwYCd
	/youMc/2m//s9m3Ii1k59OVkwi2Bt/2cjmTYoSoLnOta4apxOPTmv02qBHYIXKOe
	L56rew==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2njrrfvn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:28:26 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-290da17197eso90151015ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761632906; x=1762237706;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKE09VxaVzUpPLetM83B2Xv7yChLQ7TS6ugh7H6buVQ=;
        b=UJretUnMCj0UsZKpFS8kYmzwtOuyr4DGL1pjXwdC1oWbvlpCCyRgkaOwRg1dgQJbH7
         spUeC1zI+BOGChzS7jBfSnmRVzVsZZMCROTzx8qaMOCNsEXFlAxdZHUXYaPmfEVSusBc
         jhb/TLJGUfOl1G4J8u/pjHKLbP5gBh63OJvd9+aR0WYAH8ncHnnufNGLdvvMdRiZaQlE
         dLoubxipxRqgolwv9k3qsLgBSY6ol8hJ8kG5LucCalK7dpUBBUxYvmLpLuVGCFumqAH6
         +GbfOJFHbgqa4mOEu1WDLiTqq5EUJyhd5aspfqz6kz4jYbojV0DIMZwMEPG0ihM7x0Oh
         jfCg==
X-Forwarded-Encrypted: i=1; AJvYcCX8J70ydsRZOosGsg5J7QjcVwy8HpASvYMeRRfPMJhDnj5DFSY+VUGfd4pl6koi8gJ1ueoMQI4do3K1uAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyva6E//chxH3QlfVQEh3UivYt1Ia1tJhfGa6k/LZADlipcTVjF
	dIB+s7iWgPgeHU36oyiJzykYcxG0eKCdbLxuSqIGD9Fnjsr83/IE+zoTjIbF0hHPlsfS0hj/Q+r
	nJwdyUgjpUfKFy0naFl5ofOpDkRqUpnLXylkiPLoNlq2DeeCzQKBU3/PK0tbyFHXgYuA=
X-Gm-Gg: ASbGnctHQgvIWhKL8setqoGRiIn6wSospCZQEPdxz5SZtAeUAIS0y6ji6zraWBcY3D7
	heXCxaH+2QH1+NgC4sH7p/rpCNq8kY7BkoQM7uyYpsSfqX6IlnsHc/z+qSu77YemURV1naS2Pva
	6Rk814/gyUXQQAI0flqH1aqVzGPooXb2DOY/ni6stOoC00YsDfoM//tM12DBWEFWnoECtJg3A8a
	9m3WGoF88KTrubVwkwspw2yY8w3WKSger/p1PiBEtIdPi6SXK7za0sEcgub6EK9wAJ//gUfj1+l
	ECgoowDqeXr11AtvNbJ0qdRd+OEQcfdGgRKmuQOaTsWfAa87Pn0ui8OCoH5vEvgg1cNTcvgdjtU
	JWo+lhrDrxmRzovj/m3K1vDx4lmAtceq0EhagIB6Pai8uK73hoMzjSWI8
X-Received: by 2002:a17:903:244e:b0:26d:353c:75d4 with SMTP id d9443c01a7336-294cac912dcmr33759635ad.0.1761632906312;
        Mon, 27 Oct 2025 23:28:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe4aQxpIrO/1B82cuCX52JRehi2pSlkgcn2SqnpQ0dnCLRo8Jx6elBnucY+48SF3Le8+WI+Q==
X-Received: by 2002:a17:903:244e:b0:26d:353c:75d4 with SMTP id d9443c01a7336-294cac912dcmr33759385ad.0.1761632905772;
        Mon, 27 Oct 2025 23:28:25 -0700 (PDT)
Received: from hu-yuanfang-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf359asm102503265ad.12.2025.10.27.23.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 23:28:25 -0700 (PDT)
From: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 23:28:10 -0700
Subject: [PATCH 08/12] coresight-tmc-etf: Refactor enable function for CPU
 cluster ETF support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-cpu_cluster_component_pm-v1-8-31355ac588c2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761632890; l=4804;
 i=yuanfang.zhang@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=bsUoTDGB8Bei1YOrLoXxgoY5Y6GaCFBJ2zNDknL+Cf4=;
 b=+K6bkm1CFS5i3Hih/msZzJgWwLlKyW09rlA+eXyrLAa9Vv3XSZIp/7+PFqpHE3ux7LAVrf2tn
 aV+xKD9W3XEACIDgZcXolFAEPZ2eS0mF8crJa/eAgpdt57LlWr2ae17
X-Developer-Key: i=yuanfang.zhang@oss.qualcomm.com; a=ed25519;
 pk=9oS/FoPW5k0CsqSDDrPlnV+kVIOUaAe0O5pr4M1wHgY=
X-Authority-Analysis: v=2.4 cv=dqvWylg4 c=1 sm=1 tr=0 ts=6900628b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Kblxg2WO1sEH5cuAf_YA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: nBWK6eloMbGfOpFEVs9nwVdlYq7KDUS7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA1NCBTYWx0ZWRfX3ie83q0bgWBH
 Qg44WvQnB0uLiEObtleWt+q5lO62Hg98s7QkxrbqTFkG/yvRAsDnUzQzBypp3EpDHZcyZlduvMY
 Y02HzQn1217F98S08aOPMq3TjLvEoWBLPIW9w9CMwtRcXEYFUTX54tlOXHOVxU+V5dWj4Z4BA65
 y3LXJTK9JSGOjhzf7s4yOWkAbqi59xdtD8UDw0LJQrfPLYkOkA4PS2IPpumusvE259b8ixanT+H
 Gc+VLUXRfNVriNhPVGiED6DhQTBFXh0lYiHKIXNMS10+tlpm/ymX7NR1Z65MSJTgf3xp0I3LjSV
 kpdC2piywhz0hp5UBj8lje0SlVVgNbLmpFX8qDwh2BV/O7JabIDwWrRsZ2ruF8Bt7Z1nJ0+dMwf
 YJd6drnLPhsVh4j/E7uhiIuUcJTdmQ==
X-Proofpoint-ORIG-GUID: nBWK6eloMbGfOpFEVs9nwVdlYq7KDUS7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510280054

CPU cluster TMC instances share the cluster's power domain, so register
access must occur on a CPU that keeps the domain powered. To ensure safe
ETF enable sequences on such devices, split tmc_etf/etb_enable_hw function
into two variants:

 - tmc_etf/etb_enable_hw_local: replaces the old tmc_etf/etb_enable_hw for
   normal ETF cases
 - tmc_etf/etb_enable_hw_smp_call: executes CPU cluster ETF enable on a CPU
   within the cluster via smp_call_function_single

Also add a check to ensure the current CPU belongs to the cluster before
calling tmc_etb_enable_hw_local for CPU cluster ETF.

Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 86 ++++++++++++++++++++++---
 1 file changed, 76 insertions(+), 10 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 0f45ab5e5249933ce7059dfee7fe7376ab33ed2d..b8a1c10d4b4c49144449b33f26710cf11713b338 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -47,7 +47,7 @@ static int __tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
 	return rc;
 }
 
-static int tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
+static int tmc_etb_enable_hw_local(struct tmc_drvdata *drvdata)
 {
 	int rc = coresight_claim_device(drvdata->csdev);
 
@@ -60,6 +60,36 @@ static int tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
 	return rc;
 }
 
+struct tmc_smp_arg {
+	struct tmc_drvdata *drvdata;
+	int rc;
+};
+
+static void tmc_etb_enable_hw_smp_call(void *info)
+{
+	struct tmc_smp_arg *arg = info;
+
+	arg->rc = tmc_etb_enable_hw_local(arg->drvdata);
+}
+
+static int tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
+{
+	int cpu, ret;
+	struct tmc_smp_arg arg = { 0 };
+
+	if (!drvdata->cpumask)
+		return tmc_etb_enable_hw_local(drvdata);
+
+	arg.drvdata = drvdata;
+	for_each_cpu(cpu, drvdata->cpumask) {
+		ret = smp_call_function_single(cpu,
+					       tmc_etb_enable_hw_smp_call, &arg, 1);
+		if (!ret)
+			return arg.rc;
+	}
+	return ret;
+}
+
 static void tmc_etb_dump_hw(struct tmc_drvdata *drvdata)
 {
 	char *bufp;
@@ -130,7 +160,7 @@ static int __tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
 	return rc;
 }
 
-static int tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
+static int tmc_etf_enable_hw_local(struct tmc_drvdata *drvdata)
 {
 	int rc = coresight_claim_device(drvdata->csdev);
 
@@ -143,6 +173,32 @@ static int tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
 	return rc;
 }
 
+static void tmc_etf_enable_hw_smp_call(void *info)
+{
+	struct tmc_smp_arg *arg = info;
+
+	arg->rc = tmc_etf_enable_hw_local(arg->drvdata);
+}
+
+static int tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
+{
+	int cpu, ret;
+	struct tmc_smp_arg arg = { 0 };
+
+	if (!drvdata->cpumask)
+		return tmc_etf_enable_hw_local(drvdata);
+
+	arg.drvdata = drvdata;
+
+	for_each_cpu(cpu, drvdata->cpumask) {
+		ret = smp_call_function_single(cpu,
+					       tmc_etf_enable_hw_smp_call, &arg, 1);
+		if (!ret)
+			return arg.rc;
+	}
+	return ret;
+}
+
 static void tmc_etf_disable_hw(struct tmc_drvdata *drvdata)
 {
 	struct coresight_device *csdev = drvdata->csdev;
@@ -228,7 +284,11 @@ static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev)
 		used = true;
 		drvdata->buf = buf;
 	}
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
+
 	ret = tmc_etb_enable_hw(drvdata);
+
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 	if (!ret) {
 		coresight_set_mode(csdev, CS_MODE_SYSFS);
 		csdev->refcnt++;
@@ -290,7 +350,10 @@ static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, void *data)
 			break;
 		}
 
-		ret  = tmc_etb_enable_hw(drvdata);
+		if (drvdata->cpumask && !cpumask_test_cpu(smp_processor_id(), drvdata->cpumask))
+			break;
+
+		ret  = tmc_etb_enable_hw_local(drvdata);
 		if (!ret) {
 			/* Associate with monitored process. */
 			drvdata->pid = pid;
@@ -374,19 +437,22 @@ static int tmc_enable_etf_link(struct coresight_device *csdev,
 		return -EBUSY;
 	}
 
-	if (csdev->refcnt == 0) {
+	if (csdev->refcnt == 0)
+		first_enable = true;
+
+	if (!first_enable)
+		csdev->refcnt++;
+
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	if (first_enable) {
 		ret = tmc_etf_enable_hw(drvdata);
 		if (!ret) {
 			coresight_set_mode(csdev, CS_MODE_SYSFS);
-			first_enable = true;
+			csdev->refcnt++;
+			dev_dbg(&csdev->dev, "TMC-ETF enabled\n");
 		}
 	}
-	if (!ret)
-		csdev->refcnt++;
-	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	if (first_enable)
-		dev_dbg(&csdev->dev, "TMC-ETF enabled\n");
 	return ret;
 }
 

-- 
2.34.1


