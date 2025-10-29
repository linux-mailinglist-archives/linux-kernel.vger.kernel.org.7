Return-Path: <linux-kernel+bounces-876676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EDCC1BF99
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B35FF34BE4E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A3034DB59;
	Wed, 29 Oct 2025 16:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDik67Xj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C479B32E125;
	Wed, 29 Oct 2025 16:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754317; cv=none; b=HOez2n6yPTYm19pDR4UEhAgwbA4/tqWYEJDswpiHzZp01gLvec6gqYzlDsuyvr029RWmesDzhpMDijHBHZFzsBXnDyF/IuBCBrrSTVwGC/tj8wo9l73nuvyilgA7fS1skEn4ie+jaqO6WjKIveXcub8KXNpODScN75BNcKgp+9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754317; c=relaxed/simple;
	bh=4tliw4UQndH1N9g1/up84eMEVp/xYC+YCAsm2JdOf3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cgk2WyBNi2Gosi3exlP3BGhkuBwHXCjTLjJfUsAz8DOY+poG8KoPCX87vMgFkGDKmno5/UNSpgOdMkkUaQXJJXQaEDPIULf5NJkH/rLuyvqCg26zEkfRrcSTXLXWQCMzTKbP8wGhaRtFRWmpOReMMBVDxwCSEqQjnHXxundRhxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDik67Xj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9E4C4CEF8;
	Wed, 29 Oct 2025 16:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761754317;
	bh=4tliw4UQndH1N9g1/up84eMEVp/xYC+YCAsm2JdOf3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DDik67Xj2g89qtJbhs05ihSJj1yuG8PXOTAlyqGqaHz91XBjOhszwyGqHOVvLB/4U
	 rqmdClAvEu+T4Ct5K8CAGQRCtqcK+N5cDJ0A0SMUOIk4tjw+waLVHy2csrayoOjxyH
	 oYMTQyfA2utC8FJ8FieW2497NYjVTk2G5DRqwGPhzMwy002nKv1gFDhUe+TYZnm/oO
	 BDCVIueC6yO1hzRzl+la8/bEWGwKwzh4rujaN8N3gZSP7ZUZxUs6LGsfuPusMB31Sd
	 uuKme3s/ZEBMq3/KhhFL7nkHX0HZ781nSOhcyZK11GooOwrPFc0OcnHK0qGcIo44X/
	 PTt6vXAgwIVPQ==
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
Subject: [PATCH v6 7/7] MAINTAINERS: rename Microchip RISC-V entry
Date: Wed, 29 Oct 2025 16:11:23 +0000
Message-ID: <20251029-timing-venue-1cd20c3450ac@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029-chewing-absolve-c4e6acfe0fa4@spud>
References: <20251029-chewing-absolve-c4e6acfe0fa4@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=735; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=WjqbuqvJbBVUVn1s3EoLv4wSnU+jVPnRC0yZy4Sseq4=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJlMNusF9rzrT3y85rnMwW1Ve/sfH/j9ccWcxf3H+mWPe l1pU2na3lHKwiDGxSArpsiSeLuvRWr9H5cdzj1vYeawMoEMYeDiFICJuMUw/K/M3HBAemLkxk2K 9xmmJPQlHLw8ecIbdqcyp2nb/vxOfviekWGGyeEk84JLk3mTV1qoiCc9nKu58tTMxlX6X1dVuKd LcnIDAA==
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


