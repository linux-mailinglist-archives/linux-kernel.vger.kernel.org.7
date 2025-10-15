Return-Path: <linux-kernel+bounces-854046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9772BBDD6CB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 934274257E5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1E82FF144;
	Wed, 15 Oct 2025 08:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOMkfwOq"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214C53002D6
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760517001; cv=none; b=A3sLd+wLzVRqv881B6jAM7YxFdXkymePB3yJkyUHdwJydW5NmL6LkkglxV8z/7dD7f2PbAHSbwT3x64UsTlp5XeO/ksTxkwNf59AmbwVW3+fCXViLgIasuPJPrWYTy/6ppXL7zQdr5vQIZ9j9G+Dg/bCbBmcb29z3qTUgLnt+Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760517001; c=relaxed/simple;
	bh=+yqUrodFRa2b7YQBwGpfRslfhPNG5SM2SgweyWev2Rw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=q12AqtxZVjlNYeocLud3aNhttXlf/mxKe8B+DmGkIa60Ntj89Sjd00Yod6pjjG3zvKE2N9QqNjgGBhUuphrk3Lkxq9MM7pE6rPJPaZBrQNK0HFUQUMyj8g6petVK3/hebuXRpzb7D3WMrf89nF75MyjcLVWIFvIC4YLsOgA+Upw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOMkfwOq; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-781206cce18so733996b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760516998; x=1761121798; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfoMcfD/PnjYiytAB/unpKapxhVytLhTH7sRTEu1OF4=;
        b=QOMkfwOqxYGUpBwZ+pZ94b3F6A5WINiWqeDOuieImcf09ogS/Bzd+FjRyeLcJEzKyv
         sRAZ79rUMWCe+dz/5d4+rfIckv8RbDVO5PCPg0WcS588LM6XZQ+zMjEZBWguxH2aDgqO
         dqQ/Yj0l5w3a9P7TIjQ3lCTclk1Dj+4si1DWafNmMgBHSGGMb9YwUeJfDO1QOcOlyZRm
         Xv4on4dE3Ygbom9J+o4yVVb4G82SQ6561VECkIIezH5sYhbHAxbk/Dju5risPY0aPfWS
         DeOKue8l8T3caJaxffOX80le7bQT9sYaGupA19jq7zTOhFK6Vvii9/ypN9oKP2/LB+Jq
         PtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760516998; x=1761121798;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZfoMcfD/PnjYiytAB/unpKapxhVytLhTH7sRTEu1OF4=;
        b=XbXedzeRmlEB2z/CL4rJrmZ3dSRAy1dYv/vJlRWV+NI+L4CgPOC3pR/juhy3fJC199
         stqTVsgPahVXx15HF8bvbNvGto67fN3WgF8brWKdOBRYs86LtG3kCDzjSrjS7KgAcNML
         hIwb3X8wIDHgkk7LhHSizatz2T7fNoBdDRmVdXG5YJ+raOWIijGXXQ4IokzHsBh03bcC
         Uuw4jyhkcEN7d9K2qXbZgDj+gp6brDBwTBFUA1cs+oegic4FA7jdjmKYkxscLcuDBAV3
         GuJo7yuq4Ril8PQt3gBPdDVIsmTTdM2FgJ35GmSam8GklGZgvs4KxUGzsb4f141A5IL9
         bTdg==
X-Forwarded-Encrypted: i=1; AJvYcCVlbylJFivIxjP/H5ulHgarpK31gCSgtOnOobCGCIpAXMU3zpWkXL0qSj8PLRMzgNNFb9A3Em852BTxCTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBeyTEPnRN9fz1RigtbjJcfpFQzVg5t8bT6+ub3bUop+XGrVVD
	WfZEMdGRH+zUR9PudKlrZyQTw1qadJpEghp/5u2fnUVQEyiqkMibSPqi
X-Gm-Gg: ASbGncskKUKdm/f+31PcvqjFnatm6Cjt48SJyOLy9xDk7nRxgYZqwPG4brgNPBhBRPj
	oTQBecif9BYPVWSXfDLIIUkXZkgCqedk6i0f2tjtrtRrMnwyTgTaDpxXaF8GZ4vqSwc9v8xg7n7
	DanBRJToILof487XnIrrVrg4BddrOXoGicUqriAXN1QAIqGuKmJ1LfuyFJu3etHi109+MfaaYqy
	lvFA6RYRtz1B1j9uVwjQQdkaborvvSGIcWHUQLF6UuMjze2rCIUFiCStSoTNw6oRH5AADxz/B+/
	qwR7z052S1xGNkDqHNaSb98e6Ha3a58FBLnNDANqFxXF2VB8ZMqzOxKDgsP7+AGpyeqk6Itc/Py
	IPUOP+55LWsOc+hGXZnKJ+uFSeH1+6yOJrH0s0lGR3DXGypRjBNA=
X-Google-Smtp-Source: AGHT+IGQ19ISwFZr70VQbxykwZJbmjViTX/pcHJHj5+1grEzkpXedUcScZHyl+DUM1XHWZHCDBY4tg==
X-Received: by 2002:a05:6a00:3e25:b0:77f:2b7d:ee01 with SMTP id d2e1a72fcca58-79396e6902emr34412247b3a.1.1760516998287;
        Wed, 15 Oct 2025 01:29:58 -0700 (PDT)
Received: from localhost ([116.177.27.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e198bsm17797054b3a.60.2025.10.15.01.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 01:29:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Oct 2025 16:29:49 +0800
Message-Id: <DDIR6RWVMIRK.2DQB98BRS180Z@gmail.com>
Subject: Re: [PATCH v3 2/2] iio: humditiy: hdc3020: fix units for thresholds
 and hysteresis
Cc: "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Chris Lesiak"
 <chris.lesiak@licorbio.com>
To: <dimitri.fedrau@liebherr.com>, "Li peiyu" <579lpy@gmail.com>, "Jonathan
 Cameron" <jic23@kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Dimitri Fedrau" <dima.fedrau@gmail.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.20.1-4-g02324e9d9cab
References: <20251013-hdc3020-units-fix-v3-0-b21fab32b882@liebherr.com>
 <20251013-hdc3020-units-fix-v3-2-b21fab32b882@liebherr.com>
In-Reply-To: <20251013-hdc3020-units-fix-v3-2-b21fab32b882@liebherr.com>

On Mon Oct 13, 2025 at 4:12 PM CST, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
>
> According to the ABI the units after application of scale and offset are
> milli degree celsius for temperature thresholds and milli percent for
> relative humidity thresholds. Currently the resulting units are degree
> celsius for temperature thresholds and hysteresis and percent for relativ=
e
> humidity thresholds and hysteresis. Change scale factor to fix this issue=
.
>
> Fixes: 3ad0e7e5f0cb ("iio: humidity: hdc3020: add threshold events suppor=
t")
> Reported-by: Chris Lesiak <chris.lesiak@licorbio.com>
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> ---
>  drivers/iio/humidity/hdc3020.c | 67 ++++++++++++++++++++++++------------=
------
>  1 file changed, 39 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc302=
0.c
> index 8aa567d9aded9cab461f1f905b6b5ada721ba2f0..5a978801fb09ca49c449028d0=
46a91e0e67c38ea 100644
> --- a/drivers/iio/humidity/hdc3020.c
> +++ b/drivers/iio/humidity/hdc3020.c
> @@ -72,6 +72,9 @@
>  #define HDC3020_MAX_TEMP_HYST_MICRO	164748607
>  #define HDC3020_MAX_HUM_MICRO		99220264
> =20
> +/* Divide 65535 from the datasheet by 5 to avoid overflows */
> +#define HDC3020_THRESH_FRACTION		(65535 / 5)
> +
>  struct hdc3020_data {
>  	struct i2c_client *client;
>  	struct gpio_desc *reset_gpio;
> @@ -376,15 +379,17 @@ static int hdc3020_thresh_get_temp(u16 thresh)
>  	int temp;
> =20
>  	/*
> -	 * Get the temperature threshold from 9 LSBs, shift them to get
> -	 * the truncated temperature threshold representation and
> -	 * calculate the threshold according to the formula in the
> -	 * datasheet. Result is degree celsius scaled by 65535.
> +	 * Get the temperature threshold from 9 LSBs, shift them to get the
> +	 * truncated temperature threshold representation and calculate the
> +	 * threshold according to the explicit formula in the datasheet and
> +	 * additionally scale by HDC3020_THRESH_FRACTION to avoid precision los=
s
> +	 * when calculating threshold and hysteresis values. Result is degree
> +	 * celsius scaled by HDC3020_THRESH_FRACTION.

I see that Andy asked you to include the formula, and you accepted that
suggestion, but the formula is still missing. I also think it should be
added to the comment because that would clarify where this kind of
magic numbers in the return value come from.

>  	 */
>  	temp =3D FIELD_GET(HDC3020_THRESH_TEMP_MASK, thresh) <<
>  	       HDC3020_THRESH_TEMP_TRUNC_SHIFT;
> =20
> -	return -2949075 + (175 * temp);
> +	return -589815 + (35 * temp);
>  }

With that modification,

Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

