Return-Path: <linux-kernel+bounces-884648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B773DC30AC9
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 12:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4FCC189E962
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 11:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239F32E1F1F;
	Tue,  4 Nov 2025 11:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hMs8UXnu"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593152E1EFC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 11:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762254568; cv=none; b=QgkAi+puxNXsEtfeEMBe+uOwGDTTLZdaLbQgwnxcu0RQLNPmVvhx3DU1ZgBC9zo6cUjiB8CS587H64YybxQ39v6fssFyzqwRm93zT785TOVWRvgf/d1IZn8GDeWzf49LBCu6LWWCwzjvU9qDRBt12e8YZjEnrJg/RSAUuBqKtcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762254568; c=relaxed/simple;
	bh=f3jxs8g7Dv8ssBMWPEZR/dPnXfR0wvqn5N4pheZu5K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHoPbJq1C+Tye9YSYFr7eSjYM65F9Qy/96e9FUgQiT1RbipBhQHgfoYVey0NfU/yTTNQYleFBeb49cPctLy+m0FMzmUZkPYApcn3AV+RKL5y2a8cjteuOkTFQYyAEIygz1jtS+J4VwPeDD9Rtorbk3AEesdcga4M4+2te2SoNxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hMs8UXnu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=K636kHKOtARt/ZcJFrFL1GtxK5zuMOMIE2/8C0vPMVU=; b=hMs8UXnus5ZoQ2JWbzy5WPT/jE
	dC9J4jgIbzuAwapymMIaYrdKWo/Qfao52h/MNjzrrjg50MD0EocdENbyV3gj8mfMxLeBEwbEfQW1J
	2+j2od9RN/iAln3j+1/jbVlToitPUwzc1exSjUnJXyl2rYXX+k20Mk/e4Lhpk1xJTTdRSA55Zlq2x
	xxzqKTgSdkm08soAB9hgDQCWkS6rZctCu09DQYHyluTgVTNyPu0Eo6FZtmICpJwGxWTF5bMg078ko
	iwnADhIygRztrPaSQ8d9QgeNl/Riia60WxT8+fqfpgIhHOsTF3Vu4uwg9Q/hNZTaKyb3hY+8CzmBT
	XQc/zZ2g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGEuk-0000000Bgu6-3a3O;
	Tue, 04 Nov 2025 11:09:26 +0000
Date: Tue, 4 Nov 2025 03:09:26 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH v2 1/4] mm/vmalloc: warn on invalid vmalloc gfp flags
Message-ID: <aQne5je7dTkaf7Lv@infradead.org>
References: <20251103190429.104747-1-vishal.moola@gmail.com>
 <20251103190429.104747-2-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103190429.104747-2-vishal.moola@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 03, 2025 at 11:04:26AM -0800, Vishal Moola (Oracle) wrote:
> Vmalloc explicitly supports a list of flags, but we never enforce them.
> vmalloc has been trying to handle unsupported flags by clearing and
> setting flags wherever necessary. This is messy and makes the code
> harder to understand, when we could simply check for a supported input
> immediately instead.
> 
> Define a helper mask and function telling callers they have passed in
> invalid flags, and clear those unsupported vmalloc flags.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

And just for the record:  I very much suspect we'll find someone
passing unsuported flags soon with this hidden somewhere that will
need fixing or at least temporarily extending the mask.


