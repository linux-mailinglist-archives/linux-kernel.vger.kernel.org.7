Return-Path: <linux-kernel+bounces-584444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 278CCA78747
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 06:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E581891E67
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 04:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CB323026C;
	Wed,  2 Apr 2025 04:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="US4SRlgL"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AC1208A9
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 04:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743568262; cv=none; b=eRKYmXAnjdfse41ZQY8n+eXDNfKpkpWcEHecta47qe+upNRTEmqBqaOv2jiHl+MLzky/Tn8ualRitHKpxUgvSA5AsQS9P19TJa9x57aUwDozSsqR1m5pf9rCfYUZ3OoPcXbtsRLwTK4yod1h75PX8glfrV9UsKDyzDSr3Qtao+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743568262; c=relaxed/simple;
	bh=LbXNrJhrOIJHYPRNG6ibkDGKv6FoVPDGmvtQ7vXHqQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRlEbztC30LcqfqTjRsoGOz/chODV8gc51gRGHHblT7hMB/ImffxAkLRVdRMFuh8sNoGDyJGNKSjzGaRK8xdFm4waCi+J7IND+mOJKJjrbFOh0uaSYaXfMdbNFnBsYrbSbL6/TFgqcfxIRXGI3cA31VyATdexCnaAqnuEhgcFeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=US4SRlgL; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 1 Apr 2025 21:30:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743568258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HupEOjpJ1alZUJx7rBRExFhNIIXyoCjP0X+QdCxkFQc=;
	b=US4SRlgLuPcvnUnR2AI1sOjw2LhwvqA/VFNy5r9GOQPNFiUOH7SD/fiE7cOikvD1NV/tz+
	eTmVAUkLpTx03lR7PImI5Ytx5AuYdmbVZpsIuvOvUbOWp0BGP34g53Ik9+NnbdY3nqbEnZ
	4k7dPGfM8Vod8a/0RIUY24gDzbw5SF4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, bpf@vger.kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz, bigeasy@linutronix.de, 
	rostedt@goodmis.org, mhocko@suse.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: Fix try_alloc_pages
Message-ID: <wmjx77dvccw22xppuqh4plrv37zdq5pjsofrbpcmqdvjfygype@rj55r3iz2cut>
References: <20250401032336.39657-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401032336.39657-1-alexei.starovoitov@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 31, 2025 at 08:23:36PM -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Fix an obvious bug. try_alloc_pages() should set_page_refcounted.
> 
> Fixes: 97769a53f117 ("mm, bpf: Introduce try_alloc_pages() for opportunistic page allocation")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

