Return-Path: <linux-kernel+bounces-836251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E91DBA91AA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E26DC1890DE8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C722F304BB6;
	Mon, 29 Sep 2025 11:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duPNxDDJ"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA6D30497A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759146567; cv=none; b=INBRKLFLt5Wk/wLR7hJ5udLoZSXSoL6B4ah9cEGF6pFG1m0oGx6YPJNlG0Ivy8tM4acN3SefwLD7rdPhKmwZpB8eb4ymWq8SygQik8W+FMkpl2KZMAaY7hUSBRcm+6JJaR85EYzF+AW4WE09r4f5/iZcn/iLfOZMYISyRkHw8AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759146567; c=relaxed/simple;
	bh=3xOYS52/3sAqAFoOAMM7xyJw/GbBkIDjCptmDIQUZYg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=A5adj3lDqs+3uNBgbynVKyguOb+9xHPf6c4R6gYMWHASJDircCx6cRycD5EokspBN9jqqOSBDOCDAygq0/vBQMxkESHGD84KoPrHDyPUtdPlgBCrKriboIeHVVoJrf9A4YREfN1PlQYynKBiOPiHtE4tW9X2qd/aDN+1aMl7zog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duPNxDDJ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e542196c7so3933265e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 04:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759146564; x=1759751364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AA8qJbDS2PXrHXWRwL/CsSJDqnLVXMkoJNGc5ktbBCE=;
        b=duPNxDDJaN3WnEy7gBXhvYagfiWrCVdjAsfepRv492uwHQ09vz1pWMuysobNgW2j6x
         CyGO+jx7T4uoD4W1x3q1CjXnfn2aPdlrt3sSwmJiMtBH5Kyu0jbolHRo6SAFzJs7CfQW
         5pYychuu14C9rZdNSXu/EoRuKGKcMqqr10LepIsg5LgZeVObP52KsrF+x1J2zjGoDSJq
         YEqLSPYhiDkfUEmUpi766LDSpHo+aR1y9tHg/ONd012WzjJsX32tVKwvE7s+iig+ORSX
         3C7iYCY61bdj/QVVGg33+uMXpFZMKFWjwTSJVCr9s+5YtcN5R+aDKVhSgC/iWqFcyQmw
         bekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759146564; x=1759751364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AA8qJbDS2PXrHXWRwL/CsSJDqnLVXMkoJNGc5ktbBCE=;
        b=ks1RO5dCeMASXHYqC7nzoPDymbsV57mtSHl/Ws/K8YvVd7lhCUkGhBzkYLGA2fYPEV
         Kp2NV2OswaURf2XIsXITytJhCWbTmIXcuNfreI704dFBMqxGHqkaTldoA+T0vx9wLQga
         QR8axHVZc3fuGkXkF1tZ/YbhDUGmi4NKxVjNh/V0sU6TjG23FvLu1E19BjhzwtI8RtKD
         9RWXGPvZDwkLilWTZ+k2WI3JeohzAMaAtfuoHbCZuMwlC+yddFN601LbwQAbTyZ2Cj13
         3bWmltMe6BwORTLTphCGsC9CN4jOGqQRzCTNcfNEvxOzUbdyJRy0BZuq39pevwbhGjvx
         122Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBUJ/AIZYrenvIACVCvZwhCUlcQcO5NgJtRisjlozslx1i+f0B0gUJiJa/1YGyhnRJOHxAAhaaryUEWqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw74KaJQfZfeDuOQI+UF7UNIkEotp1ToiSI7A2wXXQePzq3PKF3
	6uk9KcAjBm6xOsTPdq1Qw8FlXdT62iyLtBHYb1uDy/k0zASfGJ0Iq2tf
X-Gm-Gg: ASbGncvBWnmM03gGZ6n8YsAzQcyBnRwO0G2n0+A1zZzJS8y8Ib46T39nsNuVbUmDtxc
	TWBrgIPZcGjMD0vN5C3U/FT42GYT/o3cdo0zn1DqgZCp4I7mEOp+JKASshPThnESdHdE0gQj2mc
	4S6UzxA9w0+c1Thpuh3fvV7SeZWBigUcA7xNjFbb44G3dkK8vy4LXmVZDFN56huiIzLxL/8IGdz
	cRyDbvriXRt6fpgWXYmenCjKbYIInLMyIMNDxgdYJC4u8hgqeqeHK7u0rn8eGK8Qyh649y7fc7O
	bqkVzMqUwgEdbpe0V5mo46ggCjDEADUbasRscRDyz+Ej8lAGyznFV+iU4qKpe53MV7W7hP0yhWx
	JuqLUhC/H39bUeGLjf2gO1rk4wr5HDO9AbekCSypwfN0Q750J1nHaeFd22FSamZdPU0Txz7g=
X-Google-Smtp-Source: AGHT+IHWIIGjN6nhJ28ac9trCVEFZnQxU7WiTxI9XitTonZzPwwSA3UglkJvouFg2U2iPv1aIzbnYw==
X-Received: by 2002:a05:600c:4e46:b0:45d:dbf0:4831 with SMTP id 5b1f17b1804b1-46e58a02073mr3602305e9.0.1759146563815;
        Mon, 29 Sep 2025 04:49:23 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-46e56f77956sm10030835e9.20.2025.09.29.04.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 04:49:23 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Felix Fietkau <nbd@nbd.name>,
	John Crispin <john@phrozen.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v4 0/4] arm64: Add AN7583 DTSI
Date: Mon, 29 Sep 2025 13:49:11 +0200
Message-ID: <20250929114917.5501-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simple series to add initial AN7583 DTSI. More node will be
included as they will be supported.

Changes v4:
- Add review tag
- Fix alphabetical order in Makefile
- Move PSCI node after CPU node
Changes v3:
- Fix typo EN7583 -> AN7583
- Add specific compatible for watchdog and crypto engine
Changes v2:
- Fix DTB BOT warning (fix crypto compatible and OPP node name)

Christian Marangi (4):
  dt-bindings: crypto: Add support for Airoha AN7583 SoC
  dt-bindings: watchdog: airoha: Add support for Airoha AN7583 SoC
  dt-bindings: arm64: dts: airoha: Add AN7583 compatible
  arm64: dts: Add Airoha AN7583 SoC and AN7583 Evaluation Board

 .../devicetree/bindings/arm/airoha.yaml       |   4 +
 .../crypto/inside-secure,safexcel-eip93.yaml  |   4 +
 .../bindings/watchdog/airoha,en7581-wdt.yaml  |   6 +-
 arch/arm64/boot/dts/airoha/Makefile           |   1 +
 arch/arm64/boot/dts/airoha/an7583-evb.dts     |  22 ++
 arch/arm64/boot/dts/airoha/an7583.dtsi        | 283 ++++++++++++++++++
 6 files changed, 319 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/airoha/an7583-evb.dts
 create mode 100644 arch/arm64/boot/dts/airoha/an7583.dtsi

-- 
2.51.0


