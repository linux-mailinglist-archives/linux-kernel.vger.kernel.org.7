Return-Path: <linux-kernel+bounces-728006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A11B02256
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0B0566A5D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72332EF2BC;
	Fri, 11 Jul 2025 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vCqprmGl"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63221944E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752253780; cv=none; b=OHs6q3vuf3ynKgQ4O8dAzcNCT5hYGWpTIZ1mPbEud9jXrj2+bJkR+k+qwo3mxQuziI6S6LX7/OgUigTuA4Nx9Du9yvQvZ4UmCOgKLtTm4wzwKxKIi9hYNPkvOGdc7NvX+dFxSXD06xxuudbgicn48je/0bosjy+zE7ozedo2AZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752253780; c=relaxed/simple;
	bh=rGIy1pkQYmtcAjyatutqLQoQqkLBz360GZ85LcsduN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SRxwPI4dNvnH45dc8Y1fADZlLbTPSjATGhusAFJ8EssZBmapc+QzRauqvv6QWrXbJzPIauwprxcmOB7thvZAROJgQOQoKdthvO0yMgh8maF+5U0lb0eZ5HuNpofXYL8k9ahKbivkTbA9+qDE5vluyW8cLAQavbtCDcX3ptPkHlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vCqprmGl; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-60d666804ebso1713431eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752253777; x=1752858577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lYyuRDB/HktfRyE467qi37bT7tU4zkVraiVc+sdSSt8=;
        b=vCqprmGlXjms3AGz+b4XdOxZdviQbawh3gfkugdX0zlZLY0SVKUUFhfTypAtjc9tdi
         K2D9XA/dUrayq10YH9TKW+HWYk1e0BHSOjS5Z9FzKZyKSVQ0uXp/d4eDdshhavPiaXuL
         cocG1dV09DEVqQVjXgduFP9R09gRg/QxlMyy36FK80N99heCbYjWh68se+dyD7jueW6G
         HWROD5ZHDayFjKbE55L9uN/3PBi9WLB1KI8+ydEQlgQ7+GeQcxdnQuB7AHUMYfUqK85N
         L/8yXXUQZ4Y8/Bde9namDCeDLKwn/xsJpLA0EjJGIfYNpDUM9LaZ6MdbbyavWt2CcfCp
         CVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752253777; x=1752858577;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lYyuRDB/HktfRyE467qi37bT7tU4zkVraiVc+sdSSt8=;
        b=nbU6880mhOtydUOSViMdVdsa8wjicPnXaxfyy0aIz1/OUciFUGslpuyDmDVllsZyMV
         6tnJ05Fq21sf8mj469VbSclg3GtdDN0WNwWk77r1nfgiN3Vw1QytLVvJr0nFNrWAc+da
         DoRIgi6w9bj9TnMi8cY94yQE1ou/zmQPW8HaNfjBDGs2kGM2861VYf4FlmkDrHGlU+OM
         KrFmMIBQ6jdwR7WnhfiTfnw2awKgc0C7gAaAJN7LOqq9nhOI6ELhbnVUZ4NafPiJRuqe
         KOW3jRc4GsrGg4fO5j0uHFBbs9BpeYGtuM39yQO2EW7x6sA58ES+sAlTZFqlSQ7DPC+Q
         Ue/w==
X-Forwarded-Encrypted: i=1; AJvYcCVsmKlbc4czPMplGKT6590SprO79qNXJqnzXvK0BJFS2H/OxsZjY+oeGLKwdLgwrESErRtSgXzsBRd+DEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVVMwGEFoExuMqrgRDMKSwNhyEb6sJYM6A/TelFXENr4en7gsC
	BM9ocsWZV4bHy87M4OmFQEbBcPLt4AkGeFuejpztKi64YsCFhjXe3JZTpuBcB3PRamA=
X-Gm-Gg: ASbGncvuxA4mtAQ6zfeecjzQh3Jx7znLGLwoOIy2bdHhm1+KNAtsqH/us+ZawY6diFV
	X8+3VIWF7QkhwFYHzO8tnxVXt8KnRwM8j/nsIqu5KjhKfQGKEiFKO8O9OWEZOxob6aPBoKOBOdU
	4TjjI4td0CY85yf552VXcuxDQ4H+9WcveGzS3DEkqzoLsbhrpidhAnf0HAiMu18TUJGZ2B307/r
	xa6x2DajxuVr8e0MUW+T5lkQ29wIuWl0VeYNO+ZnijiL5A98yWCj8X2w2CWI1W7g6U/Avtg6nx4
	zT64lQLywzFQQnDwLBHs/y/AITT9bf3sii0maxZD3EBZhuEAW7iE9v0Bj/5UwMgWTudYs7UUd0G
	svQ7JFhFOMg8RFtRQEDPu+lmkUHmjUgTAgcA9jMFl4KO4LiCd/S8oswJUL3Wv5jJhVVbMj7DZX0
	A=
X-Google-Smtp-Source: AGHT+IGm4hiu469Vc3JSD1AOTjQdQx2W5sxcZJhYPSfhyP8P2MO+kMPBaRS60lXTzmvnR86pVPsFTQ==
X-Received: by 2002:a05:6820:4b05:b0:613:c8c2:a08e with SMTP id 006d021491bc7-613e5964d97mr3100119eaf.2.1752253777324;
        Fri, 11 Jul 2025 10:09:37 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4601:15f9:b923:d487? ([2600:8803:e7e4:1d00:4601:15f9:b923:d487])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-613d9f26c1esm542425eaf.35.2025.07.11.10.09.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 10:09:36 -0700 (PDT)
Message-ID: <5025b191-c5ba-488c-a7cd-6f2bfde47bd2@baylibre.com>
Date: Fri, 11 Jul 2025 12:09:36 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] iio: adc: add support for ADE9000 Energy Monitoring
 IC
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250711130241.159143-1-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250711130241.159143-1-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/25 8:02 AM, Antoniu Miclaus wrote:
> This patch series adds support for the Analog Devices ADE9000, a highly
> accurate, fully integrated, multiphase energy and power quality monitoring
> device. The ADE9000 is capable of measuring energy consumption and power
> quality parameters in industrial and commercial applications.
> 
> The series includes:
> 
> 1. New IIO modifiers for power and energy measurement devices, including
>    support for active/reactive/apparent power, energy accumulation, RMS
>    measurements, and power quality indicators (swell/dip detection).
> 
> 2. Device tree bindings for the ADE9000, supporting waveform buffer
>    configuration, phase configuration, and trigger settings.
> 
> 3. Complete driver implementation supporting:

You will get much better review if we can spread this out across
multiple series instead of trying to do everything all at once.
At a minimum, each of these should be a separate patch. 2000 lines
in one patch is just way too much to grok at once.

>    - Multi-phase energy measurement (3-phase support)
>    - Power quality monitoring (voltage swell/dip detection)
>    - Waveform buffer capture with configurable triggering
>    - Energy accumulation with configurable time windows
>    - IIO buffer interface for continuous data streaming
>    - Event-based notifications for power quality events
> 
> The driver provides a comprehensive interface for energy monitoring
> applications through the IIO framework, enabling userspace applications
> to monitor power consumption, quality, and waveform data.
> 
> The driver will be extended in the future to support multiple parts such as
> ade9039.
> 
> Antoniu Miclaus (3):
>   iio: add power and energy measurement modifiers

It looks like [PATCH 1/3] didn't get sent out.

>   dt-bindings: iio: adc: add ade9000
>   iio: adc: add ade9000 support
> 
>  Documentation/ABI/testing/sysfs-bus-iio       |   19 +
>  .../bindings/iio/adc/adi,ade9000.yaml         |  157 ++
>  drivers/iio/adc/Kconfig                       |   13 +
>  drivers/iio/adc/Makefile                      |    1 +
>  drivers/iio/adc/ade9000.c                     | 2187 +++++++++++++++++
>  drivers/iio/industrialio-core.c               |   11 +
>  include/uapi/linux/iio/types.h                |   11 +
>  7 files changed, 2399 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
>  create mode 100644 drivers/iio/adc/ade9000.c
> 


