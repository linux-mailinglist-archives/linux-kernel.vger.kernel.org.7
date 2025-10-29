Return-Path: <linux-kernel+bounces-875831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F36C19E9C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D68FC3542CA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B652EA72A;
	Wed, 29 Oct 2025 11:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d2Ab3UA0"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60C62D8DC8
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761735677; cv=none; b=l12+h4UNccfvrjeGGRIpwArHdezt/fJUpntY9fo+8uYbdwTJVlrij9yxshTwVbK7nXDE2atQ2CHcYpq63U7bcko8j/MCSjmAXqqpb1rodQkuh5mv9ptrHpqjxByeuGB8IKazaEqOrfCv9I2SCYCLZtJMOrEpo1WjteGNT7WgUVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761735677; c=relaxed/simple;
	bh=hXAUBSkUqybhhXZyTYQ9DuFdsPNmrVbpbQYulz4IDPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iIrGn/yQrx7/x9ndNfwtasiK/VmOqiMRr9QpPy8jCwuTRNC4mywWKTf+7NvniqEvtB5AOZ6+4YfPEdeg0R3YmEHoJ5Q0e+iwdpU+lohkMpgjVWXsTonPfaoBfu5qc8nSwkWgw8GBcLJ2UVkseRqcjOZD5QWsDVT5xRWjLs08CZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d2Ab3UA0; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-891208f6185so649086485a.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761735675; x=1762340475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQWDpVejCHNnm4EwaVB6drbJOWDW2V1Yh8yBgxJN8YA=;
        b=d2Ab3UA0YObITkdK6FoBmoK0OZVlsKdKYJPms8kn3nOg2HLJfJA+G1sL/ZyOVvf8wo
         KBylXVJ/xk5CYCcoW7Oj2veY2xoOF8Y7ksl6ogjdGO2jvdKIL6I/3WN3kXwammHa4Hex
         niBiJrBggqs+lcEY7KMiyFCzSLWKcsxyKQpi95l2JndUav0dEOJahdoRI7a8K1m9jdph
         XYiFWMHG8tvaT1g8qbQqg9q05UFZ1BCSUBEtvu2TJhg5ylTRCSh1iC3ysxaLA8iY1EY0
         SQE7mh9veBTJvJl5IJXUD4yFccv5hgRI7/On1htphSMKry5IsVfP/xcir+5EU0FmdYoe
         fdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761735675; x=1762340475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQWDpVejCHNnm4EwaVB6drbJOWDW2V1Yh8yBgxJN8YA=;
        b=Zc9nagc8FpC5wWGLF9S9ojWESfhaBh6RocJU9VEE1FoiQnf71KRerVZqhHZj3N3N5g
         z5h2ou7LBgmlvfbo/U4whN3VA6zHclVWZ8jq225tFmI2cwQJTsCVlUcXyXL+0yorH1qQ
         4reqZTcP5jYXD9RQVjM424liFgRyBmvnlmpUh35Sfwa8MPMig8FonMuP59lg+3kSoCZK
         IzUKf0WyOJZLaF6/EOF7YZ03TxKlPnGDk6l3sRr7960FknLKXcDNy3Xra/AlqARjewxA
         57blDoODazZKNdfA2oQItD/IRDUe5seSbCA7QCA5Uto4KhZsgibCyqS7II626VCTBzkj
         u2TQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfGHf8wsSkQQAK7AVUZLzkj45ALLK86njkL67mOIWVKnIzDmt1k18tL4yk612t+84W33KbdokbFrYgcFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEvzS2Hdk5gv/pLxjSKVgaUIDJlqwxapdIA3hue83aCP/ldEKb
	sqIh+JjUEFvsw93n1v3b4a98sQ6hnIX45U0WcVGNr8Ve4ZGRfu7k2tQGdsuZeReLs33D05+iNqw
	NE6R77b4z4+e9gP+/TIlUl7Ymppn6GmQ5xj+CiYyQuQ==
X-Gm-Gg: ASbGncs8SdLwB03mpRlp2Mt85+sCq5QqiuZh0dKspGWpmJi23sdBWzTxXCtgdzK+xQq
	YN2zI89YkEbhYcFcqPBiNT8b4lOXuJK9lk/XUIS6RagTYneNLwQR35BUAMRfyliltKdLf3gaBH/
	aP296BTK3rUuzygc+E9MpkXqI9G7QgpLOa/cA9ZCPqOm1vU6O9DZZCTkGNfQl1o4r2ZpZ7RHZFO
	d7690LC+BwE+AOEz5m7Kn2J+shCbaecf5cVedsXUtBvfwy0RUdod573RPoHhvTi3Y1zwTiNajV+
	mWXXS46FDxwQxEycGA==
X-Google-Smtp-Source: AGHT+IHWP5Cbc3G4W0Ik0NLLQcf3Rmww0dInCJA9bBcxiEAnG512YgHlmnNkFU3hoCfwOl86Kin1pgVlI3IyVxMDBkU=
X-Received: by 2002:a05:620a:7019:b0:829:fa5d:6f0d with SMTP id
 af79cd13be357-8a8efb03ddfmr306069985a.82.1761735674490; Wed, 29 Oct 2025
 04:01:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027-cpu_cluster_component_pm-v1-0-31355ac588c2@oss.qualcomm.com>
In-Reply-To: <20251027-cpu_cluster_component_pm-v1-0-31355ac588c2@oss.qualcomm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Wed, 29 Oct 2025 11:01:03 +0000
X-Gm-Features: AWmQ_bmBZ4u6Nr5AkhU0uSKV2P-I149L6WKOoDdLwfOOqdcc5hyzFz1zWOkxIwc
Message-ID: <CAJ9a7VipQh=y0o+6k=fLMMK408E5eGD6vhY2TKBMm+q63NUiWA@mail.gmail.com>
Subject: Re: [PATCH 00/12] coresight: Add CPU cluster funnel/replicator/tmc support
To: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, James Clark <james.clark@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, kernel@oss.qualcomm.com, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Jie Gan <jie.gan@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This entire set seems to initially check the generic power domain for
a list of associated CPUs, then check CPU state for all other
operations.

Why not simply use the generic power domain state itself, along with
the power up / down notifiers to determine if the registers are safe
to access? If the genpd is powered up then the registers must be safe
to access?

Regards

Mike

On Tue, 28 Oct 2025 at 06:28, Yuanfang Zhang
<yuanfang.zhang@oss.qualcomm.com> wrote:
>
> This patch series introduces support for CPU cluster local CoreSight comp=
onents,
> including funnel, replicator, and TMC, which reside inside CPU cluster
> power domains. These components require special handling due to power
> domain constraints.
>
> Unlike system-level CoreSight devices, CPU cluster local components share=
 the
> power domain of the CPU cluster. When the cluster enters low-power mode (=
LPM),
> the registers of these components become inaccessible. Importantly, `pm_r=
untime_get`
> calls alone are insufficient to bring the CPU cluster out of LPM, making
> standard register access unreliable in such cases.
>
> To address this, the series introduces:
> - Device tree bindings for CPU cluster local funnel, replicator, and TMC.
> - Introduce a cpumask to record the CPUs belonging to the cluster where t=
he
>   cpu cluster local component resides.
> - Safe register access via smp_call_function_single() on CPUs within the
>   associated cpumask, ensuring the cluster is power-resident during acces=
s.
> - Delayed probe support for CPU cluster local components when all CPUs of
>   this CPU cluster are offline, re-probe the component when any CPU in th=
e
>   cluster comes online.
> - Introduce `cs_mode` to link enable interfaces to avoid the use
>   smp_call_function_single() under perf mode.
>
> Patch summary:
> Patch 1: Adds device tree bindings for CPU cluster funnel/replicator/TMC =
devices.
> Patches 2=E2=80=933: Add support for CPU cluster funnel.
> Patches 4-6: Add support for CPU cluster replicator.
> Patches 7-10: Add support for CPU cluster TMC.
> Patch 11: Add 'cs_mode' to link enable functions.
> Patches 12-13: Add Coresight nodes for APSS debug block for x1e80100 and
> fix build issue.
>
> Verification:
>
> This series has been verified on sm8750.
>
> Test steps for delay probe:
>
> 1. limit the system to enable at most 6 CPU cores during boot.
> 2. echo 1 >/sys/bus/cpu/devices/cpu6/online.
> 3. check whether ETM6 and ETM7 have been probed.
>
> Test steps for sysfs mode:
>
> echo 1 >/sys/bus/coresight/devices/tmc_etf0/enable_sink
> echo 1 >/sys/bus/coresight/devices/etm0/enable_source
> echo 1 >/sys/bus/coresight/devices/etm6/enable_source
> echo 0 >/sys/bus/coresight/devices/etm0/enable_source
> echo 0 >/sys/bus/coresight/devicse/etm6/enable_source
> echo 0 >/sys/bus/coresight/devices/tmc_etf0/enable_sink
>
> echo 1 >/sys/bus/coresight/devices/tmc_etf1/enable_sink
> echo 1 >/sys/bus/coresight/devcies/etm0/enable_source
> cat /dev/tmc_etf1 >/tmp/etf1.bin
> echo 0 >/sys/bus/coresight/devices/etm0/enable_source
> echo 0 >/sys/bus/coresight/devices/tmc_etf1/enable_sink
>
> echo 1 >/sys/bus/coresight/devices/tmc_etf2/enable_sink
> echo 1 >/sys/bus/coresight/devices/etm6/enable_source
> cat /dev/tmc_etf2 >/tmp/etf2.bin
> echo 0 >/sys/bus/coresight/devices/etm6/enable_source
> echo 0 >/sys/bus/coresight/devices/tmc_etf2/enable_sink
>
> Test steps for sysfs node:
>
> cat /sys/bus/coresight/devices/tmc_etf*/mgmt/*
>
> cat /sys/bus/coresight/devices/funnel*/funnel_ctrl
>
> cat /sys/bus/coresight/devices/replicator*/mgmt/*
>
> Test steps for perf mode:
>
> perf record -a -e cs_etm//k -- sleep 5
>
> Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
> ---
> Yuanfang Zhang (12):
>       dt-bindings: arm: coresight: Add cpu cluster tmc/funnel/replicator =
support
>       coresight-funnel: Add support for CPU cluster funnel
>       coresight-funnel: Handle delay probe for CPU cluster funnel
>       coresight-replicator: Add support for CPU cluster replicator
>       coresight-replicator: Handle delayed probe for CPU cluster replicat=
or
>       coresight-replicator: Update mgmt_attrs for CPU cluster replicator =
compatibility
>       coresight-tmc: Add support for CPU cluster ETF and refactor probe f=
low
>       coresight-tmc-etf: Refactor enable function for CPU cluster ETF sup=
port
>       coresight-tmc: Update tmc_mgmt_attrs for CPU cluster TMC compatibil=
ity
>       coresight-tmc: Handle delayed probe for CPU cluster TMC
>       coresight: add 'cs_mode' to link enable functions
>       arm64: dts: qcom: x1e80100: add Coresight nodes for APSS debug bloc=
k
>
>  .../bindings/arm/arm,coresight-dynamic-funnel.yaml |  23 +-
>  .../arm/arm,coresight-dynamic-replicator.yaml      |  22 +-
>  .../devicetree/bindings/arm/arm,coresight-tmc.yaml |  22 +-
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi             | 885 +++++++++++++++=
++++++
>  arch/arm64/boot/dts/qcom/x1p42100.dtsi             |  12 +
>  drivers/hwtracing/coresight/coresight-core.c       |   7 +-
>  drivers/hwtracing/coresight/coresight-funnel.c     | 260 +++++-
>  drivers/hwtracing/coresight/coresight-replicator.c | 343 +++++++-
>  drivers/hwtracing/coresight/coresight-tmc-core.c   | 396 +++++++--
>  drivers/hwtracing/coresight/coresight-tmc-etf.c    | 105 ++-
>  drivers/hwtracing/coresight/coresight-tmc.h        |  10 +
>  drivers/hwtracing/coresight/coresight-tnoc.c       |   3 +-
>  drivers/hwtracing/coresight/coresight-tpda.c       |   3 +-
>  include/linux/coresight.h                          |   3 +-
>  14 files changed, 1912 insertions(+), 182 deletions(-)
> ---
> base-commit: 01f96b812526a2c8dcd5c0e510dda37e09ec8bcd
> change-id: 20251016-cpu_cluster_component_pm-ce518f510433
>
> Best regards,
> --
> Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
>


--=20
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

