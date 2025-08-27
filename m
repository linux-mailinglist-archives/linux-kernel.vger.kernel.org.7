Return-Path: <linux-kernel+bounces-788684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E7AB388AE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 19:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229F717D957
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3DA29D291;
	Wed, 27 Aug 2025 17:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zBpxi8j+"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625B219CCEC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 17:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756315876; cv=none; b=SkXun4VCMWdB8KFD9Ux2K/D3h4Ft4mNRYFGq/H2aQwVGTFv0IDhSYeEHXqDvmeqXM0u8FSiuMeY8qUy92dubkGENICvC9o2neu/2SVFLIKF+69aZLJvRD6A04ynJ3fyq/9/aez+xCHHYS3Uq0IS1IPfrbwajGUkkUfFcgrTu0l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756315876; c=relaxed/simple;
	bh=Or1YtCo1m/YUhX9dpsqsIrPaYwB+P2dq/LEd0lL+/Wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDhY8YvYorZ8RSr/YRcXe21PoC2EDKi2sun8/oX/a7FuzTk+uUgETHzOsOeZcOiHhdLv+wY7RMVA/8KlNKVNSUoyVO5HHwk/x0xrTHxkd9QYF8wZ4Cvk8gv+I/IYl3mMqj+ODlehT7fFBVO60YqLO6AO26B3OYF15YO43Q87D6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zBpxi8j+; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3c68ac7e18aso43213f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756315873; x=1756920673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Or1YtCo1m/YUhX9dpsqsIrPaYwB+P2dq/LEd0lL+/Wg=;
        b=zBpxi8j+8x96oi0aPWc0G7yLKVPOJKslX1cYJGGulQPHWihBJYe3UK3FfCBkFez9ZN
         ONuK5ZasTtZrgcs9byT8feQBoOvBOLsWZ2lNxByjbr4wbNfVgvXUo3hGLdP309X43MNo
         uG8T1Zh8ExMEc3HpQYjecM2Nmp8+mP80axT4g9OftTXVe51cSeCLjKqYDsIlDvIrK8fT
         4dAZUvK7vZ0X8W1WVXzAfvnMh4N0Ko4NsO0BynO8SlGa+J/Rxom7wTe5t7o54+dzrXOm
         99ARNpktjTz3QS/tJ7EhleUs7SznETOp7LBCm7C3Mtll8WJPRmESNI8eBDovNwkrW7bF
         x6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756315873; x=1756920673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Or1YtCo1m/YUhX9dpsqsIrPaYwB+P2dq/LEd0lL+/Wg=;
        b=FmeV4LBv6K9dKidFioiTXKz/eNZsp5chME2xzqVnAmOmoB3fUQExT5MUnYqfRS9vAh
         Jsk6nMWUT/Mw7qIb9urYrN1CBVwT5RMpgh+yNezXn/CkR6x+2cYAn21cxl2xKA71irEY
         yBbNpp72brtv/fN1Yx4hzf9Aq++AmdffQVWG0395Os6h7iUvFphUdfRRN+OOaUi24GMA
         YZ8J2fSS/uCHPnNYAIPV5+xl49djHt543C9p1rof8dz3+NE4X4emN4fT81LtJaGucazx
         aKq9S5DMSSCtk429NHfFYM54cN0pSVJP9COV8LA+zVNl5YIGwwmaOsrasmnKqUXSOh8R
         rX+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW8q4ld3SbmpqG0lfmi8hAlanIzMzWmHw75e8Vp+u8+r+63O6WsI6Yirk4e60f9KB1oSrvI0LweDAIb4fU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcWNnCFxZgDRO+3m1M58YwS7MoZfLf652xyhmeCzDmFM5qfKzK
	sUOTScYeeg+mJI5SEZMYDT4zdCHQslWdyP37pzBbsL+h03CWT1EWGW2xWN9faZgO4CclnNpu7t9
	WiOYrnTHMHfbVFu6qEV17PRCg3y/c8rmb2BzVDpXD
X-Gm-Gg: ASbGncuXqTkDJPYkrmzvueS5SmanRpTICHsPHJbWN8784fSA1X3H5zT53t5lZzGOD6x
	bi+s6IIR6YTfy21ycnMHMPLcrwT769oE69jT86xyhw/5JkOSqOmkHqevCM84TQq4t336PwNpvth
	YVwqAsrbqYtF4C3/Oi0BIzKnV4NxI9+CnyVUGtumWQaLf/QuQI948o7MqQPywBhD4bAVymznFVG
	D+krQlp69AdEYs4s9tR7qu0hznMKYIEDZhMVwUniotUQp0=
X-Google-Smtp-Source: AGHT+IGc7d8Pq14S2SYlUEH3xU20sRWuSFJKCdfeEnTmu9D/gpsBAVtTzNJTf3E/dhzYSTnSXR1XNWNmY9g2cqBDGtk=
X-Received: by 2002:a05:6000:2f81:b0:3c9:24f5:4711 with SMTP id
 ffacd0b85a97d-3c924f54bb0mr9843614f8f.43.1756315872503; Wed, 27 Aug 2025
 10:31:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814093046.2071971-1-lossin@kernel.org> <20250814093046.2071971-3-lossin@kernel.org>
In-Reply-To: <20250814093046.2071971-3-lossin@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 27 Aug 2025 19:30:59 +0200
X-Gm-Features: Ac12FXzOvTF883WqSz8gINB3T0AfVGe4A5ccB0Utfotj0gCC-lsWQgkVt0ROKd8
Message-ID: <CAH5fLggOfOFj+v5vhmF0m9VhBUeegAT7Y8NR3++04LKsBrJPEA@mail.gmail.com>
Subject: Re: [PATCH v3 02/11] rust: derive `Zeroable` for all structs & unions
 generated by bindgen where possible
To: Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 11:31=E2=80=AFAM Benno Lossin <lossin@kernel.org> w=
rote:
>
> Using the `--with-derive-custom-{struct,union}` option of bindgen, add
> `#[derive(MaybeZeroable)]` to every struct & union. This makes those
> types implement `Zeroable` if all their fields implement it.
>
> Sadly bindgen doesn't add custom derives to the `__BindgenBitfieldUnit`
> struct. So manually implement `Zeroable` for that.
>
> Signed-off-by: Benno Lossin <lossin@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

