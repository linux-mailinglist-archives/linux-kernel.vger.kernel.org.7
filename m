Return-Path: <linux-kernel+bounces-781009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D04B0B30C4D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 05:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC74A6058B5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 03:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A4E27F74C;
	Fri, 22 Aug 2025 03:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="kqxwAYqf"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6423827EC7C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755832026; cv=none; b=INBzYSQgHI5oT6kyerRW/r13n/3l1IStTTb9CtJCKoa5Qpdcdih2hNWJraFkY99WpFRt8AfQz+TPOiCeO7GmEfGGCRLRcpTdB+yy+hdCOv7Ycl/65WoWCmIWliC3tMG76fSS3gcsWC4m/r4RdI1QlmjSWeleqtYN3392p2QZIVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755832026; c=relaxed/simple;
	bh=cFrWQEEvMc/7ZId6uak27PuJOXHlyYH9+xN4BakqZpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j4nX/0u98q63iPEz9pLkYkokz54PtZ0LmV5NTNYWFfsEzsc3s+M3BGwBCWVkhP+7kl6oQ+zxilVsW1jYs2mPTUzv7r3AMdyiyBF+0fveOJ7dtFkmCcevbKNwue97ggsSt2IwcjFCc4qAVwrUD909o23vUQkWFm7gQap9UZ7cV4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=kqxwAYqf; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e2e6038cfso1988630b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 20:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755832023; x=1756436823; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZudeS21S7Z9HKYl2WwDLHxu+6vkPHg6qhFAwHt0tdNs=;
        b=kqxwAYqfBHgQ+JJwAUosXmJYFt2MWianOW0QzPwGqRmtycDq8U1CkUom4Xlm8h92M1
         hVlE6rjaHeTpgjRjHiAf2CxZnAFQXkvnRibp6/vVG41wGGKLmB5SAXD+I0JMq1zXqrxF
         RJ/taYk/h2rV8qrhhA2LZdW25pv+jY4gx0s4ZHmmpkNVi5IcwszB3oxVouOuk717fOu/
         7EwpRSfyotgKGzqxW1W4KNNjtST7hie0v3/P86VCUelODnd42RKVQTvch+aDOLuQHdOs
         NoMm/X9mAL3HDMuMwjqKjb4SV2yoDrT2PQ/YJaAsEcPVJF5LarrGkRiy7cSmD2JqyVDm
         npvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755832023; x=1756436823;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZudeS21S7Z9HKYl2WwDLHxu+6vkPHg6qhFAwHt0tdNs=;
        b=UAvQsGm6jS8gOi7rf8DkHpeOTXzPiExROVGNk0QHlcZf5HMsm+S7n5ncodJFd/7WKm
         FoSt/je0zqc66uZxYpGCDdYMmMfRzCFj4dzaaXqvquM8RmMXVJENIxmxZs9XE8hecTuI
         H2ftmZCyt/mkSQGKcs9tFkZJMx1/0umRaYKDSqN7MVcHYRZpCwpBD/j7XnmeDrKvbyzj
         8kR7p939aqhP5May/ZBbe77s2L6copmWDHE1AaaNalOQboNHb7Tnj0/A29WjnM1O2zNu
         e/QGmbA4OLl03yuG30R78iSdvzT3Tz/hUpWls0WjjnQRadjJOp/d7d8x1FZ2jMcA00Ab
         hpgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXEra3MfiaoCqw0Qf0shHjVuzonBpH29hHgX02JsDOaj1Y8ya8+eUnHZNsWhrzlBE32nZvKpNHEpp5EPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2c1nT9oHfBaEcKb8Zoxll0qHtXmCzXLE3O55ATyRJ0JnJnqmZ
	CKLvtHl5ltoplkjggipYb+F0zmZSadxPH0al17LeTzFHLrcrG0lgaScRYaLYfs7SE4O/iFUlXgh
	LSBfbE0VGFWHQ
X-Gm-Gg: ASbGncv4leSdVqSuGQc0nwd6Ow94ZudyFohzDqfxyQMUK33NosIBdjzV3ETI4r6cgBU
	jqUEfs0TJTmPnwiknAlYV2Gc/eiacMfB5wFpxOeszDU4EpAsgPeWbqcE82MoP/NRL8M6QsWF8R4
	/hZrAX9OqqNQKsSASbg9jtmCdXqSdNn/5F+O2Tr3ymxrlrvO8K/cA+N5af7gUZenUKVD9mX9dGw
	hC10NNKb3tGNqlCefCwmPOo2nLWyEbMK9gPiauECKe3OcVVNKIOnkMtdgCj0R0iypM/L227tRHb
	Cnc4D4upciHzV8COA/xlpDhRz6eJ4l7GwdRbg+ePt4aDiHyv/fkaFVE1hlUKRqUy4i0ILzix/qD
	3HsUPvQUH5FW+BSFXdC6byfN38sirvmDlx5ez8i27dsg3
X-Google-Smtp-Source: AGHT+IGm4j2NRRY1FzjfoUSGytYiPyWd0cIxjX3x+KRIkqu4iEC4XXZhVq4VrVHDhxiZRilFQYwnKA==
X-Received: by 2002:a05:6a20:6a0b:b0:240:489:be9c with SMTP id adf61e73a8af0-24340cd3104mr2211058637.39.1755832023564;
        Thu, 21 Aug 2025 20:07:03 -0700 (PDT)
Received: from [127.0.1.1] ([222.71.237.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47769afc1bsm2756777a12.19.2025.08.21.20.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 20:07:03 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Fri, 22 Aug 2025 11:06:32 +0800
Subject: [PATCH v5 6/8] riscv: dts: spacemit: Add PDMA node for K1 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-working_dma_0701_v2-v5-6-f5c0eda734cc@riscstar.com>
References: <20250822-working_dma_0701_v2-v5-0-f5c0eda734cc@riscstar.com>
In-Reply-To: <20250822-working_dma_0701_v2-v5-0-f5c0eda734cc@riscstar.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, duje@dujemihanovic.xyz
Cc: Alex Elder <elder@riscstar.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Guodong Xu <guodong@riscstar.com>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.2

Add PDMA dma-controller node under dma_bus for SpacemiT K1 SoC.

The PDMA node is marked as disabled by default, allowing board-specific
device trees to enable it as needed.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
v5:
- Add reviewed-by from Troy.
v4:
- Rename the node from pdma0 to pdma
- For consistnecy, put the "interrupts" after "clocks" and "resets"
v3:
- Adjust pdma0 position, ordering by device address
- Update properties according to the newly created schema binding
v2:
- Updated the compatible string.
- Rebased. Part of the changes in v1 is now in this patchset:
   - "riscv: dts: spacemit: Add DMA translation buses for K1"
   - Link: https://lore.kernel.org/all/20250623-k1-dma-buses-rfc-wip-v1-0-c0144082061f@iscas.ac.cn/
---
 arch/riscv/boot/dts/spacemit/k1.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index abde8bb07c95c5a745736a2dd6f0c0e0d7c696e4..861f0fe18083fa158da51bd3be2808609f6233f4 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -660,6 +660,17 @@ dma-bus {
 			dma-ranges = <0x0 0x00000000 0x0 0x00000000 0x0 0x80000000>,
 				     <0x1 0x00000000 0x1 0x80000000 0x3 0x00000000>;
 
+			pdma: dma-controller@d4000000 {
+				compatible = "spacemit,k1-pdma";
+				reg = <0x0 0xd4000000 0x0 0x4000>;
+				clocks = <&syscon_apmu CLK_DMA>;
+				resets = <&syscon_apmu RESET_DMA>;
+				interrupts = <72>;
+				dma-channels = <16>;
+				#dma-cells= <1>;
+				status = "disabled";
+			};
+
 			uart0: serial@d4017000 {
 				compatible = "spacemit,k1-uart",
 					     "intel,xscale-uart";

-- 
2.43.0


