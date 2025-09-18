Return-Path: <linux-kernel+bounces-765710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C90DB23D2A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 02:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8282C4E37F7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 00:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CFA1E22E6;
	Wed, 13 Aug 2025 00:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hpBhiATq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2295E1CAA6C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755045430; cv=none; b=lgFbmkrdWstl+fgo5UaVihEvUMennjNtxnPv5FgMVs2g0T4UqqkaDu/1lTRCLMJZwJnpH3Trca0LqAXCjsCpeZ1U+yoRScrZ/SE3ncRK58DLgaMCftvY01LUWlPajzDMU5xlmoS9eLB/YteUoH5EPGp+0o5eYuKZT0t2IbOI4uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755045430; c=relaxed/simple;
	bh=nhZDUeOuEBpe4gtZaFsCxHLG2a7kWizgihFMSQLXv+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VKcnoQtyCZiwNUTMyUcPnRSODem0mB5sJGg+IZsj/fU1CiYEd9dppxAMLLVo0HLaF9NO5jOMFHI6D6j3ktKgRoH0OnZ/gD6O0SVwdJUNzGbB9jDeZxcz+vrcAcjOuBnGE/ZOvQ5Qy9HmDyHEKX0QmzIggctPc72TwH5P2sqjIsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hpBhiATq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CKrDCg020372
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pvcGflOb4oHfrwRpsgfYu+5cxv3Vb3K+8uRpTdLXgHU=; b=hpBhiATq/lYNQoNl
	JU0LE67zXI73ccU1PvZFZjE6yyrHd6m+Rex7gpWZXVjKmVucI0LExqgRMNhd0J98
	9LH0ei/1XvHw7Bjhh90eu6VvCtoJ2dnUsaGkCTQs+sXNwK8JudT7rxMIcpW9t54d
	KWyPtiMr1bEO9bWZanKSUoeqx3C7bs46ZQ9e7TEIYovgNoDN3M4/BrpqIsDnZ2gE
	CC9qnem/iRSbNs15mScprIvuAeZSl/Yoj/TAq8IQoxpi9J2bPjDiFm+lteTwdnCz
	P7+grhIauu1rR6yPuSwvZO1FLPfM7Ee1lqPxDahF437iZV+vk563+0j+eJZVv2vK
	eYKKOg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48eqhx82u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:37:08 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4293085605so5707110a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 17:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755045427; x=1755650227;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvcGflOb4oHfrwRpsgfYu+5cxv3Vb3K+8uRpTdLXgHU=;
        b=CNwaX+LEsOBs/KCdkZ0usU/9mGS1eZvN1BiKfeWpuhOWai/hs/ayS6CeTU5pm+773u
         TuIJIjhBtEJA3sfNZmj+n+JxtCx8UXElfjZZFcYmkC0d6+4cZy3kAiY0b227bkC5y3XE
         jEF6y9GUVNJuMoGV7yG3bF8YLglzUiHCb1M1/QiOIfSuUQK3NGBc00aR2ipvwLAs4Z22
         prlCUV4SKknLAEvR8JCSVNxc9dfCqo6y9cRyD5o6A2hlSDfJ6GjuizJ+0mMBMcL9mO1N
         83vygzXXWhWDX9YQa5W7qluMw4xRO+ToX9bdasR+CWxzGibgrEbCeyfW4bQoPhEDZDkb
         l19A==
X-Forwarded-Encrypted: i=1; AJvYcCVZYY/G56kWujak/pmCCx8W+/u5TNivtpVmlY3wWndOdRqRVAFIn4G9iwC1ymJLvlYkU0B7v1bzNXa9acU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9VtGBYt/mMBODAECjuiCV4nq9p7NmSBEvz+yvAlQCdwyLAkW4
	jBjgLOYhnf3UGhp7LkFtHOLXbiLHYQtr2V+a6bTREyJO93MKAOqWXtswo+CmG5h8qIB+3nGlasO
	S5tslwG6uRzb88j81VxzHOSoZa/CTJ8iVKbntLwCT/py7eG6GOSyoFWVuB4QT+JcDrA==
X-Gm-Gg: ASbGncs+vqhNgP+clqfx0rcUbbbJUgztiYYgwm45at4NAVaEwTDBJUt6l3hvLbaw4ff
	Ca0xS+h94LBIJyB8bAPzuFsdhx+qMGYvHedyQWx5ybzLXaenGyD3wDzfPkP2U6E0UWr9uplDHMM
	KSulaFvRC/r0nDuMnC6YPlUULBwKWwLtnVwGgj3eNPrghHZB1Gaq8M8ZVmpIMWsNS7NF9AaIuJW
	YQF+CLmnQYNXAw/2/HDcukQML302aMA6SSqzJSWBWJDE8rpjh571ABsJwGXj4Y4x0hUlcysIIsS
	SIaSrOQjY5a9Mzn9Vgx61r6HfvmkTZmybkRFagGzs4gPTPsC3Ikigfscw0HZc83F6fYlHPkA2W0
	o+GGbpPAMV+49kMn44BwRzoQ=
X-Received: by 2002:a17:902:f64f:b0:234:d431:ec6e with SMTP id d9443c01a7336-2430d0dc1c7mr17668575ad.3.1755045426967;
        Tue, 12 Aug 2025 17:37:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEq1Kn7j1C7ztFuBwXBgmFYHdC9nyMf6zyzl32DpAdGpojtxsRNAvOz4Khl5wCYv7bj+v3xFw==
X-Received: by 2002:a17:902:f64f:b0:234:d431:ec6e with SMTP id d9443c01a7336-2430d0dc1c7mr17668205ad.3.1755045426556;
        Tue, 12 Aug 2025 17:37:06 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8975c89sm308781585ad.96.2025.08.12.17.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 17:37:05 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 17:35:34 -0700
Subject: [PATCH v7 05/11] tee: increase TEE_MAX_ARG_SIZE to 4096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-5-ce7a1a774803@oss.qualcomm.com>
References: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
In-Reply-To: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA1NyBTYWx0ZWRfX316jlRhfi9Ie
 QKUBll2D47l7pviEITZEmjN+nC9cKa1dM4RRl8PbP6EVQte2aVFO+6I4y9GgLjklz3ebHWI3kij
 LDy5Ej3Xzx4TJJTKB0LKTIgAH093pB7XVj/S3Zrl1g9M/Nh2PmTtQYr12Hyl1yOhstLrwDkUxJb
 Dnieg8/dILAcz+Abee+s2Lscl1D5awrRJl+lwTOVWNF353XAor12GGoEkawYkuDSbAqjyTk7fcv
 8l3QCeXvXaRtt4e6HCi/avsFX5wX1kzcWJruuFX3Twlr6xOIqIxuKT+Rxa6SKFMejItFnNZ/B+b
 06NwYGvvl3/2Lrb4GRl7WeRT81G3mZYJyXJT5Gs79mciUK8LKczfC+p/9riAMB8I8vUb2Z429tw
 NcELD9mj
X-Proofpoint-GUID: kJbvXeN1Wsj_Gg-JKalqoROwpcHx95iA
X-Authority-Analysis: v=2.4 cv=aYNhnQot c=1 sm=1 tr=0 ts=689bde34 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=JCP0Puskdh6qvuzBaLcA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: kJbvXeN1Wsj_Gg-JKalqoROwpcHx95iA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508100057

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


