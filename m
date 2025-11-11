Return-Path: <linux-kernel+bounces-895556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C94EC4E46F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4876E3AF032
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C06333ADB3;
	Tue, 11 Nov 2025 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZsUgUUo"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835A33570B0
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869542; cv=none; b=ulpj4tekzNL7VY5eNBVurHWE+E6VaecRbnOGDHs80RO3b1M7DD8jb3zIQ0/rf2PRVuTMjODN0wMQU4UF2xIlS3OoHsiwQ48fD6GcH/IQa3DExVzG4w8044xyWsdneuzMmK96A0ujISaCsznY4YLBzbyYz/u+O25OIVGOptCDa1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869542; c=relaxed/simple;
	bh=hRUmzVbCzzL89fOTZQBAaUfGAwTMnx1MK/93dcHh+is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfA7CG8ijWuDP4Hv9GZLVzFm6I+F7DuIIeYpHl5Mbv28qm1jFFHiobVWzFgDFThbCcDb7Wl54C/IrizlMEVOqVBlOwt9tE4YYTUqyT+i4EKo3jNhfDrMfWSAQxZFpHxszYeHy1enIIo72Lpl41vxiTVnIUDz0QX4Z2SAKOntZUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZsUgUUo; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-29800ac4ef3so4076225ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 05:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762869540; x=1763474340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRUmzVbCzzL89fOTZQBAaUfGAwTMnx1MK/93dcHh+is=;
        b=YZsUgUUoLezCFU0P/y4ACxySgN2oXPKkH5rAUf5K/Knu+yjMKYIEAtI7YWLE1CRREH
         G4CuuxoaTEockrL6hXAlWf0lY4nQRzzL80T1q7fmEJSsVau+53U9PGuFNWSL/5ALXvZ9
         gY4Gy8aWTsH+WCrDPGfy3++IOkelaCvSmWKF5ReNu5O7A3o5fX0ZZx4+cq0XO63GN9qd
         bYV9JSbp9+UvllV9KKNUO+tyGt51I3QqMtssFeRcwbmHn5h+RNSgJkV/O2Rnzmtfj4zK
         CVY9Huk2VfkwFwl9kJtqYxHo8j5N51q9r4sCHWCJUmcuSGkPkMEVb2wS/9+OgyV+2kBx
         vg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762869540; x=1763474340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hRUmzVbCzzL89fOTZQBAaUfGAwTMnx1MK/93dcHh+is=;
        b=G9gLElmEwU4exb/fqTwf/qW0k9Yjq63mdQ/cOFW36dn6qpVPnamYFieDsYYliHQVww
         xqpZcLCSA8s7uwdOZPZfU15mJT4QO86fo3R+sA7Ju9EUM0EtuCo5/8hqQXiQiI3xGTAy
         l9PKAOcDqg3F86NOmqYYnhHDTCwDMO52QLMvDgw1667T/wZWAU+xKHanudLSUgeZebGH
         HFjbYBdUnOPbxtzAhwsrB2eOLktPN7Xc2q3CKY83FUf8l6Fl0+2zTjbzXMm/9Ye4XuqT
         6qmOxMUrOs6hyoN+6fntXUCp4H1JgvTsCU684s0ak6czHc/2TYCJFGnrlECwNhdktG4j
         eAgg==
X-Forwarded-Encrypted: i=1; AJvYcCUuUFAlfc8f3Z07Y0zXh5gzP3B+stO4OWXKGAvL6sbHBnSiD440QbQRg0A6ho0iW9mdHPIKaFtjQCV0IDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdbaq9vVp0z3HtkqZH9zqeWtK7aPcwMV8eqeliNGkNMznl+ngD
	dmBQbpkzxbgkicBUQhnX8Nx6juby7793XrjEzrAM+XEBPntSXCxrYzcbzCUt1W1/oG12k5zCwCO
	txUVDHKOOLFHV6u1rdcjKC/ian4UuYBE=
X-Gm-Gg: ASbGncva6NvFoZAwMcXWsqE62QGgCT24yVGQXsi5axxwtg5Ro1TeqzSyDfINEjFQU+q
	wECegAhVF5n6C0G5lOvyZ/2pUX0lbZqpBcA75myqXw22dBh1+ok9Nwm34yeB7IS8wTtu5MUMcBF
	3aVDVMHbQpRL0zTqWKHPPaEg7LrWTpDpqvAixYdyiHLk6enZYYsR4azWCpir6FN8DXmzJbir8+f
	lPabsjUSBe6zDQ+0sv3naPlCdBz3D479+nQ21hhcD8RCFcaMZeTJnbLo3EE8w/ydrUGNDVTVi9p
	oHdSrEPwdTYNS608z3XJeXaq9GgkjssIhfrr8iGNuysyG7FQm/6ATpL45DxX8EqFuahknuIms/S
	T9Li0cdK9dsOvtQ==
X-Google-Smtp-Source: AGHT+IHYXxM/I5GaOybb6g1yecFYohV3zCOa1VEm8f2yGvBo9rJ8osfE6aj7FDf3tvSiEZ9Z9+sidUs9ZqMaIBw6rqE=
X-Received: by 2002:a17:902:d48f:b0:295:54cd:d2e2 with SMTP id
 d9443c01a7336-297e4d096a4mr91553105ad.0.1762869539841; Tue, 11 Nov 2025
 05:58:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110131913.1789896-1-ojeda@kernel.org> <CANiq72mjFobjfQEtNvk9aA+757RkLpcfmCCEJAH69ZYsr67GdA@mail.gmail.com>
In-Reply-To: <CANiq72mjFobjfQEtNvk9aA+757RkLpcfmCCEJAH69ZYsr67GdA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 11 Nov 2025 14:58:47 +0100
X-Gm-Features: AWmQ_bmjChoTwnLfQhUmk8zTDZP6XuF3N7zYh0KKb3TDMGl3YRN3n87n4dAkPXU
Message-ID: <CANiq72kaoYYMq+ghFsa+YrRbTE13M2TrtOMwAK1eV1Sk9tEQzg@mail.gmail.com>
Subject: Re: [PATCH v2] gendwarfksyms: Skip files with no exports
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	Haiyue Wang <haiyuewa@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 2:54=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> I will send a couple other fixes to Linus this week, so if nobody
> shouts, I will be picking this one.

Of course, if someone else (thanks Haiyue!) wants to give tag or two,
I can still pick those up, and that would be very welcome.

Cheers,
Miguel

