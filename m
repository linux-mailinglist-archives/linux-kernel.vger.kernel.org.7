Return-Path: <linux-kernel+bounces-727643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5B7B01D78
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0296D560E59
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395AA2D3A60;
	Fri, 11 Jul 2025 13:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="idm+1zLI"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA77C2D3746
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752240570; cv=none; b=iIxaDgxe+bcwwfGHdjxNgHGXMVTI4mHit4qdwNygeWFNL/0bKPGSoDuJNS7C/RndLow+FtPtGv6FowbooVNg6cQiCQKV1t8tRavf9I5suULdM/ql4x2szpEzRObeXc/C0I9+uTyanFSDRAg2SQK9kU0fG3zwuKLesTkiA0cFxMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752240570; c=relaxed/simple;
	bh=WDiPIjuqiChPX+asKp37/ByLWlXgZKPqmpcoStrHRxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hc8tG031GHvqRiDG3CDUzIp+fxd/hLGG0oXHTGCAuFy0vZEPShZqQFSY3+MeTJwy+fhPhPXJ8HE55CkcsXcdPooIwByzVPx7nTaetCFt8uFT8U+cz+vxIphnVWm1soVhbEwnCBdpn89nEzGkra9bPDaISqV7SH6U/mfrrBKIyLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=idm+1zLI; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23aeac7d77aso18464335ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 06:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752240567; x=1752845367; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pPQRVC+gYXzA0BtSE8rtHH/2+eUDBChSDQmEkeHBXgE=;
        b=idm+1zLI9/PsnIdNl2AjPQmXZRdGyJf4BmfeAe0FmCmw3CfOCb5XcK56fFNOyW9bKN
         9hLHYqM/i4dS9ifqsHHEUsDrDl34xwMjHufMPq4cAlAhGqPg9VqYih2F/gY/LTmiGIRY
         zMJgcrB+QxAf/nzzS0Hj7B3ygDIrQon2YRQGCND0ktvK9KySusQ9V3XiJOnduOr8hMNA
         jMoYUiiMcFzixAqeIyRVgyVya/G75h+4Qj8p0i1vybz/BGt53Kea5KmaeIb3oqrKB7z3
         9pmw0YAtfooThSpEMQsMPv/YGQZo4jRW/A2Vrk/82rWD2/8CAbNMn6SNbha6pm+cz4yU
         z3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752240567; x=1752845367;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pPQRVC+gYXzA0BtSE8rtHH/2+eUDBChSDQmEkeHBXgE=;
        b=mOhiTl5PpddVs0Hv6nppwZ13oqI1QjtuKdzExz7jeARt01OA9oWW7Dp9ko4v0O0OFK
         bXCglx1mi9BUMc0rhg+c+oYgWqYM3m+g+nAcMyV7c/A0abYG0k4zaA3ICAYnHPHdRdRH
         /1dI+Vs8KF69nFjC3cw296+4jXpmLhyyD+GAbxvRDLx6ViTN38q1ngAUPkBkunVmInC5
         2NTh4pWdJUTpTKfNGzoLBI7btvtt4RST4uyYE/M55khDOUpgBzbgxWWsE0qOmbVj87J7
         yzMHxWrmedqaYvnRtQDpxG0n71YpibbSjvp86XJm3xRFZkyBB3GpWFx3X0stoIrmuV9v
         juVw==
X-Forwarded-Encrypted: i=1; AJvYcCXzbtFUh2xxOn8omFpPe+TbKDMM8j6xaRdf6xqGYN2K4LJtSNeajDbdm88bkcFab73NYp0VhXJSiM1fedY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvzFa/3MFqMp8QGFRs3uLOOAlXQhE3u1e0HpVajMECmOKU/349
	OKGW4tPVGBmlKUUfao+5qc1mLmb6eCYAXP7t6fm2EZibN5DJQdFWUVG6zptYH3HcSFCd8hDNQzL
	24e2p7JBetXGCHrBVinif3nV5qkxAX0gTm1dybKHRkA==
X-Gm-Gg: ASbGncsx/wPEzvxi22u45ENbPBXqeLmbJcK5Tjc8OKWcZ5P5QAJRkaf3YEwbvG7Szop
	4lVznyJf76Xy7Ul0lpr7c4dRD7b649O5Vq2FhKHK98TY9+gfc6XIQFQbKUMIyvz1G8F6rW0PHnF
	p4XjBAAAVE9lsXY7JiNmyMoGyaYViqGdbU4Y0UQcmsCezUNFRvjWkKLf/S6FqOjiqEgQDwvIpkl
	aVtLt03ckSunIXgtj7xbZI3pb4sTEr6mDfSGEmQ
X-Google-Smtp-Source: AGHT+IG4zXliACGrQprvEQ5wj7JsyfYLrvCmNiaEH+tMrZ+FZGuEDY+CASzdByOLlOs/WswgsUHGYzyvgG94wPmljLk=
X-Received: by 2002:a17:90b:4b8d:b0:313:b1a:3939 with SMTP id
 98e67ed59e1d1-31c50da140amr3325921a91.15.1752240566909; Fri, 11 Jul 2025
 06:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711094031.4171091-1-quic_jinlmao@quicinc.com>
In-Reply-To: <20250711094031.4171091-1-quic_jinlmao@quicinc.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Fri, 11 Jul 2025 14:29:14 +0100
X-Gm-Features: Ac12FXz2yLkWQDmM32aTY0N8Gj1hFRU1asfRpnUpH_TzU92dKa2GOxAV8v2hkGM
Message-ID: <CAJ9a7VhmHooDpht-gU7eAA5O028Tn=CVmCNHU6Qg+UYXp6kUQg@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] coresight: Add remote etm support
To: Mao Jinlong <quic_jinlmao@quicinc.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, James Clark <james.clark@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

The majority of this code should not be in the coresight drivers
directory as it is not actually coresight.

This seems to be a communications bus system for various SoC
components - one of which happens to be a remote etm. It really needs
to be in a qcom-qmi subdirectory - which would also remove your
reliance on the coresight maintainers for getting all the qmi drivers
upstreamed. I note that there is a CONFIG dependency of
QCOM_QMI_HELPERS, which implies there is already a set of QMI
functionality not in the coresight directory.

We already have  a dummy coresight driver to cover these cases where
the actual etm source or sink might be in a different subsystem. This
could be extended in a generic manner to have an associated driver /
component, with the dummy source then forwarding the enable / disable
commands and acting as the coresight device for the purposes of
enabling the trace path from source to sink.

Thus the "coresight-remote-etm" driver becomes "qmi-node-etm" driver,
with the proprietary comms info, instance IDs etc encapsulated away
from any generic coresight information, and has an associated
coresight-dummy-source to handle the connection to the coresight trace
framework. I imagine the association could easily be modeled in device
tree using a phandle reference.

This would not change your usage model, but would give better
separation between what is clearly the QMI comms subsystem, and what
is needed to handle coresight connectivity.

Moreover, having the generic coresight dummy driver extended in this
way would allow other underlying communication systems to be used on
other devices in future.

Best Regards

Mike


On Fri, 11 Jul 2025 at 10:40, Mao Jinlong <quic_jinlmao@quicinc.com> wrote:
>
> The system on chip (SoC) consists of main APSS(Applications processor
> subsytem) and additional processors like modem, lpass. There is
> coresight-etm driver for etm trace of APSS. Coresight remote etm driver
> is for enabling and disabling the etm trace of remote processors.
> It uses QMI interface to communicate with remote processors' software
> and uses coresight framework to configure the connection from remote
> etm source to TMC sinks.
>
> Example to capture the remote etm trace:
>
> Enable source:
> echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
> echo 1 > /sys/bus/coresight/devices/remote_etm0/enable_source
>
> Capture the trace:
> cat /dev/tmc_etf0 > /data/remote_etm.bin
>
> Disable source:
> echo 0 > /sys/bus/coresight/devices/remote_etm0/enable_source
>
> Changes since V5:
> 1. Fix the warning and error when compile.
> 2. Add traceid for remote etm.
> 3. Change qcom,qmi-id tp qcom,qmi-instance-id.
>
> Changes since V4:
> 1. Add coresight QMI driver
> 2. Add coresight qmi node and qcom,qmi-id of modem-etm in msm8996 dtsi
> V5: https://lwn.net/ml/all/20250424115854.2328190-1-quic_jinlmao@quicinc.com/
>
> Changes since V3:
> 1. Use different compatible for different remote etms in dt.
> 2. Get qmi instance id from the match table data in driver.
>
> Change since V2:
> 1. Change qcom,inst-id to qcom,qmi-id
> 2. Fix the error in code for type of remote_etm_remove
> 3. Depend on QMI helper in Kconfig
>
> Changes since V1:
> 1. Remove unused content
> 2. Use CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS as remote etm source type.
> 3. Use enabled instead of enable in driver data.
> 4. Validate instance id value where it's read from the DT.
>
> Mao Jinlong (5):
>   dt-bindings: arm: Add CoreSight QMI component description
>   coresight: Add coresight QMI driver
>   dt-bindings: arm: Add qcom,qmi-id for remote etm
>   coresight: Add remote etm support
>   arm64: dts: qcom: msm8996: Add coresight qmi node
>
>  .../bindings/arm/qcom,coresight-qmi.yaml      |  65 +++++
>  .../arm/qcom,coresight-remote-etm.yaml        |   9 +
>  arch/arm64/boot/dts/qcom/msm8996.dtsi         |  11 +
>  drivers/hwtracing/coresight/Kconfig           |  23 ++
>  drivers/hwtracing/coresight/Makefile          |   2 +
>  drivers/hwtracing/coresight/coresight-qmi.c   | 198 +++++++++++++
>  drivers/hwtracing/coresight/coresight-qmi.h   | 101 +++++++
>  .../coresight/coresight-remote-etm.c          | 262 ++++++++++++++++++
>  8 files changed, 671 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-qmi.yaml
>  create mode 100644 drivers/hwtracing/coresight/coresight-qmi.c
>  create mode 100644 drivers/hwtracing/coresight/coresight-qmi.h
>  create mode 100644 drivers/hwtracing/coresight/coresight-remote-etm.c
>
> --
> 2.25.1
>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

