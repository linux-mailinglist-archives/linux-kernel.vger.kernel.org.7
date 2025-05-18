Return-Path: <linux-kernel+bounces-652913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8870AABB202
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 00:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1DE31892711
	for <lists+linux-kernel@lfdr.de>; Sun, 18 May 2025 22:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BDB20C48D;
	Sun, 18 May 2025 22:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="V9+p/E1n"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D7B20C02E
	for <linux-kernel@vger.kernel.org>; Sun, 18 May 2025 22:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747606060; cv=none; b=pZ8yWB/trAoC6H6Kx4Ipl9++vX34MQJNma2kL52uBzZLLfHjC7dbgSPnZDUbiaTJb9UpGTkaKmWQEXvzwZ54nFUOgQ9wzsVkYqC4/ephQDiGvuj/NHcmLK7d4/L/bZLvncFkCHyLgvTCddJn5GCQeSeD+iLSIjQ9lj3G/BQNNDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747606060; c=relaxed/simple;
	bh=BM/558NIb/OQWzTPVj4yzIGBsEsv0oJQTjiJ9z3MSy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PfasoliUsHHcbxecrYmRTbmEddvLCunJmuZOTNhWo0efbQP1T2V/CzfVVts20UQCSXGCGyqCG0ZD160Gh+tj1o8kEwZLY2YCT9jNTy1yMgvPDPoZpGOWMT4bPq9bvF8vezSI0AFHg6QcSu6FpBD+UhHdJ4UJuPPq8TKdsc9Nb10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=V9+p/E1n; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1747606058; bh=JuYEKWBVukLDcGbYOqkONpNdiBoEcCXdcXXV5j7NdiE=;
 b=V9+p/E1nz3ZLcm8k3oBT0VX+3dLbM5NrxWV+TyVYCY3UP+/RWqhkDAcz64VlgFtlDhu0WfMt3
 4MPn/T1ARuwUBBuebuHJleS7wTnQnFCp3XpmI8zrHwZHewYLri0FH7lIKe0ggT66NIGGWcyPN8N
 X78F0mqpfadB1bsY9XfDVkNUn1lIe6RMWyHdFPPG+ukfv+Sdd1dEnvyESjMWSGbPfhLPphkBhM0
 P1E7dkIz1iv06nXUHb4L2LsWaCussuZEWfOB/dMVKw4rgE209O6iurPt73N1i5Zl+NeK+uhNFi1
 0h8HK3jOj1kZ2qSZ9yJNWngpOp0zG0IumLDA7LZXcvMg==
X-Forward-Email-ID: 682a5a2678cae75fbd8d46da
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jonas Karlman <jonas@kwiboo.se>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] dt-bindings: mmc: sdhci-of-dwcmhsc: Allow use of a power-domain
Date: Sun, 18 May 2025 22:06:52 +0000
Message-ID: <20250518220707.669515-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250518220707.669515-1-jonas@kwiboo.se>
References: <20250518220707.669515-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 7e856617a1f3 ("dt-bindings: mmc: Add support for rk3576
eMMC") limited use of power-domains to Rockchip RK3576.

Remove the power-domains: false to allow use of power-domains with more
controllers, e.g. with SDHCI on Rockchip RK3528.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
index 5fb347167004..f882219a0a26 100644
--- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
@@ -120,10 +120,6 @@ allOf:
       required:
         - power-domains
 
-    else:
-      properties:
-        power-domains: false
-
 unevaluatedProperties: false
 
 examples:
-- 
2.49.0


