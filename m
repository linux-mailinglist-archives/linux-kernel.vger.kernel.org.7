Return-Path: <linux-kernel+bounces-620041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC95EA9C545
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 12:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B0961889B71
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 10:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B5B23BCFF;
	Fri, 25 Apr 2025 10:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eUUMkiTT"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3DA23D290
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 10:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745576483; cv=none; b=OsQGZD1+aclHHaX2eIZl6p+IDWZzTL4/uhnk55co+ncV6fZUXzLWm3at424o2EI9wNz9VkbSyFtKrBL2YGDIAMxlcVpo5VLKEYNZBfeMd0W2EJlxWEdlLIFr99SoIxjeWGfHH+PW91fkaHrKXRQOQSrb36jEt7H9itGIf168OXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745576483; c=relaxed/simple;
	bh=5aRIMiRABy1PGTOKgctdnys84VTQ4AhqhUvl/MwXJMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=REzkqFfVPYuQ52wrxmGkuP5wAlnsG19DgLehMa3RmNqZ9evKUcIMx9dTY7s4ogxqQO/Cfr7EZUc+qGCjxgb7IanpyzO1izcydsHoGwDX5rIUeYsTAok56lMIx64yORjXN71KZGiPLbHhfwyTr8c7Zvh+ZgHS3BI86HXw12Ph5Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eUUMkiTT; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-707d3c12574so17730787b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 03:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745576480; x=1746181280; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2dy23SZTpPz/OtRsVa67VPlSbZbxd200TTdg7Zq9HNk=;
        b=eUUMkiTT/TJ72ObG/86gWFM8lydzff2WEWBNYCnp9i2KLqJSzd1XNyi4o8FPHIR1Z8
         TBoOmY0v8/aR+QTbvXqYDtNqZ9672nvlc87pm5kXASo3CVlE6jiSG0eprxUmtUdQP/Th
         SjBivRuzB5mSxsZqVeZKUd46M/yQm8sbgk09skKzlf5CJwWjrK8zXkDOw4gLR37Xf11q
         FTcBdQG0lLom1m31goeTJU9EJTLeCtrrkDa+kQch2y2WFXqEW/yl8OgDdxai4vI5qbAN
         8VR7Uzg1pJW0MzI3/RixThuZkSF7cledK6IdIUyInQAn0jDe8qgJDxaUCuJ6Eo/1/KDO
         IL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745576480; x=1746181280;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2dy23SZTpPz/OtRsVa67VPlSbZbxd200TTdg7Zq9HNk=;
        b=QIXqx/wijY3LvuPDuGPiGMCmMXOxA3tIfaBS4QqzleAGTebJ9UH+xInYVidJEzI7ra
         PaHn4RcjmrvCdlG3yu0S2Cd6SVw4miRkzIBLWttj0y8gkW+hKhW8S88eOdjm7XFrvtvr
         drxf306DvpOQtim7OP8LSG4UeqQLVBuxRkx/BNMq7/gXbKnUseTv1N3aRJFSdsuZ0lmQ
         BUeOkvsL8aexFreSuyrmXb/F9v66IMi+JIdHOsysOkMJKL2XTxj1f6OkXxyp3CW/+Qek
         kt5lnPwnVoYa6k+C0SeRkI3c5n2Bk6+O1oANotxWjnuQd2YXk7MExsaDLrRqfCySE1Eo
         +GqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXG/vNYXuk+ZzyTUtJbmQecG2tAEKCVRSjj25KZ0mUPTsql0pTXBUo7Tn0Nc7pELv1eVhnD6TT2wxBcwkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqn1xOLZDX494IGeuUzsVGkZTsnAHoF9iGVaxIKzthj+LPkWZJ
	ZNVXUsBmvRKcoW6krFfkV8ALeNfL/QSMs1lu1119pv7fWrxsKNcAhEVij4F5EWAsUJWeYeYAIMc
	6uvEUm7hOIvJLyrVMwLM5+0qOV3juJLr0D8npLg==
X-Gm-Gg: ASbGncvSlClM12elXUen3YXPUA0xDzRR1yq5A+qK2q+Gfhq5M37KFHiak0xcQcpART4
	/uzAxmr6Q0tgaZZ4w760sytZNn04K8pM/YC5F3GgxJXNvqnhtiYDpVBOly9criAN5OZt5rfqvYy
	id+efr4w72uCzfGYGHbOp0s3M=
X-Google-Smtp-Source: AGHT+IGCkeBYkL01Ob0/q+cYVVyOOQUT9d0JdZJ2RLVPcS+2b1wB0bERA+PHNQouav0l20rXKN6j1bHrWfsqVHaUuzI=
X-Received: by 2002:a05:690c:61c8:b0:705:6afe:4580 with SMTP id
 00721157ae682-708544de4demr18549377b3.19.1745576480517; Fri, 25 Apr 2025
 03:21:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421090951.395467-1-wenst@chromium.org>
In-Reply-To: <20250421090951.395467-1-wenst@chromium.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 25 Apr 2025 12:20:44 +0200
X-Gm-Features: ATxdqUFyawKWbJKKMCdA_eJxPR8YeUvlb5__azoGszdJwBU8e_s7VHYVEWsbp3g
Message-ID: <CAPDyKFroHJt7u6CzmPLnWv6rii4+adsFNDgoVqA-2AvN6S911g@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: mediatek: Add error messages for missing regmaps
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Apr 2025 at 11:09, Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> A recent change to the syscon regmap API caused the MediaTek power
> controller drivers to fail, as the required regmap could no longer be
> retrieved. The error did not have an accompanying message, making the
> failure less obvious. The aforementioned change has since been reverted.
>
> Add error messages to all the regmap retrievals, thereby making all
> error paths in scpsys_add_one_domain() have visible error messages.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/mediatek/mtk-pm-domains.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> index b866b006af69..22cdd34ed008 100644
> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> @@ -397,20 +397,26 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
>
>         pd->infracfg = syscon_regmap_lookup_by_phandle_optional(node, "mediatek,infracfg");
>         if (IS_ERR(pd->infracfg))
> -               return ERR_CAST(pd->infracfg);
> +               return dev_err_cast_probe(scpsys->dev, pd->infracfg,
> +                                         "%pOF: failed to get infracfg regmap\n",
> +                                         node);
>
>         smi_node = of_parse_phandle(node, "mediatek,smi", 0);
>         if (smi_node) {
>                 pd->smi = device_node_to_regmap(smi_node);
>                 of_node_put(smi_node);
>                 if (IS_ERR(pd->smi))
> -                       return ERR_CAST(pd->smi);
> +                       return dev_err_cast_probe(scpsys->dev, pd->smi,
> +                                                 "%pOF: failed to get SMI regmap\n",
> +                                                 node);
>         }
>
>         if (MTK_SCPD_CAPS(pd, MTK_SCPD_HAS_INFRA_NAO)) {
>                 pd->infracfg_nao = syscon_regmap_lookup_by_phandle(node, "mediatek,infracfg-nao");
>                 if (IS_ERR(pd->infracfg_nao))
> -                       return ERR_CAST(pd->infracfg_nao);
> +                       return dev_err_cast_probe(scpsys->dev, pd->infracfg_nao,
> +                                                 "%pOF: failed to get infracfg-nao regmap\n",
> +                                                 node);
>         } else {
>                 pd->infracfg_nao = NULL;
>         }
> --
> 2.49.0.805.g082f7c87e0-goog
>

