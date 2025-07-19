Return-Path: <linux-kernel+bounces-737795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A64A7B0B0AA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 17:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE51AA6AEC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 15:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5F52882BF;
	Sat, 19 Jul 2025 15:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GtasaZZy"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9422222BA
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752939535; cv=none; b=IKuKImrobHBLhS2xoVXIiMfo8EnIE0ydOidj8c99fqZ40ETI1/oRkuS+/g7zfM9TeWcBws4Z0HXmtAn6YRMZfG27GjW03zi+dtGbJhFilvaUFR4p623FCB7FbPyBJJUA/Bs1zGnfYdOiL/C0V33jdlNzC6CP6maZer2ZHhHGB3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752939535; c=relaxed/simple;
	bh=esvGyu8JnnHIYbCLir0OmV0T51s3+8MXKXoURIZNyTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhShU2Hw2IiRxsfexLx6jAcjg4mS8uufQsuaEDGSmRpDCgRkfkzPOHBR2zkjNqHzozJHRAmwGlIF5LjDs2gPC//tn4nU3z9SGxLLjQ3fv5G0TtwDDZGQV6PG+7zMn7lOUv3K9YiVwLTY4CNB7C4AflSBAHCVflbyMsVQcB1N6tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GtasaZZy; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-32b3a3a8201so26818251fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 08:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752939531; x=1753544331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esvGyu8JnnHIYbCLir0OmV0T51s3+8MXKXoURIZNyTg=;
        b=GtasaZZykNx4LdK54H+dzExtvhEEuGHZDBY7FVV19QSUuomlUzQQaBZAkAgey3kFNr
         Iy4px2j3DLC4J0h4h/Uf9Pqp22TfQmord69f+bSbbt9c49KRhUVAYWsIz60gKpjYAofg
         mtmcyghjY+vI3Kk0mtLPFp3kJix0x2X0v392h+mZzasvIFwijEuWuoFPO+uYSOgeCUbw
         dvNYsEspnBOD2Aqn0ajJZFf6tL2madrQaZx8qyr6qUJSVM6MgqUNHOiQo2e4/k8DEcho
         TIycflbGTWzIs/a6S+cB6cygyZ7NIPHpq9nGj5rWXuWmcO9wBAArn2dOOmKIiZ7u/pug
         t2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752939531; x=1753544331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=esvGyu8JnnHIYbCLir0OmV0T51s3+8MXKXoURIZNyTg=;
        b=w7Ew5X4evPWBxdKBbSAsizgQ8Tk+tmU04RdICw481z1J4Y3CbzX8kpBc9N9EaSRqLb
         SaCCV3fO4W3femDOIXHd691x8rNts1J1IeahyHyHNZ8MzOlZIStvx0bGNs1otdogWTUh
         jkpDGLnDHygDUahwVHsBKTiXxcMopYfFDrI8u3dxtGqAA+ZYRqVZ5xwb4ay/86kmz9kY
         xG9tNYYhvC5WnlcJWVhQUtZ2ZzjYXre8Ar8BcVfsj9R4TcVPiJSQezEulWjwkYU0vcT/
         LJFTd22LpFjxjb3YNiTk/slCDW98IhmcYjA4xEiptIyF8wmKqutfIGSWM0f5qCgRYIfN
         EdQg==
X-Forwarded-Encrypted: i=1; AJvYcCXaumNqGOR9uBBpNwD/6Ogwy02asAhIPPrIXkIhjo1hli8uLe3QXgaSy3y2CLFMv8bkruJPiViwPitfooo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRSJ2uFFN4N7/GB9+0nC1NRqzSL/BQ65mnhFzr2115GYwvg1KV
	PpMeSe2QAEBH7ISU7xP3pqoSM0yRPCPWa36/H/5m4ItKDsF8RE1opHUhTJmH75/vX1XxkwHi9Zh
	TCOLBhhv6dsG0wlMgTT/34Hs7eNP46VDzv0nETtS4JA==
X-Gm-Gg: ASbGncs6ODRi1R5E6d9aUdHM8BKw35Y2JS/MjLlELuCclsFr017IXZVFdhj8Yzet2EQ
	ZNoc+Bx1GRihHKuSYsxTv0NSi1TgNJjbfsTeWvmCneU2qX0N0FZ4DkA9NFRl7aVRBZM1pRI94xn
	mX7jaKi9P0Jgz8pna4Wfyu4smyPHSvJIzweK54KRFJiFCMWqZmqJYHHn3DNIf/aBcWB40yNPJas
	9NPGOE=
X-Google-Smtp-Source: AGHT+IEwlbXHvry/qY2RXEOh6vpApFq8XZg4BSuHABf7Sre3nDCz/8jjYq1SEUpJJI5MtznrxVrRAdQS9Sa5qhK2BeA=
X-Received: by 2002:a2e:b911:0:b0:32c:a709:80ee with SMTP id
 38308e7fff4ca-3308f65a482mr33857141fa.39.1752939530816; Sat, 19 Jul 2025
 08:38:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717125758.53141-1-brgl@bgdev.pl>
In-Reply-To: <20250717125758.53141-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 19 Jul 2025 17:38:39 +0200
X-Gm-Features: Ac12FXzPHOlu5REnsZeyzyWx9zIDyQpFtIWVYfIb9ILC5hC-cRqM0O4_7jyb6Vk
Message-ID: <CACRpkdY1G1WyWABbJV2=sGzZLLRS5B+P7ZfJfpOXUTwxhwr+jA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: ma35: use new GPIO line value setter callbacks
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 2:58=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> struct gpio_chip now has callbacks for setting line values that return
> an integer, allowing to indicate failures. Convert the driver to using
> them.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Patch applied!

Yours,
Linus Walleij

