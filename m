Return-Path: <linux-kernel+bounces-864392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A20CBFAAF0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA3A0356858
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137922FD7D3;
	Wed, 22 Oct 2025 07:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b58lm7+w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4F62FD1C6
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761119322; cv=none; b=PsvAKeRpRmZ1j1CHfqIy7xAE4WvI5bXO3F4UZhdyzM6XxD0s37LC1nXQ0JiAfM2AhdAAUVkp/UZkxRPrScXURxL4oaQ43IUj+7sR0L37Qaz35grJtjbVV+PZGx3ZA3J3Ay51F0m9fWyYybMEXJUPypWqBVBppg8gEx26Tfe8wVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761119322; c=relaxed/simple;
	bh=hg7ZnStODXk0tmaNXauC9GSR5tXux7ipULBbQ6CkS2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgfFGLBFmABlGxqzlBY9wY7Z2ZlD58enFVj5vfEQmBudD/dfXI1JwWbnj0GzNJlgQY+tmRV8Bm7Qnkf6Y/EaoNVuZVbBf7b6SNJRg6YOHBWpMvUFQIl3JC7EoOm+b2tnmXeo6hm7gXnpqCJv7ZDKLgWDmir3++XjymmVaGtYh4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b58lm7+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D07C4CEE7;
	Wed, 22 Oct 2025 07:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761119321;
	bh=hg7ZnStODXk0tmaNXauC9GSR5tXux7ipULBbQ6CkS2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b58lm7+wL0fRgZMY5Gh+tA/3XTEhcmmzr4oHWEEFeDU/BagECZHcN8XJEIxa2eB1k
	 f108R3zMg+KsB2OH1v7du+IyYLsP2sQhy6Cu5iOvxAlsfKF4yKGJQZYzcnVL7EIDjE
	 OEfg4hPtReB70EUEUUjAnbJ5JEeUbmnOFB1W7Kg4=
Date: Wed, 22 Oct 2025 09:48:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Gerd Bayer <gbayer@linux.ibm.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme-pci: Print error message on failure in
 nvme_probe
Message-ID: <2025102230-omega-octopus-3cf1@gregkh>
References: <20251020-nvme_probefail-v1-0-a420046d98f0@linux.ibm.com>
 <20251020-nvme_probefail-v1-1-a420046d98f0@linux.ibm.com>
 <20251022062634.GA4790@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022062634.GA4790@lst.de>

On Wed, Oct 22, 2025 at 08:26:34AM +0200, Christoph Hellwig wrote:
> On Mon, Oct 20, 2025 at 05:29:07PM +0200, Gerd Bayer wrote:
> > Add a new error message like
> > nvme nvme0: probe failed on 2004:00:00.0 (result: -19)
> > that makes failures to probe visible in the kernel log.
> 
> Is that really a thing drivers are expected to do?  If it is generally
> usefull I'd expect it to be in the driver core.

We have that already, dev_err_probe(), no need to create
yet-another-version of that.

thanks,

greg k-h

