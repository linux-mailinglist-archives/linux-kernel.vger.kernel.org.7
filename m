Return-Path: <linux-kernel+bounces-817368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EA0B58153
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D63E202A7B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07044223DFB;
	Mon, 15 Sep 2025 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjyUCt8j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659382DC786
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757951672; cv=none; b=p42Th5SpOsNOcIyzRKpzbUU3ssTYxOlJ3g0mMUEGEhgrfxWmZBvfUyWyI8bxqtq5jUsXP3j1hIrKBLxRnFyGycJXATYs5mlTj8CEbFbMoDJrRpxgcvnOBPdAlP+bGRxBNjVfEebwR6B9uLJo7B1A7XHDgpHJhUqItTz876VMnBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757951672; c=relaxed/simple;
	bh=PU0OOPiAgbD+Iw9nQrDiwgBmr5LTIbyqLTo6qzwGXCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYkOeqYjlnPPjCiAMWljdELn4zB8g6i7cDpcWgYx1YlQUcKUmlIKlL150fjr3U+m5Oue7DJ9paM2+xOG32DD0SqzJ51q+p2LzpwQtlr6t/VjbC79KGuf80y12nI3jFLEHD6mzWKTch7oUrJRxWu0Oy+BQ4I8chMwIa92yVw/NqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjyUCt8j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C0FC4CEF1;
	Mon, 15 Sep 2025 15:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757951672;
	bh=PU0OOPiAgbD+Iw9nQrDiwgBmr5LTIbyqLTo6qzwGXCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qjyUCt8jr+g2CDJYU9PDyIz3JKdKpkvmSnINEGwkIHefL/J4iwWA42AanpSKglZDn
	 ikplR8F4zMe7fAt+9hBj6uBI3aY+twvZS//4THIsr2rCds5ul52yRmDXgzUdx1Qe48
	 Oir1h0rDknKdjzuiNK5dGC82iKk8PHtJek83UxNroAjMq6sKDExXLaLcj3n5jb9kVg
	 mFwSup0JeQpYd3idg6eBLUpDMsxeHrkNYdKkZ3cgp58xKiwgLNhHmAJw/8KtNEktAh
	 25uF4paR/es37oSYv6vPvnKxbV10ZEDUw1CQkX2yF93eEDKZFE53niwdEV42cOIyWl
	 NNrOBS7j0+dBg==
Date: Mon, 15 Sep 2025 09:54:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] nvmet-fc: fixes for blktests tests
Message-ID: <aMg2tdHWa0-dE5F8@kbusch-mbp>
References: <20250902-fix-nvmet-fc-v3-0-1ae1ecb798d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-fix-nvmet-fc-v3-0-1ae1ecb798d8@kernel.org>

On Tue, Sep 02, 2025 at 12:21:59PM +0200, Daniel Wagner wrote:
> I've added the other two patches I've recenetly send out to this series
> for getting blktests with FC more stable. So this series containts all
> the latest versions of the patches flying around.
> 
> What is missing are the changes for nvme/041. These patches need some
> more work and more review.

Thanks, applied to nvme-6.18.

