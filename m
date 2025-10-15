Return-Path: <linux-kernel+bounces-854749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6984EBDF4CD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842E5188EE0D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BC92F9DAA;
	Wed, 15 Oct 2025 15:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gii1H9Ca"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88952F5A01
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760541385; cv=none; b=Cr2wNkB5mFLbvA7oFL1F+qg0i1JKN5ZNhRHYIUCNLF8jmwRnNqIEaSskIs1FwWTcTsZG2N2eVW8bNu3+3hwHXOdc7eWVY45ubRuVepkssAOfiJ2qLOcYHWHty+wGMBBJTf0eUKIUWlx5WUaItfSjVrvIRXrOkZjdzsaFwjKxVmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760541385; c=relaxed/simple;
	bh=lmpfn/DkP3K4xfQoydtxx13vyKNJA4/NSr1HVbrF6Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEUqxZvIq/mDcaVcdtD8DJgRYKsAJDh+6MHnSpkGYEyVhoGK5i6RmtJf5R6+6VtDUQyVQiLUJyF5MEc+x+T80rkiMbwy9DR2T1t0WJVCmJSaL7JizznpbVl9G/1sZdwciUCt+zHiSfTEqT1T23eVOpx4iQP+RH65cp59prwubCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gii1H9Ca; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-856cbf74c4aso1277930985a.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760541382; x=1761146182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1b0J1G5Je076UHWfx+mUwV1mmqcJCq/SSu5M7TFN/I=;
        b=Gii1H9CafGIRyV+KbgQsOWYUps6Qs5ieJtryQ5INNdOyAg28FXH3uj4NCsEmtWaa7J
         LTQYsOmv2X4XHaqHz4smV3yhaULoN+CDkiKHdl/LIBQshSyY8nGe2n41LWcyudDgCCvJ
         QPcIMADc8iHd2c3dbjju7nKIbyyNjbGBe1X9ueKwN028IkeTPEFRC2xoLVyLVqIXg7BD
         vUh/kMzJ3PK18jLsVnzxZVtoilDktE/gFqKfiDSoPD5zI+2DIVuivNz1zsM3VMYUMUXA
         an1sSQIBn+q9yqIQnCRlFRiWDc4TanGLMTUtSyndVAdBw+qOHFnTPZk9270X9fAGVODo
         k8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760541382; x=1761146182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1b0J1G5Je076UHWfx+mUwV1mmqcJCq/SSu5M7TFN/I=;
        b=hvqfG3N7wKJ5RDIl/TsdWf6vzosB08E5g/NqdNZrRsTYeQWkhGROpqudaKS76kIoMI
         lYgO3KY6lJnBZfyh/zakaoOmYVk42tetmPWhxoBnEJBsu+Xui6tD1wJN1jqg3jONWt3o
         dOigO5a8c40rdN8QP1BY7tqVtFjmLeWG2FPgKd0eq/I38oe9rkWGM9//cD05og5YDFYZ
         +8rdpFNa6w5bKu16Q20WGHPA1sl/X31vhXnagL8bKWjJhW3dQgIT83dMaX0gSpCYQ4Cc
         dpAqbBltRptMAFB9vj9EEhusBys2RID6DVIbhjLG//xQupkLj2ODUzGyZkhEIk4iiRFA
         4K9w==
X-Forwarded-Encrypted: i=1; AJvYcCXVg5cGmnaJyf/RXBR7DSA2SWnzxhY+K+WiNpAqhcmNbGVnqxv4I1+PVTJyEPD48360IGxbdrE82+CCcO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWt2rHGpm0lw/C4kaC/HeI8s8t8V1JKtHjCUkSVRpxl2UxQxjp
	qHORPbcRPuuvtPyXC3InMxipNmjV5bdnkEH2Kn9ZB3/2H2hJ8cx9aAVI
X-Gm-Gg: ASbGncslSbcuXZi988iKgrxmTlfqDy0Q21HW0Pas2H8F6tiZGNIml4PndxkOA72YTOW
	YhRPTT2r/fHkg3g9bCXexHf8R+1fHKy7GR/fB1qit2a480klU32KpR6oZ3p41TK1QE1oNH1ekfF
	tZe89n/CQvXqxMoMgjxXOJJz1rMa3Upse6wQZYaS0k1UtO7p6ndEVOQJtxQltna2bBydIhikgfF
	8W+MGhUdXRrRW8KmC4dXPWlajSjsmrnnI6Lcb+T4EnIBczJlCoUcVFkJbroOh6K697T8koZaa3X
	qWKMr8oV1nzSlR+GFPL5Q36YyoWd2vyatLAG4+JfKS2mpngTm5h+jrFBUk4aTKiUcdDRyqkDZzI
	aQvV1/NUzaWvfFUmlva0COWXhJ+SxSTfHEe8OqICvl5i/LefkWI8skPyNaPn15lb3zim7piQyvO
	N4yLbA9sNCWZp6WVXTI4YkgCQM8W+Q6qUdQl6MCO8WorlxQjdLPTZo
X-Google-Smtp-Source: AGHT+IGbMBv6Zp0dBtQU2MY/WYyHe21/S+lNmhqFeFtOQVIigJfhz/Qmqq61kZu5LBzm/GoppyppHQ==
X-Received: by 2002:a05:620a:1910:b0:84b:76ba:9548 with SMTP id af79cd13be357-883523d6ef9mr3794601685a.24.1760541371038;
        Wed, 15 Oct 2025 08:16:11 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-88e536d1f05sm128357685a.38.2025.10.15.08.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 08:16:10 -0700 (PDT)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id BE2B1F40068;
	Wed, 15 Oct 2025 11:16:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 15 Oct 2025 11:16:09 -0400
X-ME-Sender: <xms:ubrvaGvTeAqNJ_uXNMrj4jPR4N65SDRrdsji0-RZEKkF7d8BajvR-Q>
    <xme:ubrvaDbd_rddq--aGbhGbgY-5lTkMmUjTztgYqvO33n6NLcynVLkpeDhcMvi0ezTh
    ettaA8vAQ-DqMDubBBsGvIXXkMC4O_GyzIghMV_tU8oEnQRf69RRA>
X-ME-Received: <xmr:ubrvaI-9sCnTqckr0zCHn8ZEG9Z98S4oBPBKIdb22ZtBmootBWxSs1KmrGK6BXGyT4m74PJ_vEko1b8ZnzNdpjvurcBHcVqh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdefjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteehuddujedvkedtkeefgedvvdeh
    tdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthho
    peduledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvthgvrhiisehnfhhrrg
    guvggrugdrohhrghdprhgtphhtthhopehmihhnghhosehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehruhhsth
    dqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlkhhmmheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopeifihhllheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorh
    hgpdhrtghpthhtoheplhhonhhgmhgrnhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:ubrvaHqNRmEnE0oVLOWCNHv_fy3ZOkrzpfipgrJxyvqvoi84fnmmpw>
    <xmx:ubrvaDErjbgQEZIx4nBsHYJBJBHU4f1pJ-tmr4UOIP-76LAjQWwE9w>
    <xmx:ubrvaPmhy9zwRSncx9ldrozOVQ_ROdBMzNQsCcGryKB21tv9_1Qn6g>
    <xmx:ubrvaH-hJFCfnf7Op-jTRY0RCPbv3VqeEFIOz1_bl_940Xz93F1UKA>
    <xmx:ubrvaIm0loiuwZ1xpe8BeNBC2JVM7xmckDi6kRGyjT75CdzO3ib-ygMa>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 11:16:09 -0400 (EDT)
Date: Wed, 15 Oct 2025 08:16:07 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@nfradead.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	alex.gaynor@gmail.com, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [GIT PULL] [PATCH 0/4] Rust locking changes for v6.18
Message-ID: <aO-6t4eYgwCdo9Ix@tardis.local>
References: <20250919091241.32138-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919091241.32138-1-boqun.feng@gmail.com>

On Fri, Sep 19, 2025 at 11:12:37AM +0200, Boqun Feng wrote:
> Hi Peter & Ingo,
> 

Peter, this pull request was missed during last cycle, and I want to
push it in this cycle, and I have two options:

* I can wait and add more locking patches in this cycle and send a PR
  in -rc4 or -rc5.

* or I can send a PR as it is at the moment (as a "part 1" of locking
  changes), and rest locking patches could be in a different PR.

Let me know which one you guys prefer, thanks!

Regards,
Boqun

> Please pull this (mostly) Rust locking changes to tip. It's a bit late
> than usual because I was at Kangrejos conference this week, however the
> changes are relatively small and simple, so I think it's Ok for v6.18.
> I also try using "git notes" for submission links as Thomas suggests,
> let see how it goes ;-)
> 
> The following changes since commit 17d9f8eaa87d40a2ff66598875a43363e37a909b:
> 
>   MAINTAINERS: update atomic infrastructure entry to include Rust (2025-09-15 09:38:36 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git/ tags/rust-locking.2025.09.19a
> 
> for you to fetch changes up to 9622209360c25d78a81048a9db72f1efef7fbc58:
> 
>   rust: lock: Add a Pin<&mut T> accessor (2025-09-15 22:28:35 -0400)
> 
> Regards,
> Boqun
> 
> ----------------------------------------------------------------
> Locking changes for v6.18:
> 
> - Fix a data-race in do_raw_write_lock reported by KCSAN
> 
> Rust locking changes for v6.18
> 
> - Make `data` in `Lock` structurally pinned.
> 
>   Previously the `data` field of a `Lock<T>` is not structurally pinned,
>   and it's impossible to initialize the `data` field with a
>   pin-initializer, hence e.g. a `Lock<T>` where T is a pin-initialized
>   type is not supported. This encourages workarounds like
>   `Lock<Pin<KBox<T>>`, which is more complicated and less efficient.
>   Therefore make the `data` field in `Lock` structurally pinned to
>   support pin-initialized types in a `Lock<T>`.
> 
>   Since the `data` field is structurally pinned, make `Guard<T, ...>`
>   only `DerefMut` is T is Unpin, otherwise `Guard::as_mut()` is added to
>   provide a `Pin<&mut T>`. This is different than normal Rust standand
>   library locks.
> -----BEGIN PGP SIGNATURE-----
> 
> iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAmjNGoEACgkQSXnow7UH
> +riU8ggAnRUTBam8NTmHJpZfVbbNSfx1ndaARxd9Wb/MLEh8OHYKbVRPJwvWGge+
> dafO0VYULku7ho1SeIlLXp4Bbjy3YC6o/J6xOpr9xMmysUky7RHi+Ys0y9gKaSmW
> daPurQEOS8TBUWu5yVxNAfWoRgPEiPULovbzgANKKAV7QsljyoEg7mQCPxLftPze
> Hr22HxU+lr6SDH5Efc8ihGqXJAvwunk+0mkJymZbjWo3ZF3cuhXlTMcIlu1SK14a
> R1VQu5UoX8S5y0T0gkJ84UJ11e0wrSZyT0EqmHWSpVBnyGgWk8H1u284hDiGG2iG
> FvwoSQ9iVuxLhxjhPUSOjq30DzmFfg==
> =MZj4
> -----END PGP SIGNATURE-----
> 
> ----------------------------------------------------------------
> Alexander Sverdlin (1):
>       locking/spinlock/debug: Fix data-race in do_raw_write_lock
> 
> Daniel Almeida (3):
>       rust: lock: guard: Add T: Unpin bound to DerefMut
>       rust: lock: Pin the inner data
>       rust: lock: Add a Pin<&mut T> accessor
> 
>  kernel/locking/spinlock_debug.c |  4 ++--
>  rust/kernel/sync/lock.rs        | 41 +++++++++++++++++++++++++++++++++++++----
>  rust/kernel/sync/lock/global.rs |  5 ++++-
>  3 files changed, 43 insertions(+), 7 deletions(-)

