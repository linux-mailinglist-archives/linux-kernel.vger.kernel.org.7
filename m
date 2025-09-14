Return-Path: <linux-kernel+bounces-815698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F41B569FA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 17:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8394189157E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296E2195808;
	Sun, 14 Sep 2025 15:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFseE28g"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EAC38DDB
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757862219; cv=none; b=iI4CdGoDWW3QWbhkS6sndgylajkRvoNwzHgziqZ7z2GTzTx7Vla6TYC3wtT1suh4SYDdsLmG7nW8HmVZ5saWV+uzd0L9KvC6TDx8y7gIlcD/gCW9qp2+MMmiB02V8M+fZmygrRBamRdKmZdtACJ/zt6Q2xKFs7/xzuOZeHrCis4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757862219; c=relaxed/simple;
	bh=xs6LqiBmgxIFnHypoqe7nG87ntLyreVaFYrZoS66JuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kzzF5AcgYNBpxqqCu+et+LJ7cwExFC8BUp9HjC+/ZEG8NOYZCBcr9/2kfVTEbDzuwZts36fYipQbC9sG/ui9uxJXnJSZfeaUjhJwy017hAzIFOfyR/6k2PoyPud+6lLEkIofDmPDTGvLbEBDnpFN7t/e0QwFt058c0KUAy80AZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFseE28g; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45ed646b656so25314905e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 08:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757862216; x=1758467016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1lIRCb0Ss5Rfvrp/H0UgF1zFEFWzkJIihax3RDmNWDM=;
        b=hFseE28gfiaz8Z80hrHQ89F1TldD0T1aRIaEbmPWo8YnLnKqBMj+CK7C/IGJ4Kc+nP
         iNFpNOv/9rvtfMLU9sTCPs8JcEaaOHDVTvF+14mScxUz2LMqCBNnfjzH9g7UDnd/dK+b
         xhMmpwG5J33MFXKD1Q0GD/4mG+MvVtlwZ8OaaSz4haOIDL7dzWscn/AawtjzbTkRBcw2
         OZ2Ot5SgCD679WZ/fyltev+oFVcrQY1z/kybhrf4wGhBFO4SnKhOa2bKYff68NCiy20K
         q1lUYDAX6EEN5nPWhk7QJW/fv20kQzYyw/zEGuosGQpX7YdhHPEvcI6fSUDlIiQwlG9k
         veGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757862216; x=1758467016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1lIRCb0Ss5Rfvrp/H0UgF1zFEFWzkJIihax3RDmNWDM=;
        b=IRXtNepcBQnmCk6A/hobBIny6RAxOuv8HuJ4btN/b1KhbiWWl4jhaWMwt0hA+z3u4X
         dO2gpMfxF+70CzewCAXQrMGeNDSlxG6mCNmZCnszqbJZMGR88SpFSp06h9L8Ewvoz68U
         iySWPIxRpvQHGZz6CdQ2Teu5AFY9qk4vH1RjS7O4iN8u7QQ99aENet1POHUJATp9fJR/
         /SDKJrUNV+bqSisTLZSIGkNs94zizw9mXQjMory1I/H8EiWK4WrvQmZGlARMYwnXH2vt
         qHCNuhqp9BGwZ3l++OfH2Zy7RmVDmgUbVOgKaXMV430HS1Y6j4V8VvnE/sB0H4QBdcVs
         7FrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSY3UMfb8DgKIdV5KFgLtmxotiR3ZwdwJMOluoGF7Zn4zAITG+q4AOE+MoMAV6bI1HbQG/nHmpce9Jcxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4C6BUoz6FT3r9KcqQwctHnadS0n81QMeO9B/9gWKPhkN42/dd
	HOLn67alrVdpxYDSQ9U+fhis1D8a48ITOgXlQ2t+9UPl6IyiNUAxPO3Y
X-Gm-Gg: ASbGncuxEES/hI8LybcAb4+EY3+aie/Z3OAQlZw6Gf3XzlI+oT/t3dMTmFmzZJx9vf7
	iQ/vYnslKIu3dH9FXUrzR7joiEQxCtBjj0hLOH4EnjXUxf9HpRlV+N17zQqXxliyPcsrFjbEI4I
	OqTjILrBcis9TkOMXH8qlcCYZRfPSsORilX1RPMtyUVVWNRiQ9A9W2fUbhjwNZ28QTPhHOYqnRE
	VV5i3h6Qma2MsQX/K7Bt0D9lt2/UB2yWh02iqmiCXGx38lluZrS+nUrX4ZgSuxtNdK6/gEnHra+
	LLsbItTlf8CRS/xOH+8PeU0abHkuU16PfaMI3Wi0pDV4NuqvHozDimm0SMslijUfzHWo9nolEGX
	XdvREcpNgkPyjw5AYk3uL80iCft0y9AZ8+L73R+U6HuWi7+C8CgZXIhhmfT0WNEMffywD6Yme/S
	Qi6/UmB5eN
X-Google-Smtp-Source: AGHT+IGX+t8bHaJsVFUW55Nu1/GECO/8bMja6DNHy/GlXV5xfnZ/WFPTaKZBY0dv6uJ4UMHLFZgm8Q==
X-Received: by 2002:a05:600c:6d45:b0:45b:47e1:ef6a with SMTP id 5b1f17b1804b1-45f21208baemr59109745e9.37.1757862216245;
        Sun, 14 Sep 2025 08:03:36 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f2acbeee0sm32780385e9.0.2025.09.14.08.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 08:03:35 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] arm64: dts: exynos: add initial support for exynos8890
Date: Sun, 14 Sep 2025 18:03:18 +0300
Message-ID: <20250914150321.2632019-1-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey folks,

Before anything, this patchset depends on the following ones being merged,
either for dt-bindings for compatibles, and/or device drivers:
[1] https://lore.kernel.org/all/20250914112942.2604194-2-ivo.ivanov.ivanov1@gmail.com/
[2] https://lore.kernel.org/all/20250914114457.2610013-2-ivo.ivanov.ivanov1@gmail.com/
[3] https://lore.kernel.org/all/20250914122116.2616801-2-ivo.ivanov.ivanov1@gmail.com/
[4] https://lore.kernel.org/all/20250914124227.2619925-2-ivo.ivanov.ivanov1@gmail.com/
[11] https://lore.kernel.org/all/20250914134458.2624176-2-ivo.ivanov.ivanov1@gmail.com/
[13] https://lore.kernel.org/all/20250914145555.2631595-2-ivo.ivanov.ivanov1@gmail.com/
bindings only:
[5] https://lore.kernel.org/all/20250914131452.2622609-1-ivo.ivanov.ivanov1@gmail.com/
[6] https://lore.kernel.org/all/20250914131620.2622667-1-ivo.ivanov.ivanov1@gmail.com/
[7] https://lore.kernel.org/all/20250914131848.2622817-1-ivo.ivanov.ivanov1@gmail.com/
[8] https://lore.kernel.org/all/20250914132033.2622886-1-ivo.ivanov.ivanov1@gmail.com/
[9] https://lore.kernel.org/all/20250914132201.2622955-1-ivo.ivanov.ivanov1@gmail.com/
[10] https://lore.kernel.org/all/20250914132339.2623006-1-ivo.ivanov.ivanov1@gmail.com/
[12] https://lore.kernel.org/all/20250914135652.2626066-1-ivo.ivanov.ivanov1@gmail.com/

This patchset adds device trees for exynos8890 and Galaxy S7. The primary
method to boot mainline is via uniLoader (at github.com/ivoszbg/uniLoader),
however support for using Barebox as a bootloader after s-boot will be
available soon.

Best regards,
Ivaylo

Ivaylo Ivanov (3):
  dt-bindings: arm: samsung: document herolte board binding
  arm64: dts: exynos: add initial support for exynos8890 SoC
  arm64: dts: exynos: add initial support for Samsung Galaxy S7

 .../bindings/arm/samsung/samsung-boards.yaml  |    6 +
 arch/arm64/boot/dts/exynos/Makefile           |    1 +
 .../boot/dts/exynos/exynos8890-herolte.dts    |  573 ++++++++++
 .../boot/dts/exynos/exynos8890-pinctrl.dtsi   |  703 ++++++++++++
 arch/arm64/boot/dts/exynos/exynos8890.dtsi    | 1009 +++++++++++++++++
 5 files changed, 2292 insertions(+)
 create mode 100644 arch/arm64/boot/dts/exynos/exynos8890-herolte.dts
 create mode 100644 arch/arm64/boot/dts/exynos/exynos8890-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos8890.dtsi

-- 
2.43.0


