Return-Path: <linux-kernel+bounces-620827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C96F3A9CFEF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 19:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D718E7AE8BF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 17:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3212192EF;
	Fri, 25 Apr 2025 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cLMox5l3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8282185AB
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 17:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745603241; cv=none; b=pHUJOGxAOzE3H+y1m6sQFZPyRJpKptYK+zhMlTVErpWWgcJdaMAmhpZPmW3yx+stbO0KcNWCRsh7KZJWXw0m6Oovi1cbK5r+D6+EzMvGTDg3VMuwxnviDAh6JQ6v/QirovfAT8zzy4+i29BWpm/SLtAeeyoXESywT8uxUSAKjZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745603241; c=relaxed/simple;
	bh=1d2THw15+daDuyiX9YdQivB5AYVR+M6/q3kC0xvZnOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fZfAJOHL5Hw+G+JaShB1k/csh3OSVk/w/c3i/RFh7uAIPfssrxADxYnDqBBIkKpsBDYYnMi5ir2JXHIWqHA6DzSJltkOItT+2q5DjRzoYcs6AQqlR1dQVYEkQgNe3oqAbfZIeboicHr/XFq2dka6xGbvYtwJssPgmlMtRJAVNY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cLMox5l3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PGJqPb004641
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 17:47:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PL7jN6f+eBJVRlNozYaif9ayrUgthTONRjua2k2Vz4k=; b=cLMox5l3ozjZgoY8
	uEhF0icCilZrkBV1AnO3TDE2Lthvp0blA9Dl2p8QYGF0VS+KzZiwgs+S0rJwNBbm
	x/zqODA1njV6DyPJjqS4Bf3N8BuPASjn3JBG2NH6ddiHvQ7K0sC/n+Yh8SX9Gsn2
	R9zJzXJ+yyrXiXomyPCuOdHIQNt5xbyaUJ2PNYDujQ3Lz51YvdpdL3YL0yjLXLeF
	3Yszz/6m+LyyKpZintLUL8Bf/jwRCdYQCWPtJbtpUvGDfRqOhtPIscpUZVsBqN3S
	GysgHjO6sxVzrJUEGVOPDXdGwi5giG+XwRvHiYU0qbuXnWYXH2bPYwGXXnT7DxkZ
	Yib2Ng==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh09w69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 17:47:18 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c7c30d8986so702141685a.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 10:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745603238; x=1746208038;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PL7jN6f+eBJVRlNozYaif9ayrUgthTONRjua2k2Vz4k=;
        b=u2QHwc9wluR8QDp+d98Om0xzM9lxZrkVOp5VVEyfRprOfnlknhefJf++ObIleJNM/9
         dIthlIGs9TwQxTOGZPxU1Bq8k+t1k0vFo4yV8UTsnxDRHB1glQN4f8EUeyK7hYSamfyi
         tkm3nTKsB+Hqn1/mUiCp7rzWcyabTWvRzI4ehsSS56nof816nj6HI6sSBju1O4dKqY8/
         FxIA+7B02d+ZDCi1BHF6Ah11oikI9u6QnHPLpLDQX3u9MD3OGCHSncsO99iGyUAzC46k
         C2RO2OWGo3Zt5qAKRJsgrAml7mzoY8DC+8CJVqA2PrpdTpg9n6tVSBSp+k3vyiGC8ea8
         aSFw==
X-Forwarded-Encrypted: i=1; AJvYcCX8phNxrsIfi+RF/i3QLUa24FkQntRvOyWbc8K6MnHOcmcfRTN0Ft/UahatQFbEuxj/U6PJyMF+Tj6uFjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlYsdb0jc8copa+38KjvA4QXiS4LSbQIPzLTTgYB2t8COOp91G
	Dot9XnKl4mzB6Y01mn5o96HPgfi2jz4cdeUeZhFTS+aiwL93Qqyp2Rn6G6yR1ZK2ltpOog/Ma/k
	21XwhJZGi9g5w+nJI4PARr27FvbzywztLfNxc6XjSZNJ3YyEXJ81zj4jGThVYrcA=
X-Gm-Gg: ASbGncu3LbBeOgFy3FHwpLvSzltE0JY/XHeQgmXCUNjNPeFGgnmgI9Rm8Gqb5kEHd2n
	PtDkwCjzhvobZjZXpYbkXNcFRrDmeaU7EYJmOS0EtcKOjulljeodGABO5HcoN5XCMdRkdDMgBev
	ETZlRKYVT8Fnmmauqqp8/3OUus//sPMYXEmlrEBpvF6CoXmtHRXFuYHzTGxGHCicTUoWPKiQ2AV
	+ojyEElKmYF0w9krxESa5fjzFWZCRR8fwXojMnwrzL0rRojWl1Xtx+yza1fx5tZg8jNEu+5jM2S
	qR9/OJkq6DAQ0kbKIUmIE+FZALPm0tezPNo5HSvBSazvtbdB5w0vh4oiMBNOUSPQxf9PFMaMsgH
	j2j9rQnZ5AkhMsKrvotjQ6Ugl
X-Received: by 2002:a05:620a:2894:b0:7c5:5e05:df33 with SMTP id af79cd13be357-7c9668cda1cmr75281785a.51.1745603238046;
        Fri, 25 Apr 2025 10:47:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdL3OArWzBhvBqNzfsFrRZba+vV4aIlrDXD8fYlmtF9uaU4jSX4/V36YajbOCQMlIImOTPuA==
X-Received: by 2002:a05:620a:2894:b0:7c5:5e05:df33 with SMTP id af79cd13be357-7c9668cda1cmr75277985a.51.1745603237688;
        Fri, 25 Apr 2025 10:47:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54e7cb3bd4asm673193e87.84.2025.04.25.10.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 10:47:16 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 25 Apr 2025 20:47:05 +0300
Subject: [PATCH v3 05/11] dt-bindings: soc: qcom: qcom,rpm: add missing
 clock/-names properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-fix-nexus-4-v3-5-da4e39e86d41@oss.qualcomm.com>
References: <20250425-fix-nexus-4-v3-0-da4e39e86d41@oss.qualcomm.com>
In-Reply-To: <20250425-fix-nexus-4-v3-0-da4e39e86d41@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Lee Jones <lee@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linux.dev>, David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1045;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=1d2THw15+daDuyiX9YdQivB5AYVR+M6/q3kC0xvZnOg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoC8qaJPnWlePN4G06TY7fEEm69HG8cdexjAGYi
 z9VeXhWgCWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaAvKmgAKCRCLPIo+Aiko
 1evlB/9Ov2RvEXWeMwV1ap857cd7QPGS90ERiHjJ4txAv8jlKQr3TtRgpW9mYpCDGftZOWe64sh
 sl01bwEr9KWeKaauSSO12q4bNkn077fa++Jzjkw/g4vBuxNTC30ZVmqVOBxIEPLBLRlw7Y3uie7
 AmdkGsh+NVZ7yeTCLWCl+T1svFCPVGR/QVixHnjDa87sPZPtuKhvQ3qAEKO8GqrPzLj8Fa+iFkF
 oUlzhFpQ1cUAs/u6xSeW+K1KZPdpStNWbr9USOYVqLQsSzJSaHrvjZdkYXxJ+0YbFRlvfcSlvxx
 fq9+uVVmjwkpPYYXf3yGyKonDbA9oEmuLc4Zgf86H6ju5EYb
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDEyNSBTYWx0ZWRfX0w2Etpd1ToCL jobj/ejc1tue81bgr1Id1+spTNBD780ZWR3l4HV8Xf31WfTtUPyfwpwjHALjfcQp04HmmA9Ss8p VQ3+tcTWH7vgTHkVblNlNoL5wcvisNKcdkqvQD0udZ8td2Gm8P6YJpRW2vNUf5hDQ+1mEywWLY5
 YmouOUz4ODebtkLxAh9FIYC3g4yIZU1t0xG8PzSdv2pICMHHWInAiwi928r+cS8JU+QHzSyV5dK nIL577nz5jrSKn+MZsnKCKeH7hgX7xiecP6Jv3xpBUw5Hv260jstdxZOKK/DMbc8DLz0AM/waC+ 2zuCYO1iKar4ITNDwyJ5wBu6nYcAX5LxHwpoN2jgYNvQvvBrwZvcPNlbIhFg0J228dafnxBhhj8
 mtNMqB0qecGOjHVQeVZGdwzJiT2Mke0FT0lARiVm78ef0aKZL8Wk7LUvs8oTkuBFuE5C71Rl
X-Proofpoint-GUID: 2sf9UJ0cMv1EiJh8uKSTlCzJJqWxUi8g
X-Authority-Analysis: v=2.4 cv=ZuTtK87G c=1 sm=1 tr=0 ts=680bcaa6 cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=kK6--y4YYZXB64QPTQoA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 2sf9UJ0cMv1EiJh8uKSTlCzJJqWxUi8g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 suspectscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250125

Qualcomm MSM8660 and IPQ0864 platforms use additional clock for the RPM
device. Document it in the schema.

Fixes: aa0c4b815045 ("mfd: devicetree: bindings: Add Qualcomm RPM DT binding")
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,rpm.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,rpm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,rpm.yaml
index 10956240df0856a4241d6032d3aff7d447af9ce6..3e8d99cb4dc368ab6b31e3e60eb5f7e082cd312d 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,rpm.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,rpm.yaml
@@ -36,6 +36,13 @@ properties:
       - const: err
       - const: wakeup
 
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: ram
+
   qcom,ipc:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     items:

-- 
2.39.5


