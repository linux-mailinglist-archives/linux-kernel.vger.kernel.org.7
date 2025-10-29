Return-Path: <linux-kernel+bounces-877285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FFAC1DAE0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 00:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8861F4E1CD7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 23:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A823002BB;
	Wed, 29 Oct 2025 23:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WL5C5TJc"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D5D2F5478
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 23:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761780076; cv=none; b=Q4o3IEPBRbecXMGUSmZEBAVzPQ906c7Sy+Gn3VsGQDgfhX4AsuWTvrq+yci7Yb191lId40X3cBvMOADMn/E2xDdk12HPfW3yJKBYPUpmFpnIwVTo8xt06RziLRlCQx9MdCyT5clC5qMnlKMXuWwjk3mp/dq4t8Jj703FmUiwzq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761780076; c=relaxed/simple;
	bh=cDDkPJ7F9tdZVaQUuqF8+zownvCRgI5zNRVsWqM9mfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h74jYo2ZEEOvOczHDHgAQDK3+juCrwqBRqygQTqDvCQdzFg5R+CFtjmVD5B3iTQPvzyZ2JHfDypdSg4Qo/dHYq59DY0U3NUIqHL/GLd65yWZHI2wFFASeuzWzNE3TN+wiETO+yadU53UjOEkeazsX2l3t7P9VJwwohSnhUg1xQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WL5C5TJc; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b6d5c59f2b6so104364566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761780065; x=1762384865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKw67xewyEQ2RYEG8QR7XxorPa9DhZO3u8V3evRxitc=;
        b=WL5C5TJcgiiEz+Uh47dbIbBzVFU5PocBi48D8UItMqwO/ib+WEkX99TPwFqgfkNc5b
         CLyASbhwdcJNkC97w0GipHhui933Lyep5T1xxdYqtleYBGWvKcakQfLseEtM5hozD2H/
         AkMjDuOMjxmhSounNgbx0vJaPWhBzNj5tB5Zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761780065; x=1762384865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKw67xewyEQ2RYEG8QR7XxorPa9DhZO3u8V3evRxitc=;
        b=rZ+v7fXfql83VkrIBCPkt5xBgQo998cjtD2e+rIlqkpFzWetv7JJPZ/C/fbC8JACul
         If7YC+2RkOAE8KCIn90CyLlKFH5k9p7sAbfici/G5jYFMl4xj+ahyTOqWX4TwegkwnWe
         IjceWjg/YPUgir/4OZsx8GS0tqGgG22+cqT1A0ccxaztkAkKOqP4U+sMLeFo4k00/uu3
         /C4Cirgr3x9E57JW/dM9stMaXApFvOWkfJqE2WE+JJ7wDZceCNo9Wepzuwak2WT1M2b0
         Q2Srt2qQbHJ0KWd/SyowvlibooTDClolGzsPUuBep6v4dgTURf+XfXxiuhOfbXwEm1Vs
         hgyA==
X-Gm-Message-State: AOJu0YyMGmPyt1Ko0744Jvd1JDgRVLF4Em24IDmYVt4v6k9drRabVRah
	97CVnhCvP7e2PVkmqwXn/UreepRaX2362teP3zCGhJPqwISm2vdnqA7gU4W010qODakHYiagGJ+
	TgkZnEw==
X-Gm-Gg: ASbGncts8jrMJ7TKWKI6DMLExwOIuAiDodXQQjqLjlu8dNhh/DuSwCksYRa5AcAaMuh
	Tq6bUHIRlIwcS6s+BDa91+Vqss97dDktnnwVsKrmoZRNN/01DKUqXG4k3Ahsgomrz3FUaUBrq8t
	5a07gt28TkFbI4TtvJrG4eULNV3C4VBOtW0PXrt4gEcBWiuyl4lIlFk3jSP2ov/UZjhY5+d/Hs0
	qBkwEDvQxocXWcsZupzXftFDr9QUMAOLRChi8/B0psuF7x7asZM6rA6cWJvBN+KsAnSPRGiucKj
	qiN09SaxFkqPeqv15d5eI9KtBuAr+KeI1eVbx1uBKtKZthWDqUTrhaHd23jazgIWyrOHxJiTqSr
	A2vuw1dz6rcM7fhbWg0JVAqklqOVjO2wS/mWrW8k2RLBhhMn29ZR7iDykN5bcUCwbk9XCvXZVCJ
	5S+wOHEuYukY/5gEav/Yx7taiFlofdrqlvhMRaSt0=
X-Google-Smtp-Source: AGHT+IFvBrfxwQu2p1JLj7wdP61sopBMHsjdNfE0Wk0p4TskiZiMKSqDVuOO+fcnSpMJjbHHaWZQAA==
X-Received: by 2002:a17:907:807:b0:b6d:3fc9:e60a with SMTP id a640c23a62f3a-b703d314ae9mr454383766b.19.1761780065387;
        Wed, 29 Oct 2025 16:21:05 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853f9a0fsm1553450966b.50.2025.10.29.16.21.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 16:21:03 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so96827566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:21:03 -0700 (PDT)
X-Received: by 2002:a17:906:f588:b0:b4a:d60d:fb68 with SMTP id
 a640c23a62f3a-b703d2dc0acmr408681866b.6.1761780062930; Wed, 29 Oct 2025
 16:21:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029081048.162374-1-ajye_huang@compal.corp-partner.google.com>
 <20251029081048.162374-2-ajye_huang@compal.corp-partner.google.com>
In-Reply-To: <20251029081048.162374-2-ajye_huang@compal.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 29 Oct 2025 16:20:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X9hUxsrJ6o5yP0-bprfKgyQzZJnQRwQVYRo6G0yKWhCg@mail.gmail.com>
X-Gm-Features: AWmQ_bnALe5cE6UL5BlZi69GWxwTwFqhUHYXfwWWJkf3C1AVS9gQ6kR_yZsS7Ms
Message-ID: <CAD=FV=X9hUxsrJ6o5yP0-bprfKgyQzZJnQRwQVYRo6G0yKWhCg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] drm/panel-edp: Add override bpc quirk for generic edp
To: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Cc: linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <jesszhan0024@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, jazhan@google.com, 
	Jani Nikula <jani.nikula@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 29, 2025 at 1:11=E2=80=AFAM Ajye Huang
<ajye_huang@compal.corp-partner.google.com> wrote:
>
> Adding override bpc to EDP_PANEL_ENTRY3 quirk.
>
> Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

This seems OK to me. I'd be OK with:

Reviewed-by: Douglas Anderson <dianders@chromium.org>


I think you could alternatively add a EDID_QUIRK_FORCE_6BPC quirk for
this panel in "drivers/gpu/drm/drm_edid.c", though I haven't tested
it. That _might_ be a better solution? Maybe Jani or someone else CCed
would have an opinion.

At first I was thinking that the quirks in "drm_edid.c" were probably
just for "DP" display, but then I just realized that they probably
also are for "eDP" panels. Specifically I think Intel hardware doesn't
use panel-edp.c so I think the only place quirks could get applied (if
an eDP panel was also used on Intel hardware) was from "drm_edid.c".

Any chance you could confirm if EDID_QUIRK_FORCE_6BPC works for you?

Does anyone else CCed have an opinion of which they like better?

-Doug

