Return-Path: <linux-kernel+bounces-739375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3839B0C57D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670201AA1DA7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFE92D97BD;
	Mon, 21 Jul 2025 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQG5kiR9"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AD32BE04F;
	Mon, 21 Jul 2025 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753105844; cv=none; b=g5avJAIOOy9GCsEuB+MoTH175IgCDm5NXRMwPY/OE3fKNPi4S7ltU0vU7YKaXUKqbsb5Lw4zXtMNvgD5kmgUiHEyQWJi+oGTXTyGIuQPCoKeV7/1W/d8sid6gxWvLsh7/wbXeuS8FgeBV41czy1CCkCDZUlS89cKuHf/yrZ7G+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753105844; c=relaxed/simple;
	bh=Ouh+Rb2DpWa0BE8kZFuhuQSkkgiHTdJ5Enf6J0Q61q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhLGbdy7evSraVY2BNUjFy4OTKZ5H3DJ/CYE6MDwVBMAzuu1S9IZmbxoBKNAD/aQmWtYxHrzpVY37llgAFAHPyOR8seYeEZ+7x7cyT4nyDfS1zXm2ff83rYhEz7kydZJNqkz58JeI+XCb4Pd6oR8guEl99gYJRHK8jqVGFZHGYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQG5kiR9; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ab81d0169cso60412011cf.2;
        Mon, 21 Jul 2025 06:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753105842; x=1753710642; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kDWJYEkMDweMn2MG5CYOHj9gUw0O9qH9V4td8BhypXE=;
        b=ZQG5kiR9WXfGGjPpeyaRbPdW4R9ls1/xHON/yFdJPZNndJ3i+9OWRg+VKPTFD+cpWl
         xTIuqpPUAq/kz2ZM5LWNzTEpjkHMeun5uRYy2RWmGCxfs4RFFcAFPF30SsFFRRMgAP3L
         77k+z2E4Rf89YUn4nflfzZoUJl2fvSQ4ssndB8NygxJFd+itYcr5fYk/SW4z7fWGIRsX
         t4CZ+ooxc613pq88XyQ8Dys+dsE/NzPsypuiMy/n/eRcOg/YDeh26G5H7YRSp+mpAPaz
         EYZnahPVDzOMsr92hy7N80jlXRahZgCXFA34XP4BphG7wnAkiKfN/FtmQ65HBE5z6RVw
         zUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753105842; x=1753710642;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kDWJYEkMDweMn2MG5CYOHj9gUw0O9qH9V4td8BhypXE=;
        b=Qv2jA+96fIoSt5Z6l7vh04wJo3qd01DNvQzTt8UxUtu6YxuR5Cs66TOmPYhX8N8MdO
         6f48VKeNwHRiAYxe4mf18OQzLUFS3TFP7XWs1qcqVs7b3Yj8rb19v2TjuxlMYXepJ+Yn
         CRifdS73PczUclHmGfPmmP+byC7qtipp85nuzCHyQcj4wqnOwRYI6JIMcHJqUinUjtoJ
         epnxP200759uEF6BB3/SYVhRht18j/jxF9eLPHyQwud1btGDkESYybT0ih9XZGfn6v0I
         YeD2hFpimw751iBlBC4RGR/o56bD8yzjFrHMWsCfQDZuGxnuopyEd3OmOq8FeK23iZOz
         6i5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2b/yULnBvqv5Pu3LagC2dhVgjJCYPoQIsRWUj0KrMoNafxgl9tMqQIypVljSoCW5XhuXS9qUj+yDbmZ0=@vger.kernel.org, AJvYcCVBQ4OHWEQa17xKoueO8BxtD++7eDbOveCLZ3Q3ykQAB31xz2W4Mc09UsNHPY1CO8YCK8S44IuTVaXpP+uT3kc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKrxTmRwNdJD8tLoipy0cVSVezwQ5uaK+0XEEb5ut3R03fxlA+
	ITJRNHQFeX9R1i8dUu4fqxGzKqZhjU3szutaBxsGR+Hf5qGV2IBm5U19
X-Gm-Gg: ASbGnctS2RkO1FSsN9oQXEb7oLnWOM1Oi1AW/e0iYairZ//zLIXgkPM32msbIJS/ESN
	zBKSkxYTdBBk+8rIXlG0GBmQuOsn4WdovNRFq5vZ7v726DeNuXPRDLPDwoi0BduAH965jnUtLoY
	1Xj1BJtfmlyMMtWXm+lkN7HhR2kl6mU8a63PV+YCXn284YXTXbyalfUqKhi6aFmUKsxI0Y8XF+1
	a3H1qNWYbO3ARlzzVs9ZUPzuaqKhO/Ssj1vjiKVeaL8eZn9CljM8v7tv0lJ/zIfjW1MC7+LPjma
	F0c6qO+uc57O54NNCmGTacEUm0PY+06fEXGnFMvK9dZNAYIIN0OR5jIJ4PaRPp/CTAuAWEj4d3O
	X7mTxZV/OAd3QAASuHfQ14LQP8TTkcWxZOqYbkg4oobUgaqkfo5AtYnMOY6IrRFwK14yB/OjJ/s
	U0HSpPs+IZydOeI3IGk1HVBRg=
X-Google-Smtp-Source: AGHT+IFmrPwcjbXv7D6cvTSAvEa9bZ4UiiY9QfKEDHjEmYMvt6DyjTBIN4LKxmXUR6KBkas/qE7PnQ==
X-Received: by 2002:a05:622a:2987:b0:4ab:50bf:e9d0 with SMTP id d75a77b69052e-4ab90987701mr241335011cf.8.1753105841389;
        Mon, 21 Jul 2025 06:50:41 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b57d78sm42149441cf.73.2025.07.21.06.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 06:50:40 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id ECD79F40066;
	Mon, 21 Jul 2025 09:50:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 21 Jul 2025 09:50:39 -0400
X-ME-Sender: <xms:r0V-aGwNuHBLUz9FIKEiQA9u5kwjtrMjUj5i-ydgJCJlsBesA5WY4Q>
    <xme:r0V-aOYJ22wa2HiQImGDVi7Af5p7QW4lbpiSRU1KMq1VSHdRERXoYNRN8OMSFYyO6
    fs8MGcjn_Gafkut4g>
X-ME-Received: <xmr:r0V-aBn3hHX6w91J3-Axk5BrnCMzqmunPKSB0945WnQqc_X8tyL9aF4k-RA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejvddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeejhfeikeekffejgeegueevffdtgeefudetleegjeelvdffteeihfelfeehvdeg
    keenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthho
    peefhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlihgtvghrhihhlhesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepmhhinhhgoheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepmh
    hinhhgohesrhgvughhrghtrdgtohhmpdhrtghpthhtohepjhhurhhirdhlvghllhhisehr
    vgguhhgrthdrtghomhdprhgtphhtthhopehvihhntggvnhhtrdhguhhithhtohhtsehlih
    hnrghrohdrohhrghdprhgtphhtthhopeguihgvthhmrghrrdgvghhgvghmrghnnhesrghr
    mhdrtghomhdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhrtg
    hpthhtohepsghsvghgrghllhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:r0V-aLkQjUzD63dh2EgEL3kRgcGo5g1Xjor2jwIJp6Ko2j59znGKlA>
    <xmx:r0V-aMNLIoSkHAEHrwxwHn8l_1DsSO8Ja-9f5NzrZHvvYZMZpFQ8Wg>
    <xmx:r0V-aNpoUdlAaTJtSiSPkH7ZE5GEb0wkRRwECI4CITcO_oJMrNhnmA>
    <xmx:r0V-aHQDoAJm5WrK3Mh2iQtg05p296ka2jMluRSsqtFNoOxkSRBk-g>
    <xmx:r0V-aFb8x-QJ1J1Hmcp20IJxKj61HAkTw8mGTL-jbxHiB5wswtbcQ5Zq>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 09:50:39 -0400 (EDT)
Date: Mon, 21 Jul 2025 06:50:38 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,	Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>,	Valentin Schneider <vschneid@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,	Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,	Danilo Krummrich <dakr@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,	Justin Stitt <justinstitt@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Tamir Duberstein <tamird@gmail.com>,	Kunwu Chan <kunwu.chan@hotmail.com>,
	Mitchell Levy <levymitchell0@gmail.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Borys Tyran <borys.tyran@protonmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Panagiotis Foliadis <pfoliadis@posteo.net>,	linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,	llvm@lists.linux.dev
Subject: Re: [GIT PULL] [PATCH v2 0/5] rust: Task & schedule related changes
 for v6.17
Message-ID: <aH5FrrpORLWpDCkk@tardis.local>
References: <20250625051518.15255-1-boqun.feng@gmail.com>
 <aGKWIFVl4nwSl8SG@Mac.home>
 <CAH5fLgj1C-BVAfK8Qoaxb4hV=s74-SNPUeHq9LtmQ5q8aqcd-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgj1C-BVAfK8Qoaxb4hV=s74-SNPUeHq9LtmQ5q8aqcd-g@mail.gmail.com>

On Mon, Jul 21, 2025 at 01:00:49PM +0200, Alice Ryhl wrote:
> On Mon, Jun 30, 2025 at 3:50 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Tue, Jun 24, 2025 at 10:15:13PM -0700, Boqun Feng wrote:
> > > Hi Ingo & Peter,
> > >
> > > This is the updated version from my pull request last cycle:
> > >
> > > v1: https://lore.kernel.org/rust-for-linux/20250506045843.51258-1-boqun.feng@gmail.com/
> > >
> > > Please take a look, thanks!
> > >
> >
> > Ping ;-) I forgot to add that this is a dependency for Rust version's
> > read_poll_timeout(), which is a dependency to a few things:
> >
> > * In the `Tyr` driver:
> >
> >   https://lore.kernel.org/rust-for-linux/20250628.224928.690831629261546521.fujita.tomonori@gmail.com/
> >
> > * In Nova, the gpu driver:
> >
> >   https://lore.kernel.org/rust-for-linux/20250619-nova-frts-v6-24-ecf41ef99252@nvidia.com/
> >
> > * In the qt2025 phy driver:
> >
> >   https://lore.kernel.org/lkml/20250220070611.214262-9-fujita.tomonori@gmail.com/
> >
> > Thanks!
> 
> I would love to see this land to unblock the above users. I wanted to

Thanks, Alice. It's already merged in tip tree:

	https://lore.kernel.org/lkml/175153176741.406.14557081807475800171.tip-bot2@tip-bot2/
	https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=7e611710acf966df1e14bcf4e067385e38e549a1

> add that I fixed the Rust language so that it NUL-terminates these
> filename strings, so Ingo's concern from the last cycle should not
> apply to this version of the PR.
> 

Thanks a lot for pushing the changes at the Rust language side.

Regards,
Boqun

> Thanks!
> Alice
> 

