Return-Path: <linux-kernel+bounces-765288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FDBB22E26
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8352A62222F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E2F2FD1CE;
	Tue, 12 Aug 2025 16:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7Td/XYS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7D52FA0EA
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016895; cv=none; b=Q2Eb8pFMFB0HvIH/9uKxSG2S/ag333Cdx5Pf4OoLbdA234Fnvwsjz58gp7c0UFK7sXRlyjBN6xq4a5pn7hBXgenbLucEjr2amPnaxbvZh2XvuQwc/2u35ETZBWraWGXzOzUmw/nmiLMrffgANGiluqJxtpGowpCsmiHRDpQNUQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016895; c=relaxed/simple;
	bh=Cz71HGZiV10OArJiGd1SueEwh2yw/h1hDPVhk8eQoqU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OBxDDvHSf9daxiLcnGKitJWomonssUlS1hirMB78V0VQs0YtjTNI7brWTZBnMD2q0acXPiG9r8Zq8IYKGJLltZ5LRgoCRzksBoNoAuR7rNlyBzRnLM2/s+5GJ58704fwSLm/HS7fgxM0wRBLAveby+kFmegHbvTNS54CLGhhTEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7Td/XYS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A91C4CEF0;
	Tue, 12 Aug 2025 16:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755016895;
	bh=Cz71HGZiV10OArJiGd1SueEwh2yw/h1hDPVhk8eQoqU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=A7Td/XYS7kBFYP4p5YSjKxxvUHupGJ4gpMnTI1ZhtBf1+KXExRfczfZWjfvjbSjlf
	 AUnD4z/FKP7v5FlPuUKjyIyPYPIlHVsYDv57/SKPvPFRUCLmBHMickl70bMweLF0RO
	 9iHamuSPiDIpTGfMRFPevWyUHzXhN/guR/43BT0HT9UAU2Q6JFXc/KzTZUdRTGF+VM
	 P+IwLZNi0wHySQjH4Zs9ePNWLzYYRYx+9nDI7hb9NV+wT/IuYbJFN01kiALOpaG8zC
	 wZdnod1gMWoewwbRg2fz0wX/AZskl1G9z1ebDtFOBCS2Zk2qhPL6QEiJoXlsZ4cBbH
	 xv0KLpuV9hLLw==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 Devarsh Thakkar <devarsht@ti.com>, Francesco Dolcini <francesco@dolcini.it>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, 
 Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20250723-cdns-dphy-hs-clk-rate-fix-v1-0-d4539d44cbe7@ideasonboard.com>
References: <20250723-cdns-dphy-hs-clk-rate-fix-v1-0-d4539d44cbe7@ideasonboard.com>
Subject: Re: [PATCH 0/2] phy: cdns-dphy: hs-clk improvement and a cleanup
Message-Id: <175501689198.633310.10908708738197218310.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 22:11:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 23 Jul 2025 13:01:27 +0300, Tomi Valkeinen wrote:
> A cdns-dphy improvement to return the actual hs clock rate, and a
> cleanup to remove leftover code.
> 
> These were part of a Cadence DSI series:
> 
> https://lore.kernel.org/all/20250618-cdns-dsi-impro-v4-0-862c841dbe02%40ideasonboard.com/
> 
> [...]

Applied, thanks!

[1/2] phy: cdns-dphy: Store hs_clk_rate and return it
      commit: 7ac3644d1e82ae6c7ad3767a3f2594faffd12264
[2/2] phy: cdns-dphy: Remove leftover code
      commit: b659c5cc993767a42ad1a712dd357522099c5c37

Best regards,
-- 
~Vinod



