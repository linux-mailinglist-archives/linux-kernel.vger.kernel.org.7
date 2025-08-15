Return-Path: <linux-kernel+bounces-769784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7255B273A8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E93D1892E9F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 00:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37502629C;
	Fri, 15 Aug 2025 00:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M6ajbUKD"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696DC224F3
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 00:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755217168; cv=none; b=jjaNZuJ9v7kDHp+2Y09LEKiq5hk/Hdqxti5Q4AEuYeFtg3FS2fsGZlY7ywB8cttKZDaIk7HK9PYqgG6rZQbgedMeQoOGzYxguxNncs+RxgfCH15PCjOjs6fc3sXR3bb2c95kdirqc8LJqc07jMMbK3dUQf/JwddZEJUFuBotKVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755217168; c=relaxed/simple;
	bh=2mZs6T5Rqv9g1ujstn9eEbs1bLEe/SO5e+VWz8PZJcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SuJeDIrCLK1UuQjf6SlyNsFCoRzuOtjFlFzDN7RaUxRwS+RLccbv0n2FiEjZkFDrpX3PnVAeSO2lhMMLDYG106uAiPzGs0PNfbEj+1fJHS7cbc6DQ/0CSNdWrpVOOTjm1IYnDOM/vbU7PJb7gE60Sw7CvnXKr8D93fUoD4s80Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M6ajbUKD; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24457fe9704so11963465ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755217167; x=1755821967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEZvwZ6yQfWgMEqsVmo462XXGUa5NScj6l2mlIQyQ0c=;
        b=M6ajbUKDJ0ZHqniltzdDSFshlEP5rQ4q6ig5FFJKlKtZt7jSjshvti29rKSeOr7pzJ
         x/d9rHxhiOLY3KK0ARa/pyfS3y9RDBCHv0iBuaqSJ3zHsOPK6YMgSHv1QcoRkJHWNQRx
         nvqIdBhdm5LotaOPh6bnzwoL2KNoxS6zbXOKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755217167; x=1755821967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CEZvwZ6yQfWgMEqsVmo462XXGUa5NScj6l2mlIQyQ0c=;
        b=VIaMGGfmp3PLrKUh+/kEdzjqvqqEJ5e9n9mqZyNScQH7GTVDzbGlZ5l0TzHg8ofn2P
         Fu+th8qGfKU2S4Spb9cOKRHot6PH6U3SGpVU0FrE8SJwqp1bozxZxR5YChXYu2yiittQ
         ZPMgddh4ika9Hez9/dBRVnXxwie8Ff9ZIDIPn+mkoiUjaP3hk7HK99Yyn4tRQOLFob62
         aRL+VmXBGBwaj4sfbADFKdcwvFI4V5WXM1TYjS9bfZ/C1wFrUiCjs0L7PjDPyIK8bt/5
         b2br6ohAhRGzMPdQYH5AxVi9cJZS24Yo5Ww4ApAtXZUpUI8Y2N1tqXLMxpUkuyL1cJGs
         imQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy7ziv1aIkg6yZO+LMDSs8o5Ot0T5TVd7lhYr1HtvbCCQg1cmSTcj7/79/PBsoQDfQTMqfPzTr8pC8ct8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiGsifg6tdTWYYmMWYbB7/24p+n+5zgEjvu6lsKMl3SgD6IkHU
	mHcCEx7iFyNkZCbXUCsMaYGSDBllNOl/uWnjCzi5VAsEex1r22bIwbNUmNZoYsCuMEkIpNnib/a
	u+X8=
X-Gm-Gg: ASbGncuE+zgyuLSMh5rhoSimtnb/5HMhKFy4tLjlqdsRhlUtHHAR1u771m7G9KGeDL2
	03Rf5pS0vNrXbHnno2kqwBkTiOmFHm2bwLrjftDgZBzLbFzhY8nsQioiqAI4ET/tyldVcUG6EuZ
	dhe+CMcyB+uL5UVP1HkO5iNtnMICKE4MPlfPvr0PG+IeljzWxbw27JEC+N51u9yfbZrqKRmhkxb
	yB9kBqakbAlXou2B/0+tA8vHMBk1YlfybwX4CPCGaeazIUKKOHTDK2C5Smj4a6LWMeFK3pmXeTV
	v2kLxysMMGwwmsWJT8eFjd48EBFG0Y6jYx4hQy64iQ/iQ6ld4bAQrnyBbfAQ/+3KldU7sO2NZN1
	dgsN3apAtPi6QTywuSp5lRicKQ1M4RcUwL0GJF4wkYhh7n62uFeaABXxRKdz/jsxuZg==
X-Google-Smtp-Source: AGHT+IGPxa9g/4FnxtHoomFCUenLz7NpyIh+1t5CBrI+6qCrLpFWSDqE1Sg3ZqL0OXe85a25RMpcRw==
X-Received: by 2002:a17:902:e80a:b0:240:3f0d:f470 with SMTP id d9443c01a7336-2446d7087d7mr1662265ad.20.1755217166712;
        Thu, 14 Aug 2025 17:19:26 -0700 (PDT)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com. [209.85.214.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3232ae14f6dsm1289987a91.6.2025.08.14.17.19.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 17:19:26 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24457fe9704so11963365ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:19:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUOfs3kbccw2OZ5O1EAE6GrPcWzzZ1Qp13YSS/TYKLC4thiv8+UcTOF7ypt3xwKO65g8OzPps9h2EOqlOQ=@vger.kernel.org
X-Received: by 2002:a17:902:e947:b0:242:a3fc:5900 with SMTP id
 d9443c01a7336-2446d5af310mr1936465ad.8.1755217165481; Thu, 14 Aug 2025
 17:19:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813125132.1319482-1-treapking@chromium.org>
In-Reply-To: <20250813125132.1319482-1-treapking@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 14 Aug 2025 17:19:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VAMT4xNoFKan7UpCS8RRXvOPWqRXJGsMudvJ+eWOOuDw@mail.gmail.com>
X-Gm-Features: Ac12FXz-ckb7A9RPiPMgTBiKCqz6twUCK_GsqpTzShr-jwEY5OOiNXBDYC75hpM
Message-ID: <CAD=FV=VAMT4xNoFKan7UpCS8RRXvOPWqRXJGsMudvJ+eWOOuDw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/panel: Allow powering on panel follower after
 panel is enabled
To: Pin-yen Lin <treapking@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	Chen-Yu Tsai <wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 13, 2025 at 5:51=E2=80=AFAM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> @@ -230,6 +239,18 @@ void drm_panel_enable(struct drm_panel *panel)
>         if (ret < 0)
>                 DRM_DEV_INFO(panel->dev, "failed to enable backlight: %d\=
n",
>                              ret);
> +
> +       list_for_each_entry(follower, &panel->followers, list) {
> +               if (!follower->funcs->panel_enabled)
> +                       continue;
> +
> +               ret =3D follower->funcs->panel_enabled(follower);
> +               if (ret < 0)
> +                       dev_info(panel->dev, "%ps failed: %d\n",
> +                                follower->funcs->panel_enabled, ret);
> +       }
> +exit:
> +       mutex_unlock(&panel->follower_lock);

Extremely nitty nit: all of the other functions have a blank line
before the "exit" label. :-P Could you match?


> @@ -598,12 +641,18 @@ void drm_panel_remove_follower(struct drm_panel_fol=
lower *follower)
>
>         mutex_lock(&panel->follower_lock);
>
> -       if (panel->prepared) {
> +       if (panel->prepared && follower->funcs->panel_unpreparing) {
>                 ret =3D follower->funcs->panel_unpreparing(follower);
>                 if (ret < 0)
>                         dev_info(panel->dev, "%ps failed: %d\n",
>                                  follower->funcs->panel_unpreparing, ret)=
;
>         }
> +       if (panel->enabled && follower->funcs->panel_disabling) {
> +               ret =3D follower->funcs->panel_disabling(follower);
> +               if (ret < 0)
> +                       dev_info(panel->dev, "%ps failed: %d\n",
> +                                follower->funcs->panel_disabling, ret);
> +       }

The above order is incorrect. You should call "panel_disabling" before
"panel_unpreparing" which will match the natural order things are
called in.

Also: please review kernel-docs for the following functions and update
them for your patch:
* drm_panel_add_follower()
* drm_panel_remove_follower()

-Doug

