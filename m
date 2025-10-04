Return-Path: <linux-kernel+bounces-841939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5667ABB8951
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 06:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23C7C4E2C78
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 04:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C82D215F6B;
	Sat,  4 Oct 2025 04:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1dyFHIFi"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A206B23CB
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 04:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759551283; cv=none; b=q4iTEC9k/O2wIwG4U4ubemxU7pMWpk5t2bcAyHzZBFmGqxwWaJNxmchKQtYd7XhUMWSBtQFlpZN+W+nmmi0XXCOTNYwZ3ne1RTLLGvBYbomR45Lj9cw8125sVhPndekz5NYV39HvQAImJBG9d9qa/NvI69IMIhbfGwc7qeepQVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759551283; c=relaxed/simple;
	bh=UZxSWZ3NsD7ekBl93jkZDMfDfDKGOuYwWYjGTGP8gQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGl6C/I2GxOxQv7agVEKXrBtckeFCB+B8fU6GvDczM7F1/KmIdczs/CL+HHVS+1YWUT7NqyKht3AxEdWgjl2ysGEwflakVkIdDHVhgaIL2LwCN3i6kJB7iKGsNFHLqyjYHNEZKNbg2II0x8hMJoWJ4vv6ZJYXiGdo2khB+JXkTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1dyFHIFi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0N9e1tpkfiMHaTa6nj0tYfEjaNPIk1YRUO1PEpbrJk8=; b=1dyFHIFiOXWsqK/BdR2bx71Dg1
	bC1bE7iTetLgW6G1N+h9b60KZa0EBsj3oQFiISm3vZRDx5yS8HI7DUWV4MapPD8qbfc567Uv4hScY
	wDA9P2k688jao3HMdlJZYxQQsB8+UNczM+TZRAvhyWvVArlndS1VrZeNhiJmqLNsuZXrnC+dj9XdH
	YQDJXPZvyiUJ+kqnVk8brWbVpalEICkn/x5VfELZ9Gf2FJ+Ss7DTTYotwZVF/boFgPkVLKp6WbdIc
	ODiom0RFX6n4koubb3RBTujWfl05bJy40NxipQ+EPm9fp83mNX7MD2jiAl+9vv+z8lnmXRhIF7l+w
	EZmKp/lA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4tfK-0000000DRTK-03te;
	Sat, 04 Oct 2025 04:14:38 +0000
Date: Fri, 3 Oct 2025 21:14:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 6/7] lib: Give XOR_BLOCKS, RAID6_PQ config opts names
Message-ID: <aOCfLTDYR83WS2CB@infradead.org>
References: <20251004020049.918665-1-kent.overstreet@linux.dev>
 <20251004020049.918665-7-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251004020049.918665-7-kent.overstreet@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 03, 2025 at 10:00:48PM -0400, Kent Overstreet wrote:
> Give these config options names so that they show up under the "Library
> routes" kernel configuration menu, and can be enabled by distributions.
> 
> These are needed for bcachefs to be built out of tree.

We do not add hooks for out of tree code, and this applies to you just
like for everyone else.


