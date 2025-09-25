Return-Path: <linux-kernel+bounces-831820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C5DB9D9F9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3FA617EC08
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0372ED17A;
	Thu, 25 Sep 2025 06:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U11XaSTd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8532ED16D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781792; cv=none; b=pgxE/7n8iY8vuEiVtkVqfEMxIqdkjR6a7MHTqQcWNS1JoIBaDLdu+8fFxAB3Q4Zn5ELKso/ry76nNg/AVW4DNlaOAmqeyOqNJ40Ko8d1m1lOoQ/LQQeHG0zKLOb2yyO6jcwM7+KwktFAMTkzCRJ5PNopjNs2x55g37BLoNxET1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781792; c=relaxed/simple;
	bh=9LsryighRnETN2UrxBpydd19TKIhUoH8J1E8OIf9RY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HdWThfe0hK7DEVIzqq+xxJyPsznUuXNdu61NfEQyqDd7M2UPa/1UmWJy13Yn9chFpK8E8EKBadWSWDG99bg2/fXTPweaAMLl/0YAnKCFgB2DIVuaJSzaRilWMWoeNWQD1J8A4WFJnZCADb/vLvOsBIvZewaCKVF3IJ/zke8oIvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U11XaSTd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ONHgxZ027912
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VV4MOx0mlwBQzDc46rG9zmLxghWZvJp0NqZlDVgFSZw=; b=U11XaSTdduYqNtin
	kjfhek7+tngOTDL5if7gtAQVXiQSsKoptxcmcnlibDaPkolJOjs5SoKJWOzHH5rq
	vUCidaUpufeXirPrTYrYAu/78B4/c3HDg7ei9rpKYejg5ZQkVNtvfvKEYxLcKlyl
	Db1fStlw4S/s9fTrpO/k2wUzmh9IXJ5huEtAs8aQkx52kpXN2kiV2kyacFbTyMEm
	AL+niolEOmhRI2vlAQUKX8Ml+aSblb/I2+J7NKrHorLFFZprd2f56wn7pIUsd7Yf
	Vk3gPq4x1gkSimEAcAts3Uacng62U4hBSWItOG4uR6UjJCVs1yuw6yeCIn3IiegX
	/pmz8w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmnycde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:49 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-780f82484faso536448b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758781788; x=1759386588;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VV4MOx0mlwBQzDc46rG9zmLxghWZvJp0NqZlDVgFSZw=;
        b=dXJ/68nA02RFGk5tnKDQ3DAPd8xQIWKJekSGlm0GXhkDZCyGG0D7k4RZ5C3Mbdhrlh
         JOpZARg83GwWSaMth3c6ySo+bNFZ82hsbeStiDNyiefk2jWuHCle28BgDc3YVkzwcqUy
         E3q7mwREw9YEsfNrlQkAmwNtLsB769oPVikojpOPGghmbaj+w4Zgq6d3PMah9LJv3/nw
         oyyOux8PoSSrO5Q95SsFzkjgzv58UjrwF4Xl2576gbDm3n8617Vo5cu5ejz3VUXFqAEH
         h2u0lF4Kstw0/J1o7Z7+2+qCdVQ5G77ENh/x+/C/Va1qgGAv1nBG+1KyuPz0Pm//Pz5j
         PFzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWewtFY6cLVJphBVlynO1K8Vrx83jisoRAJ9e/ftAWS4Tp6IUgceRjVg9vwdAu4bchpoGZ4bIwtAqhlDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRX5SEpQAacBvz0UtvCl+ZIbI01Ip0MfzjD4q9ulMEdZ2T/ynj
	UixTEQLBwBfgCwPqa16KmbP1EDyoQL3IAK2LKzqM5eP06ScNYbv3K37zU/vSZ1AVZiKWA/3jo3j
	rDIRUPLnyWeBdDAWZ/6Otg7qK3YFwf7oxBctOJmfPYIIAP0cWAFdkfl21QU45zX+DfVo=
X-Gm-Gg: ASbGncvJnkGKEwzy4T8cW9XKmINDEaRfBTGkC1O5xHDOdCGQKvlceZjkmZmsonp5LxP
	aJY+6j8cObdD6E+xeD/nOXDPLiMGV6JAaWexK7f02KeGWe+Fninb7+t2MQHyK0nZBgrsY32mWMF
	c9c2YM14Ai9XjbjZ/BstjPXqS9VWRVRpYv69PYY9ZrLAB+seb/jXxLBEksPTMbmAr7j5icXTzyd
	CYwI2Em0MRLof7uPawYFHVJNrSXdf7YBapWCyai51uBs36/GmYhLoBMdJVQ5xcweqVa1lUA1QdN
	PciWDq6jd8ORyPQMDE8bYDJB47ksYOsjMb99hWGJOlZZZUJlPi/aAWjyARlSw5TzBYUeXiC/AAi
	BtQ5tNQVCpTAT6nL6ZG23OQlzMYxPj9RCaVISJ1JTAm1k1GTOdgHF0dCO9WYl
X-Received: by 2002:a05:6a00:26db:b0:781:556:f33 with SMTP id d2e1a72fcca58-78105561ebbmr642572b3a.5.1758781788269;
        Wed, 24 Sep 2025 23:29:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSmaBiNSEZFNTgVGxeiZurLaxid5rTzkr2yDI27F9UmteVsp0PaGzPhMcmhyEJqcPNc3eN5A==
X-Received: by 2002:a05:6a00:26db:b0:781:556:f33 with SMTP id d2e1a72fcca58-78105561ebbmr642550b3a.5.1758781787833;
        Wed, 24 Sep 2025 23:29:47 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810239136dsm952962b3a.5.2025.09.24.23.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:29:47 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 11:58:22 +0530
Subject: [PATCH v2 16/24] arm64: boot: dts: glymur-crd: Add Volume down/up
 keys support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v2-16-8e1533a58d2d@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68d4e15d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=eOB7tIhUYvXyc_ElL44A:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: 8WMsOODwmBvgzOZDMC5g97B4Yb046s6Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfX/Wo40k+Hlewl
 tQQd9xdme1f/xSthWKN3rggP1qAjf/JFyVm6kEE8TH7fQ4L6CxYkRR53mkyDG23JoRRUozGUwGM
 9arTmYDe9C+xlz8w8pbqsiksEkwPnCqtGCXNklqAmF1JCVlhzosP37WcUNwSen03eR9VL/21Nb1
 bj+y0A8n9FoqMtBobaewIwvwYdF4JeSxJXzWFsCoWRs9qDRMAKhR+dH/7ZWKMjQiwO38zokLyFC
 4EWYZtea/+ucx+QMQ4ARB5nm39rnjKz9v5jz/sn2dHMLMW7+RoQnt42wnDeE5dxrKEG6IOpCVUi
 XhBZkkkgYBrMyHsMHFApT1z/hNlub8r/lM0q4zBVZRtSQuRvy7Fr11m8NLvJddope8fZhd/dKWo
 PGDBMJUA
X-Proofpoint-GUID: 8WMsOODwmBvgzOZDMC5g97B4Yb046s6Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000

From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>

Add Volume Down/Up keys for Glymur CRD.

Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur-crd.dts | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/boot/dts/qcom/glymur-crd.dts
index 97f6eedd7222368f5cbfdd02e9c4d87261d7f19a..d6003ae515e37049fdf17d6b604b974dc8e9fbbc 100644
--- a/arch/arm64/boot/dts/qcom/glymur-crd.dts
+++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
@@ -63,12 +63,42 @@ aliases {
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-0 = <&key_vol_up_default>;
+		pinctrl-names = "default";
+
+		key-volume-up {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&pmh0101_gpios 6 GPIO_ACTIVE_LOW>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			wakeup-source;
+		};
+	};
 };
 
 &tlmm {
 	gpio-reserved-ranges = <4 4>, <10 2>, <44 4>; /*Security SPI (TPM)*/
 };
 
+&pmh0101_gpios {
+	key_vol_up_default: key-vol-up-default-state {
+		pins = "gpio6";
+		function = "gpio";
+		output-disable;
+		bias-pull-up;
+	};
+};
+
+&pon_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
+};
+
 &apps_rsc {
 
 	vph_pwr: vph-pwr-regulator {

-- 
2.34.1


