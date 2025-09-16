Return-Path: <linux-kernel+bounces-818163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4D4B58DC3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE7EF1BC2611
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9CB2741A6;
	Tue, 16 Sep 2025 05:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYAcEnnP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C4D2222C5;
	Tue, 16 Sep 2025 05:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757999787; cv=none; b=Loev9hyv85XZrFvF7tLj153zapwC/PncmX9GROPONrSwDINZblBN9TdThAUNpZNAT/OJmgN/VYjk8gTAknnujngq5XN6hW5I7j8xbwCQItIIcjT+MtG/PqI3M55KRv+7qzgJ5G7z7J6VBAXHLZxWr+6i7zHlMzz0qCYRROuDJXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757999787; c=relaxed/simple;
	bh=Azo2XfPipP/QNg0jNi2mu2/SW3/aSQz1jPCKvUHMCJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZvV7Iav+FoaJj+k1wyvfBhH7cEsUh1tm+vjufPripXLi4VcSY6p+Q/ddn1dbVHRcudF/jfjK7hSg/xuVXr7kmZ4Di8OGz0m18ku8swLqoajMhUHZxplZcJLzVyf+lu1ARAjCn+05VA/uUIm9+Ia3qL8ux1579blVEbz4DG/ldKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYAcEnnP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A69C4AF09;
	Tue, 16 Sep 2025 05:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757999786;
	bh=Azo2XfPipP/QNg0jNi2mu2/SW3/aSQz1jPCKvUHMCJc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VYAcEnnPHuGlqRJ2ZbkbyolzOLPvsS1RzQB/VwxL8LLNgzvItpykXT5WsVSYEjo2v
	 LN80vO9Og4CElbDtzyfZQwlITQqtRG3PG4xaRZGioFD3BK1jfIOsItyFkZLpaOHR1k
	 FG0O9d9mhva+WXCAULPHhX/55lzDlZqBTsvughnwy6my723HjKuUAKAPiuXHDdOAwm
	 T6ExgZNXypCyn5p6Yxo7LVDoZr3cUdrBDPx7AWnRLAfBrdJkF5k8exrRxmpKgWPRh7
	 o/WUODpWhSQHSQse6RbL59TVrF9pOj73EA2Ry9f1l93Y+PUfD41+l7VvEaWGtTi6jT
	 F45IcWc5AJ8EQ==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 15 Sep 2025 22:13:41 -0700
Subject: [PATCH v2 1/3] dt-bindings: riscv: Add Ssqosid extension
 description
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-ssqosid-v6-17-rc5-v2-1-2d4b0254dfd6@kernel.org>
References: <20250915-ssqosid-v6-17-rc5-v2-0-2d4b0254dfd6@kernel.org>
In-Reply-To: <20250915-ssqosid-v6-17-rc5-v2-0-2d4b0254dfd6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1207; i=fustini@kernel.org;
 h=from:subject:message-id; bh=Azo2XfPipP/QNg0jNi2mu2/SW3/aSQz1jPCKvUHMCJc=;
 b=owGbwMvMwCF2+43O4ZsaG3kYT6slMWSc+LSy/HfvZuke4fPaPcaeh2dyvC1ZvMrnGY///KWna
 uueRz8o6yhlYRDjYJAVU2TZ9CHvwhKv0K8L5r/YBjOHlQlkCAMXpwBMpKuR4Z+108oGVdnzuRcZ
 GWxn/uHjrZ6/fbfa95CsKXe5D3otz4ti+O+qpXZpnsSO3e3pnyT4hT4c/5LTUe+wX1mKl9+2euV
 bNk4A
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Document the ratified Supervisor-mode Quality of Service ID (Ssqosid)
extension v1.0.

Link: https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index ede6a58ccf5347d92785dc085a011052c1aade14..38e3d8d38cce55022ea70eb52423b1163e3cb097 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -165,6 +165,12 @@ properties:
             ratified at commit d70011dde6c2 ("Update to ratified state")
             of riscv-j-extension.
 
+        - const: ssqosid
+          description: |
+            The ratified Supervisor-mode Quality of Service ID (Ssqosid)
+            extension v1.0 which adds the Supervisor Resource Management
+            Configuration (srmcfg) CSR.
+
         - const: sstc
           description: |
             The standard Sstc supervisor-level extension for time compare as

-- 
2.34.1


