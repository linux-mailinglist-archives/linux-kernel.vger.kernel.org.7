Return-Path: <linux-kernel+bounces-803456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF617B45FF8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B57EA45185
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D536435A2A1;
	Fri,  5 Sep 2025 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zb3G1xOz"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECF5313270;
	Fri,  5 Sep 2025 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092916; cv=none; b=e+pZoMjfNVRNM5WU4ihiyrcSOZ8tl3O65eiwCy7H7dMfFJAUSu8mTAQfRCqvEdjRYoEFCTW0jSAj1gc/s0JA8qCQMOaxBMEWVqNqqkUvlTAmZ1gipBF0rN55wsODBNWQrgCWeSvvTU5mM+SEo5V8FJbF/YC5aG75mcliJl6aVmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092916; c=relaxed/simple;
	bh=UGJZrTlyxlhtg40AgmN8LaTmzVKr4Sl2AOH8Cpc9Org=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=feoa52+TRraVjyvt6u450yIoCG5t3S59qrJ6eKfrL1VjW9whWziy8BUwZF71eXXS5Y34Q6XOUhGkUkJ/2k8VPr7Lz/tecPaoZAtfKd9bB8NaDvPN+AOz/le73e7OyZVvHUkOCZafk8RWk8FsED9vfIwCyWbPWtvu5NML6UNM+u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zb3G1xOz; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-7291d89185fso11427686d6.0;
        Fri, 05 Sep 2025 10:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757092913; x=1757697713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojkruaY3kRdJj/HExv5LGFVsZ/Ot5/KNUgISWC2ZkwY=;
        b=Zb3G1xOz15x2HJJb7XSfb2duM0PuHd9Gau9404/dWDC0XPkPelSp1C17IpWc0C8MFz
         awlzZGGUx8PXXKLxGKUJZuziZepMa6F5Fe45BULqT8AK7D7vwirD5YnAg9N7eFL014qR
         EoXUGa0eSc3rM78WZFk6ThZ6KVv1TcRRVamXsqWDe7/ac3fFSrWCxUQNzcN3jCYnSIW5
         DqMeKNVxxKny1pSuvP6GMV0iFO15TFTlb/lOirpgZpeQsxgyFDlS5HUCrUxbMERxRjRE
         81zRqeVVunos37FJnSDe6i3Pe0pwEJPRCZzN1oSkgcKG9Cy5Dx8gdQ5g0b7OB5zcCg0F
         kLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757092913; x=1757697713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojkruaY3kRdJj/HExv5LGFVsZ/Ot5/KNUgISWC2ZkwY=;
        b=rJVVMIpDdgSL+bdjeL705+D/saEjK5H6qunEzoDqQbGiLx/+0dlS5E9tPVkRvSMFai
         RnyIb/SuHfH7MaunkSMbeaan0choXxsU7ACCEYu+Q5UekAvE6xtw7xAB7CGUjgjFRUxE
         czM+RiKGIohvvaTuzJDXJWVeW7rcUnOik5bWh2gfo9bQmLH2bAZAYbYGKC0iWGRfU+dg
         tglK/T8lmOhqHAxn+zxLS5JsjYtP0ON45bTEmu+EvMPcVKe5XvnKxoeNXyck3VGs+162
         nrwIigeMID554wdpPH4lgIKDoUY+3scHcrWTsDIbks28qrCXv7kvUFWugPU0SzkdloJ4
         jvTw==
X-Forwarded-Encrypted: i=1; AJvYcCUOwdL7HozudGTnqs/vCzvLBTy9SyR/k+VqF22So76MQ6Uu+fC5lC42MsYoj8Z7wjJ0x17P3le0G8fTH60=@vger.kernel.org, AJvYcCX2yfJeHFNqAT22fHD4azrV2fzOCsMesa4l/9uotXULrcGYgsyF644kqqrXUoC/jFesQ2feffhIUFsfxpKK6j4=@vger.kernel.org
X-Gm-Message-State: AOJu0YymFchfrDvbxkx4blRvq6tnHfDDeA3TvCaoorD6VTKuJA8rwFkK
	sYj8aVQx3E3dJxqizLEDm6b2KvUWT7ydJaTDaPX5T24kT5X/TsRB/g+t
X-Gm-Gg: ASbGncurI/0gkjxC+tnUF3i/lQMfw5iADDvlAOaAwghWk5sRNy/ZQR00mmxp98DOiHy
	rBB6cMxOsbvRyDwEWLyi105XkKUSIIh2KXWvyJf8fs4eUkwp8IKsVW4oTumpcfONx0xUUvkYWb7
	A/+xCH9Xlwi8d5W8VDk2zj+ZcahEQoS4mzyR5MynMg/7ZyFsVjeCIwf+unj00/g8fRkcr01MfbR
	9kWvjGFPYsHDkA0mQEpM+Br/WM67y+Eda8vqQfuAio6vDuzhT5BxvaIMYB6sLrqZ6q7tAfDiVEV
	fr2O+vRnas1A7Q2UPbppUimRUEpuPjOZdqgmxj/u2FnZ0grncptr+xUQaliXvZ6a4lKZbHaWZYZ
	nSuZhMI5wCEBBP9FTXWhblQi8ge206L9Ts+pcqmAbcj19gr5ei8a2DJIT5eG/ovqKjDT5pEuWlu
	QligWk2nTl2LDlbaSP7DbKvPKWvEKwN6PWZtelOr10fzph
X-Google-Smtp-Source: AGHT+IHvYp931SXAxT1u59cLKnwlPbnLOsc4TRjevIGttrrwPHVRH8WvMI0LrkxHpd2Yn2NzTDShiQ==
X-Received: by 2002:a05:6214:410a:b0:70d:f758:597b with SMTP id 6a1803df08f44-70fac6f8128mr257309206d6.5.1757092912874;
        Fri, 05 Sep 2025 10:21:52 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b683283csm69994416d6.68.2025.09.05.10.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:21:52 -0700 (PDT)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id ED72CF40066;
	Fri,  5 Sep 2025 13:21:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 05 Sep 2025 13:21:51 -0400
X-ME-Sender: <xms:Lxy7aDBsJ0Z0KryaHpKn4ltDLTN_66ChTkvw2iMGoNoYavdw5cFpdw>
    <xme:Lxy7aIC4psUkUhoS2LEgJr_2Dhr2BMqs6bUymT9VYm73aKUzr2LsoIklkfp8yfhg3
    pk8W4j26rB8V7jdNA>
X-ME-Received: <xmr:Lxy7aKHN3aUuZXPdDeWjl2wkj_JgNGJeea1BxmS47T9I70PCyuE3-MbZe6hgsj3FjuAgbn1YUMlvj2ageVjZEOOXaR40PkAW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelgeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpefftdeihfeigedtvdeuueffieetvedtgeejuefhhffgudfgfeeggfeftdeigeehvden
    ucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnh
    hgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedu
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhoshhsihhnsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihse
    hgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhn
    mhgrihhlrdgtohhmpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphht
    thhopehtmhhgrhhoshhssehumhhitghhrdgvughupdhrtghpthhtohepuggrkhhrsehkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Lxy7aP7GFvd5i-ussE66htRj9wgyQTrIMxZCUBJT7VY7d6s1fFDRSw>
    <xmx:Lxy7aBRug6LIiZOF2QENhQlxZFgKsbpf4DRrWiM3mTtd8Cya5tUeSw>
    <xmx:Lxy7aK5nB1wGt2xLs4F4VXWcq-LliBoqm7jqwYxHDyOuHK4wSuAS8A>
    <xmx:Lxy7aOSN6tVyuvIlA1uvvh2diDHhwff7T2X2CXGSQ256n2M1HUGVXw>
    <xmx:Lxy7aPnhTwPfoAcNU5U5CPXfSSuLc5Dkjd4n5jc8XCqOivL3Bd3OhXXp>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 13:21:51 -0400 (EDT)
Date: Fri, 5 Sep 2025 10:21:50 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Fiona Behrens <me@kloenk.dev>,
	Alban Kurti <kurti@invicto.ai>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: pin-init: add references to previously initialized
 fields
Message-ID: <aLscLsY0Sv1Qwgni@tardis-2.local>
References: <20250905140047.3325945-1-lossin@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905140047.3325945-1-lossin@kernel.org>

On Fri, Sep 05, 2025 at 04:00:46PM +0200, Benno Lossin wrote:
> After initializing a field in an initializer macro, create a variable
> holding a reference that points at that field. The type is either
> `Pin<&mut T>` or `&mut T` depending on the field's structural pinning
> kind.
> 

It's hard to review because of lack of examples. Could you or Danilo
share some sample usages? Thanks!

Regards,
Boqun

> Link: https://github.com/Rust-for-Linux/pin-init/pull/83/commits/0f658594c39398f58cd5cb99a8141e370e225e74
> Signed-off-by: Benno Lossin <lossin@kernel.org>
> ---
[...]

