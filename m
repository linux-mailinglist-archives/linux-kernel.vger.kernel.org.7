Return-Path: <linux-kernel+bounces-815365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 951F3B5634A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 23:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F351B24E00
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 21:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD13285CB2;
	Sat, 13 Sep 2025 21:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkBw5ZPO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460122848B3;
	Sat, 13 Sep 2025 21:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757799066; cv=none; b=kAdI+fMAEVJsBDO3EaNLSGl7MP16PdPIxTwDvl5ijHJF3dTz/5cgvV6dM7Xs8h8Soq6bfG7Ofo2PvgzxEc74+sYiKlmq9JpPdwkAog5OcGHal2p0fgVo5piSmEoAvg7TAMfWyWAcBYREYsDzLiPbOxN2ZIm/0P0nLjPdhNYdkLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757799066; c=relaxed/simple;
	bh=KWeVzBb2k7TISyEOWMEPtUUbf6En7nS4bmjdkluUFOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lPmgq4PMeGzoj3VePZHEn6jq0eg6fuIswtQrzzCiZxa8tkOPbfG6vyIl/dbokqVKjTWCWLljsn1a9SzprADzxuJ98/84Jn2LcgPfWHYQo1AkUdOZ0G4c8aVBf9gl1XYs8eVa/x/xY5qqnCvJvZWMV71GI5hWKNbnqnrSVoJwGUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkBw5ZPO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADDDC4CEFA;
	Sat, 13 Sep 2025 21:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757799065;
	bh=KWeVzBb2k7TISyEOWMEPtUUbf6En7nS4bmjdkluUFOo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LkBw5ZPOz2Mjr4ispAEQ2XM17AuZf2AhRSngYzmp4DwRso3D2XsgIEfodRIUbubTT
	 a07qCAvwkJoNybyy7C8zguGhCXSzD/TOzVa0Eb+SHwjw4E/qPLCd44X4eIB5OUtTIk
	 S6/MajvD9FJtWfd/LVDuCYjfOG9vgUtuQagPdrcD7YNecESGeFX2UeOHXGhKSzOoeM
	 slkludN0tEGGpdsr2XKbMvIo1Au0u5VL2qIu863gaosgluf4HmYuIFuQEYmplXAV+p
	 0aPUNJaJD2878chpcd9bCBl2mRAm4R1kMUuYrfl4T1+FBdqiEjdSVoChNpNi+2wkES
	 12ebWe64VhZQQ==
From: Drew Fustini <fustini@kernel.org>
Date: Sat, 13 Sep 2025 14:31:03 -0700
Subject: [PATCH 4/7] dt-bindings: timers: Add Tenstorrent Blackhole
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-tt-bh-dts-v1-4-ddb0d6860fe5@tenstorrent.com>
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

Document clint compatible for the Tenstorrent Blackhole A0 SoC.

Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index d85a1a088b35dabc0aa202475b926302705c4cf1..198146c59de0c95a2ffa052c8d4d7aa3f91f8e92 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -36,6 +36,7 @@ properties:
               - starfive,jh7100-clint   # StarFive JH7100
               - starfive,jh7110-clint   # StarFive JH7110
               - starfive,jh8100-clint   # StarFive JH8100
+              - tenstorrent,blackhole-a0-clint # Tenstorrent Blackhole
           - const: sifive,clint0        # SiFive CLINT v0 IP block
       - items:
           - {}

-- 
2.34.1


