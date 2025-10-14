Return-Path: <linux-kernel+bounces-852766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED45BD9D77
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2413BA213
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619DE30CD9E;
	Tue, 14 Oct 2025 14:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0MbkMKT"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4814A2E2F09
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760450501; cv=none; b=rkqGwH8/auPmaGrGawtrXfTFR6ZUIQ07GvYpomiv6tV1HC5uEnc2UFbgNpIUIb1FPmkedJQqw0j8+T4ibKDbrVPWMkiQ6HHaqP7pEcjQj522P33FbC9ZQGRmO+prKFz8FptvNpPMaYai4BHMPNyMlatdWo5VzE8wquG3V9DPpkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760450501; c=relaxed/simple;
	bh=ORkyXfUlrCWsmh6RANOw0pZZxMqtCdH/gG/DbxBBa40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ya4hp3IxcgdHrIyzJ9qrGx0mIZxlzeZl1aAsexNDd0ZOh8Ojq9v52+f35omjgVyO3tuuu6ELhl0FHLJ+jLL7YA12sf7KlOzwAYmlRjLlBvWzAu75t/HytQeHu8871nvhAcZKhKGRR9A2jIMRV2DlL24CWKQqBpXBx4K83Y/bumw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0MbkMKT; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-87bf3d1e7faso20123086d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760450499; x=1761055299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LS/tbUNJsSKY6ZBKj3q4etRpyWDlKJg9S7gh6A/LQgo=;
        b=L0MbkMKTdkUFEd10cDZu8mG+7eaqSz9iE5HgOOX2sgcD2dA991d4OX8szIm4Ue6Erk
         dYe3JsUVx3xfWSpyUStkRHEWRml3EFbna7dQbFbCBJncXvgMfl8ziHETcSpt5cBEPY30
         2KfbMp18oqAtub7pAqHXzeqSCHpJHYTLa/zUyfpkFoljWQYgj7pfI0NWM2fEUVIjEfM3
         F33KNfiAEW1Yt1Ygwzy5wg/U+0U0E6WHebJc21n0VF1kG2nbNKm6wHYMmuzjetgVL9+C
         Ub+F3fDSvTTyGrzVnRvQC6xJ4+NnxrpcilO5AJZiu1ZBs6cUYJVNZx6abmQHzU1qVwIn
         Y6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760450499; x=1761055299;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LS/tbUNJsSKY6ZBKj3q4etRpyWDlKJg9S7gh6A/LQgo=;
        b=RAtmMpALZp+mTuawA0NIt+O0MtBYdlu0k6bNl3JaZ2YXfsNZ54iIOfHwV2lIDKs6Qs
         8njrtNGz5lYE2BEfiCd46czQy3GEoQllxYy1iRLs2014QIVZzMgHYpHb02TVsEPzUQh6
         w2qFvMw/s72p5yrrCECEwdc7ZtWdhIz/DhLoLcQVFqcseXRAp2OT4TFAi8fmjo2W16gG
         Bnqf6l3j4Ow1+0Qp+WCEcvw0wbfTU4yzjhRAJbfpX9hM/CS0cy8Lw/pH7lQCosJA62SV
         +xv8i9SyD8V/+u3cRTJY3MYfAk1Cbr9oAq9e2dJGnv/bv99k25FZGM6fm72Ae6WNLFiu
         zMfw==
X-Forwarded-Encrypted: i=1; AJvYcCXS9IW40zLIK+661n71zVi6suWiMbR/uCY9sq3rhShIxS1YFoOWKsbIuZpytdfZTD8Y95yA6THrZmB97ZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8SS0Uto6dmF2fbqdg9vGdreyqV1LmyGfM6BFwlhfimbpFgEJF
	IQSdoU9xFUfrjbKIFSSxVYnfadgz0ZWha6UaEnRINeQT4AyFRbkVvEfs
X-Gm-Gg: ASbGncu6UsKMEVq2ps/RDK6DxZVcR8zSy/wJ9pGqT0dBqbB0ptyUPO88yoxKOvT/xhh
	HVHSoxjac8ba5y73/ygbhq1HuCHq37edx14Y0OxVx7rDq0xSSpwGN50NwHtzGWyeeq57COtJsS/
	qyMuKc1OUaN0EVPp8ZCtWmqsuWaBXJdf2nfv0A7wgo1NVdPTFvzAAVmPY3qMOVDH3siRUMOr91E
	UcOBwb0LlZE7laARv7XKPyDYzuMU3rZzH5NdhX/r159Kq72kmeiXBjBmpVwPedkOlRc90m5l9Q0
	uXLwh3qXWEE80BuA8Q3OD1TkCpxqjLRXml5Rj7PqJ7lL73d9NFh+sFCmPz7Tn87/lZ3SwAqKFq/
	YYnwJrdbyC03oJU7eM+1k9Z6UiTcv9E9pwI+OGpD4nFfurrfLKWXiWb+MEEPWzwNembi3eJ3My0
	LpLxI=
X-Google-Smtp-Source: AGHT+IFLWmAN9G07TTGLUzgifyDJgAAk5U/8bI9uGvO0YQEdEpRvVcRB55hOrODs3UAIlksFawlP9Q==
X-Received: by 2002:a05:6214:1c0c:b0:802:3d9c:4450 with SMTP id 6a1803df08f44-87b21032734mr363621256d6.19.1760450498747;
        Tue, 14 Oct 2025 07:01:38 -0700 (PDT)
Received: from [192.168.0.155] ([170.10.253.128])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87bc35ad1b7sm92609116d6.58.2025.10.14.07.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 07:01:30 -0700 (PDT)
Message-ID: <8918310c-d0aa-4e02-b9d4-9aac98b0a48f@gmail.com>
Date: Tue, 14 Oct 2025 10:01:28 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: greybus: documentation: replace strncpy() with
 strscpy_pad()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: gregkh@linuxfoundation.org, johan@kernel.org, elder@kernel.org,
 schopin@ubuntu.com, me@abhy.me, greybus-dev@lists.linaro.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20251014134148.2597178-1-vivek.balachandhar@gmail.com>
 <aO5VvrKTswmfO-n9@stanley.mountain>
Content-Language: en-CA
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
In-Reply-To: <aO5VvrKTswmfO-n9@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Yes, Dan. Nice catch. Building it with below sample change:

memset(&intf_load.firmware_tag, 0, GB_FIRMWARE_U_TAG_MAX_SIZE);
strncpy((char *)&intf_load.firmware_tag, firmware_tag,
         GB_FIRMWARE_U_TAG_MAX_SIZE - 1);

If it works, will send another patch.

Best, Vivek.


On 2025-10-14 9:53 a.m., Dan Carpenter wrote:
> On Tue, Oct 14, 2025 at 01:41:48PM +0000, Vivek BalachandharTN wrote:
>> strncpy() does not guarantee NUL-termination and is deprecated for
>> NUL-terminated strings. Replace it with strscpy_pad(), which guarantees
>> NUL-termination and zero-pads the remaining bytes, matching the fixed-size
>> firmware tag semantics.
>>
>> Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
>> ---
>>   .../greybus/Documentation/firmware/firmware.c        | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/staging/greybus/Documentation/firmware/firmware.c b/drivers/staging/greybus/Documentation/firmware/firmware.c
>> index 3b35ef6d4adb..deac8584841b 100644
>> --- a/drivers/staging/greybus/Documentation/firmware/firmware.c
>> +++ b/drivers/staging/greybus/Documentation/firmware/firmware.c
> This is sample user space code so the strscpy_pad() isn't available.  It
> will break the compile.
>
> regards,
> dan carpenter
>

