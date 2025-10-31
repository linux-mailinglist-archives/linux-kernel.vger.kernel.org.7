Return-Path: <linux-kernel+bounces-880173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE49EC250AD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2240C4F4400
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16A434B187;
	Fri, 31 Oct 2025 12:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mK9ezMbh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OtBbq2/K"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A3C3491E3
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761914060; cv=none; b=XTwx8EFN5VTsjP6v0+UpCeMro+2uQD0MrR74j+lzgdPTM/tK+ZFG/1LynLTzjC/BIC928ZNJ79YO76ENZSPQS9kNiS3P73dFIO/6qBpGByU26sqNJi7Pg/dSnDFhYYCsyyDQiMuj16o1W79sdbUd3RUWdKcrhgppUKSOoWhz7n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761914060; c=relaxed/simple;
	bh=NR+u/ZJ6Rn1lUAwh58hNdYHt2exbdPvMhMjCvAy03bc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M10+NvVu5ri5vzYOlFmd0PqvIpiRMtQjTW+H7RzZLGVAlWea4IckJSqaNFRDarCTZl9Ec84PbEv2WGAvkfYBmlpYtbBEsl4U+y8oqGKB46SJzgN+aNQDK7Qe0Hr0twq/Oq6U7Je8Rs5t0sqDZ+2BKQqEl1TQwJ8DWt7weNjufg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mK9ezMbh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OtBbq2/K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V8DumD832799
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=xcYCpAv72+s
	x5mvCiKKluLtRci+vKelpR/tA9qHixdU=; b=mK9ezMbhjC9ZHRQI/X2cAc+OXIL
	U57CyaRyu/K8qNnWi+kUsgQcIGipmd9GJSa/o7LJa05jYG7b/2FaZlJtLkZlLHIM
	zUo6rCnJyUAWdfeWDBgT+JyOJf2uW4pSBps8CWkljyP35d5D7Zm3vJVOb0siBN4x
	8LRgVAvbIpE6DiV3G+6wZtYDUFikSN1BxjoqJRWps7JMtnVGUnVS9qvOxlQwS+Zg
	8/szuwvqTdzQHOp5Cy0NdGpIr5ouGSfCiJq04lZkPLzKgr/ZDTS01/xefw4dNsz5
	r4q8+vkXjgwqKQUh52H6z0Sut0dv+JHqgFU+poTwn4bYFhRmQHYBHkArH1w==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ffb26bd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:34:18 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b92bdc65593so1011875a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761914058; x=1762518858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcYCpAv72+sx5mvCiKKluLtRci+vKelpR/tA9qHixdU=;
        b=OtBbq2/KlUPVNUMLAUdv8gVZNLu3Q/47Gx3O9oXhD/cecB3unFdBVyzUC93eAszkMg
         IeKpEEn3M35H7EtGSvTikOVrAAWB4T/dSMBt6I9abTS7jSq0dceq241xdoBhLxGFrRPs
         CTC1HXiQtRYjhxcJezXoU1T4YzPvj821uHI8+i0F9X14+k9DrqHdgDDQ/2G0XFb01hOp
         XjA236oduz4B9WuI1Cvxu1F1LnhVqBm+YFaVUg5KSe+RL9p9bgBagHMjOOwGXisdzaIZ
         kpXoYODKrbmz4iu5TOMJvCf6NMHpKmjsutF8PhMUAUw0WtC6DhKMRMC5srgQMn3VoIhZ
         20nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761914058; x=1762518858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcYCpAv72+sx5mvCiKKluLtRci+vKelpR/tA9qHixdU=;
        b=Er4GvjDUtepqf0watQ/PdS13NVoHClRc2R4+sqK0C4hbH8HOMV2D1wYDgF2ZwkSRyW
         5c8tn7WAM5IGcVODr6Y9BhRO10qNmwYqrErNHLsjm+Y7RBFkY74H+gepady14swO+Fhl
         8DMTBXJaZAIt1iVv9AacN+NM4PE6ZKaZQRmXz0fRcKAeDZynLwHzvjors9LDDp/+5uVf
         YzKbLZqLc8u7oLQi1/Hx1gqIQQB7ckiaYlwxKcLLTm/an1yQQVsHuXf29nBCqwBuwtC5
         Zju5Lxr8yAxvcH00Pp7Cuk3sSOigkBWBBh7hFJPTHYn+jmwiwadtIjJa0B2WM/Ag3n61
         tL9w==
X-Forwarded-Encrypted: i=1; AJvYcCUFJUI0pMFwCpujGQdFC/+SMoeOMThwUNdFP/o1mt2Tq1xYEPfX0mwXwNl/661+fdJ3yxnEwCSyUm3Kz6s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdbp2xeFmeistNhi0EYR738Q5UTTfwY7ExtyBr0sosh5TC5Up0
	thxW4uIkQwFOoSp9P47HARcZ73FFhvA8g1BoKcv9dc1MEgII2S52KCHFFuUsFLUpo8tDDKIfU++
	ds986q1gUkx6zLvLYgTiEdj+QEq/lpjDTOK3X39FHCuR8QTYpqamFRSGSp+Rf9eUZpCo=
X-Gm-Gg: ASbGncvnV+UJ3Q1j/up0NUHhUkriRUZBU9/Y9SZnl5OpS9uH/v0oesEPJXN+t5Sc2bL
	TdiQ17/7tDjEeH4QmDiPgJ9PKhbzAkG4UAQlRWf/zBzy6esYa3yMd3fBKuJqsXvXgvLNPOFb57k
	vyRk/UJNo/oat0wYTUYYwxEuZZcei+z3jRRpleeuoKVADMWZEyaawAOMnaf6P76HrVOIcUz36M/
	/AlZDkRhHNiFzfVqEUuig4kiNIL6w/hKWvnOfh0452lfy1/GfRATqXYpfz5dT+T3d4VjHkENBLk
	zYaqOX9UspK7O6n9rXvghxVOFlCyZYBK/Db5eQUzAM3IsJRfFY+7pQrA11CEOFfVLKosGMlQP+E
	FL1y6wkP9Al57hUrISIBk5Tlm+/bj34uygC8i
X-Received: by 2002:a05:6a20:9189:b0:334:a124:4583 with SMTP id adf61e73a8af0-348cab829a8mr5100092637.26.1761914057775;
        Fri, 31 Oct 2025 05:34:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkEeYsjWqXGrQIsSrAvcHTdUX4vNYKplEL+CgKXc5YAFxjE+LZqVrETbo1+ALExr5m7cbeBQ==
X-Received: by 2002:a05:6a20:9189:b0:334:a124:4583 with SMTP id adf61e73a8af0-348cab829a8mr5100030637.26.1761914057122;
        Fri, 31 Oct 2025 05:34:17 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d8982109sm2131277b3a.1.2025.10.31.05.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:34:16 -0700 (PDT)
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
Subject: [PATCH v10 3/3] arm64: dts: qcom: sm8750: Add USB support for SM8750 MTP platform
Date: Fri, 31 Oct 2025 18:03:54 +0530
Message-Id: <20251031123354.542074-4-krishna.kurapati@oss.qualcomm.com>
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
X-Proofpoint-GUID: ogS9dETrLmS6clOauBt2yErhBKcVnNUW
X-Authority-Analysis: v=2.4 cv=fpjRpV4f c=1 sm=1 tr=0 ts=6904acca cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=JjTwLu2Kam44ScBvYj0A:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: ogS9dETrLmS6clOauBt2yErhBKcVnNUW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDExMyBTYWx0ZWRfXwKpQOPP7BDqN
 qgpVxgA8vxybuZiWIs1Psy/i0G/Oqne1nZrz8HfoTTbSL+MmJH1fbTrPBm7IQ8+2k6ak7KVUlnt
 KasoEXwSBg5NGKD1DHOFRGxxA8Jo2j0kXNzi6ioxIUuy2YIlD6r9yvKKNN3fN/gTwnIBAFQWvNr
 BvF+Z/tAc032huvpQwZkZDSpL9vzfIfeF9GWo7M6a6cSUdsDCOHokm34xAuwDF+ZS8iVI8Jds19
 O9hvym2/X00ypqNubtKuI5nytY0RlNi9cfGXi0b4JuYhnTouuB1EUtVFDwI8SG6rfN2Gx7OkE6d
 xCDmXhgtUjUL/1rsXCQsi1wvrgrRH5yGKu7Klhm8WGIDjbCRavjewumbn9Y66wMcE0dG7Fincmi
 QeZxMZ9ssfv+Rm60B/7tALr4h8OvCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310113

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
index 13c7b9664c89..c545695751db 100644
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


