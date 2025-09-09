Return-Path: <linux-kernel+bounces-808653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C69AB502DD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E757B1C634BC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173AD345756;
	Tue,  9 Sep 2025 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzJVOmnf"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0C02C0273;
	Tue,  9 Sep 2025 16:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436049; cv=none; b=qqGNpky2aR1cB9YzPIf3VDd900l9dabzO/6GUmaD3d+1gJ2ySa6IrKsMwB5MEeim1Fop6G2XVXnFy8OJfUJrx4qSkAM1grKZcOzbK1WffeShH6zhgnMCM40mx1NRpP+qNGSkVSeFqDwDgJQwMO0LkchHG+mHnw/7wE4YTNmL2O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436049; c=relaxed/simple;
	bh=DsmtwckixLME0r6rlgitk45MeFqcv1jMLe+x0m9pdYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YllqO8HEihRh89rNUgfgW6YBu4aK9OCvy8kGLPhgwqPieWRMKRCznf6g/loLuwRZanKMQq3stDGZqLxsuNV9dxAwa+6szSkHabkmt2raBVbnzpEpg2t0EKnjAh1M3ccj/dcba3XI4lYYFOuzPpegnYa2sBXlj1+Iv3gWmbYWpdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzJVOmnf; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8072bb631daso539383585a.1;
        Tue, 09 Sep 2025 09:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757436047; x=1758040847; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gS7mM/4N0grbgruYQEKrI9zVY9v9+ZQYpAxSRL8zcLo=;
        b=KzJVOmnfXUl9lv6S1K7eVADbmdW3ZE5deBVZN6mt51eGRWxH6NAbITpW6UZguAZeAa
         jRTQR/D01Zb1skQPyqt7Bu/4NZ/FuGOLyD+ylJFELBVq4cypPvGMwZx3yuotdVcU2d0x
         dqip9u0u9OfjtOBaqVpk6RySS/Agkfpi9M2mRBvASP8v8vDE3M/ZvdU538YLbbBqjmvx
         zRyGonopDG0cyM9UMR9GH0F741+jJZB7tWuau9BDWE4mZQq8XMdKr2EDhWBfv96Im55J
         LZkMpUCUGhA70tpOv6vS/4ii/5f3uh2kyERyFpZOErlk24Y6qZBxGQrli9FLUd3szbhe
         TLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757436047; x=1758040847;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gS7mM/4N0grbgruYQEKrI9zVY9v9+ZQYpAxSRL8zcLo=;
        b=MPBRpZiPUcH0J12ylIZ90zd9V0Lmn2oFfHsX7J2aNjmvQos2edTD4nYii2avot4s2q
         CyPbLivnvrZB8Cx+f2ywk2L0NrX1FYW1gJZGhFYeHaqYER/9w72R5kWCd9HVLS1V3vd9
         KvQ6b4TQar/zyA//BFNR4Jgbr3/x4ytte+y4B/3enPKD+wE/t91XO0KGS2jp3pu4/eBs
         N97x+xiGhpaE2p20m5FdfDUQqbEPN9MlxNzrez95W6bhBb+b1i2sdWyMW9M2ZFoEFinL
         Vt/BUfPUQD2I14CFfpsFtfIPGOpr6VUtco35GVzNrGH7xrB/fBA+m5JkXmiyGQPbHEpw
         1dOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV37Wet5Xhrcuho62dBaN7mY9GCALKhTsfKmnVpL6s37Mqtsvh2wUtOto1Ridw8IVvJ2rxk4E+Gk45lqzaj3VE=@vger.kernel.org, AJvYcCXFURfZs7+xNJsDpTLYq5SYASzE9kN6qtZ7Y531cGuEECiA6j8xW3zN6GO9Y0zC/YOZqwj2G134yLLfeAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YynEfCxB/AUZccHmFOUFz8hUIf4KQ2bWhoHsMUjPB4lq4x4KgYq
	iZintZl+nkCly21qcMdOX3jvbfd85FMmg1/leb8EPkosmUJ0RElcHiel
X-Gm-Gg: ASbGncv4xmYuBN8VhL/idl1aBiJ7WR12x2K1mEKZpjeIONbRZqIkXGbfSdK5H9o1VJx
	sIpMlqtHCOt1I2YbGR9IIRNmIcsyk3FuG6FnMHYiygeahdIUYKhuiPhK8urJwrougqV49O+6/KW
	vT79GT8IcCZSRyM9d1pxPYLFxMvSJLKGjMmRBlCxVlbUGif/r4XvL1Yx6Gu+/qw7nUSV8fgGPit
	mAC0RuOMRYN+Xk9HGcdFh0vSMO3WDRJLr6OgSRSkw67W5ljM+oBO+q24rpQ7aVHXSUZUkH9gq9P
	JRYejtidn2qf7SBWTxWgDCJlCY0nXkHXaIQic3KVgTecsFWAUfprcNnbAfTbEk5pJZWg1BdfKAL
	os7YKYaGYI+XQUEZhd/kORk7EKU6S0d7zV2v8GdDUYKVbRn/+m1fMXkabbooe8Q/tyFCXQu4f2Y
	pkTSf3W4A6MKVuc4lm6b/TuAP1cLVre/el3g==
X-Google-Smtp-Source: AGHT+IFjLJFh+D73rZbvKHmeUI3jgKWvh2hB45V6RASmn5NE8C4AppqtKSkLOAyb/RtS3DIf77tPWA==
X-Received: by 2002:a05:620a:700c:b0:812:cf99:edba with SMTP id af79cd13be357-813bdf6871emr1295216885a.10.1757436046497;
        Tue, 09 Sep 2025 09:40:46 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b6019f4b3sm143442685a.70.2025.09.09.09.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 09:40:46 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 94DC3F40068;
	Tue,  9 Sep 2025 12:40:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 09 Sep 2025 12:40:45 -0400
X-ME-Sender: <xms:jVjAaK4lghnqiRRKKMw0Wti2mFuw9LirmZEvCeX-TyxvrFvm8xWyCg>
    <xme:jVjAaPv-chdb6mT3GjVFTdvihBoArbCS_zlfx8Ib4_LWASliTKeh2aAk86IpO19NW
    5HcyBRL3LlXMDzjHg>
X-ME-Received: <xmr:jVjAaP421yGis2jHQkwQaRxboA84tBSDd-2xnLamcfXxutLQTtY8677LqxcQpRuvVl3gyCElikfOrVm8FVE-Zn0GU7fjVpMM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedtgeehleevffdujeffgedvlefghffhleekieeifeegveetjedvgeevueffieeh
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegurghnihgvlhdrrghlmhgvihgurgestgholhhlrggsohhrrgdrtghomhdprh
    gtphhtthhopehlghhirhgufihoohgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghr
    ohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorh
    hnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopehlohhsshhinhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:jVjAaD2jXU4ZLbl70b0K8CLNiTFVMp-glZKxfa2vVCQSWwpM714k0w>
    <xmx:jVjAaCjCbRQYoWxfAzrhu1gsLqbFlYYyDGc0hVOzJH30VDPfbo1uuw>
    <xmx:jVjAaDoL71yOOPTjHQGX0wSfsPFZz9qNldu18HhoYue8POIdmM-XyQ>
    <xmx:jVjAaFOz51HsLJ2oGZpd1_eJe44brjzShrZrN6gesyZA38QoRMW6AQ>
    <xmx:jVjAaP328m_06IL6ykN9tla-YYKZWOQDh1Qj-Ybm-HXJXITpgKya4Fcl>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 12:40:45 -0400 (EDT)
Date: Tue, 9 Sep 2025 09:40:44 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rust: regulator: add devm_enable and
 devm_enable_optional
Message-ID: <aMBYjIo2O77Dp2VV@tardis-2.local>
References: <20250908-regulator-remove-dynamic-v2-0-e575ae2cde6a@collabora.com>
 <20250908-regulator-remove-dynamic-v2-2-e575ae2cde6a@collabora.com>
 <aL_PwXck1HsLp5wH@tardis-2.local>
 <AA8FC1A7-EE88-44FA-A0A9-A3EA5529B10D@collabora.com>
 <aMBJ805QjQcPdRol@tardis-2.local>
 <8CA69D19-754C-43F5-96CD-B7060C68B025@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8CA69D19-754C-43F5-96CD-B7060C68B025@collabora.com>

On Tue, Sep 09, 2025 at 01:12:51PM -0300, Daniel Almeida wrote:
> 
[...]
> >>> These two functions are already EXPORT_SYMBOL_GPL(), so you won't need
> >>> to add rust_helper for them. Creating rust_helper_*() for them will just
> >>> export additional symbols.
> >> 
> >> These are inlined (stubbed) if CONFIG_REGULATOR is not set, so we need the
> >> helpers to get around that, IIUC.
> >> 
> > 
> > Well, then the question is why we want to compiler regulator.rs if
> > CONFIG_REGULATOR=n? Shouldn't we do:
> 
> Yes, we do want to compile regulator .rs. There´s been prior discussion on
> this (see [0] below, but also [1]).
> 

Thanks for the pointers. Well I guess we really need helper inlining
badly ;-)

Regards,
Boqun

> > 
> > #[cfg(CONFIG_REGULATOR)]
> > pub mod regulator
> > 
> > in rust/kernel/lib.rs?
> 
[...]

