Return-Path: <linux-kernel+bounces-804644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF6AB47AFE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 13:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E051B3B879C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 11:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598932627F9;
	Sun,  7 Sep 2025 11:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n3dXKfQw"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ED925CC75
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 11:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757244826; cv=none; b=J0RXXK5/uJnQhOdA+/x38l+4uUjw412ciH5leXlHQxNNVdS0YkNtAfofBLO9iZ6K1kPin4uhAn6uGU/QzVjWy7aT8tdKC3mk3zDDVV4UrCDGXDVTKPAm+yijzL81t7QJFhdMWK3s6zChyA9gqJpjK+lI6EH4jXY+WA9nhiiN0kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757244826; c=relaxed/simple;
	bh=x/5am34huXepJCcawFjdn/9LhzouNu+bZlMGrTfGLs0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D/b3ul8rQs0g/2NaZuFsQj3ai/4dm0//3krRt7mjoqrzUvDOzW8+hWFhm9tiLe2XwHKnQ0pvPWxvtdDCT6sAiWifzGpe1U8P9dByNAfbOV0+B+e2dgVjj62cD7LoqML1PrwzOskKhvocBALJoyyvLAsq7BeSMcjMIeQS6b5sbsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n3dXKfQw; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45cb4f23156so18463295e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 04:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757244823; x=1757849623; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/R8lGbzqnwIDc4eQKOATvFwf+sXQZDlB3YpeC90/y20=;
        b=n3dXKfQwRXvhEuUeIAN9D64ZBHvu0xVkJBJ2BuH/nJ0aGQHH0Q4M1CO/XzaDMO94Sz
         SMPw2CInhCHev8JiR9wK5lN/9y0kRrHzi4nwTg/fknIdiFN4OLPOktTHSm6n7PiLegvs
         ntqlF2ZD/iTl/UO04fA460P9+NeB+ekwDByKOg+MeYCeMuaDMvBzLdfHQULs/Lbr5poX
         t4luGPO3hIKZbeVlraWIJD4zdGK8rPKEjgkN2002YJ4X0O0jClgpFwV83YrstKTWI+D/
         8i0l8ENTap2sNQIS0AJ+rqMzUkClLKpTQuyssDoS208/+32UP5IsElfIe5AreDXyk0AR
         T1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757244823; x=1757849623;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/R8lGbzqnwIDc4eQKOATvFwf+sXQZDlB3YpeC90/y20=;
        b=NOqWj3izsKf7JnCRSAw7ShRSNQr8CT+lXFj1Fgo6kxByx7Bxcp3arrGoCcxvhiEOaA
         PLncT+QZCSoSqw5h08eL6RB7L6fCBDS5C4XAR9YJzyLfUoV4SkuDyVFO+Fas9zW3tgyF
         hIat5EYmbyO+JXCOPmYIhs/jLHFNiGRcrL0pnX9CxPjtUHna3ggdODC+V0JbgMcy/bqD
         Qv2xJFgZreSwJkTm+Eyknx5qBau7cef1r/utej5VPIieXGxGgwQSAj75zmTcMMCuIClG
         d7PmpYwXyg65c2W27rH6mAAgyyyxPJqH6IZDpuvuXJdY00tW3j/owV27+QGtl2mqjKXJ
         TsCw==
X-Forwarded-Encrypted: i=1; AJvYcCX8zzDaHYIwOCjEiKEI+LGRUV0LxYCqHqqyRaeMom6HtZgpn/MSsgTvsgIFIr103u2qWqiNIA3RE2IJneU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUwrPIm5Aa12aDaJbSyuZoGqJAjmd5nn2HqsFo5TDqNjTAxiyv
	sSIgEg0o+ljEqhiny/p/FsXvkPi0McpRCmPvd2lJfxtAUod/rS2EEmmyi6EmOcvyzA6earBY3Nn
	vvW4th7/q093PL9fvig==
X-Google-Smtp-Source: AGHT+IEy+e3S3O+aoKGHPH1G+6qJeWq9D8heiivAshi+Am1uetfW+/PvRgvQ/VNB0LSOOQzthMzNa/JBPKQBz5E=
X-Received: from wmqc10.prod.google.com ([2002:a05:600c:a4a:b0:45d:dbd2:ec9a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:35cb:b0:45d:db2a:ce37 with SMTP id 5b1f17b1804b1-45de2cf982emr18269065e9.0.1757244823652;
 Sun, 07 Sep 2025 04:33:43 -0700 (PDT)
Date: Sun, 7 Sep 2025 11:33:42 +0000
In-Reply-To: <DCMJ0VFOV9L1.33BPI08N4H7WZ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250905140534.3328297-1-lossin@kernel.org> <aL1lHyhzWX0xGrmo@google.com>
 <DCMJ0VFOV9L1.33BPI08N4H7WZ@kernel.org>
Message-ID: <aL1tloBwmJnYFPpa@google.com>
Subject: Re: [PATCH] rust: pin-init: add code blocks to `[try_][pin_]init!` macros
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Fiona Behrens <me@kloenk.dev>, 
	Christian Schrefl <chrisi.schrefl@gmail.com>, Alban Kurti <kurti@invicto.ai>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sun, Sep 07, 2025 at 01:20:39PM +0200, Danilo Krummrich wrote:
> On Sun Sep 7, 2025 at 12:57 PM CEST, Alice Ryhl wrote:
> > On Fri, Sep 05, 2025 at 04:05:31PM +0200, Benno Lossin wrote:
> >> Allow writing `_: { /* any number of statements */ }` in initializers to
> >> run arbitrary code during initialization.
> >> 
> >>     try_init!(MyStruct {
> >>         _: {
> >>             if check_something() {
> >>                 return Err(MyError);
> >>             }
> >>         },
> >>         foo: Foo::new(val),
> >>         _: {
> >>             println!("successfully initialized `MyStruct`");
> >>         },
> >>     })
> >> 
> >> Link: https://github.com/Rust-for-Linux/pin-init/pull/84/commits/2880a9b898336e2d54f80715f00ce00f21f74d2f
> >> Signed-off-by: Benno Lossin <lossin@kernel.org>
> >
> > Nice! Would it be possible to include a user so I can see it work in
> > practice? E.g., for the irq feature?
> 
> Devres needs this too, but the corresponding devres stuff was a fix and is in
> the current -rc only, so that's not a candidate.
> 
> The IRQ stuff is in driver-core-next going to Linus for v6.18, hence, using it
> there, this patch would have to go through the driver-core tree as well.
> 
> For me it is fine either way.

It doesn't have to land together. I would be happy with:

	THIS CYCLE: Land just this patch.
	NEXT CYCLE: Land the irq and/or devres user.

But I'd like to see it work in practice before I give a Reviewed-by.
It's hard to evaluate this kind of macro change just from the macro
itself.

Alice

