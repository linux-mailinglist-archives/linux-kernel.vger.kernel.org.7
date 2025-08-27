Return-Path: <linux-kernel+bounces-787643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EEAB3790C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 06:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3B923B1FED
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 04:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51662882D0;
	Wed, 27 Aug 2025 04:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iNhbMWaJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534D52C15AE
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 04:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756268461; cv=none; b=fpTWSHubnFBcn1qVyErsXlz6D1UASumz8DJSFRKzaGUKbsC9Nn1rhRWSnXbdJvMf0jki66+wLzZc1P47uuZyVxTgDTf5M+cDpAYa1BJk6lwr6TfDx09uTZkH7vvYRXmgyV1ehy0kqSn0m22Id0sGFIbR+9MhN241gC5ZkVMysBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756268461; c=relaxed/simple;
	bh=ocp4EtIWT0yQZJx2kabJRwppCpqBBhc20itvLNY7cW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sinXy7EAyn9FYLi8EngWCJf+XMIi/Z3yZ9VIxrQnoFK+axieYZ3CSFUc91VCbEO7bfh2jRwgxpS9XnJe2sgwr2sQaFc09lKVkmgmT9iHAxs6HtCYG/pNG6C+yrXXU6F2l7399CV1z5rEyw3UxU9UKvzPjCmMXF1bzHZlLmntLb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iNhbMWaJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QL1RfQ021722
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 04:20:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=LFgzrZAixnT
	qFsEdbAYjDQONQ2mnmA9c8+kXB2USXhQ=; b=iNhbMWaJDlRl7uFXPhJdTn/l/sK
	oVXznRwiU+6nBM+5O1M8eEXZJDPjaY8C3tr1MgdcUTFUL4FXZhyjk1fg8a0BFisD
	/04GkXfCopoJ1xjouI4i2/2TwdzY0PquJaJARlyivNCPc2R8Miezam0CnTG6WKor
	ruRJy2p38cQ1aF8+HmMEQa1Y4l6N2HAmrJDn94r7W/Lt41qx5wZvMsMnUJLx3wI4
	E7HN24cgv2/E4a7koHRewY1SzgJFaXh90IbfR4H2yOqWDA3gYIrnBjDAawTk6Rk3
	SFTcAe20c1eh87dxOvntLL9FfjgZGuolCrREc4gfMyIquCHjmYRyr31l+IA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q615ka8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 04:20:59 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b471737c5efso4728885a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 21:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756268458; x=1756873258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFgzrZAixnTqFsEdbAYjDQONQ2mnmA9c8+kXB2USXhQ=;
        b=rL33uW+9/TEwIYWwDL9dIu1D57txkQmsSMJP4HyfiixQAW77RMTw0CDTVZbax5fTft
         nV4kwRmOmpSBHOLOhjFGJzJOyGH1JP4xfZFIS3cCsGi9+dNpyiaqQpov1pB0g1KNotqY
         0NauVMtox22BfUeTSnS7emJmTRobQ5H/Ji3IaLSUAwXK9Uh++i7KBa4mULE2RSPFc6LD
         y7XoI/OqDRffw4f0/G/cwCM8xRGTp1AmgSmr2irYQm5R1TggBgDTdOjeIW5iKpUuCtOc
         rh5IIFOZnSWeKByeTDvvfb3PHqx6Lq4K0ewLcoWXSjf1UGIokjc3K3nE7EhQIB6tD31z
         tlWg==
X-Forwarded-Encrypted: i=1; AJvYcCWtMeHC3fI9UqYGiZ8jneF6d33403BX/9kT/1Iyl5vZSuRuB+B5MerTsX/WDgBsqJfVTG9038CtUYJePcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaPY1gKO4Zb/dfqr/MekOlOG8Jg3zAQo1pRmeKmShvc8yUxKHI
	R7dMICzd8Cg0ijCXgBHufIHJuDVWdwLDUZWRCIoEw/kzibBUhicpMDKwhJccQBX+JSZJfihWG5m
	pNBkdshReIn/8dGsDKIIOv1ADlZ14aGLVnEj1/P31EiFQz/rDHudeDaAofLABOy9UyJA=
X-Gm-Gg: ASbGncvyhGMW9lJhj5lMn3NFg8X16CYyh1ghf+SxHbTxUpZswx4mMIp2NDPDJA9tnH/
	PkUQ2yhvr+ShbHCOdvWXVm79wZNae3HdLaHp2fAqSQW/kz4GZT1O37biccH9bkmZDvrVLhwitjr
	P88hZFxvpCEc7VtpIPrmeln79AYzX3+usem9ZCvFQV+nxTot1qWWLKyoH8gsamc27AG3IFC8k+e
	Eab/DaiJ/HtdcaQxfl6DXPbquVtg99n/+K8/8sejFbJPBJd3YPMuUbzxfl9NLQ/HMeb2Ua55LBN
	YHj+QRwSOUGQ7eCsaRWasCIs9dehGbU8J0yy4W6hgRo9JXfghBag9BoCenP2gP6BZNcN8CiNR+c
	NoPO6X7u/PPhrYlXJQ0Uj
X-Received: by 2002:a05:6a20:244f:b0:230:3710:9aa9 with SMTP id adf61e73a8af0-24340bce30emr25026146637.4.1756268457889;
        Tue, 26 Aug 2025 21:20:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdCRcL4yrE9XGANFjJJjHieROHuyk+4KHF1iEmPx2C2KpvsxbNZ36c7SUdVsYPPF6S/m2zyw==
X-Received: by 2002:a05:6a20:244f:b0:230:3710:9aa9 with SMTP id adf61e73a8af0-24340bce30emr25026121637.4.1756268457424;
        Tue, 26 Aug 2025 21:20:57 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771f4072ac4sm4323076b3a.34.2025.08.26.21.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 21:20:57 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 3/3] coresight: tpda: add sysfs node to flush specific port
Date: Wed, 27 Aug 2025 12:20:42 +0800
Message-Id: <20250827042042.6786-4-jie.gan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827042042.6786-1-jie.gan@oss.qualcomm.com>
References: <20250827042042.6786-1-jie.gan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNCBTYWx0ZWRfXx0P4ImRJEnHN
 nzKpL8U83xC/K82/iAC7ddhS+hTteRk0Y1g/0mbzbrPmaxNkouPxW/MtVtdS/Kew19QTMV6Lm9R
 ttMhVjkVV1zkrGhum1skmGj+OrR2Y1jg/2aZ/VNiXzNS9Q/gzsOvOksizuXtqCMqqUYDye6ohZz
 2AkGRzi+DNbqC9EcjYLzkegMZ8/TCBgSE6OhRN2M8QgMCyW8xMNPH66+ZRGKLs+FCE5UGFBLD7Z
 gV7Mec/jBPI8Fp3bqB4x3dKjq7eW39f9z6/3/WJMUQWWdzrIdgynIVqmUsXttJWG0+8Z5ePfQbb
 1S2RIRAin76eTgOrnMxLorEEaA0cCOKioQz57BzUmrN5wiqtp1GYItPEaD2KxJFDRrh7klT1Z0i
 MqCgOPLX
X-Proofpoint-GUID: Ac0iCg-0YYQO7uApZoeasRAri5ls8ndX
X-Authority-Analysis: v=2.4 cv=K+AiHzWI c=1 sm=1 tr=0 ts=68ae87ab cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=l6kBNUb3cY0M__Xq7_0A:9
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: Ac0iCg-0YYQO7uApZoeasRAri5ls8ndX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230034

From: Tao Zhang <tao.zhang@oss.qualcomm.com>

Setting bit i in the TPDA_FLUSH_CR register initiates a flush request
for port i, forcing the data to synchronize and be transmitted to the
sink device.

Signed-off-by: Tao Zhang <tao.zhang@oss.qualcomm.com>
Co-developed-by: Jie Gan <jie.gan@oss.qualcomm.com>
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 .../testing/sysfs-bus-coresight-devices-tpda  |  7 ++++
 drivers/hwtracing/coresight/coresight-tpda.c  | 42 +++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tpda.h  |  2 +
 3 files changed, 51 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda
index fb651aebeb31..2cf2dcfc13c8 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda
@@ -41,3 +41,10 @@ Contact:	Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Tao Zhang <tao.zhang@oss.qu
 Description:
 		(RW) Configure the CMB/MCMB channel mode for all enabled ports.
 		Value 0 means raw channel mapping mode. Value 1 means channel pair marking mode.
+
+What:		/sys/bus/coresight/devices/<tpda-name>/port_flush_req
+Date:		August 2025
+KernelVersion:	6.17
+Contact:	Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Tao Zhang <tao.zhang@oss.qualcomm.com>, Jie Gan <jie.gan@oss.qualcomm.com>
+Description:
+		(RW) Configure the bit i to requests a flush operation of port i on the TPDA.
diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
index 430f76c559f2..8b1fe128881d 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.c
+++ b/drivers/hwtracing/coresight/coresight-tpda.c
@@ -487,6 +487,47 @@ static ssize_t cmbchan_mode_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(cmbchan_mode);
 
+static ssize_t port_flush_req_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (!drvdata->csdev->refcnt)
+		return -EINVAL;
+
+	guard(spinlock)(&drvdata->spinlock);
+	CS_UNLOCK(drvdata->base);
+	val = readl_relaxed(drvdata->base + TPDA_FLUSH_CR);
+	CS_LOCK(drvdata->base);
+	return sysfs_emit(buf, "%lx\n", val);
+}
+
+static ssize_t port_flush_req_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf,
+				    size_t size)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 0, &val))
+		return -EINVAL;
+
+	if (!drvdata->csdev->refcnt || !val)
+		return -EINVAL;
+
+	val |= FIELD_PREP(TPDA_MAX_INPORTS_MASK, val);
+	guard(spinlock)(&drvdata->spinlock);
+	CS_UNLOCK(drvdata->base);
+	writel_relaxed(val, drvdata->base + TPDA_FLUSH_CR);
+	CS_LOCK(drvdata->base);
+
+	return size;
+}
+static DEVICE_ATTR_RW(port_flush_req);
+
 static struct attribute *tpda_attrs[] = {
 	&dev_attr_trig_async_enable.attr,
 	&dev_attr_trig_flag_ts_enable.attr,
@@ -494,6 +535,7 @@ static struct attribute *tpda_attrs[] = {
 	&dev_attr_freq_ts_enable.attr,
 	&dev_attr_global_flush_req.attr,
 	&dev_attr_cmbchan_mode.attr,
+	&dev_attr_port_flush_req.attr,
 	NULL,
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-tpda.h b/drivers/hwtracing/coresight/coresight-tpda.h
index 8e1b66115ad1..56d3ad293e46 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.h
+++ b/drivers/hwtracing/coresight/coresight-tpda.h
@@ -10,6 +10,7 @@
 #define TPDA_Pn_CR(n)		(0x004 + (n * 4))
 #define TPDA_FPID_CR		(0x084)
 #define TPDA_SYNCR		(0x08C)
+#define TPDA_FLUSH_CR		(0x090)
 
 /* Cross trigger FREQ packets timestamp bit */
 #define TPDA_CR_FREQTS		BIT(2)
@@ -35,6 +36,7 @@
 #define TPDA_SYNCR_MAX_COUNTER_VAL	(0xFFF)
 
 #define TPDA_MAX_INPORTS	32
+#define TPDA_MAX_INPORTS_MASK	GENMASK(31, 0)
 
 /* Bits 6 ~ 12 is for atid value */
 #define TPDA_CR_ATID		GENMASK(12, 6)
-- 
2.34.1


