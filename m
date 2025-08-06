Return-Path: <linux-kernel+bounces-758438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B461DB1CF21
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 00:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FBD918C5201
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29A62356D9;
	Wed,  6 Aug 2025 22:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+STqCyz"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E010222D9E9;
	Wed,  6 Aug 2025 22:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754519865; cv=none; b=pFI48Z9YocBwNSx2uTwmhuSSIVVj8+3d6Yly/Pi9zvIODAJSABi22Qe7nhPkL0CoW75Wl1Bp9ct2Cp4zIM1Lq/e57eWk3Q7tHhqURRX167h/TAfaLxdfB7zgbh7E3f0BS1RLMhi+lr0QN4/MbQtIp12GIdYE/uxOsXR+Cf0feQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754519865; c=relaxed/simple;
	bh=g2AscUwWTqlot2kja3W60Yj5oZqmO4Sp4+EYlYITTDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAjFmCQypk4SpHUQdXmJL1TWt1G5E4VCzH/UFVxUIWH+jDwGJCMcmIdt0xcA8sdCo+S8MRotW8KTYo4gE0h8nhS8aYvyDZ8hqdekovLT4kWLxzppCmy283yWvZESXJ1H8u/yzT3TOlum0pXK+XOMAfz33gce/wNm0LTogCOTSCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+STqCyz; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4233978326so177811a12.1;
        Wed, 06 Aug 2025 15:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754519863; x=1755124663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUVrsQEhEsYbTB4y6KG5eLfa00U/D4bcsw7bFq5t4Os=;
        b=O+STqCyzXh/NaPo2dkeqBlIAfiTzWyc1r3rUCTFPyo8k/9NTa7sI+1ea6ZaSpdu7iM
         y6fTFxpq/S7gGvCEEt7TlCXRO3sm4vohQwx1Clsj+GZOyXBcMe+mY5BPx23pYCrixCIH
         PAmwR4ctHsUSECCln550QkpIh91tHwRNqp/LlYx3eKBM0W2w7q1AcvsNcvEf3c+VVUGU
         C1WZ7b39ogs0EMhHNG39e/LkalrNzCWlbE8DBOpwsHJpWqedxeYG8fa18a60F+1ns/Wm
         wnTqTWO0s2vl2s5qZnfd5ak/mOnjq0gzQCUFTw/fuSAj3QiNGKZ7XksZvE87eP2s3yMH
         sGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754519863; x=1755124663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bUVrsQEhEsYbTB4y6KG5eLfa00U/D4bcsw7bFq5t4Os=;
        b=qpex5NVAEZxzH40kSwrpWGf5khMY+Cd+XFovGWHdRRN+hIjluCzrdW6RmI+gBqszWH
         KHUpf/huvThprU/soJGPWHD71K7v+6aV3YQ1mH6MdceN4LHfzL2lF6YU1Ja+qh8RauXD
         OQvSDNkAcPHgqkMrE9oGTKrgUF70z60dvAF4cCSuPtLSyjPVsCd+EWm8YQPy+aOddi3U
         aBUdxFsWh5BQaQ6UcHOD9fiIuYWl/RnogY91sq8ArFgEq1HSjaxxTRa79XMGPQk4XW2C
         ayOZtVQVRkproVCSDlyC8DJc7Lw7oCyfxd4CBsS2l/djm87BMA+wS/e8UbgJciqGe+Vf
         7IRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCbloT3ckXswsrelvPJYps1IYMD4JicKfzjug/ISebc7tnJEdnMie6H4tnrP70bWJUj3dd3ThATQ0RE+5t@vger.kernel.org, AJvYcCWL65Dk5eX/sHRci/y4mvaYcYW2gE2oE22KH7q39nhoXFVJeZof1qu5X37ZcXwt53Y/Pb8TKRBjc2WK@vger.kernel.org, AJvYcCXAw6XaiSSwB6qTqo2/ZTZkQFmytxOfVSLunA6ZShM+n+gg+jUkbo6gBBxtCTXD6eOW9/zSGyuw29pE@vger.kernel.org
X-Gm-Message-State: AOJu0YwqQZNySP2y2UEETVTnzewaEuK9gUVJOUQuSWRSyerjBF0Yzjk7
	8BYDFe4S65kJSv8cANAxpG4z5cgAiePedp5mJdRq+QFC6Z0tTRiOaD3PVbWcHg==
X-Gm-Gg: ASbGncsSE3R5K2ViUkO8DlsyW0GIlodOajIqmgGgXFrWXvhp21N8uh70PWdDmbu0pMH
	7FGZTY/dNsWsKwRayTzeFXd6C5oilyBqPMF9ah45QrYu48VxDirXrlHyMKjRsZHe//FX5ai6VXE
	FQtB9zT+beSMEHGMlAA/p+jOz93G1tWDRvpBNj4ITKGNtds8onwUpKd00/ROpY4KDvGpiGZtHjS
	5kTf6Oe/4aXEEmKp5/2+d1CBsSYJs96NT8c1oWBEZJ7f79KMR9oRqJ492hKY0GT6FJbomjKUdHU
	G6ELQ1udyWyxMVtmqRxm4jWZn852DS+T2h0sB23iZhqn1hbNBx5JQvbUBK3RpDfUZSnalyFT0s8
	2QConMSE4fRvK7zIRFc78gpnL/J5efiePGFDt0HeLpCisjJ7re/dnag1fSAs1txzrVu2zRV9MAu
	MbntmEij1IIBp69Co=
X-Google-Smtp-Source: AGHT+IFIx6EJDsgMMR7duBsnxQ8s32x7eU/v69ZjooxeU0awDHomyrd617C0A/MFlu3RW1+Zz6JoAw==
X-Received: by 2002:a17:902:f543:b0:23f:f96d:7581 with SMTP id d9443c01a7336-2429f57624bmr60017735ad.20.1754519863034;
        Wed, 06 Aug 2025 15:37:43 -0700 (PDT)
Received: from CNTWS00427A.itotolink.net (111-242-118-39.dynamic-ip.hinet.net. [111.242.118.39])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2426dec66desm86776775ad.54.2025.08.06.15.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 15:37:42 -0700 (PDT)
From: ChiShih Tsai <tomtsai764@gmail.com>
To: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	corbet@lwn.net,
	t630619@gmail.com,
	ChiShih Tsai <tomtsai764@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: hwmon: adm1275: add sq24905c support
Date: Thu,  7 Aug 2025 06:37:23 +0800
Message-ID: <20250806223724.1207-2-tomtsai764@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250806223724.1207-1-tomtsai764@gmail.com>
References: <20250806223724.1207-1-tomtsai764@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for sq24905c Hot-Swap Controller and Digital Power Monitor.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: ChiShih Tsai <tomtsai764@gmail.com>
---
v2 -> v3:
- No code changed, included Acked-by tag from v2 review
- Link to v2: https://lore.kernel.org/linux-hwmon/20250805124449.15187-1-tomtsai764@gmail.com/

v1 -> v2:
- Modify devicetree properties ID to silergy,mc09c
- Combine to a single if statement for MFR_ID.
- Add description, SQ24905C compatibility to the ADM1278
- Remove two silergy properties,re-use adi properties
- Link to v1: https://lore.kernel.org/linux-hwmon/20250804124806.540-1-tomtsai764@gmail.com/

 Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
index ddb72857c846..d6a7517f2a50 100644
--- a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
@@ -18,6 +18,13 @@ description: |
   Datasheets:
     https://www.analog.com/en/products/adm1294.html
 
+  The SQ24905C is also a Hot-swap controller compatibility to the ADM1278,
+  the PMBUS_MFR_MODEL is MC09C
+
+  Datasheets:
+    https://www.silergy.com/
+    download/downloadFile?id=5669&type=product&ftype=note
+
 properties:
   compatible:
     enum:
@@ -30,6 +37,7 @@ properties:
       - adi,adm1281
       - adi,adm1293
       - adi,adm1294
+      - silergy,mc09c
 
   reg:
     maxItems: 1
@@ -96,6 +104,7 @@ allOf:
               - adi,adm1281
               - adi,adm1293
               - adi,adm1294
+              - silergy,mc09c
     then:
       properties:
         adi,volt-curr-sample-average:
-- 
2.43.0


