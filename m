Return-Path: <linux-kernel+bounces-786215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F53B356A7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75413166732
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 08:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714D72F8BC1;
	Tue, 26 Aug 2025 08:21:11 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E04D2F745B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 08:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756196471; cv=none; b=YZWDizmesPo337OtJKeCZ05mqWTDu/2c6WLBOwz6INMVVeUXxUdorQsSrhX/EeY5Y7mhpAA8zMClXbf7WiDK0ATtitpVzJ7Kv3EY+m0vqpqnOsOXzBU2soibTsw5+d12F2Us90VGQgs6GxEJlAYYRhO8b9hE4CSf6OM8/i/v1VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756196471; c=relaxed/simple;
	bh=Ecca/+43CnAcu4qhqcxuM5FAed+uSPnmXzgzfvDkrLk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5NwIqRN9WgZIL9+1ZBvIFSs2LlElR4cOBftcWpZo6MONrV2qcX7xkRwfn2hbtQhDtGkRLjXneJwL/JwQk0VnzJNoJDK7ljkNTermbzdAQVAKVLnfIKYYs7vTGxEfRJ8M0J2C2m6MlXHMniDVz1bqt61iwV4mnDYOUq9tWKqbAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 99b0226e-8255-11f0-a1a4-005056bd6ce9;
	Tue, 26 Aug 2025 11:21:01 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 26 Aug 2025 11:21:00 +0300
To: Bence =?iso-8859-1?B?Q3Pza+Fz?= <csokas.bence@prolan.hu>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v7 1/2] dma: Add devm_dma_request_chan()
Message-ID: <aK1ubIiYCOwIFM5r@pixelbook>
References: <20250610082256.400492-1-csokas.bence@prolan.hu>
 <20250610082256.400492-2-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250610082256.400492-2-csokas.bence@prolan.hu>

Tue, Jun 10, 2025 at 10:22:53AM +0200, Bence Csókás kirjoitti:
> Expand the arsenal of devm functions for DMA devices, this time for
> requesting channels.

...

> +/**
> + * devm_dma_request_chan - try to allocate an exclusive slave channel
> + * @dev:	pointer to client device structure
> + * @name:	slave channel name
> + *
> + * Returns pointer to appropriate DMA channel on success or an error pointer.
> + *
> + * The operation is managed and will be undone on driver detach.

This introduced a kernel-doc validation issue (Missing Return section).

> + */

> +

Unneeded blank line.

> +struct dma_chan *devm_dma_request_chan(struct device *dev, const char *name)

> +	struct dma_chan *chan = dma_request_chan(dev, name);
> +	int ret = 0;
> +
> +	if (!IS_ERR(chan))
> +		ret = devm_add_action_or_reset(dev, dmaenginem_release_channel, chan);
> +
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return chan;

Hmm... We usually use "error check" pattern
Compare to


	struct dma_chan *chan;
	int ret;

	chan = dma_request_chan(dev, name);
	if (IS_ERR(chan))
		return chan;

	ret = devm_add_action_or_reset(dev, dmaenginem_release_channel, chan);
	if (ret)
		return ERR_PTR(ret);

	return chan;

> +}

-- 
With Best Regards,
Andy Shevchenko



