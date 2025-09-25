Return-Path: <linux-kernel+bounces-833314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50DDBA1A56
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D50A3AF446
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35365322A29;
	Thu, 25 Sep 2025 21:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j68Vua4S"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EDA322A25
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836249; cv=none; b=GcLGbiZD5wtG7BwLndVxg+M9IG33Wh6fPUVIuO4625Ip/EjOYZFkD+/kjt/h/IP2nmYbDfEP8jksG/wmPvPVuyFjnfhGD/FA0IPlWj7Fv4u38umwBVdCmuUIM+IWLB/Cdsp67yTZM7E+N8IBQoc4h/uLBT9M3AF9WgUXTO4RCRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836249; c=relaxed/simple;
	bh=KWj5SMGs9GL6SGPtfMBXs29Ozf1AF6eboLKHNyGz8DA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=OznK4mBf3yeShpzWzofzlNAjDL2a23ljH73F1lKqfy5rJCG4ay1MDDJP0HAYWu6ZtcPXP2MF46AYn3QH7OIQNhVaoLYGELYkUN5E+Xo/QRjcTTRk4sb+GCjJmxsYYjCzwKtaNV1spwyA0N85nmdGY111dnjY3UsYK+/j2NeA4Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j68Vua4S; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27d69771e3eso12674215ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758836247; x=1759441047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZYcUucsu2Uq27Rmf/o+v2BRybHVFSFbw/IMvqqBLJ38=;
        b=j68Vua4S6pwna6zSAjkq38J6bJvaWkPrC+dqRLmlW1aTi8XQ3zW/v3KLtKrUYbYYhN
         VAlThZJ0Lyu93dgvGX3M8bKgujNl06GqirjstC2MRo3YBFiq7dWGzlNFmqPvahpJHm0R
         HMiLST4P+B6nJARQ4iGvAb0eZa6SM9oPPVu9PqttYX7vyFkYSRb01caCp4f2A6R1vkTs
         yAHSYe6hqjgNMmcS+e73XiyCyYGJisTRlp7y6bqCXFFNmhk805Imd7V5vBFm1yjV0V6s
         b5RwAjXoFS3RU+uDQo939HBuz4IeDLJMmSQxrwrJlaW0cjUAQt+jrwNwkgkmZFmqSV9l
         qXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758836247; x=1759441047;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZYcUucsu2Uq27Rmf/o+v2BRybHVFSFbw/IMvqqBLJ38=;
        b=MrwEwz9WcsWIiLdbdmOrxRTLEPYIaBeRPJ2ALrm4e2XKwkEFjqPLnwQrSEj2AM6sn6
         0aecgA7EftlbBcsmg38FuQ7EFUWKTGFpwRn8vE1rh4JlHHsD005rkL70niQ832ltkAeV
         PDL5SmdpydIXvRPj+B52eF7wk9PSJn9H5fv8bZ4xEkfBzOiNnYVbkKM7SebVmGl6H+7J
         0YSmnSQrNvBaVSCGt84oECMyvfaSm/io4hK09mFxDf1uzo+2jyD5z+Q56XDzd33Es+r+
         oprwmaySEmoqYHBxyNSdRO3oL17YpCqIW9XWk4BqXJhdZIqzs7S+aEq+voM6KUUzDpwV
         CXCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYEsa9hFcy//l7paqmlw4IszY/LuGhCJZy7j+R810PpbD7M5NfqDor/fRbwLC4FFTTajJCgQKpn4ooMZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG2r+4xr9tRZ+22+5oeeew+OLPf3ruf13RLcmjReR06dYOisv5
	EgDpZI5g4jRbcYx3w69GRxUUd1skIK0vOKnJ4vuK5qBE59XmwAwqaDaB
X-Gm-Gg: ASbGnctjJ6q1HmLzW8fZAsYHJ9GQDRj59IJ665TFfOsgFi0OMchH4qY/Ot1Ib5ybp/O
	PiNrTCXJt1hz50im06QFNJzthSLwk2D+XSZciDMxyS+B6z++1AAh2NKyjFTHGJGFyW88eCpuwqj
	MW3jlLVrgCQ2p3XvMpsRIJX13wGOO/YPbw9DrFF1AHcTxRt8PyLSU/EApd9m4LDTceRkXvT+Qxr
	0A+Ou/FWlr8uC/I5hGSYg6kv3TyJ8pMQ1DCi6SUe3U9ckAskKPkLZSZUWmimLF3nPXnrMGbaIAo
	Vf25zQW1NgDR1LytiimEExi/jW8RHCfXheje3FHGE8rObiGdm3VT1sfXa7JXUIm7+z+9zNUxzzS
	ATSf2hoil9DTnhD5l7MK6xVJSTZhWmzMYxw==
X-Google-Smtp-Source: AGHT+IG+2KEihIk2iYcF1rjTLu4O96y/VVkFEcf/JLe3idjXIjtbiAgmixKfzknuBISuyb0xDfvIpA==
X-Received: by 2002:a17:903:1a2d:b0:25a:24f2:af00 with SMTP id d9443c01a7336-27ed4a06c8fmr52614235ad.12.1758836247107;
        Thu, 25 Sep 2025 14:37:27 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2804:18:161:d250:a5b8:b662:f3c3:afe5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6725bbesm35180615ad.60.2025.09.25.14.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 14:37:26 -0700 (PDT)
Date: Thu, 25 Sep 2025 18:37:23 -0300
From: =?ISO-8859-1?Q?Eric_Gon=E7alves?= <ghatto404@gmail.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] arm64: dts: qcom: r0q: add touchscreen support
User-Agent: Thunderbird for Android
In-Reply-To: <b3151086-206e-4520-9a52-04591478de0a@oss.qualcomm.com>
References: <20250920014637.38175-1-ghatto404@gmail.com> <20250920014637.38175-3-ghatto404@gmail.com> <b3151086-206e-4520-9a52-04591478de0a@oss.qualcomm.com>
Message-ID: <FFAB92D3-5808-4683-A095-00D1EEFEE962@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On September 25, 2025 10:08:37 AM GMT-03:00, Konrad Dybcio <konrad=2Edybci=
o@oss=2Equalcomm=2Ecom> wrote:
>On 9/20/25 3:46 AM, Eric Gon=C3=A7alves wrote:
>> Enable the ST-Microelectronics FTS2BA61Y touchscreen=2E This patch
>> depends on "Input: add support for the STM FTS2BA61Y touchscreen"=2E
>>=20
>> The device has an issue where SPI 8 (the bus which the touchscreen is
>> connected to) is not working properly right now, so
>> spi-gpio is used instead=2E
>>=20
>> Signed-off-by: Eric Gon=C3=A7alves <ghatto404@gmail=2Ecom>
>> ---
>
>[=2E=2E=2E]
>
>>  &tlmm {
>>  	gpio-reserved-ranges =3D <36 4>; /* SPI (Unused) */
>> +
>> +	spi_clk_tsp_active: spi_clk_tsp_active {
>> +		mux {
>> +			pins =3D "gpio30";
>> +			function =3D "gpio";
>> +		};
>> +		config {
>> +			pins =3D "gpio30";
>> +			drive-strength =3D <6>;
>> +			bias-disable;
>> +		};
>> +	};
>
>Drop mux/config, put all the properties right under the pin definition
>
>> +
>> +	spi_clk_tsp_sleep: spi_clk_tsp_sleep {
>
>Underscores are forbidden in node names, use dashes instead
>
>Konrad
Will do, thanks

