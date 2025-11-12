Return-Path: <linux-kernel+bounces-897067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F446C51DFB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B65AF1881FBE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C32430749A;
	Wed, 12 Nov 2025 11:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBdcHOPS"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A7E2D12EB
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946034; cv=none; b=ZUkBGgYMElBVxNklW8FXeHiicpqtL3OsnrzrEMjWLUBoGMazvTc4vp4AlCA9RV5RHKTvD+p0kVc+lRx2lEQ9PcJVbPiJHBIT4fbk13jQ7BNKscQ1mR8J55Om4LTCYomuHi16PZTwlYJtjJtZhE5XUccSE1A212VCIIX3zY4l5B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946034; c=relaxed/simple;
	bh=HKRQgb7qkXFEXY0rIg9AQCQabb0xmTPYzrOWr+EJXY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iCNRiFqSo11URfI8Qf6OF12iA7hyPP+Iw/73YRe6uMidMQ2P3e8l/fDcX2B7opMidyFswubZYbc+6esB4ektvDQVAmXaOEuLj/ILPsg79gb35tyZ7mhyp1s9fVEzpZ0rZ2I8En8gZwR/OEZ6jCerZ+f6lN0DWxixm3T2OapVstg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBdcHOPS; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-295351ad2f5so717485ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 03:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762946033; x=1763550833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKRQgb7qkXFEXY0rIg9AQCQabb0xmTPYzrOWr+EJXY8=;
        b=FBdcHOPSk/RCte6K8VHG3Ca0v2zHxnekNbAxUvgw0m7tRPb6I/fuKEJ6JfEeGex7Ub
         mTlcYU9o9m/OLM3cfAaKQsDHEY9fEuuAMMkDfsIkXyu54ubQol6cFryQ3hI88bhs5AfJ
         0Z6YFEDuDTzYpxwSXiWZLe82VCx2iA6zz2COnL4gZm0aE0mpRgOP9JiwQwLX/n3M23R/
         mIwv0LLFvFG89IWTwUBWrkafu1Xc9eb8+9/kiDkSPwfWaScjig5jt5WK8gYEtyCVjvaO
         LGyrfRs47PDHXl3iTk57VX1bvdmbnopU5U0fERG06YSXJFummkiqe13o5a2EOTFE352+
         BX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946033; x=1763550833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HKRQgb7qkXFEXY0rIg9AQCQabb0xmTPYzrOWr+EJXY8=;
        b=XdaE3/OgXnl6DqJe9O20aAcDbM2EYN7lVifvx/ZqiRlKq96yZ31YXa6/jzdXh9PLWU
         EXg/Xs9MkM3qM45VNZFajwUv7ZmGgrNwR5MfL5nFXLXki5TU5H9oUZyV7gSegwlGLIeH
         nAkLrR5ElAPIf7AwxMnk6S7kLN+NTjy5lJynssvFlAAIyGmAW4YbiUHpi1+OpavRhFrT
         uk4oJ6XdzE+K+9rdngFQrcljoOfM6Opjy0tBYbWb8JZJ50p3LNTGrmbdWL49XF+J8t6a
         JTTnB9TiTSO8uCOAmjRePmu7iBcqwW/nEedlcl7JiNdIZGeVBjqoTtWRWbp2KH5zgybb
         CN+w==
X-Forwarded-Encrypted: i=1; AJvYcCXhrOgt3SPH+IMONmdWgilT339YExEEFF14twNATEYsEs/3rDfo+u+bVfok1h3wSckTYlkBXdvdL9azaBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD7sLKufHwZ3BlkDEjVZRdXatGEklqoZci4bt/uRXPKYgHpJtv
	v3Uvzn3NTY9wWFC4he7VYH642TEZwrzU2LNmlYk+jBzKQGA6fOE82t7+DaD4A4eUFdFJ4JY/J7C
	v/j3glpFIOk51eiSOjUdXztRA3+d3d/g=
X-Gm-Gg: ASbGncs7OajrFewetY77r3COnwl0cauFiS+xAPf+2zhpvCz9EJUz/jugiE/yR6Jg12/
	a2PbqkwXhNvJibQn3/4DFjPZPHDliCra1gbhxBxWcVeHevtDCNr/+dz7RbNI6ZMZSYzFxvvCh6n
	8EIkbY4Tn/GNAEdAUhLuUaavGsD1imvUXqMeDjT3E/LsK1Kv8I7sDHfvBmYmIt7kl8/x/pY1NXb
	Fge4W5hZ+L4dx71O/h+12XZwkHZCweF1asLr0CkLzCph6TDPivJsCEBiOM2y9kkx9upCZWldlW/
	3YtWt0zyvgSeyyEwU9W0jhmZmZUVuM/1CYgTR804HwPbjOc8wT4mROJ9LmSOY0XTi+7kT8Kk+re
	fv0hpRXhs0Xc6XQ==
X-Google-Smtp-Source: AGHT+IEMVOPLQ0kfBxj6LLguRfI9eu1jQSQHIP8wiKHhwLHRC1rvaWObMB1+XwvZaSaxDEkp8LUmHo0FgkmnVhYp2tM=
X-Received: by 2002:a17:902:e84c:b0:297:d764:9878 with SMTP id
 d9443c01a7336-2984ed48799mr19398545ad.3.1762946032845; Wed, 12 Nov 2025
 03:13:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110095025.1475896-1-ojeda@kernel.org> <20251110095025.1475896-3-ojeda@kernel.org>
 <8e58087b-17e6-4362-93f9-f9aaac6c4476@nvidia.com>
In-Reply-To: <8e58087b-17e6-4362-93f9-f9aaac6c4476@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Nov 2025 12:13:40 +0100
X-Gm-Features: AWmQ_blP421Ww4skNX1IA86Afm7j4Lia0EL-t0RKvHyVdfTUWYuVKwSCLUjZdhU
Message-ID: <CANiq72nssjH0dZ5Yso8fp3sjHOMK2YYyfZG+uG_Fb_09xd5=vw@mail.gmail.com>
Subject: Re: [PATCH 02/18] rust: kbuild: introduce `core-flags` and `core-skip_flags`
To: John Hubbard <jhubbard@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 8:18=E2=80=AFPM John Hubbard <jhubbard@nvidia.com> =
wrote:
>
> I agree that switching to ":=3D" for this kind of Makefile variable
> is a good move. However, it should be mentioned in the commit log
> so that it doesn't look like it was accidentally introduced.

It was meant to make it consistent with the upcoming additions since
this commit is essentially about that, i.e. it was not intended as a
drive-by cleanup (which I usually oppose), if that makes sense.

I will clarify in the log.

Thanks for taking a look!

Cheers,
Miguel

