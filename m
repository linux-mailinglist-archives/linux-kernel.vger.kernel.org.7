Return-Path: <linux-kernel+bounces-808945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4A8B506C0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73256188977D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60414302CAB;
	Tue,  9 Sep 2025 20:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z1jph/xi"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03341D799D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 20:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757448705; cv=none; b=raLRClNNm8xs5iP4UMN6hZtTlsweceFba9BNfAM2zDHPN41aFw1lSQpDL2oRhc5yNRyvJp2w5XhWRt/1YHAUJ/TOw+S3cxDk3o51G93CT7DgkQTp7lvYlTgodQQAv2QtFHcnszCoBFB10j+XgvBDHn3QMWMGL/M5Dm+38rzSwho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757448705; c=relaxed/simple;
	bh=9vPy67zv5T92jftIDastnMX5dZzN4nyVbtxUd0Tu00s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sB9ZuPXwX52/E21c87NfXKMqGPzNfZ6Gq2SB/YmOU+H85/04WZrxua8Dxr1yDGZXs3DqYpe8RjDoFegXVRhr6NHFllP6B4LUE2J6iRWYyHorP0HK6ExDQpr/cvNg9A/w8v8PdT8MbJXmD6/1daesYvsw7qxzIXpYyR/JyKtcktE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z1jph/xi; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 9 Sep 2025 20:11:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757448701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zF+/R3skTysO2OwLmP+g6xYOgLccfqCBAyrfZM+b9H8=;
	b=Z1jph/xi2L07bJSUAgXtLFZYg00hfwUMGPwVLRiZ8iNWV+vbOLvq3U2Oxn74CirpHRT7PX
	FtQbynaXy9tPAEmOd6UBxfgcWn79Rv3Hc4xavlFMXkse5I4ggeipB3ICSj9d39aPK7Oefa
	WUP+xQNVPLMYyeDBzC/zAVlGJ6GIGpc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Nhat Pham <nphamcs@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] mm: remove zpool
Message-ID: <2aenos6u6gcljdovxjj5wwhtuivicfwtkigfkvg2maachhg4ke@cm5ep6jzxiob>
References: <20250829162212.208258-1-hannes@cmpxchg.org>
 <CAKEwX=M8ccnsOUc4_ZcFrg-8MSwDDF250=LCFKctvTrL5vJZ6g@mail.gmail.com>
 <4vpqew3bfs74kesmgd6kaafgm6nr6zbtt2t3hl2khkc6ds4zep@hllgy77hdumf>
 <CAKEwX=P=2cm7X4VMGO==xqmcFfBj4tq_YU9DqCSbyAmCioDccg@mail.gmail.com>
 <20250909150326.GC1474@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250909150326.GC1474@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Sep 09, 2025 at 04:03:26PM +0100, Johannes Weiner wrote:
> On Fri, Sep 05, 2025 at 02:35:12PM -0700, Nhat Pham wrote:
> > On Fri, Sep 5, 2025 at 12:45 PM Yosry Ahmed <yosry.ahmed@linux.dev> wrote:
> > >
> > > On Fri, Sep 05, 2025 at 10:52:18AM -0700, Nhat Pham wrote:
> > > > On Fri, Aug 29, 2025 at 9:22 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > >
> > > > > zpool is an indirection layer for zswap to switch between multiple
> > > > > allocator backends at runtime. Since 6.15, zsmalloc is the only
> > > > > allocator left in-tree, so there is no point in keeping zpool around.
> > > > >
> > > >
> > > > Taking a step back, even if we do have needs for multiple allocators
> > > > for different setups, having it runtime-selectable makes no sense.
> > >
> > > Honestly I think we should take it a step further and make the
> > > compressor selection only at build/boot time and completely get rid of
> > > supporting having multiple pools. We'd create one pool at initilization
> > > and that would be it.
> > >
> > > I believe this will simplify things considerably, and I doubt changing
> > > the compressor at runtime has a valid use case beyond experimentation.
> > 
> > You are completely right.
> > 
> > And, even if there's a setup where we benefit from multiple
> > compressors, the current setup is definitely not it. How are we
> > realistically going to use these sysfs knobs? Change to one
> > compressor, then quickly change it back? How is this remotely useful?
> > 
> > Let's remove it all. In the future, if we want to do multiple
> > compression tiers, or per-cgroup compression algorithm, we will need a
> > completely different architecture anyway.
> 
> +1 Completely agreed, it's not worth all this fragile code in zswap.c.
> 
> I'll send follow-up patches.

Awesome, thanks!

