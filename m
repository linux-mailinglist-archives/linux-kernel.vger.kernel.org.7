Return-Path: <linux-kernel+bounces-807992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF67B4ABBD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD9A17AE10D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E697D32039E;
	Tue,  9 Sep 2025 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJ9JhkZT"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036F831CA5B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417217; cv=none; b=c8KGW814gfb2Y1Ith9xW63b3PZkVBlejfn1m09S1n9EUMUGEtKkCY0etlH04rimyy1DjNdRdXqfqqsFycdbCqyszpMR/coNibfYrIAMBgFy3fdyMDNoD05Z+guwpEKDCdhosoQ1bHwdP4fRkhmav8SZ10PkvzXSyvWW9PkoQybA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417217; c=relaxed/simple;
	bh=c+ptnOyAm3jUIUln5KuULPwP/29EvnP8THI8ZxcBLg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NUE/LTLSGCIf2ErhXKmG75/VRGqz/OBRkUoovYQ54rm2dWM4+GN8vQOO4ICcgHoQM2QEfIEXJVaSLFWzM45wkvPWz+pVFYJYr+Qm7teDE5g6QFlOCRgF/nbRrxDGe+rw/tMw3atr0zp3h3ITzKAbfdvzED/9zHxciRNosUILJWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJ9JhkZT; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b522e2866bcso169765a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 04:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757417215; x=1758022015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+ptnOyAm3jUIUln5KuULPwP/29EvnP8THI8ZxcBLg8=;
        b=jJ9JhkZT4QWT5zTpOCK4kMbMWRGtV20piCNhFBgYjepihWvea2byMS5GLmtKCVT7Um
         WhUJv3LvdPCFHCJb182wKIph6rM8h7HMs0QgszKPobhweRSGfoGjxUp0m177MyaOK2nl
         8ZPvp+rgXtX14tKXEitzmy/sAMWSUBfSXwjWlMrnL1jUPriQPHUvH5Y5w62HvgEH5Hr6
         CwYq3YpnOc7MsLUSCY8LXgleqD+6rqw7IuLAIQYMebaRaFJ0FlydDJWlw78w51NtEjPb
         3Tc/6Pp10zFS+RmBMFnfYCfeoplybZV/tA1N52gG6WVhX/deWK/J/Ix3TwksXpz5IQag
         cwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757417215; x=1758022015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+ptnOyAm3jUIUln5KuULPwP/29EvnP8THI8ZxcBLg8=;
        b=E17ZzStNpFi9FI1yFmXvX0iQiDhoXsWSBsYUqdH66A9amoukTzxgfv648u3MIRvSHu
         JHHfU7NsJW7I6U92Vl+Nyj1nyG1h9xgmBIuXpixLK3xmhGJxdRoTktmfQnPF6oVjfjIp
         fKCiXPk1Feo8RQAgNEXRzYu2Pnc0gll/VxtOg9xWaXEh9Qq27Bc6Hoz1sMKA3ihgcyUz
         RVyydyL5EQ4gXYrwXfrgHlNMYSLQevqcwYBEE/y6oyv+g5y/yuuRKKNa7NYCDG5Sal+B
         hihixtPW4JCC+RZ3A+7cX0i+JUtglq0nV61zw283XXAfevpDBPIDp5zGMMjmfu3WbHYU
         L2gw==
X-Forwarded-Encrypted: i=1; AJvYcCXDQeXy730dYeHJVJiLL3Zm0G15HZHzYD5Aih7lFIMWt9FW0y3QjEbtUtT1eRyLtYAWsKdI/hFLGDii+MM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzANdKazOCXlWGcXkNdgELtwqMNYqN/GZ6tV5Kz5OgEVECKRnQC
	8nvMGL2/7p9rkBhh6PoGdcK91ZtMmPZLjZKVX2qx6oEyW7z3wbhp+VkiC5wUmnh2ihUDTwL5A+5
	h70vDD3FhOmbkJd3hDun2WhPpaQHaqPU=
X-Gm-Gg: ASbGncv65VwCkXxBJASFv1TrG8csz95ToGXMVn3JhiXAYoRiWW7f970GksrpwBnL9HF
	4Jcsfr8rFjG4u+zjKVltoTKEqT87cnnFZghy3anofqULAZnlTb2UHatCOIVseGTbAYwJLLHfqpr
	YWc5o4/CXCmilPYCwF230ngnNnvL6XemS9Sbl+YlOgE3O71lfx0vGiLqrOR9tIsXVS+Hq45GQ/Z
	iVlb3R2R16gMazYhFiV1xUu2r0qgLUAmNrqwpdzTU8FuW2VjX9Cgd0wLC+3wMPH07Roqjiy4bRJ
	/bgWvD5TMbToLwc82DjwaHAz6Q==
X-Google-Smtp-Source: AGHT+IHq6LxauZ4W7XVEaPw5eeAmvgO7uHid3sBeb2MBggW4s5U8nrTwtThoBWZwkRM8YjaKlKGX/jYtu36SsSGL5YE=
X-Received: by 2002:a17:90b:38cb:b0:32b:dcef:f65f with SMTP id
 98e67ed59e1d1-32d43f772e8mr7977540a91.3.1757417215077; Tue, 09 Sep 2025
 04:26:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aL9Ch_XaYTxMzFXK@x1> <CANiq72=6yb5PZnuPYX3xWAms6pfYmfpoPj-GE1AZv7OfxcROJA@mail.gmail.com>
 <0633E365-72E2-47B9-B6DE-99E05D1E729A@gmail.com>
In-Reply-To: <0633E365-72E2-47B9-B6DE-99E05D1E729A@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Sep 2025 13:26:42 +0200
X-Gm-Features: AS18NWBtwT21xFJ4tCPAlJTc6pRxR63ipRI4okv-GtO4w11-zahOibO8PV59FvQ
Message-ID: <CANiq72mhca5DF__uJt2N5uK=j7iA8Hn6vqr5si_5sa_15T3qpQ@mail.gmail.com>
Subject: Re: [PATCH next 1/1] perf symbols: Handle 'N' symbols in /proc/kallsyms
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jocelyn Falempe <jfalempe@redhat.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ian Rogers <irogers@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	rust-for-linux <rust-for-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 1:17=E2=80=AFPM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Nope, there are 2 lines in the commit message, both zeroed as I did it as=
 !root, I can see them as root.

Not sure I follow -- what I meant was whether you saw other `N`
symbols apart from that one (and its `__pfx_` prefixed variant).

Thanks!

Cheers,
Miguel

