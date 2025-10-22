Return-Path: <linux-kernel+bounces-865074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DB8BFC279
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D222262090A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FE626ED5D;
	Wed, 22 Oct 2025 13:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aK1zoXLA"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EB928750B
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761139200; cv=none; b=A9dDvKCaz0DYPBzMvF0MQG3vM1Yi+PB6burPjTLWikk4CK2PxSySBB1tgBzvtmotUXwg9Rm+ZXKkufbDg/ptsRGPs2aGjR62zX3aTPnEV027ZRiYxWwpbE7vRJODGIZ80hzwXE3oGqAbIdl3i+W8PSZeioYzZKimFjHb9J0WhkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761139200; c=relaxed/simple;
	bh=ejf1bYPnUQMokUT1g7RKeqZOKPzbttb73m8pCpDXOgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKWfvpsLUxtBgHuAuNrnigkNfSe+OynINck1YLTbgxWGnWKyaz72RI9p9g0Xb9QVNhVUiEOTWWpi7VX/liQoC8KQEub4pUlUM63+IZEfGtNp38RU0G8Jwhu6TH+m1tiWJWrpltbkl3gI6e/Q63dVI15OYvEJU9E1ozqpi3xYT10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aK1zoXLA; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-891667bcd82so141898385a.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761139197; x=1761743997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kl7tw7oO+okb5Kv2O+S27IhofeeA3ILxUV7GihlCiso=;
        b=aK1zoXLAgBhO6s+b3Yeyoo4UjC5vVJjdYZBRpXT8qRsgLOmhIZzDJ5FTPe4CQRVZip
         XozpHrL17Kx0QglGWS2ZoyNia7QsStNT1XqTPtSsmKJfuoZ8aN9Rk/TTtOwhdTVofxlJ
         ndAUIerPNl4ks1dfkcr1MKSiJHwW83WE0GbPYX956YH7+0gIVvFPbS8AxoUgHR9muf2n
         TBdYCnASJ7FoOWnkbGfMo266/+pqCztqQZU2UmSZ8waBO2Z8qbhQUYG9Q9WWTKMkNk9E
         f2jXcNsFT6St22UdKSyKmrf2CcijPlpL1LG4hc6ZBeqGl1r73IHRjLbW61giLGdYoMc5
         Mzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761139197; x=1761743997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kl7tw7oO+okb5Kv2O+S27IhofeeA3ILxUV7GihlCiso=;
        b=Tg6wVqyAr6OL5tMngMgPBSEgSq56ND6Wt0rg4LPVaF8jbs1m4Ac25j+gF0b18/YUlB
         UpMsKz3b5yJPw4+SJWGRkZIdxQ/UpxfcDrMX7nbRK4rCGXA6cUgMFDvtyNRzpq1htkUK
         sOePKY1V+LI6nnUfwxWGn/dAWvJLdAl/D7IPjLWQsxbejCbLOl1GjwcfjtwST48ZgESH
         bgvVL0bMCvqzqh3TtyvLKF4eAA4YBBuhmI/XzS2Xxj+ftC0P34lXukhGUeA6fp5LpIAv
         k/3WXlT1vlc0ZjvYiKadav+Yqs1ldKaHSfVapB8dlDMnaIoUYx6ZAzhYU82DbcqEzt96
         hLPA==
X-Forwarded-Encrypted: i=1; AJvYcCVrPZ1jiK5CUd80KrtearhizYfQlxkFE9KGz+s/DBvob0Bvy+T2lUF9R/aBeKOVDypIXB/QTHTwFGe80DU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiFE4Ct9fN5ZX7kmUd5XKiI82sk2lsUE+2+XrFV/lqpCfHquoo
	rbIyXcyLPDXi/03BviNO5IAJb9O1EOYHcWysxH5sIhV9uoSaCtchD2ae
X-Gm-Gg: ASbGncuk/PiN5mQ4NMAbNvw6NECG36010Nn55pVY2aU7DC46N7ydCAtyPWoxGFmYTVY
	VdsccrbQgTx7sbKzLIrT2NoEDqK1VO/rogS6qtx1dcLDlEu4FkC7qvEYrxPRsuEOkCqej3vPS8Y
	f0G5ezCstE9bTP12lFy5iqjjDUi0HnPMcae2F7PpWOCZU+cIKLGtWeeb0dI3bo1Xif9CyjD5AWs
	AcLmoPQO5jySN3qV3Hu9lJraYSpU8KEmOkviWnRlh1nRuGpQDAevVenOPGjIWeEAoKk6nPxLGOj
	MX/qRdrlSKy6kjzJ3J7arZ2W4QnP6t62ndAIdOfTSHfHXOmjxM4MyUICujjLzQYZRYbiuTMNBTW
	yMItytMPyKndIY/3rpZ12/Ed3Pb5o6+QkVXgds9urjTtxtY2dWf/YxdChvCTve5oxlgRO5e/KL8
	fsp503GxiAFQDbX4ZBV9L63Rp6b0X0S9dMHz6fi36riY54kIHYFUiJViv/p9juBfjAwEPsTZyOI
	iPt
X-Google-Smtp-Source: AGHT+IGMBMUvzu8Mtecf/AUCYSKo7attYFh57E8uVG+HBJHjtAvjIcTWo0/ZUKtNMW1uLZToAFAWWg==
X-Received: by 2002:a05:620a:258e:b0:850:f6a0:931d with SMTP id af79cd13be357-89ae191591amr135171585a.21.1761139197062;
        Wed, 22 Oct 2025 06:19:57 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cefba740sm967124685a.29.2025.10.22.06.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 06:19:56 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 182CBF40066;
	Wed, 22 Oct 2025 09:19:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 22 Oct 2025 09:19:56 -0400
X-ME-Sender: <xms:-9n4aJ5YypRrwwMcCaXYLg71V2U_wRXqQFvZJcO46TfBBVyOFM92Qg>
    <xme:-9n4aC1usiS3Hm-GO0kNLT00eCyHWW7jAKgbdecBGGp30vA02RVxpAeEoycUc7epH
    ySJYOGnZsC_pjd21xVg_aljr35d69sP6gl5o34Jo4_pkVjmuZfhjw>
X-ME-Received: <xmr:-9n4aGnzUkmJOYjHOox4SjFp2zik0O6ykf_OobeAns9h44iJScRof2GENQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeefieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffei
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepudekpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehruh
    hsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthho
    pehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrkhhrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrh
    ihsehgrghrhihguhhordhnvght
X-ME-Proxy: <xmx:-9n4aIjSc1REZE_y6-t03PRLTiqe4NiEN7z_m71tAztU1nqhH3kqWw>
    <xmx:-9n4aLSGlhYcjX2jRdSRTuM94AHHOfIBNS9_Nia4zfDrqajx61PXZg>
    <xmx:-9n4aFiuNb5V3VTCdzB6qWQzO12PWQH8IyvWLtIA1KpNqjsJum5uYQ>
    <xmx:-9n4aPhqPYtg8uULjMPinXlyUHqFpYiIqOKmdKiMgdImYBCUsRoy8Q>
    <xmx:_Nn4aNby-4UbpP7P0BL6Bzg1z9N3i4QlyB8JB1W9tDnc4uzGolkRlqcL>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 09:19:55 -0400 (EDT)
Date: Wed, 22 Oct 2025 09:19:55 -0400
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Matthew Maurer <mmaurer@google.com>
Subject: Re: [PATCH 0/3] Remove the usage of Rust native atomics in debugfs
Message-ID: <aPjZ-yA4ihZqlNwb@tardis-2.local>
References: <20251022035324.70785-1-boqun.feng@gmail.com>
 <20251022080717.GI4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022080717.GI4067720@noisy.programming.kicks-ass.net>

On Wed, Oct 22, 2025 at 10:07:17AM +0200, Peter Zijlstra wrote:
> On Tue, Oct 21, 2025 at 11:53:21PM -0400, Boqun Feng wrote:
> > Rust native atomics are not supposed to be used in kernel due to the
> > mismatch of memory model, since we now have the LKMM atomics in Rust,
> > remove the usage of Rust native atomics in debugfs.
> 
> Doesn't rust have a language feature that allows you to blacklist them;
> ensuring they are not used?
> 

Although I don't know whether it's available today, but I believe that
can be done (in the future probably?).

However, this patchset is about cleaning up the existing usage, which
was introduced before we have LKMM atomics on the Rust side.

Regards,
Boqun

> 

