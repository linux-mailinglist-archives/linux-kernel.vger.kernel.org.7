Return-Path: <linux-kernel+bounces-809116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BEAB508D4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 00:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989274E7361
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43CB26D4C6;
	Tue,  9 Sep 2025 22:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9ecApbS"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827FC25DCE0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 22:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757456548; cv=none; b=PJ86qixOoBuQAJrvVJPp1VdTdCVQ0IZqgJWc+6QHgv7lxho3G+cjTssb9LUZsbjxbqdc4oi3jzz33XvsuyKIgZZkxdKsKOwK/7TgwdK19wdli2RDv1/LnYuZ5lKimhv6PUejHgJT8GwDvKha9HHY1rkPW4dt/uWse3SJ+JDSwrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757456548; c=relaxed/simple;
	bh=Y1+lVOHdJgc/PJLxgnBu4EYLxexrbOv/c65GNuXU3SY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TdZRJbH+25XfDfZkjoq/ciDjSP3VIWrAuMJU1qATXM20C4K2xrf9Wa/nTmbhMNjFNaUs6nELHfsvQaIt1DeQNcxj+baMzvwfOaggze0Ifdce/4Bxck04u74vaGFMYjTT+d5eJiUdKakhtB19iwNnSrElaKWR3aZutKXfcdoLPhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9ecApbS; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55f5f7feeddso1134365e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 15:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757456545; x=1758061345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14zKoaawmL+tkb0ufqaatkUvQTDgaxwDhKzZv+iGXOM=;
        b=l9ecApbSPZVEftWFfPIN3jzQz8mJkSbjo+On8rboD6dTjNHrROauE/PJA6RVumSbhW
         zqR1GeyJyUJwR+6kc3WimMUcN4+L1IaQxwJGj5c/Rxhcwl1DZJSI9Wrl97CSfmd3cZai
         fo5ShOUjdt7ba8D99afGy51VyG+V6sp1udGNggyP5b2g4E4aqZX3AM/fgYzmRwH597bk
         JpcClhLmB8xSXFTPC4euEbp5rxc8BaROghVaaiCDI/TUhrvKKi21XhrnmTK9RG4kkzDV
         Es6R51dYcwfq0VVDqvesgHB6ZztAe4F2E+VeDD/ys/+aJX4rZBC63Zx6OfemPFJgCCXM
         gfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757456545; x=1758061345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14zKoaawmL+tkb0ufqaatkUvQTDgaxwDhKzZv+iGXOM=;
        b=wszLgrH8AD9to8X0qZYdb3HBA+Pqvgz+Smp3i7B1kvPlRQy8lk7hAcI2q+ROWpszxt
         xVfPRseXI2NONcpPIp3l81OovZh8LXhMsk1Dx8mBupfyKJes20lFYwl2JyOXI4swRyqx
         Fqf4ipQITVk1V7rK8QJe377SUC87cyTdeGp2xHVX1kqq8KqbiOKteCSeAdYmOclVxwO5
         ntsA5WdVmwJMKBw2xpWYLcJtIChNoxtc0DyqxC8X5AVgVEXjpohPU+r+YxKJh35GQfbb
         ohNbsXr+UQpXy2V+eCFIdhtp6m9EWZ2U5vN62PyZKf780tKfFrIbRs4EIaEMO0V1paSk
         4yOg==
X-Forwarded-Encrypted: i=1; AJvYcCWcCaAPdnEDhAtkaNSIusOQImFJemvUvEeMjd932iYHidECeVdDayOAoQJUQMcwNFl0wn8YhTPD2erZhao=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtKebtPtig0piCNZGp3Hjf7RlI5qTBKg+9OeAbdGJfTmATyh8J
	9rrOw/nMtoxCRyoo+IO/x0z50eNUuyMPMv7tsFDboqFwqfsT7SOPVYLmxSFMK+N3fDrYcPX0Ud7
	hi6bHxSE0A+kBOUsEQ2WiXBiA8gcanbM=
X-Gm-Gg: ASbGncsaXITg7yjCVlHWqjhK//W71Ema+f2mx4pfcFiuNUxViyy4dN656zE7H3NQ7B6
	Yj45iSmLkkgosGK2L+HXvvymB7M2hYCR/60doVkQA1Zc3/uYiAFWc+JjU05TSsywELm7peP3dmz
	Pu6SQLWtnhWt9bdYNDOFuFObeEz7Ai8/s74aUfy4lwxWh5aDIRdOGjFtWabyrWNzu0UZ1nRrPMm
	oOP1d6jGIm0m2jJhtBxsMF7d9QLtOqALMmNjvhzSCV7CnWgmJqA6X2kx/Ufoz4ztuXcc6dOLpzr
	AuayaV02ZR6PRkhCXi50HZfgXhFYx/Y0o9SOg0JPp9f0Om8=
X-Google-Smtp-Source: AGHT+IFDuCYxLQfV628Z7phqsroB85psQfsmvFVoNoEg802fzEjgvQkjguzByvEJEMk6c6/YwQXKAJTtY3UGkeA4SR4=
X-Received: by 2002:a05:6512:3b94:b0:55f:5965:e4e5 with SMTP id
 2adb3069b0e04-5626275d96bmr1967969e87.6.1757456544495; Tue, 09 Sep 2025
 15:22:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829192243.678079-1-ojeda@kernel.org>
In-Reply-To: <20250829192243.678079-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 10 Sep 2025 00:22:08 +0200
X-Gm-Features: AS18NWCf2pIbJBXY_TohxQA27AKHeeu88lGrE2tNqE6BO5-_LqyV8PLVSxBYSKA
Message-ID: <CANiq72kS2OFaW+FEgSXGYup=kC3VxxJb32f+ZDs946NGREXUnQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Error improvements
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 9:23=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
>   rust: error: improve `Error::from_errno` documentation
>   rust: error: improve `to_result` documentation

Applied these two to `rust-next` since they are straightforward --
thanks everyone!

For the last one, we can discuss it a bit more in Kangrejos.

Cheers,
Miguel

