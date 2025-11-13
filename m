Return-Path: <linux-kernel+bounces-899017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAAEC56934
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B0F313531BB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFEB2D23B6;
	Thu, 13 Nov 2025 09:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRBPlZhB"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D227C287246
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763025694; cv=none; b=SqiMzSgw4MRp9tm6COVu4Lsk/mdIZUp2CSxQqv6jUkBDaL+4YoL9vdRH4Z3Dal1ujnfzMUMJ398zr4UW0CqPVTxWOQm0+aPMlVqTtk3UpxWbyeL7C8RXLbE/Di090XSqrt/p68W4a9Gsm2ewCg7X1lL1EfFAq7xekkjKGPXoRVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763025694; c=relaxed/simple;
	bh=HqJJwnuhSPmFDMkoRfA3CX+LjNXittqjXdLVN3Yi0iU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3vIcFefOgCwxGY5r4US0q1IgmLAfMXF6/sj+qlMP7mDTbEuFc5Zy9APeiws+e0VaPhFoLJmX4xo8Q/xs5g/EtLSvWkkK2b0God8jMmkFG84VyXzK1B40vOUqwrJiYtKpo+sxhFaKfvuTWsP//HmsyAsfNbLkL4dQyvzbNc4JiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRBPlZhB; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-297ea4c2933so326785ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763025692; x=1763630492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqJJwnuhSPmFDMkoRfA3CX+LjNXittqjXdLVN3Yi0iU=;
        b=gRBPlZhBgMtlKS4FUHhr7Wklc6ovQ/66+HAQzRlnu07yM01KYncLSMz8fp5sUgWP9r
         jkSQfsqp+tMzpbxQimgnmH2ZyRDL/+MLi1A64haOlnCD5tCH5lbzj75x8k4w23OmCSBd
         02+45/YFpNnRLIcNqU8smccbsavRMik46agr51zP6Ylec/jg+GYGYCutjZ3Lzhv+iW+u
         2fG36VxT1TrFxpT3w33c/fPwHUm4bnz46y5ir5nN5eIKBXBKwETxxbTeZMZUXnrkoF5Y
         dc21LXpt1lrnM4WyeJKqbI/ItytSc3HtAk6PLFoBz683nnsuJ4509BORzSA4W2RieJt8
         tD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763025692; x=1763630492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HqJJwnuhSPmFDMkoRfA3CX+LjNXittqjXdLVN3Yi0iU=;
        b=GB+iQZUdsIiUhGv9z85yOLIxBR1lCc7eOtDlET4X+zy5g2XGn6btChb+YM/LdNNJJs
         d1W2AjdLQ2gu84giYCd1EslwFPkCfbTJRyI5mZ1l5EZWzTUeA1tMVXjKILGTsLg+ZKko
         P6jKarfEtyn//2WzrCLldodPHpJhS5tzI8Gm2qv8amGOJeUxgB+8FiFNYKyD7bfeZNmD
         MG1ve0d0Q9SAUJpxb00zc3biOOqOvRAODf6/OnWyBimjJfEciWzTYLHhLJY7p2tZES5D
         KCwzVdppvY2IthDvwpIWLdXOdRFmVGsqXM5gUhcrzUldkfKXvcYZLswaAqoZ0M/ymDJr
         l6Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVoRlrLHym9zHs6+GP5Zr0x84HTtG7kvqTpPSgOAu0hizVSXYk1sNdboDsPS2iuULP4N2BhZTdpbvTDwFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsFx1eMQw5FVxack/GexPoIsiePhbC5RmEmmwjKtfk0syigseX
	N9Grp5lcYX15IubAULDCRRAVVkOGWb0F/+yuvhommg3hYIKzQsCZUa3pRRasIwO833/C9IC6L9e
	HJO41RD/oHUvBtgmaVr1ur8iM8gyC0MI=
X-Gm-Gg: ASbGncvHnMwJXD96YTwF4n1tfwLQZ8bMK15dNj/GhglY5RxQ6/JiC5npM/roFV65iAx
	xIFYS6CKQE2tLOZVZcu6Pi/uutsOvcenpvx58QfTOkMyjTgq1nvHKDr4Ybnbne5exSrBNoGjy5A
	COvcXujvIdhX+Volj/d8qOH7AnEfQdoPLunQkaGJc3/acifPQl3KL3W91yy/HVU/bmr9gKxCvou
	zvTpUSy+5PEoRwHg4Tu2Y09J0acYzZGjdxIzCfu9uktDygmR4qCol8XGLsgiIL/GeeKPJghyVQx
	vhXDJ8ujRLRUUn/am5hRVpmIj6CH6YBzMW3Es+IIYpIwUDziueTWSZurY3anRYdDSmLvzVGVnyf
	HBvo=
X-Google-Smtp-Source: AGHT+IEmA0uOG86gaMLms71+k9nerriBq7yV/bNgdSSQ0uGPxv5p0m52ue78t1UkmbjQMf39XAyH4hdMig4vnGuN45c=
X-Received: by 2002:a17:903:1109:b0:298:535e:ef34 with SMTP id
 d9443c01a7336-2985b973375mr15566045ad.5.1763025692169; Thu, 13 Nov 2025
 01:21:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112-binder-bitmap-v5-0-8b9d7c7eca82@google.com>
 <20251112-binder-bitmap-v5-6-8b9d7c7eca82@google.com> <aRTbX6RPsFf0NW48@yury>
 <aRUZq0Fo6T1f3lOD@google.com> <CANiq72najqKYQGWpc9UuOnDzPELiFB3hmFYmX-7pk8Eh7zA+Rw@mail.gmail.com>
 <aRWhakNj7_DGZDYC@google.com>
In-Reply-To: <aRWhakNj7_DGZDYC@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 13 Nov 2025 10:21:18 +0100
X-Gm-Features: AWmQ_bmxEFrPCwsCsz_DeFclRfIg4KeejcDD4up8UdhIWBiaOtxSVGB1gV6kGt8
Message-ID: <CANiq72nPgvzmOJKQHu81k1cvEA34+1XjWGiKmDe2fjyOmSJ-Hg@mail.gmail.com>
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

On Thu, Nov 13, 2025 at 10:14=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> I was thinking of warn_on!. There is already a pr_err call.

I see -- if you end up not adding the `warn_on!`, then please add the
`debug_assert!` instead.

That should help and it also makes it even more clear that it is
something that should never ever happen.

Cheers,
Miguel

