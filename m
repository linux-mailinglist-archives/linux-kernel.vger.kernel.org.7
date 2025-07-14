Return-Path: <linux-kernel+bounces-729475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7DBB03734
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC8B31706A5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 06:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BC4236431;
	Mon, 14 Jul 2025 06:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F3AZEB+X"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DFC235061
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752474727; cv=none; b=pHVrRiBYo5SN0J/X2Im8RH+Nuzq/S9G3d78VHdYcsYdHWyPV5JL8g8c9DANuu1/TW2+7jVubMTAl92L2Qil3IYeabriKTLeaEef6gZCYuiu9yTE4VxqJBx0tIwupFbU+RW75TuSJllbWTnXzDK3NcbEh2Wy6wU947N7uyCeYTY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752474727; c=relaxed/simple;
	bh=DsAeaJlnnfbHDj+ZqA9awBKXz/l7fvyToWZA3JSDpi4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uPUgkBUJnj2648PWAhdl0p7z7TnsqAi4Q+iHLGw3eH+WsfvMn1wcmg+TOeDZh6JyMaKQrgT5/rgS7cmNPCCf+olI3PJI2JPORFTrS3WPeMSazmFGnfZCCBLe0XfeNTAbVAeUrhQCFoY9OXIypb0wbxfu3RwxUNO/a1PQyuM/NSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F3AZEB+X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DMSPnr028415
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:32:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=/fz+LGoddWm
	iY1/jAhIAcksrU+G3xmeGky/QljdjsCo=; b=F3AZEB+Xa9w97TbTTc4fAGYqe/j
	SkzXlJLOV6BuDzAs8whaFtIaoJ79hijzSFWI/8HZIU1tmbjjKvuw8Eo04ispnMzf
	XLeLtz/PbCEbpSMmqk5VN3pqd9LlGBPEeO0SbasJaGzhiOfy8NfGgPehOhEpfGOr
	gTSzaCuxIy78dnzW52X1Ukri+7x7oq2zGSD6CZIt1tzzwj/TEp86HzxlJjtLS3kA
	5/fRy7fjXRWiSizc4AnaKaILIXWyBK/umcGO0yixTL4VleTupJziZwEWyhXuT6gc
	NWYG/gJmLQvngf+wg+9AYf3akQrcgrJOxbI34+FKrL3pryVjPKdTUT84kzA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufut3exq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:32:04 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23dc7d3e708so23601145ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 23:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752474723; x=1753079523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fz+LGoddWmiY1/jAhIAcksrU+G3xmeGky/QljdjsCo=;
        b=BSAB70JKqlE/AYspd9ZCFWJQxjKUSfWC5Z47PP2yCPDbdxk0D2YmON4N7x/xvzth/i
         gjCEoxiAIkV7z6oF3k+FdZB/EczVkQuJYHxZxvw6TOAc4aXtQmT5DMYl3ngwTF2u9Q/k
         V5lXAa3PvOw4GaH4Y4wLSMHyKVgbTqYu1hkL2ldkBfe7mEZ8T+XHbpL8NuJlT+lAJ3LW
         gZw0IHxkapylJIXtLc72rTxXgP9dKjWcstRTB6VIS/oihZ5TrdBWo7A3+4UDa7rNPFCT
         bTIES1mmtMAQRAWQAEWCE0+hVoASLkeJX/a6WHcvtJ+l0oaAS5OVBCzA0HP7wP9ghRyg
         erag==
X-Forwarded-Encrypted: i=1; AJvYcCUw8x/VP0OPvv8zBYtDdv0XQcujR7q46Fp2WI+eR3cK97DhyI9nB91sBwO21NmVPGnercWITNrX83e2Myk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk21d9i788ccwRRxn/hlPK17BbqosZXpWmvFaiticYcZAOlXB8
	oGzORbkJV75fd+MUeLDb8pbSWuX52OWySFEojBSs1613edql6K/Pu8Zli3D/WMFMKMaSIyIYaHU
	dPLrpOaJnoe/m39iuDbfBNRUlQ36MKOQFOGJibyU1A4AnUOfYGQWE3nOjPSYtbUhuMyw=
X-Gm-Gg: ASbGncuiSe1N0F+pongXa6Z1UAdqlJkgAtiP+W5OsBulqQzm2ef1dqo8lcZUChJrRhw
	r+gSQ4uuEXMqyozVai7ZOGRWeRFdtGYE65VlGhNYYQXfoFeVdckhVNs3RFVgKIWfdgRQFWsu1x+
	0zKPgzlrrZDXnYJ29HmY9dwmGr7q3oufIHei6CSrXdtdzeQZ/dq6nAfceOYcnoX0e0tEzHlsIDJ
	49NYenjNJnK1OKwCqs1az1ItDDrr/sXg56ZSV/wztlgEmVc5aj5/aREIcbfxXcP+yCiM0WJ5NOJ
	71HhJVFQKiutpRq5QjqQUqMETyjkF+F30HF81naPyrainA82kYNfhH7PnJUHby/cvDME8zG30id
	9Igv3vu9DWdxPW1dUf07N
X-Received: by 2002:a17:902:f691:b0:235:880:cf70 with SMTP id d9443c01a7336-23dee1e8c82mr157439955ad.14.1752474722717;
        Sun, 13 Jul 2025 23:32:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbEosWbcJHr08zZ1EkpTq27v410DV5/hiU//rvj4mE1PTiP9bG8uglFbxS8uo2dt3oI8k2ug==
X-Received: by 2002:a17:902:f691:b0:235:880:cf70 with SMTP id d9443c01a7336-23dee1e8c82mr157439485ad.14.1752474722239;
        Sun, 13 Jul 2025 23:32:02 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4334005sm86138255ad.158.2025.07.13.23.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 23:32:01 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Jie Gan <quic_jiegan@quicinc.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 RESEND 09/10] coresight: tmc: add read function for byte-cntr
Date: Mon, 14 Jul 2025 14:31:08 +0800
Message-Id: <20250714063109.591-10-jie.gan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250714063109.591-1-jie.gan@oss.qualcomm.com>
References: <20250714063109.591-1-jie.gan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=e7gGSbp/ c=1 sm=1 tr=0 ts=6874a464 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=56IJ4eEW6NAC_NOVRZQA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: jXBsWRkNyvrLFQ-aP6rgbSSvbZ8v8u-7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAzNyBTYWx0ZWRfX44lA68k+oDax
 WNKlejE5vJImj2LXdr3TSbrOF6CXxZ4vNirN9cXcS0L4BYSA7DQ1QM/g9CPZo8fBvpcvLnlEqpt
 s9Vd8bZRlXN6EWX8e1zFi2fTrB9VRONN/ZqdypurxgkciDlE3PwvIvfRV4bOsoufvtCbKDXisMU
 1wcm/ZE3N6C0cQGNuuUZen8wIX3M7Tj8ldM6lTrXAm3CMGJdx8dyGuQ/snBcL1Qm7gYBBXxZuuB
 I2kAyxiU7b6CgzFObiFzj3Y1HDAAoUbzvuGVE2TLXZitkteVQk8qOwtkHCpOE1YCJ6a5Q1QOove
 FaipSE3rnSQUwRz/06+3kIFm0Z85ZAn6fenj392EiQbnZT5htGP69POsmrSr2UT6duy4NSBPm1q
 ZKBwlHY8HEXtwBR4gkv6acGinSe2viAfozes7ozKypWSuZv7w8PwcrUGrlXJMT66G2t1obWo
X-Proofpoint-ORIG-GUID: jXBsWRkNyvrLFQ-aP6rgbSSvbZ8v8u-7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140037

The byte-cntr read function always reads trace data from the deactivated
and filled buffer which is already synced. The read function will fail
when the ETR cannot find a available buffer to receive trace data.

The read function terminates when the path is disabled or interrupted by a
signal.

Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 .../hwtracing/coresight/coresight-tmc-core.c  | 31 ++++++-
 .../hwtracing/coresight/coresight-tmc-etr.c   | 90 +++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tmc.h   |  3 +
 3 files changed, 120 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 354faeeddbb2..3ab25adc4e4d 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -318,14 +318,18 @@ static int tmc_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t tmc_get_sysfs_trace(struct tmc_drvdata *drvdata, loff_t pos, size_t len,
-				   char **bufpp)
+static ssize_t tmc_get_sysfs_trace(struct tmc_drvdata *drvdata,
+				   struct ctcu_byte_cntr *byte_cntr_data,
+				   loff_t pos, size_t len, char **bufpp)
 {
 	switch (drvdata->config_type) {
 	case TMC_CONFIG_TYPE_ETB:
 	case TMC_CONFIG_TYPE_ETF:
 		return tmc_etb_get_sysfs_trace(drvdata, pos, len, bufpp);
 	case TMC_CONFIG_TYPE_ETR:
+		if (byte_cntr_data && byte_cntr_data->thresh_val)
+			return tmc_byte_cntr_get_data(drvdata, byte_cntr_data, len, bufpp);
+
 		return tmc_etr_get_sysfs_trace(drvdata, pos, len, bufpp);
 	}
 
@@ -339,7 +343,21 @@ static ssize_t tmc_read(struct file *file, char __user *data, size_t len,
 	ssize_t actual;
 	struct tmc_drvdata *drvdata = container_of(file->private_data,
 						   struct tmc_drvdata, miscdev);
-	actual = tmc_get_sysfs_trace(drvdata, *ppos, len, &bufp);
+	struct coresight_device *helper = coresight_get_helper(drvdata->csdev,
+						CORESIGHT_DEV_SUBTYPE_HELPER_CTCU);
+	struct ctcu_byte_cntr *byte_cntr_data = NULL;
+	struct ctcu_drvdata *ctcu_drvdata = NULL;
+	int port;
+
+	if (helper) {
+		port = coresight_get_port_helper(drvdata->csdev, helper);
+		if (port >= 0) {
+			ctcu_drvdata = dev_get_drvdata(helper->dev.parent);
+			byte_cntr_data = &ctcu_drvdata->byte_cntr_data[port];
+		}
+	}
+
+	actual = tmc_get_sysfs_trace(drvdata, byte_cntr_data, *ppos, len, &bufp);
 	if (actual <= 0)
 		return 0;
 
@@ -349,7 +367,12 @@ static ssize_t tmc_read(struct file *file, char __user *data, size_t len,
 		return -EFAULT;
 	}
 
-	*ppos += actual;
+	if (byte_cntr_data && byte_cntr_data->thresh_val) {
+		byte_cntr_data->total_size += actual;
+		drvdata->reading_node->pos += actual;
+	} else
+		*ppos += actual;
+
 	dev_dbg(&drvdata->csdev->dev, "%zu bytes copied\n", actual);
 
 	return actual;
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 3e3e1b5e78ca..174411e76047 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1163,6 +1163,10 @@ ssize_t tmc_etr_get_sysfs_trace(struct tmc_drvdata *drvdata,
 	ssize_t actual = len;
 	struct etr_buf *etr_buf = drvdata->sysfs_buf;
 
+	/* Reading the buffer from the buf_node if it exists*/
+	if (drvdata->reading_node)
+		etr_buf = drvdata->reading_node->sysfs_buf;
+
 	if (pos + actual > etr_buf->len)
 		actual = etr_buf->len - pos;
 	if (actual <= 0)
@@ -1339,6 +1343,92 @@ static bool tmc_byte_cntr_switch_buffer(struct tmc_drvdata *drvdata,
 	return found_free_buf;
 }
 
+/*
+ * tmc_byte_cntr_get_data() - reads data from the deactivated and filled buffer.
+ * The byte-cntr reading work reads data from the deactivated and filled buffer.
+ * The read operation waits for a buffer to become available, either filled or
+ * upon timeout, and then reads trace data from the synced buffer.
+ */
+ssize_t tmc_byte_cntr_get_data(struct tmc_drvdata *drvdata,
+			       struct ctcu_byte_cntr *byte_cntr_data,
+			       size_t len, char **bufpp)
+{
+	size_t thresh_val = byte_cntr_data->thresh_val;
+	atomic_t *irq_cnt = &byte_cntr_data->irq_cnt;
+	struct etr_buf *sysfs_buf = drvdata->sysfs_buf;
+	struct device *dev = &drvdata->csdev->dev;
+	struct etr_buf_node *nd, *next;
+	ssize_t size = sysfs_buf->size;
+	ssize_t actual;
+	loff_t pos;
+	int ret;
+
+wait_buffer:
+	if (!byte_cntr_data->reading_buf) {
+		ret = wait_event_interruptible_timeout(byte_cntr_data->wq,
+				((atomic_read(irq_cnt) + 1) * thresh_val >= size) ||
+				!byte_cntr_data->enable,
+				BYTE_CNTR_TIMEOUT);
+		if (ret < 0)
+			return ret;
+		/*
+		 * The current etr_buf is almost full or timeout is triggered,
+		 * so switch the buffer and mark the switched buffer as reading.
+		 */
+		if (byte_cntr_data->enable) {
+			if (!tmc_byte_cntr_switch_buffer(drvdata, byte_cntr_data)) {
+				dev_err(dev, "Switch buffer failed for byte-cntr\n");
+				return -EINVAL;
+			}
+
+			byte_cntr_data->reading_buf = true;
+		} else {
+			if (!drvdata->reading_node) {
+				list_for_each_entry_safe(nd, next, &drvdata->etr_buf_list, node) {
+					if (nd->sysfs_buf == sysfs_buf) {
+						nd->pos = 0;
+						drvdata->reading_node = nd;
+						break;
+					}
+				}
+			}
+
+			pos = drvdata->reading_node->pos;
+			actual = tmc_etr_get_sysfs_trace(drvdata, pos, len, bufpp);
+			if (actual > 0)
+				return actual;
+
+			drvdata->reading_node = NULL;
+
+			/* Exit byte-cntr reading */
+			return -EINVAL;
+		}
+	}
+
+	/* Check the status of current etr_buf*/
+	if ((atomic_read(irq_cnt) + 1) * thresh_val >= size)
+		/*
+		 * Unlikely to find a free buffer to switch, so just disable
+		 * the ETR for a while.
+		 */
+		if (!tmc_byte_cntr_switch_buffer(drvdata, byte_cntr_data))
+			dev_info(dev, "No available buffer to store data, disable ETR\n");
+
+	pos = drvdata->reading_node->pos;
+	actual = tmc_etr_get_sysfs_trace(drvdata, pos, len, bufpp);
+	if (actual == 0) {
+		/* Reading work for marked buffer has finished, reset flags */
+		drvdata->reading_node->reading = false;
+		byte_cntr_data->reading_buf = false;
+		drvdata->reading_node = NULL;
+
+		/* Nothing in the buffer, wait for next buffer to be filled */
+		goto wait_buffer;
+	}
+
+	return actual;
+}
+
 static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 {
 	int ret = 0;
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 1dbba0bc50a3..4136ec5ecaf7 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -364,6 +364,9 @@ int tmc_read_prepare_byte_cntr(struct tmc_drvdata *drvdata,
 			       struct ctcu_byte_cntr *byte_cntr_data);
 int tmc_read_unprepare_byte_cntr(struct tmc_drvdata *drvdata,
 				 struct ctcu_byte_cntr *byte_cntr_data);
+ssize_t tmc_byte_cntr_get_data(struct tmc_drvdata *drvdata,
+			       struct ctcu_byte_cntr *byte_cntr_data,
+			       size_t len, char **bufpp);
 
 #define TMC_REG_PAIR(name, lo_off, hi_off)				\
 static inline u64							\
-- 
2.34.1


