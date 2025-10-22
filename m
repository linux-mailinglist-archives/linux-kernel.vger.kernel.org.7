Return-Path: <linux-kernel+bounces-864009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6CCBF9B45
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA12C189A52D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 02:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8264B21A457;
	Wed, 22 Oct 2025 02:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwDZScFN"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4552A1F4190
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761099542; cv=none; b=HjvI9BP9Vp2BwQO9c/H3/p5iE7RVMOnBWQWnd3nth/p85RL43ZNE5lKBcdb2bA80uOet0b6dgkw7EVuAKjWQwgu5JnrJBEJxgNNbQ6YMaxi0c68DjZlM8DcqNbz8y535QVfeywAGrOGIfxcZsnaXw2Yx8tyDRfbcfdyQaHRYSj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761099542; c=relaxed/simple;
	bh=BWGUKDVRP/T6icTkv4fm1loBRi7OcK6/7pesRsu8/AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlOMT6TmNXBCLhs2um6As3aQkrFVeHxGfOPDKnUhpWg2llSVxRCEEnj1RBt+WowGmN13Uzp4zsOaCKW+i04YDLIQFi2Tj1FePSJLLVYhdHYZmms7I06Z9NNQB1xykxb7uxGflfAsa2C0fk1iA2fIJY6/3W0H1ugkqjZ40vb0dzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwDZScFN; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-795be3a3644so52140616d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 19:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761099540; x=1761704340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Unvmh2ruzLsZCnmE4tSnjjhwCv09SGt96yN+BEwTbEQ=;
        b=PwDZScFNJSsGEOaj1xIRuK4RT1g9MtQgbeSzbkj0NNZ1tTXxJmjbnn0zezdMpmhgoH
         R4VwSFa5XJAK4Mb3bG+nEL4C3tAOucCgYE7ciRofpjnUQeN9QuJkABUL4R7TTvPszR6R
         3jPDqO6TjRavB8IsxGtdKZNccAK8jcfNWb3EHftki8rKcZ2cRb8STlPuyRMH6sYDy9oG
         nv0T7r5L934UsPGRUzpq7IhY8HIg9bkeT0cHnjbZMuGAaJK/oBbCUaj7teR/i90ktEZ5
         +9x3L+f527Y8rffx0QtraSyx9+MjcMydNsk+01YPFPoxtbZhwr3jqaE4HVHeqIpPjrtS
         2DjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761099540; x=1761704340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Unvmh2ruzLsZCnmE4tSnjjhwCv09SGt96yN+BEwTbEQ=;
        b=uC8d25Oi8Boz8O//DxZZYYUfweQjtUqweVeOkk6ecxBGdjS0kS1ht5x3o/oLgZE41R
         o+BRaTx5DIPjQeODBJY+B2Mzu1l3qbAS1C3exlQ7Nwa4aUZLFY7rgPxUZHjgL1u8XvPB
         Wn9U31rfUD2qeOlo3qtfG8FtI6ywFiWnLleK7PdD/x+QznNWC+ffwf7JsqYw9ujSDDlk
         WKv34UeMZiNCouxhz0b/shayj1WmPgezaB1T4fI5KXYXq7hot5E1jhxoH4fJov3ljF/U
         PgYP1kUg5yjxBDDcC518s3wl2Z8ty5JRJd4t8gDLWv7W55wNIDXTdrsNBNa9zSeVbb0M
         B8Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUFhs6PZxWVrthX5YwBazPFHIUNQcA5bODeC+hRodCtFx65VALh77SLUyxEtHavoOark9W4jHYxVvGD3oQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxav++1yB73ESydQVREnVkJaISQrpIv3W9DzYuW8PMmgg3XvY2u
	JlyzKXFOrxoXccwQBhaVAQQHWQ8hypUwc9FOkEq89+zbsXqymy52oGX5
X-Gm-Gg: ASbGncv6mIBS0wSbmutA7Yl0HONB80kujacz7ZYZgby4r7z8ycHpIaW8sqvgcr4OWYR
	xCJPKkW1N2vnrvc/vyGW1MeyrC1E7HDRAz32l6cofyXvwJZeYkdGVbNlU6d9HXGHvdY0PNS/ifH
	kQMovqaziMQ7V8pb6WNrVVTFM/H71A096AaJY8itHHC8fbCtvy9I5ZDfJP9Pxo/d8hn7a1ezLQQ
	iKv+HK9XYz/cjPncYe7FlxoksF0kZ0O63Y1V3T+KxdGk6xHzBDRVISr6M47JD1aK/gjU4EQguKT
	dNW0LAAh8MrfISr4LERitrL8TrxuhbyWBLc2pMWALBPquzeELS/aUMumktPXcWLwI6ZGtk4gioJ
	gQL1gWm7ItIBwEvhwRaTnKrAj2GSUapoiUh/Rf9h70PHifxO3jQ15C/78RHf2pxb8p6U4mqnV2X
	/2SkX11kJ1RODpMU9C+A16T1sMQzwEr4Anu6BvBsIGhS3IGux8rQM62IOffZnady6lXPE6vRvwd
	KtRcVE0Dl9nHfw=
X-Google-Smtp-Source: AGHT+IEvJfWi+IobdsNPqzDQQa/e2phAlQYHRxKgL1tMIjSc01h/eT5CzWCXeeI5/w7EGpZjqLxkcQ==
X-Received: by 2002:a05:6214:20e5:b0:773:b324:c5b2 with SMTP id 6a1803df08f44-87c2061dd4emr275271236d6.38.1761099539924;
        Tue, 21 Oct 2025 19:18:59 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d028afad8sm79485486d6.45.2025.10.21.19.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 19:18:59 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 28828F40068;
	Tue, 21 Oct 2025 22:18:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 21 Oct 2025 22:18:59 -0400
X-ME-Sender: <xms:Ez_4aO2HGAp1Y6EcACQJuyGQzoiAUrz3P_QHQ3u1TXFsee0Svh5dmA>
    <xme:Ez_4aNq02KJTuQ_T1YhqT1TyNekgtGfxghF6To7Wsi55h7Y8AuGtToBBeOkIrI-Mv
    2CKbRI4L3FvVWP5_oZgFQ1lz4Yp2Vq5zu0tsILWomf6jPfdoOUqzw>
X-ME-Received: <xmr:Ez_4aLUVX0GApraQjrlmWmLpN42szeNmt_Zfc5KYACV2sHvxlvIuMzewClutojsxVCiYH0SMLQZ-4iIbS9bwGWjThACDfC1V8fI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffei
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepshhfrhestggrnhgsrdgruhhughdrohhrghdrrghupdhrtghpthhtohepthhglh
    igsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepmhhinhhgoheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohephhhprgesiiihthhorhdrtghomhdprhgtphhtthhopehpvg
    htvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegurghnihgvlhdrrghl
    mhgvihgurgestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvg
    hrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhn
    vgigthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsohhquhhnsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:Ez_4aGrdTWzaq1X7jktBUoZzase07cSqShQuZ-cxAli_eLzxNPi5JQ>
    <xmx:Ez_4aCBa6ncaewMEyQpxWgXz49DOz06woOL8rOnzjkULyQHeRJX9yg>
    <xmx:Ez_4aCiXQ0q0lq-Lv7chNn3xSGGn7QbdnmaC8rHepRY41scuC7hRWw>
    <xmx:Ez_4aAa1NfUTC9pHVG4bl-J3qSfVwkxN4uSzVZoCxsocd7v1ZGk1Mg>
    <xmx:Ez_4aDmIe4AoBVy7tZ6wEkjlyxGBf-Xn10HjkxUGa7kcQzuiKg7gPaAm>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 22:18:58 -0400 (EDT)
Date: Tue, 21 Oct 2025 22:18:58 -0400
From: Boqun Feng <boqun.feng@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the tip tree
Message-ID: <aPg_EnqRSqmFVdOX@tardis-2.local>
References: <20251022114644.4437c2d9@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022114644.4437c2d9@canb.auug.org.au>

On Wed, Oct 22, 2025 at 11:46:44AM +1100, Stephen Rothwell wrote:
> Hi all,
> 

Hi Stephen,

Thanks for reporting this.

Cc Mathhew and Danilo,

> After merging the tip tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> error[E0594]: cannot assign to data in dereference of `lock::Guard<'_, T, MutexBackend>`
>   --> rust/kernel/debugfs/traits.rs:64:9
>    |
> 64 |         *self.lock() = val;
>    |         ^^^^^^^^^^^^ cannot assign
>    |
>    = help: trait `DerefMut` is required to modify through a dereference, but it is not implemented for `lock::Guard<'_, T, MutexBackend>`
> 

Could we make the `impl Reader` for `Mutex<T>` to bound where `T:
Unpin`? Since `Mutex<T>` is structurally pinning `T`, you cannot use
`*self.lock()` to overwrite `T` directly. And that'll fix this.

Thanks!

Regards,
Boqun

> error: aborting due to 1 previous error
> 
> For more information about this error, try `rustc --explain E0594`.
> 
> Caused by commit
> 
>   da123f0ee40f ("rust: lock: guard: Add T: Unpin bound to DerefMut")
> 
> I have used the tip tree from next-20251021 for today.
> 
> -- 
> Cheers,
> Stephen Rothwell



