Return-Path: <linux-kernel+bounces-744721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECC6B11043
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B75AAE25C8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5D62EB5D4;
	Thu, 24 Jul 2025 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DU8fH2HB"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E227494;
	Thu, 24 Jul 2025 17:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753377612; cv=none; b=XPYMFMJFQjcPMHcFqLg0NzwYEe0lAJO5zBYRHrGyvpo6GUAk8klRkj+KKXNdxJsR+RRjqh2JbdsUxvEEs7z0g1fw3R4J2h/XdElOe+Cff/HSKnmlYYctfr0aqyVDkJeJzT0mgT66emgCl3POmxCYcNmBYTyEcGORH6eBGMjhCwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753377612; c=relaxed/simple;
	bh=wSQImFBpLS69jJ4HU4sKHhUpPk0xeD90ui+5TYFQMPc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aQQeurROFxo+PWjYWwgVXh+s7R6XkknHxPHcwUnWpLbpsxVJi0sat23pIjhNFvIoEZ2U3+M0ByNxv3zDYq8Emw2mSA3X6SeThpVMCQw5OMSzvQXAd1QiAUlkaUbvoBbKE5ldPP7qAUOlUU8u/FqxBGRxWd4xKDbcnT45K2rGMMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DU8fH2HB; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-704c5464aecso11737326d6.0;
        Thu, 24 Jul 2025 10:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753377609; x=1753982409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V1jiyMjklgfhoAq++DmZ/54lpQnPivc+GcxoTyx1vys=;
        b=DU8fH2HBGls4gWvP7hAmNmwAmyYt2omYKnwgSLw1QWx2cXXirNtAt4VgfvCUPAj424
         I6asEtYS1XasyrMDUzOY9Iq3N8mnCAHHNgkYGu99pMyft5waFvp2zpZD2CtVCJuJGSsv
         9s5X5xz1sC+0vycuKVIAlWmtroD/2v9KvC/RqcAE9KLZQMGSVDUcHU7R9ItvTtVGQGaa
         3NvpTY8vIQ9CLhKjPqh+sI1en3XiE0ToUXn4fa2igHbZdeOOyclhWAki7Dd/Vak/wwgt
         waw7ZdVZGTh75uHPPmATAneI7HWPmjO8VB1tgUEzLJm4sZm/J+sBnInUvauDoyYW9YBX
         cc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753377609; x=1753982409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1jiyMjklgfhoAq++DmZ/54lpQnPivc+GcxoTyx1vys=;
        b=Wua4Ys5h99mr84UUDqYYv92QKZu0Es1ukrD9lt1gjcDVzDcmOWi6PI9MtpzguXqByF
         zURVVbc+4VTV+1fsm7bYHCxRWyqnmFo6Y0eJ/puN9Z/X7+a5uroyAeLT12oLLB3aifjo
         O9RYpW7h8TOBgrCo1G5awG7FEwfmAm4Eiyhm5AUe4MA1NFfq64zMjeVT37sqLCcB057U
         r4SorOFeivgZm7u4EEERHap+5PRONYhKD3p3SWzTmphtW8zoNZKuCzu3qB3XlbYEpRkb
         /rI1eqmc8r1WvYPahbAfZKC2J+UjqGAHsbdECpzjOKzwFpEpdLrByN5qlvS0nWdU6Wqa
         nLOg==
X-Forwarded-Encrypted: i=1; AJvYcCXaGynVtDJrwdWMiVVhtWtpf+Y+rtZ9drP1Yzd8jUyBFoyw2okWVAT+hpnUdJ6IdomiWCY6RHOMQrxln1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzJv3UIUDe6P8p5EZImX8grVwXCXtjWD3J8pSL5Sg/ejajwwbB
	8KRKMqGkUGEfW1XZoIx5XYHrIb1g4MIzO7nPwCGKSHkVujSgp8e89Ar9
X-Gm-Gg: ASbGncvZGJkok0cdzUymmlvA+1gHuNtMVpVrOpODT8RdZhSoKQLv/1aiT5qUEGtLBLW
	PESRPCu8LbFXf3Hczycp5zg2xEeoO1+2eZtFYcP02RrEU3cakGruraWhphsq06mPgM1rlBhZR7b
	uytHAjQys+o64Uo7AqqsaFK2182CYmaATNCFJFj9OMWWJHEd2ZKfIADZL8+zeQrHDecUqvBIddL
	DPv72tVobuehdVwGmY5IWo25LxdgFeYjdw8IKXeDQ/DuAA+Q9xP8kabfkClJHZpTnTP1dQTK5uK
	QNPTsv3nyWSQ7OZ89XrHS1BUa1c1d0uLgFXMZQqeUIIrEMqSkozlvxHHgSxmUqnfpIeJqa2IfJr
	Poej3H4VXQvhecmjTEur6c0fKIJTMI3/jRmFe1+H9OqGPhe0QDiem/TAiIfQ7yPi9AS5voiJMMX
	+sXqcKrHMUFjszyQyxXuXtSLs=
X-Google-Smtp-Source: AGHT+IGmdjBPiKCVhD0VgXdslFKkEiFX2j9qrPfUyQ3/mEJd65H3ue/PmeYIg6LHMKCeTIw+ZHu8+Q==
X-Received: by 2002:a05:6214:501d:b0:707:915:acdf with SMTP id 6a1803df08f44-7070915b2b4mr68960806d6.44.1753377609017;
        Thu, 24 Jul 2025 10:20:09 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7070fca2543sm16212006d6.58.2025.07.24.10.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 10:20:08 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id E4EE1F40066;
	Thu, 24 Jul 2025 13:20:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 24 Jul 2025 13:20:07 -0400
X-ME-Sender: <xms:R2uCaLT-Dx2UAg3qlZSeXoX40UIjR4-zb09TDxe1V1TFM67XccinAw>
    <xme:R2uCaInKW1Fk7Y3J8tvFmamNv1mi0WxdKqPTo4yTW5U79DnLTrQEsl35dpzrvj2F9
    _ElXWZYzZEZeNGPEg>
X-ME-Received: <xmr:R2uCaHR2v7tczcQXwuVrupE4LPD40eBGqya24GXxSNPn_7Sc4G840XZ98eE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekuddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfhvghn
    ghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvghrnh
    epgeegueekgefhvedukedtveejhefhkeffveeufeduiedvleetledtkeehjefgieevnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshho
    nhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngh
    eppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugi
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhes
    phhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtoheplhhoshhsihhnsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:R2uCaHusDFSJ5DNOgiTDyHKjJQ-QpTtD5Y7XfjtvYiWtvE8E9EK2_A>
    <xmx:R2uCaI5lagvpJJijfp7noM_0tvPTsZ1y14S_tI1eEAGt_ZBIQvyb4g>
    <xmx:R2uCaKhBVpfsE8Xavy5J8aWf6Gb-XhcI6LZzUT4EAwHcGKTpjp49qg>
    <xmx:R2uCaCm0KHxvpC0He34Hm9sI1oNbprtZi33wvdD2CPRvnpnCPGIpiw>
    <xmx:R2uCaBuWqC3RUEHoI_jXxVvbsGGXU5ZZlfAiE5AU-0WkAVJ3LCnmJ3Hz>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 13:20:07 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	I Hsin Cheng <richard120310@gmail.com>,
	Albin Babu Varghese <albinbabuvarghese20@gmail.com>,
	Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v2] rust: list: Add an example for `ListLinksSelfPtr` usage
Date: Thu, 24 Jul 2025 10:20:05 -0700
Message-Id: <20250724172005.11641-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It appears that the support for `ListLinksSelfPtr` is dead code at the
moment [1]. Altough some tests were added at [2] for impl `ListItem`
using `ListLinksSelfPtr` field, still we could use more examples
demonstrating and testing the usage of `ListLinksSelfPtr`. Hence add an
example similar to `ListLinks` usage.

The example is mostly based on Alice's usage in binder driver [3].

Link: https://lore.kernel.org/rust-for-linux/20250719183649.596051-1-ojeda@kernel.org/ [1]
Link: https://lore.kernel.org/rust-for-linux/20250709-list-no-offset-v4-5-a429e75840a9@gmail.com/ [2]
Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-4-08ba9197f637@google.com/ [3]
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
v1 -> v2:

* Rebased onto rust-next which has [2].
* Minor formatting fixes.
* v1: https://lore.kernel.org/rust-for-linux/20250719203646.84350-1-boqun.feng@gmail.com/

 rust/kernel/list.rs | 120 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index 44e5219cfcbc..7355bbac16a7 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -38,6 +38,8 @@
 ///
 /// # Examples
 ///
+/// Use [`ListLinks`] as the type of the intrusive field.
+///
 /// ```
 /// use kernel::list::*;
 ///
@@ -140,6 +142,124 @@
 /// }
 /// # Result::<(), Error>::Ok(())
 /// ```
+///
+/// Use [`ListLinksSelfPtr`] as the type of the intrusive field. This allows a list of trait object
+/// type.
+///
+/// ```
+/// use kernel::list::*;
+///
+/// trait Foo {
+///     fn foo(&self) -> (&'static str, i32);
+/// }
+///
+/// #[pin_data]
+/// struct DTWrap<T: ?Sized> {
+///     #[pin]
+///     links: ListLinksSelfPtr<DTWrap<dyn Foo>>,
+///     value: T,
+/// }
+///
+/// impl<T> DTWrap<T> {
+///     fn new(value: T) -> Result<ListArc<Self>> {
+///         ListArc::pin_init(try_pin_init!(Self {
+///             value,
+///             links <- ListLinksSelfPtr::new(),
+///         }), GFP_KERNEL)
+///     }
+/// }
+///
+/// impl_list_arc_safe! {
+///     impl{T: ?Sized} ListArcSafe<0> for DTWrap<T> { untracked; }
+/// }
+/// impl_list_item! {
+///     impl ListItem<0> for DTWrap<dyn Foo> { using ListLinksSelfPtr { self.links }; }
+/// }
+///
+/// // Create a new empty list.
+/// let mut list = List::<DTWrap<dyn Foo>>::new();
+/// {
+///     assert!(list.is_empty());
+/// }
+///
+/// struct A(i32);
+/// // `A` returns the inner value for `foo`.
+/// impl Foo for A { fn foo(&self) -> (&'static str, i32) { ("a", self.0) } }
+///
+/// struct B;
+/// // `B` always returns 42.
+/// impl Foo for B { fn foo(&self) -> (&'static str, i32) { ("b", 42) } }
+///
+/// // Insert 3 element using `push_back()`.
+/// list.push_back(DTWrap::new(A(15))?);
+/// list.push_back(DTWrap::new(A(32))?);
+/// list.push_back(DTWrap::new(B)?);
+///
+/// // Iterate over the list to verify the nodes were inserted correctly.
+/// // [A(15), A(32), B]
+/// {
+///     let mut iter = list.iter();
+///     assert_eq!(iter.next().ok_or(EINVAL)?.value.foo(), ("a", 15));
+///     assert_eq!(iter.next().ok_or(EINVAL)?.value.foo(), ("a", 32));
+///     assert_eq!(iter.next().ok_or(EINVAL)?.value.foo(), ("b", 42));
+///     assert!(iter.next().is_none());
+///
+///     // Verify the length of the list.
+///     assert_eq!(list.iter().count(), 3);
+/// }
+///
+/// // Pop the items from the list using `pop_back()` and verify the content.
+/// {
+///     assert_eq!(list.pop_back().ok_or(EINVAL)?.value.foo(), ("b", 42));
+///     assert_eq!(list.pop_back().ok_or(EINVAL)?.value.foo(), ("a", 32));
+///     assert_eq!(list.pop_back().ok_or(EINVAL)?.value.foo(), ("a", 15));
+/// }
+///
+/// // Insert 3 elements using `push_front()`.
+/// list.push_front(DTWrap::new(A(15))?);
+/// list.push_front(DTWrap::new(A(32))?);
+/// list.push_front(DTWrap::new(B)?);
+///
+/// // Iterate over the list to verify the nodes were inserted correctly.
+/// // [B, A(32), A(15)]
+/// {
+///     let mut iter = list.iter();
+///     assert_eq!(iter.next().ok_or(EINVAL)?.value.foo(), ("b", 42));
+///     assert_eq!(iter.next().ok_or(EINVAL)?.value.foo(), ("a", 32));
+///     assert_eq!(iter.next().ok_or(EINVAL)?.value.foo(), ("a", 15));
+///     assert!(iter.next().is_none());
+///
+///     // Verify the length of the list.
+///     assert_eq!(list.iter().count(), 3);
+/// }
+///
+/// // Pop the items from the list using `pop_front()` and verify the content.
+/// {
+///     assert_eq!(list.pop_back().ok_or(EINVAL)?.value.foo(), ("a", 15));
+///     assert_eq!(list.pop_back().ok_or(EINVAL)?.value.foo(), ("a", 32));
+/// }
+///
+/// // Push `list2` to `list` through `push_all_back()`.
+/// // list: [B]
+/// // list2: [B, A(25)]
+/// {
+///     let mut list2 = List::<DTWrap<dyn Foo>>::new();
+///     list2.push_back(DTWrap::new(B)?);
+///     list2.push_back(DTWrap::new(A(25))?);
+///
+///     list.push_all_back(&mut list2);
+///
+///     // list: [B, B, A(25)]
+///     // list2: []
+///     let mut iter = list.iter();
+///     assert_eq!(iter.next().ok_or(EINVAL)?.value.foo(), ("b", 42));
+///     assert_eq!(iter.next().ok_or(EINVAL)?.value.foo(), ("b", 42));
+///     assert_eq!(iter.next().ok_or(EINVAL)?.value.foo(), ("a", 25));
+///     assert!(iter.next().is_none());
+///     assert!(list2.is_empty());
+/// }
+/// # Result::<(), Error>::Ok(())
+/// ```
 pub struct List<T: ?Sized + ListItem<ID>, const ID: u64 = 0> {
     first: *mut ListLinksFields,
     _ty: PhantomData<ListArc<T, ID>>,
-- 
2.39.5 (Apple Git-154)


