Return-Path: <linux-kernel+bounces-744754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F34C4B11086
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11DD67B89D3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B75D2EBDD5;
	Thu, 24 Jul 2025 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xutrl/IK"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06161B4F0A;
	Thu, 24 Jul 2025 17:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753379683; cv=none; b=rrP0OfEGn0+8lgScPolLqQzHI/FOEp2wGdvWT0pyU+n0dc1dHxFtsagJswck23+6Yh+t51I7NDKf83dUoxvXQ5MCm1gytpMg2lF6Vqd1KDt9qGbKa+dMuPBzt5ojujnBl+DLeiuBklpQyU4Vw4q4jKefbl4wXgYIb0+GA0APZkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753379683; c=relaxed/simple;
	bh=SrbecWajszZ0E7Rg4tKhBbbcd9ooXEENh6iDv5K1md8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4C2UZF0PzTAI2lgA6A7QjhE21A6UKSeBDz6VtuNM5J8g2AGPVqAG3v+9pwoq9UHKCD0PiBi+6RHFRELRIZge/2C39W1Fz7OwH3BoAmGKgwAMXufuMse/Wbn/5AkoYMi35NB+BT9OWLwsWgiCn4wtJU15snJJm+P3XW/regLi18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xutrl/IK; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e29d5f7672so113415385a.3;
        Thu, 24 Jul 2025 10:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753379680; x=1753984480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rY/YBmfcluTP6Wi3nMV778eBkdB5PVNXljMRuZhg5g=;
        b=Xutrl/IKIVoQS+O4Ow0wJxdknO1mnnvexoDo4Fmaz23AkmRyU5GjR3aTjMbfsgfiih
         GTncjqMMrx79Iu6J5RshHH0zuXkw2utrbC6cjM2MYpwxWJJW0rjdwsQ99u+dt7J/jVnU
         ogxiqslIAwAbv3O8qBSU5i3HWTO+cp93C+MF0cSIWbnw+8wZ7gyspbNroLjNnn1JBBIy
         5bdNL/p+S8ywvbUcfSXX0HkcmjsTj6CZLDc3ux4RqV9ej3qojUHQO1D73bcnKqFpnyzF
         u/tM0DxAiqRBtntW6L879CLMIYiZo7p4XBPjciZcu+SWEDTli6/CfJNVvAGz+MNspe3d
         7EmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753379680; x=1753984480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rY/YBmfcluTP6Wi3nMV778eBkdB5PVNXljMRuZhg5g=;
        b=Hy6rsfKzGI6D8QlBJi9HNUXbRpcs8fj8qng8z4btKGlG9MigsNlRJqd8k40Ep8anQp
         bRM+EtJgOFD/yZ9IOwNd9xIniwOLIn9t1lnShDAA890Mby6NpTisJeAya0JfgdlUDwoh
         LDTDE0BPgux+IT+U3JwpRfSKSnvwdaX/6P5wHHfbNU3q4R0gyOrsb7tjXKSAqGyrLv9W
         UnekS7UM+rRp5WHkW3J7zGw3Fw0LJPr14jZeJn6EclXbhVmPujF+7KenWNelqmbkRLcj
         HS5u32hUYFfJQwBLJrDKuIZFdGd4jK9cE3PylyEBCl+tVGnO7FE3+24RpMlo1/N5DtJs
         p79A==
X-Forwarded-Encrypted: i=1; AJvYcCXyw5nQVwWPW35FJhD7bk434rTQgXKrZseGDtJE2SPf6/Kjhz+5TmAD/Z1Pi7uz0z0ECZLi7pAFFo3ZTOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJL3NYqszyrQ+EivpO2zdUipvvkTBSHPxhXmRK6LfT+YK/NoVN
	Cvt6xi/ujhoQoxxZMRFD8OkgiBeEN5y69VjziI7naXmvswa7RD30W2/PmXtOKQ==
X-Gm-Gg: ASbGnctPYXYCRaGNkHiCShT7UAUf0BC5duqw4FLpmHQ5ZgHTL6hb3X+sYhMkmW/RnqF
	abBzeZsuXSgeK9hBzZWeXBunrtiTzh/xDgEz6L+QVybIE9cdbu3qoBtRepwj4gk92IJ99n07HTs
	fY5BgQJVpuyu48cYQk5n2N0NhDUOzlZJaRK9D2hOJlu3PJrmGaJ6dY1WdjyiXhiEZARRje2zJll
	j4tMtXcyaWvrFhwSbRSwi9g/osrsMgyAIaw/jy6IK85CBVJc7owHwn3EwGN2jaTj4nOPoxjRXyD
	/2rlV32ORrijoEF264G30kUYCaWYNTRm/DxAtPTCX1/K4oDFpEqar7L678tFphBtY4BgIw1oXyb
	coIUfgmpsUvGS2ICJTAxNi4J59/eEyc7bELH/iiibEiuRL9wqwDwkWDhQ+5rByw65exsb83IVT9
	AeVR1u9nWuDY1H+qZbr39SnYo=
X-Google-Smtp-Source: AGHT+IG5y4w2WgnuRSjklyIYU9frH4en/w0/K+mowFhQ8WZSo86SvdD0+GCUMBbv4+OvZCuP/lalVg==
X-Received: by 2002:a05:620a:1986:b0:7e3:2d1d:bda0 with SMTP id af79cd13be357-7e62a096683mr931743085a.2.1753379680368;
        Thu, 24 Jul 2025 10:54:40 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e632e4c4dfsm144051285a.89.2025.07.24.10.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 10:54:40 -0700 (PDT)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 77A17F40068;
	Thu, 24 Jul 2025 13:54:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 24 Jul 2025 13:54:39 -0400
X-ME-Sender: <xms:X3OCaJXn_qfNVaSqHWgh7BJjkJbV5OB2SMaKvRD21VrynZAtSUFUWg>
    <xme:X3OCaLEU1gEc8nnvljTB97R1NOsM3Uq1RTAsmzjZicsFJxFpl5IH28W7Ts24e3380
    crKZZU_mRwBPNC0fg>
X-ME-Received: <xmr:X3OCaDCuj9Ll2xDVu5PeDbCezjMFtsqfy1wwBms6_ijOP-09f1uaogY7heE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnheptdduvedtffevfefgleefveekgeetudeigffhkeegvefffeeikeehlefhtdeiteeu
    necuffhomhgrihhnpehfrhgvvgguvghskhhtohhprdhorhhgpdgtrhhttgdrrhhsnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopedukedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eplhihuhguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprhhushhtqdhfohhrqdhl
    ihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehlih
    hnuhhtrhhonhhigidruggvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrg
    gurdhorhhgpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpthht
    ohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhnghhmrghnsehrvg
    guhhgrthdrtghomhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:X3OCaDz9q_4BrfdQJTbBRxC8HcRpgXKNisu4L6zWZACNQUyt3K_v1A>
    <xmx:X3OCaEBWNw1ch5obsD5RMgOgBO-r4sCbwMVguiAm286m6kZdEggkmg>
    <xmx:X3OCaMBYrKVKc91oBp2uPFltNkABiS0tOm3l7-tz-OiaCrLKC3-JwA>
    <xmx:X3OCaP7gOBXFAYpcXjMT3Bnrwl-icQd_w_sVOe-q4yCSI7nnf-M3UA>
    <xmx:X3OCaI2_Om2DamPpGm_zMwdk-0kQWt7rIHFx4uDCoW4olsxVBZNJtcNH>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 13:54:38 -0400 (EDT)
Date: Thu, 24 Jul 2025 10:54:37 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH] rust: lock: Export Guard::do_unlocked()
Message-ID: <aIJzXV8XyIo5O3F6@tardis-2.local>
References: <20250724172615.436901-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724172615.436901-1-lyude@redhat.com>

On Thu, Jul 24, 2025 at 01:25:00PM -0400, Lyude Paul wrote:
> In RVKMS, I discovered a silly issue where as a result of our HrTimer for
> vblank emulation and our vblank enable/disable callbacks sharing a
> spinlock, it was possible to deadlock while trying to disable the vblank
> timer.
> 
> The solution for this ended up being simple: keep track of when the HrTimer
> could potentially acquire the shared spinlock, and simply drop the spinlock
> temporarily from our vblank enable/disable callbacks when stopping the
> timer. And do_unlocked() ended up being perfect for this.
> 
> Since this seems like it's useful, let's export this for use by the rest of
> the world and write short documentation for it.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Seems reasonable.

> ---
> You can find an example usage of this here:
> 
>   https://gitlab.freedesktop.org/lyudess/linux/-/blob/rvkms-slim/drivers/gpu/drm/rvkms/crtc.rs
> 
>  rust/kernel/sync/lock.rs | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index e82fa5be289c1..60eb98805a489 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -228,7 +228,13 @@ pub fn lock_ref(&self) -> &'a Lock<T, B> {
>          self.lock
>      }
>  
> -    pub(crate) fn do_unlocked<U>(&mut self, cb: impl FnOnce() -> U) -> U {
> +    /// Unlock this [`Guard`]'s lock temporarily, execute `cb`, and then re-lock it.

I would like to change this line as the following to be consistent with
other comments in the file.

/// Releases this [`Guard`]'s lock temporary, executes `cb` and then re-acquires it.

> +    ///
> +    /// This can be useful for situations where you may need to do a temporary unlock dance to avoid
> +    /// issues like circular locking dependencies.
> +    ///

Could you add an "# Examples" section here with a simple example?
Thanks!

Otherwise it looks good to me, thanks!

Regards
Boqun

> +    /// If the closure returns a value, it will be returned by this function.
> +    pub fn do_unlocked<U>(&mut self, cb: impl FnOnce() -> U) -> U {
>          // SAFETY: The caller owns the lock, so it is safe to unlock it.
>          unsafe { B::unlock(self.lock.state.get(), &self.state) };
>  
> 
> base-commit: dff64b072708ffef23c117fa1ee1ea59eb417807
> -- 
> 2.50.0
> 

