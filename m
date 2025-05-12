Return-Path: <linux-kernel+bounces-643585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79065AB2F01
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 07:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AE84188F224
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 05:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DA6254B1B;
	Mon, 12 May 2025 05:24:52 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA642576
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 05:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747027492; cv=none; b=AOsDpkLW1HvEvAhWw9fe1M9vyZ0JfGvkHUFe4TiKSoozIo346JXkGH+YxDDli+sDvAPs6NqN6r4tiHcXDu1LGkgc6XgRTsPiq7YVtAL3fSJT12+l7FQvfAtIa9keMdzhCKuFvG2tlEnitNrPQJ24wJQTb+klrLb5tGJv0vcx1ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747027492; c=relaxed/simple;
	bh=+OAWNU/dmVNIt0GSxZPkuthMKkbjHnqnnawkKBfekMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=se3bEr9m0QFkvckUe8JuDVBkAuEYwZf9Ad/8XnHmt1zONvRkmCuYyTHJ5UvzTZWDkbAailKcLlT9lgwMDLIhg6rqcGtJTzzoYHmKbMqwXf1pVQudb0PUIvDT2qjmw+FQvHWkJU6W+o8CTV1e5sweYdZD07Toz35fCGa4L0tLVzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 41D6F68AA6; Mon, 12 May 2025 07:24:44 +0200 (CEST)
Date: Mon, 12 May 2025 07:24:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alistair Francis <alistair.francis@wdc.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] nvmet: nvmet_sq_init(): fix use of uninitialized
 variable
Message-ID: <20250512052443.GA1869@lst.de>
References: <20250509235904.915626-2-wilfred.opensource@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509235904.915626-2-wilfred.opensource@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

I've folded this into the original commit.


