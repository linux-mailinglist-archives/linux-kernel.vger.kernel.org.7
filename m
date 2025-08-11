Return-Path: <linux-kernel+bounces-761698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66506B1FD7F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 03:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CBEF174DF9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 01:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F27E1A23A6;
	Mon, 11 Aug 2025 01:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvraiM4V"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515E5199223;
	Mon, 11 Aug 2025 01:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754875482; cv=none; b=dpRGfNU5nQaVNc2v6ASdNv0HLt2+Mc54MQSl24uoJO7a0XHRMV8BpNZOO7a/XU8beuKZ2Zp78aGyL2MOEaBx8Sukzo1DmqTZCOMiUDgrOzCIDOLyJfkpKx91i5kSJJQdc+vGInpT70afthlVSkGoS/eb17Eba7FHsAMe7MPzY/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754875482; c=relaxed/simple;
	bh=WtJuf/zMFqqZZzz+K4qh4sniOy2RRzXQmyzrX7GYhOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXwlqaHOtRRgTpiI8nEMtxv/kXVChtTs/HeMXLiz7LLSgg0LxeTlzN8sQzQbhNSxvZSkq6TXe9hPV0RnhYFStu6d5sRewvtETPDlOLY+S1apx3SeRPt0gPuD+SS40Jv7gVeIgvAIasFnXQ8qrBpD1gQhu0s4ZbrKAKQ21vQHH68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvraiM4V; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-70736b2ea12so20052316d6.1;
        Sun, 10 Aug 2025 18:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754875480; x=1755480280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dA3TMw5sp4v1L/ktOGoFRCSG11wCWiMXJf64flXffa4=;
        b=QvraiM4VEGSNkXyi//ezPMKXymmrC1VZLwzKcNHQKAui2urPEQwBJBQO8KrHrBxrOc
         H8TUx8nMvvW0I6DUhL+ZIlX/0KHRK8alWkfjRicfKF4EaAJe08WbcWkR9JXn2AYOI8vy
         +/A3TBnKT8gPG+rcHz3or52B5ZW4/QC0TZKKIkoIps+lVjHZoXcSkAe5nlCua+fxptV6
         kAQIayNhZISGG2ASSv6SlcRcqjnO+U9BCRPpFQ4Ez3cf1GuuXOaoZmwMGZm4DJ7XOD01
         LtTmSeDCWrEmFK9J9ibWAyC+xi0Et/8aBLx0BckpLAeky4j7KTBlSf2s949XZu2e9Zbh
         HQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754875480; x=1755480280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dA3TMw5sp4v1L/ktOGoFRCSG11wCWiMXJf64flXffa4=;
        b=lAqP/GXDzk3x35uqgapn/Bhc8MI5tUCC+jZdxrgxSi/l01ac2Q4UPJYx1tp/u818dl
         PPpJb2INpkuRDswSoBGeOytIcAo+wbbk4SQtIxSyEEd+lp7nojkMmBcEY8BIZkx+HgWM
         y/8uzjulRsvpYINcnamHyZ4U1/H+jlrC3vbwCnWIPIefmGGd6m2JJ8sJTFUrP6N1H8W7
         CYRhOtZl1NWZgTZsa23eXecdFZV62EGDMDdySR3WcBzNZS4B4FsK9fhCG3THmFY9DaRs
         zdRBjHAMfcWD0ZeWefoG13o3fwPIrCJy67rFY9dndQuGZkaZCo4V2YKNh7FPWmapb2vg
         Y+4Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6CNxP5oyFd/sG6IZRVJZ2Ic1w7J8J5I7Nka2IwtaqJv0DwFFarIteOTwpOSNyvFKxgQVlGuoGlFCle28=@vger.kernel.org, AJvYcCXTNJbkQfU+JSty47YIqEheiRJDSZcF8riLReSRNuTa0KCS+bugD+Mq4sCLxs1lro1PqXvhFsBrTaYlSFPPN0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YykpYisQCXbbCtXt9UfZ1qIEUoGNS5G8j81nJtBtiK+u0YQ4J8B
	iA3JnNBRXO7YTjiSfC5Qu90kzKMv0nl1u8DBLKhiHMntBAtsNwM6lMu3
X-Gm-Gg: ASbGncvFI34VR2fPKwjo4lzhmSWOIlugi+tgcp4fbS4kaVXDVfB6zbuTgivGcdGEmwE
	GzwwefcEXZH/QO/jie9wCCQZdM+/IAnqjcPNL59d6qjxOuDJfLLtQBpyFoQ7d+C/51VrdlrUsau
	IkyOMTnkv66ocRvRC7njDB0cBiRQulgnKQxWEDYBjdooVgO40F0gL5dAZyCfOXwBsTnX0ye126/
	AQg/a1I9wXDN1THhyJVAFB8oB3zdov3Bq6G51Hgs7uzunuvEU/T8WrxQUw+5kYhqqBK2E8LyMmk
	1aaWD5yZfifiu9S2b2kmOYGL1MMtToWc6Am7p6GjS7ytz+f5N0TeYbNFPtSF3XDSh3txojjdTL/
	/JHLb+HkEvL0xfxGpQ6Kll2+tZtFymT/McsXcvXLwPLsY/QzvcYK8MJIit3m1KIwlpSdsXadJfD
	/4UwowZsoKLkEbCNO44neyz5bsu7TpkAjRJw==
X-Google-Smtp-Source: AGHT+IHLTGqZsJZ6sW5t4IoHAGpadkfnmoEdge4NW0DcDiLplipYaqU7kjzQt0oSY3FeTScoG7qH5g==
X-Received: by 2002:a05:6214:21ef:b0:709:205a:d90c with SMTP id 6a1803df08f44-7099a27ee53mr164596796d6.3.1754875480141;
        Sun, 10 Aug 2025 18:24:40 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7097e906c3csm68183516d6.65.2025.08.10.18.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 18:24:39 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 11118F40066;
	Sun, 10 Aug 2025 21:24:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 10 Aug 2025 21:24:39 -0400
X-ME-Sender: <xms:VkaZaP4hRE5GxA1LCyiN7an7_5Wrh7JkWVPgl8Wv5EUhBrUksmUtgg>
    <xme:VkaZaLXOfi1zu1XKZXWOtxUvg4jTp-4Rtu_yr4VAMk4wbx8kol9z78Lm6Z-c8C0N7
    YGEMvjfFL8sZ5yttw>
X-ME-Received: <xmr:VkaZaD9Vn5sO-QxWpcVZjbqM8aKzQvhcxRJ5WWkU-dZFmYAQUtZlxzK8ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeduudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpefftdeihfeigedtvdeuueffieetvedtgeejuefhhffgudfgfeeggfeftdeigeeh
    vdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthho
    pedvuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhithhvihhkfhhoshhsse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggv
    pdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoh
    epohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhho
    rhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvth
    dprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgt
    phhtthhopehlohhsshhinheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprgdrhhhinh
    gusghorhhgsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:VkaZaIjzOyAwiG3tTyGVt0pYqosrTjK-0YEJb1Aqv7lviLa-09pWlQ>
    <xmx:VkaZaCWShKUwvRNUhRx0O2TC3_LeKQIbG6c2Ul75GIy8qFr0ciPuaQ>
    <xmx:VkaZaEt8CgBI79C4U0AMRKPDr8VjrtHGkMA-GjVQ9SoeKobF5yXBaw>
    <xmx:VkaZaL_1AbpyBTQIW1uNicSsKw3YMKJAEQDQ4vd-CBMt-5c5T23n5g>
    <xmx:V0aZaMvZ2GnG_IF2gfMwW1LiWmbKbnN7RJM0Mo68hLhfUgIc4LZkRjax>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Aug 2025 21:24:38 -0400 (EDT)
Date: Sun, 10 Aug 2025 18:24:37 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Ritvik Gupta <ritvikfoss@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] rust: kernel: cpu: mark `CpuId::current()` inline
Message-ID: <aJlGVfdwVXp6Cmcw@Mac.home>
References: <20250811012000.444173-1-ritvikfoss@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811012000.444173-1-ritvikfoss@gmail.com>

On Mon, Aug 11, 2025 at 06:49:58AM +0530, Ritvik Gupta wrote:
> When building the kernel using llvm-20.1.7-rust-1.89.0-x86_64,
> this symbol is generated:
> 
> $ llvm-nm --demangle vmlinux | grep CpuId
> ffffffff84c77450 T <kernel::cpu::CpuId>::current
> 
> However, this Rust symbol is a trivial wrapper around
> `raw_smp_processor_id` function. It doesn't make sense
> to go through a trivial wrapper for such functions,
> so mark it inline.
> 
> After applying this patch, the above command will produce no output.
> 
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Link: https://github.com/Rust-for-Linux/linux/issues/1145
> Signed-off-by: Ritvik Gupta <ritvikfoss@gmail.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  rust/kernel/cpu.rs | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/rust/kernel/cpu.rs b/rust/kernel/cpu.rs
> index 5de730c8d817..cb6c0338ef5a 100644
> --- a/rust/kernel/cpu.rs
> +++ b/rust/kernel/cpu.rs
> @@ -109,6 +109,7 @@ pub fn as_u32(&self) -> u32 {
>      /// unexpectedly due to preemption or CPU migration. It should only be
>      /// used when the context ensures that the task remains on the same CPU
>      /// or the users could use a stale (yet valid) CPU ID.
> +    #[inline]
>      pub fn current() -> Self {
>          // SAFETY: raw_smp_processor_id() always returns a valid CPU ID.
>          unsafe { Self::from_u32_unchecked(bindings::raw_smp_processor_id()) }
> 
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> -- 
> 2.50.1
> 

