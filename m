Return-Path: <linux-kernel+bounces-811305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 546DEB52741
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05DE4688475
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80C326C38D;
	Thu, 11 Sep 2025 03:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lD81zjBU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7062923A9AE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 03:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757562100; cv=none; b=FcQaZKhEo8ggc+xUDAZWJq1P8DInrszofZHL2sn3tsSSPeNd9qKkXtOF/ei8q1cnF1Wp3NBuSOVeD3J8l7FcEGvl05295ffiPfYsCUxu5vkXFyjWknj8tCLlonlE57MQ9WbCgQgwhvurqLmAsVr/ryoP0sWyjxkroxEijvWlGvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757562100; c=relaxed/simple;
	bh=/lv6U+EjPMeafYia+qKbji5Tbq552Q5xbMPIUY9qAiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kzAiK8JGqhICcQ/9p2VpRPIdnKa3exjFpz6f4JOhPak3ssF7Fxx33TM027xaNIQRVA5oiRbO28dqkTKKgMjlrblAR8BI/+sTfIS59vrRBBPOcaLVVYanOZtG3vxrIZ47QsIS0+BSrQqs1UQMAjWMjIpyZVly5ak28ZOlfz2ZNA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lD81zjBU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B2J3x0006616
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 03:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YP1F2mKERyMRZBFmEs3SVcCv9UXZBJL5UnDFWST/l1c=; b=lD81zjBUQ40u8W2l
	UmBOznX4JfGe5Uc8w5e1E5ljITBKS7BsvfJadjMBZVNwmuJjs3maPhCIm1VeKuP2
	Ao1EYPK75Vl1bjpsY8ngMmzHKZJMqg/kyUOs/mM1gVHTBPi5vPIv4/Paxkp1ZtxD
	erCgNiZIJKFbKYts0VENwvk1WpXjnCiIhIvm2W8cRSYKTHEOHhy2H6YbiYeorEPc
	mVWJlM2tuNDJD/dNAzbweTL2u4WH/A+eNML53zt6A93mQ/ODNh2m3dFV4BlIZXUV
	vUwZV8xUkxkTnof9CAQsHGV1o6qJFJVmtH1RPcOpFN4jaTpyQGbzTVipJ5SsgssL
	SIU22w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491vc2a63e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 03:41:37 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-25bdf8126ceso4956895ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757562096; x=1758166896;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YP1F2mKERyMRZBFmEs3SVcCv9UXZBJL5UnDFWST/l1c=;
        b=V5YLeVyHzwU5pFAqS8A0ugmBIiC4P8j9WTpItlJUOpkFCjKw2aJgV85rdTbZEMf0gW
         JzYBC2vCNMFQz6FFLMNGiy86G2zFIGyVl/mYpuFLF0wgABSEIARXkqPFh494QhNBLStp
         nYHD+QSRolwlO9bP9fsVCQHfVl6MFtZrbWhceLhOZkYl4LxibJMjR+yEkV/tg0l/Vz2D
         B8nTkm4Bs2snWa8/nCEIhD/PgtxmfGkp0m5joXGnBFsWqpeAgQAh2VUvRGOaCfCNxxa/
         nz9032pVF5LLNFz6uWJyyR+gE5UL0PJ9rEWFoNLFlswFirpWOuv9tkQPzD9wyNwcGNpQ
         +p3A==
X-Forwarded-Encrypted: i=1; AJvYcCX1mIUK5KvV185Cmvz6lXjYz8MWMLgT92sUh4jtDdy6QZoFgSI2U1TfIZVjluKbh/yZh0NhuP9vgPbPNJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWhz8Somw6UHcvfDF87r26Uyyxs9EUDxKycROiXkzi5VJu4hPU
	2HQKJIvGaZyA54Elxb4BEqaScHPzelKRzfwOkhYWN+zNfsX5R1zBIZdPjimrLQCAsVBNDEn9e4Y
	LG/lZezcpL2euvSy1M5oSRPVulEVOFXFyt4oOlspL1MwmJf8Tw1WjT8aeCByK8SstKQ==
X-Gm-Gg: ASbGncsZPC9qnOkZsWTdtS5U4Qgf5hmwcawVx1R7AJcOziobcRHiW2kr3q+F5rWIZOj
	FbO07zZGhJev+BQG7DpUaKFdokiCNqbH7gLKewo/XjjjjbogOlT0WDYwfnKaQ/g885j3e4QoeE3
	fzVGtPPaDMFGLkUzQsf4A2XQ3i0IZX6b9EijwrR485UHBoWXmip/hgbsjbHEW/GYCl9fXI9Pa15
	D4PAfcDsMNiH8IuIY4N2buJUJPLEkWBDEJVqN5RXKHemlqvK54W7W6doLqbtZkokQYJ4cCkj95b
	bqDMx+jiMGJ79KsfoFIn9J8RQPPUe9SNvEUeHrRrPeJsHC/kqcMU4sozJi9SUxp6VjryZvLNQbz
	pD3gKJ/87xvMRUsV0HZLLQ1A=
X-Received: by 2002:a17:903:2b05:b0:24c:ca55:6d90 with SMTP id d9443c01a7336-2517493a0bfmr195669755ad.61.1757562096056;
        Wed, 10 Sep 2025 20:41:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvQDQ9uOhNwBYBH4VDpBdDwefv3e3oaJPc/CzBPBFYYZmFclBHQ1LdmEcszkXBkPyeDRPZhw==
X-Received: by 2002:a17:903:2b05:b0:24c:ca55:6d90 with SMTP id d9443c01a7336-2517493a0bfmr195669425ad.61.1757562095433;
        Wed, 10 Sep 2025 20:41:35 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b304f76sm2962275ad.130.2025.09.10.20.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 20:41:34 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Wed, 10 Sep 2025 20:41:20 -0700
Subject: [PATCH v11 07/11] tee: increase TEE_MAX_ARG_SIZE to 4096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-7-520e867b3d74@oss.qualcomm.com>
References: <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-0-520e867b3d74@oss.qualcomm.com>
In-Reply-To: <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-0-520e867b3d74@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=FN4bx/os c=1 sm=1 tr=0 ts=68c244f1 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=JCP0Puskdh6qvuzBaLcA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: CVepWvzXzYvpyxguqedN169lL0ZzS5Ep
X-Proofpoint-GUID: CVepWvzXzYvpyxguqedN169lL0ZzS5Ep
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA5NCBTYWx0ZWRfX4LvFQiX4SIae
 JxVEiOfhL+fH1EQq+keQRg9K5wZMYFs8vGJLJkRNSFmVVOSVmTgCZqIM0CPq+SX4EL4f7jmcQ9y
 m8fW0qD3LdDv9b4BX1Gb87Kk98AXaPOSEMw98MavcGRebFVmE1gmY/N7hJrtxpiAJFCmUpW2aoa
 SXDRaXwSBiBroik2o7wS8RrWwmCyuREj4LxdRoJj6YDYGyw2GIziUZlm1WiKuJg32RY4QUPW+a1
 Pz828dFnDhL7wY04dfLl3zQe/QK4yDIelH0hXA1DqeuQBPmDg9RPJC1VXZj78m3VpPQrr2DnrgT
 ghqOY0hursp3YOHDATWxK5Z1wlKDUhwKkLEtMi7wRXYlb6cDxO84D01xawVJ++4q+LChtz2uosy
 wdNKj/r9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080094

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
index 9abb0f299549..a5466b503bfe 100644
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


