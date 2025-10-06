Return-Path: <linux-kernel+bounces-842814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5ECBBDABC
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 12:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B51A44E2655
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 10:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E4822A7F2;
	Mon,  6 Oct 2025 10:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WXVJ62bX"
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D1B226CF7
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 10:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759746121; cv=none; b=gK6MVJ9O0b6y9/4x/xVGUIkqD6SvPjNx/NmXiRE8M1u9Lf//Wk+XtA2w6YGzDMuVDpFNMCf/OinZ++zwW8pT/UVwUQ6JdXtzW+bubV4CVE9w1AFYuijRr+hhCn3IVfrqnoC/K7RJsAk5aL2eJIcnsi9XO0blB57AwFFJlFIvKAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759746121; c=relaxed/simple;
	bh=AJrCHogOFI5cKQaQS0F5R4X36lqcVoGB6kMJM/rOTkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a3Shg7agU5GCc2emkbizPeCqVu9X27TZq+94wkHg6YXXBPpkClO+7XNCwF9VXelvxN/KN9FFSgTf5BagOW8kms+t0jAJ83EBWzIB0grOZstRxHDbgsztc+MBDxTid/4bv+yEaHxKM4CEnwbgjhR6oktNQqLxE5zcqfqfmeTX7rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WXVJ62bX; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-63470a6f339so4698236d50.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 03:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759746118; x=1760350918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHswFDCD4540V/T99FHqHZnQrWbNJSfM6DtDuneKmnY=;
        b=WXVJ62bXWTIxHv7/snRP2F1VHosC3KeYy3TBfnmBPIVXzKL2h24FcngY8/a3JD8g7A
         QgruRLDrR+bvYXUu//jM241mmdJuVPeOQ0O0qwXrhWjWHTrVlGzqvDCnp806QXNc8T5o
         r/I6eADyKnPAJxzJEaqp4wlSPBjzrP1E71qhTl1Ncm4fe8V8dU+PpCcBkiKdo5DK7fII
         mnA2DS+gDRTIkRFkYgaEx/fodLM6MlbgGTV4MZGkIg5g0IbvzEH3vux0eUxOMaY5pdJv
         rLacb2amccSJX9yGIXaIPu2dFmPtz1E4SPywy6x0Ch6YYIUe3CboDP0jBX0KJWqJMZZQ
         xhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759746118; x=1760350918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHswFDCD4540V/T99FHqHZnQrWbNJSfM6DtDuneKmnY=;
        b=s/bxBKEFmhstnh45I8u/1HX3iE9pSTWoaVQB8NiOZRU6IkmDUH0UZ34rh6fSnpjxXa
         KEb43iuLSnrsjz5mV65Gifv8I9y55vDCdSjAAnIra/GqtCRX8HcnvkWBk5Fhk/YOB0ZY
         XbNk1mN4GyjaXZC5IAgusm2a93NzsUaB7P3f8scs9P43RxE3Wi2fWZAkYKbQhX1Uu+RA
         BlFOqrPNti5UQGH3ufryjS2f1nV/MiA7anDJj+T4pBqiYEQQd8wwMpq0/MGAJswW3HEO
         3qGbK4C5l57VpkD6lhuEyZe2e6RReHB4Yn6Bs+QVRJxfEU//4uqnoNl4xUCaNwxNPopA
         P0IQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1bWI7UmDF9ARVN0fw15lvyAtCBltgB19u7wwWZ5TxJF6nYSAC/s+40Fr0hNnJfm1HwaMLjErF5MVf5zQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA76K56MF2wA4AVCoeV4v+ACTI0rypy2BKS6ZODvuDZMwNwPAo
	rdclCUJAGKo37gD2ODbv0FHnCU/iT6nS+d/69gMPZRNrM61nR8S/nLMPmrOYZiz4ua10Yk6NOxU
	rir50N9U4eAHUgHksA4rb/LlhuEGrgHWK7xRl+O/P3g==
X-Gm-Gg: ASbGnctwYaQ8upq30xHQXjhFhLdo2vFLbWQ0q+5GCn75DSv4k2wQpGClDOqa3ej5PyN
	8PvvqhimPTRw+brPTQ1pH0IaEjrYdNeoit+dKk3YWHdjS3oRwJTrezG1a5bQ5aXG4VeX+vhdnVM
	Vp9z0jLYQy7ncy2grmVQG/hpqjzcptFYYorz2XkWxrFVbqApwK4a3NwLJ5nn/aCWUIiUZABnXaB
	riB849pdBLBjK8Bl+KJ1I21k/7BMJED+7d0
X-Google-Smtp-Source: AGHT+IF77psB9K+vCNT5BqknfIdXI0+uekUjNxpVa2VL0PkfMCs3+TBiryz2Ck/k2rBVvaai4e1MlY1ofOfIlxeiR/c=
X-Received: by 2002:a05:690c:7403:b0:739:7377:fdcf with SMTP id
 00721157ae682-77f946d9ca3mr238701107b3.27.1759746117957; Mon, 06 Oct 2025
 03:21:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001060805.26462-1-beanhuo@iokpp.de> <20251001060805.26462-2-beanhuo@iokpp.de>
In-Reply-To: <20251001060805.26462-2-beanhuo@iokpp.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 6 Oct 2025 12:21:22 +0200
X-Gm-Features: AS18NWBgWnP4AaXTtJfAgW5wzsxvciI-aFmsX0xMwXAc3pjmjuiaNSmq0CyP-3U
Message-ID: <CAPDyKFpyh7Qag+ckCcPkr1RWh8YiST-4V2_Y7xvBU4LRLNC28A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rpmb: move rpmb_frame struct and constants to
 common header
To: Bean Huo <beanhuo@iokpp.de>
Cc: avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com, 
	jejb@linux.ibm.com, martin.petersen@oracle.com, can.guo@oss.qualcomm.com, 
	beanhuo@micron.com, jens.wiklander@linaro.org, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 1 Oct 2025 at 08:08, Bean Huo <beanhuo@iokpp.de> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
> Move struct rpmb_frame and RPMB operation constants from MMC block
> driver to include/linux/rpmb.h for reuse across different RPMB
> implementations (UFS, NVMe, etc.).
>
> Signed-off-by: Bean Huo <beanhuo@micron.com>

I have queued this up via my mmc tree and plan to send a late
pull-request to Linus to get this included for 6.18-rc1.

That should help to land the remaining pieces for ufs in the second
step without having to care about the mmc parts.

Kind regards
Uffe

> ---
>  drivers/mmc/core/block.c | 42 --------------------------------------
>  include/linux/rpmb.h     | 44 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index b32eefcca4b7..bd5f6fcb03af 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -79,48 +79,6 @@ MODULE_ALIAS("mmc:block");
>  #define MMC_EXTRACT_INDEX_FROM_ARG(x) ((x & 0x00FF0000) >> 16)
>  #define MMC_EXTRACT_VALUE_FROM_ARG(x) ((x & 0x0000FF00) >> 8)
>
> -/**
> - * struct rpmb_frame - rpmb frame as defined by eMMC 5.1 (JESD84-B51)
> - *
> - * @stuff        : stuff bytes
> - * @key_mac      : The authentication key or the message authentication
> - *                 code (MAC) depending on the request/response type.
> - *                 The MAC will be delivered in the last (or the only)
> - *                 block of data.
> - * @data         : Data to be written or read by signed access.
> - * @nonce        : Random number generated by the host for the requests
> - *                 and copied to the response by the RPMB engine.
> - * @write_counter: Counter value for the total amount of the successful
> - *                 authenticated data write requests made by the host.
> - * @addr         : Address of the data to be programmed to or read
> - *                 from the RPMB. Address is the serial number of
> - *                 the accessed block (half sector 256B).
> - * @block_count  : Number of blocks (half sectors, 256B) requested to be
> - *                 read/programmed.
> - * @result       : Includes information about the status of the write co=
unter
> - *                 (valid, expired) and result of the access made to the=
 RPMB.
> - * @req_resp     : Defines the type of request and response to/from the =
memory.
> - *
> - * The stuff bytes and big-endian properties are modeled to fit to the s=
pec.
> - */
> -struct rpmb_frame {
> -       u8     stuff[196];
> -       u8     key_mac[32];
> -       u8     data[256];
> -       u8     nonce[16];
> -       __be32 write_counter;
> -       __be16 addr;
> -       __be16 block_count;
> -       __be16 result;
> -       __be16 req_resp;
> -} __packed;
> -
> -#define RPMB_PROGRAM_KEY       0x1    /* Program RPMB Authentication Key=
 */
> -#define RPMB_GET_WRITE_COUNTER 0x2    /* Read RPMB write counter */
> -#define RPMB_WRITE_DATA        0x3    /* Write data to RPMB partition */
> -#define RPMB_READ_DATA         0x4    /* Read data from RPMB partition *=
/
> -#define RPMB_RESULT_READ       0x5    /* Read result request  (Internal)=
 */
> -
>  #define RPMB_FRAME_SIZE        sizeof(struct rpmb_frame)
>  #define CHECK_SIZE_NEQ(val) ((val) !=3D sizeof(struct rpmb_frame))
>  #define CHECK_SIZE_ALIGNED(val) IS_ALIGNED((val), sizeof(struct rpmb_fra=
me))
> diff --git a/include/linux/rpmb.h b/include/linux/rpmb.h
> index cccda73eea4d..ed3f8e431eff 100644
> --- a/include/linux/rpmb.h
> +++ b/include/linux/rpmb.h
> @@ -61,6 +61,50 @@ struct rpmb_dev {
>
>  #define to_rpmb_dev(x)         container_of((x), struct rpmb_dev, dev)
>
> +/**
> + * struct rpmb_frame - RPMB frame structure for authenticated access
> + *
> + * @stuff        : stuff bytes, a padding/reserved area of 196 bytes at =
the
> + *                 beginning of the RPMB frame. They don=E2=80=99t carry=
 meaningful
> + *                 data but are required to make the frame exactly 512 b=
ytes.
> + * @key_mac      : The authentication key or the message authentication
> + *                 code (MAC) depending on the request/response type.
> + *                 The MAC will be delivered in the last (or the only)
> + *                 block of data.
> + * @data         : Data to be written or read by signed access.
> + * @nonce        : Random number generated by the host for the requests
> + *                 and copied to the response by the RPMB engine.
> + * @write_counter: Counter value for the total amount of the successful
> + *                 authenticated data write requests made by the host.
> + * @addr         : Address of the data to be programmed to or read
> + *                 from the RPMB. Address is the serial number of
> + *                 the accessed block (half sector 256B).
> + * @block_count  : Number of blocks (half sectors, 256B) requested to be
> + *                 read/programmed.
> + * @result       : Includes information about the status of the write co=
unter
> + *                 (valid, expired) and result of the access made to the=
 RPMB.
> + * @req_resp     : Defines the type of request and response to/from the =
memory.
> + *
> + * The stuff bytes and big-endian properties are modeled to fit to the s=
pec.
> + */
> +struct rpmb_frame {
> +       u8     stuff[196];
> +       u8     key_mac[32];
> +       u8     data[256];
> +       u8     nonce[16];
> +       __be32 write_counter;
> +       __be16 addr;
> +       __be16 block_count;
> +       __be16 result;
> +       __be16 req_resp;
> +};
> +
> +#define RPMB_PROGRAM_KEY       0x1    /* Program RPMB Authentication Key=
 */
> +#define RPMB_GET_WRITE_COUNTER 0x2    /* Read RPMB write counter */
> +#define RPMB_WRITE_DATA        0x3    /* Write data to RPMB partition */
> +#define RPMB_READ_DATA         0x4    /* Read data from RPMB partition *=
/
> +#define RPMB_RESULT_READ       0x5    /* Read result request  (Internal)=
 */
> +
>  #if IS_ENABLED(CONFIG_RPMB)
>  struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev);
>  void rpmb_dev_put(struct rpmb_dev *rdev);
> --
> 2.34.1
>

