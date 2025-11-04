Return-Path: <linux-kernel+bounces-884904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1BBC317B2
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F75427249
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E4D32D0F4;
	Tue,  4 Nov 2025 14:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0EojjdD"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A1E329E4A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265665; cv=none; b=dyIxzq/png51DWOPNQLP6W7at/lMQ821cwm/SOm/MChE9RcXxFZBeBS6PYdHdmBwvacOet4Bdl9MZvSXm51Va/iIBISixv8f/cljJwADvPRql+5UbQ3YBcPG57hZfqgBAS+/eIvctIMpQJu3FzMJZlEpJ62EhHxqZKWmxtDknMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265665; c=relaxed/simple;
	bh=SGP8JF92L/6RhRBwWPU+X1229HHx3P2St1M5nRR/lJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kaW6OGYMIRXhLaOnwdV68TvbcVkDishsowOgBGp2PKiHGheg7PN1GeDGrvPjXNZyLesYBLa1TW/mafYKQGCJCUHgFFJqeArzqg5la6CfQKuf70+4GI8NqlVUr4iLst6GF8LiDCYd5HxCX++EB0nZP0g4qv2lBnYsecsRMGYwgMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0EojjdD; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7a432101883so606727b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 06:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762265663; x=1762870463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGP8JF92L/6RhRBwWPU+X1229HHx3P2St1M5nRR/lJ0=;
        b=Y0EojjdDxEpPAAdeCQL79Dmy99njNLdmS79Goutog4QWcxc1f0DC8XpkjrwSgvYve5
         VCLKiZf7g9P2WjR1Zvz/Ki2KVk+BpDxwYx+CILMQ3G/QuDKU5dQ7/3vJO0zah14Mu6dt
         1eVj2U1X3/IxysiDba7anRaFuspZ5EK9D1E8SBmm2dTCWdKRLuB7TpcyZ7wp0hC2B2Dq
         B9J6qBG6zOT9nD4K7br0YD283D5nKtKvb/UvCnp3VWcYL1bLcyMNVBa/GLN4sRgNUP6w
         7psSqmv6E1fwzeItWE67DMAMgxttQJO/GAsTXtpwmDjCu47cgiYek3n5SRLVUWDxJ1Wi
         hMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762265663; x=1762870463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGP8JF92L/6RhRBwWPU+X1229HHx3P2St1M5nRR/lJ0=;
        b=UY7LUXAkU50KjGGq6BiuKcYkHjiS/QKS6ib8DcWuA7AkQEIGMVP8PMnupCTTOavoTR
         Z2IoiGmydnVd047MpjBFRaCABj55kEdUBBzbTr8gwvvFVrlm/xnG3VERvZZLY9aMSkYX
         zYu1apsx+aqymUUdnm1eIIp/YDRxcv0Eje66Tst+ER3hjzZCOIPWDWOpUxd7hLqUHssA
         Tno3PyIHDLpc2+Fij/1Arh62BVisGxwXwmwidv5JM8B9Rv0MZlNUUFrVqWkA0KoeK17z
         n7dwng82Kd4qsjDGu6QWWhaxyEdGQ2bA1NOya27wkm8zMwDqWSE8vk1SgPBK8SXNaa4e
         dQ/w==
X-Forwarded-Encrypted: i=1; AJvYcCWGDhEkQS2IXloR2iLB/EJ9/j2x8Oe6CiyR/z/nnrYV6w+H93xObGNGYgHMQVDp1n88Wc1wxti+YccxmO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAOSjpkFb6fGbrAgeNLPleiyISUtRG6D35lzfJrnqx3IuulIxg
	V54EBS+6DsluT/RUAR3RVA3MzvEj3RgoAeJcyEYhuO51UEqMCZqSNgA37DjyRY+zZj5DivkE+le
	g3CaOTapiFVXRyBVsAWF+EYNXo3gncQ0=
X-Gm-Gg: ASbGncsPCIDdGJiPKdMDt26DSsu21CncUWVaOQxccTEF2uRwOQV0Zn6s31mcB+nKq0U
	kPm229OAxG//F10MMYKWv+T/npyWuMfMdyzc6YObYOa+gtHyISFe5q0iAr+0RIVsvaV+GcvYywM
	R+2jiIG5gxyWf5hO9YX2cP2l0CHJJDjK1TQUsLmonlbQatSWeXi9QITXSkEewZpzuk0ywfUd4sL
	lmEI94WjEpQllKt/5x55lFLEIdsEZVY39K1AXzA61ti9fTDn97Qn1rwWYVmXKlMn0OmOjeSwX0R
	fJL9viq/7JSXzxs/OIiOrqAYkZBzWXwjCSuS171XjXnTto20kw9AVGKtTW+pkBv4i1UUCo21/jp
	/14GRhjFuu+mjKQ==
X-Google-Smtp-Source: AGHT+IENtmho833wN6Y44k3ZoLlyo6il7Q9SnD9Us1MRf94Lyv+kyTvd1By7QWzNerf9flzY0EtIawjmGFkh/4m0d0Q=
X-Received: by 2002:a05:6a20:c89b:b0:342:41fd:38d5 with SMTP id
 adf61e73a8af0-348cdb00a48mr11418895637.7.1762265662997; Tue, 04 Nov 2025
 06:14:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <df3a68334760b2b254219a69426982bf858dee39.1762221537.git.chenmiao@openatom.club>
In-Reply-To: <df3a68334760b2b254219a69426982bf858dee39.1762221537.git.chenmiao@openatom.club>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 4 Nov 2025 15:14:09 +0100
X-Gm-Features: AWmQ_blFZtrhuRadtbS8ZQwPdHW79l05pO_B3UA9ukD7F5PYPPp4Mnzv6n9S5i8
Message-ID: <CANiq72=WZJ5=UACpFLWCVJ7mcXbc93X9MyYAZP8-0F==2b0adw@mail.gmail.com>
Subject: Re: [PATCH] rust: kernel: Support more jump_label api
To: chenmiao <chenmiao@openatom.club>
Cc: ojeda@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, "Steven Rostedt (Google)" <rostedt@goodmis.org>, 
	"open list:RUST" <rust-for-linux@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi chenmiao,

A few procedural bits below for future versions/patches...

On Tue, Nov 4, 2025 at 3:04=E2=80=AFAM chenmiao <chenmiao@openatom.club> wr=
ote:
>
> If finding the offset from the primitive type is necessary for this
> implementation, I will abandon this change.

In general, this should not be part of the commit message, but go
below the `---` line.

And if the commit is not ready, typically it should be marked as RFC.

> Additionally, support for the `static_branch_enable/disable` APIs has bee=
n
> introduced.

Please split different changes in different patches if possible.

> Signed-off-by: chenmiao <chenmiao@openatom.club>

In another email you used Chen Miao in the From -- in general, please
note that the SoB is supposed to have the "full name" ("known
identity") as you would normally write it. I mention this since
sometimes people use the local part of the email address, i.e. `...@`,
but that is usually not the normal spelling of a full name. Of course,
please ignore this if it is correct already.

Thanks!

Cheers,
Miguel

