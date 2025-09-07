Return-Path: <linux-kernel+bounces-804863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CA8B48108
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 00:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D478B7A7D01
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 22:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323EF223DEC;
	Sun,  7 Sep 2025 22:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFWfvdOm"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5066420F08E;
	Sun,  7 Sep 2025 22:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757284181; cv=none; b=ucUhAgpBLLPJ9VcL41iZdoUCnDKb2+kNSPjg5x2tmAySFr+aV66gTFPwjglrX6AJeW23nomXeWYgBe04IjZfLiyk9QB/naZKPjPYDIeZVUE2nNX6ygOhvL2B57SHriytiHpQm7xdr38C5mOa2cqwlR3zi75Ljl4AzPFQLYSCTvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757284181; c=relaxed/simple;
	bh=CSBO26MzWvBbOHeZQly5SGEViHpBQheuuUdPvZ2z0YU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSiGaBuuVNyUxJuxrIsnCXc81HyvvnHYknlAB9pgowVdKOXs52DNEWZ0o4SjYIcnPVNZAzdhGBXJ4n8TSjNyZxk4Dl0qwrl8EB6ALDrkrDskwWdAGgY/httlNDn4AHulmFJ1qr8gqeiZaNYawcj4Xs9fxZ4pHsHV5qGk2iL4fD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFWfvdOm; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24cb6c57a16so6904025ad.2;
        Sun, 07 Sep 2025 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757284180; x=1757888980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSBO26MzWvBbOHeZQly5SGEViHpBQheuuUdPvZ2z0YU=;
        b=BFWfvdOmkAsE7jk4oezwlPFuMXbFjyDCH5Oio0EAQbCVPv54Kr4jxbt+KzjktPsvcN
         YxY9xLb21Bd3en/IqU7/MDSXelNgVGgk4EcwcPegtzyKS172bDd3mkQHJj2mqvXg3SV6
         qlI5Zd9r6tlP9y1F5tybsdTnktl1s6d33xK9fuW9Po4dHADj5NH9gptQQovpb8K2iGoj
         0FMUH2mY498WEZjmFf5HyLoksyk87w6HOSfsL4p0k9P+n12fjQcAhWyg/Fr7rOXnABn/
         BTIBWsOB17c6/tV1nORbSUWeXz9CpSdOk7/SetvAo3jRfGFJ0Ms9kZiNb5lg2Msg8+F7
         Y9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757284180; x=1757888980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSBO26MzWvBbOHeZQly5SGEViHpBQheuuUdPvZ2z0YU=;
        b=PA78NJZzDNpcGq2vUxK07hIn5AUHyhjILGITK4T7JL9WaWqUYfCGwbZO6e+3FmfzNB
         WIDCoBB3F3w0F1okbLiL42oiiHdtGYxJv8co1pIRdiO2b6YJudh5bZ4tBIYMyZ2FAYdd
         xDtMoJzFuLMGIs6idDLFEWXXgGB/8zp/mb3MActnpujRSVwa4kd3oM9vtBUYxyHWduHV
         1xE0gmxPCvQqcn++gFSXXb1pQ48VVznBcCkxgW71rVGYTg+lBS2v2NSjx9ubc1yn3qf5
         aQCEsR5+Z05dTc9FTnV/RKwue6qEBV3Ja0nucsUXF1Lfpzlca5h/g3bmLp/h6bPzaTPx
         k1Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWO7+q9qG/b0Hq+xgkrTCAPYdek8l85JP/2U+CLRogL7pnRFUoj3xIx09c+o41Vsrr0JyhfLlmayFCeJwQ=@vger.kernel.org, AJvYcCXhQjapP4T0w4UzYA6r1kTHyC5GwQwfKmHA6jv7EohLSs0210UwBlz9AvKijyJzZl6mQ9sBcirEERVKgC1gA/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJqriH33SCDazcGSJGeUMc8KGQRHyPGajL8spIW2F2k5NNtQIu
	5yjugnV83cGvceFPCsfCostiTjDaWeLZKB9o8N3cSZLBaxcuKHwSpRH4loxTw6b10airMa0tHAE
	l+s8TCyDKg2ynS4TfesiUudbROujF7BXNJRXGUQA=
X-Gm-Gg: ASbGncs58gzl2szYDBZn8I8mo1pkhI9bcQobhPbgYVunyev1oGJEhM7v4hLSrynPeda
	5jWZnpurR74aFnWMK5o1bU354t70ejz9BY6yxG3E88IOfDlQk/OCIM+CQK+sV24H+UKeiink0hf
	d2R5q9xZXqJ0C43ldVmkSUEUGIl8y6dJw4wsdBIJ4NEyoTLsHWGUlw4bjeCS7c44dtObOczmXHj
	67nd1EUJPYQC/5ZaCved9h7+xL2iTvrOrKYH9kblJC/lK4PFrDpwjeyPViLic8n9cAgDKvPm8qi
	dIawM5rLf1ogBcKH7o9msnCFqfpnzDOg7h53
X-Google-Smtp-Source: AGHT+IHmaxcQHVJWKA3/eYS2zGDb5C1g+sVPs2hAm+EHVCPC76dURhszoKZ5XmqWdssWwb29K1HFjNcmnpupuDGEnmc=
X-Received: by 2002:a17:902:ce83:b0:24c:b881:201 with SMTP id
 d9443c01a7336-251757ba959mr44505205ad.9.1757284179564; Sun, 07 Sep 2025
 15:29:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818191034.523381-1-shankari.ak0208@gmail.com>
In-Reply-To: <20250818191034.523381-1-shankari.ak0208@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 8 Sep 2025 00:29:26 +0200
X-Gm-Features: AS18NWBFRH7WDrNQsts2w13-f3ht6ZYxQWYZCeA0iSIU1_J2bW-4BINRBieZ0D8
Message-ID: <CANiq72kswZD=2fAWhzOPAzPY_H2CMtKnZSL664Q5jy6WvwcWwA@mail.gmail.com>
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
> Update the in-file reference of sync/aref.rs to import `ARef` and
> `AlwaysRefCounted` from `sync::aref` instead of `types`.
>
> This aligns with the ongoing effort to move `ARef` and
> `AlwaysRefCounted` to sync.
>
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1173
> Fixes: 07dad44aa9a93 ("rust: kernel: move ARef and AlwaysRefCounted to sy=
nc::aref")
> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>

Applied to `rust-next` -- thanks everyone!

(without the Fixes tag, as discussed)

Cheers,
Miguel

