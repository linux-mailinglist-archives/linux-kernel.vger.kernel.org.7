Return-Path: <linux-kernel+bounces-781643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A38B314E7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C4B1CE43F9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE3B27C872;
	Fri, 22 Aug 2025 10:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LxpRTgp+"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDDB2D3A74
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857784; cv=none; b=PgLplL90USms4GAPt9188gCunJbL/yOENWhMA3ctL+FgQk+G0rEmAMurPtlrkXV5Ok2Hgg8MA1OOSzZbbZu8bPwMwpYDyHigdX2DjFrLP3r9gih67CkTMs2HHsuvTpoACVzV1JHML/iCT/u+bi4QdtwIf/E1tw51J7FLrFCVKoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857784; c=relaxed/simple;
	bh=ljAWuzvOYiIpTo6Czaq+47GM+C7kMXSt3L2+v0PFt8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SF1eaqb45yTl/vGFDBU/FhjhTXOXrSqI9Da1AeNnN24aUIEyVy/tL6nb+ZVR2u3sDCHARQpQ7faT7yn+R9lzf/7fgNFk06n1hKPQUUiPm74zwNQEFvaBq8mMQW3MBsqXMkp7DfryOtpDgsjTnx6WZAeB/ItxHvMT1dB+D3vy1f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LxpRTgp+; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d6059fb47so15853577b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755857781; x=1756462581; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XnmV0us7Kg27Umkj8/JkmwkYYloh1umV4GcZnJysZtA=;
        b=LxpRTgp+GortkgvvCHGdVQlJekUFhnsmNwCeQl+PyWfY+3EARRGSupQ5aAenLuApCK
         nISjSmMrfH3vW9W56oAXACeCoGSGSpoBGpps6r1Kf7xHkWIn5sXioYZ8btJp/HxWy4TY
         UD3jvNfbg2/dZPt7zYiKUIngHCpYX4n2aXR7JIEa9Df1C9jwCP2V5Wi0ToCxr/KnnNNW
         u5wJ6C068EzmI5c3NQEYamG7rIiL4/Y1W7ICiIYsHmzpvCbsQWfnspEsntZByTtwkaC4
         Ihp5x7e7D5iI57R8HO2RXHAKZ5vU5egxMSro2SVeGDn6wnadT2UosTyUaGrIWEpOmGLj
         VWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755857781; x=1756462581;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XnmV0us7Kg27Umkj8/JkmwkYYloh1umV4GcZnJysZtA=;
        b=nAd9kWfJcnKx1f+38k0yyhQAfFNJplBDSMHZC1eeKw/SBCB/+55OFmlNcHYcdLFaVH
         Bifv+yiUYYceq2EAQ3VO70wnKWyemedu9BPVqtwzyFBWSyrUhHQee+IGt8E5QZCDLVaw
         fOB2r7uNTnoPEuw8SQBHXdtk8u6jR1JGl/5gNHbbtPQGxTM8iWerKHWzbyt+0X9P4Vr5
         n1rNTYtOoVH0JxYSSn9jGAyYeOwPnxofwJJAajXDg/PgRYZGr7pFnd/Xtq4iADhD5RH7
         5FblkHSt50e70wmxyRMX+G62A/KzQy1ZkGA8AjqXoQv+f7b51nF97WStJ6xnFMOz6ZuJ
         kNaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD2wBopk9CwwScIegfTQgTsTCQkLJnAKd3E2Ep/n9r/QjOlf7FG/1vCKp2aSf0sBtk/aWCLWPA6vCfdjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFtXfwqnDw1Ak4Bw1TM1u+3ikjGK+Z7vqzwGsYePYx5vcbXEYR
	PaEfACVPiz/5RMCxW/wbG3V52Vb62JDRJQff43t9zepYWzEKGxt+bqpe7fo/+uiCcBcRx0zmVLm
	ZD2gEf9XJ7TSAZsMP2h5WaHH00G5EBDFySHKMahhu1A==
X-Gm-Gg: ASbGncsnIov7HIXELOtpo6URm5dL9FSreoDeCDgE15Th0LMSb824dP6AwZhwso5vQyH
	8jy/dRYwTtl8cNB3V+26VHw3S5Hp7VNNXPEfoJYuK/Y3oWHs45fruwlWOE+Z689wXu1oRisnswt
	8K6o+9PCRVlUqt/nyMEA3h+8sQLYRpzCFfzmSQ8qNFGcaZkwt0aK01R1M/j+PWBI0lVUhUxPsTJ
	rRxwZr3
X-Google-Smtp-Source: AGHT+IEpjzEssQlLmXKXxadk4uEAS3oj1+xFV7AZ2qzlp06a7zrZrtPvDZicfzfIyyJ392bIlgHbjZLUDN0DNQK3CX4=
X-Received: by 2002:a05:690c:87:b0:71e:7ee9:839b with SMTP id
 00721157ae682-71fdc2e30a0mr26325577b3.12.1755857781289; Fri, 22 Aug 2025
 03:16:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aKcR2ea747xkw_it@stanley.mountain>
In-Reply-To: <aKcR2ea747xkw_it@stanley.mountain>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 22 Aug 2025 12:15:45 +0200
X-Gm-Features: Ac12FXx4XgJqgvW0WIQS_GDqdVbcgIgtnbc-eSHmfbfjx2viLj3OvkBKaDsAa_w
Message-ID: <CAPDyKFpHTktROvbW5ev6e_VGoVOUw=2EvRoMzmWLNfqoCPSykQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc_spi: remove unnecessary check in mmc_spi_setup_data_message()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Rex Chen <rex.chen_1@nxp.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Binbin Zhou <zhoubinbin@loongson.cn>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Aug 2025 at 14:32, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> An earlier commit changed the outer if statement from
> "if (multiple || write) {" to "if (write) {" so now we know that "write"
> is true and no longer need to check.  Delete the unnecessary check.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmc_spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 95a32ff29ee1..42936e248c55 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -566,7 +566,7 @@ mmc_spi_setup_data_message(struct mmc_spi_host *host, bool multiple, bool write)
>         if (write) {
>                 t = &host->early_status;
>                 memset(t, 0, sizeof(*t));
> -               t->len = write ? sizeof(scratch->status) : 1;
> +               t->len = sizeof(scratch->status);
>                 t->tx_buf = host->ones;
>                 t->rx_buf = scratch->status;
>                 t->cs_change = 1;
> --
> 2.47.2
>

