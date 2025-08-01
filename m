Return-Path: <linux-kernel+bounces-753643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B88ADB185DE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 18:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 619233A7684
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813981AAA1B;
	Fri,  1 Aug 2025 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gMURKO6B"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF651A0BFD
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754066180; cv=none; b=I0OxintgYUcRhsL/KEuCiJIc1V485wReqwivPcHRR5C2AICUp95zH5PALNKDa31tgZLd5BBV0vMuVRv5dLH9TNTLmY2DIfYua63JVn5kGfhvxFX88UHiZGpyy09YepwpFmETniddOqVtt5Y/KysZaS1gKN3wqw3Hm8KXIndRPKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754066180; c=relaxed/simple;
	bh=USVIRTYvItXP8BGf+5XlbaJOiJKBYU+1rya6gVHqn8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VDU9W78h3pS5+IebQS0L40W90tVHr/KJtj4SYQuUMlkfKwxXDf2OqbB0jnSlMJGnb+NG6XT2QeDxlPOOsnStdLdr7YXg77lAm96yGqPzLVey3v9cQWUe1xAY0pKpEsKTJ6vxos0QamQ3csop7FQgEy27n4nTWqZGsw8NjUNN0kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gMURKO6B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571FLPnQ003897
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 16:36:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=i93bfBUxotY
	KxTjsE6wzFA2Q/b0JiDSP7PrC2Xp3hqc=; b=gMURKO6BOkDUpx5AG86lNVc550f
	93+3neyFsNZzdo8c5nnixXNezJG9oyN4wbQkU5Ksu2NaPRoi4TKqfhtJp9pkp2tm
	jkKVk59SgDMUHki6V6SD89Fa+aJFHdJrQ+BH0v0QvJutYWpcAPP2uZl5hBjzmUgy
	EIAlX9qygfcAbb2sBA6u3KvMpSrxYCR1umva86r8FHiOoQGcz6pQua1AbARrHk8G
	+lFuxbYgJJfbKHgME7XtOw0R0VIsA038qmMMS4RiY+S0b46pWWXt+6AlIOiO7D8X
	ZnxNRihBxH8tiV14p0Blra/IQGZI4HhUXeZY7z980QHvJy+qlF0FF+JvGYA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pm2vbnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 16:36:16 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b42099903c3so317853a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 09:36:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754066175; x=1754670975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i93bfBUxotYKxTjsE6wzFA2Q/b0JiDSP7PrC2Xp3hqc=;
        b=M9xJHWSJzY6+k54hgr8NKcKZMoh4BGjTWtVvaIfHmNBYxvQCk0BO9vuwDz9pONnL5F
         BISCGrMEXQ09G/+26isVotxA28wzP3yQC7q6ImN/u0zUwlcy5Pjdtx3p5kSmWDSyadL8
         Hw5Db/dsaDd3av4qRKCkjnzuVuMNmR+2geQ40tauf6xLVqAa5N6duoX6qxjM+3uI4WV9
         UoXbmqJXzdY/K6pG2RxMQeqo/2dWZueBBxNuGIw2V8bjevMqScNi1AJE4HJfA2VNQLP0
         e5H7xSdVv4QEJrgHvWaFiAMii168LSk/iKPVKXD84nErfsEz/9n+BRC/czJfoJiOoZf4
         TOrA==
X-Forwarded-Encrypted: i=1; AJvYcCXdiuQtKEQ2qMeNdXjITPZh7jQIxKZLDSAbNAAYZNbB/OWh7xtbUXkC7BujdYmOzCRCIVBL2Z0fQ/glChM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXXr5FWzHS3MPMg/5Qxbm/DkDlmr39ca7mHyy5JvFBrd2OVVog
	1M7h1HR/Qd3gUTme59p0OW8waGAtIO2JZNRKlFV3urdtpjCasI62s7/uQCue4DtZeJBbsBQAXpj
	rYob7sa6r0CEVLBrLYLu1bvcXYlQZU21oDEVa1OytyL3apJBEQbPHRL7z2/I5XZrpZLE=
X-Gm-Gg: ASbGncv7VYaVjH+bucalHZaL/Oynqlc5dU7ibzrZ73oZJBAFmgrKjxFlUGSXXoVz7Ww
	0Bz+zVOLbrOa3GsV8R4mjMhqFOiKZ7lHGAfSgm67UIOxEgXHJ6zUDW6LFZdVuvFyVeyroUvJgHy
	DiQqsldVUooiYOfr/g/4APfGBSMi4gvU2r/8pNsulEcBmy8n/SSsZ7wunn4fCTpGarQf/8+KtYc
	Y6HuerYhpGIh5z4yJjvokS61tjwsnSbwzEhEjJ39RjKlRwE5LmTPF7zhF440MSpR/VRiHlOMVTH
	Ukx3yK7StTZQXaHpqoq3EiQkH983Ni7VaeGjOZEx7rrqRhcDwxIRYi1hbAIAgbQePs5cURo=
X-Received: by 2002:a05:6a00:2d1f:b0:76b:cb1e:ac3f with SMTP id d2e1a72fcca58-76bec4cc7cemr4470b3a.7.1754066175505;
        Fri, 01 Aug 2025 09:36:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTMLKM2eZ4vKvP/DSM7I+lMHWQJybrsCRF+VUbih9RkpYt4jteso/4tQ42Ujq1Z60KobCoOQ==
X-Received: by 2002:a05:6a00:2d1f:b0:76b:cb1e:ac3f with SMTP id d2e1a72fcca58-76bec4cc7cemr4444b3a.7.1754066175138;
        Fri, 01 Aug 2025 09:36:15 -0700 (PDT)
Received: from hu-uchheda-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfe74bfsm4508775b3a.121.2025.08.01.09.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 09:36:14 -0700 (PDT)
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, umang.chheda@oss.qualcomm.com
Subject: [PATCH V2 1/2] dt-bindings: arm: qcom: Add bindings for Monaco EVK
Date: Fri,  1 Aug 2025 22:06:06 +0530
Message-Id: <20250801163607.1464037-2-umang.chheda@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250801163607.1464037-1-umang.chheda@oss.qualcomm.com>
References: <20250801163607.1464037-1-umang.chheda@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 3p7Ba8GdH6QGiPUc0h7s9hFy2UklRnM1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDEyNyBTYWx0ZWRfX6aLM0lquGO/Y
 aYTloVTMSOFWFwRZG2KTZakTasz5uq2zSeXyL74lErpjzrMQkiDGdhTjtH60LiZAeV2WeWuF63x
 3Uh+U4Tu+QMxVsESp3RiYIxBtSD6lo1m8qBc8sxxCk5l3+O5O7AOmwYQNScuxhNW6kqHpPVpJ0B
 yCSRLf2mcVJGbab4uM7RSrkr+/UeVC4lDprRKoN11TMKwPgo45ZAVxF4WQoywVA6ANYUtURsEN0
 GsH2XYPbyo6srrGzV31m4a8TUERe4k85YkTCxanIlHwsiR84ZAYlkC/c9toG7h2JMwPf9lsJ9Ka
 aCZPmNe3tZKMP5/9TAZOAWBCDyoFbpfdT0hwfumITbhYzfl7H1szVBx71sWV93k9CpWBqlS9eyZ
 guDZcImf9mepIhtH5i9qHCm8PnOnY27CxcwGmMBPrUsTG2gp8yEy8f2CkR5juldnBmTav7q5
X-Authority-Analysis: v=2.4 cv=HfYUTjE8 c=1 sm=1 tr=0 ts=688ced00 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=Zd15BVePnIxtF9Lu70oA:9
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: 3p7Ba8GdH6QGiPUc0h7s9hFy2UklRnM1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_05,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508010127

From: Umang Chheda <uchheda.chheda@oss.qualcomm.com>

Introduce new bindings for the Monaco Evaluation Kit (EVK),
an IoT board based on the QCS8300 SoC.

Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 47a7b1cb3cac..31e260590f52 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -950,6 +950,7 @@ properties:
 
       - items:
           - enum:
+              - qcom,monaco-evk
               - qcom,qcs8300-ride
           - const: qcom,qcs8300
 
-- 
2.25.1


