Return-Path: <linux-kernel+bounces-810704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A18DB51E25
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 374FB5E16A8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FDA27602F;
	Wed, 10 Sep 2025 16:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ad5ItL8i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA8E26E17A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522840; cv=none; b=j7zxzifJzAEsRZcfpsr42jLGQsv7zFxHEor6ydCyqY6Ubb/YvEjDTS2xkI33xYUY28DvPQ/LGUW77XvHGJPP0+KY7slXEFHvZMopOdDMS8/CB4ba09/qaaVTncyzjt64mx+ohiuwZr/LX1SCIQNABBoR6ZLvrP8Yt40vAT0GSik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522840; c=relaxed/simple;
	bh=Z+t15aECbrtdH0Qhho1BJCHW5HvMZbzNXsR5fDu8BLk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WYtm0Ru3qsjyQNis0SG/v7TG1PWk1L4TqeCwv1lHOv2Pq0T1S99S9uUMaS2sFmWdpu553Y7BLGwX39ZPgjRK+JAfayzszMfEBN6ybO2hlDZGaFO9N/APnG88Oih61SDXX72TyTvorWAS1f1hzTvtxUyQqxt4xMR4KcyuPRTL+cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ad5ItL8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6F0C4CEEB;
	Wed, 10 Sep 2025 16:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757522839;
	bh=Z+t15aECbrtdH0Qhho1BJCHW5HvMZbzNXsR5fDu8BLk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ad5ItL8iQA7wSTwPPslRKE0/JwJ2f3sAcvYtIZY22KrHwqJtmvleXhLbbZUE52KOl
	 B2D8en1oqLsdUApzNcGYPUVt5cBXCSBggG7ZKva1kq81KpSsYPEcrVy7PObmdM1mwn
	 FYlWF6AelK+NgR/Y2PcWWv5pPUmfUPKmOC2BSId7Hn/yQU4I9fEMEx9tIGU3GKvVH5
	 XWisX+aA9WSSbCP5iUU0LLVbo7Dp2J0nbS23FdglxeoVIyWJByL0iEczAXwBmZDWrX
	 07T3OV9DVha5ThXcNErQOJWSDbnvVvU0+e2VB8CSsm43/cAKIPDV5/B9bxn0qQGWj/
	 fjJi8dR2qASBg==
From: Vinod Koul <vkoul@kernel.org>
To: kishon@kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Devarsh Thakkar <devarsht@ti.com>
Cc: aradhya.bhatia@linux.dev, s-jain1@ti.com, r-donadkar@ti.com, 
 tomi.valkeinen@ideasonboard.com, j-choudhary@ti.com, a0512644@ti.com
In-Reply-To: <20250704125915.1224738-1-devarsht@ti.com>
References: <20250704125915.1224738-1-devarsht@ti.com>
Subject: Re: [PATCH v4 0/2] Fix PLL lock timeout and calibration wait time
Message-Id: <175752283611.484319.1968162513387724056.b4-ty@kernel.org>
Date: Wed, 10 Sep 2025 22:17:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 04 Jul 2025 18:29:13 +0530, Devarsh Thakkar wrote:
> This fixes PLL lockup and O_CMN_READY timeout by moving the polling
> function after common state machine gets enabled. Also fix the
> calibration wait time to optimize the polling time.
> 
> NOTE: This needs to be applied on top of
>   https://lore.kernel.org/all/20250618-cdns-dsi-impro-v4-4-862c841dbe02@ideasonboard.com/
>   https://lore.kernel.org/all/20250618-cdns-dsi-impro-v4-5-862c841dbe02@ideasonboard.com/
>   from the series:
>   https://lore.kernel.org/all/20250618-cdns-dsi-impro-v4-0-862c841dbe02@ideasonboard.com/
> 
> [...]

Applied, thanks!

[1/2] phy: cadence: cdns-dphy: Fix PLL lock and O_CMN_READY polling
      commit: 284fb19a3ffb1083c3ad9c00d29749d09dddb99c
[2/2] phy: cadence: cdns-dphy: Update calibration wait time for startup state machine
      commit: 2c27aaee934a1b5229152fe33a14f1fdf50da143

Best regards,
-- 
~Vinod



