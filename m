Return-Path: <linux-kernel+bounces-884889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AD12BC316AF
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B8174EBCB8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA5532C929;
	Tue,  4 Nov 2025 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwBOQiR4"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4DD32B9B7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265249; cv=none; b=WWeKdvLV8UedPLZ/lJ1ClDP7JyUc/zlvW82wOCm6Wo3qSY29wl1OC7Be3c4KjWU0JXGOKTBiX5SZKdFd45/wbPMuGQkQc1cDBhCmay2Kec9K7BMTFPr4bY4Foe2IwqVoZpblNTYwDsR+WOMHZWTO33H3NiGT+52jfpUMpg9oXMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265249; c=relaxed/simple;
	bh=PEGyLJUT+zzSFJ95q6Pkl8/xdguEfP2nRB1yIszhyZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oMdkzv+KF53+L17UUcNGBE/fJwCHx6d/Ar+WUfGDEtCsBL/C5F5ZWkA0tndObM4y2xj/+qsXfjnwMOgwXXj5XIIaLNglm5UXMaegYjcCBQckUuEXUCqY0pDtZmGzQx1c1llj5dZmvpaKevcBa845PTTmVJHsVrUFUx+1Rn3Uz0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwBOQiR4; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7ab689d3fa0so216147b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 06:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762265248; x=1762870048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEGyLJUT+zzSFJ95q6Pkl8/xdguEfP2nRB1yIszhyZY=;
        b=QwBOQiR4q9fn59Pb4WjCrc3qUgYA1S+vIUbE8ZS4xy+UsL8t9aolAlsD2BIETdO6bd
         1KrPXBSuJxUJINerxxiYCtZ6T7DEDXc5XsSR5iqYpLQC5rfZeo19VbUSXCnsMh8QF5Nj
         S2fMPBhkwldM2k/EHgF/AaogANhuUSIoOELuoAC/Rs9VBQEKm1Av0gH+FxDT7sE3grbM
         JnOn14JaJST+AqpGc40k7uh0+//NwLNDW7w6GdyTZOJ1Xzue4VM9B6uCl0jlLMKEEiat
         Iiu6okkk8OUQd6777s/HWQjJIuOw625fON6PvbrGZfxlDd8EyxSpWyOLg8s3ejP6iPrY
         SSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762265248; x=1762870048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PEGyLJUT+zzSFJ95q6Pkl8/xdguEfP2nRB1yIszhyZY=;
        b=DhMrvlY3UbugujcKbO9RI9/PlYCZePPCKeWKXRBdTngmL0PDkVgZj/dATSxOOiyFqj
         43RYyTy/UOrFAjjnjNd4ZiVi1+aOAhysuOOUStiUtXogB3rDZBZcInpDKhTpfsERl2LB
         e6XVRnLy8XDUH/X84jEmhIEc/UW1VsjDK8bxfDYB7x0VAP+OX4/8ChitJhVIFOrvACbr
         YNV9LGmJNF6LyJqwxFQzJMJ0kQXwei5eOgeD6P59MIyqhKssCNXg5FFZtt7Wh3AmgWRH
         tBaqZ7+7lvMQgAu1GkiIr/zAY4kATUxk7FoU+WDHjqvXGRr8XB0ghxB9zSg9rCrkTvgn
         1Upg==
X-Forwarded-Encrypted: i=1; AJvYcCWy2GHBQoIHfNLyxpNb/l93U2q8Bn30zK8RBONN4dubQI9em9SD+WbD/pPxE0T4YjFUP6sK8MISGBYT5D8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRg9ul2IV1VU49v10yRSu3tU3jZO+OsJHZvUYdyFKVs3hoAA/G
	1KkiuZAT05gjzN/ePHt0uAh9U5HnULWJ1g1bbp+W9+zAmKD/iol06J6C8HVZB5aa6BU/0bTc/8A
	XE0Vy04sDHIAtc1SJVr8TNz1Eqxr8+Tg=
X-Gm-Gg: ASbGncsMCzRQnWEt1Us3Brt+1ouKs5B3kw/sfpVNcDZSOrRvo+sU8XX4RjSdUqNT1Lm
	4tHZcLumneYeSall9uL5h0+4hZH+e/VCJOfNcP5SQJFxuemK9AXSf92vZIxs89IG3hFRzv2c9Du
	lOog3dVUDY+oGLqXBwAsqzvzZ9Xm35t5NPgu+Inb6/rSQh4lZs+YyFQ0VVIoJPY1WkGThgWcGEH
	+fOkaHOCBoAnBiqBEEzRD3cC3J7RzAH3bldE70RtbBdIjdxhA+Z3rY23biqs8REFEDD0w2RCnid
	5/M5BoxrMtYcOHcR02oN5AYoBH+S5LBBA3mAq4/X+CN/1aIUmDczHhp+TXnO57HD685lhytfi9m
	wQkByOWNp6mlGxw==
X-Google-Smtp-Source: AGHT+IEoQt7wc4QhveCREcNLj59n0mc2+WwtyT6a1zVCHIjoX1thJlflh/bTa19DZhwmYOUd1dkkOIBrsDu+HwIpQfs=
X-Received: by 2002:a05:6a21:a44:b0:2df:b68d:f7e with SMTP id
 adf61e73a8af0-348cd411b8cmr11613230637.5.1762265245767; Tue, 04 Nov 2025
 06:07:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030190613.1224287-1-joelagnelf@nvidia.com>
 <20251030190613.1224287-2-joelagnelf@nvidia.com> <DDX1WYWQNTAB.BBEICMO8NM30@nvidia.com>
 <20251104005812.GA2101511@joelbox2> <DDZYCRCPYMOL.RMTIF0R404Q4@nvidia.com>
In-Reply-To: <DDZYCRCPYMOL.RMTIF0R404Q4@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 4 Nov 2025 15:07:12 +0100
X-Gm-Features: AWmQ_bnRfHv_8j6zHrslJDNBWq9rDs6IM9lMFZ907aXIc2-_3edh4KvJlGf8RU8
Message-ID: <CANiq72=Cj_gJ27+EAiytxYGYk1dMwu7M3xQpLGByD4QstgDsHw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] rust: clist: Add abstraction for iterating over C
 linked lists
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	dakr@kernel.org, David Airlie <airlied@gmail.com>, Alistair Popple <apopple@nvidia.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, joel@joelfernandes.org, 
	Elle Rhumsaa <elle@weathered-steel.dev>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Andrea Righi <arighi@nvidia.com>, Philipp Stanner <phasta@kernel.org>, nouveau@lists.freedesktop.org, 
	Nouveau <nouveau-bounces@lists.freedesktop.org>, 
	Guillaume Gomez <guillaume1.gomez@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 2:42=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.c=
om> wrote:
>
> What I'm more worried about is that it might be a PITA to write. :/ But
> maybe the core folks have an example for how this could be done cleanly
> and in a reusable way (i.e. we don't want to duplicate the dummy list
> creation code for every example).

Using a shared module/file may be good enough, as long as the `#[path
=3D ...] mod ...;` or `include!(...)` is hidden with `#`, i.e. as long
as the user does not need to see that to understand the example.

But, yeah, we have already a few places in the tree with fake `mod
bindings` for doctests and things like that.

Cc'ing Guillaume in case there is a better way to do this. The "have
something applied to several parts of docs" has come up before for
references too (the "external references map" I proposed).

In any case, even if the example does not run, it is still way better
to have it at least build instead of completely ignored, because that
means it will not become stale.

Cheers,
Miguel

