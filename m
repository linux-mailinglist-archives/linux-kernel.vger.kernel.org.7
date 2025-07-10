Return-Path: <linux-kernel+bounces-725115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2007EAFFAF6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A14A564281A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C5828A3EC;
	Thu, 10 Jul 2025 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="l3HtWAI9"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAD6289E2E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752132823; cv=none; b=F2bxl6X88Kbo7HzeoX3t00RUX7I8SqqBeEc0k7KVHYe6BfR8S0xBYRo2TTklbxZsvYO82/6eR0844NbxeIJUpFV3M/rBW+BGwJ+GF/ktKyh7DXjBOzWdjSXguVn49LFbHRxUB/REolwNEvKrabMot/dB3KXtOiMiDRsShaq+iG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752132823; c=relaxed/simple;
	bh=+cjQnk++1bzGkpqMFN4wt4PyunkBLE0VE5bOPYI5+EY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=STcHHUmM4SPAb71c4065BWW8CbKbC8qzuXYj8eiX9E1rWOuI16UEmL1L6W/HnxSKSpieoNFbv4wCYQTPidg+nybdJja/t3nwpcFKHu3ggbv3ZEgxPcs4WQ3Wf6AE+10lDlqiwbazHQgQQNIEnHMU0Oej+39f4IhtGhSF5G0c8lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=l3HtWAI9; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60c3aafae23so3869928a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 00:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1752132820; x=1752737620; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dc3P5Oeg2bmqCJNQbYoEMD7h352Kk7u8cbR4u9q01PQ=;
        b=l3HtWAI907PF2MtzWugEjsOEFkLy9glYCb7hhMExDJseRo4UKTwHugeZ7m+eDnlYQ4
         FuM0FhunTmEvUw1FOeMGryU14iVA4OxKe9JGc45q2tMeoMS9fIaHuQRxHyEeVWsQvGyr
         saEDZidxexBF5yGCAFRIFzMhmMmqK0JwyNkpMhqsKh1eNP77YLYDeN5kR2Gxu2piYACg
         ZiHAHoVPhiBcyaFPgyzNdbu36zQZChYS2JPbbFwZLXivWoro9X7HiUe7ecDs9oj+f2bx
         bgagzzJrSxEkpvJUn2lE4yKV5e0fxZ0OKqqugu6vWb3OyBq+GT5INouMH4+n4Isx4jhs
         dcnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752132820; x=1752737620;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dc3P5Oeg2bmqCJNQbYoEMD7h352Kk7u8cbR4u9q01PQ=;
        b=NfivRyhHSeD7GzqD8zZLiFX5SvAqbOsoRx1aSG9VNZ6quoOP23N0PikWswSBo4bMdO
         w2WDY61VzH+5o6F6Jl/MZqqje/9GG9IF/kZ6K8c9IYAFG/mXN+sMCoAkGMjs2urfHKOM
         szListAuBin8iOkiHvwUpZnRT65jpzgyy/gETBcwP4VcJdo7xYSz/F4V3kUOFkiejeY0
         ZfP5Zes/FlSUraA+jp7yQS95J4XgvR2YTDJwwIF4DuV8vIwbJia3v4PEoCCh+LfqVlJ9
         ZfImT4d4ay1ScyfIFU0B72GPLPjkIBwIpTOaUNDImpL/bGQYxSLWKmzpnUjqDFqZ7oco
         Da3g==
X-Forwarded-Encrypted: i=1; AJvYcCVaI/WrRosm942wwhj7vMJErUtFF/rsULZ3S7fDrQxlDRRBulU3y5dCajWMXcpqCz4tJK/N6lL+xBezIHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGvXHbnG1kT1R2rVzVE2rnLm1EimiaUx7a5IBi9qKVKfcUkzGp
	K+d43V0Wqd5MVhy4iNgeysjfU89stMAkxEWS/NflVhKNxD8JEjmqvHHf7COCZTshPv8=
X-Gm-Gg: ASbGncsVIlOCnzwmEH+6oMx+veE7w0BCLDg1oJfYZMVb7/Rg0GFYSYCfGSiLZNGPWAR
	ZFZNwlQgetIJKW8o3TplHTT12qwBFA0bV6u7jre4fYm2iiYIPZR8SR00oBs9Oz2oxrCJfbWNgXA
	1nAnRWlrLlHDLlgS/74TKBQArObAn3Kkq1YmBWfSqKWTivj9CsH6Kp4zg6cqCY2naLv16JDQjn+
	avolqv9Xp05sfOXyMmvyjtxE0uiycRGRC1LQ2nGOMQwJxvcqpXYdOwkQkEpHH212kVypCaUszG8
	sYsSldsgLzgH1sLxLDU5edkz4Ek8caJ6pr0SG0MEtB1PmCUosnOX9DgqPqYP1cadiTqDLA==
X-Google-Smtp-Source: AGHT+IFP44qvVL01Qb6g5roOyXaKEqhnKPzl7FYoVy33V/zCBqQ1uZivmGf2cxu6nX3jQYwA8oqa8w==
X-Received: by 2002:a17:907:c88a:b0:ad5:6174:f947 with SMTP id a640c23a62f3a-ae6e24bbf63mr210305366b.22.1752132819879;
        Thu, 10 Jul 2025 00:33:39 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82df311sm80484166b.165.2025.07.10.00.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 00:33:39 -0700 (PDT)
Message-ID: <47a9830f-e0cf-46d7-8f8d-344901bb6236@tuxon.dev>
Date: Thu, 10 Jul 2025 10:33:38 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Update the cache configuration for Microchip SAMA5D
 MPUs
To: Mihai Sain <mihai.sain@microchip.com>, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250625064934.4828-1-mihai.sain@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250625064934.4828-1-mihai.sain@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 25.06.2025 09:49, Mihai Sain wrote:
> Mihai Sain (3):
>   ARM: dts: microchip: sama5d2: Update the cache configuration for CPU
>   ARM: dts: microchip: sama5d3: Update the cache configuration for CPU
>   ARM: dts: microchip: sama5d4: Update the cache configuration for CPU

Applied to at9-dt, thanks!

