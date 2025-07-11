Return-Path: <linux-kernel+bounces-728103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17278B023B3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F0CA5C3F17
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4B32F3624;
	Fri, 11 Jul 2025 18:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b="twv8jBC6"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119A92EF2B8
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258808; cv=none; b=BOoBPskvXqtLOb3Ds+veFXzrlHFzBXf0a5V8+YXwZMB+HNoQ9QtFgzF7/nrRvTFGKXG0KcnSH5hvpugU/4Qmr1Phfg5AaSLfpFC+QQ7eBa7aFUAnGZBIhVOdDKsdgFzUSywOBpA3PzPeFBbIZyr3wO4ij4yB3N8SyFbvElyAdGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258808; c=relaxed/simple;
	bh=1G0N7Bw1f4gd8ihh0vme3OMtchuWzqYwrdve1euwDuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bOcqfADpqNPUT/jSQVPicHW9MyS0FFPhY4nyGYjfhnMbri75npL3ZuXVNTkbW6CE4T+6tFAoy/RzVFwVaC+yGot0GHMmmRxwv7pcVQsq6bs6ZlSDnDwYYerzvmtCk3mghNWWtwo11/liW59S8HattXxR09wB0vy6PDUz7lnj47U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be; spf=fail smtp.mailfrom=hammernet.be; dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b=twv8jBC6; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammernet.be
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so16218705e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 11:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammernet-be.20230601.gappssmtp.com; s=20230601; t=1752258804; x=1752863604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wGlAjOiaXk4Ea4ZU7FQtfjdQUVKQwTgsf1DZ7CdrvG8=;
        b=twv8jBC6dv1Ip0AVbkbCguXn4S4OtDYswzOmShzGdb3nI/yX1Oc9h8O8s6EJ1s9uZq
         yznJLg2LwmI4KPrzi8wE9yvJCeLR7jyEWscHqrRjzc3I8rocowuOP90NOOTiDQJ7NLfm
         dm7rrUQr3kvpKCg6Gg/FylSyA4fSVAHjshlAcP/2MUub00Oh9reSX5upS4LYBS98CkVM
         yUmJbTELPmW9ZzG5Uy5qASGCTipGAh09f1pFVt78zfWZq30PziJ33nEglUiTa1pBGYKm
         k/xUjSALfsVegYseuAeLw2S0RKKkA7Bo+ofmNJ/ZGnzqbZyP3sY7m38hhlJ6oIv/1inw
         qcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752258804; x=1752863604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wGlAjOiaXk4Ea4ZU7FQtfjdQUVKQwTgsf1DZ7CdrvG8=;
        b=UEPLkIj/7bFuzk61bLRMoel2FW0yFEpFbGFYOiNRVrlyLZXYUdE7zH9KAV4NhQNfMY
         CHABjXstAX9VKRTrNc0Joa5V1Fe1dnCR2sxZYhKXfUKdqVupOFmWAm7ckhMJeaLNKg0Q
         IYr3D3syKlACvwIj6Lvx0wKjqJqSRXHOU9+BusTOYKKO26u7HW1wWJRCw84HjzfQ1daG
         0wDkiEJarUBsD+ELAAb5uu081iewyuHUEBX1JYp7/GpfCxKlM8cXkG6V/8EiNL4Ylb8K
         SSRqOIRxUe9ze93Sw3kFZkaFQGoqoQ1lOPzkk8iR1dA86b4ZdJAV6p8MoiXpVQpGxMV9
         ioCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhW2hRhj016aDSjQF7+OLpyaM7FPTTAVqrYQAMcD8cm/nCVKUYuXgdoN6JnNJzeUp4kTx+1TpgUBLpunE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7wgQxTWnhRhQLdae6i8IEwIEj5Gh3pn4kFjjTGRgZDyTesFMT
	qm76eYyTRB8RddevKqSZDmR/rcljCOrpn/ihre1G4O3VHAxz48V8BxfpD0aD7JR9V8Y=
X-Gm-Gg: ASbGncv/QLm17sqw03+WQxLtZ8FuwiqwcIm59PAMBFSkCnGxDiDLShQB7qgqWMIbGoW
	Yi2Kj/fLNEiWhSSf6SBALOoTxRR5VFr1jFfnedNEJL6qqX0EkFVELShz86udkcsJJ/dxhmruh2H
	QZrj/fGp2BghevdZS6XM007/QUbB6U91IlRiXmkWN8PMHodAs3jk6mmADIeU4rY+Meg58anUilA
	OmKf9L8TN/ftqN2ykf0oayHJO7jYivOJ4/sHYtnWfF+SpEyUAUtM/ExKP1CfKwEydmSlNiLhKLd
	on7NSYOceb7uAyOXMCZZMq1PGIfFUFcC+olKv8XXSF7GKniISvwV/PLTiCWcfpvya8cc8gPmh09
	QcrJSn+AMagV0Kw0DTEL/PfQNLgLDl1BL5O7sQwL2kUMRRxWvjA==
X-Google-Smtp-Source: AGHT+IG0eptajR/3ce/67Zp32WT9bRB0ErxbOxP9NIp+sKL8MyAm504UpLdi7e8zbMZpfT85BGq8cQ==
X-Received: by 2002:a05:600c:1908:b0:450:cac5:45e7 with SMTP id 5b1f17b1804b1-4555f895800mr32393375e9.1.1752258803998;
        Fri, 11 Jul 2025 11:33:23 -0700 (PDT)
Received: from pop-os.telenet.be ([2a02:1807:2a00:3400:bed2:2848:b66c:32d3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45601053020sm705205e9.36.2025.07.11.11.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 11:33:23 -0700 (PDT)
From: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	dlan@gentoo.org,
	palmer@dabbelt.com
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Subject: [PATCH 0/2] riscv: dts: spacemit: Add initial support for OrangePi RV2
Date: Fri, 11 Jul 2025 20:32:43 +0200
Message-ID: <20250711183245.256683-1-hendrik.hamerlinck@hammernet.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds initial device tree support for the OrangePi RV2 board.

The OrangePi RV2 [1] is marketed as using the Ky X1 SoC.
However, after research and testing, it is in fact identical to the 
SpacemiT K1 [2]. My proof:

- Similar integration in the Banana Pi kernel tree [3], which uses the 
  OrangePi RV2 and identifies it as the SpacemiT K1.
- Comparison of the device tree code showing a match to the OrangePi RV2 
  Linux tree [4].
- Locally tested the OrangePi RV2 with the SpacemiT K1 device tree, 
  confirming it boots and operates correctly.

Patch #1 documents the compatible string for the OrangePi RV2, and 
patch #2 adds its minimal device tree. This enables booting to a serial
console with UART output and blinking a LED, similar to other K1-based 
boards such as the Banana Pi BPI-F3 or the Milk-V Jupiter.

Link: http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/Orange-Pi-RV2.html [1]
Link: https://www.spacemit.com/en/key-stone-k1 [2]
Link: https://github.com/BPI-SINOVOIP/pi-linux/blob/linux-6.6.63-k1/arch/riscv/boot/dts/spacemit/k1-x_orangepi-rv2.dts [3]
Link: https://github.com/orangepi-xunlong/linux-orangepi/tree/orange-pi-6.6-ky [4]

Hendrik Hamerlinck (2):
  dt-bindings: riscv: spacemit: Add OrangePi RV2 board
  riscv: dts: spacemit: Add OrangePi RV2 board device tree

 .../devicetree/bindings/riscv/spacemit.yaml   |  1 +
 arch/riscv/boot/dts/spacemit/Makefile         |  1 +
 .../boot/dts/spacemit/k1-orangepi-rv2.dts     | 43 +++++++++++++++++++
 3 files changed, 45 insertions(+)
 create mode 100644 arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts

-- 
2.43.0


