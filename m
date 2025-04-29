Return-Path: <linux-kernel+bounces-624656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC70DAA05F7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 10:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A9A1B62B6E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 08:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3B429292F;
	Tue, 29 Apr 2025 08:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ansbdwJx"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3E729290D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 08:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745916056; cv=none; b=MT7usvyMM2kwXaYSXNVR4x6pxzTLRvT4imsorXg9SWF3cg/E3mQVu8CKxGLvmb48z67QH4GEIxBZy48w3u31L1xxwQ83sbPQEje5mLUJEmt/mMRpXhCB1c1Uem/2r+b+hLITghQP/Cij3ndRmKzt0iTSddwd1tpzfl9Mf4Nwr+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745916056; c=relaxed/simple;
	bh=KyAtXWPUARsz+iDauIm3noZwAgvzeeeL/6Xih7T8GDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UWScKWq6B2t6wY55tt0ITTvA0nHVq5hWtIvtS+ZIwFVj7/7Pn6EIj9JKM2hvaO7bkp6GQQSOn4UF7vgGAn2q6lDwvRZyXXy0wWZ5stspU5QoYoADtf3caJUBwjffQZiHzgy4EOvd97P+fJ2xMeks6NOHES50N84UFvd8OX2pNnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ansbdwJx; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30ddad694c1so63175101fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 01:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745916052; x=1746520852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyAtXWPUARsz+iDauIm3noZwAgvzeeeL/6Xih7T8GDE=;
        b=ansbdwJxsueyefFM/ctUcCC6V8SAelIg4fyKH0DNmeisPkebKtqXUHrNQVqfENhfvo
         /+xit3qJOdMQNIxjRfKCjBsxY2jgxaKdC9yYi5qsMAbJn/zV1cYNMbu/w4+loB87L643
         DH0iVgtbCj6WQeJ0sbJ7sNEfSrSsGMP1adYk92DE/R/9ycX53FcJURUwQsxFhMD6m4Ai
         T+HRIAFJccEWJbCk8+vatZJzmsTisFrWvgBUure1gbQ0+JaJ9Of4s58IKYvHqEa8LScR
         UCmvWxEUobYTFF9R4MH7dqF8MXy9MWi4sSVnogYjOCJV9F0dCattldNwJT0oODZa8Tnd
         BmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745916052; x=1746520852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyAtXWPUARsz+iDauIm3noZwAgvzeeeL/6Xih7T8GDE=;
        b=uh3ktImMriSEe0BIOjpRy1mQdrukfUcsOQ05ZbD0B/5JO0j2rZNw4la6ztZ3yitQLU
         fphLUHtgd4LnZQC3KcodRRRT+QVh41bQuhsUaoBY8XASaedJgutlqRbHkuNYjlGFYKNm
         hwOD+SlmeQvQHi5F3oourKPuQ281a9dh+e2tXq6z+yn3+tOS9urrxnSlpDoHy2usgvA1
         fmO1NdRB8M9adVtJt5W7uGc/rTWFYp677dzdHCdbkJYYUDy6n9ERqX7nnNveJNxRKMez
         kBCUUMRnFUkiryGIQvS21hXW+CRoqLQZZ/lo9KgOHnvrb0WtrPdarUkrVBxKvPb3FeOT
         9iWA==
X-Forwarded-Encrypted: i=1; AJvYcCXu0nn9t9jWw7Si1YZ6hq0XbJfikLv8NkydGgKPMU3Qfb+AQqxBSBDk7HhV7gtN0BbSJwmQYRtztoh1JG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8fYYOru8ePsF3vcsaHm97le905bLnLDZIev1tX+FtzIh5nuE9
	vOcxyNO4u1cuS9YMZjyRqoQH3HIuPjs5r24k0DECdgGzPZAod1UOWcSGL3Q0+1ARyuUVOuqc5j4
	TYrNoorGdTmBj7jhTTATRItmPlOrEOD9K80qsQg==
X-Gm-Gg: ASbGnctm6mXurK2GpdPkNNQDlJdtrFOP0qT7B3yo2hNp02vn7awzuz7397s/1i+fFR/
	cIrzOKnYmyAAx7xTX2p0uEVNDWBUMGtSiTJSDARlPLytPKtpQYpT7Tc/Z7Ilh2oXaFW3+SGZ0vw
	2ISEqPYxHHgMEiDWlAu+797Q==
X-Google-Smtp-Source: AGHT+IEUiqYB296CVrwZ+xxBw7BC+pTcJa/x+6Bu5GNB2EvNhnBwa7BLSUJNRUMp+Ehtf1mLBoE9JSmzpMhMYJBukms=
X-Received: by 2002:a2e:bc0b:0:b0:30d:894a:a538 with SMTP id
 38308e7fff4ca-31d34b6c243mr8766341fa.21.1745916052135; Tue, 29 Apr 2025
 01:40:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424-drm-bridge-convert-to-alloc-api-v2-0-8f91a404d86b@bootlin.com>
 <20250424-drm-bridge-convert-to-alloc-api-v2-15-8f91a404d86b@bootlin.com>
In-Reply-To: <20250424-drm-bridge-convert-to-alloc-api-v2-15-8f91a404d86b@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 29 Apr 2025 10:40:41 +0200
X-Gm-Features: ATxdqUEhPh2HxY_cKMawBJnfuogL8n7jPhFvg8U9jTR5km8hYrNkb1VPdIYXtGQ
Message-ID: <CACRpkdZt8zem0hFUiq3-Z1feNZHRh3R=Y0cEtK=pVt=bJ9Qf1g@mail.gmail.com>
Subject: Re: [PATCH v2 15/34] drm/mcde: convert to devm_drm_bridge_alloc() API
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Jagan Teki <jagan@amarulasolutions.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	Chun-Kuang Hu <chunkuang.hu@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Anusha Srivatsa <asrivats@redhat.com>, Paul Kocialkowski <paulk@sys-base.io>, 
	Dmitry Baryshkov <lumag@kernel.org>, Hui Pu <Hui.Pu@gehealthcare.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org, 
	asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	chrome-platform@lists.linux.dev, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
	linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 9:00=E2=80=AFPM Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:

> This is the new API for allocating DRM bridges.
>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

