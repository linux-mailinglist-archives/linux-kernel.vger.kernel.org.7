Return-Path: <linux-kernel+bounces-854700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C710CBDF275
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A15A43C58D8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82B72BE638;
	Wed, 15 Oct 2025 14:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fDZk1URF"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9802C028C
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760539649; cv=none; b=TnWU+hM9qM8DrNZdiuCJZ5O+1uLLr9GFl6bIjYegpMSyaoC+lswMJm5Ok64wGWfvos4pIhHGQEaPZW2YWMTIYffKqTCRZkqQ6ZAmidQpYdbRN/+k/nHNcez7eBUeQhzJABMT+hHrdsXoxvIyXUEbW+3h3hYfF9oAzBKRugAFoaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760539649; c=relaxed/simple;
	bh=QUCvg677zhCDZSxrUQAlexw6PjexV7DKVMj4nJGBmi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P2MT82QQt59+g64G/xq1wG6DSkfncgKErAa0RkpGe5XxjpdvjS14Z6m69N+KaUfSKyN4a3phatdSVj9Dv6Cyer29Xc4PzoPepJncUUBNoI/Sf1+h+GObwGiQtGtUHbTNeTBuPlhIvDoZcjqJtTB4XkOqPnAGihG8kKmf73TLaCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fDZk1URF; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b5c18993b73so293519366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760539645; x=1761144445; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BkRSLUnpznpy3qYmmJfpc7POjKcvG8Z1LeLnSK1GGKQ=;
        b=fDZk1URF5eS4U1dQlxHNMNPkp/ddZGxQOOoZBdyAtJdu9mnPnEpZHXdIHKLu5vj5OG
         8zw2OP4Njz5OSTbnJ8K2pXaKuSpYLrRtlQaO7S2sz7rk3GZH1diDieZrxCXrDFtLy5rU
         XcnCw3QIcCAR3YQ7Rbkjc3Oh6anB/XAnDVP890DhTunZyKQ4IgpR6IST6W1//kd7K+v4
         GH/WVO6Xg8bUlNMSRIMQX87RNguF1jLLH5u6J6w5L9ZhhlfSWhit8C3uxysPp8g23Sm8
         pnnniRTF6YoeJAlBaGD/EXTX+Gt5RkzyKeWnUzPEybmJo7O8iw2uRcwL6DvaxPxApNmH
         5F6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539645; x=1761144445;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BkRSLUnpznpy3qYmmJfpc7POjKcvG8Z1LeLnSK1GGKQ=;
        b=X8m0mf97t+Jyrnppv6jXs1yuzmBVNhbxbnfXmFRhObV2vu0mrZj0qMMK1bfo1QEGQP
         eMWTzk2+JWMrKF4pUrjbzp/VKppAAEvqBzeanUuJtBQjeYa1CBRfqWK5jh6Qk6JJKMlk
         +OZjC7pw67twxn9KygzNWD8Au0RebnYaZNzoE/LXQWIpXnIa9rFgERFK6kUpLcea2exN
         4wV15JZCRZ2OmwBqwHSomN5RRXZ9hESdDQYrmz/2hhpt9LVR8dYHwQ/MUV2/fmYFClMa
         TyLWDo/5JKQq15eJ51HP7T44h3n1CjoLpGZ9P4WGeF4uxqXntXvYNYLPhyqeFk6m8ua+
         oydA==
X-Forwarded-Encrypted: i=1; AJvYcCWWPav/lwkd/czIs1iQqiG28800DBdw7pMWpyD89/e46g++6qulNz8EJu00hQxFSsV+zyqS7D7kNUzHICE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzl2Roi74+aFjEK04coHM3AaAzo6eS2OVqPzWz1bWo1CV1peHw
	lfvSY3grXxDd9tXHfzUCXhCbSgq1HdI3gKzoWoquxMHPKrUApWcm/xezBL6mK8iw6K4SWDIsslB
	ue/Y1bk3NvGf8zb30p4gjfAksO2/mMHkYOLioXvwKug==
X-Gm-Gg: ASbGncsxt5D45NdeQZ+sufr5JKBicbMjbee2zPD5MO+CQOQabVQsoi9Fi+eF4GEV88n
	5Kgh0XtGhiiKDvFx1avqe7lsrtRTy98yjuDTx0TBTDkQt7zM6nLw80RKPw7mupQe3j2Ep4K5Uqk
	/+x4Q8pzPcliXIQd84z2eix/cBn0Iy0gZ/qJZuUhdqY3oB16+9XkV5HTxmEJ5EyYWgHV9qvtcf1
	XV56sqa6lgp8ewEmgwiXJ4kRGFFHe+ul9lmdgx5gLruzdyCLnVMEd6Otu+eBC4IPwKhyYZa
X-Google-Smtp-Source: AGHT+IEUqGfQp9YhYQvza9pi3u1frVExIPZGobHvkJpepK8/VlN4XugYvlYQpaqAjcg5hzZJQWZYiCQ8a7FDZgL9rGQ=
X-Received: by 2002:a17:907:3e95:b0:b3c:cda5:dc5f with SMTP id
 a640c23a62f3a-b50aa48b9cdmr2796236166b.9.1760539645069; Wed, 15 Oct 2025
 07:47:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
 <20251015-arm-psci-system_reset2-vendor-reboots-v16-5-b98aedaa23ee@oss.qualcomm.com>
In-Reply-To: <20251015-arm-psci-system_reset2-vendor-reboots-v16-5-b98aedaa23ee@oss.qualcomm.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 15 Oct 2025 16:47:08 +0200
X-Gm-Features: AS18NWDY7WIS_O4_p56TfpOvWCBi95zCtvBsZn2zTDEoiMSusyplTlJpgBuyRf4
Message-ID: <CACMJSetWthCcJo8v7EuUK-aDKhf5KTNG5WQQ9aTQu62B+E=DMA@mail.gmail.com>
Subject: Re: [PATCH v16 05/14] power: reset: reboot-mode: Expose sysfs for
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
	John Stultz <john.stultz@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Stephen Boyd <swboyd@chromium.org>, 
	Andre Draszik <andre.draszik@linaro.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	Elliot Berman <quic_eberman@quicinc.com>, Srinivas Kandagatla <srini@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Oct 2025 at 06:39, Shivendra Pratap
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
> Align the clean up path to maintain backward compatibility for
> existing reboot-mode based drivers.
>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>

[snip]

> +
> +static int create_reboot_mode_device(struct reboot_mode_driver *reboot)
> +{
> +       struct reboot_mode_driver **dr;
> +       int ret = 0;
> +
> +       if (!rb_class) {
> +               rb_class = class_create("reboot-mode");
> +               if (IS_ERR(rb_class))
> +                       return PTR_ERR(rb_class);
> +       }
> +
> +       reboot->reboot_dev = device_create(rb_class, NULL, 0, NULL, reboot->driver_name);
> +       if (IS_ERR(reboot->reboot_dev))
> +               return PTR_ERR(reboot->reboot_dev);
> +
> +       ret = device_create_file(reboot->reboot_dev, &dev_attr_reboot_modes);
> +       if (ret)
> +               goto create_file_err;
> +
> +       dr = devres_alloc(release_reboot_mode_device, sizeof(*dr), GFP_KERNEL);
> +       if (!dr) {
> +               ret = -ENOMEM;
> +               goto devres_alloc_error;
> +       }
> +
> +       *dr = reboot;
> +       devres_add(reboot->reboot_dev, dr);

If you're using devres here - at least make it obvious by adding the
devm_ prefix to the function name and make it take an explicit struct
device * parameter so that it's clear who owns the managed resource.

Bart

