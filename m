Return-Path: <linux-kernel+bounces-843478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C2EBBF8F4
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 23:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 723094F2305
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 21:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9282DEA9B;
	Mon,  6 Oct 2025 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XinHgjrU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F8B2D7DCC;
	Mon,  6 Oct 2025 21:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759785713; cv=none; b=Xn6IQyE2cgdMhtuftiahwAX4ZG2ZaF+AxWqV4/xdFlMO9ckb5ODlbVSkjalCY/GRBEgki6PP0U1RWkBciG0vBhk7Vb0WTWDdte6HWS+9ML9djMU2rqVSY9T3gt6B1SiDyO8YE+Mid473LQfJQCPCIXXeUF55H0IwLKzbSxUYsUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759785713; c=relaxed/simple;
	bh=rNu0QItyK8D1qVeWfJOHhXOMoiDoQzrzmDZqy8+fBZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=brThsLDNZ9Qy4Bll2obbIW4oVYJUyPSbdCZoz8xCBf72pHwBzl5gL1bQrnR1RdYkvmjL43RU0GNvfubOcu/fdnwo6Teax5FpP40IzJnHhwRqHpMP3f4zxTIq9QtliDm/dUbfhDs1V8PQ2PbJWsqxCfPXNAHvvUvQT8RTkBd9lI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XinHgjrU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0EDC4CEF5;
	Mon,  6 Oct 2025 21:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759785713;
	bh=rNu0QItyK8D1qVeWfJOHhXOMoiDoQzrzmDZqy8+fBZ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XinHgjrUiZT0GIS6aVa+Wx0unLVoBHiyNOX985q94IKfnr9vH4qt2jwZnRTSSH3Xs
	 xGTs6ngDbvCLj4zMMg0a1ZtCjl9X+YSgXI8oyn+jF7iR2OjghibKWrL7Bun5YC3q0U
	 wstq8DNbV4U3g4VysLtvmhxL73vm9umLg9nIKs6hoqD0VGG31QFz9BqUaM85bPt0HG
	 SBP5hItQm4kF51IkjoVHUBk75EmModrWXqRg4u3cOCA6qaXMv8mIqPQVYG8gZNoe/o
	 4Bf0A6VQlJX6JsMmoO3G8/OMkCBQR4n4jV4bZeVuKaYGp+4cm88oyLRQMCQa2j5Yju
	 cTuFzWs4leCrg==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 06 Oct 2025 14:21:43 -0700
Subject: [PATCH v2 3/8] dt-bindings: riscv: cpus: Add SiFive X280
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-tt-bh-dts-v2-3-ed90dc4b3e22@oss.tenstorrent.com>
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

Document compatible for the SiFive X280 RISC-V core.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Drew Fustini <dfustini@oss.tenstorrent.com>
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


