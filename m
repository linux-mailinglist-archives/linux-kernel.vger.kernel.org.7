Return-Path: <linux-kernel+bounces-864874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E2420BFBC07
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 952F24F8D1D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C82F32AAAC;
	Wed, 22 Oct 2025 12:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZU0fnZtG"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4C229A312
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761134444; cv=none; b=g1SIrtZshOn0jlrpkO3nx2vqBpm1CAs/qsiuYnETZXYm7gIiparIr1gch4+Bx8AGFxgbsRAiwy4Y7Kb59sQIfelVd1KkRGyFoEb65S/JXjekL6ARiqyPz+l9k/HzOPaI1GjnTbfObnG0z9kploUYJrppcx995bZfQxrw3SdjZG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761134444; c=relaxed/simple;
	bh=97a8tZjKqwRtHNr6BZl+meSJb3s8o64hqDASwzxbu5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QbSAx3Xo3HuCMAcTg0YE/csSotp9xGiMAvCJtt/pBmtGpSSvdIr4yqYZjNjMhJYjGmtTWSEuN0wEFUfDhpxFjPhUby5nuTz4T0T7qT3jIE/IWS9ngZx833/ut8t1wcSCmcA2B9H2Y3FcizYiv416FFdnFhuZvHl/qZeA6e/ovEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZU0fnZtG; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-785bf425f96so8564677b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761134440; x=1761739240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6uhgqipKW89TbAKSJ0VsiSw+i7Bc0BvME8dlqiNOkU=;
        b=ZU0fnZtGUkFNuLa8Ca6e43Ct9sxzfOOMFNaD/PsOrrOIveuOY7JsxWvOuqyz8EarfA
         TooN8WmQWzEWlnMScJOSM9H4gtWDzlxtj2bqLSlXnMxv0gtZQWk19KaRQ6tm6BgZcxaw
         Qb3DRFQZDjD4/xKWBl9AaBFWNUCPir1scC3exaxZbF8lDVV5NpArwYWzo11fwi5ii4F1
         Pfr1ZMmDhOrTvcm2Z57Zj4GIAHL1RIexvGC6RgHQaUCD25y23vjfBen9k2VukcKern18
         AvQL9FnGDL790sKs1WsCuE7JW3o3X4bA5UfnYJLtpa36JrSFOmKfMUKlPZxJAj+Hn42y
         AQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761134440; x=1761739240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6uhgqipKW89TbAKSJ0VsiSw+i7Bc0BvME8dlqiNOkU=;
        b=Rs63N7dgNxVyUweoCfaGZ6nI4TYCd5aicVBMQcj9LLfi2ny8HRjoIRvlORohabwhCQ
         pNDNtGQS6kwyooFQqoIFTLNeraH4qfk2J2yC8FyOVA0ziHqWbVmHTKnYyatrTHqUSECl
         xm5kR7uwK7e4RBHmv7fFEFrNM40DxGYTuJDJE4Cy5lRkTT1SbM7fSkevDkJzYrZqJe9H
         +VJQ6Xw5CUYPswSUg1YF28i6Bg5W2PEfNlMvVgl4s1o8f1St9bClJUA+Yd1f+9mDACj3
         IAqD2HpZvcIK/n9mTcBBJaQir8bbcP8d7J58hOFqQ5lmMal8MWxagnL57q5a00stU+U3
         9OfA==
X-Forwarded-Encrypted: i=1; AJvYcCW+ySqyumQSWBEetHljgkBT+AW/6N/VtPjoAJruY5kBSFRHIfwao6bzKBcJ7zYvJF9RlucN064XP92fZ2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFOUFnHhSbUN7ZIsgcJXvA/0C+cfszHUe91EDLqhRTuv9pPsYE
	bjNAxWrk5vd1JgN9gzcfYntoI0Y12cB3cJ8Gdgi8gfwCB/1l01/nc/2Flftl12LiG9k34VpbmhZ
	UvLAoYTmX8+O9nz0CwDBZsiVyK47M40Y=
X-Gm-Gg: ASbGncu4vXf8nl9ceTxMfAqxOw315HcB1cZ1PtZkkX4UfCGLAD8+2ZyvRlRRYUSYXqa
	RFQ1QTNumCWGEl6bojw4VgzzFw44fdAhUSy2NhNs1Gh5FDAylJDp8Bck5XrK392yUWhLkcpj0v5
	doaHj2fUdVdj5Sh+/vmyq/o997XK/UBMQnwVDqV/N8HaZ9zwPBleo+raM9KbwAu/dcz2fU+e4z4
	nXL5bwJbv3aOu8jzox2rtOyZXTyx7nESA2cE4l4RR0DI2GB8j9RIH5UgPZSTQ==
X-Google-Smtp-Source: AGHT+IHe7HPf6WFvrCRkjbNGAn3hqNruzzhDGzkeQpPjDeNqpVAuLbWf1eiEYp5Q7LepTL72CtjhjX2Ia5Crn9kuh08=
X-Received: by 2002:a05:690e:1a8d:b0:63b:a941:90c1 with SMTP id
 956f58d0204a3-63f2f5b4e47mr755807d50.12.1761134440040; Wed, 22 Oct 2025
 05:00:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021104002.249745-2-srinivas.kandagatla@oss.qualcomm.com>
 <20251022003429.4445-1-threeway@gmail.com> <76567559-4cac-467f-9740-e8a539a445f7@oss.qualcomm.com>
In-Reply-To: <76567559-4cac-467f-9740-e8a539a445f7@oss.qualcomm.com>
From: Steev Klimaszewski <threeway@gmail.com>
Date: Wed, 22 Oct 2025 07:00:29 -0500
X-Gm-Features: AS18NWAgMZIyWSBaRtc28HmRupfvFkfndCADg6zxwcxhZ5F7Sr-vfM6vIit3CAM
Message-ID: <CAOvMTZjjCn5gDgOrf_2++QjfdCxz2PXTey5Nh_-=caB4wX1g5Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] ASoC: qcom: sdw: fix memory leak
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: Stable@vger.kernel.org, alexey.klimov@linaro.org, broonie@kernel.org, 
	krzysztof.kozlowski@linaro.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz, 
	srini@kernel.org, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Srini,

On Wed, Oct 22, 2025 at 4:52=E2=80=AFAM Srinivas Kandagatla
<srinivas.kandagatla@oss.qualcomm.com> wrote:
>
> On 10/22/25 1:34 AM, Steev Klimaszewski wrote:
> > Hi Srini,
> >
> > On the Thinkpad X13s, with this patchset applied, we end up seeing a NU=
LL
> > pointer dereference:
> >
>
> Thanks Steev,
> I think I know the issue, There was a silly typo in 3/4 patch.
> Could you please try this change, I will send this in v3 anyway;
>
>
> -------------------------->cut<------------------------
> diff --git a/sound/soc/qcom/sdw.c b/sound/soc/qcom/sdw.c
> index 16bf09db29f5..6576b47a4c8c 100644
> --- a/sound/soc/qcom/sdw.c
> +++ b/sound/soc/qcom/sdw.c
> @@ -31,6 +31,7 @@ static bool qcom_snd_is_sdw_dai(int id)
>         case RX_CODEC_DMA_RX_6:
>         case RX_CODEC_DMA_RX_7:
>         case SLIMBUS_0_RX...SLIMBUS_6_TX:
> +               return true;
>         default:
>                 break;
>         }
>
> -------------------------->cut<------------------------
>
> thanks,
> Srini>

Yep, that does it :)  Thanks for the quick fix.

Tested-by: Steev Klimaszewski <threeway@gmail.com> # Thinkpad X13s

-- steev

