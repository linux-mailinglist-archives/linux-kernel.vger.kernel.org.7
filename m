Return-Path: <linux-kernel+bounces-898909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A6682C56493
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6B6CB348481
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CC4331A5D;
	Thu, 13 Nov 2025 08:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWCBgB3j"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E283314C3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763022744; cv=none; b=DaceMX/D3g0jQy59l7ie8P3iyHuGDU1Mi5mQ4c9DIFF9V2+RIcVAu5e0PM9fiuIe7bQQMt+sDckxMH4+Q2fKUYF/yMvoczYE7htuNPE42cDf5vMBQc3yfGIDtTE2Y+VDKyRo5yQcxUgvs+EC7nlmHi0io2TSGafNooj4jT9vLoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763022744; c=relaxed/simple;
	bh=fWkrgCFVGA8ycSXNGT0kHhwFC86H4xheW9omFn7mil0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mke4D1/mqkzxjgEDUM1iyeTQBk1GruY7pC/JJTGQYaZ9N5Re1FaerbOn777iUWt/0DgDntUv1jzUlcxsc5m9pFmgXwEolMhrqoDZhVLZIgWIp/RhMiAfqjVBwrgeepLqXnh6xu6A2pcymb1BOxw2G4yPRY8EU2wfcrAT0VSdEKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWCBgB3j; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-297ea4c2933so299885ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763022743; x=1763627543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWkrgCFVGA8ycSXNGT0kHhwFC86H4xheW9omFn7mil0=;
        b=HWCBgB3jeCsyoD2k4/Py0n0TJNwB4Q31XOwe71egWPg6peWKcLFgMZ4yKo8M+xNhDP
         Llhtr2Q2esM4IohEk9lLugclhsUa6yDi3PrXOUqqDfjQ5pqhPbtoceZUZZMdFtsJyBbd
         fSUj5kLYW4hyW2NFk6O6P964lYetdZihd64x3K8sYhgC2sXJ5CgFuva7nLXYbVxoTzYF
         CAhyAVEkv12R86/fscxbiTv3leX9PoXJVuaazdNk2c7Gi64sdWhJfDSBbp5tfYdsCyJU
         vuG81s32vch7mykcmS60MwBvrk9FWQqk1gjMFaFPnkWEl0vojFfx4inS/iXl13rQMNPt
         r7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763022743; x=1763627543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fWkrgCFVGA8ycSXNGT0kHhwFC86H4xheW9omFn7mil0=;
        b=ZEEh9EvD7fvezl3gXHvfO5hBAlb9Hv7+kMac+95jKgziMXrqv+gzKxyGyCyuQoyvY3
         df1FO+t83QvAUdgc34JPZKdXWP3MfK6ROEiMIW+YfkEe2DSU/NhQXQHBQnZtqvw19h45
         TG2YM68sRsAdNO4J8N8W374W4Z3beKkitOBegqB3zty/65e7BpUwzWb6QRKIs7Ek8BIt
         hH7BSEGmZkcq10+EeqQsxuS0f5YQqCGuCQVMuQfe1W/+84Ke9uEnzELHrA1QEEEz+fTM
         Tcfq5wf126MoOJ4HYq4HUUv3wjRX+ObKfs3iL1VAUiEGu3utRp37QqRsy8dp4x5NHqAL
         VX/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUB3ER4KkiAHwxeHTmBNy+1aABRu8YKSlSLjX81WrnnjAePnvoM9Q/FHQlSBOHEiRwgJvUcouiQ8wny428=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWNkU5bExLeE4zw8jhpoiOOT7INNH5kxp6eLAJapsyDjSLMB1x
	3ISEc2nCV+1iuDDPiQfwnutjX011Id/6MmWObuc3NKAJchdk//pty4462lNaWfOmSN4B/n+68JV
	ATHPoNgbwto8NBD/y7vLQMcHH4NeI3PU=
X-Gm-Gg: ASbGncsx1FVC23QFPJajBrmEjBeDir37H95rhSZZu0Y0jxOLkN4WdpNK7FI4GKzoIbV
	a3KDPfhrHCMMCJgMQWp5Zww0tbus0NUCfssU2rEUxPbtk48hLUPnnzas1Kkyt9bDDHyNVnKZYQY
	9NH3AS8haBAH5PK2Ro9UFGVYKw8pTDBEabHiNm8em1t7aleDdAdOh+CwfqsW3oJv0dO5RGgRfga
	LrGyMVo3zeOtYOQ3IUZtupEfldAgr5c4NvFGKytZ/OGDT42sNXdSTKiEbFEDPsUY0XTAIj0sUnQ
	/ZKefsp+SmpyuV9kCHMX4p14a7k3CDIoGk0o8H0JIy3/5s7LrTqj8XofXd6znUQjtig2q65VESF
	58p4=
X-Google-Smtp-Source: AGHT+IE7NyIjARYCoGXVPLTRHyIS4snYyg052NinbmAvhieV0+P8KCl0oiy/F+gMZzxUpEmb7fGQGEAaoFBYjjzJirY=
X-Received: by 2002:a17:903:2f87:b0:295:586a:764f with SMTP id
 d9443c01a7336-2985b9f7747mr14629275ad.11.1763022742721; Thu, 13 Nov 2025
 00:32:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112-binder-bitmap-v5-0-8b9d7c7eca82@google.com>
 <20251112-binder-bitmap-v5-6-8b9d7c7eca82@google.com> <aRTbX6RPsFf0NW48@yury> <aRUZq0Fo6T1f3lOD@google.com>
In-Reply-To: <aRUZq0Fo6T1f3lOD@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 13 Nov 2025 09:32:10 +0100
X-Gm-Features: AWmQ_bk8GPBMLXEykGlWHqadm88w8ZM_NALuaQkEK8ERifzVwLi-vw-oKLW7SeA
Message-ID: <CANiq72najqKYQGWpc9UuOnDzPELiFB3hmFYmX-7pk8Eh7zA+Rw@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] rust_binder: use bitmap for allocation of handles
To: Alice Ryhl <aliceryhl@google.com>
Cc: Yury Norov <yury.norov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Burak Emir <bqe@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 12:35=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> Although we should never hit this codepath in real code, I don't think
> we need to kill the kernel. We can treat the r/b tree as source of truth
> and adjust the bitmap when mismathces are detected.
>
> I could add a kernel warning, though. That shouldn't kill an Android
> device.

I guess you mean warning in the sense of `pr_warn!` instead of
`warn_on!`, right?

If so, could you please add as well a `debug_assert!(false)` on that path?

Thanks!

I will create a first issue for the combination, since I hope we can
use it more and more.

Cheers,
Miguel

