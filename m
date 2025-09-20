Return-Path: <linux-kernel+bounces-825934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE3DB8D287
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 01:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC6B7E1CED
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 23:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AD028C2D2;
	Sat, 20 Sep 2025 23:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIUVkayV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86F8261B98;
	Sat, 20 Sep 2025 23:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758412322; cv=none; b=b7cYDC3tKH61RrMLxhn2SVF4BQ9BX9kDHdB6/BE6y+wUhxybBfjrk66xtsWZLkQ4CNfe60o5Lq72Nl32qzCsVrXCK3dmQml6TlRJmhrhOSwHyy/DLx52ofglRsPhAAxp9C3IMS/AnsYTPoi0lm/j2T3sxQdCAeWLCt6yFths87k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758412322; c=relaxed/simple;
	bh=uXeBhkQI8P5Fv4fD7In2Mcgow0lPIEHbQ1emGeRuBwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pJDGO+WlYa4UO/VriB5zpW1Vw2susa25JCWJ9Ie0qrcCGYWAJKaCRzNQd3baG4m2UT0yq4JabKcOu+2Bni9X0+BNQ1irCD1wo40Wn4HvqxE0tWGTkRYJ2iPU2I6s0cwykkHJGOymcBj10yeEqfbOm/EoqIQvtH2llfwTHZ0/hJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIUVkayV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19EFCC4CEF9;
	Sat, 20 Sep 2025 23:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758412322;
	bh=uXeBhkQI8P5Fv4fD7In2Mcgow0lPIEHbQ1emGeRuBwg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DIUVkayVUa4krjWwr2K/M6Dc0TSNaINEWKotMxb+GWdRDmHmCcSEBhVkUldzeFCwX
	 O1opGNEQgjyyuitXJnUKnLrmgSyw2D/YYbshSt4MNxrkVNWcDFVJcbiTSAE+pBcXVp
	 IdFo5+kXOvADlhsPSzbUaS8CsT2wqg15QRDfbH/aSit7CUOuUk11FTkyafdLYPxHjc
	 0XwOVjfzJKR7YP7HVgTcuw7nbgiDReeKanDz9l9nnIUoQBIbQukRas86u4o6vqqAmA
	 7Sr9k247ULsfd1kdyz58kERi80R/oyar74WKrWu/XcEppp5GjN6T1xsCj1MDMjN+k3
	 UZ9Ctk4hRr3Yw==
From: Drew Fustini <fustini@kernel.org>
Date: Sat, 20 Sep 2025 16:51:42 -0700
Subject: [PATCH v3 1/3] dt-bindings: riscv: Add Ssqosid extension
 description
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-ssqosid-v6-17-rc5-v3-1-5093162922d8@kernel.org>
References: <20250920-ssqosid-v6-17-rc5-v3-0-5093162922d8@kernel.org>
In-Reply-To: <20250920-ssqosid-v6-17-rc5-v3-0-5093162922d8@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Conor Dooley <conor@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Adrien Ricciardi <aricciardi@baylibre.com>, 
 James Morse <james.morse@arm.com>, Atish Kumar Patra <atishp@rivosinc.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 Vasudevan Srinivasan <vasu@rivosinc.com>, guo.wenjia23@zte.com.cn, 
 liu.qingtao2@zte.com.cn, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Drew Fustini <fustini@kernel.org>
X-Mailer: b4 0.14.2

Document the ratified Supervisor-mode Quality of Service ID (Ssqosid)
extension v1.0.

Link: https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index ede6a58ccf5347d92785dc085a011052c1aade14..94c5786507f09be632e2748eea93b998ee8710a5 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -165,6 +165,12 @@ properties:
             ratified at commit d70011dde6c2 ("Update to ratified state")
             of riscv-j-extension.
 
+        - const: ssqosid
+          description: |
+            The Ssqosid extension for Quality of Service ID is ratified
+            as v1.0 in commit 5059e0ca641c  ("Merge pull request #7 from
+            ved-rivos/Ratified") of riscv-ssqosid.
+
         - const: sstc
           description: |
             The standard Sstc supervisor-level extension for time compare as

-- 
2.43.0


