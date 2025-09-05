Return-Path: <linux-kernel+bounces-803553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1E4B46244
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 20:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E101CC7E46
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB18261B91;
	Fri,  5 Sep 2025 18:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D1sDtMRb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198C830597B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 18:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757097045; cv=none; b=sbw+miZxNPDO0p5n/kXRfPGxq+JalG27SHSYt0fXVzIpXoqhgA1Tk13CdU8OOVxjAMqA3p5NBsgFX1uB2GmcluG4Mp6MFQeD2IDQCjwSvnQtbzYSiH3c4fsJGn1JOTSHeDSPDobA7ZhyQ7tVEBms5m9wP6Mjvvyipecz/MuFkHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757097045; c=relaxed/simple;
	bh=Ths2r9Q0+7GYMIMkvaTHPVsbLrlk/9SHbCDdMKgVc/w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MoSdSCS365Yn8mXykl9M+JWoW7VC0C011f0M5+v1U9u/iB8URyef4gonRik35sEvjPkd3EDzImrcHxZft+4OYLR14xROV5AetX3GmFwgRuFxG79e2P/HxnctyYot5JOptwgBFTRVcVjgVgkUr8nkiztBnLmcVK/sQEXg+APD20o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D1sDtMRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C4EC4CEF1;
	Fri,  5 Sep 2025 18:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1757097044;
	bh=Ths2r9Q0+7GYMIMkvaTHPVsbLrlk/9SHbCDdMKgVc/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D1sDtMRbYZnBAQIplNxKWcfibeIAp+uefUh0m5gm0mR4BMlRu5hBMNKHkIJb0gg8G
	 gSH0beERjv09OM/B2vMQpARlW93eq2nT7MXyLVEckxDLwKTU0xtyTGj00ReZHR3FfP
	 qKFjBrul6T8rlYkHWJIzyvm6I+ATvvmXynYmIcnM=
Date: Fri, 5 Sep 2025 11:30:43 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: hannes@cmpxchg.org, linux-kernel@vger.kernel.org, Vlastimil Babka
 <vbabka@suse.cz>, linux-mm@kvack.org
Subject: Re: [PATCH 0/3] mm: remove zpool
Message-Id: <20250905113043.3fb70f94c86445617266c958@linux-foundation.org>
In-Reply-To: <f0869789-ee30-4eb9-840a-502d031df1f5@konsulko.se>
References: <20250829162212.208258-1-hannes@cmpxchg.org>
	<20250904093325.2768507-1-vitaly.wool@konsulko.se>
	<20250904164710.210731847fe25d9419203886@linux-foundation.org>
	<f0869789-ee30-4eb9-840a-502d031df1f5@konsulko.se>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 5 Sep 2025 07:42:34 +0200 Vitaly Wool <vitaly.wool@konsulko.se> wrote:

> 
> 
> On 9/5/25 01:47, Andrew Morton wrote:
> > On Thu,  4 Sep 2025 11:33:24 +0200 Vitaly Wool <vitaly.wool@konsulko.se> wrote:
> > 
> >>> With zswap using zsmalloc directly, there are no more in-tree users of
> >>> this code. Remove it.
> >>>
> >>> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> >>
> >> Per the previous discussions, this gets a *NACK* from my side. There is
> >> hardly anything _technical_ preventing new in-tree users of zpool API.
> >> zpool API is neutral and well-defined, I don’t see *any* good reason for
> >> it to be phased out.
> > 
> > Well, we have the zpool code and we know it works.  If a later need for
> > the zpool layer is demonstrated then we can unremove the code at that
> > time.
> 
> The whole patchset [1] depends on zpool, with the whole intention to use 
> it on the Rust side.
> 
> [1] https://lkml.org/lkml/2025/8/23/232

Well, that puts a Rust wrapper around zpool.  But what user-visible
benefit does it (or shall it) enable?

