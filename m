Return-Path: <linux-kernel+bounces-824796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 975FDB8A2B9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D765A6738
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3F5253B64;
	Fri, 19 Sep 2025 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CaDGoptu"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D67257855
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758294306; cv=none; b=oGtamHtu0oQ70B81kTaB39DqCkh6BJVy+Zd6Kx/Ohc48ApeGNDd3pdsb6X0gwL+Vfk4ou5frhywWxmXvsuiTTLocxGk12GoUdznzai9gGuqgKl9/uagh4y2LbS9srmNTzCwPtkWLf4NX7MmflTlwi49L+WvEWJbeTX+Q1Zj72YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758294306; c=relaxed/simple;
	bh=RGxC493IbjEEger8hKnkve1PTNTnnMKtNGhHQrFJ6n4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YFNLsZcRM9kmR9RJ1yCKhT6goNz6RzRyko4Bv+6LNUELp93fV7rhPVKz7V0QssDxSf9WIGx173MWP4cqMtTj3fM22EFqrBnO6vNdMqIUx8MFFon5KuzQ7hr+9AqU4qwAQFQk/wlHOlKX1TPIdvPOjSWD1ulLYqDkuv55RYFP8fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CaDGoptu; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-795773ac2a2so16728446d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758294304; x=1758899104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGxC493IbjEEger8hKnkve1PTNTnnMKtNGhHQrFJ6n4=;
        b=CaDGoptuO7+gYm/LN+pnZ4lY4/s97m+PbxxS6g+OQ7MfP0XtuFTsk3JNJdV1DQOZ9W
         uA7HXNU2CcLDbSC2RKBVbOIwpy2kdIBMLyMGjSAEc1ODdzSuO60172qeaNpvwJVpTX4V
         6y/vik/koLoiQZnx6e060dpRSS+L0PfcBFtra8AVDmifsvO25de2KGjThl0lgTh/0T7V
         huV94L2Sy+3kqRgFuMKgQRN41uwEMDfYwNw6NGYILd1Ea73JnmKFkiEPQI8ifTj0HqXe
         sKh23vzJmqEl+f+2zTvlKM/Cb+qv+tseikUkVNBUtxHnMoHP4lPGguJbkQw0k+5QZ5UN
         /A5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758294304; x=1758899104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGxC493IbjEEger8hKnkve1PTNTnnMKtNGhHQrFJ6n4=;
        b=VWBjegefeHzZDKpfjzbdB4rHl2bI7cC8LxLoSfHyRALnXcUIYaU9RiIBKDb7vG9Dzb
         VfBoBblm0YVhOmJtt6msphBxcOtjSsv6dI74KMcSNpaJy5YI1kalC1A7KbKajg4/7ISG
         x+QIF3VGpiVB/m7HIXt/XFkiViVCIHNlkyKGT3+B8aKAyF0ZfDmp8MYu7+ur4OGAaeew
         eLqOcxOSpi7RLmeYgfdDuwQyqi/o8hq88qVb5/VoJHPX18INZCNFBEgT4SjXSrTriSrN
         MgK7aFS2fQsJ9NEOTmmD3uJT/guVbSkQqTblIvR6wbwPyzgRKxz4yUuBXOC+qmuGBsIP
         ZCuA==
X-Forwarded-Encrypted: i=1; AJvYcCWOkx86uDtjxdBijNm9aA8WWabHBI97guZoeqPa4d6Nr6GFGaCYD6G8g+qNIvt06nuhX045nGcz0Ejb1D0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6pHk3K+zKrYxEe5T8Z96wXsJnZNJoxwHIEz/QP6mu4M0e1Gz6
	jvvUeByOzwuGIYzRmgEUomcVH12veW9ykKusoV/+8ePpLZWJfvqK02RmeKZZfJZ1ozdftwuJcUF
	DGsu3sCFyU+MY5IIY6Ic0/J/+Fvdba3bkwPZTiL82
X-Gm-Gg: ASbGnctQSNvPQe5fhiiO/JNwivvBdkL7pss+FZ5CZ3yb6qgSy39K/tjHvV609xbZKzI
	LXhLsril773+reZ2LkBG6lkDDEz1xQWEf1aXomzo1rJyyLvFD6U6GRuDnpCwxJBSMv9exVeAIOn
	yVA2umUwT+y2fFAgoIQMAZBfrH0lKpRgRVJsi84xwyYuR2UW8VQayZgcLmme12LogtVz9dVEfKc
	GeYkRVtcVqEkj4QV/3eLFChTGLpZ0fzPpL4Gw==
X-Google-Smtp-Source: AGHT+IF48Qn9P8ThM/E5RZW+mTL5SaGErQDzvl4ZKUA9/53oJ7O4E+LJZwUwDw3pueAy5SweS7Sy91A5mlwWtXOr9SM=
X-Received: by 2002:a05:6214:e6a:b0:747:b0b8:307 with SMTP id
 6a1803df08f44-79912a7799bmr34142706d6.26.1758294303181; Fri, 19 Sep 2025
 08:05:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919145750.3448393-1-ethan.w.s.graham@gmail.com>
In-Reply-To: <20250919145750.3448393-1-ethan.w.s.graham@gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 19 Sep 2025 17:04:26 +0200
X-Gm-Features: AS18NWDNOJ80ZgwJUanMmHMdQpo3tLnLB0-s453y8IuyYBCYAQcCDLNYEOTyu6E
Message-ID: <CAG_fn=XXvk-okceUAnpwkk5W5kFLecyoNJcVU9Rb3g=M9qA8ig@mail.gmail.com>
Subject: Re: [PATCH v2 0/10] KFuzzTest: a new kernel fuzzing framework
To: Ethan Graham <ethan.w.s.graham@gmail.com>, shuah@kernel.org
Cc: ethangraham@google.com, andreyknvl@gmail.com, andy@kernel.org, 
	brauner@kernel.org, brendan.higgins@linux.dev, davem@davemloft.net, 
	davidgow@google.com, dhowells@redhat.com, dvyukov@google.com, 
	elver@google.com, herbert@gondor.apana.org.au, ignat@cloudflare.com, 
	jack@suse.cz, jannh@google.com, johannes@sipsolutions.net, 
	kasan-dev@googlegroups.com, kees@kernel.org, kunit-dev@googlegroups.com, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lukas@wunner.de, rmoar@google.com, sj@kernel.org, 
	tarasmadan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 4:58=E2=80=AFPM Ethan Graham <ethan.w.s.graham@gmai=
l.com> wrote:
>
> From: Ethan Graham <ethangraham@google.com>
>
> This patch series introduces KFuzzTest, a lightweight framework for
> creating in-kernel fuzz targets for internal kernel functions.

Hi Shuah,
Since these are all fundamentally test code, I was wondering if the
selftests tree would be the appropriate path for merging them?

If you agree, would you be open to picking them up once the review is done?

Thank you!

