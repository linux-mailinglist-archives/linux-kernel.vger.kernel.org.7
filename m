Return-Path: <linux-kernel+bounces-741108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E65B0E02C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAF5A1C80DA9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDA62EA495;
	Tue, 22 Jul 2025 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ey3Ss0rf"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7030A2EA156
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196973; cv=none; b=rmWvsqJ+7ZeudyhC0olplK6VnfaBbdlEPNOIR91XnTsbsr5RPzuMTT07+A3sx0eVBJsfFtHgA9BBK3hSb4bpA/B/lPYjTXK+NZTmCL/StkGWKnIwbAPK+AkJQBqqPiR2q5pV+YfBQnr+9Jqe3oDNvlCciNut/Xlrrz2Y96kDfXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196973; c=relaxed/simple;
	bh=8sr6LThGTFN/5LAOo0/+N4gENZSD+AbbBtmgTBNp9uY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pfxqZKii7QLVuUb0/dWHAxgq+pHytwXUg/UN3Uq4/962WxRNSpv9X/yAYqYi4IFXotkyor54ShF8b0pAheZ21BeWkMtt+0YyrFhh+QsjTJtI5E2gmlBS0wlah99/zKX0NcLVhIvqU/2nA21l1yr4LvRoIfPhnvGF1jRqytWWegk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ey3Ss0rf; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6129ff08877so8857519a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753196970; x=1753801770; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YKz1T7vmhDi74XbPi/EE55Hox/g8J5sLC+33/H3TOKg=;
        b=Ey3Ss0rfR/LbvhtEggkS/Zv6ugizL22CL97up/keGyqtBv8XaSWJv2jnutUZeoOucC
         Omib4sc2Jjj9z0Buo+49kA3obBdO2tA1Cn61boO8u04cqAzJSBJlJ8Hjk2Pwmie5R+po
         PRkQ6qAi773X3RPn/L6Pl3lrlrY4c9xAQR/5OCs/2nDTAsimZR34nyYIGOoEk8fqAlP5
         0okL+ZUsjEeU/VZiNeN7A4cccX5FE79JvchBk67p0gA6EIUiexCFIe4Q16JrNLRZsz+d
         PZSBinBjX1uowMKHFuwh9E3DhhtxAzE7SnZgwKJdkU0o3it575kGl/QVPU1rS0xcvGdQ
         MzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753196970; x=1753801770;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YKz1T7vmhDi74XbPi/EE55Hox/g8J5sLC+33/H3TOKg=;
        b=Z+5HIsoSPOS3Jnp49SDURIbDlSJCcpxtcvmKRwcyCyRzsVBGu6UlTe+iS259HT0WL+
         nzNXUs90ktehX0eH+TlP+n2xOGmJTvVFIgbtrSPwzIn4z6j+1QlbXn8NAFY/lvXhdFQA
         wzz7lbf4fdXNnuqXZKFLtLu5IcP/vOEuoDbwwNkukh/UQ046wRCxB10VxDqA6BKGg18d
         1W5OqemvoF5/ipDXAidIMrE+IrB21jbtB6VT6D4K9A8due3tmBt8JDdLKPPs9/vCsRDR
         LmHrc8LJ+q0lK4+L+2VDK8HsxltXDeunGlLXRfhrWv2XCDgdYCszGyts51xY7OMPcQYy
         0GfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1w7YxvSW8Imyp6hZ+xRCujd3XFRK8RPpcfJZtWJd6cHeiT/MP6NDqdJMbrFCtFYQLQA2DHtG7+M9b76M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXY43sgATHgK0TjQerHKPbt3TJvCCdRoa0FR67tl5EnlEU17Ci
	bJ/J5DBKXNaE+wxOmRnDIVoLm3uzURtt572xAMMsK+TE7yAWyJamzfe+yrOr2COSU0yrBw0aDsw
	v7n3kDVa5HiVuP0HGnTveknBRqkiT9qR2jMbLVFdN1w==
X-Gm-Gg: ASbGncuH4DJk5oTXZJnn12NSmrlvXJOoZU8KyTQx4VWSgss9sO2sMppgBz6YA/+JFmT
	l6XCx4hc6OaXEJtFABqmgbvBYrNMXtLnvT/uuq1N7NbTXbteb0Tuy6VdxoFpp/mJykuBrffSrwY
	HTXMclM2KTOrmdrIgSRTFgRxrUePWe7O3c9amvOGZ1Yb3iHMgV5zh+3My2GK2h1JtrbYNm0NdYZ
	j5SD8td
X-Google-Smtp-Source: AGHT+IGpbjpX0grZZPVQmZw54+wx4altW7i3KDxNPLIE1PMRey0GQaLdxv8J+phJGzB0ugLj/bW3oRXI/qzLkenwXwU=
X-Received: by 2002:a17:907:9703:b0:ae2:3544:8121 with SMTP id
 a640c23a62f3a-af1529e3c52mr389560266b.9.1753196969564; Tue, 22 Jul 2025
 08:09:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714063109.591-1-jie.gan@oss.qualcomm.com>
In-Reply-To: <20250714063109.591-1-jie.gan@oss.qualcomm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Tue, 22 Jul 2025 16:09:15 +0100
X-Gm-Features: Ac12FXyw9fjZ_hHkKsJzmg7jt57Reyq6o7fHyn-BAdPCUShE29PhKSCLcUeB0K4
Message-ID: <CAJ9a7ViCf=_wmLX93TzgT82vjZvbKj3XLbr8takyfC1niQESsg@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND 00/10] coresight: ctcu: Enable byte-cntr
 function for TMC ETR
To: Jie Gan <jie.gan@oss.qualcomm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, James Clark <james.clark@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Tingwei Zhang <quic_tingweiz@quicinc.com>, Yuanfang Zhang <quic_yuanfang@quicinc.com>, 
	Mao Jinlong <quic_jinlmao@quicinc.com>, Jie Gan <quic_jiegan@quicinc.com>, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi

I have had a look at a few of the patches. The buffer swap mechanism
appears to be good.

However there is a lot of byte-ctr code in the "core" tmc / etr source
files. As much of this code as possible needs to be moved to the
byte-cntr specifc source.

I suggest having a helper function such as qcom_byte_ctr_in_use() to
call from the core code, and if true then call back into the byte-cntr
specific code to do the specialist functionality.

One other possibility is to have a flag / enum in the tmc->drvdata
structure to indicate a variant. - e.g. TMC_STD, TMC_QCOM_BYTE_CTR,
set at initialisation stage to remove the need for checking the device
tree every call.

Regards

Mike

On Mon, 14 Jul 2025 at 07:31, Jie Gan <jie.gan@oss.qualcomm.com> wrote:
>
> The byte-cntr function provided by the CTCU device is used to count the
> trace data entering the ETR. An interrupt is triggered if the data size
> exceeds the threshold set in the BYTECNTRVAL register. The interrupt
> handler counts the number of triggered interruptions.
>
> Based on this concept, the irq_cnt can be used to determine whether
> the etr_buf is full. The ETR device will be disabled when the active
> etr_buf is nearly full or a timeout occurs. The nearly full buffer will
> be switched to background after synced. A new buffer will be picked from
> the etr_buf_list, then restart the ETR device.
>
> The byte-cntr reading functions can access data from the synced and
> deactivated buffer, transferring trace data from the etr_buf to userspace
> without stopping the ETR device.
>
> The byte-cntr read operation has integrated with the file node tmc_etr,
> for example:
> /dev/tmc_etr0
> /dev/tmc_etr1
>
> There are two scenarios for the tmc_etr file node with byte-cntr function:
> 1. BYTECNTRVAL register is configured and byte-cntr is enabled -> byte-cntr read
> 2. BYTECNTRVAL register is reset or byte-cntr is disabled -> original behavior
>
> Shell commands to enable byte-cntr reading for etr0:
> echo 0x10000 > /sys/bus/coresight/devices/ctcu0/irq_val
> echo 1 > /sys/bus/coresight/devices/tmc_etr0/enable_sink
> echo 1 > /sys/bus/coresight/devices/etm0/enable_source
> cat /dev/tmc_etr0
>
> Reset the BYTECNTR register for etr0:
> echo 0 > /sys/bus/coresight/devices/ctcu0/irq_val
>
> Changes in V3 resend:
> 1. rebased on next-20250711.
> Link to V3 - https://lore.kernel.org/all/20250624060438.7469-1-jie.gan@oss.qualcomm.com/
>
> Changes in V3:
> 1. The previous solution has been deprecated.
> 2. Add a etr_buf_list to manage allcated etr buffers.
> 3. Add a logic to switch buffer for ETR.
> 4. Add read functions to read trace data from synced etr buffer.
> Link to V2 - https://lore.kernel.org/all/20250410013330.3609482-1-jie.gan@oss.qualcomm.com/
>
> Changes in V2:
> 1. Removed the independent file node /dev/byte_cntr.
> 2. Integrated the byte-cntr's file operations with current ETR file
>    node.
> 3. Optimized the driver code of the CTCU that associated with byte-cntr.
> 4. Add kernel document for the export API tmc_etr_get_rwp_offset.
> 5. Optimized the way to read the rwp_offset according to Mike's
>    suggestion.
> 6. Removed the dependency of the dts patch.
> Link to V1 - https://lore.kernel.org/all/20250310090407.2069489-1-quic_jiegan@quicinc.com/
>
> Jie Gan (10):
>   coresight: core: Refactoring ctcu_get_active_port and make it generic
>   coresight: core: add a new API to retrieve the helper device
>   dt-bindings: arm: add an interrupt property for Coresight CTCU
>   coresight: ctcu: enable byte-cntr for TMC ETR devices
>   coresight: tmc: add etr_buf_list to store allocated etr_buf
>   coresight: tmc: add create/delete functions for etr_buf_node
>   coresight: tmc: add prepare/unprepare functions for byte-cntr
>   coresight: tmc: add a switch buffer function for byte-cntr
>   coresight: tmc: add read function for byte-cntr
>   arm64: dts: qcom: sa8775p: Add interrupts to CTCU device
>
>  .../testing/sysfs-bus-coresight-devices-ctcu  |   5 +
>  .../bindings/arm/qcom,coresight-ctcu.yaml     |  17 ++
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi         |   5 +
>  drivers/hwtracing/coresight/Makefile          |   2 +-
>  drivers/hwtracing/coresight/coresight-core.c  |  54 ++++
>  .../coresight/coresight-ctcu-byte-cntr.c      | 102 +++++++
>  .../hwtracing/coresight/coresight-ctcu-core.c | 113 ++++++--
>  drivers/hwtracing/coresight/coresight-ctcu.h  |  49 +++-
>  drivers/hwtracing/coresight/coresight-priv.h  |   4 +
>  .../hwtracing/coresight/coresight-tmc-core.c  |  70 ++++-
>  .../hwtracing/coresight/coresight-tmc-etr.c   | 270 ++++++++++++++++++
>  drivers/hwtracing/coresight/coresight-tmc.h   |  29 ++
>  12 files changed, 688 insertions(+), 32 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-ctcu
>  create mode 100644 drivers/hwtracing/coresight/coresight-ctcu-byte-cntr.c
>
> --
> 2.34.1
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

