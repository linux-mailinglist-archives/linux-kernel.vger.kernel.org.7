Return-Path: <linux-kernel+bounces-788147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D7AB38062
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3BA16287A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437C834F461;
	Wed, 27 Aug 2025 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pdc9mhhc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423A134DCD7
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756292158; cv=none; b=f6tUmhA9jtpz9e4KALLXP2q8SXO7h/kWTQMJt1648mdta7DGI8b63sKdBfkO1h3y6uGq3j1ZmKt2OEigs4y307YeFfWtw9jbUjxEcQAtGzO1+ONG8SZazmd84JEnMmkI/SYW2BD2EUrVXbFWYJOIRa1uRu/j3SWdjW8RUK7hvXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756292158; c=relaxed/simple;
	bh=rQ96BiidjdZVuBuCVbJxZGaP06pW4XgFOoystzoRyOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C2yGxWKwYpsxT75RgIFP8v5O3t8qi88K1urJjm/68zw6UOYoHwuNTo66UX7U9Io11mteJzITmJR+4TCCM+YQpeGUivRUxarHiBaVwrTPFhxdKEG83qeWw5FsFktjUKqOKqkb3E6hZipMbOXzjU0Nqqo7DWdmlFwXRjQOATaJjNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pdc9mhhc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R6kCr4027275
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=bGRCpbWuoAe
	XmlM4HsvMzttpVGFxmROnmfvnhtF/ofc=; b=Pdc9mhhc+g4ivIAx4v6EF8zsslv
	JNn/tXx/+Sk9x1sSVrDxlf+lyCJVlOTRVLb92CEmZAzlOWS2SVgdwSKlVX4aDtf2
	Xvqx2nVW4CqN+e2Wj6/CWICsEpLSvIKcs+QCidMofcBq/P8LA9u5oRYR+2Njs2Fz
	DfCLZQgJe4T6dUVdAaPHP3WRiqY0DU4VlYcL0DjJCYmz7pTdXs16TMgfYU6sC/Hv
	rCswUowmKqdih/9GofNk5aJZrf3VSN62bIopzY36FX4DnctjlK0BrKjgK4QJ9/z/
	XUptk6V9YWhMTeEqx0o88aY0JPx1gTjvJzZcbWnNH2K2dAh63dPcacrsB/w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48se16udet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:55:55 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32326e72dfbso9721862a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 03:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756292154; x=1756896954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bGRCpbWuoAeXmlM4HsvMzttpVGFxmROnmfvnhtF/ofc=;
        b=Pe9TAdeFc2ryAvegHjXzL2A6GBlMAoSXhKb24oDcnH0uCSVb15JWwQHnWE0zABk496
         VOp6scJ7mDIe2y55h5HlATdI+bpn5KG1wRhGxUnkyqupf3fY6oSt9069zqIFDaPbekGQ
         StNTJbcEsBzs7RGxpy8JHvV1iPAUzRoiy1vXGi35t+5kUwO3Mi5zt/EVNwJ1U9u6uu04
         8aNkH5856pnZPenejZHyW/WMH7QIXF0YVeeg7iU7EkgniXoZX75o+dD3F8MvykDmxUHa
         Jk3zUgDVKkCqTsjA+j2JAajNEGJ5P2aExYLn/6xykY/J0uIREEGFyBU7+m0WwpBm1ct3
         GpEA==
X-Forwarded-Encrypted: i=1; AJvYcCWiYZwD0p0VSvphGnUJ7o7ufl2YpJFjFpcJp2LwRQ9DmWMy1AtcBWeAAtPGRxbCrgzeHxXw/OVWuof5UvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWkoT5gJuC40GqlZ4SLIi1VRF9f9tmlRXMTqXpakOHi9TFp+wK
	VVmdAUybOMqqsPQsvkIddrU6thqCLt2kRlfhmsRiASdjziktiTxhRO+BIswXmT1CTx4XtMhnAwy
	nDxg0yfyQBTeKgmrUYyyqjQ4HJu7sLVy9iF6fD45CPTci0DejcJYyon6sN3CfAxPhqcc=
X-Gm-Gg: ASbGncu0jQCWAZjOcgo8SvCuHMKvVKXcv7py0y0wF+AzkxyxUxG4fJqnyeQDUl/Y8HT
	PQq4NokDyeUjP8jt/t+Q6o7+svZV3V1eXGMXzJPvLZkq8eJmduNBlM1Xn8876EAWpp+qc0CXCvg
	8s99oHKnN4C65pTQws+vJZu/F2wrAJD1OHQAwmBPxUXMKSwy+XLYUumAjk3Yhb42J93htbSid+R
	QbTXSyl8Z3o2KOUPHsQ5xew2NrKmuTTohtFs5nzO62BqEDW9poLuC03AEXm5EZ0qaGCiwZBS1W9
	z10OkRxOfcZ2RBA4cvxodosQEBxHxFVCMmpiqAlxXFFreYNrKW87O2dRInTJbxUL0Ns7ThLU0sv
	92CEB8L7rE2QqeUADHDIF
X-Received: by 2002:a17:90b:38c3:b0:321:2b8a:4304 with SMTP id 98e67ed59e1d1-32515ef77admr24278197a91.10.1756292154209;
        Wed, 27 Aug 2025 03:55:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwNMyZcrQVPEWGkwnWvs7YNOYO9VEeBd6cV+tfHxFoasx2pAFKCLu2F1SMsovpNElVALzM/w==
X-Received: by 2002:a17:90b:38c3:b0:321:2b8a:4304 with SMTP id 98e67ed59e1d1-32515ef77admr24278165a91.10.1756292153622;
        Wed, 27 Aug 2025 03:55:53 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771f2f2ac7dsm5573035b3a.43.2025.08.27.03.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 03:55:53 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 1/3] coresight: tpda: add sysfs nodes for tpda cross-trigger configuration
Date: Wed, 27 Aug 2025 18:55:43 +0800
Message-Id: <20250827105545.7140-2-jie.gan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827105545.7140-1-jie.gan@oss.qualcomm.com>
References: <20250827105545.7140-1-jie.gan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: S-lbfBPVNZY5-z6BhgjKG16sC6wmGyKx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDEyMCBTYWx0ZWRfX6V4mv7ttGfaU
 EY6oTowl2JT3eTVuirZGbAGj0vB+7/NV5MHQvYcxI0H7uNuk8QSYkPDZCN/DzFZv02fuyOpaiMy
 aE6JsuRjCzDyQSgiLsZ7Xrb3EfRGANQUHCRZmCisHSSWO3ythppaxg1dE+3jSf6aLMRfEwOs/l3
 PmqzKORuXUvqFc891QB2HhC9rsQ1JLyI64DGOFGZ6BXPf0Y2DUjKcSid90YevqfS1jDuXQsXb9h
 oDbraVx9tu/xMZJMmtiPqCCHjFv5I8UXIDk+LXr9xuuyy3KxcRa4wZouMlnaIQZ7FatjRAC2T+c
 DRi82aEhoMh15qZYy8ye//3i68g8HpxtVMq8d94jcI3ttCr3/M9FQTINi0S3/5lY5yis7w82e3e
 MAk43WEk
X-Proofpoint-ORIG-GUID: S-lbfBPVNZY5-z6BhgjKG16sC6wmGyKx
X-Authority-Analysis: v=2.4 cv=CNYqXQrD c=1 sm=1 tr=0 ts=68aee43b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=Hl4cRc3ft4hpfJdQRooA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0
 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508260120

From: Tao Zhang <tao.zhang@oss.qualcomm.com>

Introduce sysfs nodes to configure cross-trigger parameters for TPDA.
These registers define the characteristics of cross-trigger packets,
including generation frequency and flag values.

Signed-off-by: Tao Zhang <tao.zhang@oss.qualcomm.com>
Co-developed-by: Jie Gan <jie.gan@oss.qualcomm.com>
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 .../testing/sysfs-bus-coresight-devices-tpda  |  43 ++++
 drivers/hwtracing/coresight/coresight-tpda.c  | 230 ++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tpda.h  |  27 +-
 3 files changed, 299 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda
new file mode 100644
index 000000000000..fb651aebeb31
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda
@@ -0,0 +1,43 @@
+What:		/sys/bus/coresight/devices/<tpda-name>/trig_async_enable
+Date:		August 2025
+KernelVersion:	6.17
+Contact:	Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Tao Zhang <tao.zhang@oss.qualcomm.com>, Jie Gan <jie.gan@oss.qualcomm.com>
+Description:
+		(RW) Enable/disable cross trigger synchronization sequence interface.
+
+What:		/sys/bus/coresight/devices/<tpda-name>/trig_flag_ts_enable
+Date:		August 2025
+KernelVersion:	6.17
+Contact:	Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Tao Zhang <tao.zhang@oss.qualcomm.com>, Jie Gan <jie.gan@oss.qualcomm.com>
+Description:
+		(RW) Enable/disable cross trigger FLAG packet request interface.
+
+What:		/sys/bus/coresight/devices/<tpda-name>/trig_freq_enable
+Date:		August 2025
+KernelVersion:	6.17
+Contact:	Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Tao Zhang <tao.zhang@oss.qualcomm.com>, Jie Gan <jie.gan@oss.qualcomm.com>
+Description:
+		(RW) Enable/disable cross trigger FREQ packet request interface.
+
+What:		/sys/bus/coresight/devices/<tpda-name>/freq_ts_enable
+Date:		August 2025
+KernelVersion:	6.17
+Contact:	Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Tao Zhang <tao.zhang@oss.qualcomm.com>, Jie Gan <jie.gan@oss.qualcomm.com>
+Description:
+		(RW) Enable/disable the timestamp for all FREQ packets.
+
+What:		/sys/bus/coresight/devices/<tpda-name>/global_flush_req
+Date:		August 2025
+KernelVersion:	6.17
+Contact:	Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Tao Zhang <tao.zhang@oss.qualcomm.com>, Jie Gan <jie.gan@oss.qualcomm.com>
+Description:
+		(RW) Set global (all ports) flush request bit. The bit remains set until a
+		global flush request sequence completes.
+
+What:		/sys/bus/coresight/devices/<tpda-name>/cmbchan_mode
+Date:		August 2025
+KernelVersion:	6.17
+Contact:	Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Tao Zhang <tao.zhang@oss.qualcomm.com>, Jie Gan <jie.gan@oss.qualcomm.com>
+Description:
+		(RW) Configure the CMB/MCMB channel mode for all enabled ports.
+		Value 0 means raw channel mapping mode. Value 1 means channel pair marking mode.
diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
index 4e93fa5bace4..d4d1def5ec15 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.c
+++ b/drivers/hwtracing/coresight/coresight-tpda.c
@@ -156,9 +156,37 @@ static void tpda_enable_pre_port(struct tpda_drvdata *drvdata)
 	u32 val;
 
 	val = readl_relaxed(drvdata->base + TPDA_CR);
+	val &= ~TPDA_CR_MID;
 	val &= ~TPDA_CR_ATID;
 	val |= FIELD_PREP(TPDA_CR_ATID, drvdata->atid);
+	if (drvdata->trig_async)
+		val |= TPDA_CR_SRIE;
+	else
+		val &= ~TPDA_CR_SRIE;
+	if (drvdata->trig_flag_ts)
+		val |= TPDA_CR_FLRIE;
+	else
+		val &= ~TPDA_CR_FLRIE;
+	if (drvdata->trig_freq)
+		val |= TPDA_CR_FRIE;
+	else
+		val &= ~TPDA_CR_FRIE;
+	if (drvdata->freq_ts)
+		val |= TPDA_CR_FREQTS;
+	else
+		val &= ~TPDA_CR_FREQTS;
+	if (drvdata->cmbchan_mode)
+		val |= TPDA_CR_CMBCHANMODE;
+	else
+		val &= ~TPDA_CR_CMBCHANMODE;
 	writel_relaxed(val, drvdata->base + TPDA_CR);
+
+	/*
+	 * If FLRIE bit is set, set the master and channel
+	 * id as zero
+	 */
+	if (drvdata->trig_flag_ts)
+		writel_relaxed(0x0, drvdata->base + TPDA_FPID_CR);
 }
 
 static int tpda_enable_port(struct tpda_drvdata *drvdata, int port)
@@ -274,6 +302,206 @@ static const struct coresight_ops tpda_cs_ops = {
 	.link_ops	= &tpda_link_ops,
 };
 
+static ssize_t trig_async_enable_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return sysfs_emit(buf, "%u\n", (unsigned int)drvdata->trig_async);
+}
+
+static ssize_t trig_async_enable_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf,
+				       size_t size)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 0, &val))
+		return -EINVAL;
+
+	guard(spinlock)(&drvdata->spinlock);
+	drvdata->trig_async = !!val;
+
+	return size;
+}
+static DEVICE_ATTR_RW(trig_async_enable);
+
+static ssize_t trig_flag_ts_enable_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return sysfs_emit(buf, "%u\n", (unsigned int)drvdata->trig_flag_ts);
+}
+
+static ssize_t trig_flag_ts_enable_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf,
+					 size_t size)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 0, &val))
+		return -EINVAL;
+
+	guard(spinlock)(&drvdata->spinlock);
+	drvdata->trig_flag_ts = !!val;
+
+	return size;
+}
+static DEVICE_ATTR_RW(trig_flag_ts_enable);
+
+static ssize_t trig_freq_enable_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return sysfs_emit(buf, "%u\n", (unsigned int)drvdata->trig_freq);
+}
+
+static ssize_t trig_freq_enable_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf,
+				      size_t size)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 0, &val))
+		return -EINVAL;
+
+	guard(spinlock)(&drvdata->spinlock);
+	drvdata->trig_freq = !!val;
+
+	return size;
+}
+static DEVICE_ATTR_RW(trig_freq_enable);
+
+static ssize_t freq_ts_enable_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return sysfs_emit(buf, "%u\n", (unsigned int)drvdata->freq_ts);
+}
+
+static ssize_t freq_ts_enable_store(struct device *dev,
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
+	guard(spinlock)(&drvdata->spinlock);
+	drvdata->freq_ts = !!val;
+
+	return size;
+}
+static DEVICE_ATTR_RW(freq_ts_enable);
+
+static ssize_t global_flush_req_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (!drvdata->csdev->refcnt)
+		return -EINVAL;
+
+	guard(spinlock)(&drvdata->spinlock);
+	CS_UNLOCK(drvdata->base);
+	val = readl_relaxed(drvdata->base + TPDA_CR);
+	CS_LOCK(drvdata->base);
+	/* Only read value for bit 0 */
+	val &= BIT(0);
+
+	return sysfs_emit(buf, "%lu\n", val);
+}
+
+static ssize_t global_flush_req_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf,
+				      size_t size)
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
+	guard(spinlock)(&drvdata->spinlock);
+	CS_UNLOCK(drvdata->base);
+	val = readl_relaxed(drvdata->base + TPDA_CR);
+	/* Only set bit 0 */
+	val |= BIT(0);
+	writel_relaxed(val, drvdata->base + TPDA_CR);
+	CS_LOCK(drvdata->base);
+
+	return size;
+}
+static DEVICE_ATTR_RW(global_flush_req);
+
+static ssize_t cmbchan_mode_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return sysfs_emit(buf, "%u\n", (unsigned int)drvdata->cmbchan_mode);
+}
+
+static ssize_t cmbchan_mode_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf,
+				  size_t size)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 0, &val))
+		return -EINVAL;
+
+	guard(spinlock)(&drvdata->spinlock);
+	drvdata->cmbchan_mode = !!val;
+
+	return size;
+}
+static DEVICE_ATTR_RW(cmbchan_mode);
+
+static struct attribute *tpda_attrs[] = {
+	&dev_attr_trig_async_enable.attr,
+	&dev_attr_trig_flag_ts_enable.attr,
+	&dev_attr_trig_freq_enable.attr,
+	&dev_attr_freq_ts_enable.attr,
+	&dev_attr_global_flush_req.attr,
+	&dev_attr_cmbchan_mode.attr,
+	NULL,
+};
+
+static struct attribute_group tpda_attr_grp = {
+	.attrs = tpda_attrs,
+};
+
+static const struct attribute_group *tpda_attr_grps[] = {
+	&tpda_attr_grp,
+	NULL,
+};
+
 static int tpda_init_default_data(struct tpda_drvdata *drvdata)
 {
 	int atid;
@@ -289,6 +517,7 @@ static int tpda_init_default_data(struct tpda_drvdata *drvdata)
 		return atid;
 
 	drvdata->atid = atid;
+	drvdata->freq_ts = true;
 	return 0;
 }
 
@@ -332,6 +561,7 @@ static int tpda_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.ops = &tpda_cs_ops;
 	desc.pdata = adev->dev.platform_data;
 	desc.dev = &adev->dev;
+	desc.groups = tpda_attr_grps;
 	desc.access = CSDEV_ACCESS_IOMEM(base);
 	drvdata->csdev = coresight_register(&desc);
 	if (IS_ERR(drvdata->csdev))
diff --git a/drivers/hwtracing/coresight/coresight-tpda.h b/drivers/hwtracing/coresight/coresight-tpda.h
index c6af3d2da3ef..0be625fb52fd 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.h
+++ b/drivers/hwtracing/coresight/coresight-tpda.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2023,2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef _CORESIGHT_CORESIGHT_TPDA_H
@@ -8,6 +8,19 @@
 
 #define TPDA_CR			(0x000)
 #define TPDA_Pn_CR(n)		(0x004 + (n * 4))
+#define TPDA_FPID_CR		(0x084)
+
+/* Cross trigger FREQ packets timestamp bit */
+#define TPDA_CR_FREQTS		BIT(2)
+/* Cross trigger FREQ packet request bit */
+#define TPDA_CR_FRIE		BIT(3)
+/* Cross trigger FLAG packet request interface bit */
+#define TPDA_CR_FLRIE		BIT(4)
+/* Cross trigger synchronization bit */
+#define TPDA_CR_SRIE		BIT(5)
+/* Packetize CMB/MCMB traffic bit */
+#define TPDA_CR_CMBCHANMODE	BIT(20)
+
 /* Aggregator port enable bit */
 #define TPDA_Pn_CR_ENA		BIT(0)
 /* Aggregator port CMB data set element size bit */
@@ -19,6 +32,8 @@
 
 /* Bits 6 ~ 12 is for atid value */
 #define TPDA_CR_ATID		GENMASK(12, 6)
+/* Bits 13 ~ 19 is for mid value */
+#define TPDA_CR_MID		GENMASK(19, 13)
 
 /**
  * struct tpda_drvdata - specifics associated to an TPDA component
@@ -29,6 +44,11 @@
  * @enable:     enable status of the component.
  * @dsb_esize   Record the DSB element size.
  * @cmb_esize   Record the CMB element size.
+ * @trig_async:	Enable/disable cross trigger synchronization sequence interface.
+ * @trig_flag_ts: Enable/disable cross trigger FLAG packet request interface.
+ * @trig_freq:	Enable/disable cross trigger FREQ packet request interface.
+ * @freq_ts:	Enable/disable the timestamp for all FREQ packets.
+ * @cmbchan_mode: Configure the CMB/MCMB channel mode.
  */
 struct tpda_drvdata {
 	void __iomem		*base;
@@ -38,6 +58,11 @@ struct tpda_drvdata {
 	u8			atid;
 	u32			dsb_esize;
 	u32			cmb_esize;
+	bool			trig_async;
+	bool			trig_flag_ts;
+	bool			trig_freq;
+	bool			freq_ts;
+	bool			cmbchan_mode;
 };
 
 #endif  /* _CORESIGHT_CORESIGHT_TPDA_H */
-- 
2.34.1


