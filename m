Return-Path: <linux-kernel+bounces-896631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAB7C50D48
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12BF1886BD9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAB92E92DA;
	Wed, 12 Nov 2025 06:57:00 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A942E0926
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930619; cv=none; b=T/pWvXzOc4HMJrQ+n9eOxqCsM9AlouehOLLkhrooqGnsiFxoaHp35IVXgLyGMFuL4zNx7kQENg816QhGTEIirJkRYAIgWBIdgs0wo5pOOFirZDmKs+vRXcGJuz+fBwTByptrFqyWFa6MhM///J9e7x1D0ZskoL7FJyaxfviOF48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930619; c=relaxed/simple;
	bh=1Buu3x5HyUGPfPzgce1j6PfWF9hG0JCszolcnvbpZ0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPsCfwguAJ7EHoPNCIB4lzkUw9ycBYj4YXV/Lsh9LG8ucihceNXYGohn6po/wLpI0t4vpzF+QrEdqOQNWyLUmQXGsuHPxFucsWy2Zi1JTqzMXeSH+1CMM6NZq0Gg4g5jFxMh1xIWGX7MvWtRu2FxB/rupbK2jjC7XkxbnDZRVVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8F0FC227A88; Wed, 12 Nov 2025 07:56:53 +0100 (CET)
Date: Wed, 12 Nov 2025 07:56:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	hare@suse.de, kch@nvidia.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2 4/4] nvme: Allow reauth from sysfs
Message-ID: <20251112065653.GE4873@lst.de>
References: <20251111234519.3467440-1-alistair.francis@wdc.com> <20251111234519.3467440-5-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111234519.3467440-5-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 12, 2025 at 09:45:18AM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Allow userspace to trigger a reauth (REPLACETLSPSK) from sysfs.
> This can be done by writing to the sysfs file.
> 
> echo 0 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/tls_configured_key

This now takes absolutely any write, right?  I think we should at least
be strict to force some value, and document it.

Which reminds me that Documentation/ABI/testing/sysfs-* is missing a
lot of nvme attributes it seems :(


