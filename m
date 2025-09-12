Return-Path: <linux-kernel+bounces-813170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A84B54181
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D5D567439
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 04:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B45527F160;
	Fri, 12 Sep 2025 04:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="myK/rdMl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B91326563F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757650081; cv=none; b=TKw6+enda8+lbLkNPDMoClbxUMzRvmQBG+BWIaeDyIagQnIQxJz0n5dGKq+nvHAI6HDlO/F/gZn5CfJ1z9sOV8qZB+XcUv2nynwd1czCC4K1vdauoj8T3G8Mrg/zVC3w+GcFaqV/DoTelMdchZAH/cpyn8wzbhGHUQ9NCVELLAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757650081; c=relaxed/simple;
	bh=/lv6U+EjPMeafYia+qKbji5Tbq552Q5xbMPIUY9qAiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IHjqYe2rGG4c6dq3uWb982AW5iOLgJPUfo9R6AhyQ123ocKCZzB/sHWjgsvNFASm/IJjXYATNlQB+EG9WsyQQDHfcGVEGqHwbQkPcvUh+otW/UmZ3T1o5yTUs6hdvcUKeU3pRog/xGiptBG8Uj0fiXSIRDztNACzkk6d6xSbFIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=myK/rdMl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BIPU2D006005
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:07:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YP1F2mKERyMRZBFmEs3SVcCv9UXZBJL5UnDFWST/l1c=; b=myK/rdMl99YEWJ+9
	xmp2+5NdqcR+Mu+5y0d5ntrTJX9/3MebyNDBN6k2hK86ki46zaHW748n/KtCBdeD
	E7qghvpX0ci8pjksyjhbtkX+LtEM5Gt1MZcYZtDy5JafX2Khhg7DaqXXzsANT7xe
	DivRXSpi6QsdkYn0hI3Osyenpa1JFJHDpZQHErgoOrUjSxa63457nU2i06IqMgAw
	zE/Vzu1O0sX6KCtTHFnWxXY6ji6a9apjzErEzNhHq1r1DvPPAAfNx/A/bNvvC+KY
	aF1b1ZNKfjQIJ+Y8/VfNenfusgpvFdpATG0XArnnzpTg8ooKN9Ke01LjlaSqpCEU
	fQo7aw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e8aj48u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:07:59 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b522037281bso1069143a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757650078; x=1758254878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YP1F2mKERyMRZBFmEs3SVcCv9UXZBJL5UnDFWST/l1c=;
        b=A/07FJkmych7kNCEl2oS2b/QTfzny4AeLZaPw0WWgyCFbA756gHouZovTyMEwaBecx
         BwlCNRVv+/x2JWAmJt9D1VxZsevOON0qkq7Th6A7Z8VzIrrIdP/yudWX/AA5t03LTjqi
         mwxvWgpBoJVstNDv+8RaQ6CUzYNQGojIdkT+KE10XqY6zVxmZiM+rqNCyl8pf1Klij+K
         FeD/awgh5fDwFy+tDdn7WVHJHZGu6yU11bi1JW1TOJ4uEcZeJHZyuF3/ZhSLeDThgjmX
         N9kncknzXAtpf9qJx5gawiorK8VcA/iWWtoq/dRHJCJTvPHObeIbW79+8Y89zQdlJG4K
         408Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYFIFI4k0LGUbVs5VbiRnU51QXQu2Hy3ZiyPG1tUksSWITjvTXTTqIJAdlWJUASlY/Bxuh5zw7P8oF12A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWGlC8YaFRtzHk7s+H57PjKle/m6MZCcVUr/+Dt/DmDFsg4WeM
	fClnd3qILhCPs+ZnHXoU7I1akpGrh8hrRzDeoXlspkijsUltjKpGlgsJPmoJ1Wuk18uZOhyg8lR
	Dr+uFD0gowOdeDib7ibfAh40Y+CXdVKnr8wZ6JEiZdRhRWMs9LVEWbCumAEXR++0OlQ==
X-Gm-Gg: ASbGncsZBtAi9GK4gHtv42yMsQFHQfGr9SL33vmpMwWgGwSxa7FDhr30mfjLOL8KitW
	ySSmLhhpZ6K7oVlYs5Ui5VMEfV5RhyMfvR5xTomqkkihm2llc5TFZJCWWHp4LS5G7jzOatI/ObD
	2nBKcxRdVoc2eKORSRxr0nDSnx7ibRWdKNpkjmOhSkFMDJ24Hw6/pQNLLLDBGR4C8PSA0uu3T4u
	8oWzqrqr0+VcX3466mOlUYEO+LfDMsT5kyOfSYPj1LdUb3gq8eSd64wrREOdscW3fUYAzmIkZTB
	l2gKa1TAkRQ4woocCBzI4jQITvFZnnQPF8oaikxv2Qu5O5fXls45uhzyOTXnmwMzWxePxhh9RYB
	SSlKbvLyBEuOSSZFaTZ23XtQ=
X-Received: by 2002:a05:6a21:32a7:b0:251:e4b4:7a37 with SMTP id adf61e73a8af0-2602a894843mr2108802637.19.1757650078385;
        Thu, 11 Sep 2025 21:07:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ46PSyhK+l4ntr3olYRusLBfLu7HsNfzRgfw3MxvnYkVZfq0w6ancyu/i44/JHqDSTmkaxg==
X-Received: by 2002:a05:6a21:32a7:b0:251:e4b4:7a37 with SMTP id adf61e73a8af0-2602a894843mr2108762637.19.1757650077930;
        Thu, 11 Sep 2025 21:07:57 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ad5e168fsm690960a12.13.2025.09.11.21.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 21:07:57 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 21:07:46 -0700
Subject: [PATCH v12 07/11] tee: increase TEE_MAX_ARG_SIZE to 4096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-7-17f07a942b8d@oss.qualcomm.com>
References: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-0-17f07a942b8d@oss.qualcomm.com>
In-Reply-To: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-0-17f07a942b8d@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=H7Dbw/Yi c=1 sm=1 tr=0 ts=68c39c9f cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=JCP0Puskdh6qvuzBaLcA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: FBPAbmzpejr-h8RMi0J789s_Zr3eRVAL
X-Proofpoint-ORIG-GUID: FBPAbmzpejr-h8RMi0J789s_Zr3eRVAL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOSBTYWx0ZWRfX/30r0G4GsWYU
 0RJ4edKPxMemHUZ5oE5JT3MghqMpgT7OHULprCva6tenyKcIHZyqyIyOg+vTyiEnxx0ODmeBucz
 A0c9blWjgutamtW841Hn5XmDI0ejsQPD9r7s1BBkU2lOUO4pJWFdA7bHDGr0kfEH5AkQEtAZYpC
 ctQ+wEAwfADDan5ZqvJ0Y+wYVK2Xj5l+0ruOD+OTvcyJ80DJEDJBrO5/pp3HLRM8CVKoUUUyUnl
 fD9hVPO88PAoH8Ysq01ww08AeV8L70CWBYkpvbmYEdxSjoUvUVvI5c472VPAEvIHKU7bzNhp5oR
 /lpzvRcQFAenk0Js/NP1lXrshkGE1k2dNsrX39bWSGK+POyp1MkeR8Q8QfssEnpr0g39mmiEn0i
 cKfg+zHG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060039

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


