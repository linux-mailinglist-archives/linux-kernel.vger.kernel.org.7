Return-Path: <linux-kernel+bounces-779319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44256B2F28B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7A1B1CE1299
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CAF13D51E;
	Thu, 21 Aug 2025 08:35:53 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3954146A66
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755765353; cv=none; b=hm3fJjnu4u/+DOXtTBXSLKSRSJYC9pMonBgU+/tSjZf7eTQ5XUZC/TBbDz/NU17Slh3nxA6a6K6//MvGJrV7wTfKsU8S0Us/TsYcOqVrbrHCvdUFOal0xO52iZeBBngV8XY67QWn1iGcrPHDqrzIWPLCQc+CJdS1O8zVmRo19Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755765353; c=relaxed/simple;
	bh=lysEUEk7RrDtr0FUv+P4PfID5/YBMrJFBdUZXQ7wN2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6EHGOtGRe7vGjngdeyKDDogQZZgd0J1m4KfkU/CePFTGBt+HOekowh5qQcgQK5P2g3IxuhvP7VcnCKgz7vw6ZSFmpMFWFOM9m3T3culHi2/6tZGwDfAqjhamYKmCFVm63r/xM3tC37BnyEhyRUBABSN181G5BVO+j/CeNNrUWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 17E06227A88; Thu, 21 Aug 2025 10:35:38 +0200 (CEST)
Date: Thu, 21 Aug 2025 10:35:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, nilay@linux.ibm.com, martin.petersen@oracle.com,
	djwong@kernel.org, mcgrof@infradead.org
Subject: Re: [RFC PATCH] nvme: add an opt-in to use AWUPF
Message-ID: <20250821083537.GB29224@lst.de>
References: <20250820150220.1923826-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820150220.1923826-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Aug 20, 2025 at 03:02:20PM +0000, John Garry wrote:
> As described at [0], many parts of the atomic write specification are
> lacking.

I like your british understatement.

> +	list_for_each_entry(tmp, &subsys->ctrls, subsys_entry)
> +		nvme_queue_scan(tmp);

queueing a full rescan here seems expensive.  What about just keeping
the awupf value in our internal data structures and always use it
for the physical block size calculation, but only apply it to the
atomic limits based on a flag?


