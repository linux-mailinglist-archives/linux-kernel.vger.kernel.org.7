Return-Path: <linux-kernel+bounces-822171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A0DB8336A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E19801893514
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E5D2EAB6D;
	Thu, 18 Sep 2025 06:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cENixNJJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5170E2D7DFE
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758178189; cv=none; b=BMqqP2+OU+BUQ0b/yJ7VdGZvlTLGdk8qc+iAKrs363EPTXooUn895ba63MSMDuFxTO2sVDqUECAGWKDF2kJxTtx0OXWVqvMi4LDfDEdt/Gdi137xcLNnnUdBJkNRHr4U6ctSK2dG4uO12lcCth7RZL0sN6uN4echOyGQmkIYW7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758178189; c=relaxed/simple;
	bh=EDxK0JAECJqknU7nyBNM/XjceytGlGUL11eBwTOLESE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KoklQaaGDSoWLBGnaoveUHEnlXD1fJsEliKMlwovkwwipDx3wQ3iPCPmDKq9YX2ZnXmfJxQtS7CGR31ylL89/M9jx02pJ37XBFIVZyVxX/W5sHxCd18nNvntbi84Hsi6SXzGRd5/zbR4BwtTKcpO/kw5+jU7jxS9pnJqpoeZsaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cENixNJJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I3V96s010769
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:49:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=dzJS/eOWAno
	Hpfft1/dBeRGBEhv7bksVWKJ4cITaZw8=; b=cENixNJJK/h9/M/2CyV2djLyEcm
	PWAfS6nYBYj4IM1o5HhaYZ7RqgOVdD3V9tz72prPrBo+yIxsm+XL3r1hzrNMsmpL
	MQBSGImqqtEniqctJt5uYVSfxIKFcp4TVDGDZHvbAiFlbd8k/aXJDhd1MYmiTA7/
	cnBjJDtn8qSnuJCODaiOAcbcbpTQQ1W55vZvwZc8aQpgYWoEQOuq0O4L2pMxEDb8
	0zWSZteX6riJnKbwpkCAGyk3q3O6CWKt3NHm1LjQtT62AVoIy0cR6s2bT9pVMjwm
	MXKL2kt8moqOIjuxqRTuWAnZdx0EEg3gHAAc+GCKtSne2cGKZ5vqDm7BY7g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxxw88j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:49:47 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77267239591so1077943b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 23:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758178187; x=1758782987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzJS/eOWAnoHpfft1/dBeRGBEhv7bksVWKJ4cITaZw8=;
        b=SeEL7Whax9uHx68rm7vcL6hrPui9PrdzK024vaj4783iLUf6GkmpEth91DuRJbnsX6
         paRZ1MsVrtU4llyZvhjgxDSdy4X+wYz1jrVYAcijB1xIOvvIsZ1aQwpcx5H3GaPw8DX/
         gwMS+1nKSPKOCGpcg5WRE3RnadXw9L5LxjpZ3LdSLBmuoYrLxjZzlKM2AaESnja14Sat
         Cwn5k1kvyZbJnJq04WP8JX5iy92bFCK05vL0xHxJg+yIjwVXc75wfMEYg1KoZbdfC1G+
         rYk4C10mOpKTERFnF4YyUkFPtpN39Mi1WzXNNNZ3yR2wsKD4yyorwoS5uJ7Ug5Hi1fGY
         Xc3w==
X-Forwarded-Encrypted: i=1; AJvYcCXjxzyJfo+rFlZdMDBdnCOx9ANMqDjnMiJZagiH7STiwYp+27PQ7O0GkbpxPFjFy3zw2LGp1b11BsIcRek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Uq4creZwWao8qY1KZadTyH0fBSeC6vXx52B8ValOeowIrYc+
	n8v10nuxW0G4Jgf/6aPXhDP8Ndi8QDBzpw/C8nOgPATm/aTF1rzcwZTpxNfHBtAGKttFz6IUSy/
	RloM81Y183HNmyMtC7P6y9Rkhb5Wto1Mit3nxvuCqAd0EvGwfQjMZKP/ScenOumrbBqQ=
X-Gm-Gg: ASbGnctrFX2txhAcvta3GQvQvhAUrkJTcnw8z5sqo8wy+8VxxSgpnttm6JoiSxFP+kI
	k9ZsScoNXsDXUxA//zJrXqRyCkq3n3J2aXw4RLJgQutyWc/f9SmAvFBdiMHziteFiH2MlsK5BwQ
	a7XW/GWUNHeNgjDvnssQIW+WiW69SSyfO9IiLFbOQoWF227WRxfboCaHpcDKqf/MajydHxjmZfV
	BGK88LNF0zvvAN+RyXAoynkmx3YMTyUnJt32jb0u5rIQzmVHMVPPdvIgtQR2ukR4p0JwrJ//TYa
	QcQ7+6RCnQ+esTbWwy6klutguzlyuzqXE6WOx5pjgadutG+bAorAwTfkIJplq2Vqwqdux+V7nsf
	o
X-Received: by 2002:a05:6a00:39a3:b0:771:e3d7:4320 with SMTP id d2e1a72fcca58-77bf9c4ee61mr5751223b3a.19.1758178186657;
        Wed, 17 Sep 2025 23:49:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHY0H1OHgZXTD07nw2+cuSZdMjUSSXrxm4zMX8TS1uckPmlzXEVaCFUKW165uUvcbg/3u2M9g==
X-Received: by 2002:a05:6a00:39a3:b0:771:e3d7:4320 with SMTP id d2e1a72fcca58-77bf9c4ee61mr5751194b3a.19.1758178186193;
        Wed, 17 Sep 2025 23:49:46 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cff22bdb5sm1356789b3a.94.2025.09.17.23.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 23:49:45 -0700 (PDT)
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
Subject: [PATCH v4 6/6] dt-bindings: can: mcp251xfd: add gpio-controller property
Date: Thu, 18 Sep 2025 12:19:03 +0530
Message-Id: <20250918064903.241372-7-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918064903.241372-1-viken.dadhaniya@oss.qualcomm.com>
References: <20250918064903.241372-1-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX3sq4zJIIR0SL
 h8pGq4L3nAG3tC1iUFjZUHhkP8DDnbvVZ1ckDxaDo+yAicFWsbCfP20OoJVydLvmeYpoLoZszYQ
 j1HV2gDDWwoMQxtELXVYI6t6BxYxtU88MryHrZE+0wweRFpArgJ0nagmjp2KZZdPX8ycYLj5VXk
 8PqK3xFvpjvQxy3dgQKC8/vM7Ko+CQECEwKhcAFdJNFtpIqJqUDA+oEA8upPoTIK1SaEdauJH2T
 KyOw3DRVqHtA19Zuw+YbO2F8AnpvIW8pcnr6NlOKnG9+O9xNdRjO0u+202LJPdBJhBykxbRVX1p
 hzXH8XGYNPOqIe/IenTzzjXz4tinptIDJ6DaY3yc2git/LT6aZ8M3XxwCk0Y55H4n+vkHvavyic
 esxKlPZ9
X-Proofpoint-ORIG-GUID: NtmrWM8wPflqV6WROlJQandLmz6Uhkow
X-Authority-Analysis: v=2.4 cv=KJZaDEFo c=1 sm=1 tr=0 ts=68cbab8b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=8f9FM25-AAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=ubk9sFcynENsk3o0iIUA:9 a=IoOABgeZipijB_acs4fv:22 a=uSNRK0Bqq4PXrUp6LDpb:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: NtmrWM8wPflqV6WROlJQandLmz6Uhkow
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

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


