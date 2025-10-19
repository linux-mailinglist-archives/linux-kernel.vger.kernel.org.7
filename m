Return-Path: <linux-kernel+bounces-859495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FDCBEDD57
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 02:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 848E718A1812
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 00:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B1218A6CF;
	Sun, 19 Oct 2025 00:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZmqW0tBY"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF58238D
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 00:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760833933; cv=none; b=VDGKD4dW+tIooW+BPRus8murHzL9T0Fk/RtTTafcRR7fbuq/ruRBGBOnvM4CfNpnqoZbOFLyGChfxDZpj0cEkmtIBqcBcEIpaLil0XiGmD/lDbnsmgCiNXuBWIEMdFrcTyAkn6Zq1pYwp/cG5KjZuIQoH+Q1KPJovFjtx6/DFD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760833933; c=relaxed/simple;
	bh=K1LpFrkuZxYUoJjkjLzsl43muGPOFa0yP0Rfx07YSqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJz31dugqbsPmIn7Ftxaptp6vxhgzIlMNQmgEzt2c/aG/N3AWDew1PJMPSR4zcnOxUXrdvfSgtwA08hoLdg8RvU8w2c8E4yD0vo41P8uEOJRVQBdBaiVz7tZ/xphKlrDCzNo8qohdtyvi2u8XyWynGvQlCz8HigqIHAhMFivyV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZmqW0tBY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bDwpCJk3xs4cweUC7JTSnq7g+gl/B04N8QtBpC33QWU=; b=ZmqW0tBYLxzSCCUm7Qcs3VwJwB
	aXLfR1zJzPtROayNES+PAMWAiz5Ee8NvuDzRYfAPoP9Hi7WKSeCM+CQGOdZ6Omwr3roXI/Gted7nM
	j2e4xm9k8uqo6eDwelETHOX50BLZRWD+0bKcJf1T4ydiNp+yZS01iKqa3h2c73cbT4k9FjFEv5La1
	euGydgCCSzfRZpe1TX2LQZLhJUg7qnHDxCAC2tPSQdaqo5/BOfk2BAoPYw9ZjGPgjvWPP9ozotE9R
	RqhWBUVaRrKtrBg0+f0Zfyru5RV2n4Rfgnzwm4ny41AUHB3SwNbbFXQnXMtXf0ORFQfbexMXdlhCT
	524gkQYQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAHLA-00000000ZsS-1go6;
	Sun, 19 Oct 2025 00:32:04 +0000
Date: Sun, 19 Oct 2025 01:32:04 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Huiwen He <hehuiwen@kylinos.cn>, maple-tree@lists.infradead.org,
	linux-mm@kvack.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrew Ballance <andrewjballance@gmail.com>
Subject: Re: [PATCH] maple_tree: Fix potential NULL pointer dereference if
 mas_pop_node() fails
Message-ID: <aPQxhMH0CSZm86Lk@casper.infradead.org>
References: <20251018152305.1612722-1-hehuiwen@kylinos.cn>
 <9092f8af-72d9-472e-8d5c-f950c8ce782d@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9092f8af-72d9-472e-8d5c-f950c8ce782d@web.de>

On Sat, Oct 18, 2025 at 06:38:11PM +0200, Markus Elfring wrote:
> > mas_pop_node() may return NULL when memory allocation fails or when
> > mas->sheaf is invalid. Several callers of mas_pop_node() did not check
> > the return value and directly dereferenced the pointer, which could
> > lead to a NULL pointer dereference and kernel crash.
> 
> Will another imperative wording approach become more helpful for an improved
> change description?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.18-rc1#n94

Markus, stop this.  You've been told before.

