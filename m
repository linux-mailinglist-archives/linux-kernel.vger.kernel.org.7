Return-Path: <linux-kernel+bounces-860846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD19ABF123C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2C03134B14C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E00311950;
	Mon, 20 Oct 2025 12:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sxt8BRhI"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A092FD7B2
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963033; cv=none; b=QTykQ+32cQkD43qV9NHSy/eIoV952vnmGc2No8wMQL2U8PwEvy4igt+5ZrQncNmXfCEBy5Vnp6Ou8AziVP3m6aBnN9ydC8ETLf9odPVNRwAQOf77tDK/+tDVci3QoFbe0pDC0T0D0o17LEx/70xRQAIwE3eH513T9ZafNzoyAv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963033; c=relaxed/simple;
	bh=xsVrddNgKdsa59i88tOUom/s0Tf6ykU6bezL99BIn20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HVKK3UHCT9McZ0m7EKXe2XuAowDy/uFKRKu2ImXkKejL4pSIXVa+PSF4WDLPI2t0vVHGUfpgBfVLVAEFLx43h0YCIoRduFn5WP8ksyhe013Ux2U81aICMZiS69DRkev5JHQFWBR0KjXnREERoXQdNM2Va5RaR8O7L4hjBULJBcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sxt8BRhI; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47106fc51faso50918705e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 05:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760963030; x=1761567830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsVrddNgKdsa59i88tOUom/s0Tf6ykU6bezL99BIn20=;
        b=sxt8BRhIXDtx4vu9KqP17PgMkS+Cc8Wf5VnW9SPMpkawYQFCW2nJ4UqDokOnQ/BbOP
         1UKoNPjca7BshWAGhdLF4sM1dXQDy4YkBGp3VhyH6zetcxIGWlCYeKeNKsX8frNfx42P
         XP4hW5S5UsXOIllauXGcuR8cMGiJNQJK0ut0424GQnez6x7Oj6JvGHtNHR0TxhSgwX1x
         xN27l81GfgUbDp71FxBU21EOtTZbCM2VwzRAheDehQCkQNIJFmv3MNr4G+46pMbpp+kJ
         P4bcNgolPKgt5uNNvwTN4qFjEpPUa7aT21sjQi4WyWlbR+WOlx6nvcL7RgqgyUowmerr
         UDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760963030; x=1761567830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xsVrddNgKdsa59i88tOUom/s0Tf6ykU6bezL99BIn20=;
        b=vaRlTaMiiM9Bxg0EnptcGrSdVnaSZRr27SAuNkymdjXfh2bmGbbbG5KqbTH7+B/8HL
         ZCAlV/hAkKsU1nScxZiSbKyooa0iMokNO9AH4XeoDMDayFDBJGXpwXv5gbEmmC/jdbtK
         jqhphdNVCRMikJaPBsMVm5MxQdyuJZkJ423qwcu8a3REk/ClZ3SdCzM2g6Z78LFBU+0c
         ZyYCNwn5QBaIWSBckk7MPVQueGd8qBY32bEI45liVHWIdU8Ou7fKUj/m5JBh17XLX5o/
         IQGPEW2Hkcu8JLh4V5mwHM+gowhgQTdUp+cD4twq6FtKLKCqeNZNS5zF/oJAOcUZ2Fm+
         xXaw==
X-Forwarded-Encrypted: i=1; AJvYcCWsLvIIRrk+Ps4q0I/SUZM25JuYpdOuoT3FFfYDXTphV2ChG8ESbA4LMDQ4MUyy78OzBQIec+Pqfl4TJr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN7zIm7iS9YI28+GOuilwpKe7UqPkQQ34/5Y1xBmk+KYCQJ785
	lfSVpOUnBglvrdqoSdf+WDi6cEFKm3vnK64Fa/Tn9AFckjTzw9wcEAU0TdecUAR7JpW2n09LFp/
	O43JpeyD1ZwYnuGZyrhr9/ZGZ+sLJYnPtt4+e7NjR
X-Gm-Gg: ASbGncuobZ8YUrAoWNG4do1sJJu55EEKj/pAJ0WRMxGFNlh0qrd1IAmlLJET7cmmlIz
	ZNhBzKz65cvRtI98TnVer8g/UW8gMVIJvC6TICkbGsMb9wwOLS1iC+dMD6vCPB+wwVqXBi+bQLM
	tA0rDJZbxdi0ezft1KCnIbwrp+TstmJqVAKyZ+EPAtgtFWpSMoAB8nc4rEXRe6HBVHHGtdVvRts
	HP9GOSQKounBOuffAnHbo46chumseOlY6f+V41155YBJIqWTpOp9ApRyX/WtXrUKPLN5yPJ6mIC
	HJa0+RGXn7sI5To=
X-Google-Smtp-Source: AGHT+IEzDxQ99eTVFb1p72eG4BzDy4n/ljYK7KwPaNsss7sxyo0CST4hlFo6R49mTS4MCJM90qjBH4sAGn3rQV8UuQ0=
X-Received: by 2002:a05:600c:1d9c:b0:45d:d1a3:ba6a with SMTP id
 5b1f17b1804b1-471179174dcmr105272825e9.33.1760963029708; Mon, 20 Oct 2025
 05:23:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014064120.263455-1-lukas.bulwahn@redhat.com>
In-Reply-To: <20251014064120.263455-1-lukas.bulwahn@redhat.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 20 Oct 2025 14:23:37 +0200
X-Gm-Features: AS18NWA5B7IaPN02pGfQccVfxUVjCyEnsxCY8l0rw-xGHW4tso6TZRmVCMfMeXA
Message-ID: <CAH5fLghsp6UXy9ghYe0bS7ASty-VrDLVwRkmOt44Pr1sU6vvag@mail.gmail.com>
Subject: Re: [PATCH] rust: drm: remove unneeded handling for config DRM_LEGACY
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, dri-devel@lists.freedesktop.org, 
	rust-for-linux@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 8:41=E2=80=AFAM Lukas Bulwahn <lbulwahn@redhat.com>=
 wrote:
>
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
>
> Since commit 94f8f319cbcb ("drm: Remove Kconfig option for legacy support
> (CONFIG_DRM_LEGACY)"), the special handling in the rust drm code for the
> config DRM_LEGACY is not needed.
>
> Remove the drm_legacy_fields macro and simply use bindings::drm_driver
> unconditionally.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

