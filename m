Return-Path: <linux-kernel+bounces-815671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7AEB569A9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 16:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAC37189A0AA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BD8202960;
	Sun, 14 Sep 2025 14:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYr1itAM"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918378287E
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757859479; cv=none; b=PgREOUkUcBoDViSwTc3W9msCJfHZSUq7JAmhgmgr3Oxjsy8MG12NWGeH31uBgg9pijL9ClbnP89CX6g/5+ycZo7E0cbEs3KP9HTPaERjDruQNgLg1mz7V8RPtCkRK2Zpvu+i6hK08oPr6VG/RbRpdditrpOF454pKj5kcmcYYT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757859479; c=relaxed/simple;
	bh=oanHDB/HU2SsYAo3QKajuMOnq/wtBoc5Vph6yvBts6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e4nWdeAl5d+YbpbAJ6oVK31bKMAudmoNxAcWSVKYdlohEOiLvLlRoWTcdUNI2MXtRWmqIW3d3XyeJ4FFJBlyasUpFxDo2Q5OCDj9xpqu/iindy/T4bCeIMgtNUQfjrR91DMqRsSSAz1/zVYaXU2APARlx0omXvqngS6xV2omIfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYr1itAM; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ea7af25f42so129377f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 07:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757859476; x=1758464276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rsUHVkzZaZp36viUnZ0K/EbyNwm+EVEnUQ5b1FzHDOg=;
        b=EYr1itAMOIfdrCpe2HS62umcPEJL6+uAcVycupbYnWKiGsxhiehGGIN19MMcP1ricl
         mgJJr1nScQRJ2FN2KIFvX7kODSpUEE3KvK141IJWVR0+AkoWVTdwqlH/pxvKr3c1vxsh
         U76N7XBdMtMlZD5tgmGk56ybae8SKd/FMTBpBSN40edAb9g/1OcPvtE7wSvtSVbnETmY
         3lRLyMVatgLoafCu6vTq77vsWmTdqZoh6mCHDI+QHVD1EQz1Vo95ITxs7nDQ/Hgp2eUI
         Hf+hynf7ABYoyjg8oSMJ0VWqst3yA/auB9nAa8PE4o/wnA/ND/rMB6VpUZbbBHj+lMGJ
         U9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757859476; x=1758464276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rsUHVkzZaZp36viUnZ0K/EbyNwm+EVEnUQ5b1FzHDOg=;
        b=nQzytsw+A9OcApVkF1T0u7/wC5KM0GiOtmoWKA0rIoTfE9RqXbem7Br594gTmyG/bH
         KltIABVvJDatE9uQV+5iKsWklpL5Yo7ska+OLJbwPq0d+xgvFdrG2+hlGv0WEiX9Tp1y
         Xb4qMCyjutw73bDAL//hbGjwbZG3oukPue1SfkL5MCIs+R6UhOW1W2Aedq0k7IzkhgBj
         xXPjuJcoCk8xs7xUkH5OixTRuJM6L7LfJW2e9VR3vCuGc4D0XXpnz0vjEQIWIKkuGZsk
         GdAo9GaWbNR/2Lz9j557NxbG6WvYck1veAIhRKrnOjywNp346IqGdFXJ3i2kbMcw3UA0
         Ov+g==
X-Forwarded-Encrypted: i=1; AJvYcCVem0VMVxgmGlNGJ1TdESKIuaEmarNpgn2hn5Dv9xuAMpwGNPHqbVgJ3+v2j4er/a3aRFP9OpQPZMpBeaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3wVnSY5OwjYExxkqCbAxDkv5yNNYUiBWtzmCDAG0a5qvh/tQZ
	YO+J92VYn03riRy0aYXC5k4HToOGTQZw4sVf0J5dUJwCpFLQrr0ZLdoC
X-Gm-Gg: ASbGncv0nOACogpMhLFjC8lUxPNNqUN5ouzv3+YRUvX5ksUIyF6Pp6YY4Md/dlGIC3N
	OycC6mTuV72kvzfngDqYPkOVvmiCnv/IYFhYseg+bo+8T1IDO0NW9b8m7s00sMPYJDLPITdj4L0
	CMK3dqvWU2lsWHPJ1WVy17Y66dWmoK/acvVNgdzDYE98ZqQ51U5jQB7hwqxy+Odr1GEPFJxeM6r
	u0taGEPjjMQ2cjAMW9K4Yvw7XclCo+04neU02Kz9un5Vv8fk/OzMpZzkMgIzZewixxGK9SAZ7Ds
	tLN7D49+yXWjsHERXIKGrDD/Sz9sUv2hAPTjNTD2DR7cPYPd0t8ABcVfYbdNV0vSBD2+j3Tm/8D
	/Lz2sYGEzkVMHGFVCg9ipW5l7mydEFtfO/gpEjGCTCdiQcjTocabioWAk+8VaCh/gxVJ1PNVx0e
	SZTESgvqTD
X-Google-Smtp-Source: AGHT+IG7SrhD2n8YR6eRCNsiBeL2SRv1fue30YukLFK37eQXkOEUvQbSB53x/xhqHBpjrKKhjtKgHg==
X-Received: by 2002:a05:6000:270e:b0:3e7:9d76:beb5 with SMTP id ffacd0b85a97d-3e79d76c25emr4400712f8f.14.1757859475877;
        Sun, 14 Sep 2025 07:17:55 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e813eb46f3sm7319270f8f.23.2025.09.14.07.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 07:17:55 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] phy: exynos5-usbdrd: support the exynos8890 USBDRD
Date: Sun, 14 Sep 2025 17:17:41 +0300
Message-ID: <20250914141745.2627756-1-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey folks,

This patchset adds support for the usbdrd phy for exynos8890. The SoC
features 2 dwc3 controllers and 2 usb phy controllers. One of the USBs
is used for DRD, whereas the second - for host. The host one seems to
only be used on the MV8890 SBC, which... I don't think anyone has,
really.

Code from this patchset can and will be reused for 8895 (I actually based
it on my old 8895 work but decided to upstream it)

Best regards,
Ivaylo

Ivaylo Ivanov (2):
  dt-bindings: phy: samsung,usb3-drd-phy: add exynos8890 support
  phy: exynos5-usbdrd: support the exynos8890 USBDRD controller

 .../bindings/phy/samsung,usb3-drd-phy.yaml    |  25 +++
 drivers/phy/samsung/phy-exynos5-usbdrd.c      | 210 ++++++++++++++++++
 2 files changed, 235 insertions(+)

-- 
2.43.0


