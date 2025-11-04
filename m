Return-Path: <linux-kernel+bounces-885139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E026C32185
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E19C3BFF26
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65071333458;
	Tue,  4 Nov 2025 16:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dgukZ9Wt"
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8633D561
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 16:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762274069; cv=none; b=B6l90PcZVDqrAQemTbkKRc0D4+W895/r6k6Bx8iB7SnOdqH+Nzt9GV2206IPgyq01ekJ1KirL+EXO7mmaxaENSoauLUUTwbaOlayqY70jzb5+jBuOEsykgRqbhUCk45ilwd56qLV4/A6wXFZev702jImoLV/mDNIdd+aJclBKH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762274069; c=relaxed/simple;
	bh=K0YyegNjV3CrpjVAJkKYS2lK+2AdnL3qhw0eEMQppNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MT0+s8qsmcy1FbAnYmJsBtGwChwV29DMQM5iXXfndMvaUaIxtIProCYfmvLh3jtD7qul2SAWMtiFrPNM7yJJ99IsTfVS/BmSs48iF5YlWqf/34cTcVwPG4llOE0xfwYCrCbQo59bnjI/AyrbSm0TrCEfn4v7TVSK2lEXRCy0VIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dgukZ9Wt; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-63e16fbdd50so4977750d50.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 08:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762274067; x=1762878867; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZURaLbDo3dwoVqwyM02ToCv5MutkNZmPeTZy84rbNEQ=;
        b=dgukZ9WtimTXIEowesZB5thCKlLVP3GbkE05sE4lrkuNRASQOoqFXPl71pfCBbaHAN
         6LC91WExLd++ugRZJCUyLBCULNIVgHKqNaCibUjCS5EvvdGacpMxLrmztnEYWT2i+NV5
         fS4iha/okSN/8/h0t76wL+nQmi5gqZQ65ICFZD/fF+2r0bZ0dZe6OkjlSZjh83k75eOY
         46CnfYCYK0iK+XOI91eMD6UkFHWCsSlV2id7oRjBRuifD6n6KHhF9AfOS1GQV/Jsg4Cw
         E56r43rMCDPwAGlHyAMJ7F7E/s07Z2NWqVQTYOmhUwwVTn4MpSq2U/7QYmA4AXYDxVnj
         slIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762274067; x=1762878867;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZURaLbDo3dwoVqwyM02ToCv5MutkNZmPeTZy84rbNEQ=;
        b=FLHoN/Stv/xVjzWkXod8eVcm1ZcLIxP9hRwoH1bnXakD+DgPmg1q1h6OdQHIJz/Vf/
         u3uc6f+3Y67w3iKRHTTX1sA+PFAucHpP/3Xu8XUtggL2nmq16eKEWmGy5s234H2tCRsc
         MvGPE4h/Ld+8Ww7c1fe63rqJ5sYYR4iwtMKkR4lmV/7sLy0ZvvNy92lbif6XbfuDxy35
         AQLCuSfdKrVwwPaa3Hp69y7S72S0hcraqIRU8r1YVPpWNJp831QFI+shjURt4s6BvlsP
         8ivff2Ctrsgjk16F8pr4//I3lID+qVf9WIfPpctBpXGgYmU6CaTRLNYMKQqz5oywfvnH
         duUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqUZ/hp03KOESrveFrpDZzAUsOO774YdLo3c7024q2dbA0LVlc3lTY05mdnL7Z0YEpZP+MVArHUzlP28E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlXzS2S3HzM4OXh/IXXdtYgCyAFZbnkkH0avh3O6IOb0nIGWkc
	6W892zZU5A/z5M4uGhnXfrNkOB3WW222GEW8CLxPq4/9x4z0nYttUsuUXovRlqHaNeO4qP4Z4oa
	8SHUXwejlqr7hamGMgmnyKWmnsGgB28GqgUIwj+mipg==
X-Gm-Gg: ASbGncuDWkxtjRvl+lgqUcLCvn2QYsmSG3aynCrPWIIAv14OBkqKpYvAA2qq7Nl6yG9
	yZLs/LNs8AtT0/o2EsKVZZi3fpvCyaYumsIj9TTTtePYetXnPU89B+zxf9ND9qxF4T4uCuJGmMB
	cAgjXFLzs20WOBHM8vdbb8rs9Vv06EYS7DCuKKBuRyBPgZNiy431tFzuLkQ8ptWqDyacYvKuChe
	pq8PtCY7pO0ZgIG2esk7+NioYd17UNus053IkW9WoOei8iwj0ScDHWgRpJ/jw==
X-Google-Smtp-Source: AGHT+IGVTYPjRbvY2dc+1i1hVKSl6/mUpbt8rBD57n2a05T5582PeM1IiJduGFBi48QQYI8y525MVnCW3dK3LdtTGiE=
X-Received: by 2002:a05:690e:419b:b0:63f:c10e:6401 with SMTP id
 956f58d0204a3-63fd358fe2bmr57363d50.59.1762274067017; Tue, 04 Nov 2025
 08:34:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030-mfg-mailbox-dep-v1-1-8a8c591aff27@collabora.com>
In-Reply-To: <20251030-mfg-mailbox-dep-v1-1-8a8c591aff27@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 4 Nov 2025 17:33:50 +0100
X-Gm-Features: AWmQ_blVz8oV6Q800iTY_FXK63-gujrHnWpwcZPlwshpI-BtZsgfevwVde_Zipk
Message-ID: <CAPDyKFrJdN_6FyyjMrfNCKwXt6kFPEPAxcuosdasoxtbJHk2GA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: mediatek: mtk-mfg: select MAILBOX in Kconfig
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, kernel@collabora.com, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Oct 2025 at 14:17, Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> The mtk-mfg pmdomain driver calls common mailbox framework functions. If
> the common mailbox framework is not selected in the kernel's
> configuration, the build runs into a linker error, as the symbols are
> absent.
>
> The hardware mailbox Kconfig system, MAILBOX, has no dependencies of its
> own. It's therefore safe to "select" it rather than use "depend on".
>
> Declare this "select" dependency in the Kconfig for the driver.
>
> Fixes: 1ff1f0db6aec ("pmdomain: mediatek: Add support for MFlexGraphics")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202510301311.TcOCnZ1s-lkp@intel.com/
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> I assume this can be squashed into the mtk-mfg driver addition commit of
> the maintainer that merged it.
> ---
>  drivers/pmdomain/mediatek/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pmdomain/mediatek/Kconfig b/drivers/pmdomain/mediatek/Kconfig
> index b06aaa9690f0..8923e6516441 100644
> --- a/drivers/pmdomain/mediatek/Kconfig
> +++ b/drivers/pmdomain/mediatek/Kconfig
> @@ -32,6 +32,7 @@ config MTK_MFG_PM_DOMAIN
>         depends on PM
>         depends on OF
>         depends on COMMON_CLK
> +       select MAILBOX
>         select PM_GENERIC_DOMAINS
>         imply MTK_GPUEB_MBOX
>         help
>
> ---
> base-commit: d78b0fee454c25d292fb6343253eca06d7634fd9
> change-id: 20251030-mfg-mailbox-dep-ec32ef510e6a
>
> Best regards,
> --
> Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>

