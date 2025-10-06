Return-Path: <linux-kernel+bounces-843480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F36B4BBF900
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 23:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56433189D15B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 21:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164B02DF3F9;
	Mon,  6 Oct 2025 21:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsiCNB8P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D96C2DF13C;
	Mon,  6 Oct 2025 21:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759785715; cv=none; b=bclU4EVDsPxZOGTKzg/QiclqmYT1rKbhQbMhri5m83UN1oevtpZrjYDnJZHeBHChnve+qw7TLaFQwQ/xXh5WHnfLU9y9QMh7gQwclyz/DW/ZpYRTbCczksxKWhfCnkIhkQ16uM5Vg0aSgrOnAjuS1vYRHPErHEQU92VkmFfQF5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759785715; c=relaxed/simple;
	bh=VVc1pawzmxk/CiU4x01IQ8kCJVDTfOVXRKwQpCmltm0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C/85L1t8eTGl2RASbScbcPToqI6GcDF1GFsS60cT5IIiv7SCsE6Z1o8X0qrTU0KrJvDDdNQ8iglh2FYgNm4GV8Qfx30nQGxLCO25BP2vQNjhi+x1R6mTWmMjOfLHc2u6Du6+4HMhScnc6kcvcoRXrVxY2gl8xbrICVtTRRcY9dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsiCNB8P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581C1C4CEF5;
	Mon,  6 Oct 2025 21:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759785715;
	bh=VVc1pawzmxk/CiU4x01IQ8kCJVDTfOVXRKwQpCmltm0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PsiCNB8P0AYTWQoh6lYN/mHpLXEu9+Lq6cqw74glTtAngNeIQXQI7jqW97XnQP689
	 ySBq9eHqxs6mJDGrrbSR7SbXpU9U9syA+ZqkiZOvEE+WcFyCBRvJ92IFfl5/php2bO
	 9CEjSIgwIC5YoVb6+0SyTlQj9SjGHpYql2hSy5eOXVtJqNTIn25H7wsaWgefxmgn4z
	 lupUtZt7IO88RXFT9xN+XsCzxVVN9KQBxbMOFepBA3KxLbkL/e05zT9bEJXj1/hAV8
	 OSdW0g34dnMHKOBjwSvqOMroeTsKRCVeP9GUAReoZ3uBnlSaZQ8btd8H70xGiCQtbm
	 btHipG4lJx5Hg==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 06 Oct 2025 14:21:45 -0700
Subject: [PATCH v2 5/8] dt-bindings: interrupt-controller: Add Tenstorrent
 Blackhole compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-tt-bh-dts-v2-5-ed90dc4b3e22@oss.tenstorrent.com>
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

Document compatible for the PLIC in the Tenstorrent Blackhole SoC.

Signed-off-by: Drew Fustini <dfustini@oss.tenstorrent.com>
---
 .../devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 5b827bc243011cda1fd45d739d34eca95c6e1ee2..61bb9a98b1f5544efdf1460ee3873aad1433ac41 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -63,6 +63,7 @@ properties:
               - spacemit,k1-plic
               - starfive,jh7100-plic
               - starfive,jh7110-plic
+              - tenstorrent,blackhole-plic
           - const: sifive,plic-1.0.0
       - items:
           - enum:

-- 
2.34.1


