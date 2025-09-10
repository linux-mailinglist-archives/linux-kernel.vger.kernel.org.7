Return-Path: <linux-kernel+bounces-810491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEF4B51B46
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE91D7A7D37
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059DB31A056;
	Wed, 10 Sep 2025 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VG2k820X"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA02A3164A5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 15:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757517454; cv=none; b=ijozufZCCAk+Ms9LSlbWrcuVcuU165ApPt50YobOpc/K0iwD39Q93P4vqUn3cR0FzfjHcq7NSfrFm3G+2uE7R5h2xyTTRODk6Cw6aGUPfStdJ30HZX6HplGC5be8OBZnh/MjI56RtvL3xECfBQn8c93oe0sWZNnVa/hIBO5zf2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757517454; c=relaxed/simple;
	bh=RlwBJKFczL391OBuoRLS65aYjJYRk8LexlJl9+TvLd0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=cuVLebxZqwGSKit1ldqY3csdcSlPr0FEe4TtuQcTlUxeUixVgztBKtjSirw9WkRp4RownOR2QRtMN5etHM03H81Bz59nhlvFW+uezm0PS6OOzfa6smJ8rhdMceHZolSKLZ6rvQfussSQu+IAD8LU/YKkWhH8QF73XorsiwqJ4Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VG2k820X; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b490287648so112161321cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757517452; x=1758122252; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C1mzq7QAamyCDgZjqIwsPENWf0k+ggNwYSd/FkLWnRs=;
        b=VG2k820XySOeymjBAER8qVyXedJN6R0p9ilLo03s5Z4chxOH0eHqAxmxvsicKuRqUs
         ID07AjTIck/EwAVi+O6c96sDLrm23k/Fjj3IIK/Zev+3y7YRjyDPU1zy51x1k97FNQjD
         7/lEPegGbmWUySguO/kdI2sfV+M5JSoVPzjt4OHugFU1mmcp0m1esXvTyQcuOdlOeK7X
         Tx8gQ29LUMP7T0jzr5QsfdvoF35v0AMc8X8XRdGepusGIBK59EHwzGUmereB3hn5vZXp
         NRXRacUqagkarlBysf5S++ibIXNfDxcQ7Hr14jBE38iqZUTKiTpaKlX37Md3aMjx2gUc
         favg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757517452; x=1758122252;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C1mzq7QAamyCDgZjqIwsPENWf0k+ggNwYSd/FkLWnRs=;
        b=SVWtcg//WiPNNT5OS/A1kSR5G22zPbP2wXO6Z4G4Lg8cztq9bDHnQ20QL4m/V2vrZe
         KbsEHhCjp3BV6zuewBsR9Zq/JQYFSVj2rc9bi7yiTMLj0uiM1Q5nDJe037JeOD6b065w
         z+/bjVF8+9t4L9xQgj979/bN7lnrmg1VEGwNOgO+NYqm8O+bRMKqP53khRU1rgjWdXoL
         CbHpgVPf3ZJNblPnyJT+iVQC1j5FLQTDTzcu4OAS5RL1yOW19PiELHvCmN2FE8GFHoYp
         Jp1bbcpNagSm4+8rQI143VMudpHt5rTtPAULay0cqntqlQ1TUPCqDnAw4z45YMc+E/C+
         ko0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV79FjIQynSmIW0qAncucAHXoQgVdkSFHMwpWXKGj8+esj0rMIlMZ77y0pF6U6dXIHQ8Df7AGFqkrOs9Rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdXpvdFXU3cXVugG0j5htADG5kT5zKkaUu6O37lhVDP3hrFYgy
	4kwZjj9F8tQ+awxKSJvxjGA0GJvlm4T+UiHkSnqcPXmAZM0CRmuxHpohJxO7r8i/P1ZOhQl+2ZD
	Ll2DBV6Pzn/+2vxZZ34kSseO/SaoftQw=
X-Gm-Gg: ASbGncu3laTB0dGKwMP+FtDH/gOUJ2ph6HTP46y2AGCy1muwhJglplvMYuM2rOLcJNS
	Jx4iqmxsvg+z3ZvuEcVSxPsf4Wce3sodKCAPUk7M3/Pxhd6k6ophi0CMbQWeAhhB6JrBL06AKpQ
	Pcs70TtYUIw6uuYAU97uff9i7VftZWQXVkLjghLgavw+hDtQChlLGXK4tgvkbD16PWxGYvdPHQ6
	14VfQEyPBvNLfpo
X-Google-Smtp-Source: AGHT+IEn8qLkTWj3W7cFUn0zV2zlgKzDIbStPJ8mNqM9yeK3nj1hkEfb6zWsFfNBsnId52FU4XUstuGirGgUZY2sHX0=
X-Received: by 2002:a05:622a:180a:b0:4b4:3788:baae with SMTP id
 d75a77b69052e-4b5f844743cmr179099701cf.43.1757517450398; Wed, 10 Sep 2025
 08:17:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vicente Bergas <vicencb@gmail.com>
Date: Wed, 10 Sep 2025 17:17:19 +0200
X-Gm-Features: Ac12FXxyvwjkGBqU5CGnwwYoBL_GhGR4Pi-bYCMRWWnvxg2lK5-1tJY_LVyPzDg
Message-ID: <CAAMcf8BfxMJx+5ttEXx0kONP2OYWSLFqEYF6rfVBKoRg5TKZzQ@mail.gmail.com>
Subject: Re: [PATCH v13 3/4] drm/atomic-helper: Re-order bridge chain
 pre-enable and post-disable
To: aradhya.bhatia@linux.dev
Cc: Laurent.pinchart@ideasonboard.com, airlied@gmail.com, 
	alexander.sverdlin@siemens.com, andrzej.hajda@intel.com, devarsht@ti.com, 
	dri-devel <dri-devel@lists.freedesktop.org>, j-choudhary@ti.com, 
	jernej.skrabec@gmail.com, Jonas Karlman <jonas@kwiboo.se>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, lumag@kernel.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	neil.armstrong@linaro.org, nm@ti.com, rfoss@kernel.org, simona@ffwll.ch, 
	tomi.valkeinen@ideasonboard.com, tzimmermann@suse.de, vigneshr@ti.com
Content-Type: text/plain; charset="UTF-8"

Hi,
this patch causes a regression. It has been reported in
https://bugzilla.kernel.org/show_bug.cgi?id=220554

It affects the gru/kevin platform (arm64,RK3399) with the Panfrost DRM driver.

When it boots in console mode, the blinking of the cursor keeps the display on.
If it is turned off via /sys/class/graphics/fbcon/cursor_blink, then
the display briefly shows each key press presented on screen for less
than one second and then powers off.

When starting the graphical mode (wayland), if there are no
applications drawing on the screen, the only way to keep the display
on is by continuously moving the mouse.

Regards,
  Vicente.

