Return-Path: <linux-kernel+bounces-727722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 848B0B01E9D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70967580B0E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A112DE714;
	Fri, 11 Jul 2025 14:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBg4FdH4"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41B12836B5;
	Fri, 11 Jul 2025 14:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752242750; cv=none; b=KcB53mRStExB2El8xLjFiSf25xg1I7R1eMQGjxazUjKp7wM4ERcC458zi10BY+PXrz8mZwJdDfKAbfeBwksLnYJCmBd8s+UAq14XXxdi8crHgR2xN52q55PkL89kwwaCWIDKUuR3fw73VYv+nh5UsoBpIVBTkOhHgbOOsV7ai4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752242750; c=relaxed/simple;
	bh=DvDgw198mhgEE+MiYh+ifDkNko+sIUJyp6gZ8QQSPJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fy7xCItMa4vHedYPNroh4u1k384++274IGqcZAkHt56sKdXAflaK9wrgYnNc+CIh4B66wLbpy16M6HrnozNuI483ViTs6/OvDyKntjgbL8qEyhhwk6BGyRuePdI65geO8GnDVrYdpcKxS5koVl9hNf6W0mo5WpUYNE8+Qzo9eVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBg4FdH4; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae0de1c378fso336686066b.3;
        Fri, 11 Jul 2025 07:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752242747; x=1752847547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WE+IOp0gz3myzml1robE7AcvN3W7ZGy4gHZpbzrQ97I=;
        b=eBg4FdH4eluNvnLhn9f+NeKdznr//XBIfhwpfmCdhwdI8rCWiU/TJiU+YfeRjeZuw9
         CP0WG4Wkc49SAp82p29RIcPm5/+LQHQpJyFL/UhKA2IQtiNERh+jRvtLNYK51zhFy98A
         07mJLxzbDxCA0q6e21EXzU0dlxa0a03cHJNr31IH7zyLyw7xEZl1mkm4IOXpKNy7SE1A
         AoJ7Aw+ksQegYvqJSngE2AdiTRm5ZQRT7agNYU4AJ4EcPZ60f1JpJrEsbuk+m39yu/XU
         ZaOjcA6sZXTCO1XzMSSgAylQjGTsxbR7QYeVSBBd+/tTVF7QRyOo2+eOwqFS/XZHBcS9
         TVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752242747; x=1752847547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WE+IOp0gz3myzml1robE7AcvN3W7ZGy4gHZpbzrQ97I=;
        b=ZDA+S+cJtXCxhKoCaWfyHUN+KhOWPhodIVqqwyBb+K9ITmBESNhN5OrMnBmwU5twzN
         vQ5nt+Vp2p0Cap5jl8sol1ukSH3gLuHakkx+2zHNeR0hQIUeNMb4XkZDFtWl0hHphsEr
         SjAMs7KixFfXJhpwelnEh9tm/WW6+Yy9aor4PLaTueV3glAXqTHxn/NrzBFjqK+mlIUL
         lLXxqe5NkDgGCF5ci+im9/4+nrxjlqAKBjTZs9/E31XGimlYviuOh/HEvx1bRlBfg9c9
         r5i/nrj3Z1y74gI8rQMwXe6l+Ct0Sqr49Nb0fHt18uSs1O3liV67Purc7jU58F11wONv
         NUDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWm1jNWsrL/cUJARRjF8wj50jQRKcTOlMiHJxJDFZ2SQD5jI0/XuZmwd7k4YlT4DlbNHSfonU6ml/Z9Y3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrqe+5Y2I5WVM33nOPQTQ+W+8B8EsLeRKVvD3UXx/Jk3YOfnQs
	z1gsNrjK5MlavzCQPZSCoxhs7a/6LiaECjQAfTfP2vhOdRs0CccARdiiu+CpNwbI
X-Gm-Gg: ASbGncuLsGYpg5dCGvOkIy46sbYRyZnL5CQziKRPvpjezVWMNLQ6cDXBtmO0cl9XIVx
	AYEa2MmJ55AR8M+Lx+9JOkGe2Kzo+L1YbOQJ8WcpSMGSGUYDTXshF3rnB6DEwkdVGzAX0oyUjjs
	RnzA6ODAmd4gAwZJnUFvqgGmg9a+WIX3Q3VoTcPHJM2WdNsmOVvqnb3T1W0pIxRfv4wovKaGg3N
	krEKiOS4xjWUMTPJR0avU1PVQM50Ic4U/lEfVXhkJ0zH1fTkYU0t0XXk9ZkZxlkeI9CoeDczBJU
	HdhtsLmCNUgYWtr+xSqU4XdCuTsT9ne/DkDRl4xRm2VNCnHSWrX64OWvHSHsbxKOsgxG3CUqza5
	+sfb0AT7WvqA60bjpqT4akcBne8vskME/kWrXNm9zh76VKYz5aaDbAIk4j0gLb5yST7oxCy9Xrv
	5KcAPJJA==
X-Google-Smtp-Source: AGHT+IFAK2oK6DeRRLbqXQFKOkQdLjirZ1hHerSgv3MN1KO3ZnnEdCiHyEsNz5O5pHHIDXGQX5buSw==
X-Received: by 2002:a17:907:1c1f:b0:ae3:75e5:ff7a with SMTP id a640c23a62f3a-ae6fbc8a3dbmr382722466b.19.1752242746462;
        Fri, 11 Jul 2025 07:05:46 -0700 (PDT)
Received: from Lord-Beerus.station (net-93-70-53-177.cust.vodafonedsl.it. [93.70.53.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294bd9sm303435166b.132.2025.07.11.07.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 07:05:46 -0700 (PDT)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Stefano Radaelli <stefano.radaelli21@gmail.com>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/3] Add support for Variscite VAR-SOM-AM62P5 and Symphony board
Date: Fri, 11 Jul 2025 16:04:55 +0200
Message-ID: <20250711140507.17574-1-stefano.radaelli21@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for the Variscite VAR-SOM-AM62P system on module
and the Symphony carrier board.

The VAR-SOM-AM62P is a compact SOM based on the TI AM62P Sitara processor,
featuring up to 8GB DDR4 memory, eMMC storage, Gigabit Ethernet, and various
peripheral interfaces. The Symphony board is a feature-rich carrier board that
showcases the SOM capabilities.

The series includes:
- Device tree bindings documentation
- SOM device tree with common peripherals
- Symphony carrier board device tree with board-specific features

The implementation follows the standard SOM + carrier board pattern where the
SOM dtsi contains only peripherals mounted on the module, while carrier-specific
interfaces are enabled in the board dts.

Tested on VAR-SOM-AM62P with Symphony carrier board.

Stefano Radaelli (3):
  dt-bindings: arm: ti: Add bindings for Variscite VAR-SOM-AM62P
  arm64: dts: ti: Add support for Variscite VAR-SOM-AM62P
  arm64: dts: ti: var-som-am62p: Add support for Variscite Symphony
    Board

 .../devicetree/bindings/arm/ti/k3.yaml        |   6 +
 arch/arm64/boot/dts/ti/Makefile               |   1 +
 .../dts/ti/k3-am62p5-var-som-symphony.dts     | 500 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi | 408 ++++++++++++++
 4 files changed, 915 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi


base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
prerequisite-patch-id: 7e8493f8ed01ee319f827119ffdac7531afbbc4d
-- 
2.43.0


