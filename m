Return-Path: <linux-kernel+bounces-815362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB75B56345
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 23:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93974AA19B0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 21:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006CC283C9C;
	Sat, 13 Sep 2025 21:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVSqRlRn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527E426B95B;
	Sat, 13 Sep 2025 21:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757799064; cv=none; b=hritp6vCVkmea3bYSPPoTxG18LNJxDBqTIkD+QYwB8pDiMOEmZyz+bycr6w7qfLLcarvsqCU/axPrPiYJD5Mv+IEtOUdcpwVIkRgH6d/qyhDakkvlNBBQhtzT2MTv9Pnr9Z58e7hcMYzhJKqEOBdjmFRGrPZtJubERncTJw9E+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757799064; c=relaxed/simple;
	bh=rAEJCjiuy2zBASFDNgTzbAQNwNe+tJ4VWEcuHUg6TYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qWJsSI1tA+Vd1oSSB3Pv4mvB1UxpsdQroIQprANFea6Vi9CXSm1QRMytwfUVjUrU103aeuPFOXdMyLmjax5HJkxXd1WSwBshsx354YWXe9bIBLEeP1o4IAHX8QS1Wu5HxlZHWWm/fUyvBQg/LnPOtko1SdThHCRfTwH5yrp1pZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVSqRlRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43705C4CEFA;
	Sat, 13 Sep 2025 21:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757799063;
	bh=rAEJCjiuy2zBASFDNgTzbAQNwNe+tJ4VWEcuHUg6TYo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NVSqRlRnfzLvA+lRv2ZK/ZG6x+tQE3cM+RkcOD1tRyE/iMU3flrKzBWsVZm7f2Xgw
	 UyN8UaVHC2q/TzdmRddkB3konWqBjFvnFt+o5319N3u1dFZO7rqb6eGsPrtjVA5YJY
	 rBkjMCzUfRY5M9Z7jP29Al0Da7WlDIde04oWf1/aVEVt3cYEFiW8nz9RHJvy3uEm0G
	 aZhp6R0UvsBEk6OFJGLk1hACIrtnLJErJhk+GPWW2A63S5K34TBMVVitBkw44sldx3
	 AiKqNik/Z4idfxgkKv4DSLVqdwM75dyRtzkntmfkZIbGd4W4/BvTJGOyvlGyqtPFZM
	 QAkGYQ8zgjZJQ==
From: Drew Fustini <fustini@kernel.org>
Date: Sat, 13 Sep 2025 14:31:00 -0700
Subject: [PATCH 1/7] dt-bindings: vendor-prefixes: Add Tenstorrent AI ULC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-tt-bh-dts-v1-1-ddb0d6860fe5@tenstorrent.com>
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

Document vendor prefix for Tenstorrent in DT bindings.

Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9ec8947dfcad2fa53b2dca2ca06a63710771a600..8bbc0ebdfb9eb5864f2797251a8d144e2eea9a92 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1547,6 +1547,8 @@ patternProperties:
     description: Teltonika Networks
   "^tempo,.*":
     description: Tempo Semiconductor
+  "^tenstorrent,.*":
+    description: Tenstorrent AI ULC
   "^terasic,.*":
     description: Terasic Inc.
   "^tesla,.*":

-- 
2.34.1


