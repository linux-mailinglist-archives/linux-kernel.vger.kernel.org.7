Return-Path: <linux-kernel+bounces-735303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBB3B08D85
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13C5162EF6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777E82D9494;
	Thu, 17 Jul 2025 12:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TXv1jUaG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5871F2D878D
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752756707; cv=none; b=TcpqkarNHRlPuQ60qXAttp3K4z8SVb//8c+X/Ltg3VKYQ6tHf4U4Vml18Qi6xSfuRNVB54LVaVAW+9rtSl60BfTclRLVuSHpdVufUW1SD9qyLQaV08UdL4oog/boOT2M9lgmcwn1cy8GOujuczHRmjizLqOqGEkIy5ueycS6fVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752756707; c=relaxed/simple;
	bh=avnk6sc8EHSeOS7ES2prPQK2MQlrFEYK/e/4co5pN+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vs4JelvK1uc1V+GJZkHS0zriVTiuN0PENxokjMtmf8rMcEiAVUyOQ44OrABaFNmEMPfGEczRL+75+/kANd3baNtz8EqYSLi0xYwCJWWtGZKJmyZGXrqtaP8ggijWsCzzDXeCLrLqiEQrtkRQXt+cslr+af9RerQj0X75IlwjT1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TXv1jUaG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCeNYt008788
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:51:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9bzr1TaVGkOfJPBjDfmJ+dlX1XuUnIuMJk+rn5ei2Ok=; b=TXv1jUaGkMiw9z4n
	dxZrogRMLuA3TH7hSzGhmTxCMnpUsev5v6AcJxADvMStX7hZP2R86mq+jNWlAqKY
	aQ02xK2QZxM0KoEOtAvTPlAR+ExADu+01B7/wDDgWSBE2K2GaRxfClZPrfC6Ewlf
	48bHAH2kr2E3TwY1yG1pYEra0TPlmHN3vso4p00HgY85m7uU8aLp8oGL43kKCJP0
	n3rhrN7Q+vDvmI9IV0mCXXfN2COryDoDLVyRkqGRv16DLdjvOKo2486cWKqlIQ+c
	aaMnfS1lxn3LCvlpAql6isu75Bicl88AMKze6lrY0dPUwO5W4ZjmtLeETxWnoJzi
	PrTQCg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxb7pbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:51:45 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e1fb57a7adso84810885a.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 05:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752756704; x=1753361504;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bzr1TaVGkOfJPBjDfmJ+dlX1XuUnIuMJk+rn5ei2Ok=;
        b=VVvv9+BCVbVVRb/7kRDwD4r36HbN4QNgMSduyqwP/ULygid78voijibm0n5WiLGtdq
         ZvzM/nLVW/JzGvkAAz1mfauMKi6w2LGbU+9iZbbd3L/tmkEI8ajVe4YPzyg09mmdZljz
         4PVAsKG231hy2ZcwfAF4YXx519IB25yf9AHgrr9qNm2PNbPbntKKyG5xcNKfHPnaswES
         q6uiTZyEcS6/xhNBsHLqlnoN3QbM/FMMoI4vEXHaCxY4WeF80unrS0Ww1PW0BDKQ10uz
         znjsVg6ihpJ2lWT+TyIiDsSQRMxyuoeL7Cw93rGxmPsOonbKk5+JAo54fDrcpqlbdsXK
         S4iQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHz+6tTuShWDZAq8FyqoLo+C8T2IV5pIRl5ZswvCrjPmiN8OjpKOJUPTso5vHYUwGRj+ZGrSRmnHcPlr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc+pCRnBFH/4hCKuwwNuPbkZVLhRdvn5L8sHajKLcCPuYIgqLt
	w/FI9YUpmI2mlZxZWfLkLZb2dPm3+m39BBstPt5lo1wkaFxyNwN3ZT1TQsTjiBx+McY9bxfuysh
	Ehwd2WN5AzLYYz9V2eSqj7+R1XeganbIeZWJKdL4hnf8nFeZegY2Zu4Adiapj3JMAuwU=
X-Gm-Gg: ASbGncvpUxNj9cOnYqhdMV0YO8dMhgT+wzZ8qC22qfBHII2cunZa8PBJhenSSuRISPM
	SfRdLNlLvgkrYn1Mh1AwYqcd3K7LtUsyOnapo4ND/A6/8WVPkw0rw164ys8nkqUhISbCq728GCR
	afis0K7V/4igazOfRRyd/ODBr9rBGqsP+GKXwIu7wnbnazdrHOxXuYWCfrFEUffOH6y1jLvqg7H
	2umIoeQoRz0dqiAOUL7P3rlpdWdgPYCS66u46WSL8SCvRmWeldeZo3n866H8XeGFut+uBL8m2ds
	w6XO60O7yct5dpZVjpv93skHqChWHZX6cfqqTPeqXcq+y/qTaraBRLOug3kqF/cV5B80e7ixSfG
	kxRDI9/PSFNxrUN6jk8AQxVn+VjqTJFSMeBtTPD79+v3TEGTsQJC2
X-Received: by 2002:a05:620a:63c3:b0:7e3:3836:b2e2 with SMTP id af79cd13be357-7e343617261mr981667985a.48.1752756704306;
        Thu, 17 Jul 2025 05:51:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBrP9UwwmwMrpp19kw5Ud4uZADb4Qpf7uPsYlVY6B9Br5gnf+nzoh6J5bkwRBddYMkvgY8XA==
X-Received: by 2002:a05:620a:63c3:b0:7e3:3836:b2e2 with SMTP id af79cd13be357-7e343617261mr981661885a.48.1752756703651;
        Thu, 17 Jul 2025 05:51:43 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c9d08fesm3032872e87.126.2025.07.17.05.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 05:51:42 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 15:48:19 +0300
Subject: [PATCH 4/4] arm64: dts: qcom: sm8550: stop using SoC-specific
 genpd indices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-fix-rpmhpd-abi-v1-4-4c82e25e3280@oss.qualcomm.com>
References: <20250717-fix-rpmhpd-abi-v1-0-4c82e25e3280@oss.qualcomm.com>
In-Reply-To: <20250717-fix-rpmhpd-abi-v1-0-4c82e25e3280@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Ling Xu <quic_lxu5@quicinc.com>, Dmitry Baryshkov <lumag@kernel.org>,
        Tengfei Fan <quic_tengfan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1098;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=avnk6sc8EHSeOS7ES2prPQK2MQlrFEYK/e/4co5pN+A=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoePHYGkw/Rph590C+UEwl4DnZrUOVRJn+NeX96
 gfPgIBO3pyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaHjx2AAKCRCLPIo+Aiko
 1aY5B/4ktrdchoWj/19HvXv1ozvYVpbwr8rM1boFE1OPTarm6mFCOYCl+Fxu3Xwc0LjF+67NNk+
 eRVihFkq7YPWJmVPEQhjOieEtalR1r6hMDGCwm10nBBdbxD5fyxUeUgawIpDAYz4yNnTCQC2/ya
 e5DFpX93SZV0rXO6b1wiX2sB7E/0x0KDnhwLYEvDYOCGivZSkYxcDbTAYjOnWpXj9gSSHq833rx
 DWx9/OOlyEtYa1GQa2mX8jTSPqeWBHiCr3XOHiu+LeoStGdkEu0tVv3Al3AvVj6V/NdIs6x2/xL
 fKuRO4YpGrsx3gxqttwbw/hSiGOWVPA0dumdcNpJBr1ci5j9
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: KaXXPzHg8ixYCnTt8WiOrOe3snpKXsrO
X-Proofpoint-ORIG-GUID: KaXXPzHg8ixYCnTt8WiOrOe3snpKXsrO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDExMyBTYWx0ZWRfX4Nio8QC8WGPI
 Nh09ppG5U2803YhxCBHhrcJVN339LspLhGURtyiJe88I1RNMkX44B0+1ybVlvjjjhqBsObaNpmE
 ilPrJsndooEjXjxB133HZqIC4Lun0EINDzOeemLCvo1hW5Qcvr2tMSZljErQDr1G1Vmh4+rqRO+
 SywU5VHQtLxda6+blSp5T68/vxVXniHOyfwKh8h4fbpGVE6iXid4M5NVMNbXod0u2qP8FkjIMzb
 SwybexsvByhddkhH7LPHRlVz5scNtKIeS0W9XmgfGJvNaz4DUek3dpoKNHgRUyqEpBpVC52BJ7N
 xyEHjdycPKfHRNz9klo29hyGww/gWc/abAPR7Nf8vSNRI43SgbnPLfu7dIAaNvdDxFVWk08thaJ
 3/jQV1KpA0PmvVlCXxN/H0RXxF4VNbZ7Nnjoj14YR0OMuh9uZ4RTR7uq5pTq8NZTJZZZL9bt
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=6878f1e1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=e06P08YCo0CmzbESZgoA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=770
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170113

The SM8550 has switched to RPMHPD_* indices for RPMh power domains,
however commit e271b59e39a6 ("arm64: dts: qcom: sm8550: Add camera clock
controller") brought some more old-style indices. Convert all of them to
use common RPMh PD indices.

Fixes: e271b59e39a6 ("arm64: dts: qcom: sm8550: Add camera clock controller")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 45713d46f3c52487d2638b7ab194c111f58679ce..a4ca06679c2f1eebacdd5938e380981c1b17925b 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -3623,7 +3623,7 @@ camcc: clock-controller@ade0000 {
 				 <&bi_tcxo_div2>,
 				 <&bi_tcxo_ao_div2>,
 				 <&sleep_clk>;
-			power-domains = <&rpmhpd SM8550_MMCX>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>;
 			required-opps = <&rpmhpd_opp_low_svs>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;

-- 
2.39.5


