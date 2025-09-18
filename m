Return-Path: <linux-kernel+bounces-823359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C76B86331
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790791CC159B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D76131A547;
	Thu, 18 Sep 2025 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K96h17TL"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D974E31328D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 17:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758216269; cv=none; b=ikdu88qDMXpg++KzjPwbB9Z7g/+fnmzdNRkjzbHI/92xylNHgGxrR4eb5jj3E6LOXS1Uqh4s6tqbzH3jTEprrQW8AVeKThZp4+UJhgQPMRcjTh33Cn+4TKn2G4BZDKPkgI93W1tZz5ymlioSd4VKAIM8X32krjD2LH9b0DdTmK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758216269; c=relaxed/simple;
	bh=VPVaLq3mEhpTLnLGgFBqDthQx4v4zfVov8m51kTdsRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cTKsAukjBh1/Zuun36VpaCoc3MHZ9X2mvtQnj3lMIzqywQz4H2FCoXMGTWNLZYaP3m3Jx9iZZU+3cqo2NnIgqROKR6JlsWpV3DPt5oA9Vcww0h3TsgP5lQJGiZpiuqtkXIP4LMMeJMrV3jvEOecI2lNDpqOF3A58syTG/JTHccw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K96h17TL; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3d118d8fa91so511267f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758216266; x=1758821066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epDoJHvLYqW2JL6NNPKc53wLkRtM0zeExMM8c9t1quc=;
        b=K96h17TLtGLiQ+jtYwQXqYRBF+MV55l8OrAIg3e+N/O9IuSoCcFNL9x+q1kO8Kaowr
         ZBmL2CMFuZPoYSnhtRm5avT0VEDbHwbpWoNFAAT5cqK4v8lJTZ51fLPJWze4iE6PuNA0
         jEYnrT3lTr2TV4GQGFBZhVC4TpCXfXoVansGkOpFRBjGmjTHGBKT1G4m4rzpVC4KB/Ly
         0LNtxw1/Hna0dI6tJ9L/qmRdC8FHfG3IFZebW9EqkZdFd4FyRBfMwHG6i4Hjzr0y0eou
         S4CRlEg5/eJ2/QbbbrrE3lTnMZKfzcbMaa97fDgHPySkLl0rYeTeyngJPum9UUqEgeRS
         iq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758216266; x=1758821066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=epDoJHvLYqW2JL6NNPKc53wLkRtM0zeExMM8c9t1quc=;
        b=MHZNr8DsoJ2AK0LbCk1tcXCUTGSRd/ET/bR5d/w2K04hhnAWTBqjgLoi1jk5Lqha3W
         6Xfrq1mK8vwnwc0PJDIpXklNA3c2nuE1cH20vCXPIP7GBMGUbK8yOjFBc9dFUbil12en
         wacD1iNciEuJg3fsJenwZVJIH3Ey94iDSUwRdVPWdwLx4c/vrRGUHiU0Vm7J4M2F+puu
         3UOhZsELbOAQsQ9FsOc07FSvcUvJx+uxOi6PRBK4IqF1wjWkeclR7kpZ0XxcDSfkYeWh
         uxSHN3bVkjL/seBtF+InujpowLzffpIuho6Hxb2YahD8RyqYCMDAGxRjRZpAagdkEC4A
         zPEg==
X-Forwarded-Encrypted: i=1; AJvYcCUJOOmvRfV5/6xu9VDk/ADm6LP5FrvEL5KDA12gm8DTilALf0n3NlFHTWtjy+RnKqBo8tU7dUuKDBan0EU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWsu4uCeL5AnjPRRIwHxswSTIeimVRH83ch8ygtHBGMeWUBStv
	TbsIJsGySON6a7ebdUte8kfU8BPm7w5xOhyOr3YWZRji3IZZZWkAmWpkuu/jbZ35YlTYlaGlPCv
	H4iUQEjQYQjTatrMvB0yBqiCXsCFY9GWSl7w4yKS9
X-Gm-Gg: ASbGnctG5o3C7k3sPpJOSc0DDBd+VUqF9IaSnWCLOKDcdAlP8elwNFiyhjtVtEHMn/G
	hLen/wgYxiko9YnuAg2eNGRpZNvZn7S6SYJ0zOWu3fPYXgdpxawClofiWPvXLYx+ebWgeENUoxs
	Cjxg4sWpybjeurrej6CLlzw3slJ5xUr8vwLje8ziCshKdq/8mXasxVmErZjAg4T5uT4oahc2l5F
	7BY3EuAv6Rp/KKvtDX2X6DCWMdZqafekkI3tsIs4QP9zH721V6/DjZiYU8DQzIm
X-Google-Smtp-Source: AGHT+IFOw4CJFmAI9RamLzW4T7p5y68pw3l7sF7vN11tflJvFcK2DY7GQts5zPIH7DY4olKyRLU0HJAAK0jICO110J4=
X-Received: by 2002:a05:6000:2301:b0:3ec:db88:bf1 with SMTP id
 ffacd0b85a97d-3edd43c02fdmr3984418f8f.12.1758216266082; Thu, 18 Sep 2025
 10:24:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918144356.28585-1-manerakai@protonmail.com>
 <20250918144356.28585-3-manerakai@protonmail.com> <CAH5fLgiDJbtqYHJFmt-2HNpDVENAvm+Cu82pTuuhUvgScgM0iw@mail.gmail.com>
 <d90b10f1-2634-481a-beec-ce9f31aadb74@protonmail.com>
In-Reply-To: <d90b10f1-2634-481a-beec-ce9f31aadb74@protonmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 18 Sep 2025 19:24:14 +0200
X-Gm-Features: AS18NWCJ-KA24BPiLVdZMm7KuWsn9wKB2ov2s7U4hMX9LGAaLcStRnnsDeNwjmk
Message-ID: <CAH5fLgiCzcTo3VF5Of=_bHO0H8+_uPKYwD_aG_Q-oJc3sf+bTA@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: miscdevice: Implemented `read` and `write`
To: ManeraKai <manerakai@protonmail.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>, 
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 7:22=E2=80=AFPM ManeraKai <manerakai@protonmail.com=
> wrote:
>
>  > We already merged read_iter / write_iter functions for miscdevice this
>  > cycle.
>
> I couldn't find it. Can you send me a link please?

https://lore.kernel.org/rust-for-linux/20250822-iov-iter-v5-0-6ce4819c2977@=
google.com/

