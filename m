Return-Path: <linux-kernel+bounces-802013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D612B44CC9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8B16585A55
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD18C275AE8;
	Fri,  5 Sep 2025 04:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpOUZ+HK"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B4E202960;
	Fri,  5 Sep 2025 04:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757047322; cv=none; b=Au5foxPHGLSZAEIODF/aOKzW34e+02XrsfIX/B/bsflZD5eOzYh+wLiGzx6aO4ZHZBGem/BzUijr8V1doD364sjvKwiVLvHgqybZY9rwqi4xr23YIoix/G+rPHP2IMAL5mKaP6auUhHYsLtGDKhyzFC1opdpy6MSKBl0bshl304=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757047322; c=relaxed/simple;
	bh=f4eiBwubrd47ulH8dsOU/+6cPfr4kyy+koNkZCKYUnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMqoDgK50qCZPVFbKkGK9stKGLXrmhGlQGyGmG634RLqtcm+ti444P5tQgyLH3gxJVqsPKkXbZJ73vJHQN4R+gRA2NEiLDDtikyUAN3E+oHGhVYiEXvXlPw3oEFVa3pEdvXaKci9Jc9yDtmVGg8Dc2TV+UOh3j9GrSCMZSUEpC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpOUZ+HK; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-726549f81bdso16766236d6.3;
        Thu, 04 Sep 2025 21:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757047319; x=1757652119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rn2GfE/ftcH+bcKjBN/MiRCnBIOgKwY3iKOh6OgZfLw=;
        b=dpOUZ+HKzFnsf+foKDK19ZWwqrGhkaZThtM6rn9o5QPJ51/+kxbzA5BCtgFeZs4paI
         lUgJzhV/h7PaoffKoPWzDfHvHDUJkiZ+UaObKbJkLf91GiUiutHBckZK1+QWIU49OorY
         lQ85zzU1DzkQfyLHPC0OCD6zzdz0y2bgdh/VbHSYA9Uj5QeoGZ/g20MDFNWZnC78g0u9
         igeuAOguQ9fIo4ShevuiqJFLXUibd2rV3HBk3sWS+EJHEiQttXwVdbQJjfuL+e/ERZzR
         EAZpxZWx44egz7Av0OPPbu8l3xwYtosvcEqQKP3eKMTW3WStOoz8xnT9zrfFmWsk6dur
         rNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757047319; x=1757652119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rn2GfE/ftcH+bcKjBN/MiRCnBIOgKwY3iKOh6OgZfLw=;
        b=Z/qr+ETiT4z2JommFqIy3lbr3QhsidvnFyhLmipcE4kDgSj1mtd8Ie21+IsTGhVABz
         wbUkWE/KDh/uN4QIG9QNUdQANhozrn74GSiTjbrvRyeI3tQskw7Ae+2PID1XWcrqjjTu
         QzuU0bcjA8WoFBxBGYOnFvxgqPchZqbRJyTetQBAXVhZxCLkvSaHt2DsNpZPVS02OEKy
         0biHyt2hbfNtjjhm+OfXoQvnZQCGSjnL21eJ9Qcu7FDTNnHvBKvN1FI/mWbY+7W1PY66
         IKm//ooyGRG4VaFdudbM3cdLf+cuwl5BWLAC797wJvwZDKb89/udBUnPH0GKyTsDbK+M
         wT6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVcpHFRKICcYz0RB9Ugbr0eABV10TnjFbLcaYLr6Wl1ZSLHsVjWhL5gPbm/oTRkDBtZvrDWPRQAMjKwWtE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdh9dcK3Oe9Q38jjwhT7VLC4R2UzbnlZkvBRuRThJIsB1kQ9Kd
	bafh7BkgVsCoWfX1+iN46g4qdG34L0qXkhPavXw74YTBN3BcARyvPbrJDCWUWw==
X-Gm-Gg: ASbGncvPtA+Y4gC4joujZMP5qvzaQGtgzYDKmeQPCMioxL80fG2/Hb3+/l6QgXEWQLU
	IUGEzSWszlvZ5F7HFcaqiHUQ72BfRrfkfnAlqQnBhxo5zsq+nipoH25iG0jKZ8knpw5KlcCr2YK
	5YgyULPcfc9fXuCjM2IZX5UNk0W0RUwzxsBTArM1rN5IQWii54vsjxjq6l+OZ+txfSy41HnvGvw
	tnrTRiBKRescU/8P8eU2iKE+WmOACAyW4G62ztk+QlqOHEzskj7yfHDx0cR9L0sMrs6WLW9hSQT
	op5mxQAEtc7tNQf06dclO+s56MYpJ3Ay91cRkaH1610+fRb3iMwwN1IW9dVUIzVsAwyXWPh02U/
	kJrwLmaJR6o37ZGast5HmOCcWOWZzjiSwY11MzYJD2vP+V9xdtNeXrJL0XbVRhWrJ9TfaU/7RUz
	qxyCjyru8TbzxXgPeowVhhf42iwFW6CG7CVQ==
X-Google-Smtp-Source: AGHT+IEFsWgkYgheaas7fNYfUn2vlQ/fBdzANdaDfeIptNsyRkloxoBsH35cO508AekNDiND/bs9OA==
X-Received: by 2002:a05:6214:4710:b0:726:9bc3:f8b5 with SMTP id 6a1803df08f44-7269bc3fa6emr76740126d6.32.1757047319057;
        Thu, 04 Sep 2025 21:41:59 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b6a1bec4sm58765486d6.67.2025.09.04.21.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 21:41:58 -0700 (PDT)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2AAB4F40066;
	Fri,  5 Sep 2025 00:41:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 05 Sep 2025 00:41:58 -0400
X-ME-Sender: <xms:Fmq6aDqGQu_Od5Kf4TTdaAH1qZxD9w0HI1ZhnyqpqUvQ_hYzYX10PQ>
    <xme:Fmq6aLUpd7ZkaEfDRRw-NAkvA1178shPZrHhEqrRVcd54_lvh4AbFc5EpF5r5_lm6
    Qo9lTcMXK14huY0_w>
X-ME-Received: <xmr:Fmq6aB9KhHxofyUFJlrCYrs1oiWFXQ6WGZjxyjCDjRcsuk3pHyMvkmA1-GnIPW0mX-MLDpOfsY7oxNVd48Zp8OL6A5lluEkH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpefghfffvefhhfdvgfejgfekvdelgfekgeevueehlefhiedvgeffjefgteeugfehieen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnh
    hgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedv
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuh
    igsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhkmhhmsehlihhsth
    hsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhope
    hmrghrkhdrrhhuthhlrghnugesrghrmhdrtghomhdprhgtphhtthhopehmihhnghhosehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvg
    dprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Fmq6aDYi65Bs3oE_SuP9m1WTjgNjN44j7PUkH-rqo_fQ6cvhXyUkpA>
    <xmx:Fmq6aJer_RKieZu4GcWyG53sXR5jdIOvgc45egyGMp67mRujFdGOGQ>
    <xmx:Fmq6aNraKSkbdjv0uFeKn_x_R2a2j_XeHks78n-8KdbDpBl2VTf4_w>
    <xmx:Fmq6aAC_eLg3yaVJndNzve2ivZmIKQM7cUA5bk36pzxLdCp4GDWJEQ>
    <xmx:Fmq6aLVgvZmUqC4oNxwhlbzQMetOViHIsbH0HkgShc-qAFELFcvK3luX>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 00:41:57 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev
Cc: "Will Deacon" <will@kernel.org>,
	"Peter Zijlstra" <peterz@infradead.org>,
	"Mark Rutland" <mark.rutland@arm.com>,
	"Ingo Molnar" <mingo@kernel.org>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	stern@rowland.harvard.edu,
	"Miguel Ojeda" <ojeda@kernel.org>,
	alex.gaynor@gmail.com,
	"Gary Guo" <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	"Benno Lossin" <lossin@kernel.org>,
	"Alice Ryhl" <aliceryhl@google.com>,
	"Trevor Gross" <tmgross@umich.edu>,
	"Danilo Krummrich" <dakr@kernel.org>,
	"Andreas Hindborg" <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 04/14] rust: sync: atomic: Add generic atomics
Date: Thu,  4 Sep 2025 21:41:31 -0700
Message-ID: <20250905044141.77868-5-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905044141.77868-1-boqun.feng@gmail.com>
References: <20250905044141.77868-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To provide using LKMM atomics for Rust code, a generic `Atomic<T>` is
added, currently `T` needs to be Send + Copy because these are the
straightforward usages and all basic types support this.

Implement `AtomicType` for `i32` and `i64`, and so far only basic
operations load() and store() are introduced.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/all/20250719030827.61357-5-boqun.feng@gmail.com/
---
 rust/kernel/sync/atomic.rs           | 271 +++++++++++++++++++++++++++
 rust/kernel/sync/atomic/predefine.rs |  15 ++
 2 files changed, 286 insertions(+)
 create mode 100644 rust/kernel/sync/atomic/predefine.rs

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index 2302e6d51fe2..ea5782b6ee95 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -19,6 +19,277 @@
 #[allow(dead_code, unreachable_pub)]
 mod internal;
 pub mod ordering;
+mod predefine;
 
 pub use internal::AtomicImpl;
 pub use ordering::{Acquire, Full, Relaxed, Release};
+
+use crate::build_error;
+use internal::{AtomicBasicOps, AtomicRepr};
+use ordering::OrderingType;
+
+/// A memory location which can be safely modified from multiple execution contexts.
+///
+/// This has the same size, alignment and bit validity as the underlying type `T`. And it disables
+/// niche optimization for the same reason as [`UnsafeCell`].
+///
+/// The atomic operations are implemented in a way that is fully compatible with the [Linux Kernel
+/// Memory (Consistency) Model][LKMM], hence they should be modeled as the corresponding
+/// [`LKMM`][LKMM] atomic primitives. With the help of [`Atomic::from_ptr()`] and
+/// [`Atomic::as_ptr()`], this provides a way to interact with [C-side atomic operations]
+/// (including those without the `atomic` prefix, e.g. `READ_ONCE()`, `WRITE_ONCE()`,
+/// `smp_load_acquire()` and `smp_store_release()`).
+///
+/// # Invariants
+///
+/// `self.0` is a valid `T`.
+///
+/// [`UnsafeCell`]: core::cell::UnsafeCell
+/// [LKMM]: srctree/tools/memory-model/
+/// [C-side atomic operations]: srctree/Documentation/atomic_t.txt
+#[repr(transparent)]
+pub struct Atomic<T: AtomicType>(AtomicRepr<T::Repr>);
+
+// SAFETY: `Atomic<T>` is safe to share among execution contexts because all accesses are atomic.
+unsafe impl<T: AtomicType> Sync for Atomic<T> {}
+
+/// Types that support basic atomic operations.
+///
+/// # Round-trip transmutability
+///
+/// `T` is round-trip transmutable to `U` if and only if both of these properties hold:
+///
+/// - Any valid bit pattern for `T` is also a valid bit pattern for `U`.
+/// - Transmuting (e.g. using [`transmute()`]) a value of type `T` to `U` and then to `T` again
+///   yields a value that is in all aspects equivalent to the original value.
+///
+/// # Safety
+///
+/// - [`Self`] must have the same size and alignment as [`Self::Repr`].
+/// - [`Self`] must be [round-trip transmutable] to  [`Self::Repr`].
+///
+/// Note that this is more relaxed than requiring the bi-directional transmutability (i.e.
+/// [`transmute()`] is always sound between `U` and `T`) because of the support for atomic
+/// variables over unit-only enums, see [Examples].
+///
+/// # Limitations
+///
+/// Because C primitives are used to implement the atomic operations, and a C function requires a
+/// valid object of a type to operate on (i.e. no `MaybeUninit<_>`), hence at the Rust <-> C
+/// surface, only types with all the bits initialized can be passed. As a result, types like `(u8,
+/// u16)` (padding bytes are uninitialized) are currently not supported.
+///
+/// # Examples
+///
+/// A unit-only enum that implements [`AtomicType`]:
+///
+/// ```
+/// use kernel::sync::atomic::{AtomicType, Atomic, Relaxed};
+///
+/// #[derive(Clone, Copy, PartialEq, Eq)]
+/// #[repr(i32)]
+/// enum State {
+///     Uninit = 0,
+///     Working = 1,
+///     Done = 2,
+/// };
+///
+/// // SAFETY: `State` and `i32` has the same size and alignment, and it's round-trip
+/// // transmutable to `i32`.
+/// unsafe impl AtomicType for State {
+///     type Repr = i32;
+/// }
+///
+/// let s = Atomic::new(State::Uninit);
+///
+/// assert_eq!(State::Uninit, s.load(Relaxed));
+/// ```
+/// [`transmute()`]: core::mem::transmute
+/// [round-trip transmutable]: AtomicType#round-trip-transmutability
+/// [Examples]: AtomicType#examples
+pub unsafe trait AtomicType: Sized + Send + Copy {
+    /// The backing atomic implementation type.
+    type Repr: AtomicImpl;
+}
+
+#[inline(always)]
+const fn into_repr<T: AtomicType>(v: T) -> T::Repr {
+    // SAFETY: Per the safety requirement of `AtomicType`, `T` is round-trip transmutable to
+    // `T::Repr`, therefore the transmute operation is sound.
+    unsafe { core::mem::transmute_copy(&v) }
+}
+
+/// # Safety
+///
+/// `r` must be a valid bit pattern of `T`.
+#[inline(always)]
+const unsafe fn from_repr<T: AtomicType>(r: T::Repr) -> T {
+    // SAFETY: Per the safety requirement of the function, the transmute operation is sound.
+    unsafe { core::mem::transmute_copy(&r) }
+}
+
+impl<T: AtomicType> Atomic<T> {
+    /// Creates a new atomic `T`.
+    pub const fn new(v: T) -> Self {
+        // INVARIANT: Per the safety requirement of `AtomicType`, `into_repr(v)` is a valid `T`.
+        Self(AtomicRepr::new(into_repr(v)))
+    }
+
+    /// Creates a reference to an atomic `T` from a pointer of `T`.
+    ///
+    /// This usually is used when communicating with C side or manipulating a C struct, see
+    /// examples below.
+    ///
+    /// # Safety
+    ///
+    /// - `ptr` is aligned to `align_of::<T>()`.
+    /// - `ptr` is valid for reads and writes for `'a`.
+    /// - For the duration of `'a`, other accesses to `*ptr` must not cause data races (defined
+    ///   by [`LKMM`]) against atomic operations on the returned reference. Note that if all other
+    ///   accesses are atomic, then this safety requirement is trivially fulfilled.
+    ///
+    /// [`LKMM`]: srctree/tools/memory-model
+    ///
+    /// # Examples
+    ///
+    /// Using [`Atomic::from_ptr()`] combined with [`Atomic::load()`] or [`Atomic::store()`] can
+    /// achieve the same functionality as `READ_ONCE()`/`smp_load_acquire()` or
+    /// `WRITE_ONCE()`/`smp_store_release()` in C side:
+    ///
+    /// ```
+    /// # use kernel::types::Opaque;
+    /// use kernel::sync::atomic::{Atomic, Relaxed, Release};
+    ///
+    /// // Assume there is a C struct `foo`.
+    /// mod cbindings {
+    ///     #[repr(C)]
+    ///     pub(crate) struct foo {
+    ///         pub(crate) a: i32,
+    ///         pub(crate) b: i32
+    ///     }
+    /// }
+    ///
+    /// let tmp = Opaque::new(cbindings::foo { a: 1, b: 2 });
+    ///
+    /// // struct foo *foo_ptr = ..;
+    /// let foo_ptr = tmp.get();
+    ///
+    /// // SAFETY: `foo_ptr` is valid, and `.a` is in bounds.
+    /// let foo_a_ptr = unsafe { &raw mut (*foo_ptr).a };
+    ///
+    /// // a = READ_ONCE(foo_ptr->a);
+    /// //
+    /// // SAFETY: `foo_a_ptr` is valid for read, and all other accesses on it is atomic, so no
+    /// // data race.
+    /// let a = unsafe { Atomic::from_ptr(foo_a_ptr) }.load(Relaxed);
+    /// # assert_eq!(a, 1);
+    ///
+    /// // smp_store_release(&foo_ptr->a, 2);
+    /// //
+    /// // SAFETY: `foo_a_ptr` is valid for writes, and all other accesses on it is atomic, so
+    /// // no data race.
+    /// unsafe { Atomic::from_ptr(foo_a_ptr) }.store(2, Release);
+    /// ```
+    pub unsafe fn from_ptr<'a>(ptr: *mut T) -> &'a Self
+    where
+        T: Sync,
+    {
+        // CAST: `T` and `Atomic<T>` have the same size, alignment and bit validity.
+        // SAFETY: Per function safety requirement, `ptr` is a valid pointer and the object will
+        // live long enough. It's safe to return a `&Atomic<T>` because function safety requirement
+        // guarantees other accesses won't cause data races.
+        unsafe { &*ptr.cast::<Self>() }
+    }
+
+    /// Returns a pointer to the underlying atomic `T`.
+    ///
+    /// Note that use of the return pointer must not cause data races defined by [`LKMM`].
+    ///
+    /// # Guarantees
+    ///
+    /// The returned pointer is valid and properly aligned (i.e. aligned to [`align_of::<T>()`]).
+    ///
+    /// [`LKMM`]: srctree/tools/memory-model
+    /// [`align_of::<T>()`]: core::mem::align_of
+    pub const fn as_ptr(&self) -> *mut T {
+        // GUARANTEE: Per the function guarantee of `AtomicRepr::as_ptr()`, the `self.0.as_ptr()`
+        // must be a valid and properly aligned pointer for `T::Repr`, and per the safety guarantee
+        // of `AtomicType`, it's a valid and properly aligned pointer of `T`.
+        self.0.as_ptr().cast()
+    }
+
+    /// Returns a mutable reference to the underlying atomic `T`.
+    ///
+    /// This is safe because the mutable reference of the atomic `T` guarantees exclusive access.
+    pub fn get_mut(&mut self) -> &mut T {
+        // CAST: `T` and `T::Repr` has the same size and alignment per the safety requirement of
+        // `AtomicType`, and per the type invariants `self.0` is a valid `T`, therefore the casting
+        // result is a valid pointer of `T`.
+        // SAFETY: The pointer is valid per the CAST comment above, and the mutable reference
+        // guarantees exclusive access.
+        unsafe { &mut *self.0.as_ptr().cast() }
+    }
+}
+
+impl<T: AtomicType> Atomic<T>
+where
+    T::Repr: AtomicBasicOps,
+{
+    /// Loads the value from the atomic `T`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::sync::atomic::{Atomic, Relaxed};
+    ///
+    /// let x = Atomic::new(42i32);
+    ///
+    /// assert_eq!(42, x.load(Relaxed));
+    ///
+    /// let x = Atomic::new(42i64);
+    ///
+    /// assert_eq!(42, x.load(Relaxed));
+    /// ```
+    #[doc(alias("atomic_read", "atomic64_read"))]
+    #[inline(always)]
+    pub fn load<Ordering: ordering::AcquireOrRelaxed>(&self, _: Ordering) -> T {
+        let v = {
+            match Ordering::TYPE {
+                OrderingType::Relaxed => T::Repr::atomic_read(&self.0),
+                OrderingType::Acquire => T::Repr::atomic_read_acquire(&self.0),
+                _ => build_error!("Wrong ordering"),
+            }
+        };
+
+        // SAFETY: `v` comes from reading `self.0`, which is a valid `T` per the type invariants.
+        unsafe { from_repr(v) }
+    }
+
+    /// Stores a value to the atomic `T`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::sync::atomic::{Atomic, Relaxed};
+    ///
+    /// let x = Atomic::new(42i32);
+    ///
+    /// assert_eq!(42, x.load(Relaxed));
+    ///
+    /// x.store(43, Relaxed);
+    ///
+    /// assert_eq!(43, x.load(Relaxed));
+    /// ```
+    #[doc(alias("atomic_set", "atomic64_set"))]
+    #[inline(always)]
+    pub fn store<Ordering: ordering::ReleaseOrRelaxed>(&self, v: T, _: Ordering) {
+        let v = into_repr(v);
+
+        // INVARIANT: `v` is a valid `T`, and is stored to `self.0` by `atomic_set*()`.
+        match Ordering::TYPE {
+            OrderingType::Relaxed => T::Repr::atomic_set(&self.0, v),
+            OrderingType::Release => T::Repr::atomic_set_release(&self.0, v),
+            _ => build_error!("Wrong ordering"),
+        }
+    }
+}
diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/predefine.rs
new file mode 100644
index 000000000000..33356deee952
--- /dev/null
+++ b/rust/kernel/sync/atomic/predefine.rs
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Pre-defined atomic types
+
+// SAFETY: `i32` has the same size and alignment with itself, and is round-trip transmutable to
+// itself.
+unsafe impl super::AtomicType for i32 {
+    type Repr = i32;
+}
+
+// SAFETY: `i64` has the same size and alignment with itself, and is round-trip transmutable to
+// itself.
+unsafe impl super::AtomicType for i64 {
+    type Repr = i64;
+}
-- 
2.51.0


