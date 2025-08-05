Return-Path: <linux-kernel+bounces-756324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04467B1B2B2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 040AF7A1CAF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E46D25A626;
	Tue,  5 Aug 2025 11:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wJFuQnos"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5CB1917E3
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 11:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754394237; cv=none; b=ToFMuQitBpA2uLS3D0G1GmtGkYyjvpKxVyLnRFQl1ultbtxwCG+iOYvGa4YebHjs3pJ7p2x0bn/2yPAt+piIpNha6Cm3/Nd67C2zDhajqmy1GEmiVLH5Y0rF6mLkRYUHnqHCpN5IPnZjKab6CUcBvHWHW/V8+pPUBWoh62D+D0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754394237; c=relaxed/simple;
	bh=qQFbXAdVddS139994BH2eru2jJIxaSkSenZ1cOMHaHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NtyRMCZo9VUjt7+sUpwzgJuIYRkRYhvG6Jqyb9ztO0eksVvKoFx+IQHdoDU7pyihnFpIxtOzDnAoOzyyGZDLNee/sZv2B6vonioAP9sZ4ES9KKNLo6342Ds1ECsvI79vjixA6FAG/ZU24E6DmBOJ1H8O+/nHOdDmRGt3L9I/Yag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wJFuQnos; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-31ecd40352fso4633379a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 04:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754394235; x=1754999035; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tDSem0VEHhNCiFbhAejGqkNC7DQu7KRaDbsToqiPuSI=;
        b=wJFuQnos4fIqYR59KevA3Mp/gr1rj16V4NJu6JA5PYK+Nvk6Iat6Dd0PU4Hh+VbrCj
         T6tl/o9ZUrpSfz0JILELXdbH8yXWR9QtqaGyyBmoxdE95QMYl1/2bvGp3S3pUZZH2p54
         AdOCkBJifkK3eCXzWK+Ybm/cMPuuvA47KzGn8+2GY8QDm0moBVp04xDCokooYpnN6ZD/
         gxOQIW9CWa+gepY4o/shfZKD6Qz75asj6GQCWs6tRbIQJFNns0apKwBwCVSkf5emg9NK
         1BbppwhmJ3TDcOG/leb/rmsKOtyAkAHLCCW7wT6iG6mbjSrE4KKhZENNIbCgKuJi/lwt
         9rcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754394235; x=1754999035;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDSem0VEHhNCiFbhAejGqkNC7DQu7KRaDbsToqiPuSI=;
        b=FONjCI3DUpkj3jC53oBx1OAjAqXzUIgROY9fbYCHZiu4ZpUd/b/rxoI5qwCbrro4Y+
         ipi1anqHvJ/3zByYMgriKm0QyEzmohGBbQUJ/E4u9fJI8DiLkS1mQ9IXHSMQAmcw0DJP
         1Y36nmi73Vq0jWr9SJLL66KSJnW85PH5y4W3QLeQjTuUkHYiVWnciECedcZfbx+SltDC
         0WVE1klISSrz5+38+xSpIYUj+a63ZOPuBPkWqnN28Ewezxm14+VHXV7DJ729A+gMThMb
         C4/JOCkdQ/GR64qjPUJH60+YLivuAx2GH6sYNX/JKsR/LXR+BxtKioqyGBmqoVyrD4cr
         1kAw==
X-Forwarded-Encrypted: i=1; AJvYcCXRr/0D4y8qqXsKw4KvazUPiS2iZ+3lii6QXAKnv/bVUoQHGgMRpwn7WLewqW5hzvbHCPrccTkHWlo7BF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbJvy4qLAu2AeH/l8BlLdLAcfnVnYu6RgfUFBUYgiWkYI+3lxS
	S8yPZUoXLr/Z69TIUmRNMFvaBz55CI6lqsGA2TyuCLvG6vSjSoJg+ogwQ1QwcEa1oaOvrNHyAwv
	X7vqPZUBjSZlj1IxtNrONtZb85QaY9wSupcJLnafcGw==
X-Gm-Gg: ASbGncvkUCV/C2ImkAdcebvXvXmv+KEEuouBs/5qZ4/mpuI15Uhf1b3WXo1UjCg8Bqb
	Tnh2T16bFI3hBKqtZIf7OAHAvzVV2mx2WmunQrtXTKWNqpKwKenqyb00Gn4Nt9t/7+R2x2Z8GcV
	vRaftv3rmov5SmlwTSTko99AJirPtwkLsHlYN8Z41QKfy7Fmbu5dHAIMfvSUd+rT0TUtuVoDU5J
	bgOaMWPd46rysQw
X-Google-Smtp-Source: AGHT+IGQh1IHldLd0Xsa7DV3WGgE48Y3oh+lMpkw5CWGb+Xj011SVcOFfY2rdo3TaHAT5I0VaX6ImgYZfxqtKmD2FQg=
X-Received: by 2002:a17:90b:3146:b0:313:15fe:4c13 with SMTP id
 98e67ed59e1d1-321162c9366mr18968548a91.27.1754394234942; Tue, 05 Aug 2025
 04:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717125343.3820505-1-quic_jinlmao@quicinc.com> <20250717125343.3820505-3-quic_jinlmao@quicinc.com>
In-Reply-To: <20250717125343.3820505-3-quic_jinlmao@quicinc.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Tue, 5 Aug 2025 12:43:43 +0100
X-Gm-Features: Ac12FXwQ6TRr8fi74oMe-Ptz9AMCTyfI7J3MuYdWjVEh0hc8XNY3WysaB9ylgCw
Message-ID: <CAJ9a7ViD6MqOrtBp6LYnEg-rs6x0c9HuGfy4pWHG1iW67OdT=g@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] coresight: Add label sysfs node support
To: Mao Jinlong <quic_jinlmao@quicinc.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, James Clark <james.clark@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi

On Thu, 17 Jul 2025 at 13:54, Mao Jinlong <quic_jinlmao@quicinc.com> wrote:
>
> For some coresight components like CTI and TPDM, there could be
> numerous of them. From the node name, we can only get the type and
> register address of the component. We can't identify the HW or the
> system the component belongs to. Add label sysfs node support for
> showing the intuitive name of the device.
>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> Reviewed-by: Mike Leach <mike.leach@linaro.org>
> ---
>  .../testing/sysfs-bus-coresight-devices-cti   |  6 ++
>  .../sysfs-bus-coresight-devices-dummy-source  |  6 ++
>  .../testing/sysfs-bus-coresight-devices-etb10 |  6 ++
>  .../testing/sysfs-bus-coresight-devices-etm3x |  6 ++
>  .../testing/sysfs-bus-coresight-devices-etm4x |  6 ++
>  .../sysfs-bus-coresight-devices-funnel        |  6 ++
>  .../testing/sysfs-bus-coresight-devices-stm   |  6 ++
>  .../testing/sysfs-bus-coresight-devices-tmc   |  6 ++
>  .../testing/sysfs-bus-coresight-devices-tpdm  |  6 ++
>  .../testing/sysfs-bus-coresight-devices-trbe  |  6 ++
>  drivers/hwtracing/coresight/coresight-sysfs.c | 71 ++++++++++++++++++-
>  11 files changed, 129 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-cti b/Documentation/ABI/testing/sysfs-bus-coresight-devices-cti
> index a97b70f588da..55367bbc696f 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-cti
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-cti
> @@ -239,3 +239,9 @@ Date:               March 2020
>  KernelVersion: 5.7
>  Contact:       Mike Leach or Mathieu Poirier
>  Description:   (Write) Clear all channel / trigger programming.
> +
> +What:           /sys/bus/coresight/devices/<cti-name>/label
> +Date:           Jul 2025
> +KernelVersion   6.17
> +Contact:        Mao Jinlong <quic_jinlmao@quicinc.com>
> +Description:    (Read) Show hardware context information of device.
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-dummy-source b/Documentation/ABI/testing/sysfs-bus-coresight-devices-dummy-source
> index 0830661ef656..9a11bd5b15cc 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-dummy-source
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-dummy-source
> @@ -13,3 +13,9 @@ KernelVersion:        6.14
>  Contact:       Mao Jinlong <quic_jinlmao@quicinc.com>
>  Description:   (R) Show the trace ID that will appear in the trace stream
>                 coming from this trace entity.
> +
> +What:           /sys/bus/coresight/devices/dummy_source<N>/label
> +Date:           Jul 2025
> +KernelVersion   6.17
> +Contact:        Mao Jinlong <quic_jinlmao@quicinc.com>
> +Description:    (Read) Show hardware context information of device.
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etb10 b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etb10
> index 9a383f6a74eb..ff1f89795188 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etb10
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etb10
> @@ -19,6 +19,12 @@ Description: (RW) Disables write access to the Trace RAM by stopping the
>                 into the Trace RAM following the trigger event is equal to the
>                 value stored in this register+1 (from ARM ETB-TRM).
>
> +What:           /sys/bus/coresight/devices/<memory_map>.etb/label
> +Date:           Jul 2025
> +KernelVersion   6.17
> +Contact:        Mao Jinlong <quic_jinlmao@quicinc.com>
> +Description:    (Read) Show hardware context information of device.
> +
>  What:          /sys/bus/coresight/devices/<memory_map>.etb/mgmt/rdp
>  Date:          March 2016
>  KernelVersion: 4.7
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x
> index 271b57c571aa..743f26619c69 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x
> @@ -251,6 +251,12 @@ KernelVersion:     4.4
>  Contact:       Mathieu Poirier <mathieu.poirier@linaro.org>
>  Description:   (RO) Holds the cpu number this tracer is affined to.
>
> +What:           /sys/bus/coresight/devices/<memory_map>.[etm|ptm]/label
> +Date:           Jul 2025
> +KernelVersion   6.17
> +Contact:        Mao Jinlong <quic_jinlmao@quicinc.com>
> +Description:    (Read) Show hardware context information of device.
> +
>  What:          /sys/bus/coresight/devices/<memory_map>.[etm|ptm]/mgmt/etmccr
>  Date:          September 2015
>  KernelVersion: 4.4
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x
> index a0425d70d009..e6a584a4b040 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x
> @@ -329,6 +329,12 @@ Contact:   Mathieu Poirier <mathieu.poirier@linaro.org>
>  Description:   (RW) Access the selected single show PE comparator control
>                 register.
>
> +What:           /sys/bus/coresight/devices/etm<N>/label
> +Date:           Jul 2025
> +KernelVersion   6.17
> +Contact:        Mao Jinlong <quic_jinlmao@quicinc.com>
> +Description:    (Read) Show hardware context information of device.
> +
>  What:          /sys/bus/coresight/devices/etm<N>/mgmt/trcoslsr
>  Date:          April 2015
>  KernelVersion: 4.01
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-funnel b/Documentation/ABI/testing/sysfs-bus-coresight-devices-funnel
> index d75acda5e1b3..5578fa5f6f02 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-funnel
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-funnel
> @@ -10,3 +10,9 @@ Date:         November 2014
>  KernelVersion: 3.19
>  Contact:       Mathieu Poirier <mathieu.poirier@linaro.org>
>  Description:   (RW) Defines input port priority order.
> +
> +What:           /sys/bus/coresight/devices/<memory_map>.funnel/label
> +Date:           Jul 2025
> +KernelVersion   6.17
> +Contact:        Mao Jinlong <quic_jinlmao@quicinc.com>
> +Description:    (Read) Show hardware context information of device.
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-stm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-stm
> index 53e1f4815d64..c3a81978e30b 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-stm
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-stm
> @@ -51,3 +51,9 @@ KernelVersion:        4.7
>  Contact:       Mathieu Poirier <mathieu.poirier@linaro.org>
>  Description:   (RW) Holds the trace ID that will appear in the trace stream
>                 coming from this trace entity.
> +
> +What:           /sys/bus/coresight/devices/<memory_map>.stm/label
> +Date:           Jul 2025
> +KernelVersion   6.17
> +Contact:        Mao Jinlong <quic_jinlmao@quicinc.com>
> +Description:    (Read) Show hardware context information of device.
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
> index 339cec3b2f1a..9554f4f453a3 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
> @@ -107,3 +107,9 @@ Contact:    Anshuman Khandual <anshuman.khandual@arm.com>
>  Description:   (RW) Current Coresight TMC-ETR buffer mode selected. But user could
>                 only provide a mode which is supported for a given ETR device. This
>                 file is available only for TMC ETR devices.
> +
> +What:           /sys/bus/coresight/devices/<memory_map>.tmc/label
> +Date:           Jul 2025
> +KernelVersion   6.17
> +Contact:        Mao Jinlong <quic_jinlmao@quicinc.com>
> +Description:    (Read) Show hardware context information of device.
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> index a341b08ae70b..e6d935e83042 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> @@ -272,3 +272,9 @@ KernelVersion       6.15
>  Contact:       Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
>  Description:
>                 (RW) Set/Get the enablement of the individual lane.
> +
> +What:           /sys/bus/coresight/devices/<tpdm-name>/label
> +Date:           Jul 2025
> +KernelVersion   6.17
> +Contact:        Mao Jinlong <quic_jinlmao@quicinc.com>
> +Description:    (Read) Show hardware context information of device.
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-trbe b/Documentation/ABI/testing/sysfs-bus-coresight-devices-trbe
> index ad3bbc6fa751..2a5868ba3d6b 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-trbe
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-trbe
> @@ -12,3 +12,9 @@ Contact:      Anshuman Khandual <anshuman.khandual@arm.com>
>  Description:   (Read) Shows if TRBE updates in the memory are with access
>                 and dirty flag updates as well. This value is fetched from
>                 the TRBIDR register.
> +
> +What:           /sys/bus/coresight/devices/trbe<cpu>/label
> +Date:           Jul 2025
> +KernelVersion   6.17
> +Contact:        Mao Jinlong <quic_jinlmao@quicinc.com>
> +Description:    (Read) Show hardware context information of device.
> diff --git a/drivers/hwtracing/coresight/coresight-sysfs.c b/drivers/hwtracing/coresight/coresight-sysfs.c
> index feadaf065b53..f7a0c9056854 100644
> --- a/drivers/hwtracing/coresight/coresight-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-sysfs.c
> @@ -7,6 +7,7 @@
>  #include <linux/device.h>
>  #include <linux/idr.h>
>  #include <linux/kernel.h>
> +#include <linux/property.h>
>
>  #include "coresight-priv.h"
>  #include "coresight-trace-id.h"
> @@ -371,17 +372,81 @@ static ssize_t enable_source_store(struct device *dev,
>  }
>  static DEVICE_ATTR_RW(enable_source);
>
> +static ssize_t label_show(struct device *dev,
> +               struct device_attribute *attr, char *buf)
> +{
> +
> +       const char *str;
> +       int ret;
> +
> +       ret = fwnode_property_read_string(dev_fwnode(dev), "label", &str);
> +       if (ret == 0)
> +               return scnprintf(buf, PAGE_SIZE, "%s\n", str);

sysfs_emit() here.

> +       else
> +               return ret;
> +}
> +static DEVICE_ATTR_RO(label);
> +
> +static umode_t label_is_visible(struct kobject *kobj,
> +                                  struct attribute *attr, int n)
> +{
> +       struct device *dev = kobj_to_dev(kobj);
> +
> +       if (attr == &dev_attr_label.attr) {
> +               if (fwnode_property_present(dev_fwnode(dev), "label"))
> +                       return attr->mode;
> +               else
> +                       return 0;
> +       }
> +
> +       return attr->mode;
> +}
> +
>  static struct attribute *coresight_sink_attrs[] = {
>         &dev_attr_enable_sink.attr,
> +       &dev_attr_label.attr,
>         NULL,
>  };
> -ATTRIBUTE_GROUPS(coresight_sink);
> +
> +static struct attribute_group coresight_sink_group = {
> +       .attrs = coresight_sink_attrs,
> +       .is_visible = label_is_visible,
> +};
> +__ATTRIBUTE_GROUPS(coresight_sink);
>
>  static struct attribute *coresight_source_attrs[] = {
>         &dev_attr_enable_source.attr,
> +       &dev_attr_label.attr,
>         NULL,
>  };
> -ATTRIBUTE_GROUPS(coresight_source);
> +
> +static struct attribute_group coresight_source_group = {
> +       .attrs = coresight_source_attrs,
> +       .is_visible = label_is_visible,
> +};
> +__ATTRIBUTE_GROUPS(coresight_source);
> +
> +static struct attribute *coresight_link_attrs[] = {
> +       &dev_attr_label.attr,
> +       NULL,
> +};
> +
> +static struct attribute_group coresight_link_group = {
> +       .attrs = coresight_link_attrs,
> +       .is_visible = label_is_visible,
> +};
> +__ATTRIBUTE_GROUPS(coresight_link);
> +
> +static struct attribute *coresight_helper_attrs[] = {
> +       &dev_attr_label.attr,
> +       NULL,
> +};
> +
> +static struct attribute_group coresight_helper_group = {
> +       .attrs = coresight_helper_attrs,
> +       .is_visible = label_is_visible,
> +};
> +__ATTRIBUTE_GROUPS(coresight_helper);
>
>  const struct device_type coresight_dev_type[] = {
>         [CORESIGHT_DEV_TYPE_SINK] = {
> @@ -390,6 +455,7 @@ const struct device_type coresight_dev_type[] = {
>         },
>         [CORESIGHT_DEV_TYPE_LINK] = {
>                 .name = "link",
> +               .groups = coresight_link_groups,
>         },
>         [CORESIGHT_DEV_TYPE_LINKSINK] = {
>                 .name = "linksink",
> @@ -401,6 +467,7 @@ const struct device_type coresight_dev_type[] = {
>         },
>         [CORESIGHT_DEV_TYPE_HELPER] = {
>                 .name = "helper",
> +               .groups = coresight_helper_groups,
>         }
>  };
>  /* Ensure the enum matches the names and groups */
> --
> 2.25.1
>

with the above change

Reviewed-by: Mike Leach <mike.leach@linaro.org>
-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

