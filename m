Return-Path: <linux-kernel+bounces-838782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161BBBB020E
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 13:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A622A1043
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 11:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5C12C3263;
	Wed,  1 Oct 2025 11:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R+EHTCxk"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5110B2C178D
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 11:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759317877; cv=none; b=RjYHpvONIbUFsCI843RuOwcU6OGpc2Ugi/mw5WQ1kyHi3d0MaD8wGfHze1Q0lBY3AgNBgLMrhEbhY5Msnc/C2erwvqDLvZD0OuBsLCAtDnAX8hfR5a4XgOZLYqNWBOODa6nzzXQkw9ZLgMsKVsylFm2y245JBOHCByNvAugCrdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759317877; c=relaxed/simple;
	bh=5e/F6QKv/vvIaNOCn+i1T0+gkBtuWnI86XhAnampRNk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=mZtBT9myOS/Sz8YwmkVK44Kqim9lvp9EV3kucrnpdpnP8CrFU40v6BBS8gXpQmaKwOhBTr9BnbwsYKaUi3eaOIM30gWWAcfM7eHnIhvxY9UZwR8uaAui0Q0T+jqQqn7AiTbfRJhWEjkNcAHC0Sf5gtAVrqxWLzCA90kZeCrXurE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R+EHTCxk; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e317bc647so45882735e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 04:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759317874; x=1759922674; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loyJAwQrLX68E+xJ/zLjfhEY3jyjUwwo2QQ6EsgIrWo=;
        b=R+EHTCxkowXKiJqW2azLB159NiOyF0KfrXw9Ppus2Ucpt3SVD+O6U0bsereAf58/jC
         HFv8fsj1wTct/joVo5XrVdhjNh1cVY/zb7zRC7mY1cwrhdp5Kk5hwKl5gQ2GCaBR5cIZ
         Z5UkdaxDve6kQwWAG8EHfb5t92KNzo4pg0FvRhE2+1hL1UP+37U9ukRNoeTiZSa7bSCh
         t4ZDkEBREiHuf9CAo6/jImUbPVvfDBYK6L3pli5QudwDrq/WpfmQX6JSW3mnxsU6vr5c
         O6uwNtZQUArSepUYSwumeSoJZRFTvo6E1Tla41efs46WtgAflmFVCJbyllRoSHJodFwN
         S9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759317874; x=1759922674;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=loyJAwQrLX68E+xJ/zLjfhEY3jyjUwwo2QQ6EsgIrWo=;
        b=WHD3dR4xCkeWwmV/yDVm4CU1ugSrSA8O/D9woN7jHqEm4ifgrFngJiKb/Qvb3t6zRx
         UY9ZtHeOUs/dUxkawsxgtDuZU+QVODcME4M7y9TAyhQxbHjsql8ZG6brEv0dmXIi2wVP
         8bEIWBG3j2ulypWL8T1qGrK2L+0eUlZytN2RrRLxAnGV3Y8m2Ak2I4L3xl/VipPS6tFG
         J+y+1tfxlYMD9mcXuToQeWy6qbAA3GFjHt+5RVDgN5OlBwnQ2CVYiA+sNhWfHsG4Z2KW
         xLbfttfDYCpmd1M/Lrh0YOhzIlXyCXRq9+OfSvM3HvRupDGwDLiASosllZzvtVJDZctY
         R/8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXS+0zVRUK+rvMwhhrIQ7BOzgawJL02+ptqDUVJd9Sj4+PCUIosSMgl8F2yj3l0K8sVALXCyLG+F9RAVV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvt5rCABRnbJ130gqzjlxaKOtcZVaCnVQRj/Ukc2jCt8giYyTU
	IUCCl/WNbDxuI0HaXt8y5WPFToATSmmRfePhiN/l0GeMua2Y7QkoEVavlxwFvLbn/4s=
X-Gm-Gg: ASbGnctIqUUvz7S1vdUxSEQNAbPBXvkGhERg4YBwd1tPJcUsz09Ps1Cc6r70idgj4Gd
	SYpwx3Ub+4BXhG3sws3g9wqktxzCeveZZf2QXcvkNR6tik84NZ7A10w89ttZ0Nf1U0+Eex7U/IH
	IE4BZ6z174seS/D596pkzpZCGPfzMcwsNISyJGGqRuDP3tOzuVnswKknK13TbF1dj8TyuJdRJhn
	oMdBEp1qTuMpsIvDQJcBWJsaGLroBbxUaJ5w7SxLOh/YFi8gUS/C2worcaBZQtyPGD7p7flX8iP
	6nRqaH6E4pK8t/gvmrBjBFy01PvYiXxYJQmXOTp36o8v24urTOhRXl/x1y9wyLIRUHmnJLFy0og
	h/6V5RswEQQ3UtgM/pNH3O0NGJfQrMmrM00RhW+pyamQnQ1XXKEhNaPPb1bwF2zW1kqa4BWBqpA
	==
X-Google-Smtp-Source: AGHT+IFtAgywWrsfSYERzPm6WM2utiuL00aNpUAhUx1d7BqDM282ZQ7LYiOHorp1TnI/lQjZh6x/0w==
X-Received: by 2002:a05:600c:8b65:b0:46e:42fa:ffce with SMTP id 5b1f17b1804b1-46e6125d025mr23588735e9.2.1759317873648;
        Wed, 01 Oct 2025 04:24:33 -0700 (PDT)
Received: from localhost ([2a00:2381:fd67:101:6c39:59e6:b76d:825])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5b577c87sm35652375e9.0.2025.10.01.04.24.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 04:24:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Oct 2025 12:24:32 +0100
Message-Id: <DD6Y4WZD1ZMK.3E0AUSVO0W79P@linaro.org>
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "TangBin" <tangbin@cmss.chinamobile.com>
Cc: <srini@kernel.org>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
 <perex@perex.cz>, <tiwai@suse.com>, <linux-sound@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: codecs: Fix the error of excessive semicolons
X-Mailer: aerc 0.20.1
References: <20250930094103.2038-1-tangbin@cmss.chinamobile.com>
In-Reply-To: <20250930094103.2038-1-tangbin@cmss.chinamobile.com>

On Tue Sep 30, 2025 at 10:41 AM BST, TangBin wrote:
> From: Tang Bin <tangbin@cmss.chinamobile.com>
>
> Remove unnecessary semicolons in the function
> pm4125_codec_enable_adc and pm4125_micbias_control.
>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>

Please use better email/commit subject or title.
I'd say that something like "ASoC: codecs: pm4125: ... " would be better
to reflect which codec this change relates to.


> ---
>  sound/soc/codecs/pm4125.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/codecs/pm4125.c b/sound/soc/codecs/pm4125.c
> index 706fc668f..aa8319c4a 100644
> --- a/sound/soc/codecs/pm4125.c
> +++ b/sound/soc/codecs/pm4125.c
> @@ -691,7 +691,7 @@ static int pm4125_codec_enable_adc(struct snd_soc_dap=
m_widget *w,
>  						      0x00);
>  		pm4125_global_mbias_disable(component);
>  		break;
> -	};
> +	}
> =20
>  	return 0;
>  }
> @@ -756,7 +756,7 @@ static int pm4125_micbias_control(struct snd_soc_comp=
onent *component, int micb_
>  		dev_err(component->dev, "%s: Invalid micbias number: %d\n",
>  			__func__, micb_num);
>  		return -EINVAL;
> -	};
> +	}
> =20
>  	switch (req) {
>  	case MICB_PULLUP_ENABLE:
> @@ -799,7 +799,7 @@ static int pm4125_micbias_control(struct snd_soc_comp=
onent *component, int micb_
>  			pm4125_global_mbias_disable(component);
>  		}
>  		break;
> -	};
> +	}

Thanks for noticing this.

Looks like checkpatch.pl --strict generates a bit of more warnings for this=
 file.

Best regards,
Alexey


