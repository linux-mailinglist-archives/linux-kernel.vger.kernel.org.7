Return-Path: <linux-kernel+bounces-827395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DDDB91A35
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A5922A51D7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA620200110;
	Mon, 22 Sep 2025 14:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xmDGy+ST"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A601E491B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758550866; cv=none; b=oxHFUn4ifMfB1pES4sn+h9BTvzdl2QhitTgrqpC9a9bvHTa/KRrb1+GOLhTH9iyz1ySFO8ChmQsqNWakLc4QAzn8Ok5x/4x0ZdbTCDZL7wlVdhfUGRZ7UuENfYoafIbBwi4K4YRM4uqtkH5t7+sO5zHtXGocigUJ8Nou68oMVU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758550866; c=relaxed/simple;
	bh=ug0zAAEr5kbnK08BBV4RWvp/VJgoebn0vXwAlF1IdfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uvtzeo+MfJk4necqxfT54VQ0n2XXkHb6y1ImYPEQUEk/J81nQfnFaEbdzwxFu+LbKML6GLkRehpNQeaE5uPYUveo1w0viDFtE8O6pcFeQVnKPdAIPvCBYwYoecMYRT/RWTUYK6dfxg5GGSJZ3Xj1Kpv/v2v3DU6HLd1xljRQsng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xmDGy+ST; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-57bb7ee3142so1451356e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758550862; x=1759155662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ug0zAAEr5kbnK08BBV4RWvp/VJgoebn0vXwAlF1IdfQ=;
        b=xmDGy+STUmXvdAJZ0LPjBV1yp4IwEktn7OtJPwqszQGAibeAm50CKoYPBSFDur6O5k
         YxgwbAzPbvlH17GdsSgow65hWx7+QQbk/ydzLml3jOScoZyeDOG4JEPy0L2Suu5AFVGJ
         pOW2VEF/PGAVH0iVvunzOleqiTKo2VTEcWdq8k16ndTSmuYjB/YwouiTdPQTb+2OcYjD
         vGgyTpj0TCpKNXPjXtJLKpeo7ln+JUULrnpOUP1vhsKR4UC12JT8l69KH9BQLE2bBMdV
         JMX98k6kQba0kM4u2GF/jEWhUlzOdQdS78ZV73oplEKcupAak60k75nA1BClFMwmJ8LY
         pnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758550862; x=1759155662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ug0zAAEr5kbnK08BBV4RWvp/VJgoebn0vXwAlF1IdfQ=;
        b=wQuIQQW+kvsT+lvxpJcOq2EF+V2AWnKGY4YYnMNwMAKhGgOykb40gJ1HkpixjFhJJc
         bPWopIEhY6HrM/vkNtZania/3lesU4HFJusF3WnvWTQZouX664x6L6VgnNyGjM1cRqWP
         nKgoHNTIXWBnpguwLFCxZqGxebMNOp/bX6G6ZlPnb1VEaQD+PFDLBR+/R3GUrO6JTFV3
         0pCrJlCvV2NE1UK1GR6WgOPmRK/CFSI4GB8BH7B71lHaYco77IqklDNqjGMZDmiYGyol
         xejFXgrM7zJS7uj+W0t0tuHOTx2Q5fY8c29chQgZ6vYVYBKBpwCM+y8gZixTnis90WUa
         0lCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUq2b4wcmuupYG2Dz8ZyMDeVYTTCreb+2EpGhZ66vYyORNCVFVszt5mKqZK7H44TWTfm+6IFcsKZfAqLJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlQmTs0IlbiIceuQ+96TaQHjHWH37+JcSv9dKSTVB4GbDoBQGL
	70xml8IVZu0NiD0MR1m9cdSkHqIUiWjJdIHjyTblMmIXIFkBkTBPXJ3GgGR8G+IEuyglEjwE7fN
	J9wY05bQq1xzZWuL45z7e9UcE4FlaggbGUox3DSpz/Q==
X-Gm-Gg: ASbGnctrjb35nRFwbYnCegqO9SQHVH8yrlkjQtgE2Bb1W4fCQSJzs90Rlxdo0Xx/BYP
	cbkHRLS/gJF7kTNczBHiZQGjsh76W6MCFdOKLtkNM1ixy9umMrdN4ecLCWqj0nKGU8Ff58J1LC+
	XGEMQd1T4LTX3TYbTMuTbvNwblq8XNe3L44oshhfaTgscFi1uBQxNrd44QntS5LeJGy3+o7wIIB
	FWpfqVvMChpCnSU6JDI0agFC2hLnOOj/47WFg==
X-Google-Smtp-Source: AGHT+IH7ov3L6MY+/rmciyf47ro1aYeL/sC/ClPN8jzfMPrPzjD7iBzVpIdeYJWjKJ4AasrYgahlFBVLjb5jrV6WEng=
X-Received: by 2002:a05:6512:2305:b0:560:9993:f14d with SMTP id
 2adb3069b0e04-579e1b68f17mr5336192e87.3.1758550862286; Mon, 22 Sep 2025
 07:21:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919-rda8810pl-mmc-v1-0-d4f08a05ba4d@mainlining.org> <20250919-rda8810pl-mmc-v1-6-d4f08a05ba4d@mainlining.org>
In-Reply-To: <20250919-rda8810pl-mmc-v1-6-d4f08a05ba4d@mainlining.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 22 Sep 2025 16:20:50 +0200
X-Gm-Features: AS18NWCnht0SxyHuFtw_GctfcVE1YPQlre0zCChnlr1t9VjjDpuBjNY-9qJgvpY
Message-ID: <CAMRc=Meh5WJ_C1wMjAk9CzFW729QfX_Fbq5diZ99GtsR43k8ag@mail.gmail.com>
Subject: Re: [PATCH 06/10] gpio: rda: Make direction register unreadable
To: dang.huynh@mainlining.org
Cc: Manivannan Sadhasivam <mani@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-unisoc@lists.infradead.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 8:49=E2=80=AFPM Dang Huynh via B4 Relay
<devnull+dang.huynh.mainlining.org@kernel.org> wrote:
>
> From: Dang Huynh <dang.huynh@mainlining.org>
>
> The register doesn't like to be read and would cause all the input
> to be switched to output.
>
> This causes the SD Card Detect GPIO to misbehaves in the OS and/or
> may cause hardware to malfunction.
>
> Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
> ---

I have responded to you already[1]. The commit message is still
sub-par. Don't say "the register doesn't like", say: "Reading the X
register causes Y to happen. In order to remedy it, do Z." You haven't
answered my question: what will happen to existing users of this
driver?

Also: you have not bumped the series version to v2, that makes
tracking the changes hard.

Bartosz

[1] https://lore.kernel.org/all/CAMRc=3DMeHQf_Oa2DRR0T7tum-Tuk3qPh5r5gimxGY=
3EXTyvoKZQ@mail.gmail.com/

