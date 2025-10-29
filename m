Return-Path: <linux-kernel+bounces-875550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB0FC19534
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F9335675EB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE0931D742;
	Wed, 29 Oct 2025 08:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CBqySYDJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SSPJ3MIn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7A0328617
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727945; cv=none; b=E2brkF9QXOx+uddqM1jUox2TAqHE7QILJdR30slDrjYVEmawjdrxCwKFMEtOaT4Vg/bWfuapuweACwocs96ZCMaQ5E7W2xt6uWZEMIrhb3QbVTMl9bDjZN9TDRIwPrMEZ6l1JHaIwUIVRHg2tynlA5Tz+4blgUm6ofYdyfKQykM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727945; c=relaxed/simple;
	bh=kT0nNkqfwLX+XjzaS7EK/w+Lq2GKCF3A4szZDCXzJMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t1qdEYniqVDERiR+t+F7/v63h7cvaloyqDhFUhAryrucfidMyCNX+Hq+lM+F09LPqfpq4NDO1dfsM9+A6yVCQETGuHBhKD9q34NqCT1A5T6xm426+k6edJ+WlOjy8FvvuWiHMSJtufLJAwREzdNVL540EQH/JDeMe4WC9n7bCtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CBqySYDJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SSPJ3MIn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4uuRO3642920
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1e9oSMS+d/VCq+PGqeKk2Zb2CCfTMlkGDkQXezm1vKw=; b=CBqySYDJhaZvDH0A
	lrZF9p0C/7Cr/7S4+hc6UIbj1u0GG6AvawcvDdMRddTfj6H9rS58aOFjRjIbPjB3
	ZMWM4eEueHhYvReXdjbWQNXCKBPw5gmBuqwFXua5DS7UX0cKp3G+ugCsgLNtAeX+
	aLhysyHOl2huQMXG2zeTDOk9EE8ZQjk4I/ePAuroUouJA5wlMWNNFVY4iX/dHk3L
	9djCFxdAjULaSIa/m7UDX3unvzDEHlneTMWn/PRj/8pW3oYLw6JbocDEKogK6JvU
	iz3TjFMnsHCQ6UAv1o+rUYEB1mlohYEheeKM2VX7PD/KvILU+9FUTUDkQVp/bWEj
	ootbFg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a1hvn7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:52:22 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e899262975so215878431cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761727942; x=1762332742; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1e9oSMS+d/VCq+PGqeKk2Zb2CCfTMlkGDkQXezm1vKw=;
        b=SSPJ3MInr5gcRgavQC45suagnhTj1ZUOJf96BBSQp97FTk6mfdEX9auPWGREqjAFQw
         /CRNHSYXj+Xtkiw1vo9PP6Omlxjoa2nzb9MpsdkXoMrLVNqAYmVNbUC59o77vJHNhz9e
         4FLJb/uEpPQVqlaE4g7otBCKfi/VkcKhzgoOgb5z1w/+UMctVck3KvtDS6XgwKBH1GfR
         wf0KuUo+OpwppSEZAdr6EK60SOUS31hTvWq7mtUv5tIqWeqw/ttUrVWHpQe+8FzJYFMk
         AP7g7ZCKg37UZ/qNR1Y8/SKcAjGCvZDtE5kudZwVpok1VpfoBphFIIVgsP60hcd2mkuE
         PTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761727942; x=1762332742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1e9oSMS+d/VCq+PGqeKk2Zb2CCfTMlkGDkQXezm1vKw=;
        b=P6zMPR4QFce/3KWWce9lLV6/DefawM9PUpXndeJt0qypDZ4E2G2lw6gxYa0FkZGfUF
         Bxkmr2bfvkPoGepgq1JIsUIJvtfkERDlhCrer+TyAHcvv4J2qFa9ND2MXjwF3FOAjmtk
         qfVMD5UOh3dV32ysanWzMNngLrUKfSbw8IhVsBQYozQolby6w1m28N1qbDo24CI3fbz1
         cL8NOJCaAVjVnP+OhVR93wgFlVzqqp7G8RE1Hm24tFWz/fzChRgY3D3rdSf6ejl0IxCi
         02NMnCtSVsr1sMec/VZRiQHwvZY4E+zgUj0klwBwInBtnZ9TfesHhiACx2KBabW7n1j2
         6rwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkfh0xEX4S2c9cZRwdN5fmrHA7hSqTfaXg8WAZb/GVhfsjcXI4LZ1dHt4K+gV6xaET2yrEwYF1j/SnCNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSFLRdWkV0Xb3zQYuRDwIFJU7N/KGcjYKzE46Nj4WPzHUAXE59
	Qt9WFGdSfy3Fszv5vOa5B2xRmvGSMJyE5zfrde1Ib32XTWFQhUJPCkoFSqHN8w+UTCIbBINGBkR
	LUK2BPax8W1naf6EKdMJIBf1O/Fgtmm4G0VPP943x+Iaz5v3cw1XwdwH345aBzADSWSM=
X-Gm-Gg: ASbGncsWl7tg1Up0itvsc34/UtefcDoiSPL7EKDA7r15eEXgV3h8wuFFFgZFNGIcLXe
	XJpP+dEhLjg3DcEQ0/sc0tqv9v+rl4IBUb5pEXviPKIiJvZU/+4S0T7c+ERMfvxpd8sOnGdVM31
	lZy00qtxBbjvsXKnXkW+iPgrLhXVfUPUozmKq5rXY6gZK1H1ohCD5r23VTwS+C8lcJcfp95fNX5
	DvgB9Xqqav7yZWnZTujAkN0NRwPzZIvYRg094G69ol+FHrHryoIfgu+tmmjc/sT/ig6acal+wSF
	YNUEZIM+M+y6+yHNxZtd1fFh7UfdN5HnsvEPVYM2BtDGRIukXP9ceBnvHzegR6Fyr4O6s+J+CAJ
	CRhfhOpKXjxKfITQkJ/PMyzw=
X-Received: by 2002:a05:622a:260d:b0:4ed:1ccb:e617 with SMTP id d75a77b69052e-4ed1ccbe7d2mr2855531cf.6.1761727942305;
        Wed, 29 Oct 2025 01:52:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhx7ax4/RlPT+IUaI3UXmPttDiy0gzUvlqhRIcryDt0sdvPy/2AnJ4i3HDDVRg6uQM7MD3xQ==
X-Received: by 2002:a05:622a:260d:b0:4ed:1ccb:e617 with SMTP id d75a77b69052e-4ed1ccbe7d2mr2855141cf.6.1761727941812;
        Wed, 29 Oct 2025 01:52:21 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed0817602dsm36760171cf.18.2025.10.29.01.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:52:21 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 16:51:37 +0800
Subject: [PATCH v13 4/5] soc: qcom: ubwc: Add QCS8300 UBWC cfg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-qcs8300_mdss-v13-4-e8c8c4f82da2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761727898; l=1133;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=kT0nNkqfwLX+XjzaS7EK/w+Lq2GKCF3A4szZDCXzJMM=;
 b=z7KgsgL6QAqNhspcyEXiISLQx3yK4dMx/rLPpvzTlBHiZhv7tB4FcIzHldIVlGllvk5/X+Ibn
 7wQqJO/f0kqBH3aLICgSJ4J+ZrJZHN5Q9FIij8s0r7NDf2uFfNvEmCp
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=dbiNHHXe c=1 sm=1 tr=0 ts=6901d5c6 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=yyC0Gtz2zuuxwh5CSaYA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: JABeY0ObatLV1nqenyJeUT3ofpF8oamK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA2NSBTYWx0ZWRfXzI8vDvZOQO+a
 1kXgFfv0QpY/Vo9QJG+1Vodv8BDSFxoxBSY3Xk81hPoNZheAu8WG1I6DeWSfDI7SCV4FjknXvzq
 jXlCvK8tpCvDYvl+pESvMFvArbLyEIDjkKIgnxGurNJi8p3GUFLdM7/9HpSzeEb0yCFKeL9/KpB
 V0vQnHFc9KVSJmPcmBMm8x5EDh+09l7+2LcW3zESxRQqStAmHD+XECzaj/IqH2bjgOGziOEa4w3
 52W7T0jQ+KeiTW8WTnpao5YY7sWaOgUQdxMUFSAQnPP3tHzSKSUsCQaxe1jUqNwKBcf5oDvgnS7
 6E6W37G0N6v8XANhSwT/96iNVjnrKWV6EhKJOmuThb8tHftObvq/U6Qp0zIfPg30iS3zu3LOA+5
 vq9Ojdwj9Bxg/o1CIO2wG2DKII+yLA==
X-Proofpoint-GUID: JABeY0ObatLV1nqenyJeUT3ofpF8oamK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290065

The QCS8300 supports UBWC 4.0 and 4 channels LP5 memory interface. Use
the SC8280XP data structure for QCS8300 according to the specification.

Acked-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/soc/qcom/ubwc_config.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
index 7cca2afb68e3..942fe6c17612 100644
--- a/drivers/soc/qcom/ubwc_config.c
+++ b/drivers/soc/qcom/ubwc_config.c
@@ -249,6 +249,7 @@ static const struct of_device_id qcom_ubwc_configs[] __maybe_unused = {
 	{ .compatible = "qcom,msm8998", .data = &msm8998_data },
 	{ .compatible = "qcom,qcm2290", .data = &qcm2290_data, },
 	{ .compatible = "qcom,qcm6490", .data = &sc7280_data, },
+	{ .compatible = "qcom,qcs8300", .data = &sc8280xp_data, },
 	{ .compatible = "qcom,sa8155p", .data = &sm8150_data, },
 	{ .compatible = "qcom,sa8540p", .data = &sc8280xp_data, },
 	{ .compatible = "qcom,sa8775p", .data = &sa8775p_data, },

-- 
2.43.0


