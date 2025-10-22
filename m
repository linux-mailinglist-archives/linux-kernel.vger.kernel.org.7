Return-Path: <linux-kernel+bounces-864480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C64BFAE08
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A11C188CDAC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5752C3081B5;
	Wed, 22 Oct 2025 08:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v2OJ3Gd+"
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F286B2FE060
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761121493; cv=none; b=OMhrphyTTfnPJLe9tSPFbdX70H7EU1kIQ94iJQDLJPDZ4KzdX79GfbuzHZ7IXHMsBa5g7di2KfLWg9LP0mpPv2S4Ye8TkSb31ND8+TXJMMFD6pVqQ+BKqVhydiwmUgkZqGxZW2WFLBInavI9tGFQ1FUt9yrKA1R2c3rbtpntyog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761121493; c=relaxed/simple;
	bh=RXxaSNMDRj91FhueTL9SXO/VAqCmGMKRScvrihJDC2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lM3wmLXPKRNncfcjrOXQPJo1zXuw8b430a6wtkRid+LnT6r+mCMWI82UlVPNiCKd9bWMHTBgJWVFPmwzoWC/XA+CgAbIhAA8eC1Fosow0MZkFyQRZkvm0fwX3j6ljbzP1cQTzlAYMh00e/a5/YVIJSXQwYpFFJz+SktVTg4CEmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v2OJ3Gd+; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-63e336b1ac4so1229886d50.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761121491; x=1761726291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXxaSNMDRj91FhueTL9SXO/VAqCmGMKRScvrihJDC2U=;
        b=v2OJ3Gd+tALwRf4OfHPbzgAmhR2q9x/EyLAQAwbT6+55z1sA6ldadAZiRvzfidl9II
         vGoBi+EyFET4eGSsVUDqyT7hX4f/U4Ox21zvHhKBg4eAorJZRGQhyM6H3Ix/+t6KAU1Z
         RF4Z4LKUPq2B7ejHo2s9gT6sEg25t7Kkk7+HWqIlLz5sWsYsLivmHifhtnsDSdyj8O1V
         SezByrdRbuCT+J0adHFptnb43WJgKgHPyyJiDw5gXTCjdAXb0lQaGd0J/DwX5viBu0K/
         e5hU0XOVeN2QjDscsOrS+26KnEaIjGjBLQA3VvR8rmqiVvp8HxttM0arvwOGJJMNgHFB
         V8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761121491; x=1761726291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXxaSNMDRj91FhueTL9SXO/VAqCmGMKRScvrihJDC2U=;
        b=DwzDeNF+2AtAnoN1uW8tozAIBIyEpYo++AZenr5ck6UWw1V71uV9ADF9175QHjYb75
         T//juMspckFN7nphRyHDjkwcuY7VFp9VR3rAR2b0ORD9t4mlC8xOiLixQbYM6aqvhEcv
         etlNaFPliprsCa/xOQZWYH69CDAbniVusgon29+ElY6EM0a41nSjWkiCnZc3yYs/njVI
         xQmonmEKMFcfdLP9+QiEuC2swQtdfJe/NK9rubsNGCjYgh7xOF2i7eswwvFCCkNJ3CUZ
         XoCL0gGQavyZO96TpugO4pFK9gXnutAETQp+khc44kEvRHptaOzb2bsmCQZ0SCeC39JG
         BXWA==
X-Forwarded-Encrypted: i=1; AJvYcCWm0gO1cOw/que1GJF53jObohcLv9aHmF53mJpb5S96uT94a0gSFad+9cFhppUFeq5js0EekdU4QMW/xhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKrRI1gUl28sVhRrEGkwJoPYepxhmSe1lxutsxv02DWLFX4gRU
	ypD+FsFTCo8iX9TnTJ1Ccay8g4E5GfAsXsBKx4tUMHtJjlfEdFzcWADBh4GQxeS8FiLyjAiI4Cq
	pxPhximxWORdWzoc/lrZesm5J9kZy9bX46YeBXbR5hQ==
X-Gm-Gg: ASbGnctapey3Iqs6ReRwfStyxtopqyD2IRMPk+5yza5CHWdciWtxFuDUdDPAGVSOcl9
	bTdv1En4DGC20RdlksZgBrWyotcIaRTVcxK+JvPZx50RD49gI2xC7uwFnG7Oo1/HfE50SSbeCMq
	PyLHs4jQEBk+9yXKrby/APPsgNmjMma6vgeARJII/mZ9j4Bk2/ZzQugSkj2Pc0d6FiES6ROAyKp
	gUILZUYQbT9R6bRtn3BM3CbpzMvOlhUWyn75XUc3Ha5maNr4iH/SFPiZpONaxu+iHNW15Y=
X-Google-Smtp-Source: AGHT+IERBbCdzrK/DnyqVvBrjv6GLzWwxwoEO7f9Mw9D/RkAigeGgzM8GB04mtMR32cqX6B3SnKkLTsVQyTiuof3lXc=
X-Received: by 2002:a05:690e:11cd:b0:63e:2b9e:1462 with SMTP id
 956f58d0204a3-63f2f624987mr358734d50.22.1761121490978; Wed, 22 Oct 2025
 01:24:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605171524.27222-1-aradhya.bhatia@linux.dev> <20250605171524.27222-4-aradhya.bhatia@linux.dev>
In-Reply-To: <20250605171524.27222-4-aradhya.bhatia@linux.dev>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 22 Oct 2025 10:24:37 +0200
X-Gm-Features: AS18NWBhnPNxVBgcXMb7pCZGsTv2XFqiKsKzW4r9u2dZYTJ-75bh2elmyFMfPJQ
Message-ID: <CACRpkdaOyDJ-ur6iO8qnWesL1SZ9C-okWO353rUKpTO-q8urWA@mail.gmail.com>
Subject: Re: [PATCH v13 3/4] drm/atomic-helper: Re-order bridge chain
 pre-enable and post-disable
To: Aradhya Bhatia <aradhya.bhatia@linux.dev>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Dmitry Baryshkov <lumag@kernel.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	DRI Development List <dri-devel@lists.freedesktop.org>, 
	Linux Kernel List <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Devarsh Thakkar <devarsht@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
	Alexander Sverdlin <alexander.sverdlin@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 7:15=E2=80=AFPM Aradhya Bhatia <aradhya.bhatia@linux=
.dev> wrote:

> From: Aradhya Bhatia <a-bhatia1@ti.com>
>
> Move the bridge pre_enable call before crtc enable, and the bridge
> post_disable call after the crtc disable.

This commit regresses the MCDE driver to a hard boot failure.
Reverting the patch fixes the issue.

I think it has something to do with the internal DSI bridge in
drivers/gpu/drm/mcde/mcde_dsi.c

Any hints to what needs to be fixed here?

Yours,
Linus Walleij

