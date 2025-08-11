Return-Path: <linux-kernel+bounces-763367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3518B213FC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 20:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3E7E19073EF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741342E1730;
	Mon, 11 Aug 2025 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CrRT6JDS"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701D62E2820
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 18:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936029; cv=none; b=mYmRNUzgheXGm53jnUzGO3ZYct7GROwekPv28zdRsQqA8jAe/qipWqQp96E6uedglqWcY/FhjYVFB0HzcciNUjy0xxwq0SUNE9R3/AdBeJpPX6PYxJaD+vvWD+ZvcHsdwnWKjwtVd9I7InpBWfAb8ENyOYUqcO9c4hdlaTu6D1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936029; c=relaxed/simple;
	bh=ANm4Uux2/v/BkH0mMC8Vcvx5lJDO9zkQ5mDxi+2+IZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R++o2FlpJ3JP0Zc5x/5GecbCohV1OGy9Gw9Y6YHnzqznAsTfhA8Pldh82PYZ3pgz0CAoQVYZ9CSfHkvHNAkr42DwhbfxxM3FKLzwsNDDWrs+fjj8HIatvxIqWW+U51Y4WaVTuDC4+RBY5BN1gwhp93/D+SVU7zMq22NhQdyUJ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CrRT6JDS; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-31ec651c2a1so3810154a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754936025; x=1755540825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANm4Uux2/v/BkH0mMC8Vcvx5lJDO9zkQ5mDxi+2+IZ0=;
        b=CrRT6JDStMnr3Pt9JqrYGt76D5oQSHdJafT+btuiUChDpi6YAQGkwcTLwKHfMt2NHg
         ZXiPh9K7ZeW7u4DnnNWfrtBM5Cz95y+KwTZ1JC9qzsZXnYC4iaFXkCSrUvuQN+6pmll6
         U31+zl/BD57MJor/tt9SClJwo4A0IKsddBnmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754936025; x=1755540825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANm4Uux2/v/BkH0mMC8Vcvx5lJDO9zkQ5mDxi+2+IZ0=;
        b=bbX1FfH/LZeG5uw+VallEjkAeg/IEjaOeVPoFes9kroezleJ/uRcPj7Y1sRmTFnYj5
         NpejwNbqPVQu0PMgX2hFG3smt/lnGk1nUYSSWugKRapxz27QQTzMmgDPTuMimQOBEoKx
         o5gFFJNCyA0mAPEURRS/ykXaNBx99gtpDETCXBxudKNJN32KvvOYp+Wmc1TA3HOiWsQ7
         lMDmhrs4e476XgeSXYCAzooL+LYrxEPmOEM2bBfgjyDLxoMxMEWp43XstZ9GgRu8sRHi
         4gXeidNYWExlNRMkJAAk9ThKPp8bOoHHY+kRFKVSjzK+McfWk24ZYtNkXL7duXY/QMvV
         H47w==
X-Forwarded-Encrypted: i=1; AJvYcCXM+31lbVokOXNKmXW0Gu1ZBsD5BfXQaROHwne3LVfAY21RB1IWMl4ciYlXEbDJqDF77n9k2X+Q2GIq3MY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx//WSXBHIHNJjMIfEulYF8RlEhH3t9AweDnDb1jJCDtfBFU0nC
	Z20aRzK8auhkEfQpknUubu9h8b7zeJvGB95g/6yAHrQ8VakERCbvHVpvUP9ceVEgoEvykJFPYe5
	GV5w=
X-Gm-Gg: ASbGncswx7bsPuicptHx2HQRIXyGBxpBWCSk74LnLP4wYKNQC5/yuoexbQjvPjIkz53
	cambEkxpET5zanAiNmLRBmhsx/zW0Iz78fcZLcdZM+N8+bKXdYcnX21CLLg9zJtz4sT8SN4j5D9
	3NmFelkxqOb9wDuH5F1nXAo8AR21msgbg6lQs6+TWrcuW7HtTkp+bk+MoQpXaqVfbJSevbzf26Y
	3vyIMeD8iiJOL9u5tMtFU0CStKKsKPgLznBmg7By5A4iSG5lko2oChv9FQrW1Jh/UA0pvkQ2+8r
	zoSddco3rZ2Szb+tsBi0vA0N2vlu5tHAvyi66E+gjBVb/CoOzthq8r3pPZfJ4chglX2CzwwSi31
	aUWLh4Pos/eM8abtQBUpduLd4lu0qkNBsQYRJ7G5ApVAKOt2bhRSg7kCELxlhNi2QfQ==
X-Google-Smtp-Source: AGHT+IGciR82whuSmcWeAJ1vbpn6IxnXcgSVV19uZuC1ejio8FWN6aSjJmxj87uTzVLMEE1BkkIUKw==
X-Received: by 2002:a17:90b:2ec4:b0:311:df4b:4b7a with SMTP id 98e67ed59e1d1-32183c45f65mr19706965a91.29.1754936025318;
        Mon, 11 Aug 2025 11:13:45 -0700 (PDT)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com. [209.85.210.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32102850ffbsm18176686a91.0.2025.08.11.11.13.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 11:13:43 -0700 (PDT)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76be8e4b59aso3968209b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:13:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWgAG/FoDaW3w9Zq5iLTWOn0A8LUyvR5LRrAS3jzIf5+T0oMyUQwTstNO7LUNNKTHuEro/niBgvZqAXd9A=@vger.kernel.org
X-Received: by 2002:a17:903:19cc:b0:242:a3fc:5900 with SMTP id
 d9443c01a7336-242c1ffce82mr181750335ad.8.1754936022978; Mon, 11 Aug 2025
 11:13:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811170351.68985-1-thorsten.blum@linux.dev>
 <CAD=FV=UrEv+=KmjZTDt7F5ftuw5xrpOyEim0OrGAkoiJ5Wi2cg@mail.gmail.com> <17A3048D-E2E3-41FD-A6A0-853B2E481B12@linux.dev>
In-Reply-To: <17A3048D-E2E3-41FD-A6A0-853B2E481B12@linux.dev>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 11 Aug 2025 11:13:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XzSD+pz9RNZDS0paDUWKJ-AW91U5DuEQziszYchuZGAQ@mail.gmail.com>
X-Gm-Features: Ac12FXyQvkSM0ZmqfknQHYkXyeurhKpeTOYtq8R_cD4QpIIkIrGjU0oRnuKfLKs
Message-ID: <CAD=FV=XzSD+pz9RNZDS0paDUWKJ-AW91U5DuEQziszYchuZGAQ@mail.gmail.com>
Subject: Re: [PATCH] kdb: Replace deprecated strcpy() with strscpy() in vkdb_printf()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>, 
	Justin Stitt <justinstitt@google.com>, linux-hardening@vger.kernel.org, 
	Daniel Thompson <daniel@riscstar.com>, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 11, 2025 at 11:11=E2=80=AFAM Thorsten Blum <thorsten.blum@linux=
.dev> wrote:
>
> > ...so I looked a little deeper here to see if the buffer overflow was
> > actually possible to begin with. Looking, I _think_ this is true:
> >
> > * `cp` is a pointer into `kdb_buffer` (location of first '\n')
> > * `cphold` and `cp` are equal at this point.
> >
> > ...so you're guaranteed not to overflow because the destination and
> > source overlap. ...but that means we shouldn't have been using
> > strcpy() either way. Both strcpy() and strscpy() say that their
> > behaviors are undefined if the src/dest overlap. This means that
> > really the right fix is to use memmove().
>
> Good catch. I read about the undefined behavior in the function comment,
> but never encountered it and haven't really been looking out for it.
>
> > The above is based solely on code inspection w/ no testing. If I got
> > it wrong, let me know.
>
> Yes, I just compile-tested it as I didn't expect src/dst to overlap. And
> then my last-minute change to strlen() made it even worse. Sorry about
> that.
>
> Are you going to fix it using memmove() or should I submit a v2?

Do you want to send a v2 that switches it to memmove()?

-Doug

