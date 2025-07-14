Return-Path: <linux-kernel+bounces-730712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 889D8B0487A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 22:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B942189B12F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 20:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B1E278E63;
	Mon, 14 Jul 2025 20:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wXZrJShm"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3B5238144
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752524906; cv=none; b=SPJYlBQkNNkHEDCWfiozEPsbFFe/8aJPiHkVEHQARK3h6mQeBrqb/3pvQNrMk7EmhCUguZwpaFR3Q93nx8cled2F6Zcgbwa1UuGPRoMFGJxUd9wjUMPEvfIlIWtQmGkFO2VLE6lgtPJ/xglnOX38IUXnSPEMabdvJ6Vrsk/5yDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752524906; c=relaxed/simple;
	bh=TPJ2WG14z56rLTjUQcdrLpbDbtksQ8xCoBLcwu3yzr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9Vlt0JEDnN7jYxGKCP/lBPylHQ0PpC98YVh/gqYMZL1v1heWwX5whC0UEuKvkyjtUpcQV/QnoaG2jE8mBi7tmKoaunZml7OUoFsfKYUOFSg466fItIRghcWgeSb2VMnjEp3zEtiHbLR7HEzqfNK73tiInrYHw6/lJbFdGO89u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wXZrJShm; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 14 Jul 2025 13:28:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752524900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8fQyIOsuNSBC9vq4oF9Pm+Z2yhRW3OY+Y+eyPVEJoZY=;
	b=wXZrJShmdA5Pomt3K5vyoc9cM4l41sRzQeghtojgmSp3zAijJFzknrSEkPNgYyrx/25a5y
	HpHZXsHVReBZwAezJ1ag5gCmw7GXb/vLVN4nK5K9i7zsa1rIikqMuAdEp/TLaG3w6aBOs8
	LWWb95KQ8daBG8AYj+lv8vawF649WMg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Hugh Dickins <hughd@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko <mhocko@kernel.org>, 
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: skip lru_note_cost() when scanning only file or anon
Message-ID: <32nmrynnyg3fazfq6i7uddczzahwia3ae2c7etiaaqphmqg6kb@rswensgq2mys>
References: <20250711155044.137652-1-roman.gushchin@linux.dev>
 <8734b21tie.fsf@linux.dev>
 <21100102-51b6-79d5-03db-1bb7f97fa94c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21100102-51b6-79d5-03db-1bb7f97fa94c@google.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Jul 13, 2025 at 12:57:18PM -0700, Hugh Dickins wrote:
> On Fri, 11 Jul 2025, Roman Gushchin wrote:
> 
[...]
> 
> [PATCH] mm: lru_note_cost_unlock_irq()
> 
> Dropping a lock, just to demand it again for an afterthought, cannot be
> good if contended: convert lru_note_cost() to lru_note_cost_unlock_irq().
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>


