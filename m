Return-Path: <linux-kernel+bounces-895742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8B3C4ECEB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E77073A8CC4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD3B366573;
	Tue, 11 Nov 2025 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQzekAKi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEB6365A1E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875233; cv=none; b=snQjqYhg2sbURMoTcHnp7JCuINYZvv7JkfQiKDkh9bj18oLcuKF+gZPYg/tazSNEaB3c9jPiAFAozoAocHo0538vAfwee52f/Koq1j/aaF6z0fOvd9NZAfK7hhwHsjLV/EvtlZyfoCThEdtRoaNEv4SnmYNkKpjK4KGtDiGWH08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875233; c=relaxed/simple;
	bh=NtCYubUcGncQrTNUZ9d2vx9gyZQQSONQ+UH0cB54qQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lIurherT1xU4SzFqhH6OjS4ju4lNcsMAnZUFO0HELHtrK6C16HP75x3IyAeN+2LrLyKix/SYjR7vxNJvppSkpyMwyrx4iQ/AnoCg3OVYEwpY/n/7Cb8fdg3ZFTk1P+WRatZPRwjrUt0rEoKxc+dlJfqNmxof6LIil62BTNOBvp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQzekAKi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A0CC4AF09;
	Tue, 11 Nov 2025 15:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762875233;
	bh=NtCYubUcGncQrTNUZ9d2vx9gyZQQSONQ+UH0cB54qQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LQzekAKilQicC0T7Pvp29YNrYn1l9h52BbPdUjhgXMOIclC9GDjVSRWkMpjasWtWT
	 WqnV1BKifVEfpvuSOCoeDyVuUKHfl4fbOW69XXFc8zcyOZyqD/wFEqbdDNv2bDOE/R
	 y3gGX6Wt/UJfXyw6kEp0GkYj8tnPJHCJgl+SvsAiIw0BwkMWzpZnUhfaNQAlzZTWdv
	 1UpOliGtmI/4VrofMxQ1Yc4O5gJ8Sk1m/dafsuFgOuxQrAt1KK2Oq2BUmuJwHARoc/
	 or/oRJbBD4JS0izRSp/GdCr9+P3/aNLTUDrXG2Go1Xpsdcz1D9BhYmM2o/XS5Y7qxP
	 qdlRIO3b0X2LA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vIqNX-000000000B6-1NR5;
	Tue, 11 Nov 2025 16:33:55 +0100
From: Johan Hovold <johan@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/3] clocksource/drivers/arm_arch_timer_mmio: Prevent driver unbind
Date: Tue, 11 Nov 2025 16:32:24 +0100
Message-ID: <20251111153226.579-2-johan@kernel.org>
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

Fixes: 4891f01527bb ("clocksource/drivers/arm_arch_timer: Add standalone MMIO driver")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/clocksource/arm_arch_timer_mmio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/arm_arch_timer_mmio.c b/drivers/clocksource/arm_arch_timer_mmio.c
index ebe1987d651e..d10362692fdd 100644
--- a/drivers/clocksource/arm_arch_timer_mmio.c
+++ b/drivers/clocksource/arm_arch_timer_mmio.c
@@ -426,6 +426,7 @@ static struct platform_driver arch_timer_mmio_drv = {
 	.driver	= {
 		.name = "arch-timer-mmio",
 		.of_match_table	= arch_timer_mmio_of_table,
+		.suppress_bind_attrs = true,
 	},
 	.probe	= arch_timer_mmio_probe,
 };
@@ -434,6 +435,7 @@ builtin_platform_driver(arch_timer_mmio_drv);
 static struct platform_driver arch_timer_mmio_acpi_drv = {
 	.driver	= {
 		.name = "gtdt-arm-mmio-timer",
+		.suppress_bind_attrs = true,
 	},
 	.probe	= arch_timer_mmio_probe,
 };
-- 
2.51.0


