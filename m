Return-Path: <linux-kernel+bounces-896752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22ED8C5121B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C47C3ADA33
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F05B2F6176;
	Wed, 12 Nov 2025 08:32:12 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732932F25FB
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762936332; cv=none; b=fbdlAQn+FACLbG/jDZo3bJxlwfeb6W+hqX4BUMZw9/861UZXmqf/3GnZ+qQJky86+37FlD6TN7kYtm30OcJhaFyxl8zTrOS6ntCV+fnWNAET5T1iYDGJK7ZThJ704KcVh6+eKsUCdZbyMC6W4wSqv9vwdDTz14drFQkBrT+3fzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762936332; c=relaxed/simple;
	bh=BRgudIymazOk2utu/3m2CJjnAQ90SxLXkszEmWDO6wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiPBkXWsRb8K+ul0zXxhbIWfyQGymnDmX8AKVwtQFFrp4FvAlXLQfuKhvqK6jrxINTew5V+p26k1jARuF3HMaUoo9qSeKJqnLHlgf4GdkD1KXWJ+jThKX7JUPRhAPpZTVRqUGpHAG1mOTyqrH0B5osoFkk8X0NyzOTW5MqcWHDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BF2F1227A88; Wed, 12 Nov 2025 09:32:03 +0100 (CET)
Date: Wed, 12 Nov 2025 09:32:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Alistair Francis <alistair23@gmail.com>,
	kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	kch@nvidia.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 3/3] nvme: Allow reauth from sysfs
Message-ID: <20251112083203.GA7838@lst.de>
References: <20251030035114.16840-1-alistair.francis@wdc.com> <20251030035114.16840-4-alistair.francis@wdc.com> <8a236ca6-3675-461a-9166-4d4df3b5de08@suse.de> <CAKmqyKO=W2+5ZBudWhN_L1choupte9vzJBEoxVeZ-vNHykeR0Q@mail.gmail.com> <20251112070256.GA5276@lst.de> <c7679208-c963-4fdd-a038-a91ccda0a075@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7679208-c963-4fdd-a038-a91ccda0a075@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 12, 2025 at 08:21:41AM +0100, Hannes Reinecke wrote:
>
> 'tls_configured_key' prints out the value of
> ctrl->opts->tls_key, ie the key passed in from the 'connect'
> string. Normally this value will be empty,
> as the 'connect' command will pick up the TLS key from
> the keyring automatically.
>
> 'tls_key' prints out the value of
> ctrl->tls_pskid, ie the value of the _negotiated_ key.
>
> So why is 'tls_configured_key' key the better option?
> Personally I think that 'tls_key' is more 'natural',
> as we want to replace the negotiated key, not the
> configured key ...

I've not even looked into what is better, but accepting anything
without validity checking tends to always bite us later.


