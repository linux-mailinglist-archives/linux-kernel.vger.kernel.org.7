Return-Path: <linux-kernel+bounces-783979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88932B334EE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 06:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62AB71891F2F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 04:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6866253F20;
	Mon, 25 Aug 2025 04:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9RS0hjZ"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A4019D071;
	Mon, 25 Aug 2025 04:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756095269; cv=none; b=iDjdPjHZWM8n1lQKLo5RJZHWEwIw9Y3+5ACbM6hVZplJQ5o9AW0t/K/swiKSqEswH7MVNzbtITlO1fykRA1ITXW89ToHa+HwaIBdYwSXw1jMxLa/pz0BLrUW2rrz0QGST2pE/Wm8kYuTD6otvNZzsAdV4ZnkAdFpfx/ct2QPCFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756095269; c=relaxed/simple;
	bh=kTyTKmt4u14/pDZRnlHuTpZoQm276cUnBsIckpPWGrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2UYswgbruNevgWsoONZ/Mcg21AaKSdAnYyJGs067pdlGRd6uutsqwkAKw/nb83HxmYFoL7v/XTwagGOxcX01EA80GvsEUeYzcccROcnD+pl6tDAOXNMRCwK2g4FaLprY69KHZi4jaV5Tu2Ol0n9sePMijHErW4z3CYL7Jb4tnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9RS0hjZ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b297962b24so39755231cf.2;
        Sun, 24 Aug 2025 21:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756095267; x=1756700067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOh2zrgwMM7O3l0xhloYC/6+a1bBMnQHqCxm2UGL5BM=;
        b=N9RS0hjZamktinXyqd9A74VjT7+G25q2sJBiGMb2NbIYMyPobfgrEmz19YpxaK+MQ7
         oDGc1BVp24yhrANxFBE8vdA0nCJTtMuhn0tsz3kK3v0ChT7hapXb8TFkgxGFmKyPwcyd
         yOywaKrfRIASUHZRczibNsuC7IC/hPKEOn6odQKoSvRRmTil3UBN71SpGmeakjAf226r
         KtULFDu3YVqLGHFrGF6dfCWj6JymCv+Mr66ZFPJR+GQhx9VC4WZkTuYguLvgcZyb+VPJ
         QceQuES12/lXWOK8LeoFdrPdRMcHQcD/Rb6c00rCFWxPPBvesgCVk7jpZLV1EhbsXZwT
         VPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756095267; x=1756700067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOh2zrgwMM7O3l0xhloYC/6+a1bBMnQHqCxm2UGL5BM=;
        b=J+OpdF82WhfrUiuEUOei402e/2lythDoAko7z8yg65HxKAz9LWGajNfBmy8ozL28oP
         aebCLgWKKhHQYVROPOO+9ryVFwRrYdGxSRY9S/iC74AHR+WxxfizQ2mV9spwZ0z+F4gs
         sa2AyZ39q2R+NFBW0KApNqLubOIEO5yFmjeNC0WtJM/G9fUbS6Be+dRAnd6k+rNoerrJ
         8/MwSQYdzaSgOY+QsNw3f5dcE81PStZbvKWc/wMBMkeWSWsSJvSe6QdIz3GKyJgCUll7
         rG7TxPPzMXkdRzX6paNQe+iqYBS4m8oiEB8Q3XqBCb8IPo6XrUUsZmV1dM7wkh0OaDcZ
         1Acw==
X-Forwarded-Encrypted: i=1; AJvYcCUyxm/N43kIm7JzJu5F61CjQIHxq7g9szjBGifqncfRyLRyJfTbLS4ehBryGfx/qSf04OmlsnQ8y/cTDsqqBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdgCu4/QwG6ZfZer2P+zXIBpT+ts3Hd3X8dAEuE3lRYPGQwptg
	neBgygxBVCsvV12zsPSNAp7KSB3l+6NOgxzDB/pQIZ/OD92FZ8x6jd1w
X-Gm-Gg: ASbGncuBvQaZN9DSiG4h/WEZok1vSi/WlFdk6eMHRWgw6MEVzGTjwDjLHjphswcFZ1W
	thm3LTJEV4JgtsMJGU0j7fV6g6M7jmJVZq81QxWHmAY0hOaiLjrF6Fqw14VcPpXmp7+BH8hJ6v6
	1No8iqMhcUqZMh0AA7v3LrZ0QWAUiy+q8HJaPOyCw5BMBy5N7rodCfcEzEGBRu///NhhT0X6OpX
	EaraKWt5nG50xdaly/6+2y4QG7muC0r6sUEqyyk4bM2HAh3um8dHrmzoKDwEqfRFoVnkpcUfQ3h
	di4WpVqC9xI/eEBLrTD5NKy8ISz0tuxa25Ym+SNGGnRSrcQ71aqyCIzS5YfwepEzwkJE4/rCPWd
	MDqcWVO/runlPWxg4XeLygP7RnlYF+OpV6sbDBRpH3qHMHIwkkigQjl5sCnaUCAPQNE1qXw8rVz
	EfjxQ5Jr70fIs98b4fv54WsHY=
X-Google-Smtp-Source: AGHT+IHTpmBSdC9OospIa44n4b+nt4viPlNUNTHKQNuykbjihG/uNqp4xTDAwFri6VpVN5FwW8kVWg==
X-Received: by 2002:a05:622a:1ba3:b0:4ab:42a5:7f1b with SMTP id d75a77b69052e-4b2aab04a8fmr128331761cf.47.1756095266463;
        Sun, 24 Aug 2025 21:14:26 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebede53d5esm403947485a.24.2025.08.24.21.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 21:14:26 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7B0E5F40066;
	Mon, 25 Aug 2025 00:14:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 25 Aug 2025 00:14:25 -0400
X-ME-Sender: <xms:IeOraAqVH0xHpIKyWQ3ybJ_Kshjv0YpB6lPdCifKz6WF4djBaEhJ8w>
    <xme:IeOraEVYpeMnNsdmg52cN7iFAaw0sI7AL_f9UYJro-7w4mfeat8HJMwc_x0CyISKF
    9HfAjhXBt2RnPrzJA>
X-ME-Received: <xmr:IeOraG99wwM06ImfE2hoTc02kCFVMNREZV0BhweHSpTD0gaOJmzB0g1oZNwAs36khWqjtyp_FUJGf2Zt3rAcgpVBMPXMGvcf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedugeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffei
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehjohgvlhgrghhnvghlfhesnhhvihguihgrrdgtohhmpdhrtghpthhtoheplh
    hinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    uggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrtghouhhrsghothesnhhvih
    guihgrrdgtohhmpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomhdprhgt
    phhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtohepohhjvggurgeskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvth
X-ME-Proxy: <xmx:IeOraEbbrZyUqYjMScyfJ-LJA6t6Jpt2QYEsAKW25DbudEMMkMtWEw>
    <xmx:IeOraGfX6oGaAe0wjNwJ0xqGCfMSc8fGy_Kg_CoQSICGyB3WSSZnfw>
    <xmx:IeOraGpiQj177fPWnyMZxuOOBmK9PRMdHc_MfV5WShnqpgIFs8JBqA>
    <xmx:IeOraFDXdSn8FLG6f3J8YLE8iwP_27ELJNiNLIQbiNBmU1oACjQzIw>
    <xmx:IeOraMWaGOO-91bFCJRNYaTjfXFvjB-Vitnlz9G1q4h7zE3vFnHmo3_A>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 00:14:24 -0400 (EDT)
Date: Sun, 24 Aug 2025 21:14:24 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	John Hubbard <jhubbard@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>, nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] nova-core: Add a library for bitfields in Rust
 structs
Message-ID: <aKvjIM39f1oGyn23@tardis-2.local>
References: <20250824135954.2243774-1-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250824135954.2243774-1-joelagnelf@nvidia.com>

On Sun, Aug 24, 2025 at 09:59:52AM -0400, Joel Fernandes wrote:
> Add a minimal bitfield library for defining in Rust structures (called
> bitstruct), similar in concept to bit fields in C structs. This will be used
> for defining page table entries and other structures in nova-core.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

FWIW, Joel, I only received patch 1/2.

Regards,
Boqun

[..]

