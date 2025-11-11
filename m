Return-Path: <linux-kernel+bounces-894535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2DDC4B41D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 03:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD3A3A93D3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 02:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671AF34A773;
	Tue, 11 Nov 2025 02:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QW9nXCxG"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429D432D0EE;
	Tue, 11 Nov 2025 02:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762829725; cv=none; b=fr6k+EFlk/u7+n3F5JPvraNki6TqPXJkYXgqj77U9shR1OOq7E4eTsZgsDEdX0+oUn6mPlFc1tC5aMvLBrtm7ViUrEQxrD/ulhgpOyv6R7WSfFpXUEsL81acEGD0qb2Zh/MZRnPuhNLdUXs8+hwWpEsn2iS/Jit4cP40mNKMJao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762829725; c=relaxed/simple;
	bh=Am6cpxf9pNFg/Q8TQbd5ZIYP6XVJFT/DHNbaL0gxeUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPmdg+N7xaVL/PFgJRqLY2PfUYcJHxDQsERWZEWRGnSbEJwlBymAkziwVv+ZnbZ/k/kCdOroORxihNmMV4VfaCgWD+CIaGS5s8awjTCiJpNI4PEvG63Gi89zs2BZkImRS8vgl/ubh+dwlxLndMZzBhxE3lnZJt/dXOWJ4kgP168=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QW9nXCxG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Am6cpxf9pNFg/Q8TQbd5ZIYP6XVJFT/DHNbaL0gxeUM=; b=QW9nXCxG4HRWjEretCLVhG5rG1
	UnC3IWrR5j0YDtwYKtxw55yW58DHyNCJxlZixfPe/jb+l2NJxubx7+R81y++u+soFkQJMtIoYG0jB
	LoubwW2qNzyxcbDlijvNS2uUJYCOgmPp5TO3TgD82eZUqZrwl725YBGYsiEs+51cfCxOch0/PoItZ
	W/Tq1LRGDlZDJx3QzdZE37JhqGXU8vg6QuyaDDEzWu+blKqVB8VQOHzrVi+RPbovEVM0PZxVUvtja
	hOkwht5UZK976B8+xpm9cFvBMax2AjVklg+sfcFtBHHMr6fHaaxN/AguLLTIs3UqOBY+rH4TaQT7j
	/G1wMU/Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIeXQ-0000000CmvV-0Ee9;
	Tue, 11 Nov 2025 02:55:20 +0000
Date: Tue, 11 Nov 2025 02:55:19 +0000
From: Matthew Wilcox <willy@infradead.org>
To: ying chen <yc1082463@gmail.com>
Cc: corbet@lwn.net, tj@kernel.org, jiangshanlai@gmail.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	laoar.shao@gmail.com
Subject: Re: [PATCH] workqueue: add workqueue.mayday_initial_timeout
Message-ID: <aRKll6BXZdW2I_Wq@casper.infradead.org>
References: <CAN2Y7hwttMyUn0qsEcSBbrQ1h+aSzNpHMhgAxEbqJZn4vf5hBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN2Y7hwttMyUn0qsEcSBbrQ1h+aSzNpHMhgAxEbqJZn4vf5hBw@mail.gmail.com>

On Tue, Nov 11, 2025 at 10:52:44AM +0800, ying chen wrote:
> If creating a new worker takes longer than MAYDAY_INITIAL_TIMEOUT,
> the rescuer thread will be woken up to process works scheduled on
> @pool, resulting in sequential execution of all works. This may lead
> to a situation where one work blocks others. However, the initial
> rescue timeout defaults to 10 milliseconds, which can easily be
> triggered in heavy-load environments.

Then we should tune it automatically, not blame the admin for not tuning
this parameter.

