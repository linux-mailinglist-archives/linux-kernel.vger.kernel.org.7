Return-Path: <linux-kernel+bounces-896897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A02C518ED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A5342791B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C4F2727E6;
	Wed, 12 Nov 2025 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JefUen9Q"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC83256C87
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940779; cv=none; b=U/gNeOcl6T5WefShaXGbW0zoaCKteUC+6SQ0bvHNzQLEh8JU0roXb3TVrMUX9+MMtniUBJGDMahCuIRLDMGJdC7+yvx+HRVEUqJdrMOeyp9S6yBjtNt4Q1wDcdD+vznujKuitleiJ4iJzPN8ue+Z2khvbwJVv7s6nYRX2LzxM7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940779; c=relaxed/simple;
	bh=8vIallErldatIIpknUDD1YI8XXkWsYygZikQLjNWeao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJHIL8x9eqMVhjF8lEXIgRitl2TKvww9gp3ZpWacMUNR77bnIiVE9VNAs8CXKJ7n1xr1WQN0FAJT6IOZTOWh0XmNh/G90+Tzx2nfU6UD2MKR7j5IETRoOAkrj+250JfMjXDOeo+bZVdyo5kpyqfYLzxER1iW/wmKomcPC8F/TOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JefUen9Q; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5943d1d6442so596833e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762940776; x=1763545576; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W1/V2YXbuYAodqpAgnmEeCbBkEOrsNuONxmEzzkkrd8=;
        b=JefUen9QODpVL/8O3yGSFlUyI9DfrgIaGnfSxcoKurnfiKGrjeU9Jd5v/m/rp3Uszf
         layIlzUtL5702Vh3oxPsAwmy0ZSImA6j7xCRr66eqKvM1/qpCo/OKmVO9tKsg2mA5Y/G
         bJb2NLdTN3xNq124T02AldfYAlj9iJZ1m/imkOURugKiE2SLNTob0+OrAyuobP49tmYd
         y4d6wgIb4s5LjufVsQN6WNi0GjIAxAHbD7ZVh13idTDE/Iw0cggqIvykDq1TOoL+VUwH
         98epzg51UmqHOH6n1Iom90AtDNmBXCRLndjI2RXV0F7oxYA1Mr78QETf/WMGZDwHbxG4
         OcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762940776; x=1763545576;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1/V2YXbuYAodqpAgnmEeCbBkEOrsNuONxmEzzkkrd8=;
        b=sLGxqByQoSZPuIaPrGj3v3EuL6wxEzecg0pzLD3np9kAnOov5bYZjv5ESLvB7JAH3s
         S0cf6AmpRNFSgCH5bUHLeg3DmdEWDpVtpw3mY6z2I6x8PvcZ6DcofRFgAFt6MJbIjnw7
         8tJUqHjHl3ueABxCdNvB8kxWBP+3MJvalE6+wsjMlf+8qfHV2jjum5JByeh5XDBRRxk+
         FcrLSGO559fZLQON5Ph+msjkWMK3bflLmzCiLrrWhwAezGeegyJBLFt+V3pBKy7ltQwK
         nMuYSQ6iBfEIiBBp/tgHGQE3QSKb1Bee+ryxfHiYzDx5hmTnpDeByvv2uKWhKsD5vCvv
         XTqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCxIuozbUlUYd3TadDr7dDtev62A/MoOJpHOpa4fc/XrJGkGFHmivCYJSJ/VOHl0Vvn++Qjtv3VCODu5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgzaB+HCc49KnUaByXxOoqogAVwrjF/w2BILqnD+eciAkYu2I4
	QPHYV4MGUQ0E6jc4gp6a5fAb6jsZTxr66t9bs68MlZtPl5q5SXxDi+3q9faQvW2335Ye9hfKpXA
	4VnglmulH8umbyt2rvanu8D539BreI8VPV1hB0zTuBLeOr6g+JdXp1nGquZfz
X-Gm-Gg: ASbGnctdxVvRjCukV2M17cTaHifnyxnnMv9Me6SY+up8tsUPlJLywG9Cn/MkgrF1mZK
	2h+Tg1D6SJzsrxTyCshsct0usqu/SBBJq2UHPmlorUgf0CMouOBnQU86U8Pfb8rUCQ9De5rpouT
	VJ0ZnEy7QJqS9QJ1mV89ALsaLilf1y5qsBDVcNVddDVs8b3u25Jr6hgx4bbBqJ0wcJDwVO4ahvO
	73gmEbaEv2U3e50aGGtbuvwb9H+6rcGFzlGXiUSp5UfnUEoThaA0eZbmhW+yAlcjQ==
X-Google-Smtp-Source: AGHT+IGD0G7XdFEc9kkI3XD2txQlDGCmedxcVcwXw73sg3bdIvO7yH1fEFrr96nDac9g/9uQLIFNTD0QRwWxluV5d5k=
X-Received: by 2002:a05:6512:3d26:b0:592:fbb6:889f with SMTP id
 2adb3069b0e04-59576df4c10mr718458e87.20.1762940775516; Wed, 12 Nov 2025
 01:46:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111093536.3729-1-huangchenghai2@huawei.com> <20251111093536.3729-2-huangchenghai2@huawei.com>
In-Reply-To: <20251111093536.3729-2-huangchenghai2@huawei.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 12 Nov 2025 17:46:04 +0800
X-Gm-Features: AWmQ_bl1OCDE9RgLreec6kT78RkCRNfxq026i6JXnizuf1fqPFKGTb00tE_OArM
Message-ID: <CABQgh9GeqxyBPwe-posbstbGy2RBQdfGGBR27tr6+S+5dYzBDQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] uacce: fix cdev handling in register and remove paths
To: Chenghai Huang <huangchenghai2@huawei.com>
Cc: gregkh@linuxfoundation.org, wangzhou1@hisilicon.com, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	fanghao11@huawei.com, shenyang39@huawei.com, liulongfang@huawei.com, 
	qianweili@huawei.com, linwenkai6@hisilicon.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Nov 2025 at 17:35, Chenghai Huang <huangchenghai2@huawei.com> wrote:
>
> From: Wenkai Lin <linwenkai6@hisilicon.com>
>
> This patch addresses a potential issue in the uacce driver where the
> cdev was not properly managed during error handling and cleanup paths.
Can we clarify that it was caused by cdev_device_add?

>
> Changes made:
> 1. In uacce_register(), store the return value of cdev_device_add()
>    and clear the cdev owner as a flag if registration fails.
> 2. In uacce_remove(), add additional check for cdev owner before
>    calling cdev_device_del() to prevent potential issues.
>
> Fixes: 015d239ac014 ("uacce: add uacce driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wenkai Lin <linwenkai6@hisilicon.com>
> Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
> ---
>  drivers/misc/uacce/uacce.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> index 42e7d2a2a90c..688050c35d88 100644
> --- a/drivers/misc/uacce/uacce.c
> +++ b/drivers/misc/uacce/uacce.c
> @@ -519,6 +519,8 @@ EXPORT_SYMBOL_GPL(uacce_alloc);
>   */
>  int uacce_register(struct uacce_device *uacce)
>  {
> +       int ret;
> +
>         if (!uacce)
>                 return -ENODEV;
>
> @@ -529,7 +531,11 @@ int uacce_register(struct uacce_device *uacce)
>         uacce->cdev->ops = &uacce_fops;
>         uacce->cdev->owner = THIS_MODULE;
>
> -       return cdev_device_add(uacce->cdev, &uacce->dev);
> +       ret = cdev_device_add(uacce->cdev, &uacce->dev);
> +       if (ret)
> +               uacce->cdev->owner = NULL;
If uacce is build in, THIS_MODULE = 0.


how about this, handle cdev_device_add fail for no device_add case.

+       if (ret) {
+               if (!device_is_registered(&uacce->dev)) {
+                       cdev_del(uacce->cdev);
+                       uacce->cdev = NULL;
+               }
+       }



> +
> +       return ret;
>  }
>  EXPORT_SYMBOL_GPL(uacce_register);
>
> @@ -568,7 +574,7 @@ void uacce_remove(struct uacce_device *uacce)
>                 unmap_mapping_range(q->mapping, 0, 0, 1);
>         }
>
> -       if (uacce->cdev)
> +       if (uacce->cdev && uacce->cdev->owner)
>                 cdev_device_del(uacce->cdev, &uacce->dev);
is there an potential issue, uacce->cdev is not freed?

Thanks

