Return-Path: <linux-kernel+bounces-738738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA7FB0BC7A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1695B1724CE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 06:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D19426E70C;
	Mon, 21 Jul 2025 06:26:07 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B712AD04
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753079167; cv=none; b=uRmMQpUnV6yYaMi0RPNn33z201QjCv7623WYebfDAFqNFYou5HoyCVLtQETXmsE9enCLOTeI/6Kuokitt4XHSU+IU0isls0KTh7N1d+5QO6eECNiEX5Fcp0Y7PGzV0J75FB+oc1TmEw+X1sozPvwNYB7CXeYqMKZBn5+3pP7vUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753079167; c=relaxed/simple;
	bh=AwpLY7EbWsOdpzEv1EsGSeym2rHI8iqPutv6BppbmAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jt9fXs6H09j4mYdD+ttA5ZYDpnNhof35sCBtUjvFQLw2uvQs8YgzMPBnlBnvic1p/+Wb25/Uyh00XW9rXaxmh37lE+JqJ5r5zqYRMLjLuY1opqy+3pUB0WCBB0IqqiTN36rnSqSPByTdq08BcmbyAt1VMsBftE+NqLdDgGEa0oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7425B68AFE; Mon, 21 Jul 2025 08:26:00 +0200 (CEST)
Date: Mon, 21 Jul 2025 08:26:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Joel Granados <joel.granados@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Klaus Jensen <k.jensen@samsung.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/8] nvme: Add Controller Data Queue to the nvme
 driver
Message-ID: <20250721062600.GA28867@lst.de>
References: <20250714-jag-cdq-v1-0-01e027d256d5@kernel.org> <20250714130230.GA7752@lst.de> <fjnpyvjn2kqlmlzagvuy43numc7u44ylls3nqxay4sh5qjayv5@xq2ty7wipbg5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fjnpyvjn2kqlmlzagvuy43numc7u44ylls3nqxay4sh5qjayv5@xq2ty7wipbg5>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jul 18, 2025 at 01:33:34PM +0200, Joel Granados wrote:
> > to win a point.  So for CDQs to be useful in Linux we'll need the
> > proper live migration still under heavy development.  With that I'd
> Do you mean in the specification body or patch series in the mailing
> lists?

Actual code.  As I said I very much expect CDQ creation and usage
to be kernel driven for live migration.

> > very much expect the kernel to manage the CDQs just like any other
> > queue, and not a random user ioctl.
> This is a great segue to a question: If CDQ is like any other queue,
> what is the best way of handling the lack of CDQ submission queues?
> Something like snooping all submissions for these CDQs and triggering a
> CDQ consume on every submission?

I don't understand this question and proposed answer at all all.

> I went with the ioctl as the faster way to get it to work;

Get _what_ to work?

> I might
> explore what having it as just another queue would look like.
> 
> > So what would be the use case for a user controlled CDQ?
> Do you mean a hypothetical list besides LM in NVME 2.2?

As out line in the last two mails I don't see how live migration would
work with user controlled CDQs.  Maybe I'm wrong, but nothing in this
thread seems to even try to explain how that would work.

