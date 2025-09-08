Return-Path: <linux-kernel+bounces-804971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D57AB4827F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 04:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 395823B0257
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 02:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF42B1DFE12;
	Mon,  8 Sep 2025 02:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBSM70Ax"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C8BE56A;
	Mon,  8 Sep 2025 02:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757297315; cv=none; b=TKfBhoBJ1r+Wf4slphl+yhT6+aX+c1tN9yzJ6c2yy0Ga1iIGmL2YsPDFIZ4YFi2cQWfIjjupnP0LZgHDjiRGNGycn41x4o9TK31Wse4g4dZM87yIJ1M9K98b6VENLWvf0epqaHVtLDJrMNfb1NNHs1reZ8CHc0sOQ8TTUiNDtZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757297315; c=relaxed/simple;
	bh=+6vge6D5Rmxr8sGWIAM2plq0WDBQ7eYtTTfWmyKyGMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eD4hu0D1RZqMFMS9fJWQN3FVL8CkLY5CGbbTC2krSabr8T/tVmLHWf4mHRYcxQZEJYv+NY1lLuJ7SPpS7hXsfKu61fMLXRCQsg4oZqAwYBtkb3ZYpb2NauHT3wjh8qUO6lG8A9A5ZbdISn56GYQkNhWLmzO68VcDEabjAP7YZ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBSM70Ax; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-70ddadde2e9so30994576d6.0;
        Sun, 07 Sep 2025 19:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757297312; x=1757902112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5wvK9N0FAN5WWE/5m873xnm5UeYdKcL81Y7rv8hpKI=;
        b=ZBSM70AxDJaChSAH9d6rTkGXMM2j7CLBT+WDeH1qnyC2FMZohUy04AjYhXFsvCZ0A1
         UjkTNN/doE4j7mz8S3IK8EyNquijZ29/rh4g239Hrzu7ZBh7JJpevzgGoNllA8Dy/pPC
         nj7sx4bRYmTjBaTv72p+Lh/JGBp7veWISEA8MN1iOW3eA3xzixuiBZhuNAlsyfJfbbZ0
         tT83+yynBzkOaP7u+UU4MI2jhlgNWdkIfgRdgy2N5purjCISxtu8o6SSK2rjoUWhj8hk
         WkucKYeIFLztFARVOtqE1HXCXaY6mX2C7JWFAhsn7Amm5LrK/73FJtoFzdIGA6lPlCxs
         WifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757297312; x=1757902112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5wvK9N0FAN5WWE/5m873xnm5UeYdKcL81Y7rv8hpKI=;
        b=HS8qchaM0cw9OQ4f4/9Mtt1ozadhG6tYZzFT+hmcB9+LzJPE1SMxKT9VexYY7oZFmA
         yoL0iWddLhWVPRl9QZx38WObxxVQ+q3+aVh+vQy0s+4Mxun90CkisnYNvyJD+ZNeh7f3
         nzBHQuCfsZDu5KTxdvSIURPLLsf66b7F1pgzV5GMDHFbVvGF5zQUupRFEiqyF2yh8WT1
         6mGgqHQkgop4CuX844ZL29WvUXwsj/2quephv/hRg/DtmiogydplNbeXdj4M4MzEa9TK
         GO1I7lKEvlr3B0/x/ylwh6foyq951FWSu0qy7XISKaTXAvnWZGVdbOuuFvdRr7rVqge5
         bgQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxqUvqOZHeOFPpzwnSrUo3aRGMwxlkdS2EhxvVdkG7MKuJJhqGGu8rBhKJHklqoS/oFwyQKoJGX44wOHJfsgU=@vger.kernel.org, AJvYcCX+zFh/XWWlOvXM9et8rVrFePdYEI3dgQbiCCgSPvH6TKno9lX5cA70BA4CV6+tWzndlFGWInzalzGyd44=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjjvmojnxU2FzlE11gmqBfM+dmEM76Xbi6ZFr0om1cQsiNb43Z
	recGQHgSKe8lWDFhT8DVmJEuVhp0P1jpmrBfMS7IFl1vTB8e6PB0HmeC
X-Gm-Gg: ASbGncuI7mknPMp7qhYG2F9JUIvsTXFtjOM+6OE0SQv+8jfqj4UD67dH8eDc7uX0Hg1
	Y054U59EZfVJZIlIAlK/8VzGO/4LXeCawsUMac1xllyCZX+8H5zyQfGhqNGS+vmgvtg96KUxaE4
	v9ftN1xaoqGMEDeAMSpDvWnOhfS0IYMMzbYfyY6r5iKy/6LCQDE/yWWMcSY2oaSXGWgqAe0l8Yi
	hOvObp+QfLwFILQgEsqCq3ReUnkxmn1K7MxBjhGOXlomrKfIxaXRf8Kgp5kuo3BvRZ6O/5oFM1U
	P2w7m/uL8rQR8zaakZtVdS8OBwp2AlGDM6o+MI0zLc0gfVxaAXX3wA9FPZATTj2ugVA0GKLinGx
	dVbhgCjGt7QekMrswUD1MIOtAMQiVoPpA2s3a4U2LJ1wH1eAnPUliX14qqkPX1RVGLj7sLn4lRw
	WQGhZId3mQ5Fl8J6Da0iTgaog=
X-Google-Smtp-Source: AGHT+IFFn+9Wl1V9GGuDnYnwGJmjleHmmxMFlIz9m1PHuiCzLvMoC23SgnPGHqbpVUGstOgLkQRAUg==
X-Received: by 2002:ad4:5e87:0:b0:72b:37ff:b877 with SMTP id 6a1803df08f44-7393950ed3fmr64869776d6.42.1757297312434;
        Sun, 07 Sep 2025 19:08:32 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720add660desm113280016d6.30.2025.09.07.19.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 19:08:32 -0700 (PDT)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6C0B0F40066;
	Sun,  7 Sep 2025 22:08:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Sun, 07 Sep 2025 22:08:31 -0400
X-ME-Sender: <xms:nzq-aPQuKw2s68kWLVDtIC3GHcqYkpKAA1CzsgUsdL4LfdHqoynK7g>
    <xme:nzq-aCTSYwu-g2B9zQPwohz5aMQ4JdlsKWrTkiA64pJLI98TG0GGiQExM784libKP
    y2Hgja8p9SIZ3Btsw>
X-ME-Received: <xmr:nzq-aCeqIpy4VAD5D7BKWG3duzGmhBztCVtV7Nwjm16w0DB4QprpPJidehZEChEml4CJvPARwqK3RicPh9VfFfzBeBbg0ISJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedvkecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:nzq-aGcvVVpCxSmuqkh-9kgNAt6tQeJbq4eNEgMTg0W4Tx9SAQlrHg>
    <xmx:nzq-aI9U-KDW2lH0lwoVAy9ooH_h8eauBuPDaAdRKMeEa3DitNvy0w>
    <xmx:nzq-aGOaJ-bHC0Tu5unGBG1sdHxhf0xS77imWTqCxAgq_83hdWa5Gg>
    <xmx:nzq-aGVF8CJiu-41RspGcaZoMKkBrnNWK9CsRrpD0ZzCEPoRd2r38A>
    <xmx:nzq-aGgJeekwSp2ifU4SmNnNbeOfqelcE5ss6jgpeE3es5BH5mhgltS3>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Sep 2025 22:08:30 -0400 (EDT)
Date: Sun, 7 Sep 2025 19:08:29 -0700
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
Message-ID: <aL46nRkYj2SlOhl8@tardis-2.local>
References: <aLshd0_C-1rh3FAg@tardis-2.local>
 <DCLNSNWA7AT7.19OWOXUMJ5ZRJ@kernel.org>
 <aLzmcK2UM53I2Tbn@tardis-2.local>
 <aLzoyWpOr6eg-3yB@tardis-2.local>
 <DCMFN8UGD7QN.27HTYEXL87Z8@kernel.org>
 <DCMQVH09L1Y5.3A842FC1NGG5H@kernel.org>
 <DCMVHB8P7Z2G.PCOWPQXBSBT6@kernel.org>
 <DCMW6H0VJ9AP.1XWI1RI9YWO9H@kernel.org>
 <DCMXPGXDXHYT.D9VJ5QBMAVPN@kernel.org>
 <DCMYLXICOGM7.2G4JBQAE7805B@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCMYLXICOGM7.2G4JBQAE7805B@kernel.org>

On Mon, Sep 08, 2025 at 01:33:26AM +0200, Danilo Krummrich wrote:
> On Mon Sep 8, 2025 at 12:51 AM CEST, Benno Lossin wrote:
> > I actually came up with a third option that looks best IMO:
> >
> >     init!(MyStruct {
> >         x: 42,
> >         #[with_binding]
> >         y: 24,
> >         z: *y,
> >     })
> >
> > The `#[with_binding]` attribute makes the macro generate a variable `y`.
> > `x` & `z` don't give access to their value. (we of course should come up
> > with a better name).
> >
> > Any thoughts?
> 
> It may be a bit verbose is some cases, but it makes things pretty obvious, so
> LGTM.
> 
> How about just #[bind] or #[access]?

#[shadow] or #[maybe_rebind] ? Or #[pin_ref], the last one is clear
about the purpose.

Regards,
Boqun

