Return-Path: <linux-kernel+bounces-785644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE51B34EEF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 00:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459B7207AC7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA08D23ABA9;
	Mon, 25 Aug 2025 22:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlworCGf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA6323026B;
	Mon, 25 Aug 2025 22:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756160520; cv=none; b=C5S20ePEJV1D5U4ijVSWBQsUs9Nduv9n8Bu2yXvwLSXP+Z0C2JcLJFN2eGR86ssSy+TYMgxmQnYaWg2nEgX33iclMgdZNcMOBzQaMr59UVrfbAVZt7zHAmPrYky8gin/saO/Xf1GRwiNGlBQQi6GcC0L0uqgIb0ZWyxSwDCQaWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756160520; c=relaxed/simple;
	bh=96rEtlr/wVeNGcUVV2rp/lcVxCnwOxL8kgWk+EHrEBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfWDso44+Xht0CXp0NrcQXuXY0Pls6/i/JjPoHVsJwyroObslwJJtyWNl6IDa6K9viqsUH5T5qFq6nkSR20S4Y7/v8IE6xb8Sa64O0iE5qdaItBCEWQW/QvB/oXBWplRFAORe6h8BKBimGCf8A4XquQBHp/MB2qNzPh2NQPP7ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlworCGf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A611C4CEED;
	Mon, 25 Aug 2025 22:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756160518;
	bh=96rEtlr/wVeNGcUVV2rp/lcVxCnwOxL8kgWk+EHrEBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rlworCGfJZghHIW6KraZlUHCJifNHTnwNHVUxcNBAFJPxSXfKMhKSfJxX5/uWfivr
	 Ce8NX0F/VBU3IYHGzrAZAa2/kjltHh01uepzFQlLoMWKiY6F7fQAlU9aYRpp1Ky5u8
	 aNXHwckNzXUQs4ySBBllJeqft4HSklujIyGXKb0WiXSuKbe1N3ClekdWQk7Sc8F22E
	 3UkecWeotABBk5p1ckLimgpHuZKlHMEnU6/ov/gWV7TK+pif6933/PrEn8tupGkjhH
	 WK/fakAqKeT0T7N6EcZkBJbeYWZ2j0QsO3y3YB6LCULeSE/WKZN/3Cq4v+YuD4f3ut
	 PN6UNm/j0QLlA==
Date: Mon, 25 Aug 2025 17:21:57 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] of/irq: Convert of_msi_map_id() callers to of_msi_xlate()
Message-ID: <175616051613.748925.14127647667836301013.robh@kernel.org>
References: <20250805133443.936955-1-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805133443.936955-1-lpieralisi@kernel.org>


On Tue, 05 Aug 2025 15:34:43 +0200, Lorenzo Pieralisi wrote:
> With the introduction of the of_msi_xlate() function, the OF layer
> provides an API to map a device ID and retrieve the MSI controller
> node the ID is mapped to with a single call.
> 
> of_msi_map_id() is currently used to map a deviceID to a specific
> MSI controller node; of_msi_xlate() can be used for that purpose
> too, there is no need to keep the two functions.
> 
> Convert of_msi_map_id() to of_msi_xlate() calls and update the
> of_msi_xlate() documentation to describe how the struct device_node
> pointer passed in should be set-up to either provide the MSI controller
> node target or receive its pointer upon mapping completion.
> 
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> ---
> As suggested by RobH:
> 
> https://lore.kernel.org/lkml/20250627213241.GA168190-robh@kernel.org/
> 
>  drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c |  2 +-
>  drivers/of/irq.c                            | 25 +++++----------------
>  drivers/pci/msi/irqdomain.c                 |  2 +-
>  include/linux/of_irq.h                      |  6 -----
>  4 files changed, 7 insertions(+), 28 deletions(-)
> 

Applied, thanks!


