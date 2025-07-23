Return-Path: <linux-kernel+bounces-742252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E032B0EF2A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 212BA6C28AF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C790D28D837;
	Wed, 23 Jul 2025 10:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LwNk8W8/"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6C3283FF7
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753264956; cv=none; b=BMiwB8nFABXJhI0Ayke8tpoBUSZyFpCsbY5K7t3CjA4DUZpGR4XTkEXJvexerEoVx3qZRK9U6Vamtwc84odIgsXycIQXqEYF2TBRbe7x5Kf6xBa1rJToLrCnrV+I/N53XalYhdcAD+8LR+x28JUR9JA87WoARNddvEFIbNsTiUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753264956; c=relaxed/simple;
	bh=dVNC3ShRwc9rraYqV1NZd7Qv0LqdAYPie3YmmaCJa10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=plYWYlY9yyx2DQRw6l7EMTN6sJ7hdAutUv8A/31aTupRDWsgcVrO8iH05/8taeMpVBVW0lAwZ3XrKraTg0tZXinJLTJ0fxwCRLfMPgrEsBwGDnx1GgdBM/ciSuD0nPx/fT6oZauDeuiKECE3j/EJC1iRPHjxlk3C0Fg2B7Vt6IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=LwNk8W8/; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E073DF06;
	Wed, 23 Jul 2025 12:01:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1753264914;
	bh=dVNC3ShRwc9rraYqV1NZd7Qv0LqdAYPie3YmmaCJa10=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LwNk8W8/vE8k1ufkgq4T8LE0WquQYZBYxzEnaHEh0ukdbqh2IncvIs4jGy8fGLu/j
	 TWi3rz+gkG9VomX3/R/+FKqmvwfZ5FfctDS2lU+yAEBK8Kvbm7KlGPBsCAei3DYl0o
	 4bpDBAS2XJVgYpT46I2JzQ1p7MiEYWY0IpJK/KZQ=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 23 Jul 2025 13:01:28 +0300
Subject: [PATCH 1/2] phy: cdns-dphy: Store hs_clk_rate and return it
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-cdns-dphy-hs-clk-rate-fix-v1-1-d4539d44cbe7@ideasonboard.com>
References: <20250723-cdns-dphy-hs-clk-rate-fix-v1-0-d4539d44cbe7@ideasonboard.com>
In-Reply-To: <20250723-cdns-dphy-hs-clk-rate-fix-v1-0-d4539d44cbe7@ideasonboard.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 Devarsh Thakkar <devarsht@ti.com>, Francesco Dolcini <francesco@dolcini.it>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, 
 Jayesh Choudhary <j-choudhary@ti.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1463;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=dVNC3ShRwc9rraYqV1NZd7Qv0LqdAYPie3YmmaCJa10=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBogLM2ScIg+pul+KwrIVolm8pm4A+8750e3elZX
 p+uM4p6A7+JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaICzNgAKCRD6PaqMvJYe
 9ZRAD/sG6tZeQJxjzmSEfufkletE6/L+9BXyM0XAKgiRFBVEVwAaVB29HqAAsgWIBCdIg5wNXog
 xl3gMmU1FwbeaAUr4Zww/NaVvWIOspQJrrZq0tvTiEGGvCgOfN2q6O3aI5LFdFj9OgEaPecblp1
 us8rgSqmYRYjkivlDzeXNTzfLesqs5/NOG4u3K/cyWr7z9uU1thjywADA2mCZCm32Y3CIZjVkxs
 7j3ZuuBI+VsCrVYyg2Ct54Pdos5qVlUIbS/ZhV7Jpfc0OJconlajYr5gYz/S87iKjfllkEXUoWD
 U8V8fS5yp055xxYAQxSugUv+zMfVv2oGZKUUk2IULoO8yp6gjnmK5LRIGkNPEZiZKCRVN8PvewV
 pxREnQQWd0gST319Cjv09703hYuDl3CAnE3HC1swQ5ao11ruDz+Bb7I3T9aWQYNkDXxdVcXE/aQ
 Pq551oFRsCGb6FaoPQlr9WizNiI6bcPJm3DtN+Zhl3inPX7XqoUMsNRpRjL18Q58yJgCeb+0KHz
 k6bU4toQTsBU3bd7ShVM7jm5TuM2Or6iEAY0GOj7hCJXD6YqxKJfXSByOTEg7jMaLDtF95867Pg
 HjSr2Oo2EaD46uGqWH/P+Eh0U/KnI9s+ifIrtrXzeFZlsY1C0LmiXdBe56tQ44dzCpmyS/RRIPq
 252Xho0K+r24fNg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

The DPHY driver does not return the actual hs_clk_rate, so the DSI
driver has no idea what clock was actually achieved. Set the realized
hs_clk_rate to the opts struct, so that the DSI driver gets it back.

Reviewed-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
Tested-by: Parth Pancholi <parth.pancholi@toradex.com>
Tested-by: Jayesh Choudhary <j-choudhary@ti.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/phy/cadence/cdns-dphy.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/cdns-dphy.c
index ed87a3970f83..f79ec4fab409 100644
--- a/drivers/phy/cadence/cdns-dphy.c
+++ b/drivers/phy/cadence/cdns-dphy.c
@@ -79,6 +79,7 @@ struct cdns_dphy_cfg {
 	u8 pll_ipdiv;
 	u8 pll_opdiv;
 	u16 pll_fbdiv;
+	u32 hs_clk_rate;
 	unsigned int nlanes;
 };
 
@@ -154,6 +155,9 @@ static int cdns_dsi_get_dphy_pll_cfg(struct cdns_dphy *dphy,
 					  cfg->pll_ipdiv,
 					  pll_ref_hz);
 
+	cfg->hs_clk_rate = div_u64((u64)pll_ref_hz * cfg->pll_fbdiv,
+				   2 * cfg->pll_opdiv * cfg->pll_ipdiv);
+
 	return 0;
 }
 
@@ -297,6 +301,7 @@ static int cdns_dphy_config_from_opts(struct phy *phy,
 	if (ret)
 		return ret;
 
+	opts->hs_clk_rate = cfg->hs_clk_rate;
 	opts->wakeup = cdns_dphy_get_wakeup_time_ns(dphy) / 1000;
 
 	return 0;

-- 
2.43.0


