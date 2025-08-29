Return-Path: <linux-kernel+bounces-792480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C67F5B3C492
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7051797ED
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 22:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97963275111;
	Fri, 29 Aug 2025 22:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="w6Mlitym"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF4BB676
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 22:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756504920; cv=none; b=ocZ9ux0Sn286mEp6OMNfhfzfJAizqywlEcaUmOnAzqam/m4NBcGRsmadF+EVDTpJ544OFdea5BxkSLLHxMtZG6wU8g+TeIXYwm55iN+FvS5W019Tf58nGE1nsWBFUoPZSg4v6uNe5yCkvXP4HUhZ4kIN1umn5QDzIvIVHcinlLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756504920; c=relaxed/simple;
	bh=zl6vBGVXeQU+dLiKGHbINuGEJlV6Isf3zVGqeouSOs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cPv98XqgZnAA8PRsHP0uqM0ZERVOUv6nNsUEka66XKrVe/lR1tqiFc/Y1Eoa1/puvd2doozx8jwSc/bYGZsuPuEIXq1QWQ6OX/9knDtfiw33EaU1FCzVUYHLJbQj01ec64Xt0nPv5IbJ1Gq+9TVCTcWyINLO7XNwXk4ldSjG9RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=w6Mlitym; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-30cce8c3afaso2175963fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756504916; x=1757109716; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=19qA9IJiXINaqD9EgIAK4yhHbK41U19o5AGAxAC1+DQ=;
        b=w6MlitymBOEMAXEUvPj230NXK2+Aa2j15op3i2MO2DLO0kFpzp9cw1wcH81M1gZohJ
         zLsMUN3ra9K/YKrmSgjsFqO/rzN63pKzWMXwEbI0w1AcaMakltLDp0ZDfSplCiovnqbF
         SSEEcChglthyskEZYiiz8taSrK5kCVADBeR/iS0JEBDkaIeSNIObAUAdv5vJvS6oniNp
         qWm67SQe4P4w+y+CwrFgPAioquy1c/RSssfA+zFNoq959rLhRtKYU/yNm2E8yc9c1zTn
         YtZOnYzSPVClKdH0Pntz9NEWxxjeFNWo9cnj5B7XZ/u7+F2D4zCIMuVykh7gAuJ+UJuU
         I6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756504916; x=1757109716;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=19qA9IJiXINaqD9EgIAK4yhHbK41U19o5AGAxAC1+DQ=;
        b=MrJzAzI23tT6xZ2zL9+dVkaFnN235nXans52GFPxcBKckScA3NJHS9WBeFGWrHlrIN
         jaoBzZ4w7MnVqxKrC0jDqA+60nuzL6tBNF6IOMkHxrGiMbC19eLp2uukCukOpILS9Xs8
         ekeudCyA6iNdxdpLIw8wd37vbVgB3wpZ6RSucInFa4ZV3lD1tvxnjo/2/TZL04GAXGg4
         tml1L1RgkhwXKlHpP74/aMz8BnmOsaJTSfEzMnJcTpcNP5g6Qp+SI3be2hkpuhOrzcyh
         nj8cInQSN0AmTv30JOD4nM+RTUTgJ5SPPybOaF6zK4rhLaWHcEqOdTUE5biq5MJ/VCFN
         Br/A==
X-Forwarded-Encrypted: i=1; AJvYcCW+T0LA+d58pLkwVdQvPRISVuyvwAUVRwAziwQyiSOaq1f8bGi3tQ05+c4xphjbSMXy5YmEls9TrSmm2t8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEs6lTl776J95OfY3JNJe90n61qATkASx95fWkSiBOD2RNINIm
	O8Lcj3ceRyU5374XxPFLTpb8so/kzP0UaruKinYOT697BoKv/Zs7s370mjOE+ubp4w0=
X-Gm-Gg: ASbGncvmwumTuvxeZRT90PyD9ATzwMhWC2K2koZt0RcgnpRUAqNSuZg0w3UOQyLIKjj
	gHNFjELdiWZlHczytKBgoCqgWzuKxYETbPkD5/uFVDQDoFY7W+AhWHuMGPp0KBJPn9cqCZok97J
	p0SD/YOvfYPUR5/gIGJJXXG9QwxSdjo7z/vmR0w9yMSc5x8GI4vD6GbmaDexlGqodjDUBIJ59Cu
	Q2PkZ4yhYoSlsbyRcFRGJ2WgkTG1AKcQf+GT2NRUCxS6ynAQ2+RdklGlPJj0Z+qV+1ppP6FcqHr
	XCz3kO0eGzs8pT/BXs2rcIsT2YcPqiEbXusiakl7Lt4oUz93pCQSr37cMX3D22FRVQBd91kTfGM
	RU4TinkzhD8bZvAF6a7W7nZ44R1DWZXSWNl241wsg7eJ+5hqUo0QNuklfy220mX5aj/McgC9Qkt
	AXz/dFuB+v1Q==
X-Google-Smtp-Source: AGHT+IERWcMFksvA1SjoYrWgF8bLN146tgMZEG+xX0MMIQYjzycbPjINqdpX4BOPaOfHn23qYd2Ubw==
X-Received: by 2002:a05:6870:8996:b0:319:5c90:4829 with SMTP id 586e51a60fabf-3196346319cmr69215fac.43.1756504915921;
        Fri, 29 Aug 2025 15:01:55 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:8d0a:2553:5881:1318? ([2600:8803:e7e4:1d00:8d0a:2553:5881:1318])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-315afe11ca1sm1702399fac.18.2025.08.29.15.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 15:01:55 -0700 (PDT)
Message-ID: <f83e3204-6033-4de4-b112-e474dbd8861c@baylibre.com>
Date: Fri, 29 Aug 2025 17:01:54 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/6] docs: iio: add documentation for ade9000 driver
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250829115227.47712-1-antoniu.miclaus@analog.com>
 <20250829115227.47712-6-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250829115227.47712-6-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/29/25 6:41 AM, Antoniu Miclaus wrote:
> Add documentation for ade9000 driver which describes the driver
> device files and shows how the user may use the ABI for various
> scenarios (configuration, measurement, etc.).

This is quite helpful to get the high-level picture of how this
is supposed to work.

> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v6:
>  - add RMS channel documentation with scale and calibbias
>  - add separate scale docs for each power type
>  - improve calibration section explanation
>  - focus events on RMS voltage instead of instantaneous
>  - add filter_type attributes documentation
>  - update examples to use RMS voltage events
>  - complete device file attribute tables
>  Documentation/iio/ade9000.rst | 292 ++++++++++++++++++++++++++++++++++
>  Documentation/iio/index.rst   |   1 +
>  2 files changed, 293 insertions(+)
>  create mode 100644 Documentation/iio/ade9000.rst
> 
> diff --git a/Documentation/iio/ade9000.rst b/Documentation/iio/ade9000.rst
> new file mode 100644
> index 000000000000..869ba154653e
> --- /dev/null
> +++ b/Documentation/iio/ade9000.rst
> @@ -0,0 +1,292 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===============
> +ADE9000 driver
> +===============
> +
> +This driver supports Analog Device's ADE9000 energy measurement IC on SPI bus.
> +
> +1. Supported devices
> +====================
> +
> +* `ADE9000 <https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9000.pdf>`_
> +
> +The ADE9000 is a highly accurate, fully integrated, multiphase energy and power
> +quality monitoring device. Superior analog performance and a digital signal
> +processing (DSP) core enable accurate energy monitoring over a wide dynamic
> +range. An integrated high end reference ensures low drift over temperature
> +with a combined drift of less than ±25 ppm/°C maximum for the entire channel
> +including a programmable gain amplifier (PGA) and an analog-to-digital
> +converter (ADC).
> +
> +2. Device attributes
> +====================
> +
> +Power and energy measurements are provided for voltage, current, active power,
> +reactive power, apparent power, and power factor across three phases.
> +
> +Each IIO device has a device folder under ``/sys/bus/iio/devices/iio:deviceX``,
> +where X is the IIO index of the device. Under these folders reside a set of
> +device files, depending on the characteristics and features of the hardware
> +device in question. These files are consistently generalized and documented in
> +the IIO ABI documentation.
> +
> +The following tables show the ADE9000 related device files, found in the
> +specific device folder path ``/sys/bus/iio/devices/iio:deviceX``.
> +
> ++---------------------------------------------------+----------------------------------------------------------+
> +| Current measurement related device files          | Description                                              |
> ++---------------------------------------------------+----------------------------------------------------------+
> +| in_current[0-2]_raw                               | Raw current measurement for phases A, B, C.              |
> ++---------------------------------------------------+----------------------------------------------------------+
> +| in_current[0-2]_scale                             | Scale for current channels.                              |
> ++---------------------------------------------------+----------------------------------------------------------+
> +| in_current[0-2]_calibscale                        | Calibration gain for current channels (AIGAIN reg).      |

We should probably clarify that this is the instantaneous current.

Also missing a row divider here?

> +| in_altcurrent[0-2]_rms_raw                        | RMS current measurement for phases A, B, C.              |
> ++---------------------------------------------------+----------------------------------------------------------+
> +| in_altcurrent[0-2]_rms_scale                      | Scale for RMS current channels.                          |
> ++---------------------------------------------------+----------------------------------------------------------+
> +| in_altcurrent[0-2]_rms_calibbias                  | RMS offset correction for current channels (IRMSOS reg). |
> ++---------------------------------------------------+----------------------------------------------------------+
> +
> ++---------------------------------------------------+----------------------------------------------------------+
> +| Voltage measurement related device files          | Description                                              |
> ++---------------------------------------------------+----------------------------------------------------------+
> +| in_voltage[0-2]_raw                               | Raw voltage measurement for phases A, B, C.              |
> ++---------------------------------------------------+----------------------------------------------------------+
> +| in_voltage[0-2]_scale                             | Scale for voltage channels.                              |
> ++---------------------------------------------------+----------------------------------------------------------+
> +| in_voltage[0-2]_calibscale                        | Calibration gain for voltage channels (AVGAIN reg).      |

row divider?

> +| in_voltage[0-2]_frequency                         | Measured line frequency for phases A, B, C.              |

And these are instantaneous voltage.

> ++---------------------------------------------------+----------------------------------------------------------+
> +| in_altvoltage[0-2]_rms_raw                        | RMS voltage measurement for phases A, B, C.              |
> ++---------------------------------------------------+----------------------------------------------------------+
> +| in_altvoltage[0-2]_rms_scale                      | Scale for RMS voltage channels.                          |
> ++---------------------------------------------------+----------------------------------------------------------+
> +| in_altvoltage[0-2]_rms_calibbias                  | RMS offset correction for voltage channels (VRMSOS reg). |
> ++---------------------------------------------------+----------------------------------------------------------+
> +
> ++---------------------------------------------------+----------------------------------------------------------+
> +| Power measurement related device files            | Description                                              |
> ++---------------------------------------------------+----------------------------------------------------------+
> +| in_power[0-2]_active_raw                          | Active power measurement for phases A, B, C.             |
> ++---------------------------------------------------+----------------------------------------------------------+
> +| in_power[0-2]_active_scale                        | Scale for active power channels.                         |
> ++---------------------------------------------------+----------------------------------------------------------+
> +| in_power[0-2]_active_calibbias                    | Calibration offset for active power (xWATTOS regs).      |
> ++---------------------------------------------------+----------------------------------------------------------+
> +| in_power[0-2]_active_calibscale                   | Calibration gain for active power (APGAIN reg).          |
> ++---------------------------------------------------+----------------------------------------------------------+
> +| in_power[0-2]_reactive_raw                        | Reactive power measurement for phases A, B, C.           |
> ++---------------------------------------------------+----------------------------------------------------------+
> +| in_power[0-2]_reactive_scale                      | Scale for reactive power channels.                       |
> ++---------------------------------------------------+----------------------------------------------------------+
> +| in_power[0-2]_reactive_calibbias                  | Calibration offset for reactive power (xVAROS regs).     |
> ++---------------------------------------------------+----------------------------------------------------------+
> +| in_power[0-2]_apparent_raw                        | Apparent power measurement for phases A, B, C.           |
> ++---------------------------------------------------+----------------------------------------------------------+
> +| in_power[0-2]_apparent_scale                      | Scale for apparent power channels.                       |
> ++---------------------------------------------------+----------------------------------------------------------+
> +| in_power[0-2]_powerfactor                         | Power factor for phases A, B, C.                         |
> ++---------------------------------------------------+----------------------------------------------------------+
> +
> ++---------------------------------------------------+----------------------------------------------------------+
> +| Energy measurement related device files           | Description                                              |
> ++---------------------------------------------------+----------------------------------------------------------+
> +| in_energy[0-2]_active_raw                         | Active energy measurement for phases A, B, C.            |
> ++---------------------------------------------------+----------------------------------------------------------+
> +| in_energy[0-2]_reactive_raw                       | Reactive energy measurement for phases A, B, C.          |
> ++---------------------------------------------------+----------------------------------------------------------+
> +| in_energy[0-2]_apparent_raw                       | Apparent energy measurement for phases A, B, C.          |
> ++---------------------------------------------------+----------------------------------------------------------+
> +
> ++------------------------------+------------------------------------------------------------------+
> +| Shared device attributes     | Description                                                      |
> ++------------------------------+------------------------------------------------------------------+
> +| name                         | Name of the IIO device.                                          |
> ++------------------------------+------------------------------------------------------------------+
> +| frequency                    | System line frequency configuration (50Hz/60Hz).                 |

Probably should call this one `mains_frequency`.

> ++------------------------------+------------------------------------------------------------------+
> +| scale                        | Shared PGA gain setting (1x, 2x, 4x) affecting all channels.     |

scale is already listed above. Does this mean that there are 2 scale
values that have to be applied to convert raw to processed?

> ++------------------------------+------------------------------------------------------------------+
> +| filter_type                  | Waveform buffer filter type (sinc4, sinc4+lp).                   |
> ++------------------------------+------------------------------------------------------------------+
> +| filter_type_available        | Available filter types for waveform buffer.                      |
> ++------------------------------+------------------------------------------------------------------+
> +

