Return-Path: <linux-kernel+bounces-843479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B397FBBF8FD
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 23:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA6864F241A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 21:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532362DF130;
	Mon,  6 Oct 2025 21:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dk+2ogom"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A895D2DECB2;
	Mon,  6 Oct 2025 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759785714; cv=none; b=E7KFE8wLBwfFWdiWb/HEN7qR56Ux9DI4O4/dlfrFU+z+7ILxehKMWiITADQIEQCFzIrs0p2lxZ/RYxFpL61kS3mj0eDXTTca1FBLbSFtHfcyQVHv8amvPAqrM8nTGj/lSGdWZVyfTaj3T9FSPhaBttU0boFambNFgJg8uX2eOdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759785714; c=relaxed/simple;
	bh=gNYHshhPBkImsXhFnyujnboGbeZdrhN0P9KOe+5Jyoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NM5KrGlD8Nnm1g9ImhrOsX7wEWPPhIR3UwjPRQbXk0jnpGsk6cRgy4d1LR8HmiQ3qMyFpvHnAbW6y0vWwXLNKJ4flqE+fU8klMvocpmGj++cHQV1hBWrQXTVVUAdSr08xQcYjj/7t+gaAx8zhYUj0r8e4SHzQ1CQl1lOZS2MJ6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dk+2ogom; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFF8C4CEF9;
	Mon,  6 Oct 2025 21:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759785714;
	bh=gNYHshhPBkImsXhFnyujnboGbeZdrhN0P9KOe+5Jyoo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Dk+2ogom/We9ws2EhoF0IVBKqHawSW2TzCmIOf45bhuE4NKjyHhtjJbRyvaOJVBLp
	 DIpWF1HJlJKpEdHe7kas2LGVU5hgOWbMJe+uFLkQ1Zy449LaU+JNrEpJUb8FoI/WnU
	 u1eS8eixwpBqN7F8t9JWVL05igOPJzaDNUVAV8wAgjhOXfyhGVE+6krlLTii8+PaSe
	 QG0N6Lj/+LB6otH9uf3LWPvXA+6XdVXhdqyTERxG7UUvwu9+4k25OlbdNmHpkorFlM
	 xTazwdieTjzqKdbEt9eWec01jeTD2KrDnYqtCmtZCTh3jT4bZOr2JnbvzI1Ec5iPA+
	 Z4i4VoVj0EABw==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 06 Oct 2025 14:21:44 -0700
Subject: [PATCH v2 4/8] dt-bindings: timers: Add Tenstorrent Blackhole
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-tt-bh-dts-v2-4-ed90dc4b3e22@oss.tenstorrent.com>
References: <20251006-tt-bh-dts-v2-0-ed90dc4b3e22@oss.tenstorrent.com>
In-Reply-To: <20251006-tt-bh-dts-v2-0-ed90dc4b3e22@oss.tenstorrent.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <anup@brainfault.org>, 
 Arnd Bergmann <arnd@arndb.de>, Joel Stanley <jms@oss.tenstorrent.com>, 
 Joel Stanley <joel@jms.id.au>, Michael Neuling <mikey@neuling.org>, 
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>, 
 Andy Gross <agross@kernel.org>, 
 Anirudh Srinivasan <asrinivasan@tenstorrent.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, 
 Drew Fustini <dfustini@oss.tenstorrent.com>
X-Mailer: b4 0.14.2

From: Drew Fustini <dfustini@oss.tenstorrent.com>

Document clint compatible for the Tenstorrent Blackhole SoC.

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


