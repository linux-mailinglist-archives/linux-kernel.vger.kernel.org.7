Return-Path: <linux-kernel+bounces-820368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE59B7CC25
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 006E41C060AE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 09:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042DA30C37C;
	Wed, 17 Sep 2025 09:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lCNqGji/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6A630BBB0
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758102115; cv=none; b=YR4ou9vkEGYcTdiwBruePD6qh+ppX5W645lv4NIrGaXAqiXoOIdfsFoNJqbJnRa5ElQ/aw6iEtxh4uA9xkMBx4AGgEc22pHXuh1jaVCXAD7d9/2MeTB2ctdYyTh5pSLcyk+yYZn8Mz6DoGpyq0/ueH0Qgy59yKQqcXY2d+QU+5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758102115; c=relaxed/simple;
	bh=p8S1VDimS2zg7uQi7pM+Tja1wksl8Fn6Vx8THIESBew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kcbswCgc2a4jzH6HH1bC4oqasY/3zJIv0ZOTGvDMppMNOydimJAqR3cfB0GswrobTYXraBxjS0lopCpfpUE1Q3FOnVFZYymujK4/qlpYH47XBZRSbAC2qYLvf16uid2lXKcrjujG274OVQXb9LxVkTJkGUWlEDBPmfMjJBJNsCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lCNqGji/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58H8XY6s018235
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:41:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=kFrYXA4FlnihNvw43zAu/XhZJbtjtQD7rqX
	ygRQJ1VI=; b=lCNqGji/rSrM2TqKHp9NbZvIJ7VKJ0MGIg/w042GBHs4SJ+owPm
	qLro/Kw+CAbhJ9to/74ZJlZtgdnQ5pjHM37lNNuHzaCnrJFG5RHPYe74gXt0n37P
	8RPLOFuA5BcjfTnUiOftD86saaNOlE4uSP6Qecigs39D60wgR3aemWIRvaBk7u64
	JLjwTjoZRki3HmyoN0OmxL8IF/BGrBH3KldIxepO/xC+AZE5lRy1TaSifvAFeMjd
	lqqzEXECBOki9OofweX3KNBcNY7OLtvQ8husW7GTCzVSWMK497mZOiVoXyKhRnMT
	dSfzfKqDZKc+LenSv06uIVHOzzhLIQRliwA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxw9uay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:41:52 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2659a7488a2so65040635ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:41:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758102111; x=1758706911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kFrYXA4FlnihNvw43zAu/XhZJbtjtQD7rqXygRQJ1VI=;
        b=wKGSs0/ey/fFjMyfjnzYusaAGM8MHuquq0TG0nCLjXfu1k9+wW7lv67Vgj4Jy9gQMB
         rIJm9uxR5iWEWmpcDA9T+E6/GW1Iigzyxx8u1bRqV8+mBIm4y+WRhTGUXDmdQGxie5Ol
         IH8UMqTJevWznTKkWMIlBy7qhERJbiyvn3Ro7O0gYNjh+6agtUSHwog2xZ6ahPtf2obR
         +4+TP5K0ttknqOUSXHov2wsdoX8xYAAFgvjQBlccmUZYW0MKs/tdPxxgVKDca6zD3rHw
         Qdg+H6rNBH1BQmNPLlMrQCsS6gCrs4jLqdsPX8IV+WV46PheyKTpcbCKeGRfvF/JvDzM
         WKxw==
X-Forwarded-Encrypted: i=1; AJvYcCXJ3N12sUHKELplq0vznnFEXgjtqzDM1D2F0LNzEDPRsKoSGy872BPWNTAuq60KJqJ11cUYEmqlyE/TOxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmpLM2XMQCHhygopbZHoxg0d3ieq4+P4ZxkxppPZpsCZCddG/o
	J0B/V0T/NBPla6q8brobShj87G2aI8dT5BRwh5+CQuu/WqBB1EhRHedCPefq7boD438JPaXgyPD
	fFqij01qFcqHpkLSzWTLWFtTveoXYSUTwYDxEcv9cFsPkiktY8cfzErxLiv1WChTjTYA=
X-Gm-Gg: ASbGncuKzfBH95hsCoLSB1XFnuzchbHiX9UekU6RuOAiUKM+Be0BHFzw3e534T0+87M
	RFGWRuPDddx9QMk9MaSa7iUMePTen++jPiQb/JBzgsmOHkIBjBCLRLy41bRrY4TUMqIk6K/FyU0
	wjENAuyXXQ9IeLiczKKu1wZS9cQlQQmu0UnPKTwwPRamb9yr7CNbHKZr6P+nlMVbEsaKsOgBgZw
	GYG9ljjmCmYGQQdUW/PZZHItPgn56cT0lFHXtMNBNHdMQ6RWUBIc3A/nDWcUryyIpQOdnmuq2Ks
	fqqKkjPPCyW8CIi2vsj1KWswHC/ELAcWT0B9pGrGsstc9K7B0Pk91l0guLkrhjVN0BRFpS9DCUd
	Kke6FOY4ILl4850sr3TGlemi9YgWoeBs=
X-Received: by 2002:a17:903:1ace:b0:268:500:5ec7 with SMTP id d9443c01a7336-268118b4286mr21516925ad.2.1758102111373;
        Wed, 17 Sep 2025 02:41:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNGoIDfb5pzgXvPOENVt3HN3joOEiGJjfQkZC/ldkf9dnxcuviCUuY4vaqdKqUUX6HUT7N0g==
X-Received: by 2002:a17:903:1ace:b0:268:500:5ec7 with SMTP id d9443c01a7336-268118b4286mr21516595ad.2.1758102110897;
        Wed, 17 Sep 2025 02:41:50 -0700 (PDT)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed257bbf8sm1942483a91.0.2025.09.17.02.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:41:50 -0700 (PDT)
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
Subject: [PATCH v3] scsi: ufs: core: Fix data race in CPU latency PM QoS request handling
Date: Wed, 17 Sep 2025 17:41:43 +0800
Message-ID: <20250917094143.88055-1-zhongqiu.han@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HbIUTjE8 c=1 sm=1 tr=0 ts=68ca8260 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bwEYGBBtgshAin72mCkA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX/VV8L32rjN/j
 dnetkD3n+Pw1ZW00qXe12zO2XzDoh9iZJAsQPzlRPpc7PjHGUBwAWlMKUYcT81Lc8+c7mjsZBIe
 mTuN4NGLzKvBCrAxbYhaOOV01yByWAMrZURTEzqS6F5wv7nzTFTPMI965OIotmth2KjNEhnZ/np
 1IdNsP0+rG0518B2KJ5BhoqO5FTdklBdnghnLylWL4/dSh4Jqq0GTgToen0KxQvxcqj4x/Mr0Bm
 lI29f0o9/aM4Rt9RU3gYdx9NVZn6bThjPno1xjJSbp6/mFt7v/XDIWSKfO3gGcfH87Jy3VsJceb
 IzKcOK/QtMbr0rJm+jHGUvOKCkjL7yAGIbHFjey9aCOVGsWGRgpbiIo09wIxrpol2zfBv9ikEGE
 2Q9PbYEW
X-Proofpoint-GUID: rdM1CvUpc0fjXd2ZQF60jyXg7oiNMpCA
X-Proofpoint-ORIG-GUID: rdM1CvUpc0fjXd2ZQF60jyXg7oiNMpCA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

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
preventing data races and ensuring safe access to PM QoS resources,
including sysfs interface reads.

Fixes: 2777e73fc154 ("scsi: ufs: core: Add CPU latency QoS support for UFS driver")
Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
v2 -> v3:
- Per Bart's comments, replaced READ_ONCE with a mutex for sysfs access to ensure
  thread safety, and updated the commit message accordingly.
- Also per Bart's suggestion, use guard(mutex)(&hba->pm_qos_mutex) instead of
  explicit mutex_lock/mutex_unlock to improve readability and ease code review.
- Link to v2: https://lore.kernel.org/all/20250902074829.657343-1-zhongqiu.han@oss.qualcomm.com/

v1 -> v2:
- Fix misleading indentation by adding braces to if statements in pm_qos logic.
- Resolve checkpatch strict mode warning by adding an inline comment for pm_qos_mutex.

 drivers/ufs/core/ufs-sysfs.c | 2 ++
 drivers/ufs/core/ufshcd.c    | 9 +++++++++
 include/ufs/ufshcd.h         | 3 +++
 3 files changed, 14 insertions(+)

diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index 4bd7d491e3c5..0086816b27cd 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -512,6 +512,8 @@ static ssize_t pm_qos_enable_show(struct device *dev,
 {
 	struct ufs_hba *hba = dev_get_drvdata(dev);
 
+	guard(mutex)(&hba->pm_qos_mutex);
+
 	return sysfs_emit(buf, "%d\n", hba->pm_qos_enabled);
 }
 
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 88a0e9289ca6..2ea7cf86cea1 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -1047,6 +1047,7 @@ EXPORT_SYMBOL_GPL(ufshcd_is_hba_active);
  */
 void ufshcd_pm_qos_init(struct ufs_hba *hba)
 {
+	guard(mutex)(&hba->pm_qos_mutex);
 
 	if (hba->pm_qos_enabled)
 		return;
@@ -1063,6 +1064,8 @@ void ufshcd_pm_qos_init(struct ufs_hba *hba)
  */
 void ufshcd_pm_qos_exit(struct ufs_hba *hba)
 {
+	guard(mutex)(&hba->pm_qos_mutex);
+
 	if (!hba->pm_qos_enabled)
 		return;
 
@@ -1077,6 +1080,8 @@ void ufshcd_pm_qos_exit(struct ufs_hba *hba)
  */
 static void ufshcd_pm_qos_update(struct ufs_hba *hba, bool on)
 {
+	guard(mutex)(&hba->pm_qos_mutex);
+
 	if (!hba->pm_qos_enabled)
 		return;
 
@@ -10765,6 +10770,10 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 	mutex_init(&hba->ee_ctrl_mutex);
 
 	mutex_init(&hba->wb_mutex);
+
+	/* Initialize mutex for PM QoS request synchronization */
+	mutex_init(&hba->pm_qos_mutex);
+
 	init_rwsem(&hba->clk_scaling_lock);
 
 	ufshcd_init_clk_gating(hba);
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index ea0021f067c9..277dda606f4d 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -938,6 +938,7 @@ enum ufshcd_mcq_opr {
  * @ufs_rtc_update_work: A work for UFS RTC periodic update
  * @pm_qos_req: PM QoS request handle
  * @pm_qos_enabled: flag to check if pm qos is enabled
+ * @pm_qos_mutex: synchronizes PM QoS request and status updates
  * @critical_health_count: count of critical health exceptions
  * @dev_lvl_exception_count: count of device level exceptions since last reset
  * @dev_lvl_exception_id: vendor specific information about the
@@ -1110,6 +1111,8 @@ struct ufs_hba {
 	struct delayed_work ufs_rtc_update_work;
 	struct pm_qos_request pm_qos_req;
 	bool pm_qos_enabled;
+	/* synchronizes PM QoS request and status updates */
+	struct mutex pm_qos_mutex;
 
 	int critical_health_count;
 	atomic_t dev_lvl_exception_count;
-- 
2.43.0


