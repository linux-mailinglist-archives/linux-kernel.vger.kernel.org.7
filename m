Return-Path: <linux-kernel+bounces-798920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5772B424B6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79D83176432
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0738320A17;
	Wed,  3 Sep 2025 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Km/12yOc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7209131B137
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912442; cv=none; b=Ta/14QYGlujgUyv/60EfArk7pbhh6iSTt8DN0jK9FUKvgd8Ref+QAIHkp0+ZMAuyX9DSw30N49GxvMx6RTxxmUlz52XfyLTxQfymgKAePyYtJxHs/sk4nKNyicld5BMqabfbYf6CK0UZlrryfcMDhUurBTnm3caPQ5INfqjEea0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912442; c=relaxed/simple;
	bh=XFm/BadHDzadfJbe7CFKN0imNyFqdCDjXz6VuEFz8Vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y4aUfRBFhT+mopuSHHvAbns4ULTg1uSkG1M0oKwjtWVe525KO5Liyi4jy90ch7Vszl8tbi26X8JflaCYKQIfF+ggeyhLiq6PRqnV04Vuz2+0C81SXKQAztF6gHQfDlRMdOSd/RB/udkVuw7UIJpMFutprGdMqYnvCc67qSW681A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Km/12yOc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Dwt6A029904
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 15:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=RzL4kYDIxuH
	5s4GrG8w0rRMRXppv6MYJkkpGNs4+K8A=; b=Km/12yOcEbyfKQ8OskOzsEjhsTW
	3ejAHzA25uMh1rrBnurCAaHl3DyaY9eFx2fDEKGkz8CR2OjfK8a+gLHXILetdc0M
	qa2QZN6x2LPo1QMWpEL0gXJmKmvrXYQOVxD9ocEwmpA01YNwVCRyA0pYM+GWG0og
	YcOakpN/gA5y5nrlYrkHb6rimfirybcgaOEpaioqHgFCbGvWSzltNMwA6YpZG2T4
	3QT2lPrQMiAJxWDvkiayP693LaNYw1Hj8Pb1RQ4EAdNIr0/pdvofjqg++pr0lCfW
	QY+0ayf5niylzgD6E9kE8J7ow5UKBwqlv1dH6WgKhblV5Yzs37QGsGvgrqQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnpca4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 15:13:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24ae30bd2d0so355835ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 08:13:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756912438; x=1757517238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RzL4kYDIxuH5s4GrG8w0rRMRXppv6MYJkkpGNs4+K8A=;
        b=RfYbXV31XZtYPz4Lr/1H11618SjfLyvr2TzmG2SKcmSQ5AadlHoFiRt+yZKZSXnl/5
         kZr/acrD18YLF0JGd9CcJ0LST+sbsYyjRdT0kn9l0i3YwO2oxI53wuJLq3VAxGVwRNLW
         6UpETpIZEBXZPy7h6d2EwVs4fqMCOUi/xufp0554Q955Yb0bN6kdhZvAo5+Ag7xsvyvY
         3CXwHD10pmaAkWyEjbZPpaZMD5mX+XDI2aenLlLAceD6kqnwajpA0wwCJ0Ndq2D8onHG
         SNuBD9DmiYuUcIPe+2jvLuNfg1ZLR7ldJ5smjOLx5SXGKzz0FHoQm7Hlmu7Dh15pUPQS
         q6Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVBKuV0jvaO19TEvLWcd5NDqfFCjY55nOsGjdqDydgVggJd35rSpCM/zpXz8q/quVYLSTkB7mJOu3AV4CQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYVgM1YxkWMs36W7zRb/zWK087qRNQmiL00feXPWT0AGW3kHAn
	QvLmCuZoVu0r7hPrDM433016zZn4bS8Fo51wyN4kxKZdYQZ7QCHYL6JPbUnUmYmarVsXm5F63OG
	8p5EDq5a5Xmy6bQ6eTDPulMrDzXGcjiV0NLX4KhJtS0cGLLPOSqKJtW5GTY7lpmQaoTI=
X-Gm-Gg: ASbGncu37JE/YbPwTqblGPhAFjP7LdbDEYV1UUz74VH53SyQUkqMTFJatwAVdVJxhK1
	jeKxMC+5J+4Xa8smxSnnZyJTaTmyd8+SC7bjXn3dgqKpNlzgLApIbVZKlYxP6Hs+vaK20rbFo9G
	5Btx7fPsqhXxI97CblE9EcEqmZB0Z9zShO2rikySPhjiGmAcARIIQO2SPa/XhQBdpfGYdC/o8Pu
	UZay68sT2V/qWPWEzOylWk0ELWB4xfEH5ojEOYhJ/VyJ9vRaXAWAP/ILQTig5s2ieN+hILzuutl
	c1eGoF/IzQNCs/y5XIhBd4D5Yn+/cZEEScwcBXpnfNkdxwqMuL3HZs9KA3R1pId8JbB/FVeLVOe
	Z
X-Received: by 2002:a17:903:350d:b0:24b:299a:a8c8 with SMTP id d9443c01a7336-24b299aab5fmr72552275ad.20.1756912438224;
        Wed, 03 Sep 2025 08:13:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTvTSzNvtnYATXSFnYQsCvI8SPhdcYHjrUO+5N2sNnL4YMyS9bz/HRtJJrkQSDQo1/PcpV5g==
X-Received: by 2002:a17:903:350d:b0:24b:299a:a8c8 with SMTP id d9443c01a7336-24b299aab5fmr72551665ad.20.1756912437706;
        Wed, 03 Sep 2025 08:13:57 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903758b89sm164818945ad.59.2025.09.03.08.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 08:13:57 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        prasad.kumpatla@oss.qualcomm.com,
        Prasad Kumpatla <quic_pkumpatl@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v9 1/8] ASoC: dt-bindings: qcom,lpass-va-macro: Update bindings for clocks to support ADSP
Date: Wed,  3 Sep 2025 20:43:30 +0530
Message-Id: <20250903151337.1037246-2-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903151337.1037246-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250903151337.1037246-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UJgvJODjeo5jqIKzptsAORfRkNTZKfcG
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b85b37 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=iKSB4sV-3DizVrPEodAA:9 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: UJgvJODjeo5jqIKzptsAORfRkNTZKfcG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfXylVfDcng0xTZ
 0gBaCd4ZTW39G3JklycGvpgAN8rA1nn4VGh+JaDYK2/UTdU1l9ItAByZou73ssX16BfsqH8Wqzm
 SgIk0HHZuFUe8rx+KKTyi6P4YpNqzL4WGoZ1MCgeBKP72T9RyMOjCLzxmXQ4yu3IKxmBSvYIX3H
 VpqkvC29Cy4a67ZbGNdGhhXXwN1mBW5j/LkHU2v6MKN/CHm6BK9yt7/IWDNdOfXAve8PEMUDeQN
 kD5tX6W8TACwj2rBbHATyzAHOp3OU1G+9n9rzn8xx2gPmNnr4tAODndTemiOFlz6DYBBWDyivvb
 PumXxu1lOx9DazERmc7PqPby762kapK5zTpMnPqU516Zk059Mz6i4XuKWrv1wLezy2/95aD3jO2
 qEV5Ug+4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

Manage clock settings for ADSP solution. On Existing ADSP bypass
solutions, the macro and dcodec GDSCs are enabled using power domains
in lpass-va-macro which is not applicable for ADSP based platform.

Co-developed-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Signed-off-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/sound/qcom,lpass-va-macro.yaml   | 23 +++++++++++++++----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
index dd549db6c841..3bfb0538dba2 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
@@ -79,12 +79,25 @@ allOf:
         compatible:
           contains:
             const: qcom,sc7280-lpass-va-macro
+
     then:
-      properties:
-        clocks:
-          maxItems: 1
-        clock-names:
-          maxItems: 1
+      if:
+        required:
+          - power-domains
+      then:
+        properties:
+          clocks:
+            maxItems: 1
+          clock-names:
+            maxItems: 1
+      else:
+        properties:
+          clocks:
+            minItems: 3
+            maxItems: 3
+          clock-names:
+            minItems: 3
+            maxItems: 3
 
   - if:
       properties:
-- 
2.34.1


