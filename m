Return-Path: <linux-kernel+bounces-880317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46276C257B3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0C94563284
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018F932C936;
	Fri, 31 Oct 2025 14:05:50 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF5122A4D6
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761919549; cv=none; b=Fb7VqJWaIvLbBGUEnvDgWELTg0kXpqsgRARxLfVXr7LePeQ0/j1up+R/Vzi89JGHaXXi6ouP3lEpvfxIA1Le+A4jrprygvwXrPI8sp/XRFHiMcXxn4D2VDSxH9dqL1WW2Yur2CJBMFUzmK85jK8lWgaCpg4+XFpiL0/iWJgfIIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761919549; c=relaxed/simple;
	bh=hWrYXqEI3tri+2vKEYQcP6uvloWU2cgm4HWAzk5l9Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDioxg3WCDVXBq46vlpGpi0lkSfEkc7/Z23trsAxtluMqehV+U0E+06xwe/i2wkndZH+W2FShlJCJTbSMVqhFSFxLNFyBmaalmOMx3PJF5YU2I7zM4OAspcSdDHfY2NJzVVSsgI0Z/jKCKKYlyjSjv6DBKItD0o2PvL4E/pzoAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0B336227A88; Fri, 31 Oct 2025 15:05:42 +0100 (CET)
Date: Fri, 31 Oct 2025 15:05:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	hare@suse.de, kch@nvidia.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 3/3] nvme: Allow reauth from sysfs
Message-ID: <20251031140541.GB17006@lst.de>
References: <20251030035114.16840-1-alistair.francis@wdc.com> <20251030035114.16840-4-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030035114.16840-4-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 30, 2025 at 01:51:14PM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Allow userspace to trigger a reauth (REPLACETLSPSK) from sysfs.
> This can be done by writing the queue ID to te sysfs file.
> 
> echo 0 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/replace_psk
> 
> Note that only QID 0 (admin queue) is supported.

Why pass the queue ID then instead of a boolean value?

> +static ssize_t nvme_sysfs_replace_psk(struct device *dev,
> +				      struct device_attribute *attr, const char *buf,
> +				      size_t count)

Overly long line.  And very inefficient annoyoing to modify indentation
compared to:

static ssize_t nvme_sysfs_replace_psk(struct device *dev,
		struct device_attribute *attr, const char *buf, size_t count)

> +	rc = kstrtoint(buf, 10, &qid);
> +	if (rc)
> +		return rc;

Nitpick, but nvme style is to use the slightly more descriptive
error and not "rc" which doesn't mean much in general.


