Return-Path: <linux-kernel+bounces-822892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1464FB84EA1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A6557C4920
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B902226D18;
	Thu, 18 Sep 2025 13:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0sl/C7d"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FC5221F26
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758203560; cv=none; b=KQNXc4E+gKrtgAGlpKetr63lSMeROUSXg0Ct2L5XjeFgewwOkkcd3IwUmoK86P8CG4dTMe8tKvIea8ErmnYSp7IbobT7w3Zp7uQh1/VrUbhKyWemzPOq4S+3KxUc75Z3rRruvq81o9QbnUdMj0wgr+Ird/ZImqPDpwERshzJof4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758203560; c=relaxed/simple;
	bh=Ajn3a/yDUuSlAXJxD2sbv6WzjoXdyhQSoN9vhU4ZgXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNXfLZoT4JVZUQZTutDKNtl7TFSWgOqUkTebpgnY93orHa7svYaiFvNoblT6dDPMLPyy6oZkEH5uTVkVtamfqyA92b1ix2J7Udzxf6YSwS1ol0fgnrG+eLIGyQWP/sJX6Bd5ZKxHO3wI9899j5JhwyrlOwGrsofMcd43UeHhhls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0sl/C7d; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-78defc1a2afso12119306d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758203558; x=1758808358; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cE/jfSCYe24SF+rre+WE2G1fWS5o331BSQb66kdw9Tw=;
        b=V0sl/C7dNoMJUnXk8v/AsoTd4LfAerJ9tptV4UR03UrnTZioj2zN9MDmWJkCjVqep8
         GIiHSbLUvoqZy7dV/otqPhUm5+pXJlZqpQWzAiWGqDDf4EBKYPh9E+pHz8gejd8lK3QO
         6txS4TdOHtcuGuhUAJk3x2aPYsoML4tlOrm16n+up5WSHUzEa1bz41pWMO0hDIw04RfQ
         ciQRbR+BUwp5gH3o4Ubhchleoy2h1SLcYHdvO/N1NXTKhGoLQ5+o+9idUWYgsIplqZ8f
         80ckPdHD5yIt69jvakvr2Kr16HPFqxOp1Rc3L0pulEWY/g/mUC9g9tiFLoddPrqTs374
         Q52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758203558; x=1758808358;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cE/jfSCYe24SF+rre+WE2G1fWS5o331BSQb66kdw9Tw=;
        b=doRG6Cvp0nIsykdU6PTB7ILQ74llxYKXbzLsYU4GBXsyHEa8glZ7tOLYXA/F5J8hZ8
         e5iYIFJpI/aJrCqX897VgyxsATJZNXGTbsF7UE6n514E50mLmm7ZlYnDlDosS8oIiehR
         TQ8bvr5Y04u/9rRndeipgMn9tWMbYWZJB4201Of6zWFCMdtsGIdffFJrQQMC74YmhdUX
         O762rkoiBKqNIojOypb8jCJixN10n7IgSk2MtC7I57T6+5s21h3F7V0W3frU6ZQbhsDB
         KS3p7Yis5JkszOI6dLUUia7wenKnDDRiYVTWmTTTCLua68/WhSmX19jMV6eL8ex/WWFF
         kg6w==
X-Forwarded-Encrypted: i=1; AJvYcCVTbBf2zPTV23dz2d4WbQRRP3EjA3gNKArhdfrQ1c/l00z6BFOWl95hnYHldEDHB89KFAhBoFLrz1Id5KM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwIckSgF2Vs9jYv6ucGZ7BAGKVvm2MGiwmv8grdEQBgNaAv2kG
	nkzduTwTq7OYVGI8x+rcGpmiu9F5h8vE1iTYwRG/3Kt/MJSH/Fgw/7k5
X-Gm-Gg: ASbGnctvxOMkpMdVZtFI4LwP47OVZ62iVvrl58RS5TOiEE9VjyeCo2N3NANTZtNEe0b
	SsS4L//n2hgyHP516rG8/0/eytP+HW924PTY+3HSFcmPqU6qxhA0aYzkXBL7hKnXwqghisqBWae
	pRssHFYomer/oCExr1W1DhgXYWIJadX4/7nTSRl+AtSXIzyHPwflUto4RGPe3Bl67djp51hS3QW
	CgbyiN4yFv6h1hF6ToQBDDW546sNTINlcTPn0Enpmr/S8bePaN3I9cE5X7Kr++6F5+kT/EXkNGB
	CKuX2vH9GrrX+cotk+3mwbc6MxDTF/jmyvqHM7HzK+dHkyzAiEuOQw3O2VZZ9wojJwgRhjQGEpg
	O0ukzj0ubLpKJjN8l5U87rdPceWYJkGpNnXdmg1p5evMMhxRkpEe80r0oySKcKNAck3A8fpCq5x
	tVyFCKuWr5ucsBabJWhvj4Hw/LUn22b0s=
X-Google-Smtp-Source: AGHT+IG0+wbWRL9kj9CAnFUfs7kPskW4drG3XQcDv80xqtqRIjJDglvei2+8r7mvayYyCmhK5XG5zg==
X-Received: by 2002:a05:6214:d61:b0:785:a907:967d with SMTP id 6a1803df08f44-78ece36a473mr62210306d6.41.1758203557584;
        Thu, 18 Sep 2025 06:52:37 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-79355ce7048sm13234056d6.69.2025.09.18.06.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 06:52:37 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 07115F40068;
	Thu, 18 Sep 2025 09:52:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 18 Sep 2025 09:52:36 -0400
X-ME-Sender: <xms:ow7MaKie56oVZXFhhaDZNmEU1iOrKavP0VQzpmbPAJm-1LxBETU0Lw>
    <xme:ow7MaJzi7CNJPjA-2vAE28QLiAj4I7V-4UyITUicsDcBy5KZtWSKzck2JQ6mPDL2X
    ht4V_PDwNP47iibXg>
X-ME-Received: <xmr:ow7MaGqbxKXfYVnIkVsjA0m4J6D-uVDVjyPcSoj61NPKxoGvBl7p-4OqA5eait0yy0KasLMC3xAiDotJq6xMa-t-7HehYDt60NMl0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegieehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpefgleehteekgfduteejjeekhfejfedvieeftdfhhefggfehheeileeihfdtteeh
    feenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthho
    peefhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhrghsthgrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrh
    ihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohht
    ohhnmhgrihhlrdgtohhmpdhrtghpthhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepthhmghhroh
    hsshesuhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:ow7MaPVc8T7eZBy2RgW9sfyPigQKRfcjyhXDf47-1LDV2oC82c34Pw>
    <xmx:ow7MaPM072-TRFZ85bgpHbLLRkyNUHsjKtKuIMbZUT6vjGxkEY2mDw>
    <xmx:ow7MaGkpDFl1mZWl7EeGd7k0ZEyKWnGWtSo-Mob6pYsTFLbXLuVYeQ>
    <xmx:ow7MaEpdTrbDMRd8hmdFBYLVuTCXbSTCi-kiw3IeU9UrqNoXN9_qhg>
    <xmx:pA7MaNnK8xCAmxYh-hPX_BlzF6o-fxbbk-FKI5-2ujJWT4JdG0vkQtHP>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 09:52:35 -0400 (EDT)
Date: Thu, 18 Sep 2025 15:52:33 +0200
From: Boqun Feng <boqun.feng@gmail.com>
To: Philipp Stanner <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,	Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>,	Waiman Long <longman@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,	Justin Stitt <justinstitt@google.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Asahi Lina <lina+kernel@asahilina.net>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Krishna Ketan Rai <prafulrai522@gmail.com>,
	Lyude Paul <lyude@redhat.com>,	Mitchell Levy <levymitchell0@gmail.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH] rust: sync: Add dma_fence abstractions
Message-ID: <aMwOoYe1xGDBg0Zv@tardis-2.local>
References: <20250918123100.124738-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250918123100.124738-2-phasta@kernel.org>

On Thu, Sep 18, 2025 at 02:30:59PM +0200, Philipp Stanner wrote:
[...]
> ---
> So. ¡Hola!
> 
> This is a highly WIP RFC. It's obviously at many places not yet
> conforming very well to Rust's standards.
> 
> Nevertheless, it has progressed enough that I want to request comments
> from the community.
> 
> There are a number of TODOs in the code to which I need input.
> 
> Notably, it seems (half-)illegal to use a shared static reference to an
> Atomic, which I currently use for the dma_fence unit test / docstring

The `CHECKER` static you mean? If so, it should be a `static CHECKER`
instead of `static mut CHECKER`, also for future versions please use
LKMM (Linux Kernel Memory Model) atomics [1] instead of Rust native
atomics (you probably need to define `CHECKER` as `Atomic<i32>` because
AtomicBool is not supported by LKMM and potentially sub-optimial in some
cases).

> test. I'm willing to rework that if someone suggests how.
> (Still, shouldn't changing a global Atomic always be legal? It can race,
> of course. But that's kind of the point of an atomic)
> 
> What I want comments on the most is the design of the callbacks. I think
> it's a great opportunity to provide Rust drivers with rust-only
> callbacks, so that they don't have to bother about the C functions.
> 
> dma_fence wise, only the most basic callbacks currently get implemented.
> For Nova, AFAICS, we don't need much more than signalling fences and
> registering callbacks.
> 
> 
> Another, solvable, issue I'm having is designing the
> dma_fence_begin_signallin() abstractions. There are TODOs about that in
> the code. That should ideally be robust and not racy. So we might want
> some sort of synchronized (locked?) way for using that abstraction.
> 
> 
> Regarding the manually created spinlock of mine: I so far never need
> that spinlock anywhere in Rust and wasn't sure what's then the best way
> to pass a "raw" spinlock to C.
> 

You can use `SpinLock<()>` for this purpose, no need to add new
bindings.

[1]: https://lore.kernel.org/rust-for-linux/20250905044141.77868-1-boqun.feng@gmail.com/

Regards,
Boqun

> 
> So much from my side. Hope to hear from you.
> 
> (I've compiled and tested this with the unit test on the current -rc3)
> 
> Philipp
> ---
[...]

