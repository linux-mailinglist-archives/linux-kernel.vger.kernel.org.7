Return-Path: <linux-kernel+bounces-893280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAB6C46FA5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06BE18939CE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BF73128B9;
	Mon, 10 Nov 2025 13:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VA+mM9/n"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F8F312813
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781953; cv=none; b=VpBMJn0fGZ8mpvb8dKO3tIsvJTUn/WGi83gNJE59iVchKMBDoUGoJuUIolF5CBCq0gxYNXM41BkmO5sKiAnQHIW+zb5wVpMpkFhdOEybBhV1j4rEOv7GkOclWp46PUfFziOb75rdx+61nypnqordIUs9s8D/+ky4vP2OVddXwS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781953; c=relaxed/simple;
	bh=JxxNv3zsqMj1Gs4mcPxMIFOWegAIC0ZVsqaUYW8cbJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1rIiC7xWumCUfkqI4SW2bxjowStKXgWDPqxjqMZaKKW9b89nA/ahLCup8EyOhiphpZhGfE14s7JtsLKAn39m+o9JuiNwYGGeyz43OcoCOhCzjja+iM7kGNSmObFrHzwxr9pZ+N3vjegEnwlLhxq0Sbkp3u7Q7W9HfvWATvQcDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VA+mM9/n; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b9a5f4435adso242300a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762781951; x=1763386751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxxNv3zsqMj1Gs4mcPxMIFOWegAIC0ZVsqaUYW8cbJQ=;
        b=VA+mM9/nNv7CLjjgxUpggLDb1EDI7HiIhGR3KA9rHkrX82RpM1Cs9YSYkuC74LfENg
         PmnB/mmGlAbiwlw59wlngTGJdEoVoWJXS5eGCoo2gC5EhksQHfV5+1zb59r7Gw1E53De
         trp3mx/BAuZ1UlmlsMlOfo19wzjHsjkVkCDFJqTZ3+sjPuK97GnN37n3iXfkyBim8k5i
         tVRCZuZv1OlEJY2DRKTHzokEu2kclBLLmlyYGzg6FB0F3DefJPi1LbnP/gPl4+Q6AYyA
         FoQRXhis8MhsLXLwvQ0kMbLjNkJdnV/TMQ8EqdyKsc62BLjc+z1Pm8ZtT29PBQ1qvDXm
         5hYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762781951; x=1763386751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JxxNv3zsqMj1Gs4mcPxMIFOWegAIC0ZVsqaUYW8cbJQ=;
        b=M+9GmGum7gfV1PJSEAYpJ5PB4oI/hogyYm+paETfjW6jZwjofkpi8nubNxZmj+Myiv
         IYBxFUnQ8MoSkzr1/W/vfyb63vlFIttlIb6ao+EOdpUS/L0b+t0DtAhnawd3pHnu8HAL
         3svaFLYq6PFCs4UbuMAPgbclyQ+4nJCA8DNoMDOOS893Cn28KKdPyV4Ltx7clx6U5UPo
         UuSnSAkM+3rBsxnuWq5Wm6p7U6QECirlCOyuT6h7lDzEt2/luUZaR4/IpjpbJvAztESS
         ry/1MsaD7IfI2hl4ZwYp+bYZsRYhhEwO9v108cLZuy3wv6+BZg7s0OjS5BxOS7tJyrR8
         fqDg==
X-Forwarded-Encrypted: i=1; AJvYcCX//qh+opkNOGukAuQ2mlux4jiLUwz9QApnkXjoEao06zNiKcgN3zzGklhaaFQMYWoUEdTKk3ydx/r8yJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP6y7QUyNLORTj6rfWJJcM0Que7TXRsGFeyLfh9VCy8CpFU78H
	qSuf6+0H5MwYaGYfbdOVH+D4MHo5mdhptG+KApnUMoFaQMO4H6yWypkbxU6iDEKQcjk7kMN7ov3
	g/WOIgKBFbsrvTFyO22sp7WbhyZinVYR0ohEU
X-Gm-Gg: ASbGncsXYS3Uihzi2/WPmRLY4ChhYotRf66PN/K7C97afkCL2IrEu43augipCOknJvH
	ZPTi46+jjCtFqTMwW0AKwhubT+7O4fWuIx+UMZkY3X1XRaXqRdvfPC4YKch/NhUqbZvJwDTytSh
	b/RtzLt6apU5ctmESqmvV3R3Sk1nBbjEG6Is72jOJxDJsiTar+Ez0lY3a5Q6VHNigGyPQJYSd7S
	E/qAIFc8AerN3COWcaz0aK+nRwt2UmWN0MGnLjNj37rY/qDqYvEzk41suziQ3jtFekQXG3nSujV
	DWY3IXCNqCLkvo+Jey/Cv/bqWm+tI2wuan8SHko56vXiMxxWqKw/3qozS2Djf6z00wAVu1Xs5TQ
	r7GY=
X-Google-Smtp-Source: AGHT+IG/R5OD4pp1OFOM9MYMt9/Bhul+bEC+eJ9Gapoq++XiZ8PPTIp2w0OLJEaZ5ptFkMI9E6aTQfedtmXfsk2hbhE=
X-Received: by 2002:a17:902:c409:b0:295:3262:c695 with SMTP id
 d9443c01a7336-297e5646bd4mr60288355ad.3.1762781950762; Mon, 10 Nov 2025
 05:39:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110095025.1475896-1-ojeda@kernel.org> <20251110095025.1475896-19-ojeda@kernel.org>
 <aRHRYbHIfxMQ77eh@google.com>
In-Reply-To: <aRHRYbHIfxMQ77eh@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 10 Nov 2025 14:38:58 +0100
X-Gm-Features: AWmQ_bm55qKIiHG3q93w7SalH37CbhDBzqfQWzONZGIL-nfi2vUYjlTXeaaq0Ug
Message-ID: <CANiq72msN1B8c8QFuH2VK40xXY3=uGiGL=YgAo68o92LTO=kLw@mail.gmail.com>
Subject: Re: [PATCH 18/18] rust: syn: enable support in kbuild
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 12:49=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> This change seems unrelated?

It is needed to actually use them in proc macros, e.g. to build the
new `pin-init`. We could move it to that patch series, but then it
means it is harder to use this series (e.g. someone was waiting to
port other macros).

I can put it in a final patch or perhaps just mention it in the log,
similar to the `quote` one.

Cheers,
Miguel

