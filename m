Return-Path: <linux-kernel+bounces-757206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4E7B1BF16
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 05:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AAC3626A59
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 03:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97601E25E3;
	Wed,  6 Aug 2025 03:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfdPMSq1"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521EE199931;
	Wed,  6 Aug 2025 03:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754450102; cv=none; b=W2+o1jNHSIdnWioJfBp7G6mfRuU7P5SrYJQLnbjoUq5AqGkAOa30Rdu8nykFbBYAkRVZc8owq0acUYIHjZoVGr2IoJ+HkT76hJNpsF9ysKuW2miP/9foXn8EZm2vA3M1sl0nLQQYL9WC2xqUDrZyBgPWrtpzKjf1bERHvyklHUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754450102; c=relaxed/simple;
	bh=EbY3vb5nJiuhstH/MUgZ/kdqRmd3CcCHo2dRcTLXkOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lsbI8JvZz2wTSat3wPrj95ZGe2sEjKl3Q9odFcWH8yM6MC2+sQOQ4EphTNJCRUqw7uEkBAVRVQ52Ps2xv0o/jbunQdn7qse4KWDOK0VhYXDdft6AWugQHHobQgXvRcjNLw3IvL/pqFWJ02DdYRd4CCrBU6nCB/nwY3ZBixcmOAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfdPMSq1; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-313a001d781so5273015a91.3;
        Tue, 05 Aug 2025 20:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754450100; x=1755054900; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=FKlo96Z8h7/Xm6bQzZ0wd+2ryR6dxIsF/X2HceDzkGE=;
        b=MfdPMSq18dcyT80LT2MkE2WDeghGNbiDYspLYDFGt3yOROX1KqVa+zDye5AU7DERBl
         hLOfx1R88oE+7TTa9JkWkp3G1wxqfC/3q4KxYF3lrNdAfWD1BdFrKzRc07icqm4xPSyl
         +bV0MFt3U1VyyPBQEtcD2dS1FY9WWjXYqHbFNYPSNrTZKq7FMTgwlXrCUUAJ0TG2BG80
         dRpyJE4qpVy/+iXav+DMttmP/pq4VUsWG34PyT6OYElf9yfa4KPE4klG/npR01Tpn0+5
         Naf4D0XocBGlm7IZqXrY5zu0//V5E29G1SjNZc5o55YH139PjwEDLn0LpCPCx4Kcaajn
         tFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754450100; x=1755054900;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKlo96Z8h7/Xm6bQzZ0wd+2ryR6dxIsF/X2HceDzkGE=;
        b=PLnpvenVXaTsk8yeFGycum/krnwDWTVNU7Trzb6XX3lbYVwjlTONc2UMZaCOMrRI6w
         IfQfkPsv0gPr6naUpF3Onf/flW9GZla+hbSzNaqsZ+GZMGGwaPU2IwRX5hGl+d2QOeM7
         slMlnJLsEf+gQ3/me6Ia8Lnp5Uq8eS3Peb6ZNadPOrs+DzpH1yEHwKddn2uDtZWFy9/z
         NriSLJzaqIPDANwFTG2jRMrI96WBDOEq1Xju5piw57hpKOzZf6EmvibIkpXn7lZV7TWs
         LDyD20masvCvOp/8p9RBizOU7HBkgaetOagwzdmtL3+rfF0FcN3P9HIFdz6wDNYlwBCT
         rDsg==
X-Forwarded-Encrypted: i=1; AJvYcCUFXNLqvrygvXezgP92LSbodROGqXF/RWY7pF3tBPB796bV04Ug9QRk4I9asZVY3NzETAov7Z3MlrGn@vger.kernel.org, AJvYcCVSQRICYAn25w394J40Rj6zZ2GL9DMxefEm/xM3Dfsx5h8+HPgg2vGPhbuzygAZFpp+cIBHWG13ORtJAART@vger.kernel.org
X-Gm-Message-State: AOJu0YzkKG6plHA6AuuxzPFnKfQxUDR8EdUWDZ9e3Yemuimr8A4Y1q+i
	Hb2szonABaxb9ftE87qD1551YfVIB2Gu4oor2dwAoefJ1hh15nYLPL64Xphf+Q==
X-Gm-Gg: ASbGncuzDXOWS19Bh6FWAhP+E8kIui+4ZvYGUh19ZP1xcpXJjxc4CiLOH2+hUYlG2Ye
	I4WRmiVq1TgTx5l9GQhcXXZNZx+oZimc2fNXdqlRPSnWYEz8zhRAoeBS1c3g5Jk4kWrV1/oRX5V
	pe3RqTcHG2j8C6OqDTiuNWi+O6sRzxpLerBjGRDKY39GGqYkYi9OBpdx4rYu5wAvQ6Y9NuoLrYt
	EjI8xDLxVCpx7LypDuhDHiggchFl5XckkhtvmL937eHCXUosMBUJUXifEGwSMzprrLA+VK+ijjG
	R+9YOIP4qy8hdc6VebqcJ26I33/+lasxuM/0QT5E/RpM42HhCCNz5VAdfvMrWSa/FgE5ZXKqth4
	8qEyDtIhE+Uzh5922qvdDyAusRiYbaN9gIzwZawdh25otNrlPihKPiBLsKaebnOjbohLINdM=
X-Google-Smtp-Source: AGHT+IGecgNQRjmTC7HzaMwNFKebma9In7w2RFIWD5TjU4S0tMtUhhqovlxsKk4bF6wyvxohXmLfPQ==
X-Received: by 2002:a17:90b:1d50:b0:31e:e88b:ee0d with SMTP id 98e67ed59e1d1-32166c2bd3emr1602159a91.9.1754450099438;
        Tue, 05 Aug 2025 20:14:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-321612950c7sm1443811a91.31.2025.08.05.20.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 20:14:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fa1b8f0f-23a3-4baa-a424-9b1506a9699c@roeck-us.net>
Date: Tue, 5 Aug 2025 20:14:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hwmon: (ina780) Add driver for TI INA780
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, jdelvare@suse.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250806005127.542298-1-chris.packham@alliedtelesis.co.nz>
 <20250806005127.542298-2-chris.packham@alliedtelesis.co.nz>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250806005127.542298-2-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/25 17:51, Chris Packham wrote:
> Add support for the TI INA780 Digital Power Monitor.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Looking at the registers, the chip seems to be almost identical to INA237/238.
Why a new driver ?

Guenter


