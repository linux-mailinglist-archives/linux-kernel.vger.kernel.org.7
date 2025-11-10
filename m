Return-Path: <linux-kernel+bounces-893724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15540C48383
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D63D4FBB2D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357213164A8;
	Mon, 10 Nov 2025 16:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXCIop9C"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0622C2D97A6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762793345; cv=none; b=DQGbc//Rh22a6Q9RFhVmA3Dekd7xiy92csDMgnujVsvyp0QSi6aUQM8NUpHSn6k6AopcPwx6daLf97XH/Nxqtzc0HEd1CgLMDol2IXE+tSntOb23KkOHLjnXgQntJTbkOhNOWZMxAZ2wv/Tx+ZvY1CuvUM+4JMFfWHTYmttxddg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762793345; c=relaxed/simple;
	bh=WCn2M9Pn98zQCwXGhIe94Mp208rWyyDEa7Ij/HDRHtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H4iGN9zjyaOwshXniDCm4B7BZTLoRCxRm/QBd/27doV6OZjsFaBgIV8bnXkKCBPcBPJmobOp8nAWidmbO0rnG2mRpIgNPeKQ+BrLLkRe1XOVsZLBpsnITtMMDpAFlCUL6fcr6ml0/ncYvYFZ0tartZb3ZNFzuQSfGzM9TZJ/cgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXCIop9C; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-297f5278e5cso4042965ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762793343; x=1763398143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCn2M9Pn98zQCwXGhIe94Mp208rWyyDEa7Ij/HDRHtE=;
        b=LXCIop9C9154lwZg3Trtm3kb7fxgwtRrx/MWfU21BhkvGi1QP8dHv3OAgCWJtm01hK
         sQzeTMCj9AAr+qxes3HBTPDDwt+FhNNRhgoZPAoUJF/KDNwqjy9azSHvI5ez49Oi5W/Q
         cRe9LcY2DZJfksaFhejhBVfAJNu57XIA8qFIn7VzWA3LWJ3Ett3CijAsRTTpzEgEMi50
         X7Ccwwxua/Wefi5U9121aYnrM9GinZ2kc4vZF6bOmH0rFAae6lb/iLvfK8iqdpkNIyYo
         NBF/v2yqn7x6o2qKP0RxJ82yYoFHS3LM1V6sEPbNEzM4Gcdw8a/BO9otQvGHsEEtTdb/
         svHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762793343; x=1763398143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WCn2M9Pn98zQCwXGhIe94Mp208rWyyDEa7Ij/HDRHtE=;
        b=nJuRburTt2329kPux8omJmBzFfTyoZ/Vbw98kNTgn8W6LDbPLQWopvFvnplXj5sUjY
         4Dn0NtgxkMOZr0frgj9/RPFOyNbGKrCm71ir+5Q1MRphDxZrj2WPfTrdZZQiKpHBNCLE
         CR5kAQ9NtjqZvSzIQwXLCkx5hAa6TVt6LKeJIM0MTerUfwFn9qGqYuCYM6Qu976V1mQD
         9trBtS8FjevbnEaMXrY8YP5j83Pf1H4I8aabBYMmQwahrNBrRDSir6S/64VqeCo6qU2t
         S6AfGCkeIA/gS4bLHavOw3JexNIGXM/jFAo2fU/wgkbb2BrZz9KLvQLTwDNp0zROyXDE
         mwzA==
X-Forwarded-Encrypted: i=1; AJvYcCUOQu34bmwad/I830bvi52O0E27Mpjg2FHUC3b6ZSEcNgg/SOpA3VTC+Rc9jEbwoKEA9KXlqCNFKX4prao=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVMYMcz60gKqXHNyR2y0piddEBVi/LltTrkz3HwK4o4T12JHpo
	0/uIngkohN/fMxtovnY6aUR/0GoMpfjeFfrm4pkY9YG3QaD3ChJANrcNpaoX0GUkv3NRF75lJ8e
	OfxhmsAiJ1dgQV+nuzcHaBTyN+dEsKfI=
X-Gm-Gg: ASbGncsar1hrmeZZWBNxf6i9mLay8qDlUBrBXiNFLvd7PWy3mivEOPiqc8WTq4PcVS6
	EVDYJIpnAV+ijQ9eM/vDuY06Ey39TF3PKWDrjXNKgD/ogFdC9XtIPxBYTnXo+myH4BeHyGIrlqL
	nuRQ4Qy0Nb5yKvzZVu06z+H13Ddf0HS2eLSjPTFKP0qNXfhmgjChlDe1TBqpHqWyge/MghqjX8o
	z2O73x4y9nzWcoQtn23iY7MXUCNF7M9PjqQfTrgejsetGrhBfcK6Jnn2oo82D6mdt3cynrxNQ8e
	hMC26VNCZRZeZL4ZHOz9Y4EJN0fDXrBETaU39v3PgGzmn88h8T3TUyB8yBx+thLe7ROOxo07YSw
	aQGoxTcU4SbFR2Q==
X-Google-Smtp-Source: AGHT+IH5I1+eyd6kWRNYzgBd7iVcE03A1u5jBf0zW8VtsXhcRPQLzp8sRacyFb9Hd3dmI6N+ld/TjvRphEHH4nekiBM=
X-Received: by 2002:a17:902:d506:b0:290:ad79:c617 with SMTP id
 d9443c01a7336-297e5611fd3mr70148695ad.1.1762793343249; Mon, 10 Nov 2025
 08:49:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110131913.1789896-1-ojeda@kernel.org> <aRH9Tjf0tszyQhKX@google.com>
In-Reply-To: <aRH9Tjf0tszyQhKX@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 10 Nov 2025 17:48:51 +0100
X-Gm-Features: AWmQ_bnW52r8h-0gmyLN7ivgaSD0gXN5MS8PTRXx5xySmJt3bBV43-xYwc4HHKc
Message-ID: <CANiq72m4K+UZxodnKqdx3cowbYB+Mj_Z0gB63j=3jE+E-x+3UA@mail.gmail.com>
Subject: Re: [PATCH v2] gendwarfksyms: Skip files with no exports
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	Haiyue Wang <haiyuewa@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 3:57=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> Is gendwarfksyms actually present in 6.12 upstream? I know we have it in
> Android's 6.12 branch, but I thought we backported for Android only.

No, you are right, this is just me being overeager. It should be:

Cc: stable@vger.kernel.org # Needed in 6.17.y.

It would only be needed in 6.12.y if someone actually backports the
feature (which does rarely happen, so I guess someone could have found
it useful since there is no Fixes tag, but hopefully people would grep
the log in that case...).

Thanks!

Cheers,
Miguel

