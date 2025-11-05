Return-Path: <linux-kernel+bounces-886458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE12C35AA3
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 13:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 697D534DD1F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 12:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33F72DE202;
	Wed,  5 Nov 2025 12:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuX8P9iN"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCE82C08CB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 12:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762346066; cv=none; b=AIl3ZERS4S+uxZSl8bqNNEYVeCvlxNP0ZqH3lcthhLMqQnDywCPJdrZwQFy8VQNvkqq3Jyko0oenk/GXF/0spk5QnSPJtKaqWM2LDQqqQ5xVKiIj6/sDMloB5LzhUZN8wNWo+dpIGZIA9+Rv6oSfXFC/5W+U5ppKHpPyM2XTV7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762346066; c=relaxed/simple;
	bh=hGgkV7T4rmn30fGeoZ5wtAASpC64quKD9rauLEzLo68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHayh8Da5CnKd1bBTRof6k9mGOIkyI40pNUa+3h9FRPtknKB/FimtB3FvZRrUCmUBzMZ1pkzdmr4CpotQEXbkYgbQzH9NKfc6C33cJg8lhyhyEwfJeNMka4vf9yXON+oKEL74mh0614xJv3YncOiksKxXJ2r7ntStObD9LJ/m0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NuX8P9iN; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b8b33cdf470so420660a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 04:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762346064; x=1762950864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGgkV7T4rmn30fGeoZ5wtAASpC64quKD9rauLEzLo68=;
        b=NuX8P9iNEy1Bfbo+holgYWZRGL9w45u1qpDpmMCuzLckZwmgiVumzVtqPQhopUKZ0Q
         pkaTFXmySyodvysKLPKLqjiR4hWiDSa6tvTmGj4tRIe7EMpVX8qjVdnpj9HCn72j3ft+
         AmjZ4u36YjptFCZS6JzvmprY2nxstElRmyySV9u4EukvpdAxb2wg/ckIkXvoqC64U+fh
         G1HZ8d9fuuQs/EUoKookyKbUuRlI8tl9URUbmAFaO3/keoNWs65kL5+QKmBWdJKbYP7s
         4b7PzJF8KN74HBtAdqh+1hQvwXFHr82NJEIAIuwp3mpnGJU747SXNEZuGC2buSivWnyC
         da8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762346064; x=1762950864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGgkV7T4rmn30fGeoZ5wtAASpC64quKD9rauLEzLo68=;
        b=W7VIbPN3StPK2nc49GxyBU8lX4rRBxx19JsKwRT5YxmJ5oFwd1RBa6csowZLEzRi8F
         27vU9GjToXzsUfclLCyb4wPuTvjttzl5qzSRcPKpnIuq6omdZiIGXyi5zWMuAtegzzkY
         VOG/kuKRGz+fni37d5CUw8j6A9C7BDGoglTxjOmCcF6OxfTVZjcd3+QujP0U/aWf3QO4
         IiQ1+nGNV7YV/OzPt3nPgsm3gYC0RNDVP4gxVTOvsSVvuPzXqRZOsH4AHAZPnbaKusO1
         ps/prgOcf+lFJ+bTcAMtwpVcsQDhHbO9D7C+fuyUNLL78xOgJ/FwBEiqnrfzrvJLtkS8
         U0yg==
X-Forwarded-Encrypted: i=1; AJvYcCWLYUTjTwp8jX+PXgR4yqhvjoo9woe8ra4ujVUGyB9ksM7VWrJxA6P11X3+rbw2xD+XBzG9jsexwcQzwCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiMZbS7Xlo1d34UpbMdGqd0q64CZ1WXRBupUEmZp+KEZ7kB+ig
	kDrkgGS7LlssVKrKK7qb8/qTomOdNZq3nY9luc5CvwYSQYI9LsfZiHV9UhgcnpUgMwQG0vvBaxx
	axHE3h+CRsZuqOPVUW7ZGTsHr49M6o6Q=
X-Gm-Gg: ASbGncsO2BvoOQ7jNso75H6Hz5UPF6673X4QcaaCqyquBvvWbr7+Wf2+rHZnNjCib9E
	f61Om4JHTXCDDlsmbXEa31DTgYUmucpzQGk/KqDkKhwYbbP6ecR3dB9kNy5wNUUZ7Es12Z0lbXQ
	tFmUts0bINmPprBZdMT0fnDVKWOWbYdKIHkBV0KDDtxDVNb10l4R4cOf1GVIUdJYet2ZFRUOcih
	xg+aSqqNxv8TW4MA6O5c6sMGJAiKdBzPgQpZN+paUNW96B7Y8sfh2os3UfDXNvkOQ9BBdamoM1R
	liNzb3vzVfLDZNRcRF1KFwzF1YOKe6OAHVrnJnxu7hMS/tHuX8ZUIXsEQF5Y5Ei3kc3mgqhhRrf
	gXBU=
X-Google-Smtp-Source: AGHT+IGPnGA77HTnkuEDn9KaiHykchcjd6679IPhyR8msMD9QFespo3cGAfPkq4UEjnIJP148VVjxRLdqZbT7pFCMEw=
X-Received: by 2002:a05:6a21:9187:b0:334:8d22:f95d with SMTP id
 adf61e73a8af0-34f83f0aa57mr1863124637.2.1762346064162; Wed, 05 Nov 2025
 04:34:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101-b4-frombytes-prefix-v1-1-0d9c1fd63b34@nvidia.com> <DDZN5VK2OK1W.25NNI77Y315WW@nvidia.com>
In-Reply-To: <DDZN5VK2OK1W.25NNI77Y315WW@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 5 Nov 2025 13:34:10 +0100
X-Gm-Features: AWmQ_bn6XvvVgDpvhYnwlf3fpIlTTtT4AhIV5g4ThaMmTVf9z8pF1p7dtJRdTJs
Message-ID: <CANiq72nedDTruFvM0Wbbp+DL9n_3yte4Mpb4SsgjG7=H=bJvow@mail.gmail.com>
Subject: Re: [PATCH RESEND] rust: transmute: add `from_bytes_prefix` family of methods
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 5:56=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.c=
om> wrote:
>
> Rust core folks: if this looks ok to you, could I get an Acked-by to
> take this through the drm-rust tree along with the rest of the series?

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

