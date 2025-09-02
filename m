Return-Path: <linux-kernel+bounces-795719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE42BB3F6F8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC64485184
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3F02E7631;
	Tue,  2 Sep 2025 07:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eCyZFndy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E042E7196
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 07:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756799321; cv=none; b=dLN8F3cIK8S7vwCxhG3bg2Jnwd9igjus8Zp6eaUV6mxpYbwBaFMFIrex+U44J88RTanwhnvfFFJ+ITEIK9mfFCM4KCGUnmxuk6HLL2d5dm21LfZu0phn4f+tw7fKJefNtS6lkpw+HyS8J3KHV4iO5rTan6rvlex9Ef4B1t5V7Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756799321; c=relaxed/simple;
	bh=fDoOHY0Zpl4rBQTY1PUdC0etCtUgqqjSMNTz3YokoUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rz+z5G1dGcTJXMjzNKF1IDgZle1NtAPT+zIHc7aQP4Zc7s9qpo7VrHDhq5ru7lhre+hf2BJCrQaNGg+rbAglqtHD1RxEinZ6WDJscGz17o0I1co7k5qo2GaK4e5itLzXA75Czvo5MJCqczgYpItQFtPH1vbkn2I+WCHirYBpSm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eCyZFndy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S5ZG025153
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 07:48:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=qaqsDaJl/E8BLR+cwPeJEtVPr1RgbXmwoZR
	9XUu8+uw=; b=eCyZFndy+RC0oFgBGyH160boutj8Oi6XPvPRlIUodiUgVkvddEB
	acBtYugF8QLf/LhwJfxWmjPJNCwwpYb/xQnFyvTjKuWG7MXVII3kB8zVxJUrnp/A
	czImov6QLNggYXBWH/uoskeYKcu79w74E6/ajxtZtzozzv7O1KEt6072kv3w4E0y
	Y92g5b9BrxBTso7KLa3IYHOe5tNrtrzGGOk8mzeFw9drVGA4LUYnNUrl9A8X3FYM
	foMdixCTd1l61xhlF1jbaMqSC1oMlnw67yHlchmZIPWLqrPHZUVYdFBu3I9uwD2s
	qQakv0+7HOlioYIl2H4S53owqJjdDMRe24g==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscuy0xk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 07:48:37 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7725c995dd0so1468318b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 00:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756799316; x=1757404116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qaqsDaJl/E8BLR+cwPeJEtVPr1RgbXmwoZR9XUu8+uw=;
        b=ZjAJQAhN9W6bfbZnwuUgKo1rVEZt1P1GXCT4FJFY+AzO5mQfdnzG67gFSMwzmNJmCv
         qECyjg9SI+8h5XmpDRgYxKqPJcf/f0frGM4UUeMVnpmBUdermMSfdbbHrUW/DVFohMuj
         dpAquOL1nzDVxSW8easpngZiV8SUkU+zaF1eFVPNoTp0/c2lVV/QyrQoZJHdXxoZAgRW
         dNHiSlN5ur/eFIyRaTfN9ncDHa9sIlI+HwRSUWK9YoUd5kSOu9s951Sk6/fZf9BYSaSA
         t5QyLa3SQ0BOPTrT3sATI0GZcOPiXqg8Xc5atIjJDr5o9pRESifYTGyfAZIW4APUSn5E
         xlpg==
X-Forwarded-Encrypted: i=1; AJvYcCW9P4pGPIf9BeCJUPiRX8+5vzT+BNnenSFd1L+7aKOcBh5oZwV36X2SSdImbTgRQ4/7jW1hYFboTiPZTUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyeDDfQQJFqqjdqayb7FMJIBsrtuDwP4tJAyyorwiwYOqITgse
	TNSATMdXkn4slQCLQtqrefl6r6m9Xl5ylHINW7RVQy4uIu36/wWRld1tc+V9L3O6ZDqYmHYPT70
	ky93Ez/B1V26W9GoZAeJ74m0RjkFudrPm9AoICrTrzsm/YtDGCp9bxC7eHhTmKdMJ+II=
X-Gm-Gg: ASbGncvFox687XZEd1exXP/ch32y5rNH38NZ128cWsnecJLp6oq7vhBq0wlO9PnyEJU
	LZJScA4osWBSxO5FsywRlTPwt2V2i4V7rxXG0k3Nh5uqFajaLXgTOLbpSzBn3WIVzDsWtNtrmT6
	IP6NGN65kiW7KhcxRvv3XNl0u0PCREzAQpzFnANqAto3Yc5a1jZm/CwxuovZxXZ79h+QVvG31pB
	TNfABRaKRzzjLW3Jf/CPSWkoRhQ4LdoSa7EBlAMtPyMzhOR/+8OJk7FDL1oE9Z9W3HYzDPq/sLN
	xXaOZzuyVrO6o0x3bxXUQB0Ssg/oMkI96IyQf5lAmlAc8/4VeN9pgum1McVe1dDkWJxeq16XIFc
	kBw4msJFJmhj/HxKYUJG2L25Qqjlsp60=
X-Received: by 2002:a05:6a00:90aa:b0:772:554c:4879 with SMTP id d2e1a72fcca58-772554c5019mr7993593b3a.26.1756799315830;
        Tue, 02 Sep 2025 00:48:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqC44eTVxcBKP6ZclsLZDlo5hgjCLdI1LecbFM3XvQVNcUn1KLXFVzYxhNe0DkscCmNKJkSA==
X-Received: by 2002:a05:6a00:90aa:b0:772:554c:4879 with SMTP id d2e1a72fcca58-772554c5019mr7993562b3a.26.1756799315346;
        Tue, 02 Sep 2025 00:48:35 -0700 (PDT)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7723427c127sm11372459b3a.62.2025.09.02.00.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 00:48:34 -0700 (PDT)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com
Cc: peter.wang@mediatek.com, tanghuan@vivo.com, liu.song13@zte.com.cn,
        quic_nguyenb@quicinc.com, viro@zeniv.linux.org.uk, huobean@gmail.com,
        adrian.hunter@intel.com, can.guo@oss.qualcomm.com, ebiggers@kernel.org,
        neil.armstrong@linaro.org, angelogioacchino.delregno@collabora.com,
        quic_narepall@quicinc.com, quic_mnaresh@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        nitin.rawat@oss.qualcomm.com, ziqi.chen@oss.qualcomm.com,
        zhongqiu.han@oss.qualcomm.com
Subject: [PATCH v2] scsi: ufs: core: Fix data race in CPU latency PM QoS request handling
Date: Tue,  2 Sep 2025 15:48:29 +0800
Message-ID: <20250902074829.657343-1-zhongqiu.han@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfXwLU0asnzwq2Y
 0Mw4Us1Dm00beOaOk7jrRmfGydCeG6CZOa8I0tgBCseecc3n/nB/nMKw3PO7ZUVcalomBMIPWHZ
 A6vU8YVlvIg/4ztEOeiv3cKQlbXtabIVbnrSaARxcQK/FePNLKPc1VZbA/JfpbNz1rltjaroYWV
 sO7oZWcJf3e6vVG4il6wf3GQOhZXuc3jFK4z8Y+fS/vyMyf2QTuj7Y+PuzPLc8B5xAQWcz9cyPd
 BOtmX1k+68pWBCoDN7wXu/MwPqBfvbcfRkXKMughPq2Zmwa8JvzyVBc3Jnf5aGQlhGbR/Rz10o/
 qKCbt75VTyrDYUy1BQX5rzUSGrq3H1r5Kh4nx+NUBK3bS5bl8myoSZY6i2dY8V9DNZQrbSaotG7
 aheXj/fo
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b6a155 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=LWsq1cZ33obsDQM5gBoA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: Pg2FjUWeovGn-lfIXOJeCMiuNFgibm7c
X-Proofpoint-GUID: Pg2FjUWeovGn-lfIXOJeCMiuNFgibm7c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031

The cpu_latency_qos_add/remove/update_request interfaces lack internal
synchronization by design, requiring the caller to ensure thread safety.
The current implementation relies on the `pm_qos_enabled` flag, which is
insufficient to prevent concurrent access and cannot serve as a proper
synchronization mechanism. This has led to data races and list corruption
issues.

A typical race condition call trace is:

[Thread A]
ufshcd_pm_qos_exit()
  --> cpu_latency_qos_remove_request()
    --> cpu_latency_qos_apply();
      --> pm_qos_update_target()
        --> plist_del              <--(1) delete plist node
    --> memset(req, 0, sizeof(*req));
  --> hba->pm_qos_enabled = false;

[Thread B]
ufshcd_devfreq_target
  --> ufshcd_devfreq_scale
    --> ufshcd_scale_clks
      --> ufshcd_pm_qos_update     <--(2) pm_qos_enabled is true
        --> cpu_latency_qos_update_request
          --> pm_qos_update_target
            --> plist_del          <--(3) plist node use-after-free

This patch introduces a dedicated mutex to serialize PM QoS operations,
preventing data races and ensuring safe access to PM QoS resources.
Additionally, READ_ONCE is used in the sysfs interface to ensure atomic
read access to pm_qos_enabled flag.

Fixes: 2777e73fc154 ("scsi: ufs: core: Add CPU latency QoS support for UFS driver")
Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
v1 -> v2:
- Fix misleading indentation by adding braces to if statements in pm_qos logic.
- Resolve checkpatch strict mode warning by adding an inline comment for pm_qos_mutex.
- Link to v1: https://lore.kernel.org/all/20250901085117.86160-1-zhongqiu.han@oss.qualcomm.com/

 drivers/ufs/core/ufs-sysfs.c |  2 +-
 drivers/ufs/core/ufshcd.c    | 25 ++++++++++++++++++++++---
 include/ufs/ufshcd.h         |  3 +++
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index 4bd7d491e3c5..8f7975010513 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -512,7 +512,7 @@ static ssize_t pm_qos_enable_show(struct device *dev,
 {
 	struct ufs_hba *hba = dev_get_drvdata(dev);
 
-	return sysfs_emit(buf, "%d\n", hba->pm_qos_enabled);
+	return sysfs_emit(buf, "%d\n", READ_ONCE(hba->pm_qos_enabled));
 }
 
 /**
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 926650412eaa..98b9ce583386 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -1047,14 +1047,19 @@ EXPORT_SYMBOL_GPL(ufshcd_is_hba_active);
  */
 void ufshcd_pm_qos_init(struct ufs_hba *hba)
 {
+	mutex_lock(&hba->pm_qos_mutex);
 
-	if (hba->pm_qos_enabled)
+	if (hba->pm_qos_enabled) {
+		mutex_unlock(&hba->pm_qos_mutex);
 		return;
+	}
 
 	cpu_latency_qos_add_request(&hba->pm_qos_req, PM_QOS_DEFAULT_VALUE);
 
 	if (cpu_latency_qos_request_active(&hba->pm_qos_req))
 		hba->pm_qos_enabled = true;
+
+	mutex_unlock(&hba->pm_qos_mutex);
 }
 
 /**
@@ -1063,11 +1068,16 @@ void ufshcd_pm_qos_init(struct ufs_hba *hba)
  */
 void ufshcd_pm_qos_exit(struct ufs_hba *hba)
 {
-	if (!hba->pm_qos_enabled)
+	mutex_lock(&hba->pm_qos_mutex);
+
+	if (!hba->pm_qos_enabled) {
+		mutex_unlock(&hba->pm_qos_mutex);
 		return;
+	}
 
 	cpu_latency_qos_remove_request(&hba->pm_qos_req);
 	hba->pm_qos_enabled = false;
+	mutex_unlock(&hba->pm_qos_mutex);
 }
 
 /**
@@ -1077,10 +1087,15 @@ void ufshcd_pm_qos_exit(struct ufs_hba *hba)
  */
 static void ufshcd_pm_qos_update(struct ufs_hba *hba, bool on)
 {
-	if (!hba->pm_qos_enabled)
+	mutex_lock(&hba->pm_qos_mutex);
+
+	if (!hba->pm_qos_enabled) {
+		mutex_unlock(&hba->pm_qos_mutex);
 		return;
+	}
 
 	cpu_latency_qos_update_request(&hba->pm_qos_req, on ? 0 : PM_QOS_DEFAULT_VALUE);
+	mutex_unlock(&hba->pm_qos_mutex);
 }
 
 /**
@@ -10764,6 +10779,10 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 	mutex_init(&hba->ee_ctrl_mutex);
 
 	mutex_init(&hba->wb_mutex);
+
+	/* Initialize mutex for PM QoS request synchronization */
+	mutex_init(&hba->pm_qos_mutex);
+
 	init_rwsem(&hba->clk_scaling_lock);
 
 	ufshcd_init_clk_gating(hba);
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 30ff169878dc..a16f857a052f 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -962,6 +962,7 @@ enum ufshcd_mcq_opr {
  * @ufs_rtc_update_work: A work for UFS RTC periodic update
  * @pm_qos_req: PM QoS request handle
  * @pm_qos_enabled: flag to check if pm qos is enabled
+ * @pm_qos_mutex: synchronizes PM QoS request and status updates
  * @critical_health_count: count of critical health exceptions
  * @dev_lvl_exception_count: count of device level exceptions since last reset
  * @dev_lvl_exception_id: vendor specific information about the
@@ -1135,6 +1136,8 @@ struct ufs_hba {
 	struct delayed_work ufs_rtc_update_work;
 	struct pm_qos_request pm_qos_req;
 	bool pm_qos_enabled;
+	/* synchronizes PM QoS request and status updates */
+	struct mutex pm_qos_mutex;
 
 	int critical_health_count;
 	atomic_t dev_lvl_exception_count;
-- 
2.43.0


