Return-Path: <linux-kernel+bounces-831447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA934B9CB0E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99BB9383546
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D192C032C;
	Wed, 24 Sep 2025 23:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YhKY6jTw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2FB2BD5A7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758757448; cv=none; b=cOnITYQcaqXtjI9eoJilk7uXkUvVLDBEf2GPyMOEArcW0kO2HMOZ0w0WADsZWVzkiSSeow4mCLWjvKf8CF8TxTtryvw0GbkkxSiSxtuetuKWjd1PRhbAXEi6VQVLXlKJIr8nyMRMQCUSNlHt9LVWaoXXqW2Dhsu9aCj6AhZ2+HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758757448; c=relaxed/simple;
	bh=+PguNXnKz4shlGzI8jizbctu7QM/1nClTAgxolHd+Xk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q4khBp5eqkz5v1kW26nG2wI+bsrsVOHsNLCHlYG5G/FnvkSSgssl1TqIAvtb5vM0AwzSFtGU8rS5DRmbaw058tN8gKRRMF0yjv2j+C5njh/5jW1BbyPCOKeba9QsPOcB0HXFZAL0qVdC4UwIIAsFtPy3FZoMMSwCe5v74gvYwuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YhKY6jTw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCnMvK022454
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:44:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CSmqcMOdgm06/uXCrcq/BO6IeQZcYft2rlSV8w8pItw=; b=YhKY6jTw9TeZlutZ
	iR9yBjg2+XhWYOJ+6ogv8590TAxqEIlxuNKsmyRx0d8JnigOPGQIbntTcvaxPE4D
	OiqGOngCmLKTnrMPUTVYf8Im6IRKmqkfV30Hbh0fEhel/g7LvPbZ30Hg2dJTkZqV
	gQG5Af+BlWc5ZdutP3qujm6ifMd7ortPYmnE9iORa1u0jAuBl7+ZaWkKQqT6U++I
	t/8rTrAu2gce1/FhwgqdJLB/ti++V2+1gMu7ji+02Kz3wbIkCznThLgkrwdqGWCl
	N+zBydCgt61gMsswQ/DP91neaxo+13tyU18eud2x/ypKQW1jKk7FlVqX0rIXmX9p
	6IjLrg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49budadmjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:44:05 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-332560b7171so1150454a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758757444; x=1759362244;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSmqcMOdgm06/uXCrcq/BO6IeQZcYft2rlSV8w8pItw=;
        b=bHhg3FBNHAWiok5VVw/eUGQ7XELJwOT3mroRb3657uan3ttgoCgXuOcPcJ9DOYSB8Q
         JuuKRg8FnNZ5CadPQQqEo9t9oS36dNc30h/0QgzaM1dp8BkiD6YHJCtuaPLGJsDM3T+x
         I662GKEGsb7JAkKIOJ2RQVzzRtxo7BIhUKHub4T05f4AFupNUw4Xq6f/k0+X3QvGRBf6
         7NKIGSzsttr1uTkYwaY2cnJdOkRqfbvxm8LZyHxGUyLfR+QFvdL9RSJWErww4KXkCatN
         Z7+H6iIJho3cRzUFFELW10UPa0h8fHLC4bg5mdzgT5WOrzNjMKu9V+va3IXdzC4RMNVX
         h5Uw==
X-Forwarded-Encrypted: i=1; AJvYcCX3OP96Hr9JBIX8aMsZR7dcxgwC6R4u4CXWFXy3vExpDzaOje68y1W/r7URO8T4m1br5K89hphV7Z+qZcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy84SH5hUjVz+feBn+6BclOWgOfU3V7TyAGQsMRMRzoTSbnC09Z
	4XEmSn2nQxqOoQ7UL6xDb/72X0iC4HcDRq3FRFUIq7Yg1ETFQ0X4n+H9+7ybbR8TLXEob5qySlZ
	C/vkZwq9szRBUAmK0+NdSlycd4d+5IMKqi2B8glirhyTonai2eOjUcT4dSpcdNQKsinQ=
X-Gm-Gg: ASbGnctXMCEsWXNFGWEP8WUzb4ozXAajVVGMryNGXLSH/FcUfPIJayLHnlaPBdVTwAd
	vRjyFksuFg9Mg27mecCQ4tA4sRldRkULmWd9BYlL2n+OMEJLq5EUBj9te0TBtzqeYsdr0ZeAc8X
	Mdtc0RTsLGRCbHYKKL0hLUF9njoGFJkjxb7zAB2UTULGBedGdr9HXQvGPnAOzwPsMoK96D5/kA1
	rXbmi4ZexAWvb6XlGTDjE+7XIAsm9m+gNH6V59MdlEHThfSy8/L/UimwsdgjSz3ig9hAr1A8fCT
	ZaGWtENvVoeOFJEnIzUhWiIN5EEvL+mtfQqnzeNxgh28nWFltUvK0ulbVHQFEOtIYLS5rZ3cocj
	5/1D5gLZqX7OZzX4=
X-Received: by 2002:a17:90b:3911:b0:32b:7d35:a7e6 with SMTP id 98e67ed59e1d1-33456c715d0mr526451a91.18.1758757444486;
        Wed, 24 Sep 2025 16:44:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnbw/R/ieUMgffqkQ9oegzvq9+haEnU55ylejKV2ZmhkVF/1e0/sfHGVVDCgw9SQDnekgoCw==
X-Received: by 2002:a17:90b:3911:b0:32b:7d35:a7e6 with SMTP id 98e67ed59e1d1-33456c715d0mr526428a91.18.1758757444026;
        Wed, 24 Sep 2025 16:44:04 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3347453dc35sm206983a91.16.2025.09.24.16.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:44:03 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:43:53 -0700
Subject: [PATCH v2 1/2] dt-bindings: leds: leds-qcom-lpg: Add support for
 PMH0101 PWM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-pmic-peri-v2-1-32316039db2f@oss.qualcomm.com>
References: <20250924-knp-pmic-peri-v2-0-32316039db2f@oss.qualcomm.com>
In-Reply-To: <20250924-knp-pmic-peri-v2-0-32316039db2f@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Fenglin Wu <quic_fenglinw@quicinc.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758757441; l=851;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=QTBiSyI3nJAg71OzCZCRGKakt5nc3BD7jBRfC3qPe0o=;
 b=UbnSeZlbwRc86lY5l6M0xtgXmffAuI7ZX0Bfwmk6rotsBBFqtWTyHuumX2J8C0u0UPn8OdBVN
 eq1+Q8xGDKMBSIM7kbMRSfJcBFUanW8HFHCLLohNvu2m4YTTcdUaouO
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: iEO3Xd1l2ad109P-lVmyPfcwmyfAqeYF
X-Proofpoint-ORIG-GUID: iEO3Xd1l2ad109P-lVmyPfcwmyfAqeYF
X-Authority-Analysis: v=2.4 cv=Yaq95xRf c=1 sm=1 tr=0 ts=68d48245 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=5jWUu6Y50JxcgPCnrowA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDExMyBTYWx0ZWRfX65OysDFB1KKL
 inC5bo6r0hU3PSSDU6GOksRk5IueAyfE9TYCoRgjYF8rMM2STxc8H/zJtlaS/enSHstGy4GpAfD
 Cm9WQxxLUiRO9r/whV9IPjRc4Apm8oM873r4z1co5OSvLoy1jqKKsLRUWhVwepEwqYOO1ktuvPX
 Vmugdeikw4jBaIStp9jhZkP+pQ+UaEjtihoElG0b7uVRHQcQ5vjmO1vKLcCBcqAdlAL100hXW0c
 /aZwu9yUSWFIGm/Dcn8iiVtmLxxatma2mNjK84L0FVsTh5/5YFVpY3K8DO3srMxFgulW79eozsx
 MBI3QEkhUFyGsys4/T/bUm40aDHGHyM2YCByMm70hma45SDTGPkQXfu4D3oTiP7vt3O3qeU6aMQ
 HM1wBIic
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230113

From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>

Add support for PMH0101 PWM modules which are compatible with the PM8350c
PWM modules.

Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
index 841a0229c472..1278152e8eed 100644
--- a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
@@ -38,6 +38,7 @@ properties:
       - items:
           - enum:
               - qcom,pm8550-pwm
+              - qcom,pmh0101-pwm
           - const: qcom,pm8350c-pwm
       - items:
           - enum:

-- 
2.25.1


