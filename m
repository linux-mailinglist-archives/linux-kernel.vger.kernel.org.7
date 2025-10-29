Return-Path: <linux-kernel+bounces-875349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99636C18C25
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B1664036CE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDF830FC33;
	Wed, 29 Oct 2025 07:44:11 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0686A30CD84
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761723851; cv=none; b=knS+wDy3G+0YmkLYzJmq4D8xqGmLwxeU+b+oQpi8cpj7M2AnUuHpxIb3aEz3Iy0twuInFDUrBSZtVFq3gn81ak5uTgYaRjb8a02PJ1d1BpkcckobMKFiAIVl7oXWvPhjs2Mt/GuwKRiVgNt2a41iG0E6RQaz3yUceUXjc/liCKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761723851; c=relaxed/simple;
	bh=Cl6jeGaofwbmSJrbF75/Xe97g8hjhZXPSj2A7vSAlSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HooBoyDnHhdWSRuWF6dns68BKFesXTmuzicYv3JyrNpqhURXMgVxT+KguZMYXXjpNFXVKDrkQT0/qGO+sr4+kzA60YyMY3B5U5WVI+6nFLsBKp4Y6ktdbQK9ArXETyid4AakuW0Bm1yyh5/6a7AR/8n+Jacujh6FGT71AE9sTFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 11554227A88; Wed, 29 Oct 2025 08:44:04 +0100 (CET)
Date: Wed, 29 Oct 2025 08:44:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	John Meneghini <jmeneghi@redhat.com>,
	Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH] nvme: drop bogus nid quirk for multipath devices which
 passed id test
Message-ID: <20251029074403.GA30412@lst.de>
References: <20251028-bogus-id-check-v1-1-c087a98b5466@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028-bogus-id-check-v1-1-c087a98b5466@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 28, 2025 at 01:54:56PM +0100, Daniel Wagner wrote:
> Obviously, using the correct IDs is really hard. There are at least two devices
> which share a the device id and one needs the bogus id workaround the other
> doesn't.
> 
> We discussed the idea to pass through configuration from the kernel command line
> at ALPSS. I am not sure, how far we got with this yet. What about something like
> this here?

The Intel devices are dual ported and multipath cabable, too.  Which
isn't surprising at the dell one is just an OEM version of them.

But more imporantly dropping the quirk for multipath devices is
fundamentally the wrong thing to do, as we really need proper IDs for
multipathing.  So just add another entry for the Dell device using
the dell subvendor/subdevice id that does not have the quirk.


