Return-Path: <linux-kernel+bounces-792195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E03B3C155
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF07DB6056F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1654733471D;
	Fri, 29 Aug 2025 16:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9ngOEEt"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A0B1C5F39;
	Fri, 29 Aug 2025 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756486443; cv=none; b=LYQ1Cv/1NRk9H+CGlCB0SAEFG4X1NZ9SG/Y16aMaKQzJTFZYWmSIYb1xtNoiTuij5jb2iMvBht/y/c0LAi+zed4tHMHZz9HRgITFURFCwiam2ZupT5zVZDiUE30Q/2FmmuYyc9F3HiHYotlfmuMYf8P+/1a2SRVStIwmQV1EgtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756486443; c=relaxed/simple;
	bh=/Zx6EuJdVsMaChgJrLRAWufLoMX5wE9nNg/FXJkVlKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QmAiVoekFdywTpXnz6eNcJxMGS/osx3k0n0yhWP9sVgD5fbbV8NH7LE1YXL36EBdcr4akRS9alptTckeQnEGWRbykKoNrvun/Sg16iWWSgTbUwQ2Hwd0hf38pBl5d5tkHzrvWUAyLWSbyTI35aPOkpZEdG1ZuzCIRLqV6OIgoNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9ngOEEt; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61cb4374d2fso3050214a12.2;
        Fri, 29 Aug 2025 09:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756486440; x=1757091240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JSiXnFNMhbGWyzrQUq1p1OLKuc73ypZQPHqffR4Wb5E=;
        b=d9ngOEEtGVZX6D2XB/Yh946pUzCoyEU11QPnnsZTw9spX+s5sL8wESb8tbdlpPGxhT
         5Pbde/G9Y2o8GUWMwYKWMH+xLL48BMUUFBgkUWrbizG+z8MgdWh3oneSmPCTl733cpM4
         w/sVeS7crhSOgC9OHeG/QN3PiwzmeNDyQCbR6lR3sJP64ahKLxzTGBKb1SrDtiQmPVtR
         6tT8XEAN1KOAGuGL6oIO/CYWG0Lk0YsbLdszYdOYhDfWAWb+4F0pvPRJEXYc7yraZ/om
         6Ff7qTru21Bs5W6EGABEZ2hZmh1kONeJamfU1tjbZZ5d81i977Sde9NI+YnlnP/SmJLr
         lDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756486440; x=1757091240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JSiXnFNMhbGWyzrQUq1p1OLKuc73ypZQPHqffR4Wb5E=;
        b=ZsrTDed2390J0YZ9WvKDP3kwhlPIUVVakZZZMdRmA3OusnXdHXYr4kW/ACflA2mey9
         LhQS1DWiKKE9qpX65kIfp6zSm0eFfQLwmZgQwYyq3023gPZUwdUljM5Ywa/P6TIV5K2x
         LL3FS41+darkKtR8IQ8V0bBByd200T7ezuDEa1GmHMPnmGADW84T5y3V7q/ATOehWJyk
         1Vo42Z4+KKRvufQopQAUF4aVxXZJ+L2mATDAOPeLCiS8jjgVLVMYMquk8vkbtd0Dgv+I
         nqpAU/VzoaTJ3GRUuDBzKwpeuBACsQeL0V4b1XmVkURzX47+Sbdp4zu9nzlhWQPYOm8M
         S7cw==
X-Forwarded-Encrypted: i=1; AJvYcCUIeLd8MwXJHGhCtdx8+qeXxN7B4iRfQQUcTGAQoA8jrXMC1AktHAQ+NnV0QoAOmzOqEFtSI19VtYwl7Gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNceYb6zOHelJW85js7OUxtfLp437OjT4QvsyDhw8nNd2W3tDe
	l5dDS+ybeLmCgKxdz7g35VZm4nYMz/TJjLqUQ0HrC17AmxGN7l9UY+qZlJ9ICArv
X-Gm-Gg: ASbGncvy+fVvFwIn6J1P7qF5FPIRPxlMFk9KCgVih0TM8CVoZtUFauyggwXX7QXAc6h
	8KJbAcTW1VbQ3fho9CjnEe0lGaMsh0yhDZ2aEolFHm24zPi3xOuww0fIruyabUUoGVoJuo4ECot
	9crQsKU45WqB0mDhGAKggqMOpMKGP+onefEV5sYfGxWkKqMUrusQqYoqAP1U4amCn76FLy4jAU9
	3wdAx6Zx/7QxTYb1aLvXHtvQFmGlOo2D3nQVGRw2B1bQ2kGL3udtM30KfgcZzXR1p/hBIMsxpUH
	nMDk6DD7PTJiuSE+x8DAEwSZoWtrfN0Dk+IAsRxf4hO+AWaPRbM7v23EuwGphpZP1EGHsyITU3Y
	LK2R7OL+1a/yQynH+vXc9Vn17HzSsvn8/xZnPf+qzDpMVeAzKeZzlpI3Oy5EIKnA1G+Z6bXMdJ5
	UE2s9Y4MycRDfhUc1E
X-Google-Smtp-Source: AGHT+IHtrSLNKTu7xS6Qz+TQBOEpQiXNuNzq5jN5nWhxoEPMOUPi29C7dPZp8V5L6mpyiEmvm2PQxA==
X-Received: by 2002:a05:6402:5041:b0:61c:f91f:4365 with SMTP id 4fb4d7f45d1cf-61cf91f52f8mr4225211a12.7.1756486439709;
        Fri, 29 Aug 2025 09:53:59 -0700 (PDT)
Received: from Lord-Beerus.station (net-93-70-53-177.cust.vodafonedsl.it. [93.70.53.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c7848sm2130350a12.2.2025.08.29.09.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 09:53:58 -0700 (PDT)
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
Subject: [PATCH v5 0/3] Add support for Variscite VAR-SOM-AM62P5 and Symphony board
Date: Fri, 29 Aug 2025 18:53:16 +0200
Message-ID: <20250829165327.20007-1-stefano.radaelli21@gmail.com>
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
 arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi | 387 ++++++++++++++
 4 files changed, 894 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi


base-commit: 07d9df80082b8d1f37e05658371b087cb6738770
-- 
2.43.0


