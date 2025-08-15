Return-Path: <linux-kernel+bounces-771028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E452B281D9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED2ED169785
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229A226CE2B;
	Fri, 15 Aug 2025 14:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aJYCvFgJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24702571BD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755268244; cv=none; b=Zss9N7Tzdzb3VLpPvSm4K5vgI+qKGrmbU4pC/m2tzsx36bZi86LO2pTNbA0Sw9wnlH3BRwFTz0Jh/19geuAJ6jMuVOd/IeIQFBgGjwCeX4GuMdAd/QV8XA7J0rIwb3ce92TQ7YTmQTHkSiTg7xUwDUpNF3JMOh+ibcp337zSsjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755268244; c=relaxed/simple;
	bh=a8ke4j4Y6LPEDYk1jRjeU6q11tENi0EWXo++z7UB0Dk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PJCH8lNrnNBF2q2ZIxiHydM95V+Dq3lMn6OJ83GN7aKw7bczf3A2v0kDNvSAxJa/Tr3gXxw3VLkJll4B6EeWz6Jz1fnI9riYI4b8JQRJ9HswPZhQFTHADQBE49/5ouwBgANMtH9xuHtxUUi9P1d0BVIbFXGouOeMhvSo/SmtDiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aJYCvFgJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FEIoAl011479
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9CzfHCqMGwSglqPBGTXjDnFh1Uf1qA700EaDFGkGlqQ=; b=aJYCvFgJ18llElZy
	UoYH1NEgasfGOKpq7t6sIMLByYKibTopr+PrfcUnVZMvkdEFIE3d7guk2cLIV7G4
	Vr83aRMb288cYGJOeI4s6QMLsHS/XCKHlidfE4Z0+Mm2dbNKhmwxWzks7GXJmHc7
	P3nvmCSRKo7NxjoR+Ptk0G3qOZZOaHRU/taFRyT7SJWdZmBBe1DwJfAFFo5Ql01z
	P/PB9vqnPvKnWaXsoNEIPojHwrafEddrHgC9S0wFOE2oyJeeEk4pyYq2rJ1ayJ9n
	wW/90L3ACJvvk7P26rUvHejAfT0u4lR0L2yZfOI0o369nB/YgdYKxalZ4DEsRJLT
	88bd0g==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48gr9rywx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:30:41 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70ba7aa13dbso10721596d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755268240; x=1755873040;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9CzfHCqMGwSglqPBGTXjDnFh1Uf1qA700EaDFGkGlqQ=;
        b=AOqPvmMItChZMmhz3/fl3MJ1qWKWPEpJ6/WHw2qPLJ7gYyG7F6PuC59HrhGN2TXO3q
         BYcRYdHPuct0vTIrVE7bkBqY9I4+C6KYfT4DpGFquN7SzKlesa4CrfeGcPZiC/+FUksT
         Vur0XtI7cM+IqD5P6+agKZI3W2aJkeYRvT++fd2AfmQ5pHWZdGiHc5OLwA8C7rNS1Ohs
         LO+BIDatPPoOpHEdrGH6ZEbaW7zX2qqyDcbbINjFBbwU+gFrHTtJc5DEopxnyvdz3Bah
         PnY3H1w6C7uGKPROxQO/+ZGI7SWquD3bhix+nlGTUWDye5pH75VQbw69RQOesbkx5yWX
         M8KA==
X-Forwarded-Encrypted: i=1; AJvYcCUsiPbd3KM9sQ1j0f1+n/CzGocNrfRDX8b9HJ5MqluGMF78XIhGS8sdbI3gdG64YnPhSgPd2xfkDWYxUdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLUnkBSUjIazcZpbohoXABsBMFc2w6cKSQkrpTAu4TytkmW0Kb
	HUJE7BCeVgSF4BD0nAY/FKANgl9tC4pfin71ZVoNSeq4JFHHYIZbOxuvyJWSjtSlG5B9O1FWaHz
	InfCrO97/Tn3HwNLFN429ZsgyBvKr5k1SzvBJmiMgicO5waafX/4iGHBQKz4cCDfkPBA=
X-Gm-Gg: ASbGncvQi45cYovP1dmsQSofXoMhRlmm5f3//iyW7jC0rJuTPSAblIBbUkaW+FgMien
	hisEdaSDuJAEel4D/e1dR5SQMapzQR7WEUphHtE9nzNhegpMWP0guj/xMv2sol3KjDbOYeSywO0
	eZawH0UZv1N6lkudQC0+dlbKU6ufdpwazig/5LwE0iTyAdWRep4hjhLZE56TYQqXidbOIyeQ8C4
	z0C+78HGnu/QrEMbO2X6SIctJrc/3koyRTcw23CCj3dbt78TU0ZdRE6E2vmwHyGYkWTpX00azJO
	TylF6/6pazXzSAx93QaHGyNhHXYGS8D37CxTfBAM5+agQzO10tEwnWiwbjTL+rLuPnd5/ZM6RuT
	uBquUJppAcs3tmDa2sOgwjLlE3BhDYen+/RiE4R/yJEVJpgYy1cdh
X-Received: by 2002:a05:6214:d84:b0:706:dee5:fd3a with SMTP id 6a1803df08f44-70ba7c6fda1mr21010706d6.47.1755268239948;
        Fri, 15 Aug 2025 07:30:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESu9wlfWDH7KhI+726PhxhS7B3c8t9B4QgXuWap5FzKvPgEw79c+md6NHYKPbonVOwZ8hFIw==
X-Received: by 2002:a05:6214:d84:b0:706:dee5:fd3a with SMTP id 6a1803df08f44-70ba7c6fda1mr21010126d6.47.1755268239262;
        Fri, 15 Aug 2025 07:30:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3f358bsm305661e87.110.2025.08.15.07.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 07:30:38 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 15 Aug 2025 17:30:29 +0300
Subject: [PATCH v6 2/6] dt-bindings: display/msm: qcom,x1e80100-mdss:
 correct DP addresses
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-dp_mst_bindings-v6-2-e715bbbb5386@oss.qualcomm.com>
References: <20250815-dp_mst_bindings-v6-0-e715bbbb5386@oss.qualcomm.com>
In-Reply-To: <20250815-dp_mst_bindings-v6-0-e715bbbb5386@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>, Mahadevan <quic_mahap@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1755;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=jGBROFXef1Ek+8wHh+Y3Ci+prYLBgIDZTxGb8ga6KTM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBon0SHDouVFwSMXsubc+sifkSHyNOV0hEn37tkL
 bqSE8McafuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaJ9EhwAKCRCLPIo+Aiko
 1TTxB/4gbz3IsGn9diGtjv2N5oYvAbdCdzHiv3yMsoTJal/i3X9QpJ3Ud66nYST/WdG22kwCghL
 y7bjJZ/Iu9LIOWhO25Qt0NsCoDROQspnDy/3/2+lXYpuuaVdi9bMyTPKR4oZ3nLsUy2B9wemtdS
 /rqpwQbDZCTcqo09i7ylwFNa2qQx66xVy8akja0B2jPMT9uzW/LfADYjGuaK/tUKPaMTZJPE5no
 djBSqP0D2JQ1iAoszmyCEeKWuMGecsRjj0qCXDr2QRkAYYt5x6kIbZM5Mr7DI/MbZgDJgKpyGnJ
 Uq6Eiy3aNNEEqIxG7h9GfNZ2DsGLF+z1g+fqKL+PWmMmV7ok
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA5NCBTYWx0ZWRfX+Nit7+Y1fLRC
 J6iQoeSqzaZbvkkMnJLWV1wX9b4IKOIQ5fz5opWB6ytOeequijGhTBLp2wA+FtFI50swiGIgtpA
 LemtCmSj76H+8lLATnv4GIdNrUE5y0LLpyOLrvauCKj38Tq5fDuqDYqIaoZXj+rso/abXpEBy6N
 iESfV9htjyeuBpk5eRQEbQW1kD7WoUviuwM57HKns6hAEdm5ObuoBToOHZ4txwClC2xdAmIs0ve
 0EhrzGNbEOB+upOpQo6RH2tUMzB694b3xqJbFcj9uUojaE62tCg7nOVm9VSwsATRI0sQjlramdf
 GJbpBRWrO6ybrI+VqEhShcVXiFw+V4PP2lG8oKfHlWbnb1aq7OITs0W7bXwByYAz9K8tXSQdsjl
 8g5XSSo1
X-Authority-Analysis: v=2.4 cv=NIrV+16g c=1 sm=1 tr=0 ts=689f4491 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=fvGZ3mk3BhhUN7shqj8A:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Hlcs1fRb1EWqKSseD6RzchSZyzNZjkDx
X-Proofpoint-GUID: Hlcs1fRb1EWqKSseD6RzchSZyzNZjkDx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508130094

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

Fix c&p error and correct example to use 32-bit addressing (as the rest
of the example DT does) instead of 64-bit (as the platform does).  It
got unnoticed before since DP controller node wasn't validated against
DT schema because of the missing compatible.

Fixes: 81de267367d4 ("dt-bindings: display/msm: Document MDSS on X1E80100")
Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml    | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml
index 3b01a0e473332c331be36f7983fb8012652a8412..e35230a864379c195600ff67820d6a39b6f73ef4 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml
@@ -170,11 +170,11 @@ examples:
 
         displayport-controller@ae90000 {
             compatible = "qcom,x1e80100-dp";
-            reg = <0 0xae90000 0 0x200>,
-                  <0 0xae90200 0 0x200>,
-                  <0 0xae90400 0 0x600>,
-                  <0 0xae91000 0 0x400>,
-                  <0 0xae91400 0 0x400>;
+            reg = <0xae90000 0x200>,
+                  <0xae90200 0x200>,
+                  <0xae90400 0x600>,
+                  <0xae91000 0x400>,
+                  <0xae91400 0x400>;
 
             interrupt-parent = <&mdss>;
             interrupts = <12>;

-- 
2.47.2


