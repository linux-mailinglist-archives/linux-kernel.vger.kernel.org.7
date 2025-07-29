Return-Path: <linux-kernel+bounces-749408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DE1B14DE3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1C715441AF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8812D224CC;
	Tue, 29 Jul 2025 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f2tfzwpP"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B89182D0
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 12:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753793462; cv=none; b=J2jnOrdWy5C94yyV2yBzjmqrQz0KtwoaE5sHQ5iOPvrGpQ87YWSXxW+uAXHXxoP3JVLHF5hp9QOS2d2zlbSYaT1iwTPISnNEWfh86Kcu0JhgX2fYRaqf1+9MhIUddvA3Nvr5Chf9VquLgHeZk1ONW4jItLsj4/2/3Tb/XPI+zRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753793462; c=relaxed/simple;
	bh=1IT47AEYwCrCF+FILKOFR4N6iUJjZRYZctMo7alsby0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JB5QAsB6e4s+BOWwjxyxW/DBz9dkpjBwmoSkUZRdQrrmqWNBjGHkYn7uc/mxZ7m1D+Jo72MtXt2XfUS5794l/dga8LE4WMpxG+bGc7l20raV3FNKWWfgakDQ0IBA5gPiKrERhyJx9kvonXY3kEUUgSC1j8WwlGorJHqQvU0txBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f2tfzwpP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pJjEbiV5g+NYVFXOD1NeopHaTyP4OV+DoFwiBySnRy0=; b=f2tfzwpPeWAKHfEdE1Bxz0OpBo
	VHp1WpTQls9sIIxpPnNlRtqNh78tB54Mv8Fs5MbF94ruMzgkyGMxsNSZOLfO4w/9GaFlngs6QT8aL
	1CrUE4YaHzq3PzXFhLEo1lA7NMC6kcnj/7QZ0lsLMtQBH91taKBm6B2s4c4ktsa9CKycxPNN+Plcs
	3Hv8XBZheIvN5GaPXLJqUyzThZLsNFqQ+UxBgd2HWbK/JI9QrbtIjeHC15/CgEC9/D6K626A7wbyQ
	IZpfXYiQtTJ4bdTIpo1iTEL6u0cMJ1sgsJXIl33unEHxkFEB3zd0k9A8VXycb2KgbjFKEoy9lE2D4
	T41JJTDA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugjn7-0000000CRmM-2hyh;
	Tue, 29 Jul 2025 12:50:49 +0000
Date: Tue, 29 Jul 2025 13:50:49 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "akash.tyagi" <akash.tyagi@mediatek.com>
Cc: ziy@nvidia.com, david@redhat.com, surenb@google.com,
	akpm@linux-foundation.org, vbabka@suse.cz, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, mhocko@suse.com,
	jackmanb@google.com, hannes@cmpxchg.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
	chinwen.chang@mediatek.com
Subject: Re: [RFC PATCH] mm/page_alloc: Add PCP list for THP CMA
Message-ID: <aIjDqeQR7t3ZlD_C@casper.infradead.org>
References: <E70C1648-DDAB-4027-AB07-1C19B10C6AEF@nvidia.com>
 <20250729123028.1224786-1-akash.tyagi@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729123028.1224786-1-akash.tyagi@mediatek.com>

On Tue, Jul 29, 2025 at 06:00:28PM +0530, akash.tyagi wrote:
> Additionally, android kernels create cma pcp list for pages less than PAGE_ALLOC_COSTLY_ORDER, but not for THP pages.

Why bother?  If it's a CMA allocaation, just free it back to CMA
straight away.

