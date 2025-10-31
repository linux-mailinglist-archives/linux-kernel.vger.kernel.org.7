Return-Path: <linux-kernel+bounces-880088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 700EAC24DA9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4DE460D38
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0900347FD3;
	Fri, 31 Oct 2025 11:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FQPvey5G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DIXzhEIz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF873446AC
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761911311; cv=none; b=Sp4xwQR1f3ffp5HAGfvNkDkjypqCmBMPtPe/DX5FPrAWN/5K7xzbM4n10A9n7SRhR9ip4xdYXU+te6O0k2wnUuxZ9QaSLbQfuo0mpuSLlHUW4kKDsp8xvBeshAZRlE66JojKw65c2iJvryr6tw6WUuw2oVFfKZUJTCcoKm9zajY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761911311; c=relaxed/simple;
	bh=sOQOsePjYlM2SdUmv8lUrLY2KaB8teOMMCQg12ut7nA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rX3sJ/So9ByfCihiuBYsza6Qeh1AtOqlmtJSSfu8PovysyXoGn28OAbTM9M9JhEQabgD3LWpN6jQTeac59k5kybq943ZBczJXxByG750Z1NINwp7ATcRlT0J+z+lSRXHLaSoaRz800QGn53RxV0xSrWtt+/hJspBXWvLlZsGLVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FQPvey5G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DIXzhEIz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V73Ukw2058979
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=j1FjvgdJcCM
	iQjsMtzDEBVWbE1HV5FnpJ02ra3ujabY=; b=FQPvey5GVIUh2Vh46cc9O/hrd/8
	jNqN138I5ZOhO6FaGxnnw0JY1dIzG1EtHHlmRsOBodPjgZFb9HCqrgZf6UOlzL6g
	HH9+GmXvKmMaOTuO6fmFhFmbrn673bcAAu3oQqkp2MOBTFpbmpTKUdqFasPAXNsq
	kDwHYBMI0rhRIuAihGfjdNKuoLfo+CxssahzkOZGrqYfqh9hNnIC+9DLozH0pHvf
	9yZPc5nE0paxO8AdiTHPPSwT+ftOtAvaUuzrBPXWmiHTXjLHGO67bBPYii1keGJh
	vXfv1ATmtcIW2XQCnTJW2GwUxVKXkphPWrJgsxbx2KoQ5CJ83r+UNJoDNmA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4rcvgs0c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:48:27 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4eb7853480dso54825141cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761911307; x=1762516107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1FjvgdJcCMiQjsMtzDEBVWbE1HV5FnpJ02ra3ujabY=;
        b=DIXzhEIzLdGQ2NJ9DNJwu+1UFIX4cSO3FhHYUx/mXVqIgMvK2oSAfO9nKm8tNuXaxl
         HAXN5kKjgjY3QohEKvDrbzl1cVzrCRmzvPs03HIiKWe4Was95kCr+BKC+3qX0ys1uQnV
         k7QK+3qAiqtZxAaWUW734u4qqLlBMh0iGQ4KiDTiurPof/2xCkcaV6xG8dtvJyd2wggR
         L+3KEXw2Lb8oe/R+5I3seTvuiar44URy8SnfeX4x6PN6gsSEFXvQPHpeeBeOrMDAY1+Z
         4xhOlRh3FuWqTyHEE/aikz45QFTRT1Xqw8Dd+/XdFI2cHjtjdVHaW4l/GjW73QIIlX84
         WQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761911307; x=1762516107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1FjvgdJcCMiQjsMtzDEBVWbE1HV5FnpJ02ra3ujabY=;
        b=d3a6eioRgaZZwUTNWfJNpumrjqB8LY1jQZZStqGN+EnAqgLbyN91DQwMXmZlGSUOkB
         Vp0AfD1TfMUL6rjKT8BFGgM8NuGljdrDxT/aeMw7zKxqBDwJqC26BJMFEYZaH4GiaEUc
         CNc+0JghQcIZAuWngUjPiC4XnSBx52kjTYl2kpDdZUpRzFsmuG+DhvWUjx4ROqFoq/1G
         Dsi5WinhfAPFm0NH43TuFL1CDHnC6p+3A+yZTLI7PlrHgbxuYUvsHA63x8m4YG62Ykzf
         7kl4KotJ/gLggvPiamjUz0iMqblH64ZDr/56+ziQLKuOsFJqfe9Hp80I9x1VWGIHtb5V
         PXXw==
X-Forwarded-Encrypted: i=1; AJvYcCWHeVMbzy3TEk+0sFin/4iVNfikQaMUQfFPn1z/wAZsw68bLcN9toUav5AF2euHNEfNTUa/cF/EL8/CO54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/RplNBFflZX+pyvbsdAA/eYaXpq1Tys6rXjrF6P/rxa4/Dik+
	9wt9TxSQWIhCB8bhan97Ao1xK7nUg6b5gc/pSqI9jxDGMiWT3RvL6MKFLhTs+T9zFGgfFH+DFKJ
	hciAdaNABerNgDp8qzNlZcq1Aomw9NpCyQwaXMiKrt6g0JBnII2ZEOYNvdUDaQNWuV2w=
X-Gm-Gg: ASbGncuxd1yJOGYyyekynIra4YmOgcVwe0csrloE9K9XqrFQNjy3qoZL6Lhb0+nQRFX
	6Tu/CXWgvsl0M3w7EPcTxvQsytWtxdkYN7TwQfKw9DI1Z26C7c6emTOWU9waFcu9y49TT9rndQN
	WJ0qBlaV3AnnY47Yl3/GmpTtR7HTQEQ2bb10wCklG7qJWZAyGGMgL0OT1jtP6gp2xfxArElwwke
	mWbhyW80ZS2k6Qi5kxVVOrEMEgeziQJzJW294497SciD/S5Gljra5xuq1Dpmx2LuKFnnfU/H7BL
	whg/UZsM7W6+1U+6pwU9i/DjicFvbVAA73Q35ISv5LNBAB4F7ZRdi+tZcNES/Ht+hVHBEh0Z6Ur
	080eDwiZplzJj
X-Received: by 2002:ac8:5d0d:0:b0:4ed:2edb:92b9 with SMTP id d75a77b69052e-4ed310bd461mr39463381cf.81.1761911306902;
        Fri, 31 Oct 2025 04:48:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGV7FeNt00GvU4b+LMEjbJ+gjBtvvYtDUL9yozhNZog5D7ftzUP+YptgowQ6Mp0rebrCNKzpA==
X-Received: by 2002:ac8:5d0d:0:b0:4ed:2edb:92b9 with SMTP id d75a77b69052e-4ed310bd461mr39462901cf.81.1761911306373;
        Fri, 31 Oct 2025 04:48:26 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47728aa915asm86831165e9.16.2025.10.31.04.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:48:25 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: robh@kernel.org, broonie@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alexey.klimov@linaro.org,
        konradybcio@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v2 2/6] ASoC: dt-bindings: qcom,lpass-rx-macro: Add sm6115 LPASS RX
Date: Fri, 31 Oct 2025 11:47:48 +0000
Message-ID: <20251031114752.572270-3-srinivas.kandagatla@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=bJYb4f+Z c=1 sm=1 tr=0 ts=6904a20b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Vptr8DYYLnhAWPBg-1oA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEwNiBTYWx0ZWRfXyl4t1+QrCVbO
 O26rhYVykMhaYl5ocKytf8lbn4/9RUScrUct5229GK3MbXHUeG8D6wGi8LZQYaU5aq2x3qZinn8
 j8TU1dKzo5wuEEeAhDSKBQvJqE2CB2yN3OoW9S/IXUWXpvNq+W6yLjiGXUGOZa2q7y/LaXlvYz8
 vKMY97qDbCLfl9D5QYrj3CAprhUSZCHnBfX9nghSfxJo/bIB+0R0NbqWlv+5gYyy9tML3XBJPI7
 O4ySH8fOACZ6iIxZb0Ccvk4i+6d3HHj6kIf0D9YV3ZlnqyFeP1BLhQm7f1j5It/Qjey1iX6oTIE
 uR7G1rwcUUulXb+X+FcpjjXkK5Y1ZHgS5IcRKo9R+7TjZ0n2/0yG1oDHX7vmEg1sOl8gCuOSkTM
 wFTu7N2tHPgljr8ElbqLpHqvgwpGzg==
X-Proofpoint-ORIG-GUID: EFB5ZE9njEq0g8AHdgeFmZuzFhBFqK2D
X-Proofpoint-GUID: EFB5ZE9njEq0g8AHdgeFmZuzFhBFqK2D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 malwarescore=0
 spamscore=0 suspectscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310106

Add bindings for Qualcomm SM6115 SoC Low Power Audio SubSystem (LPASS)
RX macro codec. This SoC does not provide macro clock so reflect that in
the bindings.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 .../bindings/sound/qcom,lpass-rx-macro.yaml    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
index b869469a5848..2eed2277511f 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
@@ -14,6 +14,7 @@ properties:
     oneOf:
       - enum:
           - qcom,sc7280-lpass-rx-macro
+          - qcom,sm6115-lpass-rx-macro
           - qcom,sm8250-lpass-rx-macro
           - qcom,sm8450-lpass-rx-macro
           - qcom,sm8550-lpass-rx-macro
@@ -81,6 +82,23 @@ allOf:
                 - const: npl
                 - const: fsgen
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm6115-lpass-rx-macro
+    then:
+      properties:
+        clocks:
+          minItems: 4
+          maxItems: 4
+        clock-names:
+          items:
+            - const: mclk
+            - const: npl
+            - const: dcodec
+            - const: fsgen
+
   - if:
       properties:
         compatible:
-- 
2.51.0


