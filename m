Return-Path: <linux-kernel+bounces-786097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 951C7B354FA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E11A1B62A2B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9148C2F6170;
	Tue, 26 Aug 2025 07:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M+Wk6QH2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2C52F6591
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756191730; cv=none; b=Azc3RKm5T+2cklyhw+71shY3/IoJdT+qtROaT7vAtkO3jj4PJanePBx4r2C7wVv/Fo9y7fGJqFZdB4f0Ce4laNpwYT7kCfWLb/3Ga0dHYhOUUYOcBP/hHBtxFI61xmjTmhbEUpmRBqAZ/2sPiKK0UBOHPjM0Znkeyos6j5SpssY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756191730; c=relaxed/simple;
	bh=LFM/BpfDv7KoqVFQiQm8FDdXWbIYBapsw4EuLf8hqW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nSANjFbYZu9xBB3DXs2L/4umtUXI9QGAgQYkuQAeW9qYbUgSzaGjWczOSeRwUr/GLOhvDfTM+6J+n/IXsgZznYW3TACcZllwM+xCFGIitU75N8xSShK229LyLCaVIFbzkDyc1gVTHgAfk0oJQLBol4b6pDujm7jWg2GXn4jKcKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M+Wk6QH2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q37Wjo012652
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=+mTRaR+aWbF
	TUCZaXg5d7I+myL8Z4TCVvhpp1WowyOY=; b=M+Wk6QH2pFHpmpFO3m7YFOnTSSQ
	z9kmxagD4cTb0/hcg5psKXBwiRBx6DnVBH6modHXpsNB5vhOIjqADxeTRke5hD/P
	vSoIXL7u2yoQECu0Y81kF/ELox6dafPQsscWpwf9TiaigYWkPUtCW7djioIIlarY
	LFgXfi40eglJaWUZs8gNvLSCnurgdTf7EgKRxRyrz54rRMhPZqTaJ2Pi+C2lCCCA
	EHsPIpDgCKHbd5Zg36YdHhTRQeop399Cfz9iXSn2YG7x/KVpKA0G4vVBJJD4FAyJ
	EcZvLhRGI+VBLRVA8T61trAFZh2zKZQKMKFDEehXPEtAgJLcCF5BBOQbJiQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xpqxhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:02:08 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24636484391so42204345ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 00:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756191727; x=1756796527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mTRaR+aWbFTUCZaXg5d7I+myL8Z4TCVvhpp1WowyOY=;
        b=bIE3r3Guj+OHe+7Fc/pXu2Q4kLR5Vu905ILNXmLXqR+4uWdi9ZzxjtihsQ7UYunQT9
         cB8iwDZY9t/d8YbNVfZEeqL+pj9qPb8i8NS/xI6lCPDLfnocVV0yqSX8dYGySUSiQ35w
         WgGYphnbNJUGoO1CviLMCovPu+NtAX/1bga1lVmJ4LRZCY7RAl4azsEOKmDzkEMgWXGP
         /NMKaYaACg2X0IIPIvp2H7nPAVvULz1gD/AbwLmXEG/Xgh+PGIYrwwEPRz7wj+O2cYQF
         NQWZrVDhb+ogM8XjL8Vgt80XqwEgmhZvvAjREPZPQYiqlBxZn7b3YTriMRHNS5p3YehG
         Gw3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXURTVqv4Ev+Lk46pBh80tfx4E/CKk3vbMAbOq+/qwppxOgU/VqbJNL9ySLi4psyAbflfS4RViaygrMCd4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo8852Kilc0R2ruJ8Zzqc8Ze1sU0KIlNG+wUYv9QlzSvkNIXTR
	6LMpDDk4/6ZvauxI+e6tdrkCWltHwc5jJrS9qcHCtQuaitdnQQzOu7G1CHA+C0nT77ThmSHgkKG
	yUlV42TvZUH47GfV34VngiMaoPH1kamQp+uGbCaTeeosYpZqe6FNjQrJT62N6nTJJRTI=
X-Gm-Gg: ASbGncsimQ9rg1uKjKvhpLO/foueM9mOoCAJMvOCwu+mB3B2+8t8+O9NRPW2Fgcyui5
	4u+wXPGdQ1mvmgBV6U0jdhZkYrrTaiYRTN4sp4Ubq1B/Lgwkq4XMGImHMGGoDolNKoBDSgDcz4m
	ppnSLnIgIxIlOW0DnvXx/5HUiAjckQJwlylcfKb4mGCqYgdWLu/TIqP91zQOldBa77M31Hn4QSZ
	T0/r2ehpOmm4Fep2yoaLlez4UBqco55Qs7MM9QVetuGfopvku4aotshznht20UPpgO18XlPxKIe
	zOBlaa8B/9/Rqx6ldlklhJ77PA4NPrJ5HyMB+FnfV07XQ3Rtve1QZaHb0Nds+Clq3FExPyN/9Q6
	1VBvNZdQPv0VqhYhQBnk2
X-Received: by 2002:a17:903:244c:b0:246:b49e:d439 with SMTP id d9443c01a7336-246b49ef64emr93661705ad.38.1756191727162;
        Tue, 26 Aug 2025 00:02:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoRc8uc8vAUbrMEPeg17gEclVd7NzYl81uv0y0+g5JCi7ysOqsMZE8I6TUqXsU2PMBTgzBHQ==
X-Received: by 2002:a17:903:244c:b0:246:b49e:d439 with SMTP id d9443c01a7336-246b49ef64emr93661165ad.38.1756191726678;
        Tue, 26 Aug 2025 00:02:06 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770b5bed428sm5628582b3a.16.2025.08.26.00.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 00:02:06 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v1 3/3] coresight: tpda: add sysfs node to flush specific port
Date: Tue, 26 Aug 2025 15:01:50 +0800
Message-Id: <20250826070150.5603-4-jie.gan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826070150.5603-1-jie.gan@oss.qualcomm.com>
References: <20250826070150.5603-1-jie.gan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KOlaDEFo c=1 sm=1 tr=0 ts=68ad5bf0 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=UsKUHg3HdU6Ygep39SEA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: EfFwMngyCK64dvwk4NHRFBOQa0mYfFSd
X-Proofpoint-ORIG-GUID: EfFwMngyCK64dvwk4NHRFBOQa0mYfFSd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX5H3pGPovO3ci
 ljKg1pcgg5c2mgs2WZhbrO9wtkz35Ek/7KRJGa+K2xNySZL7LTz6wk+5ztM0paB9ym946Yfh/M1
 1RCxuqbzUQv0WsRBWDPwaWCvjvAC6SBv/5rik61wNu59b6kC1m1bH17rpZ/9ooee4hU70X+fNx3
 ipPaUmwqS6mMMFPSgl7mt8ZUkC5F+fLUJNSgRbMabwctBzh2GwGrN94Zxn1ceUkgXrJi5QHqiIK
 AI9hcrTS2YvIgkNOVMTN9wUnDNrtZU/y3DWONtxmk3fTzYgKSQP6l2i5QQ1jYIEYcjhdaIeDbWa
 rpJZY64OGe1SnJbwugM3rMM1mpj9ynyBPP8v78u+2aePMj4S7yPbzq4NT+T53udxqNgCjS5hS7O
 lBiOK+FI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

From: Tao Zhang <tao.zhang@oss.qualcomm.com>

Setting bit i in the TPDA_FLUSH_CR register initiates a flush request
for port i, forcing the data to synchronize and be transmitted to the
sink device.

Signed-off-by: Tao Zhang <tao.zhang@oss.qualcomm.com>
Co-developed-by: Jie Gan <jie.gan@oss.qualcomm.com>
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 .../testing/sysfs-bus-coresight-devices-tpda  |  7 +++
 drivers/hwtracing/coresight/coresight-tpda.c  | 45 +++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tpda.h  |  1 +
 3 files changed, 53 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda
index e827396a0fa1..8803158ba42f 100644
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
index 9e623732d1e7..c5f169facc51 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.c
+++ b/drivers/hwtracing/coresight/coresight-tpda.c
@@ -509,6 +509,50 @@ static ssize_t cmbchan_mode_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(cmbchan_mode);
 
+static ssize_t port_flush_req_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	guard(spinlock)(&drvdata->spinlock);
+	if (!drvdata->csdev->refcnt)
+		return -EPERM;
+
+	val = readl_relaxed(drvdata->base + TPDA_FLUSH_CR);
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
+	/* The valid value ranges from 0 to 127 */
+	if (val > 127)
+		return -EINVAL;
+
+	guard(spinlock)(&drvdata->spinlock);
+	if (!drvdata->csdev->refcnt)
+		return -EPERM;
+
+	if (val) {
+		CS_UNLOCK(drvdata->base);
+		writel_relaxed(val, drvdata->base + TPDA_FLUSH_CR);
+		CS_LOCK(drvdata->base);
+	}
+
+	return size;
+}
+static DEVICE_ATTR_RW(port_flush_req);
+
 static struct attribute *tpda_attrs[] = {
 	&dev_attr_trig_async_enable.attr,
 	&dev_attr_trig_flag_ts_enable.attr,
@@ -516,6 +560,7 @@ static struct attribute *tpda_attrs[] = {
 	&dev_attr_freq_ts_enable.attr,
 	&dev_attr_global_flush_req.attr,
 	&dev_attr_cmbchan_mode.attr,
+	&dev_attr_port_flush_req.attr,
 	NULL,
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-tpda.h b/drivers/hwtracing/coresight/coresight-tpda.h
index 00d146960d81..55a18d718357 100644
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


