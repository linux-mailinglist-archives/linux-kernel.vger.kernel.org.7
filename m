Return-Path: <linux-kernel+bounces-886819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F6FC368AC
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 236974FCEE4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6707833DEE4;
	Wed,  5 Nov 2025 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjFlp/Re"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AF8334C0C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762357776; cv=none; b=Ez+6MEM0tO5P1alWbuEjvI+NSNX5Z31aliEsWr9Sevg2Ck8k6eUz0AtZznLnN6xTyXZp4ccopTPp+72RFqX1POxvoP3XVBz4xgugm+wa6opQAb9ZM1v3WXBQmNel9gWJ9mevamUomEvJ4/17tOrE0IV7h5HvfURy7lB/Zz4QZDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762357776; c=relaxed/simple;
	bh=DtATJshX8Uw22T0PAFWfM5w5TCFndGBfJmM2TM7nGJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a9QGjbEx4hUM7R1BN3EbvZmtjwSFAa+iTc2jxnNy83KGuFJwrDBIAjzOJhhIeLTV66ySLDK6rQWAoR4gWX1igf4dACrfa16lcCcbAUUf8m1VfsvQkTUHOJ9PZgKOAQPHOVEVLXbKTsOj7tY2a7Ba1NS4zJzdrWWv5La229GoMFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjFlp/Re; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-429cf861327so1290307f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 07:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762357773; x=1762962573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XcEZQFVnOtJdsvRu0YCs5+hYadtJeqzkPyRDef1hGG0=;
        b=gjFlp/ReyvozfdECxOHUx3nS9r72ELtFNO33lrbOKM7wznjEm7NAjhELmegkzWBNAH
         DIAGxqVcEzbC+nZ6XJLN0y0Wvk/I7MHh5wfj1qK5zztjZjFYn9S2vjGo9C/LX61XXzkB
         MLWNdFgbCuH2D04TqwHN03NB+wlFIln3WJFivQcJl1C5ZbdgiLjcC3eMH6giUc6hv48M
         BXAoMKG+IAbXmhzEZ8wJ4YcoybrMI9Ugj8afOrV4anzsQDdMaZ45HqyKMf597tGDEOHa
         KvNnSzGMO5mALAMrtxq8Pc7SsTk7oPkVWtxIsH9Eo0jNIocm++W/HXOUj5GPS3vlzgpO
         wmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762357773; x=1762962573;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XcEZQFVnOtJdsvRu0YCs5+hYadtJeqzkPyRDef1hGG0=;
        b=qYMDwVn8tnGSinANnrpA/oyffcx//FmPDN+YW42WR6HM27KAwZljBLGCrrnByxiWtL
         iyOnUh9TdCcJuJqNqLyuHPdqmVthtDjCPhRpfdWxCBjtLjbuJDxKsaTHo8JnBdkeP8cI
         4uJeke9JZDBq/+q3v0lbJH6/QV5dpV7yEJesWIF6t+cgOJrYgDMuiEIvVEEYBYgRhf4n
         tIJmU1MuXCLJk+lg7JBJmfAmDdX2oWAap9ip5/c7WIsQiTa6WMe6FVvRqoJQvSs9295H
         WBATD8trNaXLgdnBPGwU58toMpybj1mxfwKGMO/lsZJF2EOgJgh24TqfCJAB0ZESZRUS
         qZng==
X-Forwarded-Encrypted: i=1; AJvYcCVO9XRlAuy33a6F/sMaw7USu18bx2BFGiSc8pKtrG2y+dMTlB+ZxnJb+YXtXeoKtLiKlBSFANdyOBMkkao=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGtsQMBB6BQussqxsfhm5vvMuia+FxV5ZjJ2FMRXGJHtcrxEwu
	TRtP3fgcm5yzcsQpQ8td/pcWiy7PdbpKsvRyja+ZM1mljCoAE4pjpCWg/eoRVA==
X-Gm-Gg: ASbGncvWKPbSl3sUGwFl3a0K2thakenJCt25yiLb0NFvvzhyGoevovdP/YlMFL3IYzn
	H8ZJ6rMKwuYp6Ast114G76nmdOsX9nRn2itRQY8U4fLEPSgG/8GhAkqkP20ndG5MkhFxiGe3IsY
	36XQD4TeJi0tYWYLVWN+NxnUxVCaUwwgh0aWTsGz+4srCwbQ88cWC9YWjrhN6GgIpu693MVxvzw
	jkmEFp1toNcP3G3d+bgoRyJDHKnaxnfbRgi4QmohPP1vixbIcocA4Sphx1ki78WVWuBZ2KDxuTq
	zDV+Pdm5jDqtYKTj1iv+SsAKaBLYIYC/SZnbs94cAEwAH9+1VmHl7vWHaFyAq0m1i055ZgiCFDa
	JEzQZsp6Rm/YghC4EZyrFATfO7mH+WnhPrQKLQkrTNHi223A11hA/UOH9PZzpcQPWURoHeTU01B
	5cQtTZrvXeJZCofc3taXNC0LhLyO6go6U9RqO7D7HmBXsny0GPpKLShVAtNLL67jgzChTCMi2YV
	FuldAxGbtBs1Q==
X-Google-Smtp-Source: AGHT+IEzs1S1sLAl7p/we9qqsVeyvz/pALsABAmrgieR9Td73H2qHs3uXGuyNO1AkR/BhQluU5EN8Q==
X-Received: by 2002:a5d:5f91:0:b0:429:a867:41f2 with SMTP id ffacd0b85a97d-429e330bf0bmr2820132f8f.49.1762357773110;
        Wed, 05 Nov 2025 07:49:33 -0800 (PST)
Received: from ?IPV6:2001:9e8:f106:5b01:5cbf:5078:e623:8643? ([2001:9e8:f106:5b01:5cbf:5078:e623:8643])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f5be4sm11086326f8f.31.2025.11.05.07.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 07:49:32 -0800 (PST)
Message-ID: <ebeada4e-d739-4a8f-8e5f-a8de0d4e885e@gmail.com>
Date: Wed, 5 Nov 2025 16:49:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] gpio: add gpio-line-mux driver
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>, Peter Rosin <peda@axentia.se>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Richard <thomas.richard@bootlin.com>
References: <20251105103607.393353-1-jelonek.jonas@gmail.com>
 <20251105103607.393353-3-jelonek.jonas@gmail.com>
 <CAMRc=MdQLN5s+MpkLUF2Ggc4vYo30zOXrA=8qkGmXvu7N3JjeA@mail.gmail.com>
 <12efb5b2-058e-4a9c-a45d-4b1b0ee350e7@gmail.com>
 <CAMRc=MehBmd+-z5PRQ04UTWVFYzn7U4=32kyvDCf4ZQ4iTqXhw@mail.gmail.com>
 <74603667-c77a-e791-d692-34d0201e5968@axentia.se>
 <CAMRc=MdkkRnwxx3vcMB3duOteQNdC9eb+A1P4GActou=xY9yJQ@mail.gmail.com>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <CAMRc=MdkkRnwxx3vcMB3duOteQNdC9eb+A1P4GActou=xY9yJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 05.11.25 16:37, Bartosz Golaszewski wrote:
> Ah, that's what you get for revieweing with a fever. :/
>
> You're right of course.
>
> And yes, we'd need to modify the bindings.
>
>> Or, are we talking about
>>
>>         glm->shared_gpio = devm_gpiod_get(dev, "muxed", GPIOD_ASIS);
>>
>> and
>>
>>         muxed-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
>>
>> ?
>>
> I would make it: glm->muxed_gpio = devm_gpiod_get(dev, "muxed", GPIOD_ASIS);
>
> Jonas, could you please send another version with that addressed both
> here and in the bindings?

Yes, I'll do.

> Bartosz

Best,
Jonas

