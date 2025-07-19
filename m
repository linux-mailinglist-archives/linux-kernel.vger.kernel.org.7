Return-Path: <linux-kernel+bounces-737906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F14A4B0B1C1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 22:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71A9F189E9F2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 20:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B564B2264B7;
	Sat, 19 Jul 2025 20:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gL23AST7"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB2F1C861E;
	Sat, 19 Jul 2025 20:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752957413; cv=none; b=QKzTMpfXnDYheg0vlfjJc8IlsZCBEMYblrbHGlqSmcXAsQ76G4qO4BT2WV7gbq484YE3Y0tc/4P6qDlpY6PZYAD7NhlRnAkwguVPDQT81cQj4ZWIAzlwBKPuW0D2rdfw+1UBTIIs8DRaxjeGkTqWylJs6e3rpUQx1ZT2P9nEKS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752957413; c=relaxed/simple;
	bh=di+mcCvt0+UBtHhM8HRY9AByVNConNif7PwF2Wn94wc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HWvd1SXGp4ADag4bZXmOEgrnfu2nSbUrZT/EnKVpUldTiGbLLwHd2oW1PndONoED7UrzZUSRbiD7IY0tPy6yRcYQ506nSxjyu5dTtcax/Vdjqv2D262JTw2QPMAvbnQeaOW2FNOux2iviSNNCGQn53j6T0SxVz0MP+8tKkXdjIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gL23AST7; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e32c95778aso166046285a.3;
        Sat, 19 Jul 2025 13:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752957410; x=1753562210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/28dPvNYfbE+FFDSr4PtOx6mzozUV3wLj3+bPK0eQsM=;
        b=gL23AST7CbA5hEIhcZXxZ1Ve54aXFk7se2ROxOSVSeWPELjLcgsgYxB3VIntTgUybE
         4jbelWCHJu2pl6FfrrNLJwlf2NOqZZXeDOfmgY2KaVYTwZ7pkglabwkKXfQ7nkYMZUm6
         IAAyEodp31vU8AhM5UPTvQsY+3hy26Y8k72u0FUUnHlXkUImqFgD6B9GCETiXtJidOId
         kjykoPiu/5LLIlPztL8efYCVTB3l65t+yWVlq2swOEp3KiCpUcX15I7838GfIHzQ93NR
         t5VESHf6q4f3q/84Bifpfia2bhfH6linw58lUaAzNout7MNF8tFs071WI9IZmTZe7ywR
         Tyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752957410; x=1753562210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/28dPvNYfbE+FFDSr4PtOx6mzozUV3wLj3+bPK0eQsM=;
        b=ALsvQLlR3HCjWgIchBt/2JT7udvf2GeyQ4q2Gci81tnXPf73aMmT/cS+fGz4o7UbfT
         ClTh6TrFaQdR3TmWZ7cMoUVu53JBlRF/HYzlo0qZs26VL/q7pUqi/CcKwDmUaShM6AtZ
         gsvDaZJ9x8wRmz8JJJQLRtRKc9C7YyGcVkPYgqka+7rqitXZdAQYYjMU44N5CZfuW9Pu
         Z0PoXMZ7B2uquBkVFPVXHGbJQiMZj6FrHEJBJTRHonXqXCkc3uU0+g8Usmb9IH3FB3yI
         jRZOKzY/t/o3KFovFVesUZTOm1UDNVb2JxB9fNf/8a4WKAbvGnkSkEIz6uTY4YZyjpdZ
         2J0g==
X-Forwarded-Encrypted: i=1; AJvYcCWUmo+GSlxU66/52U13xYzkAeO1f67ENNrlDxyF1LNl3rsKBPtDBw3rTr6g9M8ZctbJdVYPxo/fa6inxoY=@vger.kernel.org, AJvYcCWxmfN52bxABSfXX4AiNuXzp2Td/ZFdfjjPVJvMVTNzw2v58HGISEhZuRceiw42LRuDH/PD85Jw2waBybu/wZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi3W50NEbthemzKg92je3xEUxGkw3u4UfSJltgNY5CUWqeobou
	NeHfcSFjzWDIRkdDiCvXh4UY5pqekgz0y7uZJDjLMEBO65wrgFBdvRbr
X-Gm-Gg: ASbGncsZTPTvLxslDaL2VLgMVdy97YJQ8MXjiJj/ZKVpxSWy6sE3OO6Ys6tLJvHKET9
	kEA1T2h1oAVSbsSpgX1coOer7x9ZiZ6et1CYGdyUGfwZopMcgoPAuwUAni8q4Gxc+gTPTmZQc18
	RJLefbDS9mjDAE+6va4KH537Sd8TXRmoorJazPl5opt4H7VrrwmW/7iLx3wF8EfjXd8gGMdHyYe
	nkWC5wgyhvygCfpYZ4IJFT0p1x/gwe8Q8nbE0QmAr1xSNHc5Vn82f5R7R/ojmLX68mHC5xYDthn
	QTwW3ZXK1R36DTPG4VekyRbuKqDZqMGApBXh5NcFESQAQp8oSlZ/CDa6Q7kSCypjnjUOww04FkA
	aIhC1L2qX7Ye7169qMtMvO0ewY8HWwqD0D0qD+RRjDknp8cPkvhstAXlIFNqTeaCB5m0z/InNhQ
	90a8E2eUlxLHUrcjDdbGZsP+o=
X-Google-Smtp-Source: AGHT+IGeKABTFHfN9W6A3yT2jAFSY2KexZG1xm5flv3gh7T0aNpDMjDu7i8oSpr1PQh701WQXLZoPw==
X-Received: by 2002:a05:6214:cc8:b0:702:d655:f4e9 with SMTP id 6a1803df08f44-704f6a19c56mr233430946d6.18.1752957409906;
        Sat, 19 Jul 2025 13:36:49 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051ba6b0e4sm21863886d6.68.2025.07.19.13.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 13:36:49 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id BAB4EF40066;
	Sat, 19 Jul 2025 16:36:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sat, 19 Jul 2025 16:36:48 -0400
X-ME-Sender: <xms:4AF8aKoCiqhLIc-d40SEhuiBP1zRqgP3VBYQQUEAh5R_nS9i6GqPlw>
    <xme:4AF8aHnjCjYScWhQcTKBgd_nLeH0F3zjrD9ZQF4O3Zb9fkJawt63Y2a3fKZw6-2xj
    cx7wK-GjMm2WJ4ugw>
X-ME-Received: <xmr:4AF8aLQDOKCfFGUPJ2ihvaKQ9JwVlvRJnuW04mTdJkuApcle6dOrEl71-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeijeefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepgffhffevhffhvdfgjefgkedvlefgkeegveeuheelhfeivdegffejgfetuefgheei
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    udehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    grrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhr
    ohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtoheplhhoshhsihhnsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepthhmgh
    hrohhsshesuhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:4AF8aNa7AG7q6qFr78s3XEt4AwRn3Ix4m1K6r8yEWh0R6KE38r5DdA>
    <xmx:4AF8aL8N7JIvbmsnBa63R9pCJ52SUIdCVjKNIvGdhW0T0vxTgm98Rg>
    <xmx:4AF8aPl-mgumOgmQubcbV4iG18QEuly0ldctV1HpS0NgXod1-7fJUg>
    <xmx:4AF8aIYlG24qGS3p4NyQgKBEw2Dxkji_HN1RXx2Mb41T5xw0t7aGFQ>
    <xmx:4AF8aPPlHiWshwO0mGLlC2JdpS47gf0t2ivHw6fChvEByGGisWzzuItV>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Jul 2025 16:36:48 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>,
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
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH] rust: list: Add an example for `ListLinksSelfPtr` usage
Date: Sat, 19 Jul 2025 13:36:46 -0700
Message-Id: <20250719203646.84350-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250719183649.596051-1-ojeda@kernel.org>
References: <20250719183649.596051-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It appears that the support for `ListLinksSelfPtr` is dead code at the
moment [1]. Hence add an example similar to `ListLinks` usage to help
catching bugs and demonstrating the usage.

The example is mostly based on Alice's usage in binder driver[2].

Link: https://lore.kernel.org/rust-for-linux/20250719183649.596051-1-ojeda@kernel.org/ [1]
Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-4-08ba9197f637@google.com/ [2]
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/list.rs | 125 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index 7ebb81b2a3d4..f66898738b31 100644
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
@@ -143,6 +145,129 @@
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
+/// trait Trait {
+///     fn foo(&self) -> (&'static str, i32);
+/// }
+///
+/// #[pin_data]
+/// struct DTWrap<T: ?Sized> {
+///     #[pin]
+///     links: ListLinksSelfPtr<DTWrap<dyn Trait>>,
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
+/// impl_has_list_links_self_ptr! {
+///     impl HasSelfPtr<DTWrap<dyn Trait>> for DTWrap<dyn Trait> { self.links }
+/// }
+/// impl_list_arc_safe! {
+///     impl{T: ?Sized} ListArcSafe<0> for DTWrap<T> { untracked; }
+/// }
+/// impl_list_item! {
+///     impl ListItem<0> for DTWrap<dyn Trait> { using ListLinksSelfPtr; }
+/// }
+///
+/// // Create a new empty list.
+/// let mut list = List::<DTWrap<dyn Trait>>::new();
+/// {
+///     assert!(list.is_empty());
+/// }
+///
+/// struct A(i32);
+///
+/// // `A` returns the inner value for `foo`.
+/// impl Trait for A { fn foo(&self) -> (&'static str, i32) { ("a", self.0) } }
+///
+/// struct B;
+/// // `B` always returns 42.
+/// impl Trait for B { fn foo(&self) -> (&'static str, i32) { ("b", 42) } }
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
+///     let mut list2 = List::<DTWrap<dyn Trait>>::new();
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
+///
 pub struct List<T: ?Sized + ListItem<ID>, const ID: u64 = 0> {
     first: *mut ListLinksFields,
     _ty: PhantomData<ListArc<T, ID>>,
-- 
2.39.5 (Apple Git-154)


