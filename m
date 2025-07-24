Return-Path: <linux-kernel+bounces-744427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B82CEB10CB2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A5EB04CAD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D1F2E2F00;
	Thu, 24 Jul 2025 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="WT9unhE2"
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E852DE70B;
	Thu, 24 Jul 2025 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365714; cv=none; b=hKKtV8GtuPMOr/4AINfcqw0VG16y/Pn/F2XwR7a5EKQQBkCs2VGA3xPHUbK6Pi8/qWSL18mIQ5w/19beotzTe+erl5jnk1PJ063lAL43P4Kqb41cdPG0fqmtRag9CD4mXkrlu0oorBH8xRnBSqSZgfF3MGNE4ce/Pakn3RD4Dc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365714; c=relaxed/simple;
	bh=LHrZybXUzn7zDp/R54CFIe7FKl93yn8U5vdZRGns188=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ILgfnNr+BGO1M51U9LU0P4LsU1LosCwzY3TqFPU6afuGC5muBpyNUyXC9Z1jgHZo0UYeNZqIEqtJFgopUa1cmqLQk7fIul5xpTMr6l2fF2ETulmjcfm28s9sA7hzTUwZY02tb36p5JZu+kQXx203gtxG3bt5oQHBvDuwPEn4+iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=WT9unhE2; arc=none smtp.client-ip=178.154.239.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net [IPv6:2a02:6b8:c10:2987:0:640:47b0:0])
	by forward500b.mail.yandex.net (Yandex) with ESMTPS id 88372C108A;
	Thu, 24 Jul 2025 16:53:58 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id rrU2IQHMTKo0-lK3bD38L;
	Thu, 24 Jul 2025 16:53:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1753365237;
	bh=09JoW2beWYFP5LMbPMIkZ+GQKIeWeh1GWRRSwO8kTfg=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=WT9unhE2qaSclquXzea8JhpCe/36zx0V8K0JyMsE5RzRsHo1x2bqk8fbdlel8RffL
	 cCrORXzfwy5mWwvxfoAmVQo68MJg/pr7u9kKhqQ8WK+SBCjHddkdrq3XUL9dEPIQCT
	 NDdZJYybm/2Okq9boh+jfblViNFXbPFfcJfHMkB0=
Authentication-Results: mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Thu, 24 Jul 2025 16:53:51 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, lossin@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org,
 peterz@infradead.org, mingo@redhat.com, will@kernel.org,
 longman@redhat.com, felipe_life@live.com, daniel@sedlak.dev,
 bjorn3_gh@protonmail.com, Lyude <thatslyude@gmail.com>
Subject: Re: [PATCH v5 0/3] rust: add `ww_mutex` support
Message-ID: <20250724165351.509cff53@nimda.home>
In-Reply-To: <20250621184454.8354-1-work@onurozkan.dev>
References: <20250621184454.8354-1-work@onurozkan.dev>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi again,

Just finished going over the C-side use of `ww_mutex` today and I
wanted to share some notes and thoughts based on that.

To get the full context, you might want to take a look at this thread
[1].

- The first note I took is that we shouldn't allow locking without
`WwAcquireCtx` (which is currently possible in v5). As explained in
ww_mutex documentation [2], this basically turns it into a regular
mutex and you don't get benefits of `ww_mutex`.

 From what I have seen on the C side, there is no real use-case for
 this. It doesn't make much sense to use `ww_mutex` just for
 single-locking scenarios. Unless a specific use-case comes up, I think
 we shouldn't support using it that way. I am planning to move the
 `lock*` functions under `impl WwAcquireCtx` (as we discussed in [1]),
 which will make `WwAcquireCtx` required by design and also simplify
 the implementation a lot.

- The second note is about how EDEADLK is handled. On the C side, it
looks like some code paths may not release all the previously locked
mutexes or have a special/custom logic when locking returns EDEADLK
(see [3]). So, handling EDEADLK automatically (pointed
in [1]) can be quite useful for most cases, but that could also be a
limitation in certain scenarios.

 I was thinking we could provide an alternative version of each `lock*`
 function that accepts a closure which is called on the EDEADLK error.
 This way, we can support both auto-release locks and custom logic for
 handling EDEADLK scenarios.

 Something like this (just a dummy code for demonstration):

    ctx.lock_and_handle_edeadlk(|active_locks| {
        // user-defined handling here
    });


 That would let users handle the situation however they want if they
 need to.


Would love to hear your thoughts or suggestions on any of this.

[1]: https://lore.kernel.org/all/DATYHYJVPL3L.3NLMH7PPHYU9@kernel.org/#t
[2]:
https://www.kernel.org/doc/Documentation/locking/ww-mutex-design.txt
[3]:
https://github.com/torvalds/linux/blob/25fae0b93d1d7/drivers/gpu/drm/drm_modeset_lock.c#L326-L329

Regards,
Onur

