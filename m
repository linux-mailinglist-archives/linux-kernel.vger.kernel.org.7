Return-Path: <linux-kernel+bounces-778917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0A5B2ECB7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A8A01CC3D2A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 04:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67588283C87;
	Thu, 21 Aug 2025 04:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="f8fCfwFh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A3523A564
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750264; cv=none; b=rbcBy2oYFnt51u3fpdgMsmk6yfsOG2aYXnJpFnl1J+LawbJFyIwT8nXvYaIWp6Cfbg/zgJXwHAshKbBQh+oSKwbL5elPP1QmbdD1/HjxLMKW+33insOTLWAjfzgjUtzC5vroRgzOkpyR8XQPYAEC/6E12hi3n8csbB3TM+g7Eh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750264; c=relaxed/simple;
	bh=yEbxrMCEYmcIooCbdM8kiby0WKYLYX/mSci3aAy4yVM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qv4AR+i2oVqWnEYNTDpa40SlKgAGm5UdxvJh5He7M9/G//SLNVnK0VunTDaAaCOeLUFKkxaJg4FgM1dFB1HKBhnNp3o91yALqQWNrLMG4Hk3IwdR+p08u2vE7dDPQxYlN9Ab9skHYIVMsKNgFiIyr7BfIO2s7VsmTuA921+TUc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=f8fCfwFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09BEC113CF;
	Thu, 21 Aug 2025 04:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755750264;
	bh=yEbxrMCEYmcIooCbdM8kiby0WKYLYX/mSci3aAy4yVM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f8fCfwFh4Z1og95qFf//8M53G5+NpB0yLPawo58P+nEJ33AB0QDoMmwRNquGqfk1S
	 tsu4nuflWvmc2k2+b/tD4Yo2VUE6pT7IUR7ZuBev1amEvdmaRaGakAhitSeYTBEzes
	 Yn3DvWs4xjELaW3Hr13oWRpJRwYQUcg2i4cxPTps=
Date: Wed, 20 Aug 2025 21:24:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: david@redhat.com, surenb@google.com, aarcange@redhat.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/userfaultfd: fix kmap_local LIFO ordering for
 CONFIG_HIGHPTE
Message-Id: <20250820212423.fbac2b17eb4f6a9667a8c979@linux-foundation.org>
In-Reply-To: <aI04CQZZzgCDO2A5@lappy>
References: <20250731144431.773923-1-sashal@kernel.org>
	<20250801141101.9f3555a172609cb64fde7f71@linux-foundation.org>
	<aI04CQZZzgCDO2A5@lappy>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Aug 2025 17:56:25 -0400 Sasha Levin <sashal@kernel.org> wrote:

> >> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> >> Co-developed-by: Claude claude-opus-4-20250514
> >
> >Well this is innovative.  I doubt if Co-developed-by: is appropriate
> >for this (where's Claude's Signed-off-by:?)
> 
> Claude (or any other AI) can't legally sign off on code :)
> 
> >I'd support creating a new changelog tag for this case.
> 
> This is in the context of a proposal on workflows@:
> https://lore.kernel.org/workflows/20250728105634.GF787@pendragon.ideasonboard.com/T/#t
> 
> The Co-developed-by: usage wasn't my proposal, but it looked like the
> majority of folks were okay with it.
> 

I need to do something about this and the discussion over on
ksummit@lists.linux.dev has been as beer-addled as one would expect.

Oh well.  I guess for now we can welcome Claude to the kernel
development team.


