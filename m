Return-Path: <linux-kernel+bounces-854587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C39A0BDECC2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CD100356D97
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6AB2475E3;
	Wed, 15 Oct 2025 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BQZEOMkg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F3A23314B
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760535763; cv=none; b=QImWZGZOhMcaavfdhySeTpW0h4l9RgE95y5aFQIfOhtR+lJ94BuDGpYq21+GQqSO4eE/7JOqCa75nLuFFTL3x+YbvSe1vKCpIc83p9yd/meELtfViUZ2w6rP3Q7zdKHTCtckL2XgZNc4LzCLHZdPVGpkDkfj+QnYFmNDsPwLGbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760535763; c=relaxed/simple;
	bh=PBQh2etxK1f1LTUrNCY2I1fGG2Es6sPC/p64HJuEj4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pcwEORAfUkIKx80t5+0P90ULIpXMJ6rOqUWFbB8JpWlqD0SxMQGmX+ggo8wBhyecMYIbIf+G78XZjB7M7VaO6t5rnlsICm2GoBf1pZFFg2f50qn/Hoq57lmfW+ugK6ZVDcFSgM7E7eE9Dute/kFHnmLFXYoOW4YIF3wyx0sGoqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BQZEOMkg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FArJJH003664
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:42:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=H+F/Zx1E+4LDjkQuE7qBfj
	1kxTU3KKLrksPW74kFLG8=; b=BQZEOMkgZWQgu1cKzQd97L1i8RxVHw5mVGK5+5
	9bQFG6NPfJbbad6+yMnw4qSbspov8zubc2EzVR9dTuluEotrb7LX75vqwCGIxxwZ
	B9LMr752wE/uJP4PKEDQ8BFrnG2LOk4KnABNYJnVh2qDfyVuhKipx5VSglUBXuB5
	dQ1tjJNgfCto2Q0dKpgkMwIgUHQHqAr7RikNcrD993GrYyxDSZAaoXbBbcc1dg8P
	K0aHkW3A2sFJTT035ohRX3Zs+/DU49SU5JGT2nSfjHPMX0cnJNNVHOOuCqEnwHJa
	YqsHIcWA5Hxd4Kqic8YjV/hdJZKIV8Evqo5cI/+dk+pqat9Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd94ms9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:42:40 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b650a3e0efcso10493540a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:42:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760535760; x=1761140560;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H+F/Zx1E+4LDjkQuE7qBfj1kxTU3KKLrksPW74kFLG8=;
        b=BA9aVsFNnDiI71gfciZ/nvjF6IXEQQMUrv6DjEDrA6SBHemEqFvRPxhASMG/8ZBf9x
         NtYwu1VFrxhy4UWiuVj7KkxpEYnzKcrApSz0powrGrRjsuVF8wK0STMhhij56DAIUT+c
         qdycqqhSpflialDDNv2ogmTFhYmOX04oWXuvoThrkyk4WvEGYLklyETjCnDNJP4tATnR
         +DFsmVJAwwvhHc42iirS12g/Cm4dD2PgoFsdb9rSQ4vZIKmnmzUsFa0/1lW03xTOpPbP
         qI+GdKqadW2CoxdRqTbt8ETGisP2oeaw17/ZGyAlYtDN5He37tvapLdaAMrHN58Jrp98
         VBuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHzozCWQSsuiJyg+RlTFpgG7Q1DiYZdfZrJDO5KHezKbLtCMNMmMewUhce+zReDPxSzOF5d14YUZLDuHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXzP34jZY+jd9kBch4/WUlI8ktXkdYY9ZFOMSHYI08fgBgBrBD
	Wso35E5Fe/JETLiRTuCFIROTQPS6LJqaqWC8JJmTt/Ixd96oVCd7tNojyPy3aNo1r305U9UK/xu
	n1HPOc2J67bvAhWEL6TjjthlMkO5npTumBTlKLBvo3+BQrwzCshCgnf/tAMyYOUoiqA==
X-Gm-Gg: ASbGncuHjdOZesmnM+44c+RjQUWx9hQUq6x+Z5dFRORU3OhIYM5/tKn2KLdGxots/Hc
	W8+sAnoWsmucVkYLrd4YKlVORHt7cMAMHS19zS6xhX4EUBdfxZ7wAxVsKsa79OvUszUZiui6x6E
	HRxibQX76IPK8QGRIodR/xfq3602atgGoM4DDYweT8043pfO3dQ99Ag6X8LeOwWlNm228AEdyoV
	CdD0d0bkpyvtFc1/VxeEo8XFReWP704F6iNxOmLyNIPAsUuG66s/0FTw47EZ7Qzd92pHRM0OWLZ
	igwY4ubMdLaReFtRh73yCCBOeMkfMHBK60SDEBVHbbS/Ciyg9B0pOWR32p17OQU89lRq9w==
X-Received: by 2002:a05:6a20:a11f:b0:32b:725a:d684 with SMTP id adf61e73a8af0-32da84616efmr38547261637.43.1760535759731;
        Wed, 15 Oct 2025 06:42:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjUPUFdYaIufIIt8S8dui225qseRVZF4bOTg8Kqh3cjfmBmHA0/by9WGvbGn7zbMYYmRePQA==
X-Received: by 2002:a05:6a20:a11f:b0:32b:725a:d684 with SMTP id adf61e73a8af0-32da84616efmr38547211637.43.1760535759170;
        Wed, 15 Oct 2025 06:42:39 -0700 (PDT)
Received: from hu-kotarake-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992bc18c96sm18849417b3a.37.2025.10.15.06.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 06:42:38 -0700 (PDT)
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 19:12:34 +0530
Subject: [PATCH] arm64: dts: qcom: lemans-evk: Add RTC node for PMM8654AU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-add_rtc_node-v1-1-601c9663422b@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAMmk72gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0NT3cSUlPiikuT4vPyUVF1DYxNLgyRzAyMTCzMloJaCotS0zAqwcdG
 xtbUA7V4Sm14AAAA=
X-Change-ID: 20251015-add_rtc_node-13490b702486
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760535756; l=1110;
 i=rakesh.kota@oss.qualcomm.com; s=20250919; h=from:subject:message-id;
 bh=PBQh2etxK1f1LTUrNCY2I1fGG2Es6sPC/p64HJuEj4s=;
 b=RlP8WWM4kyq3AY2tzV2Uxdz6tWHlt09Teuf+elIYO08JDrdBX49xY9wb741nXhp54kvu4IJ2Q
 YksN7jOqQPwBbS9q1X9qFYQx49wpMtWzNXnmHdex2x9Klzvea2l2wwN
X-Developer-Key: i=rakesh.kota@oss.qualcomm.com; a=ed25519;
 pk=dFhv9yPC8egZglsSLDMls08cOvZKZkG6QQn1a/ofwNU=
X-Proofpoint-ORIG-GUID: CeeaD_65Qsk-BgTKR4kOTRfuhvmn2F62
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfXyJzgfc0993EX
 N2UkPoreBk1ZpTmNrrGup26OxJO83mHtaAxlsCsOI09NRC3wcn5jCkoigLQOokBjv+5w7bswxa7
 JegVxR/ZXY+UUsn6dvgDJX3cOzCh0te6buOKWqbHOOtZ4yciYO94012KKPV5PrJ7ehVe0HFZcJa
 YNYJ35MluRh1zRV5WkiYqg9aP+bfu2T8yYs5fz8FX2HKMeRuqyKe8BFlAFkKjEmz/+fMgT6cmEn
 2O3gobqudRLO9132YMQ4Y5Rz+nrwW1Ovp1ufiZSQEP9mASvR+HFgNoCoZJQP0/RU9oSpz7e/XKx
 btNegcpjQrGa06i0w2nFJE4zkHONrkY+PahVXJF0CRtWhRlkX0wvxhXfFX9MzaqDQG4ZpNWq6vI
 ZnNcRV/yhrQh4FVBZYItvY+XaXPXPA==
X-Proofpoint-GUID: CeeaD_65Qsk-BgTKR4kOTRfuhvmn2F62
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68efa4d0 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=-rC6o90vqo3ez8JSJP0A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

Add the RTC peripheral node for the PMM8654AU PMIC,
which is controlled via the SPMI bus.

Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-pmics.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-pmics.dtsi b/arch/arm64/boot/dts/qcom/lemans-pmics.dtsi
index 1369c3d43f866de9d8cd5cd4985241b99c0a0454..4eda7043b851f363d0bf053587fb1f5edae0c4cd 100644
--- a/arch/arm64/boot/dts/qcom/lemans-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans-pmics.dtsi
@@ -142,6 +142,13 @@ pmm8654au_0_gpios: gpio@8800 {
 			#interrupt-cells = <2>;
 		};
 
+		pmm8654au_0_rtc: rtc@6100 {
+			compatible = "qcom,pmk8350-rtc";
+			reg = <0x6100>, <0x6200>;
+			reg-names = "rtc", "alarm";
+			interrupts = <0x0 0x62 0x1 IRQ_TYPE_EDGE_RISING>;
+		};
+
 		pmm8654au_0_sdam_0: nvram@7100 {
 			compatible = "qcom,spmi-sdam";
 			reg = <0x7100>;

---
base-commit: 13863a59e410cab46d26751941980dc8f088b9b3
change-id: 20251015-add_rtc_node-13490b702486

Best regards,
-- 
Rakesh Kota <rakesh.kota@oss.qualcomm.com>


