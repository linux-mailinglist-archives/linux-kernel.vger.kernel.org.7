Return-Path: <linux-kernel+bounces-754229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E32B19022
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 23:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 408C8177ECB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 21:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3812204592;
	Sat,  2 Aug 2025 21:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDHYqf3A"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ACB1E89C;
	Sat,  2 Aug 2025 21:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754170284; cv=none; b=I9jJ5ZBMFttAmTxczGUgPFVbQGWbGL6N3QSeEePw8ML2XabHXm6T3HDYtqyHAHvi2yLhg3X8/zp5g19MkGeK7+6ULkkwRniC3h3wKhcoVARB2BZmnGRGSEi+EfHOIBlqnQP55tqmlm8Gu3QtECH7+wRh4GzpSxeHn/9bQBbaZ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754170284; c=relaxed/simple;
	bh=qf487f41K14igRdmD9PUV4gDp8XiRSpyoTZp9VXkb+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSiFRcvhaEDagM5CrVJpK52S3S2e6TdazYcFIwOp1vT8msCZ8602NU6PD1raQRzioeSjx5c8yQpgFh8fhoa9wCn5sjvfXk6yNB6mLi1AC3y2tjsT5TyiziE7v0t5l5K5sfZFTS5bj1a2JbmCJhICki/KXGb0ybelwFjEREzeVgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDHYqf3A; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2400a0c3cf7so5300415ad.0;
        Sat, 02 Aug 2025 14:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754170282; x=1754775082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qf487f41K14igRdmD9PUV4gDp8XiRSpyoTZp9VXkb+M=;
        b=CDHYqf3AQdg0QjQwG3OftGX9jIxk3QVzbQuQLdrw8vCu1mWvo+n+w2OtNGvITVq+PW
         oHtlxI2v34gs6H3D9wbQ7mCv0mcEdIEJmbiSUBJehJKZMkiauNvHGGjy0P0dJodY88Nm
         YhAk0UOM4Bhl6PtfIQnMg80bZnqK0mPv1IWJ8QLEikbKF83uhG6HMxLolyf3t6wug/tW
         EGr/JWde9g4UT45+WTjt5J+wS2YP++cJ08WOt/eTiXlzTZK+TfdG7C3F8kK9pNMoC+I0
         idWZzCmXkY93wqh/Tw+9ZqW6E/AcCvLdtQpeE+4oo5SddS/FyFtPcKl6GznDLS797EJl
         ovyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754170282; x=1754775082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qf487f41K14igRdmD9PUV4gDp8XiRSpyoTZp9VXkb+M=;
        b=L3jVaHWtF+Wzxp/fSh4WVPOxONrOa8jTobNMY96GMsjD9uBFI1ncbLdFRa19a4HJ5A
         nPfXMC6dMKxQi2O3JEJC6DdSky3GAWUrHg+1HJ4eA7cP6CVfU1G5U+M0XJ5KELn78+Qd
         OapQTgobqM1kI73evJc8VHA1Djsp8/NdZYLzLMPEA4+6RvxfCzSn+r+hWYPVki7YfQIZ
         SbCaZgUTUSYxXTjNgzFvkaZjFsusF0699p4oeMIkuKBwVm1o5mlykcGauregUFgAmgeL
         nsWiRFEGiHFJgeUA0nuJIMm64+pBLG9W0zvD2i3q8lOxV7jJmPccS3wnWiy/58IB4w0O
         KIAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4Y/ZVJeU6qhNM/mfgUVMnyXxOZ2n2DznEYhN/udBuGBZfqoYFh/LSZHcv4fUvdloF060Ha3wBKBjVS0I=@vger.kernel.org, AJvYcCXw20fZLoodCA0VJCj4tN4M8/Pa/PnoQO4wey+rh7+pfhgxP9T05iBYRC7aV77rfwE3Q+nKT9PknvRNNk/qdNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNExoqnLwrmdaksm8YbGWzD2iGOFVm7aM4qni4hfxSMGtaOvhK
	i4nsAEczovhRJRE4E0HclfBuA/m2wVlYvz8tUJwRq33Fv5kUDFjGgQNEaX4fI3ryxMoG0ycgTg5
	AHGmnOyJdS+GBRpJy4QEHema92aaD7TeFWEMWFSs=
X-Gm-Gg: ASbGncu9RB3lfDaw7ArpKiylp5BGElcgdHI9fZd9zFVew+8j818kFSo6lxTrpsjZoIF
	93b4wikVC+DqpFkPwiA8Z+QHGHf/eaGyZI+B2My1M4d8gOivs+5x876k9yXaOfnfYtsIYiBOmux
	DuQtZPv6tW/qBLscvt+DFadpbGSLAYzIwY/7apWjM2t2CqgkifH+N4/dJitvPSNkkw8Cw7JLpxB
	9A7DKqD
X-Google-Smtp-Source: AGHT+IFXn2kP4l2ORTI1Euj6ulZhyKBWLwQNZ564sSrh9VrlbKvf9dqt1Bsda5RwwC1AgsXqDBIfQ2/SKTZduTA7G64=
X-Received: by 2002:a17:902:d4c5:b0:240:4b3b:333c with SMTP id
 d9443c01a7336-24246fe0475mr25643215ad.9.1754170282043; Sat, 02 Aug 2025
 14:31:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250802210001.824022-1-zhiw@nvidia.com>
In-Reply-To: <20250802210001.824022-1-zhiw@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 2 Aug 2025 23:31:10 +0200
X-Gm-Features: Ac12FXzEUAanBhI1Fc4d0IPTxB76YoAw0tflhyLJZ3EnRtMDDL7cAmnz2ioLrBo
Message-ID: <CANiq72mT=Eee3NwxxmysBu4iP6LYuHA2NckrKKVY=qQSSK12=A@mail.gmail.com>
Subject: Re: [PATCH] rust: list: remove nonexistent insert_at() from the comments
To: Zhi Wang <zhiw@nvidia.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	dakr@kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 2, 2025 at 11:00=E2=80=AFPM Zhi Wang <zhiw@nvidia.com> wrote:
>
> The insert_at() method was never introduced in the code. Remove it from
> the comments to avoid confusion.

Hmm... I am not sure what you mean -- `insert_at()` is an example
function, used in the example itself.

Why would we remove that one, and not the others in the example, e.g.
`remove_all`?

Cheers,
Miguel

