Return-Path: <linux-kernel+bounces-847666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1037EBCB618
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 03:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C3474EE7B7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F7F231A30;
	Fri, 10 Oct 2025 01:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="MMdxdl7Z"
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A051DFD8F;
	Fri, 10 Oct 2025 01:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760061420; cv=none; b=VaRfNrfv/12jARThkq5Knb8uD94q3QUXhCRCpqxmR7GMbzDPIPpvRnURctGAOea6qDUhYMA+z8ZaO2+dUTWqYZYWpep2sEEjw2WP6Kx2YHiloyIT4ZqK2uY2TCRBXjFv0MKOHqEvSvrLTOAE0d0eEaKOknoDRJVjEyXqyqVA6Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760061420; c=relaxed/simple;
	bh=ooFfofg3THi0o3bPDJoZZmYqUSX500L5M3Ie3KTomQg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HxG+tpVIgceOa1b/vojI0Oie8jCQjHw8eRyKHtx1/FNJEQzhY1ZdjnQf+APanek0LDpGW7PaPlVpvjzXLJF9wLfYwUq5thxJfc0HhBHXJHc9/p+YPFZKK6eCiF7hSHgLqDMJhQHKaE35RapSFeyvqvx/fnDKCU/YH/LUyU8ulTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=MMdxdl7Z; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1760061411;
	bh=OcfVMK6zs5edwxTbccOuT3PYsnF5yyJeWpncUgVm7OU=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=MMdxdl7ZbsCoiGjddJwzwldr33tJhmoUT3EAwS6Cgg+4Mlr2Ln85ZxLFi1G6AgZ2e
	 YxB1XNvEjkMeUeAprPm7qh9G+yV5iTuaO1pukSmV642i4iZnqv0tb5tVbLAmlbRKem
	 MVu4pNhU+dOGVqXFrEAHiRJmd7YxtaozwBTv23tU=
X-QQ-mid: esmtpsz21t1760061405t7d47b63c
X-QQ-Originating-IP: matQ3Ugr3EH/fuWS18RWMCswPJQtU83D+PuIwuHwPXc=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 10 Oct 2025 09:56:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2672388393376587538
EX-QQ-RecipientCnt: 14
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Fri, 10 Oct 2025 09:56:30 +0800
Subject: [PATCH v2 1/5] dt-bindings: riscv: spacemit: add MusePi Pro board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-k1-musepi-pro-dts-v2-1-6e1b491f6f3e@linux.spacemit.com>
References: <20251010-k1-musepi-pro-dts-v2-0-6e1b491f6f3e@linux.spacemit.com>
In-Reply-To: <20251010-k1-musepi-pro-dts-v2-0-6e1b491f6f3e@linux.spacemit.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yangyu Chen <cyy@cyyself.name>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760061399; l=2561;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=ooFfofg3THi0o3bPDJoZZmYqUSX500L5M3Ie3KTomQg=;
 b=kIwAlm93xlsEZwNBaI+LdFvXe5v6i5CIHyps44SQKXhWutlsqYTP36ZX/hhk6r7LmK7OEKhYC
 vBp0C+cRH9eDkztNUawFEYuv7pJzc7K7QCzh90CUq8l5LdQmqwf2Y14
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: McQkEgLnGfKHzu8S9YBl9klno334JPzj50wFcTa0EQJTgPHDYwscCEzG
	TSPflaX5vaqphR+tOZdYszVZ9IGt4WiXdzu1/I+K/Ul7eB7LMMKU61sdjfV9rEI2+LZ+q1o
	yCBtaHsOieLnah4S8HNO5TvbpkGR70GikuNJvG2eR06S0xm8p1sM6Poxuk+aBQfT3JfgEa1
	PeImzczM8J+Zxg0whGzcJOe0YFB1iVQhotZS9CeLyVpa2JvmygDAFnJB//80jZ/zSA1BrOS
	CKoUvNH/RGBGb3c9Iq5ye0UB+bbbadNZ3EhTDuimjFqYoI8kL0vk7fnCSP5l+IsIpxdroIt
	tLr0KZsuFmjJ3/F9KoQmkdsIn0MyFeKpcA/z/XKo97uxFtjmQNqFM+1IYmcXE4s1VSc7zch
	N0V5L/TYO6WV2zH3zk27LMPEWK96S/4GU42ZmIfIPpLCjopdj4sNmGU9FqOOzwT9mhSHm6S
	H8OxUBe5V+2U1rg/IWsOXGOtGBrWlzQD1N4BWo794CLk7EdaQTNXc8MilWG2DQDa7sYN8Tj
	ApwEXLWriVabJc9X1JsqLMLn2m1L+PVRmAdCQO4uHvY75TnQrWFjEkFydyjWH2c/ug/KVpL
	CQDNwTFfAGiUOcP8aZTvfhCaYKEeWHQ1oNfDQGbROdijI/qfXY9hFIsxbcQOyiS2W0UAqpp
	S7dvi1lCf5HwB8FN2Qowecj6NEDosJjGdnrONtZy7UWtYBrjvoOpmjSEXW7vLjzTizU2Il/
	A76IZM2b9Zhlv8WgpP0SBSZSYljkV9Fd/tVHOxT740WUSl/wdVUtMurvn9gSd8JcF3F42dR
	KYadFGwClvfV2iO6WtceL4ZXK9r2wcaT0bgYPZOfVF+nTHrKqpSLHkd68vD181+EDhQpnYm
	mrg/5jfuzgZL2PP3OaFkpxcU2zZQNmShmUnjublNE1WJ9P5rIkAC2E+Yvk62yoGFLAxH0eV
	rQN7mali3VPsSaKkFvLi4iV59PxODkRB7qW0eH5thnVG9qwlOTpPcmoqbaHqRYA6/u/Tv8Q
	o5PBCMD9GW8yxDOMzAHDx/ZttQ+GFa141odBSbk1W+RqHqE1Lgh9gk74X/6/akKCWCz3GXn
	cmXQlgmtmtiv+aOKCcYAmVLjINjGn40ZEOvhTMe9HIQ77J7B96VREqjjJJryEVTDfKe6C40
	t1aIQKfJQYxQ5wc=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Document the compatible string for the MusePi Pro [1]. It is a 1.8-inch
single board computer based on the SpacemiT K1/M1 RISC-V SoC [2].

Here's a refined list of its core features for consideration:
  - SoC: SpacemiT M1/K1, 8-core 64-bit RISC-V with 2.0 TOPS AI power.
         This suggests potential for light AI/ML workloads on-device.
  - Memory: LPDDR4X @ 2400MT/s, available in 8GB & 16GB options.
            Sufficient for various workloads.
  - Storage: Onboard eMMC 5.1 (64GB/128GB options). M.2 M-Key for NVMe
             SSD (2230 size), and a microSD slot (UHS-II) for expansion.
             Good variety for boot and data.
  - Display: HDMI 1.4 (1080P@60Hz) and 2-lane MIPI DSI FPC (1080P@60Hz).
             Standard display options.
  - Connectivity: Onboard Wi-Fi 6 & Bluetooth 5.2. A single Gigabit
                  Ethernet port (RJ45). Given the stated markets,
                  this should cover basic networking.
  - USB: 4x USB 3.0 Type-A (host) and 1x USB 2.0 Type-C (device/OTG).
         Decent host capabilities.
  - Expansion: Full-size miniPCIe slot for assorted modules
               (4G/5G, wireless etc.). A second M.2 M-Key (2230) for more
               general PCIe devices (SSD, PCIe-to-SATA, comm boards).
  - GPIO: Standard 40-pin GPIO interface, as expected for an SBC.
  - MIPI: Includes 1x 4-lane MIPI CSI FPC and 2x MIPI DSI FPC interfaces
          for cameras and displays.
  - Clock: Onboard RTC with battery support.

Link: https://developer.spacemit.com/documentation?token=YJtdwnvvViPVcmkoPDpcvwfVnrh&type=pdf [1]
Link: https://www.spacemit.com/en/key-stone-k1 [2]

Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
Changelog in v2:
- modify commit message
- Link to v1: https://lore.kernel.org/all/20250928-k1-musepi-pro-dts-v1-1-5efcca0ce3ae@linux.spacemit.com/
---
 Documentation/devicetree/bindings/riscv/spacemit.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/spacemit.yaml b/Documentation/devicetree/bindings/riscv/spacemit.yaml
index c56b62a6299ac24d3cdef7edcdfc407dc62a1846..52fe39296031f21d1c28c4f1ea5ca9fe28caf45a 100644
--- a/Documentation/devicetree/bindings/riscv/spacemit.yaml
+++ b/Documentation/devicetree/bindings/riscv/spacemit.yaml
@@ -22,6 +22,7 @@ properties:
           - enum:
               - bananapi,bpi-f3
               - milkv,jupiter
+              - spacemit,musepi-pro
               - xunlong,orangepi-rv2
           - const: spacemit,k1
 

-- 
2.51.0


