Return-Path: <linux-kernel+bounces-742119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F97B0ED84
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 119B2963767
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD465281353;
	Wed, 23 Jul 2025 08:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q5fbrSFO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDA3AD23
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753260244; cv=none; b=u2o+ooG4IdBxruIxp9sm5u/8ZwU2nT6gASSZ6IXS1ZLwGjssynUVUQVnWk7lUb3Ct4Q0ZHdnDqKzHTM+MhIFyNSSJ5vs4ghYhjhjq0IeMhbsUUAqTPs5U/gBj3DYh/09Jx+37evnp+rsnMX33s3Kg9q/CBgIj3+5Q5wkI7fbu40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753260244; c=relaxed/simple;
	bh=XUasQFYoY490T8WsoG5vluLO+2GFii8wwDKUuvEBYbY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PfiHpc9AsQcFdv2i1kFH9s71WJeEJnPy83AB4iDMIn+NWcVV06uvZNM8WD1InMkWeoREeN0KHnEmaEXA2/YEA/ohYlwXpU+UA5MlNzcHkefI5QuymmJKwbGPKhXGMw0rCzYV87ghXgj45hmeNS6BcCpB2yMGUFmwlrm51G8M230=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q5fbrSFO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MMNt6u030489
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=C81n/IdXv7ES+6R3S+HgxZx6XJbHygDB5cl
	Xpax9EVE=; b=Q5fbrSFON+NBCVlx4cQaAoXSoRk5Kfqds4QO0/GsECEK58+T5yg
	+dSo7cd0Bei1MV7cIOsKMOBOWFZ/53ebcjv7SkdWxdsfSF24ya4i6gUDDWh4tFf5
	xdZWMn+C3lkVJufdnJak6MdPoPSkDVIpno46hO3nn4DdPvcWkRWZmsXChnzj9XWr
	N5su4QsEZLLGg0ntD6cUUHhnwst8PevKWoNz/FNg63Tt+HTIPcz7WVGGwd0amVFQ
	/oB7OdtQZtveED7wEaZlh+HfkThOvd6bB2XEXWTO/M5W1zKkrhA4uSpZk+ZRjrie
	9x/VFJQ8mHHdR6fMSVkBiYNoohLbWwphb7g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48045w2tjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:44:01 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-23507382e64so61241705ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 01:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753260240; x=1753865040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C81n/IdXv7ES+6R3S+HgxZx6XJbHygDB5clXpax9EVE=;
        b=OqFzkQvqjmRJyBJHz7H7cMVgENfreagDBD82UdSjET3j9NfF/6jceVckcVSggqpe9u
         0Ph3clBoZOehHPuJtSGt960FSghOrK2pnxGdW3j92B1SraGj8DFyXKC3a6kX1OJ2Lh3B
         RlIq24v+E36DhF5n/SF74YxbFvzKf7JgKpadJM4cOInBRkUJ/EhIuQMX3Qcesp6FHVk4
         C3C8d6zVMIPtpTIoCubfKSwtmLR1hWmrFjvTI3DfkzjcjG14YaqPmlaUdrvzrl8FgKL+
         1KZ9KvZhQXJtE/y2EeOHhc4nSQD94sMrvFiwidk88KBIxuMzm0sY6GH4TNBn8Gw+EfC1
         9XfA==
X-Forwarded-Encrypted: i=1; AJvYcCUmXcYETF4vIZJQ8EW9T6gZjwYU0uGHHKCGUucX2Bs4mt4lJ8uJfJ3FrQPMTONCavRYxezFIN5ATwnwVWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5EQ0M/nTq6W78HhkpoNvz5VSvzNo9XIPjWeez2gZOrCSUMhNk
	3t8jvIFUeBtji3hV+5jreoqdgWR+3s3hnHFMaxvc5Msw1hDDnYvb0OGUbtRqTPDHxr+Y/2eKvGy
	oJDbxr1BgZVjGk5V/rOHKe2MqHHeXAW//sR5PvaicDRN6pKdOD+Qr2nWPLm0s86yR+2w=
X-Gm-Gg: ASbGnctb22Bjv+UulWC8gbU4KrAOqjSK5QcPzR6Gt7BiRzhDWJAwhC87HAMCIj9bnKm
	djm5FGMrKtn67WyVz+YkZqsTn6tt/AcSqIYxUYZ0WrlHeZ/ZYLqF7fWH9G7NRnXrlOgCGBT5OKm
	fO85W6fnlqfco4C0T4MauZV6UoyS1OUnksG1gK3Khq78O6q0XENeTVEdtY2AAvGtrv5HH/aMLhs
	QChAhFA+vkH/vGPMmwqwN4vY/DKQLxn4mWMT7IIFW3NM+csT1m6ADj14vjbkfEcBvapKb68x9CD
	fj0l2mUsP/oj4helEQgT8GsRDP5c26pCkPD0vmizlXVtdAAIa5rMZhrvJIic9BmpEb6JaBh/Gcv
	jNLzjAB3w6+KC/WI=
X-Received: by 2002:a17:902:cccd:b0:234:98eb:8eda with SMTP id d9443c01a7336-23f981b445cmr27163915ad.28.1753260240179;
        Wed, 23 Jul 2025 01:44:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtRsvM3+AQBUPzMzqkonNubNB+b5qEeLhTQ4cIhxEqCbs6BelcoQshzWdlOA/REzw7hsekzQ==
X-Received: by 2002:a17:902:cccd:b0:234:98eb:8eda with SMTP id d9443c01a7336-23f981b445cmr27163655ad.28.1753260239761;
        Wed, 23 Jul 2025 01:43:59 -0700 (PDT)
Received: from yuanjiey.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e3c95sm91696645ad.34.2025.07.23.01.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 01:43:59 -0700 (PDT)
From: yuanjie yang <yuanjie.yang@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_tingweiz@quicinc.com,
        quic_yuanjiey@quicinc.com, kernel@oss.qualcomm.com
Subject: [PATCH] arm64: dts: qcom: qcs615-ride: remove redundant gpio header file
Date: Wed, 23 Jul 2025 16:43:51 +0800
Message-Id: <20250723084351.4627-1-yuanjie.yang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LL1mQIW9 c=1 sm=1 tr=0 ts=6880a0d1 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=EiXXGwTVnQMrs5tmZeoA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: aKj62vByKQUqrMKRxmG33XbYlvjj-BtS
X-Proofpoint-ORIG-GUID: aKj62vByKQUqrMKRxmG33XbYlvjj-BtS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA3MyBTYWx0ZWRfX25TPO5YVWFhD
 5CnlAt51SZT36FFtBFOzzzA8qkOsvVD6O1EChTTQU5eQzBsVPXitCsWGLZYDkN77CVE2I6cIXKQ
 6OMSgl2k3rmwqk0Q/RDxbBvBKsFLTJJbp2i/P8NbYjV7frytAtOXxqpZmykP1mpWqykT7qMPB3t
 KxsHUAL1dVgJQGn/kwSDY/xqOW03Khqyg9hIEn3h25AQyu+ELmQRohw58hvNpKGja253JP1du1M
 Qc5M1Qmxzk9I6aex3SZsXNWTDJd5lP+rwom4LbiKUXfssdKL35sdGmAlhl0a9hBpLfOXu55xkHZ
 INE8v7DWwtCUD56iqb1wEdFfIff+RdbH+sXiVsyfTTC3pDkYBfQ8QbsWqeHoGqJc02/Dr6zTqoc
 uO9D5DcWhM784/TnJ+oGG4af9KVa+FBV0iJyaoeNSu++ecFDq7Q4G7ZNuS37GvTEjxVFYkr0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxlogscore=936 clxscore=1015 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230073

From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>

Remove redundant gpio header file in QCS615 RIDE DTS.

Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>

---
 arch/arm64/boot/dts/qcom/qcs615-ride.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
index fdad6388f6f7..55b9a62cafae 100644
--- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
@@ -6,7 +6,6 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
-#include <dt-bindings/gpio/gpio.h>
 #include "sm6150.dtsi"
 #include "pm8150.dtsi"
 / {

base-commit: a933d3dc1968fcfb0ab72879ec304b1971ed1b9a
-- 
2.34.1


