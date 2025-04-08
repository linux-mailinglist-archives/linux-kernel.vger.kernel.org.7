Return-Path: <linux-kernel+bounces-594009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F613A80BE7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 15:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C281BC1078
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 13:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F74A204C32;
	Tue,  8 Apr 2025 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NI4ClvuO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024471DED6C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Apr 2025 13:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744117826; cv=none; b=nEDItJN6Er1KiCwox+WKUoIvjn0sVm9VWguG00IyTn9OH5tqgSjAaUQer27dX6DalwC/yFrtGHCQjTBNcAmAFBwkqzclDCTVQXIKZCky1hSskJa0Zes0JQQWXPb6Mrb+Iqqqp0lTLUCoywXGLrfFikp7pZ711Gd1LFdTrkVOZrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744117826; c=relaxed/simple;
	bh=wmcbvuwfcexkF/IZq5AXxakmuiHkGVEOuFwNiJ9zpng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=a10w/FZIRju8L9zhBlZIeZnVBOKV1tCm01iS5aA+ImbI5DwmqDyebuMHjNR85+LsfR5eAbKF+eDd3/RmPTNULqn7bjJw6O4oSeWcJoDH4eNRgA6Xb7gH8GQrH0QZnYA9Mh937hk+lOVI0z8P3KpROviJO3PO2qMtLTB96tcF/VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NI4ClvuO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538BEQTO020065
	for <linux-kernel@vger.kernel.org>; Tue, 8 Apr 2025 13:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5UBWW4MRrgta4eIXJ9yYXc
	6dcVrwrrFfqWYMy2Uu/k0=; b=NI4ClvuO39OUzvCXEef7OTJniPpNB7FhjGWtjF
	TZgqnc4tIxDl/cFF2AvYmAazLljGuT9/JFxYMC7+TUUyo9As95bPsLfzafbfPH4M
	vfkL4WY6ruPAzXCJbeWjkFezTN5bZxpiNlORu/XhB6qxBxwzO1suqr5wdummxbfN
	y37Vs3kBADMNxJHDlG+l2LGQa6RyPvZvpiXCdb3/eLuJ121+Om0qRfZQTNyIxnZT
	WRJqxgWcB6tl1A8HhznjJMf0N3gvZFZBflbVk44ppM8G7CSTHBFY0tsgfREvQe/0
	NV8tuXHb9x2CI9xzcxPvrrumKWLDhUhHEEh4gF74dlCzk3Eg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twdgfv6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Apr 2025 13:10:23 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c549ea7166so904858585a.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Apr 2025 06:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744117823; x=1744722623;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5UBWW4MRrgta4eIXJ9yYXc6dcVrwrrFfqWYMy2Uu/k0=;
        b=v3gdHJ5P4s8eESeJfrLtniEFe4SopHwPBI8shAqvfFweuQKXaaGx1FTWAZEkueRLS5
         r8YpAA1Yw1k935aR19d5SWYOVFWRK1pC0hcT8CrjETQyJWUjivd0j7QeOL10QxOiTCdQ
         +5be1sB7OQg1ysq+eOodWOcJdbGOFYkAi8BwXastcVt2YVL5bgNJ7JLCuXmzEPpmuVA6
         6Lj1nqkpOaHoUAv0kwrdAH/p/aUesfCgeJTA+/sEaez418/UUpKNc/uvMTpANDdjg9Dd
         j8ABgOEWs6NugrytU1OfGraw6KJhx3te5LKL7IdIiVP7RwgFNLvv+PaIfTSjN6sX5hov
         Honw==
X-Forwarded-Encrypted: i=1; AJvYcCVwKevjXhgwlSSc5YZ3SvQ2xpPLh/lDvr+Q09owVwNXSJcGfbFHLIRe98dcO6XAmoEn1Kp9CKNkVIUU5mE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1jwyhZisDAerZ5/51j1aTFHe5EA9i93GYsvAhhNnsdXoE2tY9
	oZ+AqMjgJinv4guZFb/g84kEYda4H7hTd5RBBvBRyOwppAMWcvljcBjLskZtQ9/l+O/BhC3ix0B
	0VBTaEju+vcEPpEROJrhB9HB78Znw5q3amTcA6iOyWCqn2aOU8yhbUJzPNr05HLmHcZHkZcw=
X-Gm-Gg: ASbGncvLZ+mK7QHgERUkCe0YRtPtmVaHYedk8L85T8tKr/si7B0kSpQqGaZUtaCu9fd
	n4ufP+J3ncSRYskjLGo8F/rOXKavZ3grTNK1cC41gYaCu5Lkj7b+YOokuQDWXyXy7xNxVgdIgI6
	+OgSHoxyrRPviVtBlCKFppighLVV7o7SxURFYQ6MDl4tYCEqUVIaJHzz4H2RJREQd/l3aQqO0dF
	+Zvxv3UIVrF6fR7RfmLJbMdLUKe8XQyP3QC/A1k8t9PYk/mKfh7aveZ3eXeJwepcIeSNVKzCXsd
	tL0j8x/EAmSxCZZiC3CkqnCoX88tXV934yjEnNsJmMScvRZeq3GZAPKs/X0kHh/eTBE0y92EXZO
	oYmVNjyP8AF5NYjVp9VKUEQcVebI8
X-Received: by 2002:a05:620a:40ca:b0:7c3:97a8:901c with SMTP id af79cd13be357-7c774e4ba4amr2246818085a.53.1744117822650;
        Tue, 08 Apr 2025 06:10:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKoJuWHnW0lE7wkJ2sSIhMNy1Bxs/JmW2vMjs80QwWr8TuvnplUD0b17fUpjDotwXYWysf0A==
X-Received: by 2002:a05:620a:40ca:b0:7c3:97a8:901c with SMTP id af79cd13be357-7c774e4ba4amr2246814285a.53.1744117822206;
        Tue, 08 Apr 2025 06:10:22 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c1e5ab889sm1514837e87.11.2025.04.08.06.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 06:10:20 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 08 Apr 2025 16:10:19 +0300
Subject: [PATCH] arm64: dts: qcom: msm8998-lenovo-miix-630: add Venus node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-miix-630-venus-v1-1-771c330ee279@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIADog9WcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDEwML3dzMzApdM2MD3bLUvNJiXfNEgySTNMM0Y3MLCyWgpoKi1LTMCrC
 B0bG1tQCETl/FYAAAAA==
X-Change-ID: 20250408-miix-630-venus-7a0b4f1f3788
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1021;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=wmcbvuwfcexkF/IZq5AXxakmuiHkGVEOuFwNiJ9zpng=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBn9SA7VNUl98nBv3ZNkD88KYglSCweZUYPxLyTL
 mCsUeWPNIiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ/UgOwAKCRCLPIo+Aiko
 1aktB/9/USl+Q+vHI3iIzz4QXK+WZdXBO18AsdRDQ0iQrwGu48tunrs5c076iK0LMbleV42Cqcd
 e+RxWus5cZSE4w/uRoDGryj/IhAGAkQfvubEOeK8MsaukPzSpGm+TYDLiJMwUzIne3EgjDhELwg
 BUJYTx2HmX+oH7SsnHXyNnMB3XhqUGhsi0UjAP/To4mWSpER6gBNq/2UT2wFrwrCCC22Cc1o9rm
 fsab6zH2PnrXJWl6UKkrqgQeLuv66mgRs0jbY9OXKSv8SjXPmCyyWNYzuno0dWdlGe0fO7XedoU
 5sx7X9JwUJdvYfQequyzuKn42R2mdzXBvPK66ctodBb8CE94
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=PJgP+eqC c=1 sm=1 tr=0 ts=67f5203f cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=TDdjnMeiFjqKsEOA0EcA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: UlsFr2Q8t60PxHsHtsd6xawhB-i5-FT8
X-Proofpoint-GUID: UlsFr2Q8t60PxHsHtsd6xawhB-i5-FT8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_05,2025-04-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=928 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080092

Enable Venus on Lenovo Miix 630 and specify corresponding firmware file.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts b/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts
index f160ba562b0af505bdc1357731f75a394b5eeeeb..c11b972771c3881a57ba5a4dfbdcea487da7c6f1 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts
@@ -100,6 +100,12 @@ i2c5_hid_active: i2c5-hid-active-state {
 	};
 };
 
+&venus {
+	firmware-name = "qcom/msm8998/LENOVO/81F1/qcvss8998.mbn";
+
+	status = "okay";
+};
+
 &wifi {
 	qcom,calibration-variant = "Lenovo_Miix630";
 };

---
base-commit: 2bdde620f7f2bff2ff1cb7dc166859eaa0c78a7c
change-id: 20250408-miix-630-venus-7a0b4f1f3788

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


