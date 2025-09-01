Return-Path: <linux-kernel+bounces-794116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 914DBB3DD0D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68AED189DB56
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2052FF163;
	Mon,  1 Sep 2025 08:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d/nw8qgB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC372FE589
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756716687; cv=none; b=CYex1X6oSf2g6DTmNeAW6txdcPLlWWPPvfL7UDuQj9tG2BsTElY2A+JKVbC5LdcBKvR8RSLkv0ja9uS8dWFYG/dAszLGBGoFIv837CFk5NmITC1WRNMM6ePAQDSWLJMRjOcewO74DVESC62sqHzu8BvVslIQEep52bCDhVgHM2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756716687; c=relaxed/simple;
	bh=XrbZexRIxDvZhju5+9QWUl6stdqXzSMg2jQoWArCM34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XSGjkiKrYTvIUfE7bvAB5qVX1wXYolTm3tTrbGOtfyfyXTr1+jRfYQ/nxzOncnJQemromHQ+6xu/G2X6OPO3XtKEzncmq3i06Gg/MdxehZYauj1fBrx5xcr3DfavCH8blniThpuX+9pnhCMEa4/aTabzHqJYkqGo0/u29RgeuR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d/nw8qgB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5817h25T008940
	for <linux-kernel@vger.kernel.org>; Mon, 1 Sep 2025 08:51:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=u/UuUiBZZ0n9XhcUdx3sipQ4gPzSrPJvNFj
	uS2EBN/Y=; b=d/nw8qgBf7jokW/ivtdWqSnh6yvSwDtn4yviWwwNqIV0UzvAYN3
	vYeKHw75co+X0K6HAj5LoZWTZyZWda+01Yb94Zc1NcgOQkiFmiHdxxMrSr41MDr7
	yqUM7cfHSwHgs8lcVpvOkbQMiHFRbOxqKV67Z6tNnrK9WEXmBFQI087awfrDmnB/
	ayCHsAqa39d3KkwBwYPnMLPo+iLrqKvHH3i61dP1zlGXGh8MPEfU6DDR7Y+dHoRH
	AYmrHpphnhBWnsAe+eZru62QzAurpVxS38v+h9iJxomkdTvN4PJaXVAStXgsDFpj
	p48THpAnFrMG1KZv2Z0EAxar/MexfRWirfw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0ec8dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 08:51:24 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32811874948so1646318a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 01:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756716684; x=1757321484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u/UuUiBZZ0n9XhcUdx3sipQ4gPzSrPJvNFjuS2EBN/Y=;
        b=XAMbBpL8rhO+6zCbtWKunsbFrhJbv9lYf9D561KwoMowSJyz4lgkbP06baDUtcMXTv
         3Q+YfLSXIAlCbIX0PRQC/PVktpN0mkFBotGN94GaKSTSQ/CglC/E5zhvl4BccATEDUe/
         yuyZOZvYdK/JN6ShTWHDuv5kK4lUSGSeTjJej4+AJ3gY7DC1m5OyZ3udRorw86nzcV5W
         HJ2rKIcEV21FKdZ0Fa5wy2ZcGIjvENZ01t/2ALv/gWEMatGq8FkPf8lEF6nEAO0w/ovw
         eRXSV0pufiFXRvCBk0Tszh17ipKmMaFoBXQqodV7f4GAu+gqaYlMw7hBtLsOJRawgwOv
         TjgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSr7CoAAjpFSo7wonZUfZeyzUZZRGX+u9ZgdI3nIjr3FPdiIGC76HUSNq/8EtOAWR9+mCqAjqbBEd/hcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/eXSothOqXzx7cqEFa+Gk28x9TUTnI9ZCZVssl/b8LSE9Knco
	15AJUkRHGgY/YQN4DvldmRdXZGT/zh01kizjYmeIpBzHUrwu7xMHI4CmOvpKEIlmfmyzwn9sUXo
	JYwMermckCNzMOz2Yc0cnEYtZxXuJ1Kkh40oXwqjZkntYceyKJgRI1tfQrK3tzNwHtzc=
X-Gm-Gg: ASbGncvz3ROJeaFQLpPNzW3yfW4jyzQaiL6j2bPblJG9Xgq0tqoq3vJPn01EoQcFxIm
	zKuz2+8jB/k3Xn5E46ek+j1bGFFRa2P8WlZb6YwPR17+4l3CG5Sni1U53K8OiGEKs/OA9GNg/zH
	UMF+QT9TIFUsWM4dpB1EzVvJDzNsHxXJgFblYwIhe64/MmhetGjdmf9O0QYOr6g0c/1Zp1uzcDe
	BIaZphSRuH6Gm7+5izpMFvlM4k1H8LOMIcfTSc5UMBMOeDFC2kw/0jIiR+sbSVQ+9F4KgujQtxY
	+5wqmrh9BmKJiFuA1VUziw0RIr/bSfq8NdMEc4RsH+GAFwBLxD/1F9ljEKr+Iz7DCfg7l6qCL3W
	WgG4fzWIkjatTfXRaWEdgdKzrlBSWD/0=
X-Received: by 2002:a17:90b:370a:b0:327:aaeb:e814 with SMTP id 98e67ed59e1d1-328156babd1mr6591989a91.23.1756716683694;
        Mon, 01 Sep 2025 01:51:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZhrulCPEiXiqrYyGIf41rwfHjxwpZKyJ/5zPadKvzIZFBh7PM85GZFS8GhIVy869wdnfmBQ==
X-Received: by 2002:a17:90b:370a:b0:327:aaeb:e814 with SMTP id 98e67ed59e1d1-328156babd1mr6591959a91.23.1756716683147;
        Mon, 01 Sep 2025 01:51:23 -0700 (PDT)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd006dd49sm9045090a12.5.2025.09.01.01.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 01:51:22 -0700 (PDT)
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
Subject: [PATCH] scsi: ufs: core: Fix data race in CPU latency PM QoS request handling
Date: Mon,  1 Sep 2025 16:51:17 +0800
Message-ID: <20250901085117.86160-1-zhongqiu.han@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1TIpzUBCvlsVDSSpU_WmHGp9YUHuScdh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfX7rIIIkHHc+xf
 6CyfE9wJ85spz1sVtSl31aR5tcgst+dMFuCVj7YvChAdUrCLNqdPlSRhLJa28xhDaRGqO/Woo+X
 rff9SIylU8EK6b0mQgjEijDA5UuB7pTJvdwXqFWF9saEDuUNDeuKI2F5tZfE6SEiIHlsTW61WN/
 51OtVAMQzaCtkqEorHr6o7tosn76dj/98eQ0A1sl3O9hppZBXHUOXo9KBFiupn2+F4ALkpOpG1d
 5r6ZhCx+ODTUr+6FIAddHo2WbZacgCxE4iexXt3JVn2Bg9xVMRDyTYQmKaPTNdInlS+MLNob5jj
 LizMussZZPQ+e3LJxx0AEuG5CxTHhLBjTIh7/QjeEFUmFyDLfaoGdGLQwvifCD1xrDbFB/NeGEp
 cLQWw6rA
X-Proofpoint-ORIG-GUID: 1TIpzUBCvlsVDSSpU_WmHGp9YUHuScdh
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68b55e8c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=af37CCu951KBZlcfKc8A:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300004

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
 drivers/ufs/core/ufs-sysfs.c |  2 +-
 drivers/ufs/core/ufshcd.c    | 16 ++++++++++++++++
 include/ufs/ufshcd.h         |  2 ++
 3 files changed, 19 insertions(+), 1 deletion(-)

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
index 926650412eaa..f259fb1790fa 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -1047,14 +1047,18 @@ EXPORT_SYMBOL_GPL(ufshcd_is_hba_active);
  */
 void ufshcd_pm_qos_init(struct ufs_hba *hba)
 {
+	mutex_lock(&hba->pm_qos_mutex);
 
 	if (hba->pm_qos_enabled)
+		mutex_unlock(&hba->pm_qos_mutex);
 		return;
 
 	cpu_latency_qos_add_request(&hba->pm_qos_req, PM_QOS_DEFAULT_VALUE);
 
 	if (cpu_latency_qos_request_active(&hba->pm_qos_req))
 		hba->pm_qos_enabled = true;
+
+	mutex_unlock(&hba->pm_qos_mutex);
 }
 
 /**
@@ -1063,11 +1067,15 @@ void ufshcd_pm_qos_init(struct ufs_hba *hba)
  */
 void ufshcd_pm_qos_exit(struct ufs_hba *hba)
 {
+	mutex_lock(&hba->pm_qos_mutex);
+
 	if (!hba->pm_qos_enabled)
+		mutex_unlock(&hba->pm_qos_mutex);
 		return;
 
 	cpu_latency_qos_remove_request(&hba->pm_qos_req);
 	hba->pm_qos_enabled = false;
+	mutex_unlock(&hba->pm_qos_mutex);
 }
 
 /**
@@ -1077,10 +1085,14 @@ void ufshcd_pm_qos_exit(struct ufs_hba *hba)
  */
 static void ufshcd_pm_qos_update(struct ufs_hba *hba, bool on)
 {
+	mutex_lock(&hba->pm_qos_mutex);
+
 	if (!hba->pm_qos_enabled)
+		mutex_unlock(&hba->pm_qos_mutex);
 		return;
 
 	cpu_latency_qos_update_request(&hba->pm_qos_req, on ? 0 : PM_QOS_DEFAULT_VALUE);
+	mutex_unlock(&hba->pm_qos_mutex);
 }
 
 /**
@@ -10764,6 +10776,10 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 	mutex_init(&hba->ee_ctrl_mutex);
 
 	mutex_init(&hba->wb_mutex);
+
+	/* Initialize mutex for PM QoS request synchronization */
+	mutex_init(&hba->pm_qos_mutex);
+
 	init_rwsem(&hba->clk_scaling_lock);
 
 	ufshcd_init_clk_gating(hba);
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 30ff169878dc..e81f4346f168 100644
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
@@ -1135,6 +1136,7 @@ struct ufs_hba {
 	struct delayed_work ufs_rtc_update_work;
 	struct pm_qos_request pm_qos_req;
 	bool pm_qos_enabled;
+	struct mutex pm_qos_mutex;
 
 	int critical_health_count;
 	atomic_t dev_lvl_exception_count;
-- 
2.43.0


