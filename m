Return-Path: <linux-kernel+bounces-809402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99230B50D44
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 07:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD803B4339
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 05:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA84E2BE620;
	Wed, 10 Sep 2025 05:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQbytidA"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431FD2BD5BD;
	Wed, 10 Sep 2025 05:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757482061; cv=none; b=cUtbdWZitIvmr+Tj0UZJ/UIM59+za+toW1KJsmy5/dsu5Z2urz/3DcMPUvvr8BbS84vcw9w4/mylSS/AWRmYaUCLXOtKpbewEGL1D1zwkM9rqu9vM2B0n1KqO8AlVAPL/2Hx1bd7OxG0Eee8YpKPc7e6ByGIRZgj+5DADlWVeCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757482061; c=relaxed/simple;
	bh=OEjoHrb9xyWRVDSFvcYOUh3LLg2YMksqTVPNz0zunko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GduyYx5Q8YnDarS2SxU5Fwt7pEt2w3lSety+P1svo+GM7fnGZonmUDErhhnKFxaPGP38ai0jd9JhpMJ3EFkvl5dYlvTXJTBPC4WGjj+1pnBPkXjTB+hUb/+/nCUvO1BQaHfuCRAJDbbdMsNBFIsoVBbMo3C1vJK84kILRhyAQ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQbytidA; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b5fb2f7295so35312181cf.1;
        Tue, 09 Sep 2025 22:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757482059; x=1758086859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfXAU4kTFrH930fc28SyL71k8a9bCpgJfUYnQ/0K2J8=;
        b=TQbytidAdsFvfXLMoH4MtOYnIAUcZ60oo3oqrzTkacUyHdsiEr8m9gyeyWYq908Cyp
         oYu/IrEYDgZ/6wJBmzhUSJCzpukI8bz54tb/xq9a0N/8v+D/j/VsAmanWQlQlVwB9s3y
         vg5zKo20+H81G6Wd42wGbdLZcJr+2aiYWhd2hrjHTdwAuSewobWscy0uNtJUC+Nd+I8K
         srVqCjhHWsVI1E0PB/V47fj/O7E/vMjjvvlym8pCCXHj9Nf5VoTApgBuq1zDKuYy2NpY
         Y8d8jz50US+oPFD4fdxOdhXoSowds8FnAZTxSZUF+rflYfC28gAJNnLwzprTUKvd99PA
         W8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757482059; x=1758086859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfXAU4kTFrH930fc28SyL71k8a9bCpgJfUYnQ/0K2J8=;
        b=XlR7yImgmY1AVWEkaeSIrsSRlVAdmWq1Z/kUb9k7D8kyvXAaFOcoT9yJpOB3GU6v3D
         r/7UFKoeqUG3nTaT4Ad9n8stRAIqtrS8eAAiXks67Cpxikh/kFRXn0o0MXHLl2i3Lp7A
         mASwU8F2i9jYrqGxHohjG//XVMWaRybYCWpmfaPOLg+CpPFuXlO34sPJgKit/P3BepQ6
         NEL5voSWMrqUlRuJwdeFStUOOn3LGk0tzfSyUQjs8Jm/8b7YAjtbMfX6yZ6MCpV4d9KB
         2NpPI9W/iBPB4g5SGLVmmoTbu3EnGdKhT7wRe4AG3ojpovecbXPf9bCEiv3EajFQHaPo
         pJpg==
X-Forwarded-Encrypted: i=1; AJvYcCX/ApRXe0/jxAkW95jnhLQSjNY67z0wzcZ/xiPC70RzjpdkqivvxWJJA0dWJHO2KzqPo/Xv6Z81cOEKjN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwngG7VDHCSnrWx/LxolRMLXfiK+5zGT5LJYkt2aKOmXWRt4VZc
	kM92e1tYR0hG8Fx4IvdPQvJKlznkfIM3WTrZGFB8LNYh3MW5BwjFTH6L
X-Gm-Gg: ASbGncv4T62gZsL7mGyL1jKETvSq2GXoS9kdFnhO/TGDSqFlpfeCu7U0s1uOFl5d71/
	l5ViLrcKucO3uEfiRWs8iqLiwDxh/DiUg7R1MNGPBVaQ8siYeoIqumRQs8UxudwLU3IIcL3mR7V
	781Y5Uwn/TRSrkW/OX21dj2DYv01s4DaATysF/dBNwpHcNhBZ+oS8FwDmEqcXUMKWd0qa7TuVVM
	FBHiDk7DaqPZABs2ib0EarDeFEETMfmImlMK6MyxJVrh9A/JH6VOPCkYjENT1kxzYHzS4LfwMNg
	4cTQQ9wAGwom4aRrQNgIMuJGnMuVENvt0Q8Cr02z+w8vQJX2eh6d8hGy8dJd9EdieO1N/fx61pt
	9RJGjBO3Hq1pPEWSwLJFZ3WqEkK0EnvUHqyr4JhBaaDsu+KeN5nHpJSYAb8WMMF+faWndk52L9r
	qN4YU38Q/pxl0Pmj/AVPjYgPg0aBxR8A1olg==
X-Google-Smtp-Source: AGHT+IGJCpC+WkX11yTimojnzJpYFmfIyENqaoCRO9ATPdK5TG7co7dhryOiWhUgo1G6hXyFDiewfA==
X-Received: by 2002:ac8:598e:0:b0:4b3:5060:2520 with SMTP id d75a77b69052e-4b5f85396e0mr144011751cf.54.1757482059056;
        Tue, 09 Sep 2025 22:27:39 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b61bbf7e4asm18769491cf.52.2025.09.09.22.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 22:27:38 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 25393F40066;
	Wed, 10 Sep 2025 01:27:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 10 Sep 2025 01:27:38 -0400
X-ME-Sender: <xms:SgzBaIzwYRQ4Ab6lGaG2VfE32Siy1RNHNHHvowNhpDeNvBnOG7ahmA>
    <xme:SgzBaKodVCj1d7SRIE6X1gDwVm1M0mwf3SlMP-jSkOyfFY1Cgq6aWmXQTMHn9kBwq
    bJJRXJvpCAneno1QA>
X-ME-Received: <xmr:SgzBaGUWm_7OTEyRro3DZog1ojhO8RFLRh6KHhre-GOO_E_oeK2BVUy9gqtecgoiAqStwdWfX8ZvYA0mcG74jTfebMydEmHj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeegvddvhedt
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    vddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinh
    hugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlkhhmmheslhhish
    htshdrlhhinhhugidruggvvhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoh
    epmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtohepmhhinhhgohes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidrug
    gvpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:SgzBaJrdnrmq4oGebfUVw60Et0G5R_v1jwoP4oX7GmjTC83BfPbEJA>
    <xmx:SgzBaCHYfqMbtt3REvQnyyE2BaAM6kF5atDtvEiyMHj1NLaaSPNdWw>
    <xmx:SgzBaDtgqjk1d0w7H27JPIc-EV0RaUjhs8zWPRcd8slF6tESybD0OQ>
    <xmx:SgzBaNQIHv_3lcmrVqVvWmrQlJMF4aEaTAqnzwm6uLURm4A0W1gsUQ>
    <xmx:SgzBaIHr-TT9egXJ7Ki0K_lPKpYOyeBPq6K-6hSyRUpkl-uxmUNgBslF>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 01:27:37 -0400 (EDT)
Date: Tue, 9 Sep 2025 22:27:36 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>, stern@rowland.harvard.edu,
	Miguel Ojeda <ojeda@kernel.org>, alex.gaynor@gmail.com,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [GIT PULL] [PATCH 00/14] Rust atomic changes for v6.18
Message-ID: <aMEMSGSLpprpG_w2@tardis-2.local>
References: <20250905044141.77868-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905044141.77868-1-boqun.feng@gmail.com>

On Thu, Sep 04, 2025 at 09:41:27PM -0700, Boqun Feng wrote:
> Hi Will, Peter and Mark,
> 

Ping ;-)

Regards,
Boqun

> I'm sending this pull request containing Rust atomic changes to tip
> tree. You can find the technical details below, but most importantly we
> got a new reviewer for ATOMIC INFRASTRUCTURE that can help maintaining
> the code. Welcome Gary!
> 
> Similar to other pull requests of myself to the tip tree, this pull
> request is sent in form as patch series as well, in case that I missed
> something and changes are needed in some patch.
> 
> Thanks!
> 
> The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9:
> 
>   Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git/ tags/rust-atomic.2025.09.04a
> 
> for you to fetch changes up to f9bd1b3774be140762af2fec9c415b4a11746c48:
> 
>   MAINTAINERS: update atomic infrastructure entry to include Rust (2025-09-01 19:15:53 -0700)
> 
> ----------------------------------------------------------------
> Rust atomic changes for v6.18:
> 
> - Add initial support for generic LKMM atomic variables in Rust. This
>   ensures Rust and C side are using the same memory model when
>   communicating with each other, and would unblock a few more
>   fine-grained concurrent core on Rust side.
> 
> - Add the wrapper for `refcount_t` in Rust. This avoids using customized
>   reference counting solution on Rust side (e.g. in `block::mq`).
> -----BEGIN PGP SIGNATURE-----
> 
> iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAmi6YvwACgkQSXnow7UH
> +rh/kgf+LruO9gn49QAzDE4T7kf9rP/z4ocie8sxMtED5J0vw12PAVa0UERQyB4m
> 756O0GSFKwESJMjLUifBslkt64k8x8hQ+XHYH/WPe/Rm7Ku4kf1zsTO9Mt0xA5qr
> c5OgnLxR3T2L+1x8rEus8lPnExyX0G0b1/H1XjR+rvZAP1enwcLNyGFV3fNfAYNJ
> cMpkGCMFM9wc5dpzDx89ttw49I8yuy+Cmf/eTtm1YDWQgzYVEycF8jTkFqYykIax
> jMcZC0a1Lqrn1pLbxCZ5UEM9vxJREv46xBW6iKSkH5RWlbLo2gqMJbixYvkLtgBP
> AbtrUtsyIx4Rw0nPEZ880Nce/LdhUw==
> =Kuix
> -----END PGP SIGNATURE-----
> 
[...]

