Return-Path: <linux-kernel+bounces-740564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A9AB0D5C2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 202D4170E88
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18AA2DCF7D;
	Tue, 22 Jul 2025 09:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTSS4ybn"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78AB2DCBF7;
	Tue, 22 Jul 2025 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753176033; cv=none; b=Sd95KnF75DJU2Mt0hHoTHLbayeVsF8FKhONmq/Hw1oUG5wUJxIJlVUxoJ2fMKjxwvyrVZvwkanfZMFORMzXHkZedZk9oUSWViU25/AtAmGOo3/6dNw1tevPVS14i5vjKbZfHPeW9ZKp7NcL4Kn/KgH209usYVRFMHfbVwjHGGhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753176033; c=relaxed/simple;
	bh=Nn9sCHDMbM7M13uC5Ckzj4+kXEm/XS8Z+xrifEuNhEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMNK1k0LPwhzgWmknJJh9Hs8BRmBISXDymXEzvqUbOcuvfS/pjd/iBEpxjtpu1qZ450mKbiFQOU5pS0vaELfgf0DYvgqaM9sWcqqrT/QhcHDC24jvPuEBqk+x6+lTJ8UNAo6ldEeWFVhJ4RcSJp2+5dH/6Nb/1hKyNjWaxh1P4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTSS4ybn; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-234ae2bf851so4974085ad.1;
        Tue, 22 Jul 2025 02:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753176031; x=1753780831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nn9sCHDMbM7M13uC5Ckzj4+kXEm/XS8Z+xrifEuNhEM=;
        b=GTSS4ybn0Vnv+StOSAN2VggmlcOHZ3TqD2tIuYR1t7fkfXUPd7wkgxu/s7biXenVyS
         yOF1SOewJR3itjj/5+APXcXp+DOsHDb4kSkYfAGOCA5uF4pbdumsx6gVMiHVIXCXVNvy
         ksoIpdFQp5m7poM68NlKAvC/HgVHsyQiZJQOyvagIN8z6QHgUQqB1NO1v6ylxhmT0dux
         yDRxY4IrXmW+EWaCz1Feie3Bn1YCfXAwwQs2fZ1YU23ffT9TOpp1KIybre+26RbHFHGQ
         KoQY3W2TlE1HIBR3fHgy6j+eRjvNl+a6yFBPV+u9VwgF9LNPNswH4aZdaWGr6mIQU3e0
         Gdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753176031; x=1753780831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nn9sCHDMbM7M13uC5Ckzj4+kXEm/XS8Z+xrifEuNhEM=;
        b=vev0QGIwrlYspGFRH4MbngOsUGqfTUEoiakSQM5+G0e+Uuw2xZGuBDLcmZebmF8qnK
         JWsu1amSFEjMtVwR0fxpmQwgCOTHe2ltoaFUHbJuyW1UAiyh+LTramAae7+5vIFqjiIC
         IR6NDXZ3l6gJOnZnvGHqG3X0uWlB0Imvj9xJRS/qGtwFRawpmKm17ixzJujO23P6+fkm
         oAWYBAVZkUvxt/6Uf+lmFqlMlZtjpxBln9ydOUvvQ2s5xoEPeZGgG7ROZLNw1B4s0MRc
         uj0BRyCB8Ko0TKPMVbM/yCwr1TgELSMQiikwCYqs7gjeyI+N/W3+4tAsh3dE0NblE8TT
         rjpA==
X-Forwarded-Encrypted: i=1; AJvYcCUcmH8G/znl+hGbn3M9mEutkMxBXmsPXdIjWu2ZBEWn30x3zTU9oLIirRqCASgom0TEd+7trQXmoVVN3HfvyIQ=@vger.kernel.org, AJvYcCXFJWGte7tBRQidCIFOCYhOvLYNqKtltpbknThTGeo6aycSuiMTGZlvIMgYNY+GMr/Bj9ArLmWoZz+ZGsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCPujOoCsb9+2uSIrX96SiiSq/uRP1R0vbhaUP9NpqZrC+YQmq
	kZMejTrclUznXM/H6FDG1eYJMkdkYrkYmFpi1W0lTBAP66qWgtUBr0QcmmHBCcRscfW6RTu558y
	8rCvhfE7i8cyHya/GUwZMAkYVIru2xb37pZni
X-Gm-Gg: ASbGncvhD8WeujK2ia5cXA5CWvw3uvJYtrtDoUWtys6ttBDOSZO9z1sDGmgqjC4eWRG
	+nn7752ansh2qY8k1DCSnL/gQ+i/GAcl4xyYo04C6wpW5bDIF0mdnONyupj11A/tjJPDyKdohna
	bf3onJJccjRbGBRSwuFu9Dt2Ac1v5kom4ESGboqMrRh/q27ox0nFJIVcVzYu/OZWsJprgtmA6+Y
	MDIvDaD
X-Google-Smtp-Source: AGHT+IEoG+ntdvZJtbRwxk5of51Jgz94WQ1WG6t+WIcog6BWsuPvnyj/cU03qQaaER0Rx0RjuH4r3NuQczU30CK1r40=
X-Received: by 2002:a17:90b:1cc3:b0:311:c5d9:2c8b with SMTP id
 98e67ed59e1d1-31c9e7767fbmr13255767a91.5.1753176031145; Tue, 22 Jul 2025
 02:20:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722085500.1360401-1-ojeda@kernel.org>
In-Reply-To: <20250722085500.1360401-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 22 Jul 2025 11:20:18 +0200
X-Gm-Features: Ac12FXyNAwQRmWBDTmd-dEi5WjSAU__xl71rtwNdTomqSodwxeIO5UXzL_1ugaU
Message-ID: <CANiq72nyHPO-zFo9-4-MCmsPrxoQMK046EnvYSsQKCUBnz3MXw@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: io: fix broken intra-doc link to missing
 `flags` module
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 10:55=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> There is no `mod flags` in this case, unlike others. Instead, they are
> associated constants for the `Flags` type.
>
> Thus reword the sentence to fix the broken intra-doc link, providing
> an example of constant and linking to it to clarify which ones we are
> referring to.
>
> Fixes: 493fc33ec252 ("rust: io: add resource abstraction")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---

I should have mentioned that, as usual, please feel free to rebase
these if preferred (I think you don't in that tree, but
nevertheless...)

These two are meant to clean -next (and rust.docs.kernel.org, which I
build with WERROR so far).

Cheers,
Miguel

