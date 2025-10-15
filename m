Return-Path: <linux-kernel+bounces-854674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD49BDF128
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8169819C2FB9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AA11EC01B;
	Wed, 15 Oct 2025 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I11VRqau"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D02247284
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760538737; cv=none; b=Ej7CO3kt9dh835FrKn+TEUDj2roMTeA4bdPF8mf1aUTsLBd+qga3oPeTonSru8NginSwcZ3Q+/MQyeibmWW33M8nCnOIaJ3GUOfGQA7hsDMSSXsYWVCxY/qequ3XIjEN5Ff7Qb20Qx+e9Pe5+Q2yZW9MXp+gdR+BVhE1j+JNlHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760538737; c=relaxed/simple;
	bh=zgjScSg8gxQVegmaLTY1qc+sG3oeDoXkbobmP8U+jSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ze4OiGLEaksZcnAyGUCvlLxDhxcrNiU/2o07G0VLo9VShsdYwKEBp9MRh6e7hiIpr2BdsbUNS0POGLZo+N66blVko5Qi0h3yXwHBGF8p3V0V//bhtidLDlfoDQ4/geAVXoxJahLpdtVl8ctFdXO8Do4Moyonid9bU/KMgrCOdLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I11VRqau; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b54f55a290cso944764966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760538732; x=1761143532; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/GGPPAy1fHT4f0hgkyN0lKffg2M7YAAILDfIXtiBKFM=;
        b=I11VRqauvz2Md9yzxVKhi/ql4GEIbHYh68mXiqzbEUpeacbu6x9biKT1X45i9OkPia
         WQP+kNhDx22Yq0SxvtFyyI2nUVjA9mQT4/lWSXkz4sm4DRIMPaXX1BpJcB5VJ4fWakhF
         k1pwi7zoOxyLLZY1nqGemhzvD3mdgVFoIP1MmFRBm2ePgnB+N8JGuaP3cWOOLPx8klwl
         as2Ox4LQQy02EuCw6nS6PFveJ8+a3SRAH1D4PY7EhA1Pu6Qy4iYxtYwUFmTyJYnzWpZq
         b86gi50olKDJzNmieFJjSC9YmCZ5IONirampH5uQMR4LOLiPYNv46ckKbVhL7FLa2j16
         QY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760538732; x=1761143532;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/GGPPAy1fHT4f0hgkyN0lKffg2M7YAAILDfIXtiBKFM=;
        b=abKBQNBr5Q/YRAXC12ADxyyiH3UzXEV538Jde6VFKx1xQLsyCoM7ETgZ5UO8xjExPd
         fHSSmDOSsnbHmKHlrgm14gjYi47VY/HWmA6MuWcXGVqprigw6+4Hu32fA0DjvfQiUbeW
         ozWj+jv32ggwB9JBCYahRN7yiTntD1PXq6B6MrOMa8uRb9LrEc1W4DqkgujjsatyzufL
         eihEVPpEj+BFZ6fV5s0ef8F8msD0H9bAPQk2jr+n6YiweuiNwGpE3GEdwNhbHPuI0/9S
         Ogo6ncwX/TPQ4pLojv1lbw+keG3WBjfewWwkAyMu/hbSYrS5FGz8qXyu0Od7Bmxqqo9U
         ZL9A==
X-Forwarded-Encrypted: i=1; AJvYcCXySckOQ2nxplCEUk5AMexw5Tm2x44jlN8KivYEdw2EppvnT8EjrWNz2VPNKzmJqfT7FO0rtukX8r5obA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YytZ7jIgZWZouocMXtbO5zqeq07tCbwB7ZIBntSKxqGEoN7VPXS
	U3bH2Ci84So2hGusujnFJTwM5c5h8rlUKpysA8/JWdqf5BIfZld0IhwwE7JFvzgMw12pWDBGm0V
	r9hfZu7luiBBaRM/ma1v/D8Jeyo4H6ZrVcjQWp7ME3w==
X-Gm-Gg: ASbGnctCw9lZMvXQAOKQ3daWL0JVFnqKE9de/RRVTZgJ07x9+L+NlKiByZdZDEUNE4+
	DiDiSDOaibbxtYNArbW0NyS91cq52ibWugsCuuHMhHKOmIK4pnTyAFCswQvM+GXvCq1LbSg4IWW
	iSI9rNHgLhQ27/LZMB7ndklHqbbhm70LGIQXlCPJCNn3JGwgSeHtjSpEtdqOREuJb6KGPws+2fA
	JQJe6ZqL1JUlytrL01hpHQhQ83TmKlbanB8GM6A6cca9QuoNc6b98J8ZUrPp5vn7OwfjZ2J
X-Google-Smtp-Source: AGHT+IGvbF9vBWEbG0yxHrHoIRF115LWGGkIrcNil1qvyPeGnU0jWQdwZ6i5CqfPgqW4PnBPT+plyU0IoAr45ong62E=
X-Received: by 2002:a17:907:9448:b0:b40:a71b:151f with SMTP id
 a640c23a62f3a-b50ac1c4e7cmr3318624966b.30.1760538732189; Wed, 15 Oct 2025
 07:32:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
 <20251015-arm-psci-system_reset2-vendor-reboots-v16-1-b98aedaa23ee@oss.qualcomm.com>
In-Reply-To: <20251015-arm-psci-system_reset2-vendor-reboots-v16-1-b98aedaa23ee@oss.qualcomm.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 15 Oct 2025 16:32:01 +0200
X-Gm-Features: AS18NWDYlSPyX3_l7fQSeSlc4Ni_BqTNtU4UYXiSbDcs8VqP7UVRqIDp11dg6gU
Message-ID: <CACMJSeu_Y2Rra8x22kWN0B38jKZEwq7=B9C75zH18QdjDHAWqg@mail.gmail.com>
Subject: Re: [PATCH v16 01/14] power: reset: reboot-mode: Synchronize list traversal
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
> List traversals must be synchronized to prevent race conditions
> and data corruption. The reboot-mode list is not protected by a
> lock currently, which can lead to concurrent access and race.
>
> Introduce a mutex lock to guard all operations on the reboot-mode
> list and ensure thread-safe access. The change prevents unsafe
> concurrent access on reboot-mode list.
>
> Fixes: 4fcd504edbf7 ("power: reset: add reboot mode driver")
> Fixes: ca3d2ea52314 ("power: reset: reboot-mode: better compatibility with DT (replace ' ,/')")
>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  drivers/power/reset/reboot-mode.c | 96 +++++++++++++++++++++------------------
>  include/linux/reboot-mode.h       |  4 ++
>  2 files changed, 57 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
> index fba53f638da04655e756b5f8b7d2d666d1379535..8fc3e14638ea757c8dc3808c240ff569cbd74786 100644
> --- a/drivers/power/reset/reboot-mode.c
> +++ b/drivers/power/reset/reboot-mode.c
> @@ -29,9 +29,11 @@ static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
>         if (!cmd)
>                 cmd = normal;
>
> -       list_for_each_entry(info, &reboot->head, list)
> -               if (!strcmp(info->mode, cmd))
> -                       return info->magic;
> +       scoped_guard(mutex, &reboot->rb_lock) {
> +               list_for_each_entry(info, &reboot->head, list)
> +                       if (!strcmp(info->mode, cmd))
> +                               return info->magic;
> +       }
>
>         /* try to match again, replacing characters impossible in DT */
>         if (strscpy(cmd_, cmd, sizeof(cmd_)) == -E2BIG)
> @@ -41,9 +43,11 @@ static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
>         strreplace(cmd_, ',', '-');
>         strreplace(cmd_, '/', '-');
>
> -       list_for_each_entry(info, &reboot->head, list)
> -               if (!strcmp(info->mode, cmd_))
> -                       return info->magic;
> +       scoped_guard(mutex, &reboot->rb_lock) {
> +               list_for_each_entry(info, &reboot->head, list)
> +                       if (!strcmp(info->mode, cmd_))
> +                               return info->magic;
> +       }
>
>         return 0;
>  }
> @@ -78,46 +82,50 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
>
>         INIT_LIST_HEAD(&reboot->head);
>
> -       for_each_property_of_node(np, prop) {
> -               if (strncmp(prop->name, PREFIX, len))
> -                       continue;
> -
> -               info = devm_kzalloc(reboot->dev, sizeof(*info), GFP_KERNEL);
> -               if (!info) {
> -                       ret = -ENOMEM;
> -                       goto error;
> -               }
> -
> -               if (of_property_read_u32(np, prop->name, &info->magic)) {
> -                       dev_err(reboot->dev, "reboot mode %s without magic number\n",
> -                               info->mode);
> -                       devm_kfree(reboot->dev, info);
> -                       continue;
> -               }
> -
> -               info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
> -               if (!info->mode) {
> -                       ret =  -ENOMEM;
> -                       goto error;
> -               } else if (info->mode[0] == '\0') {
> -                       kfree_const(info->mode);
> -                       ret = -EINVAL;
> -                       dev_err(reboot->dev, "invalid mode name(%s): too short!\n",
> -                               prop->name);
> -                       goto error;
> +       mutex_init(&reboot->rb_lock);
> +
> +       scoped_guard(mutex, &reboot->rb_lock) {
> +               for_each_property_of_node(np, prop) {
> +                       if (strncmp(prop->name, PREFIX, len))
> +                               continue;
> +
> +                       info = devm_kzalloc(reboot->dev, sizeof(*info), GFP_KERNEL);
> +                       if (!info) {
> +                               ret = -ENOMEM;
> +                               goto error;
> +                       }
> +
> +                       if (of_property_read_u32(np, prop->name, &info->magic)) {
> +                               dev_err(reboot->dev, "reboot mode %s without magic number\n",
> +                                       info->mode);
> +                               devm_kfree(reboot->dev, info);
> +                               continue;
> +                       }
> +
> +                       info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
> +                       if (!info->mode) {
> +                               ret =  -ENOMEM;
> +                               goto error;
> +                       } else if (info->mode[0] == '\0') {
> +                               kfree_const(info->mode);
> +                               ret = -EINVAL;
> +                               dev_err(reboot->dev, "invalid mode name(%s): too short!\n",
> +                                       prop->name);
> +                               goto error;
> +                       }
> +
> +                       list_add_tail(&info->list, &reboot->head);

This seems to be the only call that actually needs synchronization.
All of the above can be run outside the critical section.

>                 }
>
> -               list_add_tail(&info->list, &reboot->head);
> -       }
> -
> -       reboot->reboot_notifier.notifier_call = reboot_mode_notify;
> -       register_reboot_notifier(&reboot->reboot_notifier);
> +               reboot->reboot_notifier.notifier_call = reboot_mode_notify;
> +               register_reboot_notifier(&reboot->reboot_notifier);
>
> -       return 0;
> +               return 0;
>
>  error:
> -       list_for_each_entry(info, &reboot->head, list)
> -               kfree_const(info->mode);
> +               list_for_each_entry(info, &reboot->head, list)
> +                       kfree_const(info->mode);
> +       }
>
>         return ret;
>  }
> @@ -133,8 +141,10 @@ int reboot_mode_unregister(struct reboot_mode_driver *reboot)
>
>         unregister_reboot_notifier(&reboot->reboot_notifier);
>
> -       list_for_each_entry(info, &reboot->head, list)
> -               kfree_const(info->mode);
> +       scoped_guard(mutex, &reboot->rb_lock) {
> +               list_for_each_entry(info, &reboot->head, list)
> +                       kfree_const(info->mode);
> +       }

Please destroy the mutex here.

Bart

>
>         return 0;
>  }
> diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
> index 4a2abb38d1d612ec0fdf05eb18c98b210f631b7f..b73f80708197677db8dc2e43affc519782b7146e 100644
> --- a/include/linux/reboot-mode.h
> +++ b/include/linux/reboot-mode.h
> @@ -2,11 +2,15 @@
>  #ifndef __REBOOT_MODE_H__
>  #define __REBOOT_MODE_H__
>
> +#include <linux/mutex.h>
> +
>  struct reboot_mode_driver {
>         struct device *dev;
>         struct list_head head;
>         int (*write)(struct reboot_mode_driver *reboot, unsigned int magic);
>         struct notifier_block reboot_notifier;
> +       /*Protects access to reboot mode list*/
> +       struct mutex rb_lock;
>  };
>
>  int reboot_mode_register(struct reboot_mode_driver *reboot);
>
> --
> 2.34.1
>

