Return-Path: <linux-kernel+bounces-894279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 161E7C49A7D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8D091889A59
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247702FF172;
	Mon, 10 Nov 2025 22:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AudvVO2c"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C772EDD6C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 22:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762815213; cv=none; b=CV0RPVzfu3SnrwLhTykEgZT8sxi0dfgcCZg1NP2ezUDdMBYLopyBr/g4uHE5C+DgBm0LmsTZfhvtf5eHe3plm3e7z82H4NnBgHXuVsUsXXVuHJtyrRLh5SeAwYBiwS+3Pa9tgyzMFJlwUt5CHLs1yQ6u8YzcvzRDnMw6fdJyIxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762815213; c=relaxed/simple;
	bh=wisYcRrfbRCUS5Nty2NE2uua4YAjjkpHuPSNAbv96NU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iCzLMzJyvZ/iMdffrVbZ/KRqwOzO1smpsZAXZYdkuBSo1IR6fO8mAjwIUfvVGyZ0pGJVMXhNDdqD8k7dBDOrbe/AAX1XppLypvHRL+qezp++Vhu8UzDSZOXoaCHxv0sKgzdfyO1tpIO0DXEIhzoJiHWqtj1YbQiAW1aU7Y4okg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AudvVO2c; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-787f586532bso16052467b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762815211; x=1763420011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wisYcRrfbRCUS5Nty2NE2uua4YAjjkpHuPSNAbv96NU=;
        b=AudvVO2cMkyPBBwt2VKR/f0oHN0f0k6h118jW+/y565F5diSyp65yYptVRGZrhn55I
         KsPpNbCg2Q1HLaO/Xz6IGyRYtCtHKiJm7xnfEU94r57rSGr3FK+syusG69becW1ZwiYo
         6eUbAn1YGKK1sRnYF80Cl7sLxK5YPzsr2J0OYi19GxKh7UonFjagPCXlB9d60lOqH6q3
         8EALVKAAcKl3odRqL5NJF5fvc74qARSfXqFkCo5BO26UkK/F9SQ4HhU+zG1B95HrhBva
         c5VtiSOAheZ2LaAHL3fpfwdUPFlCoJt7Ij3aa9/615Y7tZ46vD1gTPo6DHyo9ZV1/87A
         p03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762815211; x=1763420011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wisYcRrfbRCUS5Nty2NE2uua4YAjjkpHuPSNAbv96NU=;
        b=FfgPEwSpiztsNixgiB6/5hKUII7nB6FAoYZ3ymZPllQnSsAt79VfkH1CVu+r2yzWn1
         nS4dwsZO8Z7pFaRct8IVaN6TK8UiyQZw6k7zNPEhcW2A03O+Q9FeIHvex+DSrwZz+kpv
         KfoWUJIaMtnLjmPb69o8ho0tgoi4z8cAN4XRo+/8JeJXDSzTQol5GBP6ra0hdYCFXn6E
         gCY82A/YBFrZg2jud0dJPh5X3bdl38PkwCGu4rfrb46cRD27Z4mYnH4mj0d3VBt8WtMU
         4/YKurVkSPlqNqm2boTEjhTueP5QapR3xzKQgUckaMALbwWLDk+x774YEAI8teGAv1Jz
         Tn/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9xtqlKvOSvdq0TQTGtjJXWYKLD2zSProKrSQiGzilyfhcNMwU7iRCCI7V7m3GyBvzqkHCYny+oHhun5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3+wUyCLvSd83PJSD+lhU7U3mCCKuJcd2okAGaEHeu1L2mJs3b
	VhWaC6xW7TbteUqmrR5TDzoZxPIvcoqPrgvyF72/z+YQTUrp3OeVr+NNivSNZRvg/Erhgbd52y/
	Y4xCbxFU0Hecmg2W2KkLbqQjX6G7Syyk2JfYl1MK0HA==
X-Gm-Gg: ASbGncs4bo+DC+etKAOwvZOOEhOsLaZHr79z9vpcS1CYgUT4jDhzYSvUXdeXOlYvto4
	qs17DxZli5/3TLIe35/QvnEUwOq5kDDnGk/3f36AwN6PtUj5JPSKkOdZ6lM1EyABNyRM7JU/2S8
	Ce+48M6/o7EaQm25In28pWpKe42Ds8vtKRmCkZoDnLCBLqKEFuKrKJIIxX+/agQFlqUbDBbe8Hh
	l5H55NX8L1N1+jrcWdaL29nnVRUrLm269xuHCBHjUtBt/9wMV2Rr951TSVn
X-Google-Smtp-Source: AGHT+IHNyQvNqmdYrM78QwHVRvJjiWbfKP8B2ocT8ZX+eLdaIL3JAgnLzsUw0lJqDlEMqAhgvtyOmYzmDcTqXg2ZMiA=
X-Received: by 2002:a05:690c:b96:b0:786:a8bd:3511 with SMTP id
 00721157ae682-787d5344644mr101270777b3.4.1762815210861; Mon, 10 Nov 2025
 14:53:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105163610.610793-1-jelonek.jonas@gmail.com> <20251105163610.610793-2-jelonek.jonas@gmail.com>
In-Reply-To: <20251105163610.610793-2-jelonek.jonas@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 10 Nov 2025 23:53:14 +0100
X-Gm-Features: AWmQ_bkxttTo889YZn0qA_t2H-4zQ19FSfxreSfKwmw2tLV48lnj9lIQa9TIwuI
Message-ID: <CACRpkdbo-mT18fws2J1eUsN=-KQQ36YLiWS-p6nTwRqHnmDq5A@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: gpio: add gpio-line-mux controller
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Peter Rosin <peda@axentia.se>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Richard <thomas.richard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 5:36=E2=80=AFPM Jonas Jelonek <jelonek.jonas@gmail.c=
om> wrote:

> Add dt-schema for a gpio-line-mux controller which exposes virtual
> GPIOs for a shared GPIO controlled by a multiplexer, e.g. a gpio-mux.
>
> The gpio-line-mux controller is a gpio-controller, thus has mostly the
> same semantics. However, it requires a mux-control to be specified upon
> which it will operate.
>
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

