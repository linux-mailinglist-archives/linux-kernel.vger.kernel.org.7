Return-Path: <linux-kernel+bounces-789703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 760B7B3995F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB7E11C23FD7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DC530C350;
	Thu, 28 Aug 2025 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANDEJsC5"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433A330BBAA;
	Thu, 28 Aug 2025 10:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376136; cv=none; b=j2Al4meJrQa6TdBlkzOy+wNb85IZMvSMp6IBm42kF2rg21X5L7+t5RAhH/Jbl6M+0Vb88H9c5+T3i73Cb2GMyL7+/Ggjoe7FMjtMDIyqg/ebDrVpI1llyjt1dXdOk+FbXEUw4ydqU4ixlUn2CIkqfuwCtxg5//CU3cHxyDmdT5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376136; c=relaxed/simple;
	bh=QHy9i2efZ8tkwqxNRH6HBfyzmqhrQcjUYGnuYwTPd4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IHELo3rZ1U8OeD2sKeH+AErEvlxmsB3fRICbem9Dpyu9Vyghr4WDs5jFJaegIetScg07C6dI80FAglBPSe8Dd7F2bcM9H9A0vyTXJg2L7Pgy7zr//XIJvKAkkxCiIUuwcer3ED34zwRQ7gSfjrVl00OVGWhT/uNYAa05AD/u6pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANDEJsC5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24896af0650so1427065ad.3;
        Thu, 28 Aug 2025 03:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756376134; x=1756980934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiVOZjj5dX5ezdymB5W797ap7j6lkwqulyL8xQVxYMA=;
        b=ANDEJsC5f8NWTGg8rriIigAnZDWwmpj27IrG2vpNSEI2xCLd89gQtzAEDmySaE8plv
         dbVQ6OAL9nCnja43zdgmWdEDoFQJLOfYb6PG86ulZwjT5pBlrb60gvYPmgcMSnPJV7eA
         ltjQdHH61oCmc/xd+IYXczp/p5HMxfip72XLVz4i27zPkz+DYsnDQEEb610YCBv6GWNt
         wCV/yw4qhFRbPs/lksKGQdj7UCsMrShF0UVkec7ySB2WIO60nxW1MiefeFIW3hhelOIQ
         6aUJRDvE9Jq71yIu2QPsjxi1atmQLbpuYbug5pLeoe0wWz1tjo+kWazoil7q4F9+EyQz
         kOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376134; x=1756980934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JiVOZjj5dX5ezdymB5W797ap7j6lkwqulyL8xQVxYMA=;
        b=pwqjkWj/E+vE4nVojbm9hHSRQivHNWwIrG5kmgM9btpok8dBvE8DcL5nu5HXWxsPRY
         HZrawznhdl175Izied7mr4kmbggYJk9UNivr+l/kz54BR2ugjvJI7w/5d5RjqtuXGkpE
         HufFKd6XPqyRNq+HqAcJpuOAbyjO30d8r/WXxTIkxo02lXJ07AfLg763nKgIpmM4vEjM
         K24AvXHZDUom9f7imZVTDACjEoe3qbd4aCzRBAD0XI7KrgXTLJBYzobO5vp5sLfZZUd6
         eGUzoIZVtiO9Sfd5K2/Fy0o7/Hc7q2fJl4/nP9DV2HZ95uDlkmOhVY/qy0hgp1AOwgVZ
         hH1w==
X-Forwarded-Encrypted: i=1; AJvYcCVxDuAIu+BlwRJl2QVaGrffr/euMOiU0a0OJQR2NR7Un7yCsf0h57yoZJYPqnrEy0Gw55SLqlA4UvBQQS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQapCLzhkWPZam9vjLrgAIDYCuT6Uh7AQsuoNC/SmZZvoJNeUS
	+dn2v1qTkNAMZPgFrnIBn1f7WVLpl21/MailkwKEjl6cU2g/W64mIyG3JVQKQuUXn1xxzqj/f+E
	vcLVBxAjaXjh5iupCxDD+F8U07Ue9BY4=
X-Gm-Gg: ASbGncuw/fvZfaN2fWcutr2fI0pip2sEZouvhwTngId6UWVh65whFrwIvxKONSf2v0U
	X6Kx8bm7YEa9khyeNQGmRb6vbZnWTecZAbnNe5jbszISSN6Vw8Cb8LDdWuz5MvKKFh8hVkLtUH/
	Z/j3L0jr0BG/3sLqdB6Q5BeqWtwtDdgBD1zTRjo+VcyxPhGx+z0w1aBxRX4xB4tZlZ/VvtsRSUU
	P5fvhoulpQDDjvqvTVHUUb0XihCZHv2ZG08m4GfRVKxyJzdRNf3rxCwwtFoA0pn0rkMe0+xWCGv
	4R/Qo4WWUF6rUWAYDraLWkuFO5makxELPj36
X-Google-Smtp-Source: AGHT+IExt0H24cYfDNYRK7VV1Kg5o3DmULfVx2WtpxMereez+JEW+sM1Ye6VbJM8ljuSOWPtoVblQ8wfMuLOg8pnybU=
X-Received: by 2002:a17:902:fd0e:b0:242:d237:a8da with SMTP id
 d9443c01a7336-2462eea895fmr116993385ad.5.1756376134541; Thu, 28 Aug 2025
 03:15:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821090720.23939-1-work@onurozkan.dev>
In-Reply-To: <20250821090720.23939-1-work@onurozkan.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 28 Aug 2025 12:15:20 +0200
X-Gm-Features: Ac12FXyVsdEDADN8qh-rg_GIvdEzdptyAbwPlz4I2qAbcyrPd-Z_H1M6KVwvdIk
Message-ID: <CANiq72kM0X3fGNvD2WKBUHxg=fau+m6dqz+gq5rPyzax_3-ZVw@mail.gmail.com>
Subject: Re: [PATCH] rust: regulator: use `to_result` for error handling
To: =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	dakr@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 11:08=E2=80=AFAM Onur =C3=96zkan <work@onurozkan.de=
v> wrote:
>
> -        if voltage < 0 {
> -            Err(kernel::error::Error::from_errno(voltage))
> -        } else {
> -            Ok(Voltage::from_microvolts(voltage))
> -        }
> +
> +        to_result(voltage).map(|()| Voltage::from_microvolts(voltage))

No big deal either way, but our usual idiom for this so far is:

    to_result(voltage)?;
    Ok(Voltage::from_microvolts(voltage))

which, in a way, uses early return to put the happy path in a less
indented / more visible place.

(I noticed a few similar patches lately)

Cheers,
Miguel

