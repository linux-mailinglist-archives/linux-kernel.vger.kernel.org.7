Return-Path: <linux-kernel+bounces-736871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D935B0A46D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA1A4A4565F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AF9CA4B;
	Fri, 18 Jul 2025 12:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QL5c7FMo"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED64172610
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 12:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752842866; cv=none; b=pFEZqVrLW5ouiaI9bwALqMfdCwXA3COJhaRjlJ5EMGYd+yvmnL6/07S2Cos7PHd/Is3m7SU4CtPIC4o94HJVCtVeLu9ItmppJJoKCIKZbJRP1bYhYJLrvAh0AVEFJlR+6MZnH+xwNeSai1uJrMgdZhxk7QICsj8H5lsHIkNGkts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752842866; c=relaxed/simple;
	bh=s04Gar8iaD2QraUQUxwoiSLaIB05kvgte6K37xqltbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KnnsiNKVqjwixLwHxhLQTOpP+QWbuUb2KyqNN7ccGn6SrVOojATY3eUD1C7XRfIcZXtETVOCOmd0k9zYpBlvaVNivykY6y+29yeYIKK7kmy8TN5vG+W0GW/xw17qxBFLOROgKsd09UUiV6C2WXzV24ueSoHCNWvXF4ejbTSXKfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QL5c7FMo; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-749248d06faso1812087b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 05:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752842863; x=1753447663; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QeRQlyAUR3PqW+g2eLdPPpZ5mVhOZm45aebnnXmKoiE=;
        b=QL5c7FMoFSaxDWPyHCOj8IGVRJSYmBve6nKxNQUhbtlyKxPFBlb0lceN2EC3IUvNQG
         NXpp94SvkZbnk5z2dm1u8AV4XREYG/UNn+E/ijRbDzB+EPspr4dtXlSuCXtd7CcCSq6o
         7L+gUfvclKLcwfrNiD+eZDRf9JR9gGiGxP6Cmf1uU7LQ8xAF6JR9jUZ7LpQknIfTAcFi
         3YbaIljksPknHsTrNz3dSCxu67wAZXqnfgaK+3PJbDv9idGL12wTv5n3CSxqeIMLpSrr
         18DMjtFwcTTe2R4ssj34il95PlyyiRx86KVjQAOBrLgz6+aQuWnL6bGhauYjrpQLIRZ4
         pi4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752842863; x=1753447663;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QeRQlyAUR3PqW+g2eLdPPpZ5mVhOZm45aebnnXmKoiE=;
        b=CY1EIt4zi+art24NDrDLMvteO0B67XmjdK64oyaUY8GHvog6nTvN1bDxDiq9EOUWci
         kNhK+zVl7YtIPTSyR0UGLng1TeIBUSlQbsGCDkikch/EuNHjVMEsaDdq6Vdh4oioI0Bi
         P5MqEH4hUKMD1MRXK9Ni7fAnXvQA9GHhgC9rwQM6PLCWuamm61vyjo08baQQh+6FWi+Y
         xvcHQ5gW4ak/aCLL4PjD58X5WR5KlkGt8W0F3Qj+AdcfkGDiuYTU8Ew3GlzljzhiIxIh
         ig1Nl0g+8NbK9tcHGVY85XWWoQ9/612gbRkdkCKIVgPRqa47ichGxhDROO4MTWVKKkOV
         p8ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzSP6U2X6WzhAWq7PfKzaLd+AK3+UVT+t6EGboezERN+JO/LrAGrMvmkgs3l8zlWw84xlOBqhF/TH+OIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBkG6gqfQEPM68J6hbEPmr+qDfrlG8Y3ZtmJUxQo6ykyyEICqf
	TE/sVBrW8+CINsMJDYao2fFWSJEit1+zDUrx6/imLAWt2SGkFklU8RLpphWi+CHHD676iBGVdrY
	0dNIrIoVO5afGkbadXtV6nB4P7DcRPDqBxm3HKO2YYg==
X-Gm-Gg: ASbGnctGwcxoLp7DmDi6yJ2/SzgXcsCss1knXDujhGDuS3VZxGK2rH58qedjXT4xjlm
	04vjkY5Ix/xcy1Lfnmo64tV+FZ1vN2OwmNGhxAVvo9Un9Cmt/K3JJUUUP2X3VDlRQ+fzU2LDRHj
	wv8BZHUoDCkoKCsvy7M/KdHoNyy2EV5IZy4WP9aT5jJ7PBYAZDmkF1ok8cv/nYsvFFCA0yksQAR
	hqRkp6R
X-Google-Smtp-Source: AGHT+IEMc7UZ/KYJa/a3DfDdOy24w8KU+Grmwp7vVtNPwtQHk7nDpLvJRl2+7eiSzAbsGuJXlmMDrfna6kz153iEkMo=
X-Received: by 2002:a05:6a20:9389:b0:234:e900:4fb7 with SMTP id
 adf61e73a8af0-2390dc2f767mr10317148637.24.1752842863244; Fri, 18 Jul 2025
 05:47:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7bd9fae8-a15f-412a-8800-ce47acf0b5ce@sabinyo.mountain>
In-Reply-To: <7bd9fae8-a15f-412a-8800-ce47acf0b5ce@sabinyo.mountain>
From: Mike Leach <mike.leach@linaro.org>
Date: Fri, 18 Jul 2025 13:47:31 +0100
X-Gm-Features: Ac12FXwpsQaG8cu8OC5sYhhmw0Xl3b3O3C7eTtu5iWVgpjaqHzEUSGMRFw2z9oM
Message-ID: <CAJ9a7VjykdwBd3_Mh88U_Mqpqsi6aNFeeMS_wMsLE7EV4n_iMA@mail.gmail.com>
Subject: Re: [PATCH next] coresight: Fix a NULL vs IS_ERR() bug in probe
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Yuanfang Zhang <quic_yuanfang@quicinc.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	James Clark <james.clark@linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Leo Yan <leo.yan@arm.com>, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Jul 2025 at 20:38, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> The devm_ioremap_resource() function returns error pointers on error.
> It never returns NULL.  Update the error checking to match.
>
> Fixes: 26e20622a8ae ("coresight: add coresight Trace Network On Chip driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-tnoc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tnoc.c b/drivers/hwtracing/coresight/coresight-tnoc.c
> index 0e4164707eea..d542df46ea39 100644
> --- a/drivers/hwtracing/coresight/coresight-tnoc.c
> +++ b/drivers/hwtracing/coresight/coresight-tnoc.c
> @@ -183,8 +183,8 @@ static int trace_noc_probe(struct amba_device *adev, const struct amba_id *id)
>         dev_set_drvdata(dev, drvdata);
>
>         drvdata->base = devm_ioremap_resource(dev, &adev->res);
> -       if (!drvdata->base)
> -               return -ENOMEM;
> +       if (IS_ERR(drvdata->base))
> +               return PTR_ERR(drvdata->base);
>
>         spin_lock_init(&drvdata->spinlock);
>
> --
> 2.47.2
>
Reviewed-by: Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

