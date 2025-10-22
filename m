Return-Path: <linux-kernel+bounces-864339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1164EBFA8CD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 626E534CAEA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE382F9C37;
	Wed, 22 Oct 2025 07:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZY6krDsL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3525B2F83B2
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118141; cv=none; b=tShg1RoZqTDiYn5hFw6aBRGkLRjUJ9l58f3GVCFXV6jQQe5TUthUqPY+zeJ/0ETDgPfUp/VOtuAMYGl9oXD3Qm6lg7w10w+ZPv/xVGm5WeLkDGEUSBcm3qngsWTaNFbIEzrI8hfcgBjsmJa5m4HAAH5a3iEUNovZw6z7POWZhkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118141; c=relaxed/simple;
	bh=jwAg/fX3RHeusGY6KoIA8mmpz+S+raOvxoiw5Q2SpXg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VTA3s/RKnSV5upmEL6mWqnobvCoODe6oZupFVUuFbsrLV9y/TDM0Lj9VQ2VqgyDTVm1s4nm1fqlzVNqkvBU0CX0VgPhqjqPZL369WjQ6MaVTq7owP9KHdfyQFUCUMjLLaZvCB3oyGgyjxfvRujwz69erRiCMmCmH9KeHy4TskBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZY6krDsL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LNvWPl020413
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:28:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8MM3ZnxMKNX/HOlQQQw5DE4q0GrhaHbNC2oVd9aKK98=; b=ZY6krDsLY1xJbbiT
	HbH1xIu8cY7uQZ8vJTfBij7EE+8DmJTfyiKgRMsE8wEy2GyS1UjOeXoHSuRDk96r
	UMPKCBqP6qllq4/ze5/LCz86LgKhxKfY6otcGdqy3o79s0tXRWa8Rs/jdchMhRty
	2s0LwqepUf2dj9kZT9M3jW3fkwgiPcEfWw8h56HAH3Igi95baaW3e1oBeQrA4PUK
	pobQQA6pShAjZvpN5xD5pAab/oO/jO+NB+E+kK9m1T10Q86ly2ZcAfkd7kw/gktj
	alJpQSHGCsOCR6zr7QACO2zYwAbuZGFkiAMdRF6Wfd4POxa6lNWIS+PsQVtK2ytn
	F8wH/Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3443pq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:28:59 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33bb4d11f5eso6506760a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761118138; x=1761722938;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8MM3ZnxMKNX/HOlQQQw5DE4q0GrhaHbNC2oVd9aKK98=;
        b=CYxw80AdwKLmB7DyqCacKCbGXm+fZmOZg0H9JQDveN4NTF0DXuYNnjQazoLtsG2KV4
         GKToYHmCxrGp4/92N95mVscYvvOQDmKjlIVIjiNksC25h8Pa3sReaS9TSRmCNLddw/RQ
         UZlwVPh3Yjt7xIsl0Z/5soENHlFgSTD/rMC7UXEqHqhcic1V+o0i1SEo3EouPyHJ6SF8
         Aa7BwpKRjGhi/R/Qs2jZkZZQsNVSZfGKJPYDyZRIQDKezoBr782I2hshti4t7khnRa/Z
         6ikCUmp/s1DlICQUgogrONHGO3IsLBpad7/z6XN6wd+kxtjYoIJyyEHzjHlmgG2jvSOc
         E0gA==
X-Forwarded-Encrypted: i=1; AJvYcCXg180hKuQgkdjQenN2SsyQx5IEedEvf2TGNz4912QP1K742v3F2ZqQHvmpr5J6A9Xumvc1TrJYNvgPH9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvSBeC/QTxVY+Kcpzevh1SNjwawwFg2o7egrUqZZUA/FWin9Ww
	2p3rPhP96fl3b0RxFI13XvvS3zcZI4//CdLVGbp03IXnLeF/rYkJHQSfNDv6ibHTtSkv7pfjl7Z
	+KXZqva/dfL6GR8q5JgDMXPSynPV9MWI7AiyAVSA2DQhbrUpaXyGYbBjh2Hq7UlpFPqg=
X-Gm-Gg: ASbGncuilIXnwsonNJFUNs6agQSrbERXd/d42PcrJTAFGpNggVp4x4R/A6uc9fZgcv1
	H9tQilAkyqjfToaLnycjBpJPqgQ2MjkwvG/9WqyHi+nPjPsJYwfJ6Q76SEm2jeekWVdMpcYquBl
	TspBecc9n10NMuqDK3XugMinyuVftRr6PE28XRBPDW5qIOZpLlK6bDTU7HsB1cQ23nXKhl/DreA
	JScces3MQuGsZZsJMWPjikvlVBCFAlg6amQ5jG/CY55eijhI3K70oTInkuIMOm9AA6sSdFmjG9l
	ifKgH/PyAjZgCA/GpCov4OUii9EfMAgVHSaI5DbIpiAm95cDoCLX0BQWN8926WxviCBs6O37Lnf
	RXuZMFM/O8AxWQiuaiuKYpSzwPXQzjrfDxkw0ZGP05D0PzrAVfQ==
X-Received: by 2002:a17:90b:224c:b0:33b:a096:2231 with SMTP id 98e67ed59e1d1-33bcf920efemr23228828a91.32.1761118138291;
        Wed, 22 Oct 2025 00:28:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoiORJH1jQ1h5FNacmn38SH9uOfXazAABC/+UHRf3iMOZk3OQRydS2TLV9FjVlt0+yyYmXKQ==
X-Received: by 2002:a17:90b:224c:b0:33b:a096:2231 with SMTP id 98e67ed59e1d1-33bcf920efemr23228800a91.32.1761118137814;
        Wed, 22 Oct 2025 00:28:57 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dff4498d0sm1687342a91.11.2025.10.22.00.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 00:28:57 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 00:28:41 -0700
Subject: [PATCH v2 1/4] dt-bindings: soc: qcom: Add qcom,kaanapali-imem
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-knp-soc-binding-v2-1-3cd3f390f3e2@oss.qualcomm.com>
References: <20251022-knp-soc-binding-v2-0-3cd3f390f3e2@oss.qualcomm.com>
In-Reply-To: <20251022-knp-soc-binding-v2-0-3cd3f390f3e2@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Eugen Hristev <eugen.hristev@linaro.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761118135; l=803;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=jwAg/fX3RHeusGY6KoIA8mmpz+S+raOvxoiw5Q2SpXg=;
 b=JXJoF0O53vOjmOQ2/dzhvBeiZjPXcC7M0KRAc0APkQo8S0f9QvNYWsrXfwuMj7oOEBFN9thhC
 XZABTsmlYPSCDtvTtBBDa0ptuzS7Bk80tgId1gA4wCGP5XiFCpps3Nn
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: OAT5yYl2HeSItC18mTWQ76TRGNVwEa0e
X-Proofpoint-ORIG-GUID: OAT5yYl2HeSItC18mTWQ76TRGNVwEa0e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfXzTa/vufqkusC
 vZiabhsbMksZQSNQrkyiA3Oo9/k5kKwFo49SI5lnznGVBvTCrhyY1YLUglrFe9Q8iTngi/V9RYS
 IKqAx1alK50HF/2EoO/dN4jElbCVH61wkiG6mizw/wFMqTFzk1N71118bNlhmZLfHHIxEZX8nfp
 QuGxdK1nS4cVNE0KJZhzMHoRKg2T3eFNCP8NpPyAjwQKqtsUBi+QCejGz4WH65tGojyCWoo5QQn
 6t4jXu1c91V9gQyWTK6BvEPw3jpY3L0AAEbTVWnpjQFHRJHCTX+BlnNJ56aEC+8/pGV9ZxMszqh
 EWLw8CX4LKXXVjV8/zUFSwp/WDU1hkOfZnApn1ls0aGK3XWTSzq+/0RaJz7ZcAFzPnSB3BnAbs0
 tf8cc41HsXxuIB8nEmRCs7yKQDHuaw==
X-Authority-Analysis: v=2.4 cv=E/vAZKdl c=1 sm=1 tr=0 ts=68f887bb cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Ety4sU5WZCxzx5fwigcA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180023

Document qcom,kaanapali-imem compatible.

Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/sram/qcom,imem.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
index 6a627c57ae2f..1e29a8ff287f 100644
--- a/Documentation/devicetree/bindings/sram/qcom,imem.yaml
+++ b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
@@ -19,6 +19,7 @@ properties:
       - enum:
           - qcom,apq8064-imem
           - qcom,ipq5424-imem
+          - qcom,kaanapali-imem
           - qcom,msm8226-imem
           - qcom,msm8974-imem
           - qcom,msm8976-imem

-- 
2.25.1


