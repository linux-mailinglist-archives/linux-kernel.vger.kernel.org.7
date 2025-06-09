Return-Path: <linux-kernel+bounces-677255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A96AD1868
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 07:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 267883AC9F3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 05:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4672427FD7F;
	Mon,  9 Jun 2025 05:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gnj797qV"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F2A610D;
	Mon,  9 Jun 2025 05:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749448269; cv=none; b=QDUf6oJndewvFFGNSXpQw4asIe9UlC0Yk2ymxOKx8duCIhWEWvU3Iblhs14EuY+4wQOgOxI9/70SaZvxG/YWKF69IS09/1ynXtuikstwLI3ykBY6gktmrnZrmd9/3wvgofe+DAES3gk1r+bQv0ANDu3T/8yn3DIQ8oVVEkwq2EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749448269; c=relaxed/simple;
	bh=PxjVqm/eXXAF8NTPJtYxzTaZ0/Wdl7H979xMQ53MYnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cghF6nOPrTGCB9Bl6MQ2oBgT8Aq+et5HJWeJeZfkJhFAMJE1x4rfzNPLo00+fJoDRmVoq0F4hDwgOaX5pLuK7UiP3H80rGOJby3CkDyaeGbrQIRdWBSMq/O8jskCU3fKCRS6dQnn5Bi2+ovyfaLCltMgc1dfkGO74Y4r7QB9FAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Gnj797qV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5+yC4cHoWa3km4DkL5LnggBUHvFkOZKQ6IEpZnGeOp4=; b=Gnj797qVqsixob0/0kEyeX4fwD
	/5DZOVLNbFOmI4avA085r/63lWaNv8J4PxpQQnMoURKM9Q6kx08cpm/BNs01LK7tOTPbYApGIqEaY
	gUYH4PGtCeW36+ryEBYl8Gy/0wxRN+HUQzlvxiaqWR3Fb/wrTZwrbBu0E2OObQQ8Ox3cpKcx7PlDd
	2D4gI4XuL9gI1tG6kJqA2OFMDKm/+4fggznuzCjxmbdw4Mmi0pnXmzcUte0eLDWRnwr4luVf7tj/j
	V65WUdNsXZ93xmVzQy4VC5VscCElsyqY5/mUNrVlBxvTjyfj7N5WIPfEyKlmI4pglMAHB/jYBKBpK
	P4RRZPHg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOVPV-00000003Ty4-1vgV;
	Mon, 09 Jun 2025 05:51:05 +0000
Date: Sun, 8 Jun 2025 22:51:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: jasowang@redhat.com, Yongji Xie <xieyongji@bytedance.com>,
	Cindy Lu <lulu@redhat.com>, linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Laurent Vivier <lvivier@redhat.com>
Subject: Re: [RFC 0/6] Add multiple address spaces support to VDUSE
Message-ID: <aEZ2SYAXdqffWoqk@infradead.org>
References: <20250606115012.1331551-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606115012.1331551-1-eperezma@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Before you add new features to vduse, please remove the broken abuse of
the DMA API first.  Without that no new feature work should go into
this code.


