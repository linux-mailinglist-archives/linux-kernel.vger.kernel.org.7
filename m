Return-Path: <linux-kernel+bounces-808935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 724C9B506B3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6BCF5E2FF0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB0F322DA8;
	Tue,  9 Sep 2025 20:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmGcvBCO"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9542FD1D8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 20:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757448370; cv=none; b=Tbnp2EzO/vN7nXS/Zk1DkNWZ3bB56IyVf3jMb4D9bxi9M8R5Na9lGjDPUEaj5Q8ud03rDeWhCCYp1SWccpgaBIjzZ5I79OIHtJBlqwK71cC6QHEfMSUPF3GgwubersgzhnVsp99AHoIW7C1Kr03nFLYp7YHOdiwvV/b/KOt/gO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757448370; c=relaxed/simple;
	bh=Sy7PANXEcnJRzO+JUjUbY/ki/kQU2URyHERMut01QRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tOSQ9NhUdsKREwvuIsJZaG7VxUygplAHFIJCEvdigqXGGqhqo8aX3mPHAorgzQ586flCHzUQSGY64tvwwgwPoiwwHZR7ggpRNErq6n6Jk4K5NZx0VdlYO0kYHVyNj8FwkPAbqUYq/DYuB7pXyMzcws19lD8wSI/Enb+PVbRsT6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmGcvBCO; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24cb6c57a16so9685615ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 13:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757448367; x=1758053167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sy7PANXEcnJRzO+JUjUbY/ki/kQU2URyHERMut01QRE=;
        b=FmGcvBCOxFkWep6HRG5jMMfhTobihr+xyTGb9QrJAQNQ+aZKz9l+BrXGgok578RC+A
         0/kGMS+cJLKK7Va9whLMKkgcPdqY8bwHAlO5s/xH3d5Odn7doG6ExSKdACcWdUJ4BmuQ
         /sCcarMTShcdL8HjCqsNJF48BNcWCvKFk85J0W+yVW5z0cdepeyJ1jQyKgGNVF/+NSpb
         u6JOBBXGDxGWS6qyIQvEwhzElYmFmhyqm+V8Tygp8ydcVwFHomFP2sdw1jWsr3iasFMI
         UVsJSCygNV8Vitu2+b2zI7zqMFfiRT359Fa6VAdPUD0pYe1DWk4o0ndHwjPflv4aTbrI
         y9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757448367; x=1758053167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sy7PANXEcnJRzO+JUjUbY/ki/kQU2URyHERMut01QRE=;
        b=hm4z9nYUCc6peNEmPgloYHAlDrG8r9BPtphD0g+wOCDGNkJ0YQjPuextbMKlQFFOLc
         AnQlpDrc0u/DSu5QnKOPgagyXc9SKT+RWKXMJ+8lPI1eYdAgAANufySQsfMgWJMqtxJf
         whm7P5ZaBYCoYeqWeWlEi9Ax0jWn4FIa8tqL+xO+ANc0C93uRnxaIisPGJbA+qcbgjeK
         DxQMBSBOZug2wWAhUFYKsEA4y2a4u1w7yeir/qInxCusB9eYmlW5oRMnuVd9JRubSd26
         y8jFPKuv66+Q5yrVzdenB/EI0rqyPqI9PP3YTFME83Ils79QFVaCiDrJIa0paSeKYMl6
         i4aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVclfppJ3Es/vvfea1Ww47EblQZh/vFvAps2+m3tZmc0X1uyoglDwS/F96Lsbz2CHKZNEJInNlmIQAIOcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlOLuBfEqhHNFaVrW/gYy5u9b5TrIXLCqnX1mIdpKWaF58E+Nj
	YY/xmPwczesZBZt4PmZhY+vvt9RA1bbmU9HdUzIWQH33uztQNhL6zQ9/T4ccpNXs3IKofH6ubSn
	+Pag4iARuTH3TKMBrZzrXhnii+pnW3w4=
X-Gm-Gg: ASbGncsHCrCFkNz/3MTKgzrLTw+1MWn+jx20MckCt/+HxJVJ5g8LqmuTz3rr02/MlX2
	NloIo8evYZENZF5GNbhzL9B6dcicJ7dSPoYChM2rxfOvlRHFWPYR3ABw+ywJ+SzvVkDCUQZ7FWs
	6SdJULadY+9lskEaCIetdkaaO/eZ+6S9Ik5oFivvAAs/FBd90wV9/pbJj0l3qJNLoBnmfxC6dTY
	FlUmdTe/76p63uE18QZndbzFGoqQWqLo1eeXKQ3dX7+uG1HBaVgAv7D7DvbEkoJF7Titui7zRaA
	/T5cqgYp5zNPLjtcPnzukktBWA==
X-Google-Smtp-Source: AGHT+IEP4KYqs1xKje1fi1736xf7IOzQ0zTuER/dvSVCGv+BSykA10hu16Op3hlA+dmkfWVP/lYeitao4BB7JdM+XHs=
X-Received: by 2002:a17:903:184:b0:253:a668:b638 with SMTP id
 d9443c01a7336-253a668b76fmr85847785ad.2.1757448367489; Tue, 09 Sep 2025
 13:06:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909170013.16025-1-work@onurozkan.dev> <20250909170013.16025-2-work@onurozkan.dev>
 <CANiq72=kWpxpo23JUYTqxwpsY=E0uUvCHgotRuepZpL-qUqXqw@mail.gmail.com> <20250909204308.74ccedf4@nimda.home>
In-Reply-To: <20250909204308.74ccedf4@nimda.home>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Sep 2025 22:05:53 +0200
X-Gm-Features: AS18NWAQRmJ5WxK5ELCNrAW5yN6YV6IFiCPcnvtVOypshoCFMZlLMyJBUIE9lPY
Message-ID: <CANiq72=NrS1cFJec6sm7ZY-UPqrzxHKVvPu67Rze02Fg_xeWpQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] rust: refactor to_result to return the original value
To: =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	daniel@sedlak.dev, dirk.behme@de.bosch.com, felipe_life@live.com, 
	tamird@gmail.com, dakr@kernel.org, tmgross@umich.edu, aliceryhl@google.com, 
	a.hindborg@kernel.org, lossin@kernel.org, bjorn3_gh@protonmail.com, 
	gary@garyguo.net, boqun.feng@gmail.com, alex.gaynor@gmail.com, 
	ojeda@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 7:43=E2=80=AFPM Onur =C3=96zkan <work@onurozkan.dev>=
 wrote:
>
> That change was incompatible with v1 (due to the different signature of
> to_result), which fails to build with my patch. This version (v2)
> fixes the issue introduced in v1.

In that case, please try to avoid mentioning "broken" or "fix" or
similar, i.e. there is nothing broken in the tree itself (the commit
message should mention what is done in the patch). If you want to give
extra clarifications, then you can always add them outside the commit
message, below the `---` line.

In addition, if the changes here are required to be done all at once,
then please do not rebase on top of regulator -- this would need to go
into the global Rust tree. Otherwise, any changes that does not need
to go at the same time should go separately so that it is easier to
land.

Finally, I am not sure I follow the `unwrap_or(0)` here. If one passes
a negative enough `i64`, wouldn't that mean `Ok` starts to be
returned? Currently all negatives that are not codes are supposed to
be bugs.

Either way, I think this should probably go on top of
https://lore.kernel.org/rust-for-linux/20250829192243.678079-3-ojeda@kernel=
.org/,
since that adds documentation, and thus it would be nice to adjust
that one to whatever the generic one should do now, especially if the
semantics are changing.

Thanks!

Cheers,
Miguel

