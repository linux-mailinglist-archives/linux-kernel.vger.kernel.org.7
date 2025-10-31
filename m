Return-Path: <linux-kernel+bounces-879434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEB8C2317B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 04:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8897F188FA34
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2601F22655B;
	Fri, 31 Oct 2025 03:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q6b2y4Pw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TVy/qw79"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AF713B584
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761879614; cv=none; b=I1/q/Xh1Q0vEwzpIoPGjIjr/LmvseV27Cpv26TeaF9LKBVWPMWN+O3S94JHYtBu2WIbONaEgFdKzGDWTjqkFE8jugIbCD6Tly3lykaDNvvENVoo27HNZ/UENIpsbYVe5iSkheMBDpAsIEdKScB0COAsj/zlGBlTkQYUalP8JnaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761879614; c=relaxed/simple;
	bh=12ifn/h0FdAmM0zlYgL6vpYfcGA0ATj8ireBxFP4Hvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NERGKA16B/V1SUqUDMp4pa+YAFrNto/3SL0x/luz7C6+gPU/bKkRWkyp4s0D5Gss8DuM4YjLeUQiENne9EYY7BjY58jNtYh+T8xgwfuBZd4pILGVAXbdqBVrpT8a7lFxn/2rIj2oGchx5G388TAHvyfCJ4Gi/jYK0/FOmR5Z5pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q6b2y4Pw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TVy/qw79; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UIPQTk3117264
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:00:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aIoImiVEY38ckPGZxJxA/BLNldACaExF3yFcJOYBzxs=; b=Q6b2y4PwSFVGJKLl
	SCWuprWTiDpOO/a69RcuQYLWpknL2G4BMrG22b4uhbpZ36J9YgXhFCJneWD9EreN
	7dW+hfadDfpPqda7XaRMSTrc6sAEc5O8k3eybENwgGqvCOj/XGQop694/ajhlXM9
	yxiN5TaDleOhi47OHO62tJ5hKzBSx8N2CLe9TTW3JNhCllCEdxsJHb5BMqDIdt+L
	z7IZGtg3qImdCTu8DU3UyGL3YyhZ3XBsYFEw2ccRm1ktwZEky+k6AUQLdg5wmNne
	lQAa9ZP5d7r5yeW0LqAz9hM4SIV4HC5qA+HryifpF5NmkKZJqlq53nxwZ6UIsMQv
	d7IfZg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a45frjn84-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:00:11 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b6d53016548so3463177a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 20:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761879610; x=1762484410; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aIoImiVEY38ckPGZxJxA/BLNldACaExF3yFcJOYBzxs=;
        b=TVy/qw79ZE6Encu1hdYqO50QGDM91xW49cKHOceYMbawUB8Jmn9HOAeCUCR8GzTw+n
         vvSDkr9NisvJRVGvp7JDiE3+VYoDr55ilu0DTZpc6BS1IKlKbFPSOCiAVisaHZhPZdyZ
         iXwWWxrS3OPXSoxPaeGNM+TDZaFAiW0vba1JDpOhAHJXQ6ik1iQU2tfnEMqeFybCRQit
         BxNqToNZuX6o68Un1qQDgtWGNKhhLGMzjENWSPm66YSMheBGkwv1bzPs+EF+M1HKBUKL
         uesCCiu8yu8YQ0VO6lWvJ2GatbHPgcXzM3GfSkE6xUTJt5NSASjG8biXzTyHSWojvuqF
         y2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761879610; x=1762484410;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIoImiVEY38ckPGZxJxA/BLNldACaExF3yFcJOYBzxs=;
        b=BS3Lfn+ZA0LIxcRaw6yhUQna+LYkUHF9PB6IP9mY/5099ggnmVhsTerX754GMZ4lb1
         iosVtzcIqRoQhvyO+JFCyfcbl2esFSfwThayUSLhNPSn/vepM/hoY8yaPwFC30Ibxf1y
         JEyXPGxhDkQR8J3eZbDFKOC434AhMJGZVc/AzcOWoZ2nnWcARopCeyK31Mgd7j6EPDit
         elvPxTZ7qucrMVpEw09g3uqXni3jaWBEqbgOyl9HY0R50Kd8ZnbjN0W9ZgpYilpNPlNz
         Yr0wXBi3b8H8XvZqUA16F1dZqfqwxAvRwmSpwBLSYdzYCXTe1AI38rerk3eRikjOdBNH
         F17Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQYWFve5KfbeMSfAqQsJJLZv8yWuZsTWO/rXZEhG9NhGBlsa4TUbla5GvdA4aNsRVTlx/7ddiA42sbyvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhtGlyhpsUiSxEbf0Q9E0H4egM0n35P578qmw0dpLJld1aHqeD
	CCimgxo1OdrJ2Efb/ZK4cT8pTFhZo8/nGCcddnNAE3JGEENMoMclHvyqmUf6LSYy28ZLcxf+uhC
	h4ASFeE4q29BcSagFtoZkTkE51yG+oqnk2In5MIaB7AWkQwhPy7mZYurAaxqNuftIX4M=
X-Gm-Gg: ASbGncsbMhNSodKPSANZBOvmvOYLDQ3ZRFaKuC5sgqFULkmAgt4M7Sx46gwmNtyLR+f
	GokVKdCF/xbWRHu2vvjWcCBwB71fQwlY1DjLex4I4XgfPvKAJVWsF6O3Af5nQ4rhIXFjI1iMVo2
	5mDG21lWURse0h8Fft9sj8E97bntW3xSj0TrOs729HJHKtQoBG0U77VBg5OIOaJvjn2mhXpPHBb
	DSU12J2Q6x9qhejqzG063p93EE6EESC7t66L6C4mrBF4VkYM/Z3sTlBG2otfKuzSpT33yTQYdce
	cl1KK2xM5LyyjRbIw/2M5JFvJrGg6VEPcFdhOuWJcxF27Q0+pmMgqR4F0TfI0D3/knwKH1GdJKR
	kpBdLD7PDBtaxmPVsBV/7+I8IyDnnzRL9uX1eS9Xz8NDFhEesKwnSjA==
X-Received: by 2002:a05:6a20:2449:b0:331:e662:c97e with SMTP id adf61e73a8af0-348cc8e5d4bmr2851788637.37.1761879610095;
        Thu, 30 Oct 2025 20:00:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKb2m9Wf2AZlvxL1iP5wTLbiSr7QNBNEp0qYaiCO8kZl4RTjx9EDnWQGDRlbTih2Bp2qox6A==
X-Received: by 2002:a05:6a20:2449:b0:331:e662:c97e with SMTP id adf61e73a8af0-348cc8e5d4bmr2851716637.37.1761879609421;
        Thu, 30 Oct 2025 20:00:09 -0700 (PDT)
Received: from hu-hangxian-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db67cbdfsm352570b3a.49.2025.10.30.20.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 20:00:09 -0700 (PDT)
From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 19:59:48 -0700
Subject: [PATCH v5 1/6] dt-bindings: i2c: qcom-cci: Document Kaanapali
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-add-support-for-camss-on-kaanapali-v5-1-f8e12bea3d02@oss.qualcomm.com>
References: <20251030-add-support-for-camss-on-kaanapali-v5-0-f8e12bea3d02@oss.qualcomm.com>
In-Reply-To: <20251030-add-support-for-camss-on-kaanapali-v5-0-f8e12bea3d02@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Atiya Kailany <atiya.kailany@oss.qualcomm.com>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=KupAGGWN c=1 sm=1 tr=0 ts=6904263b cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=AartCDbB9JJyHY4DVtoA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: iyU0Vcq_PPVyo_cCRGdVFGAwVE-8lRKf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDAyNSBTYWx0ZWRfX9fwtzRfnzrAq
 OnSnVmbvGRSxCSUv/DLsYJQ3BdNzHZ1AIZ29ceNrEI5ZZs6R3tNKzTQBt3tA4jOikyQyo9A8A4g
 yJy0i+pr/3QejSs/UO5mECJ90wFefCkNSBjIx5MQ1JuhAn70Fgw6gLBZaRxaekleiWXu65i8XCC
 T+/pA6vqcDzYx1laKx1pwCB/gj/W1qCMru736P14QaXFMaXU9gZIXdnQxYuXK1olnLiMjjMq4nN
 ue2T6MrjMlvoQTf/hHVzaigdA7eA3FrwvNA4DKAs4PDRf+R/PDaWmFxlGI8twv/BHKzlO/937BD
 302anmsSYZ6R+cZtqOEdXyB6fpWDIfO4Q4Y5cadQFbAl0hNmFQWJewD4gdVF8f3DvxlcxJiQRhc
 Ksgl6p2VffD0XGwUJrLDJ/K7ZAgp4A==
X-Proofpoint-GUID: iyU0Vcq_PPVyo_cCRGdVFGAwVE-8lRKf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510310025

Add Kaanapali compatible consistent with CAMSS CCI interfaces.

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
index 9bc99d736343..9b83ec63e124 100644
--- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
+++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
@@ -25,6 +25,7 @@ properties:
 
       - items:
           - enum:
+              - qcom,kaanapali-cci
               - qcom,qcm2290-cci
               - qcom,sa8775p-cci
               - qcom,sc7280-cci
@@ -128,6 +129,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,kaanapali-cci
               - qcom,qcm2290-cci
     then:
       properties:

-- 
2.34.1


