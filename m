Return-Path: <linux-kernel+bounces-807125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED6FB4A067
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 05:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE8617A816
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 03:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D422DCF4D;
	Tue,  9 Sep 2025 03:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q3a+8A66"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6403C2DCF41
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 03:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757390234; cv=none; b=qbUUVTIwzfeCfOe05uHhFKrbVguPmd7XxVYFf4TSIferYLXS0yWf5Jkvm381Km8LfbFr3Mm6kZ4D7KvyIOxa2pBFxRF/cd6XS0LiRDDJeC87sK/M9Pg0hSwiBWrX85NsbtRFEqC1xN268EbBouygvKYcgY3aIaPJHJOVMWgXg3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757390234; c=relaxed/simple;
	bh=1r2sMelXbjk/wDAFKdurvjSblStRt30JAp3AyhW3uRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NOI/XyKaES0GNadypUAjEgYU76JK9WYpWpt8ZsKIVvyoPeJtTba1f9P9l1z9sSxmp2R9VQ9oKum0JKludW3HwujX6/skvK0wsxPW7AJd5E9LfLkhrgR412nr8Ote3+hzc7NQJ7HhH+7EoXk/qlY7DtAUDzA1aohGPyEAPGIdZfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q3a+8A66; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5892EWlP019340
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 03:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2zmm3mqUYRqAp7XjdK+i0CCS4NnUVrAXcuUzDM38Iiw=; b=Q3a+8A66NySPW61r
	vrZBVMMi5lopGOmBwGz1cX5iFs7rora+nbPLbPdSoi3xCw/Y8SxNFV3XpoucF8Ht
	/jCwkqrsyllpc8TjuN3K5fOfU1as5J3jqdGb/0rv+WwpvuNlR1Ns8dnmiLoQs4jv
	AkJVaT2W4WQ1kt2lo4PsxJ6su32rpBeg+6TeWi0kjDLUE5LBB9wlscCA8AXVOMEc
	vNJgyA9ueFZEFf7QcgLjdZ0q0gzeUh5wAhjbVrmiRwYyODidY0v8go8YaPbVtjte
	Re7P+5snh/D241TXkpuntcv63VOt0wpUJGqONTU86oVUXv2bbGluFbXw9CCrnnm9
	FNOAjw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491t37u93d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 03:57:12 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24d4ab50385so58376965ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 20:57:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757390231; x=1757995031;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2zmm3mqUYRqAp7XjdK+i0CCS4NnUVrAXcuUzDM38Iiw=;
        b=DTAJ0E0YzABTptqOpX7XNQewHHDOhBjXVNYQT0DsGVpkNh8iWLPS2vfTSlRok8p7oR
         2DW9NqSDT00EowQJAki19/Xq7OojWpRrDP9OwTgI0ovNEcGx/gtYC9jH+x0GOMfVjLo/
         fSuVDJ2fnI4Ih3+8wLkIEGT5+3tdXNazsNATeBMCYZFj2Fw0jNGcS0bsS19Ibfbxwz0c
         YkO9iYoqnaatTF5c8nNo52GCxIcISORI3iqMu6bz2u4Ns6q+19gyx1NC317S6iba85ot
         jJBEkI7OwivV6dF6nQGZpLz1nl3HWIoOCK/tt/LYanvlHBpCow+QaPTNsB0PNOKtv2p1
         GiUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu6X0MUUsCi5o7K6GRxDvUJ3z90gBhXHtita1GXTIhN6HvYgbXqQ/R4vySz238oAiYMF9zhPyMrZOPiu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3cKnNvsNZf/MpUFEhucieh3jsg6M0GMJMhUTLIvOhSvsep+EK
	ls9HgK/mghBGRT9YwC0rWHNk94vKsh3czyDk+Qjg5jJysN/WvzaJT1gr/Bjbs3eMH8TYxK/0UF3
	n+fEbrhR6efNntbtFBixSGYs1FulQpfP6eFAkvEb4+0ylUTA9b4/923MGHfNCegi6lkg=
X-Gm-Gg: ASbGncukJtI2TiXTtcHzw8TrMu/gtMqmN6os+vtgoOTGzimFtnAjtvyewcdw5U/Hqwq
	8o2iNm6InpEORz6ZVFpDIvPHd/Ih5ulmu+PGFRdYHsCUc4fTBve/ByAeqNT8JNsEKpEzmm8iMqH
	NiKhe4Honul9amd2x+/vs+KNJ8Hi6hgBvPbMJXIuj+nROg9QVY989UQxHd3ApRz2SY5codnfQhs
	iXUMcXe1i/5UibvqeFLac5amqfoMldjeiD9lGbmGutpMTOzqP6tG0fTRseAXmkZXzWXLWv1xMdx
	Jd4hlc1XwFX1xnRqSKGeaflSpDCJpwasHAVYTDRRUpSjOoMHg97ztA7PWEdK/V5UtnAKykxTqLd
	WTwGG2OhUiEmDt5nZfQWdNLsFyYTl7OfIlg==
X-Received: by 2002:a17:902:e743:b0:249:1f5f:f99d with SMTP id d9443c01a7336-24cef940f8fmr192818645ad.22.1757390231241;
        Mon, 08 Sep 2025 20:57:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJCci47uEcYdrrAlKDV74Ch6si8QGfcDx7sIK6ebs5yPJEKcgCBw2AcEFuBlnCX399ax0Kjw==
X-Received: by 2002:a17:902:e743:b0:249:1f5f:f99d with SMTP id d9443c01a7336-24cef940f8fmr192818385ad.22.1757390230798;
        Mon, 08 Sep 2025 20:57:10 -0700 (PDT)
Received: from yijiyang-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903724b94sm295614705ad.35.2025.09.08.20.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 20:57:10 -0700 (PDT)
From: YijieYang <yijie.yang@oss.qualcomm.com>
Date: Tue, 09 Sep 2025 11:56:03 +0800
Subject: [PATCH v10 2/4] arm64: dts: qcom: x1e80100: add video node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-hamoa_initial-v10-2-ec10057ffcd2@oss.qualcomm.com>
References: <20250909-hamoa_initial-v10-0-ec10057ffcd2@oss.qualcomm.com>
In-Reply-To: <20250909-hamoa_initial-v10-0-ec10057ffcd2@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yijie Yang <yijie.yang@oss.qualcomm.com>,
        Wangao Wang <quic_wangaow@quicinc.com>
X-Mailer: b4 0.15-dev-5bbf5
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757390219; l=2903;
 i=yijie.yang@oss.qualcomm.com; s=20240408; h=from:subject:message-id;
 bh=uRYc8tLe70Gcn2K2RcdgjKkdTXcXz0g6iNtU/vtcWZg=;
 b=4OD1sNT5iJU58TyHCkZBdULUQXHTSkIHohFpEmw/ta0iN/g1Azbmlr1WlXoeLhayjISRCSD3U
 tk7RwEr0/0WD/zrE4PiNbHjpkOhUAjpDk+Re2C5P/r4Eqgb9sulhRXR
X-Developer-Key: i=yijie.yang@oss.qualcomm.com; a=ed25519;
 pk=XvMv0rxjrXLYFdBXoFjTdOdAwDT5SPbQ5uAKGESDihk=
X-Proofpoint-ORIG-GUID: ZUcWwK0t8-ztQDaFwQuMQCD0t-0SXvG9
X-Proofpoint-GUID: ZUcWwK0t8-ztQDaFwQuMQCD0t-0SXvG9
X-Authority-Analysis: v=2.4 cv=NdLm13D4 c=1 sm=1 tr=0 ts=68bfa598 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=tEm64AmstYfONosBKmoA:9
 a=Pof-dxJgaamTTWcV:21 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA2NiBTYWx0ZWRfX9qr5p51isd6x
 v8lCj9c2XOnshKk3E1/b6urleb2N6EsKWcmnnrOWAIrATwq1fWFtesNMjmN40YO+aCZU5ohdgQv
 TGZYJGc4XX37U+pgxcBxORBeZ9BuQWuQP1ZHH1Dx6GaPztt3/3wRGR0DQ1w6D72pR7SLJaMx3EW
 7VKJMw4ZXExyQQgyMjm3xPn1etbfn+13dEBuKoJENqy1CVQsejB2KXWbWrbbsD3hdsT85RJvXvc
 iu7jqNOxpsqMeTdaI+pEIbfuzHgliqdTV2nzEn3BoOLuIbWrEpWzN88l+2omFDdhEuaNefUUzMC
 fFwvtMWLyUjlN2HdTzGISEn9Y2Gx/2e07f1Ok8ZOEKddMgwQEOIx+Ry6QqLgST5xbNRUNylFThJ
 6RJ2nS64
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080066

From: Wangao Wang <quic_wangaow@quicinc.com>

Add the IRIS video-codec node on X1E80100 platform to support video
functionality.

Signed-off-by: Wangao Wang <quic_wangaow@quicinc.com>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 82 ++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index e61c9010a3f2..7ddc3fe3e5cd 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -5183,6 +5183,88 @@ usb_1_ss1_dwc3_ss: endpoint {
 			};
 		};
 
+		iris: video-codec@aa00000 {
+			compatible = "qcom,x1e80100-iris", "qcom,sm8550-iris";
+
+			reg = <0x0 0x0aa00000 0x0 0xf0000>;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+
+			power-domains = <&videocc VIDEO_CC_MVS0C_GDSC>,
+					<&videocc VIDEO_CC_MVS0_GDSC>,
+					<&rpmhpd RPMHPD_MXC>,
+					<&rpmhpd RPMHPD_MMCX>;
+			power-domain-names = "venus",
+					     "vcodec0",
+					     "mxc",
+					     "mmcx";
+			operating-points-v2 = <&iris_opp_table>;
+
+			clocks = <&gcc GCC_VIDEO_AXI0_CLK>,
+				 <&videocc VIDEO_CC_MVS0C_CLK>,
+				 <&videocc VIDEO_CC_MVS0_CLK>;
+			clock-names = "iface",
+				      "core",
+				      "vcodec0_core";
+
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&mmss_noc MASTER_VIDEO QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "cpu-cfg",
+					     "video-mem";
+
+			memory-region = <&video_mem>;
+
+			resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>;
+			reset-names = "bus";
+
+			iommus = <&apps_smmu 0x1940 0x0>,
+				 <&apps_smmu 0x1947 0x0>;
+			dma-coherent;
+
+			status = "disabled";
+
+			iris_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-192000000 {
+					opp-hz = /bits/ 64 <192000000>;
+					required-opps = <&rpmhpd_opp_low_svs_d1>,
+							<&rpmhpd_opp_low_svs_d1>;
+				};
+
+				opp-240000000 {
+					opp-hz = /bits/ 64 <240000000>;
+					required-opps = <&rpmhpd_opp_low_svs>,
+							<&rpmhpd_opp_low_svs>;
+				};
+
+				opp-338000000 {
+					opp-hz = /bits/ 64 <338000000>;
+					required-opps = <&rpmhpd_opp_svs>,
+							<&rpmhpd_opp_svs>;
+				};
+
+				opp-366000000 {
+					opp-hz = /bits/ 64 <366000000>;
+					required-opps = <&rpmhpd_opp_svs_l1>,
+							<&rpmhpd_opp_svs_l1>;
+				};
+
+				opp-444000000 {
+					opp-hz = /bits/ 64 <444000000>;
+					required-opps = <&rpmhpd_opp_nom>,
+							<&rpmhpd_opp_nom>;
+				};
+
+				opp-481000000 {
+					opp-hz = /bits/ 64 <481000000>;
+					required-opps = <&rpmhpd_opp_turbo>,
+							<&rpmhpd_opp_turbo>;
+				};
+			};
+		};
+
 		videocc: clock-controller@aaf0000 {
 			compatible = "qcom,x1e80100-videocc";
 			reg = <0 0x0aaf0000 0 0x10000>;

-- 
2.34.1


