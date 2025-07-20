Return-Path: <linux-kernel+bounces-738285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0DBB0B6C4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 17:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C2547AB9F6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 15:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7E921D3C6;
	Sun, 20 Jul 2025 15:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtB8rnrf"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2802192E1;
	Sun, 20 Jul 2025 15:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753026177; cv=none; b=W6HeRm/Sv1mcH2KfqG9uNzuxxbZQc91pxhtgzmR/Mb7UfSH6Bwp1vgVcatEaPPJeb0JJ+5zuBwiAQC2Uw8Bysj3wFtDGoC4eL71+DlsLj7on/7C4wv7iekk6vUIEhlDgOa26+2kjCKduqadlYA8W0t0ilsqOJpbEIR0ul6a3snc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753026177; c=relaxed/simple;
	bh=hf3nEi1GbUVBwXQMtePHrC8sHuymtVkKRgUPw3v74mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zf9KRikXG901yBLs1j2oSsmzrsCVn2rr5BJoGWjSALlVjO+Rwc0qRAj/OgAru3n42HWo+EvwXdI5RGGas2lNSni/i4ktV+pgruOoBZipxi01axJlk0SsLqOVral6jE+WfUohJh11ZFmyzeVH72E1ToTWdR/aqeyU5yTiNRhlhbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtB8rnrf; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-313336f8438so632262a91.0;
        Sun, 20 Jul 2025 08:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753026176; x=1753630976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hf3nEi1GbUVBwXQMtePHrC8sHuymtVkKRgUPw3v74mk=;
        b=UtB8rnrfluFhVUWseHYKPg0H1TW+LckjcUGhAuIVv8LS2JEG6ZQGRBe2BhGfXTAO15
         PeHYCGsQSRdg+wFducfz4Wo6BB5Hxld0lykTHPTzOmnP2h4xG1iQHJkbxBnKVBbWc+gG
         M7vqyJxtiu19/s0sbbRGelq3VmHyGWzFZLwTjVGllVLU5ol4FVYDggw1XlPFMdYu6tFg
         oeM0N3jJKs8PhTRjUBGLa3VHaNYJTLgC6qwAPATlpzAvqpkO6uCsYKX/bjOMZVxCvFT+
         C+CN1qq1jHqpAeBDtiHrldYQ1hmVxylXcF7gVtCaB49McrPe0OG1ojR7qCSHZHF4IPFQ
         76JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753026176; x=1753630976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hf3nEi1GbUVBwXQMtePHrC8sHuymtVkKRgUPw3v74mk=;
        b=IpKy8Ap60CuHq7IDcTPIaznoL3qXLpff67IEY28g+MZ/wEMVuJwg2zpA04b2/U0Bh1
         yPjn4IpgmDXRQBjhzr9tV2Twi1jjvL6UsjGz2wKVAkTVa5lqREMO/PfgCbNcgU3Zx+HB
         mUmnbHAMcFlPhNL0dWrfvOnqYFfyFgniq7fvk855Oe/ec14cOJGmEWsXkY4c6Z2CTUoi
         nNPyVE0PrYo/isk4W2XjUC3iaf4+OkQ9wC8KwQbZ1bdGgPqlzbxqqQqddDOpQXD4cQYg
         e91GyqSXpedZ07xjUQ8tVwCPg6dbk8+1gqejIGLt/yoCHOSKo2+j0RfcIBzVFYx2E/uX
         NNyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8wzFdR+GInW40uARdohYQYw5sBC3EFcdLs0OCusOdBXRdqysCSgjpT77ajIzl1r5OP2PTIqCyK3nzyYic1So=@vger.kernel.org, AJvYcCXD1ynQiY37MFYfsvwPGIjkyP14/n9eXgmhH/K1DUJe8qQYkStbUETRWSCchgfOQar/AKeWaTBbkcbjj3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5kWGrCcjLnT4kLNpkbmiQQd6FXXZqKbqJWqFyljGzCy/U9wyb
	Cg9nmDmkklqZrxQFTn3mgIhsA6+M2g8SNZ/CgqrwYGYd0P2XgGYVVmR7ePv+pWeGKBgg2WdNb92
	X3PZEs3Nwm/7UK+oiXfFzGq9zG5QMoY02Acgr
X-Gm-Gg: ASbGnctWwmVjxwI/7m8wiok4TX7hjeBeFCZ9X2sR9i0tKkcQnNb0xS2LQrcv4FpXrda
	3X7iQUw3mJ6bhYbDmYxlOFLN0M+ksIKUqlimYuaTmP/XSJpE6THC9aEAUem8lGHfPR5td1EIIfW
	uPeYZtNpTniexkGdJGojqOc8nnxcasVZpKXqwEBAyMUoSEnNLhjp4EQH/IMc3DvyqG+N7Y2RA1w
	xCHWo+0
X-Google-Smtp-Source: AGHT+IFqNpOzdBTmFRFiTW4z6woad/Um1O+RHnR6ITbtsktkp628Ij8ZiKOsT3ZsBgqURGRDEMUjrCb8+P9AUwzN9tY=
X-Received: by 2002:a17:90b:5307:b0:311:b0d3:851 with SMTP id
 98e67ed59e1d1-31c9e75ef14mr11738434a91.4.1753026175613; Sun, 20 Jul 2025
 08:42:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720094838.29530-1-work@onurozkan.dev> <DBGYNQJJ0JI6.P280ZLVZUSO6@kernel.org>
 <20250720181721.54ab9faf@nimda.home>
In-Reply-To: <20250720181721.54ab9faf@nimda.home>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 20 Jul 2025 17:42:43 +0200
X-Gm-Features: Ac12FXwbzBgYEAXufTfE5ha-Lse8W5OKzwHGOO_Sv0ekfeudF5vdUNCNPLhNZWk
Message-ID: <CANiq72mv2yiJW_AD-_F1JUP2QdJKGGg8SqZ5SgDWT2xc_tpbZg@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] rust: make various `alloc` functions `const fn`
To: =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: Benno Lossin <lossin@kernel.org>, rust-for-linux@vger.kernel.org, dakr@kernel.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2025 at 5:17=E2=80=AFPM Onur =C3=96zkan <work@onurozkan.dev=
> wrote:
>
> Personally, I don't have a specific reason. I thought the change is
> harmless and might extend functionality for other people in the future.
> It could also (although less likely) help the compiler optimize things
> further.

I think it is OK -- even if we promise they are `const` and we have to
remove it in the future, it is fine, since there is no stable kernel
API. So that flexibility is another advantage of no promises there.

However, I am curious, in which cases it would help the compiler
optimize? The compiler already has the information on whether it could
actually be `const` and whether it can be evaluated at compile-time
and so on -- do you mean it has an effect on heuristics like inlining
or similar?

Thanks!

Cheers,
Miguel

