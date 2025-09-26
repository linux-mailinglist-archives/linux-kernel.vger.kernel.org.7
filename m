Return-Path: <linux-kernel+bounces-834331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 166E3BA4770
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C52BF62269D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B2022128A;
	Fri, 26 Sep 2025 15:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjzZa+Hc"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EBE21CC68
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 15:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758901490; cv=none; b=X2yNIBhKNjgDKFA9trW0qV+lVVm8Y/7RCtVylGhFttX/0etEns9z3x8mkzhvu79xoQV5H1eje3FpRLeGQZWwJjHByyxIYNg0QAvy62+sJDU6GVAp0VW60LP5dofMuxtBrXnRIna5wyz5MGxiCzPyGjShm47athmEC0hbmgVca7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758901490; c=relaxed/simple;
	bh=gw8GlEm/pMe/T6lV132M5o7O/nbVio5JrXJlGluzWjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzZHFe7+FnKPBO2waGdqllwhKGwTYi4XogYzdg+VorAyk8z157Urm4hmgIs0fnGtyM+tli5K9bAFJg68yhxfJoI/fjucGzLfZ++5gxY63zfjwSeD4nPoRRSErnvEJT2oZ0+W16f4N+eCMksrDs2t9fqFTcYETqWPmbAcxndKwkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjzZa+Hc; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-85cee530df9so229729185a.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758901488; x=1759506288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mcGhhHjp2eXgOL7P5TYM8JSLgVlfC9igU21PobzEN4=;
        b=WjzZa+Hc2Bvs4HPFJ4BTqH0d3NnRe7jnmlv4orJF6xTVdUGTr04GIzSdSMtglozzn0
         qHP4h6h9tzHV7fNtgTEGXM/3sO0O8NErtBicCRpsFBZ6ZP6/cSxl3DIb7IC4IjiXDl/x
         0GRS/PIp4kp+o9rJv2L39VRZdhTtini8wK9dMe7LIodr0+w/kUHdFovHMjErzhRdPeJs
         IYxMSIZMzLRUAEDWJbT2V1VvUIQKhJYFpkN0YMXjiROiwNFGB5A8LLPkkNYxZQAB/6Zu
         tAGvFT9EPSRX8Tyd5kbiAH60cNYht1SrcNLGJ9HMhUG5YPO+O3J89A2/WsVZjxDSKk4Z
         fgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758901488; x=1759506288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mcGhhHjp2eXgOL7P5TYM8JSLgVlfC9igU21PobzEN4=;
        b=Ubo1N7z2uNSwJ26G6gz/3+XNMMyEHehXEQzo3P6FI+FHqy5bT+zYs+i4CiLroGCrRB
         hUyiJiSXWW07EJgQcsoXqY0W4LxMzkjVbXdxMnTwdZW6B/fL2vhfr/gbpYHNz+hm2GBj
         wOpUgYiHpHov9v2SOLyd7EueR0WaVOZh/l+5ZZAyu4iQgU9YfWC6jfVH8PZODTfjTAE3
         DdSxVKY9KFN66mntrlNjjQBgyCNAQXTV8Lz5lRCHIUkQn4qs7L6BDCytn46HFqF7Xp3z
         mZ4oGtykYU1cO9CH+RoHfrRNB5oopkLJYce8i0ldqZl+H211m3JKX8gGl2Ryfr6XBifg
         5gvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWltZfa4J8xbby0/lekSTby9wE2Eln70IdMvFy1My11DmYNVFWJveixAcUzuov2DJSSQfJk+goQ2vBvlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYgOkZbiSWCGpUjgGIxMVHG3nKDb1+LHZzcY2Rk0gTlNnbfY5R
	e6LRs6f3yeull/qgVinKiHa99r8SxnLAukeZvgsAc0BNxwBb5IqkU6cc
X-Gm-Gg: ASbGnctSR0KNBzV/obHlQL8vHS0BRoeVaZ3/4DM1+XxI56VaEJK8RvxG5w+jo8SzbTU
	Y4G/KNc1UudG+qE03SkQ12G6oBSmxx2a//ekRDv4YZsl0nXbFyIot33H7JGp4gcc5lKTxjMG+SK
	XNVDYaLrIDrCaVH1cl6YL/pg7JOuUqOZTARH6OR3yg8UytmYmTJe4fccsrRdY8EIlsOWJJH/jGv
	N+6QgguiQ52afI5SUtFFkdQ0EmAkSPxn6eIhu+MQqN2MlPdYPIB7RAuzWxuf9VMuKGosqSHmDt+
	mhAzx14RsubzkZ/5YWsNCNu1PhlPwE0OASKEpnilaH4Wa1XxFSlkwxksd2wjFmYh8W3m6vtpGTR
	+/Xf6EdiqWicQEyNQqwu2clXtwZTTSbxkqIlsmm8lyuAKjC9M5WFW9c8Op6h7hynHaVMYyMBmAT
	ASt8/4HD/matZr4Fr2t4ZTnhf/3zH2zjgFFw==
X-Google-Smtp-Source: AGHT+IF4wq9zktArSY6pgVpnyiaBJyrWrNThCHzoU9ocyuGVqekUKxsMvPATedxtbT74AR7HQqtngw==
X-Received: by 2002:a05:6214:1c84:b0:731:e432:888c with SMTP id 6a1803df08f44-7fc386ed8ccmr41407516d6.35.1758901487586;
        Fri, 26 Sep 2025 08:44:47 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80143053d1esm28046766d6.32.2025.09.26.08.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 08:44:47 -0700 (PDT)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 25925F4007B;
	Fri, 26 Sep 2025 11:44:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 26 Sep 2025 11:44:46 -0400
X-ME-Sender: <xms:7bTWaD8GaXpVPbrps4d7E9n_bjzzRhZyG3UvDqjG81DMRYYMxzL2Tw>
    <xme:7bTWaP5evZu5Jr9rE7T_zoz5mMUoC-9VM42W6g_142QkRYuEIfMVqWZSfur5_keVF
    Uw-YrVo3i0uiyx6K7a6e2wombFiL7v2-MhxjU2qTfgBZcmuDcrq7Q>
X-ME-Received: <xmr:7bTWaDoLBZ1TjkSNsGNG9Isnd9Z5-o_3v-_n8RrKeYiNEoS79BAnCtlDLX9I7E3_Y2ICHPCmx3NsOJ4kQRgHwE2mfk-CRmS9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeileejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeegvddvhedt
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    feehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhgrshhtrgeskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhi
    esghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothho
    nhhmrghilhdrtghomhdprhgtphhtthhopehlohhsshhinheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehtmhhgrhhosh
    hssehumhhitghhrdgvughu
X-ME-Proxy: <xmx:7rTWaLDaM191edQ-YKFNpdeiSbvBtv0cpOhQkc4eQR5XyuNUhps9_g>
    <xmx:7rTWaMMxsC4UmqKLuFihps-FBk1oH04IIIOSgN3xQpOaRyNBxu4Q1w>
    <xmx:7rTWaKnkSMn9Z8haCh4AUBredHO5C0g2OqlHlwk31tIpgC2aEKfb9A>
    <xmx:7rTWaOd94ceZ9RNOFgxiSxh7w7N-BU8xivt9AOWwAFKni64LYzL32Q>
    <xmx:7rTWaPCKNLmxIZnmFKhOcWjFMyzLQM-dpSYZbCkdoHOB8J79vxdCuKbB>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Sep 2025 11:44:45 -0400 (EDT)
Date: Fri, 26 Sep 2025 08:44:43 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: phasta@kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,	Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>,	Waiman Long <longman@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,	Justin Stitt <justinstitt@google.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Asahi Lina <lina+kernel@asahilina.net>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Krishna Ketan Rai <prafulrai522@gmail.com>,
	Lyude Paul <lyude@redhat.com>,	Mitchell Levy <levymitchell0@gmail.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH] rust: sync: Add dma_fence abstractions
Message-ID: <aNa069wZv1cn8VGh@tardis.local>
References: <20250918123100.124738-2-phasta@kernel.org>
 <aMwOoYe1xGDBg0Zv@tardis-2.local>
 <12c09de235023c99a8a864b17b2f797c7339bb7b.camel@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12c09de235023c99a8a864b17b2f797c7339bb7b.camel@mailbox.org>

On Fri, Sep 26, 2025 at 10:48:06AM +0200, Philipp Stanner wrote:
[..]
> > > 
> > > Regarding the manually created spinlock of mine: I so far never need
> > > that spinlock anywhere in Rust and wasn't sure what's then the best way
> > > to pass a "raw" spinlock to C.
> > > 
> > 
> > You can use `SpinLock<()>` for this purpose, no need to add new
> > bindings.
> 
> The dma_fence C backend needs a spinlock pointer, given to it by the
> driver (so Rust code).
> 
> How do I pass a SpinLock<()> to a C function? AFAICS SpinLock doesn't
> implement as_raw(), so I'd have to implement it, wouldn't I?
> 

Technically you can use a `&raw` to get the address of the spinlock and
just use it, since `SpinLock<()>` is `repr(C)`, so it's transparent to a 
spinlock_t. So you don't have to ;-)

However, while we are at it, it makes sense that we do it right.

> Or rather, as it looks, I'd have to implement it for SpinLockBackend?
> 

I think the below should work, we already have a special from_raw() for
Lock<()>, it makes sense to have a special as_raw() as well.

Let me know if you want me to send a proper patch, or feel free to add
one in your patchset ;-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 27202beef90c..78f3287a1372 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -160,6 +160,13 @@ pub unsafe fn from_raw<'a>(ptr: *mut B::State) -> &'a Self {
         //   `B::State`.
         unsafe { &*ptr.cast() }
     }
+
+    /// Obtains the raw pointer from a [`Lock`].
+    ///
+    /// This can be useful for working with a lock user outside Rust.
+    pub fn as_raw(&self) -> *mut B::State {
+        self.state.get()
+    }
 }

 impl<T: ?Sized, B: Backend> Lock<T, B> {


Regards,
Boqun

> 
> P.
> 
> > 
> > [1]: https://lore.kernel.org/rust-for-linux/20250905044141.77868-1-boqun.feng@gmail.com/
> > 
> > Regards,
> > Boqun
> > 
> > > 
> > > So much from my side. Hope to hear from you.
> > > 
> > > (I've compiled and tested this with the unit test on the current -rc3)
> > > 
> > > Philipp
> > > ---
> > [...]
> 

