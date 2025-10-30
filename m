Return-Path: <linux-kernel+bounces-878527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E3EC20E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 450B04E3FD5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A318B363364;
	Thu, 30 Oct 2025 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WaXCZTz7"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAC52F3636
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837748; cv=none; b=TrG87B3NOC6FOH36KBGHZrWVbu3iEaORZj5T6bk2zde5z0HyofHv6EzPBSSfWpsOnnrBE2cI/dNCJvqvI0cGk1MH4kHyEjHPuL3Z5VA+vYZ6EeMbfOmt4dSZ4/6AxuNd/YLf55L6Zk1Qt6h4lBalOyzVSlw5maLwskpGcB4VKt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837748; c=relaxed/simple;
	bh=6d/OVmKJJb7OlddG1Bh9+D9lD7AVNsH/e/F/SKjKcKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h6bDP7Tb+jtm8B2NqQqQoV5d86SSCqhJtST/PkHGftWh5s1Lw6WVsJPrFkpJDow2mzRjvgrIA58Shd4rtDPlo19cowwSA8sXsJbe8GdgQPeDgNh9qsEFmmOwnPBcUxVaTEnWFHjq+kqTuCNikNyYAygpJIkWiMkXeC0WxUF1txc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WaXCZTz7; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3b27b50090so199982266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761837743; x=1762442543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6d/OVmKJJb7OlddG1Bh9+D9lD7AVNsH/e/F/SKjKcKo=;
        b=WaXCZTz7tePSRgNv7Pkvrf/u4Vg91E0+C2q5cVsPZ5NtpUYyLca24nqxplAXYClEm3
         abJV2YrT2cVObZw55Wfao8eAV5KCvJeTwzgfP7HIFAnzbgkcbDSjt62ZR7Tc8X8ZO69U
         tPGfZepsczbGnO1oPomGObBguiGWG4KozFDzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761837743; x=1762442543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6d/OVmKJJb7OlddG1Bh9+D9lD7AVNsH/e/F/SKjKcKo=;
        b=fcWKUeTKD9j5YK2JEBM0FAdhKTCAOyW4ZzgAFJa8vGzbd7zILyjzHfWDSZC2UJrnY6
         6o2DjprWjo16U3SkXRT4/+CKxRj+W+siWZMaCOBorKinfjPKV9nmyvecIgMdWl0U2/zf
         NPyN9S+FwtgxZZv3HDf6ANf36UHdAEBOlVSYt89m2sK+TLEW2WmqYV3ud0X9IYisWiLN
         bsAdzhumXoyKnAyiHHOCSekVWIJvGtF+38mUMyqXOJ/xD8Y5kLZy2lQ49E41leo5pL69
         rceplrZSPBs4azgkHDZlQJWNEpWNwBzWMovT3uNhY1mtmhb6S097FgHtBELd8zN+wC97
         +QuA==
X-Gm-Message-State: AOJu0Yw1p8QO6WqPnmW0HwIDBpyqLlNsQGgjgwpWZr7AXVJyPBcmDTnJ
	gTVRhKGTVidNfvgG2eao0Vt0YFiA9LYZv1IhODrvOY4FIhmUdb5lNIbAg+4ECC12gBDK37l4IiQ
	FAxGjOO0a
X-Gm-Gg: ASbGncvj1C5Fre6xYcdaUWJm5MwlC+2rFM/nBFI8kEgQJW/T1X6E/DPkRlO3eW/6hHl
	dB7oYmX7nnC9t2Hp9nDMrHHy7NnsKHlIajR6RjrbXOHnMtNpK5XpC69kzvPw0Y3VZcdz1kt2Btl
	fg6go8MjBPN/6vQlYQuUt1BbRMFBUwKCpOePimjeZlC/iD1ZDLLOrgBMQjjrrVc6GrOs/2hIn2A
	r1S0SCK95ak46r554AVkVdnDkFw9Ro2IVZ7dsHTykcBYGYkj05JpQViToxrdZUHMaj6rTuG2ClP
	7na8zFugcshfQJvNHOqEb12WKUaJQ+QEpF+wScoYSt1BwwQeAYm2gbSQNBGJI3Oo2NYs2eMwz9k
	LsbP2yBYCIQ2KLrPXothaHpcTLHarlzS5NiymPUNg8Lozc7DfD0Zr66G/4Kb5glzTtxn+Y+lMXT
	XaPWh6hZM2h2u/Q9eMyey2uWNfAb2ZdLX2xomLHsY=
X-Google-Smtp-Source: AGHT+IG4PHSG5nJUS0ovVVsUE7XDsMJxAyteqbV0t5OT84EHLu9IeOTSUpEuvlu0ETjxAV2SlHbsOQ==
X-Received: by 2002:a17:907:970e:b0:b5d:7a22:ae41 with SMTP id a640c23a62f3a-b7053c1571dmr367230766b.24.1761837743358;
        Thu, 30 Oct 2025 08:22:23 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7044d00de6sm495632766b.74.2025.10.30.08.22.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 08:22:22 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4710022571cso13972705e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:22:22 -0700 (PDT)
X-Received: by 2002:a05:600c:190e:b0:46e:42aa:75b5 with SMTP id
 5b1f17b1804b1-47730793c04mr1042045e9.4.1761837741749; Thu, 30 Oct 2025
 08:22:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029081048.162374-1-ajye_huang@compal.corp-partner.google.com>
 <20251029081048.162374-3-ajye_huang@compal.corp-partner.google.com>
 <CAD=FV=WbR0u_a7S1pcL-6C+sj9Kt=GOLUwJmwt8ANJbyV4JYFQ@mail.gmail.com> <CALprXBb=_HuwskwFP0nRKH=3zwoGbig4fWY+Q4g53Jhn985TsA@mail.gmail.com>
In-Reply-To: <CALprXBb=_HuwskwFP0nRKH=3zwoGbig4fWY+Q4g53Jhn985TsA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 30 Oct 2025 08:22:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UXRpk=O7zC4B9hRE4oTNHJLosm_bhhNUgVur0csChMhQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnhb78qdonzJKwyTXBrXsT_c1_8-ezmVyvceIjunYMg8V3tseIDtx918nA
Message-ID: <CAD=FV=UXRpk=O7zC4B9hRE4oTNHJLosm_bhhNUgVur0csChMhQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drm/panel-edp: Modify LQ116M1JW10 panel's bpc to 6
To: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Cc: linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <jesszhan0024@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, jazhan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 30, 2025 at 2:58=E2=80=AFAM Ajye Huang
<ajye_huang@compal.corp-partner.google.com> wrote:
>
> Hi Doug,
>
> On Thu, Oct 30, 2025 at 7:25=E2=80=AFAM Doug Anderson <dianders@chromium.=
org> wrote:
>
> >
> > Unless folks end up preferring EDID_QUIRK_FORCE_6BPC:
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> After following your suggestion with the following, the issue goes
> away during YouTube playback.
> I will send a new patch for drm_edid.c, thank you so much

FWIW, it is a bit baffling to me that you report link training seems
to be failing yet then talk about the symptom of noise during youtube
playback. If link training is failing I'd expect nothing to ever show
up on the screen...

-Doug

