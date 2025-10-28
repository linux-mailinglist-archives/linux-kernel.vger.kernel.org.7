Return-Path: <linux-kernel+bounces-872922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6A6C129E2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 03:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7967506784
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 02:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC569199252;
	Tue, 28 Oct 2025 02:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dbz9zrsq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D891D5151
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761616974; cv=none; b=DNN9eJmbeziMx+uIpM4Bz+BlydjQ8Zj9jF3owRtAcPuHszl+iZB0nrbFcFWw79GncImJjTWGcMv+zdtnAL5o+x7Dy2DxDS4a1mZ3/EfEWxxiD8YaqBXpFFSu2m96T5Z/wyCTJZIhp69K3JYEMGVavPX2q32XP4oBIUnz0mFU4Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761616974; c=relaxed/simple;
	bh=x94bmBPDle7HVbS0PkSm2/lJbSy5IMebw+R2HhIbqFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qKZHFT0PNIlEur9Yjdp9RZfP2NMU+rQLnJJG0+gB27dzZwrF2l5TFFfiMg9CHN8WrA1/J/LgduXxCp23wXG40AXTfyJCRoP7HpL7uRKxJYLNytdvQ9/jL9z8DkaOTNkVvAO9bgRCLbvqvoYUlf0NFZAHN0bkvMRC+eWuVgktIOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dbz9zrsq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RK7lGc2547332
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+wNhB652mnMYlogksGyeHgsrdx+7RWlwaFzG6ELHGc8=; b=dbz9zrsqWYQlSu0P
	fR7DV2lWKcUJzJAUjXPws3C7B0cqHeoEAq8wGZOVP4r2JXNO4uXGhOLnHYFdQpp2
	vmMU93DYhfIk8ypgQd2vzwKg/drsPV8ynUdUXRsf2sRq/x14/Ku9xrT/l2wY+nj9
	PhyFQaag956rIyCvsGF6Z/JF963ES3H9WAIhdkgMqfVVsZB0CbIqiB93+1NtHx8o
	lGhu1a/onQrl7iBmbKR3QyiD73yMgK3PHWRmMu9HWTDrg/IbXKx6TLgIRVwFG0d9
	J8wxUb2vIuLaeV//WqrYEELdTxR/QLDYf3SLNJiO02s5OMszHkqg1Wwu30RP3+1Y
	9yjD7Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a27s2jbnj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:02:51 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-26983c4d708so40649975ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 19:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761616971; x=1762221771;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wNhB652mnMYlogksGyeHgsrdx+7RWlwaFzG6ELHGc8=;
        b=tm0SIgIrGng89/SGr0qsLYdGAbDkceePMRM6NHtMeU//AK9yA9UKQIY4zF/VU6r1To
         +PoQCQZsC9Jpo2TwU45jpdKa+Fm93/uN6rcKHow/36Khi5bb1iteUwE9h7EJOyQ3dCnm
         1qp7IxfbiV04hu94fsBnV+NdfdIJ7xugHuYUS/N7yAzGhhc7j1pyRYjKXZoqgzAQHSA0
         ywtWRooHgGzhov4cpgEwwf8uVOfTywh9Pr00UHR7F6FwBts1WHDq6ZVsOyZcw368oUdS
         GbO3ozDnAkXL6JgzOJjfgb5DbkvnFI3EZpVGGKfbpy3AmRCcbRaWvTfgxXGjQw2Y09jj
         6ESw==
X-Forwarded-Encrypted: i=1; AJvYcCV02can14kFHDwj7hIUZoEp6EDr93zpQoKyqjDvf9vDMNoRvXIoPOgH4PobDKthCTPUZfoc73c4R2KKF2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ6gt5R5ZqS2rIZa6hevW5sDwnm3qdKLRF61VqNARXn2lUmFfM
	IBEuZKQpI6+/ABwOk3weT7UEzOpFbEowJqr83g33Upk6CZgQK7jPMsEOrFEntJj8hJIUjSF1b+e
	nEr8wCoEthA/Hk5haOZomg4AJhJW8nmrfKT2amkvpnszM+DPOBBNUMD+eSa9MmBrAug0=
X-Gm-Gg: ASbGncsYEZd1SFA48x3w9xTUqSe331D5m02FfMYkHSS+8lhsG2v97GkJoJCh8Zj7HSJ
	FuCNeYEHbTXK1hXWyr2CHqr2n/JXeKsY3VA/MLuhxIGDnN3KbJNysIAASkkjkGR5WxXCdUVr3M5
	wl3eP3oRCM0jlTlS1w15GQV0CeWmQrbFPrtoRPf7bo83jwfm7MezOM8R5Q8AW0NEENecBs8zkNu
	tW9g+2tCZ46LZs6wJaXJtXNfg8p1l536UU/ouJeKpT9ML196z7lwwZMZugd/1RL5em1pK12gra+
	kr8W74pA3UWkmmRqtBL59fjTNc5U7CKSmjDsqUBf/dJ7nFjKmLkndq+HxSiV+hBsh7Nt4D8Onti
	QbH824GvFQl1XG2l0Fs6osGjWdey+QkJz1wwxfGWnZu/3cNWL9lVfdIy190JNIpwrBw==
X-Received: by 2002:a17:903:41c2:b0:28e:80d7:663e with SMTP id d9443c01a7336-294cb4ffffdmr21884105ad.40.1761616970343;
        Mon, 27 Oct 2025 19:02:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUxghaYNmQqPK2saAE7r7SCzRdyzrULOVS/CNtBQxvDlc6kr4GGOx6zKHHzmW/336KTEw8nA==
X-Received: by 2002:a17:903:41c2:b0:28e:80d7:663e with SMTP id d9443c01a7336-294cb4ffffdmr21883685ad.40.1761616969873;
        Mon, 27 Oct 2025 19:02:49 -0700 (PDT)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d2789bsm95861895ad.62.2025.10.27.19.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 19:02:49 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 10:02:17 +0800
Subject: [PATCH v4 3/3] coresight: tpda: add sysfs node to flush specific
 port
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-configure_tpda_reg-v4-3-23000805d21d@oss.qualcomm.com>
References: <20251028-configure_tpda_reg-v4-0-23000805d21d@oss.qualcomm.com>
In-Reply-To: <20251028-configure_tpda_reg-v4-0-23000805d21d@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jie Gan <jie.gan@oss.qualcomm.com>,
        Tao Zhang <tao.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761616955; l=3779;
 i=jie.gan@oss.qualcomm.com; s=20250909; h=from:subject:message-id;
 bh=jDq21b1Z8mMMtc7DmhlI9qf036ZjY6vmqb55m6leOnQ=;
 b=TykYWRh4kXkeVJ0qVldcJsYhpROcPoeLyg/QusfUnnRl3p+TkGNRszmNpzWTK64rMcJ9EwJRa
 PpZJQhq55aYCnGajpS4jseWWlXV6gIeSqWMP/Kgs4GAsGH39iGDjaz6
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=3LxxUZRPCNkvPDlWOvXfJNqNO4SfGdy3eghMb8puHuk=
X-Proofpoint-ORIG-GUID: dSoGcA0YjL4nig_TLbQSXsXHHw8qbQMK
X-Proofpoint-GUID: dSoGcA0YjL4nig_TLbQSXsXHHw8qbQMK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDAxNyBTYWx0ZWRfX3PHIchq1RFf+
 vFt1XTBG/T5BqeRwJRtQ0214FwNZ1upb5PfC5GT0V7muZLMOHG9orzOATHXKUspwT9PJlK8CJ+W
 BMtvKyHVCpxF7F7kjquiEZsCGPqldvlGphh6Lvy3HRvuw7EI+RasjEDlhmaihsi+WREJe5mXetN
 9gOZrCArVaoFlzD5oQuxkb+/qz3y1uUwGwf8LMuyEcW8vGeaTWmHdvo0rs4+zrdKKbmlgfisJ1t
 WmU/zbX4OOUAJF8ZA5PK8Qhzf2hVtgpi74SlBoN7OMxyYQl1lHO25ui7SU6Zt0WxksWdFwGNn5s
 GFitdY5P8XbDBGza5HJ+1OnwsOTe2jxM9mMHvCR0wXNx2XjTjNw2J4DYlYx1duGcEk5yD3WJZWX
 T2U0ygky+fd/gmvZ0zVdwqMoqXoxHw==
X-Authority-Analysis: v=2.4 cv=R60O2NRX c=1 sm=1 tr=0 ts=6900244b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=oM8RmAA2zgEEgW_MHrIA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510280017

From: Tao Zhang <tao.zhang@oss.qualcomm.com>

Setting bit i in the TPDA_FLUSH_CR register initiates a flush request
for port i, forcing the data to synchronize and be transmitted to the
sink device.

Signed-off-by: Tao Zhang <tao.zhang@oss.qualcomm.com>
Reviewed-by: James Clark <james.clark@linaro.org>
Co-developed-by: Jie Gan <jie.gan@oss.qualcomm.com>
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 .../ABI/testing/sysfs-bus-coresight-devices-tpda   |  7 ++++
 drivers/hwtracing/coresight/coresight-tpda.c       | 41 ++++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tpda.h       |  1 +
 3 files changed, 49 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda
index 80e4b05a1ab4..e047f69fd5cc 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda
@@ -41,3 +41,10 @@ Contact:	Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Tao Zhang <tao.zhang@oss.qu
 Description:
 		(RW) Configure the CMB/MCMB channel mode for all enabled ports.
 		Value 0 means raw channel mapping mode. Value 1 means channel pair marking mode.
+
+What:		/sys/bus/coresight/devices/<tpda-name>/port_flush_req
+Date:		October 2025
+KernelVersion:	6.19
+Contact:	Jinlong Mao <jinlong.mao@oss.qualcomm.com>, Tao Zhang <tao.zhang@oss.qualcomm.com>, Jie Gan <jie.gan@oss.qualcomm.com>
+Description:
+		(RW) Configure the bit i to requests a flush operation of port i on the TPDA.
diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
index f079861da279..3121c4c527fa 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.c
+++ b/drivers/hwtracing/coresight/coresight-tpda.c
@@ -481,6 +481,46 @@ static ssize_t cmbchan_mode_store(struct device *dev,
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
@@ -488,6 +528,7 @@ static struct attribute *tpda_attrs[] = {
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


