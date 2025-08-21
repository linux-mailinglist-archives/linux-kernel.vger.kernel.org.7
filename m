Return-Path: <linux-kernel+bounces-779330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8EFB2F2B7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1112D16ECFB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876C12EACF9;
	Thu, 21 Aug 2025 08:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhnOeq+4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228732AE72
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755765779; cv=none; b=WI4T/ag7CkQgZJgtR3tR9551wgJyNZZjCy9u2DkirfnNyisWXBEoPoKDgzy15za10VJf95DAgiFQcsEP860tZs2LyXoKtvMQGZkt6p6I9lO9R75YSK+QMH14keUwG62/jCzpz+1vcZQiWqB6TXDtctnl2tfI4JGbQNI2ri6QoQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755765779; c=relaxed/simple;
	bh=I5NofY1I/J3cD2I9Jah37QRoad7PVZJEMc37nY7nYhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjUcNfIMQCIEb3eVhCEwG+OjsM3tUmpnzmWSpyl9TUpTZjfx3FC2y4lecx19S4R3FQRAP6mQ2cdH0mYiaYLezQry8pXq2ZyEVyyU7/IVwk2fdR1KuZSf6iomRCDXcrrSbuilGCodWQD+pJT+nu5INaZeuZ5uO6nwBScK+3oYJZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KhnOeq+4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755765776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BGmAixpDDtSx5//pjZh8mD9uLe+6T7TvnJDxd1HMKKM=;
	b=KhnOeq+439Je504Nn0UfA31a0+Miac3447z32OzbH6XVVlx8c/kitq8oAkwvGsqRrSW5BQ
	iXojWqlZpmTgw/Mv0GWojBiyWfQFBgR3QDsO7Owec1valaS3Ta0pq2kinm5Ro5Vc8pwQto
	DI3V0AO2Jd+8tCvHBxjJxTW8/HWsau0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-J_fkF5NUPDaMrZIvIbTjRw-1; Thu, 21 Aug 2025 04:42:54 -0400
X-MC-Unique: J_fkF5NUPDaMrZIvIbTjRw-1
X-Mimecast-MFC-AGG-ID: J_fkF5NUPDaMrZIvIbTjRw_1755765773
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a15f10f31so10374865e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755765773; x=1756370573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGmAixpDDtSx5//pjZh8mD9uLe+6T7TvnJDxd1HMKKM=;
        b=kf5kUHEsuYYeeFjXIlmNi4rzyfUjv/yUzeg31OElMPgUq1oGqlZrPBFtbP3yqIiK6T
         ptLvjhtTXNBMd0JJlsRnuW6pu0pm0EA22FIPr4kZwA9emvlM8Yez05NSjlxZCbCVNLJT
         oVLFJNkgv5/DWjV+s+mIJMFA9j/iZOm+/+V2+utzTlNWOi21JoCHdILzvsYlajSpBI83
         y44kAouzbjSwLomvhdRkVAJyEbwGSMwN5C6rmicbQ79qyHXBE5Q8EWImrzGThxBm7OWN
         e6EVqX+l7aKG1vcZSewLRnRytig6f3zy0M+0O83VFNN+kUDzQUex9bkRdT9/kLVY1JN0
         SqmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB6WBxVFkpkTq8stx4qYL+nYqtLhbZU98oR/jOOnLpW/JNirLlabKgL+2NwuHk0Da7T4kK3kmFeHufm6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuFGSEyOBz0O3G4X+/3dGvOs1luds//qSyA0RkXEr5B5WK1jai
	MHP7VjDSYpUMzpm9wgHTWZgxgasMSufCNRY5aRId+hrf73D7BSKhDswKRRpr5O8WyVTPdgqnY1Z
	csZt6EKZ0Qd+hzysJX3ZD+aFyRMLqRRwD6AchWGHG3I6xXQWbzkuXtNgaQVE+yN8bIQ==
X-Gm-Gg: ASbGncuV/4z51KSVVb6MGXcsv6oTms/Fm3BCMjiBZ0ZM5z5o/eqB5el8obT1oiQw+jJ
	3ykUn2t8QXaogq7KAWjDt74+DlTFhTF9L7h6zON7gF7aLuKhU2+Z11ScFQAzSk8rVfDLiTdadQR
	qBStjDineiDynknAnDmUpbov2f3ovi5TAVMN6unVGEnC0olQyOc6sZ7WJVqO3eTGj/5DsOWcLAW
	GDGbcIbMnLjv3d0IJZ6RHm8IDTwUvlsM/FGmPapnKIf9Omxo20iUcaSTKj73sOeuZHQAC9+qo02
	EouiY4hf7vtB0hj+U1ES1vmdAgLAAwRS
X-Received: by 2002:a05:600c:a07:b0:459:443e:b18a with SMTP id 5b1f17b1804b1-45b4d9f41f4mr14568645e9.14.1755765773201;
        Thu, 21 Aug 2025 01:42:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwZkrl5fXD20Znm+tAZTWUxfgrHTe58SkGcqEtQUMP3n+ZiDjZ6JOOe6sj+jRr77tMsBIMLg==
X-Received: by 2002:a05:600c:a07:b0:459:443e:b18a with SMTP id 5b1f17b1804b1-45b4d9f41f4mr14568225e9.14.1755765772624;
        Thu, 21 Aug 2025 01:42:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4db2ab4asm18352405e9.8.2025.08.21.01.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 01:42:52 -0700 (PDT)
Date: Thu, 21 Aug 2025 04:42:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: andriy.shevchenko@intel.com, harald.mommer@oss.qualcomm.com,
	quic_msavaliy@quicinc.com, broonie@kernel.org,
	virtio-dev@lists.linux.dev, viresh.kumar@linaro.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	hdanton@sina.com, qiang4.zhang@linux.intel.com,
	alex.bennee@linaro.org, quic_ztu@quicinc.com
Subject: Re: [PATCH v4 2/3] virtio-spi: Add virtio-spi.h
Message-ID: <20250821044231-mutt-send-email-mst@kernel.org>
References: <20250820084944.84505-1-quic_haixcui@quicinc.com>
 <20250820084944.84505-3-quic_haixcui@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820084944.84505-3-quic_haixcui@quicinc.com>

On Wed, Aug 20, 2025 at 04:49:43PM +0800, Haixu Cui wrote:
> Add virtio-spi.h header for virtio SPI.
> 
> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
> ---
>  MAINTAINERS                     |   5 +
>  include/uapi/linux/virtio_spi.h | 185 ++++++++++++++++++++++++++++++++
>  2 files changed, 190 insertions(+)
>  create mode 100644 include/uapi/linux/virtio_spi.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index daf520a13bdf..3e289677ca18 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -26760,6 +26760,11 @@ S:	Maintained
>  F:	include/uapi/linux/virtio_snd.h
>  F:	sound/virtio/*
>  
> +VIRTIO SPI DRIVER
> +M:	Haixu Cui <quic_haixcui@quicinc.com>
> +S:	Maintained
> +F:	include/uapi/linux/virtio_spi.h
> +

I would add a mailing list:

virtualization@lists.linux-foundation.org


>  VIRTUAL BOX GUEST DEVICE DRIVER
>  M:	Hans de Goede <hansg@kernel.org>
>  M:	Arnd Bergmann <arnd@arndb.de>
> diff --git a/include/uapi/linux/virtio_spi.h b/include/uapi/linux/virtio_spi.h
> new file mode 100644
> index 000000000000..b55877b3e525
> --- /dev/null
> +++ b/include/uapi/linux/virtio_spi.h
> @@ -0,0 +1,185 @@
> +/* SPDX-License-Identifier: BSD-3-Clause */
> +/*
> + * Copyright (C) 2023 OpenSynergy GmbH
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
> +#define VIRTIO_SPI_CPHA			_BITUL(0)
> +/* Clock is high when IDLE */
> +#define VIRTIO_SPI_CPOL			_BITUL(1)
> +/* Chip Select is active high */
> +#define VIRTIO_SPI_CS_HIGH			_BITUL(2)
> +/* Transmit LSB first */
> +#define VIRTIO_SPI_MODE_LSB_FIRST		_BITUL(3)
> +/* Loopback mode */
> +#define VIRTIO_SPI_MODE_LOOP			_BITUL(4)
> +
> +/**
> + * struct virtio_spi_config - All config fields are read-only for the
> + * Virtio SPI driver
> + * @cs_max_number: maximum number of chipselect the host SPI controller
> + *   supports.
> + * @cs_change_supported: indicates if the host SPI controller supports to toggle
> + *   chipselect after each transfer in one message:
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
> + * @max_word_delay_ns: the maximum word delay supported, in nanoseconds.
> + *   A value of 0 indicates that word delay is unsupported.
> + *   Each transfer may consist of a sequence of words.
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
> +#define VIRTIO_SPI_RX_TX_SUPPORT_DUAL		_BITUL(0)
> +#define VIRTIO_SPI_RX_TX_SUPPORT_QUAD		_BITUL(1)
> +#define VIRTIO_SPI_RX_TX_SUPPORT_OCTAL		_BITUL(2)
> +	__u8 tx_nbits_supported;
> +	__u8 rx_nbits_supported;
> +	__le32 bits_per_word_mask;
> +#define VIRTIO_SPI_MF_SUPPORT_CPHA_0		_BITUL(0)
> +#define VIRTIO_SPI_MF_SUPPORT_CPHA_1		_BITUL(1)
> +#define VIRTIO_SPI_MF_SUPPORT_CPOL_0		_BITUL(2)
> +#define VIRTIO_SPI_MF_SUPPORT_CPOL_1		_BITUL(3)
> +#define VIRTIO_SPI_MF_SUPPORT_CS_HIGH		_BITUL(4)
> +#define VIRTIO_SPI_MF_SUPPORT_LSB_FIRST		_BITUL(5)
> +#define VIRTIO_SPI_MF_SUPPORT_LOOPBACK		_BITUL(6)
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
> -- 
> 2.34.1
> 


