Return-Path: <linux-kernel+bounces-882355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A563C2A3F4
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 08:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7E8CD34604D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 07:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D357B29993A;
	Mon,  3 Nov 2025 07:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="orCV1CB1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JC2ZtFJV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF23296BA7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 07:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762153610; cv=none; b=pPvAsBvFj3HzeunmxXg0O5Lh7a7GjL8uloINK6ZhML+WITUZ96fdoyDF18VKKaWWCWJRPtm3V7Ed7Oa7odWpHNbAxp144Iwc0iYqNyldPSA3/Q5pejsF/AzsIiFFKc6zJifOMwWvw6GzmmaiW5P/wRkPXWme1JuZlx2IpgEd4EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762153610; c=relaxed/simple;
	bh=5feK2N/IK2O6e9qopvnZcd3fQLzy4a95KobwSy+NIHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SIGvmmsFh75Y/wXQiqQZ7BPUoz12wruNP/V+znMuJaO7Nw0kOfKnTU3t3r+7SvafICOy9ZLkvy2OwtvbIrGQYMbB+SVoZvo/Ji6p7VYdBlVRpi96u8nQ+ICcSvC39vLpQme8KY2gSREEKn+B113dU/eazKPkisTeaYGcW+sL03E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=orCV1CB1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JC2ZtFJV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A2MflDH1514946
	for <linux-kernel@vger.kernel.org>; Mon, 3 Nov 2025 07:06:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AMiAzcEtWsm2GpmS8Mvt7u1so77xL7gySGMapgJ2dos=; b=orCV1CB1h45GUHdk
	uH6RhMtC5KQ0W8DOWfy6OEkEi+JS6r3yLtj9NMyn5Cp5F5BK5n2q2wweSQvCGs7j
	DBmCYMpBlsj2pj5DJW1QK8w+KgmchGqroESQSYFfPNDuDaN94cndWnbBMAGL0q13
	Ac5auVxMQlHcAgDn0rIJf8Uo+LdIZcxfjKmMwLY67e+vEitNHHz39/aQPs7D9/Oy
	ME3C0rYcCPTkJJKgFIR90qiSOwmonJ4m2ed9dsykAMiYez5aNU9MxsGWPDtRzNzc
	tTSzdfkCI0NtfOvYmjfNDeRoWPkK+OAvuyUWNXw/2Co4yYRtAvDraK2lAF2SfmeE
	K3HMTg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a5977bqnu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:06:47 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-33bbbb41a84so9198107a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 23:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762153606; x=1762758406; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AMiAzcEtWsm2GpmS8Mvt7u1so77xL7gySGMapgJ2dos=;
        b=JC2ZtFJVbRzwVSPzBPNj4BmOdcWpP9ybDhVRjJDOYUMZKpgZSh646xMvj/0PqWfzTB
         9zeOKUR8Zxp3zQzxanXSFCl2BPS80uNDuEcduIYrDFYu3AhcbB//8wd7xLxFcpEyptCZ
         d0NNCHgv+4IK+XDxoGNX7aXH2+sGa8vC720DeUbjtryGRMZOaoIihmZRKlG4XO/l5ByQ
         uxj3bp+uYX9WQqjgvGDd+D6dStk9PznGOB+o+obiQXdU1xNnl052ZqDjcTmjUiGacjIz
         qF6xhv+a6YyqEHKv85IivFgs0Y8TAArQaxtEBbYLrUFTic45rCxWZ8avFdFwJCvb92yc
         vpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762153606; x=1762758406;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AMiAzcEtWsm2GpmS8Mvt7u1so77xL7gySGMapgJ2dos=;
        b=AAqbHqBzUQ7OHTqgvmKqJgWRdv0QHBQ72EzRyxdROxRJomulLii8irdm/Kgr+oKdms
         6Ageq6/sKmukPVLZhZYairysHQpIlwBNinR8JBfzcnzrAnAP0lWT6iU7q4Dsjw53K4kt
         8O46IJ9dakx3Aa2fCwJk0PrmSAkMJAOEJ9WdgtVugLqW7I1RPXhKtQMlF+36/cdMBj3K
         LJC/iciptBafFFXghe1rBZvHRf1oPKOXFc15omNqt5o6e/T7beqFq3li9twSR8XP6YG6
         Y4FH9TBxaOzcLr7KWr9GuNFKFC71wf+cp29w6suY9AuJrDBhrQrSGMDQ3EbaCOjSNKXa
         3dEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/6KK87MPtnc6nWtFwiK7vsqy7+p2GdwTIAdZceePbii76JZx/2BZK1zb0FdtlIHAVX0JGAgFUHLDsT3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyihXp27I+Bb9UGHg4fV4syR0cXrK2iLP9t9Tbe7KdBsg5fBC8o
	BgaA8goLfNXbBf2AIK/gcEuaaUzwG+gFcYbDnOeEcCI+yvG7YmU1vr/fJPKjQz/3OvwvbvLF52G
	yOmi+gV6xqsAkd0NSxrQONGL+vU7Qr0IBkqZPfylbD51VBm9QbNtV7mfiBFjF8ia+0innxD3Qot
	R6Zg==
X-Gm-Gg: ASbGncsMAKlmts67crXkKqd2ezIiT8Pr6xhFpFvSznMm/TGjMA6rlO8YAoyRC924Y3R
	551Zl99tfMEHj1Szcx22/hMhqGgSYTfFi7aoGN+XgI+ZtqfrMBe2/LKLO1GrDyw50XCrqQ06/Hj
	6Kpa0/kqs0u5VXaxLa4qu1PctJTbAXAjIm/LyTxpXbTK4uw2IaSUkqmD6sei+niaTFxc0PxkA+H
	O3IysLrtRXDP/15JmcWrbd+upFv91AqgwEPwk6ZVr4Z90AwD72Uto99n4HfXB2yXPBQj985Iqxz
	gQiIzp+6uBKDWdS41muhIH5Fuzvc3gkLuplk0gKeeDXDulJQ/zSWgOkUGXytpXcwwbI0dypp46E
	BXpAntDbubGBJ9l4JGwcLbYgRtBYsSeRt7zlE7ubf2LGYXjoxxvlcz2QMXS+ePQ==
X-Received: by 2002:a17:90b:51d1:b0:340:2a38:d45f with SMTP id 98e67ed59e1d1-34082fd9dcbmr15875292a91.16.1762153606393;
        Sun, 02 Nov 2025 23:06:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHc4H2LRGClZtWN81SzIchmgkncf9wzDlUy0SH6VKxxQ3RTVsKby5uuHb57K49kE/2mymOotA==
X-Received: by 2002:a17:90b:51d1:b0:340:2a38:d45f with SMTP id 98e67ed59e1d1-34082fd9dcbmr15875253a91.16.1762153605909;
        Sun, 02 Nov 2025 23:06:45 -0800 (PST)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3407ef49da8sm5808704a91.1.2025.11.02.23.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 23:06:45 -0800 (PST)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Date: Mon, 03 Nov 2025 15:06:21 +0800
Subject: [PATCH v4 1/2] dt-bindings: arm: add CTCU device for monaco
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-enable-ctcu-for-monaco-v4-1-92ff83201584@oss.qualcomm.com>
References: <20251103-enable-ctcu-for-monaco-v4-0-92ff83201584@oss.qualcomm.com>
In-Reply-To: <20251103-enable-ctcu-for-monaco-v4-0-92ff83201584@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
        Mao Jinlong <jinlong.mao@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jie Gan <jie.gan@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762153595; l=1171;
 i=jie.gan@oss.qualcomm.com; s=20250909; h=from:subject:message-id;
 bh=5feK2N/IK2O6e9qopvnZcd3fQLzy4a95KobwSy+NIHw=;
 b=wSQTSdvWIFwS8IjlZpSNpP8OrFOJfB2BlcLGf7sNcivE6BG019LCbSQNR8PfHS+18qv+MV0kn
 UpnqjY4VYTJA0HvQJC9yx5JbVBIC5JEBHABC5QH9WqixYL3WueWT8OQ
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=3LxxUZRPCNkvPDlWOvXfJNqNO4SfGdy3eghMb8puHuk=
X-Proofpoint-GUID: VdAHINompCoT2bcCa_u_pZhaY-EO4GOQ
X-Proofpoint-ORIG-GUID: VdAHINompCoT2bcCa_u_pZhaY-EO4GOQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDA2NSBTYWx0ZWRfX2RWqRnZhqojg
 jfc6hV1Gof2351ihVZ1lL2jx1ZomkcHUY+l/gt3sML8iAbnwX4n3YRqgplbwqYn9zVx34EqgXO5
 IUEfDWZyVLgo7ll8OZFCARwX2iuKQBKjPlnyt08CK8wysi0vzw14YNWeI+vC6Z7APbY2Svrvz3K
 rMeoeBiVF0GwD/Dzjc3gq9OUPdg/h1qKmLSFe9AivyASteyrchivARD2C3y9pHhJtLGYuRgfBT1
 uurnsPAvet57fBUTfqFsrymYPa7eaOxlyx3dKY52IA3u9GCPhUX6QKIs/MCGUKWUrXlRo54jgfx
 SjhbyqwkwtFUlRHZzOwJd9mYlZHa2GqEYxslvdOXqrW8Pdy1AdeaeKMJrjiDW47ZhL9phpOJ5YP
 ediv1syrsYMq+mTeMr4s22nWVFeLRQ==
X-Authority-Analysis: v=2.4 cv=WcABqkhX c=1 sm=1 tr=0 ts=69085488 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ekrabmmykuFM9VwHVzQA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=cvBusfyB2V15izCimMoJ:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511030065

The CTCU device for monaco shares the same configurations as SA8775p. Add
a fallback to enable the CTCU for monaco to utilize the compitable of the
SA8775p.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom,coresight-ctcu.yaml | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-ctcu.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-ctcu.yaml
index c969c16c21ef..460f38ddbd73 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-ctcu.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-ctcu.yaml
@@ -26,8 +26,13 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - qcom,sa8775p-ctcu
+    oneOf:
+      - items:
+          - enum:
+              - qcom,qcs8300-ctcu
+          - const: qcom,sa8775p-ctcu
+      - enum:
+          - qcom,sa8775p-ctcu
 
   reg:
     maxItems: 1

-- 
2.34.1


