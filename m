Return-Path: <linux-kernel+bounces-804518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEABB478A7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 03:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A64C204A5C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 01:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E321A0B0E;
	Sun,  7 Sep 2025 01:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNfE7ZGW"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AFB19CC28;
	Sun,  7 Sep 2025 01:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757210229; cv=none; b=IP1TNBocPxSzKKkozKJYjjIfjmLStjRyMYdLMecjPShxj7yEUEJSHFlgDKB96CgkZsrFrufDhqwtAMRp4Wr7s9YbUzqwtIcsRHqgTrDSBhQMiWatTSXyx8zXCZrTFfsjenUBxjsyBv9s54V3K3rNO5C+uEymb5QuhPC2bggWqMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757210229; c=relaxed/simple;
	bh=HIANAWEJTSk4h6jVR+naSmXE055aF+gsPiBbfQucI+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFNEOMpQJGW4zEhHTQUVvce6NUmW4gWzG38sJ6sWH1KrgAudOYBQFY9GRTcQ5e+t6QlK1CkdHD9wIaTxVKknLQ9l9TzhXMZdZcmfXfxB58nj1lPzBkbfqqpzOSvTCt/dOaJTjqGHlY1at+QsnoMIj0D1sI3h1K0fEg9do2p4vck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNfE7ZGW; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-81076e81a23so322438585a.3;
        Sat, 06 Sep 2025 18:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757210227; x=1757815027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Ubqm0cemNSwa00R4M8gX2Nj2LvSr0FhtjEjZFitZIs=;
        b=aNfE7ZGWsaaksQ7bUqg0YDez2CfbNcqTCLqk92iUgub95tew6vqqMOwJA59iufrmf+
         skl34d0H8bW7Qnfs1tgwqu5u8aBWYjFV0J7IMS4+5IRBQb4usT3LIlKyS3bjU1gbSD7o
         kDVRvRBMXJpkPXJDLa+k4lcWssd2hjtYHLj0zOoWhGcfRtcOW3nx9Z77nljrJPczHqAH
         Qoax6PU9VUI2cWaDT9eLNQ1r0oCNwB0s5WQGhIMPbZyG4GWYzX5qZeurqeL7O3VHoTWw
         29XKIEssKj6a4BeW0kVwHcjW14ZebayzrLJh9ldFfTm2MQeZWrxk35wuvKjl7DGEZe+Y
         rrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757210227; x=1757815027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Ubqm0cemNSwa00R4M8gX2Nj2LvSr0FhtjEjZFitZIs=;
        b=Uvh7/i2RTtfwarDtOwCABl5+tsMwBGf3MQa2irXkVmOLEYAfdgiJN9Bhp0yl/4DigZ
         UK7icG80wvi/+bAIuTUyLQ3zpP4WqZ36r1ORm7tkYTY/mC4BT+z5EM47DgecymYq7f1y
         AndfV+dXEVQRpFHWos6i02ymGV1KZDbK4XYNguJvP3dsjcATIegF9gF/ho3F6EFR3bf4
         /lytw+45Cdeg0QnCpwZGF9Zr4cIpzKR99RSKdiEdtZX0g1YZfBLXi7t8T27/zGBMu+eg
         NBX++6sitnm+s3SY5y8elfYzTJ+6iJJokA3Tae68Ac2D5/dsOWiKQYwuzBBeCX2dZhHd
         eMCw==
X-Forwarded-Encrypted: i=1; AJvYcCUC6qwcnHUdy4K2C4e3uRTO+0CpIvPzmfYt/TttBu7cZU/zl8Dra6bJRPohXyH2nhLQNfR9ogRtrWH0wO4=@vger.kernel.org, AJvYcCUsAZJcxeuIAXH8rpwEQLCIl+KyloG8cZBw02zCZoX63TWjKPYoaHE9n2zLN48yRCZ/UZMo+1zp6euZ7PV0jNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsuDegqTq2BoJuBB3wLETa4J7Jz9j7j8crXHvlOY2xmlQzdCHv
	nrHdv0iWpHzk7OyYXIqMkxcNkiuuyMxCuxcwlThHuAa0Y1+AXXJM5xBf
X-Gm-Gg: ASbGncu0b+VOuBnjot9AKEfhaxSybH25vzy03C9CfyRY2A9oHhJ5qrWYMNmvnEtih7p
	EGZ7dgCDuwrAiN17W+Gu15n8u0Gcys+MtnW+Sf6/lMBGpfz2Jl5ExvnKmyaaGNS6e3npBnRu36w
	FVZb/0O1tjmUaMoFhbJAZQkQzUKeKOXOOqYX9YMfNw4E4H9Qppbr+RV2kPZoJlI+TmSXKHi9OmG
	owVzLPlRhNAkpYQQFRNwzVldeveF/bqfEedVIMD1Ol5VQCZmwhpXI5wbeBI8gkT2nuG0gq7EG4D
	hCv8jSGVBM+bNZrxoo83jJQHOvAV4OLp3k62fQu2yYaktonmoD0O2fEskyh7ogm81hZ8DsZHss5
	jZp4iXhy6gTMQNCIh78R1wWDhogT6Kt4zB+x3CJEkd0O/mxQhqcdcB20BLTjb5vXhh9Ce6eXZa4
	IGWw5mZ85VjHwLg8tLUQrMwj5psuWqTY6dfQ==
X-Google-Smtp-Source: AGHT+IGkfbUjiAfmJrUYTAsNW2Fmn0Z++NsMhASSx2EZdGTuDDapBTiJXZp60cXzhq31btTZ8hzpeQ==
X-Received: by 2002:a05:620a:ab04:b0:813:de67:afff with SMTP id af79cd13be357-813de67b39cmr299305885a.46.1757210227039;
        Sat, 06 Sep 2025 18:57:07 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f501690sm74875171cf.0.2025.09.06.18.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 18:57:06 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id C37BFF40066;
	Sat,  6 Sep 2025 21:57:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sat, 06 Sep 2025 21:57:05 -0400
X-ME-Sender: <xms:cea8aIYZGHRMMNs45SFezA-MHEEdzl0w2HuPTDiumWNZuVdcZpxlIg>
    <xme:cea8aE7empNwKt4XCUc8KRQCm1W3DA4It6dXh2NJHypj6LGfUkkghYK0rbpwzQHL7
    EbyCwrwds1ojZ79MA>
X-ME-Received: <xmr:cea8aAmUOLOwNEmteWVgAOuHf_YecFEz0JJ4h3vI72vyxlgd1fdvNouGOIcyQicytzc1AUWV2l__BnULVesEsQFK7I0kR1OM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeefkecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:cea8aKHQInfR5brGYOxvHvhvz7HQTKd4uiwuLaKNdhP2-2RB0oV1Uw>
    <xmx:cea8aEEW2JBYpTbiLXHk4cgima6ctKY5xWsX1OufED3OmUPqtR9PwA>
    <xmx:cea8aC3_ivyfYOiTyrNg339F7JgTnt7yGzeriR1RwgnWw8P2j83VEw>
    <xmx:cea8aGerBw4c9XVnZvkYYMQPrWi_CDDhH2qEvVcDYkzF3Tza1yXzJg>
    <xmx:cea8aEJE7c0LReqOgI_FU6EeMC6cVdkwjIcMQWZfdgxLb3PLcqrW66FE>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Sep 2025 21:57:05 -0400 (EDT)
Date: Sat, 6 Sep 2025 18:57:04 -0700
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
Message-ID: <aLzmcK2UM53I2Tbn@tardis-2.local>
References: <20250905140047.3325945-1-lossin@kernel.org>
 <DCL1DPN708H0.3JTL93J2GD2DR@kernel.org>
 <aLshd0_C-1rh3FAg@tardis-2.local>
 <DCLNSNWA7AT7.19OWOXUMJ5ZRJ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCLNSNWA7AT7.19OWOXUMJ5ZRJ@kernel.org>

On Sat, Sep 06, 2025 at 12:52:22PM +0200, Danilo Krummrich wrote:
> On Fri Sep 5, 2025 at 7:44 PM CEST, Boqun Feng wrote:
> > On Fri, Sep 05, 2025 at 07:18:25PM +0200, Benno Lossin wrote:
> > [...]
> >> index 606946ff4d7f..1ac0b06fa3b3 100644
> >> --- a/samples/rust/rust_driver_pci.rs
> >> +++ b/samples/rust/rust_driver_pci.rs
> >> @@ -78,8 +78,8 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> Result<Pin<KBox<Self>
> >>  
> >>          let drvdata = KBox::pin_init(
> >>              try_pin_init!(Self {
> >> -                pdev: pdev.into(),
> >>                  bar <- pdev.iomap_region_sized::<{ Regs::END }>(0, c_str!("rust_driver_pci")),
> >> +                pdev: pdev.into(),
> >
> > Ok, this example is good enough for me to express the concern here: the
> > variable shadowing behavior seems not straightforward (maybe because in
> > normal Rust initalization expression, no binding is created for
> > previous variables, neither do we have a `let` here).
> >
> > Would the future inplace initialization have the similar behavior? I
> > asked because a natural resolution is adding a special syntax like:
> >
> >     let a = ..;
> >
> >     try_pin_init!(Self {
> >         b: a,
> > 	let a = a.into(); // create the new binding here.
> > 	c: a, // <- use the previous initalized `a`.
> >     }
> 
> Can you please clarify the example? I'm a bit confused that this is not a field
> of Self, so currently this can just be written as:
> 

Oh, I could have been more clear: `a` is a field of `Self`, and the
`let` part initalizes it.

> 	try_pin_init!(Self {
> 	   b: a,
> 	   c: a.into,
> 	})
> 
> Of course assuming that a is Clone, as the code above does as well.
> 
> So, if we are concerned by the variable shadowing, which I'm less concerned
> about, maybe we can do this:

I'm not that concerned to block this, but it does look to me like we are
inventing a new way (and even a different syntax because normal Rust
initialization doesn't create new bindings) to create binding, so I
think I should bring it up.

> 
> 	// The "original" `a` and `b`.
> 	let a: A = ...;
> 	let b: B = ...;
> 
> 	try_pin_init!(Self {
> 	   a,                   // Initialize the field only.
> 	   let b <- b,          // Initialize the field and create a `&B` named `b`.
> 	   c: a.into(),         // That's the "original" `a`.
> 	   d <- D::new(b),      // Not the original `b`, but the pin-init one.
> 	})

This looks good to me as well. But I'm curious what the syntax would be
like in the in-place placement language feature in the future.

Regards,
Boqun

