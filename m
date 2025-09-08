Return-Path: <linux-kernel+bounces-805861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33440B48E81
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDED33A66EE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FE43081B1;
	Mon,  8 Sep 2025 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pf8y/Cpn"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A0212DDA1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 13:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757336538; cv=none; b=J0xneffntOR6nHFwtnIYiRVNQXfDfSEbHESgee4Ys+cKr7b5+JNvCWMJnemd6TZbCD+RYrMO3TeWCsyQsZ8QOPOSqWY65hmdbeVo7PMS2v9wiGmsuFak1/ffosXmbEH65ozCEoDERM9HucYvoz1ibixdBsi2XikAPuDmB8pzSJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757336538; c=relaxed/simple;
	bh=tF31xmJcbc0qseWIsNrqZ2L4YD6Ay+rKlY4qBWnaoK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uUNk5bbs62xiENww/920uXq76IGqtbkpjF6JzuxQZlaVP6Xa7Uqq9v7TD9ESong1/9sG4PzgUeOmQ2j5djYy/wlbH7zu71vWHQSPq81RqC9HXfcb8lQxFrdF8Y8tWQjDgepeS65356cCAgZzURGA7kOgvr8riwZWLg9fO739fAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pf8y/Cpn; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-336b071e7e5so35212361fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 06:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757336535; x=1757941335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tF31xmJcbc0qseWIsNrqZ2L4YD6Ay+rKlY4qBWnaoK0=;
        b=Pf8y/CpnKt5YKIqQgTlDhV1TZgOan8hz3Zim4/SwRNbSd0BFNw+UvnPWlBV2O94HJH
         LL+gwy+vgVDbC5LcEfMUcb7JEpd4xyCpB/ZepL63N+YVBi3Z2ZvhKV0wBzVcobfYaN03
         HHKD0tYzcGhPn9UbX8SGhhEsYEgXSuZ1iRcBd+wLQaWRu4D2o97lhh8TC80uVTcvNdJY
         aMKeJy1XMMaFeP5LSGZbA/A/sgTwF7mNxIZgdmijX0qGkZHYhmzMhjxPriY0/1LeYLkq
         7aXY3aYnrhigj0kP5h6a0wuJQ7VuzcN7eOdr/ghDqyFHSkhBXqlv+afg2uuCSDo2Xf9s
         sRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757336535; x=1757941335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tF31xmJcbc0qseWIsNrqZ2L4YD6Ay+rKlY4qBWnaoK0=;
        b=EOqcWg2CNDvfwUom1T1/Js4n6ZwNXNhoFOZhR8t85uqF7qXqOvD9RZhSbQZlq8jbvR
         c9w1TNJUcRRGuOPdDQRV9bIGxrDI2kywveRs9Nx6pcoY2zJ2T2oMgljNuroyvmJxxNd4
         W1D+UFVnaLgcsWheALt41Rl7XpvwcCw9b5JVDtjZdrFQVrPsIK13k4MgLOtb1MtSfhvC
         lGXRMnMBmsC6S543+FHXNhuz2hmoYaGXq+zg8RSRCMkaZYoTTh1Fe/49MtgDx7Mws/gq
         VEJ9btCKa5KFtpOxUwKB4eHum5vP1BiJ84aWRxTbHpn9dQNKogO7sKCh/JfHNiQrBiSx
         92VQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6cK31XaxkfrJ2WiJf6/iKsZh1fT6aRnua7J1CH66m2hNv1w3gF4wOkABykzLMBSGwImNRbVxN7d2TH5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9bKvbAKvvaMGSrqmTfjOM/tx9QTQZ/03UAP+zADUfy1LBZPOV
	1DUqX23Kq5cMj60l8Q+ZxWAg8E3Sn1I4hNRl7QPCCmDJHNJw9FEdNd57jdevlIT5S9v0fq1aled
	SsCANVSLLWtR7BJqJI25QwpkDttF2sDspV/GxJZVc/Q==
X-Gm-Gg: ASbGncsCeLxKZOqY8wljR2dAkeCKG8RW05oVoFqVXzhyekipKXfEo7HT7NIzbTo0ec/
	yN+CHxeHLswPtrhSXJuxkWz9mvsZ5FwJ3XC/UscgrNGitLXx6hzCMNKBwRGTUgmYDuIBjz+bL5u
	/e//wEcJ425jLktQhweBOQ9gQuDOmepi7e19R9nIRqSLT7SMgmnWzdocpK2MatDENcWO98cqhT/
	46XCbALxPucIwJXnA==
X-Google-Smtp-Source: AGHT+IEDQrNGIVJ+srnhccYYtb5VT5e/nczDh/a0UTBab1jQ6lcNoipDjpuZsUUuvBbVHlbzfGsEUZMyzV5z27NtBG4=
X-Received: by 2002:a05:651c:b0b:b0:337:88c9:4e00 with SMTP id
 38308e7fff4ca-33b4d6e156cmr26649511fa.18.1757336534706; Mon, 08 Sep 2025
 06:02:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908113425.31002-1-ansuelsmth@gmail.com>
In-Reply-To: <20250908113425.31002-1-ansuelsmth@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 8 Sep 2025 15:02:03 +0200
X-Gm-Features: Ac12FXwmkJnm8MDVmgkMoi1FgB_EyiAfRHJw-rYt80JRUULYhM8CUT2H32uFUK4
Message-ID: <CACRpkdZJtHU_pne=48UDBgpfM-9FnJsC8sfN6c4zV4KmDWs4Pg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: airoha: fix wrong PHY LED mux value for LED1 GPIO46
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Benjamin Larsson <benjamin.larsson@genexis.eu>, linux-mediatek@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 1:34=E2=80=AFPM Christian Marangi <ansuelsmth@gmail.=
com> wrote:

> In all the MUX value for LED1 GPIO46 there is a Copy-Paste error where
> the MUX value is set to LED0_MODE_MASK instead of LED1_MODE_MASK.
>
> This wasn't notice as there were no board that made use of the
> secondary PHY LED but looking at the internal Documentation the actual
> value should be LED1_MODE_MASK similar to the other GPIO entry.
>
> Fix the wrong value to apply the correct MUX configuration.
>
> Cc: stable@vger.kernel.org
> Fixes: 1c8ace2d0725 ("pinctrl: airoha: Add support for EN7581 SoC")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Patch applied for fixes.

Yours,
Linus Walleij

