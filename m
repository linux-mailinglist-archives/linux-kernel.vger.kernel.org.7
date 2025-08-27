Return-Path: <linux-kernel+bounces-788149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 165B5B38067
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D47698037C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463EB34F465;
	Wed, 27 Aug 2025 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QDPzOQ8S"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AB134F48C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756292165; cv=none; b=Wv73LtrZG076FTysFniUTP/js1KcMhKCzJC9UecwG5p3gQ8qVgrXpiCeGzJ+GeKWdwx5zYT1qiJznr4x65uKD/rfAGvsSuvDB6dgJkFUxJ1PVEgrcfrTWLMbTfnMPmtnkOfpGSlG/QnTh6B+dp0WTd6DJF9GCimq9IKsNwu/zZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756292165; c=relaxed/simple;
	bh=RHUVtvl2N2hTcYc4uv0VBvz2bqswq9gFM3vRic01nmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qatFQUHxmbbIbbOJmhUo3kI7+XQ7XxVMbzjL6D7gDfN3NUCbEEW53Uj94FmERXT6KfKzhWbMsM7upzr2LxwLdYVYsGIkY73nZUyBacPrfRiuvdxx3wBHronXoRz8tzmMYywS9iT3KC4ozRxm73e7X+L602igANX656gZDD+9bjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QDPzOQ8S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R6kC2n008130
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:56:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=g7hLmo2qiXQ
	EzJFCc6UYcx4UE905+BBd64HJXeuLne8=; b=QDPzOQ8STAnHmoQU03fFs+srCfh
	COlQt6Z8xqJ9t0Pmtw1zKsrs3VaxRg6by4f3B1G1555vpL8KRMqmfUmeqEm8OMkb
	T6E4j4pZO2wbiPMlYuWO0DrgqzTr171bMjTIdWkXcgAekWmUI5vaADnEYm5+e/tr
	a5X+Ufe7+h4uCSxynPNbWA4egj0bR1izJfKLBx5zo+r5fQ6OIf92bZ2dCtVue8KN
	jJnC8q/lpC15llGGkuSPJ1phtUssCS95wFz+ajjG1kjusnJdi2LVmTFNQoqRaZRz
	IY3L5D8/6dhB8Ihx76JrasRzQqs/w5RKTdMwnBsotCi9EvSuJfQkHTefJug==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48sh8ajm5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:56:01 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3276af4de80so1245002a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 03:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756292161; x=1756896961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7hLmo2qiXQEzJFCc6UYcx4UE905+BBd64HJXeuLne8=;
        b=LeXuqytDMJBF6lRaHtqvJUeGYqNeS70AC1v8v59RhXSNZKi0fqDmh8PbfRD6mkUGHI
         PyO5/5Yi0Eb4cb3x7gQ+olDqw5u3Wyh5U6q1zFu2V9JtSeQDCCz7sfIPfY0C0YQYo5b0
         Y0mbRHnRkAFwZUMK7x+MI/1j38GgP3v39K/7bI49SDTZrYcEcSgpKG00No04/lJ/sP64
         fpQ+HFKQ00H+hx73u2YexJOMEMsvC1Sn/CuLDCIr7MYoyow+wbePtGPjZ/eiajxqiuxI
         Xqf0sNd2iSI8RuhfgVySYOBqAYu3P0dE6vreHiLUAuAnUUQ5sHijtKHJLyPlFIUw6y1i
         VFDw==
X-Forwarded-Encrypted: i=1; AJvYcCUap/EXk/6nDISLkXrtuy1VvZP5AXWS/XhamaANZI0sJmOYnXNXtbsOhVFMokXM0DN3d4ctPLAphjy46og=@vger.kernel.org
X-Gm-Message-State: AOJu0YxklNpBIu7bbZqLwyeuL65ZpQwMBbay8rmbdHgwJ6FKmzwaBCpC
	ryUl8X0sCGrIQSnkwDCuE9eEhf2Ug5f1FSG56UWFkD120zJ4wKBfUPi4p21oPwtZEPaDCqXJOfs
	KKSFqnymTtSBUBfl/8yrh1imqVn+RwUI/g/Oa7GlMOJHj183WdHD9pp7EIRbV7Sv0lhQ=
X-Gm-Gg: ASbGncsMvLgNsN92947WEZYyhNYa/Heyw4YRPph4YjlrTTq+Gj6Px1skN/nVvjX19EA
	2FlqU9bSHkWghw0yNuKZYiJndHbgkMfUdSduznCseO0ONBZhSZuD18c5Z9cQicS2SYr6LPJGS9m
	PMmFvIhgH70y8HYhc0hJgeX9cdjnOdK3urnFE4jzT66pGi2X9wY3QKXYOo7j54wzLrAzefkKBsU
	/6i+QP/PeJfZt4SuJrPuYLYSX9xGLArNnv8l9tmdkw6faxQjSvmEAqM3XzfRkm/suK2PINLXsnE
	GWDL4RByHhJ4e+oNL9M8Wpe0R+h5DPbXmRUbExT89pzilh/Fg1dcz21NtWMVhOyaul/lpKnhf/U
	6tDKze875KZ8y54c2pDmB
X-Received: by 2002:a17:90b:528d:b0:321:cfbf:cbd6 with SMTP id 98e67ed59e1d1-32515e3cba6mr25542447a91.6.1756292160751;
        Wed, 27 Aug 2025 03:56:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwG5WKh/9Jju6a954+EE3Y3ki8sM2PuzrKsD/hmGK39N6A3Kp8fKVEhHRvsLYEuBcOG1Or/g==
X-Received: by 2002:a17:90b:528d:b0:321:cfbf:cbd6 with SMTP id 98e67ed59e1d1-32515e3cba6mr25542421a91.6.1756292160259;
        Wed, 27 Aug 2025 03:56:00 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771f2f2ac7dsm5573035b3a.43.2025.08.27.03.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 03:55:59 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 3/3] coresight: tpda: add sysfs node to flush specific port
Date: Wed, 27 Aug 2025 18:55:45 +0800
Message-Id: <20250827105545.7140-4-jie.gan@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=cLDgskeN c=1 sm=1 tr=0 ts=68aee441 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=tK8iAimETgkDkOB5pRoA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDE1MyBTYWx0ZWRfXyYl8e5Nmv5rb
 y8UVSSZ32TnZT9plmB4Y8A+IO1MlA2QX907mmS7MFF3fDf9Dau3pJBJY/1HJp10u4Pg535npLm4
 NOsaSaeZvvecwIaNRXArWFgupruC5BRsta9SCjGMdWRRyA974NV54fqcRbfqCcnb0+iGc0kaG4B
 E2rKn1eIu+LKI5ArnCj4BgmSS/4OkeVg3PuywYwsuxOesIWZwuB6rT5APyOzhwKAyoK6NJRA8Ey
 QkJBLXxKjbvB58sHweojL7+oCQ87wGWmrjqTEpwzMv2/4YBUP4MvBkexxXmGDQZrki3c/5v1V/i
 qjrNJN2qu05jRxSgXZ1rFhxIz40ztie0SM7erXhwgiT5tui7C9pFFqpytMD9WO2H9dwjsoE0me9
 Z4zwcCwv
X-Proofpoint-GUID: lExViJt-tsHUNMzZP1GbZ-nFr4f4nGOv
X-Proofpoint-ORIG-GUID: lExViJt-tsHUNMzZP1GbZ-nFr4f4nGOv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508260153

From: Tao Zhang <tao.zhang@oss.qualcomm.com>

Setting bit i in the TPDA_FLUSH_CR register initiates a flush request
for port i, forcing the data to synchronize and be transmitted to the
sink device.

Signed-off-by: Tao Zhang <tao.zhang@oss.qualcomm.com>
Co-developed-by: Jie Gan <jie.gan@oss.qualcomm.com>
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 .../testing/sysfs-bus-coresight-devices-tpda  |  7 ++++
 drivers/hwtracing/coresight/coresight-tpda.c  | 41 +++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tpda.h  |  1 +
 3 files changed, 49 insertions(+)

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
index a1393962b04d..e9e2736071fb 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.c
+++ b/drivers/hwtracing/coresight/coresight-tpda.c
@@ -490,6 +490,46 @@ static ssize_t cmbchan_mode_store(struct device *dev,
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
+	return sysfs_emit(buf, "0x%lx\n", val);
+}
+
+static ssize_t port_flush_req_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf,
+				    size_t size)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	u32 val;
+
+	if (kstrtou32(buf, 0, &val))
+		return -EINVAL;
+
+	if (!drvdata->csdev->refcnt || !val)
+		return -EINVAL;
+
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
@@ -497,6 +537,7 @@ static struct attribute *tpda_attrs[] = {
 	&dev_attr_freq_ts_enable.attr,
 	&dev_attr_global_flush_req.attr,
 	&dev_attr_cmbchan_mode.attr,
+	&dev_attr_port_flush_req.attr,
 	NULL,
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-tpda.h b/drivers/hwtracing/coresight/coresight-tpda.h
index 0c9bf2fade56..284ac63699ad 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.h
+++ b/drivers/hwtracing/coresight/coresight-tpda.h
@@ -10,6 +10,7 @@
 #define TPDA_Pn_CR(n)		(0x004 + (n * 4))
 #define TPDA_FPID_CR		(0x084)
 #define TPDA_SYNCR		(0x08C)
+#define TPDA_FLUSH_CR		(0x090)
 
 /* Cross trigger FREQ packets timestamp bit */
 #define TPDA_CR_FREQTS		BIT(2)
-- 
2.34.1


