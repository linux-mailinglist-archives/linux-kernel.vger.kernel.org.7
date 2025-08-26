Return-Path: <linux-kernel+bounces-787051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62762B370CF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 529AC1892BB6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015002DCF50;
	Tue, 26 Aug 2025 17:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1W94TY+x"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B742DC323
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756227610; cv=none; b=TXiYO+wk+bWFz5leXlSiY00z6+SnHkJXylHQNF8F8SrtWLq+mX4oef2AjjWU5qqlbiLVYeJQJkv0i6nFhTWczwVlECV5YEqW5dsmjFMKUsbu3q7JRh42//C3SBItCuQrG/PvaPbi0/nmUIFkgcsipFpeHNHWr2Gz2VYL76qzT8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756227610; c=relaxed/simple;
	bh=axU63iIjxY/Hr/A+uMZpM4mwzItOCypOOtgoOvnGx5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mEMn+6PFJocXvaOC6mQSW68+j3j+jbam6tkbw0g0/UY17VEqDfSUXMgC8Qmf/iL5l0ucoof2K1+SxZws6rTSjCuPgG4mtutxKNYAl+k4SifK0vNCwS/CCNP9NajM3KisCKpIMCOD8Dbg9JCPwdyJ3Q2CPL/Gyl7uGhgcIVWM9yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1W94TY+x; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-30cce892b7dso1878513fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 10:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756227607; x=1756832407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2T7SAuZKkQIZMvtrHN5CfG8eVXoHXEyrmLOydr35L4g=;
        b=1W94TY+xYV3ivFe/Vh8VlXD1SgxMheBjbg6pYbBJ/3QBWl9qw4TqlVswM2NNjHYtVZ
         pKArKcYWuY5+q7vlljNHARCRITL5DWUFMeHlruvpCOZ9PnPSWTRSfMwp/QWvOdLVm/t9
         IVjlKfpWjuHwsjCqu+rQFakNvTAQh5S14MhpgfYTnliNA4c8xelOcJq4aCMnfCaZ1k8E
         acrAlDPcFtMhLXdlgOBcHHzJDPTCXi1cuNpTvzst2C1DIWkit94wyqipinsX5YA2oL6k
         4DFz0bDG0cdBjwerYOFTrOJVUDtH4qIqJDSj5Zcvu2a6ir54ZXJz7K0rZ6/POMIB5iL3
         fpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756227607; x=1756832407;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2T7SAuZKkQIZMvtrHN5CfG8eVXoHXEyrmLOydr35L4g=;
        b=NWCkh8pVUpKgbIfWZKEYAYeDAXfO3rRlmFMdW8CvL2O+9iEO9HK66UOia7V40FRU4q
         fiVECjkSSm4Gv2cZpYy5B+OXLJEtPBhr9BP7ia/WiZu4GLe3l3yo5rrzj/0aNqzGrbs4
         1v1FDM8ctXYAuiAceObZyYIexf4kVjo7XgjEcfnyANdLypGFz2T+2XDA5OwuUnFQKVnN
         /qVBGAYJ/WOI7ojIGWRJO0uFtpc4+x7Pde8wWgD8azixO3g7zLWooFpHF3QBPxQ/haM6
         pMgHGJbO9li6VaNYatrEeLl9L4CDE3ylF0GmHRsmmEUUbja73YMsoTpvUKddR8p5ZEQ3
         LMdA==
X-Forwarded-Encrypted: i=1; AJvYcCXX0MfXWTHIYvyFTOX+W6eazGXKrHEgFurN+lEJLyziCm+Tv+2kRtxKGl91RLGV6F3fXmSaWHI1A74Bc9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjaGTt2MmbVNffPgTvgmdEeW8lOORuxHuElgaCrEwwc8uPrtJp
	Ztf065OI8myTmlsE6gnaiThQ4HX1QgE2Y/vn8EdrtWpnhUxPsgNnWfKG6gdVulnTHBw=
X-Gm-Gg: ASbGnctdiGwoGXzooFUmg/BfT9KnaVcFgorVRGjiO7WqtrTnI39Nowvsly8a6js23H+
	eawDmNSVC4XB2SkNq6G5ESf/BTEZJsYSIpZTPosQUJ2GFFSgTtCzDkp/BMH9l7vZQHT7aWHbp/6
	2q52tvViQPEIDZtEuqVZOWVhnp0z6qaCLzQFQUz+FEp4pT9PVSI5GoIL51PYbBszfcOgiNiVfIM
	1HhWlQd4/eJsXpe2R4lUTNjJ9SJ2SVTyKE790/PdU5cxhvKdHhw79O6Thax7r23Nfget2SIn/S/
	sgfew+ovYbmALN5WT0CfBgYsxF82yK5BC6jOiid+4KJdzEMuhe/YAfHl2FfvTLRpmcqdhQMV19x
	M3j+m6WA9HVjdX0ay7mvtrQttmrUf3D7HJd3E/AqT+Ilj1GmVjSD/QCOmzbSZYPckAbgvJ8+WHO
	k=
X-Google-Smtp-Source: AGHT+IFQCasJu/lINb/gG6XFZfcU//YPJD/Ps0nDiLhbq1xsxovzrUxcKHYTiHnxrjpHEXpG12WYAg==
X-Received: by 2002:a05:6870:24a4:b0:30b:ae56:578b with SMTP id 586e51a60fabf-314dcda7ca7mr8143599fac.39.1756227607245;
        Tue, 26 Aug 2025 10:00:07 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:aa9f:f4cd:76b1:fecb? ([2600:8803:e7e4:1d00:aa9f:f4cd:76b1:fecb])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-314f79ab738sm2566818fac.4.2025.08.26.10.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 10:00:05 -0700 (PDT)
Message-ID: <9fd7f08f-51cc-4155-a5e2-c6ba2f1c4897@baylibre.com>
Date: Tue, 26 Aug 2025 12:00:05 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/5] iio: core: Add IIO_VAL_EMPTY type
To: Ben Collins <bcollins@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250825-mcp9600-iir-v7-0-2ba676a52589@kernel.org>
 <20250825-mcp9600-iir-v7-1-2ba676a52589@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250825-mcp9600-iir-v7-1-2ba676a52589@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/25 7:10 PM, Ben Collins wrote:
> In certain situations it may be necessary to return nothing when reading
> an attribute.
> 
> For example, when a driver has a filter_type of "none" it should not
> print any information for frequency or available frequencies.
> 
> Signed-off-by: Ben Collins <bcollins@kernel.org>
> ---
>  drivers/iio/industrialio-core.c | 1 +
>  include/linux/iio/types.h       | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 159d6c5ca3cec3f5c37ee9b85ef1681cca36f5c7..e4ff5b940223ab58bf61b394cc9357cd3674cfda 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -702,6 +702,7 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
>  	case IIO_VAL_INT_64:
>  		tmp2 = (s64)((((u64)vals[1]) << 32) | (u32)vals[0]);
>  		return sysfs_emit_at(buf, offset, "%lld", tmp2);
> +	case IIO_VAL_EMPTY:
>  	default:
>  		return 0;
>  	}
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index ad2761efcc8315e1f9907d2a7159447fb463333e..261745c2d94e582bcca1a2abb297436e8314c930 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -32,6 +32,7 @@ enum iio_event_info {
>  #define IIO_VAL_FRACTIONAL 10
>  #define IIO_VAL_FRACTIONAL_LOG2 11
>  #define IIO_VAL_CHAR 12
> +#define IIO_VAL_EMPTY 13
>  
>  enum iio_available_type {
>  	IIO_AVAIL_LIST,
> 

This is an interesting idea, but I think it would be a lot of work
to teach existing userspace tools to handle this new possibility.

On top of that, I'm not quite convinced it is necessary. If a numeric
value is undefined, then there is already a well known expression for
that: "nan". Or in the case of this series, the 3dB point when the
filter is disable could also be considered "inf". Using these would have
a better chance of working with existing userspace tools since things
like `scanf()` can already handle these.

