Return-Path: <linux-kernel+bounces-895744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C939C4ECE8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 755CB3B3B6B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98526366575;
	Tue, 11 Nov 2025 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOAfjzTZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CC136654B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875234; cv=none; b=JitGiN+K3q7x6ioI/5q16pSd/LY/vXMatRGPcMueZ2DMJoQZK5cV8n+wYpzM0blKLj0DdOweWHsWt3B2EtgFpG5yRRt4s5gcz9LjTOHQ1mLjSC05Hovi3r5gx6ZfEXSeUmcnbjrSFOLku3yK0veZgS8g1eohpiBCUHFoZ21HdwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875234; c=relaxed/simple;
	bh=gXahYykNL12JzsF8XfhT6IadYUTkpChvyIc/NtcuehA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqklqSDKlLGMpOoN7k6m3xaKlxgcN4NjRVauCKltM4+9BFFIVqUghkJswbfbR5qet94kj+8RpjmU0jsiLUHpsnyqC3A31QU10pmQcrc87UcToYwS1cEPTHKEwz0L5zosVf9JeDB2sqZkM/qdvDUmc96XMRo94NolRE5JoMzSIp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOAfjzTZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB4EC19423;
	Tue, 11 Nov 2025 15:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762875233;
	bh=gXahYykNL12JzsF8XfhT6IadYUTkpChvyIc/NtcuehA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hOAfjzTZYhWHlmQN0CmxsvcZ/8xMM+ckhQ5idYpyxrDqHF2ELsNKiwGKGpDfEGGGz
	 Siod01ulw0O8u3TncEcEjbGSI0k0YnggfV7VOC6pBq/oe/itB2CQYEJVAceiFTbAX6
	 CaCLmK5SkUPkYf3Km9zaXqjbQPTUO08zJHTwrX75/6AqKST4Y8C3uEMasegEwIcug2
	 LgLcPQ9Fh9+AfHR8QoqB86CfVG6oXjvdsE3lXmY02NWuKaAaNnVAqAZZ9F7MDmLdLt
	 twuXUQyT/5fgZtsOPI0dFHcrG3dGVKAcr2jZsIMgClt5Wj3ankr/Y/A7eF5UrlAK/0
	 3iKTdnDza221Q==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vIqNX-000000000BB-28xv;
	Tue, 11 Nov 2025 16:33:55 +0100
From: Johan Hovold <johan@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/3] clocksource/drivers/nxp-stm: Prevent driver unbind
Date: Tue, 11 Nov 2025 16:32:26 +0100
Message-ID: <20251111153226.579-4-johan@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251111153226.579-1-johan@kernel.org>
References: <20251111153226.579-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clockevents cannot be deregistered so suppress the bind attributes to
prevent the driver from being unbound and releasing the underlying
resources after registration.

Even if the driver can currently only be built-in, also switch to
builtin_platform_driver() to prevent it from being unloaded should
modular builds ever be enabled.

Fixes: cec32ac75827 ("clocksource/drivers/nxp-timer: Add the System Timer Module for the s32gx platforms")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/clocksource/timer-nxp-stm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-nxp-stm.c b/drivers/clocksource/timer-nxp-stm.c
index c320d764b12e..1ab907233f48 100644
--- a/drivers/clocksource/timer-nxp-stm.c
+++ b/drivers/clocksource/timer-nxp-stm.c
@@ -487,9 +487,10 @@ static struct platform_driver nxp_stm_driver = {
 	.driver	= {
 		.name		= "nxp-stm",
 		.of_match_table	= nxp_stm_of_match,
+		.suppress_bind_attrs = true,
 	},
 };
-module_platform_driver(nxp_stm_driver);
+builtin_platform_driver(nxp_stm_driver);
 
 MODULE_DESCRIPTION("NXP System Timer Module driver");
 MODULE_LICENSE("GPL");
-- 
2.51.0


