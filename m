Return-Path: <linux-kernel+bounces-873332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2D4C13B0A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E326D1A67E90
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A152EA473;
	Tue, 28 Oct 2025 09:05:27 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D493E2E7BAA
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761642326; cv=none; b=FWhUIkYamKRg2TAcoJLao6s2ETo2wsg4kLZCD6DT4nJP31zvcY1u5DvZtGF+jjN6yiROgBqsaviFBHjH/IckGLOX3eMWyojWIOo+bqlVpKLvJy/rI4V20Xo6Yr4Nxk0cQJBIWhD1uMS+4uqFm14fYo7KLipeN9ocrApd1gMpuSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761642326; c=relaxed/simple;
	bh=HeX4/+QdTeIkEsusdgtpVEWN5CZYZZgYZNEcjz+3FZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/uVeuAw0tMvfi7IT+KRcDU8DMUs7Ae0jLzILg+xllYwLTHEgCh2PZ5AQoSe4865paWQOKEEq5d5z5ULa7LDfczNUjXZCQaEskyBtFUa9mjiJnLKB4zLGVzfdtu6N1mAPSGhkF6ffx/i3VVk1NItvbbykluGJqVLC+7ntEpUO5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b5e19810703so876027466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761642323; x=1762247123;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I3bhh0DQ8aw3qyEM+t66V7wEI7qFPP5kxL/D0neXiao=;
        b=qmqrvEgwahxUi0PMyhFr19BQqBfjoIfO4EUrejh0/fDZm83t1En837S78twiOusy4/
         DTuMpFWZsjkne3EsONMZ4/8BtCkA+HF+jpwfSSeyiyWBStb911ZyBMzmpLrV5ZAVjux6
         MBXrKpF36YfLyutHWWhVJvn3y8SOQ6PbCwRcROrhPYCt03gOasa9e1AR+Kk2dOOp4/O3
         yOXzx9HkdDz+ok/Be/Fer6CuPqJTzU2Y4uq9UEjYiUnMMuRWyxkSO0vSGcSSMutY6viu
         j334G6RQYeCfqHfK+LAU/uxDaCxUlQGcXvVM9cXwj0iFCqUhV7l7oIxUwiXDk+MER/SZ
         jFtg==
X-Forwarded-Encrypted: i=1; AJvYcCUa7vfB4eIrSFWkFU/XFeVnshvz74d80A4+sHbkXMIpTv8SnO1VuPPRLlu6d7B1j2e85gUAw1FL0L8lEMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVpZjn/OpvZ/eyWTu8fFZ7PP56EFYHXK5PEAYHygUR39tA86Xa
	YkswvvsazCiC3eJVhVKmntRdQHRZY7gZE1HH9sspJMlTEB4Q66hbub6beGb6EztBNHQ=
X-Gm-Gg: ASbGncsDdZERHOTy7lAWnWVRi+HMkpDx7KHvvjHBk+MeTM1+FyKfP9z+10bA8iBZYvA
	yFdZMEYrZlF0hoxBtbRRNa4SpbkH6MgneszGVQgeu7Ir6rT7O+296kLqrXIFCFbajHk/3rRcrbU
	ugVKnVk4W9RST2cqJIaAs5194F5TNEsWuNwh/c0NUAYoe5QHuJNn1HTKfjoXDT2gS4CS5fr2R2u
	YPtcxJ+A4TU0lgeypeKLrPeRtqHZfVNX53pxf+o9a4SldVTXx+EreuK2ifPrOqCu5BPGLrfcvGw
	lTR2Cl67QyQJEz1dwSZ9DHriMsV3mptpH5hPKMwiCqBP6wO0Ntmi8HB8/8Oj5SOyuKvAjJcxNpi
	T+SYoJdw+f75S3s/d4Dp0LEkY+MK6IufbfouxTkqeCM/UhwgbINXETnuKRA4LACwS9wn+DJMCxn
	tnomGv/NuAzCalE4vO+vuvoLlVM2SEGCQYbCf7Yw==
X-Google-Smtp-Source: AGHT+IEBgxJz7vv+Ntr2+d3OgN1mqJsH+ejgbYKWNLnE6w+jsMxXZVOIL9ZYcg3efDW+n7mP3nTomQ==
X-Received: by 2002:a17:907:6e90:b0:b40:b6a9:f704 with SMTP id a640c23a62f3a-b6dba4626d3mr269828366b.7.1761642322421;
        Tue, 28 Oct 2025 02:05:22 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85308cb0sm1057991466b.9.2025.10.28.02.05.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 02:05:22 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-63b9da57cecso8751332a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:05:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUL0SXIZKrQU0FAxo+Xpwb5piUHs8giltiPRiosLSQh8hQBSNNJwc/0GZ87GG7P5ODmlwlELvFAC15GM5k=@vger.kernel.org
X-Received: by 2002:a05:6402:350c:b0:639:ff4f:4bba with SMTP id
 4fb4d7f45d1cf-63ed7e0c0c0mr2377923a12.2.1761641835996; Tue, 28 Oct 2025
 01:57:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-v2-0-667abf6d47c0@bootlin.com>
In-Reply-To: <20251017-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-v2-0-667abf6d47c0@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Oct 2025 09:56:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVyeyiHWnBRw9gOF6=_m1SHa313dF20yKA83oQMS_oSFg@mail.gmail.com>
X-Gm-Features: AWmQ_bnk1oZlJu05NjQHeWpy9S3BuAl1j3bdf7YMwemWUQbyo0ARvnVUlNuRCto
Message-ID: <CAMuHMdVyeyiHWnBRw9gOF6=_m1SHa313dF20yKA83oQMS_oSFg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] drm/display: bridge_connector: get/put the stored
 bridges: fix NULL pointer regression
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Hui Pu <Hui.Pu@gehealthcare.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Luca,

On Fri, 17 Oct 2025 at 18:58, Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
> A patch of mine recently merged in drm-misc-next [1] has a NULL pointer
> deref regression (reported here [2] and here [3]). Being in lack of a quick
> fix, I sent a revert proposal [4].
>
> The revert proposal has no answers currenty, and in the meanwhile I have a
> patch that implements the original idea but without the same bug. So here's
> a v2 series with:
>
>  - the same revert patch
>  - the original patch but rewritten without the same bug (and even simpler)
>
> Also the re-written patch is now split in two for clarity because it was
> doing two somewhat different things.
>
> [1] https://lore.kernel.org/all/20250926-drm-bridge-alloc-getput-bridge-connector-v2-1-138b4bb70576@bootlin.com/
> [2] https://lore.kernel.org/lkml/336fbfdd-c424-490e-b5d1-8ee84043dc80@samsung.com/
> [3] https://lore.kernel.org/lkml/CA+G9fYuKHp3QgPKjgFY3TfkDdh5Vf=Ae5pCW+eU41Bu=D7th2g@mail.gmail.com/
> [4] https://lore.kernel.org/lkml/20251016-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-v1-1-81d6984c5361@bootlin.com/
>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
> Changes in v2:
> - No changes to the revert patch
> - Added the (corrected) patch introducing the same feature as the original
>   buggy patch, and also split it in two fir clarity
> - Link to v1: https://lore.kernel.org/r/20251016-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-v1-1-81d6984c5361@bootlin.com

Thanks, this fixes the crash I experienced on Koelsch (R-Car M2-W)
(https://lore.kernel.org/CAMuHMdW=zEi4XjG2Qrvj=jCa9LPBRU7HBTwEQVbe0zoz5mV_XA@mail.gmail.com)

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

