Return-Path: <linux-kernel+bounces-761159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0F6B1F51B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 17:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15B3F188F3CC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 15:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF41729E0E6;
	Sat,  9 Aug 2025 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QIG3Erz2"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECEB1B424D
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754752158; cv=none; b=PjXNBWf+hurP7b/zMWYCFxLDJrlhBH3kOZTre6T5PszzBqHoxJNsO62l7OKo194zFy8N0Y5eTEVuMGkswpQFdGqG1hrQ5OCJyDLnYj9G6XdN70agKSRbpaFABRFzi5FfrlTZ6PYo0lNbeij1yuqF5UKZwAkAkipr56GCzOKNwRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754752158; c=relaxed/simple;
	bh=UwKqpRKDDxRgP7s4GO+5N2tPP63JCco5WMTY2dPUmJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsNk94dGH3aTDCfdkFZQC+3KMheQSKZM8ZFJZiOJObV7CmAIcjM2oYjzqce0+28k0KM3qnLLPrY9fCyf8tj8P9d5A1f98/7IZt1/NpQmAzE4poyHxvu70zGu1K0frUQke945FKNQ2N9l1SnrTVHIa45OK8VlCg1ykvK6oSEhAA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QIG3Erz2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Kh5JpPd0ptOiYUOZ9ynxu8RlzVLFZCHO4x+p/YYs66Q=; b=QIG3Erz2tmy2zkOldagaHY1R0w
	YN3ASOLfG+/kOlfs8CwfLaBNXKI+S9An1kE9HNPvrkFgC8flBgVUIrmRk5sD+/1ngGFWjRQBibuKy
	qBOD//Xx7wz5QhjQowZy8eAciZjahDXdgAixcqZTD5KSSXppGf/V1fBi3/2vdfTy/vvVFVfqmOt+c
	A9ANy/l6JSDNpMKdBZzu4BwO0odN60SZiQFcxzug9YbJtRuu4GjAu4VozAZ6Xt3tyBMpSEBDXbziz
	kpdITreN5uz7ZOLCfhTeDz39FBOHu8+y8nwby7inbGhMsCVq5tI0lM25yUIlkjwD+UJVohtowjQEy
	PQmQ/OKQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uklC4-0000000GrcX-0zn3;
	Sat, 09 Aug 2025 15:09:12 +0000
Date: Sat, 9 Aug 2025 16:09:12 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Subrata Nath (Nokia)" <subrata.nath@nokia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: prevent RCU stalls in kswapd by adding cond_resched()
Message-ID: <aJdkmCP41RhNC9FH@casper.infradead.org>
References: <AM9PR07MB78119166E41E86BE5E7DDCC0882EA@AM9PR07MB7811.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR07MB78119166E41E86BE5E7DDCC0882EA@AM9PR07MB7811.eurprd07.prod.outlook.com>

On Sat, Aug 09, 2025 at 11:59:16AM +0000, Subrata Nath (Nokia) wrote:
> Fix this by adding cond_resched() after all spinlock release points
> in page_vma_mapped_walk() and in the main loop of shrink_zones().
> These calls, placed outside spinlock-held sections, allow voluntary
> scheduling and ensure timely quiescent state reporting, avoiding
> prolonged RCU stalls.

No.  We're removing cond_resched().  See
https://lore.kernel.org/linux-mm/87cyyfxd4k.ffs@tglx/
and many many other emails over the past few years.

