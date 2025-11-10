Return-Path: <linux-kernel+bounces-893468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7F3C4787F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FFF03BE07F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C8031B11E;
	Mon, 10 Nov 2025 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t9Of1YLS"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A4731329C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787708; cv=none; b=VTiekyiDx8cf94lfac4zYzxjam8D5kfrnX+9ZtQXwvG/3SNVL68NvP3n2pJ4KSv+a2/LaldV/1chERGFWmLT4l2fAUCeS4oeonLm79FUj91fjowMZFO2JdEIS26AIBx5W/2smNIYMYfBNfIBKF3LlpmUsTOuwoEWQ3kCdfxj4w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787708; c=relaxed/simple;
	bh=lhjELXmZSS3q6E2+rnaT59zCj87rpxz5eWYDWSZrjfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hWKXqDJA+vX9oXFMNMKdDyZyG/0hGC2jims7xC5N9yFLGnI1uj5FCtSqsgHodwTXwZty/mapFLDU0DPRKvvy90OOQIJYxYq4mSPoIBZ/yWpjUrxjEcKBnw1/VfLs+vbRKqlsshUCOwOKar43ViH2xu4m+PDTYAlzd7jcjDv6Dw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t9Of1YLS; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b729f239b39so674439066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762787704; x=1763392504; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tO2FkW94sB9AYPaQQFnYI79pge/7kyoIm3imhrG5Wd8=;
        b=t9Of1YLS6U+pcaO1lkopLQkFhBLmH9l0uWwSzAO37O9OwEKWoVAk0T7b7V/5ceAfc0
         eV/F6BPLuR/PVPNOpLDaCsvSmSNvFDEwdIRCEdtNacm6lr30BZNB73YmFn8JSMdb2iAx
         2ICuvW4Kiimf2fQQTNXMd/lXOlkL80kv0DcdEvg6P6Ih56OQtFbeLkjgc7u3DZqERBV0
         QiChfp3ux1mpfdu6dpRnDoHhqPhK5cquQWB/jZLnyVdGH8Hi7eM0pOK4bW+sOkn/ZU3I
         jqQo8oBX7b/SHOHuh40Sr43KAOnh/qSUZ2pjUXwnf9E21wLy/64qoCSt9+xusxqYwRFA
         dJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762787704; x=1763392504;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tO2FkW94sB9AYPaQQFnYI79pge/7kyoIm3imhrG5Wd8=;
        b=v3pR+a891n1LMJa7EvBsNCpHf3reuChXBdPiTFg9vzi95XuBAVnV4kDRWSm06Y0PW7
         dTbiB4R79WEUxffBTSrTD0tSpWY2S+UaTWqdjfmoKo06xvnVm3qoh/QCQcMfnJzsFH33
         CH+XHws9nD5UhAg4Ne/TXJmlcr460b6J7zO0xpxBZZdeKac5XnmqVjJ5wnzWDvkWierP
         YJxXHCZ0yMUP/stYcDjw7yfe5F37cKMnZ6A9uaBRg9PypY9R4dCsrGiZSsGB8/3yOIZM
         LnvnVGd1VBt9W8ZnPSFIhg7C4vIPCYAG+jcq1N4LMucRLyg87GmtpBkSOgyP8h6wgaxI
         vzeg==
X-Forwarded-Encrypted: i=1; AJvYcCUb8CJenb+vHCmfk07E1+HHdMGUeBPcAL5qo4ofUFstc/0Nzi9bkmVIBbO87RboUz0jwlEc4OFvLMQzgBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwifPAzQjOSRoqGxZuaTlhjr7lGrRsG3kUPSPe2DCp0nW123rWt
	3Y9Ru7VmvMmbYBNF7Fi9Sf6BZTL7rzO9a0uqzjxHA5YNhOPUTCjGfZs0BqLGQz+4Vqj9+1y67L0
	43Ef7QgmgBf+KXZ1VNeHqdqn+dtvduB6zIEZpZMeOtg==
X-Gm-Gg: ASbGnct9XHco2OACigAgwpsWUh0Oldcw5veblw9rKcKpB0JFyj4OSRKkh0/opBY/iYD
	/y1mySg3aDH4GAuglZSZJhlGLC2od9qnE0NP7uMD83aingWKB7qRElzHonKC39nMQ0NFLCbtqu2
	p1WLNGnKBWOU25UOBDHSwqYNwEyqq+PW5qP8J/yI+ADw83Mhf+q8gw7erExbWu8YVi5bUHL3z0m
	dLOQsyZ86Qw2fyUE3ljfBnfDQlcxVQ7jb5sXb2RWN8tkZo3SCB+wbF1D0WHXoqwFltPCqLpVahf
	QLCtumwhiOvbDY8O3U3Y+mTdVU5INCpuskjK1g==
X-Google-Smtp-Source: AGHT+IF0JiR17k2tNdQIY29GGeZp6tuwfTPaU+/ksYYCINL8GaZCSCzoJNug8wrqVngyVxyRmshkBrZF3f3+WWM6Cjg=
X-Received: by 2002:a17:907:9408:b0:afa:1d2c:bbd1 with SMTP id
 a640c23a62f3a-b72dff5f6b2mr1002486166b.30.1762787704214; Mon, 10 Nov 2025
 07:15:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
 <20251109-arm-psci-system_reset2-vendor-reboots-v17-5-46e085bca4cc@oss.qualcomm.com>
In-Reply-To: <20251109-arm-psci-system_reset2-vendor-reboots-v17-5-46e085bca4cc@oss.qualcomm.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 10 Nov 2025 16:14:53 +0100
X-Gm-Features: AWmQ_bnHJgzy3SDXUbMU9BaI_OynoJofd0BXy7gUevgAAiWJJ2om5cI31VC5pf4
Message-ID: <CACMJSesMK37D7Qy+rVq7w6bUt6bYGXykUid6bUKXvh7M9mntZA@mail.gmail.com>
Subject: Re: [PATCH v17 05/12] power: reset: reboot-mode: Expose sysfs for
 registered reboot_modes
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
	Elliot Berman <quic_eberman@quicinc.com>, Xin Liu <xin.liu@oss.qualcomm.com>, 
	Srinivas Kandagatla <srini@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Nov 2025 at 15:38, Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> wrote:
>
> Currently, there is no standardized mechanism for userspace to
> discover which reboot-modes are supported on a given platform.
> This limitation forces tools and scripts to rely on hardcoded
> assumptions about the supported reboot-modes.
>
> Create a class 'reboot-mode' and a device under it to expose a
> sysfs interface to show the available reboot mode arguments to
> userspace. Use the driver_name field of the struct
> reboot_mode_driver to create the device. For device-based
> drivers, configure the device driver name as driver_name.
>
> This results in the creation of:
>   /sys/class/reboot-mode/<driver>/reboot_modes
>
> This read-only sysfs file will exposes the list of supported
> reboot modes arguments provided by the driver, enabling userspace
> to query the list of arguments.
>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  drivers/power/reset/reboot-mode.c | 62 ++++++++++++++++++++++++++++++++++++++-
>  include/linux/reboot-mode.h       |  2 ++
>  2 files changed, 63 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
> index 873ac45cd7659b214b7c21958f580ca381e0a63d..582aa7f8ed7fa485c5a67877558c9b15d3600ef4 100644
> --- a/drivers/power/reset/reboot-mode.c
> +++ b/drivers/power/reset/reboot-mode.c
> @@ -6,6 +6,7 @@
>  #define pr_fmt(fmt)    "reboot-mode: " fmt
>
>  #include <linux/device.h>
> +#include <linux/err.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
> @@ -23,6 +24,8 @@ struct mode_info {
>         struct list_head list;
>  };
>
> +static struct class *rb_class;
> +

I know C is a spartan language but the rb_ prefix makes me think of
the red-black tree. Please call it reboot_mode_class.

>  static u64 get_reboot_mode_magic(struct reboot_mode_driver *reboot, const char *cmd)
>  {
>         const char *normal = "normal";
> @@ -65,6 +68,51 @@ static int reboot_mode_notify(struct notifier_block *this,
>         return NOTIFY_DONE;
>  }
>
> +static ssize_t reboot_modes_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +       struct reboot_mode_driver *reboot;
> +       struct mode_info *info;
> +       ssize_t size = 0;
> +
> +       reboot = (struct reboot_mode_driver *)dev_get_drvdata(dev);

No need for the cast.

> +       if (!reboot)
> +               return -ENODATA;
> +
> +       list_for_each_entry(info, &reboot->head, list)
> +               size += sysfs_emit_at(buf, size, "%s ", info->mode);
> +
> +       if (size) {
> +               size += sysfs_emit_at(buf, size - 1, "\n");
> +               return size;
> +       }

This is a weird logic inversion. Just do:

if (!size)
    return -ENODATA;

return size + sysfs_emit_at(buf, size - 1, "\n");

> +
> +       return -ENODATA;
> +}
> +static DEVICE_ATTR_RO(reboot_modes);
> +
> +static int create_reboot_mode_device(struct reboot_mode_driver *reboot)
> +{
> +       int ret = 0;
> +
> +       if (!rb_class) {
> +               rb_class = class_create("reboot-mode");
> +               if (IS_ERR(rb_class))
> +                       return PTR_ERR(rb_class);
> +       }

Why the lazy initialization here? Is there any reason you can't
statically define the class? Don't you need synchronization here if
multiple drivers try to do this?

Bart

