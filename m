Return-Path: <linux-kernel+bounces-751001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7ADB163EE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC5818C8039
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60462DCF76;
	Wed, 30 Jul 2025 15:53:43 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685722DCF45
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 15:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753890823; cv=none; b=m2mrLwsqn7y2iGbtyHyAqvb8PI6gazFHDLaG5EJGLAURlv5CkQ8MIYO6snaZjp9xsRZNZ3krRmCTJdj4KjbSKf2qk7Nmqip7XqS68BjbJ8ogJPkE6U8asbIpUCMfgLGrnR6doeOGQn56kpbYI7mHIlpiXCqjI2oQeTGgXjpimHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753890823; c=relaxed/simple;
	bh=GMTZgr4xBWFXompW7o6OC9Jp7/agq8k0ZmNnxTnFzAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2MTTHeeqyWhw/hpbjU/seirmLMxUQZD0gdNSVfJo7AwqLSl6GipP9SCCcgpQdKQwejb3i/OLXIYaeLXN4lMTD6wil//eU6KgvZDgTFE0oLKASLS5CcXOdVu/COg5tSXRKoDui7Zn1VCwra8PYEy+hrsdnyHYhC/7ehSiEBKXac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E6CB468B05; Wed, 30 Jul 2025 17:53:35 +0200 (CEST)
Date: Wed, 30 Jul 2025 17:53:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: Remove unnecessary assignment to ret in
 nvmet_ns_enable()
Message-ID: <20250730155335.GB19799@lst.de>
References: <20250725230639.2017274-1-mkhalfella@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725230639.2017274-1-mkhalfella@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jul 25, 2025 at 04:06:39PM -0700, Mohamed Khalfella wrote:
> Commit 74d16965d7ac ("nvmet-loop: avoid using mutex in IO hotpath")
> moved checking maximum number of namespaces in subsystem from
> nvmet_ns_enable() to nvmet_ns_alloc(). The assignment to ret in
> nvmet_ns_enable() is no longer needed, remove it.

This assignment already is gone in the current tree.


