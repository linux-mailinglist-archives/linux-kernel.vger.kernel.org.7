Return-Path: <linux-kernel+bounces-740253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E14B0D1E2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97A161890A17
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 06:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91A628B507;
	Tue, 22 Jul 2025 06:30:21 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390FB20326
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 06:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753165821; cv=none; b=hLUk/QYkxeYzWmUeIO+r+2jmeD9X6RWYeFpxqhrzKCPYODMAOww9nSC8H5m5/8eJWXSoOVmFD+bDTFNF2zCHnqVN5qE9vbRj+AOBISdQ5aV+uVKq/QeZIBZCnjFhleXaePcXgqod3U+biNqoSKaTlo0hh+vIJ1vYikgmqyYqEcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753165821; c=relaxed/simple;
	bh=BeBtRUrAZhPgUF0CyRL/DVV7LnxMk3LhS1Sm0Hw9LtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbhyC/wlRp9zogUBLpGvsiXL9Le+278QLaffeEfU5kf4bwmbIhcjY9mBaZ8JJaCOz9WEeyKzsQIo+XrPPjiBel5eMsZxlOQ6Ue9qygTH6HzYPA0j7LNM8zy/kMaCsmDiY52E1dIbOFQbVbJpvbEeDC/w/4DSVGAh1xmDfUq+e/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8FE7C68AA6; Tue, 22 Jul 2025 08:30:15 +0200 (CEST)
Date: Tue, 22 Jul 2025 08:30:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kamaljit Singh <kamaljit.singh1@wdc.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	cassel@kernel.org, dlemoal@kernel.org
Subject: Re: [PATCH v4 2/2] nvme: prevent admin controller from smart log
 fetch (LID 2)
Message-ID: <20250722063015.GC15013@lst.de>
References: <20250721173700.4153098-1-kamaljit.singh1@wdc.com> <20250721173700.4153098-3-kamaljit.singh1@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721173700.4153098-3-kamaljit.singh1@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 21, 2025 at 10:37:00AM -0700, Kamaljit Singh wrote:
> Similar to a discovery ctrl, prevent an admin-ctrl from getting a smart
> log. LID 2 is optional for admin controllers to support.
> 
> In the future when support for the newly added LID=0 (supported log
> pages) is added, GLP accesses can be made smarter by basing such calls
> on response from LID=0 reads.

Umm, as pointed out last time, this log page is prohibited for discovery
controllers, but optional for admin controllers.  So I don't see why
we want or need to skip it here.


