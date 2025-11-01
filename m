Return-Path: <linux-kernel+bounces-881466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48224C28425
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 18:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E3B64EC4FF
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 17:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE89F253B66;
	Sat,  1 Nov 2025 17:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DgJEcrlf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UkUjD2DR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E952B255222
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 17:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762019112; cv=none; b=kCeNnaFJcd94XFy7DiZsuVkWv7QHgPNhzVGAl29hknIMxpwkoeFjcot06WJOPWLP0X3YXwx52FzhbFDrGdWSNtJI4OSEHmskfeMS4s+QtbSojECN1kC7PTKfgvsc9hsLC2Ov5z2KYP2myL0ECP+EyvYXRQUuGg7LzImIRMz2UkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762019112; c=relaxed/simple;
	bh=WzgAceLBoyhe70T5JMBC+eLDbqFgqKfzb70WCArDfyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BmfscmjCx/buc9tjZJllNKDhnuDh1gbrG2jIYWdpSOsWFOLKtoRLQm7ka0b+EQasG1OPcFN7zHR3RLn3Gt1fcNN1pXSQIPKrBcEAI7bQN5EXoa4z6U0/8/Kd5V86HgcwTfR7cyu9J0PqiTvxZOxYrAD84+LydzHq7M4YbtNt5no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DgJEcrlf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UkUjD2DR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A13VCNg591318
	for <linux-kernel@vger.kernel.org>; Sat, 1 Nov 2025 17:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=0r10pnmYmr+
	Fs9IaUNrJNpuORDRgX7ggHWjcmGL4eXQ=; b=DgJEcrlfue14WVgLmzQCJM+dAef
	pjA8cac/JVx2LFD4JZdil2Kv8s/99u0yeMm419nCVTeJYH7gBOzG9DsEzNxWxJWq
	FtrkJmAnV8noSXMmpeMGULLAu4gH5MjRNRtkcAzkDnTr2baSZr2mCOK2CTyzDxa0
	jApvWjen2U3biXfJHx/cEgo1cdIL+jdtctKpzKAe2fJRmZk6Pmgq8tdtuxW3yWvu
	tNIrU57WBVAB+CZmS5TpT+INbV/Y6XM9Byxz9ZnIlg9SCw6tnjm8VJGHONjeUhcj
	pvmeflkPcCbNxyBb1av2yPxupNfckEwtvU3EAcoK9hZ6TEaPDtbDaoeNhnQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a57jn16xv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 17:45:02 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b62b7af4fddso2543830a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 10:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762019102; x=1762623902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0r10pnmYmr+Fs9IaUNrJNpuORDRgX7ggHWjcmGL4eXQ=;
        b=UkUjD2DRsF77cHBaTymGNRqFv5/tTXURhviSjn66B2DGw/JIQ3Pxm3l2aSfqOrSI2w
         ke0fgIrLisFUS7fPwiYK+OkNwIovSlfaFWqQe3qTL2RtUz/Ibd26gOOuyuBIeezKDPVS
         49zu2yWIJC9abI1vMqXgA+xnPeSmsVxZFCRAAK9VR1yfLxGPBrKcymKOWjg2YsIgOecW
         KdeTGvW7VAJIFPMoDv3zk5v0t7uZalofH8aWX6cEoLCGeoPKSFFmTdpubVbRQOpxRjTY
         uwERNEa8VGz71y9PwIuZ1ecMBu05Jet1crgyyi5Br8cGK+2hNrYdD5Ruh/y+4QMBC9tA
         hcrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762019102; x=1762623902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0r10pnmYmr+Fs9IaUNrJNpuORDRgX7ggHWjcmGL4eXQ=;
        b=ollcn0XCLmHv2D8MVTYQK1pfmqKdjQLaGZQIKOekQ7nBTd5qO0fpJo2J/1dJ2hQhUA
         4SFQek1rPK+RTIQodjYsHHTZxzDNBVRsqli+/w0UgiXQn9NZhtCALrAgkSiWgM/bYJKJ
         LtDl6DuiKNHDg5lIv0xqWda0FhM5H4BTW70SoFubSZ/NeKrNn1muMpx+KkkXqmRodU2f
         bRKFHvJId6kl8oeG8LEiJOdx1eYdkj9IPTCR4n6p8JsBfD1Nfjl1aLKLIOzCFEzefd4q
         mUwiwYMns/PQO7n/CTz2d4F5RoJF6v2eYVQL0wK7UzA4dpC8MCPkquHQe0tmYLyVDB67
         JYwA==
X-Forwarded-Encrypted: i=1; AJvYcCVmGTVR5gzKwy3jqo+P0v6ZatOmXcDe2McbafP5m14s5+9uq4Kf9ilyf2vB3kT6o6mTV3Ls/t1wRUS51uM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtN9FgK+f2eZkJI7GkvDnuFvazypiLUlIbPEmsZDutxMk6ZEyt
	2e7sKv7eXmRQDogDRLrArbfXmQ1cmPf9hlxuLPVsjou1CKGKyAds0MVKOaFl0tA4m1KUceBClGV
	s2ptdNJi4ahvtBj7G0FCD0f+G2qRXlb4OyOIyjvN+6oDEr02Vqk7eGHAWXIfZosZhmyE=
X-Gm-Gg: ASbGncullhFJT/idwYiUwdLZJKYgMpgjV3pfKBTvzwRyYs5kYS1LVXFMk8/hbFQsEzL
	K8DSpK4QVZAB4pvoZxssBGCxX2ezQSEzgN86F4ejnJBTA+CqZcpmIM61L/QLZjt2qowJZzGjbXX
	OkpICNE1zWqjd2hdYF+ZpEovAg0pK1mrqsmxEEpBAjlGv1fiQ3R3ec2g9Mx90qxgZUEJf3oIqW3
	NCpBR4Ho9PNMg/8M/LcoLGNyEbl2eYWgbOcBVOrQQAhsTgHHNZfxgcX9Gi6TxJS07uPa3TmgD6D
	KQ4EW6/sqpanpxsiAnADhnyMA+7iT7+Vub7SQKWk+dtcEHJqSGUnpzxbP549OeMmaXHAUkXxjDh
	/LWgPpEaEmem7ynghzrpelOMGTNQVqF/LS+4L
X-Received: by 2002:a05:6a20:a105:b0:33e:84f7:94f9 with SMTP id adf61e73a8af0-348c9f6707amr9071806637.9.1762019101590;
        Sat, 01 Nov 2025 10:45:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEm6LFQ1ZY+MxVoKxBuq08jfHxXgaNcLK4ddAl2bIzfJO+X1BHFquzWtxjbjZ7+Zb3IW0AG9w==
X-Received: by 2002:a05:6a20:a105:b0:33e:84f7:94f9 with SMTP id adf61e73a8af0-348c9f6707amr9071784637.9.1762019101083;
        Sat, 01 Nov 2025 10:45:01 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3407f24ee93sm2793393a91.9.2025.11.01.10.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 10:45:00 -0700 (PDT)
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
Subject: [PATCH v11 3/3] arm64: dts: qcom: sm8750: Add USB support for SM8750 QRD platform
Date: Sat,  1 Nov 2025 23:14:37 +0530
Message-Id: <20251101174437.1267998-4-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251101174437.1267998-1-krishna.kurapati@oss.qualcomm.com>
References: <20251101174437.1267998-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=StidKfO0 c=1 sm=1 tr=0 ts=6906471e cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=JjTwLu2Kam44ScBvYj0A:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: JS21LQ7eaRet_w1aEAb4QCioIrqC3oMH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDE1MiBTYWx0ZWRfX40NJVaO/gqWC
 CG4nWr+LIkEU1H91ZqURiXfiozWMeFjjTpdnRBo+/OSiIpqNJgJqUyuHuogbpnDrimAadfW8GX1
 kXQELr02YWrDtIVomHJmhPQ1XLv6Dy9wWFo7JocqJm3RtHjDdwBolGY7kkzu8hgwJczlbLfcZbz
 O+7OZ9ydhjHh3qqDgPw9xjwuyNA0AWwI272tufnA5t2SjDuFyJdsinFHWTtDuuqkRxl3CndnD/H
 461EHFw6huFVIE2A3cgx27i1IN5PNqrsO1lZ6a3kLQ31wm70+UDOARD0KTpqOZf7IZfADBokCVr
 6/4nkOeS9k2UozPbbYpbrSslcO4weEk16aIqRoMny2dg9cM7EY5RZ8sQ6cUNKM1DBsJ689MIiFq
 wOSiTRlum3uyRtBvBbJcVrX6TiHhGg==
X-Proofpoint-ORIG-GUID: JS21LQ7eaRet_w1aEAb4QCioIrqC3oMH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-01_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511010152

From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>

Enable USB support on SM8750 QRD variant. Add the PMIC glink node with
connector to enable role switch support.

Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
[Konrad: Provided diff to flatten USB node on MTP]
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Co-developed-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750-qrd.dts | 73 +++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
index 13c7b9664c89..b0cb61c5a603 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
@@ -193,6 +193,51 @@ platform {
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
 
@@ -1054,3 +1099,31 @@ &ufs_mem_hc {
 
 	status = "okay";
 };
+
+&usb {
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
-- 
2.34.1


