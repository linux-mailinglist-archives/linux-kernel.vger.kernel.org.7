Return-Path: <linux-kernel+bounces-838861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5241BBB04AE
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 14:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE983BB776
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 12:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B8E2E9746;
	Wed,  1 Oct 2025 12:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W6kNq+Y9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74153537E9
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759320901; cv=none; b=JgnecePULRNkNIUR+bM3oAjYS82GHeCOoi/Kfye5cNN9SFothH6S9X2PlAH6nGqfrhWgcecy/yM5Hr/Em7uEqiFLcRICf2qFFIoxIwUIBgGiGb/AH0R0+A0IsZOp5rJ4vR5UU4bW5uUGl7PK8uPUoH/xbYbto/iq4/g42XaMgIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759320901; c=relaxed/simple;
	bh=pUysoWOuzpLtIlpmwUBS4KrMK3y5u/TzCzSKbKWLwRk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WC0ohFo9cyPOej7Wf9YRpDL/5UZoU9EAWib46BpjMQxnDqJTnx9DAFpAwLmbDNEkNhBOpmZhyKuzQDp9Rau/QEI/2Ka8usrdNwNcAHpL4EtDJfobEPQ684F7+/d+5QMTmrit6qUYq4pkOEN7s6l7X8BHjwHlrT9lMgU2BzfiCbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W6kNq+Y9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5919PYvi030609
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 12:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=JrHq7SFIyXVKiO6+Yq1XHr
	/cP7kMFjJ1Nti+Tl3luCw=; b=W6kNq+Y9zYNo1taie7NwP8rOPxikA6YYtFimGV
	eHsgtC8+58qld1b84GtBOIjjzp9JiMprESolw+lf+wOhRyDqSWtGwDJrGEDTGk6C
	4PO3tGg124O9VMzIkL8AtyYguV+ljWU4HNeflJqMsEKjIgSj/HYz6TCKjysCeaGf
	2ke5EmoHGWs33Yrz4ER+7IavAM98Bn6ZnQSkNoICzm7+QKZS9secJ+JOjaJtTB9P
	oLVU6GO0BoXsm7IUbR4aae41ej3PSgsNdlmefYdoeYNfixYn9pvcUnJC9tZ19U0r
	v7mBXijykRrWbxzu5DLxKykuZ9Nws7iUFDtWtG0GhEdsqJxQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8pdm9db-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 12:14:59 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b5b3715102fso882262a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 05:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759320899; x=1759925699;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JrHq7SFIyXVKiO6+Yq1XHr/cP7kMFjJ1Nti+Tl3luCw=;
        b=MiVC/7Pwsj2tSkW8jlReb0PTtsSEVG8Uh0XTB5smkfkUkyoq0kcv1zD/JCbsrNdYHH
         KeGXS4m5iBtokzZf72oHSBDvEiHwqkvDh/gsvSAh2h6uu21kBxaCURLlWvFJPE2nTHnK
         NgNoC2OIOHAnuEDkCCiqu5vWSNU9ryntB+bsDU4u4ChOPRS3qxaoPLwNHTv2QJfAsks4
         MeTy5Q4GH5GKV0/5aPvMQ83WDmpnvQZHoWNnTBwNMjbt28rxXG7yHw1/dxdyfksZjLBF
         EuZYbdrzO3h+khb7nUAtvyNg8Qaa3Gj+7OomO4YPvrLfN1i1WKyIVFrLUDpmbhbjdUTf
         5dOw==
X-Forwarded-Encrypted: i=1; AJvYcCVJAu261m3nQ1haU21I4MdP++uKURI9H0g0kyaV7E/n+cGsSz66wCdPqskXf0HZqGsqolluwqEu72QSDHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE/bWxyuBkkT0lCmAXsn0LKmkFvHEhqNEYYxD5cwopFAVGEQsO
	VBxUUFY+Z+rVLSsA+FaYw8p4kJWQ0zm7QClKNJdEUnpJuST4vaP0bH8v/Kbs5FLeADPh6qhaWAi
	IuFFZq0C5BsO3qIy1sDJSpZoCD8+ug2bGmxcMQp2IyNBxzLHbUhfOH9QBKchtSc8ar9c=
X-Gm-Gg: ASbGncsuNde67abAQ+/0/z2vJ6LUDWblzl5UPqAo8/HkMda8C1cZhG21gUwJw6seWw3
	0u1lhc6oQoS/qinZR01OOdPp1x/UgTdlH9mTCvIq1Fd1F19HU8vQ+vUJ8nOBEhCxpqR+r4jNB1F
	k1F1vX3eTUA+4WRFGv6blbSgm6+AKWjNiRHWEUvuvhdj2/vUQrSSnbyx99yu72a/HdcaRZT8ijt
	PVso9l71c305f66ejBYgElbtUrtKv3RgFGnIShP//k/GN3dIb4t9/58hmVHQNzI5vQDIHAsMB/6
	c2nxk2Fm+3c2WOmly+QZYzWMinDwBNay1KS6y5gxG9y9zvW4wWORISxKc5gUVH6Fu21JmD5AbJr
	KD8JSIyo=
X-Received: by 2002:a17:902:d589:b0:262:f975:fcba with SMTP id d9443c01a7336-28e7ea04a15mr35811625ad.9.1759320898659;
        Wed, 01 Oct 2025 05:14:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCSzJ1IHbLA1mfK6YpBR9XBK9JKqCFzSQMfit64fdt6dtO57eMB3HX1cPLeS7li1eYgD9ZSQ==
X-Received: by 2002:a17:902:d589:b0:262:f975:fcba with SMTP id d9443c01a7336-28e7ea04a15mr35804635ad.9.1759320885983;
        Wed, 01 Oct 2025 05:14:45 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed699cbfesm185026425ad.108.2025.10.01.05.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 05:14:45 -0700 (PDT)
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Date: Wed, 01 Oct 2025 17:44:32 +0530
Subject: [PATCH] soc: qcom: ice: Set ICE clk to turbo on probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-set-ice-clock-to-turbo-v1-1-7b802cf61dda@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIACcb3WgC/02NwQ7CIBBEf6Xh7CZQoZb+ivGwbBcl1qJAjYnx3
 0VN1OObzLy5i8wpcBZDcxeJryGHOFdQq0bQAec9Qxgri1a2RkmpIHOBQAw0RTpCiVCW5CIwobO
 MusPeijo+J/bh9hZvdx9OfFmqv3zCn35ovnKe0U0Mi89/H5lwCvMeLBljbN9a47vhql4vDnNtx
 dMplKFZO+uU70evjSZEbda08U5uut7KTvPoWh7RShS7x+MJqHE+NfgAAAA=
X-Change-ID: 20251001-set-ice-clock-to-turbo-ecab9ea46a89
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: iY_V-191xP2lEn1B9rMnTelb1tDRXyO7
X-Authority-Analysis: v=2.4 cv=MYZhep/f c=1 sm=1 tr=0 ts=68dd1b43 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=u1bwIIJuvd_SIhYoViIA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: iY_V-191xP2lEn1B9rMnTelb1tDRXyO7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzNiBTYWx0ZWRfX7/XthM4Xz8T/
 7mr5M4hMc00K20eayd78D6Ej8oG8Uf8reOm0Na6BWIbf9mvTIngngQfmfVQ9kJRI+u+I069GSAl
 TuS7x15NponpQzgZsXEXOjU0X5sKSy0bUmiW9hxnYpR3x+Zh8k04HXhluIt+XB4cHKppwkRXVyx
 B7DEfSsL9DHeK28hvz/7FULHLYMSH15kZThScUKd+Ocj+47LzDvjpMfJHDICWUql7IHARYUv8ZS
 PscPRrZxMzguRteh9wLPtmfhwuRmaYiHriWKpKpxwTsjgG9y1SemoTD4YZ5UlBy1s9+IlCzewST
 W95co5mcuvVesiTxry0ZO3Zrmy0UhfwiS6bhbbZjnDlfAr9LUVHw4b0/TU5iuk9Hlzz1zFERAdj
 DXFV9QCqo+68JqFang57XJFE3Pgmjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270036

Set ICE core clock to turbo (max freq) provided by dt
entry at ice device probe.

Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
---
MMC controller lacks a clock scaling mechanism, unlike the UFS
controller. By default, the MMC controller is set to TURBO mode
during probe, but the ICE clock remains at XO frequency,
leading to read/write performance degradation on eMMC.

To address this, set the ICE clock to TURBO during probe to
align it with the controller clock. This ensures consistent
performance and avoids mismatches between the controller
and ICE clock frequencies.
---
 drivers/soc/qcom/ice.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
index ec8d6bb9f426deee1038616282176bfc8e5b9ec1..eee06c499dc36a6bf380361f27e938331f1fcb10 100644
--- a/drivers/soc/qcom/ice.c
+++ b/drivers/soc/qcom/ice.c
@@ -535,6 +535,7 @@ static struct qcom_ice *qcom_ice_create(struct device *dev,
 	struct qcom_ice *engine;
 	const __be32 *prop;
 	int len;
+	int err;
 
 	if (!qcom_scm_is_available())
 		return ERR_PTR(-EPROBE_DEFER);
@@ -577,6 +578,13 @@ static struct qcom_ice *qcom_ice_create(struct device *dev,
 	if (!qcom_ice_check_supported(engine))
 		return ERR_PTR(-EOPNOTSUPP);
 
+	/* Set the ICE clk rate to TURBO */
+	if (engine->core_clk && engine->max_freq) {
+		err = clk_set_rate(engine->core_clk, engine->max_freq);
+		if (err)
+			dev_err(dev, "Failed setting the clk to TURBO\n");
+	}
+
 	dev_dbg(dev, "Registered Qualcomm Inline Crypto Engine\n");
 
 	return engine;

---
base-commit: 3b9b1f8df454caa453c7fb07689064edb2eda90a
change-id: 20251001-set-ice-clock-to-turbo-ecab9ea46a89
prerequisite-change-id: 20251001-enable-ufs-ice-clock-scaling-9c55598295f6:v1
prerequisite-patch-id: d66f521e5e625b295a1c408cdfce9bd9524ae3ba
prerequisite-patch-id: 23934f3fee5aabe4a2324130ed02909352b5cf61

Best regards,
-- 
Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>


