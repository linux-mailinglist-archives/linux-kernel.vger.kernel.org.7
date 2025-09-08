Return-Path: <linux-kernel+bounces-805295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FABB4869F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 405FD16A3A1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320962EA752;
	Mon,  8 Sep 2025 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="See+D8Ax"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBD62EB5A2
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757319634; cv=none; b=rtuZO6V94DHrDv2aMCS9uIqBSDDKjEaY9OdYanJuzYd4mpDTKUVFf2QWVfwNtuw34Ka8LJC26ZYH1bi2m73cJytsz583dJCCpQ9OIXZ0yYxWt+mRbyVTYR91IHDxIMoXKEzJehxjM8mppYfAzKRBfsAfOauKv27PT9QLn7WqXhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757319634; c=relaxed/simple;
	bh=ud3TuPggLahDGChDQ1o7XXbj4HVsLOYi90l9y4PcyNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z3Hf3PjTrOUT6eOmTqlMT2G4IThyAQLvaqIWQA6kTz8UOn9K5vXLeFAF6ukU5myCfRl9Hw2ON2Unbq61/EUWUfn/jrOOKbfKkgkffq+ms+4yuJMEXopD6TjOQwDa4HgdxCGjTsFD/p2JL7BSvv5mSTFDqD2fFaCYiKvJJkHYQ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=See+D8Ax; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587MKAsN001547
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 08:20:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y7cNk6IecMVebr618FdTJPAEvTMA8XqQdB5/864dCQc=; b=See+D8AxF84ZaO7f
	VjLUDEfJwHPDwXoWn7kbdFH6yNWdgY7uBKAYMRKR/5giDJ7Hh02DnxtR0AFadNH7
	mz5og+gmKz/p0xruK63mZ+yhzZOmT7OCOuOzwODv7xxUHPgbcjuv6z7Df1cyApQ/
	njq5sUJP8tC+aY8K/oT1DYmXPZyrJyItgMF72IPzM/N9K2+guC65Q85+T2V+uIC2
	omzJZpL96xJaruQfltqUT2zX0bPhK8r0rJP1UyMRGSOaNYjl+BR1WVXc7U8IQZEn
	pt66e7ySgCaYUB6fLMvF9hPKhWkNpCUqFUYb3k2ujmjK3nBmQpeKSwnf1loA16L/
	vQSpmg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8bsxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:20:31 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24b2336e513so64541905ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 01:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757319631; x=1757924431;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7cNk6IecMVebr618FdTJPAEvTMA8XqQdB5/864dCQc=;
        b=LhW8J0zK2FXs9f/JNkkOWxw2wEvDG8Sn32fOko8Go1LWVjiamOfaf4VCCTRDXL+nRL
         siRIFlncIzS3MrqNlfztAir7KGXKChJevKpX0X4ubEgWJrllB8p9Hh81ULVC6ljmxyjK
         npwzgntu3VuHi+LplN+Vrkz+Y4XQgY9tYCnGry7CF7+JUCq/gmf+fZ6+DyX7mSWqgr0m
         rgpND+DBvkZM1CfxvQcdQInsIlKInZeYiuhrSC1mE10y53+AV42SZzKCWTbuv+DdHTHx
         9haRs4cCJjp2gBACGCTF7ZyckY3V/fVW6PXra5tIuF3RWmIqdd7zoBu8OHYigLNnupTR
         P6Gg==
X-Forwarded-Encrypted: i=1; AJvYcCVRUS22pNrv//r5g8pyIRH8zYi4x1Dg6AFmWbo62+whVMMWYzATXeruudQwgx72JfBWFEukpDoNB9snPS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwddI0atONiHgV/P+lPNfpb0k/dhEDaLKgCP5wRTve0JMAoFC0R
	bd3PsB9z6XO7w2Y225ju0WBm/klpLqPMmEHP9g+cBkFQof064i8u1o+Z/lPPMBeZMb/pO+2Leik
	r9o5kEV2lyxAOhtQiDqBvziccef9qk6GzdCi42QnwRVMf8+Nrp1dCQ96+L6d7yd7hYqk=
X-Gm-Gg: ASbGnctC+52HScOGSnXcTXC6F3++Cr0GIKYoJFwFXRn0TpYlbZ5mkcgTPoiWwzXwuHC
	Ab+uWJNq5B2QZsyt6fgJj3cI2rMP3R/ZEmR/3aj+Hqx5yFu0y7CYqZewHg3uN+//I12hk0avZou
	QYWgy3HgRddFWYRytSgqtaH9Hh6+YLSs3K4AcvlZTE3oOntK/unYkGbpilXdhdQYEsSV10ETk+2
	ZO8qtYI4tkWG9LuNjpf+HtKW6gTNbEzJGa7DQ1gObQ3hwPGazyUOyvOnNr0n2uwIMYn9mxYDVb4
	nK4LYLpvo/eNqzJ6VUld2XxIN2rKbt3SBSAxznOHioXYx3z1sZcmIQX7o+qQRdpAZgb5
X-Received: by 2002:a17:902:ce8b:b0:24a:d582:fbaa with SMTP id d9443c01a7336-2516f04ee0cmr106344065ad.12.1757319630229;
        Mon, 08 Sep 2025 01:20:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU2+Pn3pFEGWPMZXwcqWfe38DfVXT0Rgjw4TxXRkh6HKMpHekVGqpZgUJunuzabHm2j/OvPg==
X-Received: by 2002:a17:902:ce8b:b0:24a:d582:fbaa with SMTP id d9443c01a7336-2516f04ee0cmr106343655ad.12.1757319629581;
        Mon, 08 Sep 2025 01:20:29 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccfc7f988sm104852845ad.144.2025.09.08.01.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:20:29 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 13:49:54 +0530
Subject: [PATCH v4 04/14] arm64: dts: qcom: lemans-evk: Add TCA9534 I/O
 expander
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-lemans-evk-bu-v4-4-5c319c696a7d@oss.qualcomm.com>
References: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
In-Reply-To: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757319602; l=1307;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=jewA1ZuLrE/ryGMwa1gffJep1WWzoOZkukzHH7TucfM=;
 b=i9UWS6iq/NvrnGVeENKuHD5pzIRUYthJoB6yM1Eyw7sVIHrJwjlTu8pkSBmTCXd9ZbMx/WCOa
 JV0jF+D6AGnDzZ94UZQCW6n+UQmZrlDbSo4PlLz3htX5eUNiirnba07
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX6N3mujbigUMD
 kk3Q6ZipRvKFYm4DiPdKVDqolx4fXvWWHBzZ5IdbNzZ4jsD6YjkTmECvTlXH14ZqWPDMifTWr2q
 uyjnCHYLTjdp2DarO/Bk68jo2oDZEvLugY+IWWj8uVEpBf2XAPq+kwT6Q6t0lFFj9t8oVaxku6l
 8C+zF1zY03gnRdfnO5rEWnXnPAhB6xEHASaDciZnjDbUmz+8Hbpan1O6cyRkF50qdrr+x0vbbCM
 qOAOG2DsLz7E5CfVOY3kRv4uisdegSNomrDo0rQqcZ/GIO4FEcVx0TXxxASSRRfyUf70yYCdRLg
 WhyvhfMYgtai12DBBJz8JrNyrjEvki9Ycw7zbn0Ac2Jb2gi9tIHO423uaZsoUZ4gPwniVEcACx2
 0lB1jvbk
X-Proofpoint-ORIG-GUID: 2RG8zF-Ry-COZcFJ4FsmvqPlS1bhV_Df
X-Proofpoint-GUID: 2RG8zF-Ry-COZcFJ4FsmvqPlS1bhV_Df
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68be91d0 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=itmwO_cg3X_j9a1xKB8A:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

From: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>

Integrate the TCA9534 I/O expander via I2C to provide 8 additional
GPIO lines for extended I/O functionality.

Signed-off-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 56aaad39bb59..c48cb4267b72 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -289,6 +289,38 @@ &gpi_dma2 {
 	status = "okay";
 };
 
+&i2c18 {
+	status = "okay";
+
+	expander0: gpio@38 {
+		compatible = "ti,tca9538";
+		reg = <0x38>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	expander1: gpio@39 {
+		compatible = "ti,tca9538";
+		reg = <0x39>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	expander2: gpio@3a {
+		compatible = "ti,tca9538";
+		reg = <0x3a>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	expander3: gpio@3b {
+		compatible = "ti,tca9538";
+		reg = <0x3b>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+};
+
 &mdss0 {
 	status = "okay";
 };

-- 
2.51.0


