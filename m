Return-Path: <linux-kernel+bounces-864234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F831BFA3D6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AAE63B19BF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684DA258CD7;
	Wed, 22 Oct 2025 06:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="apz+BQo9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F45D25784B
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761114756; cv=none; b=UMGVeLTJDe7UFRb9JzX644APqOWaQmtPrhX28jVnmsNSajaXwy9azVd8nZVae2R/+jwLY/7voqi4hXdG+oo0FOi6XTsAtkOB4Jn2INOcZgIL7fkxy+r8FvcoqZXVivrZoBD25LQU9r8k+LoAb5NSGAZiCJfAk7DsBts4awurxTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761114756; c=relaxed/simple;
	bh=uaLbcQUIr5YUqcjrF9noOI3rqaP8x3PY0YKoF8vsSYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=N8SZWMqVEYlvwz8LqoL+iDyXqR7zi3/28NoAD2dmz/ZaUHtnjtzlKpzSzVUR6f1xRyoXtsCggzBjTgi/qlxz3STuH0wNGNDpNINauJhS+5ZoUDUtJg0ObXRwZHLH+gUjeKVaAl8HGu+YKlPh6LDxZNi+isjpouT6DaeEzbhxiDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=apz+BQo9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M39Aif024215
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=9tgWr2zJ3vb47UvMg9RSYc
	kWwaM6yFcPhLmKAm4hjeQ=; b=apz+BQo9xEYP8/7D/hP/poJfq/4Q0axJpzMopA
	oLNvzHF24icQmH3Q7FInexW3WOCgeYsnnlsneQoPUIVly6oi7XoUqd6eIss3cbvf
	GarHj++IWTDD2iKKYVIqmBT+moUUGjMOoFzgPPkG7BGsVU/hb9TFcFa+mbn7b8LD
	U8LVMrWkZE08+mcI9YvMhYV9xXqdWPJw+m8Q5n43BGGA7856XLtSKWtYjH0qIJdF
	9UHFIq60w9mM7iurulbYUJgSDuCdUKyXNdzi79GkOh0ar/q5f974K0L0GyujVMml
	iPenE6lN3i4T10iF0vMWBNDVc5p9zIdIceegg/R8ISC5eEPA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v1w83jda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:32:33 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33be4db19cfso10426114a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761114753; x=1761719553;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9tgWr2zJ3vb47UvMg9RSYckWwaM6yFcPhLmKAm4hjeQ=;
        b=n5D2CDgtgHQdIn0QPxqWvt7sUr9ZdatDdSsYYITKW+QG9sQ1hIHQkGCfyg1JCL9rrA
         ufDOza93ggFzUqotVmILV2ZEBj1vjYT7dlqg4ORz5lvCKHsK58p/aQRtLQiya6mqOIsS
         Fc935/PQ/h5RORYA7XUOXKNWhuzL898snCtYYSvl0X3n8vcJNaZVansG3RxG+Si9rDL4
         m1jRhtheLzwrvs/gbYaLpHjFPelxm6jeY+WyOJXxJF7sCFNY2o12Dx0NlsT6Am1ThIaX
         Judeib+yTE5TUCXi89Sz6pyNbHDi/umBgaDxsPIK5bAhugtK7mHhMqcCU6T9sGks6N/Q
         mbrw==
X-Forwarded-Encrypted: i=1; AJvYcCVnTXpH8vWKXmaQhD+E/Jvb23/mBcUiScAEXeV7d80Vhi8spsb4116AwhhBybWj7DUKPmg52AakXoKUO/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHi2qKMQqqAJlP5k8yR1DtNDQN/b2BBMcFnJraSgTiLvD9T60S
	6pc6pW40vEqDhPqyf1b1Uf4pIRO3IiNIVCJRjQjMHtJMQkPm+d7Qf+qN4/tBtS/rh0r73M5/XoB
	L/k2XpFCjdakjdX0S9A/aW6DRuVe6RF/WJ/sxevSlh1Dxx0i3RUTNWlG8TxOJ0A20zlA=
X-Gm-Gg: ASbGncvyHpiZTe4pUWG78LDUfFX9Bh3WsSZXs9uXKuKcS+pfcAO3PbnhL05qEVk1rMI
	5pkSVSXX+nl2adWrn4I1uproaUBUyRNcGT6rCzZ+WRJAuAj9osuFMWstuT7cHFaH3Pq6C7C2m8n
	0xf9Wz9dpExzg4u+3+ut4tMGBn2vw8vsMoTlPsp11Eyfy1kBpCBCm+/cL5QKXWW5XrpNGJeaoW9
	wbAxnZvoip10InOpj1OzFXn5TUFRfqVOOGpE53ckddhuYnvynKALZ3yyS6fSVgUA2XORwhSToCx
	E0jI1ofPS1jsW2TneO/dZujUp6lTlCPvYikd7sP6apaesfzr5a32wf7vXttzsjSuHtjYrBb3N9n
	RvwHfe5q7EfrqXEBoBHawQQ85F8n2HB1HNj5G6k4oJYnYD+2NPw==
X-Received: by 2002:a17:90b:1dc4:b0:330:6f13:53fc with SMTP id 98e67ed59e1d1-33bcf8f870bmr25361206a91.27.1761114752779;
        Tue, 21 Oct 2025 23:32:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyy+S2WxF2RXCWLuWUbI03Sz1JIPlWQmK6bpEB8eaWAIQhSBRwAhnBoSn52WHDu8LRAbVz/g==
X-Received: by 2002:a17:90b:1dc4:b0:330:6f13:53fc with SMTP id 98e67ed59e1d1-33bcf8f870bmr25361184a91.27.1761114752373;
        Tue, 21 Oct 2025 23:32:32 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76673a86sm11931778a12.10.2025.10.21.23.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 23:32:32 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Tue, 21 Oct 2025 23:32:30 -0700
Subject: [PATCH v2] dt-bindings: mailbox: qcom: Add CPUCP mailbox
 controller bindings for Kaanapali
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-knp-cpufreq-v2-1-95391d66c84e@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAH16+GgC/1WNyw6CMBBFf4XM2pLOWB+48j8Mi7YUadQWWiEaw
 r87sDOT3OQk956ZIbvkXYZLMUNyk88+BgbaFWA7He5O+IYZSNIBJaF4hF7YfmyTG8ReqcrYsyW
 JCnjRJ9f6z2a71cxGZydM0sF2q4P3tNY6n98xfbefE67lTS8rUn/6CQWfaTQeT5KMwWvMuRxG/
 bTx9So5oF6W5QfwtujcxAAAAA==
To: Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761114751; l=1211;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=uaLbcQUIr5YUqcjrF9noOI3rqaP8x3PY0YKoF8vsSYA=;
 b=nf2I9cNcUUz1qn+RG6q2SbkljfhGazq7TfggmPqJwt6H4cuI6D3bX71JPZZhxW6PCetSFQnd5
 lx34cc/uOpUAsXPJY/EHWnl7JAcIn6JyESzxVJ0v9B92o8dN6Ljbknl
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxNSBTYWx0ZWRfX0Wh50hlH+GNR
 xwHMY8ODgNB7h8gy9wgbGcQu4ypltiH8Sn0F6Q2cKk78W5HYCg5zEGJ/4cmeZ/BK3Q/wnVVjI+E
 aO5PfmVUGILKHvydNtUm4uM7ltc1Uf3dv3igk9I+CHidnjVLURKCINMC4NQ+QRKDr+Y3jvpLEaj
 BOohH55rD/VTyKNmYx9lB0hEVyfW3TAlFxDCeWqs2g8JhlcggrUgBAoIhroCoGT0q7Av2g8jrNN
 QNYmevJ5Mv0iLDo6/ZAAnvHMUBdJmdrAAYOtkC/iamjnPdBxtQGNqVQaiwPbV2pqK1KxbZvBrXT
 N6qAi6pJxWWE+L6xy2g6WCM9JoQTR7Qvx80n9kR3AHEpwj1rzemje+ZZk9EbOY7p9jKIaEo9Mfd
 UdJD88N8DaQ/szmXqtBCM3tNRe8UZQ==
X-Authority-Analysis: v=2.4 cv=bNUb4f+Z c=1 sm=1 tr=0 ts=68f87a82 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8jNUSCxD5SpwfXmMkmYA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: MoSiRENSORFH0rxlMiv2bRNgjVxdK7ud
X-Proofpoint-ORIG-GUID: MoSiRENSORFH0rxlMiv2bRNgjVxdK7ud
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180015

Document CPUSS Control Processor (CPUCP) mailbox controller for Qualcomm
Kaanapali, which is compatible with X1E80100, use fallback to indicate
this.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Changes in v2:
- patch rebased
- Link to v1: https://lore.kernel.org/r/20250924-knp-cpufreq-v1-1-1bda16702bb1@oss.qualcomm.com
---
 Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml b/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
index 9122c3d2dc30..9e91247c521a 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
@@ -19,6 +19,7 @@ properties:
       - items:
           - enum:
               - qcom,glymur-cpucp-mbox
+              - qcom,kaanapali-cpucp-mbox
           - const: qcom,x1e80100-cpucp-mbox
       - enum:
           - qcom,x1e80100-cpucp-mbox

---
base-commit: aaa9c3550b60d6259d6ea8b1175ade8d1242444e
change-id: 20251021-knp-cpufreq-3449bc8c2014

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


