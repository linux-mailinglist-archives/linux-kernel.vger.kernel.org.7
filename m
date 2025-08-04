Return-Path: <linux-kernel+bounces-755683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A41ABB1AA58
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 23:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 539EC3B8EDB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 21:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC57D232785;
	Mon,  4 Aug 2025 21:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XitgEzFK"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B03828371
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 21:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754342714; cv=none; b=C/9MLw12kBo0+cTWfO2JDs+xjGsjyDbItu3hQ6EIWvmXPOAfGs5X8XJiOspypblAnhPciKR0v2r754DgX1Fxs+ckrlVCtVXGy28byy6x5WYoQbFs1/hu6CdpsFO9HXi0wmGxO3s/Hex9wBDsX+x810tmJ5SRbOz7y4Ggt9QRxhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754342714; c=relaxed/simple;
	bh=RzSR3ZKLbemS2S/e7c9TTpVWYpr6XABcptayOCFNYjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GKgWS5VUYgNK+QKvFu5pMY6NgiMTj8sCKK4npDgywP8/TzzirkpBnRfwQc+89z5mMN3VYuRALkqzV/TgxXxtjCfcudN2oemhWcRwXLm96iusebBNEqtdLIpCOKlUTFeDkB4/z5Bt6vaIrgqwEt4lSn+5OPqJ6Eg8ZdIjv6ucZoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XitgEzFK; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55b8248e77bso4991198e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 14:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754342711; x=1754947511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWDD9vBYiM22iTKsOOWVvregqhqtXuA5Yr6oy6IbiPU=;
        b=XitgEzFKfQpbuiwEZie2bVTUSsPJ5FeBuHpy4fpFlHIGW+wQz2Cmj6L8L/TF/AwhOt
         jiYkgrwAllE2FPjzkR/nM1Z08jHMtWz8IzH5C1oVyUoYBwhTtNWrMzW/+ZC4UgNtLKk+
         bsSSTVaaNMUcsfAOShSVGLviRPHwKJfasHy5QB/9EYfMDg5FA9boTCZuCP4exuHT3uzD
         iA5s6cPg7WD5YhZIxYoEKueU4IxL0fVZWOGGgIIqV/AX/SGJfB/Xhb/hQe9wzlZqkmsp
         Uw7SKzkHYqgHCL3ujtE3L6V+xVXfvzRV7X5wBvtWqLWiCJDqVbqb8o4/oRCX6Hktr0Wq
         XTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754342711; x=1754947511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWDD9vBYiM22iTKsOOWVvregqhqtXuA5Yr6oy6IbiPU=;
        b=OsKrO3Q7jqp1G47KTb0ORzk0vMbPWj1MurL7x0a8MnbTUcsuV/gvSKl0bZBZHdDhTU
         EOpEjnBGi5ObbNAKnvBn1asZLpe/kBubG1SAw61o7HPoco706UieceV/qPTJGn0nVXvr
         IPCY1A0hQt6pM1t/3dPys/F8CKhm0QCeo8uSenwPkl8/yebDKGJ5K9yoU+T5Ad8jk1Fc
         6d0lW5qaeV3LrYepqqzF7inMqPkGOy5b3RUNqmA4099uJLduEw3N0ENprw0llUQUo+ZM
         0vhZWvvHf6CfLgdg/CwPpj2u4w280V5I8mLWBe/X858GWt3KE+pRd+JLN7ObZ26wsMY1
         a+4w==
X-Forwarded-Encrypted: i=1; AJvYcCW5tcGUJmfW4RmpU3/duK5zt1nWAy0Sa5h9HiC+7vBKJ2yGJhzmAIoTbQdIH2JA42jtSz/7HwABgLnKRsc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8m94MQlg2dQhz10ixMJ/No4cp3OcTkIJYk+Au1Ll2pZLnpNnp
	GMmRcWN9PEu1RdBCR2ZCsITq3bnnZndtwTOrb2iu9syC1tXPNAXte5swb8t5zuqrM9gcbdT4/w5
	Eulgu0hhzq1D2C7tc04CvUkiFrzUzX5g=
X-Gm-Gg: ASbGncsU9ya6hEXUvWeW4bh9eqrzt4Z+fMZqbA3a9G8fBXZ+gCe6vExBzxpaGpwVfwY
	8PO3gWmrqk0bTXi76ylhRr44q8YDkbVKlfm5tiKNHkJ8/OJ3Hh8yMSwp3Z6NyLLtgnbG4Dw/bSS
	nJoa/to++qJw6eC7103/3sdXTPB8iIXIjvf5BjDTxULUgBsf7fJvsCV/4LCy8UWuGxlrGt0kOO+
	is7mg0=
X-Google-Smtp-Source: AGHT+IHwhWuEn1GGHxiRWfbccegSPealqqij9ke+m0NTUfNX+oLlQL7Eg/yMlxItUPZ+g1I2s43Ndj3jMnV9fZ3MNUQ=
X-Received: by 2002:a05:6512:1111:b0:55b:8bf6:5178 with SMTP id
 2adb3069b0e04-55b97afb6camr2328900e87.14.1754342710383; Mon, 04 Aug 2025
 14:25:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250802161309.1198855-1-hsukrut3@gmail.com> <20250803165611.GG4906@pendragon.ideasonboard.com>
In-Reply-To: <20250803165611.GG4906@pendragon.ideasonboard.com>
From: sukrut heroorkar <hsukrut3@gmail.com>
Date: Mon, 4 Aug 2025 23:24:58 +0200
X-Gm-Features: Ac12FXwL9NH3bGAR7a55WkKenISlJy_mKF87GgDLFxcsdxAffltp7qpduSbCMsw
Message-ID: <CAHCkknr+w3B0NWM065Rr_d9n9QEak7YmhehByQTdfwYr30RbSQ@mail.gmail.com>
Subject: Re: [PATCH] drm/drm_bridge: Document 'connector' parameter in drm_bridge_detect()
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

On Sun, Aug 3, 2025 at 6:56=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Sat, Aug 02, 2025 at 06:13:05PM +0200, Sukrut Heroorkar wrote:
> > drm: drm_bridge: fix missing parameter documentation
> >
> > The function documentation was missing description for the
> > parameter 'connector'.
> >
> > Add missing function parameter documentation for drm_bridge_detect()
> > to fix kernel-doc warnings.
> >
> > Warning: drivers/gpu/drm/drm_bridge.c:1241 function parameter 'connecto=
r' not described in 'drm_bridge_detect'
> >
>
> A Fixes: tag would be nice.
>
> > Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
> > ---
> >  drivers/gpu/drm/drm_bridge.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.=
c
> > index dd45d9b504d8..387a3b6cda54 100644
> > --- a/drivers/gpu/drm/drm_bridge.c
> > +++ b/drivers/gpu/drm/drm_bridge.c
> > @@ -1227,6 +1227,7 @@ EXPORT_SYMBOL(drm_atomic_bridge_chain_check);
> >  /**
> >   * drm_bridge_detect - check if anything is attached to the bridge out=
put
> >   * @bridge: bridge control structure
> > + * @connector: connector associated with the bridge
>
> "associated with the bridge" isn't very clear.
>
> >   *
> >   * If the bridge supports output detection, as reported by the
> >   * DRM_BRIDGE_OP_DETECT bridge ops flag, call &drm_bridge_funcs.detect=
 for the
>
> --
> Regards,
>
> Laurent Pinchart


Thanks for the review.
I will send a V2 shortly with updated connector description and Fixes
tag, as suggested.

