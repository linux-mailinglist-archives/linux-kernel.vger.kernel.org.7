Return-Path: <linux-kernel+bounces-864226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 614D0BFA36D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7673BE1C6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6222032D;
	Wed, 22 Oct 2025 06:26:41 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136F3246BB0
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761114401; cv=none; b=Y1266X3X4yHLNcdgizOx9S9pn3W3XIthpRmqH2crln5T6w3p4CJ28NeiD2/aY+5VZBhCvj1tfLdylUNzufXk4KltVBItNK31G8BKGI+46HodA96N6oTMGqTWfqTxr+dux8tBZa6vVHGTzXk0DB4AbtYqkCxYbWR+pRqsSGvSUhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761114401; c=relaxed/simple;
	bh=7KBVRL2O9uxmP0ooA0xxQX8exoVkxwFJvtnI/i8rfBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EC59OeB5I2HlKMBdgsBrTUL/ZKU/kDuVDxKpCtJYubkMBB7Vz7wfCQfMZ0I/3XmmXjyRYhLCcHAodLhira/6UhSZKHQzZlFhtnKX3LT4rZ/0eZEjBB2dKbQfGtCQ51FS9Zd/coARWmdxuLWiyruH6h8eNfTtKC0jwL1PKLZUrPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 21F2A227A88; Wed, 22 Oct 2025 08:26:35 +0200 (CEST)
Date: Wed, 22 Oct 2025 08:26:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] nvme-pci: Print error message on failure in
 nvme_probe
Message-ID: <20251022062634.GA4790@lst.de>
References: <20251020-nvme_probefail-v1-0-a420046d98f0@linux.ibm.com> <20251020-nvme_probefail-v1-1-a420046d98f0@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020-nvme_probefail-v1-1-a420046d98f0@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 20, 2025 at 05:29:07PM +0200, Gerd Bayer wrote:
> Add a new error message like
> nvme nvme0: probe failed on 2004:00:00.0 (result: -19)
> that makes failures to probe visible in the kernel log.

Is that really a thing drivers are expected to do?  If it is generally
usefull I'd expect it to be in the driver core.

Also for nvme most "interesting" errors happen in the reset workqueue
and not in ->probe itself.

