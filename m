Return-Path: <linux-kernel+bounces-834378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 405C8BA492F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6C80387799
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6127223BCFD;
	Fri, 26 Sep 2025 16:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSOMSViZ"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD1C2367A0
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758903176; cv=none; b=ggzf7ALJq1fwdUTvAI1C66tRtuiq0MxXkfGiGUGEn87bwL+QWQa35IAGEPfNWlYwzRp0ThTMNS72RimBH/+unhSuEi7Qkfgk6YToe+9gP9CmwrPSCbRGyfm6g6I9seFTEkX/vhmn9CYIWvJPHrr52nJQvbjlVOQeBotqll8D7+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758903176; c=relaxed/simple;
	bh=fBEeVtjlMh0eakC+fIWfdSjEDTq0k01IZmIVBndPs5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ocVyAH0iPJ4AUrYEZL6Q3FaiB2p8jWXaspwra4/I80EgvocF1OtqGIeeoWz1ocLSxDAVZ/jS4szOfQdHhN1GIako6oycQqbKDf8f89T6QouSZHP5fr5sN+BSbNlkxzHaYj222xszFdBFsUO0Eg5bYY+CFmOkhrLGEQfl1SWidZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSOMSViZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27eceb38eb1so28288175ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758903174; x=1759507974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=P6vogX1yh7DM43cfcKuR1gYad8OSAL2NFfRRQVCWimw=;
        b=KSOMSViZSkslVSqI2x3iPVHvkwMONLg5YW6fo3wv08cU9Ai6/U5w2hM+t8IFKnqtpx
         PDFV4eRcsXNl9KrWd9pMYFmZW+P5B65pqx0QAAw7u50TgUgNf7iiTKkfFIECszyLmLuU
         2BeprnrekofJiUnsThKxWz5Db9PhN5/5G57U5A26g0fRUDpipGLzPHYNi90y03VhSu8F
         LtYhBNFpvTmYekOQa/m7rl3kAutVl+oKmGhXE0Y8IMD+x4LDy27vwgiBSLpJYbvETvby
         l4cAnvOqa5kRjthda31HDs/r9rHTEiW8GGrRrUUqBsh48GQ/onhctznWYpMPSL3xS53/
         zFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758903174; x=1759507974;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6vogX1yh7DM43cfcKuR1gYad8OSAL2NFfRRQVCWimw=;
        b=Ort4/knG+fcRKTEU1hTvHqOADPYj3xexELSotlOYPYzFpy8e/e+u8mnZ7AH0EV/xTF
         je9dVAqXerh4qSRAS8QXP4IY8Z57bXXMywS7DpRsyBaBaNNVRwL/U5CuX6srnedGdSRB
         jKxiKv7vrwESuQKrfS3jSm2xb5PnLR9VS8DVUXcqFGbcgovH+OjQibM9HhglWgNR0pp3
         OCA1z/1LAmKSGsPNWNalkfAR2hzqxC2MOozwWTerBg2Qq4Vr0KvWguIuIg+/CpmoPtoU
         nhGQzhmDl4dI8ss5IJgSkg6NOJON4qcuTqJoDyKr8gMg2wOEotZLwA0F+9aYpx1zHgHF
         tJeg==
X-Gm-Message-State: AOJu0YxfELTlHNfrv8SA9IbybTRAPnmzVaOvNAxsUztH/esTwBzN+trb
	CBw1TpfTsGB2qmqCDVeo6frXnIa/lQkCH9UwmGX1OtlF5iwpVgt8KzwN
X-Gm-Gg: ASbGncuEp18kF2re7ZAISYSygLg8KoZSrgOsSJFK1KbF+iriKeny3CJ/LHHoMw68fVB
	2QAQB0sHk3Fph1YfJ2eBxRmx4JBpPD1SjPVXWRczQavvThTFqZVFsPLnLGLohyLcYjJUFd0gpCj
	syzhs+t931136FxUG1uYidcBlV2VC7jXP/i0uK4J6RsgpEVWhy1F+Rv7BCpOy57MsZVhQhYxdjS
	UKmYFLH5aYGpPpjOWTSoWtpOwrg28IH9gNS/BdOhaj1dfu0OaAKz9OjvYXKoxgZLCZkN/lLs4HT
	2jSo0fVmNwM/UKiiNbj1pGwvOS/qVnMt0jnfZu4WFEU3WPQKkZcVZgtwKrxI7M9XvXPph9XoQ8t
	g6wJr5N81tI9DGKhuubjDa0wGvzesZJK00AK1k2zUdhIqKIRl4HBcIpNfLzhbtYOnzqade3s=
X-Google-Smtp-Source: AGHT+IEqhWT9kRq3x7sRjETmq47GmR2SqR1YNEZkhyvoDtGSGrchTQwPFPrqHH522oVmz7oMdfz+yQ==
X-Received: by 2002:a17:903:292:b0:25e:5d83:2ddd with SMTP id d9443c01a7336-27ed4ac32dcmr87235415ad.45.1758903174334;
        Fri, 26 Sep 2025 09:12:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6725bbesm58952515ad.60.2025.09.26.09.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 09:12:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1ac6f9ac-ff6e-4276-a6d6-c3f115db9b8a@roeck-us.net>
Date: Fri, 26 Sep 2025 09:12:51 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: hwmon: add MP2925 and MP2929 driver
To: "Colin King (gmail)" <colin.i.king@gmail.com>,
 Wensheng Wang <wenswang@yeah.net>, linux-hwmon@vger.kernel.org
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <391ee227-54e2-475c-9811-710fa22687ef@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <391ee227-54e2-475c-9811-710fa22687ef@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/26/25 07:17, Colin King (gmail) wrote:
> Hi,
> 
> Static analysis on linux-next has found an issue in function mp2925_write_word_data with the following commit:
> 
> commit b3a4efc88601cb5fc97b4ae23c478700a60302da
> Author: Wensheng Wang <wenswang@yeah.net>
> Date:   Thu Sep 18 16:06:03 2025 +0800
> 
>      hwmon: add MP2925 and MP2929 driver
> 
> 
> The issue is as follows:
> 
>          case PMBUS_VOUT_OV_FAULT_LIMIT:
>          case PMBUS_VOUT_UV_FAULT_LIMIT:
>                  ret = pmbus_write_word_data(client, page, reg,
>                                              (ret & ~GENMASK(11, 0)) |
>                                  FIELD_PREP(GENMASK(11, 0),
>                                             DIV_ROUND_CLOSEST(word * MP2925_VOUT_OVUV_DIV,
> 
> MP2925_VOUT_OVUV_UINT)));
>                  break;
> 
> The call to pmbus_write_word_data() is accessing variable ret via the mask ~GENMASK(11, 0) however at this point ret has not been initialized so it contains a garbage value.
> 

Yes, that was also reported by 0-day. Patches now dropped from linux-next since I can not
figure out the intended use (datasheets are not public, or, rather, the chips don't even
officially exist).

Guenter


