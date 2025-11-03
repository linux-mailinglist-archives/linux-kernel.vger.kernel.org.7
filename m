Return-Path: <linux-kernel+bounces-883313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6F3C2D0B7
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDACA1884E96
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7839B315D42;
	Mon,  3 Nov 2025 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AjEEQcQB"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A15315761
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186558; cv=none; b=hy372xzZbR9sQWAqxBF3kOXshRLFMCZ9c5Mr1c/dwtd5cG8mF4clb6Nt4e+ujXheQPoaXM7+TJ1Y0M31xJTbin0ex6zeEPvXvc7IKx+K/KHDQw6DV4Dg+NFt21/MbM6mmumEAy07P5n0i+1J5ks/TV0qSJDoaAZZEkm1KzwCbJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186558; c=relaxed/simple;
	bh=eJqBobj4OytscvmhKPZl0zP0AFVmYk+5BUqlFCRdi3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VYKxBx36ubXk9KbkRr/AgMlajQty+IiWOUIP13A16H7pp9YVBjhgFQ6KT3yCswGjO+c++9tdqBLSAy46WS3D2T7FQJgV9K0Txq9sSZ8v4ubR8Bv7xklBfsrSLWA7lVQXqkly3tj/bjJj6WtlhpcfxDpMyCuWyMFceSFgzfaPT2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AjEEQcQB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-295c64cb951so204295ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762186557; x=1762791357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJqBobj4OytscvmhKPZl0zP0AFVmYk+5BUqlFCRdi3A=;
        b=AjEEQcQBYsdYoJaRyq3irTJM1xX6gTWJtCzlkZqQ+b/iSVmut5ljmsE3/BeH9B9WrR
         nj65BNtNfSqRC+qrAq0sGzE3rgTi5CO5AsUJDmlGSVHGRbSWhFYESDfvKp6LE0ELAJig
         5t6JU4c0c/dJ5SmZHqIRH6FMe1i+qtoti8ExeGKilrrlISbwU5GtdTasThexRC0jOZbt
         EKM6Tw9bxCJTTiV/6CyFctS5aGggSB6kAGdnDEfg6zwXY7OP6QhMiEWlIW4Q9DqrZYJr
         t4Mt44nLrC6DsJ/Rg39xOkxLL48wM3HcfCBU1WnGWJJkVWVx5KijLZUOX5+XE8a2gtqV
         2hGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762186557; x=1762791357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJqBobj4OytscvmhKPZl0zP0AFVmYk+5BUqlFCRdi3A=;
        b=u/9dJ4rTIW0dlEJA8ntsxg2kT1gacv1RZX8HI4CAe5BtnnwrEqJutUFywRcbq+R8bs
         nMr7m29BrsKXU876dxpzFjhw+lfi0W9JK4wVGXv1mYWvXmLhetWq4OluWiWI3J5pnNjB
         l04JccTNBEJCzUbw8y1ehI+TSxgm8aOOi5VbtBTDl6VkoDhBIoOFFDHIsB1pxt+jSQxO
         zxMbi08JGQ/yKZH8wIMIk035ni31VDmEpne23gcUpCvErXCkTG0QrASuu+ppUa7u4DJr
         EHcfd3I7R3uK1bZLt864Zd9Sujl2muLLhXzRzh42ChpcSnT/J1fNydxVK7N8tO/UL89C
         gJzg==
X-Forwarded-Encrypted: i=1; AJvYcCVORldavVDnNEQ8m2OmT6IIHUD1y72tRtXxHYUPNTm5qiOlIIIs3PlakXqPwDnhLlyYvsJDSqGeMX6bF7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXZq60aRBgmXSp6SwwlPnXwtLWHHrSjm6vH1081TceD7KXbEGR
	W7zZn5VsSGdsIzbTCc2bu0OXaX1kNT+K3k/oql+9oGvfZnQnK8WStNfeY5MoAGXAz31QwKsq5fw
	lMZk4B9L8R9y7oBGTlUZS0btZFePiWLQ1rTQs1az+
X-Gm-Gg: ASbGnct8fcdbN6TQSSqIEJ06IUAgXB9WImKFA5W62p0UIfnIrNnNh9hG/oAPgQobO8K
	UxiySP4EFOciukkX5LfbnkvXbkKeDBQ3rKw2SRnqQkDOBblzbrAzLmp1BXXkD2Wv0P84jyZk/Sf
	FKXMC0jP0HvkPL2B8LF8QckGGFsyXquiajKRrVKq4AngBHtI9l0HRruHVblz4eAfRMVmpxwvrrZ
	AD5d0EuoBA4rGpNOUlxNMIuRPCJm8R/qcmNPeCLhI2A+Gu8Ll7aLmEQ5iaJ9GDEdLE21ZfNKC7f
	YZjPlTrOgPhXwUnC72kXD0kAyw==
X-Google-Smtp-Source: AGHT+IESkpVff0fTrWG6+qbua5DBKANFmK98G6/eOT2NsvwR+nXJHjYIfFHT0CWbeA3guuxRSguPyBipiQOLvR+/ViQ=
X-Received: by 2002:a17:902:d4cf:b0:295:5405:46be with SMTP id
 d9443c01a7336-295f8c8fbe9mr274955ad.1.1762186556373; Mon, 03 Nov 2025
 08:15:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aQjCEfiFLJwApdlj@x1> <20251103151912.GW281971@e132581.arm.com>
In-Reply-To: <20251103151912.GW281971@e132581.arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 3 Nov 2025 08:15:45 -0800
X-Gm-Features: AWmQ_blVKwqOT3MpSdCINIgTWdpTjuwwg78TioInmeu2jRMq4fTdiOyTs1xPGF8
Message-ID: <CAP-5=fWcjoz_iNyMM6xSqkyDzmOmar-zaejSOn1L6Dta061kEQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: Add James Clark as a perf tools reviewer
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 7:19=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> On Mon, Nov 03, 2025 at 11:54:09AM -0300, Arnaldo Carvalho de Melo wrote:
> > Just FYI, I'm carrying this on the perf tools tree.
> >
> > James Clark has been actively reviewing patches and contributing
> > to perf tools. Reflect this by adding him as a reviewer in the
> > MAINTAINERS file.
> >
> > Reviewed-by: James Clark <james.clark@linaro.org>
> > Acked-by: Ingo Molnar <mingo@kernel.org>
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Well deserved, James. Congrats!

Great, we need more code reviews!

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

