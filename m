Return-Path: <linux-kernel+bounces-865152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C0CBFC47D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1E7A18C6DF4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F79A346E79;
	Wed, 22 Oct 2025 13:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpM5qoeZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C43320CA2
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140883; cv=none; b=l5u4crg8MLdJlytDfnc58iZCk4NYzSz87e8wVxwQJLz3QtPALAF0jIjxgNHZbBAWpE83Z4OS+VKUKF7vNC5Rocizdy7qdcLKDH7MOf/YbQ16RnEotRIktinJTNGb3MKwzymikdM+0o4CrpyW1+DT4X8MWpgqoiEBRMwEYi8dWvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140883; c=relaxed/simple;
	bh=jbBJWUa2D5mD4FO+YopVcu+7lzL7qETV1oQuE65ZYas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O9BNW7Nm+8XxDuITadn3FstdlpGj9F390lBiiR5pbOT35LYpF5O7NZBD04LOcvXpTML28NCOYn3P9s04ZfLbKS3x4uvQhEq5NQAJNNU0Ofr7pncPEbn5+5yjl1ER+JI0CgEE9BCO+uMVVbtfwX8CWLqxURN4vr4g9cFcA1XAqTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpM5qoeZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47AFC113D0
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761140882;
	bh=jbBJWUa2D5mD4FO+YopVcu+7lzL7qETV1oQuE65ZYas=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qpM5qoeZQsNoRwjYOFORTPLlO9z6w1lZ1UzSvTACk5t8ycXQNg+WYTa1AP5Kd9xd6
	 sSY2YiWIBNupKyFbn5isvNZ2sEssDpM1yhXdks3ikY0j7xSTxkFF6ANXSG6Yxw3OLk
	 BLIJYTcGTatl4bzmxF6GqI9i4kE5MfF0B7YKymkX/5CBk6p4elSqZgQMxyHaFFlfn4
	 sFCpsMsDoIvxg3CdtbF4AfLO3VSPKw9hVb3zAbDGM9vEhJG73Lm9GTKW5ksa90B2Qs
	 UD1PoP4R46adj+WaRYTRqlS1dDU+oURIdF9cF442fYZx2miNz6S9nL8U97nw4I7ELE
	 Kf/KtrvT+Sg3g==
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29226bc4bafso50031835ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:48:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVHBGGxhU7JZ6NVQyxME2sjHr1YGFqVUWKgvZv5jp66PwWMnKMY5z8KMSvG8tPIHyD3q/Ku8ao8oB30n/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyevraVZBEN2Qtibbb4CsLpXpmtDcnSjAIZLUkXjxmogrGBjstP
	T/emKsfwHNq1/Btf4kGoNOj6mlnp0z9s6QNAL3mBoSLM6gsCSQpj4xGMiCYERBemUvBZWoWyiVs
	Sh0lW2ar4rz0zvUfMIH+xXeL8x0rXpQ==
X-Google-Smtp-Source: AGHT+IFy1XRD8bUn3Ht+foWFb4onBy3I0BzeduV4i7PqazihqftsGN1m+bW8yLWYlxF6eUIqhNEGG1eW7HknFBsv3Jk=
X-Received: by 2002:a17:902:f552:b0:290:6b30:fb3 with SMTP id
 d9443c01a7336-290c9ca32eemr287339455ad.16.1761140882431; Wed, 22 Oct 2025
 06:48:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808-mediatek-drm-hdmi-v2-v10-0-21ea82eec1f6@collabora.com> <20250808-mediatek-drm-hdmi-v2-v10-4-21ea82eec1f6@collabora.com>
In-Reply-To: <20250808-mediatek-drm-hdmi-v2-v10-4-21ea82eec1f6@collabora.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Wed, 22 Oct 2025 13:47:50 +0000
X-Gmail-Original-Message-ID: <CAAOTY_8-W8XRsTFDKH69BRA=hurgZ2KOHeBDnixL-LgHObqhXQ@mail.gmail.com>
X-Gm-Features: AS18NWDLymwzfszmU7JKmhTu0CgDInQdk-IxVHYP20sloO1fgKFGR0uo2gWdNLY
Message-ID: <CAAOTY_8-W8XRsTFDKH69BRA=hurgZ2KOHeBDnixL-LgHObqhXQ@mail.gmail.com>
Subject: Re: [PATCH v10 04/10] drm/mediatek: mtk_hdmi: Split driver and add
 common probe function
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, CK Hu <ck.hu@mediatek.com>, 
	kernel@collabora.com, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Louis:

When I apply this patch, conflicts happen.
Please rebase this series base on latest kernel and resend these patches.

Regards,
Chun-Kuang.

Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com> =E6=96=BC 2025=E5=B9=
=B48=E6=9C=888=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8810:13=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com=
>
>
> In preparation for adding a new driver for the HDMI TX v2 IP,
> split out the functions that will be common between the already
> present mtk_hdmi (v1) driver and the new one.
>
> Since the probe flow for both drivers is 90% similar, add a common
> probe function that will be called from each driver's .probe()
> callback, avoiding lots of code duplication.
>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> ---
>  drivers/gpu/drm/mediatek/Kconfig           |  11 +-
>  drivers/gpu/drm/mediatek/Makefile          |   1 +
>  drivers/gpu/drm/mediatek/mtk_hdmi.c        | 539 +----------------------=
------
>  drivers/gpu/drm/mediatek/mtk_hdmi_common.c | 428 +++++++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_hdmi_common.h | 188 ++++++++++
>  5 files changed, 633 insertions(+), 534 deletions(-)
>

