Return-Path: <linux-kernel+bounces-857315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E00BE67F0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D96864F795B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 05:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5CC30F53A;
	Fri, 17 Oct 2025 05:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="l+tfON4w"
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DF930BB84;
	Fri, 17 Oct 2025 05:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760680414; cv=none; b=oghMnsC1T3wWHCmystDiO14DuRQhKCwFGowX85NtB8lUyC2bWbZc4qzIL4mGpkpyHAWrVABG5RsjC9ZPeKxfWPjjaaDbRaYp1GZ0OKLmJ5uyfXldubZUVvmiM8Fs5ClrplP6G7gVoh2Ge3rOU6wvvoF55+E8HhMDC7lUqTmMCeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760680414; c=relaxed/simple;
	bh=ggfldOZp6UqSPiWVLfdG2BN5nof3l2DKdbnArSTVoxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m8ReOgE5+7h9pqHsZ2WfR2AMX1t9/VusTkicjMww4mgwRwCQWChD1wa7SaODaVF7uhj32qT3XFabZJg2g5wXX6dV16EZAuUcRR01pruim/0qDLjyEupIxvU9+HIWaZLU2TNB3uwNmNVxo54MQz+CcPMpE9xqwSLOpb74YfizhMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=l+tfON4w; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1760680396;
	bh=XsTLhqCdKDoQzfpCqi+OYz0Cka5ZsvI3BAFjhZzu0Ys=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=l+tfON4wT/A85M0Pi+PsUIOAcRdMmgZFoyBm8fFyIfHkGdHX/OA61DwVkcSqY5s42
	 5p9d/WIvmqtkFvOVnNtGeSaPBxjnxwXCqoCZIkgu3MjEV/V7kNf7gRnbmXXgGj+zVX
	 EOReFjg33TsACFLiHa58OSFNmrDBv6bnYHNS/pPU=
X-QQ-mid: zesmtpgz7t1760680395t7c42356c
X-QQ-Originating-IP: i/pMjErODknrB2ZwyCDEP9eFiO76Pcsvza8xazFbIfg=
Received: from = ( [14.123.253.52])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 17 Oct 2025 13:53:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6053374135582174828
EX-QQ-RecipientCnt: 15
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Fri, 17 Oct 2025 13:52:25 +0800
Subject: [PATCH v3 1/2] dt-bindings: riscv: spacemit: add MusePi Pro board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-k1-musepi-pro-dts-v3-1-40b05491699f@linux.spacemit.com>
References: <20251017-k1-musepi-pro-dts-v3-0-40b05491699f@linux.spacemit.com>
In-Reply-To: <20251017-k1-musepi-pro-dts-v3-0-40b05491699f@linux.spacemit.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yangyu Chen <cyy@cyyself.name>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760680388; l=2753;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=ggfldOZp6UqSPiWVLfdG2BN5nof3l2DKdbnArSTVoxw=;
 b=U91dtEZUz4Wvsoh2IA6c9a85w7dKye38+YtHxSDPuOKC8QvVm9TXO2U0mCS71DhTLBIt1isSJ
 jsL0vTMT/zvBq5td0hDVIFsVQkfiuJrU6oJx6kR/3mDJzpZxd6+wgxY
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MmAUmC4V+Z2AZ9VGQzux2D6zdwTNeDLvvonBI/0iupHrRXLDJU/ZSwa7
	0E8+3l4CX759qMwXIBts8HCFrYqwNc110SejVzFaJTsMwBbCsXG6O9HwvqoleRQVPzbRag6
	J45/Hqe7aWtD6gcTGaaZSQl8IG7fAKq+wLA68XDMRK1l7mrxLbGS0E4Y88zKxAndBKLt+ZF
	OxRZVmYxOff2jyiguOO0IL5kGnVtI5hFkG9vAK34GTJF68BUecIhLh6hWeuQG82JtXUsCiT
	GkF9qUf/ZCOfgc1+yXA8jhpVgKsxpV7sldVPMKCxVmMAdGphMZgHF0aN2Oq/vo/3e40+1bu
	qKFZTQSu7hE9YSQLmdN6de3lmovc/tTqXLFHZvAXfsZWsgpFoyMq1U6qDXNDj7voAMdC+kR
	VH9b3c0WV681JYzS2N3DxWdyoC2udLADL5hNpfeDOH4KJn6xw6yLsoHOTMe3KAPOnc0ZSbv
	40l6Ohay/C/1MIShlrRtnVANsATmUF0L7cdwn/y9hHJItsH3yHPm+6042iO6y+5R3ZOPF8G
	hBl8btrCINFrjMFoQlRB2YZiQe9w7a8SPeiJ/i80TNC8q+CbCcYp3F1t/Pfl0YD113BrDve
	J5IhNUnhHcActHASoT4taK311qZBjCr+o4fkXu/ez+2PePgTCbTi69wT8iYlDBX6bXPlope
	MxhNxpWut9XplIlw2VpxdSXTPCMB5yg0CevZtYze3sPRXX+1lr47UBMy71ekGL5Kixl8c2/
	3kB+8FatDlO5WeK3ZV1ZkLsXW+gYaMlpACDovtUoKjkPmiREUGwBBUCIv5xjXkYuv36vNrp
	SxzJZiYUKmbb37o4QELlXUcIVHJ9QkqMS/bFhqIhj6Ic19c6BSxtKPmZFOJ3Ul8Zc6xsJnH
	jgib9P0ynYCH7zW2gntiYKoUHFXmla8E5Jvk9PQcQ54RwT1bj/M36ATRwd5Ep6ICfe05zKU
	+bFc7eUP6Yjp3vopMyyReOz4C7FwQcSUhIZa9JZ84B4jeLEOnnQXyPm8lZyJi2Fb14vPNdD
	2x7j/GwlbpFljlgax/QI8b3ccmPIxD01AFDl6JbDLjLhzxHW3bvebxIJT6ficXNwVT/a8op
	im8w+n2STOk94mWn7wPhr9OFdtOpUq17NLDLIwuc49q+ugqwHO94CGbcj2SIFjufrO+HkTj
	0eFj9FMHEKQteR6+tMA1+8HNy+oie7bcq+Za
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
Changelog in v3:
- nothing
- Link to v2: https://lore.kernel.org/all/20251010-k1-musepi-pro-dts-v2-1-6e1b491f6f3e@linux.spacemit.com/

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


