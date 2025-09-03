Return-Path: <linux-kernel+bounces-798235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 909A2B41AF7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5945016F809
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405292E3AE3;
	Wed,  3 Sep 2025 10:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGOVOp8j"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B702D3A6E;
	Wed,  3 Sep 2025 10:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893800; cv=none; b=k5WLlT8ZB2LJnHfKy0WDBs24BWv5dZ76BUFzEAq/DaC4ZD74OGexz8yi+diU74ljw0o6OEQrSheqO6vO2KIPWyy2brfxGLhIa0toCH2R0/pW3RNWtPeKp1j7czu4R/jZTM0qXpcrk6k8xHD6gdJQUrh4cGsSzpZh8RZZT0IcKaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893800; c=relaxed/simple;
	bh=0ZPxvE++kjDwbZXPjF0sDxxNrHcRHnaI9qILXHsLE2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CdKsHUWb8KY5m3vy5cDNjMVcRo9Emx47b0FPYyBwDnJJqm6v7H7YCnPEBwRX51sDnTBR8/s/x38Sd6QgRIIMbpcxciH6NB9lm92YzViP2d/ORy9vqi8RwqISoHqqiPPYOmUAsZEWdwLbWdZuh+5S1gUIRkT7jVMsHj/ef3VNmC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGOVOp8j; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b4716f9a467so802777a12.0;
        Wed, 03 Sep 2025 03:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756893798; x=1757498598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgbMRQUc5eRrRBiJK+N/XxrKzBvJ2dEhNy/lilwY3gg=;
        b=WGOVOp8jDjmF4Hi5b36NyExqeKaSxOIKq5BzY3Gqj+wSJm2DXJuVuOVQ57SOBWSjbk
         HMdhWylrM7Zg9m5zacMUCpyWBX+W1ANagBp518qSTg/YaqElXliBP4yaok4EKNU0xQvd
         PTLlJw6Pc9Uiai0n61E7jUHIb0QUKUhoGWRWqf/n4unmQ1xHyaD0tYyc9c4E6hFGCGot
         V4ouxldjZBYRH6OBz3iYqfLjSr0CvUXII3JO+7ODFbXBPGuoFDI4T/AnDXM/ymhQC9MJ
         ZZJRqY3n0sl93GjBjrqYx4H8hFJ7B5zq+NJicXkYTKKPKdn/fVtkdf9Qr/PT4HfzLlbj
         WwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756893798; x=1757498598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgbMRQUc5eRrRBiJK+N/XxrKzBvJ2dEhNy/lilwY3gg=;
        b=Qa4IpEclLv9m1nIcGRkgzJl/XdqlKvr3NHYVbwS3+aowyrKzEHVHd5OW3MWmpJOQav
         qsh57LroSzikJAGdvlSZGMILpqmy6wg4/tEIM+DDOn2gYqTxp61jG3Hj9Gmzl2sNaHhi
         kFvcahcvbPV8uhPvNu8cz8YSz4rYg7/cTmOkSFKVPlbk9Ik+YcwwapLA0+/5h+AsMaGP
         i4RaXtgosth0oIQEkVxOH7tx9VvVLLCK8AXx5yr4NqIZ+wqr8TKN60YHKBupiekkOmMB
         zF+0ArsaBv0ih/5tsR+cNQ6EIzhnsylg5d1lyTfsqbDH+RsbdJZU2Cojp3AI0KSFH5TY
         aG5w==
X-Forwarded-Encrypted: i=1; AJvYcCVrmRIEUf8jpNyml3vDcS3y+CgGX+oDsQjXpFvvgPJ3uxVs9L/0MEIwWZ7hmu+iwRkUetqMQLUms372c8Q=@vger.kernel.org, AJvYcCXv07/ya5DHn86P+RYzQrPvS3Hmi5o5Q/wIQyXWmx4cklc68G+Y4mtITKF+EYJQ3YdrYnvkdrbCYwQ5myLlVCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YylYD7eeeaxDotiLkhh6oBVZXLHEjQ2L6erm10dMqwDmWjqXPiV
	O7OC4+S1Ti8UifBcGrTvF07SvR7yhktuvOJrGRasPTB2gRWjPRHC24u0gPZMrYayJtQHNdbmkKE
	cuKHxfhGo23FNlCEjjrHytVXx18JGFoI=
X-Gm-Gg: ASbGncue2TTiob0LPhZKO9zIMtyXPhaifutYV8qHrF8KtVjdr9MVF6YcGKXjIoxTV/J
	RoBW5E+P6Q8mPIvf1zqGbqV4F49vZfjkDgsnNKrHISXJa6ZD1SHxNY8xwvG8MT27XLeh36cLdzE
	p4nhsKVBskZDO7DDRF7BLPAlOCJGalx06GIhGZq/AJNUz25gXvwdZxKfZmjSvfyLz4R0hrGJF1E
	1FVQ2x1rTpbpaQxBbu3LS1HG/ZXRoCVj3GBfY7Ps/PWBtCFXxziAuzDMlXUE2Eo+8fLR08GMUUL
	bTfTpxRp8RfU5IzBtjE1ch6Yn86yS556QhGJ
X-Google-Smtp-Source: AGHT+IF1drbJnXtfZZ8zYkcNWKkBm91s6BKPijOBEDVGIWtcvxdjKU4Tan7TbgcI5ovaMpvUsGr9yGVrgGP9Pwve9jw=
X-Received: by 2002:a17:90b:1e0f:b0:32b:7082:b4 with SMTP id
 98e67ed59e1d1-32b70820446mr500316a91.1.1756893798517; Wed, 03 Sep 2025
 03:03:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829192243.678079-1-ojeda@kernel.org> <20250829192243.678079-4-ojeda@kernel.org>
 <CANiq72k7_GbFwRxW5vikF_SpiNcNm7Ff0oe6jyYX_voDg92QFA@mail.gmail.com>
 <2025083032-barmaid-rising-a977@gregkh> <CANiq72nAagBBPhyU3XdETMKBuFPbMMRaSTStWPpyLnByYPP=+A@mail.gmail.com>
 <2025090325-drinking-illusion-ef3d@gregkh>
In-Reply-To: <2025090325-drinking-illusion-ef3d@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 3 Sep 2025 12:03:06 +0200
X-Gm-Features: Ac12FXxbDdR4QPlJmACRMoGL91T5xgbMv2dg4TrsLcHw3W1mo3SjnyY3z7tN85A
Message-ID: <CANiq72n-R_NaMzWtYe3430RwOpOtmxb9KP7ee5FxV+AHXGA2+g@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: error: replace `WARN_ON_ONCE` comment with `debug_assert!`
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 11:46=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> There are no "constraints" only a definition of a vulnerability that we
> must follow.  And for that, any way that a user could cause a reboot or
> panic, without having root privileges, gets assigned a CVE.
>
> One exception being if lockdep or a few other "debugging only" options
> are enabled.  Those are explicitly stated by their maintainers that they
> should NEVER be enabled in a real system.  For those we do not assign
> CVEs as they should never be actually triggered by a user.
>
> So I don't know what to recommend here.  I strongly advise against
> adding code to the kernel that can cause users to reboot their boxes if
> they do something.  But hey, if developers want to do that, I'll gladly
> assign CVEs for when it happens :)

Sounds good to me, thanks.

These are meant to be debug assertions, so it should be fine. We can
be more explicit in the wording of the config option.

Cheers,
Miguel

