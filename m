Return-Path: <linux-kernel+bounces-837728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A86BBAD0D9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 078C5192647F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC28230D0F;
	Tue, 30 Sep 2025 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaXmhwDa"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7981F428F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759238836; cv=none; b=mzm+xPvfzXRmreVpaEHHozxPJ8Ua6dYBDjeK7R63ZWHMI6rwWTKpIGodOe/HF84SZwpeziFLevgaiwqM/VV+q/DYg33UBXDE/C3OGR7NTaXHw3wvGQEazemdi3zP+1Ma/OgoZ977uid2pWsdGuUDckh+GOfz16Eseb54GF894zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759238836; c=relaxed/simple;
	bh=C2c+iYmbNgGTOO2nKF6xIbNLg4yN9mRhc5CtHzgpGc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fGna8kAN+Z73LamHHVEhBjdg2nV8J5S9dTr8G7JdgJ2w0dEvkRfjIJhl/cyC/GvpYjmZ6QnhCPBvP/ULi8egoeeLfPIa87WSXqQbNZBNCyFOo/y26qDkL9pbVePvlumohpBjr+SFqQ/aZ+S3ArwD2r0M6f2ay/DDJ9LpdymucjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaXmhwDa; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3c2db014easo542745666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 06:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759238834; x=1759843634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pEYWNqVN+hXm3csWbV92tvh3D0m5lJ5Vd6pA/p8j2lM=;
        b=aaXmhwDafjIq8CmeSc2aZEr69FBaH8jalQuIio+zTpzuBMCFyrevY6oUJQ/6dygtTd
         riCuHIE1+Ryt082KbELkkeoO2Fi9ip+9g25nDnOp/v4xbCY4XC8Nus029t4m4/FE/9kq
         RjsyHbg1RFwNPbziPpvJYMlMe6o3RmK0o1q8q2bNKIVKTlNS6GsukMIj/NrQ/ELtyXPm
         28N3moCURJ0/UxOMLEEvzC3+wpKQtKugXkl6xhUmRsR3flUfibprAim+Rp5UqN7mxgvz
         6xvj9cjvOpTjXP67L6p3tTq9BQloBz0L0n5B4lgdU5wAx+iA2dPVcGXpUIgrM8GeBz/f
         4DjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759238834; x=1759843634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pEYWNqVN+hXm3csWbV92tvh3D0m5lJ5Vd6pA/p8j2lM=;
        b=voTAuifsKaWz0VFMqYUlL37GQ4XR+mzRPRDF0xeu5mgDQ33HTIADtP8UnRDJFKNn3k
         ZtD4//k95DFJN7fgEMBgYulnYp4vJyAW5VF+Vn1Ymbscm0z8/u1A/zXnJaMbsV8TtBZC
         heeJ8wznEuXCKr5zZG6kQOSxk/2mlkDYm0Q5gI8mvSK8axuDJiOp0ur1u9LdH5S8s3+S
         fKsoO3xvaSiNfop6bYCTU1RLg7NJiEPWrgC3wZ3BdsqDLz8QdYLRgPwaW9aEs25VbClm
         8WdR57HsZvAEj3YjI6mL9P0bPPJNZPB+PQX/Z4W/P6i1tHWsuiweZgufXp9AAtzSJYbA
         1Tpw==
X-Forwarded-Encrypted: i=1; AJvYcCVw89WDYxYfSwjzQIUOcOkldzyFWrWJOKgxbmKio3vXrHBAdE9+zkkuTtFvRYqcx/4cAXAReZJSe9w26F4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya92zMO1ge5Y6l4yzDqxTuBSWMN5jBfdtxQIqm7nO4CTeF3GKT
	h8rTuwDYU2BTQMPuQ5sQANZw6U4u0HVmit4A0qqbwZTviALGuZYp09NP
X-Gm-Gg: ASbGncsK/xCWPzv6gDqjdFTmDKYTeN+zgUwkEBG2dx5W9CYbvP9nBrQA6amzSrusGvb
	4xL2ZcA96PRaMe9PZBPMesvqwFb8nx3p9rIRxbxLXS+N/5h4O1m8D/jq4eVPrgV6El5HsswLeJS
	ocH0V2/IihAY2yepV11f2+Gjec6EBD6VukUdaQuXDcxhj2I0ycSiZxfWd3s/vfiNZptIHDAil5e
	slOiKL3i99V3//uZ7ZhV65ZZmOU/hFOT5mQCtvwu0BMDKaokPq2lWCwGPgN0dL8QJzYi+oICEA1
	kxjpud3ZBrNJKKfuNokHsWlrhQ3jgeqzrrow3caJqi6+kUeR8IePH9VshJaQri6ZW4V//cbBkeP
	SbZJ06OMDLidUTylb6cNYBnvbWKcp0iKJQs40WRmtYyxkdVnMU0FAUU99GcIKyUGgiw==
X-Google-Smtp-Source: AGHT+IEIubUseLSqrueCli47kNdptFpvg2o9b0qj23reXDH/dzzBpT/3wCPqEhs77WVKuNIkRCUy9A==
X-Received: by 2002:a17:907:728d:b0:b3b:d167:944a with SMTP id a640c23a62f3a-b3bd167d29dmr1320480866b.57.1759238833521;
        Tue, 30 Sep 2025 06:27:13 -0700 (PDT)
Received: from crusty-box ([88.223.153.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353efa46b2sm1143934766b.24.2025.09.30.06.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 06:27:13 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Erikas Bitovtas <xerikasxx@gmail.com>
Subject: [PATCH 0/2] arm64: dts: qcom: msm8939-asus-z00t: add initial device tree
Date: Tue, 30 Sep 2025 16:20:08 +0300
Message-ID: <20250930132556.266434-1-xerikasxx@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This dts adds support for Asus ZenFone 2 Laser/Selfie (1080p) smartphone
released in 2015.

Add an initial device tree support for Z00T with support for:
- GPIO keys
- SDHCI (Internal and external storage)
- WCNSS (WiFi/BT)
- Sensors (accelerometer and magnetometer)
- Touchscreen
- Audio input and output
- Vibrator

Erikas Bitovtas (2):
  dt-bindings: arm: qcom: Add Asus ZenFone 2 Laser/Selfie
  arm64: dts: qcom: msm8939-asus-z00t: add initial device tree

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../arm64/boot/dts/qcom/msm8939-asus-z00t.dts | 255 ++++++++++++++++++
 3 files changed, 257 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8939-asus-z00t.dts

-- 
2.51.0


