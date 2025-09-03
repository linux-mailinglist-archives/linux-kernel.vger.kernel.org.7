Return-Path: <linux-kernel+bounces-797525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93208B41193
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 02:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F873BF216
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 00:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A961A9F88;
	Wed,  3 Sep 2025 00:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJFllUxT"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3ED198A11;
	Wed,  3 Sep 2025 00:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756861180; cv=none; b=VAqPpZ0QBkb4OCCbMwTGRPSawVF7VUDROIgcemkFDWtS/skfpVNmt+KIZSPNHgMmpcD8iyXHjT0Cfi7Ge/JYKgcgldIu7cYYchU144fBAv9gWyUQXXlGTPhE2JEcsXAsvkLNspYH6VwzbmhZx7SdX2/L6ng4qwxPcNncwebi6JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756861180; c=relaxed/simple;
	bh=xC3e9ZFLnNKv0UU6Iqr/JW7Nbmjud41nuXXb5wnvBGw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=C6qFmQliCMAR6z9u8j69m5TYJ3FV8bLtc/P6x8nvldH6lF+deEv4o2SoznBquR+dfPY245jRugmpE1z0yEeDGvDUCMyTaTR158CNJ9XUW4d48ned8hLNbkb0Iri/f8hvwIFmdGbnXScwYhvYmyPh3Bk+AOPiFnwwMTD24RMafVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJFllUxT; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e96f14a6e97so5454079276.2;
        Tue, 02 Sep 2025 17:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756861178; x=1757465978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8Y06vxPv1L9jWLGnaFGjZfi9MLlAl9lDUxU0w0jvdhE=;
        b=IJFllUxTRpgCiT7Pxmt/3YRG83X7WOTNgFcsprXmI7j0Zg+SoSi4T0TQT2GqrqLr91
         ugUP/gdoZZRkFcktfytoFkAjCs0i/iSmYps8ddsvDD2RvKZ67/UbrKSLogNqBzuJAKKr
         nqrgBfDv3oWjqdr8WooflCOZqLXQ3LqH0j6bIAGPohxTwstFPk18DY/usIl3nFVD8NFk
         l6TmUe3vp4ch/4vihXrcOG6OuMdOBhoZ9GDmkrrkic/HXzH0ABqLONtY09K7/R9U+Pwy
         ldvgt2L8wHT/EH0bO1vnhWeF/2tB6/T9gj5Xz1ZVc0v3V4B7/docY4HOnMOcyoNhWTsj
         zLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756861178; x=1757465978;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Y06vxPv1L9jWLGnaFGjZfi9MLlAl9lDUxU0w0jvdhE=;
        b=mMsmMr0o7zWl2cufMz6Ve718SOUz3DIKraRBJuVqwJoTDeelr2N0CzZOJXBcoiTQ9V
         ZfM5DP23ZSPyWGnUgz7BZAV/TQCeaAFuZ8+lg7BIokDJU6Aa2qGnKugW7sokz/3EP/Kh
         E13oeaI+Z0RhRh5C7Olf5tVFe9fW+sujzGs5R7/3GlR477z2rlqann3bzj0OzeGX0QvF
         muim8z6kGw7rnqWqccrMeR0vIfuu5S4uBeX1odG7u4gyjTqxnaqIBuEQcYk9/A5qjrAV
         lxwbvY8mVyJedKKVQT6v/TkLnwNYyj7LftJ6xYGUuwbJ8OZQR2sRG3zTENIaW2SBROwO
         oJzw==
X-Forwarded-Encrypted: i=1; AJvYcCUqxfMQKn7za6rxjRkbhaLBTbeZBVI7vZiaKDs88OAvUV3+NpsTfdCk3FxrxsdW4kRIfCCTf6rlejicVwo=@vger.kernel.org, AJvYcCXSYITMSSXCuQZJJ8jewc2xggW1Pu9157rpCUz9qBtNOOU9dT3zFBdjeJKGJMTan1+tZw+agd5ArZKis87dlXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGjMg06tYM3a01I6Xrzqqjec+sEylhUuIH/w9QvLk72F28pRK8
	pPlhyJEqcmhk7F1k6TiQRVm2S2e9qUUcxbBJDQ7VePeqLQvbUhwtFWff
X-Gm-Gg: ASbGncuDPgqSn+EJMh4rE0H9KGVQlN5Lvmqz1m2Pl2/eKvMpigPAUHJZtmBDsL6c6lV
	xSRJnIl+gwR54jNhmcuvs/7/8wavouEQmKRQym96g3cvI5zVKm876ZcYBFaYQISW4/m42U4QdGs
	oTrSq2X1auuYuA+FS+bvTpokCE0vIHbyWQBN0b9GPP0EhwN2rh2OHeY4HCpAVKsRqh4cx91acqF
	i7jfGunONNCzMumeqnLx/ZLqS2pR6Jr/GZjarLa8A5fo/Rx4qeRySu1w6z1ke0x4nqx+YU4iNx2
	Ioh/1X6VZku//wNNtoLrJLzIOTJVVYPaMhkQiLkxpgVeFQ9Z3v3O+IICqbh01l3CqPWaNza/XMC
	7+P0lWk5WjOYiiZRX7ZW8c0rl4BggquiG+B5WdmJWj7FHT1w6YNbgM9UIxjExzYOR7GWLiLW4Bw
	==
X-Google-Smtp-Source: AGHT+IEDe9TR4LaoFnfze7nZ8Z1pjnS+aIG/ZELW7ocNHanWUV2XSZY9wPTHficq3aOCAX7mED9jJQ==
X-Received: by 2002:a05:6902:2b83:b0:e96:f63c:9a1a with SMTP id 3f1490d57ef6-e98a5839e52mr14421464276.43.1756861177454;
        Tue, 02 Sep 2025 17:59:37 -0700 (PDT)
Received: from [192.168.1.209] (74.211.99.176.16clouds.com. [74.211.99.176])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9bbdf57cc0sm1043893276.13.2025.09.02.17.59.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 17:59:37 -0700 (PDT)
From: Asuna <spriteovo@gmail.com>
X-Google-Original-From: Asuna <SpriteOvO@gmail.com>
Message-ID: <e48699fb-287d-42a9-ba6c-5edad86965f4@gmail.com>
Date: Wed, 3 Sep 2025 08:59:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RISC-V: Re-enable GCC+Rust builds
To: Conor Dooley <conor@kernel.org>
Cc: Jason Montleon <jmontleo@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <68496eed-b5a4-4739-8d84-dcc428a08e20@gmail.com>
 <20250830-cheesy-prone-ee5fae406c22@spud>
 <20250901-lasso-kabob-de32b8fcede8@spud>
 <b1734c45-42ec-46c7-9d4c-2677044aacab@gmail.com>
 <20250901-unseemly-blimp-a74e3c77e780@spud>
Content-Language: en-US
In-Reply-To: <20250901-unseemly-blimp-a74e3c77e780@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> That particular one might be a problem not because of -mstack-protector-guard itself, but rather three options get added at once:
> 	$(eval KBUILD_CFLAGS += -mstack-protector-guard=tls		  \
> 				-mstack-protector-guard-reg=tp		  \
> 				-mstack-protector-guard-offset=$(shell	  \
> 			awk '{if ($$2 == "TSK_STACK_CANARY") print $$3;}' \
> 				$(objtree)/include/generated/asm-offsets.h))
> and the other ones might be responsible for the error.


I still don't understand the problem here. `bindgen_skip_c_flags` in 
`rust/Makefile` contains a pattern `-mstack-protector-guard%`, the % at 
the end enables it to match all those 3 options at the same time, and 
`filter-out` function removes them before passing to Rust bindgen's 
libclang. Am I missing something here?


> Similarly, something like -Wno-unterminated-string-initialization could cause a problem if gcc supports it but not libclang.


Yes. However, this option is only about warnings, not architecture 
related and does not affect the generated results, so simply adding it 
into `bindgen_skip_c_flags` patterns should be enough, I think.

> I think you're mostly better off catching that sort of thing in Kconfig, where possible and just make incompatible mixes invalid. What's actually incompatible is likely going to depend heavily on what options are enabled.

Sounds better, I'll go down that path.

