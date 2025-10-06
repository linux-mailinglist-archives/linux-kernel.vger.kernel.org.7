Return-Path: <linux-kernel+bounces-843476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC5ABBF8E8
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 23:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4555188A6C4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 21:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CA7262FED;
	Mon,  6 Oct 2025 21:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzp7Lcxf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2DD25B31B;
	Mon,  6 Oct 2025 21:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759785711; cv=none; b=ftfWzeJGKqUyh/09IA0MAWF171tT3ktf07VwDcsQAL3Cd70c7bSAzFNwNh6DvlfyyChb5PjdSSCyj6B8lEWUVVCGV1DQERPi/5+H1WsGsVo69RDsMSbhqBNZdPlLr3kltiorY5s5YXPKzELN416VeBBPdNXxmWmhhlOPCM4wHww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759785711; c=relaxed/simple;
	bh=wjU6tcWnObWPbleqN1qlUZVOyplmFW9B7lV7vL64Ejc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WL8OjfJY2FaJoxBMW5YHZYsg5Qjd/8DlKFX9CBKjVjbUrIKIbqGA5eEZOWzyi/yrgnFYvNz3LsM7zgnsgBOVXVqAkT158wXgN1jqco8PNh85DQn1siiWuJUC5v+GF6x0HLjlp1eVU5izqzzejU3uiNmZSkNDTb23/yh8rTZ4SVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzp7Lcxf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C60C4CEFE;
	Mon,  6 Oct 2025 21:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759785711;
	bh=wjU6tcWnObWPbleqN1qlUZVOyplmFW9B7lV7vL64Ejc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rzp7LcxfsD/ZSDpToywVAsH34/G8AoZ6ySNhcAedqJDxcWI4LuBs22YLFWrBkGLfI
	 8SfiCLA+Y+DguVrX9uRCHswokpgyJSjht6zeq8MdHoP2UD3mQL7ss6BvjFXd8n64iQ
	 G3eEkEXko3XAXlB/BDahmjpOpa7DBehV/3J1YtvPLhrGFlAlboKl1msijjgDqH58gK
	 PdbWGXGJ+N6cNdfRtGVznQZDPX6vc/oyaZvNFaxrvaDw4CKwZXM1PP/FYVsdiy7MQb
	 W7a/Dd02nnWH018O9LNavE3OKbzaeaia0kTZTRdrIeNya7eXdFCyZbWy5D78GaLyr5
	 liEb2OsZ1xonw==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 06 Oct 2025 14:21:41 -0700
Subject: [PATCH v2 1/8] dt-bindings: vendor-prefixes: Add Tenstorrent AI
 ULC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-tt-bh-dts-v2-1-ed90dc4b3e22@oss.tenstorrent.com>
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

Document vendor prefix for Tenstorrent in DT bindings.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Drew Fustini <dfustini@oss.tenstorrent.com>
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


