Return-Path: <linux-kernel+bounces-800854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54425B43D02
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A4E54395E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CB03043D6;
	Thu,  4 Sep 2025 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EahixrvI"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB7C302CC3;
	Thu,  4 Sep 2025 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992182; cv=none; b=Fdjqc58vTnlqOKNc/UI+VVMuxa62WjwqFV19mGT0S5kFtxWMTwdEtMLtJ2kw5X+5RwmqmeEX8K068XgaBT8XKkN5hV8CMTt0DO1vzeNJsnC5izezw1yuGHpvFC3KMFlUwLORx+Ds+qzkUlzoDiwplvTDaHwC39hxwXmCzoYnSzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992182; c=relaxed/simple;
	bh=BH1SIT0J2ge84z0UNunaR9KYRxKRB/JkLBQ9BPdia7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eHKMcokuxFjI5Y3VoTz105tfsaR+v20d58ZMBDORgS6NYu8AqQ6vE79iGgHc1wOGICtiKYlRgxHteIAMZZzvAAqMWdYdJhxw6kEx9F1tCERoJypruXdLfoLSv/aZfnlGzbGCmBfgoVD6IPb1Ra5Ki2r6GZaTJPEFiTDCN7WsPhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EahixrvI; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b042cc3954fso178965566b.0;
        Thu, 04 Sep 2025 06:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756992179; x=1757596979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JL/p+y59YOttTU+SYXHVuBaRBr/sjf2d5XYpAYF+/sg=;
        b=EahixrvIq7Q8W1om99mzC2eZrRFLpaCKInTcRa2IwsNO4BYaVf7RldF4iis18gX8O9
         Q05JvDfLBl8Dt0XtlHniTLLzdXmPp0CLVNulqGuH9bA6aZOlWOBL1qNlmaXNUF1uk3sB
         h56fqbVscCSX4Pe+dxdwtB+1/09P5Cc90vDg5/wWbtpCE+YkBzeFtA4sWkyy/ciURmB8
         GK/ybZZBc48Fx+8NyUNjf2MVC4/QgK4X7bK2dHZypLXCGTM/TbWeEWx9pHPt8x3lYLfx
         9LvtNiQ584khbH67HYEDQK5U5oDX+5l2TQ5509hJzAFvWHzMMh8Z+Vr9Bh0mhnuZvlb3
         91NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756992179; x=1757596979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JL/p+y59YOttTU+SYXHVuBaRBr/sjf2d5XYpAYF+/sg=;
        b=AU6mCp/6tePv6nF0plO7gnLY3RMXWy2l0hp5ooXzZfpnUyugVkUVyc4xhTyhNrm/yk
         qqWF53NRF3knPr+sLZ24QztWGjaFRGAXjGC6fxeHCd1csDOaI+p/rnE6aVjGtR/9/uxp
         KHpLarDjX/96tGXENpPnbW2U45YIAmWeP9QsZcqcjaGGIwQ2uCq/7n4dC4t38q6cDQys
         id08uJuvMFK39Daw8JQY2Hcy+BGeDOXmJaaMliPbW2BLRDc/zipAh+ligVmilnPfX9gh
         WhC10XIlhsm68FO+KEErRUuB/UMUdnrzl0173eWA3xI/I7SfibXSpQcg3mTwef1bGR3e
         vbpg==
X-Forwarded-Encrypted: i=1; AJvYcCVDVZNulip//faYiOE82+5GdCU/sBG/YLmYDykPP47vTPDgKFs2MAE5GG5dfIQxi3Wf05hLOpMBfo3U4cA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQHwAhMz1SGaZcG+2ah1L500eX+ojB+rOTXiVSm8NhKDzDEcue
	068pK1r4zsU6sTKT53Oh2IB0C8ehUOkn6SFVF46bIxYzsWco5guB/rUvlGY4dg6SDgQ=
X-Gm-Gg: ASbGnctbGx4Cc+LRZbsqTx2WTTSXmd5HqkaWB5Wv2/Lbvw0tzZslcyYuIALBTJFUAua
	fy6vhOH8+MWilFlRZl3NEbl6G5nv8/atlgkStRaUIDDaQFyy9u01zKota6GpB6nBSaPdK+Pglcj
	gyudENQbqpHNx9tbm1txzmISuST8pcxNZHiPliDykcD8V75/2cacOh6Gmp7/daodENAw612EkeZ
	smLE1IiDrsNatPVdhIenzsVFjFIFf/sWXigAydIJkMQZAG+fTSIrEZePeB0KozllO0eI/LRFyeA
	YZmPeevWFuckdZXhTjQEQybwok/yt9KFK9mIYMbBSW/9Y7ii2XG3E0qcsVZ6OXzwOGbizSvXiMn
	xw3BQQp65KnZwBm2+nBhI2ZMuvX8ZLyNgbfJnw4vMJRESXGAR61df5SjHAd223rf1uvyicoS06r
	0GEjaBz6TksSq9/2/R
X-Google-Smtp-Source: AGHT+IEf9Sjz4QRUX/zyMVbMO4cyCoq+6iO0CcgNuyalc7VAtoMVCq7+gNaZykhi7k3Jogv9bTV3sQ==
X-Received: by 2002:a17:907:9409:b0:b04:74d1:a575 with SMTP id a640c23a62f3a-b0474d1b166mr491622366b.62.1756992178469;
        Thu, 04 Sep 2025 06:22:58 -0700 (PDT)
Received: from Lord-Beerus.station (net-93-70-53-177.cust.vodafonedsl.it. [93.70.53.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046d0b0135sm372121966b.73.2025.09.04.06.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 06:22:58 -0700 (PDT)
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
Subject: [PATCH v6 0/3] Add support for Variscite VAR-SOM-AM62P5 and Symphony board
Date: Thu,  4 Sep 2025 15:22:27 +0200
Message-ID: <20250904132240.36819-1-stefano.radaelli21@gmail.com>
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
 arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi | 385 ++++++++++++++
 4 files changed, 892 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi


base-commit: 07d9df80082b8d1f37e05658371b087cb6738770
-- 
2.43.0


