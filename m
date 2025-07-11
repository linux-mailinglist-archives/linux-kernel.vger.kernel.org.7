Return-Path: <linux-kernel+bounces-727072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2A7B014A6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4271894A86
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953681F2C34;
	Fri, 11 Jul 2025 07:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="na8xgHUb"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE481EE019
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 07:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218933; cv=none; b=Ep3Zsee5Gu9YKbA0yNcfnHLIE/zVHocyVqux381KNfQMhij2zyqyUFqrIpbh+QkEvV8L5JfzhC4bZa65LMzdFHkRXTpoqkjnfeQFdmqWO+J/VmZOw31YfgcrgxxhncP1TgxOQRn7GiNpLCtL7X/T36vnnrtRosCMzYirhRApJCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218933; c=relaxed/simple;
	bh=EKmtMeO9d4o53Iz5HZIpIvx8pwH5I0jiXMr35PqyHMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=psx1WQAgr4vHR/KLzyJ45XScDzEx7+5H3Bn2fmMgY2PV/CZNF6PqjAkVF0mTRRpgv/XLNo/5dDOx94aao8NSbRTfQKiSTGSeHMxW+TkFeMTOfCLGBYdjl62wunStxV1ufGQbvOiOVzl0U6mLqLi4fPsFvDuN0n8IIa9h7X7hZAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=na8xgHUb; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae3b336e936so338561366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 00:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752218930; x=1752823730; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RmR+8t4m9xzVFLz/MFjX7NJ/hYnQDOG3m6K+KjW/M5Y=;
        b=na8xgHUbIjCoSd1ZFGiWwnhoN1HT8lWqgqUTQ5PQ4yCLzuYl/8RvdPJWGErGhxdlkc
         YzRScJu/AkRtM09B0cVk87klIbIp7okZMEKV8UMMtFEneleRinwBhHMrDeMAoA7mYahT
         GyqQXFmyXy3Yh+k7/Damc0sn8GtRp2a5fEoxsKB62MP7oNrKQ/xbnUmy9DwsolDaLu7z
         6Lu4yMCFsLGPocmslmU/UEhcmWJXhnJ1dNUya3WbmVzQ77KZdQqlsSOUXiOf8boOXO03
         QY7ujlyO2oIO7fwbYLB8w2b9ob7rJxt25vJr/L3z0E6/pHH6yt+IEo9lTSAFGiHE8Pqx
         UHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752218930; x=1752823730;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmR+8t4m9xzVFLz/MFjX7NJ/hYnQDOG3m6K+KjW/M5Y=;
        b=V0QhaAFWqUOR5SVtvscR8m4WGBIf5ayxxPa6LJPuxN95+zd44Oqjej+4Duncn6aMh5
         7iqpOBl88ZKWznACpm4UvtSbHmjrtzrKj/jvbgKFkjlFWuwVbm+EFFZI34lUwcawusFN
         ihTQJXx1lZPYeZEHuGjvCQiopXYarZU3ZJisAbzxBIDuAEQFQ1puDhIgm6Mgwk5/wed2
         JiZxrCKYDQXm6fofbvcWuKuaMMeB/KB91vf7tjmZo6u8VlapnC/sFS1LyggjVMPk0ioS
         Vty0tko92b45MbiPTHoHDvvHAqiM4pR3oXmZY5GRsYyyQSQRotChw3+9xZ/9cu267AzA
         +l5g==
X-Forwarded-Encrypted: i=1; AJvYcCUP0H8UPe54CDRkhM9SoT/Yk5bPEmpDl6HU9OyYp0WhCQSdPyVTPlfxYcc3kL9MSVa8IuJmWo+OpDithWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPEnKPeh6ExQkDjLuzEEcRCqeg4f8dOmuB1MVMgmo4MUDaRyLR
	PuU4+/UW8Sk/NWiqi31meAzgaBvrChGYQON9/eQsCyAKs8h6nWmT0dHpeuNcblgSyCE=
X-Gm-Gg: ASbGncuLtc3UT0y/fR6Ebgzo+5Cbt9ItNi08P40X6g6NETFXPDZfbftxxqhfhxrOMMd
	CHpw5SGlmBAyDvQqZV+y7IJadfBqTQIrrrm9/SB+4igMhXFkBXNTO+8xkWKkRVri18/PeozTrbO
	XkC+J+PPsqUx/85h59lnKPdCU6+6M3PR0Fh1hr+D5E9CuTDTHfsKl5NSPxEO+hNCajDtoFLIFBV
	2IOAh9OV8Zd57ffRghOKMW2UBCdPsPoQOEMnJ6nJZu+tIIC8d6yVMwAJEegkrlg0s+7mixT/z5L
	Tdm1paSi7MwCzaorRb8aUvSiQc7N1wB+Ofwra3yKMzDMzI1j6/nxMX4pOA2+LFKaPYGFYjA+Yfl
	sgsrfqZWBWmaLBQP8Ei8ro4Xpbt29rUQn0j4U3+VmrYbyrW5rVRAlyKiTfQqlQqd0lgdMVPRb1B
	MGvKs=
X-Google-Smtp-Source: AGHT+IHjO6Cuy6N2NIyzNBY0zWndZlpasi70rEDQjthIjEIVfVhTG7c9KyNKyXzWl/VgKcWGqir0fw==
X-Received: by 2002:a17:906:7956:b0:ae3:cd73:e95a with SMTP id a640c23a62f3a-ae6fcbc356cmr192188466b.36.1752218929870;
        Fri, 11 Jul 2025 00:28:49 -0700 (PDT)
Received: from otso.local (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e90c1dsm252600966b.4.2025.07.11.00.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 00:28:49 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 11 Jul 2025 09:28:39 +0200
Subject: [PATCH v2 1/4] regulator: dt-bindings: qcom,rpmh: Add PM7550
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-pm7550-pmr735b-rpmh-regs-v2-1-bca8cc15c199@fairphone.com>
References: <20250711-pm7550-pmr735b-rpmh-regs-v2-0-bca8cc15c199@fairphone.com>
In-Reply-To: <20250711-pm7550-pmr735b-rpmh-regs-v2-0-bca8cc15c199@fairphone.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752218928; l=2150;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=EKmtMeO9d4o53Iz5HZIpIvx8pwH5I0jiXMr35PqyHMk=;
 b=TfACMMKlpTyBL6dkzahid7p42TBAErawN089xboN4nevPOFohNrTf14tInQWkOngwzOeQDzoo
 qa7jLfUrBLjD6LzHO5bmHXDRANgZaFPf5HdTN8nG5vYQMj/stihk8Jr
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add the PM7550 compatible for the regulators in the PMIC found with the
Milos SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 .../bindings/regulator/qcom,rpmh-regulator.yaml     | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
index 3a5a0a6cf5cc7090f3e09850e9a13b7e6eeac68e..3dd150e5dad897eeb46e13dce5bb2726fdb90627 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
@@ -40,6 +40,7 @@ description: |
       For PM660, smps1 - smps6, ldo1 - ldo3, ldo5 - ldo19
       For PM660L, smps1 - smps3, smps5, ldo1 - ldo8, bob
       For PM7325, smps1 - smps8, ldo1 - ldo19
+      For PM7550, smps1 - smps6, ldo1 - ldo23, bob
       For PM8005, smps1 - smps4
       For PM8009, smps1 - smps2, ldo1 - ldo7
       For PM8010, ldo1 - ldo7
@@ -66,6 +67,7 @@ properties:
       - qcom,pm660-rpmh-regulators
       - qcom,pm660l-rpmh-regulators
       - qcom,pm7325-rpmh-regulators
+      - qcom,pm7550-rpmh-regulators
       - qcom,pm8005-rpmh-regulators
       - qcom,pm8009-rpmh-regulators
       - qcom,pm8009-1-rpmh-regulators
@@ -218,6 +220,25 @@ allOf:
         "^vdd-l[358]-supply$": true
         "^vdd-s[1-8]-supply$": true
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,pm7550-rpmh-regulators
+    then:
+      properties:
+        vdd-bob-supply:
+          description: BOB regulator parent supply phandle.
+        vdd-l2-l3-supply: true
+        vdd-l4-l5-supply: true
+        vdd-l9-l10-supply: true
+        vdd-l12-l14-supply: true
+        vdd-l13-l16-supply: true
+        vdd-l15-l17-l18-l19-l20-l21-l22-l23-supply: true
+      patternProperties:
+        "^vdd-l(1|[6-8]|11)-supply$": true
+        "^vdd-s[1-6]-supply$": true
+
   - if:
       properties:
         compatible:

-- 
2.50.1


