Return-Path: <linux-kernel+bounces-763193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEFAB21170
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9FD190344D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F44296BC3;
	Mon, 11 Aug 2025 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WtqCiMzP"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F80C1A9FB8
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928511; cv=none; b=FTfkxu4aZEiP1GFuUxniQd6Q180yiyiX083AjdkAtoHa7BU51uayWiTX/Bk8CcrXhN0IU/oOvmOr8Phl/x5RS+udZE72hNGivhqrrNCOepdv6OHr8xPIq4mii30s7TvNtH6zTN4qPga9cIoIlc7dea+bUjqshGo0zSGR6vYopz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928511; c=relaxed/simple;
	bh=gULV+9ocuXUCQKeLxStfFpyd+wgjqs5egYwZCe7mDlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNmqi+0JLrCZNWJM6R5ZZwjyzaGADoQ8KIF8xi9wrIS2NPhltKJVsEDWEXTiCpb6ttsI/zAIPKOsfiI0ZiC89G+x58s7Z6aQkVMPheFTGztBuYahkUUlE8yK0mKV9N5+ZvW3nH/OZS5QY0itxuvlQb8iKKiFYsugRP9EOHxcIiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WtqCiMzP; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 11 Aug 2025 12:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754928497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JQ4kKog6D48XJVshhAwwLan60T01jfwSyzHyz06FY+0=;
	b=WtqCiMzPGG5EeBoBEN2M+z1hQlSqZ/kg6rD5v6vp3oOAAn59Pq5iszEbegA27aAASQocRt
	ngc6hdlxlmta6VoCFn894MlsgjfmWqxkv8ou6J+mtsIi0anIdKE3zee5PTceLMcI0HivOV
	XAczChxDKvxskCS6v7Bc0ekpRvjIY1A=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: James Lawrence <jalexanderlawrence@gmail.com>
Cc: tytso@mit.edu, admin@aquinas.su, gbcox@bzb.us, josef@toxicpanda.com, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	list-bcachefs@carlthompson.net, malte.schroeder@tnxip.de, sashal@kernel.org, 
	torvalds@linux-foundation.org
Subject: Re: Peanut gallery 2c
Message-ID: <ct5pqur2cwn2gulxuu277uomoknflxae32zzpyf4yqbrxcxj4d@p5j77u6xks4l>
References: <20250810055955.GA984814@mit.edu>
 <20250811154826.509952-1-james@egdaemon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811154826.509952-1-james@egdaemon.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 11, 2025 at 11:48:26AM -0400, James Lawrence wrote:
> And since other FS maintainers are not stepping up to the plate and
> improving or implementing new filesystems to address their own
> featureset and branding short comings, I'm not terribly interested in
> what they have tso say on the matter. And neither should you linus,
> let them be upset that *experimental* *opt in* systems can
> (and should) operate under different development processes. I
> certainly give my engineers/researchers a ton of leeway long as their
> work is opt in.

That one is unfair: btrfs has improved greatly, by most reports (but I
also still see reports of e.g. multi device issues). 

I think bcachefs has been a bit of a kick in the pants for them, they've
taken some stuff directly from bcachefs - e.g. I believe they took the
basic design of raid5 v2, the stripes tree, directly from bcachefs. A
btrfs engineer asked me and I explained the design at a conference some
years back, and I've seen other solutions show up in btrfs that look
cribbed from btrfs. Similarly, the basic user interface of subvolumes
and snapshots in bcachefs is lifted directly from btrfs - it looked
sane, so I stole it.

That's where we're at our best, spurring each other on in friendly
competition, stealing each other's good ideas...

