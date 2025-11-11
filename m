Return-Path: <linux-kernel+bounces-895072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A2BC4CD99
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 530F54E7DA5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936AD2FE050;
	Tue, 11 Nov 2025 09:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="NKa8NKkh"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0092FE066
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854929; cv=none; b=ozuZ86oitTTXlq38HtK0wVuReBCxRXTa93WvPp8/sodCYz9/4DuZaoDMK5QaSk9DvOHdVmeoIAqpS8oPI89vHF9u8vZe7X6MIIikxjoe4v6PXgf4/NNOaSNwqorVYfePJKAZE6O0fSl0ZR96HlnFl/4ALNQTY/uAXrtoCnQKhgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854929; c=relaxed/simple;
	bh=ikmwxJCg1ZLSESW1vFDYmoPNouGfZa1iKRO+80wj/dI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bmHGwhMoZyntA4zaLEMhOQRXVwF1rI7mMfCuCXm3xzOCXUDpMsIZV7MT4VyuhNdi8LmuGLt+52SYAVUU9oBJkqBjKPIGfisjS+1RGyc4O7wtaAKcrr0jxlUB0yMbUul9mpkre8ocB+jhr73rj5xDznL4P9rwwVqDbK67qJBDsZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=NKa8NKkh; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b72b495aa81so473197766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1762854926; x=1763459726; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2ATN+bGUhg0lzB7rPv/DY/EzdDRNtMpVBUFmN1EQDQ=;
        b=NKa8NKkhV/aQr8RU2FU4ajOF1C1LYrn0mVMhMBWfMla72BJUwKGX/kmRC+YHRKU/v4
         tUtmpnwhslkoiU8XivnpgDLO3Hmxj/QM6fINzPqH3RLvOJi4pjGVdwL0pnEUgNKEmwl/
         7tbzu6MqQmLkaNdQHteRAlk6ID49fCZifrGchvtmw4BTIbjWcZ0dbkgggpmg7Sq/IiBN
         ObR8ZLXHm9w/XPJ2pXQZr8tSWztIPTkZcUtSezYR04NWG5yHBW9vfDTbMtHyLeWvANh7
         AWaa1QUBTgFWhm1GXgc7t+GkLfW1vPLSkBYzxgGEE4EQwwYPib9rsMzRYr4hcDFpVu9l
         hPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762854926; x=1763459726;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M2ATN+bGUhg0lzB7rPv/DY/EzdDRNtMpVBUFmN1EQDQ=;
        b=PBiLoBVfvyd+R80X32XfAe772iLPyz5vqhfDJtijuuiuFGArB6VgMDVAhIKxMShgIi
         uzZq2YVomANdiguN8Y90DBiQ/OflQlhmLkjqLedpRn/wM2Rfhh0zjtOakXLGWn7b8y28
         2nbEvRAHaIxt0XnkY9yxZ/0piQXAxtLf4UT4lkg+aDKQSkNmmOZrPSeROc70EjYfA8C/
         9ARxFg/5XJnhasGnYf96s/GSfHOSRqXX3mHquMv2xYtLtU6Sn5FVilDczmJ6g9n+OSM6
         WCu6G6rAi+jccppFwLSq+m6n7bQ00j1lDw+DvTxtnwXnD+spkha7jBFC/wF5+XiFB2nO
         QniQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaqooFfV+Z6NRCaa8xEvTu3dGZX7vnAmjSeJQpqT+BHs0BOOtMot48B7wlvzWNlVBWz7KV+ye+i0MV87Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhs5u0UELxgSx+ZCAE6hOUgK8bSPqvRNjhlIQBxDif6rI91POP
	ku9nxKMuVQztMRHxGUGmdb/ahrmszXaHNaFpayh9YvIYh/RCMOV7a+ubctGfA1ZsD0U=
X-Gm-Gg: ASbGnctLbVSL7AifbH5CRGamszIWrBxf1GwiJA80unjLSdvRWl77Foso6Vl+Ofe2Q7i
	RH7NlSabJYCheRDMvD6FaOx5wbeyoI2yXXevkLa3iPPplaGt21C9/T++my/D288pzcComkY/a7e
	nW8KEcm6GTVovcUxUCsNOAwjZVS/6ujUd8A8oNzI7ggIeLSTQgPEKLbWUlDrAVHZIC0Cd1bvDH7
	9bCEZZjyOQTyttfQa2jwpq2su6JkERe18sApGuMS3V+iDTYKDOk2pJccjyi7Aw5UJ6slUdYg14y
	h+MYoPLjpR6pqMs4RkUGRy6TmxAkD6HI8eFr3f+RwmFvHTL5O4zVqbmv2ZmTVYoVfQBN4om5nPV
	AAIQGKh2e6EJK+SNdKesn9fAN47bMVBHnBFOl9j2IBw3vXPF4oEkSxhnz7Wurd2Xa95vEaYHz3c
	/NWcuYv7uLgto9S7BuWtFIiWCGcUEgAPerLMlpIEp5T+/0mQ==
X-Google-Smtp-Source: AGHT+IFd7IWB5Eka+rG7ifQ3BCS7qWlZKrkijP0KIzSAfFqPdX40qriRD00IqCgbFvUrI4yU9T8osA==
X-Received: by 2002:a17:907:a0c8:b0:b3f:9b9c:d49e with SMTP id a640c23a62f3a-b72e053f2b5mr1175658066b.57.1762854925879;
        Tue, 11 Nov 2025 01:55:25 -0800 (PST)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa24d14sm1302472966b.74.2025.11.11.01.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 01:55:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Nov 2025 10:55:25 +0100
Message-Id: <DE5RX0J5U1NY.UA143VCNT9IE@fairphone.com>
Cc: "Konrad Dybcio" <konradybcio@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Casey Connolly"
 <casey.connolly@linaro.org>, "Alexander Martinz"
 <amartinz@shiftphones.com>, <~postmarketos/upstreaming@lists.sr.ht>,
 <phone-devel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Konrad
 Dybcio" <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 3/6] arm64: dts: qcom: qcm6490-shift-otter: Add
 missing reserved-memory
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Bjorn Andersson" <andersson@kernel.org>, "Luca Weiss"
 <luca.weiss@fairphone.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251009-otter-further-bringup-v2-0-5bb2f4a02cea@fairphone.com>
 <20251009-otter-further-bringup-v2-3-5bb2f4a02cea@fairphone.com>
 <3ryhntdf52cukvcbfad5prlggqsee54nsf7us6hdd5h5f73pog@yrgo6o6j22gw>
In-Reply-To: <3ryhntdf52cukvcbfad5prlggqsee54nsf7us6hdd5h5f73pog@yrgo6o6j22gw>

On Mon Oct 27, 2025 at 5:45 PM CET, Bjorn Andersson wrote:
> On Thu, Oct 09, 2025 at 11:06:33AM +0200, Luca Weiss wrote:
>> From: Alexander Martinz <amartinz@shiftphones.com>
>>=20
>> It seems we also need to reserve a region of 81 MiB called "removed_mem"
>> otherwise we can easily hit memory errors with higher RAM usage.
>>=20
>
> If you make sure CONFIG_MEMTEST is enabled, you can boot with memtest=3D1
> on the command line to catch such issues, without relying on "higher RAM
> usage" (or randomness).

Good idea, ran it now and no issue seen.

[    0.000000] Machine model: SHIFT SHIFTphone 8
     <...>
[    0.000000] early_memtest: # of tests: 1
[    0.000000]   0x0000000080880000 - 0x0000000080884000 pattern 0000000000=
000000
[    0.000000]   0x0000000080894000 - 0x00000000808ff000 pattern 0000000000=
000000
[    0.000000]   0x0000000081800000 - 0x0000000086700000 pattern 0000000000=
000000
[    0.000000]   0x000000008ad00000 - 0x000000008b200000 pattern 0000000000=
000000
[    0.000000]   0x000000008b710000 - 0x000000008b71a000 pattern 0000000000=
000000
[    0.000000]   0x000000008b71c000 - 0x000000008b800000 pattern 0000000000=
000000
[    0.000000]   0x000000009c700000 - 0x00000000a0080000 pattern 0000000000=
000000
[    0.000000]   0x00000000a18b0000 - 0x00000000af41e000 pattern 0000000000=
000000
[    0.000000]   0x00000000af43fe53 - 0x00000000af61f000 pattern 0000000000=
000000
[    0.000000]   0x00000000affff000 - 0x00000000b7100000 pattern 0000000000=
000000
[    0.000000]   0x00000000c5100000 - 0x00000000e1000000 pattern 0000000000=
000000
[    0.000000]   0x00000000e3300000 - 0x00000000f8500000 pattern 0000000000=
000000
[    0.000000]   0x00000000f8b00000 - 0x000000037e857c78 pattern 0000000000=
000000
[    0.000000]   0x000000037e857ca7 - 0x000000037e857ca8 pattern 0000000000=
000000
[    0.000000]   0x000000037e857cd7 - 0x000000037e857cd8 pattern 0000000000=
000000
[    0.000000]   0x000000037e857d04 - 0x000000037e857d08 pattern 0000000000=
000000
[    0.000000]   0x000000037e857d34 - 0x000000037e857d38 pattern 0000000000=
000000
[    0.000000]   0x000000037e857d64 - 0x000000037e857d68 pattern 0000000000=
000000
[    0.000000]   0x000000037e857d94 - 0x000000037e857d98 pattern 0000000000=
000000
[    0.000000]   0x000000037e857dc4 - 0x000000037e857dc8 pattern 0000000000=
000000
[    0.000000]   0x000000037e857df4 - 0x000000037e857df8 pattern 0000000000=
000000
[    0.000000]   0x000000037e857e24 - 0x000000037e857e28 pattern 0000000000=
000000
[    0.000000]   0x000000037e857e54 - 0x000000037e857e58 pattern 0000000000=
000000
[    0.000000]   0x000000037e857e84 - 0x000000037e857e88 pattern 0000000000=
000000
[    0.000000]   0x000000037e857eb4 - 0x000000037e857eb8 pattern 0000000000=
000000
[    0.000000]   0x000000037e857ee4 - 0x000000037e857ee8 pattern 0000000000=
000000
[    0.000000]   0x000000037e857f14 - 0x000000037e857f18 pattern 0000000000=
000000
[    0.000000]   0x000000037e857f44 - 0x000000037e857f48 pattern 0000000000=
000000
[    0.000000]   0x000000037e857f74 - 0x000000037e857f78 pattern 0000000000=
000000
[    0.000000]   0x000000037e857fa4 - 0x000000037e857fa8 pattern 0000000000=
000000
[    0.000000]   0x000000037e857fd4 - 0x000000037e857fd8 pattern 0000000000=
000000
[    0.000000]   0x000000037e858004 - 0x000000037e858008 pattern 0000000000=
000000
[    0.000000]   0x000000037e858034 - 0x000000037e858038 pattern 0000000000=
000000
[    0.000000]   0x000000037e858064 - 0x000000037e858068 pattern 0000000000=
000000
[    0.000000]   0x000000037e858094 - 0x000000037e858098 pattern 0000000000=
000000
[    0.000000]   0x000000037e8580c4 - 0x000000037e8580c8 pattern 0000000000=
000000
[    0.000000]   0x000000037e8580f4 - 0x000000037e8580f8 pattern 0000000000=
000000
[    0.000000]   0x000000037e858124 - 0x000000037e858128 pattern 0000000000=
000000
[    0.000000]   0x000000037e858154 - 0x000000037e858158 pattern 0000000000=
000000
[    0.000000]   0x000000037e858184 - 0x000000037e858188 pattern 0000000000=
000000
[    0.000000]   0x000000037e8581b4 - 0x000000037e8581b8 pattern 0000000000=
000000
[    0.000000]   0x000000037e8581e4 - 0x000000037e8581e8 pattern 0000000000=
000000
[    0.000000]   0x000000037e858214 - 0x000000037e858218 pattern 0000000000=
000000
[    0.000000]   0x000000037e858244 - 0x000000037e858248 pattern 0000000000=
000000
[    0.000000]   0x000000037e858274 - 0x000000037e858278 pattern 0000000000=
000000
[    0.000000]   0x000000037e8582a4 - 0x000000037e8582a8 pattern 0000000000=
000000
[    0.000000]   0x000000037e8582d4 - 0x000000037e8582d8 pattern 0000000000=
000000
[    0.000000]   0x000000037e858304 - 0x000000037e858308 pattern 0000000000=
000000
[    0.000000]   0x000000037e858334 - 0x000000037e858338 pattern 0000000000=
000000

Regards
Luca

>
> Regards,
> Bjorn
>
>> Fixes: 249666e34c24 ("arm64: dts: qcom: add QCM6490 SHIFTphone 8")
>> Signed-off-by: Alexander Martinz <amartinz@shiftphones.com>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>>  arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts | 5 +++++
>>  1 file changed, 5 insertions(+)
>>=20
>> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts b/arch/arm=
64/boot/dts/qcom/qcm6490-shift-otter.dts
>> index 0d331bda4a82..31650c29b1ca 100644
>> --- a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
>> @@ -118,6 +118,11 @@ cdsp_mem: cdsp@88f00000 {
>>  			no-map;
>>  		};
>> =20
>> +		removed_mem: removed@c0000000 {
>> +			reg =3D <0x0 0xc0000000 0x0 0x5100000>;
>> +			no-map;
>> +		};
>> +
>>  		rmtfs_mem: rmtfs@f8500000 {
>>  			compatible =3D "qcom,rmtfs-mem";
>>  			reg =3D <0x0 0xf8500000 0x0 0x600000>;
>>=20
>> --=20
>> 2.51.0
>>=20


