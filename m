Return-Path: <linux-kernel+bounces-878825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B97AC218BE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38A41AA0FA2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F493253B42;
	Thu, 30 Oct 2025 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnHAwF/D"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1950F36A61B
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846259; cv=none; b=VtG6p81CCuQpIna0PvBDE4nUi8U3OJRdEYFP79rpJ0OSdCUdOHvg6h7tjZtLQaVQc4Mxoz2moPvfgVxvuzyftTXoEnc6yPgKaFkDjg6cTXNT7HGdlZymMvqqh2ZPcTPmpkvrMFNodC4yg3+5rHnTugnsRTuKA0k4xaVHpCVdK+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846259; c=relaxed/simple;
	bh=D6cA0tuKeFpeMg9nWmYaQYp+gHaB5LK2pOt58ibUKA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=saWHHhoxJ8zN28aTa5tPSWOHy2Xms2CxVf0MLYNp8wy44W9me8fWiyjG0ZMbKf8v4Hixn0CFFDsofzNGOonxB0W6KhSOqtUWn+X/U14hiCJhcIZQaeOjOT84RRfrzCJx+sOgs92W8LnrUDfp1cgTR7NX1m8PDSeRa5v0V5jm63g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnHAwF/D; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-785bf425f96so35210887b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761846257; x=1762451057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPcGBwo0LIxONJDvhEXLjvnHJC4KOb17GqsunV3dmKw=;
        b=OnHAwF/DFejoPBpnC6PrPbPyjJqHSgn4ZRpWE3jjEC2n7KWT/IWkpFFlAw0yvGP1wH
         +F0Fb0qDhBlJkqIwclzEup6d1L2hlNuBGtaq+YNf/A8L5XViAr9jUk/NfztpUs6Kmuln
         3HOJSASODT2cowculb53XIMp+20Qh+Og3EdALmvIztSCVKkXOt+Z7pPdcAiAEw2gWrYB
         FEZnYfEot/mMV4ABwclvVKl4W4UAwfT+P710Ylz4Xv0xrT7I9+QI/YWbe+LdjmXCy4zD
         SJhEzkclvc2kNJpXfCJLJb3roVR9yDv1MoBAtJ/MNnhinEpkXx3q5wBdxCwdruLtV7Wj
         xpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761846257; x=1762451057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPcGBwo0LIxONJDvhEXLjvnHJC4KOb17GqsunV3dmKw=;
        b=Yh+LKaO/bEHSymR4daRcZEa3qdTGJf2KaB3Nx6IfBbq+uVr0VaJQ1CVgqEb4WH1wLn
         f1jOCAUKgGy4eGzRwDChuaQPSICNiAzaGPre9wXDxsCPnJ9orfnFdyyILJpNJeOfLmlC
         ZrysZRBER7kmKFYYTTuTAdUYJgfCfyLXCPwoz2tBML8KaM1TeBJKNtYB+/uTRh3uxdFj
         O2BjUQHYMomRlBfXEyrLn8LCi4JuYal14AgkR7hvU6hQeoe6J6Nx7RbvS5qKANqAJvl4
         rYknrsz6u5oWylOMA3wu7yO8IrVYaOPyHdXxzUcPO8ofjp82Ib/pv5MnnmaMqV5k7I7l
         Z0mQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0kNgJMrU3jmqt3mJLai1Tk68uvm+sBPdR+7OfVkPvuqHOdNh3Uvac2uDQEJIv2x5se8WqVQS1gqeMJDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgmkYBOkBfEQCUn/p74AFd9z5TpCgi+QCldIHXp3JROVWsoUri
	mgp2O6W0L5/8o+3bL3ndmhanEEoZT3E34IqssOwVQ/bIBMVps4wW2alafUOE+jA46orWNQo2ULI
	3ei/5lBOOmrAXqeuQIgwP3EopVXmbUGM=
X-Gm-Gg: ASbGncuOjaasZdaZ8hGyXsgTk9iqRyKvOoEvr54JTK47iHYSdebmqL5k9AeAuLEYwIq
	EnkqDynf0BnfwOgLtaL8F18xRssujabZnJ0NV857yK7C8qS1cWkU5GcNV7oVvz5arIJn2RnGGDO
	tSCztxh+lF6QZCpReFIW83Gt2YW+bzq1GvY3G1ADkuM/rhlXSVw965Eq2Obx7Rx7KcjZFs7LSCA
	UNHXOKYhJg33wLg0z99xmJEv2lnxWdbAvDCHBkJh59733ql0K1+3jdYtP4=
X-Google-Smtp-Source: AGHT+IHUzr1i1p7RU6UbmOcxsnFajiDYf7p1VqY7fU7ZTT5VMVQZ7PZnaERwesvfRaKWecuNG4UrqRarnwwWYMVZGFg=
X-Received: by 2002:a05:690c:7601:b0:77f:6c6b:bfdc with SMTP id
 00721157ae682-78638e17dd7mr32251337b3.21.1761846256822; Thu, 30 Oct 2025
 10:44:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030063704.903998-1-willyhuang@google.com>
In-Reply-To: <20251030063704.903998-1-willyhuang@google.com>
From: Daniel Ogorchock <djogorchock@gmail.com>
Date: Thu, 30 Oct 2025 13:44:05 -0400
X-Gm-Features: AWmQ_bmxtubT41TSd360g6dW7G4Zo3f5Auufn28DCK8uKGh1hxFirWw0tHt3aIE
Message-ID: <CAEVj2tkow09F0CpnWBy1CqyC_CGTqkPkH4geNgCGn5R_ZGD9TQ@mail.gmail.com>
Subject: Re: [PATCH] HID: nintendo: Reduce JC_SUBCMD_RATE_MAX_ATTEMPTS
To: Willy Huang <willyhuang@google.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Willy,

On Thu, Oct 30, 2025 at 2:37=E2=80=AFAM Willy Huang <willyhuang@google.com>=
 wrote:
>
> The JC_SUBCMD_RATE_MAX_ATTEMPTS constant is currently set to 500.
> In a worst-case scenario where all attempts consistently fail, this could
> cause the loop to block for up to 60000 ms (500 * 60ms * 2, including the
> additional retry after a timeout).
>
> This change lowers the maximum potential blocking time to 3000 ms
> (25 * 60ms * 2), improving system responsiveness and efficiency.
>
> Signed-off-by: Willy Huang <willyhuang@google.com>
> ---
>  drivers/hid/hid-nintendo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index c2849a541f65..342cd6893502 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
> @@ -819,7 +819,7 @@ static void joycon_wait_for_input_report(struct joyco=
n_ctlr *ctlr)
>  #define JC_INPUT_REPORT_MAX_DELTA      17
>  #define JC_SUBCMD_TX_OFFSET_MS         4
>  #define JC_SUBCMD_VALID_DELTA_REQ      3
> -#define JC_SUBCMD_RATE_MAX_ATTEMPTS    500
> +#define JC_SUBCMD_RATE_MAX_ATTEMPTS    25
>  #define JC_SUBCMD_RATE_LIMITER_USB_MS  20
>  #define JC_SUBCMD_RATE_LIMITER_BT_MS   60
>  #define JC_SUBCMD_RATE_LIMITER_MS(ctlr)        ((ctlr)->hdev->bus =3D=3D=
 BUS_USB ? JC_SUBCMD_RATE_LIMITER_USB_MS : JC_SUBCMD_RATE_LIMITER_BT_MS)
> --
> 2.51.1.851.g4ebd6896fd-goog
>

Thanks for the patch. Seems like a good change.

Reviewed-by: Daniel J. Ogorchock <djogorchock@gmail.com>

- Daniel

