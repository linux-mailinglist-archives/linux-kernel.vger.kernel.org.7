Return-Path: <linux-kernel+bounces-832178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CB3B9E90F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 377EE4E31B5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEE22EAB9D;
	Thu, 25 Sep 2025 10:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="jWpOKZ/v"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B9D28850B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758794870; cv=none; b=B9d7Ral55ObKw4nr6rGs6w8nVfBg44ODNGFKtoYXqcfjKYagDBtU2/F1GYz/JISU+diObcQXHufNi0+vhyuGfOPKZivxxGORqXakifg2TUAt+bhfjEo2CLKsqGdP79uKrk+FClFkgpamnhd5AZ/YsJFFsTzoQ4WTbyo8x4bLXhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758794870; c=relaxed/simple;
	bh=2wAPPbqLo2LqU/nTBFwRHUuMpcX/WMRKMRc0AgRIv18=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=anrPEGq9AIkzbxj1UiPLfM8/5QQYJ1c/gP/5SJKN2B1MmtifaWU+/LUQ+T1SD2SZW/g6bYONws8D4dZ+MzNIZS/JlaTbzmb0yUH8G5a8dz6RqoGKbD/YMCnUIt10l7PEFFn+ruvfWfGpOKGOzQhlqB2yMPFG6f/4ErlP4/Rk49c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=jWpOKZ/v; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b33d785db6fso147858766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1758794866; x=1759399666; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RQA2xq7mI4lOuuo7UB6QFY4SFCKqLwIJHu6LK04sK3w=;
        b=jWpOKZ/vV5bo8kKY/+8WnshsBI5H2/ZX4tO2y1i4Uker22Xzy8Q9xX46ydvqlNG3lz
         mTt495ck8CjWQfaPrqal7UJUnsNJ93NOJDGYaTCEC3J8wirC6UCJYuzfjUT/4Pz8QdIB
         ohnS4mn0OZCvRNXMCN67LiplQkY01RVxwquMi9td9dfoVmMsraiLDfqmwXYR1UKhceXt
         XUg4CZOLsGBwSnLEEo22CX7jARb5XV2DTmtAAc2X0O9B/0q2fvjx5EeywOX3+v21mJ1W
         vcP0mTvpsR60kGEC4c4WK+K1+aGvatO5NGHQeleSEkK3qpCsMQ+BPErcrQlHb9vxc8b1
         uzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758794866; x=1759399666;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RQA2xq7mI4lOuuo7UB6QFY4SFCKqLwIJHu6LK04sK3w=;
        b=NM6huRCqxzA88q8r7Zi4UX6rpxK35RnxlbtC2myyZv8m2y4cRl4gykhHhIP3w7TJEd
         OV3jG7ighRhFCxQcL26/U2Jus3v/gXrSe2L7qVhEv/R6N+sQiYtgj/aLGdzulHjwz7/r
         +C5/itAbzSWtSGksLGrGeIMfFI7DKW+vFVkQueQx9SfknRVmsDhEUbsVdUzY/EjNxMMM
         5zDdK8o2jdmOR6v8DntrWM1MS8xOzaNwIPkkiSYs+I9xQgOEZQ6t2h71z2/ENoOjcK/T
         qOg6ciHG84HgVtlSDUKuiuTz9CCiofGOm08tbUSq7a2mMKRJl5gSoEC+OPRQZwutSwqM
         NehQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2jrhti4DNJ/tPcX1Ed9dJzJOtzgTz7LNNDFJdrY/cFZLQXr6d2q1EkLEUv+qJbkwVzaleteExEGa3qfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzL5gbM7lTpF6Mpbvl6r1Sxf17vL640RifRlS8Kl9erlvCs6mg
	c7PrOEHkEyCnsLkzQPIVFO7PR/c2GY5Za6G7PaHSnPcaHcYnaJqX84RpCv8lcuTGaRuYib+5RdT
	PUSDor7vR2g==
X-Gm-Gg: ASbGncsl397XHcGrque0z2YPUPudaRllV0xjLkV08/JomIk9dsmE2QmGho0XD/0xOiF
	eBv97JOiEQaOc8xcDdVgI2Upjyaxur/XYt671sA1JulxwJAOteWP54h7/vKBQQ1tIBwj3QCYQ7k
	bKMhW3ZKDxkOoaCPXe6qsDb4SuuP7dRRpnhDXic5adzr114Qv5k1dWvsfNQK8mT32MOlbyqp0r8
	Z0+sVBOqkC3aZAA95zQ3lh5V3XI8U4j9KiWiPQUVyuYBc9Zt/icX2e2xnsuAOL30XY5KLvsMBnS
	ToTcwYFt7/EyLTZeHHamU/xAvru5gK8ucRyOFcfELKnuwQbQVXboERzFabP944+Q7VfWndSbi4w
	ZbTaCma+4kzj6udAp0AgcfygWLu8R+ZhQR9BmDktULnjtMqm0EzMXCNfnv/hVufWP0c1sA3Vr8r
	qVpzbr
X-Google-Smtp-Source: AGHT+IE8TAQ0ieTHgs4m7gim+fRDgMGDmFFmvRIfockvNvymGGa0I6tPXCyGsiDJM+I3Aju2cVvIZg==
X-Received: by 2002:a17:907:94c7:b0:b2d:804c:f5c with SMTP id a640c23a62f3a-b34b684a76bmr362320866b.4.1758794866008;
        Thu, 25 Sep 2025 03:07:46 -0700 (PDT)
Received: from [172.16.220.225] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35446f7746sm134270766b.59.2025.09.25.03.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 03:07:45 -0700 (PDT)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Subject: [PATCH RESEND v3 0/3] Add support for Awinic AW86927 haptic driver
Date: Thu, 25 Sep 2025 12:07:27 +0200
Message-Id: <20250925-aw86927-v3-0-1fc6265b42de@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758794865; l=1819;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=2wAPPbqLo2LqU/nTBFwRHUuMpcX/WMRKMRc0AgRIv18=;
 b=K6q9xHDFqVzGDg0/K3TIC4M42C44EAjwZ3LnaQSldYEZrPR+LSp9uqb03ogPaOSd/mx0AmbMf
 4OybTK6Nk29BQYXsj4zEvBALFeNtIKQfZxmoX+kXzUcHlaZ331S+tPO
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Add devicetree bindings and a driver for the AW86927 haptic driver, and
add it to the devicetree for the Fairphone 5 smartphone.

This driver does not enable all capabilities of the AW86927, features
such as f0 detection, rtp mode, and cont mode are not included.

Note: This is my first driver I have ever worked on so if there is
anything I can do to improve it please let me know!

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
Changes in v3:
- Removed obsolete FIXME comments
- Adjusted Error handling to fit best practice
- Changed formatting due to feedback
- Removed obsolete terminology from patch subjects.
- Properly credited reviewers
- Link to v2: https://lore.kernel.org/r/20250811-aw86927-v2-0-64be8f3da560@fairphone.com

Changes in v2:
- Changed title and fixed license of devicetree binding
- Fixed typo where the 'm' in 'ms' was excluded
- Changed error handling return values in driver probe function
- Link to v1: https://lore.kernel.org/r/20250806-aw86927-v1-0-23d8a6d0f2b2@fairphone.com

---
Griffin Kroah-Hartman (3):
      dt-bindings: input: Add Awinic AW86927
      Input: aw86927 - add driver for Awinic AW86927
      arm64: dts: qcom: qcm6490-fairphone-fp5: Add vibrator support

 .../devicetree/bindings/input/awinic,aw86927.yaml  |  48 ++
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts |  18 +-
 drivers/input/misc/Kconfig                         |  11 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/aw86927.c                       | 854 +++++++++++++++++++++
 5 files changed, 931 insertions(+), 1 deletion(-)
---
base-commit: 3624e9a34b36d64a7037946eda28ae9599363a3b
change-id: 20250804-aw86927-9dddc32fcaec

Best regards,
-- 
Griffin Kroah-Hartman <griffin.kroah@fairphone.com>


