Return-Path: <linux-kernel+bounces-866460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 954B7BFFD09
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6B118873A6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7E02EBDEB;
	Thu, 23 Oct 2025 08:13:32 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53631257845
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207212; cv=none; b=aN4KwwA1FupRbJDAuvZyliQojLJJWDcn9CZNziRup6/9gvhVeUPBIxDLKMlpVw8yszw5/jMR1HwMweJQBsa91ko3SzE1Ukz3YKLOYr0ht9dfmD/UX8OkIWbrTpvs5C7JNBdp1IjXkerxjbqC70rByrnoagUrbVz3KWzW/ZYI56k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207212; c=relaxed/simple;
	bh=aUVZkGx3uk0UOU6xbtrLAhOPdkefe3ftw20cMZHMSdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1da+U1oAyRDCAmJvL/+YYMe2CBph2ECxFRcGeAxLtKrSahKdvuoZh4+dPvlWFBHDylhZGj1wKA5RYZJW9vOHKeBrk2iMT+8FQWXQTvWbplXhWyG2fmd9YFHxzdm+j2sbFHednFW4N2ITYLyQZzssIOLRpEP+i4febGrb91A/lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4BC05227A8E; Thu, 23 Oct 2025 10:13:25 +0200 (CEST)
Date: Thu, 23 Oct 2025 10:13:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] nvme-pci: Print error message on failure in
 nvme_probe
Message-ID: <20251023081325.GA302@lst.de>
References: <20251022-nvme_probefail-v2-0-26bbdf94280e@linux.ibm.com> <20251022-nvme_probefail-v2-1-26bbdf94280e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022-nvme_probefail-v2-1-26bbdf94280e@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 22, 2025 at 12:33:16PM +0200, Gerd Bayer wrote:
> Add a new error message that makes failures to probe visible in the
> kernel log, like:
> nvme 0008:00:00.0: error -ENODEV: probe failed
> 
> This highlights issues with a particular device right away instead of
> leaving users to search for missing drives.
> 
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


