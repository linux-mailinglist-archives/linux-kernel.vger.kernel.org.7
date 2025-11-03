Return-Path: <linux-kernel+bounces-883013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2563DC2C483
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454773B9F18
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E8E302770;
	Mon,  3 Nov 2025 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bmiRX0tr"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A786F272E63
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762177869; cv=none; b=gh0GN1j+yHTPx4F441TZy9VrOOPK5PD9b3SsSvB9YRjlN0iJugtG0TwokBgPrGAPVhKqxA6/nI96kjn8AXFzX6BHtIocSVSf0Xm94s7xLLhbYft/w5J183JicN+4mgQeUDl0S1AKpJLgRhKOdN/a6qMfCHSybqn/RfgbJeN7zx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762177869; c=relaxed/simple;
	bh=uSJ5MFtzv8QRsnhy/ddyi/son0cmHhiAqNrZLpnU6G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4O2SE+FvIdWV60EbSEcAVRF+XnCAeK0fqG8Go4m22ATz44yuILZVhgJVLwKcakNOvH80GDZF0LKy4mJ1Jb1iZ214lIXx5bP+H3oW9qP7rNxohWNTMAgP/8LQGIEnICY7E48CxtwOjx/qG8PFSnTNGE/gQ48VMaCoSJbB84Qvfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bmiRX0tr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uSJ5MFtzv8QRsnhy/ddyi/son0cmHhiAqNrZLpnU6G8=; b=bmiRX0trHcMFvaR7QUOgLfSZ3X
	Ns8Gpd/T/XZxm3vPareoub6JhZ1fweJZoAD6gvUKMrSoWfppLk1XnZAlCFhhhNZIF78W+FWPwpH/M
	sqcBljkLPcLnlLQdVBh4FS9JjOn7sqfj41XT6KQNpM/3Y1Intsgl0NraZ1ns9gFKY31qM2v4kQRrK
	I/40C89vXsKeKM1uaXpVADfAewVaoZ9UaZ8fL+2AnLfk41YHBXDABfytqmxBZIaqIriattecpHaWK
	IhCcgpy3mDnWbP1vzlvJZQ4+Cy657bMf89UR8gD0N/YEQEou8liJF2OTOjfSzNciStuHV3j6QiTIN
	1OgSN+Lg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFuxc-00000009xaT-3sdc;
	Mon, 03 Nov 2025 13:51:04 +0000
Date: Mon, 3 Nov 2025 05:51:04 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 0/4] make vmalloc gfp flags usage more apparent
Message-ID: <aQizSPAvNGmgpnxa@infradead.org>
References: <20251030164330.44995-1-vishal.moola@gmail.com>
 <aQimnV815XIjV2JT@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQimnV815XIjV2JT@pc636>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 03, 2025 at 01:57:01PM +0100, Uladzislau Rezki wrote:
> > I did some digging and am not entirely sure what flags vmalloc does NOT
> > support. Is a better idea is to have explicitly supported flags and drop
> > all others?
> >
> Maybe we should look at it vice versa. Focus on supported flags. In the
> slab there is an adjust function which modifies the gfp and emits the warning
> if passed GFP is part of buggy mask.

Yes, explicitly whitelisting the (component)flags supported seems like
a much more maintainable approach.


