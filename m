Return-Path: <linux-kernel+bounces-808947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64016B506C2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2F8C7B79CB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD84B302157;
	Tue,  9 Sep 2025 20:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="woqRKFBx"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936E91D799D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 20:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757448753; cv=none; b=n+yNuZ286XBFZyHI0AWAsdKJA+XWMVd6cUEW0L8pSrQdcKLLPAANBTsfKqszdB/eEjZLnGpK3ZD2wvGN29SxlJmL/ukhUMr9tZe2z6N8eCSpm61PGoKfGoDK1oglwd4jZDdhxtezu+Teq58BTbfLx4N/yo8EeEaayStcY5f1gnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757448753; c=relaxed/simple;
	bh=7A/dmEOrLuOkNmdDxri7yInXJwyPVUa1/pTdzyuIQsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xebf486QHJFN+v/4kqwpGxA6ljzdJXmDEGmMoM1dk+5CPjN+wrIMKwbc0ikTvvbMkf0O2rW3Lk1EQ+Kj/Qg4SzE3mzomzjN2qxb30kdkLs8Hkztlik7LQZrt+tuIfFeMBzqX3/y/MInkm1g7ilLt4q4fwNPkCXWPHMVUJhKiOJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=woqRKFBx; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 9 Sep 2025 20:12:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757448749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pBn9GjXNrzDpJNrr5pBWBsTy/Gh6alb/avcjcidp4mE=;
	b=woqRKFBxcgHj7ikhJEUFQZ84FxwkgwaMweAFV0Eia1mMfVN50fpFnj32IE7GzPmF/d0yDX
	kFxoj4mNHUTJEZ5Lj2s7V2DlG4YV8XWARpnBTkxED/5ef0oWOB29Jrgsyx1KDoKfSPGUe5
	uIVw0vQ1QV+5OhPRqR7RHzOCA/82erU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Vitaly Wool <vitaly.wool@konsulko.se>, 
	Vlastimil Babka <vbabka@suse.cz>, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/3] mm: remove zpool
Message-ID: <f3ufcsjvvxhi5gzw2wglkpedgyyi6tiaje7em3tbxkzhklphvh@sv3dbo4yba5p>
References: <20250829162212.208258-1-hannes@cmpxchg.org>
 <20250904093325.2768507-1-vitaly.wool@konsulko.se>
 <7b1ca42d-1b89-44f4-bffb-e6b09f86fdc5@suse.cz>
 <1d42c513-cc83-4f08-a10c-cbd6206070f4@konsulko.se>
 <girukcvvzgbtkxt4aftfz3lw3glvf2qsof4mx6wf5perolck5n@vaxlrtaeuzw7>
 <dh74mr7bjtpzk7frviv6iqqno2u2b27p7jiagp2dtnsz2wrfhr@wlb5vqg4majs>
 <tbvushbdn7nzitey3uy6humdndd6247r4544ngqkds3cr447e6@prnla4edwxmk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tbvushbdn7nzitey3uy6humdndd6247r4544ngqkds3cr447e6@prnla4edwxmk>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 08, 2025 at 09:18:01PM +0900, Sergey Senozhatsky wrote:
> On (25/09/06 14:25), Sergey Senozhatsky wrote:
> > On (25/09/05 19:57), Yosry Ahmed wrote:
> > > I think Android uses zram+zsmalloc with 16K pages. Perhaps Sergey could
> > > confirm.
> > 
> > I'm not working on android directly,
> > 
> > I can confirm that android uses zram+zsmalloc.  As of 16K pages, there
> > was a way to toggle 16k pages on android (via system settings), I don't
> > know if this is the default now.
> 
> While I don't know what zsmalloc struggles Vitaly is referring to in
> particular, off the top of my head, zsmalloc does memcpy()'s for objects
> that span multiple pages, when zsmalloc kmap()'s both physical pages and
> memcpy()'s chunks of the object into a provided buffer. With 16K pages
> we can have rather larger compressed objects, so those memcpy() are likely
> more visible.  Attacking this would be a good idea, I guess.

Yeah I personally think attacking whatever problems zsmalloc has with
16K pages is the way to go.

