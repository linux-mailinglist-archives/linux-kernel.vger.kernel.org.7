Return-Path: <linux-kernel+bounces-799261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA145B4291D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 378061BC39F4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682E536935C;
	Wed,  3 Sep 2025 18:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvSWly0b"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F07369335;
	Wed,  3 Sep 2025 18:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925553; cv=none; b=WV4/k8GKRH+t4f4F26WaSym3DisOKpHg+h6kdfpufD3ZY8i3UYWusUwlTMpBqkK2AjUQr2xT23r6U+rwWEEjU4REZU2+USKb9QuZqGYjNaW58+bMHrIx5SgRWp3C6gDoOX5yBMVvZ9M1eQZZSoZtwTK31lyxoT6HntrqDwntpSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925553; c=relaxed/simple;
	bh=QoyR4EnvaPr9AJ4HMnshwJMICtlb9NfPqy1KwMaSd54=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mN6y2/UYC5/xTEl+BmoYcUb7Ukdmd9uritUxgQPfcf1O8Ha3vDK4vGm0Nga+FZiL3IZtIZtXMmVww5UfGwLrMZX8qtJ3/JeDDaXeM1Xxk2NVCvf706jF7lwAYtomTtfyELVNfG+k3mjOJeuwNPDFU5Kq6JByYrh4ir143s7HPKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvSWly0b; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e9d5e41c670so318013276.0;
        Wed, 03 Sep 2025 11:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756925551; x=1757530351; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R45Z6oHkqk9vLqGO1gKSQohHaDkoJML+nxrSOmhsoQo=;
        b=JvSWly0bEyBBW9gJcF7Ek30sHmmKUNqLo69Dv7JRbo/UJPCKsZ+T/yR9d702Vea3xx
         quVW0ClqqemKNgua4duYl90kwPKQuJqh5OCXdBzYANSAxT8EQum4ckQz10rrAsDo761U
         cuXHsiON7/PaRMrouegXcOhuFHZZAtQedPeGRTHSNXAoH9gfwwdhrtNh9ke/9Orgwuhm
         ITlzDQdzKrZiV+IiohApjSwC1okaR1Q6jVrZTkMcsaC6ZLQfwSFKPJIi4f2F8dJ3lrvL
         6DSvosnV94Gpd1XjaCZVmbtQNgV8IPD3e7QnAYaF2TabLGwtUEiLBLhSVtCEERrat4bx
         GCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756925551; x=1757530351;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R45Z6oHkqk9vLqGO1gKSQohHaDkoJML+nxrSOmhsoQo=;
        b=Qy/omqxGk9QoGCQt6ZE68rUaYCKk46mYDb2qdfEQYktjoE/zOHbUx9NFM6pLTk1MrQ
         F3cZSZU45YvMBoa/D6I+zoikvbdFhanKUvXfNtpE47UoseHJL+EVzZW1Fl7U5aWIqQW8
         LhIfp29Buc0N0OEgnZzpaMpXnCJYtxYQGt+zEMng69ATmTN1kGAiftPo2Ceij4MDUahF
         uhwFO1yjC89HiNAnfapjwFrl8VvI8CaNIQck0hOSE5X5pFxnKuIkpTaP/wZNMCZE3p9j
         WNJXWjDCgDB6zyCeHzCkYb4u+XmsjZwEPydf6KKOi5Ng+/i7OcjdwFbseFWLztciRugx
         3R3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWO94KDZDtAvy5i3MVP4LdrgQtkT0K+DWCZnuwczojD4kCVsxWnn2nh22tluHT2nZ8a3KYAELSPd0pdpiQacx4=@vger.kernel.org, AJvYcCWaMbgGTvi8xNhd/FfXwIWvYHXNhAIdaUXPOnCb7PuvSeTKx6bOdGwqiCiCGtpjHqvkB6lYIM4uyPPcyOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ6IKGL1jMHntxw2Q5cC7gMypAp0krVx1Z74bn5spe5JVIu9HI
	gE01VgbcVjxGW157u80hQCmn0wxxymdDo2AdQkWonGiPFThwb1yN0vVR
X-Gm-Gg: ASbGncvEvMTGouZTQJPxIsMQFqFjkzLoBa1Rws3432nSbs14fR5rW9sXfBo+FcCnoxn
	Br9eTv40tejl52DRsQItvuO5vaSeHXtx1ENpdUYn9rLSKPRDuVCZ9+0jZZCeUiljscPuLYPpajn
	xNAHtaCCug7UvdMtmPWuVTEVKO54X4MZXG7aB8q3ONhSWQMJ3fu6u5xFcKO1Wx4DiwuDZ0TTbbw
	KHhxH0hz+YU3y9M5x2t44StVcO9/MUvk7lNvY9QmGjfTPTm8KzwY59S02hWr8UEp11/E24Yygny
	o3IdOj1ZAwxbRQAOrZj23ruWihevgNphXPkIqc3TSrTOfWF+8jXeYMEmE0qjxpDo21feO1f621R
	dPVgEnfOs04hpa6oXzezwqHkpu9o4ipP3ZWjO5OwfaGNjtdrlgSwkfBJ2zOfWZdofvG1eztNpbQ
	==
X-Google-Smtp-Source: AGHT+IGGJ3lccUdFjxKgtxsg6hLk40u6IHOHPrfODmWKQdLrprwqhBbQ6G7wrrbEZrD2Pm6WCLN69w==
X-Received: by 2002:a25:ba88:0:b0:e93:2d7c:96f2 with SMTP id 3f1490d57ef6-e98a5827ccbmr15628917276.24.1756925550645;
        Wed, 03 Sep 2025 11:52:30 -0700 (PDT)
Received: from [192.168.1.209] (74.211.99.176.16clouds.com. [74.211.99.176])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9bbe05debbsm1669701276.21.2025.09.03.11.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 11:52:30 -0700 (PDT)
From: Asuna <spriteovo@gmail.com>
X-Google-Original-From: Asuna <SpriteOvO@gmail.com>
Message-ID: <9de3673c-3b1c-4838-a5fe-e8877a1c3ace@gmail.com>
Date: Thu, 4 Sep 2025 02:52:24 +0800
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

(I apologize if anyone gets this email twice, the first time I 
mistakenly sent it as HTML and it was rejected by mailing lists)

> Similarly, something like -Wno-unterminated-string-initialization could
> cause a problem if gcc supports it but not libclang.
And the -Wno-unterminated-string-initialization is not supposed to be a 
problem either, today I noticed that in rust/Makefile there is:

    # All warnings are inhibited since GCC builds are very experimental,
    # many GCC warnings are not supported by Clang, they may only appear in
    # some configurations, with new GCC versions, etc.
    bindgen_extra_c_flags = -w --target=$(BINDGEN_TARGET)

The -w flag inhibits all warnings, even though Clang may not recognize 
it. I was not able to reproduce any errors related to this.

I have a patch ready and will send it later. Please let me know if I'm 
missing something there. Thanks.

