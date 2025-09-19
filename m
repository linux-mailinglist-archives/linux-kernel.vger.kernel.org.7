Return-Path: <linux-kernel+bounces-824806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70387B8A319
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC09D5A22C1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C43314D25;
	Fri, 19 Sep 2025 15:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GIYfUn5R"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0833093CD
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758294474; cv=none; b=M3fLsYpkSWbdm50mUIY16JDitStxWOAWgGs+9YZoDe7aCnHm4CatI1hlTXCcI1DSisO/CzUjxeEucM8sEpFrzPa74dG26buGjAyIGumkqu1Qg2jyrkS6uRmeNTMPbL4wJZl/sV3DUtI7eEdwJIrUFJuCcjoh3sUlab8IOBbYdas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758294474; c=relaxed/simple;
	bh=ls0ueed/BxHP3QtDBUTzflUrtNvfsIQ0artI+JKf/HI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zg4oi/hoBVvbxz0MeyenS1GSnpEkn2tW1aFWIoiyYOQL3hU8prJuR1BUb8qE3ovoUUvhyeS8ODkgZ8i80N9SatKAV8DAcGseUzMwC8iqUA71rF7vyHAZcnzdCWQ5sdSAApCBj5MJgyeqjDp1UCrfihu3QgoJeKYn4ESQHxc3nz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GIYfUn5R; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-79599d65f75so15372506d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758294472; x=1758899272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ls0ueed/BxHP3QtDBUTzflUrtNvfsIQ0artI+JKf/HI=;
        b=GIYfUn5R7QznP9L9wCkjPaVtUpqOfnlhZTcJPugiJEH0RXeZa+xEpc8MEo1O0/eiMQ
         DIk8h7dBJFnwZPQ55ajLsI2C7HB3mrwsXQYLi6aCYp1DsgCBZCRNlfb69EqnFE33fvWZ
         ZmwK3tPLOBedyWgVuTTahkzqDW0e1yDoX6whSCwYanCpJvsPAF5/Dy2jC266S578hmra
         4F53p7jbD7DsiCkGEvdUetIF9+bXUr9+q1Hrv6hzhhKlbgK88BWoVj2RfIjClrSpuqLu
         E7OtlXQPGVDfkwZES8ynT/Fv7OY+rFfqi22HGwbJn8BI7vRzBPgxf915xiX0BbhK3RHB
         gsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758294472; x=1758899272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ls0ueed/BxHP3QtDBUTzflUrtNvfsIQ0artI+JKf/HI=;
        b=D+JYCyP958HlPbX8RXxjf2SJNPiXFoufsED95a1r8Q1H2SRrDClpX8t9zKxtjz5N7y
         Rb6TybnMQVhuFkR1yfGQMqtcVCYs+77o1Gw5/NAdbHtdNtJ5tzARUYGP3HgJ02D5X2xv
         4yEqTDNX0gZSUAduvYtUBPJHHUD/kusYBfr9S5g28PBADMxKEa9VpNMedKrXQqfvNCmG
         9NAxbHCiKJPdmqh6gWXCbeMLyET6cChxQfh1cnezczw5c5HwWDZnle1vBvtipe7YcfaP
         xdpMr50aVwTmq+2nxgtmXhlRRpSu2I84eRRxcJchFSFdQWUA8f6qeYzPJ7rIb+kGi3pX
         CMxA==
X-Forwarded-Encrypted: i=1; AJvYcCXGdFz6Fv1pt3qyGr28x1ifd237gkwZe4jJnRQhAD9MwCGww1llFzuKYU+VNQxXbSmpOsA4vzgZBMrAta4=@vger.kernel.org
X-Gm-Message-State: AOJu0YySB1a8G+ZnVgSkyq+ubMrS2H9eXJBGaXFg8KuZnxdpClKRXiX+
	ExMXe1ZpMLlI5wGS54AQA7N/UTFIGhvtJWBo6Blr8FPwbK3WSpAmp2xln32znCwZry6M6mXa0ej
	VyEwjoFjr2686Ep1iM3EadxO/+dnOh/8yECUDPJei
X-Gm-Gg: ASbGncvUfJKy/18ApVvE/7IN7L2nw2R39XOCOm3fAV5cx0lRYkrjDpJg09qYDiCh4zu
	xoPi8DbRGhn6/94KGSdkmd8QjLU6qN9dhEoawv2vBDefejmxIbF8IXfpclXojnWAGewCLuWEPt8
	yF7aIedlre6/H7aa+jhC9cY/d1jCeKb8kJU/cJo2qhC4QiE8juheJ7rd5P0nytQXRKbSuDHE+DC
	4MV+DOcmYVWsAxGW3FlMngb2HyNV14jFefg3g==
X-Google-Smtp-Source: AGHT+IFrJzJuFA3uDy0oX1I+l6xaOubdUHrA6zUrrdRHERulJyx2tdaDsHhWPYomdV64GyBaRo1A+0ilKwtQxafKibQ=
X-Received: by 2002:a05:6214:260a:b0:780:24d7:fd35 with SMTP id
 6a1803df08f44-7991b0db9bfmr38784486d6.43.1758294471475; Fri, 19 Sep 2025
 08:07:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919145750.3448393-1-ethan.w.s.graham@gmail.com> <20250919145750.3448393-9-ethan.w.s.graham@gmail.com>
In-Reply-To: <20250919145750.3448393-9-ethan.w.s.graham@gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 19 Sep 2025 17:07:14 +0200
X-Gm-Features: AS18NWCM6kR1_nk7adaxFawciRK7byb-Gyk4MeMsfOVVpcb45qo2C2pvMXupxjs
Message-ID: <CAG_fn=Xvkz_-UGuR8_4Jb_9HmwQn7dTHdJuDRe6usZX61CF0xw@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] drivers/auxdisplay: add a KFuzzTest for parse_xy()
To: Ethan Graham <ethan.w.s.graham@gmail.com>
Cc: ethangraham@google.com, andreyknvl@gmail.com, andy@kernel.org, 
	brauner@kernel.org, brendan.higgins@linux.dev, davem@davemloft.net, 
	davidgow@google.com, dhowells@redhat.com, dvyukov@google.com, 
	elver@google.com, herbert@gondor.apana.org.au, ignat@cloudflare.com, 
	jack@suse.cz, jannh@google.com, johannes@sipsolutions.net, 
	kasan-dev@googlegroups.com, kees@kernel.org, kunit-dev@googlegroups.com, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lukas@wunner.de, rmoar@google.com, shuah@kernel.org, 
	sj@kernel.org, tarasmadan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 4:58=E2=80=AFPM Ethan Graham <ethan.w.s.graham@gmai=
l.com> wrote:
>
> From: Ethan Graham <ethangraham@google.com>
>
> Add a KFuzzTest fuzzer for the parse_xy() function, located in a new
> file under /drivers/auxdisplay/tests.
>
> To validate the correctness and effectiveness of this KFuzzTest target,
> a bug was injected into parse_xy() like so:
>
> drivers/auxdisplay/charlcd.c:179
> - s =3D p;
> + s =3D p + 1;
>
> Although a simple off-by-one bug, it requires a specific input sequence
> in order to trigger it, thus demonstrating the power of pairing
> KFuzzTest with a coverage-guided fuzzer like syzkaller.
>
> Signed-off-by: Ethan Graham <ethangraham@google.com>
Acked-by: Alexander Potapenko <glider@google.com>

