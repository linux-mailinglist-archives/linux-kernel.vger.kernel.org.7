Return-Path: <linux-kernel+bounces-790836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F83B3ADD8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 00:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7EB73A93DD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB482C08D6;
	Thu, 28 Aug 2025 22:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B6BlvEHF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474FD2EB840
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 22:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756421318; cv=none; b=brUdgaoYjQPng1EseTXQ2ec2X9JZO7cJox1kXHU4/wcAUVtb5RNPmLEXgLIqzXLz/xEYeLIonWlnc3uZFny7JKHbiBoey5gIGS9RW5GKOF9rSefg9fR2RtPG9i9qbpI6e1jDypjG4uRebyOb7j5UdONeXKVN6duiEK/0p34nJuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756421318; c=relaxed/simple;
	bh=ZkVsyVv2vIclITxHSKeCRDNao5rKWcCBXSWeGP43FaA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aZ+QnvzLz7xTagNZBX8/Yea2M2YlwnHpI6mc8kV56jb+7VXMyBFaRGTnnLGvJa3zFrGHAE5/Wzk4u7nBYrLfOcILSUe7Urjw7jJx5gAsgEIXRJUnsmADOXgENK52EDPpFk6/+8Rhd6ZjqaDioYDUIUe7jmPPW37be77KiYpkAW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B6BlvEHF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SLWZ2J024741
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 22:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G+WQfJRfJ+ojjNuByHH0CbbmaQV8ss9XcUKP18Ee7Z0=; b=B6BlvEHFZ2mfXJia
	x8Y2FH2KPv9Y3Yn4r87ZmUODfQXjhnMlCGXFaNDO2mCr1S/j9Qmn8PTeOYixJtH5
	EREyJqsa/GIIdNWAgMsQP87srTHGmj0xwgxl1WzrhtsJOBu692MuU8tKcWOWFRVM
	Xd7XD8ccqcIx0ZS0PNfC+8OGnAzucl1rXzVfku6ECW2CIQASX8znxWvztLU92AQ7
	+r5TjDEY75qcEJEIFsZBAgVk96QGYhN8XyzdbpsjPVzKKZ0J+NEOB4zjbzy1nBF6
	nQK+u0sRAPTU35Jf6p+vmKclNV+rGbmli5b9BUYeO6IHU6AWmiwxPnWOLrAEL/+E
	Qj7N8Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5up1v3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 22:48:36 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70d903d04dbso32793486d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 15:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756421315; x=1757026115;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+WQfJRfJ+ojjNuByHH0CbbmaQV8ss9XcUKP18Ee7Z0=;
        b=VrjX/LX4cfoK934FAzGuwbhXVtzKww3NH5VzMTjO62dXtpYlOEuS+QJil++ddwKXXm
         96BBeRCO3xbfUCRCc614H3CdcSgrtkKs65iAInQcLdKzVLW3uFaDGZhfdz4fMPrdaP9p
         2FsuVNPw6PbQCjPRhAJYD5nGmtJLyHn8zcR96BI5IxNH5tidRo/qbI6IU9Qcx403x+K5
         NmgO7DttsfMoKRmT+vJ8PVbZiqo4pOaSuwHRaN7hbgtL0XP0quoSMQcqljjduRPvFhQm
         ad8Jm8LbVC3zzPFxuyH2MB4Gk2iUoRIPVsqDPe2USFvZy6j30C69S2XhYlpRPzrqk7g2
         DjPg==
X-Forwarded-Encrypted: i=1; AJvYcCXXI2WhxsafGAtRJgD5PUk7cCMZz1fDhUUTdXdofQs4aiHSSEcwSF2ogAq0ehui7b424sGdgI0KtG6yc3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYMH1N28eWkddIOIJ4r3UxvsGqSIVslQt34/4jtenslfN5Gjk4
	1LXZMTzqMj4oTDE30hil8Xf7EITVIXQKhhYrxdiuO/DGNtoqNSIlECTOfxf9tRyHJOb4ilRKs3H
	FSCd3erkdGfT2u4lbcxVSytgnTxQuZoUPVUuFkuWddtjpvYmlqsZRBDSO/hXsQ4RPWwE=
X-Gm-Gg: ASbGncv6TbJBgG8k0/PODBGVIHFzJm9rKJwEeIwTrwDNu/MNnCT8hDtuIcSo0ggjNns
	G4K2Uj2AvwkHq/DQndBbKLBAH2ekEc6qrM30fsNC1IGCnQjN367KXU7ssfCw2Fe+tLVh0ZxA8/b
	5pIESKWMlmekvmEaFJcHgohieUZdu1dscNnFs0KQRDe9ICb7/FIxoVjymQpQffUQ3A/Q/HOECOv
	0fJ/xOG1FaQfM/0MMbRHx3DsJmOU3FsdBbmGZqkLGRlcJqKWxGjcemCNF1HMhYWjNZa9TVLG8mf
	YLWWoVKVSOUI1aonvHu25UJ9i0V7KnIB39mmgfc4jVQ1dCnLxUwKNVNrZGXeo56QTwH1h0PgOPZ
	V9E5lR1/fT3c3vYstb7uoQVGS1ALbPm+K526+NSdv72crj9lFguay
X-Received: by 2002:a05:622a:428b:b0:4b0:64f9:decf with SMTP id d75a77b69052e-4b2aaad0920mr343641551cf.41.1756421315553;
        Thu, 28 Aug 2025 15:48:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFm1EpMVEwDrDbJgOawMde18SyT48ZLYFgZYxxlnkKlKJBpSV8cG8pnZW7P4h8bSc3I/QCRBA==
X-Received: by 2002:a05:622a:428b:b0:4b0:64f9:decf with SMTP id d75a77b69052e-4b2aaad0920mr343641131cf.41.1756421314975;
        Thu, 28 Aug 2025 15:48:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f678452e1sm143807e87.85.2025.08.28.15.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 15:48:34 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 29 Aug 2025 01:48:21 +0300
Subject: [PATCH v7 8/9] arm64: dts: qcom: sm6350: correct DP compatibility
 strings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-dp_mst_bindings-v7-8-2b268a43917b@oss.qualcomm.com>
References: <20250829-dp_mst_bindings-v7-0-2b268a43917b@oss.qualcomm.com>
In-Reply-To: <20250829-dp_mst_bindings-v7-0-2b268a43917b@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>, Mahadevan <quic_mahap@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1018;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=ZkVsyVv2vIclITxHSKeCRDNao5rKWcCBXSWeGP43FaA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBosNyxmDIKU1FWxpw5qkI4IleTgCRIf37TGB75q
 y/8eWDgmmSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaLDcsQAKCRCLPIo+Aiko
 1Qn4CACvdDokyDQ6C7VsJFvZZmp5DdMfytpyhmZAZh9fT3RIKIlB5h2RiTJdcd74uapEPVpke/y
 UI3uJ6RbN5Sj4pS8kEwnp0iz4EkgRbgAzLOEEqRGTXv4UjH8danqFRirlJ8jJPNM6xbx9oFIYrY
 yqeT39+MQjSKmf1Insyxfe4LOdu3TRjtT+XYNir0f89cOk6SfQOHBP/b0mPA/IqtonvVo8hiSn2
 +s2ZQ+9xCpxGMdHfz33C99dW4ayKouSOFmcbtfZLllIh5zSXwn3yOMnA9J5sY7r4Y1AHWo5fTDC
 Qpz/7QAZPCOL3tgTOozM0Wnoodq+JQAOF1WB+mw/lmXcWXbz
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: uUJwfr92hZWeEKqwvCgGLptYjfmoQkWK
X-Proofpoint-ORIG-GUID: uUJwfr92hZWeEKqwvCgGLptYjfmoQkWK
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68b0dcc4 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=P5fMS2Mpt_njWCDp3nYA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfX6wDuPMUx3IgT
 qgAD6ifsIAOOU5F8rBiXyANzx3yG4rMrUYc4SUXe1eIYb2JufoaGetthr9pRagZHpnQu5+vpSpn
 I8YqEKleh8j0MovZMkr/sb7zdwkomfexiAevfZqxVHkQwy708kQ7OdWORGQAvW1599Qqz5lCzOF
 uObsD46lTXyaK1BjbS27bmaA/Z8+sXmdCkgtSRlvXQh+oQbhJCHt1XpCn7bNKmYPWfal+d4IMI0
 G8gf1ZR4tiYreqgNszqP+9sVPLLXNiotGJNMTA7IMIBzHOj/pWD/eOJkwPvEZWv4y8Z0XRJRLOt
 Em3BEyHrqsnMJLvw0OgX5EPtKCKDi0bIMIor2lyma+XcK9Ktt3KlgZucF+GMiBi16mkioq4mMhS
 uQY8+451
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031

SM6350 doesn't have MST support, as such in DT schema it has been
switched to use SC7180 as a fallback compatible. Make DT file implement
this change.

Fixes: 62f87a3cac4e ("arm64: dts: qcom: sm6350: Add DisplayPort controller")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 2493b9611dcb675f4c33794ecc0ee9e8823e24d4..8459b27cacc72a4827a2e289e669163ad6250059 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -2249,7 +2249,7 @@ opp-560000000 {
 			};
 
 			mdss_dp: displayport-controller@ae90000 {
-				compatible = "qcom,sm6350-dp", "qcom,sm8350-dp";
+				compatible = "qcom,sm6350-dp", "qcom,sc7180-dp";
 				reg = <0x0 0xae90000 0x0 0x200>,
 				      <0x0 0xae90200 0x0 0x200>,
 				      <0x0 0xae90400 0x0 0x600>,

-- 
2.47.2


