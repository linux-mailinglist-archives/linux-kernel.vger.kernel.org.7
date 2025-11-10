Return-Path: <linux-kernel+bounces-892967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24437C463A8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D81713A6678
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBCA30DED7;
	Mon, 10 Nov 2025 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEC6dCRf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24B230E0F8;
	Mon, 10 Nov 2025 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773859; cv=none; b=PJuoXhUFlGjJOYqfJYeDRduQN6LkPR5FL7J+NSz+HQfesBpUmGSYXxWcX+ya21hh5XnsSgOFZMfbRgtiDUh2fBfNmxhE04XvjTZuBOLzUajlOCChNZOucVIE8Ru0BMyZlMTrmEM/n/Nx76u0zZt5StqK6teY0kHDubN2UNB+kG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773859; c=relaxed/simple;
	bh=4tliw4UQndH1N9g1/up84eMEVp/xYC+YCAsm2JdOf3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPzXRfbXEgNCVMsDp9JsY1VasG9oar5vnwyjIEs2gl7BNRbBaEtfeIMcRnCQ97Un86aWwletG9o1wI8Iv5JgNxoU9Mp19jL5J6Y6CzFcBPc0P2F8pAFk8+DC0+O4dyAA2jhblyz6BNkQXwe4voAljY1KUp2zQPrxbLwxK8IyhBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEC6dCRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A71C16AAE;
	Mon, 10 Nov 2025 11:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762773859;
	bh=4tliw4UQndH1N9g1/up84eMEVp/xYC+YCAsm2JdOf3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AEC6dCRfddyR78ZZ50BzzVGaRNGXHaxZrETUuQwVxhO+HJhud69ea51CVKnRUxMz1
	 GkYETkcs1qyjvHqbzVQnaccSKcsgHLpOu8A4unYLmdJfrccm+zzs9Fd2gg/JCe1b0b
	 0jxz8FGWkV3NEmKP/Vz08cmF05jtfFa8nSzacnmUY0wFiUq8e4Se4yoIK6kHfoJxW2
	 WfQe9imOiTgRIHZmHFHahtkc4Rus2qbkqE+VbekKx7ugMMTSqmOKPOnaE5+QypO54F
	 TA8jaWXfw8Qj/lJ5nRiNoGzGWVxUIUylYTalhLY+aUPkcC1or2skdYFgIcEO2XCz0l
	 r8WFyroMh9h+g==
From: Conor Dooley <conor@kernel.org>
To: claudiu.beznea@tuxon.dev
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 5/5] MAINTAINERS: rename Microchip RISC-V entry
Date: Mon, 10 Nov 2025 11:23:54 +0000
Message-ID: <20251110-feminine-aware-9a4b62e8ac0a@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110-zookeeper-femur-68a0ae346397@spud>
References: <20251110-zookeeper-femur-68a0ae346397@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=735; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=WjqbuqvJbBVUVn1s3EoLv4wSnU+jVPnRC0yZy4Sseq4=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJmCpz1OVp1fejhP4cflksK2aancMk4fN3f39M9yestio yrgUFjfUcrCIMbFICumyJJ4u69Fav0flx3OPW9h5rAygQxh4OIUgIms28XIcEbsr/syZxWtFdOu NfFYqm5X5GxWm7d4du0bhavJywI4lzP8r0ix2SIm8uz6PqkoJ+MXWi9EfJ0+6UZEW84QVYywfze dDQA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

There's now non-FPGA RISC-V SoCs from Microchip, so rename the entry
to reflect that.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a28740a7d87a..24efae3df425 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22079,7 +22079,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
 F:	Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
 F:	drivers/iommu/riscv/
 
-RISC-V MICROCHIP FPGA SUPPORT
+RISC-V MICROCHIP SUPPORT
 M:	Conor Dooley <conor.dooley@microchip.com>
 M:	Daire McNamara <daire.mcnamara@microchip.com>
 L:	linux-riscv@lists.infradead.org
-- 
2.51.0


