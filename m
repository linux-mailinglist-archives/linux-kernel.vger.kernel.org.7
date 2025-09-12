Return-Path: <linux-kernel+bounces-814251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 369AEB55184
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCBC7B6185B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23246320398;
	Fri, 12 Sep 2025 14:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rsIoBwud"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2DA320384
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757687145; cv=none; b=Rhx+PaPEQ/I7LDR/iPnLeshfqpRAvvYzJVtK354Ps79KgtkaMCwfioVNL/vuunib33ajJzEJHgrV1ITpnNfsPlAzbfpo37GwFibmMgMInpS9u31p8qLqbryj0hBPfY0bJ+tj9AtIPG0kpkeF7MxXv/7aUsLpJ4tIDIpVQYTOMyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757687145; c=relaxed/simple;
	bh=ObQub0Fn7ODydg5DGf8K9+pxMyAg4npUNxDcfdTxVRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iVfzk56BXn8sRWb1ujhuCBtFhuSPCItuMSJ988HQi8RxcdsskVa+4v2xyjpWUsnMF21QlxZffiURTcZP4KMEdPsOzT+xsLhTTOSQ2QyxeZ0u5CAtNGkFh2zLIeSdvnsfofY22TJ0aQQUWKa1Lp+LrNDVh6RnTuAz9k05Dc5IFek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rsIoBwud; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7459d088020so985048a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757687142; x=1758291942; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X0+BU7GduzvivgLsJAA2dCFR38oEykasv0I1p1J9djc=;
        b=rsIoBwudzsQoXa83Vw3sn8MbAZfQYwBcUHlp1DMDJIUEom8nX2JFk6s7vQdt8nWo3h
         WOT2N4tJC4yWEQbw2FgnZWGmy/LWcG+J8it33H7wHl9eE9UU5vZwS553WyJiThmBABDP
         /+/RxSiGTfrzIfoQ5WNYdHkPoUtS0UDT3NTdPLQ318REY1FAdyFe1SVgOnRItURTPY3R
         +GLjcLr2FGH/FokSitt2eXYaYBKv1ZgxCrnzBMaCuH042ABqQRJygLIsSZl3Y1+1TaLO
         7ktyqjNJGhL9nzqhMC2/XlbnPKJIoBKG9d07StPaD0G6FLejMhgRfFcWN1bxMwiKD1Fl
         b8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757687142; x=1758291942;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X0+BU7GduzvivgLsJAA2dCFR38oEykasv0I1p1J9djc=;
        b=eMUQZoZU1cDJpzKNW85hU/8Yj356Uw0fpUklKRCHomcvNJaOheAeBcYbK9Remtwu9E
         y7fvnfAkSVmkTIu1pdkt9DuU8VkQrtY+vf2pUIjbxQxp97exejRmdxHXS0RVI+rbuJk/
         I/HTnTQYxTZuz92f3A5vOoBw+unhQzvggrSWOnK614G6/OfgeedipmNSV3A8Xk1LH86Z
         4YywN9U+NxYzR1NY0Qp2DOeMYv2AB0t1M7CMr2lSCy7i73b0Ssgvagljyx3h4vxfJLv7
         ntj83Rn5DIBxl+G4hrId9bwnaRKfQg76Cti925IsxGEdx1PnanDVBsbJj0apA1kuyulB
         kWBA==
X-Forwarded-Encrypted: i=1; AJvYcCVCBmLJ54VBV6bBOFPqQCLOqaZu+k+1v62p7u5+bjFTdKIJo4SMJb8SQD1RwlHhV6YZ4LK4/a6mgsawlFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0zUlrwbcv+SbJMfuQ8916ixKxp5X8rjH0StPlo4k2cQ/wTCUN
	mDMkT+H4zEcY6VsyCaGmILVpwmxmbbMT9uQR+d4O3ZxvY1YpbBdh0Q36lI7n1mHNIKI=
X-Gm-Gg: ASbGncvw2/hcZqoYaOxuimxr5nQveeWQx9EHaF8cLO+6huslSQoXOO5TjG+GYIv+IBq
	bEo8gjGTiR9D0Gx1XfeNgLVTJnren0GYCbwUl3n1QeLKAZHi5XCMnyA+oUpx2MbVHdp6TCDzxzE
	vyDIv5ClIQpRqli7IcwV99zKCgf1jCBCHwBgl/upqYw7sPw+KxEQlEq7aORTkp4DTwzxcdd3jji
	tCP3TAf3itTKEJVem6Zypt04yYfSm5eDtBpc+IM/aX8HPaFnSzkkGIys5Cq9BPheIs4smUV+7af
	en5x130uZ9s/GLMX7V1KdGPpzf8cuHfcTXQiVlQ/kFse3GZBgmzJl+ZTTXzMN2r8wQEpYj0/fjq
	PcJMoLdFQpkII1Hc7aIe94uoCBaU1bqOvR32oICvCnvTC2GdeYoBRcvOoys+6RMIERkj5vA0Rb6
	w=
X-Google-Smtp-Source: AGHT+IHpKSZF4MQEZ+u/oC7k9WZoRds7vIivV2qRW4sbQwQlgWqoybEkVA4pca3nFzL2BSPAaioX+A==
X-Received: by 2002:a05:6830:6615:b0:745:a095:22a2 with SMTP id 46e09a7af769-75352d8e0c3mr1671283a34.7.1757687142583;
        Fri, 12 Sep 2025 07:25:42 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:fdf1:f11e:e330:d3c1? ([2600:8803:e7e4:1d00:fdf1:f11e:e330:d3c1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524986ca64sm1037256a34.14.2025.09.12.07.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 07:25:42 -0700 (PDT)
Message-ID: <889408fb-e7c5-4a1e-be96-1f632e97469e@baylibre.com>
Date: Fri, 12 Sep 2025 09:25:41 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] iio: adc: ad7124: support fractional
 sampling_frequency
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250911-iio-adc-ad7124-add-filter-support-v2-0-b09f492416c7@baylibre.com>
 <20250911-iio-adc-ad7124-add-filter-support-v2-4-b09f492416c7@baylibre.com>
 <CAHp75VdMSr400YokZfv8SAkt-M8kuw7gt4+eCBb68xt7ipKJbQ@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAHp75VdMSr400YokZfv8SAkt-M8kuw7gt4+eCBb68xt7ipKJbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/11/25 11:45 PM, Andy Shevchenko wrote:
> On Fri, Sep 12, 2025 at 12:42 AM David Lechner <dlechner@baylibre.com> wrote:
>>
>> Modify the attribute read/write functions for sampling_frequency and
>> filter_low_pass_3db_frequency to return fractional values.
>>
>> These ADCs support output data rates in the single digits, so being
>> able to specify fractional values is necessary to use all possible
>> sampling frequencies.
> 
> ...
> 
>>         factor = 32 * 4; /* N = 4 for default sinc4 filter. */
>> -       odr_sel_bits = clamp(DIV_ROUND_CLOSEST(fclk, odr * factor), 1, 2047);
>> +       odr_sel_bits = DIV_ROUND_CLOSEST(fclk, odr * factor +
>> +                                              odr_micro * factor / MICRO);
> 
>> +       odr_sel_bits = clamp(odr_sel_bits, 1, 2047);
> 
> I would rather see this clamp() call to be the part of
> cfg.odr_sel_bits() assignment, otherwise the above line and this
> operate on the semantically (slightly) different data. So, the first
> line should use different variable name, or the second, like
> odr_sel_bits_clamped.

If we moved it, then we would unnecessarily clear the cfg.live bit
in cases where clamping changed the value.

In a later commit, this gets combined to a single assignment so
not much point in adding a 2nd variable temporarily.

> 
>>         if (odr_sel_bits != st->channels[channel].cfg.odr_sel_bits)
>>                 st->channels[channel].cfg.live = false;
>>
>> -       /* fADC = fCLK / (FS[10:0] x 32) */
>> -       st->channels[channel].cfg.odr = DIV_ROUND_CLOSEST(fclk, odr_sel_bits *
>> -                                                               factor);
>>         st->channels[channel].cfg.odr_sel_bits = odr_sel_bits;
> 
> 


