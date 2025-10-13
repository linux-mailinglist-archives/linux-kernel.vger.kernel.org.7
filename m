Return-Path: <linux-kernel+bounces-850552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67019BD3287
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E355D3C4FA1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D98227144E;
	Mon, 13 Oct 2025 13:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ptywgZbp"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BEC1FDA
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760361403; cv=none; b=QWs3TjB+YEI35MRmQcD8VnJ3AuceS8Ox7OPrAxgbbLx3aZNzFEkgqL837oGj5g5U3DR6RHIrzWZEFTmptvgOmVFFc/xMfczCyRBbPLpA+ws04WeBHzrIEWOlBsv4XPHDAziZLvRXl+Kj2n81quUHJjDZqXZjS0oTdYY/SGYHssY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760361403; c=relaxed/simple;
	bh=ZSh7Dgeb0daZdF491Vcis7pf3nDHt0iUoxsLAa3xTLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hl9Yf6a8ve58YxE5dDM57XKip5ijxNykHYRUMHh2k8mUJ+PKU48fxiXHfsH1L6zl1o0PFs8IqOdcjxm5i4OdtvioSY0qjQ08aIrHqlRxlIqDV6diLnG8TZBYvZ03RxHB8UZ3f6DO4mKcb8H2GIyGaNeo38UeJNg3xntktPoNybM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ptywgZbp; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3637d6e9923so37573851fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760361400; x=1760966200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSh7Dgeb0daZdF491Vcis7pf3nDHt0iUoxsLAa3xTLA=;
        b=ptywgZbpHwn1bQlqj9PqmO1E8bdgwmZySxr2OnNLGloseBqJ6LPPYAszL0mXQbZtPf
         HZ4H2LoyDIWnqLT/UjBZbKjU8tGCNNobSzMAIrHHpV+sNknalN0orh81voBuObiKLY+4
         pdYIhAf4GWN9nNlsXIdiwtyHB9/QRa2lmPivxDnYdxrto9vuuklEPEXOgu4UMFI1xxlJ
         Cj0EF9UOe3eyX5eNovWZWI9wyrCnfVlX/6z3MzEMENRa9FgRUjrz+G1jg0yR2jAOiUT3
         Nzk4tlvwKUZqFNxfiSJDc9S5FDoVnJFIDgvJaYbPcHWwjxAgdcHE/9AZ44lTIOq5zLlr
         ju+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760361400; x=1760966200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSh7Dgeb0daZdF491Vcis7pf3nDHt0iUoxsLAa3xTLA=;
        b=pg5N9foV6JTCYyIbXzXd9kVF3cMh+qE1XSdn6ga7W3LKSbi2CLiTFNm9Dr0nC1RGPB
         R6nl0L4jPSUMAwWfaPsDiokKkdRRTtMx0kljVvwNny733pfhTuLnP//IuiDXEzeq7IRI
         OJI3DLJ/g61JWGcDs4QutHcK/sTaQPWyyaaLHvNGdTmCXOagSPIhECtsHyAVdCEAm6pz
         swJBVpFhKAnn9qzljZVVsf21bfLauiuy5EjXrnAnzJ9tmv8Sk8oQBxXIvjsBJydlsWBB
         ZvxTdZ+jMpiKzrekmFMYJEG7na4KS6Os73KaTtwrCnPp6LlWumdfV8HgfrQHVg4VQZHX
         30MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhym695pSauvOhtBnwuJ1/v2DmMa9vSIBL+tpCTH8Dwoqk7hKEiyX4VZw8OkGd70JsTYM8/Ba/WJXctpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa65Rj6abaYxnpW7XtAGitJSvvzEtqhI4R4m2dZB9BvCSbe+3J
	yg8zledcHF/MlEBqHex/mpaKlrUwlvT7DwztpcpqxTI0hzE/ezyVEPJ8g58AdfN2rkmq4oF6dae
	6bUS+TgnpPvDwd0CQUXD8WbG+Qfc4L942+PtuIX6uyg==
X-Gm-Gg: ASbGncs0nfcUi/ZKC6ItO7cfmaFqG9lwvBf6OfIKCxiHdvZ0dwqeZErmSPU2jKjGuDu
	bd673nr02HaPRggn050+bFijYgF6H/sWL+WmZZoTZEY8uF7ywj0tlF6SWt5jnpKAjfvAx8SUIFA
	TmispocAO8B34lkLgwYaWSksT9jXlS6IW/ucm7CjPVs8xNfmPoxCskhSKxU0bCCRXwthYwp9wTV
	lby0F+wBRP4QYZm41R7lDvc7CMynJdMNwwQLuZh
X-Google-Smtp-Source: AGHT+IEZjgdJSMXGycisGGooIlBDTFc0ZlBxulr9PhHWH6RGYuSyos1294WYffX2tc7Z1J7gsvhrSvZBMucblVOe8EA=
X-Received: by 2002:a2e:bc14:0:b0:35f:a210:2a02 with SMTP id
 38308e7fff4ca-37609e6cfe8mr47702921fa.26.1760361400140; Mon, 13 Oct 2025
 06:16:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008-mmc-no-advert-v2-1-45bc00006fb2@linaro.org> <82b1d733-df39-4f20-8f69-69b34bfac3b5@intel.com>
In-Reply-To: <82b1d733-df39-4f20-8f69-69b34bfac3b5@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 Oct 2025 15:16:27 +0200
X-Gm-Features: AS18NWBzHhhxEZE9kPlz72rg1BVA-iIN1XSslkk1p78S4uXXy46XFsjUQ4i4LT0
Message-ID: <CACRpkda32Dw8sxkfDy9i19UP-59H-3WPNhffKLn+Pi7UgQ54vQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci: Stop advertising the driver in dmesg
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 8:11=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.c=
om> wrote:
> On 08/10/2025 01:04, Linus Walleij wrote:
> > As much as we have grown used to seeing this message on
> > every kernel boot, it does not add any technical value.
> >
> > Drop all messages from sdhci_drv_init().
> >
> > We need to keep the module_init/exit() calls to stub
> > functions for the module to work according to
> > <linux/module.h>.
>
> But is that true?

I don't know, I don't have an SDHCI device at hand to test..

The comments say:

/* Each module must use one module_init(). */

And for module_exit():

/* This is only required if you want to be unloadable. */

If it's not true we need to fix the docs as well...

But I discussed it with Ulf in the office last week and he was
frantically testing out dropping it altogether.

Yours,
Linus Walleij

