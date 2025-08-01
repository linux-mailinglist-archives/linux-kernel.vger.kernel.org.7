Return-Path: <linux-kernel+bounces-752775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6401CB17ABF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 03:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13DCC3B1F14
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 01:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710DF74420;
	Fri,  1 Aug 2025 01:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdrYC+PN"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DE58F49;
	Fri,  1 Aug 2025 01:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754010932; cv=none; b=kqepFtaXWk7MVWzEXdbCKMMvpZl0avs71YkmAqtDSwdLfoI/uKfUFUUghrKmHlg42AnCDjo3ws3aRyyEFENWeEDvjKEOpiyABizgUi26qOA9IWDGSz9UgWX7pwOHqoMwV2VTcuzDmcQs1kf6NUTlxYD+XAuXLqUEy+jG7b0NvWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754010932; c=relaxed/simple;
	bh=OUCrcMUvkngG6i2MjSMcBWDjMjB+Cvich/f1KQ2mKV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFTKw2EC5BbF45M0DsVKynF1K2curjaEnfxwoLiwN1mwOl189A+g73oAGux82U+AVXSD/GRDPglKcpSCHrLO1h5nmmLTCYPmGdUQt11IWiTYjcqmAqqQjtaqnvMMBr5F4tC3z+Ie0PIcItxJmdEVsnJZnFExFtYaLNscuijCCrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdrYC+PN; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ab61ecc1e8so2255801cf.1;
        Thu, 31 Jul 2025 18:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754010930; x=1754615730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rgsv92Uvq3zUV/eNc8BJcCyYb5Mo14mfrDUc+9wvY7A=;
        b=gdrYC+PNmy+pNaXp/RcBTKurOCGrmRAS6FVDddlr6deFPaiWcYkPMwbh7n98JrH2fe
         FGKvwFGvnw0DhNUCNVZ7Dv7QgClOeLVyjaaCK98uhIu3gXZf04t+IrCuuKqd5jgcYyUM
         1HkO3uUzHt9c22mDAa4cCYlIrRs9oxJp+uQWKImh+nBycNNwoVLikWNJQ0flOiPbW+QM
         yqMLVvvG/nOm/GVmiaJTzfGNE+6y/dsfCbOldgD2dEjp88hzYQpxMreAyAfz6rl899KM
         N8krox0ofAkisWbYsqUZBOFgUJn16m5iGaB8N0LslYv3S7J2Dsoavfd7KJIcLmstoa/D
         TFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754010930; x=1754615730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rgsv92Uvq3zUV/eNc8BJcCyYb5Mo14mfrDUc+9wvY7A=;
        b=GWyUb/UYZczwnF0jEVZahkc7utOkiKWAZohDHOV3E16IXAG2ca1qW1BpoAQrskn5bj
         L/TsLsp7ZeznGOkLzFoDn6/GjRJknIpH2Xaz7BxHDLsNpuZXENCnlNDuyq4CtmR8GDiT
         DTZM0qpywo07NMMgt9i9jDHy24ugFriaGZeDZVvPd85B+k34zC2Q6E28I3QhwFpWeyt3
         iKupX0UEJZ+25NfZm3JERFHZmE3C68dllPCHdZ5iW8pBXqTn/g7UukzXB1y58BtxPz7X
         EIB5tjEhe/WJwWkjU8rZROSH342Vkt1zX625+rYJOodeVmg1UFHBTSD9yZZ6HsHBO1k8
         qFMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxE0AtUsRKdHd8OehBD+/uf3bONbRPI4mJ6+/iQI0Mk5UyvAQgpc62wvtYax1TASTTIl6UT4xM1ZrA2qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDBSpUaTXpHgjVKf3D2FiOBGBXZxGa1HRracP7MY/s3i4h/T4V
	rjo9TjBiK6bSlmxXLfFq95G4qcGwe167MLP6D9qbj47axXvb0cao5HpB
X-Gm-Gg: ASbGncs2b1J3tYu7nCk9ailAybiqL9lKx7dH6iH1xsPCEJ+yKI++TQCtZ94tomNQ+Yc
	r1Ea9WePSX5Q2jGH9hS4DXFAUH+A94qtcByxyGMcK2EE3Zf+2AU7NuR5Qmq7+kpU/W5Bp3TPSLS
	nO4ds6/B8KHs6w4niDIJ+eHdTVErapeZ0UG8gAHNqrog7dsZxZ6/b4ly8U4Cuxr7xCy3YcXG+vD
	j7htF/f5PKBRb7ugaqhCYsPDBuu3E15Booi9WfKPOYmFxqmo8vJVnNpB5pQ4uW4K1Xko/BMaovE
	NuG6dO00UpwlrZLkK1H6zk50Hi0sZPxHUC6tUWkC7zTKGKn4hTk/YAlEM7yfQauCzpaHZkF+j4p
	g0p43jWnUhZECo6istIYRqaLSlILg8cMDIRNeMYMBxP5bf13WDt6cxeVLlvgQ9jhAtDfcFzPH6p
	9+bnafH9qN5UYBYCiAtNUjVZiyZJo8U0Zv1Q==
X-Google-Smtp-Source: AGHT+IHONCraGVv6/ue56Gf8Sj2k039AgIXi97AS2jfOOgPelBRVcwQ8x1iCJeLd84D0V/65wqSWtQ==
X-Received: by 2002:a05:622a:143:b0:4ab:95a7:71da with SMTP id d75a77b69052e-4aedbc7a475mr153025811cf.56.1754010929977;
        Thu, 31 Jul 2025 18:15:29 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4aeeed67010sm15552601cf.30.2025.07.31.18.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 18:15:29 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0EE73F40066;
	Thu, 31 Jul 2025 21:15:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 31 Jul 2025 21:15:29 -0400
X-ME-Sender: <xms:MBWMaIT3PJhclhSH1R5wDk7Li1u3NA4NgHD2VZyEajpT_XHz7hMDzw>
    <xme:MBWMaACuxUozrd-sHd7gT3hnE13lqxjtg7RLdxSC72_PFdWxoQ514zgBkm-A1QGY3
    BKbHCyTvqNw3ubGDw>
X-ME-Received: <xmr:MBWMaLSxp3WCBf65VnIir5jBIaNrVf7N_041tWCqnp4AfQny6uiOETOzVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddvfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegouf
    hushhpvggtthffohhmrghinhculdegledmnecujfgurhepfffhvfevuffkfhggtggujges
    thdtredttddtvdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnh
    hgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeduvdfffeevveehjeelgfef
    hedthfehfedtkeevvdeitdethedtgeejuddufeegteenucffohhmrghinhepghhithhhuh
    gsrdgtohhmpdhgihhthhhusgdrihhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrg
    hlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeep
    ghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedukedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhih
    sehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtoh
    hnmhgrihhlrdgtohhmpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:MBWMaCSBnfY8PhCQQzZDr75GdxB4y6ftlPtZrYQ0H9YjfDYPqwrE4g>
    <xmx:MBWMaJLrYCoXCqwHWKjxvsrkP93ZWHknN-AMrbC-C6-_Vh7qi8J03w>
    <xmx:MBWMaJE4OIHsmIItqlgAsFDxfFrns8qY6xpAUOvurY5Ae15h-m3v_A>
    <xmx:MBWMaGQSZW9p4if4DLRY91neC1nXLW4w_4aD-HC-OZtYHQzjiR_qDQ>
    <xmx:MRWMaCW2ZP62sHnC61X-Y0VixBMXLcqJxLTavfMez2cDqIQHCxmewXCo>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 21:15:28 -0400 (EDT)
Date: Thu, 31 Jul 2025 18:15:27 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <lossin@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Tejun Heo <tj@kernel.org>,
	Tamir Duberstein <tamird@gmail.com>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Alban Kurti <kurti@invicto.ai>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH] rust: workqueue: Add an example for try_spawn()
Message-ID: <aIwVL9xmBFHcX9c4@Mac.home>
References: <20250730163439.50753-1-boqun.feng@gmail.com>
 <DBPMYTZSIEQ5.3NPJM1CYVO3CK@kernel.org>
 <aIp0uo5y9O551HW9@tardis-2.local>
 <DBQ4VKUDJOF4.1JVIM88YK8V59@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBQ4VKUDJOF4.1JVIM88YK8V59@kernel.org>

On Thu, Jul 31, 2025 at 11:30:10AM +0200, Benno Lossin wrote:
> On Wed Jul 30, 2025 at 9:38 PM CEST, Boqun Feng wrote:
> > On Wed, Jul 30, 2025 at 09:28:05PM +0200, Benno Lossin wrote:
> >> On Wed Jul 30, 2025 at 6:34 PM CEST, Boqun Feng wrote:
> >> > +    /// workqueue::system().try_spawn(
> >> > +    ///     flags::GFP_KERNEL,
> >> > +    ///     {
> >> > +    ///         let work_done = work_done.clone();
> >> > +    ///         let data = data.clone();
> >> > +    ///         move || {
> >> > +    ///             *data.lock() = 42;
> >> > +    ///             work_done.complete_all();
> >> > +    ///         }
> >> > +    ///     }
> >> > +    /// )?;
> >> 
> >> Not doing your pattern and instead adding a `2` postfix we get:
> >> 
> >>     let work_done2 = work_done.clone();
> >>     let data2 = data.clone();
> >> 
> >
> > Yeah, the thing I want to achieve with my pattern is: make it clear that
> > the work and the task that queues the work are sharing the same
> > `work_done` and `data` (well, no the same `Arc` exactly, but the `Arc`s
> > that are pointing to the same object). This pattern here doesn't show
> > that clearly imo.
> 
> I think it's fine, that pattern is often used for that. Not heavily
> opposed to doing it your way, but I feel like the code looks a bit weird

Ok, I will drop my style and use work_done2 and data2, because it'll be
at the general documentation, but I might keep using my pattern in other
code because it looks reasonable to me ;-)

> & my instinct is to move the let bindings out (which would produce code
> that doesn't compile).
> 
> > That said, I'm not really against using `work_done2` and `data2`, just
> > I'm afraid that may be more confusing.
> 
> I don't think that's a problem.
> 
> >>     workqueue::system().try_spawn(flags::GFP_KERNEL, move || {
> >>         *data2.lock() = 42;
> >>         work_done2.complete_all();
> >>     })?;
> >> 
> >> There are some discussions of introducing some better syntax for (cheap)
> >> cloning, so maybe we can use that in the future.
> >
> > Do you have links to these discussions.
> 
> It's an RFC:
> 
>     https://github.com/rust-lang/rfcs/pull/368
> 
> There probably are more discussions on zulip, but I haven't read those.
> The RFC also has a project goal:
> 
>     https://rust-lang.github.io/rust-project-goals/2025h2/ergonomic-rc.html

Thanks for the pointer.

Regards,
Boqun

> 
> ---
> Cheers,
> Benno

