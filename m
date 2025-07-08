Return-Path: <linux-kernel+bounces-721356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7768AFC815
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D676E3A5B6E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6347526981C;
	Tue,  8 Jul 2025 10:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heDJNNvB"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709081C6FEC;
	Tue,  8 Jul 2025 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751969793; cv=none; b=Hlo6vl8GqvwpFX4v9UpopdDhuCFYnRcQUl2GuwC3JUHMGghM+lJj+cjYDVupyscTVMW95EqPOwbTXNsTwrPN6WDWE1MNGC54l7Xfv4OqdWw5ccjRqDkhjaZjIGNWSF2oKm3X9wjhNDwRp8KbiiwBKnJWPa+IQOFq85b+cbHlLD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751969793; c=relaxed/simple;
	bh=Mu2agmfNzU1947N28qDPAD2DRXup4PY6h7Z5E3r0lUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cRdZ7+R6XTgJd6lonYKtfxtqYXCEv2T0QNWjONkrCQl+wDH2Ruy/JawMlAOLGleSOXeglo1f8pGzWa03YxGP3v2avYSp5de3rzo9PlMfV/jyoVqM45irDiQCqz+notEfAp5Q/PAycAUo7suyH8FuWdWzPzFl4tv4wkog+ZudpJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=heDJNNvB; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-237f5c7f4d7so5871195ad.2;
        Tue, 08 Jul 2025 03:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751969792; x=1752574592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mu2agmfNzU1947N28qDPAD2DRXup4PY6h7Z5E3r0lUI=;
        b=heDJNNvBvLNIjStZ4hphML3HbKBPKhtxDHZtKY0GEIAITSZOnYWO7/DgPNRc5DDIem
         4ICEY96ZqmBC0FXMIzjUeT4udUTas+B9I+Bkv1ZopRqieVUNOmx2cBti91fgeuFeIBJl
         60/xNFU0fbpoe+RnLsSaWK+PHoCoJMLrywIJojSqM2zFROtLdKb/ev0kb1nMX5e1tJJ8
         1SAPzjBZiulVak1v7j3PzN+TLGU4kK9Ew9YP9io8FhjapqKi6Y5cs2mwl2eG8fa0H1A1
         dZ+zUCDBTs7jUHCiHVR0BeesuKc+Pit56Sd3fkQhcMtK+aOMNG3kRb2WCa8Du5uL0qSk
         CATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751969792; x=1752574592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mu2agmfNzU1947N28qDPAD2DRXup4PY6h7Z5E3r0lUI=;
        b=WmBg4/xkmCfy+Hxb/pVPFbmdOGgezSBALLaFgjESkRlv9sHqCiPgzoFKsEMRdSpWJ5
         zXrWoWHwPxtILJ/5s5y2ll7oc6kH5vK6z4tlOiHi0y9duMpm+Uk5BwKBpQ6RIAg1awyU
         QO2gvOfdov98mQDMET9/mOWg5A3y9AWJt7S5Y+o/rEt7dvKiWOZpqvxBtPCJHFxtbQAF
         8iuUzw3docBdkwu7kyaFpMEHg7j2mQFNPLgSzG/Y+6KAhf9gmQjC0yKYIEMCFclNqhGd
         voCqAcsIvpqbqJeYUdLZtCwE0mVPFUnpILoOh90KI9BmT1adfo1yp4OuZaJURonkOz9X
         LmiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcP7GAuH6RoQLcinOGeJWCHIx6EbwDLlfiwucJZsQ4YsHUAU/0/SMJsuMPGpJmM1zkWdMItFuK6a+9vew=@vger.kernel.org, AJvYcCWfWxYSDXgjNkeFk2WSnoZlgNlrhoAwmxSqmxPUMuCWf37VL/mjn6iEoAI9pf+h+jCQAk6LAOEiE/OrDR8Oy1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7q3S4U8zdZ7F+G+OV5A3E7fUiwdFWc/2ZUYM3EqE+2qvqzx2x
	20uKGznHUQc4FlwXV81o7LIUG5ionGNgbM4/7mcofnp4lUc/PLjij7LvFZGKdE6hAZR2Pvl7H1T
	YRVJeVszYr+4KdmNAGAamEQ736gS4d3I=
X-Gm-Gg: ASbGncshyXRN5sdaFu9y7rUVWx8wf6HAe8hPCijLyNzmA9mvfnUEyhFppZ80OjJjLua
	Mi7r1KpLfruc1lNk21shvRzl+7moceDLebOZqlFmayecllAjuzKdDwDOm/8iaNbjnjhnQsmrSzT
	smuiMZfDgC2phhmzuxI8Ynk4XAxS4IYwfTGbLBykkRqnC5
X-Google-Smtp-Source: AGHT+IEtiSDbVtVY2B0pLNW44Ytg7MQuZSNigbC2JZeHZUhFXRF5LQyHh/k8dU/GxbIoUGVN8Hqb+K3w2wT9wrlhH/I=
X-Received: by 2002:a17:903:94c:b0:23d:d2d2:b51f with SMTP id
 d9443c01a7336-23dd2d2b7dfmr9180415ad.10.1751969791683; Tue, 08 Jul 2025
 03:16:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me> <20250618-unique-ref-v11-1-49eadcdc0aa6@pm.me>
 <DB1IPFNLFDWV.2V5O73DOB2RV6@kernel.org> <aGtv9qs682gTyQWX@mango>
 <DB5PPGOWNW4K.2C5A4UE9V9IEF@kernel.org> <aGzrZqIrStGD_UBp@mango>
In-Reply-To: <aGzrZqIrStGD_UBp@mango>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 8 Jul 2025 12:16:19 +0200
X-Gm-Features: Ac12FXws6e6wjl4VXaStMJYjDvz_KB3jEXK4Nq0GnlHUnilneuNT3cDnqmhb8V4
Message-ID: <CANiq72kWFYS-inzFPTQAGdPRBr7MffZLR9q7iWiT_j2w_e99MQ@mail.gmail.com>
Subject: Re: [PATCH v11 1/4] rust: types: Add Ownable/Owned types
To: Oliver Mangold <oliver.mangold@pm.me>
Cc: Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina+kernel@asahilina.net>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 11:57=E2=80=AFAM Oliver Mangold <oliver.mangold@pm.m=
e> wrote:
>
> Note, though, that I already moved it from types.rs to types/ownable.rs o=
n
> request. It seems to me different people here have different ideas where =
it
> should be placed. I feel now, that it would make sense to come to an
> agreement between the interested parties about where it should finally be
> placed, before I move it again. Could I ask that we settle that question
> once and for all before my next revision?

Yeah, if there is a disagreement with something said previously, then
it should be resolved before starting to ping-pong between approaches
with more and more patch versions. Reviewers can forget or they may
not have read an earlier comment, but you did the right thing
mentioning there is such a conflict in opinions.

Cheers,
Miguel

