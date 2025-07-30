Return-Path: <linux-kernel+bounces-751118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F163B1656F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E27D1AA3C27
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2E82DECD4;
	Wed, 30 Jul 2025 17:24:20 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4121F4E4F
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896260; cv=none; b=Qgnstq66NZgcQNP1Hw6aV8cPajkOvXD58uLvZDVGPyJbdW9pvV4XXw7CI9+QKaICS31umu258AZ9UiWdage8i5aBM+0rOCov7xc8EKG3qo65D6h04eFzNMJ4EYRDWFZrtU8imlypZUXW0MNrd8e6uwcdSD2XiMw2ETDdrqZKaew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896260; c=relaxed/simple;
	bh=grAIJUCbumu3rfA5qCg4K9aApXmg5HRCgVpsKK6XyAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilHxNCtDOZRY8BwDTHIj07Y13ufbZX+B3/NwCPczLf1qVmebS071FOeMsWeUYstAzmAvga9a6pVkunTBI5QQ0EUfZfQVNDlRP5BMXzxMqlqaxCkiR+1TaD87DHgYImPWgNLdd8PNx4a7gQSLLF7G3Qpk+NxFuzAIMXX9rfw0JKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D0A3668BFE; Wed, 30 Jul 2025 19:24:11 +0200 (CEST)
Date: Wed, 30 Jul 2025 19:24:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] nvme: Fix typos
Message-ID: <20250730172411.GB23500@lst.de>
References: <20250730162321.GA22255@lst.de> <20250730171003.GA3369524@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730171003.GA3369524@bhelgaas>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 30, 2025 at 12:10:03PM -0500, Bjorn Helgaas wrote:
> On Wed, Jul 30, 2025 at 06:23:21PM +0200, Christoph Hellwig wrote:
> > On Wed, Jul 23, 2025 at 03:27:51PM -0500, Bjorn Helgaas wrote:
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > 
> > > Fix typos in comments.
> > 
> > This created multiple rejects.  Can you resend against the current
> > tree?  If you don't want to deal with the nvme tree, maybe resend
> > just before/after rc1?
> 
> Sure, will do.  I'll rebase on nvme/nvme-6.17 (e97c0040215f
> ("nvme-auth: remove unneeded semicolon")) now, and if that's not the
> right branch, let me know and I'll redo it around -rc1.

That is the correct branch.


