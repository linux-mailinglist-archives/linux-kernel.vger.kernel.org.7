Return-Path: <linux-kernel+bounces-780481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 598ECB30277
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2521CE0310
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212D034AB12;
	Thu, 21 Aug 2025 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bYFWGnrk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2535F345743
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755802587; cv=none; b=ImEorLcUXwGsQ12dkI8tam7IFDM94lGkferuBWNzXcMedqTrf6K5F0+J7BCJbdvBIUd1IxG4hNdS84q6Hgc1lVu5yI75fYauYF5bVVJNqZEAE3QxmxAxaQ5/GL9L3HYuLgKJJaBTRt70oEI4MytbPkBVPmpZ1DOAgitywYprABo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755802587; c=relaxed/simple;
	bh=aChjfEXy6a3w7pDrZzuIMywJYTXB4ltbGRJ/LVzK4KE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OckNPDvi4dB0vj95kW3Ukv3cuaSLNpLGWkMAZGPimKMGKr1mtG/GyGoDJHxca9Dlv/TUuI2EJogtH48eem+c0b2Bn2QEOAvlsTUN8yhCcf1PKYUPLRwH0Hpd4yiJoIUyLLvlzdJybmQpgO+q/Seajqwozf+IxF39ISov+OUUyxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bYFWGnrk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LIAIYG026594
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hg0J2wlHD+qbwTRIm0aZirbDd2NKawJ141THIM96R+U=; b=bYFWGnrk+i631NeN
	LipidM3q73BVwNp3x/3nmDSFegEAqSk22I2FZVjSDjQ4TfkV8p6N32nWyG5nrSOj
	BrdNOSb7U0GL3jZKcw1AGkRhu/H+Ueia/4rCnqpao9ci9cKqCzxAMHz6Zp7bvKHI
	uHkeChvMAtG14JP5W+xZyXn6bZTG/qmcJUk0CU0LNkCeQpGZX8+N292G6nVr4pZx
	uAhJIZsZg5Hd5yuOP5Ems6LUJiRt7+of9qf5CL+x+Am21GAnwHoUaVMdKpZxyCe/
	1Pc1x/Ktbr5CXi4r45Dm0bMIEsMtV/1OzCUjSv9b3MSP4z5gxlSVeMOVEywzT49N
	YK15pw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52aejve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:56:25 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4716f9dad2so2118064a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755802584; x=1756407384;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hg0J2wlHD+qbwTRIm0aZirbDd2NKawJ141THIM96R+U=;
        b=weEAYQgb/j2v2qrL4jXd1/ZV91lu9CJc60iLjMEWipolMF0UH/xDZbf9C0qJS0RDGc
         DFaYNyF1iARAs2+r9XJYAG1GXqz8uqMc13iexq1By6Jui/VKwgzpHKOncq0+NQCOEbX6
         Rz1PRO+ZVwM/R9PAjzRiiBIM4i+xktXWoyj9UneHQwnorpmNw2XssTh1c/NovEeTsXNe
         gpDq61Q6VCafTWX8+0JnWIUoVimGKvK38uITfhI0TkL6zvlvYDbBMbfWNnn4J9oIlqAa
         GbamKxP+zrU05WYNmMkG8G6N9aFEXZhRvJQVY0zdVW4ifmYh2S+op/VGM62+eWzLeZXD
         TVgw==
X-Forwarded-Encrypted: i=1; AJvYcCU0Y2kYKElNPBzc0En8TWA5cDsiBAyWIr3EJVmc+U9vwVyjq2jXzcOLeSEVePsj7UkWCi3hkEb+NpsfW5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNT98wDcuIx0ozY14220r25Km60zZnKmvw6gcSNghmmnsHu8pk
	qwku/K5+heREWbfsCyUslow8qOK/Zr5iClF8PjdlaJ64xUhbVj8t5iQ25+D6mYUkSJQS4i8apWT
	sraaKirbZNupBv+NqdlVY0Wse8D++4WzEuJ2zzQN5Qdg63AxgnqpRs4Q74sW0L2+yHZU=
X-Gm-Gg: ASbGncuLKxlf3jY6TCJ1a3SmueBCSHEnE9yMABFKi9QM8PLa0rU9RXYl407Aps/kCtI
	aieyD4auP4dn+BKGNHbJ6JGD4aT3+5RttYxFgzZQG/rcgZWddVl8PFAE4/EfLsoZgkB7wYQGQgl
	KEN1bUw+5ZhccQreTGKMVhnCj64XrQszQqwWnlDA+HW1KpdH1iizL0FLBNSklg1M5Qoj9XmcV0C
	GKShNwkbSx6Jte6bVVoH5viW7E9I2t9iebMzaGgtGx5V+vOHsICVX/4gg7my4GDJ9op3vk1ZrDR
	MzCZl9kmSXj7bJzAkVifbFS9F6TDVGdXf5yfesufK+bg3qAyXQEBbbV926IeLnKg
X-Received: by 2002:a05:6a20:7489:b0:243:15b9:778c with SMTP id adf61e73a8af0-24340e6cb77mr247412637.48.1755802584594;
        Thu, 21 Aug 2025 11:56:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGn6rh0B7c47MXx8XdwaklyhTGhJwh7xCUoqZlm5H7COv9fUxz3qKZRUNFP5avMhQt1EeCF4w==
X-Received: by 2002:a05:6a20:7489:b0:243:15b9:778c with SMTP id adf61e73a8af0-24340e6cb77mr247380637.48.1755802584196;
        Thu, 21 Aug 2025 11:56:24 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4764090b0esm2106977a12.37.2025.08.21.11.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 11:56:23 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 22 Aug 2025 00:25:27 +0530
Subject: [PATCH v4 2/6] dt-bindings: nvmem: qfprom: Add sa8775p compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-a663-gpu-support-v4-2-97d26bb2144e@oss.qualcomm.com>
References: <20250822-a663-gpu-support-v4-0-97d26bb2144e@oss.qualcomm.com>
In-Reply-To: <20250822-a663-gpu-support-v4-0-97d26bb2144e@oss.qualcomm.com>
To: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Connor Abbott <cwabbott0@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
Cc: Gaurav Kohli <quic_gkohli@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755802565; l=864;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=aChjfEXy6a3w7pDrZzuIMywJYTXB4ltbGRJ/LVzK4KE=;
 b=/XcmgOUoAHeDff1fiNFaye/iAKfeR2hwV0huFEwN3Fp7thPfeoVIoG3nl8g+jN7M47WJKWChK
 oKS2daX3S28Ac8lIb00kR4jkby/DjG7Xj96UckrTpIbzxV58+O+9Y0g
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: 3gizcGF6xfZv3XOuoHKmfJ82dmT9o_Xu
X-Authority-Analysis: v=2.4 cv=B83gEOtM c=1 sm=1 tr=0 ts=68a76bd9 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=vw9LXNJGsfarEDkO4cMA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: 3gizcGF6xfZv3XOuoHKmfJ82dmT9o_Xu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX3nBl7zH1kHqx
 8MO+EZQCDxOrIlinwh1tIXAoz1fpBvlkF73IwbbjMKQkF0L+okpy1i4z4KHZbJNpg8rovvnJC08
 nwopDY3IH+z2jSq08Op45Q7EsTgb2XkwVEAKuCVch4pdZTumgs7iT+BBZ1iJ+tzBEHTqnWhHFZo
 EIGdtzMRERKE1sICJG0SdlVBCMGY5bC5FsZ9mL/HP6UXcexQq4vPzWEJqJ+GaEXBcaE61BSbmgu
 VUFy0z3Jtos8OLr6dpxpdgZHnpM+1BIJl65xNQYE2GtoRaMtwY9Q507xlDQPhZ1SGr0EEAk2loc
 blBngD2pY3SRoN1oXDUVRgBU8KuW/2UrwD5YSWL0fWqvCnNFzEpIFCh7PAX0qhIxQkha2aFq6A7
 KYsYHEjq769BnA14KRpp2AcNYSdKEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

Document compatible string for the QFPROM on Lemans platform.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 3f6dc6a3a9f1adc582a28cf71414b0e9d08629ed..7d1612acca48d24c3b54c4d25fa8a210176d3bb5 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -39,6 +39,7 @@ properties:
           - qcom,qcs404-qfprom
           - qcom,qcs615-qfprom
           - qcom,qcs8300-qfprom
+          - qcom,sa8775p-qfprom
           - qcom,sar2130p-qfprom
           - qcom,sc7180-qfprom
           - qcom,sc7280-qfprom

-- 
2.50.1


