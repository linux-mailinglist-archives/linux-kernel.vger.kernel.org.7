Return-Path: <linux-kernel+bounces-810788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7262CB51F73
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB901BC431F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D605733436F;
	Wed, 10 Sep 2025 17:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvL6pXXG"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E13627A919
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757526572; cv=none; b=tVRhS4hxDlfkxhwXJqzZH5N9prkF+XveeZmNlEU1F9JvkblpUHuM06K073MC/Kkp2Nwzlhy0gtYTCzJDLOG7vIBcWJorFUSvA/dRJVEVFwyL3KfyhY0lb2W1o3Jb0maF1KsvO7NPU67uZAFQaYxPeuoaa3DoNjmp9IJQ5C661aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757526572; c=relaxed/simple;
	bh=2TDh7kQNLkaozzjTxM5BRkxxeG3Q69mI76e1tjImguE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqwZzUQJtAuXVSkrLojU9lF18H1oTK8psd5K3Orl0eYmwgdEwS3nbxk3fLcSP9V8CSso/gaga0KexRgPmROdsq0R+8eYK7mNdCMyC85ZfL2V/5+T3ZgThacEbv/L9GSAymiM4vZ8JLgc/vxwD7cq+EdeeHUEMoHGr63eTdAxYOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvL6pXXG; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-720f0dd2809so39779366d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757526568; x=1758131368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HH/sk2u1+avN1Ur0Gsai+wP1pZNmCIVXLH43sOHbyw=;
        b=NvL6pXXG9ZF/FjGjJbbNirdCy1kEdSK5ZC+Qe0iJ9v1PkbrE1DherPBeAPyBzaXIi3
         P+EZatxvTIr8yYMGPuzZe/CN41mJl+N9EYzABpKng3fremq8ZRHNH98l/sVVgvZ7OWpM
         k0Ana0roVUcvzG3cr8F/HMVeaNe6t+akfvyx0O7eGgfE+BD/sxGWgAvJXZJgrZqP5pHi
         Z6YdKDUxAREy1QOTi2DhDyHMxRu25gUfvbl81gC3qGN4WZGq7/Kg8oOEpjDN/ApUN2MM
         pNEtWZbTfMDR8EcPj5VKPfiN7PNjd9WeyDKPFHDiaTWqBAA7jTwsadCIJfcXf4XaYqqE
         wbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757526568; x=1758131368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HH/sk2u1+avN1Ur0Gsai+wP1pZNmCIVXLH43sOHbyw=;
        b=IWAOrH7B40zTIVP5G+SPb+1DOwXO4k2qWgGYwhsFPhZz+kdXR0OhiO33SG71uiE7Pw
         GUxwNVTkWKrKhar4ka2nuf1ig24ZBtX1tefeb6M0HI7FplOGbS64Od7w2q+x5wtrjz28
         M7cV4m4rS1O7RyJziLNTONeOh0XVolHjNgGg64Vgbtvvba7Z52MeJPzjpMdq2df6tARS
         lv1esPbkwxYvIRGitl78TuoGszalG3B37kOKjrNg48Ugk1maSIxCHb5lbEMyxGGxME1d
         5dM4AgsyXgNgPy1X5ZRm3R4iVGUz33InTZ8sWGSM/jrctUYANYGGkHYXtaZdYmYsMbhy
         92/w==
X-Forwarded-Encrypted: i=1; AJvYcCVMXHGMVAZY53NFPNKOWD6stwpF56MGBkaAFfqQ58ywZQL8Sjm82o5L65oYjqCzr/dVQ2PZSCozaJa0FQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzprcAWeJ9AXXSO8ex/VECf89bcu2wmj7JxFEq8Cwx3IxN0GrpR
	xJRy51+u3IEm0sxdmaI5bWJOkoh3TH9U1cxY2SNkY7XUn3UzJVrN6KGo
X-Gm-Gg: ASbGncsZjbKMmWfWZFi9Y1j6xBOt6Nm5vaa8uWX8s192V6fAqtGstMw/R/Rhgi5BcJn
	jpNKJwXFKANUrIyeWI2vmCYR0OLnE8ToAOST23ALcR6E5Sk4R2NnNQOO8MU5mSY97LkIdjFxKci
	/uOpPDu4Qa2x3c7BUIFthUKMEs1U3L5zmUJYv+AG5saL35b9xTb7EhViSSLt64jE/Ar6iKoCSDl
	b+uNjcze5bwx7yRTQjGWKEHRUryQjKvrnh7B1KACQWoEGIn3O2dy2I4Hwdy/zdkH8I2TPFBCsoY
	8ppj52tu1W/GgS6fk/FxBYGX30CkE7WlTHR52F10pfnjV+En9IrY0a2tTw77hsxJ7BJMfjF8rRz
	GjVnAziLGC1VwdFn3DXLBHnpnyD//LXqhzCe6wQTgQin5AUMoA7rjkfkbfe+UoWNWBiAYlZWopi
	iSqFFF34x7/HmxFdONCQ8Less=
X-Google-Smtp-Source: AGHT+IEM95swY0kJ4pEE7cWXE27bS1FyfUbGECgZv2e+mr8++Z6Pb1CgEAwNTGOBAf+oZzHMcYO89A==
X-Received: by 2002:a0c:f092:0:20b0:73b:d22e:14c5 with SMTP id 6a1803df08f44-73bd22e1629mr145693356d6.3.1757526568388;
        Wed, 10 Sep 2025 10:49:28 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-72708307ba3sm132482656d6.42.2025.09.10.10.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 10:49:27 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 560FCF40066;
	Wed, 10 Sep 2025 13:49:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 10 Sep 2025 13:49:27 -0400
X-ME-Sender: <xms:J7rBaK5HcTFTz81hNGOjseXYAAi4_PTvlp47SBd0MLQCfiOD4a6MIQ>
    <xme:J7rBaFUr-X16eBIGVvHEVV4zobkncNrOHvJrH_lliuP14EqcOxaiUA4AYBF8x3_GA
    7UfNdzM69Z4BkIxcg>
X-ME-Received: <xmr:J7rBaE0JGE2VLBziKwsmktwKR4XWJkQt0xckApkqLBZSEER9sW-U0os6S_IAHz3B1y9tPR3rLw_wKtzTcsnmPe-mRZRmwy35>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeegvddvhedt
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    udelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghnihgvlhdrrghlmhgvih
    gurgestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehmthhurhhquhgvthhtvges
    sggrhihlihgsrhgvrdgtohhmpdhrtghpthhtohepshgsohihugeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghl
    vgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrh
    ihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghi
    lhdrtghomhdprhgtphhtthhopehlohhsshhinheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:J7rBaEMY8t4bELOzHKRxNeByGs_fRPspa9sAyzgGcfAjR4Vd6coZtQ>
    <xmx:J7rBaP1ddmN7A4BjsljAGCOjB3daOWNBafoaK_zXVZ3WbhXWl1dvlQ>
    <xmx:J7rBaD2bX_DP-1yYLdO6Gp-1FaU4-Ow1LB0klvP6NlkqxM0W90o7Xg>
    <xmx:J7rBaN81bRzOckvOqHBWtllEsVP9qITEtgKNK0vfsls2RWzeq2yiBw>
    <xmx:J7rBaPYwjk3V5nKNxy2UxplgoFKMY1QwM_7pmuoWVtUEiTjhRztwGwAb>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 13:49:26 -0400 (EDT)
Date: Wed, 10 Sep 2025 10:49:25 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-clk@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rust: clk: implement Send and Sync
Message-ID: <aMG6JVMcMxVuX7De@tardis-2.local>
References: <20250910-clk-type-state-v2-0-1b97c11bb631@collabora.com>
 <20250910-clk-type-state-v2-1-1b97c11bb631@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-clk-type-state-v2-1-1b97c11bb631@collabora.com>

On Wed, Sep 10, 2025 at 02:28:27PM -0300, Daniel Almeida wrote:
> From: Alice Ryhl <aliceryhl@google.com>
> 
> These traits are required for drivers to embed the Clk type in their own
> data structures because driver data structures are usually required to
> be Send. See e.g. [1] for the kind of workaround that drivers currently
> need due to lacking this annotation.
> 
> Link: https://lore.kernel.org/rust-for-linux/20250812-tyr-v2-1-9e0f3dc9da95@collabora.com/ [1]
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

This tag list looks a bit weird to me. Why is there a SoB from you
before Alice's SoB? At least for the usage I'm familiar with, outside
the case of Co-developed-bys, multiple SoBs is used for recording how
the patches are routed. For example, if I have a patch that has my SoB
and I send it to you, you queue in your tree and then send out to other
maintainers for merging, in general you would put your SoB after mine in
that case. But I don't think that's case here? Alice's patch has only
her SoB:

	https://lore.kernel.org/rust-for-linux/20250904-clk-send-sync-v1-1-48d023320eb8@google.com/

What's the intention of the SoB tag here?

Otherwise the patch looks good to me. If we get the tag list resolved,
feel free to add:

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  rust/kernel/clk.rs | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
> index 1e6c8c42fb3a321951e275101848b35e1ae5c2a8..0a290202da69669d670ddad2b6762a1d5f1d912e 100644
> --- a/rust/kernel/clk.rs
> +++ b/rust/kernel/clk.rs
> @@ -129,6 +129,13 @@ mod common_clk {
>      #[repr(transparent)]
>      pub struct Clk(*mut bindings::clk);
>  
> +    // SAFETY: It is safe to call `clk_put` on another thread than where `clk_get` was called.
> +    unsafe impl Send for Clk {}
> +
> +    // SAFETY: It is safe to call any combination of the `&self` methods in parallel, as the
> +    // methods are synchronized internally.
> +    unsafe impl Sync for Clk {}
> +
>      impl Clk {
>          /// Gets [`Clk`] corresponding to a [`Device`] and a connection id.
>          ///
> 
> -- 
> 2.51.0
> 

