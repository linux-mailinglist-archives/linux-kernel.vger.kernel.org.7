Return-Path: <linux-kernel+bounces-808631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 360D4B50299
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66CA97B3ED1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE444352FDC;
	Tue,  9 Sep 2025 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/17yPCq"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE118274FFD;
	Tue,  9 Sep 2025 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435271; cv=none; b=UzLqF+qhHUAEeQWaLOnJqApm3bPN11Jm9XxB7Ll8PNMzK+sPJ2oSuYq/IiPN2iX56Gi1VzAef/Cj31pv66rlgmG7vPRNowzL9M4la4TFZRWnrBNID6IvhqiuEtZoqwtghycBrUbjACYudmxWZwwjs5dp54U7FQGtH6vG9kPVpQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435271; c=relaxed/simple;
	bh=248TwnhhUf+iHubt1gnzN9cycUkiuHz1/vj2OnTms0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvC0KzG+X2mDgVzjfY/l5vxUaPloV43b7duZs2VzHJkwRoAaIgzI5PA/3ihO/xaGpSGWzwlqRfP1lhuOl3rXm6ygV4tddpzZeTkKJuFNrYMameLu+MIcX9tCKFclStQPiScUOMmOXXtQy+fVY9sHDSh9/ouTF8Ea/eQGiun+ysw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/17yPCq; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-729c10746edso45409446d6.3;
        Tue, 09 Sep 2025 09:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757435268; x=1758040068; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJUeDG6go/WRpKnPHNbMiCFc+vw5StR6WimqMT2TrBs=;
        b=a/17yPCqS+YqLnY3URrJmjJAmxs2mwPrwCWiLwWzivTesvM1PZAJ7UFHG8aLgp7kod
         717jKjIM5tbuJmsAQrYtoE1eMoJ4D86S6qIkCQuNR9mD8yjNif0szHwDw/JBK+M6/uqn
         yeM4b6lWliO75oDsIOA1rxjvgWHBd0M4eqdGbqwXksvIBwrEdGNGdmykWLPU29S08Kjv
         fXWb/s6zCT33inzp1cdmBsGceG0zmpaIjdtMlV+X3OuVyyE5EaquXnShor3AzOy8usUs
         kwF15f219CHco/5HVS2CchBuSy1YO44xUMSNMuVhAc/h6cuSMaNUbusF3UKm5+RVq7MT
         ljDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757435268; x=1758040068;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZJUeDG6go/WRpKnPHNbMiCFc+vw5StR6WimqMT2TrBs=;
        b=RM1ya7Bf8/G0cyg6TPklPkS5x9g7IiuAzHjdt1VQ/xJGAz2Cbfep3bf7oRMUz/c0jJ
         W0AtMKouhvQqVE9Z+MPQRBg22jWm3kXzTAGIgelKxra/39IqvLfOzZKOxWGvfZ+w73jG
         kAR8i3ayAXWqwF8gLNQnkiJarauWlUXSPM2KDp4zyW5xGo0ifo4LHhJWTOoDH3v9yK3z
         HjPELywiRi+TDAgw/MfrIpBf8j28GGj/u2F5P23quz7NPaznLCbIZEclKOlLsW2BCtan
         0/UPt+Oq6a4g0S3zXI20lkJHmEEz/H6odwJ0oe9pYEic9iV2f1qa3MYIQZDj6xtPqond
         lyAw==
X-Forwarded-Encrypted: i=1; AJvYcCVuzUqu5jNfdpcWcOFA2WWAQMir7hkJ2pgKc/+ZszyOz9PExhLSnT5I18aOmYuhj9DFE7iY8jTIM3g8bidCAtg=@vger.kernel.org, AJvYcCXhTh7ZxvOcivV2ZJf7cCM41uxS01z2bJldq+/jsFDGjyKYeHlsFOxlUw0RqRss/OiOLRLq3PgdA7vu3KE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvM0AA1HZzr/I9TufKpHNfNWi6k1VZ7O1vw3bSU8IRS81aKUfO
	8OAPLjOWVTmFQaVTvtdVfRpbN1xzhql6m0LYIWldlPzmlqCVpB7ZzdvK
X-Gm-Gg: ASbGncs9RdFQvp6gQBYrhDCMwgDAoT4+y+OrgQU3BiWWR0nYdxC2ZoF7COZJC8PBQf3
	UZ9gpFcaJFrFCFxp7um+QFJz7Yboj9PlZskFrXimyrkC7KfpdPatzNy74fgjI9+g52pWyKSZtxU
	n1RRhBg31NvdlhHDdF6miw5C/l+15Lz+3PvnQLryvB8F1VRBJ1KPmUF9ziI//b6gijqkfSRgC8W
	mrRSgi3m8Q+o8lkycIJ54i1xMFR3mPuZCzdgVh2BB3rtEiAYE+q49EoHw2q+HnDrmWRbYj5UYF4
	tX1nEnIldbeztEDFDXAMxBZcsLV8CMu2X1t70BoxqPbr3NOIMlQ9DOVjVX243KI5CbsDWP1OBKb
	A9K9JfL126de0yta5KCx7cpa1zKVIvwjDBEzfkIkyLwJSrhY01VsbTiVMdsKKm2r+UbxQ1WLlKo
	awm4OMSHrsMK2g0hbEGYtucm4IbahfNo2pXw==
X-Google-Smtp-Source: AGHT+IHxKskNmgkAEM5AkTUg89YNKBAkBVaqKQjq0CNPs8Hr+bKHNVkf4mw3xKpGYTwLrRG7/wEzVQ==
X-Received: by 2002:a05:6214:1c43:b0:730:a986:49b0 with SMTP id 6a1803df08f44-739371a735amr123515576d6.31.1757435268339;
        Tue, 09 Sep 2025 09:27:48 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-72856902136sm111536116d6.58.2025.09.09.09.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 09:27:48 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 81FFBF40069;
	Tue,  9 Sep 2025 12:27:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 09 Sep 2025 12:27:47 -0400
X-ME-Sender: <xms:g1XAaLywop0erLDnHotUpn_buyQVeOGg2UgeIGrBUgj8X6J0T8ydrg>
    <xme:g1XAaLIyCVlURiAtdZ_bC-yEBVtdl83C89Jtd-YK_RfQ9WO9DiHFPKs65p6xk76-O
    fdrmEZNyJx1yz1ZYQ>
X-ME-Received: <xmr:g1XAaEvhQfi0fY40WhgtJOq9NGG2umuZBjkr34esnWrtc57P3-XqmZlCUoLvKdppt9utjcMFfEbpsJYdNZKKRlP23d1tOXbq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeevgffhueevkedutefgveduuedujeefledthffgheegkeekiefgudekhffggeel
    feenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehmihhguhgvlhdrohhjvggurgdrshgrnhguohhnihhssehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepuggrnhhivghlrdgrlhhmvghiuggrsegtohhllhgrsghorhgrrdgt
    ohhmpdhrtghpthhtoheplhhgihhrugifohhougesghhmrghilhdrtghomhdprhgtphhtth
    hopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohep
    sghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtoheplhhosh
    hsihhnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:g1XAaNTW67Mji4QsYYx85fn08lm1b1zrFNdU9qGwF2Zv5hYNOG-WnA>
    <xmx:g1XAaFQuY0HgwDmLkTptVG4zv1TH4cri6ii9YwobF8rDBYkzJTNi6Q>
    <xmx:g1XAaJpNRvahUNeII1cN1y0vrzwu2QQz4p6NC4_1Jy4ff1ANrrJwsw>
    <xmx:g1XAaFCyBe1A8sYRrVqPwF7f8ehcFu6td3uCpeU3Q1kAGgg28_6ijg>
    <xmx:g1XAaOsJYJtLDI1CsQ8dI8lbCZIZ_xQo6ELJwvPkjxEmgzzG5lf-Wy4y>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 12:27:47 -0400 (EDT)
Date: Tue, 9 Sep 2025 09:27:46 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rust: regulator: add devm_enable and
 devm_enable_optional
Message-ID: <aMBVgrVqX2w31GhV@tardis-2.local>
References: <20250908-regulator-remove-dynamic-v2-0-e575ae2cde6a@collabora.com>
 <20250908-regulator-remove-dynamic-v2-2-e575ae2cde6a@collabora.com>
 <aL_PwXck1HsLp5wH@tardis-2.local>
 <AA8FC1A7-EE88-44FA-A0A9-A3EA5529B10D@collabora.com>
 <aMBJ805QjQcPdRol@tardis-2.local>
 <CANiq72m18qUTjqjKKYgPfeEUh=vN+Jzz=ACFDcgA-JDLL_N5SA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72m18qUTjqjKKYgPfeEUh=vN+Jzz=ACFDcgA-JDLL_N5SA@mail.gmail.com>

On Tue, Sep 09, 2025 at 05:58:34PM +0200, Miguel Ojeda wrote:
> On Tue, Sep 9, 2025 at 5:38 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > Well, then the question is why we want to compiler regulator.rs if
> > CONFIG_REGULATOR=n? Shouldn't we do:
> >
> > #[cfg(CONFIG_REGULATOR)]
> > pub mod regulator
> >
> > in rust/kernel/lib.rs?
> 
> It depends on what the C API does -- if the C API is supposed to
> "always work" (even if it is no-op or if it returns errors) even when
> disabled (so that callers are easier), then we likely need to
> replicate that on our side.
> 

While I don't disagree with the rule in general, but I do want to say
the cost is the binary size (at least without inlining helpers), so I
think we are allowed to apply this rule case by case, i.e. even if a C
API is supposed to "always work" but Rust can avoid exposing the API at
some configurations.

I of course don't have a strong opinion on what the regulator subsystem
should do ;-)

Regards,
Boqun

> We had a similar discussion for DebugFS.
> 
> Cheers,
> Miguel

