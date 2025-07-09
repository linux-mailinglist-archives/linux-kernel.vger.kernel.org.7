Return-Path: <linux-kernel+bounces-724563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F9FAFF462
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38F8488437
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EB5241669;
	Wed,  9 Jul 2025 22:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hytf+ZTe"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62281F956;
	Wed,  9 Jul 2025 22:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752098875; cv=none; b=CjsmTbZzubuutPxPna7IkK67EbasX+/PyQG+vRqtVrM4w7BfA19BcaSiyyB2a/L/QZAnFHJuZkohwbc0dvlEZnDAhj9gQ9Ppigl8tvTEB2F3kIb5qbZuv67x+ZvDdrDn7Lcp3EJ2fTfLfUgNyiE6e/M0ftgm2jk7RRUat+8/RZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752098875; c=relaxed/simple;
	bh=Y/YzqPly9vm7+9jHV31IJ68XWg619s2G8ueK7uPcjsw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MkJpWkQtocesTpfxH1kqhheNSZuTakzcj3p0LRWpURHD46NxZvshzspbH/JnxIZajMxP8+qR0Nr0RNI1eEx9M578aa3a68u2NdR7Rq6pV9AkWS6Y6iearZUPAhSh/DbbHz7yc2xcXbszoClFanOiqjfjJ8iePEiMLoD1pX4mwqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hytf+ZTe; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60c6fea6742so512099a12.1;
        Wed, 09 Jul 2025 15:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752098872; x=1752703672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tJzM1K1Dmueh7OdUtHBIOxpyAgF67zAJOJ63216nDS4=;
        b=Hytf+ZTe7IAeqHSsqwnV05Pi92kH/rhnuNPqw//f+lRFhaqDLRvouLryV1DLKEgfxl
         S4pKWs4UiwpiND9DmoLLrWdwP8kStBzzvn5ylB878HsDZ7nD+CHqfOL3PIr/GAmpfrhi
         vZqBIB0S1InX7Y4UTEYMFLXH1gffwwsxCOM2m6PT0JYIqEGGASCoq5XOLMbz0g/XOth4
         Zbesk9LjX8qrJVhiSJPYEahUGNpfemDTfZSpieEypA9B2mc00riDSmCC8NIPEMQ+RkOZ
         OEJ8iaqsDQ+K8hrvTFOZorGkqMnift9RjZYEg2S9JhK693fP8PqAyZNnhDpXT3Z7pr5J
         L7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752098872; x=1752703672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJzM1K1Dmueh7OdUtHBIOxpyAgF67zAJOJ63216nDS4=;
        b=toZAEiFuPYw8z4B8tdK1o/zHRQmi0G0UJPEULCqgxupdhbb+oWPoykXP7IHzyyK2lD
         sKURZ/i0rOj8+lk4M/4fyiUvhVYw5/aMs6VdaRx8hel8m6+89zIAKD1Aw14Tg83qa7bd
         vjrlD/nUfICH2vMPKEGyIsygImuekmNxnocMwfh0r3RM8+TZx8HH1HbjHlIm+g7kaek0
         63ZZmhemm1FzIyLsV9xF4LpxbUen8TZWJVwb4yqMvLMT0F7yc6r8VNpqzoWZzWHEQyaX
         at39HN9H0tmSvmGUq4TQPAaNso8AIATf1XYCHTY3wYzawGv8wh1dv0DthwUkfxxMBVqA
         vcDw==
X-Forwarded-Encrypted: i=1; AJvYcCVqmPHolXLS+LJIC8kUoc/qww/SUhLn7yNysUPemVfi4a6is3Rbjh4nIeN4Ov7/GYYOBz5YUI7NlJ8/4R4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNu57TnNd/Oe0hgyMFW6U3bNErADv0Yyh7rsMl1h0+HlYTZ+J7
	hemBqDet2soXbix3dsxZyKi6wBWE0JblmRYUP89bmE93nkC+CN8CsqAifmQ0mFwv
X-Gm-Gg: ASbGncvhlOUKx3HyPyyVVKRWFeupiuWsZgK8GXobjNiZrP8+r3helwZXYXJD8s8pVzq
	RstdxFtTHiaiDbJPjRUIPzLMZy4ge2SLXAaoCzQQnOHctwEqDD7y7H6ocgLq5wdg+kLsQowDD5i
	NurbLiOg5TzJ1142SaLftNEn3NdnG3/Y+bzlXMle/GZUnw9hkqNqojv6GSYxJRC+BGhiBVzZ8T0
	e/9K9hcpUFIZRxJWM5knsKciNdaKtiKr3z/JsT+VC7mgHNIii/0R/rJJA0lt6Roz4hPhW1uCK+C
	6g3ljcJW7oIFRSWo9cgUmWQz/w/bRY4CpZRqSRQUoY4IFPshcScH2wQe8kwl/uK3HEHFINIIwhU
	IlrkUeAuVzrrE1stjTj3RpRMmZgfrFNCBEeZhPLuBXzyLew==
X-Google-Smtp-Source: AGHT+IHlkfkLvk0xG1HBQFG/XesTYuOQg3jZVndTCAQHvvSGCdCcXTtdOQ4Fa6CTUyNNcLVE4GCoTw==
X-Received: by 2002:a17:906:d195:b0:ae3:a71d:1984 with SMTP id a640c23a62f3a-ae6e14550ccmr134642666b.57.1752098871710;
        Wed, 09 Jul 2025 15:07:51 -0700 (PDT)
Received: from Lord-Beerus.station (net-93-70-53-177.cust.vodafonedsl.it. [93.70.53.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8264fbcsm10520666b.75.2025.07.09.15.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 15:07:51 -0700 (PDT)
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
Subject: [PATCH v2 0/3] Add support for Variscite VAR-SOM-AM62P5 and Symphony board
Date: Thu, 10 Jul 2025 00:07:03 +0200
Message-ID: <20250709220714.85697-1-stefano.radaelli21@gmail.com>
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
 .../dts/ti/k3-am62p5-var-som-symphony.dts     | 563 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi | 374 ++++++++++++
 4 files changed, 944 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi


base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
prerequisite-patch-id: 7e8493f8ed01ee319f827119ffdac7531afbbc4d
-- 
2.43.0


