Return-Path: <linux-kernel+bounces-872076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 28666C0F368
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8B904EAEF8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845CB3112DA;
	Mon, 27 Oct 2025 16:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4+HHYC3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94D5310627
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581588; cv=none; b=jV5OXiEPhSGT+RnFwQl5/TenWXQ3vrrUvtN3NKC34VG84Dra33jJR2pK6tpd9p2WmLrfhff1UseSJJX4WTDcngr06F2VEh2CJw2qr7IH/zX0tga4a43zcQIEERAlIu+xKwl2b512qc4ezJFklXGO3/HrX9IQ0AIDwtfCS8SHTjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581588; c=relaxed/simple;
	bh=0PIq5ISPDC4bpmeH5MEVkOz1Ty661z9UYQuZx703q50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kv4YmEczFlC4cdAWW1E6eCpw2Sh8xf5+bkGFR6W+45VY+jqiB4Qu6nGjHzFazmzLwVmqdqAUYDU9//E4d0JJ1HR2bNW/JV+eLkXiWnJCtm4+6BD/7uwp1AcZkFr3gAvgamIlJ6gJ4pIhuBxH1Lr8+5ifLOsLczNiT1B87ADpnxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4+HHYC3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B669C4CEF1;
	Mon, 27 Oct 2025 16:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761581585;
	bh=0PIq5ISPDC4bpmeH5MEVkOz1Ty661z9UYQuZx703q50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I4+HHYC3HFcb6OGPu+drD1Zdtd2C+BvH6NkqklJZ+OV0lq+FRMxmknxe70lvfN6ZT
	 UfdaR68MIj+47bvvQccgYR67Mg6rv3eK+/v+oxTJCdrh5GTdOe2nP2MRdI9Yffml+5
	 ukposD/w0Nyxf09yjYhsiEIQCopK0ET9ErofvfJlSDTXyqkfKsIrN8N6eINFXk1IPX
	 HzfOOu3AVWSDZ0ys2qJJZexGm7rrA7AEQ/PHLct3gLeNbL6wc2yzZB2qrFyMentJkr
	 ra/YKLlekuCgHV/Y1YTfA/9ji7xJPnrTFRw1UiPzBer7YuDrreW4XBwTAGe6wEVIxZ
	 OF5ejLHmUFtEg==
Date: Mon, 27 Oct 2025 10:13:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	John Garry <john.g.garry@oracle.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] nvme-pci: Log failures to probe
Message-ID: <aP-aD_Mh3ttRkxay@kbusch-mbp>
References: <20251024-nvme_probefail-v3-0-5386f905378b@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024-nvme_probefail-v3-0-5386f905378b@linux.ibm.com>

On Fri, Oct 24, 2025 at 01:05:30PM +0200, Gerd Bayer wrote:
> occasionally, an NVMe drive fails to reply to MMIO reads despite the PCI
> link being operational. In these situations (obviously not on the
> boot-device :) it is preferred to have this reported in the kernel log
> instead of deducing that something is wrong by comparing expectated vs.
> observed number of nvme devices.

Thanks, applied to nvme-6.19.

