Return-Path: <linux-kernel+bounces-729253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5596B033E7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 02:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F3997AC5DD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 00:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5B91D63F0;
	Mon, 14 Jul 2025 00:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FiBFiTjo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5991D63EF
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752454229; cv=none; b=moZeOjJBR2lEvuLie4lUgFfsW406K+zIe0DB/otRIlA750Ncksv5ixapjbVMx+a2JKNVBOW2ZlsjxMSi5dCGShQbfI0v+cE5zHkqlHOs4A/da8G0I0E6lfdoPFeDTbHxLzOpGM9IAUHcrBHvWKFTACOTKIzl5JU6GzhySLKM2QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752454229; c=relaxed/simple;
	bh=nhZDUeOuEBpe4gtZaFsCxHLG2a7kWizgihFMSQLXv+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sosDX9Al8HFcHazvuMte7iqRVIE1dM/V4OhieI9hm7mWYIONGnOeTQhRBmLM1vBJIQDoIwOyRvI2lCtgfF+cAOG3S0gDY2aGAnlo4I7bT9+pbcqCTIhowLGUc11qKZbHLtKmq4XgbgPP1Qp8N5z02k/H+jLmfL1Wz6qB7Ybh6qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FiBFiTjo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DMq6D6017291
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pvcGflOb4oHfrwRpsgfYu+5cxv3Vb3K+8uRpTdLXgHU=; b=FiBFiTjoRgGWwliv
	A6NRpzvOrEY2F2d1GiOU+gG2D98jldeZyZNBG22V6PrZlHFWpEl/xLQCPSRcULzO
	q0cJQxFLngWl3AwSZMCPnGNa/dyB2lt71XzCbGo/Kk4XG7jH/bHUFmn6ikqJBcsV
	y9j/g6P1dkTPEDY0Uxig5mgd2UjorcNhxy+w+Yz+A92pb4IKFcmPc4b4dVhAPcMa
	RhCmpNIj3t7qJm2/gAZtqZhyogUUhXXtStWx7Ay9TJSE5KaK/JLz5eVVIm9t0LVk
	NrqkvD/GYdR1qL/7LBW+gUho6lXnuv4YVKTAqx4lBs6xgtFsV+iAGI2eUnhFg7S9
	FKvmGg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47v56a1b4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:50:27 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b0e0c573531so2775955a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 17:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752454226; x=1753059026;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvcGflOb4oHfrwRpsgfYu+5cxv3Vb3K+8uRpTdLXgHU=;
        b=HOv2R75rDzr/S7Lz/hSCHALlr9ZCptRouOIsYjpL6tKffOI7lEmcmw7g25refs23wB
         o3XQIqj2pzM/gMsil7BojBuyb3XmPgE+qwNSLZv7DjMFPoPUqsZb3qDdZCMHviDKfsdS
         lUvqE7ZSzBBpHEK5Z+asFZVT19F1jVQtxZ3L0H7wyI3Q++gynbDhTIz+IXnCrNygm4w5
         nqT9XvzlM3RwnkcaKApyLwHmWhGZprCiHJ/WfxZ2Kjd+xyi/ZlmQEOijG60eNPEOazti
         GGbZ7mlvqMzYaKgv9gqBhzCmOg02luoau+3a3mTMjoPbToM/4N4sXlOzfT/QrFDIf7O2
         p11A==
X-Forwarded-Encrypted: i=1; AJvYcCWcyUB1dDLqcf4bBR0+IF53xy1N/2z+gYfCWdpuV+2CeVu2xh4E31y0o2TvvkBoG0onIO37EyqexGRdY8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwJYcNNQs868gV6W50n/1JINyLzx3YCcrRp2/qhOhSaQo6ZsnY
	l+i9oPKtWJrrN84/ZO1DhdK5/zlr/QcGsZ9JrQ5XvQ5ExufmuXftU13AXbPGobD0hkzt/7WCJlB
	ktD1UNdUQUlq7vK7o/DNxb8a2hVVxhmePXdutIkGsuhy6LzHWZI2kGbwsvGKbO62VMQ==
X-Gm-Gg: ASbGncs7aJW0E5IWLZIXeZEzFqnWkqxAXdAvx0rcKkrFlZMI7/JeWjrVUqmzVnkTql/
	QuAr2zNM48As7dc5WN6pDpVgIFLudzYss0fat5/FrTFo3GtliHOF+iRgdNO1rnvsYbP4BsxAgk4
	7UtFzPe+0XXE3j6c+ZcS+Ndd1XoGnpSlhdNu4Yc1orngNm4/LEaquMWP8qdrWPBGjlhUvTXHyW3
	wMy/5KohTTgQvwoATBzuqgXwNOhtUIU5L6CsoFMAp14cKi6KCLcp/a1YkaBrCZjlzr3qO4WmNVt
	qRAG6v6vyE51Jxen6XbTO844JhYmeFdxNHXe8J4ZQvRHjJDCwtgRkKcnf2qQtQ0uaFAIQJIv0xt
	2tsp6UXEVRVdtMxM4f1YzsFo=
X-Received: by 2002:a17:902:fb4b:b0:234:a44c:18d with SMTP id d9443c01a7336-23dede4f2b0mr147211575ad.22.1752454226432;
        Sun, 13 Jul 2025 17:50:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSKkQ1vcVqMqiNeyFPoUR8IIMJMh4dpPpOY24o/EK6hmUwpEmfMEVSQBsWp82yDp7UsudZ3w==
X-Received: by 2002:a17:902:fb4b:b0:234:a44c:18d with SMTP id d9443c01a7336-23dede4f2b0mr147211335ad.22.1752454226033;
        Sun, 13 Jul 2025 17:50:26 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de428473fsm87562605ad.13.2025.07.13.17.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 17:50:25 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Sun, 13 Jul 2025 17:49:17 -0700
Subject: [PATCH v6 05/12] tee: increase TEE_MAX_ARG_SIZE to 4096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-5-697fb7d41c36@oss.qualcomm.com>
References: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-0-697fb7d41c36@oss.qualcomm.com>
In-Reply-To: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-0-697fb7d41c36@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Proofpoint-ORIG-GUID: 9cZBo7b7fd0SezXQnRLjZ1Lm8Mw17WqO
X-Authority-Analysis: v=2.4 cv=X7BSKHTe c=1 sm=1 tr=0 ts=68745453 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=JCP0Puskdh6qvuzBaLcA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 9cZBo7b7fd0SezXQnRLjZ1Lm8Mw17WqO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAwMiBTYWx0ZWRfX2UJI5HST5+wO
 6BskQTs0B9VbT3wthrGnNY55qjU0wUFbrv9K6YxgOKpxXPI6LGgm1l/lZBzGbN1NpQCYa3+imSn
 IC3UNIMwuxQI9X0BTr690m+RynWotlV1hW/Ju0fGF/2uf8X9W6vaf94inyaNI1N0hdnC4+mV4WH
 rB5CUr9hyc6FHe3Ll2H0x9/oeNkyXrEpCchMoKYx20oafjH7A0ezlunuzoZcNgF+4U2DK354RIy
 SFi80mbJ3J4umRtOigYqSzlUXg70QCO2NfCDbEq9Thac+7ON9woknxGbXj85BpZgbdLzD8jI3M+
 P4ECAdCCMWxhYhrunqFrDqWWbEyl6NzmknqVXu9+6+8MQYtBV+QutlIkfK2VZiZvZICZqiqnI4P
 D89c1aEw7Dfu8ET+QYeNQ6lnZlU4AGqrQkaOBkPQbvi3YoK3VnH/kpjPNuVSs/SKsfDPjBs5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-13_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 mlxlogscore=975 suspectscore=0 phishscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140002

Increase TEE_MAX_ARG_SIZE to accommodate worst-case scenarios where
additional buffer space is required to pass all arguments to TEE.
This change is necessary for upcoming support for Qualcomm TEE, which
requires a larger buffer for argument marshaling.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Tested-by: Harshal Dev <quic_hdev@quicinc.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 include/uapi/linux/tee.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
index 441d97add53f..71a365afb89b 100644
--- a/include/uapi/linux/tee.h
+++ b/include/uapi/linux/tee.h
@@ -42,7 +42,7 @@
 #define TEE_IOC_MAGIC	0xa4
 #define TEE_IOC_BASE	0
 
-#define TEE_MAX_ARG_SIZE	1024
+#define TEE_MAX_ARG_SIZE	4096
 
 #define TEE_GEN_CAP_GP		(1 << 0)/* GlobalPlatform compliant TEE */
 #define TEE_GEN_CAP_PRIVILEGED	(1 << 1)/* Privileged device (for supplicant) */

-- 
2.34.1


