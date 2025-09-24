Return-Path: <linux-kernel+bounces-831383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5B5B9C83D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A88C54E2ECC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960AE2D640D;
	Wed, 24 Sep 2025 23:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fyVDwjd0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644232D5410
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758755925; cv=none; b=CDGP4Nv6CF9WlAL6/zGD+RYTYCmqx529fFBQfHWrH677W/VT7IHC50qLjjfL+uOQ+Lpk6BfGwjLuHj9+ndIIgdXaXJUB8rgNlFyZuaTkk/S6BfDR7CZJ+azbHbjdNSblabLfzYHOOOyaqt6as+AfuNM24VGQZgvp0r/LOmZra0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758755925; c=relaxed/simple;
	bh=+qkSekDGOjNKG/k7dn905Dlzpg/GVr/t9jtr3sEQRwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=teiNYUg4BQ3e/qVNDlBE20cqLcS88uNK5f65dLYLEc2L87YTvak7Q8DXWAQu/WRNTQ7dLnATD4FcHsayCtJYfhERBNa9/MaJ8FssZGLqor4j01bB9OtAaHnydPJ3GiJ0IU9IlMstsIpG+vxIFne1SAEzQxT68rzXxa1sZJaz/1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fyVDwjd0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCW1Jp018070
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5ypITQmkoYFzW0JuVREFsC
	yxSWVZiss9ZTnyYLXQQuU=; b=fyVDwjd0aZ9gk527VorQYQ5d1tzMA9uYf5wfrF
	95hMtjqb56a/LsAQlkXyGHCI/l6wIs2hnD8FnYvf/V+9fbMGQ0GI4CswqSkw6CEz
	TnRgSxXFVi/ALu1S3m6JfIme3chs3rRxe6zoFpqWJI1FkTwul3bp94Y/I3OLwAjT
	Y+AfxVn+5CAulN5XkRjjvXF1Amk+oImbRNxMtQRmPzmHeBRlPx6hAff/qxXamUqn
	UZzN//xzlkQKb54RzfcW8q7uanAaiT2XyFh7S75fZbFehjs0v4VO03bmTB33hWIU
	pGx9+wiB8IHxkePSmWHyq0U3n8jvn+Xv/CiYXTAkSm5BFkgg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3kk9yfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:18:43 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3234811cab3so300248a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758755922; x=1759360722;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ypITQmkoYFzW0JuVREFsCyxSWVZiss9ZTnyYLXQQuU=;
        b=Z+5sQ71CnNN+yiGEI/3uauEItRTkh54fUXTZwlUh4hQbzZ9/qCYpFDU9rYO2e3SlZd
         9/Kz4wg7l4o/wy7RgxPZhLqXYCY7cxf3hdieojkb1k86Z6y1BoqXI9MV5Qk7sdijzPbc
         tGtreDa3+t3U/PDGGwWrFTuQ10F4QWX0pgdthbBYvsJ8wu9PvNX5u2OR7ACKS4lk+MPf
         Rxb4E7y1gqsrv4zEuAyXGuBQbAwExxnPqp0jzNFBLe6Wvk/YM+JtVjzAnrlHCXsNDMBh
         YJokOTQe80xt2fBmR9T31yToZ3cootrE3ofTVpLYG+dZ4jgxDfqTay3kZO6JtLcoUCOg
         Sdjw==
X-Forwarded-Encrypted: i=1; AJvYcCWTBbtWScIOjeh2azpU366TtYkCUPC7rC5v5acaXZIlBcgDOhWHXhr+huA2kJXph2B2nWB1BEtteewww3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVg5xkQBq5MKiDdfUGtGYp8YBgYneSKUuUKBwyTrRaoLtIhKcQ
	h+FNy+trWdf4Cf1urkiv9s6tcpizegFLuMwFls5OjLFWYN6foT1t0ZwhzkHjnqvjnZJz4Do3vCW
	KDsRhWzaeeMhpTvqGMp6zNuQaX/STfiZxQJzhKcbDdy9rb0szCyQxc2XbZSGwgEr6V6c=
X-Gm-Gg: ASbGncutdPfimuZLV15b8tlc9M8vaaOmYGxvYwLjc4P6qRpBia3hKtL0nqKuqopgt9y
	eO6ICpQuwPmt768P6b+SgtppxRvNKbuzmSkOCR8xY+aPHPWJkeygsO3oOmVlB1XteJbfpDwdI1z
	R9stOLST2bylp7HArSFg11mGyIqUcPZ/V8VVbMReLz2q6QLH6nXyn9WNt+zP+tz50GyzXgtwUIC
	p8EVXpadmqizpWG5pRTcDr0PxBZaS4B4T38BfXxb6j5rQfHIgRmmkooOTComT5AJey3SCtxtVHc
	9MhoQz2v0Jnm2qOAE7rDKL1tU/YPHHG65JIQNPKHR7JnaejLAvxgwOSC8kHWnBF+ENxNr3+XcBw
	hGp4UgCN8YtXm7W0=
X-Received: by 2002:a17:90b:1e0a:b0:32e:4924:690f with SMTP id 98e67ed59e1d1-3342a2437c4mr1307655a91.6.1758755922284;
        Wed, 24 Sep 2025 16:18:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnkwZW7OOokn8gI0yk0E3I0Ln5FclDoYgmkYTDIztv/RM5NLyWdggkDIInIpcowpngDxQM+w==
X-Received: by 2002:a17:90b:1e0a:b0:32e:4924:690f with SMTP id 98e67ed59e1d1-3342a2437c4mr1307628a91.6.1758755921840;
        Wed, 24 Sep 2025 16:18:41 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53d9160sm385470a12.22.2025.09.24.16.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:18:41 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:18:35 -0700
Subject: [PATCH] dt-bindings: mailbox: qcom-ipcc: Document Kaanapali IPCC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-ipcc-v1-1-5d9e9cb59ad4@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAEp81GgC/x3MQQqDQAxA0atI1g2Mjlrbq4iLOEYNpdMhKUUQ7
 +7Y5YPP38FYhQ2exQ7KPzH5xIzyVkBYKS6MMmVD5arGPco7vmJCSSGgc633vvNEdQc5T8qzbP9
 VP2SPZIyjUgzrNXiTfVnhOE7/l9eKcwAAAA==
To: Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758755920; l=1157;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=+qkSekDGOjNKG/k7dn905Dlzpg/GVr/t9jtr3sEQRwg=;
 b=QQAn2FTnIVHInKPF5KCqvL/M8G6naMhW9ZVdAAUor+YhEmraG26rDoDSqc2sr6WTpTQ57JzrU
 XeJwFCepJ6yBA2P/cO8VwzTcJwI93Y2YPT1AF4d/GohtRYG6dyhtX6o
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: yvO6VlSxIXSTXaUKIv5dWWHPb3G9CQrG
X-Proofpoint-ORIG-GUID: yvO6VlSxIXSTXaUKIv5dWWHPb3G9CQrG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA4OSBTYWx0ZWRfX2MqXGlpP38us
 05L2EpPzDaXI+8nQyUDmTKyp4p67L745alX+BxSacxP3RGJkSeajHxBUoQICUFTqp783GrJ7Z4e
 zqHWuZytkuodL1eHNoEQnu6a5nqWlLzTv8p+k2o3Y2cWnpPdcySASkK0v+D2BLIfUiOVmhL4fvh
 9j9Zlp46XO6cYU00yHmQ5FZvHv8Hi6Mc3BX/4fYIfyMQsNL/8FGZdtwve6CAi8CsBmOzIYdJcDj
 vuJVzFQ46ZWGiDoRmy+7b5kDSwtWDWC9FPe0eFd151NXsAyOSnP4Rn3W6b7p3KVVBweqSpugatz
 G1ilUiQK/dc7+J+NSXS9uFEwTAfJzh94b/JH/5EUbo/ENjmrsbqPIxJTcXzlU44xLvniT8so41S
 g4Apr/1c
X-Authority-Analysis: v=2.4 cv=BabY0qt2 c=1 sm=1 tr=0 ts=68d47c53 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=U9C9QlmAXZJKE0jXtekA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220089

Document the Inter-Processor Communication Controller on the Qualcomm
Kaanapali Platform, which will be used to route interrupts across various
subsystems found on the SoC.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Add support for Inter-Processor Communication Controller on Qualcomm
Kaanapali platform. Including the document and the new bindings.
---
 Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
index e5c423130db6..ee3fe093e3ca 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
@@ -24,6 +24,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,kaanapali-ipcc
           - qcom,milos-ipcc
           - qcom,qcs8300-ipcc
           - qcom,qdu1000-ipcc

---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250917-knp-ipcc-00633383aa48

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


