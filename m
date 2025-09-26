Return-Path: <linux-kernel+bounces-834115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D1FBA3E87
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14AF817501F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADF72F9C3E;
	Fri, 26 Sep 2025 13:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="migAbhzW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968DA2F83C0
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758893465; cv=none; b=Mcc0u81vHMU0yTZaGUCM6gpd+2ygrR1MTfBWPkwH8GYz4Su9Rt4W42oJiGTJeE9IBUWDbTjAgeYkCzAa7npbXZFQUl8N2WWEB33XIHRpchN/Rmyv7j2P5zPGXddAclAev6qG0Jt+X8p/66ngV/KUOBWZtNQtolmQjXVHxWln5uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758893465; c=relaxed/simple;
	bh=EDxK0JAECJqknU7nyBNM/XjceytGlGUL11eBwTOLESE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=glN/0jkqkp4zRxofkR5MouN/E+9j+VP5Smv/HX6AVzZSjQNagUmgrOS9omY21158ZwlF0E+tllvRHijGkh14OIuwNYEHLYFn+Xj+mJBlmE9BS7e/Ot96ytnZHivFUxEIB72YbnwA68A1Oiw3T7iUUM3fz68+cn0wQsIO9JKK7mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=migAbhzW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q8vYA9015984
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=dzJS/eOWAno
	Hpfft1/dBeRGBEhv7bksVWKJ4cITaZw8=; b=migAbhzWL8v+PgJ74M+ufkydUdS
	9n18zmVFuE/FC7LRNpBMccL6mJAKwAybZ5hDDQWte7ypvyvNYcUyB6beadrejWaY
	rR9dGUlpS4JvYl3MxAwkSH97mhh+6BIihQKyZSVZBQ5lMYzsK6u/moyL62hsc9pd
	EYzVA03srswTmqFZSaUWvMMEksf/2p2FJQhEgAdqDdADeTskKN0hcZm3/5JRnTvA
	lHROQLA0kjZZpitvydMlZyscK3tGu40+0QzYRFp385FZRidbVDNQ9Tr+y8cEFBut
	U57viTYbWXTwHmCcVYMfwolorvxg6jySaT0T7CPGKom+9ax3GGMBCXrpaNg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0rk07t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:31:02 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-78104c8c8ddso1719295b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758893462; x=1759498262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzJS/eOWAnoHpfft1/dBeRGBEhv7bksVWKJ4cITaZw8=;
        b=aoMsqIqHBA9teKN9Ic2E67iRZvctcWq6TdnZhCjr9e1PcF3/QvtKlsP957ihPcjNRX
         Os62ejdG09Cf/AoAKfmInMUBkE+4uPoSI8IdOqoLAAi/BVt1H9U9LdSCqhOSl0L2mmzK
         r0ieWDIP1gTdWLjaQpNtcW6wtEaOOHKOlTzsYX3N7Ufl7a3BGt3rLPE2sGMqjKsx1YKM
         eu5llQ6N+HGlu93/Jk1kQAHf66SU3DVd3pMCslrPPOHZqkO0drrFyHzJfZO93OnRPLRo
         hMFdufQflyP9YtMVC5uuqJBCC6z0+lNSmd6RSv25f+qZRgIN9MeViXuGmjb/s5fT6gJJ
         0fcw==
X-Forwarded-Encrypted: i=1; AJvYcCWXx5eecRTs/q2nB68sMEL/QWxaRnn8qk0DEA1jnOAiCe5s5sDwjOD3xf0WqwRN5XnCVJfz5zGHWDKhB6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmqgvBgQnZkbZXOKaqUeHGkk+IcNqy3u5SUFfYvsAq5vuyFr5Q
	4T5tZy1owCeFckyeXSjRrJgwMGq1ShXCB+7m2i+hANmNDBa7+ofsUDFVz9w+lP5/sLVx5FyNkY4
	X3hc/m6hlCztY2cPmGT/VgFw1qfyQIfYnj0QlqyV4wZQMszQVvYFMyyQVhV+bcTCHuKQ=
X-Gm-Gg: ASbGncuNu0ofD5Z0PWbvy3uiQ4zcer9A2QePK0RZkXeN16GrQGdhLTiWUGgiIuu2OHt
	hkYaYzKqKOQoc3q9HEoiUvpFHsqaYQQH8VKcaitsvlOsgbsek33TuJ85hF38zOuQmdpz6w/dXRj
	ROAsyIRdiYfT3fYihpOPqF0+XF0Nr3Cj5JyFoSLuFzxJdGJ/vSxuEm+Ik54fSMJN04iR1Yik0H8
	eLJgYkFbRdPentbA5VRnqdQ/D0z0+30GPqXX5le8a7G1+P7mLS+wTgK+Rg1rPenbnfKLWJvq+sq
	yduJzVVozHKamMOkWObNBPR9asFIWCOIVncdp5cJdof7hBhqWP/DaTEEapqeQFoPHTYKYN59cRt
	j
X-Received: by 2002:a05:6a00:1408:b0:77f:6971:c590 with SMTP id d2e1a72fcca58-780fceb49eemr7690276b3a.22.1758893462042;
        Fri, 26 Sep 2025 06:31:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLeHddy/mn17tTANaaPlDdZJPY7hKHUQGRRzCDSBlp3I0nv2etth7ZbqEJFM0oH9ZNV1jfRA==
X-Received: by 2002:a05:6a00:1408:b0:77f:6971:c590 with SMTP id d2e1a72fcca58-780fceb49eemr7690219b3a.22.1758893461423;
        Fri, 26 Sep 2025 06:31:01 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238d321sm4504174b3a.17.2025.09.26.06.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:31:01 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
        mailhol.vincent@wanadoo.fr, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Gregor Herburger <gregor.herburger@ew.tq-group.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v5 6/6] dt-bindings: can: mcp251xfd: add gpio-controller property
Date: Fri, 26 Sep 2025 19:00:18 +0530
Message-Id: <20250926133018.3071446-7-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926133018.3071446-1-viken.dadhaniya@oss.qualcomm.com>
References: <20250926133018.3071446-1-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dP+rWeZb c=1 sm=1 tr=0 ts=68d69597 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=8f9FM25-AAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=ubk9sFcynENsk3o0iIUA:9 a=OpyuDcXvxspvyRM73sMx:22 a=uSNRK0Bqq4PXrUp6LDpb:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: nL-s8Z18ehFh64xmc-X9oqK_tanxOhzV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX8voKv/+1K1Ib
 x9RQzZ4gpYiyrS8wzjmcnJKa0Hl78HxrHBBLXvOiJPjLbAIqekoT6IeFmDi+LFG0ii0NE0Bg33m
 aIFMmdQU++P9Jcve9Jb0cOM0oS+mDeF9EcdeT8diBsJhuqc6gxgl21RknDdxB6GdQSmHdQkQONp
 M3WOuE9jcY3jbBHo1+HdBVxSZr+ZWEpBYzfNOI5AR+KQP1daLJwO+LqnmTq1UbkrKdCWY6uL+if
 SlohDciH3Zini8MEA+oEtQ9ApmE3yqXHkGrW6fRiFO2qX3PK1QwWCjzn8HEPMlEEFkBXSdjDtcE
 caa56LnhhW+iyrY+7mhy6Vh2Eg8EHv9oU4Muz8dJxivZDg+Oc98e1CJttVpVuEeaF2Xauy7tIsb
 MWgf7kiI7Fi7jIqRpmjsK7pXo4xvaA==
X-Proofpoint-GUID: nL-s8Z18ehFh64xmc-X9oqK_tanxOhzV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_04,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

From: Gregor Herburger <gregor.herburger@ew.tq-group.com>

The mcp251xfd has two pins that can be used as gpio. Add gpio-controller
property to binding description.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 .../devicetree/bindings/net/can/microchip,mcp251xfd.yaml     | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
index c155c9c6db39..2d13638ebc6a 100644
--- a/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
@@ -49,6 +49,11 @@ properties:
       Must be half or less of "clocks" frequency.
     maximum: 20000000
 
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
 required:
   - compatible
   - reg
-- 
2.34.1


