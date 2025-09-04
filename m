Return-Path: <linux-kernel+bounces-801840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3B3B44A94
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 01:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B4191C8515D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F9C2EC55D;
	Thu,  4 Sep 2025 23:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nOft/nxG"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4921C2D9EE1
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 23:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757030055; cv=none; b=l1LKIAyuQjS9brW9qSk/FtJHSeAafW0j1R178sSdM7fhfmoKnvKlbze2lbksXHxhN/8iOMu4aNJ6GddvTgsdLzRNmBwtYvUkrILh06nh+/d9KkJSnntY7J5Su4JFvOl1y65W0PFeTrC3BnXgYOWbpVoqIUMcoqT2gk5vIMp/msE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757030055; c=relaxed/simple;
	bh=iL+jRT27UEQKEQ6yDzyJrzLKOn/zA+VKYb2UGvu4oOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAYZQKI4W90QKQBdlZOx54n0NmloeD5j3lotSuj107iLHteUpiV528FeiMn3Y6iW35yu6xgL9+h98vcxL0b+gzL2jCjyzXMdatahE8QFbNWj0sEKjs2OESDuyHMMTlz/+Oke5ao6rjKF+rw8E9FjPKbqOIdoRm/4iFqxinXkraA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nOft/nxG; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 4 Sep 2025 16:53:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757030051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I2nHB0+fgG2h/YQBsdZgUFZD9bhaDf/fBMnAYUZmncQ=;
	b=nOft/nxG9IV86fBSha/GcaPySgvaLaSunrmXTot9uMw0gpH9yf23OW+acHtm7Jdl4Y7P2u
	LkNznH4dPpljYeGzYUBS3OFjT2YEKIOG8lSXqrs1Rn9JXfHUg+mtRdWk7lYXbnWvRAeNgr
	mmqQfMglq1NCvSXu2X2jVVvccqdMI/Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yueyang Pan <pyyjason@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Vishal Moola <vishal.moola@gmail.com>, Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mm/show_mem: Add trylock while printing alloc info
Message-ID: <4lnhlnaobt6cmhjsnhh5ul635bylwd55ha77ej3fgfhdy4k5cf@grchtd457dzc>
References: <cover.1756897825.git.pyyjason@gmail.com>
 <4ed91296e0c595d945a38458f7a8d9611b0c1e52.1756897825.git.pyyjason@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ed91296e0c595d945a38458f7a8d9611b0c1e52.1756897825.git.pyyjason@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Sep 03, 2025 at 04:16:14AM -0700, Yueyang Pan wrote:
> In production, show_mem() can be called concurrently from two
> different entities, for example one from oom_kill_process()
> another from __alloc_pages_slowpath from another kthread. This
> patch adds a spinlock and invokes trylock before printing out the
> kernel alloc info in show_mem(). This way two alloc info won't
> interleave with each other, which then makes parsing easier.
> 
> Signed-off-by: Yueyang Pan <pyyjason@gmail.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

