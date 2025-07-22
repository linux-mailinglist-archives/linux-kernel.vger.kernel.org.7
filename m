Return-Path: <linux-kernel+bounces-740468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF110B0D47F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C9267AEEE8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338BE2D3A97;
	Tue, 22 Jul 2025 08:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AoVzGfFo"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516DF13B280
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172713; cv=none; b=TN7b61fEWtmgt4tgHdx2Zy5Do3DDkpMP/hGRqpvRJwL4F/vb9g1Zrcd+KsT9jqUvU74uOizjB07unYLjHQuqfBs/rqKGTdDgsjbj3p0k8ZmoegxAIwcpJAbwEig8tM58qcKkgPZ/i1ZnnhdCacCLNT3xNFLoPToFxXjCQuYP1j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172713; c=relaxed/simple;
	bh=fhX/jJRHsuipXm7qSaqjpefaXZu2sYTweKp/b32BnUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S3rNYk320XXHRbn+EvKy8UJei61rVKOmXRmv215DXng8iK7uTW8pwBz+vuY+NKcn7jMD0PKHAJRio9Tt/7FSO4IDT+XKT2wposg5p8h4uN6kh2XRwL2c89xuVQ21tcfPUD3pZT/FMfX6mQhvX3+3s5Ph2EWKTr1YnFQwLla/i48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AoVzGfFo; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae361e8ec32so903178366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 01:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753172709; x=1753777509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OFwXl4R4U+v4tdLgyEw7EAG9uIf+XrmB60PG3fDfino=;
        b=AoVzGfFoomDLk3cZmf4KNajib2ePdIWVDkt2CNW77tB3Ow6AlQL+fZKh54k294Z1vl
         K0derfooeqP0wvo/ZE9NVxdXvJ0Z7dZDwROn4tT01jfq4HM6VrT+YvfLVNOzTih21zh6
         iETPYrWdZpsVLsYajndeQF4UKhRZrEt3If6iq436A2n31VyoIAyDZKrCVjrvx+qyMnfN
         ipYEzIwTzee/nSY+sxqufo55xPvD/47ESGRh3QJFQPPB/a2XhZ5MO3zDI0x7xeZgYLYw
         7AagXRv/WRz3QoCO0mm33MQnAzhu21qkSORTL8qJVI4jAxM8QjbOSzHP3knaxjCZfgkN
         /MBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753172709; x=1753777509;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OFwXl4R4U+v4tdLgyEw7EAG9uIf+XrmB60PG3fDfino=;
        b=d7FeuGgBIzOnIzXxTcfZ1yMsTUGaJyiF+t7RMHQNfajtmXIhv8RF4DJANGN13FSw1p
         mZojO8Frpg+lccLGnwTkFYmYz0lXmIMJDOhc5x8BQnKilTiBieQ521xUQbBgKGvRFc8e
         W7PkVkb7Gji4aZ0eglKcZCu4XzA8mvysYBLAXjrHdolfFmAUUxj1xT8Pj8SCkTkhCnvw
         puLEulNCe1F8tmOCp8g5BrQBhIW1kHaqa7oWyGU3aHJuMESYCVQ4RS8h8KxQyfV5niek
         0gdoIrlDyCSuPIE9PzDb4xNh82rL7aDO6K/TUYSiGap3Sc0ThB7Fekx0lvySWmcNN6ei
         kyjA==
X-Forwarded-Encrypted: i=1; AJvYcCVzOXTZmtJ9PkQUSjovlr7Aur4/L5+OGl3s9lXGYiDQK6C6XACNvGjFzVKJ56lH+hBDEjdGNEkDDKqUjqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK3D+LCEKHoDf94lQD5M0DIUq2STPd20q3pL7bK5ueJsCCDoON
	qtNTil0+tOzQdVS73SbYUZqT3uwjDI055uJ/SL4LiUq/Cf7ecsz3ELureYgpRwmg3bY=
X-Gm-Gg: ASbGncv7HIlH9/f2k3AXMrcb5raRgmhQXMWd0dATlcgeWmWpnAr1tukY7C7xSeWuiAU
	x3WZqqwAW4iN0PePiujXaWAa9ctIRWXdCrLasf+CokI0dX3j5mMr9i+1buc44NEizMFnJZFf4W1
	S5w71/ALQ3o85P/rgua54HZfAc6vW+MqNJWwm8YwoWgNXQq6gk4nbICrBzPdn/e+foZiglxxfjy
	UoegznI2VpjUmkSJ6egx7J9/goZRxvojPmZFutkgaaAESRhQPRWaQSV4YxK7/UbpHuCUcSZ2kVW
	xKbymu/y6Lkmib+9HqeMNAPNCaiNZx6LxXSPQce4zvqF1PXdNSgB+HRWSWlLvfr2+O8uoy0hjp/
	71TCacpe+ESvkj63eWUB/wekaEdPR8WM=
X-Google-Smtp-Source: AGHT+IHUgNamYSRn7L3IbwI7Bkin+XzznJuVtBjJoxsI+pciH450o4XSVYaP75Gf+gs7xT7SLYI4fw==
X-Received: by 2002:a17:907:bd90:b0:ad8:a04e:dbd9 with SMTP id a640c23a62f3a-ae9c9b14a3bmr2479352866b.31.1753172709516;
        Tue, 22 Jul 2025 01:25:09 -0700 (PDT)
Received: from [172.20.10.10] ([46.97.171.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c79cce7sm826035766b.24.2025.07.22.01.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 01:25:09 -0700 (PDT)
Message-ID: <2de4ebd5-fade-49de-9c16-69ca0273bf7e@linaro.org>
Date: Tue, 22 Jul 2025 09:25:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: spi-nor: winbond: Add support for W77Q51NW
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 linux-mtd@lists.infradead.org
Cc: Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Pratyush Yadav <pratyush@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
References: <20250721202257.83936-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250721202257.83936-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/21/25 9:22 PM, Marek Vasut wrote:
> Add IDs for Winbond W77Q51NW, 512M-bit Secure Serial Flash Memory
> with Post-Quantum Cryptography, Dual/Quad SPI, QPI and DTR . The
> flash part is similar to W25Q512NWM .
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

