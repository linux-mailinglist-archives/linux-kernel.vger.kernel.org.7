Return-Path: <linux-kernel+bounces-831380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C2EB9C822
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE8CE4E2E47
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B512D062E;
	Wed, 24 Sep 2025 23:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HhxaWlPg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B66729CB48
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758755889; cv=none; b=jHOQvWrgWt6sk7NybzmzIrd4b/KUXS2W6K4tuHGXjjoGh/453WJ3qf73oqC8TPeQxASf2ktK7cMpzX3UaKj4f7QIUN5mcbWNYQwgU+AkE0SbGpqX7MCWi01W2ddWbvTgqKZbor/3YQY0bjzf1QrNvkxzzZrPiK0+C5T3XJarySo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758755889; c=relaxed/simple;
	bh=kyjRNC+4QFZXsAkWIG/lpnFNbLXZy7kZKz+PYFfTV8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TKs9GIc9vCrUh1yxVZZv57PtyNGj3WvqZxCleQaPhZpafuH7b8xW4/vBAGPvJeukai8tWz0TPXH8GXiHhRDV8nON6cJNLSnGyxEhGqC4OfaLs3RgJH3VOjgtluMn520fDIj1hSFx+nK+yNOgBjRlQu4B8ggtbyoMjx9+hYw0Ajk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HhxaWlPg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OD3c0O028188
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:18:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5RPuIRFwOuvbIw6dAzYcNGhI9caskedBAXe1e6dXYJ8=; b=HhxaWlPgpT43z/+z
	pB2LBOAb6+bUF8rylsG5jYdctRryuYmuKjCaURdvt4KsKw7hsKk1of+OavF4dXY5
	sOaz55fQbSwMVsR3vXdWJVYqEGDCB+ZOX99WsYGWPrv8VHoAWywK6fREXpObZSKg
	10+HYkmtrT1aRWQJRFNOvOKmex/1QhXJHeuWXlncFs3jTlLBwQ+xTuF8qsliqpEJ
	6wfvHnaZBkTVSxK8i6GtyVzjjZR2GWu3vqkk7myb9YFbp5qwK/dLC2jH2PT4THZb
	K6pvqo7TKlka7SPrNxoB2Jm7CTc9e8xNYrx1K2D0kdMejGVDvg6JjtzVR6jeWHXg
	VKfZkg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmnxbrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:18:06 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32eb2b284e4so476450a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758755885; x=1759360685;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5RPuIRFwOuvbIw6dAzYcNGhI9caskedBAXe1e6dXYJ8=;
        b=aq/LToR+jFNvnTFjX/7cmhhcGPTNDYSdGTc0Gwsb44ZB7EkY9TqSP2zDNjulSWWzWy
         d1W5dkDzQUP643cyQ0ngczzE1asxfov2+gBJchS+VipaniplvpwOH9H2C6FQYksQ8tpI
         fJue43E6R/BjLa2d3noH+UYH0KDEF5sEgtKIP/bEC4SGV9WYN0lA9IqE3tW53LnaywpM
         S2GleW+E/j5m9P8Uev3+1vQoJlUM3NKWM1xnJqZgBj8XcB+df9dB0hbrJyrcqWYk7Gy8
         kQZ9LunSwGYVO3dGpGcR9XMq5S2iMzUhzo4PFXj8YESsptXoSbC434o7wkW6sgiMC5Pk
         SjbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtEyIk1jnR4Kno36UYBSQl76H/VxS3MLPPr9c/IECqyTckfx42iK0/apVC+6yT4SYLp8shx9UCG9rkJkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoCtEsibq11crI3RUMGyfXUeeha8O90DdBx0BZxixWO2/LGySO
	+mdQ55fW0mQcYt4c+lGb4REYrUYT1PQrWa5crzIbW8jOCQtlc4iRM0RSyWyrChkBAu5jCK4+y+i
	zQ3pRiId+ZWp6HDs2INqHe3KSbDUPIOlABsv5NpI5aNnHscelgRULsALCLywVu833uA0=
X-Gm-Gg: ASbGncsgKDcqLrNaNvHIuTF6mJpwOQE4ZT9k15hSpN8NmHMQv0vqcg8Ltu1bDcBEN95
	fKoYZMsX2Ye0UDn5QOIfErYSS7G65BnGyDGtkobAOPX043qF8GWwbXPW54dr6cSOosJbx1OSI8s
	OOaq8O1mCDSbBxqp60UdM+bD7Xe09SO/4EyucJxaUVaX0P1RdjnLnA+c7AjhpHnUpJ9J1P2YcD+
	IhLEJhnLe7FqEdRVM6yQYUH1K0gql5wiUwNkcmopBvXv9zgdEQ5wsTyeUMWLhhMuOxkfB2R4zvg
	Dn/MLOKRlfhIHp1S/lz4MEGd5VOI4PAErR784+mj/fKg/gDSvKfuaiNkPAw404QG4VIWz+x7X0n
	wnnKx5OMLT5e8DxA=
X-Received: by 2002:a17:903:1cd:b0:26a:23c7:68da with SMTP id d9443c01a7336-27ed49e70e5mr15861795ad.25.1758755885315;
        Wed, 24 Sep 2025 16:18:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEb2g9nB8TyyjQlnm+SE/pRKN3CPIDLQk1Kr1voneYm5CFJO+CITrFt9uAetd0cC7Mbqm1pxA==
X-Received: by 2002:a17:903:1cd:b0:26a:23c7:68da with SMTP id d9443c01a7336-27ed49e70e5mr15861575ad.25.1758755884925;
        Wed, 24 Sep 2025 16:18:04 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cda43sm4321385ad.25.2025.09.24.16.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:18:04 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:17:46 -0700
Subject: [PATCH 1/2] dt-bindings: arm: qcom,ids: add SoC ID for SM8850
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-socid-v1-1-fad059c60e71@oss.qualcomm.com>
References: <20250924-knp-socid-v1-0-fad059c60e71@oss.qualcomm.com>
In-Reply-To: <20250924-knp-socid-v1-0-fad059c60e71@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758755882; l=655;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=kyjRNC+4QFZXsAkWIG/lpnFNbLXZy7kZKz+PYFfTV8E=;
 b=JoDFbxHcNEziskqBRxVQmFT3ZzJqLdKTCVd2Y6JfT6TTMCcm3Fj8628kv070ccUabXzW2kfqx
 BixwcC8YfBxCd/ZhQV3EjLhWiEHzFL721ikWz6zrPhyQX58mWgzVBPi
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68d47c2e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=-GldTGkhEULYXnHVInEA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: g9wxEEmRWJxRRq9ads3XGA6mA7idoYro
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfX5D3G1PITUaIw
 2QRkdv2hp3us/ZGMEai89VfcIqd8rl03k7n4N1rMNAyAeTbKr24QrMHL9e/nAqgooKZdE9oph0z
 CS/OjG0aWvbANyZTwcSCZ6cXQfOMZLEYw+DCc2k5w8MiSiYC+rjxkiyAKT3WVN3cczKpJl9s85H
 8GNEcwT/XfziYwnS1Us/e1Dv3Q44LzMHJn8gswqCgVCFt7MOur25mF1eWSbaLeanI2b7KqlaJm4
 QuDtzPj+y3L8M07RILUxPluNfXpJ3yu1R1WiLzX4B+K2QICnnLHdIV8Rjf/aL4b2ORHtTXLMf2j
 BiFZ6RGHFl2S0hA9q7hBAwAq7n7afdDrzAURwyvUpB0RbZqmy6nd/fd9iyLN+bpM0Dhpbh00Ezi
 88xlvrA0
X-Proofpoint-GUID: g9wxEEmRWJxRRq9ads3XGA6mA7idoYro
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000

Add the ID for the Qualcomm SM8850 SoC.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 include/dt-bindings/arm/qcom,ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index cb8ce53146f0..19598ed4679e 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -286,6 +286,7 @@
 #define QCOM_ID_IPQ5424			651
 #define QCOM_ID_QCM6690			657
 #define QCOM_ID_QCS6690			658
+#define QCOM_ID_SM8850			660
 #define QCOM_ID_IPQ5404			671
 #define QCOM_ID_QCS9100			667
 #define QCOM_ID_QCS8300			674

-- 
2.25.1


