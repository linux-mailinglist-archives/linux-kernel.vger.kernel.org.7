Return-Path: <linux-kernel+bounces-811289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0367BB52707
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABEBF5672C4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4654A231830;
	Thu, 11 Sep 2025 03:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrkPbhKK"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE882329F21;
	Thu, 11 Sep 2025 03:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757561500; cv=none; b=fYagKwVrgYY6u2dIEeythIq624mRZYF834EBvMTbuXMfHKa5gsH3oYIabeGfeG3IYKfqPLgrBKjtm1BqZIEwpV0teq5CJqXgv3iO8JY3NbqCwFoAZq5FQBWEMOu1RjfX08XE7EcJMmPicNFKRv1HtRyRI7ovO4mwm31CUtfr8Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757561500; c=relaxed/simple;
	bh=8rb2eHgz+sisqDC2HjdtfVMWa883OZctZ6qacBEEcu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FeOH886HwDXfp92Sa/V6wZTLtWnW6SEEGtz3eZA/NEIDXll6vxe5e/zZaGakA7sgnMKkwt5efgOytrAQ2eX34oncQCCPKMxggTjyyLgFRImuTSh4KHzXii/yUYWxQpBMO0POPfQ+A4zyu2z9p3AHFNkRKN31NOvIDqDVx4FkdEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FrkPbhKK; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-817f3d08465so22797285a.2;
        Wed, 10 Sep 2025 20:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757561498; x=1758166298; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1syGiOChJSsvX5X8w25jQPHC2Ezw8kmnSNlrI7kOygU=;
        b=FrkPbhKKA+MCebshsDzcR0LfL7um1TCnra2iYXDwM2U1dIP6RdX4LILHGfJbjagUYC
         PEBwdUXpMRlGHfC53wOmQPImcbxroKS1jzBFOnn7wWDwZE7RONI3sIeqgifZR59NpcZZ
         GYbu/hh4NiCTU/6yQ9gaCm1HCmWOG+BfUqLEK+NDK338GiRvuoq6j4GbNgV0YTD3jApz
         Ul7KzjgeEexap1ka3WShzTqbsOG8N1YKtoCxfJeWZp49JU1enph6AtBAP3mr2/Cjpmgv
         +4RVJ5cdrizOPvQdYak7b+5SZ26/+yyUGdMPmm+dSRcMuDvMsdNvk3r1mn+5GIq4QLRK
         Quuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757561498; x=1758166298;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1syGiOChJSsvX5X8w25jQPHC2Ezw8kmnSNlrI7kOygU=;
        b=fw6qJjDah0LDiWd8r7tL6CbV16aaKrpBuDP1RsJlMhpLf779aJVLlUBm6TlLz4fHG+
         ujIQgZrc36vnRSSYd3y7OAyScnlRAhB1MOjt+NSyusmjawN8UrT5Di4VlF1UAhzFbTkF
         KrycZaRYRq+YPc9vBJToF828uWdUzONH3/88+nsXL8rwvtjYUroxnAPB3raWzeRDBDJx
         ZuN07dLKcpRfaiwyhDGfupDgY+63BcAQEktgoFGHjPpOLmyYe90ZLYqDgw+MRqAfowfL
         KrOidg+TlRLdTyJpOPD1vwNyFOfHqAmhQuTkjbwvvLYTetefMgV4e6AowWzCukDMsYNM
         0HcQ==
X-Forwarded-Encrypted: i=1; AJvYcCV++2rbHg29AfEpKp0qPDibmEvlE4CF6Ysu+lb5qgYFGlkhF/ITnIDk1kLsBRBpHbZoU3ASzGRWgn2oRRub6LI=@vger.kernel.org, AJvYcCWfqhkZ+JH5r0bvsFQT+7TYOKyY/gBOkQRbCSU+5GMT+EG2nOkTPC+WY3T6uAWNPY5P451MW8q6M8Ah7tE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvRKzpEHNKPwcFCM8Rn3hSYexcPpgeLFNQ5/pId59bFiwg68k8
	d16IH3M9ASOTg4Gaw6aAhgMXY6XbT1y7m58o2pUANxtFNiQlS7EnbbeV
X-Gm-Gg: ASbGncuklbTo9d9xftnPfxVm1/NcLN10w5xgbOvNwjHds4pQtv60Bzp8kjH0ZkoWRBA
	rRK0ToKLfkzav3RUg2tnrkDTX+J8bGIVI7pppZfRTRI/GSFJXXr93mE0VrROYtPdgATt2xofb+x
	Z3q4+P9kxfr6yNRv9vvjJi7r40mBYIy1qrTOgJlVZh/q6vc6mnHbS2X34o5ThkX4v5pDf3rGXcf
	3y7znBFYnpJkbMJ5Qx342OhYDJnNA4TEUFlo/i04Zchw9Ro5tlsLqANRY36iAqD7EdinQNb1V5y
	dgOqgpXcJeT191F1kGZeXk5+yVyGpQ6KdoWkv1RxIt9qdwBKgTXL1xFGqCUYdn36+mlb+C0A8Ua
	DdsyYhkyCtkZ1FDis0ZZ7UCYicP/4jmgA5bF6TCpnxEvGVqsm2MCswy184B9LdKRBD1cHTAp9Xr
	YMDXZOUwkwDq28IENraE96EA+iX+8wsBodWw==
X-Google-Smtp-Source: AGHT+IGrDLo5bWSqO5mkCkjgJQTWPL25KQoZekxLgU5oTKRa8fIInxRcyYRazkbM5fjz4IYYVySZ6Q==
X-Received: by 2002:a05:620a:4690:b0:811:2b34:cf45 with SMTP id af79cd13be357-813c568d2ecmr1670054585a.79.1757561497551;
        Wed, 10 Sep 2025 20:31:37 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639daa5edsm3292951cf.32.2025.09.10.20.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 20:31:37 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8595EF40066;
	Wed, 10 Sep 2025 23:31:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 10 Sep 2025 23:31:36 -0400
X-ME-Sender: <xms:mELCaH5m2zpva2BKwefEl8XBdCj6UdPsVMUs-_LrhbA-jcTsgZCHDQ>
    <xme:mELCaIEVp71Kh_LlH4M1_h3g2VKvgMzONI7ax-__5xqmyJ0o7vVWeYRCkcC-B7_9U
    bcBg4KXP5BrcPiYxA>
X-ME-Received: <xmr:mELCaCSMmsqNZ2Bn6ERN-_Bix6CCZKQsbtclueSnu06f4bsfPiRDf6-x9jbSzfQzNQpZkXSIguM62YqFdGrmLOlu1DArZHL4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvhedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeevgffhueevkedutefgveduuedujeefledthffgheegkeekiefgudekhffggeel
    feenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehlohhsshhinheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlihgtvg
    hrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhn
    fegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopegrrdhhihhnuggsoh
    hrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhmghhrohhsshesuhhmihgthhdr
    vgguuhdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mELCaCcJk2WofuBWEHIS3FvFzKNJznnFCE3Z1icCdUCTQtSiwXEy5g>
    <xmx:mELCaIi5SUn9zCNfz52qHA3WOwX8HW9afQ3_EF_WHfJsK9usr5CUMw>
    <xmx:mELCaFLRaSQ7i6VLID4CE6vrpM1W4ye0YqEykeeNYxGnOgeNu415hQ>
    <xmx:mELCaNGK-u8fRFXp2LOaxqUi14FbeNvIghfc1ltJvPq0JVHkrtrMkw>
    <xmx:mELCaD198j_BuVKJHpozr3AyrTuTlse77cXiT_-Pgcwz_9vjBxScG6oN>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 23:31:35 -0400 (EDT)
Date: Wed, 10 Sep 2025 20:31:34 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <lossin@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Tejun Heo <tj@kernel.org>,
	Tamir Duberstein <tamird@gmail.com>,
	Dirk Behme <dirk.behme@gmail.com>, Alban Kurti <kurti@invicto.ai>,
	Fiona Behrens <me@kloenk.dev>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: pin-init: add pin projections to `#[pin_data]`
Message-ID: <aMJClvnT6O5WrcCD@tardis.local>
References: <20250905171209.944599-1-lossin@kernel.org>
 <20250905171209.944599-2-lossin@kernel.org>
 <CAH5fLgjD+S0nBvDMuTfMYd6-o-3f=xGztk+jZQRhm1_vmNiHAw@mail.gmail.com>
 <DCP1ZX3ASX86.2LS8OQBF4DPL9@kernel.org>
 <CAH5fLghfeWZ1FYdgQKQ7aBftHEGgXPYZ9WTWueTSZxxtaaRB1A@mail.gmail.com>
 <DCP44KG3HEKL.35ANJWT161W6M@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DCP44KG3HEKL.35ANJWT161W6M@kernel.org>

On Wed, Sep 10, 2025 at 02:18:12PM +0200, Benno Lossin wrote:
> On Wed Sep 10, 2025 at 12:54 PM CEST, Alice Ryhl wrote:
> > On Wed, Sep 10, 2025 at 12:38 PM Benno Lossin <lossin@kernel.org> wrote:
> >>
> >> On Wed Sep 10, 2025 at 12:23 PM CEST, Alice Ryhl wrote:
> >> > On Fri, Sep 5, 2025 at 7:12 PM Benno Lossin <lossin@kernel.org> wrote:
> >> >> +    (make_pin_projections:
> >> >> +        @vis($vis:vis),
> >> >> +        @name($name:ident),
> >> >> +        @impl_generics($($impl_generics:tt)*),
> >> >> +        @ty_generics($($ty_generics:tt)*),
> >> >> +        @decl_generics($($decl_generics:tt)*),
> >> >> +        @where($($whr:tt)*),
> >> >> +        @pinned($($(#[$($p_attr:tt)*])* $pvis:vis $p_field:ident : $p_type:ty),* $(,)?),
> >> >> +        @not_pinned($($(#[$($attr:tt)*])* $fvis:vis $field:ident : $type:ty),* $(,)?),
> >> >> +    ) => {
> >> >> +        $crate::macros::paste! {
> >> >> +            #[doc(hidden)]
> >> >> +            $vis struct [< $name Projection >] <'__pin, $($decl_generics)*> {
> >> >
> >> > I'm not sure we want $vis here. That's the visibility of the original
> >> > struct, but I don't think we want it to be pub just because the struct
> >> > is.
> >>
> >> Why shouldn't it be pub if the original is pub? I don't really
> >> understand the concern, since the fields themselves will still have the
> >> correct visibility. Additionally, there is the `___pin_phantom_data`
> >> field that's always private, so you cannot construct this outside of the
> >> module.
> >
> > I mean, for instance, it's going to mean that every single struct that
> > wraps Opaque in a private field will get a useless pub function called
> > project that will appear in html docs.
> 
> It's `#[doc(hidden)]` :)
> 
> > Pin-project limits the visibility to pub(crate) when the struct is pub.
> 
> I think I would have to look inside the `vis` to recreate that behavior,
> so I'd rather do it as a future patch. Thoughts?
> 

This reminds me: I think should make these functions `#[inline]` for
now? (Until we make a decision about whether it's pub(crate) or $vis)

Otherwise compiler will generate functions in kernel binaries for some
of them. E.g.

nm .kunit/vmlinux.o  | rustfilt | grep project
00000000002449cc T <kernel::sync::LockClassKey>::project
000000000023ef40 T <kernel::sync::completion::Completion>::project
000000000023ef40 T <kernel::sync::poll::PollCondVar>::project
0000000000244994 T <kernel::sync::condvar::CondVar>::project
0000000000260a68 T <doctests_kernel_generated::rust_doctest_kernel_init_rs_3::main::_doctest_main____rust_kernel_init_rs_69_0::RawFoo>::project
0000000000008b70 d __UNIQUE_ID___addressable__RNvMs0_NtCshc5sK6KjdJJ_6kernel4syncNtB5_12LockClassKey7project2007
0000000000008c98 d __UNIQUE_ID___addressable__RNvMs1_NtNtCshc5sK6KjdJJ_6kernel4sync10completionNtB5_10Completion7project2044
0000000000008ca0 d __UNIQUE_ID___addressable__RNvMs1_NtNtCshc5sK6KjdJJ_6kernel4sync4pollNtB5_11PollCondVar7project2045
0000000000008b60 d __UNIQUE_ID___addressable__RNvMs1_NtNtCshc5sK6KjdJJ_6kernel4sync7condvarNtB5_7CondVar7project2005
0000000000010d28 r __export_symbol_<kernel::sync::LockClassKey>::project
0000000000010f78 r __export_symbol_<kernel::sync::completion::Completion>::project
0000000000010f88 r __export_symbol_<kernel::sync::poll::PollCondVar>::project
0000000000010d08 r __export_symbol_<kernel::sync::condvar::CondVar>::project

Otherwise the patch looks good to me. Feel free to add:

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
> Cheers,
> Benno

