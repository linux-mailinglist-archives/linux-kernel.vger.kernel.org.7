Return-Path: <linux-kernel+bounces-765135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 477DDB22BF6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93399163BB9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BFC2F5494;
	Tue, 12 Aug 2025 15:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKhUzREU"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEE31A256E;
	Tue, 12 Aug 2025 15:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013616; cv=none; b=hfw3NeIgKUtx7I0E1mCUeOxwYz4xXTpV9+o+nWAfdlPzO4xa8GjGEVnTsZOj07uqlGsL5xYqQScgCw3i6Qj0Arw8xBdUXfLup2HaadeoyapPR6+D1M/0D2s/4oEAC4BDuBlreuHqrv/MQj+M0kwN8EeMC3T38m0AS81j8cMbh70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013616; c=relaxed/simple;
	bh=6MG83oOsLuiPLNPayodlWNeXmfAkGq2HtuPevp8rFes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pC1VqdiTGD+U066RMiFRN7xw92SWXC+hHJPBlo49fMdygWER5ybhQ5Wy36dd3/gfuMuIVdUQ6dYpgGsJ7GpthaxlbyatnWKCzH2VaLMpbVf+M2+a5dIA9q08D06hO0Di0ADCGtoFNc/fSDWUYNmIdfjWSWzZ+2kQuTTOcCDsnPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKhUzREU; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e1d89fcc31so555562085a.1;
        Tue, 12 Aug 2025 08:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755013613; x=1755618413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEdF8TyAjnfv0Re8VMprlNQjx5ZxBaILt7aUCj4Prxs=;
        b=kKhUzREU/j79Y1uCVNt7UzK4bR74pG5kvswKa5r5HpP/jglUAejUmoJYNgxKLrKguT
         dmsXlVPJ28THnXgJng47NwPgOhsmw0eaCkiqjf6hZVn5n8yW1sacTWxtaHvs0t9B1D3E
         EdvzDWPXHKGEsSRSERznDMwUNR8ZzTwukIzkopC4BJsg2EXJkZRhQLreL81fNYeYoT1h
         3zZ4JnEHiXSzQnySvot2szdQc+pt5lNap9JUPickraWrub6WyeaMw3CkCgQGAJcLqgor
         etgHZ487mhi7+/cKxZkjwRPWRVw0vr4kLVTNiZFlwe975z8Ybr3XU8gvZkGK2meidlU0
         IfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755013613; x=1755618413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dEdF8TyAjnfv0Re8VMprlNQjx5ZxBaILt7aUCj4Prxs=;
        b=AjW+kmaXssaBlikxbQ4+V5m2l3exPT0ZeyHuRvXJosAnk4YPC5YWWjk+oNxX3nv69C
         Dq2Wq0q5Zh5c2Nvkdjt2LSHzRuuSspZI9U1fP6JZPTfzu3usXcYcREbasCs31r/EcNwE
         1Yes1XLpjEvH05WP5kZKgTiSh/iJUIg1WQIRk/C2WIx2qpQHzEHEe3gE72R4gVky0YsV
         1VdqDrTnXq3WbCuBqrCIGMWrG147Uwahq9drNUOCMpUKQUt4r3SL5KOTepQBLOvv5B7X
         TGx0sxv48NhNgpfkd+REqx+qOUiWWFQHC3B9IYTkZCPnpMNveH6bgRNxMOZiw/yZS3oh
         zedQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ9D7aOtR4A2SoWVo6MrHv+8T3/m1aBNxPK5mYDfwdw04h+WwXRKwQmgUsaRmlWpfq223azmzaGUlSWf7lEPE=@vger.kernel.org, AJvYcCVEWeb/EMKFtWr3c4ny/zRFS5W2pWOaoj5YoRYvVslU4uM0z5YpzOHZedcf0HKAcntWaDEH10nW1piIILA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7doXz1lEK1QZp6UbrKwnZgcYV2rjY8pDM7SPVJdlr+wJdiSWo
	N1jNnAy0VC0lD3AddonisoouAcN1r2jJZsEb9Z0viA45uWJ8+/1CJKgn
X-Gm-Gg: ASbGncuH1itrovS6D5l3d+RTmLv4hLsJ0j0Pwkxrak9Y6APNFoX/6+a2nypS/QoqjGf
	qdCbSLZ937A6+Lcrst1AR9cA2TnmJBgW6HYeSatiJq5O6jrKnj6x6pyaDbuLkTvhgiN5tWGVDmb
	tzoyYYySh08PO8DN//dYuxMgyod8h0UWFwwaG3XfVshSCze0tBbobpBZceB47ZYWlgQCGINpDrK
	hbmWbMPtykBR2Xuzt8rA9X6hal/oaS6bqjV37NyzLRp0Ue+Vh5B0G/RThCgf1mgs8h0m6oThDGt
	LloOJ/D5B8JLBgcMufQlEY1cy6lP/uk8hPDqj3qzHgUKQWSFBwkCyKjclAhJ5IjOGDi0JAQ6/aq
	yXF3q5eZneVKHWnQZw2ehB94vfiEMOFnaIRtxAhiPi4wJCYkCbnC03lj6l5LHFe4jioq4o0JKU0
	kiCditZAiI1pWJ/FGjHF4gpME=
X-Google-Smtp-Source: AGHT+IEOY3qgl37Oa+jXAYPHP4v2DVmsZz2e63W/5K4Eg4bgD7vnHai7mrSrxbytd3rDtZqjooTlAQ==
X-Received: by 2002:a05:620a:10b9:b0:7e6:604f:f747 with SMTP id af79cd13be357-7e86460ea53mr18316085a.63.1755013613028;
        Tue, 12 Aug 2025 08:46:53 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e84b5c141esm435361485a.8.2025.08.12.08.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 08:46:52 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id EB1C0F40066;
	Tue, 12 Aug 2025 11:46:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 12 Aug 2025 11:46:51 -0400
X-ME-Sender: <xms:62GbaBZmOFP0wTsJJN8s31dUSVSojd8SLfKaiG0ft_RfPuZGv_JZqA>
    <xme:62GbaN7RjZHxBNU57QkwCGlcR_QGNzl5_G5_uzofoibiciZ3KdmRSH6Jge9jUw4zj
    krRse1PYha2A9H5og>
X-ME-Received: <xmr:62GbaDChloudh-HyUwAtey18Epj-yaIeiSjY9Cq31NliG9D036UqAmLaDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeehjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteehuddujedvkedtkeefgedvvdeh
    tdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthho
    peduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhoshhsihhnsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrghrhi
    esghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothho
    nhhmrghilhdrtghomhdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepthhmghhrohhsshesuhhmihgthhdrvgguuhdprhgtphhtthho
    pegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdgrlhhmvg
    hiuggrsegtohhllhgrsghorhgrrdgtohhm
X-ME-Proxy: <xmx:62GbaD_PzMXLCVTBk5QZOxWKckyeQ0BajFWFLaOZNqpNph_T3w3kLg>
    <xmx:62GbaGFW5Twt3RNFLDuyeyKoT793aAEItPMvA8pDWmBsendilmOKfA>
    <xmx:62GbaNQOnTUsWWETa9eShint0GTUB4NefJPfmP5kCRnMIBP6GxXzMQ>
    <xmx:62GbaNRnD9j3bkBAdFGrCR8NH65i-OIvQPgoCs4OfXWsGFB8a2x-8w>
    <xmx:62GbaA24Mf4GDG-GpF3AjhE7KEYwlJpDSjfA1RJiqB6s4o6sgTOfXiIi>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 11:46:51 -0400 (EDT)
Date: Tue, 12 Aug 2025 08:46:50 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <lossin@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rust: sync: clean up LockClassKey and its docs
Message-ID: <aJth6nUF0zqzNhHr@Mac.home>
References: <20250728-lock-class-key-cleanup-v2-0-ad02b80c69e1@google.com>
 <20250728-lock-class-key-cleanup-v2-2-ad02b80c69e1@google.com>
 <DC0ALLZU4B8V.31REA4LHMQ6JL@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DC0ALLZU4B8V.31REA4LHMQ6JL@kernel.org>

On Tue, Aug 12, 2025 at 10:05:55AM +0200, Benno Lossin wrote:
> On Mon Jul 28, 2025 at 11:42 AM CEST, Alice Ryhl wrote:
> > Several aspects of the code and documentation for this type is
> > incomplete. Also several things are hidden from the docs. Thus, clean it
> > up and make it easier to read the rendered html docs.
> >
> > Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> 
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> 

Thanks! I'm going to apply your tag for v3 [1], and queue for v6.18.

[1]: https://lore.kernel.org/rust-for-linux/20250811-lock-class-key-cleanup-v3-2-b12967ee1ca2@google.com/

Regards,
Boqun

> ---
> Cheers,
> Benno
> 
> > ---
> >  rust/kernel/sync.rs | 55 ++++++++++++++++++++++++++++++++++++++---------------
> >  1 file changed, 40 insertions(+), 15 deletions(-)

