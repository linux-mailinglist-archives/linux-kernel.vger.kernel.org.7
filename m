Return-Path: <linux-kernel+bounces-795530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA00B3F3FA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 954EF3BFABC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 04:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B083F2E3397;
	Tue,  2 Sep 2025 04:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iU93sRdK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDC32E2822
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 04:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756788982; cv=none; b=q8jpC+u2xbia9D7/2pAYoteEdbPA5o2mEeoI1EaN2LxaP9vx0MC/XopgroyWVcZzkn2OAU1sQupCVcNZ32aUPAGZCeyhnaD4NgatRWWuvBGyC8KzfXli+AowWu4GQMJ2p4/YM0LfAZmC6Wyh9voT2NuOG8L/heAxcIJllqYZ7zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756788982; c=relaxed/simple;
	bh=2jLp+9owgiqgZBOCKFldUxG3+QmUa/8reLXIFzBTr08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pNmGZAqMPMDHbusYoZ8yvVlrlZ3w2zOnnVlbRO+yZU7BJwFKZDKBZ50TODZe3RCnGgDR4YGR8+Rxl7OwnhvpIsGcCVDKgvvPgXhnADGZphIvgchfS4akCx7GTCkITRxL5bOM+XWJJJtB+hdAIQFH0OhK2s3iKCwA8Z21xXpiXmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iU93sRdK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822THTq027558
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 04:56:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	83fAnkrveK9gQC9R/+BmmA0iOQTFfDns/UdMTMdybB0=; b=iU93sRdKWl3pXPjk
	CJm3C1+MEZAjvpK2QCNBTrxyaoU8Dhm6LI8yXVNG07wdFhUQ+ksbZt3/Zf7NxRK6
	a5cbhGIxEEh+Tv8SPxrURN+2jGmdO/stF+UUlE4bEdYO47qgwQ3q7ycSXF+Nr9Nn
	v/CMBo4e1KGkQds1Q+1pNR7W6n+hTt7TLGOjv8GMg9eQe6F90QFWkgmx09pd/HyH
	3mteK7EK7DSm2rE69rebLfyl+0iyWeC0GSLldtq0zEmRxug2+HK9dalUeHEomiNf
	/guNOzY6Juhf/kGHVY30dyPqkKaZtx3/0TYu0TIaf4kCg+otGg+FKFq3ju84LdS/
	rC3g0w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscuxjtn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 04:56:20 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-249118cb74cso39051295ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 21:56:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756788979; x=1757393779;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83fAnkrveK9gQC9R/+BmmA0iOQTFfDns/UdMTMdybB0=;
        b=f4tI/0nYLVB4X253oWTWAHjqOA2YSh+qT2o1Pw89cHkb4NGSQ3OvlfQil+S1fuqFLA
         U0A90nqFZakatnYq7wKbagxbuz5jQ/SkxFP99cIuNASYJ6Zsam1rv5wJdMPtHABw+TAV
         PTewh8PL1Z83HF0yDizTWfiT+omfR9Q8pjVb17BH1j4GC0+zgVXvbqlKTiYa05NmzX9L
         tlKDmmilgvd/7HX/OkDiuZ1Rc5fTEB3wT3bRZ2QkwQr8+NU/8+7N7Q3f33Bwk+2r6UjJ
         UicJj9/RhRTtL/7IB6YeQbIkgs7Q9wak+IWiwAeHI6WfDcrEqiZHl+2DhuX/tlK7fitP
         KXGw==
X-Forwarded-Encrypted: i=1; AJvYcCXd9FaXnmqSPGlYZvuaXXaLQXLkvE6Nhih5TEhKt/kV6Lty21qHk2CM9b6Vy1frZt3RzC737HXcPXlujDU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+zsR74p+Ui3ySjdGGMhSp1mtPTirajhtHTYG6CO1lk4KMANiz
	0xKiCMuSsOd+txU7CPb0bIG5zXtOsIyTPxXweq2X9Vowc08kzAnfycxbkdPNiQZYc9NEkGDucTe
	JlDmEz8fPvmrhAimzCRPXDI8jt/Yt5Wvw/+Y81jollJSJl/nDTPK5Qt8tyolM8zkLnw==
X-Gm-Gg: ASbGncvJmWScjHOvygf+YQUM1QJ5Lh0H8x6pT6SoYXG+lQIbdqTVhtPTLgTV/3DiyE/
	Ju26+ivORF7ZddT76bq3q3+4OrNWb2m2lKriGt6Ej4YV0rp/k6eYDAquvkMMniNQ3kMgTso8hgs
	SFssRe8/ckBZ1YFJOI5KizO63aWiHDVu8RXv2zg/+lCdagPjK+mBFDsEcS1K8SJJwl0XIXyagI/
	8LMZo2tPQqy/9SrlViOQO0vDmoOeJI+E8ryfmMJSBdNOGe0v/YvLS2fuyoh5QOXC+/epBwzErP1
	/M6j5gLtePmsMlMMyR3hJSHQcMPVisCl+OhqDHg0GeplDkoQXBsWKHuOFj4oEs6NlGOiMAIs43h
	DKr0nuskdomzv9ibrNu3vY/Y=
X-Received: by 2002:a17:903:ac8:b0:240:52c8:2552 with SMTP id d9443c01a7336-24944ae192cmr136873205ad.43.1756788978826;
        Mon, 01 Sep 2025 21:56:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjejh0uViNDEvhTaWcq9bv3V5Y7jPhdE44Q6k9Ox7H8xWnNvjCjQCM5Z2Mqif5+n1s8qZOHw==
X-Received: by 2002:a17:903:ac8:b0:240:52c8:2552 with SMTP id d9443c01a7336-24944ae192cmr136872895ad.43.1756788978349;
        Mon, 01 Sep 2025 21:56:18 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b1f30a63asm1795345ad.66.2025.09.01.21.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 21:56:17 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Mon, 01 Sep 2025 21:55:52 -0700
Subject: [PATCH v9 05/11] tee: increase TEE_MAX_ARG_SIZE to 4096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-5-a2af23f132d5@oss.qualcomm.com>
References: <20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-0-a2af23f132d5@oss.qualcomm.com>
In-Reply-To: <20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-0-a2af23f132d5@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfXwxWC+D9aJiLn
 giUwwgB659U1FgeFLQfQxzsO8QaReQCUZzGv2hicyb2XgTxonta7yQgfi6wCSoZQE3S1OjOan1D
 MzvdaF0SSdidnfK7b///QbqLhOVOof2rMUqnGJykXqo230Ri+mlCvRVr0X9h96Qt0xe5kVkQ459
 05kWkEv0r91ocW724RDwAcokeiYoS5JF3ZS+82lTUGcZWIjGm7lwXOQ4/chd49JLivSIjvdB+wt
 xMipHD5znoLeNyWY4reDULgXke4G+rT5KVdRPRhOW7nuUv1flo76K1MPzYVmGXEnsxksFlKTGqZ
 uf7aEr01Ngi4LJ5nQ75ppFw34oc9BMeRifRMehtbUgkfPI/wUZ818rsEWRvZ4Xc6SnN2veL9p4g
 xR9E+2ph
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b678f4 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=JCP0Puskdh6qvuzBaLcA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: e4lP7mlPLeRJkRcyzKRs92wuREAU4nI0
X-Proofpoint-GUID: e4lP7mlPLeRJkRcyzKRs92wuREAU4nI0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031

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
index ac455683ab5b..5e393080fda1 100644
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


