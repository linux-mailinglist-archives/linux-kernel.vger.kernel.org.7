Return-Path: <linux-kernel+bounces-749813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B73F5B15325
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65C547A6F77
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7087A24A043;
	Tue, 29 Jul 2025 18:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eWoWvQgG"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07CE24DD17
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 18:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753815112; cv=none; b=dWbg2nJSkE3wIwiKjpzMw6cZstXBEWgw64ibimlIS/j/8Q4HXJ2HNkb0+iQ+7Ak6MJL72+P3rpihYQRXxeT/+tCkQ0FpHcyLCs8DbF4HwF0EtDMUNc6mmrB5IGhWuTHnhHUEU7636E5bmzGSZUcYVYmheSJtKufk3I1PNmpKGAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753815112; c=relaxed/simple;
	bh=tkYPqG6hSoExZpavosByUWQQZFauHqgD4v+3OLU6+vA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RczZEdrA26Cb2t2lwPxoHIV/R2dB+0sm8uPUQmV/tHQXiK6+yH5mBeO8zxBXd3I8ce63Xr5UJUc2Ai02pcg3MdAnaYko0KH1z/dDhARB5lwkiiKlwJSLFJgZEUefzlaoSlEOvjR2ZmnaeUYCwOOX4+TFIkqqKjezKhWxzK0PGg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eWoWvQgG; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-41b8e837427so1670800b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 11:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753815109; x=1754419909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nW9OX3dqh3cJ18q/aTepV16/WtzibItMr8FPMWEaO5Q=;
        b=eWoWvQgGmSw/LedIqS0RAsjf2f96H6SXm2qrV1E3YImdwNYrC4KL+OaFYJ/ORBlB4Z
         vXJAfpn/Hy6wUJS1fhjg8oziAM1n66uvow67qTii0vibNkggNBug/8UvyZyrOiOZTIsC
         nz3YqjR2hZ+Nm8j3kfpHI4uJw7uJKj1TW1oLIQ5619ERq81Qib8qP/XWUEcVe0GkZ5E7
         s/WUN9SqY5lShafbzTNvaq0vaiUu3aovD9qUnbDe8g/asgURbbYFTa6mDmidKakmnacJ
         PWnH7g9H0PzYBsxihcwfyscBJkiPCHWepWio2ETipmp5ZVaLO1RZZ46bc9SezrH3MEIs
         i9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753815109; x=1754419909;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nW9OX3dqh3cJ18q/aTepV16/WtzibItMr8FPMWEaO5Q=;
        b=D3ECI+tv8uHlkTWitX50tQTahtA/A7cGd7uSvF1Z/wuy2fsp6hBJ/EWq9ELRZR/VVJ
         MqSCUsQ5H+TpTEl6vP3f0yAiSiULDCplRGjn8ERjcFWDeCBKoqZMigKAnZ50Kg555eN0
         XMzoHocVqAqxxFaB7LZ7fo0pInoveTLttOXW59akomdE+v6iKwl7ZJwSBUPNK2VObxhu
         msfyRSIpddnd7U5uhKbBCGOlkSz+YHC61tNSfK9N4qSavRr1RBKrL+OBfjUdNxDbyUtV
         iWV/5yD4fT1q8RWHQEtAh5zY/U8+oCEZLWK6aYySX1S40uE4+7usgroIHV5jS0hJ1+0w
         tA/A==
X-Forwarded-Encrypted: i=1; AJvYcCWY1y3jCq2YqGfTlt4EuBC/JPbeWYeG0eKwpZ1SASkzn9TshTJyr+jmrhKS1O7leixr3o69KbQwDjA3g+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGiku5t4oZkGvTda7BiGFsLy8RFsV0ScJo4CSrDP1/QA08pzr6
	uxZRODkihqvCafuVINWsp4r7m5GFf/s8S8yvXE41sLrAo2e4durRd5Zvqa0DJdpfbcM=
X-Gm-Gg: ASbGnctOEfcifHNMlTVLmZaUx4QDUYuN7tcrQ9Ppvvhyp1Q0EEyPxmWjvPzXLlMKrpn
	9p7yEfd8IAFowbR4ADqEVWHErer2dR/Y/unJ4ISo7ILX011pPKSlHRo/JDIa1pDlMvQ1WmHHZrv
	9khx0FwH0Z6DHZhGY209cbOf41tl7VIljgg8u1SDCGzyVifPhuibcBJrXr9kHLM94IXr0Hn6t3u
	qlMhwrowtBsHjU2u8dtThAfUt//RzTqEhR1pcyvuPIULH+n3fNHhbpJBPyXTzar+9y/2hm2reg0
	Kl3TPRD4UbOu0kFvbxmTQp3fa+z7kt6gafutnmWh+VTDNieQR2Drd4GL0wPW7klZodVRvVjy6Hl
	+VUkBkl4U5Whvew6/Xtnw+V0OjjgFRPzFO0V6HiwG/FUs9FUg/emDL2cmIz/rpwVXgVs18zwE2S
	8=
X-Google-Smtp-Source: AGHT+IEk1VUBACKAVfd3nk/GnuDKx7Ws203xpDX0qSmk0ah3tw52EhxFHTI+yXJat0ciadah+dzUgQ==
X-Received: by 2002:a05:6808:2393:b0:40b:3530:98bb with SMTP id 5614622812f47-43199d7a01cmr506635b6e.9.1753815109508;
        Tue, 29 Jul 2025 11:51:49 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:c7d5:61e1:68d6:dd54? ([2600:8803:e7e4:1d00:c7d5:61e1:68d6:dd54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-42c7b843b74sm1634782b6e.16.2025.07.29.11.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 11:51:49 -0700 (PDT)
Message-ID: <f5b46109-ad53-4d03-937e-ac4fc868755f@baylibre.com>
Date: Tue, 29 Jul 2025 13:51:48 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: magnetometer: add support for Infineon TLV493D
 3D Magentic sensor
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20250726-tlv493d-sensor-v6_16-rc5-v1-0-deac027e6f32@gmail.com>
 <20250726-tlv493d-sensor-v6_16-rc5-v1-1-deac027e6f32@gmail.com>
 <141967ee-22f4-4b15-a8da-e8cef25828b4@baylibre.com> <aIg_SClXq0pO69iH@dixit>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aIg_SClXq0pO69iH@dixit>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/28/25 10:26 PM, Dixit Parmar wrote:

...

>>> +	case IIO_CHAN_INFO_SCALE:
>>> +		switch (chan->type) {
>>> +		case IIO_MAGN:
>>> +			/*
>>> +			 * Magnetic field scale: 0.0098 mTesla (i.e. 9.8 µT)
>>> +			 * Expressed as fractional: 98/10 = 9.8 µT.
>>> +			 */
>>> +			*val = 98;
>>> +			*val2 = 10;
>> We use SI units, so this needs to be gauss, not tesela.
>>
> Sure, Is there any documentation/reference this details are mentioned?
>>> +			return IIO_VAL_FRACTIONAL;


Most of the sysfs attribute documentation is in 
Documentation/ABI/testing/sysfs-bus-iio. Specifically for this
case, it says:


What:		/sys/bus/iio/devices/iio:deviceX/in_magn_x_raw
What:		/sys/bus/iio/devices/iio:deviceX/in_magn_y_raw
What:		/sys/bus/iio/devices/iio:deviceX/in_magn_z_raw
KernelVersion:	2.6.35
Contact:	linux-iio@vger.kernel.org
Description:
		Magnetic field along axis x, y or z (may be arbitrarily
		assigned).  Data converted by application of offset
		then scale to Gauss.

