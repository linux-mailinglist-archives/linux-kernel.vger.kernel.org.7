Return-Path: <linux-kernel+bounces-730016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F680B03F29
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9523189DE49
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333582475CF;
	Mon, 14 Jul 2025 13:02:44 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA4C134A8
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752498163; cv=none; b=Doie3ZARuwzwKlzYUTMiVGltKqFkzqaR2UULPovLDrNYl8hX02VcVtNyYE1qSt51ckPVHi/XX4hzWGoGL7PNBGFsaYqf+BeMNAqtVUEUu9qxRrwPs1h1J42q/D9ZDLkdFBvNojcl4r1s/gujRPzYnfLCjlhXHPAR9LcFyVgRBLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752498163; c=relaxed/simple;
	bh=QJ59oWudwDTZxpVVYwyyyirIdNah5pUv/UiITKRqoJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbF2pxyqe9qF7xqs4zvtHISjPk41Hl1npy/BUuPIE+0J2eGQe3vMubrMJU1A3lae6PK6rAIqKgiOr1TnsHRR223+N/YiiS+qrVnzZo27Kts3rusKr6qCVEVdbTE5ZZGCU2P/YGyD1nH2NUkXhVH8f0eZSHSdpN98hDWUs/oFyOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 50B22227A88; Mon, 14 Jul 2025 15:02:31 +0200 (CEST)
Date: Mon, 14 Jul 2025 15:02:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Joel Granados <joel.granados@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Klaus Jensen <k.jensen@samsung.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/8] nvme: Add Controller Data Queue to the nvme
 driver
Message-ID: <20250714130230.GA7752@lst.de>
References: <20250714-jag-cdq-v1-0-01e027d256d5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714-jag-cdq-v1-0-01e027d256d5@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 14, 2025 at 11:15:31AM +0200, Joel Granados wrote:
> Motivation
> ==========
> The main motivation is to enable Controller Data Queues as described in
> the 2.2 revision of the NVME base specification. This series places the
> kernel as an intermediary between the NVME controller producing CDQ
> entries and the user space process consuming them. It is general enough
> to encompass different use cases that require controller initiated
> communication delivered outside the regular I/O traffic streams (like
> LBA tracking for example).

That's rather blurbish.  The only use case for CDQs in NVMe 2.2 is
tracking of dirty LBAs for live migration, and the live migration
feature in 2.2 is completely broken because the hyperscalers wanted
to win a point.  So for CDQs to be useful in Linux we'll need the
proper live migration still under heavy development.  With that I'd
very much expect the kernel to manage the CDQs just like any other
queue, and not a random user ioctl.  So what would be the use case for
a user controlled CDQ?


