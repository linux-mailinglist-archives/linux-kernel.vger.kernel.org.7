Return-Path: <linux-kernel+bounces-881356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5FFC28114
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 15:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F16BB3BC86D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 14:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1178824DCE6;
	Sat,  1 Nov 2025 14:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URjaxQwj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E12623F429
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762007884; cv=none; b=I9NvtMMr5JDla1JsbWUDvPhOYSqy82tzJsW+MtULjAnpcYNrGfyXC0fIhQ8EuP9SVT+2f3bmnp1SopEOLtXSnKH6DuBB8jsbvfxOwE+zmv9pY7qf/vlSY4d8UgziK47fzUXO9RfBV4Sm8+SK7ofsrHTgLgtHl3WJVCIQuxbtkDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762007884; c=relaxed/simple;
	bh=HkYm+o5ZrKQsoVDIa7Xk6T9MOu2JC8WhA3qTTbVvthE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8esv1MDThqUmrHRUR7VKCZin69wc3mGNaIcnG7YqRtUqtM2tlVGPWY42i0B/oJYESxnfOAXH80inDeBdXj1d0VI+j1Hd148dSoT97i9AXucTaM6ycuao7g2cIi5JwBvDGtqU/BU3iWaIMVFAT3CgGD0k9ZX9FWX5hAsCj6a5lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URjaxQwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F6AC116B1
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 14:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762007883;
	bh=HkYm+o5ZrKQsoVDIa7Xk6T9MOu2JC8WhA3qTTbVvthE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=URjaxQwj38MV9iQGYaolqDOCkpTUlKnSVuIzesiOnQhIW/2s3vUvTor5VZ2NOXl3r
	 2cOYuzMs8TvXSCJ8GkZqcH1oQUmWVTrWNSWXi5IhOXmiLHJe3uxdq0rLgVBfTJ8bJG
	 6LeOHDmU0rtBOaVQaj1TNa2WXeEM3ho0pa/OQLjuZfsNHTCHabjju0Kyu31tPVK2+R
	 upnREDJ2Wk7qeLcnJwWXYXB5vxHv5n6TDRSW9lWW4rBw1dSZrsjB5LHmnGCe46CWu3
	 iOtj3nJ7kghS2LWUPH5bO8f84VUPwjXtNBOiXUg+y1giOhYJ1aa0x3sJiuPs8K9+ra
	 C2SbXRfQTUa+Q==
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b593def09e3so2328062a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 07:38:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWs5NdfWpoKk7QPDwG5VcZVlKyV8y7evPwtC8qAUhjJMtkXOTtwIV53bO1CoW61fiFSZ07HtQvBkFdIPRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyiu0r1OKhGfz+Agda7jNbXGV84uRUkxlKiZjTgYUoY7jDCJX+i
	nXANsIRjmBaWcZOdjuTxhd05dHGU7oaQviWgeUOL07EuIcm/rk1avEvdIknxnp9Jewgs6OttI4x
	X2XlCaqV9m6yBHPrLk0sqRVpof6HVPQ==
X-Google-Smtp-Source: AGHT+IGVMak7HVgm2Kw7YYyD00KFk0fyKjURT+jhVGcUMpmtFlXzH6MEO5oeGDTKYtxCg8XT42xXcp+sjl4UzEP3ki0=
X-Received: by 2002:a17:903:1ce:b0:27e:ec72:f62 with SMTP id
 d9443c01a7336-2951a35eb36mr108901805ad.6.1762007883402; Sat, 01 Nov 2025
 07:38:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829091727.3745415-1-jason-jh.lin@mediatek.com> <20250829091727.3745415-3-jason-jh.lin@mediatek.com>
In-Reply-To: <20250829091727.3745415-3-jason-jh.lin@mediatek.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Sat, 1 Nov 2025 14:37:51 +0000
X-Gmail-Original-Message-ID: <CAAOTY_8inC0s+md84zyjqyrfvsd4Aruy=oVCVsZfhqkv6WPk4g@mail.gmail.com>
X-Gm-Features: AWmQ_bnMutOthr5nfHuj9QF2tM6tPBJ9JUU0hnLlgQDkMeGZ7OwmHz0IXIzXIxk
Message-ID: <CAAOTY_8inC0s+md84zyjqyrfvsd4Aruy=oVCVsZfhqkv6WPk4g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] drm/mediatek: Add pm_runtime support for GCE power control
To: Jason-JH Lin <jason-jh.lin@mediatek.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Nancy Lin <nancy.lin@mediatek.com>, 
	Singo Chang <singo.chang@mediatek.com>, Paul-PL Chen <paul-pl.chen@mediatek.com>, 
	Yongqiang Niu <yongqiang.niu@mediatek.com>, Zhenxing Qin <zhenxing.qin@mediatek.com>, 
	Xiandong Wang <xiandong.wang@mediatek.com>, Sirius Wang <sirius.wang@mediatek.com>, 
	Xavier Chang <xavier.chang@mediatek.com>, Jarried Lin <jarried.lin@mediatek.com>, 
	Fei Shao <fshao@chromium.org>, Chen-yu Tsai <wenst@chromium.org>, 
	Project_Global_Chrome_Upstream_Group@mediatek.com, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jason-JH Lin <jason-jh.lin@mediatek.com> =E6=96=BC 2025=E5=B9=B48=E6=9C=882=
9=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=889:17=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Call pm_runtime_resume_and_get() before accessing GCE hardware in
> mbox_send_message(), and invoke pm_runtime_put_autosuspend() in the
> cmdq callback to release the PM reference and start autosuspend for
> GCE. This ensures correct power management for the GCE device.

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Fixes: 8afe816b0c99 ("mailbox: mtk-cmdq-mailbox: Implement Runtime PM wit=
h autosuspend")
> Signed-off-by: Jason-JH Lin <jason-jh.lin@mediatek.com>
> ---

