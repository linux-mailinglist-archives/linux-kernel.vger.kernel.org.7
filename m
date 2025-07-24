Return-Path: <linux-kernel+bounces-744801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929C0B11123
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0038AA4469
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F062E8DED;
	Thu, 24 Jul 2025 18:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqobFAM8"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A571D149C41;
	Thu, 24 Jul 2025 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753382997; cv=none; b=OzsVKOc69ampDwxL/YwFkhDeCtgKpOW+pJys2yL9fwqCPNL0JmYE5NplcFN1G97URpXG0aenK1Cgfwwm5xjqgxyKLWzz+6wJOQhr5uWxuuAygx1qAIyS8zA90lp2yb0pRU9i8PmwhnHPRrHvIVjn6kCFcAARj7667ecnc4dFIjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753382997; c=relaxed/simple;
	bh=0lk2Lj6jyZbOXJdoiM3hjw+pGLKCzikgY/IZEJ0q+Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwwL5BuNMtI3sURozCr5lz5nL0m+kzonhy3Hb7cYrGYrFgPPkTr25HOO5nsXVRHwv0oeA9c2CIX95xCRP9pl6ftPkicgWGaKBTRGeZZuVnrIhgWy4wWtW1FqIf1+4aQrCmm4WqLszY9p/j2iTx6Hl0Jb1t8x81aI4HOxdM+SUxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqobFAM8; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7e32c5a174cso119173385a.1;
        Thu, 24 Jul 2025 11:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753382994; x=1753987794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTufhQS+aSTpjbaFUEUSNVcWnKE4FWo1OV0otoG8kU8=;
        b=aqobFAM8Z9BTr28A5RdKAg0OAbJUWwImDpXM16rz0NX56SFoJU0ZuGvErm39xy3g1v
         wrh9UKvTnVUpIxB5Iz5lXRWU6UfiCRLUR1ZX4SHgDDTYpxECjB71WSWcaOJFIeQEeQzA
         +aWHQgufZ0eMRCB+KIhfOpvwnVrnRNfWjb084MErF/gj8je7PbaV01s4V6rEiX/0VOYY
         S6V7Vd7CYBNLMzyluFor9YHPkzh/Lk3kohmYec2peeMgxp8U46FQeWt8Vs8vaq//xcVf
         vPQhhahhARFrua5quqalzluG0fjm135S+EDU0eJ5/a27KLGoT6pgmcaWUg5loZ4pfB8o
         yBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753382994; x=1753987794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTufhQS+aSTpjbaFUEUSNVcWnKE4FWo1OV0otoG8kU8=;
        b=jjjGDfqA8pZOb4uvKiM7kBpPVUz2H2d6RX2pxgsQiE4yjkBtIT0W9WADnNq54uid+m
         9VDaqlHVSp8MUsNJdJWWA13MZ1IanxGZr2EUfugOaUaRyFZKmIKALeV+nDR6nblBTO1d
         OjbieqQS3kptxoHcgkoZHZNKB0eAe9VxIv85Yce4X0VaTm1DQxOdtowVjxOR3z33XCNy
         jau7C5HmLjNbmHOJrVf1aCn4yFsFRYq9Y70fLPbScWOXhitfk6vMorsIOdeLeobfVlSt
         Q2Nia2im04YPTRydkbZul0DKOFvTJnoI0dsWOGO/JRJnCpL6NV376ANn6MVmNXjmxbWs
         AWSA==
X-Forwarded-Encrypted: i=1; AJvYcCV3QOgeezjfGu7YgRb6yn7ywyg9RExboPBO3xoiuilfwtJI+4CDk6oVtYyC5rbq/JYeP1HI75fQVPBjG7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRtvTDi4ZlOvyVx3m9KAFd1j5Yb7DTz+mkkTuGnhmCQzoWiA1Q
	Y98z0S4WHxY7wNrgaYsxcKhCj8z9J4uVQhYnEXXN37BQwVbyc5rLG06w
X-Gm-Gg: ASbGncvsSAo1/MHVXvXYW74z6qz1KUNLnP4Da4U92Ht2tTw4rZqzfIaB4PmwsvVjVy+
	9BmtDuRVnsYEslL5EiECHxtP6yEYCpwTu9MfSa0Jnf3lyNHSC4Wz7xjTpo9RUb+91ChoXgIbPBR
	EeBCp5CiEazohQLdVOCWEfM1gZLdRTcSQoMArFzYfy3Nl3JbHeldyT9wlPDZa5PSsXHoaFbhFxd
	W2JWa6+Vx1JmQW+96WWHoHC+f+nJnzTAufJ53dGjaAAmZQZjfza2gMf94h2c2V7fUazCl5ymAqi
	pJznEaeD7Jv3nliBMwK6Z1j8e5a1ZKm2qniZ0SVwCzpqtlJgTvIatJPVXvT6h+C5zCBfQ4U/FDn
	b3Nk5cKFtV+iz1EHsDku5PCjAnTH7/0+iQ86aXfe2zUSOi9Vgtxe5ZtyBn/Llisx+AHkdi1kWTo
	4cJgpTcvHdHvOlim4FDi5DRwc=
X-Google-Smtp-Source: AGHT+IE1XIBxV11BgOPejMYzaEDTuhxqFl6e/Qtbw1Rm2Vsz+GjFDSlGs5icKhT6BGddwAIko27Q5w==
X-Received: by 2002:a05:620a:6a0b:b0:7d5:e4a2:2374 with SMTP id af79cd13be357-7e62a139b10mr673641485a.8.1753382993362;
        Thu, 24 Jul 2025 11:49:53 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e632e4e336sm152235485a.88.2025.07.24.11.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 11:49:53 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8490EF40066;
	Thu, 24 Jul 2025 14:49:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 24 Jul 2025 14:49:52 -0400
X-ME-Sender: <xms:UICCaJHedA-V25PY9h63k-EoELWDOhMVcDqEvj4g7KLDtx-2BEcX6g>
    <xme:UICCaP2lRkONFJ33LL--7t5YhJLCI9pgH-ZaA5qRNfYQ1DWcEnoLn3xyEPPmz4ei3
    ucBO52u0r3szGw4cg>
X-ME-Received: <xmr:UICCaIzTF6wKkzfjj1nnvjQgr1jcM5oA0Vmi0oMfGPYHoB4jA1XyK0y0TiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekudegudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:UICCaGiNBChOgtdz0QHjFydrhgtpHoZLTf9j_WkZC3NQtYw8rVMVIQ>
    <xmx:UICCaPxABEqCkXniJ5Bw4k1YqsXK8NcR9D-DF3xEZWnE_B7Wr7r1rg>
    <xmx:UICCaMwyIRHcW8xWlPqKveF3-P5EpNXehyE_CkghqDblKFdse_peew>
    <xmx:UICCaBqA8Dw2AG5ApY-PgPmjTto9h3mgQ0J4BfhSKWqY9xaepUQbvg>
    <xmx:UICCaHmmLEWZZhfL1M99DRMkAS7hiGaoLRbpABCETyNTXw0soa3VblwI>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 14:49:51 -0400 (EDT)
Date: Thu, 24 Jul 2025 11:49:50 -0700
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
Subject: Re: [PATCH v2] rust: lock: Export Guard::do_unlocked()
Message-ID: <aIKATmsHoXNy8BEM@tardis-2.local>
References: <20250724182754.549489-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724182754.549489-1-lyude@redhat.com>

On Thu, Jul 24, 2025 at 02:27:16PM -0400, Lyude Paul wrote:
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
> 

Looks good to me. It'll probably go into v6.18 since we are at -rc7 now.
I will wait for a few more reviews. Thanks!

Regards,
Boqun

> ---
> V2:
> * Fix documentation for do_unlocked
> * Add an example
> 
> You can find an example usage of this here:
> 
> https://gitlab.freedesktop.org/lyudess/linux/-/blob/rvkms-slim/drivers/gpu/drm/rvkms/crtc.rs
> 
>  rust/kernel/sync/lock.rs | 36 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index e82fa5be289c1..e43ee5e2e4b9f 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -228,7 +228,41 @@ pub fn lock_ref(&self) -> &'a Lock<T, B> {
>          self.lock
>      }
>  
> -    pub(crate) fn do_unlocked<U>(&mut self, cb: impl FnOnce() -> U) -> U {
> +    /// Releases this [`Guard`]'s lock temporary, executes `cb` and then re-acquires it.
> +    ///
> +    /// This can be useful for situations where you may need to do a temporary unlock dance to avoid
> +    /// issues like circular locking dependencies.
> +    ///
> +    /// If the closure returns a value, it will be returned by this function.
> +    ///
> +    /// # Examples
> +    ///
> +    /// The following example shows how to use [`Guard::do_unlocked`] to temporarily release a lock,
> +    /// do some work, then re-lock it.
> +    ///
> +    /// ```
> +    /// # use kernel::{new_spinlock, sync::lock::{Backend, Guard, Lock}};
> +    /// # use pin_init::stack_pin_init;
> +    ///
> +    /// fn assert_held<T, B: Backend>(guard: &Guard<'_, T, B>, lock: &Lock<T, B>) {
> +    ///     // Address-equal means the same lock.
> +    ///     assert!(core::ptr::eq(guard.lock_ref(), lock));
> +    /// }
> +    ///
> +    /// stack_pin_init! {
> +    ///     let l = new_spinlock!(42)
> +    /// }
> +    ///
> +    /// let mut g = l.lock();
> +    /// let val = *g;
> +    ///
> +    /// // The lock will be released, but only temporarily
> +    /// g.do_unlocked(|| assert_eq!(val, 42));
> +    ///
> +    /// // `g` originates from `l` and should be relocked now.
> +    /// assert_held(&g, &l);
> +    /// ```
> +    pub fn do_unlocked<U>(&mut self, cb: impl FnOnce() -> U) -> U {
>          // SAFETY: The caller owns the lock, so it is safe to unlock it.
>          unsafe { B::unlock(self.lock.state.get(), &self.state) };
>  
> 
> base-commit: dff64b072708ffef23c117fa1ee1ea59eb417807
> -- 
> 2.50.0
> 

