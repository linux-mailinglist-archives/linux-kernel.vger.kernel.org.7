Return-Path: <linux-kernel+bounces-831411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C36B9C969
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40BCF4A70A6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7172A2C08D4;
	Wed, 24 Sep 2025 23:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ULgDI5fK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDB528935A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756708; cv=none; b=GG8le4m+IEq68qVtpIPJXFpNB399Q/Cv8vQie12PR56l8MLwK0AakfsECz9b8Rq9Nr4/vtXvyojTC3ZHsBygYa644ZxxHkscaJCVbwYt42QBCJupr/rYBIr5IP98dqujH5vlo95L56UKRXVu3BmFXR+QcfVPzmXI/yv9f2S4wps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756708; c=relaxed/simple;
	bh=a6tErwu444vJ3lJdP8AAwFEzMZveKsdfUtifIz4DZO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RJnVEe7FpHuUZ+ytgL1wIIomjQ+tSb8G1lEpVI7NcZaG74AfJqiiS13WnQi2yH5Wdh9nBckxDKk+7SK1fMksKR9o+gtPXpV8AhGTLoL9R8+WhLOG5YVqvyiHaWyjixt5YXWiIO8sAdx+rGDE4ZxK3MoHi6YTcUX4BSaW00K89go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ULgDI5fK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OD8H6N019945
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pnDm6xqDtoLBGOZnN8uGeh/XS9FEtKnaAOUWoj6fMGM=; b=ULgDI5fKMgZDhtYv
	PKJJSFzYb3lNWcChgziUZtWE13cAPKkplDrmm7Z9gQjaMAq8IN8kYjUCM9KBTaZP
	/V57mXLAb6K9wYLj44noUgttkpZj09VsJ0kylUB72xQlxG3Efn9lf2kDTLvB8PLS
	rkJgbcTaDQ9AdzLfk6gfEbFqtLgXFkZgpVfMqt8JRcGi09wlrvUsvPwAGmoGkk1Q
	gC2dj6NeWnfM9IWxvOiOWm7GOHvqQ5iygwevhafbZP7Z0KDEMBKXBZrWNW40R5ua
	LQC5UmEXNG4J2EbUmzKHQfrs11HPMGxvyU7qAm4Z/bVrXSWvyj6sRr2uNdQnTCKK
	qrWhlQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpdy8rk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:31:45 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3324538ceb0so547110a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756705; x=1759361505;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnDm6xqDtoLBGOZnN8uGeh/XS9FEtKnaAOUWoj6fMGM=;
        b=lV/lLNMvGsSWCgOI/pf6yzbkfEjZe255EXalU6MXNu/kGw9Wcf8KeozXW8Lt94AZ7d
         gkdy+i62CMl8zYS8PNgaLqkHr4gXBP5W68aG2b5XV92STHh+Ewke75xttwQZeUxDc+zf
         VG7AeoXayk9tISCwvgELaWABmuE9+urJXJxUNb1POEPxobcp84gPUhy5cMTOX/YbLlAZ
         g+dPX/G36n+unUjV0M7npYNkPr792DAOBtENixCbj2DsolKVkWXPTB+9Vl1Q935o4dMc
         x7rXOlnrwXtHUyN2C1v7itXIbN+hu0DI97d/rkEhoTLqYWMpzwsPHJFH2kA9PuQogGko
         C1ew==
X-Forwarded-Encrypted: i=1; AJvYcCW9yOQ0FpzVbBM2vG+Aq0gP+SNWxAWIkit689/+rvY348d8bJMIhjra71cywuDIZitmj4KnTHRnuo3fkxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzzIQuO279xZdohOHsjCT+6nvE0ACqSmWkkmzizkdZdVJYg/W3
	ckil5FLPZWGjtaUGc8FhgyQFYUtILU16Gq7OyUx4bci5GMuqpf09kQLvzMFc52+ku+n8VW2QfZS
	3An7NRYy+c5f3t00am/K+XPYbYxigmMzF57WYcJ9u53rjN12yVTYqkZuhLB1G3LZgGUL0lXA/ye
	NI3g==
X-Gm-Gg: ASbGncvIOACb12Ml1/Do8B17/Tzdgh3XrkbGY+hBdW02zkDIP3+rwX3KXgrbJM1PfDY
	4u3Xru7AHMkjkrGiEGzpEC57XimODtZt35YBDuOTD4TgD4PH3+e3Ma5gO7WPQXZm4q7qYYPfUGd
	ooiRXgs0Lwu53IelWWVWYRP0YZcL3930daSjECzisOnBqm/USKvBeZFW4CVoq39WEj6o3+XSP5D
	5jvgTnMrPKS7FC0NdDLwDIappEJyv1SGhbS9MeEh/IvecasN4RgybO46DT2cVKXkF7Uy2PFlAXS
	H8ncU4tzE8XKVRLua9EuCv28RrXO1duH7pRpVbdTN7NWy36QBdrymFmhZL0o9gjaeBi2umzJm5V
	jEsGa8VFNM/4oaUw=
X-Received: by 2002:a17:90b:380a:b0:329:e9da:35e9 with SMTP id 98e67ed59e1d1-3342a2574bdmr1377892a91.2.1758756704577;
        Wed, 24 Sep 2025 16:31:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+iQOgjYJEYbcOSaBV1oIz8mqjYSCEc/JNX+/GGUPAp/+PU13GrgkljYC04qfxOHTn+4zmdw==
X-Received: by 2002:a17:90b:380a:b0:329:e9da:35e9 with SMTP id 98e67ed59e1d1-3342a2574bdmr1377865a91.2.1758756704129;
        Wed, 24 Sep 2025 16:31:44 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33474f14e4bsm194322a91.28.2025.09.24.16.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:31:43 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:31:38 -0700
Subject: [PATCH 3/3] dt-bindings: firmware: qcom,scm: document SCM on
 Kaanapali SOC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-soc-binding-v1-3-93a072e174f9@oss.qualcomm.com>
References: <20250924-knp-soc-binding-v1-0-93a072e174f9@oss.qualcomm.com>
In-Reply-To: <20250924-knp-soc-binding-v1-0-93a072e174f9@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758756699; l=1090;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=a6tErwu444vJ3lJdP8AAwFEzMZveKsdfUtifIz4DZO8=;
 b=Zt0YUnIbbTeyoD644i05+8I/uPnlkDvSPxaRdkrHYXXym6Je36Fsp/N9TkfYCBxDUVPdmz1jK
 pJU1wiTtS38AYsdcDC3MM/uwGJ4Tnej6c4FcYh6OGx7788NJZpG9Gka
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-ORIG-GUID: Lvb6Pai9Uu9pdBiit-Air44PK6loLCnE
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d47f61 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=ffYJIid-Q94gFHaen9MA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: Lvb6Pai9Uu9pdBiit-Air44PK6loLCnE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfX72F0LAbIaVyO
 rLpDf6Ev9e3RzGRnD03UO/HlrxzSPDnQP3ZGNRpZUz1z8IDGFHQO6Bk7rq8AsoVCwf6kH7/AvOJ
 bLL4XZyWibi6s5aEbRxZCjkmzvAyjCvNdHbPL2iRps6WHrEGtQvXfVJmZal3OqvUvnl8IYD7pBL
 GA5J2knBNPdI8HqUtk2Zl+Acj5e5QyXetU6ooCqH14d0y6hMJGn5jvmqumq9+OnFVP0mCQu3AfP
 gyafPhxRWHG0L/5Q2b5+QqKmvOWF5NMSClP0lH9Wg9nn4NTD5/UI2qqLmkiBOBAEp0Kvqi2osxW
 YVKMdpRMo+f1aItomblJ5wc38VB3zr7lLJ9GWO1yk5iSzLKPJJQKVb760eUzddTZsr396J1RXDw
 YDPrakkK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020

Document scm compatible for the Qualcomm Kaanapali SoC. It is an interface
to communicate to the secure firmware.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index ef97faac7e47..340b754e6322 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -31,6 +31,7 @@ properties:
           - qcom,scm-ipq806x
           - qcom,scm-ipq8074
           - qcom,scm-ipq9574
+          - qcom,scm-kaanapali
           - qcom,scm-mdm9607
           - qcom,scm-milos
           - qcom,scm-msm8226
@@ -202,6 +203,7 @@ allOf:
           compatible:
             contains:
               enum:
+                - qcom,scm-kaanapali
                 - qcom,scm-milos
                 - qcom,scm-sm8450
                 - qcom,scm-sm8550

-- 
2.25.1


