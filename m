Return-Path: <linux-kernel+bounces-767362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD27B25357
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0CC722EE5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B672FF149;
	Wed, 13 Aug 2025 18:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGGQFzHT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920A9155CB3;
	Wed, 13 Aug 2025 18:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755111165; cv=none; b=oCjhwbja58ISYq1FIiST+GdQv5M1qeoOwIvOS+X6yNCW9w65Us9G3jE/o2u3vfcAjVmh/zukzX0zIWdcm93W8RF0R5IjDypOvfrEuDlzfX+1LBpGIwwhV5yF6i7CVTDWSBIbfmxT6/zbAKnlVmGRoCxTMMVIJWgr9p8t1kXVGZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755111165; c=relaxed/simple;
	bh=I8r3tBkgphht3SwtUg5nL9KzEgLdeknTCCzdfgQO5b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhwPrI/AOsneR9os8WS6lRliU8s4qjtcdp2YIC/2WsmGygTIW/Lv2UE2HcBw6sOWrWNOmuorA1QXIw5ytSfOkIfepp/qmKyLcJqMo2Cj2BSKfDFt7it2o9hPT2bxwvPf0Ukwitiutcc01Dxc09bodr5IKeTgJdQRmt4TzIF1bXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGGQFzHT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8478C4CEEB;
	Wed, 13 Aug 2025 18:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755111165;
	bh=I8r3tBkgphht3SwtUg5nL9KzEgLdeknTCCzdfgQO5b4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fGGQFzHTOutY+PikQOg+P+YHiU6NjTociyTwlUlMKJNB909IdYw+OmZ514aIBwUs1
	 4dU57N13Jqjkoh53Tqk7MoBxkLa9cYBLd+fphd5tjEnN4YsVyTDJiI8PZo4aNayqNF
	 cfCwRyAcwrvqeUStvHdnotiJzLpsxSm1iT19dxR8xEypH5xBPt4HPSTuo7K9yXf26E
	 UgStl/gwBTGBOnu61VjcwfVKX7u/FTfcqEtgBCi/PD76cmwdP6rXqfMW9Cu9FZvM6o
	 MtvtvEohCqNZ/Ukws+f1+wuFo8M/e5nAKepbnCtqmcgxvUZKODgK78EZ/wYQp1dxWh
	 4ISy8/MduRniA==
Date: Wed, 13 Aug 2025 13:52:44 -0500
From: Rob Herring <robh@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] of/irq: Convert of_msi_map_id() callers to of_msi_xlate()
Message-ID: <20250813185244.GA553867-robh@kernel.org>
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

On Tue, Aug 05, 2025 at 03:34:43PM +0200, Lorenzo Pieralisi wrote:
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

Looks good to me. I'm happy to take it with some acks.

Rob

