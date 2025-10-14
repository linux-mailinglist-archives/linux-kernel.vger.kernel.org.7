Return-Path: <linux-kernel+bounces-851730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A2196BD7273
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B3704E8969
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC95030AAAF;
	Tue, 14 Oct 2025 03:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBSMJhPF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFB0309EE1;
	Tue, 14 Oct 2025 03:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760411543; cv=none; b=ACTvJuXf4XO95lGVTTRRYbiZjd0ZiVQYA5Bb9jt6E/kOBH9aE2a4sRmV2WZljwOP2OEvortX8hYR2w1e+DNw8rRvYEml89k6sNiNmvj1NXErWcF/zDW96qLDSGcaS4mPpN/QBjx9BgliA/tKuCvJAmNJmVLZFGkQ81qqsr3Qws4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760411543; c=relaxed/simple;
	bh=j9X472dW2iFwpfv+A20bQZEA0DzSW/GeyjVodG/znv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j0T0rw5xClxwcpgaLh0w9btd3fxPBDUn4Gxu0rFVyy86ZpuLSWhnRqoNXMEobHLCfTnL7xleN9DDnWJcRYzI7+lRwWvTs3YajnNiiT6DhfkHEDTRTNs5J/2qST+sKuK9iZctISpVZsIVtFFYsRyqaqRIXfbuCzsr4JCGj2a16pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBSMJhPF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FE1C4CEE7;
	Tue, 14 Oct 2025 03:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760411542;
	bh=j9X472dW2iFwpfv+A20bQZEA0DzSW/GeyjVodG/znv4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FBSMJhPF4vCsfUMw2aLk4D33i8Emf8p2R3njahEelGM9lmjKgWXjWqcZ0qZxL6wMH
	 DjFHwDiSqYS6EyxyaL8HTQnJTyT4j3S6B35LLXOrP9qsgvEyIUBdEp6kH0Nerae392
	 mCdU2KV4yGYz5N4KPriQfKMpyp+ga3Ung+QKLiGQc5Q63v8inO5LbjjUH9M/AB0nR+
	 FlP1yPVXcFauS6SfcgJDoGJsicAPdtqKlT0xMJQ8Rbben/ZrQbZegUiNN9wag4Yb2g
	 i9ZG3jWac2X+2kWbjHPp0OpOiML3O88PPsuQn1jKNarr6tpwCyl01nz/mId80Olrdq
	 t/shfZbMLcZZQ==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 13 Oct 2025 20:11:56 -0700
Subject: [PATCH v3 4/8] dt-bindings: timers: Add Tenstorrent Blackhole
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-tt-bh-dts-v3-4-9f058d4bbbda@oss.tenstorrent.com>
References: <20251013-tt-bh-dts-v3-0-9f058d4bbbda@oss.tenstorrent.com>
In-Reply-To: <20251013-tt-bh-dts-v3-0-9f058d4bbbda@oss.tenstorrent.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <anup@brainfault.org>, 
 Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>, 
 Joel Stanley <jms@oss.tenstorrent.com>, 
 Nicholas Piggin <npiggin@oss.tenstorrent.com>, 
 Michael Neuling <mikey@neuling.org>, Michael Ellerman <mpe@kernel.org>, 
 Andy Gross <agross@kernel.org>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Drew Fustini <dfustini@oss.tenstorrent.com>, Paul Walmsley <pjw@kernel.org>, 
 Albert Ou <aou@eecs.berkeley.edu>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>
X-Mailer: b4 0.14.2

From: Drew Fustini <dfustini@oss.tenstorrent.com>

Document clint compatible for the Tenstorrent Blackhole SoC.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Joel Stanley <jms@oss.tenstorrent.com>
Signed-off-by: Drew Fustini <dfustini@oss.tenstorrent.com>
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index d85a1a088b35dabc0aa202475b926302705c4cf1..0d3b8dc362ba7e8d0ca6d0cea692ceddc5e1f89e 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -36,6 +36,7 @@ properties:
               - starfive,jh7100-clint   # StarFive JH7100
               - starfive,jh7110-clint   # StarFive JH7110
               - starfive,jh8100-clint   # StarFive JH8100
+              - tenstorrent,blackhole-clint # Tenstorrent Blackhole
           - const: sifive,clint0        # SiFive CLINT v0 IP block
       - items:
           - {}

-- 
2.34.1


