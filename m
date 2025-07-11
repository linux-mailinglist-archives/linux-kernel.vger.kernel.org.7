Return-Path: <linux-kernel+bounces-728049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4706B0230B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DE841CC2BA5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44662F19A9;
	Fri, 11 Jul 2025 17:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hVF4bZbE"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2312F1FE2
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255893; cv=none; b=F8kGwOi0jdJRt6RQx/k9+SSg9PG9Fb+IQGUBKnglIM8wzqyJCM9gXo4IxTkqKzImLciX/RNYlaElroWibASVt7ENahiz1izJ9uPP5QHva25RluuAEMOvc+qZ7bnMqv2HI3A7Xxf5SwbHKuU30BTp/iQCRjEzKrlg2adoDeg2auQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255893; c=relaxed/simple;
	bh=u+ZM5SO8L4rZ2xYIS3dtWrMrDyHsyXlquIkrSDaXE+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/Nhx8Ze4qjp9vtgZ0xGAQ1UYszeQorhE2L9+MaWjIKevsY6vDJ0wETsufh6+j7gx+DdtsjVGcZH9X6s25OtRxq70Hix7v/BDD9dWv3nsEoK6RC3c7Leq/ocZ0GuOFooLshyfEJtA4pSmjErmBpZT8Ah8zCoe5JkCWF3iKDrGr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hVF4bZbE; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32b5226e6beso22706881fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752255889; x=1752860689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+ZM5SO8L4rZ2xYIS3dtWrMrDyHsyXlquIkrSDaXE+w=;
        b=hVF4bZbEuP4pvsIBFxaWeWBlnqNCB7BB/8a/uCD1T/DUCO2u8PBQaL5NwIZc8VVKqi
         syC4aExadO+FYZh9gUFcvIdzcjJUTQuPBU/8HO/urMdoSB7zWNXrjOCiOeFXG4D/wHHd
         jZGYvL8sLieeQ07O9T+cbLWv/U46cyOTu+nTw/8wZ554+qxc9wE2tamuPmXoJboHT1B3
         v6rxJwF1LS4Nt8F7/jCbbg5AP0BbYriPjz7wFXdPRUnILInVlChIa5JXrCX7wLJnntah
         H+RrgZ1rwnKLeBvMoSqYBoN9vxP5LJc/gSaVvAAxBkvBEY/tL519nSt/Swt65OrL/0qJ
         APsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752255889; x=1752860689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+ZM5SO8L4rZ2xYIS3dtWrMrDyHsyXlquIkrSDaXE+w=;
        b=neUD3WQ3IS0GMVoUbaOWxg+m4d8zcZgjNbUUToddIHGrIGMqxyvlngkhPEpAGyAT8E
         v5PPq3DhCwrle7FtB2NYVTwuWvYbU5m+iXXuhjs7Qu9GfW5mTebMdoTv6oRA+mXa5dEz
         8yrF7zWdWtDsNd9m4/N58a5TGR1WLKXI+w+md2B7CRpZGLEU+oqybUNZtGSyfvc141Qi
         d2GeqMorlY2NW5MSHmpQUaxmIQa9HwLlFE599eVaVsN9W0GM0UuZ1kU5Z1X5OXkp2hq3
         yPS9Lbear0EQw2YwiP8kt4zIJzPWXQ+exRQrYuQ3dtcMXHav4sLTbY8A6BxsjBTs4e0U
         tbLA==
X-Forwarded-Encrypted: i=1; AJvYcCW7ivOsKDLIqjNB1T8pVOlTYsApNRKAtH/aXrrMJybKgbjujQPi4yxOva0WweYAM4cvy2baGjl9jGOrmJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy17cgv2e2odQGt+QRxBDOs9tdCzfqC0ebKqCJMjcErX9ETbyau
	/xwXOFw52PtWPZPXWL+rPDdJLWu05XbLFBOTgoXLYmgTLM0x2wVC0GvWsvWPJengPf/E3NU7c5+
	RlTqpzK6CIIG0nEtSpjk2iGu8ppPCil0DmZKgc6pZ1g==
X-Gm-Gg: ASbGncsga2InwUDDgXRodkbs58DsnsYjWYyFlq5dvVQsmBuDHfN+tdTjuGMDo31fFMg
	ixGM0YeovzyKascqW2NbiW5apHzvaK1hcAJpv29u3Cl8vo812F8dHannOiVlhPgRQ6hI9dpPqZa
	5s6oJCXyCnX+vw3I9pSlHh+m80uwG9WEsmmViFMHDtcG6OQFyqNNH1NNmj2FLuprlWJ4e1J9wF9
	HNwyQg=
X-Google-Smtp-Source: AGHT+IH6ZOzBfHIgYUwgOc3NHyt2gji+Em8NzLEp8xFU4pLvltizLDn2SrTtw5BwtYgzrpRFDHd1anYmDStmm3/BYxA=
X-Received: by 2002:a2e:ae05:0:b0:32b:75f0:cfa4 with SMTP id
 38308e7fff4ca-3305343ffbdmr14799021fa.25.1752255889239; Fri, 11 Jul 2025
 10:44:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710-drm-clk-round-rate-v1-0-601b9ea384c3@redhat.com> <20250710-drm-clk-round-rate-v1-5-601b9ea384c3@redhat.com>
In-Reply-To: <20250710-drm-clk-round-rate-v1-5-601b9ea384c3@redhat.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Jul 2025 19:44:38 +0200
X-Gm-Features: Ac12FXxUNTUQvVOGg3MoOkpShRe7WywXW6kbpP4WvN3P-CcJwwv5gR7MoObTWCg
Message-ID: <CACRpkda3R+2hhzvd+snkTGrRb-gZ8OUvzAhFE5Cg6yXfZ+E4nQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] drm/pl111: convert from round_rate() to determine_rate()
To: Brian Masney <bmasney@redhat.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Yannick Fertre <yannick.fertre@foss.st.com>, 
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
	Philippe Cornu <philippe.cornu@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Stephen Boyd <sboyd@kernel.org>, dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 7:43=E2=80=AFPM Brian Masney <bmasney@redhat.com> w=
rote:

> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series.
>
> Signed-off-by: Brian Masney <bmasney@redhat.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

