Return-Path: <linux-kernel+bounces-883792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B42C2E6E3
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 00:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAB3D3BA476
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 23:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D517301473;
	Mon,  3 Nov 2025 23:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="PVbmxVvG"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B3429BDB5;
	Mon,  3 Nov 2025 23:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762213255; cv=none; b=RdSwXJ6TOmXlXpXd97havacOofp2j5q9TNBhX7oXiPSuopoAFuVCJ/xf0T5z4AKJ1KzNX6aRLuXNRnueRr57pwyiKeuTvZ/aRAxGeCoD8xBCHXC4oFXAVnMvJRJqd0ogte+koz11jSWNXCu008EGCFIE7+xmYN29ThZ1jzKGpd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762213255; c=relaxed/simple;
	bh=13BNk5M4TgX6y2PqTeJzVc0SVIvFLZ5JOrBQto9JgIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MMnd7RpaYweSMpGaKv44RHQzZY9F3G7SJsaNj6Z/+bkbYanW0yWqSiG6bwmAkR6VGQ5K1WELxjJzitXJjrY7tKijJ9M+sbYUdnBlESBT19AlwKYam5OH2Nj8psLLEXj2E/StwwIzLGDzejMC9iht6cnX+1a9BQf6Azg9iv+DP3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=PVbmxVvG; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=CFTN/83Dw7cTrDD0Xt25qXAGDTGZ+icbmJJMOc+9iGU=; b=PVbmxVvG+OYwY/Gz2fFLvDAk6I
	aAuQaPh++ttBSY15koqMj8d3uvnBDoAj16CO25TWZIcOxbmbnL2ueJ0z40pwdaEMoXOqIDr5uXlPg
	2CN1K8OMBAPpJgG86QATc2MtoGgDgTWkgyZruj/h4stAN4jksj8JEK102zJe/dh1nUCYjldpkuA5g
	VZKVjazRFkuLIwtz+n/0Xhula5ONHdLVDtKqmIktsbbBooMbMS2hovfE5QHpoq3NrckAR6lRfNZGg
	eaDWwbSQG0bvwWKv698zB9HYm5eFG/EHMQnjkgySa0WXVxHdMGip2jv5dt5m+ht+5BF7EQ1UDkeFf
	nD3CYsSQ==;
Received: from i53875a3a.versanet.de ([83.135.90.58] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vG4AK-0007rE-E8; Tue, 04 Nov 2025 00:40:48 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	michael.riesch@collabora.com
Subject: [PATCH 2/2] dt-bindings: clock: rk3568: Drop CLK_NR_CLKS define
Date: Tue,  4 Nov 2025 00:40:32 +0100
Message-ID: <20251103234032.413563-3-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251103234032.413563-1-heiko@sntech.de>
References: <20251103234032.413563-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CLK_NR_CLKS has always only be used on the driver side to calculate array
sizes should never have been part of the clock-binding.

Let's drop it, since the kernel code no longer uses it either and nothing
else has ever used it.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 include/dt-bindings/clock/rk3568-cru.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/dt-bindings/clock/rk3568-cru.h b/include/dt-bindings/clock/rk3568-cru.h
index 5263085c5b23..f01f0e9ce8f1 100644
--- a/include/dt-bindings/clock/rk3568-cru.h
+++ b/include/dt-bindings/clock/rk3568-cru.h
@@ -483,8 +483,6 @@
 
 #define PCLK_CORE_PVTM		450
 
-#define CLK_NR_CLKS		(PCLK_CORE_PVTM + 1)
-
 /* pmu soft-reset indices */
 /* pmucru_softrst_con0 */
 #define SRST_P_PDPMU_NIU	0
-- 
2.47.2


