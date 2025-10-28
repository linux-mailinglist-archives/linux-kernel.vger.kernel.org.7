Return-Path: <linux-kernel+bounces-873116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E24BC13297
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0F12586FC5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94F72BDC33;
	Tue, 28 Oct 2025 06:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F+ktBSla"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130212BEC45
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761632900; cv=none; b=eBFdYJGKSp6hi8FlP2ur9/JrjiyGlJE33w6QMX4HXWlN+1KUkYtpXOFDtJNwKnyGdJ4ROZ8V/PbA1hm6GQdJDbn0g/GHsyQX8pRL0xRPbpOGAw/ZnEpFRA6z49gYeZLmFntCyirgO8vfcu9563bCIUT0SzjtcnT/bFDItBciTKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761632900; c=relaxed/simple;
	bh=TMPIo9r3GKbM4/XsJ/eT0bym94bCuMEsVFDyTCJ0GQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=siom+5bV3W6wx8sZVzFu8CATe2Yoy5ixU5ZfVOX8CAtUdlb1GbukdEK5x2Z+oUeOxu1RGza+iB75tCTq06kHuCZyASY8DOF9TFcsSeDQC/+VhtTUNpI1Ev10oWW+v4AC2myHvEPvGKRP5V1bhbvmoz8HSbiM1K7EXZppxCLYicA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F+ktBSla; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59S41Hof3165340
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HuSM5SLFMC7N6NZFy7Qf19Ll4uLRSR1mcYDYQZd6pRw=; b=F+ktBSlaRa5746cm
	0sWtcu22QT/5PTZgXcYDikvFKTSeMhqU6ykfU6t4PmsBNyowxBayFRANlzNJtJnD
	wRUsR2WzInmY6k/xZ7eHCyNQIWMNn+GDg2+b+B6xy1YuvXctI697rTiV95Z7QLC5
	jzFU0J/xvU6EsssNcoIlbF9luugYQiEfddgbj0wmoTuoKmXoXmGm6ibMfY5i+Tf6
	ijyrrv3qLEowiPk2Q6YUwVt+q+6jID9f6tsFXReg6f1iL5OMUSek3+OmFqlaXQvl
	ABvczUjhd1MU00wmOEEwFiUgDpQmmD6qONBFXuZO9JmTBm7rH0V4i6xZmyakr10a
	k+CarA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2bwx23sq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:28:17 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-277f0ea6fbaso66358285ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761632897; x=1762237697;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HuSM5SLFMC7N6NZFy7Qf19Ll4uLRSR1mcYDYQZd6pRw=;
        b=mb64yWtUALrx41+FdtyDo6Ff7+QGd+o1ZdqRv4ql/Z//jPcNPz2rVNFQOoCXpcwx8U
         5VLcvpCwFPW96lIQaJj8OnhiHXk+0pNYmRG3wz+q+NSwCqwNaGn69XIYTAKe9+vhH/q+
         vcVr/mYL9XNA5vLEhi52wIqdT4vyGfcGGMmWDer+6ijeSCIUFF2w1sISUdo8s2VzoYbz
         qhySk4+88sj/fkgmsCOOhQiljy64l2yn8JDfBM9Pc1qTOJ/PiZx3x72/sMFpGBaAVu7T
         Rzs2EolK5KYoOLaTFoHpZgZJY7vzrHqySGPZ72EOH1+BHTvRFW/R6iL3ep9vk+cNSfYB
         T7xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRsbYKPxkzRHLizHPiHLLR5EuAR0uBke1t4vplfOPtgvO/RhnmnR9QcJBJdPWdalwhMGnWiGIgIYiiR8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzbzEASrYJH513IW7iv5cm8XRPB1WujJJa5Xb9HE9/fbI0a+AE
	XZCVMua2Q4A+HBJ/MDrHj+DIF5MnVc53xotVoBrps+tZ4WgaJUQylYXc2cx3jp00Eggff1d0WAx
	IF89Xfxi4qhTQvdKHFRhqzlCEsum6qugTKXjaWTiv0ID5bvdK6s3oQJKAboNdCeTfEug=
X-Gm-Gg: ASbGncvTVVpxeREPNLSfVRtcILPh4mKsOEOzmMq3tej7tj0AsWG5Gxud9U7yTYXZ8Ze
	LHXoimYPvphQXebAVhJW9I5+Jo0tUXTBazAWmzH2b2Ivb/Oq0VqkUcIJesVyD/m/SYf4FVj048g
	WHXfejX/He9Ly4dUStC/mjPurLKmoYc0lcpzl4dmB78q2j4mrebxVX4OgyfBaghkWMHjriRQP9E
	8VXm3q9aJ0HOmr5mfpSOim4FeO2NTWGJMC8IkPOODuZwub2tutMKqAh6pYbHRN7oO2RSG5eY7+r
	diMzsLOdNN7IoAds+tTK45xD18vCHsGMGC+Y8j6ykws3bAsPuHaLzzUee9SHV6XIG5z3hl1sfAp
	PjpEhMwy3Icgna7nCD10MzB3QVjgGPWkU7JSVIc75iEUpWejAWWjHOEuH
X-Received: by 2002:a17:902:d50c:b0:265:57dc:977b with SMTP id d9443c01a7336-294cb6ab8afmr26086535ad.61.1761632896859;
        Mon, 27 Oct 2025 23:28:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJHI3hJVc5V8w2KfBaOGb+fbx2ZhMNUkTZo9hi0BOvSUZh3C76Y5JuAjU8EzyW78la+CcyYA==
X-Received: by 2002:a17:902:d50c:b0:265:57dc:977b with SMTP id d9443c01a7336-294cb6ab8afmr26086325ad.61.1761632896374;
        Mon, 27 Oct 2025 23:28:16 -0700 (PDT)
Received: from hu-yuanfang-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf359asm102503265ad.12.2025.10.27.23.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 23:28:15 -0700 (PDT)
From: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 23:28:05 -0700
Subject: [PATCH 03/12] coresight-funnel: Handle delay probe for CPU cluster
 funnel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-cpu_cluster_component_pm-v1-3-31355ac588c2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761632890; l=4160;
 i=yuanfang.zhang@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=TMPIo9r3GKbM4/XsJ/eT0bym94bCuMEsVFDyTCJ0GQE=;
 b=GugX3k+ihfKyUBUqtYh1X+pw96lNXr/5f0/RSTbu9cBkZhi71QQJKr8CSmV3S1zYjioYc7gJN
 u+Pcw81DtinB6++tLNNOcS6Ou3iIHF7jRRdAtVGIPMdw74WXe+L4j+y
X-Developer-Key: i=yuanfang.zhang@oss.qualcomm.com; a=ed25519;
 pk=9oS/FoPW5k0CsqSDDrPlnV+kVIOUaAe0O5pr4M1wHgY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA1NCBTYWx0ZWRfX2jeZDnDqB7HG
 HCMeEJMa1rkKkLt3iGp6vGc2TGwq5fiwKFaVtSLHhweKh1yNmqWhLEg/BPksWwnt3Ulyy4zjkEB
 Bw3S5XPoPFawStZaLdRDoPVxn7m5bJtH7nRSomI9/YkAPvS145mEjp/wjydmJhuqs6mjsprt6ST
 WowUnXrqyZGimxS4IxhbT53y2Y1Xq1SgbSCqviHjhuEbbcpAydDJRIJocD6EfJJTyExmxiROO46
 gINf+NtnyOn18TGVIyB7TXIENowRFu9oLBi2ZCa2MGMvH7DtPceT5lodZ7S8sBaxdHTOuEb/feg
 E9jCmrBTMRacfBD1HUqyVKwD1o6oRvH63jEQKHwjE6qWqkbGXZ4htXF6ZYMHJ6ZwNxGFYK0KQK8
 VgZ7/Ilcep+My0t7oXwpMgossv4Gsw==
X-Proofpoint-ORIG-GUID: JpUCbDmlphN1hfEIEg5tmzeOyiAnASS-
X-Authority-Analysis: v=2.4 cv=U9WfzOru c=1 sm=1 tr=0 ts=69006281 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=B8lwgTuz66jIMM7eRW8A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: JpUCbDmlphN1hfEIEg5tmzeOyiAnASS-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280054

Delay probe the cpu cluster funnel when all CPUs of this cluster are
offline, re-probe the funnel when any CPU in the cluster comes online.

Key changes:
- Introduce a global list to track delayed funnels waiting for CPU online.
- Add CPU hotplug callback to retry registration when the CPU comes up.

Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-funnel.c | 62 +++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 12c29eb98b2122a3ade4cbed9a0d91c67ec777ed..43b9287a865eb26ce021521e4a5f193c48188bba 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -32,6 +32,9 @@
 #define FUNNEL_ENSx_MASK	0xff
 
 DEFINE_CORESIGHT_DEVLIST(funnel_devs, "funnel");
+static LIST_HEAD(funnel_delay_probe);
+static enum cpuhp_state hp_online;
+static DEFINE_SPINLOCK(delay_lock);
 
 /**
  * struct funnel_drvdata - specifics associated to a funnel component
@@ -42,6 +45,8 @@ DEFINE_CORESIGHT_DEVLIST(funnel_devs, "funnel");
  * @priority:	port selection order.
  * @spinlock:	serialize enable/disable operations.
  * @cpumask:	CPU mask representing the CPUs related to this funnel.
+ * @dev:	pointer to the device associated with this funnel.
+ * @link:	list node for adding this funnel to the delayed probe list.
  */
 struct funnel_drvdata {
 	void __iomem		*base;
@@ -51,6 +56,8 @@ struct funnel_drvdata {
 	unsigned long		priority;
 	raw_spinlock_t		spinlock;
 	struct cpumask		*cpumask;
+	struct device		*dev;
+	struct list_head	link;
 };
 
 struct funnel_smp_arg {
@@ -372,7 +379,7 @@ static int funnel_probe(struct device *dev, struct resource *res)
 		drvdata->cpumask = funnel_get_cpumask(dev);
 		if (!drvdata->cpumask)
 			return -EINVAL;
-
+		drvdata->dev = dev;
 		cpus_read_lock();
 		for_each_cpu(cpu, drvdata->cpumask) {
 			ret = smp_call_function_single(cpu,
@@ -380,10 +387,15 @@ static int funnel_probe(struct device *dev, struct resource *res)
 			if (!ret)
 				break;
 		}
-		cpus_read_unlock();
 
-		if (ret)
+		if (ret) {
+			scoped_guard(spinlock,  &delay_lock)
+				list_add(&drvdata->link, &funnel_delay_probe);
+			cpus_read_unlock();
 			return 0;
+		}
+
+		cpus_read_unlock();
 	} else if (res) {
 		funnel_clear_self_claim_tag(drvdata);
 	}
@@ -395,9 +407,12 @@ static int funnel_remove(struct device *dev)
 {
 	struct funnel_drvdata *drvdata = dev_get_drvdata(dev);
 
-	if (drvdata->csdev)
+	if (drvdata->csdev) {
 		coresight_unregister(drvdata->csdev);
-
+	} else {
+		scoped_guard(spinlock,  &delay_lock)
+			list_del(&drvdata->link);
+	}
 	return 0;
 }
 
@@ -535,8 +550,41 @@ static struct amba_driver dynamic_funnel_driver = {
 	.id_table	= dynamic_funnel_ids,
 };
 
+static int funnel_online_cpu(unsigned int cpu)
+{
+	struct funnel_drvdata *drvdata, *tmp;
+	int ret;
+
+	list_for_each_entry_safe(drvdata, tmp, &funnel_delay_probe, link) {
+		if (cpumask_test_cpu(cpu, drvdata->cpumask)) {
+			scoped_guard(spinlock,  &delay_lock)
+				list_del(&drvdata->link);
+
+			ret = pm_runtime_resume_and_get(drvdata->dev);
+			if (ret < 0)
+				return 0;
+
+			funnel_clear_self_claim_tag(drvdata);
+			funnel_add_coresight_dev(drvdata->dev);
+			pm_runtime_put(drvdata->dev);
+		}
+	}
+	return 0;
+}
+
 static int __init funnel_init(void)
 {
+	int ret;
+
+	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+					"arm/coresight-funnel:online",
+					funnel_online_cpu, NULL);
+
+	if (ret > 0)
+		hp_online = ret;
+	else
+		return ret;
+
 	return coresight_init_driver("funnel", &dynamic_funnel_driver, &funnel_driver,
 				     THIS_MODULE);
 }
@@ -544,6 +592,10 @@ static int __init funnel_init(void)
 static void __exit funnel_exit(void)
 {
 	coresight_remove_driver(&dynamic_funnel_driver, &funnel_driver);
+	if (hp_online) {
+		cpuhp_remove_state_nocalls(hp_online);
+		hp_online = 0;
+	}
 }
 
 module_init(funnel_init);

-- 
2.34.1


