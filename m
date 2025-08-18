Return-Path: <linux-kernel+bounces-773128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C27B29BB3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9570E164EF8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2FB2F0C79;
	Mon, 18 Aug 2025 08:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSOdD4+G"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D34B2957CD;
	Mon, 18 Aug 2025 08:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755504640; cv=none; b=cmGqzMMd4YFoJon4jDYS4SxFF+c0WRSj16Wpe9NXbQ/Lpmrv55J3OEXlqDPL9C/oOOBXooDCzJ0h7oPCglqaJR7/qRgTqmlK/8ohSyrgBFbRJISvZ2OZKtuWlppjWCmawevKfHXcrjhJqibLAQ93Y9PHUfX6v6aCorKAa5T5kOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755504640; c=relaxed/simple;
	bh=ZUVvU1uBctCztzs2wNlnqspjnxE9qt7GG3hQrK/SzwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mz+eP8aF/qXGgCHHCkzNRUtGkUJo2UpxrMLgvsDU4/hIThrRxjn1v0Wwuy6zQJOySXhfuvpS+wbtfsOeYho7D6KTwpQkFphS/oFd4E9Z4T4p+S8d/x42dfPFq6lNQBFAPLlj4I3XUHpaNOC+In5GVRVRFQRD46ojBr6OnI13AOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSOdD4+G; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-244581eab34so6012635ad.2;
        Mon, 18 Aug 2025 01:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755504636; x=1756109436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUVvU1uBctCztzs2wNlnqspjnxE9qt7GG3hQrK/SzwQ=;
        b=gSOdD4+G9mUNZRYpCuFyl7aKit1tYrbl9XQXUSHOmVcNe6fBJdJS+fmcH7v11+W6JU
         M6rKJVYinnBH4/shA29lzdW1qwGh0JLlV4hlnrO/lL54XKyy+B3UxBa7Nl/hkBKzKb3S
         MQZpJTVHo6km81nZ21tmBuP4esYk2Q7UdFrzY92RF2pQZhmWbva6HJuTst9guwBwmeMe
         T1xVTjQeuL0bux116tnfoybesN0G9rwPi5IBr46epLkL+oT9zpwVBmae7KbWOsw1EU8I
         ErlLnH8/SP/XBdvmVEnvUgI8N0YlFehWec26F/4/Z+Dtsntolei0EputZveGaCBkK1nj
         Yx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755504636; x=1756109436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZUVvU1uBctCztzs2wNlnqspjnxE9qt7GG3hQrK/SzwQ=;
        b=fU47yFEiBZYIs8cvWZyUFq2MbMljHoOu0n2sxZpMXu6mhbZkROZGgl77w0Q0iVh2Vv
         k47gihorp+a6tlLbMSxpWAOe3ppJ5CBVdqKuE6tSOSLGt3+m/PHrhpe/l7yV9pYf6DUK
         2liMJNA27GHyD/RpHGp4Ldd+nsEO/9DdaAy9OtVq0YuPOg470pfAi8YB0nKGAkzrSOOh
         VEQvJSRtJJzsZozp7+FSSk2+BnmEwU6NTIiMySXdu4CVK5U2XSmnKqYiSxUrFRPS4i5Y
         pp05me6Z73c419cHZ8LxZscZFZE7erTTfPAVoXZjWxZmmmdHEoKLM0O+7+s5CoXn8xsp
         qEZA==
X-Forwarded-Encrypted: i=1; AJvYcCVFIk9QVw4Y1bd2ARpNcwnMuW3EVwvodX49a0FFn1NI//WKkzjGVF6TSdVnH1XzNUQaVSZcFy8JX4Cu+r3NCDM=@vger.kernel.org, AJvYcCX7nLljBDrssd1F2vHPn+KFfms9IvFJmFLpxlXPTi074i/K3XZ9+tJpIUvFsb1ZnB8AfFvJfczWJYakOsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbFeNqjm0HJvrXFj5YaB4oA7FCF1nLB42PrYC6BtqHLwz8jBUU
	k/Zl8rsCCMANufQpd3z9lhtWQl5DzOw4fsegFm8gI5MoIIv4EPVbgIbnAPkKQ8LN651NB+HnFVc
	reY6vTH7EB5xC96aMm5kfTBQfhiJzcpA=
X-Gm-Gg: ASbGnctsYwarI3ai7pOjKi4Ajo1fH+825iRWeorCdZ9UcWC2Auv29vckGp7FMx0EPsH
	boQP2WU1ZVS/b8y9omZwFi+otOLRv+O1OsVASDo4NaJ0f03/RPTfpWlegrInEu6gzhfAY84CwJq
	h9eBaDy5C7NkmXpiBiXHhiYWt6sZxbYTvYOwfeg95jXeQYCbOoNj9I5cP3+/WHbedh1tfmKS9TA
	l46q67H
X-Google-Smtp-Source: AGHT+IHIWHi8BRGRmQDJoZZenX8s7AKHn1BINGsP/5Vdw9GJZlNrhOwh2AgUjcAd0gxja+K05XVkwyo0OYIjZTkf6ew=
X-Received: by 2002:a17:902:ecd0:b0:22e:62c3:8c5d with SMTP id
 d9443c01a7336-2446d90cecemr68517795ad.8.1755504636400; Mon, 18 Aug 2025
 01:10:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818012648.1841387-1-lingfuyi@126.com> <CANiq72mTDbosz6NjJax7Mam=RgjtrQXrtZfvawr9V1LO3FfMZw@mail.gmail.com>
In-Reply-To: <CANiq72mTDbosz6NjJax7Mam=RgjtrQXrtZfvawr9V1LO3FfMZw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 18 Aug 2025 10:10:25 +0200
X-Gm-Features: Ac12FXzTHpEndOsM_99oC-Ic9CIub9LhGCmCElnk0Ji3DUGHPwjKJp-h8r2s0CM
Message-ID: <CANiq72n3dFKiSiJd3ba-5-o1kMsSFJ6RSEJjto0eg-1s_zXr0w@mail.gmail.com>
Subject: Re: [PATCH] rust: xarray: optimize lock functions with inline attribute
To: lingfuyi@126.com
Cc: Tamir Duberstein <tamird@gmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lingfuyi <lingfuyi@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 10:05=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> The kernel requires using a "known identity" (typically meaning the
> full/real name) -- please see
> https://docs.kernel.org/process/submitting-patches.html#developer-s-certi=
ficate-of-origin-1-1
>
> Also, please do not resend patches with the same title -- you should
> increase the version number if you do so (or, in this case, if you
> just wanted to Cc people, you can do that replying to the patch,
> saying who you are Cc'ing).

By the way, the From header, generally, should match that too
(otherwise the "From" line gets added in the body, here because you
use a different domain).

Thanks!

Cheers,
Miguel

