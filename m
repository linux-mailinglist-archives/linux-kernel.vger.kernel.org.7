Return-Path: <linux-kernel+bounces-841944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83883BB8988
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 06:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39B7C19E2B48
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 04:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440801F63CD;
	Sat,  4 Oct 2025 04:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JHn+kHwf"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5094A01
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 04:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759552346; cv=none; b=GT3+r2lCCgX7rdkjdyHhUYWa8jrWTP+fxF/VnHPQ9I2HGZ18FWPgnI/M9wJW/5+t4JFSFrKg5RXknxUn5RAZ7kpOo9wr6Mtjvfkzg14t0u+1CNmawFHcz4OXzRk4KPp4fgzJrm3kE7pj7HdNDaL2fLjeyxt2wH0xu9JuU3AbX0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759552346; c=relaxed/simple;
	bh=411vSC+gvNwjdjSQuSW/ImZoKWBBzUB6nNiCNv9FYVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwIimYgFChxtAQi9dbbMvPS/xW+fvwFdjPM461Wll5g6ndnCdqzAlEiA6k69q6OTIZMMhfTlzCUrCEuyeXYVTSGB/a0h7JRiREqPrqqhSkDlt4+QqOO6u0YDEmsiPp2+jFdarargEYGjfcWmppOKn6/Y1m3ihHPGcgxg6gvOewU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JHn+kHwf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=prvzOERVRH+AqE9PQ8cMi6HAoqFte//JR8n5i3O3ODg=; b=JHn+kHwftQBPtjpNiy4aHmZ4n9
	Tx/+9J3I5byQKQtUz0JjpRQLIisVBuAyHO+yxIYdXSapo/Efn4UExLF3f2LZLYiXzY4kvYXCAsZYr
	sWsrtHPTAqVvj8PlWuc5BMwRlV5PAKyJJS81DnOXLFyjjnF1zKr6N5ImqO/esxxzoLPJUKPoixvAT
	RGI1bLxybkMNylJk5rWlIim3vjjfOlWSStvY68TaZAldhk/I6OpqDfXoojKL7xEkUs/vruDtqTb0R
	m4cw7Ewet9mzRUktOMpaiRkIEQyCM8dZt73Mihfp7L7QGZjyNSD5RR+GMuIpzdUYrfPGYseBY3V6V
	cRwYOF/g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4twX-0000000DSDP-0KHl;
	Sat, 04 Oct 2025 04:32:25 +0000
Date: Fri, 3 Oct 2025 21:32:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 6/7] lib: Give XOR_BLOCKS, RAID6_PQ config opts names
Message-ID: <aOCjWdfGG3QiT1QX@infradead.org>
References: <20251004020049.918665-1-kent.overstreet@linux.dev>
 <20251004020049.918665-7-kent.overstreet@linux.dev>
 <aOCfLTDYR83WS2CB@infradead.org>
 <73o2borvbdhb7j35zigv5ua7vgjjtt4pohbb77eolflgp5q4zu@bawkl5ykytce>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73o2borvbdhb7j35zigv5ua7vgjjtt4pohbb77eolflgp5q4zu@bawkl5ykytce>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Oct 04, 2025 at 12:29:15AM -0400, Kent Overstreet wrote:
> That's been the primary purpose of the lib/ kconfig menu. The current
> language is no longer quite as explicit as it used to be, but here's a
> recent example:

It's not the current kernel where this got fixed.  If you find others
instances, we can fix them as well.


