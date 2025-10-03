Return-Path: <linux-kernel+bounces-841057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E270BB6274
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 09:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F4C3B4B9A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 07:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D61F23BCF8;
	Fri,  3 Oct 2025 07:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nolXuYiK"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A77923A989
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759475706; cv=none; b=Wz7ts4aKyuDCF/koNck2lP3VSwt1gwz+ArwXbAsTwyQtHg/OJVgqf/GLg20Vp5UF5OmEI6MHKIvbeCOqDdXjtZrwzPMJbUfywuDmme3cTcFQbDmJJYM23/Sriv+bR8gMHv6kZYwHx9nTd8CRXpN4/HiV/YcECfChWxcawpISOB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759475706; c=relaxed/simple;
	bh=yK71hSDBFEgTrIFuzQVO+jeS6J7GSdx2mpiyDMNjEzI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VZ0UR9gM709NQK477YaqFTIQzlTuKI88kW0SXkON6y4oTdLoc1NrHxeqGQs+Laqg7CE/88eX/gk2nEqvWPHBU6JjNLHSwm3NOvdVHZ8vTSDbPiQAdRrFQA3u892wcCQ7YZx9tF6v2cuxuPUH1P9a+TN7hQlisyUdLDhBWX8z8xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nolXuYiK; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4256866958bso193682f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 00:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759475703; x=1760080503; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SCxy5SDWHowEDbxrjGnQzeWW2JpysbkJk+FBY3MBfRc=;
        b=nolXuYiKkjoWXBjHRyoKb7/47luWrGheMIwTbgCRBHHXzXGVUwSfd4SMvkXcZ0YxTL
         ZB1nAA60jFIH5aD1AuhNl+2XniaQ2+HUINyvOwKbK+TlT69YMhCEFTzXwuoe2KuSA8xN
         t5eBrzSp5lcByJ2sjnnwze/5Y69Tk4YRincuiCd2DWuuITTkd/l+YQfWsHycKo+bwD1B
         33o9SR8JsjXqHZ2mkYfksl7zXZSGXoOJrVUSo5jlM7BeXKqFQ96Q5Mzgmn347lVOsq88
         eLYXYaY77mIwojSsPgPahZbv0hExE/6PuQeGIQYIQsDdIW/czeveGREnA2gUvEik06JW
         QfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759475703; x=1760080503;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SCxy5SDWHowEDbxrjGnQzeWW2JpysbkJk+FBY3MBfRc=;
        b=QBU1U1FXcu8djY2TtWCc7TF68MCIt+/jjrVGmMmsp051N4gT194FTTpT6pDMbiKrY3
         znnnNl1CAhcl7BSyUu9mWWX3UpmkqIPMU0vEv9xtyohjhQRtiiZSbIHFzN6cTqEyt0el
         uJpQTOAMCrcYx+gwOSTERs/H32cU/ff6uP30VXcnkyvsFEgCpM9ZW0GPOU4BuS+3Or72
         h0aU5+QoR+Dheu343wE4bblGYBIc5Z/C3rS2NcndbXh0GnPz/ulejoh6ZERKJz0QK96C
         Dkzsrnj2t5maM3bUn8zlsveGyBUkS3wqkWvAHPwqtI/OZE/jYoyKsC5C1m88PxlT2vcX
         otWA==
X-Forwarded-Encrypted: i=1; AJvYcCXxTR3fct9Ouo1SB7N945S2/Jg+wg1UbzXEX4vZrbDlwKTgwiiPk+8B+8T5t/S+v02rMHDBrMAOAUJQSFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmnprljOWZtXekWlfSJcwIKzzrsp728YhfAaXqdlD/DBQzqgng
	ZV2/w0+N0ciSiGxn9y9qQKHGnBbaGoztNMcQszqNLJYK2QzJfraP2VaG
X-Gm-Gg: ASbGncukWi5D2FPngmpLIAA9crVbmQac+SbxjQ4+5fuLvKgqkPC4LU+XGVw+Qtd+aAe
	GmGpyoOUFlMaEYfvOiPRkNTle9hPdxmvdcowOtLyVlAvUkfh2bvTVODO9O+0jKN4vYM71tUmPTF
	o5nToBlUf8ygQiyiVA3qOGp6MbnkS9hv8u6aSDwA2ja6IMoB+QA720AowwxFvFDv9M0OrmiuPfX
	/DLUBSuJGZGq/qAGlNh3ldbUuSWNflDL2Clby/JFs2kq8JjoSaLOYLtemtRCUScuMlpX06o6ghn
	cPBvFfhI3wSBPs0RzgTG6fjCh+kmuXPRoVTANEBaTx0e8sHUH21qe6x67cpmsbo0TZK/twYTVlK
	qNtrUwmWenLNTHsY/xZq7CbG6zRh8lNeX43lFJi9IboWmt2YoE1KBmRgP49WK7jn5JnXFYsG6Ew
	wN8cIS8bIym5kqH7EEdm4=
X-Google-Smtp-Source: AGHT+IGLTbbL0+EcLoLbEHHZSN9rL8yQmh7AzCqkvRkhjUJXYn5Zs5RuD/3SDImWP4OlYSCEwRkZcA==
X-Received: by 2002:a05:6000:610:b0:3fe:d6df:c679 with SMTP id ffacd0b85a97d-425671c1c62mr1159606f8f.55.1759475703242;
        Fri, 03 Oct 2025 00:15:03 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:94c4:fb0e:28f:2a8d? ([2001:818:ea56:d000:94c4:fb0e:28f:2a8d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8abe9bsm6738262f8f.22.2025.10.03.00.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 00:15:02 -0700 (PDT)
Message-ID: <5243c2c5a8f3dd24f40e30a695e2a3d4f948f388.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: stm32-dfsdm: fix st,adc-alt-channel property
 handling
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Olivier Moysan <olivier.moysan@foss.st.com>, Jonathan Cameron	
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Maxime Coquelin	 <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, 	linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, 	linux-kernel@vger.kernel.org
Date: Fri, 03 Oct 2025 07:15:56 +0100
In-Reply-To: <20251002112250.2270144-1-olivier.moysan@foss.st.com>
References: <20251002112250.2270144-1-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-02 at 13:22 +0200, Olivier Moysan wrote:
> Initially st,adc-alt-channel property was defined as an enum in the DFSDM
> binding. The DFSDM binding has been changed to use the new IIO backend
> framework, along with the adoption of IIO generic channels.
> In this new binding st,adc-alt-channel is defined as a boolean property,
> but it is still handled has an enum in DFSDM driver.
> Fix st,adc-alt-channel property handling in DFSDM driver.
>=20
> Fixes: 3208fa0cd919 ("iio: adc: stm32-dfsdm: adopt generic channels bindi=
ngs")
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/stm32-dfsdm-adc.c | 5 ++---
> =C2=A01 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-df=
sdm-adc.c
> index 74b1b4dc6e81..9664b9bd75d4 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -725,9 +725,8 @@ static int stm32_dfsdm_generic_channel_parse_of(struc=
t
> stm32_dfsdm *dfsdm,
> =C2=A0	}
> =C2=A0	df_ch->src =3D val;
> =C2=A0
> -	ret =3D fwnode_property_read_u32(node, "st,adc-alt-channel", &df_ch-
> >alt_si);
> -	if (ret !=3D -EINVAL)
> -		df_ch->alt_si =3D 0;
> +	if (fwnode_property_present(node, "st,adc-alt-channel"))
> +		df_ch->alt_si =3D 1;
> =C2=A0
> =C2=A0	if (adc->dev_data->type =3D=3D DFSDM_IIO) {
> =C2=A0		backend =3D devm_iio_backend_fwnode_get(&indio_dev->dev, NULL,
> node);

