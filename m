Return-Path: <linux-kernel+bounces-833321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8C0BA1AA4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027114A0CC0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C5A2F5306;
	Thu, 25 Sep 2025 21:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTgHEwM3"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1031F91D6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836774; cv=none; b=VLUDzDveZDb7awLcn+3arnnXjDKR7B+m8nWyuR8gO64N0pLnL10rYTWvyVwyrWAR50l4ywYrr6D+QWO2i1ZlAdoNa2d3Esb41SIL2CXMZkEzhIcJZEkDL3EITlWoE1yVEBFcH07Jq6aV8zXDzBhJHUNVULA5dNecrMkhqFigSiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836774; c=relaxed/simple;
	bh=jw4AgoZPRQFGh3biyZBcEMRiVCUFSYcUXqzTm/yIDkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rdydsHuEpkHMZ1a63J7h//O5ndhli+6z/qRMKYlHIO1An5ULRPu4xkFlVeQGUV5r17OUhUHuIlJtNEf2uQDb7GP/LCOzOMGUIoL3nbVFpnwDSKx0DbygFXnMI8Ro/7i+QmFRUqMNmbd4zApLRaQ6y/dLKgifteFnDFfa9jwiGy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTgHEwM3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45ed646b656so10358365e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758836770; x=1759441570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jw4AgoZPRQFGh3biyZBcEMRiVCUFSYcUXqzTm/yIDkA=;
        b=MTgHEwM3CAnNT5IOqybGvfHf7sfUgs5YLEaWESDDfLZhOg0HO7DUU0Td/QtOVTmPZb
         MOv4Mt06RgAQEFH08AfIKddjTQt8MhRo/DUxSILI2Vynq8vOc6sOY08Dob6SPEIX2mhb
         JaZaa4dSt0FTY6cGQpATdCTzoYvKNySJiLl16sJoGsarz4GZN9nGk0ug+LbWNtukPm2w
         NFmeW6Pwx4B+9wvpptWh4u9l4erNr5ElZjyFZiLohszUmI0wTFtwOi5jwAwNBBIj1FiL
         we7BleCUuqTeqit2lLSx0PxP7cFbTEEuKUryrBaKAwvRYj3lbPYG66MB7PVNOMsLd8+D
         1fng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758836770; x=1759441570;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jw4AgoZPRQFGh3biyZBcEMRiVCUFSYcUXqzTm/yIDkA=;
        b=sTppRDpDT5YynXa4qxKqONR+grgjrACa0GD0eCvXomHNlQtjHLj14TTnhR2/mRw5xr
         ImHKY2p8eGQU+dKs7OPsKate4L/n2XdHz79do4xuw/IutMSygQy8kZIf5MM/+czyeCiN
         y3pKS4n015MOTDJQS5pteQW/2R6554nBy6d6NMSh0G6W5C6xViy1yyZ5x7Jj6eJ7wpD8
         Vydb8frnr+zA4Yp5pE6R4ydvBWTApoqZo7zYdM8Arx9TErUc+WoUdTqE7LQ1g8XcQXqr
         haAa6PlNwtDM8xX3ggHTw/oKzUcf6+RznlewprRJAgSX0mCWT/6W6DF/YhQJ8iZVInCk
         gEcw==
X-Forwarded-Encrypted: i=1; AJvYcCXEllsKVqfOsXkp3ewpP2OdVkAJqWWM3ZwhJAB72KchK36aiHJd7QnanvXO/AR6IYpCOdei0n8XDB2nxvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy92G3FPvR0AJR/4ayTDSL37talmmU9CIQOs86xu+dly43tw1mh
	SxFGHQizpZlVV4ZMFz4Bz/C2qZzsTizJ7CAGlThSR2Ec+sTVPKDBia8a
X-Gm-Gg: ASbGncut7EKekdXPyNYNHgYcSXQWZXjiJXz5eLkhiCdWc9uliEyzmAoSPk2XOVSKYiw
	TCd5xxuxXD/k5srXJw0xGGKYT3DnVgTF4UAvYWn9PCUARy/UEabO6dJdZVAbsxrIBCdcM7H8DP9
	QGsN6G96iQzc3qgFjoWtCCen6YoBhEjexc2B1PyymxgN+o67UR7P7jAGKvPmyp/L2OGDZ+j8bID
	wqSmbpXsw3xcxAQwYeq9Qzk0BvYL7XwhGzWuVcWEh2eX9n5A8dQNEJWUNNS0flMw9pB21zTjDR4
	iF7MFX6n3WyQddqUmkAgXQAsAOsxxpIRaSutHpOZhJ1CY8auEO8tjudTow38mUnlZfJjH8s7Qjv
	GXJ7tBfInOTfj1UByi1EohOj/oddr78c42RhaX/T/g7ArAT6aRBm8Yq9FDX9Nq4xGGS0XeDYAgK
	4nNdTN9ix+TKE2PmrD
X-Google-Smtp-Source: AGHT+IE2xAcSQuVcodr/7hBVP7bq8EdfLJE4Esmkq4G3jP1jFOI8kOHeGuKLezUsQ9xVBsjiAJFyig==
X-Received: by 2002:a05:600c:1c24:b0:46e:3686:a2dd with SMTP id 5b1f17b1804b1-46e3686a524mr43098075e9.11.1758836770122;
        Thu, 25 Sep 2025 14:46:10 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f10e:2c01:2019:a9e4:7f02:ec05? ([2001:9e8:f10e:2c01:2019:a9e4:7f02:ec05])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e32b5504csm26022235e9.0.2025.09.25.14.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 14:46:09 -0700 (PDT)
Message-ID: <476cd546-1bde-4ff0-a785-2e6fa21b79d4@gmail.com>
Date: Thu, 25 Sep 2025 23:46:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/12] i2c: rtl9300: use regmap fields and API for
 registers
Content-Language: en-US
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-i2c@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Markus Stockhausen
 <markus.stockhausen@gmx.de>, Sven Eckelmann <sven@narfation.org>,
 Harshal Gohel <hg@simonwunderlich.de>
References: <20250831100457.3114-1-jelonek.jonas@gmail.com>
 <20250831100457.3114-5-jelonek.jonas@gmail.com> <aNW0jiJQHcS-FKwr@shikoro>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <aNW0jiJQHcS-FKwr@shikoro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 25.09.25 23:30, Wolfram Sang wrote:
> On Sun, Aug 31, 2025 at 10:04:49AM +0000, Jonas Jelonek wrote:
>> Adapt the RTL9300 I2C controller driver to use more of the regmap
>> API, especially make use of reg_field and regmap_field instead of macros
>> to represent registers. Most register operations are performed through
>> regmap_field_* API then.
>>
>> Handle SCL selection using separate chip-specific functions since this
>> is already known to differ between the Realtek SoC families in such a
>> way that this cannot be properly handled using just a different
>> reg_field.
>>
>> This makes it easier to add support for newer generations or to handle
>> differences between specific revisions within a series. Just by
>> defining a separate driver data structure with the corresponding
>> register field definitions and linking it to a new compatible.
>>
>> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
>> Tested-by: Sven Eckelmann <sven@narfation.org>
>> Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>> Tested-by: Chris Packham <chris.packham@alliedtelesis.co.nz> # On RTL9302C based board
>> Tested-by: Markus Stockhausen <markus.stockhausen@gmx.de>
> I wanted to apply the rest of this series but applying fails. Can you
> kindly rebase it to 6.17-rc5 or later?
>

I just noticed that it seems like an already applied patch got lost [1].
This was supposed to be merged to Andi's i2c/i2c-host [2] and actually was
there until the first three patches of this series got merged.

Since I had already issue a few days ago trying to rebase the remaining
patches, this might be the cause it also fails for you?

Best,
Jonas Jelonek

[1] https://lore.kernel.org/linux-i2c/20250810-i2c-rtl9300-multi-byte-v5-5-cd9dca0db722@narfation.org/
[2] https://lore.kernel.org/linux-i2c/a422shurtl3xrvnh2ieynqq2kw5awqnmall2wjdpozx336m26i@54ekftmkwvrv/


