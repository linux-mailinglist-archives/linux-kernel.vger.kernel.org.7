Return-Path: <linux-kernel+bounces-735301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D01B08D7F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA45E18934A8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C190428982B;
	Thu, 17 Jul 2025 12:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PsG65V6w"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E312D6606
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752756705; cv=none; b=uXoOeiL3o78hnhc9CNpreKopvLX8VyCYFkqOeSRyC2Ae1l8qa2bXsnyopEjYRtCw1zQM661ZKpZ4TFs8XtgBz5yZ+hHz8Dd4VRPzum8lA4zqE8RkT9zII4yDIHSeJe7TlJUyqDJCe3PokbaloGkdqL6byKs3sRavUn52q8vDDr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752756705; c=relaxed/simple;
	bh=Qk88581FUbK4p/GWT/1ubaIiHrFF5OiDLZOj+m9H7N0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CCbfwKzkGdUvctcXKXJeLTLcfztqiRfAlEe+CZg7mekLm8O3RoLxl4OcwGUKBHMiXIJ6sHA0fjJJV3lNuaK/LelIYfiscAlX6mazheHxFccRXUDPf/sb8F2uMbtMo6BK/peLXx8Bz+ie7ZIGBjQofn7ES6dP0LeTitcXBwRKfXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PsG65V6w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCU39B007457
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:51:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+ag0zs7yTwyyT5N+EMenXhXzqVE+SS4xEpUuAzDVO08=; b=PsG65V6wEFHT6IPm
	o48eAmeB8Lj6kdN7731koAa1kQXbPrSiOYecI32tXsSuRI0EtWAQ4HxNkXwkOnuo
	sdGAWoBbvVGDKi1Ndr8rlX1bpRETmi3Ho9QtdSIHznlJuySlaHeZKwxWwzwSC9+x
	nM5yN5Wl5IXEOrdHD7EGpBUQi57JpbMeIsf/gVGaMvfV9OOox0YjEdyNVuPabtQ3
	VGVyi3zw5zvLdzlWYW59K9NrXeuGhgNZfmVZiaaeAoB7TJyTgiAVA3VasaqF+Hy+
	MBUkys69xiO9OAhiiG6YrxWk0z3Z0ZnsYq8vZDtYDT/oMc18J5bLbW4JzXO/Rq0S
	35+12Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wfca8v7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:51:42 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e2c8137662so152712185a.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 05:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752756702; x=1753361502;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ag0zs7yTwyyT5N+EMenXhXzqVE+SS4xEpUuAzDVO08=;
        b=j52gxjPltDyVek8ZBgBI4H1/0GbZ4MRqn9CtWU0cyE3DK4y0O/hkjC+y35uYJ0uAoQ
         XUG/khoN/20YCM6J1KWE66AWvSw0VVOgIJwUHdQBoSgo+kjVhE+NX+rdMBw1BmpaES5Y
         7AdhZHBiWt6tCWAiMtky0+wXu1QrasvTzXKNdKjxjBiy67XXtVHhcWudopOsCTzcNJIU
         3skZATv5Tc3vxebGI/kQcF/HSHflc6GDOcXY8nnF2mabcSM0FcVDHAhfBZFgkltFz9ig
         UKd9kbFXstvjuMlzGmMzH1UcJ0R+y/uNJwvzBPTTRg6i8bbXT0OcPKV1sHRjLGD7kEOc
         kDmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWORRejBmo9p0IzNS7VgJj+319hAh/iLMoALijcUs1wkePBpFBq5Zi0ci2hnlnx8pDj97OdQy09kK6S59E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ms+/Wb42Qvgrkfza0rb3VRk2cY5YcVVJ6YbT5fn6xWzeB6jL
	krGYftw6fUz5ZTkwNHlKDDTqgY+EGwTmI3lt+21QQrsWlVwv1j9SKNXIUOkdqVgnCgT/bxIdnV8
	lYKn2iJgynp/HTqHlEDwD8qP9z1gQCj/KVpFiEFdCbLiMgzIwQ9mzaNFz4c6DAem3hr4=
X-Gm-Gg: ASbGncu0Nz8GpREveLRnC4i/MGYnb6CwHUlE1PjkNdMd05cld61he1JOyO6IWEufkus
	64KRSv36OBf9en0BVIj7VEGhaFdg6RtbZYGxQ1Bn0WM6qDOEcVEM7wipcL9ArWPbtFYLq1/IhHw
	hnMY1SrdP09NgUgKMvQ1z7sXwyLVk5uo2l2iSOJzs9qEhQ8nUbFuU7PHdsL1W6OfqHSFum27b8s
	cqTsJx+JQ2i8QoMd9lFgTLOGRusqYlpl65P2DP6f+p9pyuE8dyk//ZvVSB/lp1o5KzYuxFlpkN0
	U270XUzSf3ZhomtZBLTSQTTr5r75nXhPgUyhf+30NXYUHAqJrOXbo4WTc4Fy09cBRZpm/c1no9C
	GhbfKSDJ1C1O9HbMvMjtD2EnRwd+JqLin1VSpzXg7av4Di9WWuwG4
X-Received: by 2002:a05:620a:4043:b0:7e1:3b7d:f47d with SMTP id af79cd13be357-7e3430dcdf2mr953266985a.0.1752756701504;
        Thu, 17 Jul 2025 05:51:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAW/ycmrqPsNgyexXqBPg1Pu66hl1sASOLgzQnKNXfesWd7tzOjSI3vKrBGgwJUilS9CaM5Q==
X-Received: by 2002:a05:620a:4043:b0:7e1:3b7d:f47d with SMTP id af79cd13be357-7e3430dcdf2mr953261285a.0.1752756701031;
        Thu, 17 Jul 2025 05:51:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c9d08fesm3032872e87.126.2025.07.17.05.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 05:51:39 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 15:48:17 +0300
Subject: [PATCH 2/4] arm64: dts: qcom: sm8150: use correct PD for
 DisplayPort controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-fix-rpmhpd-abi-v1-2-4c82e25e3280@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1038;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Qk88581FUbK4p/GWT/1ubaIiHrFF5OiDLZOj+m9H7N0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoePHY2bOOJk2mbEXau2+C2+ZcIWKDu5MpHBmsk
 sgdKWof2v6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaHjx2AAKCRCLPIo+Aiko
 1YVqB/9rBWWHE/LLyyqabOJnN7BAGnBze2DE8QPL8isgkc2l/3MVjr84qdsAzNJsGDVyEPw6PNq
 +IV3wuzZn8bfjxMGa7YZozSMz8Y7vXqwWA8JaUnCOOiRbhvDqmnb2Nh3XZAkv6f2InHseW+Zh4q
 DVzUhyNDLZ1xhJKqt8SLZzNIJvVToVbaPbQ4Rtyld3LHzKH9je+3HksixU+KV8TdF/jHiND/b1t
 WIpm/ROFnpajr2k/ohso0uPRSPYJtY+uv8F4Q/SbMJGD0sPJyeDhEF8r5q2ZS3DBgYpzbbbHHCS
 La0jvBpe5c3cDCiV4b/p48PJ4wjwmtlz8t9/tJCnDXGJvy82
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDExMyBTYWx0ZWRfXxMMsHcMzttWF
 DYse7kCavMD/rYAI69reoqLUafVSaNKA87us54zhQRu9yUfWqjqxAhPA8ejKm5DP6sSVwwxKFSz
 zATMIR5H0sR20NjXxIuvfiYAf9vD5db6045hzzyjW3xKtkjVe99NY7O3uXoW/4cmuB/+dXXCJP9
 r9885IHyaCo5O8CfPaH7itS/Y82sre/qICjWGludRGiihX+QshjccuLuu2nAcie7CVmf2FFP3Gf
 Sg6kDLN0EEdtsOdtHyFlVZlOeaNGOrV1cesEdoDZ8yN0wXZQYSZrd3RKfTrLrBwl+saIDOakYvk
 hbShR3fhajiEw7ApwtPPoRTSbZfzJ01p+TmqghdkFUEfsUv+djCzufoDRq4v0M11NEgsSF4rgjV
 ZU3BIYryRwq0QnsHFU9z0xgO8qAirc3kP9mLv86sdEppb+7XB0bBP68f+qtOGbw6HUH58evU
X-Proofpoint-GUID: 8bQvqrVvmSL9f78mmRnhxrzfTrY1hS-t
X-Authority-Analysis: v=2.4 cv=SeX3duRu c=1 sm=1 tr=0 ts=6878f1de cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=7pnVX8DWB20M0aN1Zv0A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 8bQvqrVvmSL9f78mmRnhxrzfTrY1hS-t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=744 impostorscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170113

Commit 5dd110c90a50 ("arm64: dts: qcom: sm8150: add DisplayPort
controller") specified SM8250_MMCX for the DisplayPort power domain,
however on SM8160 this indices maps to SM8150_MX_AO. Use correct indice
instead (SM8150_MMCX).

Fixes: 5dd110c90a50 ("arm64: dts: qcom: sm8150: add DisplayPort controller")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index abf12e10d33f1ce5c74e3e9136585bcb0a578492..4b347ee3244100a4db515515b73575383c5a0cb7 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3908,7 +3908,7 @@ mdss_dp: displayport-controller@ae90000 {
 				#sound-dai-cells = <0>;
 
 				operating-points-v2 = <&dp_opp_table>;
-				power-domains = <&rpmhpd SM8250_MMCX>;
+				power-domains = <&rpmhpd SM8150_MMCX>;
 
 				status = "disabled";
 

-- 
2.39.5


