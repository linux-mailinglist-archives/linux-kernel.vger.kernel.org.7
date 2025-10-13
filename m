Return-Path: <linux-kernel+bounces-851122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69312BD5999
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF9053BF835
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A666281508;
	Mon, 13 Oct 2025 17:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEke+fgY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04FF2C15A2;
	Mon, 13 Oct 2025 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377693; cv=none; b=mQUvvQpFoL7jo1R4o3GBSPfkSVjqElnDnWgwgzuVq7GYy5O124CNbX6cfAG9zbDAaoYXfZnH0GprqsebRqfGdYLNwvj2PA2KzIYH7T8qROirsM1xgVI1Xv0tvhbrONEBB/F1HqFHpmywuW6ZoTO6LSE9CsEWKI+iJvmfLLSbcAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377693; c=relaxed/simple;
	bh=4tliw4UQndH1N9g1/up84eMEVp/xYC+YCAsm2JdOf3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jfkQJ4XPnllmP+L9DrAPO/2b0M+93SYZhQ02/80IWBY0OQJaZx1z6BTQBwbegyfcQXiGO1LGWQaccfwXf4gDkmfmeO1XutE7/RwIEzM/miA5nBZ4kN+5L1G1ZMwd+Sc+5qJRXd9qW5Fbx1M/Puo5t47Rn24rfaJVxGBntcQh/GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEke+fgY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD02CC19421;
	Mon, 13 Oct 2025 17:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760377693;
	bh=4tliw4UQndH1N9g1/up84eMEVp/xYC+YCAsm2JdOf3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jEke+fgYjB1mUr/bWEFrIGcs/AqCyLZw0E7ayMz2kpPI96yMJE5HZnMvF22I5BHQ+
	 HvXtKAaqDDy/5VW7q3zwbN78pIS0HAJjdZngKmuxViGWUCnahZmzIfFXXgzSs2pGFQ
	 cLPqeJMIpfwLcAb5ZVBhOiiUwOez5aBh/PcJBFIChLHOk/ip8yA+fPFKWGL4uML6YE
	 jaYJwxOeAB/xwFIBtBVkzS9ExjXLCdKYS4eoAHBsnYFtGPeQRNCYqpYx7CnzQ9bpr1
	 wRaCbEBihdVk1OQj0hVY6zCqaxOX4/UFhpszImq7SkLhAYKLGpdpy5dhS8ijtRzjbj
	 Xy1sl0jrUSK9Q==
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
Subject: [PATCH v5 9/9] MAINTAINERS: rename Microchip RISC-V entry
Date: Mon, 13 Oct 2025 18:45:41 +0100
Message-ID: <20251013-unwelcome-crusher-2bedb9ecb35f@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013-album-bovine-faf9f5ebc5d4@spud>
References: <20251013-album-bovine-faf9f5ebc5d4@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=735; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=WjqbuqvJbBVUVn1s3EoLv4wSnU+jVPnRC0yZy4Sseq4=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDBlvrQ6y/Nq440O46HGvly8niUk2cq5knPvlxNb4/weSa l0+1/+O7ChlYRDjYpAVU2RJvN3XIrX+j8sO5563MHNYmUCGMHBxCsBEHnkz/FOzPcL1ciUf5+Id 5pEn38tpNAcv+X9EqKN1X9XlEuMAcXuGfzoX+61nz7q9OC0s8F7VovQpZZktUTKdR2bvm5b90+1 GDxsA
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


