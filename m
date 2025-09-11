Return-Path: <linux-kernel+bounces-811346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA63DB527D0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 06:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8F6686951
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 04:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F6C23B63B;
	Thu, 11 Sep 2025 04:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVUvX8H9"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232344503B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757565973; cv=none; b=Rng17x313E06Wq3erstzC4SI+gk+6blHKP+dTpC2j5f1jETqhcEs9rPQW/VHcP2aIa/Z6UKopa3OsI00z2lFfhQVGydAMSvDbiqUECP4XGw7HRnBLO8e13IrqKfPwKEVFXdKEVNEaaZIHLvl7PG2YHkODAmIgCndX2RJz/85xwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757565973; c=relaxed/simple;
	bh=ZYQmQVPBF8zKRLNJ+D4bhiIq4DL1k5MFPT2Ve8g115I=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RfFpn6h0p3WAN0YmOj0J9tZ/jvbeU0n5LywjG8fB5mbulDXSlGRMtxA+Pt2jd+8VcLVD1Q0wdiytYG5r3yJKOX2BivMH+W2HGeOpZKH4piy2Nf7gVXLGdoWAEQaDxZA3uW6CDkapW4E0YeqWuf6UiEiFIZ3Hde4aa3xOf9DLbsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVUvX8H9; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d603cebd9so2976917b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 21:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757565971; x=1758170771; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1OFQORNmMyhF8NqnLlI7wxOYnlK/yXDebbJxZdkpHcc=;
        b=QVUvX8H99YU7pKHdlG0uydz/0HeW8qJ53/5dxsUs7PeTDkdQi08HUM3DSol7FAMrc1
         QjvuOZ6McvDLrVzHOPstBnf2dM352XnRuaM+Oya5mh/EV3Dk1/YZtXvGgYXwV8N02Ptk
         mZ+cNc/0dGHSXwQHYM2lJEzl+2IN+h1eZWaQ+jMWNhkFrIaGbtI0msA0m8G9lG+MI/os
         nFSXEZFBWMwik4LSj2G2gh9/t/T4eSZwGZrr4LtyFCPJIuPvsC3rMo0Qq3CQXrvHD+QM
         ZJ+BBPZLAw+BWzNaBAR437h889AHD/XGanoQ7YJ197Ld1WVYEF+foVEuv+qK1jj3wiXp
         gp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757565971; x=1758170771;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1OFQORNmMyhF8NqnLlI7wxOYnlK/yXDebbJxZdkpHcc=;
        b=NnQMP6bees4KL07dJIT7ZDaT2KlARnPAWkgr8FbXna/Cf5yBKwmpRJe0JVcEZxkyX4
         ZD6zlNUqNfdFG0A8tjGR5MdSW106Ko8rEByDj3zkytTAEljIh3bSDCgpT8gJIO7z8PFn
         EFB32ADvIOvMvxg4Z/8J5J5F0RGUKm8Iv0NWDi5tvdcgyXolNIW+3gJpb6I06lPnnWtl
         W6R/0WRy4LNKsKhuJLDERyCVK83LHa7nbq45TEytjS08g5JT4Wo7xsjL+zlpWhEBJR9h
         dxttGGnY1bu6Ozm/94Ry4ADWZXTxaf6TSS4zOGRMHFCO4YLCNXv49zuACviyXZLDjrDr
         lVFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtAYycYYuYa72jNsKACfZqHHsVqVGgQzV994c3sXRwD5GeZ7KWSQtkD5CZhE6LJJtYOtDhjgZnw/+l12o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcZrEv1bmBuhppbreH1B0L+3B0QPycyVfrEJofTTx2RsgC6Onz
	A6/Y/nVcTHmOtk5FFHYOSYkev8bJY1W/pNuGbVMG+aE1XcxqMD9nrV3W
X-Gm-Gg: ASbGncv6wr6MFZweOwoiHooC1lM4epSn/k25Iu+b24S0eh5aPsQ53Yb9kCjpN0A2nlm
	LBOZ2v7mZ5YCg3CbvaCzOgx1rkTnQEGg3F9dcKngB5u0Izhfp+/XqVif1Emuu+iJ9UcnMWxisFq
	Gf6t2pD3GS0nD370mA5VHJAS07j8SAZfQ5HjVSvzSwHIFn68p6t9EInsNeVPEuEeamXhrpOQmIw
	hGhnTRQ904H7qAf8QGR4/xBW6ttOY4NWW8m/MgIk96lhY06l+K2C+158I0nv6j4IAfImSG60i2M
	F73/O1cR3k5vDrTCX+l6zM0mP6ngB3rJfoU1COEDBRIAqPT3GRVgV48j8NfPNjXTv/kPGlLLfuz
	9oRinEfJajLJpJkYhv7jzR3aPK+j3m2Qi9Fw9SYmAZH26mQZrJzBQCETGZYPfKHZliAH7O+GaWg
	==
X-Google-Smtp-Source: AGHT+IE09XmvpU67NiXH7rk2LbrDMhUi3e2OWnnlWTn7trnF2NMGewy0hktXoxQgahi3Y4iKLHRnRg==
X-Received: by 2002:a05:690c:6309:b0:722:7a7f:5358 with SMTP id 00721157ae682-727f28e7503mr153782967b3.4.1757565970388;
        Wed, 10 Sep 2025 21:46:10 -0700 (PDT)
Received: from [192.168.1.209] (74.211.99.176.16clouds.com. [74.211.99.176])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f76c28400sm1130767b3.30.2025.09.10.21.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 21:46:09 -0700 (PDT)
From: Asuna <spriteovo@gmail.com>
X-Google-Original-From: Asuna <SpriteOvO@gmail.com>
Message-ID: <6bceca9d-44cd-4373-a456-7c2129b418e3@gmail.com>
Date: Thu, 11 Sep 2025 12:46:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] RISC-V: re-enable gcc + rust builds
To: Conor Dooley <conor@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Han Gao <rabenda.cn@gmail.com>, rust-for-linux@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kbuild@vger.kernel.org,
 llvm@lists.linux.dev
References: <20250909-gcc-rust-v2-v2-1-35e086b1b255@gmail.com>
 <20250910-harmless-bamboo-ebc94758fdad@spud>
Content-Language: en-US
In-Reply-To: <20250910-harmless-bamboo-ebc94758fdad@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/25 10:27 PM, Conor Dooley wrote:
> FWIW, this --- breaks git, and anything after this line (including your
> signoff) is lost when the patch is applied.

I used b4 command to prepare and send the cover letter and patch for v2, 
not sure what happened.

I see that other people's patches have a [PATCH 0/n] email as a start 
that describes their patch series, this is called a cover-letter in b4 
and git-send-email right?

> The riscv patchwork CI stuff is really unhappy with this change:
> init/Kconfig:87: syntax error
> init/Kconfig:87: invalid statement
> init/Kconfig:88: invalid statement
> init/Kconfig:89:warning: ignoring unsupported character '`'
> init/Kconfig:89:warning: ignoring unsupported character '`'
> init/Kconfig:89:warning: ignoring unsupported character '.'
> init/Kconfig:89: unknown statement "This"
>
> Is this bogus, or can rustc-bindgen-libclang-version return nothing
> under some conditions where rust is not available?
> Should this have 2 default lines like some other options in the file?

This is because rustc-bindgen-libclang-version can't find the bindgen 
and returns nothing. Sorry I forgot to mention this, it's another reason 
why I wanted to separate the script, in a separate script we can easily 
fallback to return 0 when an error is encountered.

Adding a second line `default 0` doesn't work, I'll try to fix it. BTW, 
when I fix it, if the diff isn't too large, do I need to open a v3 
patch, or simply replying to the thread just fine?

