Return-Path: <linux-kernel+bounces-795717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5EDB3F6F4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3FBC482F0D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643FA2E6CD7;
	Tue,  2 Sep 2025 07:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGXedp/2"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8075E32F758
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 07:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756799309; cv=none; b=pbbBOFwlDRKgAgRZTo/G0IxlKMFThoLYr12NQX3vYVHTV4S2X0fpDe33LEyXwjCeceQUG80Hg0zkISH846XueeIxnC1F8/jwkUB9lPvY08ZhUVzUqHndhmKzjDgdsnEOHEmT6ggPOI2NRxQXHq3TVdvYWk0SyYHLM8h7GKXa8XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756799309; c=relaxed/simple;
	bh=3W8IILy+ugegURG6c7mEYeBO9j6AVkJF3Qs3E0HzuQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ccCUYbRW2G7UEk19SS6Jc5dC39urHrb7lPEFkLd+EcppgyiTwmYugSNaVeU2K4ts6fr55w7+skuRUmtc+HTewaHbMce4sMwe7F2WF4tjEBqGMN8kwGxpVgLJxvWsSckw20ugmViq8egDJuj0QFJIdaWffgvZjJ0Jt5EtqelAh2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGXedp/2; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7724df82cabso2139138b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 00:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756799308; x=1757404108; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TozCbK6Gu7kax824vW+1RZdfyYGAlXrJstUGToWApKc=;
        b=IGXedp/272Av37Ah/31/LgvD6taBc6m3lS/Em3iaEQTolF/rl2G7pik8ZqZZ7NXDhg
         roof22SR01qyi6F3TRl9X+MA2WXJ+jt2Owr5xan6IkJu3bjXPx5VyUQPQ7m6HTdmmx2H
         nJiEEoOC2fsvpEfTwxarKJ1qnWD3DO2lY+aeOAiniRy156QfrjwNRkDNReDqg2lFXm2o
         xwJanZETYhbmBMkil/yQSv7w7gdqVG+8Oo2w/bjUGQZMgPt9gZ2qQvmuMA6zT6BGruyG
         g2IUjtS5WyIkKoWmAL2wJfv1DTaUJSzwW0rMBZ/xjs+aySDZDb2IZvaJrAN8J4Aa/7aU
         LEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756799308; x=1757404108;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TozCbK6Gu7kax824vW+1RZdfyYGAlXrJstUGToWApKc=;
        b=UvTmu+yv9DymrR//MO5XW6qVTs3bGbeuA7Vimkn17BPqAb51DI2GRqG3wT5M01Q1kV
         ApeAdH5ICTTpFtu/k9PzHUICAXUkSZ3DbFiQNql2lQsxIhH/zXUL4iZqxMmTC3ZBFpRp
         22a/a9uTk8Q+gTZn4h1uyxOZ1+x/7z9/cWhs5cTyG7rUlp//YmVehDEuqSk51fl5gyE6
         BrqqproHeJKwep80ZVGCldNTZsNToTgrZgnQMGaoQUTy3FtpE2aZFnJ8KIBY6rBl4woM
         T6if5mTNtpjEmD2cC34bI7Xbmu56/Y+yEjxOIV2Bb48uIfgzmEIIRvnhHrAsGUs4Y1Dz
         2Y4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAauCtDtpq4WCBqELJ+zeC6TemwqKQMS2y0NJSOuVwWKbf7nLahcd6iVCAnCcDZ8Vw4y5weYQE/H7105g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcjGEp1uJ3ecYMTrs8K3kZTwAI7NRiCoh0eLLD9rLwxpyQsWw2
	rjeaMJAgw1vAkqughosKPLU0SHSuPMxEnIamg0YsWE/Sk8pA7XOlvqwdxKz6WquRBu64LwB0g5C
	MMTlnPRtdq7bjTfCBDIToyEke7B4gZp4=
X-Gm-Gg: ASbGnctL2p7wRQNJOOzxtKm2xgLJSLtWcHwW9Dptw0jrXkw3vIav8XWuTRlYdfjMdTb
	OQf+EpeG0ip6vBRzNi5plOelGjbL3q+yNeAjZoFgYv5+7SL6XUKYOH866UxPpKWCrxZmUP6tT/g
	gPmX6MajQXA9ZUySH01Tc5rp4aGvqg8ov8HQrvxN0g/lTAssUvBybqug7Y9CuN0LBQk98J3s1Hi
	fDMTHQnRbhre7Qp
X-Google-Smtp-Source: AGHT+IFSTpNLnrarUYMsVhYePeIAaGEQ8xpKMejZyQKDrgCKsKJS/K2TWAHvZWBdQP2pCHAJyXPxjusAZYEddUvokg0=
X-Received: by 2002:a17:902:e749:b0:24b:15b3:223d with SMTP id
 d9443c01a7336-24b15b34ad6mr16913685ad.16.1756799307721; Tue, 02 Sep 2025
 00:48:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902-yarn-from-020874b4da63@thorsis.com> <CAFLxGvzO2yszspJtd_A3BSTCRNSF+ts_5+2aMkNksxM48DYEwA@mail.gmail.com>
 <20250902-life-domestic-c341a8992cac@thorsis.com>
In-Reply-To: <20250902-life-domestic-c341a8992cac@thorsis.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 2 Sep 2025 09:48:15 +0200
X-Gm-Features: Ac12FXwFpHf0iqgyEreb1xfoEqD4qKw1D3J2oevFGJ2IPUlmVQfGkwXoWME8zbA
Message-ID: <CAFLxGvxdqkvhZmMnL+KzTW4O-cL1oJ+WL6koD1TzBnVzJ7oLjA@mail.gmail.com>
Subject: Re: State of the UBI fastmap feature
To: Richard Weinberger <richard.weinberger@gmail.com>, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 9:37=E2=80=AFAM Alexander Dahl <ada@thorsis.com> wro=
te:
> > I guess your motivation is reducing the attach time?
>
> Indeed.  Need to reduce boot time here, and UBI is attached twice.
> Once in U-Boot to read the kernel image and then again in Linux.

Some ideas that could significantly improve attach time while being
less invasive than Fastmap:
1. Pass the LEB-PEB mapping from U-Boot to Linux so that scanning
occurs only in U-Boot.
2. Optimize EC/VID header reads:
2.1. If supported by the device, transfer only the actual header size
instead of the entire (sub)page.
2.2. Read headers without ECC (if ECC overhead is measurable). If the
header CRC fails, re-read with ECC.

--=20
Thanks,
//richard

