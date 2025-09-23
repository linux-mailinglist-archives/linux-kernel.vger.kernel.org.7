Return-Path: <linux-kernel+bounces-829653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B29E5B978BC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 23:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71EAE4A7FE0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7E230BF4E;
	Tue, 23 Sep 2025 21:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5B5ElUv"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CB919F464
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 21:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758661321; cv=none; b=nRrwodVZXcMxE5Lj6fFoc4Kka277YFy+qFpRmeqK7GZSoQUHerRqCAWd4qSGGZqUkbhXrLyyDmekGyA/AQmq4/XemXdprqTekktOSVeDV/q5vBCY6PEdc2tTMg05y8bos1QaP6ZSg+id68jIp56HwX6VWrSUSVA+iDh3xIJG8jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758661321; c=relaxed/simple;
	bh=GdeoEqhOUMKbsmamyUPZCj/3GBbdVWDAf/WbuzYo1JM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X1E2i4asakbPJl6RiIXSbnnB3fCp95jYKafyprcW4pn/2sdlv8j4Na+EuJxNQ9JyCgv0LXyWHn5fxc8QVXBqAkX7GsKk3kfphgsSii78o2RhZUvWy0UxpRjs2zDn3FZPcWx0Zsc3ykgE783/ZxNcCh51/A6ROFwagFpdV8A7ono=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5B5ElUv; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2698d47e6e7so12970555ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758661319; x=1759266119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IiShayob+wMbBulEHfowX58N88DexQXEmp0Our0Q2Vg=;
        b=T5B5ElUvnndRCvC+ihFX494sllLeusHobtd1Sdrxhlrfm5QpNm/+ZDJ0ZZA2aalnkb
         Q199dQfajLQLRFj73Dtm8KoZTatjEUsUfEViD+9Zk3dSn3/SsppqQhszjaKfdn1aL5Sb
         oYszoZWh+k8//hDL8noRPnyF+/Sk21imC5LvExcBtBuH25DkK3eU9JoIaf2t9SiLctZf
         MrvuL80HQM83N/YCA4cFHc/kLLJD8YI4C6EmZ4PR0jn6Qy3bnELYWQrLqoP1mKG/EDfm
         DeYQl8hz7lWoXaFg48IFIcifoXzvLZcQARmVaLmRziInmqSkXEIOkdt2luedfMXl4a8I
         S90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758661319; x=1759266119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IiShayob+wMbBulEHfowX58N88DexQXEmp0Our0Q2Vg=;
        b=W3JYluwViPWAnZlvOywMrs+qvNTZRaEdG2Ld3GFCecXQg345aLX58yYnMm+IzJGy3f
         swK4PUhWFbJ4Zp6JlTuXzfa+raPRkI2fQ9bt9HLq7gT7GsuvmTnGjZOx8wm3jM9YOfVp
         JgGZAj3XE1ehHzddSgjQMSOQBGk1cXSCcQza3naU+qzAeF3LYFfLTxS9AZPTWX7fjr9v
         YsVidr8mN6w70tl96ZNbce0MOpfv/FhLFUbDzTcIomvvZFOVEpbP5A0QIuZ7IQeTEZ4V
         vf06A5O8tY5qhpfLJxxXOLvQIxK3qTnawpk/tK/6iNZMr5eeXfhlnu9hRY0CVBUGbJ2x
         HtuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXkT/Er/MKjSLnDG+AtC13Bp/Onviw6QwETdcfdYCHG9XBMYrmlL1h/UM7437bddz7PmKwFeGS6CmzUzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNmBYhWR8gslPAXQ05Bcubtcc0WLkWfFlBm1oyG7ehgPpnxWdD
	8ujx/xGumJmOAX5gcj7httC9g5ImltcA44P4dtM3z8pxWPHoA3wVW3b5USNnNr1PKBYUwYDiYm0
	75gvwarOB7yo7Xe0wPXxf6LDPTBHbeWE=
X-Gm-Gg: ASbGncuwJiMGwEo+J9mttof5/9iRT8PGDUbFUrqE+lMX60+uxO9Y+EtI0enHJZLKLS5
	1h8LzxYZze/oasZVCb2tIaLxCyJYZT3zBxZCxR96uN2hYYyw0UuRBxvQyWplATmtBlvgmfxs1+A
	7UfONJx99P77elF89u3U1HxkbW4HHKFMlE28h8keDtvEU9OeQYcfzzhm1c3uJrBtkZhBXLiqas/
	gLucodFcYMj12iSrQ==
X-Google-Smtp-Source: AGHT+IGBIpx9mrFyDSaaGSwsEdyPQMz8HXLpGnW+28xc1uhmMzsInV1+Wy3g/FV+hkJat3S8a2AqMq6CslP7cPKpxFE=
X-Received: by 2002:a17:902:ec8d:b0:269:67e9:4c20 with SMTP id
 d9443c01a7336-27cc41d582fmr27553505ad.5.1758661319381; Tue, 23 Sep 2025
 14:01:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923171409.25927-1-hsukrut3@gmail.com>
In-Reply-To: <20250923171409.25927-1-hsukrut3@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 23 Sep 2025 17:01:48 -0400
X-Gm-Features: AS18NWAaDRkmma0nmJvOC0wFTTFBrD_CmBl8W6TTz0Z5Vyhfubp9ivnudhX4kc0
Message-ID: <CADnq5_P-UsY-uCYaTU5nA9jioCaL5jNPQHFn9YdtsBEVC_4aVw@mail.gmail.com>
Subject: Re: [PATCH v2] fbdev/radeon: Remove stale product link in Kconfig/FB_RADEON
To: Sukrut Heroorkar <hsukrut3@gmail.com>
Cc: Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>, Arnd Bergmann <arnd@arndb.de>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Gonzalo Silvalde Blanco <gonzalo.silvalde@gmail.com>, 
	"open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, 
	"open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 4:19=E2=80=AFPM Sukrut Heroorkar <hsukrut3@gmail.co=
m> wrote:
>
> The product page referenced in the FB_RADEON is no longer valid.
> Remove it to avoid pointing to an invalid link.
>
> Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> Changes since v1:
> - Dropped the link entirely as suggested
> (See: https://lore.kernel.org/all/CADnq5_NHu5=3DesJZrgy_S80jF68ZapRRYX4_L=
70DwDDSN3VXitQ@mail.gmail.com/)
>
>  drivers/video/fbdev/Kconfig | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index c21484d15f0c..27639b2590d8 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -948,9 +948,6 @@ config FB_RADEON
>           a framebuffer device.  There are both PCI and AGP versions.  Yo=
u
>           don't need to choose this to run the Radeon in plain VGA mode.
>
> -         There is a product page at
> -         https://products.amd.com/en-us/GraphicCardResult.aspx
> -
>  config FB_RADEON_I2C
>         bool "DDC/I2C for ATI Radeon support"
>         depends on FB_RADEON
> --
> 2.43.0
>

