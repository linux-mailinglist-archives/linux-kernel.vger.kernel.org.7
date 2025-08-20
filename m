Return-Path: <linux-kernel+bounces-776819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C271B2D1C8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 04:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 069841BC81DB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 02:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA032BEC22;
	Wed, 20 Aug 2025 02:12:07 +0000 (UTC)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E29277C9B;
	Wed, 20 Aug 2025 02:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755655927; cv=none; b=Hp1T/M9VDFMYMEfDOEWRInE1Wz6JTkZyaW/IZgfTjXGq5CCrVhj+ZUNtcP3zbmAsZkIv4/aJd8z2NV+rP9hJJZZsyPsex0wbpvaTUvjYUqWIQWO2MxLER1p1VS2+SY5KIUrCMfCryHA1blpAPd0XPi5bFHlvE6AH7mswWnI1thU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755655927; c=relaxed/simple;
	bh=cdfHdr6Zj0orzSqkRA9RQZJ6dX7CTTKfLSfk4X0HnwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I/ZB0Uv53p4EgHrQ9m9wIWj74zAvXHhFuRCdG4ImF20hl5G9CKwTEb4dCDKtFwD2hxTLfF7OhsKrC7H+cuVSBTEOr0NUZf2UqHelO/5x0hQAxTlOQPndiatggscvwgrZyyjgjdeU5mcQVFf0QJaHu6iV3z5uDtx4918kyYyVCYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip4t1755655827t927a0bd5
X-QQ-Originating-IP: ZT11A4xCrpS+Sor2dkaS5pC77IPe/BP9zy8H4U6AHgI=
Received: from [IPV6:240f:10b:7440:1:74a0:7bf7 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 20 Aug 2025 10:10:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11893107500383784646
Message-ID: <0318E801E3D6726D+65c4f189-4e22-4a9b-83d7-cbb0816df373@radxa.com>
Date: Wed, 20 Aug 2025 11:10:24 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arm64: dts: rockchip: remove vcc_3v3_pmu regulator
 for Radxa E52C
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, heiko@sntech.de,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <BCD8E43E564BC334+1e45d36f-edc7-4c3c-90c9-7b0f2a52360f@radxa.com>
 <20250819134028.634780-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20250819134028.634780-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MmpliBmRb3iCLdw8c0spTNXU6TGj4Xmfp1WZIYGew9nEtKY/wIFp5pn9
	TNXMWzB2m0kjG9wVZOKqHfCk0SPETLP87/VchZ3ehWPz15kjsrniYdmgnRyMMXjb/ycANw5
	W5ORlKAPkVdMc3ZPaY04V3guJ6sizPXcU0eD5lx/j3jzhfLn3SDjUtE6dMslx50Kv54FrW5
	+Q+AUaiY4Cd5mL0nBVy+UnaVd0JNwkbKCoakyi5WPHS8yT4HAoTZOHY1HHY0wdX7ghJzjjW
	MQ52JzF+lqyDfWFI/1SRRXJzeAAigElGP17zjCsnvX0KjXeEDH554lwOycoMbn95n04/pv3
	2dZ0IM5nq3uWme7XRKCCMIm2NGOCrJnn7bHPnT3i6fFgKoh9llivxcJWp/qCjWpigM7QZ9P
	KpeXu81J3Adw0Nu9OCEQ/R7m46QQcyEMF6Fi7ygLawhN+BmMNjn26J3jZEiCe++G1xbgkbr
	EIJ4RI8YNRobWC89+/p5PMi3bNk2kupLDQwv9Uad8L6rtMMWtsRmA8ZpNlONLzR/oyoOFGU
	BFU3kdxFMmQTaLCt8sO1XIWHvXZjFUGjlKudR+MbFIz/DgPCAJ1857hE2ikGcqS0kKPm6MQ
	RhDmrYLgR1qWvV78y3p5UITewahjjH4tAGVmwTL7c+VG28cOJDM+YO9D5LjI0Xmydj42DDU
	wkeztLdh1Wftm7Yw6dEUR29eyNZUbEHanoQnfJFkh7pYU2Bqq06GUYQTqpS3DonavKtinHi
	6MjQx+D/F/9HKl6r3IK2ozeTqfAnnqttdEeac9nysfIh7q/iPD8rAiv6RVeN3+3X2iPj0Pr
	gCBd9xqvXcKi+Z2FhFYBr+TDYcFOETV6qRlVeBefTh+HGv+z93+zcZh9rIu9x6xEol1hLuP
	UFCPS7sYAnsrN+UZpNsD4t2DhikRnNq9F/I0EM6F3xJA6XQt0FOuL6TJ0aL9fcQIwG2nz8k
	R6fV4Q3ZKgsHMYA2v826UivwbkAkoIwAzDVt7iK5w9N/wiqvGj7RiO7KLr4/hR/7LqBdq+S
	CPz0WtYVc7h61uCVGm
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Hi Chukun,

On 8/19/25 22:40, Chukun Pan wrote:
> Hi,
> 
>> How about the following instead?
>>
>> @@ -538,7 +538,7 @@ regulator-state-mem {
>> 				};
>> 			};
>>
>> -			vcc_3v3_s3: dcdc-reg8 {
>> +			vcc_3v3_pmu: vcc_3v3_s3: dcdc-reg8 {
>> 				regulator-name = "vcc_3v3_s3";
>> 				regulator-always-on;
>> 				regulator-boot-on;
> 
> On rk356x, the Flash chip is usually powered by VCCIO_FLASH, which
> is also connected through a 0 ohm resistor, so I didn't write like
> this. e.g. https://github.com/torvalds/linux/commit/a706a593cb19

I think it should match the schematic, i.e. it should be "vcc-supply = 
<&vccio_flash>;".

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> Thanks,
> Chukun
> 
> --
> 2.25.1
> 
> 
> 


