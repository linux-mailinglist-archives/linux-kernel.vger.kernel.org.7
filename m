Return-Path: <linux-kernel+bounces-866825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0977FC00BC5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6B7419C820F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC7630BB82;
	Thu, 23 Oct 2025 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hhq5tgn0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB9D279DC9
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219004; cv=none; b=rd8hxk981o/quhU6sa+k5dYzHuQFpB7SoANryWBz3r6MtiKAW3uXQx62r25N0biKzE0IXr/hhKzVY9ixWpNE4R3GA2ck1s1Ko3JpzvQgwDpLVL/GImkrH4e7IWrjqZK1o7pEkjC3V53yKjLZc7M9JA+tEAxiKoOEMgQ6u2B0HBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219004; c=relaxed/simple;
	bh=hd0CoMo58CAUzr+VqJ+RAeH8nis97OD0oQjfGlLV2Lk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t0vYERXlDvX1/6rDQg6QxltAzvxeLy9vLpw70yvkNGAqZEog4rb13cv2JMmdd0Ukd1kd6GEb0rKPjKImNlzv7ikmM1jG+LK8ipTYXNN3VH0tM5+gTHZJmNxVkDL2bFJpn1dD5TciSt7KsCzYxQ9/oakr+VgFKeC59rnBQkWDavU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hhq5tgn0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N72Mlj025015
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fR2JDFO0Mtu
	aMMk5vsO3PZEznusuCLxw5SSeKXZkFr0=; b=hhq5tgn0qZnnv4cXLZHGCmYzHg+
	+b+OgLayWgJSb7LgMITUGIWgHmV8MvxU3+pBC/FzFolZxvX34HQtK3mknRYPLAAY
	oYDQOfT7GjzZutZyv09Waap5meyrt67wc/qobDkoLT65fgmhfyJlDmo3tNp2HJ2Y
	QCDxCWiGcwo/UmG1ggmzhDMdRw1HUpxWVZlUR1d+KLzc3rS+u/SS/QUzMdy4K1/D
	eWdcT5dlc04lRyVly7dn1M97mLqP9bnhwdSMVO9M5aiINQ9dOKebT5fzZ6ySBLxu
	TTtV9QeiLgxMsQqfLpcyZL1S2u0ID2PNrtEVnSthWo1vSN5eooNI6q/aFcA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v1w886p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:30:01 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-293060b5065so1981925ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:30:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761218999; x=1761823799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fR2JDFO0MtuaMMk5vsO3PZEznusuCLxw5SSeKXZkFr0=;
        b=qnZvNxlSS+ODFfkWI3px+4ybKyEX0pJGPY8w0RzcMGOrFoD4ZDecDUuSmTIcuN0KDW
         vIlbAlsN7EGErAlKtnQuFIA2iTX+s8rDeLNS5atcWqn1hK77Z3WUq/N8Rjwg5Wyk6s9b
         knfTeUcLQHh65XdTsq7SvLKr5V3wO/h9a4m4tHj4tVPi36xomG3+NJweSFrKXKL3jXBv
         6WbFAGM2qCTlRHCaCEMlzNGybMrYYeBXgeq5JGHj+PV6aUgthGEljH78AC08Wreb8RsG
         /DApc/B/Ztw+OgMQwzbdsnoZvwx8pxAJOSyAt/HkMf7ipyM3yLG/nvNOkI31toK9LV2M
         zp3A==
X-Forwarded-Encrypted: i=1; AJvYcCVNiM+Gomw4zvIoHYelDglvDiciI2QEdZineQ/djyI3pSqpQhSE9SdA1dV8sBoyP52iCqqQx1Go9YO3Ggw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmQtLN7y7ezQ3O9rIXckXFO+OYd8iWn52aHL7oKn642oTRDO8G
	Poh76RWAUn6TBwuCYds/y7zGj0DacQxs2EpJ++afHIYRN/jSC6Wu/K9puvXGabDJ5cfq3Q827bg
	seS/H97oh1Ql7fMK7K/RmLbrFy6pSFdn7eTKjCAqDnnWKze4XGEXW/X5QtJsS2gXD1Q==
X-Gm-Gg: ASbGncvU+ESZBTtcdAP9bGQbRNITb+97GvH6X4887gC1AL6doJySGt53fxS2m2WSuXX
	XqKluGjDKOlv8+NFiPiGdU52py1vlGYAC4Rs0Me2l0Xheq2Knl3smFmQ4a+APIL8HAmSHwcZtkq
	xmc0+MmLrEL+TMOXibWdmdkYijPzVZrmZRhPAmPywijlRm29b57eD8JHfBcgE3UYzSv2dmSroaI
	fyEZMs0A/ZINz4oKk+d9Tto0u+jGoasS/Wkor55n9bmpn3/2QGW7aIDedkyx+gWhrsmBp9oklrV
	ZDBYSJxGohY8lHeSialPZIK8wtX+1L2nZh37n+Tis1IQwXsO8Gmma6QR6OQQeSd27bew2mZFzeN
	qenFPejz2Bjzol0lnyk0bjnkrY7IHoQ==
X-Received: by 2002:a17:903:1746:b0:25c:9c28:b425 with SMTP id d9443c01a7336-292d3fe2f79mr65295005ad.11.1761218999175;
        Thu, 23 Oct 2025 04:29:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuXQI9VRXhnQMSIZ4xgGvAhDSywgxIFMeOu/zYuaXfGqNrmw1i1qi4dhUipSl7+nHiLMY6pw==
X-Received: by 2002:a17:903:1746:b0:25c:9c28:b425 with SMTP id d9443c01a7336-292d3fe2f79mr65294885ad.11.1761218998716;
        Thu, 23 Oct 2025 04:29:58 -0700 (PDT)
Received: from hu-sartgarg-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e1231b0sm20438815ad.97.2025.10.23.04.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:29:57 -0700 (PDT)
From: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
        kernel@oss.qualcomm.com, Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Subject: [PATCH V2 3/4] arm64: dts: qcom: sm8750-mtp: Add SDC2 node for sm8750 mtp board
Date: Thu, 23 Oct 2025 16:59:23 +0530
Message-Id: <20251023112924.1073811-4-sarthak.garg@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023112924.1073811-1-sarthak.garg@oss.qualcomm.com>
References: <20251023112924.1073811-1-sarthak.garg@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxNSBTYWx0ZWRfXxXOBEdWCyvpL
 p9lInPvn6mTZpFpLgsCv/Th/8kBSGwvxhSDK/dwXoIiGaxJmUytmN8AJ3FyOrwMa2RtT5N+07ZM
 St9/am6aspAC4EL3YzMLULCicAOnuE8jbLDOybUE4+3REwQCOSZoyEtD4KIZ1j46KGIPis2SZhB
 5W3vQarHfLwvISCz+62hRg/FU2JubO2TlyIOtujQoMtWQhbqf5zONDbiOQNDqvLflImuBiNSZIA
 eop+rw/stYhZgh6w9OTiUZRNgjTuuHk1xM6q5oog93gpaQ7DZODukV/UF+95drECgawEaHYq1eF
 XtG7+a7Cf0jbGhSUVcFd9/iK9FHvLBOevwNrdcvuv78/dgngn1Y3W1BgISlpBVq2az/yLADwzEn
 dtH+AahBB+VyYcVAjz7oHn3956I4ag==
X-Authority-Analysis: v=2.4 cv=bNUb4f+Z c=1 sm=1 tr=0 ts=68fa11b9 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=QH13294MLfywbrI7NfsA:9 a=zgiPjhLxNE0A:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 9rDwMwmVvoXrBFngmNKCP_KggfFkCk2H
X-Proofpoint-ORIG-GUID: 9rDwMwmVvoXrBFngmNKCP_KggfFkCk2H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180015

Enable SD Card host controller for sm8750 mtp board.

Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
index 3bbb53b7c71f..a8727d353b46 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
@@ -1030,6 +1030,22 @@ &remoteproc_mpss {
 	status = "fail";
 };
 
+&sdhc_2 {
+	cd-gpios = <&tlmm 55 GPIO_ACTIVE_LOW>;
+
+	vmmc-supply = <&vreg_l9b_2p9>;
+	vqmmc-supply = <&vreg_l8b_1p8>;
+
+	no-sdio;
+	no-mmc;
+
+	pinctrl-0 = <&sdc2_default>;
+	pinctrl-1 = <&sdc2_sleep>;
+	pinctrl-names = "default", "sleep";
+
+	status = "okay";
+};
+
 &swr0 {
 	status = "okay";
 
-- 
2.34.1


