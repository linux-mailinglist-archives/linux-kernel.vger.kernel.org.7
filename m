Return-Path: <linux-kernel+bounces-737929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C16AB0B201
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 23:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EBB37AB8F6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 21:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1335C221550;
	Sat, 19 Jul 2025 21:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="arpZtTB3"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EDF191484
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 21:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752962231; cv=none; b=QsVT0VtQf/vJN+jJmP5EnSG+sBXyQc3agzFz+mpx5WckYogkKJat3W0X+3ktRUkg/vTEIoejvE5FqwOKSDON76z5ePDKsR6BnHurcotoUtmGDo9LAvF45ugYNrJPH5h3Ftlu1lvuF+VJ0lRH9yp+DHUzNMCCUPWeG8SBI2H62xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752962231; c=relaxed/simple;
	bh=aJsUMMJNzaMTqcwDIA8kBblsnJKcFjoDqfCZeHiosRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bApUOg5zBnM5XNDSb4WEXM32+FFIxIzzbc7khgscpJYBD2fFvxEYxsgwJcEpRtfjMMlQze11b4dRPiLO4uK4XhLGVtFYdaxlDIIGZJrZVv8uPLeeP7+fYVNztMAkghEJ7twyKf3FJeYk03CgebmYTjCMX6kzwMSEJ3uDdLIzvYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=arpZtTB3; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 19 Jul 2025 17:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752962216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aJsUMMJNzaMTqcwDIA8kBblsnJKcFjoDqfCZeHiosRY=;
	b=arpZtTB3BFoYK4Bv+OszCnPo+yYmaXTkq33utaeBJhE8FT1Q8Z4DpqTK9kSDEBGeZwf6Pk
	iKQJJKtnw8KIupX0eHTKt9uKbULxgDs70uqlhjTxIKZ8fwCxR4Qb5gonWzxLqOmjWHvnoH
	rVJg5H2zGjdcsgXrlH5yrWAtcXM0it4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+bfaeaa8e26281970158d@syzkaller.appspotmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] KASAN: use-after-free Read in
 poly1305_update
Message-ID: <iuebxxmpulg77o2sznvjclghictwopvslit6vcfh75hcouavo3@j4tco5bnifrs>
References: <684c5575.a00a0220.279073.0012.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <684c5575.a00a0220.279073.0012.GAE@google.com>
X-Migadu-Flow: FLOW_OUT

#syz fix: bcachefs: Move bset size check before csum check

