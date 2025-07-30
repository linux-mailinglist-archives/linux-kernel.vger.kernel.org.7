Return-Path: <linux-kernel+bounces-750730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E929B1605F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10A763A66A7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7C6262FD9;
	Wed, 30 Jul 2025 12:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jmZoesxt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C099476
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753878713; cv=none; b=B+M65G36CVaHcTCFveUHT/48RrS+r4F/AUSJ+HmkgsBGtlmTYzQsFB/bkj9NibgLCAlpn3MGeGePFK8KyJd9zgBRlwja0pJX/NIRchPXsRBBvWv+ylNSv5rHd2vTQB9C/IXBzCUGLTO0VILFkxjbTBDFMppxJfShBHNvZYSVVTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753878713; c=relaxed/simple;
	bh=y0mhHymve2xd3EafMEuj5nzMjkwEl/iTHvZzMCqVvHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UgbgqKJN2oStYBCArawx3ZdEgBxKKfVewwGaVV2xPbWAIX8hKf4hrJZM0/5Hi1esuNLpT+FV/s7QfAcjl0rfzw3J1cZwNm1+vA11TVuMNUfi1tTBhXsqHzaCzqFlP1xsoNLHzgwAyfxaz5TC4t+O7nGzy8FYa15Q1pNq3HSNx74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jmZoesxt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UCRI2l032409
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:31:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oVvkZH8fL4jtpPMoVbOMqc+YwXp8pJW4I1NLZU7D5Yo=; b=jmZoesxtc+Cwh8uf
	z+QpltvlrMZx2KsiWcQyAvE6ULlYQJodVCAo/YRmHhz1DRLRWpX0W9QQFK9IneCC
	9n7xVyIYhN6rWASv1Oco80tYrBivFfRT/kKU4SLBn0pRWX/QSFLGeQ1F8ZgUzpHI
	Vyb2+E2uqSoDdi2xiaXSNQUhXvALb+/3l7dLGbwwS2qVft+skeV6A0CZH0dLFkWs
	cVrRFWGQ1iUZ8/7tx0iIgDojbCAjUioMpWVF87xCZQ1USmrmUGtJogOJz4FPG9Wd
	1+40BTElvuFZFcCtf3VFDWHMCKImCdUNrnahNrIHv7pKe679mSIbXILn152gn9ey
	gHNs1g==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484qda3n7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:31:50 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-2ffb3834eb5so3310369fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 05:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753878709; x=1754483509;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oVvkZH8fL4jtpPMoVbOMqc+YwXp8pJW4I1NLZU7D5Yo=;
        b=A/Ue4ochiKcPYKwIxgLA+tCcCn8r1Tr4Hltc0fLXm0qMyzSPsvcWuvbGV/dktu9eSP
         ao0RWQYpxGdG6oR0r626AbTHd+zzKewA5FPQNq3QGsuNKn4exRqYyIiwgu1dwbzFdiGj
         /Dba8v3dlFImP/VHgBGUpgkyVPeMDt8KTU21bUUBo6dP7CwxLFakuW2IQE1IoSQC7/4k
         mxfCnEqDeZOuSiADAAgW/U/fqYq91g1xBTFsh2x9Sx8oDgDXh7nZjoShhImn2O1My3ta
         nZj9XlvgixaDnKJkgIUPW+1HT1Rwk43P5AWm6pEg2aEU+49TaswUgsU+O6r053ytzUJm
         kxUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1dz0Mrz6LV9f5wvR4ilRBl+9bEAABnVrLORNcIL5lJaL3yBbcTchmR0RsSTY4jLZsyHqTSS19KxPA5So=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEcT+bJfPXPmPGrDiABZMDknzsLhL//j3IALeaMDVPduQ388dc
	Eul9UveOnE/vgIDh26vH6HNfS/yaFz1TdDFZdGv1v40Da2/wVy2JoAdN+NsZuRTcn18ZGVOdnsg
	38AxBCnHKMBSTEazckFNbGTW/a6sHjt9giYlRnlGG3QHtm23n81LuKsCkgTlbb1JATY0=
X-Gm-Gg: ASbGncv9ihwALgyIVyjxuKy2tmTkQuZHFaPSQAbPuVEYFZgo/MOFVGPNfVPNgeb1CxH
	6PZ1mNOUiM54JfufQg4pnHftOZNi1RSHSzLe0C1yCZTQ7KOQU55sa/bcKUljNwbOdCf0S9wSdSi
	38O3nV0tdjdTtZtgPsceBiM8Y490BB37YX3oGYvPpYs3AUSSN7wr/KnPwv1vZZ6ngCpXpumF3qy
	0jCXWMmahR2JcS7bCEtQkHocNuYSSQYTTaxtArtQsjU2sN3GNyZtd6105SjBGHGukC6KV7L+9Q0
	9AACaR2bcra8Qxd9jWud+lKgEXzhpU7LeKiUWxKDKGy854dsJA7Yqg==
X-Received: by 2002:a05:6870:649f:b0:306:a149:f4c0 with SMTP id 586e51a60fabf-30785c4c08amr2010237fac.23.1753878709135;
        Wed, 30 Jul 2025 05:31:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHa3gmzKUkt2JJpFPsXUuyaMKj2diJtxIRuyxdFH28u6rjOGyjqIyTZ+s5Q2Ph/TjPfmSTjDg==
X-Received: by 2002:a05:6870:649f:b0:306:a149:f4c0 with SMTP id 586e51a60fabf-30785c4c08amr2010170fac.23.1753878707965;
        Wed, 30 Jul 2025 05:31:47 -0700 (PDT)
Received: from [172.22.19.48] ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635aa3095sm733649666b.104.2025.07.30.05.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 05:31:46 -0700 (PDT)
Message-ID: <d962ed41-2566-432d-975d-9bab8d844c70@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 14:31:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 2/3] virtio-spi: Add virtio-spi.h
To: Haixu Cui <quic_haixcui@quicinc.com>, quic_msavaliy@quicinc.com,
        broonie@kernel.org, virtio-dev@lists.linux.dev,
        viresh.kumar@linaro.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, hdanton@sina.com,
        qiang4.zhang@linux.intel.com, alex.bennee@linaro.org
Cc: quic_ztu@quicinc.com, matti@qti.qualcomm.com
References: <20250724092746.1297608-1-quic_haixcui@quicinc.com>
 <20250724092746.1297608-3-quic_haixcui@quicinc.com>
Content-Language: en-US
From: Harald Mommer <harald.mommer@oss.qualcomm.com>
In-Reply-To: <20250724092746.1297608-3-quic_haixcui@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: PGkcdFqpJDvdsWKBafttlY4blTIaxjys
X-Authority-Analysis: v=2.4 cv=Pfv/hjhd c=1 sm=1 tr=0 ts=688a10b6 cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=H0x4yso8YIw0H6KSdXIA:9
 a=QEXdDO2ut3YA:10 a=vh23qwtRXIYOdz9xvnmn:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: PGkcdFqpJDvdsWKBafttlY4blTIaxjys
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA4OSBTYWx0ZWRfXyGZEij1tRlBR
 PHQm0NwmH0XuzA244aE85xLMvOIGL3qIfCMgK7lEAsiZkSey4YuK+XTwDfWRFa6tB2qwIFjM3iF
 PZ8QlYadQzvjZy6mhpfT18QD8M4j/zKKjEP+SqRnd0YnzcH14uBdfdL7IodrpKcP7df9hqpB8+X
 WnWtTzSwcBjZ2IWS/KIjjywt1NWG/EYnwo5+gSfEAYshXyA6w0v1kGpU0q1pAhw9tgbwUiuvk/i
 sWFvd0rjacaqudcBhdq7CcaUD3ESssu5jS+dD0Wi6vrwk7bEiAeIlf+Dq4fsxexbXzeuO9IchAn
 Rn+ZEl4FIs8+n50TLpCdtcyxxG3Z3K4Dvn9brLr+LDwLagvuxOpPLR2Wp73kvWH0bAo49kGmb8X
 idH3qC3k5shyXG+Y7NsqrMZGEyiXwWTFiMONuBGACqrDWJiweNryLbz7uucG0Qz23ptCoS8n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1015 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300089

Hello,

On 7/24/25 11:27, Haixu Cui wrote:
> Add virtio-spi.h header for virtio SPI.
> 
> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
> ---
>  include/uapi/linux/virtio_spi.h | 185 ++++++++++++++++++++++++++++++++
>  1 file changed, 185 insertions(+)
>  create mode 100644 include/uapi/linux/virtio_spi.h
> 
> diff --git a/include/uapi/linux/virtio_spi.h b/include/uapi/linux/virtio_spi.h
> new file mode 100644
> index 000000000000..db94f32bd229
> --- /dev/null
> +++ b/include/uapi/linux/virtio_spi.h
> @@ -0,0 +1,185 @@
> +/* SPDX-License-Identifier: BSD-3-Clause */
> +/*

Policy was to keep the old OpenSynergy copyright notice when up-streaming started when up-streaming started in OpenSynergy times. This is also the case here with those files.

The old "Copyright (C) 2023 OpenSynergy GmbH" still present in V3 must probably be kept on top of the Qualcomm copyright line.

Re-checked this in virtio_rtc_driver.c from my colleague who also transitioned from OpenSynergy to Qualcomm. Virtio RTC has landed in the meantime in the mainline kernel.

What's for sure is that this has not started in 2025.

> + * Copyright (C) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +#ifndef _LINUX_VIRTIO_VIRTIO_SPI_H
> +#define _LINUX_VIRTIO_VIRTIO_SPI_H
> +
> +#include <linux/types.h>
> +#include <linux/virtio_config.h>
> +#include <linux/virtio_ids.h>
> +#include <linux/virtio_types.h>
> +
> +/* Sample data on trailing clock edge */
> +#define VIRTIO_SPI_CPHA			BIT(0)
> +/* Clock is high when IDLE */
> +#define VIRTIO_SPI_CPOL			BIT(1)
> +/* Chip Select is active high */
> +#define VIRTIO_SPI_CS_HIGH		BIT(2)
> +/* Transmit LSB first */
> +#define VIRTIO_SPI_MODE_LSB_FIRST	BIT(3)
> +/* Loopback mode */
> +#define VIRTIO_SPI_MODE_LOOP		BIT(4)
> +
> +/*
> + * All config fields are read-only for the Virtio SPI driver
> + *
> + * @cs_max_number: maximum number of chipselect the host SPI controller
> + *   supports.
> + * @cs_change_supported: indicates if the host SPI controller supports to toggle
> + * chipselect after each transfer in one message:
> + *   0: unsupported, chipselect will be kept in active state throughout the
> + *      message transaction;
> + *   1: supported.
> + *   Note: Message here contains a sequence of SPI transfers.
> + * @tx_nbits_supported: indicates the supported number of bit for writing:
> + *   bit 0: DUAL (2-bit transfer), 1 for supported
> + *   bit 1: QUAD (4-bit transfer), 1 for supported
> + *   bit 2: OCTAL (8-bit transfer), 1 for supported
> + *   other bits are reserved as 0, 1-bit transfer is always supported.
> + * @rx_nbits_supported: indicates the supported number of bit for reading:
> + *   bit 0: DUAL (2-bit transfer), 1 for supported
> + *   bit 1: QUAD (4-bit transfer), 1 for supported
> + *   bit 2: OCTAL (8-bit transfer), 1 for supported
> + *   other bits are reserved as 0, 1-bit transfer is always supported.
> + * @bits_per_word_mask: mask indicating which values of bits_per_word are
> + *   supported. If not set, no limitation for bits_per_word.
> + * @mode_func_supported: indicates the following features are supported or not:
> + *   bit 0-1: CPHA feature
> + *     0b00: invalid, should support as least one CPHA setting
> + *     0b01: supports CPHA=0 only
> + *     0b10: supports CPHA=1 only
> + *     0b11: supports CPHA=0 and CPHA=1.
> + *   bit 2-3: CPOL feature
> + *     0b00: invalid, should support as least one CPOL setting
> + *     0b01: supports CPOL=0 only
> + *     0b10: supports CPOL=1 only
> + *     0b11: supports CPOL=0 and CPOL=1.
> + *   bit 4: chipselect active high feature, 0 for unsupported and 1 for
> + *     supported, chipselect active low is supported by default.
> + *   bit 5: LSB first feature, 0 for unsupported and 1 for supported,
> + *     MSB first is supported by default.
> + *   bit 6: loopback mode feature, 0 for unsupported and 1 for supported,
> + *     normal mode is supported by default.
> + * @max_freq_hz: the maximum clock rate supported in Hz unit, 0 means no
> + *   limitation for transfer speed.
> + * @max_word_delay_ns: the maximum word delay supported in ns unit,
> + *   0 means word delay feature is unsupported.
> + *   Note: Just as one message contains a sequence of transfers,
> + *         one transfer may contain a sequence of words.
> + * @max_cs_setup_ns: the maximum delay supported after chipselect is asserted,
> + *   in ns unit, 0 means delay is not supported to introduce after chipselect is
> + *   asserted.
> + * @max_cs_hold_ns: the maximum delay supported before chipselect is deasserted,
> + *   in ns unit, 0 means delay is not supported to introduce before chipselect
> + *   is deasserted.
> + * @max_cs_incative_ns: maximum delay supported after chipselect is deasserted,
> + *   in ns unit, 0 means delay is not supported to introduce after chipselect is
> + *   deasserted.
> + */
> +struct virtio_spi_config {
> +	/* # of /dev/spidev<bus_num>.CS with CS=0..chip_select_max_number -1 */
> +	__u8 cs_max_number;
> +	__u8 cs_change_supported;
> +#define VIRTIO_SPI_RX_TX_SUPPORT_DUAL		BIT(0)
> +#define VIRTIO_SPI_RX_TX_SUPPORT_QUAD		BIT(1)
> +#define VIRTIO_SPI_RX_TX_SUPPORT_OCTAL		BIT(2)
> +	__u8 tx_nbits_supported;
> +	__u8 rx_nbits_supported;
> +	__le32 bits_per_word_mask;
> +#define VIRTIO_SPI_MF_SUPPORT_CPHA_0		BIT(0)
> +#define VIRTIO_SPI_MF_SUPPORT_CPHA_1		BIT(1)
> +#define VIRTIO_SPI_MF_SUPPORT_CPOL_0		BIT(2)
> +#define VIRTIO_SPI_MF_SUPPORT_CPOL_1		BIT(3)
> +#define VIRTIO_SPI_MF_SUPPORT_CS_HIGH		BIT(4)
> +#define VIRTIO_SPI_MF_SUPPORT_LSB_FIRST		BIT(5)
> +#define VIRTIO_SPI_MF_SUPPORT_LOOPBACK		BIT(6)
> +	__le32 mode_func_supported;
> +	__le32 max_freq_hz;
> +	__le32 max_word_delay_ns;
> +	__le32 max_cs_setup_ns;
> +	__le32 max_cs_hold_ns;
> +	__le32 max_cs_inactive_ns;
> +};
> +
> +/*
> + * @chip_select_id: chipselect index the SPI transfer used.
> + *
> + * @bits_per_word: the number of bits in each SPI transfer word.
> + *
> + * @cs_change: whether to deselect device after finishing this transfer
> + *     before starting the next transfer, 0 means cs keep asserted and
> + *     1 means cs deasserted then asserted again.
> + *
> + * @tx_nbits: bus width for write transfer.
> + *     0,1: bus width is 1, also known as SINGLE
> + *     2  : bus width is 2, also known as DUAL
> + *     4  : bus width is 4, also known as QUAD
> + *     8  : bus width is 8, also known as OCTAL
> + *     other values are invalid.
> + *
> + * @rx_nbits: bus width for read transfer.
> + *     0,1: bus width is 1, also known as SINGLE
> + *     2  : bus width is 2, also known as DUAL
> + *     4  : bus width is 4, also known as QUAD
> + *     8  : bus width is 8, also known as OCTAL
> + *     other values are invalid.
> + *
> + * @reserved: for future use.
> + *
> + * @mode: SPI transfer mode.
> + *     bit 0: CPHA, determines the timing (i.e. phase) of the data
> + *         bits relative to the clock pulses.For CPHA=0, the
> + *         "out" side changes the data on the trailing edge of the
> + *         preceding clock cycle, while the "in" side captures the data
> + *         on (or shortly after) the leading edge of the clock cycle.
> + *         For CPHA=1, the "out" side changes the data on the leading
> + *         edge of the current clock cycle, while the "in" side
> + *         captures the data on (or shortly after) the trailing edge of
> + *         the clock cycle.
> + *     bit 1: CPOL, determines the polarity of the clock. CPOL=0 is a
> + *         clock which idles at 0, and each cycle consists of a pulse
> + *         of 1. CPOL=1 is a clock which idles at 1, and each cycle
> + *         consists of a pulse of 0.
> + *     bit 2: CS_HIGH, if 1, chip select active high, else active low.
> + *     bit 3: LSB_FIRST, determines per-word bits-on-wire, if 0, MSB
> + *         first, else LSB first.
> + *     bit 4: LOOP, loopback mode.
> + *
> + * @freq: the transfer speed in Hz.
> + *
> + * @word_delay_ns: delay to be inserted between consecutive words of a
> + *     transfer, in ns unit.
> + *
> + * @cs_setup_ns: delay to be introduced after CS is asserted, in ns
> + *     unit.
> + *
> + * @cs_delay_hold_ns: delay to be introduced before CS is deasserted
> + *     for each transfer, in ns unit.
> + *
> + * @cs_change_delay_inactive_ns: delay to be introduced after CS is
> + *     deasserted and before next asserted, in ns unit.
> + */
> +struct spi_transfer_head {
> +	__u8 chip_select_id;
> +	__u8 bits_per_word;
> +	__u8 cs_change;
> +	__u8 tx_nbits;
> +	__u8 rx_nbits;
> +	__u8 reserved[3];
> +	__le32 mode;
> +	__le32 freq;
> +	__le32 word_delay_ns;
> +	__le32 cs_setup_ns;
> +	__le32 cs_delay_hold_ns;
> +	__le32 cs_change_delay_inactive_ns;
> +};
> +
> +struct spi_transfer_result {
> +#define VIRTIO_SPI_TRANS_OK	0
> +#define VIRTIO_SPI_PARAM_ERR	1
> +#define VIRTIO_SPI_TRANS_ERR	2
> +	__u8 result;
> +};
> +
> +#endif /* #ifndef _LINUX_VIRTIO_VIRTIO_SPI_H */


