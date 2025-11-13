Return-Path: <linux-kernel+bounces-899033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8A8C569FE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DF884ED160
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3026D2D1F7B;
	Thu, 13 Nov 2025 09:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V6eWDPjG"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35CC27B359
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026111; cv=none; b=VYddPrdlwkQKlKRt7JL8XzB4nrk3L4elECfdDKh4EjgFInQ6ThtUelKKVUVT9ajAzKLeJr2uT3vcF9UZWtTrp66TESqjbxVX8TG5mrLe2j10JJphf9wZ9KQGbrDLVX8RIs3sav9nor4QswvYFd4Hc5uhjdXtfCmFFpB+xqLAlRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026111; c=relaxed/simple;
	bh=JlFBxvosHfgKCAeQuydG1BJ8C38Wgn0G1RlCHbz6vek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U0u+wqZu6YOt/E0OhreaWObuT4DAH67hpO26aNjg1/N3I8BFoO75gTvD6GGp1x4ZCS43pDh2QmAA6XhSezU/VqfsSpbUZIJ4HrfIalBorSXuG4SypIaf0hEqMS1M9EYN9grfzLXf2UWWtrkmYsKYpY4/osydYqWd2MHfUZb0J7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V6eWDPjG; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b32a5494dso282902f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763026108; x=1763630908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N0Al/MgTi9UiIFNlCU2Rlyn7hcGn2O9uqtmtM9MWWL4=;
        b=V6eWDPjGrmvItFUhXlQe0tno9ji4OFuZtPb+K5YaOUxmM8Vy+cyf/NawCJ52i8xio+
         ZzXtBaPiT3exs2ngvcGCDXYCz2NnkJXQ2zUUvaHEMDrUh/6OfCAlWR/tcbWZ8DyMw9EG
         Ogx8acNcaUGjY0qiFs3GWXRa/BZ7udl/RUcsCowex8Zcp1veVKruaDa4LWblBwsAWorY
         SybUV+wvmqeJQmIEumkS5M9YC99tz5Tt5Pf+a7iFLtjc0MSzsgDrXH9jlr1Nr5604ztF
         fOpWaeK+Zpktlg90UQg9KGO76c7IMuMT+WavgLdhFrIdYck3aO2/LE575T2JD8C/dCBT
         1DHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763026108; x=1763630908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0Al/MgTi9UiIFNlCU2Rlyn7hcGn2O9uqtmtM9MWWL4=;
        b=YIcm4Zz9NdMQoLNoHMm+d2VSCCuiLi3sct/g9/RiDNE4r7sRMAZP68TFP5kd3xvQO2
         4iw/X+8pyk8CrcClkzDUy6nzwop7dgfncwSxh3vCT4GGQ2NaA8y5JM5CWZlgyALuY3Il
         g1wY/0LyBw1AEolzaE0O2tzeFUt4rVGUKjT2FKAmW8nxutvnce8oLC+GvEHS/+0respt
         cGm64TM4glFHgCPzqmKrT7GWnbQQv/QuWheJDNVvJ6u3bm6OH/Y9EuqoXBCLypB31EiG
         ri9rcG9M3xA5gnsgwVW5UdnyuXH7sGHmrDYEg03T2DhpzxhCFCyvENOcrbN8ZbPpBPYo
         WJpA==
X-Forwarded-Encrypted: i=1; AJvYcCXU5CSw/URnKAsTFL0a7sflZ9JFHgPu0qoniEVjjJE0WUuWuTuNvNfwEydITcZHpJYNzlSqznnXCTByJPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkJLSwD+IEcI7gydgKq9iTL3pXqWB8ZYY1/2r3FyTmVR69uW0B
	h4m1fPAYxJqewAGrd9pjbPNdVi5r4z57BPEu3/kMFyZbTRAVqyNWQiRkdMfa/FdWKNg=
X-Gm-Gg: ASbGncvIZAQV82Ocb3y4vfgkDdkcnDHn5MNfapuvFlSQSX19Yle2y9zYLFH72qhpBYf
	MJlUkYbe1t3/MH7IvAfmajaoFqeFhCxpvi0v7bcNrx7/I8U+m6etXnzH9YeiUW5WyMavA9b3bzk
	zZFKP6XHiYuaNCNbyfCIW/wNwG6xlM32WOeIAfg7CkqYW7i4265WEI/l1w57TVTrhb9/Lo4vMeI
	DbSW1Xn3R8SirbcTlGQT7PQ6SgEZAMPB5d9Knvjpk2D5JrtIeKl5BNvlxHL6zvDkq+HIIa4Bdfx
	/MJ3pbQyhE+V3ANUUud1mR0NMZBzdMwncoegfHigqwQZ5VOM4+A9Ue/QsbfYaDViT+abXwOlwJR
	yIlYidcWo6j4zQmvitBJi5ngbI6Fnb/4i3il5jk3PQALp9wTiRKN4LghcSHbIvad7b4bDRF6aSX
	X8QKofgA==
X-Google-Smtp-Source: AGHT+IGA8zptVGd6p2fpQ3iMFNNP5Z9WNKG2CHeOguw2sJYdTOHLeD4IEEwaHIyLI4eZtg1rS/iU3w==
X-Received: by 2002:a05:6000:2509:b0:42b:3e20:f1b2 with SMTP id ffacd0b85a97d-42b4bb8b8fcmr4530969f8f.4.1763026107981;
        Thu, 13 Nov 2025 01:28:27 -0800 (PST)
Received: from [10.11.12.107] ([5.12.85.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e85cc0sm3038492f8f.17.2025.11.13.01.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 01:28:27 -0800 (PST)
Message-ID: <9d77461c-4487-4719-98db-1c5c5025c87e@linaro.org>
Date: Thu, 13 Nov 2025 11:28:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] nvmem: add Samsung Exynos OTP support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 semen.protsenko@linaro.org, willmcvicker@google.com,
 kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20251112-gs101-otp-v2-0-bff2eb020c95@linaro.org>
 <20251112-gs101-otp-v2-2-bff2eb020c95@linaro.org>
 <20251113-benign-macaw-of-development-dbd1f8@kuoka>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251113-benign-macaw-of-development-dbd1f8@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/13/25 10:30 AM, Krzysztof Kozlowski wrote:
> On Wed, Nov 12, 2025 at 08:29:06AM +0000, Tudor Ambarus wrote:
>> Add initial support for the Samsung Exynos OTP controller. Read the
>> product and chip IDs from the OTP controller registers space and
>> register the SoC info to the SoC interface.
>>
>> The driver can be extended to empower the controller become nvmem
>> provider. This is not in the scope of this patch because it seems the
>> OTP memory space is not yet used by any consumer, even downstream.
> 
> Quick look tells me you just duplicated existing Samsung ChipID driver.
> Even actual product ID registers and masks are the same, with one
> difference - you read CHIPID3... which is the same as in newer Exynos,
> e.g. Exynos8895.

Yes, that's correct. It's very similar with the Samsung ChipID driver.

> 
> What is exactly the point of having this as separate driver? I think

The difference is that for gs101 the chipid info is part of the OTP
registers. GS101 OTP has a clock, an interrupt line, a register space 
(that contains product and chip ID, TMU data, ASV, etc) and a 32Kbit
memory space that can be read/program/locked with specific commands.

The ChipID driver handles older exynos platforms that have a dedicated
chipid device that references a SFR register space to get the product
and chip ID. On GS101 (but also for e850 and autov9 I assume) the
"ChipID block" is just an abstraction, it's not a physical device. The
ChipID info is from OTP. When the power-on sequence progresses, the OTP
chipid values are loaded to the OTP registers. We need the OTP clock to
be on in order to read them. So GS101 has an OTP device that also happens
to have chip ID info.

For now I just got the chipid info and registered it to the SoC interface
(which is very similar to that the exynos-chipid driver does), but this
driver can be extended to export both its memory space and register space
as nvmem devices, if any consumer needs them. Downstream GS101 drivers
seem to use just the chip id info and a dvfs version from the OTP
registers. DVFS version is not going to be used upstream as we're defining
the OPPs in DT. So I was not interested in extending the driver with nvmem
provider support, because it seems we don't need it for GS101.

Do the above justify the point of having a dedicated driver?

> this can easily be just customized chipid driver - with different
> implementation of exynos_chipid_get_chipid_info().

If the answer is no to my question above, how shall I model the device
that binds to the existing exynos-chipid driver?

Thanks!
ta

