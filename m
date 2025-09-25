Return-Path: <linux-kernel+bounces-831742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F2AB9D733
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 968AF2E2599
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 05:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1D72E8894;
	Thu, 25 Sep 2025 05:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="bt0WEexh"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A3C2989BC;
	Thu, 25 Sep 2025 05:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758777980; cv=none; b=PnQ/RbZZFk7RA88qj/qcbwK4TOyofeFMldgDAkNxXIL3O/S3Q4kPY12SHvEUPu2un227KdsdQDk8qI7GFSiVJCreRt2f+IiXBxOFhZg99KBHU7+9c0eo16daTGzHY7Z1lqhtuibIAowSpqF0MHw4mOxOxp8+O0h6p5HHKk2ds6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758777980; c=relaxed/simple;
	bh=3UnijY6OVn87e3VMLJDm82dv4A7HqOGke3i8nIC2wbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A4kmhue03LnAYuS3euhdmLwHNBfv7IazS+1TYnwD7a3qG+xwpf5w+hYuMW8AiTX3Dq9HCkkcZX2o/WurhI22ecrz3KCCxDEWxsS3bD8nQHHCj9Cpd2HaSF6HK/m0DZBmP4Mua8SFJ3woSWxEgbtZgMKhCqRaB/e89qcJOPhCF1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=bt0WEexh; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1758777973; x=1759382773; i=wahrenst@gmx.net;
	bh=b7yeKV1P1plCqn61XjKXtLsqw+qXf13C+HSwdDxyWj0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bt0WEexhKhtQny9pcnPMoHUVS+9iSRAOgfgLVeHltE+6olat7zhVh9yMMwnirxgU
	 eFlxktPND675O4VkcfRUWZ3c8V/X+G0sSqoqAced9M1v4hzUH5rv2zHVygLGzRwJ4
	 sToAdg5Xp7MkyrOuy+6MqlKdU651/NVLAd9tIaRnUKW4331dN6+n/32SaUIqsFa6n
	 WpJ3TnTazNQbiQcDcYf5/SCCyOPZJnwdv3wpNKXnt122qXj5mFpRF1r+k9Lgau1Aq
	 ZhdqQHtJ/Rc9kcpm23s3u41LGtMItKmh4UMRPECcsM5z5BqrlJu1qNphw0uKuxHhQ
	 jjMRg5hWvbLrMjGD8g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([79.235.128.112]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6KUd-1uHYD742bR-012tB8; Thu, 25
 Sep 2025 07:26:13 +0200
Message-ID: <e53865df-7566-4790-9214-0af875950742@gmx.net>
Date: Thu, 25 Sep 2025 07:26:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] hwmon: adc: rp1: Add Raspberry Pi's RP1 ADC driver
To: Guenter Roeck <linux@roeck-us.net>, Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, linux-hwmon@vger.kernel.org,
 Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Saenz Julienne <nsaenz@kernel.org>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell
 <jonathan@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20250925000416.2408457-1-svarbanov@suse.de>
 <20250925000416.2408457-3-svarbanov@suse.de>
 <d07158fc-678e-4ae4-8943-168146a58fe0@roeck-us.net>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <d07158fc-678e-4ae4-8943-168146a58fe0@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YCJtD6Aehhq369CHabRr3+AIY3hDaY/EZAsHlrTVhvoj4Hx5Q4c
 AvEJs9G0TfC5TunbMz231f0zoxcKUuu8BHpDAdBIGVW8wYJWrHucIRI2B1eoXY4JgoPikWu
 AfLSCfnAwxDqsSf4cNftsT+XGUtBFaczd14H+A7OQOzAmnU3Le5dGY5nXdleaWdhjzNyFyY
 OTdNJZAidCKxCPTYFZsEA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:x8ijikaQ0dQ=;hpccxj5wwXwPq+KDpdqdQFIWJth
 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
 0SvgpZU=

Hi Guenter,

Am 25.09.25 um 04:42 schrieb Guenter Roeck:
> On Thu, Sep 25, 2025 at 03:04:14AM +0300, Stanimir Varbanov wrote:
>> A five-input successive-approximation analogue-to-digital converter
>> with 12-bit (effective number of 9.5 bits) resolution at 500kSPS.
>> The ADC has four external inputs and one internal temperature sensor.
>>
>> Signed-off-by: Phil Elwell <phil@raspberrypi.com>
>> Signed-off-by: Jonathan Bell <jonathan@raspberrypi.com>
>> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> I just realized that there is already a hwmon driver for
> Rasperri Pi - drivers/hwmon/raspberrypi-hwmon.c.
>
> Please add this code to that driver.
could you please explain the reason for this?

Yes, both drivers are for Raspberry Pi boards, but they don't share any=20
code base. The raspberrypi-hwmon uses a mailbox interfaces to get the=20
sensor data and works for the board generation 1 - 4. This driver works=20
completely differently ( MMIO ), doesn't depend on the mailbox interface=
=20
and applies only for board generation 5. Actually I don't see a benefit=20
of merging them.

Best regards
>
>> ---
>>   drivers/hwmon/Kconfig   |  10 ++
>>   drivers/hwmon/Makefile  |   1 +
>>   drivers/hwmon/rp1-adc.c | 301 +++++++++++++++++++++++++++++++++++++++=
+
> Also, this needs documentation.
>
> Thanks,
> Guenter


