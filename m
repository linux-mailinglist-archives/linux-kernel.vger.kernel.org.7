Return-Path: <linux-kernel+bounces-884265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 066E7C2FC3D
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C26C5189BD4F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DB13090FB;
	Tue,  4 Nov 2025 08:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CEAq7DoP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eEIf2YRo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE28310621
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762243869; cv=none; b=PJXJS/4mmn/6SkpGem0shBY372plagAP1CZPB+JjbK+o7z9rkaRtm2JDs5eoQb+TClJ0y1HajLi7Vl28ujvMCtJKtHnLsf9AUo0fOWQP9zpCe3kmyDrnL+kB61neBK/zK3kNNGNXCCvI3lS5v6rwgOWdRbJ3cMndcHpoAm7xKr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762243869; c=relaxed/simple;
	bh=RRDIkxdP3/Y5/4hhAVkauK6PkEknJbU5v3IcJnyja+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lwXscpmaqkAFPvFgAjxyM2vF7/KDYNzZ72W16r/Zb8GsBKn9T9FoSPVAsFpOge+OjJfqSP01lmonIaV9Pp8+LVxJaNqNtVLnWLrJ4tiKWW+W3n2X0WZJVT89CdIp8CMD9/zTYbtpwhDhwONLT4lxYVryBo/gfx6a1I3a9+yhLak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CEAq7DoP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eEIf2YRo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A43BTs83846001
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 08:11:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WRJljLs0mUu2LG8ESeBqv0weK1tocDM94Ekh5Hl/RQ8=; b=CEAq7DoPp+XPwAdV
	2tL1ElN/hNno6ytXqV0C4Yp+UAoCGKCjAJWby/NfqZr8xCLIg6D9KWRFXnEUeEq9
	Zr6zYerQe+u69gPW972IRuxHwdyrR09twK8uZf+hWYY2jTWV2TDVO6eZWWp9EE/1
	1LF92nI5AD/ixVv6jrPa4bovaLoU5CZJDKMI9467fneca2HNU6Z5Cd+08aE829mj
	J16Jm5YRyK42rkDDYi2dlzQuY8efuRcvHSbD8DNASeb9D+0FrHPgUgjx4CvBHrlo
	KfxHWHtWNEO0QUmh8JfFL7yyXpTfYZS2JW7mlVxLFRo6MbcejXDmtIElT7UWVvor
	hxknDw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70f1j6h2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 08:11:06 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-26e4fcc744dso39639065ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 00:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762243866; x=1762848666; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WRJljLs0mUu2LG8ESeBqv0weK1tocDM94Ekh5Hl/RQ8=;
        b=eEIf2YRo6T4glevun+uIFrQpGf7TzTcTOXC5zQpFcs7Y96qWMqBXOIMNUpUdH/jbjQ
         L9oVYXoizwmnzbp6mSBmioAMw725aDGBodcEYJOOkhQ58nKTzGnPYxeNE/OH9vHdgS0I
         84FJxjlF4CNrWB+f5w2bTCnFg3jauQnsu96AUpY4mYaa2Hms3fB2Y22h+hkcTWv78Kc/
         Ez6O2Do+PiaHgJa5Zl+uoGG7HtlXyAF9O5LztId7pP/5pj5SCoeCOlmslH0q0hr1eenO
         M5aGS1YgdsUarRG/r+O2Oq5MpQsBkLZXijg9KVwcfX+PhQzaLlKCwqKi6o0bfpV4k4bp
         6hXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762243866; x=1762848666;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRJljLs0mUu2LG8ESeBqv0weK1tocDM94Ekh5Hl/RQ8=;
        b=bPl03l3OBDNS1xtFYr8BWp/g1XehST4zWVcIqj7Wbh51Z41mO+Jek0dOGKpyY+2AqR
         b7wsMBu7dmB5abYuL9RmfgHLDMqdy3flOGLs91kRWnUSqyvfuRhub9lw0EayE18IK3gV
         57SFrvsVMygFxL3vd+v1IR3L4udUbZOpVk4E4AIUETmlsH/5sivkIgdHcM5PAtupE0ZP
         6JcFDMnf5dD/vO7Q6UFb0stXjPIH0ETVKrce5+kK7uD6ljKV3v5v/HK9THhSJuCtVOyG
         OiLL1P4/GMaq3kFfPFn+Hk+hC4Bgkobb0X8Bdlxl0K2CaaPkHVuof5rxKmhJMjmuH87+
         Uf1A==
X-Forwarded-Encrypted: i=1; AJvYcCX2YxBbVqmmCWDUV5C62/+t4odl5JDStEouuGeTxttmutaSMlCndTu7YqwRaOb+LbO37kbnenwP2H9j0H4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqJ2NsU7F2pe3ESnNYiX8rJyzXzlSGS31LPbM6m1yNxzo1Rwyk
	O+7QiHPnK5cpP3D12z8k8vvZqVuiG8tzhI7iSS2ufXWN6efGu8RI1B45s2ZcQl7e3zivj0GQ6yN
	Fv9A8PsBofofKl7AAXkmMBJw3B3CHN+QTHVUOF/UaqQcTw8vb+1kLCWNoiocTMoGX0Ss=
X-Gm-Gg: ASbGncuQhsn6nFcqnU4IbG+nGN1yW0/EPqjskU1NaR6OVU1PYcjhWsoe2hvzki11cv8
	vkEJqBj89oTGj0Ga1aPrMYeB2FI9lMdcItQqi57JHC64mDrBu886ux2LLsIyA3Cibfy3sn1qMVO
	pS5DgLkbRGjJeE6oHZEMJsQw98/tW1Uw32tNqu7qtl9tV9CaFLbQ8HLj1Phkg7xpTzCDRC8X/S9
	301Qblbsk0ACeADaxm27uNBzXuPg4QWtbgzKHfgEEPDEzv1vuw6qbG9pJhuRwrVGQ8D5qaRy8d2
	FcdH6aJrsmV/Lvp1gBlkhhdztbAJ2+VyxgXyinWd/OXhhmlCDQ9SYOjZnuH5i4I0D/ylDDRR+sO
	pvhnWJGBStKNCul+9vIjiXLAO9GOJN0aaq4uDx2sxnkXL2J6mTkRxUGhP135Uxw==
X-Received: by 2002:a17:902:ea0e:b0:269:a23e:9fd7 with SMTP id d9443c01a7336-2951a3c0348mr202032705ad.26.1762243865604;
        Tue, 04 Nov 2025 00:11:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoXB8HgwRYlpL5Vtm3CBcq32qQz0T4JFr10LQq9JcvSX1bP3YvzIC0+zbTeVSa5ABSv/mBRw==
X-Received: by 2002:a17:902:ea0e:b0:269:a23e:9fd7 with SMTP id d9443c01a7336-2951a3c0348mr202032425ad.26.1762243865077;
        Tue, 04 Nov 2025 00:11:05 -0800 (PST)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a7afe3sm16755885ad.110.2025.11.04.00.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 00:11:04 -0800 (PST)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Date: Tue, 04 Nov 2025 16:10:17 +0800
Subject: [PATCH 1/2] dt-binding: arm: add CTCU device for hamoa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-enable-etr-and-ctcu-for-hamoa-v1-1-af552cfb902c@oss.qualcomm.com>
References: <20251104-enable-etr-and-ctcu-for-hamoa-v1-0-af552cfb902c@oss.qualcomm.com>
In-Reply-To: <20251104-enable-etr-and-ctcu-for-hamoa-v1-0-af552cfb902c@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Mao Jinlong <jinlong.mao@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jie Gan <jie.gan@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762243854; l=810;
 i=jie.gan@oss.qualcomm.com; s=20250909; h=from:subject:message-id;
 bh=RRDIkxdP3/Y5/4hhAVkauK6PkEknJbU5v3IcJnyja+Y=;
 b=P4Hd6IiPf6FbzSCYsqIHURtl3nbmaS85SbXA6tLhD0FS+Z0WbLeogub6LoVircW7PRSrlrJ4F
 NAxAOM3tOFuDVRRNCiVJKHWusodh6Wi8KyRgBiov9U2IytZZWXlerYw
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=3LxxUZRPCNkvPDlWOvXfJNqNO4SfGdy3eghMb8puHuk=
X-Authority-Analysis: v=2.4 cv=JLQ2csKb c=1 sm=1 tr=0 ts=6909b51a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=AruyFUP6G_q06T9m-PEA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA2NiBTYWx0ZWRfXxfwtlVAL3O+0
 zE/kWGfNZsHY8DG4EZ8o524AEAwpOJ8UNhwa6bzGPQtHEe/uTRulVzgp2kNL+/UKYRpIdc451d6
 ZU69D/BM9RxoZSBVJ+LXf/KsQrTH92bw10FtQ4YmQiA22DO8J284CNmUHH3Zbw+PedDypHeR8Mp
 iuPJT9O2bs82ujwHSoKVP173fwc4KHjzkO1DmKoxqxlmjmPV9Rx+NzzzRshsY0mFm+ddfa1moJq
 mXkl8CD1j9bDwKiut1LZe371HIfLTOQwTbDO6a5P/zOrCKNcw6RnBMzExKW4r/kxSPaBv+ZVq7M
 /TV7I5Zjt3wY3zGcYqsc/Go4/MbUfpxu9EW1hNDfzLB0e+II5Iv+zUVT6tqXW5YeILk+7rcG47C
 oEz6+jric2JX+bF6mbLcSNQjGwWieQ==
X-Proofpoint-ORIG-GUID: s0wjevyZqWnwqTUxYUTSai1cMZTF7pM8
X-Proofpoint-GUID: s0wjevyZqWnwqTUxYUTSai1cMZTF7pM8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040066

Document the CTCU compatible for Hamoa, enabling support for the
CTCU device on the Hamoa platform.

Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom,coresight-ctcu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-ctcu.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-ctcu.yaml
index 460f38ddbd73..57dede7a90e9 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-ctcu.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-ctcu.yaml
@@ -29,6 +29,7 @@ properties:
     oneOf:
       - items:
           - enum:
+              - qcom,hamoa-ctcu
               - qcom,qcs8300-ctcu
           - const: qcom,sa8775p-ctcu
       - enum:

-- 
2.34.1


