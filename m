Return-Path: <linux-kernel+bounces-867628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F4097C03268
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 21:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F3A284E7CEE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DEB34C99A;
	Thu, 23 Oct 2025 19:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q/Jw9PuC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WioleC0j"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928EF309F1A
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 19:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761246887; cv=none; b=IsNCQq2kHHSfHHfQOguZ5Kah7Nw7Hcfbbg0N8zROul/NM9j3jyaKvyNAJpYZKgwvMdTpiEVaowDsjRplYvGLzTHPoWsKXGxTN/huviCJlTPDHksEuCGXWlxclDeBX4BGOuozw/7YY/FbxseXoWpIwhdWDbt5hIBYXWt38qB/B6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761246887; c=relaxed/simple;
	bh=iY/u9q2urvID4ix7PtW8nEVgxdvZp6QVq2U/HMK61nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RN/joXci/OzzPHpwAg1/hTWiqgp5uoAJKplzFdATu0ja1o/J4H1BAKjG0NW2RtXM+qvfRwiqxNFHikSgobu4yhz9BBaxl1jEa+KigqRRJzviQ1hMiPrjI4WzF0jzmwkww8Zg/tDOcnj4FLVrXWRAdr5v2t8tkJHIgP261ljTbc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q/Jw9PuC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WioleC0j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 23 Oct 2025 21:14:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761246883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ojxKnndrVEn98BhZnNwoeXfIjOsk8ogXgzUTxXorQWk=;
	b=q/Jw9PuCORbTURdDNXTx4C7xGCG4OosKNk57L3wFzAT42yK95ntgvuXp5KHYWrMkdI5n8h
	n+oaE/+tNgcceHKA+r/rRf/seFOdsBppZFT788V7/Phk0SJ2GtJfqKcz02W2/W4b8uRFBh
	1loxXD1Op0uVAwWGM8e9brd91cDtKllQkIEQh+EXvQ72veL6r6O3fUj13WJlPy2bDZHCQQ
	T5p5i9V5WvCvwGqU+uOv2Gaf9SjEoy+DQXqH7OdMSEG8QIb3NsmrpYiM9VYSpf142WEcX8
	hZdt4CBRNRZDLrgmYVaA1q5XCZ9QdiTbnIqYk4NcMxOuLhf57xfefmygQV/hQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761246883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ojxKnndrVEn98BhZnNwoeXfIjOsk8ogXgzUTxXorQWk=;
	b=WioleC0jXukiw/yWV5+tkGx3H+RjjAUWTawRbrbwBF+RKg/Vhzj8JEq83kYPPXMofEPisu
	sqdmKVZpyyD9o6Cg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Oleg Nesterov <oleg@redhat.com>
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printk_legacy_map: use LD_WAIT_CONFIG instead of
 LD_WAIT_SLEEP
Message-ID: <20251023191442.Uu0mD_Nq@linutronix.de>
References: <20251022154115.GA22400@redhat.com>
 <20251023103234.GA27415@redhat.com>
 <20251023142655.FvZkeSa-@linutronix.de>
 <87wm4lbqt2.fsf@jogness.linutronix.de>
 <20251023151112.goqBFQcM@linutronix.de>
 <20251023154657.GD26461@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251023154657.GD26461@redhat.com>

On 2025-10-23 17:46:58 [+0200], Oleg Nesterov wrote:
> Again, quite possibly I am wrong. please see my reply in another thread,
> https://lore.kernel.org/all/20251023152942.GC26461@redhat.com/
> 
> On 10/23, Sebastian Andrzej Siewior wrote:
> >
> > This does not matter. My point is that there no need for this ifdefery.
> 
> I disagree. Rightly or not. To me this ifdefery in printk.c make the intent
> more clear.
> 
> I am still thinking about the possible cleanup of the current usage of
> DEFINE_WAIT_OVERRIDE_MAP(), but I think that, whatever we do, this cleanup
> should take CONFIG_RT into account.

Right. Please just do s/SLEEP/CONFIG as discussed. Please leave
PROVE_RAW_LOCK_NESTING out of it while arguing why this change is
correct.

> Oleg.

Sebastian

