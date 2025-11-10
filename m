Return-Path: <linux-kernel+bounces-892386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B977C44FFB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 06:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5967188DCF8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 05:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377572E6CBB;
	Mon, 10 Nov 2025 05:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRrQ4ig1"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B36119F13F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762752162; cv=none; b=NXXYs5Ykff4x/0wB54tlzlJyjhWSi5TVhKrVHAYfv9xiwygRsMc1QQZ3G1YKKbOwybLHxYBNQiSlfHcPOCkvvxt9dz+gHIHGa3RKfsJfvUW03/Gl7+ba3zCV0yyDdINggVxUKIdVNLa2iy3S5CuNUbCTMyZvToW9+n8mY4c/HLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762752162; c=relaxed/simple;
	bh=6MAGRIH5WEH+fMjOR2/tlElu/d29Oz7xmVfA9gjEHmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JXpPN91iVFw24GivrvtGSpqVJS3Jw7prXgIFEURCpFtpMa/4411b1eI+X/HDWwr0GCQF+BjCMCEpOp+ghwX0BQw2F4PLocOEhpHsugx1YGdbW23YwYSSoWHy3rsZB597QpdBv16Lc6L96T9ThLUgKLfYXAaV263AviWPp9CrsDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRrQ4ig1; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5dd8988d098so895280137.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 21:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762752159; x=1763356959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVbcQdsxhGJ251GekmogRgMgrAHB7EALgaSbuq0BgLg=;
        b=FRrQ4ig1rWd6k5szKlAfhB5MZL+nttmAtvfziX8ItT+kZBqh9ZLoVGwmU8Aa6QcurK
         l7aYV2SDGrZLQiLCxtZAQVFTc7vPXFooxjflIxjMLKRgsvw6xrnMJ5rJXIVuIPoFqyUm
         9bXmMZsLP50+HHMBI3EeELTZXeOlZ8NvXouItYt0ay5c0l+eTs5EhYebzbap1c74H9bQ
         CvZBKfcPpwa/4Xkrp4qRWj/soJojbz4ORSa4dUWHhiOi2mJBrgi9zWraQCr3FBoQ0SFD
         SR2cHtzF6JC00RKnTYo9H6rklOmnf3LTHPmfAalgx0jwvLt2GmwvK4MPiV3z1R6pig0N
         SrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762752159; x=1763356959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tVbcQdsxhGJ251GekmogRgMgrAHB7EALgaSbuq0BgLg=;
        b=q8fmSZp9oDf0TALZYtAdHKJPnpwCYjhGhfMoHKbDiO2+IuKsNXLpaQCSrY+2pKDFob
         i4MWELvajpx6nrFg994AQxjaNkVELQCw0wZ9al1IZtnNK7XrIb/KuZ8MA4kcEdufRDss
         sK1bARH74jmx+3h54kfoTEDXXanJsQiuo+MSsrPnhVKPZT7svSpks4L7/URacekABgXY
         VAFAHGgHRTAgNc5blSlUTCl8V3+4Rio2BqR4b5rNgkTMQfSkw/i9MYeAaEb9+LxRRhfP
         4pEVXZN2YcZ7r5flONYUTtbMDxjOmbKkdipP/qMGX9N5TvcyGPR5P3br6dS4VUehIEUE
         bsbg==
X-Forwarded-Encrypted: i=1; AJvYcCW0p7KlXcfmUJma86gR0vliy2woKOucIguL7qOovW9jO4zwziWkkhzdsKBz62gMRcjjPL6QG3M8TlMbU1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGTneK8kyFztzg7eaPvt5D8Mi8OP/MsvdeI3J3IEzU4ckgdH+a
	JKD8VrjLueS71qfE8jRj+fXTUEIoZ4WjeJpeHcVFo7mD54ybKQVBGiGalDKG75lFXl9BDgB6ulZ
	SPuK5BAA0Bs670zsr2L3ql97EzWcHej8=
X-Gm-Gg: ASbGncsLEuwbDR9xTNSyW18qhbsus/VcqCN7iOONcQDAxC/55nQuM/AbkocCPQuMqKD
	AJDoigE/LuM5M3KgrUAcMFsRWpvrflhL1zBwsQAwL8QXmHvwXrxiFs5WlaqC7jwuZhUkKjElFCW
	tz39qKDE3zNq8XwIboSO+ca6H7TuY6O8M3+PHNwpPlxZtUb1ct1Fc3e35WvReu1kfga5qgUlo/6
	vdsELWyu59kjEKclOdA+tf52Ud50b+PI7tRHwpcrKQwlnEkdPvdqTk0f+4=
X-Google-Smtp-Source: AGHT+IEeFVULUntPJGmAB60bMxKjcERl9eTW1jbOHV8XuGq9ZMrcrkcUimjG5F2o26/OwntJmcCh8HHKGulh3BYrYP4=
X-Received: by 2002:a05:6102:390f:b0:5dd:8c81:d7ab with SMTP id
 ada2fe7eead31-5ddc452d062mr2218860137.0.1762752159000; Sun, 09 Nov 2025
 21:22:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250929042917epcas2p2569e213500997dfa6ba43c8f361f50f7@epcas2p2.samsung.com>
 <20250929043110.3631025-1-hy_fifty.lee@samsung.com> <20250929043110.3631025-3-hy_fifty.lee@samsung.com>
In-Reply-To: <20250929043110.3631025-3-hy_fifty.lee@samsung.com>
From: Inki Dae <daeinki@gmail.com>
Date: Mon, 10 Nov 2025 14:22:01 +0900
X-Gm-Features: AWmQ_bnqaqpr6mbii-XcWKvzW_ttKXH-Eb8J1UjIIWLeqzt5jQH_vRs30wQTWl8
Message-ID: <CAAQKjZNCpK4rq6DFUtiQ2rxCeb_34Mp54quVto+9LRJMH3=ZhQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/exynos: Convert to drmm_mode_config_init() and
 drop manual cleanup
To: Hoyoung Lee <hy_fifty.lee@samsung.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2025=EB=85=84 9=EC=9B=94 29=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 1:54, H=
oyoung Lee <hy_fifty.lee@samsung.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Switch mode-config initialization to drmm_mode_config_init() so that the
> lifetime is tied to drm_device. Remove explicit drm_mode_config_cleanup()
> from error and unbind paths since cleanup is now managed by DRM.
>
> No functional change intended.
>
> Signed-off-by: Hoyoung Lee <hy_fifty.lee@samsung.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_drv.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/ex=
ynos/exynos_drm_drv.c
> index 6cc7bf77bcac..1aea71778ab1 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
> @@ -257,7 +257,7 @@ static int exynos_drm_bind(struct device *dev)
>         dev_set_drvdata(dev, drm);
>         drm->dev_private =3D (void *)private;
>
> -       drm_mode_config_init(drm);
> +       drmm_mode_config_init(drm);
>
>         exynos_drm_mode_config_init(drm);
>
> @@ -297,7 +297,6 @@ static int exynos_drm_bind(struct device *dev)
>  err_unbind_all:
>         component_unbind_all(drm->dev, drm);
>  err_mode_config_cleanup:
> -       drm_mode_config_cleanup(drm);

In the current implementation, there is a potential dereference issue
because the private object may be freed before to_dma_dev(dev) is
called.
When drmm_mode_config_init() is invoked, it registers
drm_mode_config_cleanup() as a managed action. This means that the
cleanup function will be automatically executed later when
drm_dev_put() is called.

The problem arises when drm_dev_put() is called without explicitly
invoking drm_mode_config_cleanup() first, as in the original code. In
that case, the managed cleanup is performed later, which allows
to_dma_dev(dev) to be called after the private object has already been
released.

For reference, the following sequence may occur internally when
drm_mode_config_cleanup() is executed:
1. drm_mode_config_cleanup() is called.
2. During the cleanup of FBs, planes, CRTCs, encoders, and connectors,
framebuffers or GEM objects may be released.
3. At this point, Exynos-specific code could invoke to_dma_dev(dev).

Therefore, the private object must remain valid until
drm_mode_config_cleanup() completes.
It would be safer to adjust the code so that kfree(private) is
performed after drm_dev_put(drm) to ensure the private data remains
available during cleanup.

Thanks,
Inki Dae

>         exynos_drm_cleanup_dma(drm);
>         kfree(private);
>         dev_set_drvdata(dev, NULL);
> @@ -317,7 +316,6 @@ static void exynos_drm_unbind(struct device *dev)
>         drm_atomic_helper_shutdown(drm);
>
>         component_unbind_all(drm->dev, drm);
> -       drm_mode_config_cleanup(drm);

Ditto.

>         exynos_drm_cleanup_dma(drm);
>
>         kfree(drm->dev_private);
> --
> 2.34.1
>
>

