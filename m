Return-Path: <linux-kernel+bounces-747116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 760C7B12FF3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 16:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A12871898983
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 14:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F058821C18D;
	Sun, 27 Jul 2025 14:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="FMvMNvkO"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695E8218858
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753627471; cv=none; b=CPIDCxgs5FgtuGYuurZDeh9fIo9HS0n3lcILBn3QtLclEG11L0NqF3OjT/NrzmMAoiFQo1LE1YSw3McKcXZzmdDgkvD9kRKdiIoS5t0vUXW9gjRmSGPQMRPOnZq7yRi7Fld1KX1CVas23tND4e/O+ViOnN0gRwtzWtKD92tPtXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753627471; c=relaxed/simple;
	bh=LiLhXOzyplAd7/QDdDO7YLbEDBBNjqFYMCY5bBkc8hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n051BI86SRDBMU35whTFTTY3hP00Hh0GPEWKH6KuoazR5XJh+dVH0vMDnrE1JtTZ+qGE+3FtpLdKvB1D92n1xgeZrGS5J0BXznxeSF/WyAvL0XrGTNserT1/1xh+ssPn7ARZwZjWcLqGkBo1TTlWgrchI6GCwkjDzDa9nBOgZro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=FMvMNvkO; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753627467; bh=5KkCjLGin8VBSyRUFqdEAC5Ls5N/o8F13r5OT8O7IgI=;
 b=FMvMNvkOLUppX9yRr0Qhh6ag3WCLIoob45kasFLHVRwBrmIQ6aCUeER7wDZgnIyZ7V17/Epnn
 RFqd2hmw6VmSXE+an6SjYY5x+/Svha1ISbVGzgP2e7vOaa1d0sU4blsApakuYON2Op7Rhdjnj4w
 EJEolzDpGz71JvqInHvX0yVNWKRufxBiUVgtvPtz623QF0VcRAITzD++gkUZ88YkszLI1MVSfC0
 eFpDzUQBzCTYFQht0ltv1RMmcK0WzIR+sh4LyRj6kiiiK1mIjXrlcTYpHf27Z2VMejKDDhiC5Hl
 YnHJe0yxOZZQtBhzj5rXwonQlvemUgmi+vEegoGA3ceQ==
X-Forward-Email-ID: 68863b46c752737c6c09788e
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.7
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/3] dt-bindings: arm: rockchip: Add Radxa E24C
Date: Sun, 27 Jul 2025 14:44:02 +0000
Message-ID: <20250727144409.327740-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250727144409.327740-1-jonas@kwiboo.se>
References: <20250727144409.327740-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Radxa E24C is a compact, high-performance network computer
developed by Radxa, based on the Rockchip RK3528A SoC.

Add devicetree binding documentation for the Radxa E24C.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index e3d3d483de4a..15b019caefbf 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -875,9 +875,11 @@ properties:
           - const: radxa,cm3i
           - const: rockchip,rk3568
 
-      - description: Radxa E20C
+      - description: Radxa E20C/E24C
         items:
-          - const: radxa,e20c
+          - enum:
+              - radxa,e20c
+              - radxa,e24c
           - const: rockchip,rk3528
 
       - description: Radxa E52C
-- 
2.50.1


