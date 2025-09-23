Return-Path: <linux-kernel+bounces-829654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABF9B978C2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 23:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B16F24A8482
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BE130C112;
	Tue, 23 Sep 2025 21:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zQVYAayx"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A37309F12
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 21:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758661333; cv=none; b=BDoU1FrbAa0x/SfTmv93GbQKW0p6S/QRouZBmG/wksUA0O5KLOcJwVvfxx60rXScI194lTFIiFAadyWYGcD1NOYDpKuefDfJ+P37CviHuDgl+oaBcfBQCzp6mBCf4OBdTwLbFJiCeXbCml9056GLDcDkwGYIM93yWY3nMCAb+zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758661333; c=relaxed/simple;
	bh=+BIVgApjfnmdJnNUGgOd1lEeYy+ADjSWxf8tt2yg9yE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CIvG+UVO3PN0+y8H4e6R/Wit2p03nsz6gUB7+OgpYw9tgAKxNw47MX9VlyufnynZuTDWRYlwLrOBxXYRWBqEn64MioIQyY+e8A4hSy7Oyc/cVOWppOKghHmNvH1qoPytsz+Xcc7cwOJg0ss6qPKC0dY3HHXpIA78Bj01J6FBTkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zQVYAayx; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5688ac2f39dso7045112e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758661329; x=1759266129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BIVgApjfnmdJnNUGgOd1lEeYy+ADjSWxf8tt2yg9yE=;
        b=zQVYAayxvTC4DM+yXS2+JOcDIGlI434OAs6S+P5OvEXBbv3S4tGP03+UHvzmjBnbve
         EkRqULfSAentPeUFxo/erybtFtFbKgmgtPM7Y2LCVXwdlUIQkU/NtkuJWKBK49jQraN9
         5/E5hKuhqEDtUrerlY2diMkYqZ3y9SeN8E7dbMAgQZyXjce9glrKhZYDEcMnneYs7E5I
         3qnINZWCO+8BZEmcpJ8iP1cVcEFVcXgKgQXVy7YlpJ+/JsEE+eUalmHTDrVQHTguDXQi
         dymYoiSIhEb3nOKJheEbGFnzsiw4p489IJpTG/VDtkTqEkEeFRTMIhAAZS/m9BNJ1sKF
         I5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758661329; x=1759266129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BIVgApjfnmdJnNUGgOd1lEeYy+ADjSWxf8tt2yg9yE=;
        b=I7wRh6hmVqBVPkPFU7of0KNMNZnwSQuAjvrcLuxF1P+WbuN+jZBPhfpuTZGpNAxcwZ
         DjrS6ZS+Z8Gm3NGM5YR0Bjh7waQUY+6Hhvm8pwNEsVN/RO6EovO8kZg1W4GZG4RpXnhi
         r6deuUqZStLs3VVTh2bFUuxBclar+6cIwulnct64PB49rBrY0CYkz5K9T6Ul6X+DVtnl
         yaQ9kbzqSuWUHdMKfv9UhUU8y7WUJ2SR0/jsgnei/wNvosFpY5fKUnb6uSTh9jBz/F4O
         tC1Sgvn3GPgzZCzGMsqxy6WzO0ntjDS+w7bIZDbTbQUu0EPHaHKTmweIDQlRHHEghDJ3
         OCkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpP5k5v/TFEQ6lbhrqwrZM0UjsL91Ui9M+Jp586fL+Yc1ep4HM+ZJdGsBogzF99NqrC5eQMgLve2+Arco=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHolH8YqLtJ2cOM0tuVRzFRqle97mRp371ovpxEhxsr1wAcUqu
	KhBureI3LGjdhWMHMANjXT6Dz10EbhCSYMlEBS2vTTukGMHoCgrAS2VB0NJPBX3O0h1ec/dQTZu
	zKHBrmT85N4C35zEWtIofcrvh+4T4RX+jEtD7ak0=
X-Gm-Gg: ASbGncu0w4nvGF5wHillMCQgnWOi5QwgU/YuAY8+Lrz1M99r5JFGaiC/kCrfxSVLs38
	IbpyMsGneGjgmWjffOYpUjK04ZPkK3K+jw8P8XnYFVJlDE17xSz2cpY39PCoMkv9wGmMhzF2aXN
	o/lWsRig9OEjKrhM5Imea8ffeIlx4FT2L0gP5xGI0Ypu8PDXkyOKnrElFE3rAwGt3grOAjMTyvg
	CbQ+76Jfp35qIsU5H7qhNrwwhhGaSnGbl2j
X-Google-Smtp-Source: AGHT+IFwXRDGhFAvcbaLj1l9RYEViT0rYo17s7yMQyCQ9DLTB6xQtn93PW2THfEcRcLtahipl4f1CCy1ovriaxNniWE=
X-Received: by 2002:a05:6512:3b21:b0:579:fb2b:d282 with SMTP id
 2adb3069b0e04-580737fbeacmr1539793e87.57.1758661329139; Tue, 23 Sep 2025
 14:02:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87ldnavsse.ffs@tglx> <20250923131334.66580-1-sumanth.gavini@yahoo.com>
In-Reply-To: <20250923131334.66580-1-sumanth.gavini@yahoo.com>
From: John Stultz <jstultz@google.com>
Date: Tue, 23 Sep 2025 14:01:57 -0700
X-Gm-Features: AS18NWBwhUDTbtO1jhYBKXBTPrk1XrauGwTt3ITm6Svj3UcDRtzIuMhTMW9lVGo
Message-ID: <CANDhNCq_11zO4SNWsYzxOeDuwN5Ogrq9s4B9PVJ=mkx_v8RT9Q@mail.gmail.com>
Subject: Re: [PATCH 6.1] softirq: Add trace points for tasklet entry/exit
To: Sumanth Gavini <sumanth.gavini@yahoo.com>
Cc: tglx@linutronix.de, boqun.feng@gmail.com, clingutla@codeaurora.org, 
	elavila@google.com, gregkh@linuxfoundation.org, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, mhiramat@kernel.org, mingo@kernel.org, 
	rostedt@goodmis.org, ryotkkr98@gmail.com, sashal@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 6:13=E2=80=AFAM Sumanth Gavini <sumanth.gavini@yaho=
o.com> wrote:
>
> Hi Thomas, John,
>
> Thanks for the feedback. Just to clarify =E2=80=94 my intention here was =
only to backport the already accepted upstream changes into this branch. I =
do not plan to introduce any additional modifications or syzbot-only patche=
s.
>

Might be good to revisit:
https://docs.kernel.org/process/stable-kernel-rules.html

And, assuming you feel like it still might be needed, you might add
some annotation before your signed-off-by line to clarify your
motivation for submitting it, ie: how it "fix[es] a real bug that
bothers people".

Adding tracepoints definitely feels more like a feature, not a bug fix.

thanks
-john

