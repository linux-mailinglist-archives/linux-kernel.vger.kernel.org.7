Return-Path: <linux-kernel+bounces-803922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD3AB46754
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 01:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 358BB7C84A7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 23:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95FF279DC5;
	Fri,  5 Sep 2025 23:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MIj6edrG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCE01FBEA2
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 23:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757116413; cv=none; b=ruv+aT8ktu+yD4kItWB2NI/PTS3s6mJX9LOmZiZOnC31VduE8qaB5Fqy08pGEgVP32XXJo4QQHR9rqIsb6f73aKXWwcKrUEfxdZlQheTr48aLuJJHaD2UvLRaE6NRKw08FdOROBialzOcz70fGB0h+75iPQo4hNUjgPC6SR3rog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757116413; c=relaxed/simple;
	bh=QqdQLIajWoiM08KJ43uCFk6GXl5SlPD6hgGGW00Hh34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=u0/kPuwvE1JddFbXOwJUX6XyZSitC7enGvfn4Qvux4pRrh9UDZYOti3wqsjmsYUJ2eKlIqA4tbdekrTQAz1qk/dBLePQAFafPBKOgTTbsl296e7hcbc0PDn3phmmLUZAG+MZh6nLnHvtllsxLUyzn1k+vzFl866S+sjzLk4rWPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MIj6edrG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585GPb8t022162
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 23:53:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=9ntjK0000JxML8T0CJ9N/J
	2iPUwrgd3ulvER+ZPDg9A=; b=MIj6edrGuFKiPnFwSdcROUHqHFrXNBnPyFZcUJ
	YYU8zEaaT1PVFQn3YfwtAo5v7y9NVv1QbW2Ug68vl/Fdqz055Fj+P+NVX8F1wK9f
	uJyDhcOMEfuDuac7D/6hMWcr7Mfs6awxT/GdlwNat91fQ/D2DMpWhY7FV+zlkSOX
	0rzujJmoHH7pNwbIhBqfEE7QaqdEu8CLC1c92XUrQvrjrknTrrWm/u7Cnhd894tT
	yZetz38p8dQ6479snc9BBIBmthyXfg7lya/IIQWzxeeMMqFP1IeDfgdu53pZrOBe
	KmNiKcuMU9cfBB8GiBM5CHGzM0cB+U0pxwZ/lkIybRl2IVqA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk9cn9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 23:53:30 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24c9304b7bcso30107225ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 16:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757116409; x=1757721209;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ntjK0000JxML8T0CJ9N/J2iPUwrgd3ulvER+ZPDg9A=;
        b=oAWG7JnUhDHm7PbTJBDo4rtiSASwvryYs/EgwyNHeCZ7ca0vPMWID/rTdAkP3vffef
         9nT7TE8GmQkQdLM0xNZS8hPQs62ISmYT2DCFKIn5qTGF1AvCu4vVOTEFn9obYVMYqgWL
         k9zt74UpFGiMMVigt/2GPtHfP5vckRxDt4o/k0aRAqydGBoZOejHPrZ2yMvnWfmylDR7
         ywrX/CFB8x4OD9KcZ+aozjetwpDbmoSrHtzHAeuZc3bW5/8HyTfp+HF8CNaR0EUBn2nD
         TXiQXRi8BjeiHHAKSXKybCa87KHW9SZXWITbkde7/FH3PIT/p2IkQ7+9X/R6N1Cji0b1
         rPgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSbBjl2V8zxv3klIBQZOA+SWFSCj3ReyJuX4q9D3vhL+pejwLjWi73t8V/Ry0h6aLy4pp5mU96SnjyCRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsF/suo8evreF7yFw9VfgWjohPOWctXaKIBIIyADKM/e6U4djf
	1ksnAiu7E5lFCOe3y/6yVv2udLQAx0hrHFdgOpSVJhLc8nh+cLvVQW6854PuePVS+sjVfvzdgrk
	463LszbuVhs1wwJEoa96kBmttZufxDZ64dflRksz/jQXGUw7JlBsA7DrMevASu4mLHY5ksPAhJA
	QsoA==
X-Gm-Gg: ASbGncvsyFlfFfPYsnol3S2lKL4Dg75ZWWE0mUyebsi2C9Q3+Gk7T25uzeNcuy2w5gd
	um9QSmnVOkTitOrEZf/tUIGqxmSX2f2h0257zxI+xZrYQcJzbOsc0dhsvfu9NxXjVis1K0ImcpQ
	lb5NsYnGWh8NZaK1OxcbLcmciB8sQHqA3geig4NRlPyxiJQ18wc/lQKY8T3zpj09ZyGN4FgDEH2
	Fc+xEqHwGD2WMQh6qnbeUuqCsy1UXVBakaRurat3X1arYe7tdg+SERW/yLUwzxw0X5mNzE4mrul
	ku+8XJ1icXJOt05w/kEQFeEN9frdT8H16EOFyoHGiuj+3gzLXUNH7qgUAJ9+eX8+JkYH1Gf5BP8
	8sslIHDMlqLc9dFJfkZs2S+s8hgc=
X-Received: by 2002:a17:903:22c7:b0:24e:47ea:951e with SMTP id d9443c01a7336-2516fdc9797mr5866945ad.19.1757116409274;
        Fri, 05 Sep 2025 16:53:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8QUpGniq1OUMLLIgaeWGxmpKOQZNOr5ydhxok8F8J8LWqbW8BLwCURfP79S7LrHEK9DsS9w==
X-Received: by 2002:a17:903:22c7:b0:24e:47ea:951e with SMTP id d9443c01a7336-2516fdc9797mr5866655ad.19.1757116408785;
        Fri, 05 Sep 2025 16:53:28 -0700 (PDT)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b2570cfc8sm102015245ad.76.2025.09.05.16.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 16:53:28 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Date: Sat, 06 Sep 2025 07:53:04 +0800
Subject: [PATCH v2] coresight: tpda: fix the logic to setup the element
 size
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250906-fix_element_size_issue-v2-1-dbb0ac2541a9@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAOB3u2gC/x2MXQqDMBAGryL7bGAN/tReRSSIfupCTUtWRRTv3
 uDjwMxcpAgCpXdyUcAuKl8fwaYJ9XPnJxgZIpNlW3DNpRnlcPhggV+dygknqhsMqpz5Vdo6Gzu
 K8S8gms+4ae/7D0GOwF9oAAAA
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jie Gan <jie.gan@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757116405; l=1920;
 i=jie.gan@oss.qualcomm.com; s=20240927; h=from:subject:message-id;
 bh=QqdQLIajWoiM08KJ43uCFk6GXl5SlPD6hgGGW00Hh34=;
 b=5Ad5QfoQp2FDsdLvjG/YA5o8B8oW2b70yf175ycH3GNbzdR5c/Gmgz442CiNcw0KfK6Mlhg5a
 amBabxrvU3BBE1OG5yVI9LqInzQUDK3CXL8qPxh5aQK0/LSwcdBACJq
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=OZh7JyRifqJh4xmrcGgmwa8/LCS8O11Q+mtx4aZGmi4=
X-Proofpoint-GUID: XMYncc8Pztm2Et9StkVnFMM7H2fEOh3S
X-Proofpoint-ORIG-GUID: XMYncc8Pztm2Et9StkVnFMM7H2fEOh3S
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68bb77fa cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=eYArMgjR2MFx1z2CNlUA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX3suoRyrsLCNr
 LVdRk1TzFZRsRlvl7pSIsRek6ehF5fc54mh1/Bjd7Yx7u+frh/sEdm+Rtvdnf8QFbCqxtc3Lpli
 d4VPHHicK4fwWO6AAhH81jkfZbUod7rpzcWFVrqdiBIEIFes/kJQmjcZESHIXohRpbit6EC6l5w
 mVHi/LKtl1dghS1va9Pu6C7FrAyyMLqSPaxlF/012QWyIKAEx8Wy5KE9u/Dqfn7QFp8+PlHjlkH
 rmFNMaAyclyEyJV4AzmweohwuS7QU4wZLetq06epdZZGUvzrAwtJfsFw1B9ghXmOCq/1R2lCUUx
 uytIbRKKhmHBVbDX7h1igzNR3yHM6hM2S4xDcIWH1M7WGQoJ4Kf1mTXMiA90TIjtsQyj/L1WEF8
 xHA4BZBV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_08,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042

Some TPDM devices support both CMB and DSB datasets, requiring
the system to enable the port with both corresponding element sizes.

Currently, the logic treats tpdm_read_element_size as successful if
the CMB element size is retrieved correctly, regardless of whether
the DSB element size is obtained. This behavior causes issues
when parsing data from TPDM devices that depend on both element sizes.

To address this, the function should explicitly fail if the DSB
element size cannot be read correctly.

Fixes: e6d7f5252f73 ("coresight-tpda: Add support to configure CMB element")
Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
Changes in V2:
1. rebased the patch.
2. Add James's reviewed-by tag.
Link to V1 - https://lore.kernel.org/all/20250806080931.14322-1-jie.gan@oss.qualcomm.com/
---
 drivers/hwtracing/coresight/coresight-tpda.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
index 0633f04beb24..333b3cb23685 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.c
+++ b/drivers/hwtracing/coresight/coresight-tpda.c
@@ -71,6 +71,8 @@ static int tpdm_read_element_size(struct tpda_drvdata *drvdata,
 	if (tpdm_data->dsb) {
 		rc = fwnode_property_read_u32(dev_fwnode(csdev->dev.parent),
 				"qcom,dsb-element-bits", &drvdata->dsb_esize);
+		if (rc)
+			goto out;
 	}
 
 	if (tpdm_data->cmb) {
@@ -78,6 +80,7 @@ static int tpdm_read_element_size(struct tpda_drvdata *drvdata,
 				"qcom,cmb-element-bits", &drvdata->cmb_esize);
 	}
 
+out:
 	if (rc)
 		dev_warn_once(&csdev->dev,
 			"Failed to read TPDM Element size: %d\n", rc);

---
base-commit: 5d50cf9f7cf20a17ac469c20a2e07c29c1f6aab7
change-id: 20250906-fix_element_size_issue-e740086291fa

Best regards,
-- 
Jie Gan <jie.gan@oss.qualcomm.com>


