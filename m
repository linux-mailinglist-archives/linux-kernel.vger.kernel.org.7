Return-Path: <linux-kernel+bounces-897021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D9AC51D44
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AD133AFF7B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AB7305E09;
	Wed, 12 Nov 2025 10:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nASKfrlj"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC34F3054EC
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945014; cv=none; b=ckq7CBcXTqRZ9tEqaZ7U0s1dk8EIvDzAewaV2BT9iJwEnwd8pZHwTyOBUeDZAfhTfpVDr3XMh85bSIhClFN83OaG/euXTz45EBOFT+Q44YanO6jxDFjuN/5DLN8muw/Hn5ft5/Opgmh9xurD0CNG+dTctvazIswoyPuhdBdv/DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945014; c=relaxed/simple;
	bh=TNohQaMM8ZiJd5FBk7HxCy8RYGSgToj4TZLYuUXuyKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kgmoLj0EJ4plFjvUv9tjF38opwF6EHPhhFij5zXd/MaRcTmZrNLa6MnEkPjYHlZyMITlb8NCj6R7VP7MdTr163PkCJmG+B/rJUqEGGh4tAsabYVx14N3QlADVg2zmhldkZe0KNU0DZAoe7Atfq7aDuiHE4sgWZdJtYp+KxIx1X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nASKfrlj; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-297f6ccc890so755465ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 02:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762945012; x=1763549812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNohQaMM8ZiJd5FBk7HxCy8RYGSgToj4TZLYuUXuyKQ=;
        b=nASKfrljVQyPcrhptgG/ufKjQQZy97uXwADgI47jB0uvv/4gjicXfG7FL3t13FEcws
         8HXpupXpZtatRYxzzC1h589b0ljO9YvhPAAPH5FZAWKds8wXu0YHxmtd8IcBKJshZ3FC
         OXvbH92IeL+VehYBk/BniPPo+973GXZLFh5igAb7nn88IJzVpT1ZAR0ye0v9nvbjnK4v
         bYSfSL/Mhq3ArFrWLVHtGBSm2XPff0JUQ4ztdW2qdlnAqO4EM1PkglLaCGY641bV2eQq
         RnWeOvdyGI0m/mgifLf2oeVZ2HjBNounhLQAYlQNGAZUvR87TtF8tx4RMt7orr1LDSAF
         yhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762945012; x=1763549812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TNohQaMM8ZiJd5FBk7HxCy8RYGSgToj4TZLYuUXuyKQ=;
        b=bePsi9TMfn1oQsHenMRSvsTAorLw7MAHNsR/bitECXM4t4QS9i4yn5EhegHcijt/+4
         ko8rIErPLAfpqFvOBuEJGdyNs+DyTlS7TXDYb6LiLhg8nbxvlOopgllBVud1gHU1RJPy
         Qm+PT1Ywyn3sRjW2xX87rPo/sxpMsZQFopouEFeYrQletBDrDFEcQwaWQTrK4UQ5/fd7
         Ry9cuQusDyH5ZpQUJQyXdjqqVvGo9meiS+QpoKo+bIA77Ycq4nqMiVFHyqEGM5jd3YKF
         u4AaQtOxo+YXrwp1u8coWWj9gVWE8ZwpNzpM3K8XFqjikbF8t9AmdCDHSZu3r591tpSC
         MR8g==
X-Forwarded-Encrypted: i=1; AJvYcCUxJ67pbhdd4R5m28MUjtzk7vJRLesjfTWm9PHLsf3QLY0eqOVjWaUhuB8q9yyZxRUZwf7IBQ+jAm6b34I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIbZiSAX1FXPsEtLaLLnZ6pFQlMiUgtGSd+78TBU5vCK23cHHY
	sB+6r91GGMpMw6+Pm2xkwCv6FyJzCFSe5hO8G8hHBjQ0453nOKvknxNQF0DrOOnozN/OCXZqdV5
	hhDDCuYQq1p/4DgBazHVYd+2rcGKPj3U=
X-Gm-Gg: ASbGncuAcx0uMoAnw3bxFNi+UUPxBWylqmQdtopQ9xm/SvYv8d2/MGw1EHD8xKduU1S
	+USuMuZJwRbbhtDknERKptdlDKNR6fTomkqPeOYK8gn8dXKQ1MXoGkcnZ4TRiF3GfPykVDN8oMh
	PktTegDvjR3i2G87sPuMmU/Nn5I42v0m78CPRMBigjpYzWiBY5rudfXpHCaZt5KWUPqtPVUhStD
	Wz34oiG0SqJApCinrGP+aITANR0+qLkwP0RkMILE6xUuy0R7pfCNs5AH6JawpfK21rFnwBob6vw
	h1YHqCqjkpMiXuybYYDV1xkF64lPvwNkr0REcWTjBE/zKHQyU0Fi9bFgS4F2PrcY2J4moHn0RFt
	aRPI=
X-Google-Smtp-Source: AGHT+IHrQNXhY9YMT1oddk0XUMNLWOjlpzyfDcWUjLwcM7Kn3IniWXjD6lX8+8ZvTPxv0gajGvSov9xtpg+vUe5CnfA=
X-Received: by 2002:a17:902:dad1:b0:298:9a1:88e8 with SMTP id
 d9443c01a7336-2984ed82b3fmr20553455ad.5.1762945012322; Wed, 12 Nov 2025
 02:56:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112-resource-phys-typedefs-v2-0-538307384f82@google.com> <20251112-resource-phys-typedefs-v2-1-538307384f82@google.com>
In-Reply-To: <20251112-resource-phys-typedefs-v2-1-538307384f82@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Nov 2025 11:56:39 +0100
X-Gm-Features: AWmQ_bmO92eCjDN6AY2pabBMv1OBSxVkwHvhLYHKrQoHuNDmC44_4_AWypybmTk
Message-ID: <CANiq72mL24KA59E2HDgME4-nhxw7PCvRAF_2XA02SDnre85kUA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] rust: io: define ResourceSize as resource_size_t
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Robin Murphy <robin.murphy@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 10:49=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> These typedefs are always equivalent so this should not change anything,
> but the code makes a lot more sense like this.
>
> Cc: stable@vger.kernel.org # for v6.18

From the cover letter thread, if we treat this as a fix, then this should b=
e:

Cc: stable@vger.kernel.org
Fixes: 493fc33ec252 ("rust: io: add resource abstraction")

(Replying here as well in case it helps automated tooling to pick it up)

Cheers,
Miguel

