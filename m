Return-Path: <linux-kernel+bounces-730640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80981B0477F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 20:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 793071A60128
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6822253A7;
	Mon, 14 Jul 2025 18:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K977xGVH"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DC01CD1F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 18:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752518795; cv=none; b=Y96Gl6hsJ9rFGcDqMopZ/9zra6YDxKO0t/7e0AbkSUL+WwjIf/mFXMTzlUO/A8L4n2Cnm1MYYPQbHbb30hYDhM20nu6k10766ayfL0/O2j2dVX0DWVORLCl//OXjUFJrI1+rX8PxTNfudd3bl6NMjLj3bwKrTQYrk+4tR+WcqKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752518795; c=relaxed/simple;
	bh=Y6WHSS+Nj6NTaCj98Pl2E6qZ56Qy+wOXIU5xNtNHyJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SqEcFPEE923M+h/lGTRPEyVmLJomwI24bq48Uyb9wAmI+BALmJaUY50CHTv0a8ztU2pLQbl5nzjOlBHrCgLhWu8m6mOtcEEIOQECKp1kPccOWbywSD/74Yvyhd5Q+odRLUIG+TWImyTiJ/2Fw4y1x8lAvZFLtaHXM7Jg8qQF9CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K977xGVH; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b1fd59851baso3289598a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 11:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752518788; x=1753123588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhYwsgQPrArtrFiygSmDmJo6ydvTXUjtDEZ18FPii+4=;
        b=K977xGVH9lot04WP7bPZyB4kBLrEeTkqZG0BP5piIjudOrmdWLkwaCyvagbgX+X9Wm
         p55qJJst3GQJyVuwkVUWzIYmbnQDsE0yvRawo5IpECkUbgFKFkwKiFYQ8C7oSdfISjEQ
         tQ0hPr+OYDV9cioqqRaA1vy2Y22G3YoFQtfXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752518788; x=1753123588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhYwsgQPrArtrFiygSmDmJo6ydvTXUjtDEZ18FPii+4=;
        b=RqlIngravkVBnmt86XGXs0eE/JdSOrUMnslbFj9R5C+RLIPsdRKtAGzHXnqeCGGuSH
         btybu3n+8wHchCRfT6wElsXLyM6CInD5/GqVd1rJu/edsG1Np/3dmbB5NPnUV1eJJ0PC
         SyltQ9w/xZ7hAYmnGk1zTVkVvI27daRZWIsPtrpHRlrgy9S8U3yx/sO7sCkl487xAUcx
         wy8MHWGAerg+Hjb5RTKYWSg4jaNeiI5KdhgJ5/LAa3wD/9LvAgJ+QRuuBVZg8M7hlzAV
         HUnOJFoALqlCzlL4JxZ3pk4pcumcQoDXhsrjPmNrxKPfvAkzOSJ+iQ1ADi2YMehApveL
         jhwA==
X-Forwarded-Encrypted: i=1; AJvYcCWev/nANeCWk3xRooDJAfqDAyhc4D4X5jQcaRihC/RYUg5tcEy3FezpSCPQbFNyQmoJWu1n6uGHyreI790=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUK4Ib6580X837BjzzR66SPz/TMVYDpZy8RpYTDCXu5PnZ3+9s
	Y0xtiVugwChzPmDlYN7DmLgqSe6yEhikRFGktJkBIdWwSYWWrM9hwjJRlxQE5jc1fMZcLffwLXq
	KFvc=
X-Gm-Gg: ASbGncv+pAsRz6hCrxiQriF3dZuzGAgxNSIqhmzWUM9mB8XUFQrJUAiuVKmoHOf6LOs
	H3w0nTEV/545CI/CKTe8D8RCJTwOezuKbRy277piqcXYfD5jrgIqbssXYVAbul87hEgvwkn6hkp
	sSfJBFkK7U86J1BDUPWMKk6TOPL8vgD2vutBK5yFWFCawU2ACZh4o9OWg+5Z3bEspxUX2/qfCa4
	pTNMLxTtAOJfuJkAhaDKQ8rC+Zm6hyJzuOKRbTQI1Nn0mZXfW+a7LRHZaOIwsMpc1P+ua9EoKN7
	cw0gVvRGkK0V4621rDu05pw5zHsnB6x746v3quwH6M0pCPNBqA1Sp6komdRLg6lT3IsQGFOpK63
	+YAlWQSqATaOn/yY3IAUi9RKTqb7yp7BfkdNoR079UtEy/rRrZVKDOGOr9gFT4+b+5Q==
X-Google-Smtp-Source: AGHT+IGKHQL46n0Ko2NdFMhu/TU/ShzpetKUzEFh77ZePRbjZtdsTkmLgTtziRCUkg9SqVTfL9Yx/g==
X-Received: by 2002:a17:90a:d64f:b0:311:abba:53c9 with SMTP id 98e67ed59e1d1-31c4ca67689mr19899856a91.7.1752518787667;
        Mon, 14 Jul 2025 11:46:27 -0700 (PDT)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com. [209.85.215.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4286da3sm102589505ad.34.2025.07.14.11.46.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 11:46:25 -0700 (PDT)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b34a78bb6e7so3720348a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 11:46:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX+38icUkrW0+QExWThNFk7QfAZdIst9hrXb+v47z22a/V88d3ho2rWKSOED/Ozzz1e0IhTdzTsPBOJxyI=@vger.kernel.org
X-Received: by 2002:a17:90a:fc44:b0:311:fde5:c4be with SMTP id
 98e67ed59e1d1-31c4cd158bamr19315242a91.35.1752518784559; Mon, 14 Jul 2025
 11:46:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708085124.15445-1-johan@kernel.org> <20250708085124.15445-3-johan@kernel.org>
In-Reply-To: <20250708085124.15445-3-johan@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 14 Jul 2025 11:46:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V1LN2Q2C9P9Ed3V+Uar_T2Sp--ssnf8H29R-N2Qz3uEA@mail.gmail.com>
X-Gm-Features: Ac12FXxB9Xcr1r23IW5HQaM5mlJ4_4Yoc45Qq6mTbhKGiBDrgy7Y7zJvyC4IrHo
Message-ID: <CAD=FV=V1LN2Q2C9P9Ed3V+Uar_T2Sp--ssnf8H29R-N2Qz3uEA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/bridge: ti-sn65dsi86: fix OF node leak
To: Johan Hovold <johan@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 8, 2025 at 1:52=E2=80=AFAM Johan Hovold <johan@kernel.org> wrot=
e:
>
> Make sure to drop the OF node reference taken when creating the bridge
> device when the device is later released.
>
> Fixes: a1e3667a9835 ("drm/bridge: ti-sn65dsi86: Promote the AUX channel t=
o its own sub-dev")
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 ++
>  1 file changed, 2 insertions(+)

The patch doesn't apply to drm-misc-next, which has commit
6526b02e1020 ("drm/bridge: ti-sn65dsi86: use the auxiliary device").
Seems like you need to resubmit as a patch to the new
auxiliary_device_create() function? Do you feel that this is urgent
enough that we need a separate patch for stable?


-Doug

