Return-Path: <linux-kernel+bounces-880172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 527E0C2509B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5234256064E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD2034AAE7;
	Fri, 31 Oct 2025 12:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pwLv50Tl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GTXo1XYt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89E034A785
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761914056; cv=none; b=L+2s8wCfoiOwTM2EJhed3R5YLCplTpxGtqf7C3YLNYz4kqXay4MFRiK9ybsOnFYmVjL7IM0ZVl7Wpd/aRlgLRGLpYb8XVxvrCBDQ5cg5UVp7nXSfvS3bVg2yrWPVxqWl5fzOBWrV2j/ndX9mxMb7Fq/8ZAXkg3sJWT4tPf8m2bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761914056; c=relaxed/simple;
	bh=ISl4afa8cwdv7DeeV1ffEiyBIyGaBEuEZtsasRQTFbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UMQFb5dUdKSwOK7F6p+5+FJISHEC6TvZW9Uh7ct0cRghKUZs3wef+GBn1f9fIsgsznAM98vovP2zHN4cgCjb22YsqYA7fHlTyODcxIqS1lQxn32g66tFOB+De/OYMPezyzDxbfjOVAgyREDalWttEs25BHk8mkbVEcVEGU5S0Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pwLv50Tl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GTXo1XYt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V4M3T61827685
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=T+lGrQBbk9F
	oJoDoi6KpifG+D4n9fQawHOjseZxAJ1E=; b=pwLv50TlZbSGPLWU9dCvBWTned6
	66SV+yw9A8jSu3zyG7sglU1c45xfYw+GFEAlmVdhneBt7/FcvODLXCm4AVvSBDsD
	3opqUjBrhXCqHNFzN3O+J9MtpUBT+o7y+agAqbKGZU5dHgqOBnYM+xpkkRZoAAkj
	ug8tTUD59qtkrNThc4dl3jzn3comSzBWGfd45GlrXRBz6XU6YFl7U5TkQ+A1fn55
	AITzyqXtR2dX78/a/s/Rq/0kXaqXOJZIbEG9rByPOXl5/1+WmZ/Tk0xOXcQ6imSO
	xxQ8IYKGvT/HesuYXx91D+N8jp81nP6P6dnYanUdRY0ih05dznnqN7QwXPg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4p11s8d2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:34:13 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7810912fc31so2235179b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761914053; x=1762518853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+lGrQBbk9FoJoDoi6KpifG+D4n9fQawHOjseZxAJ1E=;
        b=GTXo1XYtXvpCTBe7c9lYuZKb2qVNYHkxio/gRF0EWScduuJDE+8hRV2pIqTv4fTSbS
         gd9JJokmvsNWd0P/KJ6C50h8oBsk119mhd5xNLqehiWwXX8sFlkJznya7DN6ISU2uDo2
         YNiv7+WBrcnnnbB/yP1JY4h2NfICnOWH7rdDoEdHxlJpyQwow6GWTqUBj4JXXODJqLD4
         1t+5FoR4LJA5/VmjAATwNBbQxHsCH0bddvF1VC98vcSna2lvue2uYEymGKeSaVPBVSbC
         BM1GMuKmCRldy40MFvRoux+MHWhF54nX7RywKsQ8yhN9HipFlgtP8AT1Qx0l2bJuKZ0M
         21TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761914053; x=1762518853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+lGrQBbk9FoJoDoi6KpifG+D4n9fQawHOjseZxAJ1E=;
        b=Y9JhGs+NujQ/SIm36LtqsD9NWRC3aBJatLM3Cws9/eCeo2Gyj0KYn3qrfg5SNH1I7D
         4L4mI/CFZnW+yJOI7cIab/4KflMIvrOSQN55NC0hY3ph846ucOFn1+k5hYDAiJq5E4tg
         Dgjc1XYKUj8crqFtgFLAtl1/VBNTLxJWPhJRQ0dvqWP++IwVmhsScNH18lvnFGQfCTrA
         HLiJ01UldssYf9pNyC/yHal65pSOSMOFVuwDjzhHQiMFUSbi/+qfW1tWO83lIfSVYwep
         E04sRPe3/GhRdi4PzIzvDJbM3NSLRuJFBfww5geXUZWMIl1QcDUeouJt64i0xKG+HFBU
         Bwug==
X-Forwarded-Encrypted: i=1; AJvYcCV9Duk8dFspFBLstXW5fTsuezTryl9WZJ1Gb3hscwgP0nzQCeKyC1qZU2OfKXllxH+xTjjjVzD90p0UVT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgrO/Zij3GT210ZjMeNRpWwaEdy1GkyB1K3jaOZq06ANbHULv4
	FZEN+2z4rMOWvQjVWI6/PHHZRonvV3+8I/NlNTc4O8jQrLn4SZQNh5FW0JfwLyiyQs4XHmxm3Kq
	PsvIqguCgR6amqXg4XzQ7yyHQFbRJHEZwXT2SwaGe/RfapyEoHhDOUrKLdVrBea2OBS8=
X-Gm-Gg: ASbGncufUpTIYKzOQFYjfyBCgu812UbZoeajPyBZBc9RO9aWZci7tMwgmQ+rLVxQCFc
	bld2Tb5OI0ljQEgjVWwvFehhUTO35GOWIHBPyEue/gEp4S83TQNYhKcItj0QSNOKlnrK/fmY+Fz
	8XLqjpxSqb/0StD+w/QNF6qAOG0oqToxBjtP3Ya4UNh3/4XDwNyPauGwG1sWl7JdPc6ui24y8Ui
	xTx/S//fOBFcugzws/U7Y0pVd11roxe8V7ABu/sMQaFZBmIxjmLzjHEUKJ/l4QhDHZYsNRjnlv0
	pL8amh2ET0IrkU68iqaahw4Hf0FjN/USH+iDD1HkrmpvP0zGm/GevAxFBivrP6oRXf6MXHD9lOE
	E4RuLlRVS+VpXaaVofe4rSeS2DrD6Fafjk8PK
X-Received: by 2002:a05:6a20:a103:b0:2b0:ff55:f830 with SMTP id adf61e73a8af0-348cc6f56d1mr4796290637.51.1761914052476;
        Fri, 31 Oct 2025 05:34:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJVtBqEFCaBAGHv2UQNhXJlUSOeZOqqNb1s7Do3Pm1YnpfErwTizdQ+Rc5UArFox1YRzQCmQ==
X-Received: by 2002:a05:6a20:a103:b0:2b0:ff55:f830 with SMTP id adf61e73a8af0-348cc6f56d1mr4796248637.51.1761914052000;
        Fri, 31 Oct 2025 05:34:12 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d8982109sm2131277b3a.1.2025.10.31.05.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:34:11 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v10 2/3] arm64: dts: qcom: sm8750: Add USB support for SM8750 MTP platform
Date: Fri, 31 Oct 2025 18:03:53 +0530
Message-Id: <20251031123354.542074-3-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251031123354.542074-1-krishna.kurapati@oss.qualcomm.com>
References: <20251031123354.542074-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nH0WoeKaFJ7FJ49gtjqemw8dmnxYAD15
X-Authority-Analysis: v=2.4 cv=RbCdyltv c=1 sm=1 tr=0 ts=6904acc5 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=JjTwLu2Kam44ScBvYj0A:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: nH0WoeKaFJ7FJ49gtjqemw8dmnxYAD15
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDExMyBTYWx0ZWRfXyR0wMYh1izf2
 TdiE1M6PBwLVzgRrq9ahOvVnmenDFGcgUJuebuHx8Y92AW9YgEy7Nn4pZPgD01+RnRMLtJBVzOB
 Ud9tbvObnNWMCtBMtHAK+5Ix/1aZM06W+/jWkPAqCwhPlYRR3PooLRoc6bSremnwkD4Ah0P8jWc
 636uV5k9HX6MKv7u2K/aXJC/ALbvDvd+oJi3wuSm0QgRjYdxsPTZZa7a/6g8iPooC7YaSUhWW3W
 PrCtNufVNiZKCto6LPUwLdAv4pmepLQdyeDM3nhGRGH87p6LfVd0fnAxkOixfbBtMUXIR94QuqD
 tdlJLZp2II/mAmx34hEmlQHkSGatlMiycwACUgUmoA0jcMClTBwbz2EhhTP4ETNEVd0xGNRCwso
 1Mvr7CYM11OqySXoTCNRld3Xvud8Bg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310113

From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>

Enable USB support on SM8750 MTP variant. Add the PMIC glink node with
connector to enable role switch support.

Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
[Konrad: Provided diff to flatten USB node on MTP]
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Co-developed-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 73 +++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
index 45b5f7581567..932aeee70054 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
@@ -191,6 +191,51 @@ platform {
 		};
 	};
 
+	pmic-glink {
+		compatible = "qcom,sm8750-pmic-glink",
+			     "qcom,sm8550-pmic-glink",
+			     "qcom,pmic-glink";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		orientation-gpios = <&tlmm 61 GPIO_ACTIVE_HIGH>;
+
+		connector@0 {
+			compatible = "usb-c-connector";
+			reg = <0>;
+
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					pmic_glink_hs_in: endpoint {
+						remote-endpoint = <&usb_dwc3_hs>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					pmic_glink_ss_in: endpoint {
+						remote-endpoint = <&usb_dp_qmpphy_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					pmic_glink_sbu: endpoint {
+					};
+				};
+			};
+		};
+	};
+
 	vph_pwr: vph-pwr-regulator {
 		compatible = "regulator-fixed";
 
@@ -1200,3 +1245,31 @@ &ufs_mem_hc {
 
 	status = "okay";
 };
+
+&usb {
+	status = "okay";
+};
+
+&usb_dwc3_hs {
+	remote-endpoint = <&pmic_glink_hs_in>;
+};
+
+&usb_hsphy {
+	vdd-supply = <&vreg_l2d_0p88>;
+	vdda12-supply = <&vreg_l3g_1p2>;
+
+	phys = <&pmih0108_eusb2_repeater>;
+
+	status = "okay";
+};
+
+&usb_dp_qmpphy {
+	vdda-phy-supply = <&vreg_l3g_1p2>;
+	vdda-pll-supply = <&vreg_l2d_0p88>;
+
+	status = "okay";
+};
+
+&usb_dp_qmpphy_out {
+	remote-endpoint = <&pmic_glink_ss_in>;
+};
-- 
2.34.1


