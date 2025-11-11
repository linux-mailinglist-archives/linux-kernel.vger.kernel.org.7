Return-Path: <linux-kernel+bounces-895743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AC2C4ECD6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F39188DE18
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A22836656E;
	Tue, 11 Nov 2025 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6DPLFnr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDDC365A18
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875233; cv=none; b=CjF2NEelhAM/nCCIzLFgCG3zEY+lho3QJyZi0MD9HTHWq7nNc7GkRhcF7E3QRiHGirNQdbqV1xdt8qBwlkMJ/NPxOv8C9u/xXRE7J3dflzcxXw7wVZSCi9xqjZq1/KZbaot+VQ7LwSZC728FpdemVZBHaLa5hvKHf+LBPiZ3iNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875233; c=relaxed/simple;
	bh=e/vMQs7i8vul9GWFPsDOe5oOjV75zSf92fz9yJoigb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2eEI4lUaXDLMHJN0O3UsAR/HYPo+qEXdkKOXb/C10nQe5GqSr0DxBEa+jGDVdFIgyLE4GEOK5O8nnefF0YFtZE0uuccWRITfAV/DOC9mZmNnJjDElne/AkRgwFv0TBj+0HVWSO15OAfvjrYSw/eMJXclEOkWo2RnOXRySln0l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6DPLFnr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D18C2BC9E;
	Tue, 11 Nov 2025 15:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762875233;
	bh=e/vMQs7i8vul9GWFPsDOe5oOjV75zSf92fz9yJoigb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q6DPLFnrvzj4bh6zVLds+v54YgmJCr9tDSidzDdFgDC8Q1929HJdntESzF9HCN9o3
	 E9yGsGk4QIzHGjwv1uLvfrLMoxZAR9a6ZS36Uz6vP5E4LeHdsy9dAooruIUy2LKaE7
	 6+L2IQe0fi6mFYxO8jKxFVEJkadd1Ke4omFPC9qcndAo4RpKxqO2XnN1vBovvaqJ4d
	 MZqFuJaYFIQagJN1grcpUoTHZkbGoYLL8P+6LQkjWbNSdYBZdfhLAGj4+UJdqfYMZG
	 NOO2RG8HgNKLrN+ZYPlJnBrVlqqOK+1q+VzuGt7xIudDd45ayVUz4/eUcQVi0MYLhR
	 jRo65cWg7zAyw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vIqNX-000000000B8-1lIP;
	Tue, 11 Nov 2025 16:33:55 +0100
From: Johan Hovold <johan@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/3] clocksource/drivers/nxp-pit: Prevent driver unbind
Date: Tue, 11 Nov 2025 16:32:25 +0100
Message-ID: <20251111153226.579-3-johan@kernel.org>
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

The driver does not support unbinding (e.g. as clockevents cannot be
deregistered) so suppress the bind attributes to prevent the driver from
being unbound and rebound after registration (and disabling the timer
when reprobing fails).

Even if the driver can currently only be built-in, also switch to
builtin_platform_driver() to prevent it from being unloaded should
modular builds ever be enabled.

Fixes: bee33f22d7c3 ("clocksource/drivers/nxp-pit: Add NXP Automotive s32g2 / s32g3 support")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/clocksource/timer-nxp-pit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-nxp-pit.c b/drivers/clocksource/timer-nxp-pit.c
index 2d0a3554b6bf..d1740f18f718 100644
--- a/drivers/clocksource/timer-nxp-pit.c
+++ b/drivers/clocksource/timer-nxp-pit.c
@@ -374,9 +374,10 @@ static struct platform_driver nxp_pit_driver = {
 	.driver = {
 		.name = "nxp-pit",
 		.of_match_table = pit_timer_of_match,
+		.suppress_bind_attrs = true,
 	},
 	.probe = pit_timer_probe,
 };
-module_platform_driver(nxp_pit_driver);
+builtin_platform_driver(nxp_pit_driver);
 
 TIMER_OF_DECLARE(vf610, "fsl,vf610-pit", pit_timer_init);
-- 
2.51.0


