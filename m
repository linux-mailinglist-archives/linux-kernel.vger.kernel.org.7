Return-Path: <linux-kernel+bounces-879366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 481BAC22F0A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C973834F275
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3E122B8D0;
	Fri, 31 Oct 2025 02:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXuLjibj"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C247D21146C
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761876121; cv=none; b=YDkQh59rNgIF2lPD3k2Pnti88uvZT17K3rTOfTlYH1Y8weQKivX8LN+jSLH15UQKnLPBwpdIL8xsUgwLmAs0QBP6LHArtu/WJp15X2BNOWBpJ+9Ec1+IRmoAVbEQUXF6+rdAuSfTt4+NZwc7wT22IsdyVxpfc+9cGMvBrIkfF4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761876121; c=relaxed/simple;
	bh=QxME3CqoU5WVypaxjbRMFvY4qYl0FMCkvisldLZvurc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sTqVaAJva7JZHkZGjYhr7GmSCSpp3DKxeLSZdGDcyHKTh3nT00K+Rw1/9IF0LLYaC4zSEVhfd751XPEqVAvYt2Sv81liYlXbi5IEtFGCMULFR+LiCNjHHaCjMzaJnY7d96/Ca6M9qj0Kknle8VjSMsf7YxfvKMvYvk2kWm+0MQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXuLjibj; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-795be3a3644so10932956d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 19:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761876118; x=1762480918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrwdlpMXd2MUVO5Sx6kwMpVdymgf6ZjyIPGHeQY6juA=;
        b=KXuLjibjv7vh+KtJDlSyr6wSmrXFpA77lpvuQ56z2ocaML4Y0/YSBURtWvBI5PVEs4
         f1GfHu6ul0rfKODN25s97vIoU/x3qI0wlNNGyBFQf0GfnLKHYIA9G5xiW9k4q8jWG8Ke
         CsvxrM0Z/j1ALCltavdlYRmT+AjQKQhzSnD2CtbXK2aP08LbXDFt2cWhgZN9T+NLFgoB
         In0JqAyuHGSECRcEgh3GeWDsXF6pTuzHNoQE7iCwltt77GhuBlSK0P9Q1O5NUGtXfumF
         22gukVHey7DCGA+X9kXu2yQDuVkxWz9wzf5KIt3NFA726gg52bu30cLOFNzFqCtd11MR
         +tNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761876118; x=1762480918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YrwdlpMXd2MUVO5Sx6kwMpVdymgf6ZjyIPGHeQY6juA=;
        b=OT3nevy0Q2ZRG0zzVvoXAb2coxmkBX+D1QOX7ycn2n2Vd3FKQ64iAX+X80l2FPRSw2
         fT4idmSoNvJcUjLjDRURudgkWR6WnBWI62foWB39787YaKGe8T5YvYlmwFiUg27QvTGm
         sv4qvc6LnyzrdOvFAG4sgp5ZWM+2nuFiwZ/UDUhCbCjTw8LXSyP0LRGuv2uxjFYs0xDJ
         MecPG/yTnbQxyRd8did+KXqc9AGDSX0eGhv2UxugbgGGNzB0SSDfRkZg5S9URFbPwUOK
         4YeWeFg+HxaUNHZZOV8okkCqoMTGw2YHuiYLbdEl1AtRqd9+2pHdKHNNP9ixZDvGyrnY
         pE5g==
X-Forwarded-Encrypted: i=1; AJvYcCXMCvBgkx2KrPTXEAwbRO/u9p9ydsdzyFNujEjmBHSsTtDAvzZ68Roal63cZVUd4+9di29ObA9cqiWfnWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjTksGiqQj7UF2r3KvPFHJgXfoIMi1QQNQ8w8+Zc9femA5N2+B
	1j1OHQJutGULk0+Ov5SqZ9gfTyYQNwS+6KMuqNFSnU9nd94HORVN37+mE4Uskepm7KsIsfyeVzN
	bO49f1JgmN5s5TO/gFEKweooS4blvRYE=
X-Gm-Gg: ASbGnctlhULTxIACUcPuHr2OfNTbgx8t3s/iJFDBhNx0F4Ko5OZUKXDP79Is+uNwiUe
	XpwgrsO6bJXRZWXafGLSRauTZHyCvQYC6MYh5MU0T7R0AtBsAgQ5PpJN1r3HpcUElc43rL83qpy
	4e/lAiPyjwvXwKS7pbM8ZA6gc1Jiu8ksk3AhpnJR5YQDpxjAIuKKXJ/LVd6H+wvBKlW980WWfZb
	1m3mYx6NbYPS11HSdc0DslKNZ1pDtTo49jvZJWCusVvJxwBOCIqyZ9/MC8pVEmsNM7AAIpc
X-Google-Smtp-Source: AGHT+IFJXhBSLQEH3y/DpMWVvZaDN5VWPuxyaonyI4/RyEd4qmQGvExMvoVpZMKSHMrsXISgP0ElpwpVoL3Zh9xbpfs=
X-Received: by 2002:a05:6214:cc1:b0:87c:21ce:3868 with SMTP id
 6a1803df08f44-8802f45155emr25798186d6.34.1761876117654; Thu, 30 Oct 2025
 19:01:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030193955.107148-1-i@rong.moe>
In-Reply-To: <20251030193955.107148-1-i@rong.moe>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Thu, 30 Oct 2025 19:01:46 -0700
X-Gm-Features: AWmQ_bmH4-J_1lzYI7OXn4HTKFQqpbq6h2nRa8vejurreeSBQ5FnhakNMwJ9y74
Message-ID: <CAFqHKTk7n+aiEgRtGHNZn9gb00rviH7GhVPdh2Cwb4vTQK8Zwg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] platform/x86: lenovo-wmi-{capdata,other}: Add
 HWMON for fan speed
To: Rong Zhang <i@rong.moe>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, Armin Wolf <W_Armin@gmx.de>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Guenter Roeck <linux@roeck-us.net>, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 12:40=E2=80=AFPM Rong Zhang <i@rong.moe> wrote:
>
> Lenovo WMI Other Mode interface also supports querying or setting fan
> speed RPM. This capability is decribed by LENOVO_CAPABILITY_DATA_00.
> Besides, LENOVO_FAN_TEST_DATA provides reference data for self-test of
> cooling fans, including minimum and maximum fan speed RPM.
>
> This patchset turns lenovo-wmi-capdata01 into a unified driver (now
> named lenovo-wmi-capdata) for LENOVO_CAPABILITY_DATA_{00,01} and
> LENOVO_FAN_TEST_DATA; then adds HWMON support for lenovo-wmi-other:
>
>  - fanX_enable: enable/disable the fan (tunable)
>  - fanX_input: current RPM
>  - fanX_max: maximum RPM
>  - fanX_min: minimum RPM
>  - fanX_target: target RPM (tunable)
>
> This implementation doesn't require all capability data to be available,
> and is capable to expose interfaces accordingly:
>
>  - Having LENOVO_CAPABILITY_DATA_00: exposes fanX_{enable,input,target}
>  - Having LENOVO_CAPABILITY_DATA_01: exposes firmware_attributes
>  - Having LENOVO_FAN_TEST_DATA: exposes fanX_{max,min}
>
> Changes in v2:
> - Add a workaround for ACPI methods that return a 4B buffer for u32
>   (thanks Armin Wolf)
> - Fix function documentation (thanks kernel test bot)
> - Reword documentation (thanks Derek J. Clark)
> - Squash min/max reporting patch into the initial HWMON one (ditto)
> - Query 0x04050000 for interface availability (ditto)
>   - New parameter "expose_all_fans" to skip this check
> - Enforce min/max RPM constraint on set (ditto)
>   - New parameter "relax_fan_constraint" to disable this behavior
>   - Drop parameter "ignore_fan_cap", superseded by the next one
>   - New parameter "expose_all_fans" to expose fans w/o such data
> - Assume auto mode on probe (ditto)
> - Do not register HWMON device if no fan can be exposed
> - fanX_target: Return -EBUSY instead of raw target value when fan stops
> - Link to v1: https://lore.kernel.org/r/20251019210450.88830-1-i@rong.moe=
/
>
> Rong Zhang (6):
>   platform/x86: lenovo-wmi-helpers: convert returned 4B buffer into u32
>   platform/x86: Rename lenovo-wmi-capdata01 to lenovo-wmi-capdata
>   platform/x86: lenovo-wmi-{capdata,other}: Support multiple Capability
>     Data
>   platform/x86: lenovo-wmi-capdata: Add support for Capability Data 00
>   platform/x86: lenovo-wmi-capdata: Add support for Fan Test Data
>   platform/x86: lenovo-wmi-other: Add HWMON for fan speed RPM
>
>  .../wmi/devices/lenovo-wmi-other.rst          |  43 +-
>  drivers/platform/x86/lenovo/Kconfig           |   5 +-
>  drivers/platform/x86/lenovo/Makefile          |   2 +-
>  drivers/platform/x86/lenovo/wmi-capdata.c     | 545 ++++++++++++++++++
>  drivers/platform/x86/lenovo/wmi-capdata.h     |  46 ++
>  drivers/platform/x86/lenovo/wmi-capdata01.c   | 302 ----------
>  drivers/platform/x86/lenovo/wmi-capdata01.h   |  25 -
>  drivers/platform/x86/lenovo/wmi-helpers.c     |  21 +-
>  drivers/platform/x86/lenovo/wmi-other.c       | 501 +++++++++++++++-
>  9 files changed, 1134 insertions(+), 356 deletions(-)
>  create mode 100644 drivers/platform/x86/lenovo/wmi-capdata.c
>  create mode 100644 drivers/platform/x86/lenovo/wmi-capdata.h
>  delete mode 100644 drivers/platform/x86/lenovo/wmi-capdata01.c
>  delete mode 100644 drivers/platform/x86/lenovo/wmi-capdata01.h
>
>
> base-commit: e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
> --
> 2.51.0
>

Rong,

Excellent addition. Thank you for your work. I have no regressions on
my devices and no longer have erroneous fans reported on my system
with v2.

For the series,
Tested-by: Derek J. Clark <derekjohn.clark@gmail.com>

Thanks,
Derek

