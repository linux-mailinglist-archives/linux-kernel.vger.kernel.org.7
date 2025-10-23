Return-Path: <linux-kernel+bounces-866450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7D9BFFCA0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B99141A02469
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7672B2EF677;
	Thu, 23 Oct 2025 08:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j/7J0hxv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A862ECE87
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761206854; cv=none; b=o4ajhLmWkzgspT/T0I2qbv7UxuDCRRMZQDrqaLV609usacL/8aBtLcDxCWELajSuvy9Dg44jaSSA8knL3LDUciIm5hT9HBukAdaE+F2b4e5URrI2umwk2MsAff2hB/PrKg5vmnYiRe8641Apc//dfiuismmP84MGh/23uXswne4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761206854; c=relaxed/simple;
	bh=eHLbQKgDHrUQtLmRDXaeVqDwzsiNpWPWS6Xcj0PiRi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m0B/lmoRchvo2u/XkLS512oyZvRoZGYQMTMA3d9h5j4rhjYMdx1z0QsuIDzBwDkxXxoACsNbGrC1ty+mCvd+g95xw0OZHg0D8HVdRleC4NEtRIqVHN88kzi0PyGnHLBq8ZQBYiys498RwAl7vqBtkUV5HevAcFPWzavT6XRCMkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j/7J0hxv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6jb5i031877
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:07:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=IJq8ZteHVi/
	66D7zq8C07f3aqefDhDiFLFZsOOUaCOY=; b=j/7J0hxvXy0/VoN9aC/DOk3S369
	9ZndMDD2pApkG+uNM3VXdqkTiTpPioK0WBbr0PoYFIkTGvlrC8DTL/0vsSzOIvcV
	Yn0w+laY3HUc75NRdRgNLP9gHrru6TAIBhGIsfx1XGjLnQeqE9mdTSDxuPdZxJMi
	KhhR3iYM75xQ5KnYgcWtCpENcIW1+RvpWQ0Q6R2Z7zt+/WrAHwoeDWSffzT+YTu4
	hUFoa0BIJLkbXu30MVVP63EjN8CAOMMrnGakJz6/qZCB7kvcWAHrkr6jxi5GXaJ1
	yV5iCVGpy3Vq46ytiQ8TrqEFLz1Sxcud1xm25flZyZr3UmWPgyFwxS8jFeg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2ge7hfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:07:32 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7a27ade1e73so135050b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761206851; x=1761811651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJq8ZteHVi/66D7zq8C07f3aqefDhDiFLFZsOOUaCOY=;
        b=eLKgm+oYTYNMUhQvkCD7NuWBNANRVxvNSl5rys/WhheyikbF1zpUAh06Ih+dE+rKFC
         PHhWYimFcEM/KztY2x4i8S0I+bkOue5u0d24DjlljGyNcXCSxas+U1/FPJZ8cFH1dWqD
         Yc/q2ml38JN8m493Hmf86C+7eNpg/zaJUqLYlZf1k2WYLLfYIzHjTtKBTym+fbjqwDbR
         leG/e89VKdnuOtcKVwFuRpf/LTfvhOHVrdnbNhka/LdSoAKqRBgttv/uGKZ55k86RTLQ
         S780isM6oHPN9yIO+tk5Qinw22gN+WbwVDyISwexZOnzei+Nfj4gHqOe0aJUTC+I5evj
         Jvaw==
X-Forwarded-Encrypted: i=1; AJvYcCWpSdRLPgpgROTWQtKW7rygGNWPlVnraZB1odG2KRP98ywrphj6uB+4AAYia3MNQI9lO6VcXih95oW5Bpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ+AlqtF5LTFDP0aefFRFOfkmkFgsD7d32S56+GP44nmosgs9s
	Nn6rRcqJX2mudSwN00Dxn80txoXrRm+dUsj/fTXhes8RUa0Pud1t4zHEjaLzWsHU+YHEs5hpr/G
	lhm0dOn1wsczNwrZTLJr0+O/vdbkuK/4JJtb/Q4VIx2VJKmmTB0QLtgwVcBhn+b0Fo2o=
X-Gm-Gg: ASbGnct5lQ7ewZaPq140SVOTHg6Tss5uGm7Ut7WsIbBsJvjelK7l/3oyNFqg1rOg5UP
	ymOF+zGpQoEeHFmulpvmuH9sen3g3/CZ1xJGwq5ug7UVxPTGT2Agep13JFrDGX4etOVCd3znmfR
	63pRnWo/x5iDyLrCcV0Mr4UQVyl6OIogLp8DdFMQebnNlOndAjlA1VSvVTQZ1O0wqmC0zoCYJEE
	c7jh0EMeKns/3lPQ7wElmYdsfDZK1+35n2LHTLzbk15qQw3qbrJ4QWdtenPEyfLcS9ayzWpZ2xS
	uv6nZQsbLT9VpP7Za/oPfcwSu6QjXdI7b4FeLZ/1wxcAk7Fy3DCiqKDXWjXrcdgEPb5rhbQC32l
	qKX6ERyhOCqOY1C+CuI6IG0cco4PEQw+7enSxZf/fYNlvLi93sg==
X-Received: by 2002:a05:6a00:99a:b0:7a1:7f3d:45dd with SMTP id d2e1a72fcca58-7a220130bbamr28847438b3a.0.1761206850657;
        Thu, 23 Oct 2025 01:07:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyJ1rsxjg1qDnqSR6krY6mUI2Maa23+yEaD4eN6RpwTES5KZBi87GjaBN71trayEyatXK64w==
X-Received: by 2002:a05:6a00:99a:b0:7a1:7f3d:45dd with SMTP id d2e1a72fcca58-7a220130bbamr28847396b3a.0.1761206850204;
        Thu, 23 Oct 2025 01:07:30 -0700 (PDT)
Received: from yuanjiey.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274a9cec5sm1676410b3a.20.2025.10.23.01.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 01:07:29 -0700 (PDT)
From: yuanjie yang <yuanjie.yang@oss.qualcomm.com>
To: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mkrishn@quicinc.com, jonathan@marek.ca,
        quic_khsieh@quicinc.com, neil.armstrong@linaro.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com
Subject: [PATCH 09/12] dt-bindings: display/msm: qcom,kaanapali-dpu: Add Kaanapali
Date: Thu, 23 Oct 2025 16:06:06 +0800
Message-Id: <20251023080609.1212-4-yuanjie.yang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023080609.1212-1-yuanjie.yang@oss.qualcomm.com>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-1-yuanjie.yang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfXz8Fz0erAKA8J
 XxhixoPnPe6SDETE4NU/bKIOAo8ZEQZeptQ/DvSrw5P6wrQSp6yJ8LpS6vhgajy4swqh+z5+4qB
 cc8NbvPbEy+0/uv3QKcaVweF4yq0Sr0IVxL4nEREyXPG2IZ2HULphSaZuX26FnjEjLW055T8tDS
 PcaBJtldWpu21QrgH2pmoZR/p0fmfPVONfRCgBQODi19mlPg8SjZKIqTCJPT+CP0OPR0vrsL6No
 saUbGH5Fpd1xgP10Xf2+NHW/HCWr65+qfPafJXDf9fL7OSLXE/8+sASQ6ieADdqfEEDyxvvOHjX
 05WVgbTNMQcO9HpdcwK506ViFtQ6GNpOVc0ww5Nw9k9prtCekNGvGkJD41i6uRIK/+3y9l8z0oA
 dKI+8j7HcOyInsLVfjMHPYzuGfG7JQ==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68f9e244 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=LEfPF28z9Y6gGZEU5FYA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: HO0alBljKpORE-qpv23uL_x6dsV7cYOl
X-Proofpoint-ORIG-GUID: HO0alBljKpORE-qpv23uL_x6dsV7cYOl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020

From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>

Add DPU version 13.0 for Qualcomm Kaanapali Soc. The Kaanapali
DPU and SM8750 have significant differences, including additions
and removals of registers, as well as changes in register addresses.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
---
 .../devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
index 0a46120dd868..424dbda3fd9d 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
@@ -14,6 +14,7 @@ $ref: /schemas/display/msm/dpu-common.yaml#
 properties:
   compatible:
     enum:
+      - qcom,kaanapali-dpu
       - qcom,sa8775p-dpu
       - qcom,sm8650-dpu
       - qcom,sm8750-dpu
-- 
2.34.1


