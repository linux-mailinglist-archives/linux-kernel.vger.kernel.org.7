Return-Path: <linux-kernel+bounces-840099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AEFBB3872
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 11:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF3343B5F5F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 09:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7385E306B1A;
	Thu,  2 Oct 2025 09:56:56 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB84530648F;
	Thu,  2 Oct 2025 09:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759399016; cv=none; b=KeLNMLRTMXO4re6OF5c/Z7CJGPqdqPdHVdxVutfLT4KlFlFOnt78pVQpPRlhniKeCza0NeamtOCt0kZFctrzvWw5uxYvtaunHbQNEL2/w2iJ9EaMRdM0xZ/f5RGGIwqRxKV2PIfL5+Ip7pWiB72g+4A9RkJz6o05f/wfj5GJ57k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759399016; c=relaxed/simple;
	bh=zJ7FdG5jkEdCxQ+ymCwGmnFI8FwVMKxp6a2HnPd094g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mCUfQcx/FBnsleJTJLtRdU2f1H2Ph1uBQWjpy8AyIOl7ILoxr02h6pWYpBdbJRUjqdj6d/0OtO3TjadHbFnenSFOfQF3tqKaR2rxstVMv3/rsxbYt/jbCaML+cg0at6r607h80mdRZSFGhcr9qS2mVf0E5RTnG7XwOepuuxXmF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 2 Oct
 2025 17:56:51 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 2 Oct 2025 17:56:51 +0800
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] dt-bindings: clock: Add AST2500/AST2600 VIDEO reset definition
Date: Thu, 2 Oct 2025 17:56:51 +0800
Message-ID: <20251002095651.2211900-1-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add VIDEO reset bit definition for AST2500/AST2600.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 include/dt-bindings/clock/aspeed-clock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/aspeed-clock.h b/include/dt-bindings/clock/aspeed-clock.h
index 06d568382c77..421ca577c1b2 100644
--- a/include/dt-bindings/clock/aspeed-clock.h
+++ b/include/dt-bindings/clock/aspeed-clock.h
@@ -53,5 +53,6 @@
 #define ASPEED_RESET_AHB		8
 #define ASPEED_RESET_CRT1		9
 #define ASPEED_RESET_HACE		10
+#define ASPEED_RESET_VIDEO		21
 
 #endif

base-commit: 7f7072574127c9e971cad83a0274e86f6275c0d5
prerequisite-patch-id: 80cfedcb62367922b1e875e8e734ced8f7cc19ba
prerequisite-patch-id: d74dc2e0aff712f033ca5c2f299410ae92867d8c
-- 
2.25.1


