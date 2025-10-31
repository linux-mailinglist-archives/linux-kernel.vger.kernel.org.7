Return-Path: <linux-kernel+bounces-880090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D94A8C24D78
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5F1E1350EC2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E66C347FFE;
	Fri, 31 Oct 2025 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LUo+zSp7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N9pAhcod"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1FF347FEF
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761911314; cv=none; b=gL9WZRhY1GJfUs9WlvGsJNMaKnD5aH0LbaDTwhefOJuQsBvK4ARqrN568YfGZIgTLu3omJKU7tm41nO8VQ3e2ljHyOInhilSiUk+YXocSmoKQRa1wRRs9HAVtqKV9NUa90qtYPKZWpAYTENDWbXaPvAx9k5NN6RGMCnX0rfMNIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761911314; c=relaxed/simple;
	bh=1z/FSnj3ZUgyWqaLRX5fY7Les2o4JmWnSmIDwUcEQN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GcXN8dbG04m+YneVaHFN3+169pFtjmTUi/3gVVYelORy9ztjLUUdpkh3f148l9b7oCPdn5tAZLs57OXqFqo9xH7/EIeGwWjKTRgFC+D0uN5bT7I9KsU4OFzJ2ATjzyD0I2h0rae3qN2xo3oVYa2vzbLBqbsrISPZgIFjAQDsCwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LUo+zSp7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N9pAhcod; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V73jit2059166
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=pWjm3r9JBLg
	yWiY5RrLVYsR7m0kB0QZc1E+F4Ywtwhk=; b=LUo+zSp70Cu/KiSHtG2Den5fseV
	BlZWcKOR9SLf5tW/oardmbA+AgKX4QQAOhJwxG0GQZgrW3/mVJrV1T77OwFvnOx3
	65vQkb1pPs/1HnmTE/HpE96oo6LyQL2iq32/rS+cqZiwFxZRasCbriHy/9/lZyhh
	fbT9ZexMsJNYuR7RS4L2gwCuWCaDCIfmnzojoamhuJcsw45xOHvLxkgQW0R0+nSr
	4jhabXNP2RBaMvYQoDvbvk//t1qICpG5v4KiTPyYO7C7rsP+KWwQy2RcAlA33qJ8
	ouTBVOVysTLILhE1eQrBjPp34IVUqrsj11z5ReeYA9mm6dCbruSk2f9tc4Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4rcvgs12-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:48:32 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ecf3420ce3so41819011cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761911311; x=1762516111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWjm3r9JBLgyWiY5RrLVYsR7m0kB0QZc1E+F4Ywtwhk=;
        b=N9pAhcodQDwmUFNNhEKcUkHmKbJ8tpuT1fCm8NT3bXBBw0T4tiWkXQpU1Lba9ItNOd
         IFGew+oa2TMIJKbyfIhX7wUG3mjdizpBN7jbhcUQMkk/oGAaqxvitiNCA9D/wmrSG/h9
         Eals3xKdj4C+axxJJoSt84s2KiHaJ2D8z4dM5DnFCKOxP3WkktLTsO83OrmwEQf7sbgM
         poFyen7ZEWmS6zorzgswGnPdPlraeC2ZcXYZN6GYGqaPgXeGorIz1Uw+L6bkk3Mz+FOU
         iJEeaxz8lQWQboStbZiWOLQuld2wQxFNz3z6LtbhvKXMsGlNnRtQKSkKz4OY/zGlifBc
         2yqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761911311; x=1762516111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWjm3r9JBLgyWiY5RrLVYsR7m0kB0QZc1E+F4Ywtwhk=;
        b=alemkfaefTDLDQFCUofmE5TOCAcOpO/yXy9Mn7IKeBzNOeekKhjMDjlRncK8oj1JfN
         m7KVP0svMN7gBEqHYu6iGdplxPFhArsfvu7+2lrgiaSPkEBeIB2FPtX2ce8jMLkD01Gd
         oQFnqQLWoHnuxLLE307VbvLcTwhfRg+ttF1UZacGAsX2X/9SRiJVXBNhZkLQBqBDdbjt
         X+IWG9F+Kw1WJW2LogVq3yGDbbkBHalxKu4sa+4RHJRu36p6z+x4p9TnMo71FRhhQ0oV
         f3uZim+Sl7ipwkO4SAxZfDNESYwftfcXKCaQTDVzuumFG+W7xNLUaujbso9qGMSKGOvq
         l91Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbEVzijFmpnKEd0HC9jYHk9CKwKkvcvQf95Cc2Pm/c5Bo3SSwfQyRA+2Upan9B4Xyeu0l38PLKh9nrB7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ubPGmLTT4zCDuHeQuJwNxL+UaRKw2Dz7PpOwRJcqx0cDdSRX
	omjN3qcwi22won2vbDIz/Stqbw1I2T0DBA4S7IiQSAq6UisYL/Z3d/Z+whn1GF7M8dRUqRSoT1h
	7GuqBsY/4qJZkkEHmX+dWBT+rXdYhK+Xqh7Xqdkt880Wn7BQ21GKiW1cqEnnPRZKEJVU=
X-Gm-Gg: ASbGncvUuSVK9Jjm48ghEKVc2JdOSq1FqlfHrt4KgnWrpF9Qn+I01qpPwx6m4quxFMf
	ykAO2KQBWs4C4S8fqjsbf0PKiYBrhGVabWTrWHAswB1jd0Jpx/0/320G7//saZBL8L1MrGJm+Bt
	wbJbzE89twr0eFYEQ2crWC3Cw4I8n7bwjzV/ZJxA5fUyE9PSmY+cGCNZXOvpYVTvN9tjEzy1oMe
	pNaGmW2Tl/2fLZVQkNTFShEPvkgd3XCbsQgTw97AvSX/gcqYy3FrU3ALROn9mXDngYQU96lfXiE
	wVGB3WWpaWbuYcpMXlJmRKD7vVWT2kZjVtVY4PHJrHP2WYon4lMbpPkSWhWEcihNcu+M3m2hl34
	G+7gDm+qZvVHv
X-Received: by 2002:ac8:7f46:0:b0:4b3:4457:feca with SMTP id d75a77b69052e-4ed30d5c037mr32900371cf.6.1761911311238;
        Fri, 31 Oct 2025 04:48:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1PW4aUXjWsnBLAunnktPoZEmZj62hrfAxwz0VwIb8pmFGBAHF6H9IebLcOFRhJ9pXXvAaxA==
X-Received: by 2002:ac8:7f46:0:b0:4b3:4457:feca with SMTP id d75a77b69052e-4ed30d5c037mr32900011cf.6.1761911310708;
        Fri, 31 Oct 2025 04:48:30 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47728aa915asm86831165e9.16.2025.10.31.04.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:48:30 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: robh@kernel.org, broonie@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alexey.klimov@linaro.org,
        konradybcio@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v2 4/6] ASoC: dt-bindings: qcom,lpass-va-macro: Add sm6115 LPASS VA
Date: Fri, 31 Oct 2025 11:47:50 +0000
Message-ID: <20251031114752.572270-5-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031114752.572270-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251031114752.572270-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bJYb4f+Z c=1 sm=1 tr=0 ts=6904a210 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=q4DFcrmTo4ZQpOTRNT8A:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEwNiBTYWx0ZWRfX0N9BhUS49m2n
 1Dwouu9KEvybv1ipXKdhBRXq9jfYPO0l+SDd5prpQJxNrNeAM5TbRiVWA7BOwhrphHpiqmct7bK
 42wJ4Ik5nkqJUN0wEZGb/WzPrbV9WvG8Q4eU9d/lxYq00cS3r71igPqJwlEDAGEXgQ/XAl0YrYo
 +wd5U7YRYvPrS0UStzH9cg3ROt4m54lSIjd2ItHx+VzJu1FsJgPkjM2NBHt6tCEmw3rnCfIxBW5
 I5FzzpfL8zPQ5Jbvj7hHTn03jqj//OR68+6iKPs+zqip6Ml+EA1KGWpAkMiMXgfRA//Bm5X0Bpy
 chvgV0oKfpHkvtvzBzRKD/AL3ph3uZa8StfbplvAl3asfirl2khEUUr2KJZib3hnIsSCRq4cdWs
 e6Ag0tyPKfKaqbS/+j0diGNxuTJsdw==
X-Proofpoint-ORIG-GUID: bPPiyaYrCo8HASIsp4xYjLsqA8NwSI_b
X-Proofpoint-GUID: bPPiyaYrCo8HASIsp4xYjLsqA8NwSI_b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 malwarescore=0
 spamscore=0 suspectscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310106

Add bindings for Qualcomm SM6115 SoC Low Power Audio SubSystem (LPASS)
VA macro codec. This SoC does not provide macro clock so reflect that in
the bindings.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 .../bindings/sound/qcom,lpass-va-macro.yaml      | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
index d3851a67401e..5c42b2b323ee 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
@@ -14,6 +14,7 @@ properties:
     oneOf:
       - enum:
           - qcom,sc7280-lpass-va-macro
+          - qcom,sm6115-lpass-va-macro
           - qcom,sm8250-lpass-va-macro
           - qcom,sm8450-lpass-va-macro
           - qcom,sm8550-lpass-va-macro
@@ -99,6 +100,21 @@ allOf:
               - const: mclk
               - const: macro
               - const: dcodec
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,sm6115-lpass-va-macro
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+        clock-names:
+          items:
+            - const: mclk
+            - const: dcodec
+            - const: npl
   - if:
       properties:
         compatible:
-- 
2.51.0


