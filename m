Return-Path: <linux-kernel+bounces-815364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CC6B56348
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 23:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A113A65D4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 21:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2A7285073;
	Sat, 13 Sep 2025 21:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MX80Amck"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A969F28468D;
	Sat, 13 Sep 2025 21:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757799065; cv=none; b=HTcqTy7Mih4pkfiFIOR2QQXHtL1j+W8oZ2G2m7KJUv8oYXeDUTfT28u1YIFNpX5Sa/vL+QwGPeTmFHbbcoZ3mo9EU4E8biVskSYQfknWCmvcGXgLAt5LUiCgXGcJKaBz7fSplGRGacYHySfuJdM5phgje4k1eMSw8iZrv8cR2z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757799065; c=relaxed/simple;
	bh=dAjXCByJWDvW78TjUkKWkwaKt8o8TeBgyz4QQntn2Hs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EkBZRWPs3seSN/tewgt35RpXo903OGpojjXXK7YR8gruhKF+OyztRvu/UFTUXw/2obUZKP9+Ps0b1WGEyXVRP+x8YEjzGvmxd6ig6J4Yc1Gsm0omLNz9mgYObLwOFZ0q47aA1QHKiW733srryCPokDZD/leaKrE091gNsQMsEu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MX80Amck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99128C4CEEB;
	Sat, 13 Sep 2025 21:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757799065;
	bh=dAjXCByJWDvW78TjUkKWkwaKt8o8TeBgyz4QQntn2Hs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MX80AmckTrH9jVOS/tTJYepLYhpVtMhI/Gf5RCGFOJ/36AZKs67cAps5S+FcuzYAH
	 FIKllea9sQ513gaY40lqu58t42iRrA4k35ObCHMGHcgSFfI4xfqI//X/KicBKk6mGj
	 EGEKWKOj4njLkqMm4rGdqiH6/1D6GFgYU9H/Av+O3vWz10+qu1MV4k557hs8mm/+/i
	 Z4owwXlFMl+smrrfSOP9wVbfI9dVqB25cxyf7vvxOkIYOEpnWFKLeMIyZiCHdLvQtI
	 Wd4JqwqZqS1cnG+DpBCUHax8SSMSPRN16ESfRLhbXehZQnQInOW4HSUwkVDHToj/RN
	 jhaHP2GdLjYAQ==
From: Drew Fustini <fustini@kernel.org>
Date: Sat, 13 Sep 2025 14:31:02 -0700
Subject: [PATCH 3/7] dt-bindings: riscv: cpus: Add SiFive X280 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-tt-bh-dts-v1-3-ddb0d6860fe5@tenstorrent.com>
References: <20250913-tt-bh-dts-v1-0-ddb0d6860fe5@tenstorrent.com>
In-Reply-To: <20250913-tt-bh-dts-v1-0-ddb0d6860fe5@tenstorrent.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <anup@brainfault.org>, 
 Arnd Bergmann <arnd@arndb.de>, Joel Stanley <jms@tenstorrent.com>, 
 Joel Stanley <joel@jms.id.au>, Michael Neuling <mikey@neuling.org>, 
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>, 
 Andy Gross <agross@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Conor Dooley <conor@kernel.org>, 
 Drew Fustini <dfustini@tenstorrent.com>
X-Mailer: b4 0.14.2

From: Drew Fustini <dfustini@tenstorrent.com>

Document compatible for the SiFive X280 RISC-V core.

Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 1a0cf0702a45d2df38c48f50d66b3d2ac3715da5..bbc3886282dc5e8c53e54c0acd91608b443f590f 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -69,6 +69,7 @@ properties:
           - enum:
               - sifive,e51
               - sifive,u54-mc
+              - sifive,x280
           - const: sifive,rocket0
           - const: riscv
       - const: riscv    # Simulator only

-- 
2.34.1


