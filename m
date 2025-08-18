Return-Path: <linux-kernel+bounces-773423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F153BB29FC5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA865E65B4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D5E32144E;
	Mon, 18 Aug 2025 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bQ+isTgo"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494E032142A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514556; cv=none; b=oiqn9d9ugchkUq1iiPUD85NeL+89PC9UyecF+VoB9V+tIQTCvlbWC7w/UKJXOA+9jst7hdKz5X0xDKPLaTH5amAmtdJe/yJkXykXVj1xwJgPql8a0eE6q2cXoI7YDN+ndsY0DrKcshGK2hkSE+fWAhE4gP/VOAdVs96VoTxVLNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514556; c=relaxed/simple;
	bh=UP7+e4B8R1vPgU2CDLucQUs3/3XdVO4lV0FXk9HRIxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9Rhs7ORJwHm+SjVbqdxczddYFeLGDTtC2xaZERG/2rKoPPJIuCYmlTbOjhKFWk4DvTzI43YEp+vsdMvZzWp+5BvLriSi8rs4cZLvmK/Xlg6VatFF26ZlImlxy83zfJ+IrNu5CDQ6g4PhRggjIuRUeAsH4fVRYnMW4mMC9uwbqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bQ+isTgo; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e934bcb75f8so896683276.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 03:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755514554; x=1756119354; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QIGyc7zpEFVUm3lI2jgzfkEXQnPtPbTfkBgrHspZGAA=;
        b=bQ+isTgo5+PCrNlA93Lw63SVtP0f7ydYX1Jr8MpFr7ZPR2OJ2yWZqhUbs0HLx1Mmw6
         aY8OJ6IeQQJcLrSIv+DJ/TVEtjv8czQYpaf3yGH51aUBnt8dqgsdy1cr6lZ4FeYwWyio
         6E5egB1g53KyrzqQDbBGuPdwydKdlGUT6tuhsUxPFuL2+/J+YiSOyyopTdGghbeC0f8m
         dGBOUev1aNU6kkB2Rplw+IBt5gdWWGuTaiW+xfOPUeVLryfgyBXSMFZjjJzKhJ4dqsPe
         c9D88aPJ99ebehZsJndzd4SaEVLrjOU/OGzOeRHFaTUD7n6UGQ/Z/7mM95DaDTCNu3m/
         Ib2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755514554; x=1756119354;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QIGyc7zpEFVUm3lI2jgzfkEXQnPtPbTfkBgrHspZGAA=;
        b=LKfS6gAX64q21DzsdMwOsbNe44oX/YG6wR+1Z/En7rYNP2CnYuCZJnGaHuH4huHagf
         U6pNEMgf+FyU+gmYJgbUMZuazruYMiEAsad98OHIXnDpZv3Sk4eXHe8r5PxQL96phyWc
         5Dm9b0MMdcYEOEhxGgSz4iiOf+R5XMsBWHC1UxJnqRTUc6ESpEoQ/Xx+edHTgYtRO8KZ
         qjzm+25VD0efMvZWxbhmIbGetmnofCtfYNDaotAsMAZcBNXRLKoITP7Mgd9lDQ4NPkVo
         oBivdVRTLekjzrbVyNt56enWdvc+GtzoXChfq4C6lJY5wfBSy2TPoa6HNhKJHR3LV8jf
         adnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7O6Kqyafvu2BkjjfcJ0xFHb+JH4DgllL/NoiDwxEIiN2gnp/BUMGVcPPD/1jtyiBxcqv8L98GcHs6hAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA9mRUK/cOI10vUULjxDSnlBX0BxcWe2i9PxyhbHtzYL97Cyr2
	wLiCXUozDhQE53iqxsWpoy67ekguNkuVQYpxiYpdLgzAZ4ze6Oa+vHgR29DDaz2H/HiaMgKMHig
	CzWWoVTf3Hx9zsjyd5PTiw8cr8qD+8Rej9F00zBoAUA==
X-Gm-Gg: ASbGnctE0//U4H8NCMTnO+V0lnB90hFbncRMtsiHynyAPDyrPDnQ5sKseZkoguHS53Q
	IktGIE+dXUiJELY7YT+Q3LRrN92NSzsuIGngrmWDJ/BkoFuByN3Xg3l+S3C0vWfjAlAVxZId5O6
	Zy6lkwOAK0XUn3nvn0AVMJv/aDdUsatXIuZwfIlJY9y7k2mTH98Vem67ZoUmkuCcpKUaA4nLf8M
	I2M+nS/
X-Google-Smtp-Source: AGHT+IFkq8ZQsPYffmYGOn8sv5vUZY4ueg4jyolAPL3LCIeR/KHuj2dAdOaW0+N6sVeSogB72m6F5xqA/Vzy/BlhP84=
X-Received: by 2002:a05:6902:1581:b0:e93:4575:4d51 with SMTP id
 3f1490d57ef6-e9345754e38mr8117383276.46.1755514554219; Mon, 18 Aug 2025
 03:55:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804024825.1565078-1-lijiayi@kylinos.cn>
In-Reply-To: <20250804024825.1565078-1-lijiayi@kylinos.cn>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 18 Aug 2025 12:55:18 +0200
X-Gm-Features: Ac12FXwrjUQMO0k8DZEzoreMphRWa6TOQ4HOnWDvjf8kvUENWbni2X6of6EJVDA
Message-ID: <CAPDyKFr4CkPb5jTSsCOcsz+VaZRFOT5ZT-jJZ3oDahj14H_BWQ@mail.gmail.com>
Subject: Re: [PATCH] memstick: Add timeout to prevent indefinite waiting
To: Jiayi Li <lijiayi@kylinos.cn>
Cc: gregkh@linuxfoundation.org, kai.heng.feng@canonical.com, oakad@yahoo.com, 
	maximlevitsky@gmail.com, luoqiu@kylinsec.com.cn, viro@zeniv.linux.org.uk, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, jiayi_dec@163.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Aug 2025 at 04:48, Jiayi Li <lijiayi@kylinos.cn> wrote:
>
> Add timeout handling to wait_for_completion calls in memstick_set_rw_addr()
> and memstick_alloc_card() to prevent indefinite blocking in case of
> hardware or communication failures.
>
> Signed-off-by: Jiayi Li <lijiayi@kylinos.cn>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/core/memstick.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
> index 95e65f4958f2..3eeb93b51f80 100644
> --- a/drivers/memstick/core/memstick.c
> +++ b/drivers/memstick/core/memstick.c
> @@ -370,7 +370,9 @@ int memstick_set_rw_addr(struct memstick_dev *card)
>  {
>         card->next_request = h_memstick_set_rw_addr;
>         memstick_new_req(card->host);
> -       wait_for_completion(&card->mrq_complete);
> +       if (!wait_for_completion_timeout(&card->mrq_complete,
> +                       msecs_to_jiffies(500)))
> +               card->current_mrq.error = -ETIMEDOUT;
>
>         return card->current_mrq.error;
>  }
> @@ -404,7 +406,9 @@ static struct memstick_dev *memstick_alloc_card(struct memstick_host *host)
>
>                 card->next_request = h_memstick_read_dev_id;
>                 memstick_new_req(host);
> -               wait_for_completion(&card->mrq_complete);
> +               if (!wait_for_completion_timeout(&card->mrq_complete,
> +                               msecs_to_jiffies(500)))
> +                       card->current_mrq.error = -ETIMEDOUT;
>
>                 if (card->current_mrq.error)
>                         goto err_out;
> --
> 2.47.1
>

