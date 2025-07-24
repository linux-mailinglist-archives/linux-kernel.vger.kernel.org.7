Return-Path: <linux-kernel+bounces-744567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53983B10EA5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FBB65A67F3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879E22ECD2E;
	Thu, 24 Jul 2025 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AX2TNCo/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67532E9EB9;
	Thu, 24 Jul 2025 15:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753370614; cv=none; b=LEzlFbYWuEmXRlFOa5sMiWNOHvVDTHoQ+TXUcdYl0hAnyQk96YzTQ+K4rbop/X4GpZNmbsmQT+WBPuKIXTPr2VqasTnYGSvOwS4k6SntgobuBDX6xT0dIBlUkqlIkh1jx9URvCBe5mhOyq+cWRU2Zt4d1M5lfuTH7+gdRgLqn8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753370614; c=relaxed/simple;
	bh=Zi6IDDpoS9Ju4hosKorQswwX55xC7wpT4z9/JYXU1E0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UuSXy7ashf8dYNScWg5gWWLXB8IiEcWP96SXSIqXRFR8/wUYVzcBJ28w+6rxtWeR0sjY9Rz8ugj/WL6+P5l3S1tJzbBA/5OFYObf9gon8PFxPXHcLMWVQFysXfgdOS+Bo61LsNaoRwsVH0KwYY+FOPuaeRSVTuGw9ngZI9okrqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AX2TNCo/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47FCEC4CEF1;
	Thu, 24 Jul 2025 15:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753370614;
	bh=Zi6IDDpoS9Ju4hosKorQswwX55xC7wpT4z9/JYXU1E0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AX2TNCo/jocHN41yMdZ2XQpEKXtcdWlaKfHt3yIoTMe6ezJI/+yUi58bvVmHakFrn
	 0katFrZdEvLf85Fj1p3L16P6Q/Oj9pHsVGfeKAq5PJoV6hlKdL9VBwvrHs/sVSHmxf
	 EhD4k6bkPiz1MWLqD0P7gxXRUooqbxKNMnuj8v+eYhh5PCuAwldugR4mM2dFVsCXj3
	 JkIbfjzfqGLvPPHb3spruBzKEpvmu83uwqBZFQKzzwBQFAZ3ZzEdCpsNiP3MxqcB8O
	 vKQjZRQdRbrhT/bdN5WkyHgXlPJq5hrOwWRh/2Xjy9jdlMaeYONjnTLNRdLe9L6ZKK
	 1j6x50ZmieYLg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D92C83F1A;
	Thu, 24 Jul 2025 15:23:34 +0000 (UTC)
From: Aleksa Paunovic via B4 Relay <devnull+aleksa.paunovic.htecgroup.com@kernel.org>
Date: Thu, 24 Jul 2025 17:23:25 +0200
Subject: [PATCH v5 1/7] dt-bindings: riscv: Add xmipsexectl ISA extension
 description
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250724-p8700-pause-v5-1-a6cbbe1c3412@htecgroup.com>
References: <20250724-p8700-pause-v5-0-a6cbbe1c3412@htecgroup.com>
In-Reply-To: <20250724-p8700-pause-v5-0-a6cbbe1c3412@htecgroup.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Jonathan Corbet <corbet@lwn.net>
Cc: Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 Djordje Todorovic <djordje.todorovic@htecgroup.com>, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Aleksa Paunovic <aleksa.paunovic@htecgroup.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753370612; l=1355;
 i=aleksa.paunovic@htecgroup.com; s=20250514; h=from:subject:message-id;
 bh=YgG7inSQQ5V7j0uCLEwS/5ucVThfyy6CA6ktsQ9XHnU=;
 b=ptCHQ1B2h5iN8micPgjKEGy82G2w1BNtSjEs+wuE3VlzFKIEvR3Y3DbQuOOLl9ErWfKz1DQSY
 HJL14K0HuXkCCySBJYtAauAKjFzt6A5oln0zXi1phgvbD4cOfZV2tay
X-Developer-Key: i=aleksa.paunovic@htecgroup.com; a=ed25519;
 pk=gFVSVYLKAgJiS5qCnDyUMGOFuczv8C6o0UmRs+fgisA=
X-Endpoint-Received: by B4 Relay for aleksa.paunovic@htecgroup.com/20250514
 with auth_id=403
X-Original-From: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
Reply-To: aleksa.paunovic@htecgroup.com

From: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>

The xmipsexectl extension is described in the MIPS RV64 P8700/P8700-F
Multiprocessing System Programmer’s Guide linked at [1].

Link: https://mips.com/wp-content/uploads/2025/06/P8700_Programmers_Reference_Manual_Rev1.84_5-31-2025.pdf

Signed-off-by: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index ede6a58ccf5347d92785dc085a011052c1aade14..de41a6f074d3af2ceaf5293dfe75d16f43d416d6 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -662,6 +662,12 @@ properties:
             Registers in the AX45MP datasheet.
             https://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
 
+        # MIPS
+        - const: xmipsexectl
+          description:
+            The MIPS extension for execution control as documented in
+            https://mips.com/wp-content/uploads/2025/06/P8700_Programmers_Reference_Manual_Rev1.84_5-31-2025.pdf
+
         # SiFive
         - const: xsfvqmaccdod
           description:

-- 
2.34.1



