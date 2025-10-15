Return-Path: <linux-kernel+bounces-854694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD59BDF233
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A077219A7492
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B07F2D4B77;
	Wed, 15 Oct 2025 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fh7X//6p"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031FA2D0C7B
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760539244; cv=none; b=slDYs3Q+nA6kdx2QkulAVQ9hpyBXh4C+V0+WBKQegirqHy5qw0ll8BM/UM621cE3V3g5ThiUxhRswVvZtLdmu7GhAVmY0xKMxbvo+KGvKes1bAPlxUiVW+06EAquQOUtlBFY3qAzlKvQuFZcfZ+frOknPtdUpcWn4ngBLUTiKmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760539244; c=relaxed/simple;
	bh=ikH5swHYBeBJPlbfJqsn6TfKPl7QDSsR29Hivq5uecM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WPgD81iSdV17emm26fGsC6+1GeBwIrS0f4mZOCOzFPHofRLzzdAk5ot7GN1F8GINRF7QH0iYywGjhpv1D3Cp5iyNemq12fPZsx4/IwUYMFnRvOwzkBe7FOKL68eIt6WZPI2UrGYRrpHnn9HNh19kfunbGTWZShKf+tvw/+Qv/Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fh7X//6p; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-637dbabdb32so13008963a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760539239; x=1761144039; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ioOXHAUeOWl9Cx98+VIOdE/MtzEd2iYjV+Axx4XR/9I=;
        b=fh7X//6px4cx/BxjhTyjOcBHvmX3CTwms4d2hTXie7gwxovA3/WVlRnyMcwBfgZmYb
         eQYDdqRGgTDDMIrL+Tfhhlq39zZeoWwBpWD4/wugmXzHzA+yhpF0UxqPgsP/gmZ1dBBq
         MKCKSWbHs1+bcUUA8Stp8CxLoY9vgpjT8KisEVeAVMsd7V1GmCFOEH/wh7asyxwY1FVT
         oK4edFHel/4r1chIOsfwzZKgSyRDbrH1wUm7f1XIlUeMIRpuLNDZrSgcaF4rBSltmqM8
         2mpSUTZ5sDRjsg5yu++Edfi6juAgc7aCKO2VN/Rex7LmOp9Eo3WW+cBCPtbNQalHnj24
         MZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539239; x=1761144039;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ioOXHAUeOWl9Cx98+VIOdE/MtzEd2iYjV+Axx4XR/9I=;
        b=dCw+wWpYXbNIuL67LloWDa8GuIqNU6nGK6BXTsgW+3Eqi2rW6ra9G2GrQEuA/OBdSE
         L9afTRs0i9851ZLkVk03aS21nICP3IDHWJHH171dvIZc0qharIU7TFKKiIWl1JMjPew8
         RLYSPxzFaT4ztM1yNQfo6qpT2toQ5lzNBF6lhZhExjMtcQMkQMgEcg5G1H/1LwQ5b2/U
         oRIr8VhnnMlO5Nsmp88aLr625ZyDH/xskWn7zJBfg3Pe3cPJ2Fu5/yv3wnv2IFmr3lls
         mG0nP41lwtsSAQ38Rvlk56oQErvwGJ6p8vIaqdNGuRpyLy2b3ebUOv3zGSkBXh6jzlaZ
         UjFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWommrh6GbYZjSxUm9Pf2ru3sGJqMJCf6BZms6pTWOmnXAtdho7SLH8yPAaLmn9xWIXEnvpEZDnAB4p2ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFCQgJxG+mAq33RTdJujpbXCMDW7oC10ppIcu4i8bX5Ln86d6h
	tPWRc2FdbpTG+9dygIhEk3cJ72RUGUVCjTZReFxqnIXrd4coNklG0FpbHMxDGGJGerCiqRRF7Yo
	v2NORsTIDSwwZMLRSwZ546zLkuQdKDaRKllcizqjLTQ==
X-Gm-Gg: ASbGncsgkz+ztcFRPc5z0WaoW4MY4ep6PtQ/9VOxx0db3MrwK3ELhmy+P32K3erI/Ra
	NWU5RT0vDZVMnBm6NdE+APgwDM4ttswXg/w1g2eD2U67RB0VbMIRsfxj6TFxGh7ESmHjtqEdOIi
	k8ubhQbHql1IqCe7gyrRg10c2GfCUiFOLRIpgf//JIiGPF3/XjCYVLlFVtAkDLJmKrijJYoB3Zy
	D0OF2wkFVF0+5YzewrYJMQgqLYoH37JDYGSqiJUskOm6oJ1AX3Hp7/c/WmaQg==
X-Google-Smtp-Source: AGHT+IE55tYwWLea5Z6cfLKt4Sgq0GP5juB5/AB0VrwbGmTvtf1jxrqrlQyzV6KgpTsqfhg8Yx84hzotM9p51deCCN8=
X-Received: by 2002:a17:907:7f17:b0:b04:2452:e267 with SMTP id
 a640c23a62f3a-b50ac9f8958mr3155639966b.56.1760539239137; Wed, 15 Oct 2025
 07:40:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
 <20251015-arm-psci-system_reset2-vendor-reboots-v16-2-b98aedaa23ee@oss.qualcomm.com>
In-Reply-To: <20251015-arm-psci-system_reset2-vendor-reboots-v16-2-b98aedaa23ee@oss.qualcomm.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 15 Oct 2025 16:40:28 +0200
X-Gm-Features: AS18NWCQoc3JRxuhuUVN2sHmwVBBVV2ODuQ3ysvtaltJn61MtT40Ld9OBIYCQNI
Message-ID: <CACMJSesvTLe28Jz83b=zfHD2rvmf7-i_2+2DoV=dgooVqFEYbA@mail.gmail.com>
Subject: Re: [PATCH v16 02/14] power: reset: reboot-mode: Add device tree
 node-based registration
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Souvik Chakravarty <Souvik.Chakravarty@arm.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Yan <andy.yan@rock-chips.com>, Mark Rutland <mark.rutland@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	Vinod Koul <vkoul@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Moritz Fischer <moritz.fischer@ettus.com>, John Stultz <john.stultz@linaro.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Stephen Boyd <swboyd@chromium.org>, 
	Andre Draszik <andre.draszik@linaro.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	Elliot Berman <quic_eberman@quicinc.com>, Srinivas Kandagatla <srini@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Oct 2025 at 06:38, Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> wrote:
>
> The reboot-mode driver does not have a strict requirement for
> device-based registration. It primarily uses the device's of_node
> to read mode-<cmd> properties and the device pointer for logging.
>
> Remove the dependency on struct device and introduce support for
> firmware node (fwnode) based registration. This enables drivers
> that are not associated with a struct device to leverage the
> reboot-mode framework.
>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  drivers/power/reset/reboot-mode.c | 45 +++++++++++++++++++++++++++++----------
>  include/linux/reboot-mode.h       |  3 ++-
>  2 files changed, 36 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
> index 8fc3e14638ea757c8dc3808c240ff569cbd74786..c8f71e6f661ae14eb72bdcb1f412cd05faee3dd9 100644
> --- a/drivers/power/reset/reboot-mode.c
> +++ b/drivers/power/reset/reboot-mode.c
> @@ -3,13 +3,17 @@
>   * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
>   */
>
> +#define pr_fmt(fmt)    "reboot-mode: " fmt
> +
>  #include <linux/device.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> +#include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/reboot.h>
>  #include <linux/reboot-mode.h>
> +#include <linux/slab.h>
>
>  #define PREFIX "mode-"
>
> @@ -69,17 +73,26 @@ static int reboot_mode_notify(struct notifier_block *this,
>  /**
>   * reboot_mode_register - register a reboot mode driver
>   * @reboot: reboot mode driver
> + * @fwnode: Firmware node with reboot-mode configuration
>   *
>   * Returns: 0 on success or a negative error code on failure.
>   */
> -int reboot_mode_register(struct reboot_mode_driver *reboot)
> +int reboot_mode_register(struct reboot_mode_driver *reboot, struct fwnode_handle *fwnode)
>  {
>         struct mode_info *info;
> +       struct mode_info *next;
> +       struct device_node *np;
>         struct property *prop;
> -       struct device_node *np = reboot->dev->of_node;
>         size_t len = strlen(PREFIX);
>         int ret;
>
> +       if (!fwnode)
> +               return -EINVAL;
> +
> +       np = to_of_node(fwnode);
> +       if (!np)
> +               return -EINVAL;
> +
>         INIT_LIST_HEAD(&reboot->head);
>
>         mutex_init(&reboot->rb_lock);
> @@ -89,28 +102,28 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
>                         if (strncmp(prop->name, PREFIX, len))
>                                 continue;
>
> -                       info = devm_kzalloc(reboot->dev, sizeof(*info), GFP_KERNEL);

This change is good - devres should not be used in subsystem library
code, only in drivers - but it doesn't seem to belong here, can you
please separate it out and make it backportable?

> +                       info = kzalloc(sizeof(*info), GFP_KERNEL);
>                         if (!info) {
>                                 ret = -ENOMEM;
>                                 goto error;
>                         }
>
>                         if (of_property_read_u32(np, prop->name, &info->magic)) {
> -                               dev_err(reboot->dev, "reboot mode %s without magic number\n",
> -                                       info->mode);
> -                               devm_kfree(reboot->dev, info);
> +                               pr_err("reboot mode %s without magic number\n", info->mode);
> +                               kfree(info);
>                                 continue;
>                         }
>
>                         info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
>                         if (!info->mode) {
>                                 ret =  -ENOMEM;
> +                               kfree(info);
>                                 goto error;
>                         } else if (info->mode[0] == '\0') {
>                                 kfree_const(info->mode);
> +                               kfree(info);
>                                 ret = -EINVAL;
> -                               dev_err(reboot->dev, "invalid mode name(%s): too short!\n",
> -                                       prop->name);
> +                               pr_err("invalid mode name(%s): too short!\n", prop->name);
>                                 goto error;
>                         }
>
> @@ -123,8 +136,11 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
>                 return 0;
>
>  error:
> -               list_for_each_entry(info, &reboot->head, list)
> +               list_for_each_entry_safe(info, next, &reboot->head, list) {
> +                       list_del(&info->list);

Same here, not deleting the entries currently seems like a bug? Do we
depend on the driver detach to clean up the resources on failure?

>                         kfree_const(info->mode);
> +                       kfree(info);
> +               }
>         }
>
>         return ret;
> @@ -138,12 +154,16 @@ EXPORT_SYMBOL_GPL(reboot_mode_register);
>  int reboot_mode_unregister(struct reboot_mode_driver *reboot)
>  {
>         struct mode_info *info;
> +       struct mode_info *next;
>
>         unregister_reboot_notifier(&reboot->reboot_notifier);
>
>         scoped_guard(mutex, &reboot->rb_lock) {
> -               list_for_each_entry(info, &reboot->head, list)
> +               list_for_each_entry_safe(info, next, &reboot->head, list) {
> +                       list_del(&info->list);
>                         kfree_const(info->mode);
> +                       kfree(info);
> +               }
>         }
>
>         return 0;
> @@ -168,11 +188,14 @@ int devm_reboot_mode_register(struct device *dev,
>         struct reboot_mode_driver **dr;
>         int rc;
>
> +       if (!reboot->dev || !reboot->dev->of_node)
> +               return -EINVAL;
> +
>         dr = devres_alloc(devm_reboot_mode_release, sizeof(*dr), GFP_KERNEL);
>         if (!dr)
>                 return -ENOMEM;
>
> -       rc = reboot_mode_register(reboot);
> +       rc = reboot_mode_register(reboot, of_fwnode_handle(reboot->dev->of_node));
>         if (rc) {
>                 devres_free(dr);
>                 return rc;
> diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
> index b73f80708197677db8dc2e43affc519782b7146e..7f05fd873e95ca8249bc167c21aa6b76faba7849 100644
> --- a/include/linux/reboot-mode.h
> +++ b/include/linux/reboot-mode.h
> @@ -2,6 +2,7 @@
>  #ifndef __REBOOT_MODE_H__
>  #define __REBOOT_MODE_H__
>
> +#include <linux/fwnode.h>
>  #include <linux/mutex.h>
>
>  struct reboot_mode_driver {
> @@ -13,7 +14,7 @@ struct reboot_mode_driver {
>         struct mutex rb_lock;
>  };
>
> -int reboot_mode_register(struct reboot_mode_driver *reboot);
> +int reboot_mode_register(struct reboot_mode_driver *reboot, struct fwnode_handle *fwnode);
>  int reboot_mode_unregister(struct reboot_mode_driver *reboot);
>  int devm_reboot_mode_register(struct device *dev,
>                               struct reboot_mode_driver *reboot);
>
> --
> 2.34.1
>

Bartosz

