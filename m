Return-Path: <linux-kernel+bounces-808991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05958B50738
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BAEB4E636D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE23B3568F5;
	Tue,  9 Sep 2025 20:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fqIdaqUv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mgy8c4XG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95831199931
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 20:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757450588; cv=none; b=oKkbDtWo5HmykSUjhS2Bkzii16bECij1FnqVYDk1kBUioe+x+1ac0FSg8ANvZ9bixtzawmoCYg3N/93/FJ5xMtAutP85apscLzXuBklk6HxFF+WfYo7f+c0MZLJRdtG9JL3UW19yZ61vcAcbZpHCNDodF0VK/QGy5l99rukcdFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757450588; c=relaxed/simple;
	bh=A2TtuV0cU8N4IWWA3ZtoGIOH3MPmGjxcHnQSUT+gbHY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aMycsIGQSF3oqgNoWL4yOY9MZ3DCh4xV6PLAXEgH5hdQlGLQFhCmqEtwH0308Y5vEpLz2OnxafPbl+sXG7mpTUcm3I4cAwHCxjztMuCMgqSOrS9SDw24gISokUkmlMVx0MgZ1LM0fzTE0DK6dkUCAOuEXdIq1ZHVwkDO3ky4QnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fqIdaqUv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mgy8c4XG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757450584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X/Urw118kJNJaS5fkOxwFmDNl+G7RlIpDvGsJB1ZH1w=;
	b=fqIdaqUvD0x8ER7LyKFPkfj8uNK2nqVwfD65zM66wz6umLMhR1Y9yI5BYKAPLrar84iS67
	rF0+SeSf3LuYDB4VBVWD7XkEalEhrDECA9VNo2wvFGO+nzImMsXJI8Fn8sUGNYkzGdKn4N
	5LBQScIBAU2g9+qw5IL/BOCeEuk2RDjZ9pFwKamnjfjLVqDKdMvZ73b5n5uC0qJgI0ACad
	TzpccA8I8Zdgfm+Grf8CEyJx1ugVPpg4rYT06yYuE7WhAG+SuoyK/0MXwFpRe3mCHLpgcx
	rRBD3MZvSS0KxE1g8q36NJ0Z3i2DJ25j6duRoWOSQc/vg/kd3TP647CRRErscA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757450584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X/Urw118kJNJaS5fkOxwFmDNl+G7RlIpDvGsJB1ZH1w=;
	b=mgy8c4XGj9vJa7ZJiJBmsorIwaYhc/vzjVTwauw3MXU9XqW0Ma52UwtsboZfVMtBUDCv0M
	IMLnvYiW+ACuiKCg==
To: Jens Axboe <axboe@kernel.dk>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, syzbot
 <syzbot+034246a838a10d181e78@syzkaller.appspotmail.com>,
 andrealmeid@igalia.com, dave@stgolabs.net, dvhart@infradead.org,
 linux-kernel@vger.kernel.org, mingo@redhat.com,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] general protection fault in try_to_wake_up (3)
In-Reply-To: <4918e983-9964-46a2-aee0-59c91a9c6b35@kernel.dk>
References: <68b75989.050a0220.3db4df.01dd.GAE@google.com>
 <20250902214628.GL4067720@noisy.programming.kicks-ass.net>
 <20250903130712.br0G6lOq@linutronix.de>
 <a1808501-559e-4762-b0ea-f1fffd2e7f19@kernel.dk>
 <20250904162820.NS1U-oZp@linutronix.de>
 <4918e983-9964-46a2-aee0-59c91a9c6b35@kernel.dk>
Date: Tue, 09 Sep 2025 22:43:03 +0200
Message-ID: <875xdruzl4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 09 2025 at 13:27, Jens Axboe wrote:
> On 9/4/25 10:28 AM, Sebastian Andrzej Siewior wrote:
> Was on the road, and now back at least for a day or two... So I took a
> gander at this one too. One thing that puzzles me is the io_uring traces
> in that syzbot log - if they are to be trusted, it only ever submits an
> io_uring RECVMSG request? IOW, no futex usage on the io_uring side at
> all?
>
> Going to try and download the disk image and kernel and see if I can
> actually run this locally.

It has nothing to do with IO/URING. It reproduces cleanly with the
provided repro.syz. It just takes ages. The bisect log, which contains
the IO/URING muck is irrelevant.

Thanks,

        tglx

