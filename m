Return-Path: <linux-kernel+bounces-723084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6C1AFE29E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0420485D91
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E63274FD7;
	Wed,  9 Jul 2025 08:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JUDe1oZa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018C3276025
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752049821; cv=none; b=jMu0GjChFFFTYjhh6ek+vpcOqMb8SUIO02tqIzfNnCifn434mu2pmnYKd2shhdSQ+5t+rp9hP7EOQvw8CxtQCVixZLcKDXKqDPWV0laXe9MghNrPJiDdTN4riGCMTSIyXN0IEOAb6qpuRwHKTGqR8FrwSEbG+XkGwuWYy4kOCWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752049821; c=relaxed/simple;
	bh=y+ALyJ89mofNMm5St1h2kQaTOCzXFGBJGXcWVmtRKgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HerqYEYNZvSOOc7mfrsK5fQJhuzZhzwfB4ckiHxA3wkjsDcaOcvxU/KwyVwofHFspoLJlgJREMe1gQuCr3VvEQupS+rqhC2jvbO9y0qLIgQAhHkYO+D5QhL97Eniw+h+vbVYxLrAdrJ/Yf5eODkapHV+J7l1AQ7DwbeEiHVknCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JUDe1oZa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5697jcHU010288
	for <linux-kernel@vger.kernel.org>; Wed, 9 Jul 2025 08:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ktjlYwdjVYmfZRvKpskcTT
	MIsN/4CSP1auyN3yxMpZg=; b=JUDe1oZajjWbMuyCoXOUvQGvU8UqtuXswC3McL
	ROw5nhXnAkJU8/Gf1P8jh+EBJBgXVim7J7FPLNX2WDGos00/lvIhc5Lfk5Z62qwI
	j8sH+CbRaFJoPgHQcmdLtu6yOL5RmrHKby8hj209aWKSZvIE90D1w6iCKunLja83
	Iv9jrGyI7sGQ4F8xfjX8ectBTRtOk2RpgdocbgkufHtoiluHL18DjRD/r0gHmUY3
	TIy3cjXC45VPrPxDNivMXCdww9hIlK8cl2MLlpTCv2FEEfQ/1nP/8uWjcXeLFGdZ
	uVT7n64f6O9vpIKMWpvyW2HNRRq/E7UJtQuvz8zTBQJ29QPQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smap04qu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 08:30:17 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-74b185fba41so4307778b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 01:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752049816; x=1752654616;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ktjlYwdjVYmfZRvKpskcTTMIsN/4CSP1auyN3yxMpZg=;
        b=AfDdye9ganVr9QBM9NXlbaZAmoiIpraybPONFfCirnoKJEeuBRZKsU0iQSMBDnVhxS
         47+yVoAcvTLzb/8ts0iUkPum68s7hVx48mYPVtzIsiYKSY7ra+xKBFhjfNB6hDPMT2Ff
         fwteWWFEJzqArGgvlnrbVX7kg4igdA+Su7a/2WyP3fj/4wq6PO1aZyvcxPks1la5i7DC
         gSg3bCPXhn28ugzSnXA73jg70dMdHJLUbVY7k6MsDXF1sjPj4wrHNalZgs8Axk+5RRd7
         tBQCn2eh0vOLnUF+vTVXKGTVSV2gBNikUBL8ev56lbWhw4Mqir0zMdM6tv7bSH48Egtu
         zeDg==
X-Forwarded-Encrypted: i=1; AJvYcCWDV0lXcHIuJ0JlhF7Jl+Z08t1HZidhe3sfj4+v6BoxzPHnGNSkfm4xgbsyifd2RUn6J9p6pkgXPI18/Z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyHbviKuIgmaaankYtOa7qQyI+FUj/OD7+vfjy2rUDmqRoojC9
	N7dP8TeqiUEj3GC1a/vOwIFJfotSw48J46oOBMXmL+Yc212lqsrbswHR4FLL5hEFD82CBJa4TGK
	Kd7/hCS57yq+xPlOvh68X0MGZi7J2dw93aXKdQ1YCCA8Rw0GYBf0XxfGsnYP2cVeOgCSs29spWG
	k=
X-Gm-Gg: ASbGnctB9PPd4xIDD+vN/IWha1YCFhR2Z8hRDd4QL06XUj+QGMvBnCvcekOviPcXSkq
	VCBkmgpC8pPLjNXvS5RJMgr0Ng5JvUO6s5p/QFz2fONOHdxmEiVDGnesCeeN4gUVKDbcDa7jdAu
	OyW+VaBPxeMH4E9w/dFNBVImED3wFFP9qXpHKeWFZxI/KIrCX261Gef7n0jsFJ1QyQ67eBOf3oq
	+9f/LOtfUd7YVKcohUoVTCXrhwrDQhJv0ynGvhuHpkeXHe+SJAR+1Uze9HSt+QOrkVrtdKq0Can
	GxR41HiRKl/bvKTP9d0rd7NY+0ebRLtbfKsJCCu4gMQRa+Mwr5g=
X-Received: by 2002:a05:6a20:9f9b:b0:22b:8f7f:5cb2 with SMTP id adf61e73a8af0-22cd59ffc44mr3039824637.8.1752049816356;
        Wed, 09 Jul 2025 01:30:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWpSdApdQoxlULCIi1tLXiJftge0qv/gC9NuOeXgguazYgPCvb/8rGO86lxxZ3U+TPbN3alQ==
X-Received: by 2002:a05:6a20:9f9b:b0:22b:8f7f:5cb2 with SMTP id adf61e73a8af0-22cd59ffc44mr3039772637.8.1752049815935;
        Wed, 09 Jul 2025 01:30:15 -0700 (PDT)
Received: from hu-mkshah-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce35ccb9esm14872105b3a.50.2025.07.09.01.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 01:30:15 -0700 (PDT)
From: Maulik Shah <maulik.shah@oss.qualcomm.com>
Date: Wed, 09 Jul 2025 14:00:11 +0530
Subject: [PATCH v2] pmdomain: governor: Consider CPU latency tolerance from
 pm_domain_cpu_gov
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-pmdomain_qos-v2-1-976b12257899@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJIobmgC/33MQQrCMBCF4auUWZsyHaxpXfUeIhLTiQ2YpM1oE
 UrvbvAAbh58i/dvIJw9C5yrDTKvXnyKBXSowE4mPlj5sRgIqUWNnZrDmILx8bYkUdSj1q67n4g
 YymXO7Pznl7tci11OQb2mzOZPZG1Uo7RtkdzR9tiYIYnUy9s8bQqhLgP7/gWAlL59qQAAAA==
X-Change-ID: 20250708-pmdomain_qos-29077f8b622e
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Maulik Shah <maulik.shah@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752049813; l=4349;
 i=maulik.shah@oss.qualcomm.com; s=20240109; h=from:subject:message-id;
 bh=y+ALyJ89mofNMm5St1h2kQaTOCzXFGBJGXcWVmtRKgo=;
 b=Lrfa7NEP6jO4ZZpra+PKTz8jeXjYBtHM5IoRLAuEMMLR9HQzgN/vJxoa9JAGwyRpLo4MTp878
 nk+gmTyRorDAPEBOLN53+tLrkuTsvlwsufTjUWfXDr1k0VKNH1mG8kW
X-Developer-Key: i=maulik.shah@oss.qualcomm.com; a=ed25519;
 pk=bd9h5FIIliUddIk8p3BlQWBlzKEQ/YW5V+fe759hTWQ=
X-Authority-Analysis: v=2.4 cv=Ar7u3P9P c=1 sm=1 tr=0 ts=686e2899 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=pR31FINYhqodxwX9k7wA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: gTFfFnzYrH450wBaMEgMr9DjIWqY9Q7Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDA3MyBTYWx0ZWRfX/unOqFC33UZM
 PB8DoceMLe+zYqOBDB5oxg2ztjmaMv2dYMlzIyNMkWx8scLliT2EcM6i5Tgu1G4rPjJw1iDMN0L
 zdc31eRFH1+w0F4rim3sfIIuUUqn+n9oDGFP9QCAB3H6BBdlCFKBfyzK09Jxc+5yN4iWSGV6+Ck
 HqMNbVwxOXo3U1bNpzyBFkYBj1I2f4aBhEhR0dkMw6OG7IUMhlSSgGFHa58umM8FJOmt2YIYafQ
 vMrf6CvL18cyXSs29yLbsKIi28RzQUG6AlahkHe/ySBG2kqVOagS5PS2ger6DE2xXHmrxQfCMWb
 WxGKw9n6TNZE9gQ2wV3X/cyws+hep+RPcTy3CBrysXLmC2Z/JmdHvE79qcv7ucsZSToOJCpSrQq
 gq3u3L+kFccQYs3QfOmx5SoGP5uKNpbpFQ2puOWSmWIbY1XulprWwaGpc4DaW4wCFdiZxnis
X-Proofpoint-GUID: gTFfFnzYrH450wBaMEgMr9DjIWqY9Q7Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 phishscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507090073

pm_domain_cpu_gov is selecting a cluster idle state but does not consider
latency tolerance of child CPUs. This results in deeper cluster idle state
whose latency does not meet latency tolerance requirement.

Select deeper idle state only if global and device latency tolerance of all
child CPUs meet.

Test results on SM8750 with 300 usec PM-QoS on CPU0 which is less than
domain idle state entry (2150) + exit (1983) usec latency mentioned in
devicetree, demonstrate the issue.

	# echo 300 > /sys/devices/system/cpu/cpu0/power/pm_qos_resume_latency_us

Before: (Usage is incrementing)
======
	# cat /sys/kernel/debug/pm_genpd/power-domain-cluster0/idle_states
	State          Time Spent(ms) Usage      Rejected   Above      Below
	S0             29817          537        8          270        0

	# cat /sys/kernel/debug/pm_genpd/power-domain-cluster0/idle_states
	State          Time Spent(ms) Usage      Rejected   Above      Below
	S0             30348          542        8          271        0

After: (Usage is not incrementing due to latency tolerance)
======
	# cat /sys/kernel/debug/pm_genpd/power-domain-cluster0/idle_states
	State          Time Spent(ms) Usage      Rejected   Above      Below
	S0             39319          626        14         307        0

	# cat /sys/kernel/debug/pm_genpd/power-domain-cluster0/idle_states
	State          Time Spent(ms) Usage      Rejected   Above      Below
	S0             39319          626        14         307        0

Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
---
Changes in v2:
- Rename device pointer to cpu_dev
- Replace dev_pm_qos_read_value() with dev_pm_qos_raw_resume_latency()
- Link to v1: https://lore.kernel.org/all/20250708-pmdomain_qos-v1-1-7c502f4c901a@oss.qualcomm.com
---
 drivers/pmdomain/governor.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
index c1e148657c873a6b5b4d9c0f058d54cb020c56e2..39359811a93047b36443a1b9583962726f24b88b 100644
--- a/drivers/pmdomain/governor.c
+++ b/drivers/pmdomain/governor.c
@@ -8,6 +8,7 @@
 #include <linux/pm_domain.h>
 #include <linux/pm_qos.h>
 #include <linux/hrtimer.h>
+#include <linux/cpu.h>
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
 #include <linux/ktime.h>
@@ -349,6 +350,8 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 	struct cpuidle_device *dev;
 	ktime_t domain_wakeup, next_hrtimer;
 	ktime_t now = ktime_get();
+	struct device *cpu_dev;
+	s64 cpu_constraint, global_constraint;
 	s64 idle_duration_ns;
 	int cpu, i;
 
@@ -359,6 +362,7 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 	if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN))
 		return true;
 
+	global_constraint = cpu_latency_qos_limit();
 	/*
 	 * Find the next wakeup for any of the online CPUs within the PM domain
 	 * and its subdomains. Note, we only need the genpd->cpus, as it already
@@ -372,8 +376,16 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 			if (ktime_before(next_hrtimer, domain_wakeup))
 				domain_wakeup = next_hrtimer;
 		}
+
+		cpu_dev = get_cpu_device(cpu);
+		if (cpu_dev) {
+			cpu_constraint = dev_pm_qos_raw_resume_latency(cpu_dev);
+			if (cpu_constraint < global_constraint)
+				global_constraint = cpu_constraint;
+		}
 	}
 
+	global_constraint *= NSEC_PER_USEC;
 	/* The minimum idle duration is from now - until the next wakeup. */
 	idle_duration_ns = ktime_to_ns(ktime_sub(domain_wakeup, now));
 	if (idle_duration_ns <= 0)
@@ -389,8 +401,10 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 	 */
 	i = genpd->state_idx;
 	do {
-		if (idle_duration_ns >= (genpd->states[i].residency_ns +
-		    genpd->states[i].power_off_latency_ns)) {
+		if ((idle_duration_ns >= (genpd->states[i].residency_ns +
+		    genpd->states[i].power_off_latency_ns)) &&
+		    (global_constraint >= (genpd->states[i].power_on_latency_ns +
+		    genpd->states[i].power_off_latency_ns))) {
 			genpd->state_idx = i;
 			genpd->gd->last_enter = now;
 			genpd->gd->reflect_residency = true;

---
base-commit: 26ffb3d6f02cd0935fb9fa3db897767beee1cb2a
change-id: 20250708-pmdomain_qos-29077f8b622e

Best regards,
-- 
Maulik Shah <maulik.shah@oss.qualcomm.com>


