Return-Path: <linux-kernel+bounces-742874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D4DB0F7BE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC45E1892C19
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291741F30BB;
	Wed, 23 Jul 2025 16:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ODWFizPf"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67141DDA0E
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753286634; cv=none; b=gFMhctGx8JipA19XO/UHox8lcoQ2NOs4vZnaZbRoR7F2PRU0p4dNfkggfOJOI3/kZzEuB1bMPsi1WuEziaL218lrDx97A71YwqUgmvK5X3ofSJyLiqzQNmjCiLlVnGyNiVBLl04L0AS11+v3GkG7yIA1ICQbOcDf8JjFWkM22zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753286634; c=relaxed/simple;
	bh=ncMtVWrRo0QdAxX96U2xskHzV+HnhsIWDnQl7RkoX20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WsmPKwFdPP3N9ohpzjQ8pVkZAzZNaWBgIFXSFHzBqWwe8PEVxazZ9HkFoC7+SDnj8ME7YFgdxnTsoodykUASxsKsgrQJKXSdHd8kc4Ivxw5qFdHI0Es+GHyYgNB+6eb791WtzP7GykT9mA+SwmSX5Uo3DzNlZw7nPvI0m9zhfu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ODWFizPf; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-af2a2a54a95so247000466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 09:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753286629; x=1753891429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Q7xv7dB05a0bq7wMlNS1QxIiv1Ilfjn0v+vSe8yJNg=;
        b=ODWFizPfcoj4eseKeE9cg5Ua1OSZj8Lot3fdQkXDEew/MV6+iy3R7LA2f8W1iRRxub
         E3j/q9TRkyX1We2/Jv4rDohlZzfIxAaRdxvKlOkZDgR+7p5i4skw/ttKrDOKY/QIk52V
         DQoKYqq8JxaXhshP6sZ2kbEKhstN5He6NhyUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753286629; x=1753891429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Q7xv7dB05a0bq7wMlNS1QxIiv1Ilfjn0v+vSe8yJNg=;
        b=YnJm73tPYu4ETzEnT+rr+xCu+yaLlb0qUHZLsLk4ZhE6ELHucLkwYQ2XlZ5dMVPafc
         BplL9LNE1ImSDwTE5pe28a/XHOl1yFdpabYhE90C+cSUgfPtgNlipTEeY0swJOEle6WJ
         S50xsmojBXruMJkavYFESNNOHzSTgQGP4pHmRE0gZjgrnQkhGoLJXuLl0iWZyPTwq5EQ
         uh6l2Vcm0eQWhHystwwdjByBCtdvIEZBhhjZttyC6C9wisO1xA3YgLbJ5EUPS9Qez/un
         kBoqfnwTCW/84BVcQXaiBbxnC7B84rM+CS536xQNtj8eeSxnyaT8FJ2CsAX/ghxygStS
         mN9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVsI+750EimptQWhr6KWu4aV7JEQj4Tobt8ddIv5ofr2zOrE4Jmdj4j3ATVh4G4zw+93yBrXbleJxJEMqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTlbJRFtpaSS6JUj6HtTMma1XLwi5lu9hcAK+ZOMwQj7MMvZMy
	clronYxkXHNy7jIDbFZaAv3WiZN9tvFQl5o24gnZbxeX3LHatnWy95hMOZBdTw198TTOipzNPsp
	2nBCbkQ==
X-Gm-Gg: ASbGnctsKuk6PCUWGcfYs3zAzqSkj7Y+Cd7HvrIUcc4Vyia+y7/vVD8ZGxNwEXuUX69
	7vcDbQ8vjJstK/naIyxIgcOOxbi8YjZK39WeHw4KlL6w5h3WThg+izy2sptLV2CX4PyIbuHO6l9
	fg40uOI2527cp0YpmVQGXNzaJ847WrHWK1zvEtEk6GqRDxHJZstATRNjjGFstVY0wNa1sj904m/
	Y3IScA8oEPAjpHMsEYqiruhr5XFl+pXWdAiOVem86GZZosqHfTcihCaW0qwB9SC1ZtWlj+VX/C5
	dEtQTlL0gRfj6+Z3CitkFK49GhO8uMyj5lCH7mbxE32m9xRDTHsBHIDc0CfWkSZm+WUgt92ae/y
	a7uDanewqhE+tC5PbWTbkLi+38Vf3bKfS2SKvcJy0Fmulp3snZlsEosYvS12/fQ==
X-Google-Smtp-Source: AGHT+IH3IKXxUDOTCJgqkopovXQFarvkdP8ei0LTMB9yYFtd2HCDudxkJDirbBPelr0HR3/c2VZPQQ==
X-Received: by 2002:a17:906:794a:b0:ae0:bbd2:68d1 with SMTP id a640c23a62f3a-af2f8858b6bmr299567066b.37.1753286628251;
        Wed, 23 Jul 2025 09:03:48 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca312d9sm1067929166b.94.2025.07.23.09.03.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 09:03:47 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae36dc91dc7so1107242966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 09:03:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGysEPQJW2GDM2trnMGDQ/HjlO3Dok+/xk6j+BDziXXc/Qjwgn+m0on/LWRCSaaIVWKYEyXWxNb7a1k5g=@vger.kernel.org
X-Received: by 2002:a17:907:94cc:b0:aec:4881:6e2b with SMTP id
 a640c23a62f3a-af2f8762776mr368390066b.28.1753286625900; Wed, 23 Jul 2025
 09:03:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723072513.2880369-1-yelangyan@huaqin.corp-partner.google.com>
In-Reply-To: <20250723072513.2880369-1-yelangyan@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 23 Jul 2025 09:03:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XB0s_-qxm0p+vV96iJUxAwhcsvzFkOh1nhso2WkDoC2g@mail.gmail.com>
X-Gm-Features: Ac12FXwPjOsbwvF6lFtTC0ghMcxi51ZA2W2nWz8FIaHzuI_Dwx1tzkAytibzqGA
Message-ID: <CAD=FV=XB0s_-qxm0p+vV96iJUxAwhcsvzFkOh1nhso2WkDoC2g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel-edp: Add 50ms disable delay for four panels
To: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, jessica.zhang@oss.qualcomm.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 23, 2025 at 12:25=E2=80=AFAM Langyan Ye
<yelangyan@huaqin.corp-partner.google.com> wrote:
>
> Add 50ms disable delay for NV116WHM-N49, NV122WUM-N41, and MNC207QS1-1
> to satisfy T9+T10 timing. Add 50ms disable delay for MNE007JA1-2
> as well, since MNE007JA1-2 copies the timing of MNC207QS1-1.
>
> Specifically, it should be noted that the MNE007JA1-2 panel was added
> by someone who did not have the panel documentation, so they simply
> copied the timing from the MNC207QS1-1 panel. Adding an extra 50 ms
> of delay should be safe.
>
> Fixes: 0547692ac146 ("drm/panel-edp: Add several generic edp panels")
> Fixes: 50625eab3972 ("drm/edp-panel: Add panel used by T14s Gen6 Snapdrag=
on")
> Signed-off-by: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
> ---
> v2:
>   - Deleted "delay_200_500_e50_d50_p2e200" structure and renamed/replaced=
 "delay_200_500_e50_p2e200"
>   - Link to v1: https://lore.kernel.org/all/20250722024512.983313-1-yelan=
gyan@huaqin.corp-partner.google.com/
> ---
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Thanks! This looks good to me now:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I looked at pushing this to drm-misc-fixes but it didn't apply cleanly
due to context. Given that the original patch is 1.5 years old and the
only reported problems are that timings were violated (probably tested
on a scope), I'm going to say it's not worth it to make someone deal
with a merge conflict so I'm just applying to drm-misc-next.

Pushed to drm-misc-next:

[1/1] drm/panel-edp: Add 50ms disable delay for four panels
      commit: 1511d3c4d2bb30f784924a877f3cef518bb73077

