Return-Path: <linux-kernel+bounces-743924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4751B10592
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336703B90B0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B8B259CAB;
	Thu, 24 Jul 2025 09:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CfDQOpDG"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0B9259CA3
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753348626; cv=none; b=HB5dOA5EjGXQiA9wD7bJ3TN4DM0XN/Svnhh9qjpmholxeDRMrNr9J8aZOhd+O4KrP7eH/teKdlyTVikf5ueHzYFdblW3pU7MCGYb0X81H5tprMURpaeqWHBFVN5ULjPxsn8zUU/ftSNIIji0H0KB1y5iSVOqEBMElb/kFvMTSuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753348626; c=relaxed/simple;
	bh=PzAImXvw7ltOkAeF9aE1vYSBycD64FXcVdqDkDZASUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VjZ0Cs9FKFD3eBulNlMV9zO3XgxYny5Vql9kCCNjrToZQasj8vYjBOfjhHt6iel03c8JKDgR0GiOfLS6L9kIUpXU2yaYkva8TqW5k5mMFDjkaoQyh831654g4xLO7HaS5WWdTe3ivmEUI0hArxWMcYl5WVEGx6iSax9m6F+zE6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CfDQOpDG; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-558fa0b2c99so605317e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753348623; x=1753953423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzAImXvw7ltOkAeF9aE1vYSBycD64FXcVdqDkDZASUk=;
        b=CfDQOpDG7+H+rT4gcjxVG7nzL72tk82jIG1UHBBO6Be6KGFhDBbZJ8nSvH5RpDu+4W
         PhPhs0uFjfTJfcg3Dd/GGYRXi+YHgjZedHEcOGMbkyqaB14T4bCyZ+c26Ve1RhBXkzNJ
         Shk5METhMqgYWQyIaU1Eg7XI8HUByzQshRM18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753348623; x=1753953423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PzAImXvw7ltOkAeF9aE1vYSBycD64FXcVdqDkDZASUk=;
        b=A8f61Poj4iCKJfr4zb2RW4ikABsUmeUOg/JKHd+oupBhwY9AdxxkmQ2mwSgfUVrIhc
         Wf4cgBA1I9Oq1rmQQT2+7UpxFXko09lBOwYRFzY1YCmAE3S3+Ie8LOz9QIadgXA2C6y+
         GzAKVD5rBuRB/jF37c2XjDRIYaT3d9ESLGlgu4JPASThDO0hBGF0MNYBq7FIAX4q8gvT
         J9065DRk7aLvWGZuOrrkcBvlnNRib3j5NA3MIug5qQNbZQcSKGGq4On8L3TOKVg2BNMk
         gHpY9JcOlgdlG/E6FGRPRok1gLjBixlxpCqnxMJTHA5vcO/mV3Y1oSTwfjZLDjynZi0b
         9RmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYu85iO93ucWcHYRyK6Yen173K5W+v+Jx5patW6E1POJZRu0HNZl4Bk0pCQTrhdzRZVbYb4/52c47ochM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq3oyDL2zORpaUHtuDTx2DhuDhvEGEpAXCoOcE34o8YjnPaE5Z
	vxGKEqN/ou5uxuCxwQBhrbXzAWLfwLrBCnit06bSMjRmiLNXjlw/7FkEAp8EE3d0XK8/G96AaRB
	k5czExOLB7h2D7VGFB2FZdZ5pkDgBtcsLXzNezqEP
X-Gm-Gg: ASbGncssj8aC5tReiSZlH+Q5WXTta/1x9Wcn/Q3iPYjXVASTdQGLzZGoHTc7wUZymxN
	aZy8AUi/vdvZ/YymxjLYpowLJnvgxMC4g1UjVER1rGdvUEIUztw9bgS4PZ9L7ICZM53sfiIGzsP
	qAffK8V+bF6Th7uPkj4hvflZ+ubHF+flwZXW+klj8XEfafM0k82SD/BWK7CH1q0JCi8YDbZ3aTI
	cdIv+6oyd0w1Nm8mx6T2w93FMLB1zZoBhw9XL2niFEajQ==
X-Google-Smtp-Source: AGHT+IGEMdfa/7pI/vtQhZpE9t+GCiAKzWTtoHMGXUrvfqlTr4xGM3G4p6O55TyjazqugJ0Dpoksr/xy8ncvPcXnu9I=
X-Received: by 2002:a05:6512:3a84:b0:55b:57e8:16a5 with SMTP id
 2adb3069b0e04-55b57e81981mr94240e87.32.1753348622453; Thu, 24 Jul 2025
 02:17:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724083914.61351-1-angelogioacchino.delregno@collabora.com> <20250724083914.61351-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250724083914.61351-3-angelogioacchino.delregno@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 24 Jul 2025 17:16:51 +0800
X-Gm-Features: Ac12FXxEOfXERpbm54RTrpt_sFAe6oyRhPRCsENRyO12HQ_K_abqIUXAGxmi264
Message-ID: <CAGXv+5Exb0X-6V=bdJefaz+m=eXSrrw6_SgWY6vDF3rF1RmVBg@mail.gmail.com>
Subject: Re: [PATCH 02/38] dt-bindings: display: mediatek, dp: Allow
 DisplayPort AUX bus
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, robh@kernel.org, 
	herbert@gondor.apana.org.au, davem@davemloft.net, krzk+dt@kernel.org, 
	conor+dt@kernel.org, chunkuang.hu@kernel.org, p.zabel@pengutronix.de, 
	airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, jassisinghbrar@gmail.com, 
	mchehab@kernel.org, matthias.bgg@gmail.com, chunfeng.yun@mediatek.com, 
	vkoul@kernel.org, kishon@kernel.org, sean.wang@kernel.org, 
	linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, 
	andersson@kernel.org, mathieu.poirier@linaro.org, daniel.lezcano@linaro.org, 
	tglx@linutronix.de, atenart@kernel.org, jitao.shi@mediatek.com, 
	ck.hu@mediatek.com, houlong.wei@mediatek.com, 
	kyrie.wu@mediatek.corp-partner.google.com, andy.teng@mediatek.com, 
	tinghan.shen@mediatek.com, jiaxin.yu@mediatek.com, shane.chien@mediatek.com, 
	olivia.wen@mediatek.com, granquet@baylibre.com, eugen.hristev@linaro.org, 
	arnd@arndb.de, sam.shih@mediatek.com, jieyy.yang@mediatek.com, 
	frank-w@public-files.de, mwalle@kernel.org, fparent@baylibre.com, 
	linux-crypto@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-phy@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 4:39=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Like others, the MediaTek DisplayPort controller provides an
> auxiliary bus: import the common dp-aux-bus.yaml in this binding
> to allow specifying an aux-bus subnode.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

