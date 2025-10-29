Return-Path: <linux-kernel+bounces-875552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADA7C194AA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B4BD4670AE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70779322C80;
	Wed, 29 Oct 2025 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pm4Jitwx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FcINmRe+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEEF329C78
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727955; cv=none; b=Ui/ygcaXBFN1KBqZSRz9tq8Lo9bOqqWT/QMX9zpSqgNPnXdai9Sh+3caxssbgm8kIsQ2M3B6gCr/vjdstDvOqvoVHnTF4uUdH41gPo9HprTUj9TZun2LgQK420uJVPOt2EpyoVM6IXtsi6i7OHQnDpmnUCr1q3XG0sY0khyKtzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727955; c=relaxed/simple;
	bh=f/HHi/48hqff50ItUhEpqZ+zfupVghiSAFK6cNZOm8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fYTn20xTLKkZdpukEnb+akZBAJOeXRD1m3lSnyVPWsloygIQ/Orvp8PHTDZ99qSyRlvfCdGO04ILqz5eZKZRcclKyltJXGZSJzu/+A3WYXY0B8C44E4JvE0+qWpgimPp3zOe6vk++LJdjiR9jiddsXmPZaMcYy5JcLtVr5jFoOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pm4Jitwx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FcINmRe+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4uxw53676873
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PqVjiwHHM6HMBkqOPTdcX/9mwjZ2lFutTM2OIer6Fqg=; b=pm4Jitwxgmbfq5Yk
	AasOjN7q/v2x+NXM69VAfxotSlzOJ3yPVR3gMAh/qwfwVS4ONfe+XFPkobkocvBL
	wa2sssWwW/XSozkqOKE0n0BYdvQ5FfFEHFddKkG6FX8O1ZNebjghUqNIiyp9VGBC
	FqFoh/U0LPvJH1sVd59EctQ1PlDjjsFXlF6lMbdXadktEDb1l+2JLCe98UYl/k9h
	LV7i4HhlFVuCVE+1vEqBILYqd1olR4sq6JzI9fMPnmypikSMSffrkrQ1HBrig1Cv
	eSh4fPnszeyGdrOG6n0kqKdCUyckTVgnufhniuORGJ4hCtCmWtwLB4L5nPtK9q49
	f3EgSw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a1hukg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:52:31 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ed18b4c621so6993901cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761727951; x=1762332751; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PqVjiwHHM6HMBkqOPTdcX/9mwjZ2lFutTM2OIer6Fqg=;
        b=FcINmRe+H745y0ks6kldw20tXfN+GcWVtaZZXd6NyJkoNS7chtbYWp6/Pv3EbsokWf
         /rS9AKUeJOsGAOBOdLNvCshKjyYfq0u3lL2wiidn1CRqqujPFNsBM9FoneP/Odejs/vt
         vT+BH+Co4LmYBmfdPm1YF2V6QcJ/C930qzEQVzxrR0uYTDoRO2mx4GNtUrJ9ipQzN9gh
         L9KikoSsvZCA97D8fblpT6jsPEwPXDN+qcoMx46sLfWRarwkcHKo12bwoSJbdMY9+f9o
         JdTfQvRVWlMCj77/uFnluu8R4xF+/4+P6ay7kGvKfvjwELhVEGa/3EcJyd3QwghqUmFw
         9YhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761727951; x=1762332751;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PqVjiwHHM6HMBkqOPTdcX/9mwjZ2lFutTM2OIer6Fqg=;
        b=X3NBTzMPqtsvYjNcA9yufZq8kvoS4EcXxjYBwVmLPm8jY7gMg8h4QzoveNx1plHOxU
         OH3W1LDwROahXZ+ALGocKcek4J4/3gMd5iAeYKyOsOecahL4SHzyxRvjJ7xz84O8GwSs
         TZvZunUhRQ0TnjvoSHtnJnmNJd77dBuxPNO9Hz5n6KjVXfsIax8SGbiIgc2Ph1uMxBMp
         GEC+3iKYCKj77wkX06dAUy0vmmxkUr0kFzVZVEGuAXWFQ2hKTvnDOCyuMQmzOI2USFpt
         Hh/uqa4rzcABajE8AuZNMYC6pnxmP7JxJxD9PDmWCtltjq3PgKD0JTYIkNTUBy6o6ujx
         zSMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjNsQ7g1uhaHY6SCLDXIPL5nxz6nKWxy76RDc+4nBj/vM8R+ubUJi3TO6hRquGWFIbcCIwC+urs9pgcN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbhropmyO76C+oOQiID2yMK4ljiBjkOcOgPOMWMpmgxzHiDI3h
	+NJKqiXGpC3pCpvawP5qGyYVCMdT8GfWyzxcKFKeFnoYWT/X9pHBoIeJDGdVgtF1PhHK2MQernV
	v9uXsWa2UBtaiEFjW2j4+CWFr3nf8Kx/wn/ZLSW/gxnEV1W9EpPNy28x3hNHD5XjZoOw=
X-Gm-Gg: ASbGncsa42HZ4nkQUXC+7g6a5fL/3Ptk8+n28y8eOt9epMbqWoBglkB5S0Vh+2o1jxD
	Y79QUFO3epzJUiVBDzD59C39tnv3pnyJqp5wURtTCvVqpPs5AWXPRg5HVpt47MW9JrDG144LwSJ
	L4+xvIPRQfWISxakKpDQriIhUvxPs4bQrbIoHOxlISU/VkXFX2CRKzbHubbDxCG3x5LQnW55Izy
	DTLXkIGT/5PG/wYBi21GUmECU4Z6pwC+p+m1FnLlvmwsUYezHtNNkIB3R1C88qfi/81vqHMExlN
	oZ0V9CNFyR8vJnWAPhXvgT1SeJTR/EI4BwGe+p6wvAIqd9q6ZwhfMkh27sYexND7chB4zk399sJ
	7aVcxc5Xdtg7gM0MA3Ba9xJ0=
X-Received: by 2002:a05:622a:1191:b0:4e7:24df:920f with SMTP id d75a77b69052e-4ed15a6ab64mr21703091cf.27.1761727951006;
        Wed, 29 Oct 2025 01:52:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOvmSdC4HmFMkbpQe3HllOymugFZ7rqxM8+XOIFsKpoDo9fMiPWIgDHanhaRSDOhK6KmtM4g==
X-Received: by 2002:a05:622a:1191:b0:4e7:24df:920f with SMTP id d75a77b69052e-4ed15a6ab64mr21702871cf.27.1761727950466;
        Wed, 29 Oct 2025 01:52:30 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed0817602dsm36760171cf.18.2025.10.29.01.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:52:30 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 16:51:38 +0800
Subject: [PATCH v13 5/5] drm/msm: mdss: Add QCS8300 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-qcs8300_mdss-v13-5-e8c8c4f82da2@oss.qualcomm.com>
References: <20251029-qcs8300_mdss-v13-0-e8c8c4f82da2@oss.qualcomm.com>
In-Reply-To: <20251029-qcs8300_mdss-v13-0-e8c8c4f82da2@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761727898; l=988;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=f/HHi/48hqff50ItUhEpqZ+zfupVghiSAFK6cNZOm8A=;
 b=lXTiSppnVE0dqE0qrye4mItP4ncDSpxVMjr9mzUdFBaJRn4RRa6nlFtZAt7flu3pDhV3mLlIC
 GN4wyHDVhcaBZ/+BRwAn+FIKgQypRdAFQgzGBpZhYNA20nxPT5XkuoF
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=Nu/cssdJ c=1 sm=1 tr=0 ts=6901d5cf cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=w6jnlB3v2fMHmChJ9ZgA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: vnyLKygov-jcmPZ3OXz1cq9k3z53pQe8
X-Proofpoint-ORIG-GUID: vnyLKygov-jcmPZ3OXz1cq9k3z53pQe8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA2NSBTYWx0ZWRfXxKmeIjO7WVnN
 08gdn9jxAe1D2H4hqDACTQ1SsVOmIgpLdDzhaWP4v7tfqUdOr2Jkzrpbb2BCxy5jq1tYtZrLiVY
 mQZ+9OQw14DSytURGP4rAhlCZdj0Q5x3UHtn9OHe062Yo25kqY+a0/8RSpvHmAo6WpscxlzfcSa
 3N2QIIEJVfaeWa2s+NZxTAqnvVVoPnW9Yl/IOy53pDAeZqFauW8+zU5Wcu9GpNC2BEg5F/h9Z0e
 kHSz+b2TG9fV/EvFUN5xAWyuSPPDZb4vyl/jReDyQrcS667gfBwr81gnqD6e3+L1ks3xx7+dAVk
 B6v5qGcXwfKKIh6sI8Jt8H+3s5PoYwWlmayU1FgLz7RLIcnWww0FYdsSR5eLJY558Eqt8UnK+/S
 VRu+/BCKLKdLvMUr+/AO8sHwYzKKXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290065

Add Mobile Display Subsystem (MDSS) support for the QCS8300 platform.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_mdss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 2d0e3e784c04..db2f0064eb72 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -555,6 +555,7 @@ static const struct of_device_id mdss_dt_match[] = {
 	{ .compatible = "qcom,mdss", .data = &data_153k6 },
 	{ .compatible = "qcom,msm8998-mdss", .data = &data_76k8 },
 	{ .compatible = "qcom,qcm2290-mdss", .data = &data_76k8 },
+	{ .compatible = "qcom,qcs8300-mdss", .data = &data_74k },
 	{ .compatible = "qcom,sa8775p-mdss", .data = &data_74k },
 	{ .compatible = "qcom,sar2130p-mdss", .data = &data_74k },
 	{ .compatible = "qcom,sdm670-mdss", .data = &data_76k8 },

-- 
2.43.0


