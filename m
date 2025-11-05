Return-Path: <linux-kernel+bounces-886842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31519C36BC0
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D01D3A5F27
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADD6334692;
	Wed,  5 Nov 2025 16:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hENwCIhG"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47446333755
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358717; cv=none; b=U5GIkyTqm4xF+9WzJ8TZ3ia/JOWDccvTREzrgQXsXBNJfO1kIg0BCpMaVwFYNRCDukjdLjaNN6wsZV+gLeykT5+oeEgALjY0kECDRFs/Pmti68levH82ZTv/wMLJWKNf0APU9N2Q2CJqL2pHXnbL6kD2Y61DGBwmdYt8pZXXsrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358717; c=relaxed/simple;
	bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Me9FGS6lMt7I/LkTsk1YED0w9I53iz/03omo4aZymQ/e2VGHgixLbXqPD3eShhbo4F6zX/7Rs4Ux3ee/iNZDCCgp3Gio8OdVux/a7wV5ptfKQ9HYGCZLNYjZ1rQPVBcp+nGxeDbhOOyhfHjNmx1ccoyzRXvKto2rCKtbsT5S3XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hENwCIhG; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso11521636a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762358714; x=1762963514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
        b=hENwCIhGKqCzd8LgQc0blP4zGkTKatUNzALQjiKSsQkn5oJZf4hai0EhW4B57cdFv6
         K0626mapCt3Tzx0jL6fcl8Xo/9BVxqMMrHUZnHBV6GD5ru8rqyraqivim7bKk4gZdlnh
         Bc5eLWAEj8dC3Kvt66ucKR5qOyTn84l+57FauCvoJ4uxB4WBhzZqQ13GYQVTkznXsm8n
         1M7/VsgH4tjexnc8v4QiXXa2/2fv0J3XDdEt5gRUnySgk0QzFCHxLUsn9gFsJ1XjzRSi
         DxAoKH82W94dGtTLEdtldzNZjolWVJZbfj5VP/LGwHdT8NIBpQlkgEblYuIbe+6au9rr
         wSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762358714; x=1762963514;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
        b=oLfMawwJ4vajCC7kOTmu+6ItN/QTV74rnGtmUx1V9JM6frIs8CnKMy0i6oL/Q20gSC
         aGulxEymO0l6REEt/KsnnXjYXPn/r3XQqcHoAPQsRJyVsdKpBk7ypNqVpGT3lhZB9l3Y
         me8y4wjJeI15Zs8LM9NXVIKWe0hloGlWaR7XFECU4/jWw11LNlaemTusq+i0E8BkUDrg
         sr3FjPJaFLWa1qrjS7pNGhTFOJQxMfpcxDtch9x01jTacPOGdnKQ3lPGTttffeoPao2g
         OcwmWZr50oL0jKYHT8RuehU5sg61YTPvzLfn2lpCrzoS4k6z8sob1glvRoXh9590jsZ+
         7NDg==
X-Forwarded-Encrypted: i=1; AJvYcCWE++SYf3zF/POAEeB4OUpk4rXJr7d4WqL4lxw2L56c2gN0A8X6lpNXVpmyECNf5LlN+ybO7+fRHCLOpVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyioQ+LaDs6HHSDkl39b1cP+ddKmVnmG+sBFiCM/JLRfQeWPTWP
	upl1NNiol0wCsFaQU/pPw8YpPHSPOkN2aPYTYM5CV8BguQOy+934NN+tZIzw09oTFf4=
X-Gm-Gg: ASbGnctDktcmybu0vYdRPFWW9aA7jnkqv4Fxr0No0mdI0CGChPBm+5J8MnLg4xonJ2E
	vgfUt3XGp/7K1OEvF89YmiqSW+xm9oX9bSYA9eZUg1BBWkB271sacbNYF1bwAXinkeGVvUL6AHh
	q0Fd62hGT12P0/rwBHAUYvKdeUiouBXXMVaJ8tpQR+WQf/7z9IErtS82HiQK4F6eCrVm6L+ULhf
	/sf1/DHAs5m+dbvt21o/awP73Q/KzvyucWgTR9H6xTZxFjo0mq4Tq5aw7dQCb/APZEbYvoPyLg2
	7gjUn5ZQmc4DHE5gHivNTlmqR+/4O/KYo++B9hDclGweshuoAAJWcdynBwoy8ayBcKqp4FGrqr7
	mo/9OkFWFWz40O7KBWU0jPCWqSMZrbArEB6y7mvN8fxE/ITaMFcJyKsp8VcrVz5VnaPRvjdBwhO
	vXDYHoYfa4lqswshYBjwdg5iM=
X-Google-Smtp-Source: AGHT+IEZ4jSMqgU1j3ShuBTWV7Zpy421hTwNR5u92fURxhF1PiKkkzbDZyzXF4ZYvCapBIQeuCyJsA==
X-Received: by 2002:a05:6402:3247:10b0:63c:4da1:9a10 with SMTP id 4fb4d7f45d1cf-64105b9d03cmr2682548a12.31.1762358714583;
        Wed, 05 Nov 2025 08:05:14 -0800 (PST)
Received: from [172.20.148.132] ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e680578esm4903569a12.10.2025.11.05.08.05.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 08:05:14 -0800 (PST)
Message-ID: <fbe28f12-b462-4620-80ef-b6ba5ff3e0a3@linaro.org>
Date: Wed, 5 Nov 2025 17:05:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/28] mtd: spinand: Remove stale definitions
To: Miquel Raynal <miquel.raynal@bootlin.com>, Mark Brown
 <broonie@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
 <20251031-winbond-v6-17-rc1-oddr-v1-6-be42de23ebf1@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251031-winbond-v6-17-rc1-oddr-v1-6-be42de23ebf1@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

