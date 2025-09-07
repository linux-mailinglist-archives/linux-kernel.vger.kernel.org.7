Return-Path: <linux-kernel+bounces-804520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 373E8B478AC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 04:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44E5204FFF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 02:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557F91A0711;
	Sun,  7 Sep 2025 02:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGaXLGt9"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96984A06;
	Sun,  7 Sep 2025 02:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757210830; cv=none; b=Z3IlkfNTDawxdXfRcz9gBe7CbPxkcKqVIeKAKTGYSQ0PEcughljvlH8SvcHEzO/4iiD+TF1Q0Xu4Br4i6kE0ayknWijzIn+pIDdJnYQE6U6Sy41EB3qL1gDNIMyPrXZCQINKt51BaEvqfLmtTVrbBNOos3RX0xA6zRcnJv77Kfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757210830; c=relaxed/simple;
	bh=vhq8J8Y4+wyQO+CzSHWxBAyo1hjM8A1UGtdN2a22WwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0YUpyiYxT6U7aRqvaRWqHfeAlppUMVE1ggOPunKzQ42WA2aYsQjiAcusfBIBVxdlWzOokcQtQB8k3v2N4nHdZnAD7aRPKVWAMXOdKduGnpHQkWhZNyGUTQBu+ClrqOa7fBYJ8vcnBtpWgRQjl8/yPF00lcAziUCr7bs0qAQP04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGaXLGt9; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b5f3e06ba9so17701381cf.1;
        Sat, 06 Sep 2025 19:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757210828; x=1757815628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKXxRUe+VTLZFVmD6gmOdiUjiKWatOp1vffYRLT+kh0=;
        b=ZGaXLGt9gx1+ATnu1yXoBpG3aHIv+5ev7u/6FfocltUISZeke/AsDt0+JdGhKM2KHM
         v4OtEKatQ3H1utBI+kvEho+NMl8mJl4q8hn5jBuTsv9q1HJBneZrbr5sE7FWG6qMTOXL
         o3mMD8jP78/lVd86PjN1xpAr2XWAbxf1tV/tzvMAxJak1vrqYsWFnSpT/8z4CwZ+HIcv
         cD5lDOew3cTAR8VMssIOLLlcS3jL76Sb+fEng60Y9Locqz+1ib1Bi2W+fmfkfzWcYESr
         Be+7mHYofnhyMLIgRw704wX4goM7NPYiiMQmJRFOSYCwl09OnBu5bRDxrY4IPyRZFbrR
         ktuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757210828; x=1757815628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKXxRUe+VTLZFVmD6gmOdiUjiKWatOp1vffYRLT+kh0=;
        b=CN6RO/3oUZ7nGkNXq7Kxg3FEuybneZABzhUuNBgdteb6qr44BlNZH346AiiRhUx9p1
         jfrprq8stwXjQ3bYBflsS3dlb3WLEp3iwQwWVNdXsLEUqU8yzYn0qpQvtX18qJupf/TM
         8IhT0Z8K2C78T3PjWsGs5FM7PqhfIkakThk4h4MplYAqKN1/8mZ7S/fML4TlK3X13e2Y
         vlCeL9XMlbFQvKgLqKAWuELve+raklJXR7AJBk37hd+3KIz7Hnufsew16ABt+XGaFGYZ
         aHeQ9b3P3Va3NCqu4gzachcMvzkfjMGpfkWDmEthTQbqt074a03XV5daNFZ5KVJjOVju
         ZKCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLtk0PabZ/La6BHDafbiXEmFY7kCRRMOux2FIBiDY3fliBTG7BnaQGY1+Wb5t4ZsnjgLhZWOA3CiNOWnmhZ/A=@vger.kernel.org, AJvYcCXwZdBvBMPNKrBEhMT6PFBNi3RdFoLGAa03P7q1jpQGC80UayVYd3sbWYJY/v0ROL6fHCf9qjtkB7GGieM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd0fIlFHbW/2CThmQsUCRjX/58vwOScSTwjMqsk0kbt9Z7tRcv
	xtvwWqDpFeXGhcV1Q4+VlhVoKH/Sesh50chLBidfWRyQm9XaTo8LRV04
X-Gm-Gg: ASbGncsoPhHTQZUNPXt9zwKHtA6G6DXnldqHhdTJgy8zYNkci4Mn4aRy1yY3vJ3Cedd
	AVjTMVTnsT7J0ZLHGI3DMgTiQJeUtv1HeSOyOkSp0Wy2Oucm6FZF/vPX3tLU4nvVSkl2bhqy8c0
	TnX8oHKrZGYN6359lKEwp4sOPVFj/f/78h8PgOlYlu5Dd8oSeVXRIvGKGTRYbkc31mFYaEQ3mmW
	RJZ5qQWANmAiJWVnuF3vp3nNU31rI2Wg73i3jTucrLRSLWRyYtrB11ZTVTtKFnE3bDzGPqZj/qZ
	gJaAsjtRwd5w4q+Icm+F+sFPmTYL5PN5PP4KMknYp6yz8Em6z4GddhNSwtWIEgIoyAW31bHjQSA
	hgomVwyF3Tn3bfVtdX7cl0htDbgDVfgNZes90y73i41FBPll9NUu39NpYfgZ8dET3az2K/UU4Fb
	BE7OSw/3Btz8dTFbqbb/7Ow2c=
X-Google-Smtp-Source: AGHT+IEXm+i7sQ19CUyLFVoHqPFPZXCWcv9xAqF8wecK0OvK5Etv9gbz5gI9Yau8vkY6vp68GKAN+Q==
X-Received: by 2002:ac8:5f51:0:b0:4b3:7ec:d22d with SMTP id d75a77b69052e-4b5e7dd9325mr94067391cf.20.1757210827654;
        Sat, 06 Sep 2025 19:07:07 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80aab3b671dsm765203685a.46.2025.09.06.19.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 19:07:07 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id C1C11F40066;
	Sat,  6 Sep 2025 22:07:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sat, 06 Sep 2025 22:07:06 -0400
X-ME-Sender: <xms:yui8aLBTf14Bt8fxaOIX8tEgceifRaJihha9SiS-dFLTocnAPpKVIA>
    <xme:yui8aDBeiCppIeuZWNdGcm9hVQbygexqxnoImKH0Q5RGVJk9L2Wt9b_fzKK0WGxie
    iI8nYfopAEBSxBGHw>
X-ME-Received: <xmr:yui8aEMTlTdrYZp0KeUlTE81B3Stok6F47L4maS5qktTfR4KQdJfxBwbHkZWV5sOnZE4jEKuFYuQNcqEbarQ9LjRxjRU1sUO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedukedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhsshhinheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhope
    hgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehp
    rhhothhonhhmrghilhdrtghomhdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhm
    pdhrtghpthhtohepthhmghhrohhsshesuhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:yui8aFMYS4LkWXLZYqy87b0b9hm1UESWS3bXiGG1xkEkMJwsj1yPzQ>
    <xmx:yui8aAuJgPViNpj1mpHxoy4uiiWKfGpUv38Pu-5up21IxruiYc2pUw>
    <xmx:yui8aC9bnS3IRbapH-x3fPeBCpSmoID46HBYn5Gc-pYA1Chu76WkDg>
    <xmx:yui8aEGkWv-xh1xMaPjP9_93WjFG2UIiuJnDHINaiaqmcCJnHLGyVQ>
    <xmx:yui8aBQVzY7ksgavO976FBLICFsNTJxUHYulyCAyyWltsTerh6tBNjWu>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Sep 2025 22:07:06 -0400 (EDT)
Date: Sat, 6 Sep 2025 19:07:05 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Fiona Behrens <me@kloenk.dev>, Alban Kurti <kurti@invicto.ai>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?iso-8859-1?Q?Wilczy=B4nski?= <kwilczynski@kernel.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: pin-init: add references to previously initialized
 fields
Message-ID: <aLzoyWpOr6eg-3yB@tardis-2.local>
References: <20250905140047.3325945-1-lossin@kernel.org>
 <DCL1DPN708H0.3JTL93J2GD2DR@kernel.org>
 <aLshd0_C-1rh3FAg@tardis-2.local>
 <DCLNSNWA7AT7.19OWOXUMJ5ZRJ@kernel.org>
 <aLzmcK2UM53I2Tbn@tardis-2.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLzmcK2UM53I2Tbn@tardis-2.local>

On Sat, Sep 06, 2025 at 06:57:04PM -0700, Boqun Feng wrote:
> On Sat, Sep 06, 2025 at 12:52:22PM +0200, Danilo Krummrich wrote:
> > On Fri Sep 5, 2025 at 7:44 PM CEST, Boqun Feng wrote:
> > > On Fri, Sep 05, 2025 at 07:18:25PM +0200, Benno Lossin wrote:
> > > [...]
> > >> index 606946ff4d7f..1ac0b06fa3b3 100644
> > >> --- a/samples/rust/rust_driver_pci.rs
> > >> +++ b/samples/rust/rust_driver_pci.rs
> > >> @@ -78,8 +78,8 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> Result<Pin<KBox<Self>
> > >>  
> > >>          let drvdata = KBox::pin_init(
> > >>              try_pin_init!(Self {
> > >> -                pdev: pdev.into(),
> > >>                  bar <- pdev.iomap_region_sized::<{ Regs::END }>(0, c_str!("rust_driver_pci")),
> > >> +                pdev: pdev.into(),
> > >
> > > Ok, this example is good enough for me to express the concern here: the
> > > variable shadowing behavior seems not straightforward (maybe because in
> > > normal Rust initalization expression, no binding is created for
> > > previous variables, neither do we have a `let` here).
> > >
> > > Would the future inplace initialization have the similar behavior? I
> > > asked because a natural resolution is adding a special syntax like:
> > >
> > >     let a = ..;
> > >
> > >     try_pin_init!(Self {
> > >         b: a,
> > > 	let a = a.into(); // create the new binding here.
> > > 	c: a, // <- use the previous initalized `a`.
> > >     }
> > 
> > Can you please clarify the example? I'm a bit confused that this is not a field
> > of Self, so currently this can just be written as:
> > 
> 
> Oh, I could have been more clear: `a` is a field of `Self`, and the
> `let` part initalizes it.
> 
> > 	try_pin_init!(Self {
> > 	   b: a,
> > 	   c: a.into,
> > 	})
> > 
> > Of course assuming that a is Clone, as the code above does as well.
> > 
> > So, if we are concerned by the variable shadowing, which I'm less concerned
> > about, maybe we can do this:
> 
> I'm not that concerned to block this, but it does look to me like we are
> inventing a new way (and even a different syntax because normal Rust
> initialization doesn't create new bindings) to create binding, so I
> think I should bring it up.
> 
> > 
> > 	// The "original" `a` and `b`.
> > 	let a: A = ...;
> > 	let b: B = ...;
> > 
> > 	try_pin_init!(Self {
> > 	   a,                   // Initialize the field only.
> > 	   let b <- b,          // Initialize the field and create a `&B` named `b`.
> > 	   c: a.into(),         // That's the "original" `a`.
> > 	   d <- D::new(b),      // Not the original `b`, but the pin-init one.
> > 	})

Another idea is using `&this`:

 	try_pin_init!(&this in Self {
 	   a,                   // Initialize the field only.
 	   b <- b,              // Initialize the field only.
 	   c: a.into(),         // That's the "original" `a`.
 	   d <- D::new(this->b),      // Not the original `b`, but the pin-init one.
 	})

, like a special field projection during initialization.

Regards,
Boqun

> 
> This looks good to me as well. But I'm curious what the syntax would be
> like in the in-place placement language feature in the future.
> 
> Regards,
> Boqun

