Return-Path: <linux-kernel+bounces-866391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1A6BFF99F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE9D1A06DF3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3C9DDC3;
	Thu, 23 Oct 2025 07:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="fsdjXZAQ"
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7C52C033C;
	Thu, 23 Oct 2025 07:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761204541; cv=none; b=KaLZfblQvgmNb6TAT3OHirUeekKepGrR/7bO7LUjnQeoBJ7K4BgHSf/On+uPOeWLUfRQiCLlp8cG8TKhMqSChCbHFutcI9CUvPap+S3y+7M73ZiA26/cvWE4GMuTV562S/L1Kkl2BLXsELChy+4gGnnIdTqRxfpfATGoe/CYfLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761204541; c=relaxed/simple;
	bh=E+A7wuUeuxnJYXGw4LkRQNLqLgFKjZDXDasWjCBR6aY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rKvyPg8uOT71TFdg9jAOqu5VjlJWdul4IAMlWS8EGWMKvcmZvT92kfYApDkaP0aUgtEk2alJ3tS1ZRQ1fTxI3f7tC/hQijhpqIdE0DAbUTJBYPDKebNw9VJWP00yV4ivzhzBCge5XoFZJtQodZUr+uNR/cMDGjtfKoGGUQl43SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=fsdjXZAQ; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1761204520;
	bh=H6QZKjoMtGBy7I0nkn1HtRcweYYIKHGgR3xO60z4zbs=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=fsdjXZAQ+PA1E8Z700eRVa4rMyonJE6Xda5f+bteTFThmsB+7TgH4MR2j7RWaRtCd
	 cpeQmhyY87e2mw4e1fX+mANxkUUAOtOgt4byTTFHb1nQTE3UC+4+j+7Biq3lC4fohU
	 0tTt8jQortYkkvxM4VVVlOkRV4tOOKeDAMUV2pbE=
X-QQ-mid: zesmtpgz4t1761204518t0d7a9e4d
X-QQ-Originating-IP: LnN7Cm0YinMJ+d/RpIL+6LqoDO37Lx78zyP6Ulb1mOE=
Received: from = ( [221.4.210.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 23 Oct 2025 15:28:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3060325782525358583
EX-QQ-RecipientCnt: 16
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Thu, 23 Oct 2025 15:28:29 +0800
Subject: [PATCH v4 1/2] dt-bindings: riscv: spacemit: add MusePi Pro board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-k1-musepi-pro-dts-v4-1-01836303e10f@linux.spacemit.com>
References: <20251023-k1-musepi-pro-dts-v4-0-01836303e10f@linux.spacemit.com>
In-Reply-To: <20251023-k1-musepi-pro-dts-v4-0-01836303e10f@linux.spacemit.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yangyu Chen <cyy@cyyself.name>, 
 Paul Walmsley <pjw@kernel.org>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761204512; l=2335;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=E+A7wuUeuxnJYXGw4LkRQNLqLgFKjZDXDasWjCBR6aY=;
 b=+yTZnxXcZwl7axhHvCa3Cmh92C1T5/aAVSBdTsyjuP8AKY0oOhPMc0GPiPzYV1QUD9x/DURd9
 KWieK8hvmfMA5kM75FlXIZmDRsnXbc6T0HvZxBJ93ZIfH3pp0qv8fKi
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OVH4KwRWo4QxVMVuTJVSBb3pMYkV6kcm8d79b9x4tJq2SJXWXZn7FMCP
	wv8SZvSJ1yR7UwM73QOLFQ2vu+fBnwzdNznXHf+X+BLFVlb3Tk8RcpTcuhPxl+7R8vtedSj
	kppeQjBLD6h5xVYtHqw7rSWL6Zlnle3s8GhHrQF5YjFCBS7s10A5TQrFDilN7yoRtJ9ZV96
	iBsTbnbOPRX2SumYYIzGheVktMPJsQzM8GjiN+dYiPfD3wJFSm8peeFS28usBjlw9J0hJwm
	ce3XOUvtkYvM36j+3Wxc+MIsDfxQk7OMR/b2x+BMQyIZS4JdfAA76KuvHgFU74ItFtdYg99
	YWED+jILcbGFwtYAbe0Fr5UIp4RAtzhsQm++AY3DXjXkV9IWPrlp9akPYrR0QDYHvWh07Nu
	GR2gAf2Q8fYvtcACE8wwbC2vWvL7YlVkg6nYhKC0R4FY6YV6SBcX0W94t+QHvy12BakvR0/
	IJPD4p+aHYouoQY4+3jCjVD/23L6Di33+DTWpGdocLq/p95ma5Zy/oBu+TSuDHbG+T/6sox
	DQ8sF6Q2/ZE5Hw1abKy/dJUcVLoD2COKPBgP0YiRWaCapmXZfSDlc2xY/iFvNsaMDl/Bgku
	Wk9/RfA3QbNYpyUyc7uNZ1s3egyD+rfa7oAgvP/Y9Qv0Ub94Uk09SBbuotJgG4nB/y5G9gM
	mi+p5P0z3kZl4u3axec1oQnfvz6QVbLo2Zhd82KE8fYFx4Ev2ZWGdC9mYVGuU77F7Nl8jcb
	HxmrocHfQsPiP1Gn+qs+NnvLJl/sHzs0bKfrG4TMrJG/LsZmkRvYURuOfWsnwG5BfZoEluy
	eNWF7W6wPBTSx25UYHXyTN6nBegAsLK3flYai1Y0HzT+PwuuRhC40ORgQ16n6Yq6YOVmrk1
	x6OwXnbukrC+8lvD4XsSM9dKpl33CS60UPNzPmon9sIkAIKNv6+/dobfmx71xQmHeUhdvWL
	5sKR0PHJxyUX5cLm6K/51WfYg5cfrGjHo5ZBWZ0+YXUWy/FOM4M18RTSpUv+h4XzO3pG4Io
	XeKPM0ucE6BzOl7qdwiZZu07iXwlvhTxpirc14ISNbTNeHTMe5My0GV4c9pdA0cPLQgAoXr
	NpARMC7h57cGNfVrqHuFvsRO3QRLbJieqSYjPOZ8xaL7XVrBfTZoxVGBpVsemqyuWZ0lyYu
	PJGn7xkX64we4vG4KNbxH9Gppg==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Document the compatible string for the MusePi Pro [1]. It is a 1.8-inch
single board computer based on the SpacemiT K1/M1 RISC-V SoC [2].

Here's a refined list of its core features:
  - SoC: SpacemiT M1/K1, 8-core 64-bit RISC-V.
  - Memory: LPDDR4X @ 2400MT/s, available in 8GB & 16GB options.
  - Storage: Onboard eMMC 5.1 (64GB/128GB options), M.2 M-Key for NVMe
             SSD (2230 size), and a microSD slot (UHS-II) for expansion.
  - Display: HDMI 1.4 (1080P@60Hz) and 2-lane MIPI DSI FPC (1080P@60Hz).
  - Connectivity: Onboard Wi-Fi 6 & Bluetooth 5.2, single Gigabit Ethernet
                  port (RJ45).
  - USB: 4x USB 3.0 Type-A (host) and 1x USB 2.0 Type-C (device/OTG).
  - Expansion: Full-size miniPCIe slot and a second M.2 M-Key (2230).
  - GPIO: Standard 40-pin GPIO interface.
  - MIPI: 1x 4-lane MIPI CSI FPC and 2x MIPI DSI FPC interfaces.
  - Clock: Onboard RTC with battery support.

Link: https://developer.spacemit.com/documentation?token=YJtdwnvvViPVcmkoPDpcvwfVnrh&type=pdf [1]
Link: https://www.spacemit.com/en/key-stone-k1 [2]
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
Changelog in v4:
- modify commit message
- Link to v3: https://lore.kernel.org/all/20251017-k1-musepi-pro-dts-v3-1-40b05491699f@linux.spacemit.com/

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
2.51.1


