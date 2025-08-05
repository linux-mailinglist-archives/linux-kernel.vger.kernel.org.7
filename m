Return-Path: <linux-kernel+bounces-756191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4ABBB1B10F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011BC189EC7B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130F7267AF6;
	Tue,  5 Aug 2025 09:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UisXez2S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1942652B4
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 09:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754386216; cv=none; b=bbg7sIw2d8ra7rgVPyo4RS3kObop7+WhWI/QXemDCoW6TFfCFboPJvEjGTuECHtblNDvqGXdZyk636hQ+1jfj1Loc6JcO+IQ5/6etW9gvSsXKZy5ThUhFz+dz/R/RAiJFxh/cFZzV9WYmw2AlLihD4BkyKoAxxyNAuXGQ2Jwvo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754386216; c=relaxed/simple;
	bh=5UL00lu4xZn/SVf3QC30fPZtl2/7wiyTldeA5ZwXXoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxlzgjmx8fQNpOnkgG/wDfF4xz/hwy5LQb9P08hO2aA0N3byv2awrMP5O+R6B3HR7akO8Xp9eNSOErQVyxGuYGS5eAWM48/0KbOTMGPnaAUHiYU1uQLJy8OFBDznZPPW8C7mrAhHBsubE2/QklKnpF5HB5s81062xeWHu5ew8Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UisXez2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A532C4CEF0;
	Tue,  5 Aug 2025 09:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754386216;
	bh=5UL00lu4xZn/SVf3QC30fPZtl2/7wiyTldeA5ZwXXoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UisXez2SMuX7vliFgFd7tUEQG80nciTOaO7y238OZvizTdN0nOEfxJjHul/rCwGZ2
	 9WvAOO5qiyikZs5itcJisc41sR067BEFLsvtfQdDNSVCsMqYSnpAEwb9DO/GLuCzzC
	 OZSSLh4Q6w2ieMGyDcuOVd+uoAbONiyMx4QdmmrtBsVi7uDLAy0L2FI9PTOXtV266a
	 z1khto4C0dRIOWYVo0EH4NjXL7xZYRYPDU13TW75av+o/Juzm1LeIp29r8xx0WGX+8
	 V3tohp9cziypxtyXUOJSn2IdDzPwPdwK1Pc71EyniohDq6CiolXQeE847ym1qkr8eV
	 /SwevBaw52jhQ==
Date: Tue, 5 Aug 2025 11:30:11 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Timothy Hayes <timothy.hayes@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 0/3] irqchip/gic-v5: Minor clean-ups/fixes
Message-ID: <aJHPI8xRtleEx+3r@lpieralisi>
References: <20250801-gic-v5-fixes-6-17-v1-0-4fcedaccf9e6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801-gic-v5-fixes-6-17-v1-0-4fcedaccf9e6@kernel.org>

On Fri, Aug 01, 2025 at 09:58:17AM +0200, Lorenzo Pieralisi wrote:
> A trivial fix for a kbot reported issue and two clean-ups
> discovered after the initial series was queued for v6.17;
> now that the driver code is merged I am sharing them.
> 
> Only patch (1) is a fix, the two others are cleaning the code up
> and removing useless constructs.
> 
> The series apply cleanly on top of this three-patch series [1] fixing
> some exit path issues with the gic-v5 driver that should also
> be considered for merging please (I reviewed it and tested it [2]):

Hi Thomas, Marc,

thank you for reviewing and pulling these fixes, please also consider
fixes in [1] below that are still current, Dan sent them before the
series was queued for -next and I reviewed/tested them (in particular
patch (3) - others are obvious).

Thanks,
Lorenzo

> 
> [1] https://lore.kernel.org/lkml/670bb1dc-7827-4916-84f3-bb46ee408b20@sabinyo.mountain/
> [2] https://lore.kernel.org/lkml/aHoU8sKPuyzEFRIn@lpieralisi/
> 
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> ---
> Lorenzo Pieralisi (3):
>       irqchip/gic-v5: iwb: Fix iounmap probe failure path
>       irqchip/gic-v5: iwb: Remove module boilerplate
>       irqchip/gic-v5: Remove IRQD_RESEND_WHEN_IN_PROGRESS for ITS IRQs
> 
>  drivers/irqchip/irq-gic-v5-its.c |  1 -
>  drivers/irqchip/irq-gic-v5-iwb.c | 14 +++-----------
>  2 files changed, 3 insertions(+), 12 deletions(-)
> ---
> base-commit: 260f6f4fda93c8485c8037865c941b42b9cba5d2
> change-id: 20250731-gic-v5-fixes-6-17-949eae3c5594
> 
> Best regards,
> -- 
> Lorenzo Pieralisi <lpieralisi@kernel.org>
> 

