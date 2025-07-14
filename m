Return-Path: <linux-kernel+bounces-730824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E33B04A69
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 00:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4EB3B7FFB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 22:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF66279910;
	Mon, 14 Jul 2025 22:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1h3Sh9L"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCCA279785;
	Mon, 14 Jul 2025 22:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752531383; cv=none; b=fQ4JAbIYA6+gv7XwvI3PDRQ29vqdEF1ax7tQi6gOgkoH3GMfgqTYV/4IvfTv1RxHGW3UGWWh7hIhKXtQi2GY8KB2nq2o0sCQoajtLVnN3MveBWiSO+0vPQRYSJDCYPRAWMsq3oIhKUra46k+eo/UzKDxweKdO122n5pTReQrCNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752531383; c=relaxed/simple;
	bh=BX4aGpk7bRSOXa+qX2TZabthJLnJIj5XYr/A5yliKDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jQVOiXPHChNnRTuunu1Z4kXbR8fTTN6bUTX+vbj14birrTPxbm3QU/n1H/aHXkoA/H7W1d1dyw+iYUpt18qv9o+QuAttFiMlNAz3ndGUluLhk16OOwuqaMca2qYcYFvTGtEQk3ilspZg0LGuS0ltXBikBi1nO2d8qn/a+SJYaSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1h3Sh9L; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5331fdc1cf4so193420e0c.0;
        Mon, 14 Jul 2025 15:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752531380; x=1753136180; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lD/9nxeI2AaJ6HCAD6gBRlNwjsIBFd+9JJLqM10a/7w=;
        b=R1h3Sh9Llp29LKDZ9fxboU/74J2mYYmZSkV4pUq9lCPWtOyz3OYHxrPvtz+5WlZQdr
         Thbb0IERFRP1VNcLoIvs8v7ue+VTjaFD4LOqiiaGJiAk3gxS2Dx/j3wZE00ga6ytsdFb
         u3dLCqh+3+OOALajm4pXnB/rIWfG0nB1tjPTzjtILtyW4BbWdGVwWxBi83EQMwePV9Nd
         qJRcQSCpoe8f/azD9TFakgragoJoJtUIh+lPjIt6gMofwG3bHB6MBIp0xAwgy2VJA29O
         XBxkw8qtkVcJYxy+GBEKfQZ2MujIpvQFiUukhnj27Mms8lQCzz6tKaMNYI3Odiyy2Gd1
         BraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752531380; x=1753136180;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lD/9nxeI2AaJ6HCAD6gBRlNwjsIBFd+9JJLqM10a/7w=;
        b=Tb3OkdSrfi+quLv+vYMbhwcIyy8m8OomZmGYG6bKEI5xXtzZGERxNnToZI6kYUdy1b
         NZCtWHDSiVcpj5G2uUHH5eEtXO/upYEklQQms2xjanXNNlg3w6PMO3PClkyaoIisguKH
         yvXMIpTYereDoOFFKilXdQqzeL0KF/Ovqb06BhKTE8l5bugonwVNiOy5JRkDwVgPo41Z
         Nq3ZvdXKA6H7C5RlqM3l8Zy6R1oRfIDgF+5W4w9A0qKsKDWabQZEDsLDT7/wBKlw2zE5
         Ghu6f/jdHvIObdXyENPM/fu06pvLRa63njJ32TV4ZTrHD25R7LM0EyplgPS0wMlhWEoe
         4y6A==
X-Forwarded-Encrypted: i=1; AJvYcCWZ3vKgDhGsK96yRR8XsptjB3kitKdS7Xv+xGrgzHAX/spZtwXUSpzS839xf6PNOI7aGvkNXQAdjL/wOLE=@vger.kernel.org, AJvYcCXQDRyfwu6NH5FSY1+yvveOUcxOAxHDxNO4lKRPgj5ArvTsBijFbC73GwTV1y87qZex18NV4TA//1ZPdTlc7ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFbkpClQqu5GciehqOMp9ggrpp8ymWsUE5nD0adtgbzOnAdRAA
	zC9FrC07PqPa3QGhsBkb6+oNRthwublI03343MkJpNclahtn6P94finIz7X530+ucA3aRrhw4gO
	wxbrE0/Kf+i8ZfopDCqug7AMHvxhvnBI=
X-Gm-Gg: ASbGnctMGFKH2pdHxG38Tg13FH5mKUKmqeMl7yKqi3/nA3n9jDrT9JZGw//BO1P5WQp
	ANxl6fTd/sLt/I7uuYUziT50MYJpTlCELE9SPyaG2spKj0ICoUwLdkbU+G9iRjOxWsyFr4P7Enw
	ZsRlrBK3K3goQezF4Bl6GxzHqyUeYl4JQ7G9gmOAg9mcNZLLu7TkVLfA24Y/pLpoRI1YxQdsYii
	JavLL6vNwV2/PK38bg=
X-Google-Smtp-Source: AGHT+IEtegaV1kM6/2eLKcpj3YnxCpPwYOriAmnOSwvuuGJD0qRyytN8YsAqk2zDujqqqWicoDY8XH9Zq54w9g3oz7Q=
X-Received: by 2002:a05:6102:d93:b0:4df:4ef8:8624 with SMTP id
 ada2fe7eead31-4f684178557mr2417289137.7.1752531380313; Mon, 14 Jul 2025
 15:16:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624042802.105623-1-christiansantoslima21@gmail.com> <DB5KEWX9EJ2Q.3CX5EGS66OVHH@nvidia.com>
In-Reply-To: <DB5KEWX9EJ2Q.3CX5EGS66OVHH@nvidia.com>
From: Christian <christiansantoslima21@gmail.com>
Date: Mon, 14 Jul 2025 19:16:08 -0300
X-Gm-Features: Ac12FXx35yH4yjasif5jRv2fvp6Y53qbDwQRjQeWgKsIPTvdXuP3ZJDxbt3EzHU
Message-ID: <CABm2a9cfK+HuidwQwcD0Cs_n+dvd9Y71tFn=grz1ahGpbPpurA@mail.gmail.com>
Subject: Re: [PATCH v8] rust: transmute: Add methods for FromBytes trait
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ~lkcamp/patches@lists.sr.ht, 
	richard120310@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi, Alexandre. No problem, take your time.

> Let's elaborate on when it is "possible", i.e. the reference is properly
> aligned, and the size of the slice is equal to that of `T`. Let's also
> clarify that `None` is returned in other cases.

I see, thanks for a better explanation, I'll include it in the next patch.

> > +    fn from_mut_bytes(bytes: &mut [u8]) -> Option<&mut Self>
>
> `from_bytes_mut` sounds like a more idiomatic name for this method.

It is done this way to match the zero copy API. [1]

> > +    where
> > +        Self: AsBytes;
> > +}
>
> Note that `samples/rust/rust_dma.rs` will fail to compile due to this
> change - you must make it derive `FromBytesSized` instead. There may be
> other implementors of `FromBytes` so please make sure to track and
> update them to avoid breaking the build.

In this case, if we don't include `AsBytes` the user can add padding
bytes in the slice. [2]

> nova-next also adds new implementations of `FromBytes`, and since they
> are not in mainline yet this will make it harder to adapt them... I see
> two possible solutions if we want this for the next cycle:
>
> - Take this patch into nova-next and update `FromBytes` implementations
>   in lockstep,
> - Add temporary default implementations for `from_bytes` and
>   `from_mut_bytes` that simply return `None` so current implementors
>   keep building.

I think the first option is better considering the current state.

> I don't think this implementation takes care of arrays?

Arrays are sized types implemented in `FromBytesSized`, I believe in
this case arrays are implemented too.

[1] https://lore.kernel.org/rust-for-linux/CAGSQo03teSsTa84Mx=4SFRAfa2=irBwgXXoh5eB_Q0RoixrF6Q@mail.gmail.com/
[2] https://lore.kernel.org/rust-for-linux/D8FXFGYZTEXT.24UM4V3HZ5MWH@proton.me/

Thanks,
Christian

