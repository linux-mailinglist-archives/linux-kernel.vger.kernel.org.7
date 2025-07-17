Return-Path: <linux-kernel+bounces-734769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD86EB0862C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A08B1A64FBD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF27219EA5;
	Thu, 17 Jul 2025 07:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiE6zT+5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709C52116F4
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752736022; cv=none; b=WmAmnhMoVwjzsvPpIcaq5gUpO3S1+JtyHXxAVSQdijOptLjMHBCYNwWQu4auCGRKkmrRplhCP62EH60lxZEcJRuFMaJOymzIsn7Lf1ZVNOUNw34lM5lfEroL+LeC6ZlgtEaAmxFZ8O5dWiCu3gjZvc0abiX1PBRmjtSlkOOhr+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752736022; c=relaxed/simple;
	bh=j9t7kSWuSxq5WnXpDlCMrUBxIWgTFqJjoe9S/Cz/rRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgzREuyavQpCGCiwny7CdGAGZoLBtdL/dDDdMLOxiuE1t1WbHdExzShU5uVERSPQVn/JMcYQYuZSk9/WewlrAXNGcrSuXiA2MHS0m5HcVb4cT3tZU7N13UXiL28fxMUesbIvVLupC2Hfwh14MeLGuA1vtE6Red/gX/k11mfnWuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiE6zT+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DDAC4CEEB;
	Thu, 17 Jul 2025 07:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752736022;
	bh=j9t7kSWuSxq5WnXpDlCMrUBxIWgTFqJjoe9S/Cz/rRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hiE6zT+5kGBFyM2dVDyrhEEwBmlPhG+WnaYKzHoeTGT1QZ+VAo47aBx5Lk8hxHFCp
	 PNqNOK9PpnPytalEhpc5cyTMTSi5zhczpJzRNPxD51fjtoGd2xY3TGUCxCwo4dz0ta
	 YidAlY4GXENk8MboR7mVmmN6qugsHFhm0CVRxmOhJ0KGOTDf8PjeL2fDcLFS+joxl0
	 AwQQYcgOxXXsCWM3i84I3ldi05snpJZtuMT5uPS1WNHvykFGwG2uYYvFYkC4ISkffy
	 IxRyFOBBzMKeINOvNJtjwa4Gs17NWTCQqVs3U0rQ3dTIvLz3JIja5tUYDu23H0sfD7
	 ps8kp9QFijQVg==
Date: Thu, 17 Jul 2025 09:06:57 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Timothy Hayes <timothy.hayes@arm.com>
Subject: Re: [PATCH 0/3] irqchip/gic-v5: Fix some static checker issues
Message-ID: <aHihEUNIPd3AVL96@lpieralisi>
References: <7feeb4d2-1033-47ba-8730-150993491ec2@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7feeb4d2-1033-47ba-8730-150993491ec2@sabinyo.mountain>

On Wed, Jul 16, 2025 at 02:37:16PM -0500, Dan Carpenter wrote:
> These are few things that Smatch complained about.  I have not tested
> these patches.  Patch 3 in particular probably needs to be reviewed
> more carefully.

Thanks a lot Dan for reporting (and fixing) them. I had a look
at the patches, [1-2] are obviously correct, patch 3 seems correct
too albeit it could be split in two and I need to test the error
handling loop.

I don't know at this stage what's best wrt applying them (where and
how).

Thanks again,
Lorenzo

> 
> Dan Carpenter (3):
>   irqchip/gic-v5: Delete a stray tab
>   irqchip/gic-v5: Fix forever loop in gicv5_its_create_itt_two_level()
>     error handling
>   irqchip/gic-v5: Fix error handling in gicv5_its_irq_domain_alloc()
> 
>  drivers/irqchip/irq-gic-v5-irs.c |  2 +-
>  drivers/irqchip/irq-gic-v5-its.c | 18 +++++++++++++-----
>  2 files changed, 14 insertions(+), 6 deletions(-)
> 
> -- 
> 2.47.2
> 

