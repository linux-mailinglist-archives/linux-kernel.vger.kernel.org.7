Return-Path: <linux-kernel+bounces-839017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFE3BB0A5D
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DB081892675
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D92D303CBE;
	Wed,  1 Oct 2025 14:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WVVmrjIL"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B7B302163
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759327576; cv=none; b=oG7aGhqba60rNha08kz+rj4Xdsj9k5/HUJ9elwBbhoeArAokev6E0S06WM9Wo0k7Xd/1R7R9vzSsM5QrzB0/RcExThU0YQloF23BOtzFfLiWFVM8yUE43UBXpf+2VLmnCQFYq9fnoS+imhGZIvHb+fdgjbYQMltk5kkdo+S7Vzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759327576; c=relaxed/simple;
	bh=l76gsiwqYQty5zu0MKOtOEBLRN1gepgBIGBpL6+Rlp0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DAi+TuENujCI+CvD3t9HRcYPfP1ky0NY9VbOMYwTr3nqmQAglyHvaavuPd4avmxkz1PWs1ZsxqUgkDVHOiC+nThqfpzYGGwKD4xkSR9tRhVqCBvsjDQUey9NkZFhAn0aSPkyMcxSKn+610LW5rA3gerf/nG7fLbWQ0dx7vAFEDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WVVmrjIL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e2e6a708fso47994325e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 07:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759327573; x=1759932373; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3g3uJS7sb6Tpx0wxhY8DWuhaiEuwHEia1cLZgWlxNtQ=;
        b=WVVmrjILX9W4wOBDGVZv0jugOym0zbqc9znMfgoDkk7CGwOGazdS3sPV2+kSdqNc7s
         YS45yD7NAVBccgdRpoqSjuahyfPPmhBzs1qXAG6meSxxx90lcAZDAJyTcCOAU+M2AzKd
         jQJUjBOWBPPmmjxmK0HKxtMwhmKXdYbHL97ZQV+VRxoiX3DdoZlMSUsBXMaSytoTTWzP
         5QcvYokq+ZIzw5Fze5vVsIHWt/yAyAQNTXd3rpzSV+dmo3Z2I+kwiXJM1+vlncGlE6Cb
         rn0w3tyWrjujrziZ4D1ryW3UJEtPX88vqSsURV5rJ+a9iC/ZZ53o0HuW6RyUBCDEjJ1o
         ihkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759327573; x=1759932373;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3g3uJS7sb6Tpx0wxhY8DWuhaiEuwHEia1cLZgWlxNtQ=;
        b=S0fYCOyEhjf4c9jshNNCXwClmBzCuD8y/A3MuiLjqpcAW5VxL5axskGXz7EQJF/4yK
         crXoIYwF7+aQixQKrBu6m22My0ikkPHiFbnIG6Fx5MOPvB+8Br6hEQpAYqKruCUeL6st
         lofTSUXcDduHwV2atpWOhTDypCvHqNHibvq54N/7ID7UPl6lroRUiVKijedyP4tZgNM5
         zXuFJ5qPHBl66mRDXkEQuiS6Cc/zMoSGlgI6AjrTMtK/vPV7lqZ+zYigQdNaiEsnLnCo
         mVYCALNkI5jKAkuL1YSd4N2ZrYPexcI7gz3TSoyVh0x+HkcfAXgX+BI9S+BljaK4k8Gh
         vjAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpqKWeiFT5CYB7MshF8Cx3sZpDyXtR7OUxd2VDgrSZHl2VWJNyUX+U/9Mb0wN4VmgCDdTzVT+byvcntqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc/M11RehQMBTcqMATXKLpigj/IC69WFp0iMeqQBAcqb4uE8RU
	VqxzoiXzLXvTYMyxwupmSoP00VPQJA/iHD/kZJ6L5Eh07npx950dNDmoDHPPTNjA8dk=
X-Gm-Gg: ASbGncvoBmsQVSiBy/dmhwTYE8e25B4PXsIvq+J5q+l5lY0vPDmUA4JzCptANB1YWRl
	AVzOu4bWOS0bFtiGOk1LvyJJ7Ai4f8yd4eR+9kx00fvHwFspsFHLrNNOZEIb1y0DvFruw2JTqCv
	8Uhnt4nOe/ImUqykHplA/xIf4f3wtSTqi77GyP0C6iZULtgGueS3q1scs3RUH9vno6zdl2JOx9q
	XX1gOXzzB4NXyHy3PvTMIbc3rZtOTT2/jKUIVc3vOm3jrU/2mDLC1H46p/njHaAIK3vfmVnej0r
	Iwxfq4na4z5bZqp2rD7gsjYysZUDzFo1r++eA8LIIuIk/C0+qfZ/uVW4bZZNUYg19S2bupBhfiA
	uqDz4xsnFscAFGNXLoDGULiK9iTQLhRgzBk3Icp8aJ5KsU4SUmiGKzfkwTYHPUSg=
X-Google-Smtp-Source: AGHT+IErI2QyAnk7Cp71eAtjo9ofA6etzV1HBl9ELWiOQ9Yjvkh/gQqn9A3Z5ffEhjbWPyqfMujlgA==
X-Received: by 2002:a05:600c:8b06:b0:46e:37fc:def0 with SMTP id 5b1f17b1804b1-46e61218f7bmr32902925e9.9.1759327572725;
        Wed, 01 Oct 2025 07:06:12 -0700 (PDT)
Received: from localhost ([2a00:2381:fd67:101:6c39:59e6:b76d:825])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a020a3sm41377545e9.10.2025.10.01.07.06.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 07:06:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Oct 2025 15:06:11 +0100
Message-Id: <DD71KONODHKJ.15RI1DXF5T6PJ@linaro.org>
Cc: "Srinivas Kandagatla" <srini@kernel.org>, "Liam Girdwood"
 <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>, "Jaroslav Kysela"
 <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>,
 <linux-sound@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kernel@oss.qualcomm.com>,
 <prasad.kumpatla@oss.qualcomm.com>
Subject: Re: [PATCH v2] ASoC: codecs: lpass-macro: Add support for channel
 map mixer control
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Mohammad Rafi Shaik" <mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: aerc 0.20.1
References: <20250902062300.212021-1-mohammad.rafi.shaik@oss.qualcomm.com>
In-Reply-To: <20250902062300.212021-1-mohammad.rafi.shaik@oss.qualcomm.com>

On Tue Sep 2, 2025 at 7:23 AM BST, Mohammad Rafi Shaik wrote:
> Introduce the channel map mixer control support for LPASS macro
> codec Digital Audio Interfaces (DAIs). The channel map mixer controls
> are required by APPS to configure usecase-specific audio routing and

What is APPS here? Will be good to have this abbreviation or acronym explai=
ned.

> channel mapping.
>
> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
> ---
> Changes in v2:
> - Updated patch with improved commit description..
> - Link to v1: https://lore.kernel.org/linux-sound/20240930053111.3986838-=
1-quic_mohs@quicinc.com/
> ---
>  sound/soc/codecs/lpass-macro-common.c | 55 +++++++++++++++++++++++++++
>  sound/soc/codecs/lpass-macro-common.h |  2 +
>  sound/soc/codecs/lpass-rx-macro.c     | 12 ++++++
>  sound/soc/codecs/lpass-tx-macro.c     |  9 +++++
>  sound/soc/codecs/lpass-va-macro.c     |  9 +++++
>  sound/soc/codecs/lpass-wsa-macro.c    | 12 ++++++
>  6 files changed, 99 insertions(+)
>
> diff --git a/sound/soc/codecs/lpass-macro-common.c b/sound/soc/codecs/lpa=
ss-macro-common.c
> index 6e3b8d0897dd..777af4885245 100644
> --- a/sound/soc/codecs/lpass-macro-common.c
> +++ b/sound/soc/codecs/lpass-macro-common.c
> @@ -8,12 +8,67 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> +#include <sound/control.h>
> +#include <sound/pcm.h>
> +#include <sound/soc.h>
> =20
>  #include "lpass-macro-common.h"
> =20
>  static DEFINE_MUTEX(lpass_codec_mutex);
>  static enum lpass_codec_version lpass_codec_version;
> =20
> +static int lpass_macro_chmap_ctl_get(struct snd_kcontrol *kcontrol,
> +				     struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_pcm_chmap *info =3D snd_kcontrol_chip(kcontrol);
> +	struct snd_soc_dai *dai =3D info->private_data;
> +	u32 *chmap_data =3D NULL;

You probably don't need to set it to NULL here, if it will be overwritten
by kzalloc() call few lines below

> +	u32 rx_ch_cnt =3D 0;
> +	u32 tx_ch_cnt =3D 0;
> +	u32 rx_ch, tx_ch;
> +
> +	chmap_data =3D kzalloc(sizeof(u32) * 2, GFP_KERNEL);

here.

[..]

Thanks,
Alexey



