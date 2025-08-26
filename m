Return-Path: <linux-kernel+bounces-786315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F30BB35833
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C403E7B61A2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8692D6E4A;
	Tue, 26 Aug 2025 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7GGlgEd"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778E93090E6;
	Tue, 26 Aug 2025 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756199266; cv=none; b=F0YXs3439C0iQrl/A18gY5QdcMhZx57FSM4TkhNmTrAMkIh0Yl3slnLEZeg/NoS0IAZG4RW1xPf8RzUamaPiK65lEvC8WvoeicF9Bt2EBNpvK2nnFx99FYpKUmbbEuh3oj2T2W3s1jRXZt6LIsURx+6+fEYhpSx3d2hr8OO6/7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756199266; c=relaxed/simple;
	bh=nzBzxwGce3XN2nG/onW7E89qvRfgd9avb1fan3ulgHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m0+pq+7ymYtzz+r6HPZ8jnkON3wvpbZLItPS1NIr0G+VWWEHpdJkFMDBHN5jgjrTwv9Rkm3X7A/RWocvYjzYq7hd/SaNk4Qf5elWBZdJJ8dkC8wrPJxkDT6vMOICUcCDitmdg4ZWogs3SiFEt2fv5n8eHmMjHxkePH6uly8svvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7GGlgEd; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24602f6d8b6so9749405ad.1;
        Tue, 26 Aug 2025 02:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756199264; x=1756804064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzBzxwGce3XN2nG/onW7E89qvRfgd9avb1fan3ulgHU=;
        b=H7GGlgEdhHPH+L7D8gGfhsFLO27OTmW1ZuTX9M+CcwPRmUSDDlZhiHvmeqxSJQS+q4
         sMbwK2y3tF2nfXH4nGsmlG0MJbch0F73XWDn4oHiEDMXbj6bR3F6WFc7Wo7btbk+rEH5
         ksRZkmzb5JKJZZCOuEMyncv2cjlMJE7llWeusD4Ldak8n6oPxWmVN3lQsw8ni1O+qEMJ
         y24UQ+fjbRfEzSwqwsYDSRmepapaClBzB98fapxWDxwillAU6itUVIGCLdX4/VRzz0Kd
         YMA6nnHOw0K6sLUXeMzxC5sLh8vWcBrmrbJePAYTRiUeZcotP9S8ovx4KD0HY7kJKqcV
         KUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756199264; x=1756804064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzBzxwGce3XN2nG/onW7E89qvRfgd9avb1fan3ulgHU=;
        b=XiJ4yUelA1rmNY9X7yTwKdkoL296AZe5Xa6X5i7gKasGQUJtTxVxulVpgipO5DS3yg
         lXTTMPRwFZniRkF7vmcqTbCNjA3nDSpgqCEwVepiYM18+qi+CwjYXYl18vA1zEfCZ+ar
         VGkOdBbX4ix5r8HyYWEHagc+JlcQqfSa4zqrff/t9hEXDCFEsM7HpdVQ6nqr9bEErGNA
         YAr0e2T5OspH2jXaB4bYC6fWdINo2BiXqGbImsfCZWicpFWUP2j/xCxXAvb+1Rxz700R
         fHBXEd1jMKya1ppXkRwVNpiaLoRvO0rX8jGNWB/7QOaMN4Av/00X2pnVGTSWf1u07UvO
         nzHw==
X-Forwarded-Encrypted: i=1; AJvYcCUe8AmCGyGj5l4kGqE4MOWtf4TJ73naCMnz47EPkNdeYVLD3xT+W/Ncvp1aAdSWv7LTD2AOrCXvTQshuwNFPYQ=@vger.kernel.org, AJvYcCWTqEsm5VBtZBWI4uq6m9P0Q3Y1lDVG5LGdxJl1kL/39Hb6IgTect98dZd/7u158wCUnc5/kdQWxvXCnLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLB2cdv6nXaCPtugubQHEk3kkFYzkBpCH/GQcbUnoab2dIMyFR
	DWv6IG6mm7goeOeF2ou/ilnM/tDJIYvTGA2oF+faJYi6FuOZzSbgaPOOZj5AqatVenB01Xsl1zm
	zW+nUfT767rc0Y0zvwTH+yiObnuVDzYL9MVBAyFQ=
X-Gm-Gg: ASbGncvcSjIgJSOyzU8hmWGqO6Rfn/JO0n1p0waXvLd+GOQkO5rTuIu1f4PP4FtQpBM
	N8iDcEUOEgBIbN0gZ186AWiaO3wFd1rGXgHzVyCXvFdxovIY/a9QPaAWhKAu4MgmbUaWapP6rT/
	7eYgqXHlYXiAsz+AsjpbN1Ag18mgDXQzgzv1VP/kRMoj3Ij51Ugm629iroue6SatQRSl8nl3p7u
	zlAwCK4Giv9ceYqvFbhlisWy0RpF/fChhFtwTAeDbgk9VtOmuy9H1YPw/Y3gRlU0lxyKwjJk6Bu
	ZWQTovDZnWlFgNfhLxeD0yYNYJJoYfOfK+cM
X-Google-Smtp-Source: AGHT+IHviai/aWVF6O8hw3ma3Jen/05CjxVkJXrFc/5hzBHEyqZ24YiwmmlLkeIBg3c0OJIEgOO+JqtK29ZKuIznp+c=
X-Received: by 2002:a17:902:f711:b0:246:5d07:842f with SMTP id
 d9443c01a7336-2465d078881mr91958675ad.1.1756199263652; Tue, 26 Aug 2025
 02:07:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818191034.523381-1-shankari.ak0208@gmail.com>
In-Reply-To: <20250818191034.523381-1-shankari.ak0208@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 26 Aug 2025 11:07:31 +0200
X-Gm-Features: Ac12FXyJt0_-wAJkRr09YlZ4FwZ2WYoXHlCeUZO0L7ocM5ipSnRCeofa7oCofl8
Message-ID: <CANiq72ktk6yR7vw7FRKFxEA8Zhc6MA6+EoBGnfQ=wL_t=n4D4w@mail.gmail.com>
Subject: Re: [PATCH] rust: sync: Update ARef and AlwaysRefCounted imports from sync::aref
To: Shankari Anand <shankari.ak0208@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 9:11=E2=80=AFPM Shankari Anand
<shankari.ak0208@gmail.com> wrote:
>
> Fixes: 07dad44aa9a93 ("rust: kernel: move ARef and AlwaysRefCounted to sy=
nc::aref")

> Apologies, I had missed out on changing the in-file reference call for th=
e modules. This should fix that.

I am not sure if this should count as a fix -- it could have easily
been an intentional, second patch on top of the move, so that the move
is minimal to avoid modifying the lines at the same time, which is
something we typically do/want. :)

Thanks!

Cheers,
Miguel

