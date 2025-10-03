Return-Path: <linux-kernel+bounces-841049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D59DBB621D
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 09:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDEF619C679D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 07:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA6E2222B4;
	Fri,  3 Oct 2025 07:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sYKwgotD"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9993221ABA4
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 07:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759475118; cv=none; b=sYRCVNDtsHc7rJiCuhh/prDUe67NrYguKf4Oqkr6+mDazi8KbQM92be7iZpf0zegccCDeBk7Zx0m+TVlyncfPVRdruAYyUr5kIC1dGn2DV+qo2AS0dG4E27i5Swkrkq1d7zolIZJBZOCDaVuzwoQ3VmtOzsiCFOr9g/U4W8vbRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759475118; c=relaxed/simple;
	bh=V4nXwYJCm0qAgWBhMSc7xLQVPqXoKoYttkP89beAoNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1iNWHxpr27nnHtbmmKIhQ0DOxZPtSDCV0zsf1peAu2QWoNss3Uu2dHyBeGVmDdrMMJ0sdWOjbtJQY4w38GpVUKixxkf7Ja9BODkADd5kL+GcXSXU6WwBH9pZ7DNi78+jfRHgDtZBIN6vSKp46/BNbRAnT51kLvFuyHC0vcgQfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sYKwgotD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e6ba26c50so9593265e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 00:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759475115; x=1760079915; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WYt7I8mRkr3Ey2EwDvEAd59xCd1pgQeHenRaMjT/0TQ=;
        b=sYKwgotD7CgXw9ZxgY3uwEmRCPi8ATgNWzz52NKU4TPFuw4X6k1Swg5DqW6HhP61R2
         z2v0v/MkQ5+xh6sXCmegmI6/lp8OcBKcLcVwnpo5lg/8pkj4pDmHa2oKT4ZCdicfchvL
         J+8AlLXwjQYTi5PzQTuipbWGxbAPqhk+IamR/u4h3cfjxjdMLc6xs47x0BHGJzQu/sHt
         socjSeS3CoebE13mdhAAWJvHTy+K3nXKtJGONRLBTptsYEymaEabsFsVi36xfXGmN4Fm
         lpE0qto+nlxiIIaQDg/rcSjcpfkFGCEuwVDBNMhHo84zZ6HGAzEwDMvK1QVRQk8NKHoi
         5Ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759475115; x=1760079915;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WYt7I8mRkr3Ey2EwDvEAd59xCd1pgQeHenRaMjT/0TQ=;
        b=eCY+p6Xu8JVXaQRKdaKW9Mww65fDlSMBsTVr25KyGYQ4hgphhDkXz67QP6gGH7GTnV
         cigYk5m7O1bQcKNGNcOvpjxwzVQSOvWIY/LZvikLZ4j0bLKtkNvvaG796KBvWMTXlZu8
         3Bx5R5QkpdK524NmrlC6AdN8rbymPS84D1OJPYJLlXmCpcLUab4UqEwLEuea31p0ckiF
         /oCvyJhVxnKMFb9G6lTiUbIRoVtXXT3/5ZLseSZCiX7kVyo9u8SmjEVCEHv+NBC0DCyv
         FzQ8zKPRE1y5CxhSL2Q3Ho09InDcd1GAISQ1QzWi5pJqsqLNXUp3l60+fF1j3yy+yFH8
         a2iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxkcgEHajbqDYVZ/m9QdXZfeu0RFK6G9q5/ngC1UoJl2gqMchQstuQSKBe7abPGUJD00Simx/gQ6C0Y+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy/0vXOJZQj33PnrHfZbN5p+odUmU1QMZbDwXUQtuEc0MY7nXt
	Enfu/7dMToXJn40dSEuZRIe7VMCtmgQC89SNlzcnf1kjGABCk60pwXQSzOrzk276irg=
X-Gm-Gg: ASbGncth3x1k8hpjBh9gu0s0LW2/H0azGytrtTngQxCnDadsdT3iQ3t4KEGP6HD3g5D
	KPAEAP/qbr6l4PeG1d+MH+IS+g3o04rP8F3qnl6ccKpCKu+HbUlR8R/DVqGi9tAr8Bgzi3uRd3H
	O0Wb9r4YoIgD9o4LQHX0EfHu7L57u0Ilul1Y6oiAWUhLaXkPUYQEV6damauZBn3hSXRE1PKG2ZS
	OYJVdi94IeUqknoc8pr9Qa6vfgsR37ZqhFvVgeaD1VKq5Ij9eeqAJnssF88j5nl+fXMhG61iqpl
	Iwyh1sp5kYT4JJSJoTuM4ThGYSSKqBnyQpo65TP4wjrydbwhlV9fSc5Z+jHYQVlPwOMNG1gkCEq
	cxQFNh3Y3lKPsLart+9vTxuV6wxmUHZ0b5USEt9eYQVqWlJ0rJJpdVj7m
X-Google-Smtp-Source: AGHT+IEKWMNU5OX3+ORzmomh1gz2zjLM87JREtHvmvNpMc/EuUWnJ8BWX8gvQHfL5j0uFQFyRdFpwA==
X-Received: by 2002:a05:6000:25c8:b0:425:57dd:58bb with SMTP id ffacd0b85a97d-4256714cd43mr1162661f8f.22.1759475114640;
        Fri, 03 Oct 2025 00:05:14 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e7234f69bsm18356975e9.8.2025.10.03.00.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 00:05:14 -0700 (PDT)
Date: Fri, 3 Oct 2025 10:05:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Oct 2
Message-ID: <aN91pwLmB_2TwK77@stanley.mountain>
References: <aN6qWFc6hIcbRU1o@sirena.org.uk>
 <aN7cRUOxq-zwCoZN@stanley.mountain>
 <CANiq72mDsU3W5Qfyf=sKhbad4tAHJYF8WnY+4VPz2J0paA2gTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mDsU3W5Qfyf=sKhbad4tAHJYF8WnY+4VPz2J0paA2gTw@mail.gmail.com>

On Thu, Oct 02, 2025 at 11:35:10PM +0200, Miguel Ojeda wrote:
> On Thu, Oct 2, 2025 at 10:10 PM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> >   RUSTC L rust/core.o
> > error: cannot find a built-in macro with name `define_opaque`
> >     --> /usr/lib/rustlib/src/rust/library/core/src/macros/mod.rs:1757:5
> >      |
> > 1757 | /     pub macro define_opaque($($tt:tt)*) {
> > 1758 | |         /* compiler built-in */
> > 1759 | |     }
> >      | |_____^
> >
> 
> Thanks Dan.
> 
> Hmm... Strange, it is the `core` library, which comes with the
> compiler and thus should always work.
> 
> So it sounds like a mismatch between the binary used and the sources
> of the standard library (or perhaps other kind of mismatch, like the
> wrong edition being passed, but from a quick look it doesn't seem like
> it).
> 
> I will try to reproduce it. Did you happen to recently upgrade the
> toolchain(s) or something like that, by chance? Are you using the
> Debian packages?

Yes.  I am using the debian packages.  To be honest, I don't know it I
broke it with an update.  It's possible.  I am all the way updated with
`apt dist-upgrade`.

I'm on rustc version 1.87.0+dfsg1-1.

regards.
dan carpenter


