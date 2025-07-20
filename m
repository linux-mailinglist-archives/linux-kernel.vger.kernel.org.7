Return-Path: <linux-kernel+bounces-738008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A91B0B315
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 03:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38FD917FEA4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 01:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AD751022;
	Sun, 20 Jul 2025 01:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hioqQX6j"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDBC1DDD1;
	Sun, 20 Jul 2025 01:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752974769; cv=none; b=JQ+b55+nPHXPSBfsv8GErq3nQuRyjdqrWNOMdRX56lfJw/yfQKRQu0knkJSha7gwWQrm7sR7gOXWptXxyUgHbPADMX2ldsm2TYsn1tgNn7/wzpIQE+DoVhZcIX9vpso4i7WOUH00+D45U77J7s+rw9uY+mTERa8VKwqRsl26xPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752974769; c=relaxed/simple;
	bh=M5v8j/MbUJSw56NDaZKEqyXgTiM8XeO6qX4gT3RlSPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kr4cSwionyxmPBOrkcEXyMCi/iWJj0ukZNQrewSR6wro9WsLuPoWE8I9IDigOMIk3RWfh1PeeVoZAC37xNqulT0G93Tm+qRN3bZxGbULhTqFI8FbKVaibqG8ovsDqjXHYm/0sJ/pdTRcGF2G1K76/KaekiFIxWx/wJV5DP16LoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hioqQX6j; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4aaaf1a63c1so24124951cf.3;
        Sat, 19 Jul 2025 18:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752974767; x=1753579567; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H4YkocWtLM+MV9VqVW9r5H/qPxJMGyUCFlNySJ25hYk=;
        b=hioqQX6jhz8yTho/iOzR2HrCiQFehHfMM8nOGWV4FvFsdiabbUEnFoHavG9GE/yflG
         mVvMNITfsl4ZZ2BaG4ikX2IvIS8zUEEnAI06eyduBqbP5FeoJrOk/QQs0Lvw+HJDu+qI
         ReKqvapARTnSjJAO+7Gx+QERVS+96aXhChIB24LH1CrKzlm6g6oLK0wxDQVsqczeI5IT
         zzuuvOKWKUwcWvN7KsIHQO6n7N4g8itBkmiqIrYJ6p/RRW4s+oJu1Qn2AW8ru6tQQWnE
         4e48aQyREh2292ieXIlIrINbcxpsizw9H4ervCZPka8/NfiEBCtRF+kUTfct5100Kdot
         CZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752974767; x=1753579567;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H4YkocWtLM+MV9VqVW9r5H/qPxJMGyUCFlNySJ25hYk=;
        b=S19FAIzoLWC6L4XGx7jrnZgZ9sEDAqFyb+Ycy1/3GJKT5LQeHNNaqUFmCdFnYnl3V3
         mpjM47mrgAP4PaL9yZm7DAj3ewb8F4EwrKTfSMkfgOeyFF66jLeDy7ro0/YWZhW/71uP
         qAP8FKJ67ITpSIQkj49RFK/XxFS7w/ClBWWCFnL/WJZkbXsqcQPIV3spLa21RyxlDg/T
         /r4kEv5QMqsf+eF4QECs+Y0er4/R/Fb2+fE3V5e6XD/WcRzPI3nVrgYckMUHNQkMpuV/
         BGS6L++QajHV4R9TKDpOkbvq5YY+RnRxIh1NuFloDdgM1+Wga9f70zjIufjFsTIb75Rl
         5z9A==
X-Forwarded-Encrypted: i=1; AJvYcCVdWjMIdjaUGAr92cBVyFKXw0SFAbrn69rb9TkiO+jEW0KNWXNrxJzdwaj4Mgd8b6lPp7nrZZVNoZM/U8vHny0=@vger.kernel.org, AJvYcCVg2XgvmP99iLMllLQB9CtdQrOuISUprl06uWNh7c0c5+i8u8qvN2r4wAgQCStT0hEdvbRT00SEthaPGY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoHHQPqJz7ulOKx/w6Zqyh974IKLfzmwH3PsJvNWxQnLeclR2M
	jGnGPABWR5pOqlMkGcFyk71LQiK74iV02qukOusl+455ATDF8g/mjP+2
X-Gm-Gg: ASbGncu/JdJvqE7C8x4CH7KmL1+lAHCAX33Y+mMvX0KKnub9hU+BOmvKfLUMp3z51Go
	idB1evKThyKFksGbjqDsID1ZucUQOlshQQ/GKlnZH3FXwB6TpvBKGUGOyPeADQLEas6qDUd8/CN
	/bANA3a4UeVvARgSIl7MuPGN9ehCdTTDTqpH1Bk/52q7gJ1fVBH8I0k/VribLk8/9bcPsTpHuFe
	e3wJuO9XnFIjhf4elKlLlOOOAFz/AvBcWzhgin76176+KVeYYTzwtBBRij6qxkKGWfTTZtzMCb7
	4WAo/3ERSK1szTVBxNiXu8CqTdeK7RG/A1HXvGxskwcfwba962O0jtsXTgd8gcJPzUkb9F1eznC
	VZqUzpm2HLLzH1xy6wdzf/81B3EfDwcjzUS1Sir6U9f3G27IrlFmA1UE+27F1SQ3x0prwUAW6sE
	1w7QZgyWkdIAhSe5RaInFaJTg=
X-Google-Smtp-Source: AGHT+IEWeJHBnozEVYV+zCWV/y44rQfzmFwYBgyuanGFP4F26GarMSuN2OTUeRI3QpjoEguzfIT7cw==
X-Received: by 2002:a05:622a:13d2:b0:4a7:2f49:37d6 with SMTP id d75a77b69052e-4ab93c509a8mr229433761cf.5.1752974766930;
        Sat, 19 Jul 2025 18:26:06 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b2643dsm24368211cf.53.2025.07.19.18.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 18:26:06 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id DB245F40068;
	Sat, 19 Jul 2025 21:26:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sat, 19 Jul 2025 21:26:05 -0400
X-ME-Sender: <xms:rUV8aGtL_yI2duiIFRu3swL3rqMPKft3UOSRuXO2aayCLbl8RjcFbQ>
    <xme:rUV8aGJExnP5Ar97sZVwfXJcLcY9JBuHOCK_N-OTGYyWJ4QEgTFMDTY4KPuEFeCFI
    425fWlDRa6Wk0xFAA>
X-ME-Received: <xmr:rUV8aKfztCBxfwfIgCebLBldkKVVwJRG6DXdFBe8PYNeX5a_K_MJ8Cu_pQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeijeeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeejhfeikeekffejgeegueevffdtgeefudetleegjeelvdffteeihfelfeehvdeg
    keenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthho
    pedujedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhighhuvghlrdhojhgvug
    grrdhsrghnughonhhishesghhmrghilhdrtghomhdprhgtphhtthhopehtrghmihhruges
    ghhmrghilhdrtghomhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesph
    hrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtoheplhhoshhsihhnsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:rUV8aIVq3amHiwemn9ps7odTlSGCPiMOM_Bj247joP-p5M7gHC5f_Q>
    <xmx:rUV8aIiX2hJYNu82rcdkrXJWUm5J5g-C4b7AiGkO-dRUFUsSyHTe1Q>
    <xmx:rUV8aChReM-azl9rVPaXidEE8faUNNo2-_Pz8MvwohobH8ROzcDR7w>
    <xmx:rUV8aNtWqhJYl4Z0xulD53gOaqci6Z0yOJBrULjOBJt1op-Qt8FNYQ>
    <xmx:rUV8aAtwMwVwsXGfVnYHvV_e48zci7d-d9FdTnZF9s-nfgLlGcBbng-K>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Jul 2025 21:26:05 -0400 (EDT)
Date: Sat, 19 Jul 2025 18:26:04 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Tamir Duberstein <tamird@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	I Hsin Cheng <richard120310@gmail.com>,
	Albin Babu Varghese <albinbabuvarghese20@gmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH] rust: list: Add an example for `ListLinksSelfPtr` usage
Message-ID: <aHxFrK39YKEpKV9x@Mac.home>
References: <20250719183649.596051-1-ojeda@kernel.org>
 <20250719203646.84350-1-boqun.feng@gmail.com>
 <CANiq72niUM8YAiVWooxAPCy3c3Yqt6_1fjW2HN7TVLnmL_GQMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72niUM8YAiVWooxAPCy3c3Yqt6_1fjW2HN7TVLnmL_GQMQ@mail.gmail.com>

On Sat, Jul 19, 2025 at 10:54:45PM +0200, Miguel Ojeda wrote:
> On Sat, Jul 19, 2025 at 10:36 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > It appears that the support for `ListLinksSelfPtr` is dead code at the
> > moment [1]. Hence add an example similar to `ListLinks` usage to help
> > catching bugs and demonstrating the usage.
> >
> > The example is mostly based on Alice's usage in binder driver[2].
> >
> > Link: https://lore.kernel.org/rust-for-linux/20250719183649.596051-1-ojeda@kernel.org/ [1]
> > Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-4-08ba9197f637@google.com/ [2]
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> 
> I sent that one because I am applying Tamir's series, which triggered
> the error -- maybe you can put it on top of those?
> 

Sure. I overlooked Tamir's series.

> If you do, please note that you need a couple changes -- I will push
> them to `rust-next` so that you have them.
> 

Will do, thank you. ;-)

Regards,
Boqun

>     https://lore.kernel.org/rust-for-linux/20250709-list-no-offset-v4-5-a429e75840a9@gmail.com/
> 
> Thanks!
> 
> Cheers,
> Miguel

