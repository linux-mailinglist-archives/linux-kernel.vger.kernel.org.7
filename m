Return-Path: <linux-kernel+bounces-818484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9839B5925C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9194E3B4C6A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2175129B204;
	Tue, 16 Sep 2025 09:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SKAMH1ry"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEABF299A8F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758015336; cv=none; b=I9n6pTcDsanE2+i20gBEZXeiccLjgYr5lBG6t/t5Fta0iMuUOOAiVZhLsDFpUBciYApGs60eIzZ5VF4u4Kh26AnOW7VqLr4hKA2tClIgy9ZXa2JHaHPSlUhNBjIT8k7DFccV8RqFXPACIegJ0wdyIoV6COlfeOKyfG1Yygmbom0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758015336; c=relaxed/simple;
	bh=uVJcNQLIaI0TFYuzHf9V948rCw4GzWbCyOZcjnOCgjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ceeylc3DmmMAwgNOeMEqo8iHfBUFDdsJ0gxs5uO7ZGhZ5lONrJH3G/Zo7a0BQerKD1w/fuYCnSsuH/2gU9HbYVJ9m8QpdCbHlQw1nWBA71HF0yInxREk0nVq0EobN1xGLlGLgjBJ1RhRHRymUzXKRxFejWizmNbAGejSyvLeyq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SKAMH1ry; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b5eee40cc0so51299351cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758015334; x=1758620134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItFEEUKNnd6JDkvIGqIsrhAmf5lSlmXXN6ieayVKa88=;
        b=SKAMH1ryj8J2J012Y1bbgYx0UEv6Z2AGMpSXuuQ0c9mXf2n4QbpWNkQ69n0hjm5E3g
         GIQcDL14+IUXZ7hP1Hpk8mkozPlVHa3Uw/QPVxtIP6gTWl7uzZ4kBI7i0jui4+7bDkkh
         Upx9Pyd5Icy3HPeHwbW+o6Zz0F15Bsc2fIrXqj0xn1En4HJ4riFVdj/8Ccod7JDrV8Yz
         41NNKWfJoffNX4o8h62ibuXgY9PvguzsA5NHyqvr8ZbDHG1jTResEaXyaY1rpqpCfviT
         5L/xBKtur7MVjdeB/PB2iCaovNfB/Zg7t5TDdlUfY8ozjnlBkZjIfn3wQwmSO8ZpsCNF
         JxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758015334; x=1758620134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItFEEUKNnd6JDkvIGqIsrhAmf5lSlmXXN6ieayVKa88=;
        b=eYNzGB82q6wCkPd1s6ry6MxA0FtPMDdvz2iHmYeb5s8cdy9nvy1BrfhXDI4w3BZcjw
         bepsmm/eld9iV5ffgE+nY1O6tiuQTHLFsoHVhLmAB02K16PQJkl9UkQ52bbt85H4n1+/
         HL60sbyhd7rT87LTrV0OxFJIdpkt6M0bHzy8UrIRUZLMtWc8no3uJKkNgAxpBu+cbfqW
         L0hN8Yc2f0Vz/Qvs6/OdcT1BT+XKMSs9QUxyOdZztBRgiP3x5IlccSNYk1V8ZMee4QGg
         HOvC1kGGM44cWMJnyQoBL/cg+Ss/3kWnr2x/5YAfzXCtQcT5FlA24yN/LddJLm13MbE4
         fJIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPR7MCLY1OQYUmsltryobCoI1iYbg4KDaja+NgZRWSLF++jCuqKsTcBNWLrkekKW8qfMT8xFYWjTTunl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKsoVvpuE2Vo5vSyHDBLjVX9iEOFs1EQfY4I7UcNK3Pgp9/TDK
	mGAeDq/MXh8gbw1ib3L4IeEeo7HAMLa9zPlzijX6xBHaw84dW9D+OMHn0qbFfb5sMtarlgVvl2/
	Dnxh1jh8PLGdq2gFnpvxkgz780f3U/m2IzC+DCgA/
X-Gm-Gg: ASbGncv9B+wuVZ2kvqjoKgHuVkf4tI1op01kyHtaPGiB753hjNsyxNC24kvP3ZX6Dhy
	nOOxHiTlch/Pbx2cuEol/RG1AAZt1bboKrWOplEH2HdrNZLN4ek/oSu5jzS9dQV+BthMDr2bt8s
	YLuE0gKWwnwhvCvFrbHWqJReLtXGWBIfc4yuZaHpGnaTRLWnMTZ4k07O7pHmxvgdmm+/l8GFpND
	RpmqpidcF+WOQddWSi52E8m5wGqSnTSCxX9GIIthxpxKq3U913tShw=
X-Google-Smtp-Source: AGHT+IEoi69t7mYkGM64faWfanIG3G+aZjIxCT9T7NbXrz1Tm5ebO1fIisC59kXZkBUKvdy4EFZyz1T9cHFhC09CFbA=
X-Received: by 2002:a05:622a:17ce:b0:4b7:9438:c362 with SMTP id
 d75a77b69052e-4b79438e5dcmr151588411cf.33.1758015333543; Tue, 16 Sep 2025
 02:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916090109.91132-1-ethan.w.s.graham@gmail.com> <20250916090109.91132-2-ethan.w.s.graham@gmail.com>
In-Reply-To: <20250916090109.91132-2-ethan.w.s.graham@gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 16 Sep 2025 11:34:56 +0200
X-Gm-Features: AS18NWAeZ0I8Ql6T2VXhNmbi0_zOyyX9JImpZH4pIDJbyS4OHq46p0yv6zBf1BI
Message-ID: <CAG_fn=U-SH5u4Lv3CcqKVHnK1ewrF46AF3JU1eiAh-JYxj86sg@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] mm/kasan: implement kasan_poison_range
To: Ethan Graham <ethan.w.s.graham@gmail.com>
Cc: ethangraham@google.com, andreyknvl@gmail.com, andy@kernel.org, 
	brauner@kernel.org, brendan.higgins@linux.dev, davem@davemloft.net, 
	davidgow@google.com, dhowells@redhat.com, dvyukov@google.com, 
	elver@google.com, herbert@gondor.apana.org.au, ignat@cloudflare.com, 
	jack@suse.cz, jannh@google.com, johannes@sipsolutions.net, 
	kasan-dev@googlegroups.com, kees@kernel.org, kunit-dev@googlegroups.com, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lukas@wunner.de, rmoar@google.com, shuah@kernel.org, 
	tarasmadan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 11:01=E2=80=AFAM Ethan Graham
<ethan.w.s.graham@gmail.com> wrote:
>
> From: Ethan Graham <ethangraham@google.com>
>
> Introduce a new helper function, kasan_poison_range(), to encapsulate
> the logic for poisoning an arbitrary memory range of a given size, and
> expose it publically in <include/linux/kasan.h>.
>
> This is a preparatory change for the upcoming KFuzzTest patches, which
> requires the ability to poison the inter-region padding in its input
> buffers.
>
> No functional change to any other subsystem is intended by this commit.
>
> ---
> v3:
> - Enforce KASAN_GRANULE_SIZE alignment for the end of the range in
>   kasan_poison_range(), and return -EINVAL when this isn't respected.
> ---
>
> Signed-off-by: Ethan Graham <ethangraham@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

