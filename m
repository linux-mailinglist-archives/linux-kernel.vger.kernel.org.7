Return-Path: <linux-kernel+bounces-737542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F161B0ADBB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 05:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C95F4E3164
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 03:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7021F91C8;
	Sat, 19 Jul 2025 03:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFu91kg4"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5682E36ED;
	Sat, 19 Jul 2025 03:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752896006; cv=none; b=K80aQyWTjz6AkGBssXywbC/5zHP0zqsZwXMka5sSKFCAEaJpbikWDgwbrgK3g0eX4H+q/M2wo/Py6eAyVDdt2Imlx6Er1uBApQ4pwkh6yrBT6mjeU7S/kRYB44NZvFhTCKRvgawlhllE8t6mqxdwmBK/PqFlk8+imL6cISvaV9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752896006; c=relaxed/simple;
	bh=nxsiErN7K+UDI08bWfIdtteXjK4vzOHEI67tHhqObzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9m56qYu6Noxl9g0c3XM1KXQyPgXH7stgsRRbMRzlw+drsS3PLcNuX/nKYkeVAJqKevK4bydP/Aj2Eb993Tx3eiXSC196Sj4pITyVzUmYYHnb6tMk/GZS1Bb4EYltReZgut39YDJ1bB9LLLwvIrXZvqL8oETUXDqHNZHI+Zivjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFu91kg4; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ab380b8851so24488271cf.2;
        Fri, 18 Jul 2025 20:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752896004; x=1753500804; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWxI+jiA7cRK6VG7N78OlHjeHTVdqckiDB+WAU1/JDE=;
        b=DFu91kg41i4Zv3UnjXNnUjEiLXHm+0DncNFqPNVHA3+KPvSyVqhCGe3EgWI92PyKPs
         i5Ii+XcJtl3Q6Zr76q0/2ut2wFEJibilR7BMmqkM+Ufuwya1pquCufg9Hj0H9BvCjTnc
         BpUntp+6MbWnuMLu+1+LZbLXU4S5NZmDxcXZGky9R+f3b7TUInGG/rQuaS1Es7dEiOfg
         KpvI3isWOm+TenDtmahubYAQ5J8KZtPvkxhW8A9xOQkDd0cqxnXDt3/8LuovDnWgd06J
         +zpnD8USLfzduGsYNKrohR2IwZOMYT3rEApJ9PZQYOxXVVfV+6Cwh/MTa67DfevCraoQ
         Si2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752896004; x=1753500804;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZWxI+jiA7cRK6VG7N78OlHjeHTVdqckiDB+WAU1/JDE=;
        b=PvpOiU3KnIpDvcYQUeRoe2j1ZVF/GyvwRBMHMZwO4Iam3jZmgXE9FK77sD4n4wEojE
         GK+zsFJaFjewSLUZ69d/2V1bvIHzJlwQWf/0i7CNuYkHxtnL8im8YZUf/yzrPfErFTgO
         ru7d1lGSqPk/M4pKcacitZpOQK2amZlwLFkxx1x5q+Q9Q8jftgfi/X4lYRDMaED2uuYg
         Mxc/CXOnj/7PXZ2qELXjAVYxNTQudDoGkpxlox9KD5iWQnF80p1Y7jjgyx6F/sGP+0MC
         +PDX90KW/hnfsVVhGtDg+xMAarRIIL/sjISu68d8rZzFTsbYEM/IKakCB4wQqKEOtlxU
         rmMw==
X-Forwarded-Encrypted: i=1; AJvYcCXcOk1DYLlp17j0HpGQpeAC+PWsBzuNej8oR58QwRHJDNFPNXd7khEzswi5/8GZTe+YqzpRU9/AGLrPg3U=@vger.kernel.org, AJvYcCXzGxU89DwXFB53s+DFX7FXEeOI5SZ5llMvgyjCD98UfAW8ApCzYueYuYgmCZ9OwPUK4lvJBGpFtheFjizOIJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYTjyJV4spNRE5EawkBzZz3vMrkUTDFb0Yj2TuFz26kAKGpmza
	phJf6mIbcLiIgHyhzsI2Lle5/TRwfprUGYzvdE+ncGiZt8dK1fV/Grnf
X-Gm-Gg: ASbGncuGkeUt1Px2TL3OiVMusBXYnbNPdiv3bvrJbYBe493I+J3P1PMkZoCI//h2uQP
	nhfvJSs4Z+opbG8TrO6+ozU6PZTwtCxmvpLX02oTrCytBooavnrl8ygxsZPqQzzSggFRIzN3XNQ
	ZUZZhNW5YBYKOs+y/HszhJ4padyDnRxCVM91dEIXOSj/mYKRE25Lxr7pzw0lqJx5uRALF+97BTv
	ICHH3VL64FRjgYUk/Hu5mLU3l7kfSIcTVyd9fnQGBQI4x7qI/+RWM7SmHepHO2JaiWn2HtyGWSF
	9UiLRVyAIOaa5uZQ9KLK+PtXq1TsjWIfxxO11dNMdXwqr/Jn+YMem6IPe8QoV7yzcIFMgPFnRqf
	uPdYpHjf5ZdH2wFTTqeqljqgRXJw0hYXdhACjqPpiZz2XPfJM+vtjLv0XVmqpZIPLfMNBPwrzvE
	Z4gl3Quz9bzOIaOHO//4s38vE=
X-Google-Smtp-Source: AGHT+IEotIbNPwv1+8HyiNhpEijCD2XBx6YcAVfoP57dSY8dIlOi6xyTGu7mH7aEFw8imdgPjLMseQ==
X-Received: by 2002:a05:622a:653:b0:4ab:af74:e0be with SMTP id d75a77b69052e-4abaf74e17amr101495361cf.43.1752896003966;
        Fri, 18 Jul 2025 20:33:23 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb49a95c9sm15290411cf.27.2025.07.18.20.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 20:33:23 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id D3348F40066;
	Fri, 18 Jul 2025 23:33:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 18 Jul 2025 23:33:22 -0400
X-ME-Sender: <xms:AhJ7aOEj3eQVtFZ07wjjMFz8AYNA6IHGFz5xHmLD7xpuHdPe57_AOg>
    <xme:AhJ7aHN3e2wYRWZKujXTMLCPeRUpDStsluOg0ooBgBjbue1euSCrpSuxWbvoo5pDm
    I74r4mCZb9mLv2eFA>
X-ME-Received: <xmr:AhJ7aHiNmqkU5M4lLaq2DAIwFqRC0EIS2M8pu1DIfpxUzR4OHjtC2KN_Hg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeihedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeelledujeetgedtkeduveelgeejiefhieetveetlefggeffhfetleekueehvdei
    ieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhlfihnrdhnvghtnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhm
    thhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvd
    dqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhn
    sggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfihorh
    hksehonhhurhhoiihkrghnrdguvghvpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehjvghnshdrkhhorhhinhhthhesthhuthgrrd
    hiohdprhgtphhtthhopeguvghvnhhulhhlodhjvghnshdrkhhorhhinhhthhdrthhuthgr
    rdhioheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgt
    phhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfe
    gpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopehlohhsshhinheskhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:AhJ7aP2T2aAn00bq-0Bl_bTpO-18dyKLMu47QzyatyEN4NF_vY4IbQ>
    <xmx:AhJ7aMmOW6qLD5i8W038XvSIaZFBmMJyoY0AORKG3uTkpbla4ObKtw>
    <xmx:AhJ7aGt9jDDZFAufB32WlYWMbucccaAA5b_SiFH92ymQZ6O419UBAA>
    <xmx:AhJ7aE3UiR6sbdon4EOBIfP3lcBiry72ZvqtbbPkaB7VzsNRbxnhaw>
    <xmx:AhJ7aKTQZyJQoZDJhukyT9jgfvdsCHL6wMqitGSifLTKv-rLG4Jn0Sw4>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 23:33:22 -0400 (EDT)
Date: Fri, 18 Jul 2025 20:33:21 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, jens.korinth@tuta.io,
	Jens Korinth via B4 Relay <devnull+jens.korinth.tuta.io@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Rust For Linux <rust-for-linux@vger.kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Dirk Behme <dirk.behme@gmail.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] rust: Add pr_*_once macros134
Message-ID: <aHsSAaLDjp8TTXAw@Mac.home>
References: <20241126-pr_once_macros-v4-0-410b8ca9643e@tuta.io>
 <87zfish69f.fsf@kernel.org>
 <XyUDgEm-do6Hd7zeR0J2gte301dYC_LTbQqJ85HUnf0DKGZoH4V9G9dgvmEw4fEadnu8CAZ4j4XWqLdn2YzkAw==@protonmail.internalid>
 <OIpcOXB--F-9@tuta.io>
 <87o6z8h4im.fsf@kernel.org>
 <20250717190713.1f19043e@nimda.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250717190713.1f19043e@nimda.home>

On Thu, Jul 17, 2025 at 07:07:13PM +0300, Onur Özkan wrote:
> On Tue, 11 Feb 2025 16:42:25 +0100
> Andreas Hindborg <a.hindborg@kernel.org> wrote:
> 
> > <jens.korinth@tuta.io> writes:
> > 
> > > Hi!
> > >
> > >> Thanks for the patch! Do you plan on sending a new version? If
> > >>not, do you mind if I send v5?
> > >
> > > I think there is currently no consensus on how exactly it should be
> > > done (or at least I was confused about that). If you´re actively
> > > using the patch please go ahead! Active usage is always the best
> > > argument in such cases.
> > 
> > I was informed this patch set is the correct way to emit a warning in
> > the module_params patch set [1].
> > 
> > I did not follow all the discussion so I am not sure either. But I'll
> > look into the discussion then.
> > 
> > 
> > Best regards,
> > Andreas Hindborg
> > 
> > 
> > 
> > [1]
> > https://lore.kernel.org/rust-for-linux/20250204-module-params-v3-v5-0-bf5ec2041625@kernel.org/
> > 
> > 
> 
> I have reviewed the patch series from start to finish. I am not
> using or depending the patch actively but I can send v5 sometime
> soon (I will have some space next week) if you would like.
> 

Note that you need to use LKMM atomics [1], and you should really use
a 32bit atomic at the beginning. Thanks!

There are a few explanations on why we want to avoid use Rust native
atomics:

	https://lwn.net/Articles/993785/
	https://lore.kernel.org/rust-for-linux/CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com/

[1]: https://lore.kernel.org/rust-for-linux/20250719030827.61357-1-boqun.feng@gmail.com/

Regards,
Boqun

> Regards,
> Onur

