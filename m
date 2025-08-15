Return-Path: <linux-kernel+bounces-771418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6E7B286DB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 22:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10DB916CF89
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 20:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE6D298CDA;
	Fri, 15 Aug 2025 20:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B6fgctbJ"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B312561C9
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 20:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755288193; cv=none; b=u2E9a46AgWGx1q/Jo3o5x5RrccQpJ1ncjLPWnYn2qI/TBwTxGjxpZJYQh/i3G4Nagq535zALiGN8Hk3PgCrsQN4Mx8xL56VjGI7y06or7Mf31vs/5QEUF7ZdpLE3rA+g30IStkjaN6WS8bX493N+Sc5t9/hw66Q65xG15OAtNkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755288193; c=relaxed/simple;
	bh=4STIYGI/Iyf15/bs41CGx8JzbIlb5YFgaQssWbnWL0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cv7MBzxullNNKVj4yOOCxyrDJGqJ4uz8azTiZnlvqaj5WQAAHiBek6iYuz6I4yeQvzcb8oA+hQqiQiFHJ7Q0wUARmhhposxuqovBdvhGNEORmmacvWJyeUcDQNXpZqiPJVsq4a3JBr/y2sDDwLKHQP2UeO7wCgqtbBZycAv3Lfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B6fgctbJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a1b004954so15554495e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 13:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755288190; x=1755892990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l2kePfzDvFml6EXYBDwWfTvZ++1LxjVURGwo9pFDf5U=;
        b=B6fgctbJFJ1lVivEsP8Ula+orcSNHuUNSyjrx32PeHIZT+wCXp5IQlFG21LfbE28+K
         xN3XowFM2EsdlGIuXDbLlbEQCguLZ24X+Zwl3b0oDM31SNBlnrH5OabPWXB+yoF9eASd
         YGxKdpTIlSFam1xZ+PjW1JSs2y1i3nuurwfDSLjawkTRXODFZPm/gqbsqw1AHHbYy7HA
         4T6rk2NuNM7NUmrhpLE3RHzvplfD9VmZu76yiyGSFWKliJfeoU92cZpZRcTfyRVBxDPC
         OtVNDvPIIaMxCkzJTWSvx2f9aiieogexAL2cBnnJjmW1uKPxxxbpbodeVV2tl1HahmSQ
         KO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755288190; x=1755892990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2kePfzDvFml6EXYBDwWfTvZ++1LxjVURGwo9pFDf5U=;
        b=NwXp1Nq17vqAw4D9eDbN1bo3713Gx5+HZO5wmHD0/v9mdqkRbnMpo4jJDCEZ39njDh
         Da4JahDJxPpM/0hlSw5OZy714eHb6Qtyormmn+8rlPnGS+4a11uJjTPCiQlYWx0Fup7C
         89AyHy7eC82tKO1EY//kSWSmaMcSYuhQ4nh2rv39lLXR8VGAwee3SMTzdNad49nXp87V
         44+s+n4RyQZeGBGSPY9D/TkqfCalbkNbl7iWpCNnY7rgL2w7B2Ye6no128EiLZe3O5P6
         kPOZD8WFOoVirGN/B4N9d0lggvzPpAp4jBVmUMrXTGsLzickWJt8Fo4s037z/qx9Uncn
         EFJA==
X-Forwarded-Encrypted: i=1; AJvYcCWGyZlgYOEbAzfdOxmPCjcLeQLPl2f+FjBppk8ZC32bgDHhlBLiJtG7aeXNMeJYJk3NlD2GirQNJfjuQuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkokbbreIcwEQfimCtgrUx/NyfD/t9/a1rqAu2egVO6gwX8vNo
	NkIaY0mQDhdg51zQlNtLa+HExWYlT6DoW1AXiCN36YpHpU/9N/TJxIGjwWZDr+ALVPE=
X-Gm-Gg: ASbGncsw705h9UPlPijsrzMV8BZ3vZZ/GZyQQ8X1MaUYbvL+REVEfQqKmbqoiZWdY9Y
	GG7RHfWviNlg5c1eavS5zfpCxZCa60eWcO3QRjeDhrGl43i7/mUOgtu6CauexqcOqg+l8h823o3
	Oj0JmPf6yHi7oyhsS1xEVwIT4RMmI3QVjUF+Vak/rYyt6PPv81NXJB4Y8aoCF+t3fblbnMueuFK
	yo3fEDEB0zhduLVrP40qDpCneeKYZRaBEz/Y7Z0fJGO6usTlLZiOQ2FVCkTqXvaCYoErOd5iyjA
	3gWLKoIhc0jkV4vsAR/9uv6gONB20TjSPfXbu//JnFJ5LY5heMRZ9iUiywPhqyaECF/szzuvIHc
	T6+gKvA8UOPGEUI2UCwk8ErJt//s=
X-Google-Smtp-Source: AGHT+IHT14axeSHSDRiAFlW7o6Ist04KA+jLa97KTahHyBEMOM06qghEr+qt8YTS6r4n7TbhWi5LXg==
X-Received: by 2002:a5d:5d09:0:b0:3b7:899c:e867 with SMTP id ffacd0b85a97d-3bc6a83c6a5mr227506f8f.59.1755288190201;
        Fri, 15 Aug 2025 13:03:10 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3bb652f9debsm3174669f8f.28.2025.08.15.13.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 13:03:09 -0700 (PDT)
Date: Fri, 15 Aug 2025 23:03:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
Cc: hansg@kernel.org, mchehab@kernel.org, sakari.ailus@linux.intel.com,
	andy@kernel.org, gregkh@linuxfoundation.org,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] staging: media: atomisp: Add lock asserts for mutex
 protection
Message-ID: <aJ-Sept8uMm2Opeq@stanley.mountain>
References: <20250815170901.32105-1-abdelrahmanfekry375@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815170901.32105-1-abdelrahmanfekry375@gmail.com>

On Fri, Aug 15, 2025 at 08:09:01PM +0300, Abdelrahman Fekry wrote:
> Add lockdep_assert_held(&isp->mutex) to critical functions accessing
> shared device state. This enforces proper locking and detects violations.
> 
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
> ---
>  .../staging/media/atomisp/pci/atomisp_cmd.c   |  3 ++
>  .../media/atomisp/pci/atomisp_compat_css20.c  | 31 +++++++++++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/staging/media/atomisp/pci/atomisp_cmd.c b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
> index 3a4eb4f6d3be..48ca33e1c92d 100644
> --- a/drivers/staging/media/atomisp/pci/atomisp_cmd.c
> +++ b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
> @@ -3794,6 +3794,7 @@ int atomisp_try_fmt(struct atomisp_device *isp, struct v4l2_pix_format *f,
>  		    const struct atomisp_format_bridge **fmt_ret,
>  		    const struct atomisp_format_bridge **snr_fmt_ret)
>  {
> +	lockdep_assert_held(&isp->mutex);

This should go after the declarations.

>  	const struct atomisp_format_bridge *fmt, *snr_fmt;
>  	struct atomisp_sub_device *asd = &isp->asd;
>  	struct v4l2_mbus_framefmt ffmt = { };
> @@ -4324,6 +4325,8 @@ static int atomisp_set_fmt_to_snr(struct video_device *vdev, const struct v4l2_p
>  int atomisp_set_fmt(struct video_device *vdev, struct v4l2_format *f)
>  {
>  	struct atomisp_device *isp = video_get_drvdata(vdev);
> +	lockdep_assert_held(&isp->mutex);

Same.  Etc...

> +
>  	struct atomisp_video_pipe *pipe = atomisp_to_video_pipe(vdev);
>  	struct atomisp_sub_device *asd = pipe->asd;
>  	const struct atomisp_format_bridge *format_bridge;

[ snip ]

> @@ -1726,6 +1746,10 @@ int atomisp_css_input_configure_port(
>  {
>  	int i;
>  	struct atomisp_stream_env *stream_env;
> +

No blank line here.

> +	struct atomisp_device *isp = asd->isp;
> +
> +	lockdep_assert_held(&isp->mutex);
>  	/*
>  	 * Calculate rx_count as follows:
>  	 * Input: mipi_freq                 : CSI-2 bus frequency in Hz

regards,
dan carpenter

