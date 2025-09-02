Return-Path: <linux-kernel+bounces-795554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B17B3F47C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40CC61A82A61
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 05:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A912E173B;
	Tue,  2 Sep 2025 05:26:55 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF151FE451;
	Tue,  2 Sep 2025 05:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756790814; cv=none; b=moq7Z7Y6AE90/05bEPLka4t35x5o7WCcgHFddfx8Cr3NESMdzm+l7txBxhijlbV2hZhJgglHK00NYERVx/0YREnc3bXqTTLo3JwM7Flvkj2mTacU618HNlei1+f4qFCjeD+squpSljRicvGY5IrWTYZ1NjgS0eN372WmcRPGbJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756790814; c=relaxed/simple;
	bh=BfII0mWTjBQDFPNTLW0jl6aLZKx/Rg8X4WNfi2A6t8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMhViYTwhy49k3thfv4HOZi9Ck4wggNcT4fqLn/qmHTeMNWMMKs0p/R+VdOX/oE8zGnYnpK0NxvKwlrFrjtnxCcn3S3hgjDuq47VtYb5lPmNZjm7JdIenv06qIBBFa9N0u1hTg+CKTm9fS/1ESFr1O011yEBHG6G4ByQ/7MRQn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1565E68AA6; Tue,  2 Sep 2025 07:26:47 +0200 (CEST)
Date: Tue, 2 Sep 2025 07:26:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sven Peter <sven@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Nick Chan <towinchenmi@gmail.com>,
	Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 7/9] nvme: apple: Add Apple A11 support
Message-ID: <20250902052646.GA11139@lst.de>
References: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com> <20250821-t8015-nvme-v3-7-14a4178adf68@gmail.com> <20250825080710.GA23193@lst.de> <89251134-9685-439e-b220-92717663f038@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89251134-9685-439e-b220-92717663f038@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Aug 27, 2025 at 05:56:33PM +0200, Sven Peter wrote:
>> Do you want to merge this through the apple SOC tree?  If so:
>>
>> Acked-by: Christoph Hellwig <hch@lst.de>
>>
>>
>
> I don't think that's necessary since there are no build time dependencies 
> but if you want to I can take it through there.

Merging it through nvme sounds fine as well, I just through up
grabbing everything together would be easier.  I also noticed there's
another Apple hw enablement series that touches nvme, so I guess both
should go through the same tree?


