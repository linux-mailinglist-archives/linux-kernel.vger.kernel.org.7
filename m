Return-Path: <linux-kernel+bounces-736636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB15AB09FE3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF28BA88191
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3596329993B;
	Fri, 18 Jul 2025 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etIiMvpl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9612C298CC5
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752831223; cv=none; b=MwCqfdNQlZ2TPPvaC/BA8jrYUNK4AOJ1OzHFoSTfWYkq+qpJtHOtgAce2Mch2NqQmyQKdkwFEtZRhEKWU9/pvNRJJsX1sjGlHZxyk6cxyxR/iPD2L/Kuh7pDeAkbKl1qZUBxra9Nsbo5INGZ73Kh4TJD0bOFw8z/gIdmxIN0Q2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752831223; c=relaxed/simple;
	bh=yiX71oyMu9Q924Ckhjn0r4KiqSjGzxzjWsGvEymAH/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bD3fF+CqCOuSuRu3IRcDWXfduWYc0rLLhaYZR6x51bO+iIpf8DRD2B88oJ26x8vIqgs6yDrtcmzhVGjjlJICNBeL9gn/tFzc+3m+z08dpirta1uZuYS9StSOs/HNk3YcI1/dPGnLItnT+W51YXHly6D84iysF9J64gP5qlWt0rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etIiMvpl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E3DC4CEEB;
	Fri, 18 Jul 2025 09:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752831223;
	bh=yiX71oyMu9Q924Ckhjn0r4KiqSjGzxzjWsGvEymAH/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=etIiMvplr0+qs593DjpUzQ1lQfIm6rFRYQtwAYWiMoOYDIa4bg+osFUh5NaFaJrZe
	 TnGJyKS+IrrpH5HekC/tywj4cRhGaBGpRvgbMqylHEHvHDSAKfRo8nBkDKmgULd+IF
	 oPHJN5NRcdNSraQVptSzUTsTouskMy3NWIvlta14WXSpnoZs/wLySPUHQYJvnc+Mwa
	 gEQlFwCScW3CVpXmUeyd5gSRm/JRA8l8q65OVn0cjzyaE3/UsmtZSkbYqRV975n+9K
	 0oF5j9skTGfRAdPjWGRb893KaENHTxgbb3lXr5luMqe95be3MMPjq//OaY67zFd6UH
	 yAfH6q0dwHaUg==
Date: Fri, 18 Jul 2025 11:33:38 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Timothy Hayes <timothy.hayes@arm.com>
Subject: Re: [PATCH v2 0/3] irqchip/gic-v5: Fix some static checker issues
Message-ID: <aHoU8sKPuyzEFRIn@lpieralisi>
References: <736d34e1-c72e-4176-becb-00f0b27be2bf@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <736d34e1-c72e-4176-becb-00f0b27be2bf@sabinyo.mountain>

On Thu, Jul 17, 2025 at 01:45:16PM -0500, Dan Carpenter wrote:
> These are few things that Smatch complained about.
> 
> v2:
> I had a wrong goto in patch 3 so there was still a leak.
> Improve the naming.
> 
> Dan Carpenter (3):
>   irqchip/gic-v5: Delete a stray tab
>   irqchip/gic-v5: Fix forever loop in gicv5_its_create_itt_two_level()
>     error handling
>   irqchip/gic-v5: Fix error handling in  gicv5_its_irq_domain_alloc()
> 
>  drivers/irqchip/irq-gic-v5-irs.c |  2 +-
>  drivers/irqchip/irq-gic-v5-its.c | 24 ++++++++++++++++--------
>  2 files changed, 17 insertions(+), 9 deletions(-)

I reviewed and tested these fixes by injecting an error in the ITS
IRQ domain allocation path for a multi-MSI device - code failed and
the retry (that is not there in the code for obvious reasons)
succeeded, so for the series:

Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Tested-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

