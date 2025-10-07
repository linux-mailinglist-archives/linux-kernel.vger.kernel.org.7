Return-Path: <linux-kernel+bounces-843799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0AFBC04A1
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 07:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 131803AD26E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 05:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C14218ADD;
	Tue,  7 Oct 2025 05:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gC4mBz6q"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62A421A94F
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 05:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759816758; cv=none; b=avCXv3IQV5wxMjvjIG1Fjb6tRlKkJXXgpIww2GGbJvJsu3uwTt2WOpOiuBjzXbtkzX7hZeZOs5RoBlZohNrzFAnj5CnZa8cFAJbAfqO4kaawgB3/pGdHoK2FS2Y66pIfdSCmXyoFa2Q+iwMsTqY7fArOO/j4yNeT3tqDWeoIMHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759816758; c=relaxed/simple;
	bh=MNugEjWSjasVLozc5unFlQosghamCVKsKk++dyABjHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mDTW0bG9G7bHJZ/RFZhcsKCvXuzUawaSCfIaki4XPEirVeFoJcVEE3w3JJVtBx4kXedG4mCJy22tMdFzMhKFCASZbpgkGDs2iF3vcqKtxh93dj8Anv9FK3Gm82FLCEdHroQjJDDUeREt73kPa3fEsdtd4pbQ/+UYwpOg2A/qV1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gC4mBz6q; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b5f2c1a7e48so3996715a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 22:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759816756; x=1760421556; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TY1Z3zjE2hmR/H8RZQ8GW2E7K5sHv4uVwuJ09oV8pME=;
        b=gC4mBz6qCjTBronNclo0H7BvqdQLTIMRPEvH9H3blNqFclP1/caqrgCPAMs0upnY38
         7qGF5pSTq8aWy3T3yWnOrv1mPMtR5NBgXwWs49KnH7FrZFnt5i9ggunv4uxlS1Gzu/+j
         mVSq+bJGDlsfzbANFlBw7m32MbdxmRZrKRTkrVbPvzgsMQA+IMESkjf9mCHCHK7Fw39R
         6VbzUcvhcudJ4oGUVhZXjgJff6c92r6UupjkfZVs1zzXpW9n/EwV+jep5Wa3zFcTWAvr
         ZY6ur+IiiDK8zTCaa9ejetK/AaulRwKuInBmPjol5y0viF+k67cyFn5MID4TxxKtMSsX
         UZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759816756; x=1760421556;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TY1Z3zjE2hmR/H8RZQ8GW2E7K5sHv4uVwuJ09oV8pME=;
        b=RZckmlbtk1D2oCa6cGvw6/qLA5Masi7LUgFYYG4w4I9GUJhAgSrSLhF0H+Ej2jDoLF
         LQCSGEPfYFYNuFrbXiF4EDqobHSEjRfxAKWxZHEfvbPKfFTtHerKMYJu0HqMkR0KZNgb
         8Q7Ul6cCZGx6jLJ8D5Ihhhp2KdDmdfYL1n2kmuUN7P/WvqSj1bMPBQew/7FUDr7G3Y5T
         36tjEGkIjIsplgGRGPGIH104PzcPRJXFa5zEutxiG89k/cJrAgvPWCzNTGEEFCuM4kw3
         g88D7ti3OWEqub1j3KTcyjSZ2oIS6VMHvPi2Wz31Sl6l+lQh3dp6/sTliqyhmhePl9wg
         Mgsw==
X-Forwarded-Encrypted: i=1; AJvYcCWKlbknQ4Cl29ZcriNZZbNm57KhOjWMytvmFK7/uWBh2z7Jv6JpwKG9lJM21lJRtW9dOIIlhSa4RWfRI/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwghzQo0Sa/Q1q28OBTVvH1U0j359tEu0lerYEBmFSzHw+w62+y
	BI0A6Yx/Q1ZYk8B3NMRcLTn562m5kDKqxmMe2+A8uT1OunEb2patfTaE
X-Gm-Gg: ASbGncuFNNPT6QHdSqhLs/RhNIImtaGa6vv/k0itvCsDQGLc74KC76Ypf/qroAdYdyq
	t446I9PH+CcogwFgvZWyFxFp97d8NrBvf9nhrRwuLd3mNufvNp7PuWXaVnDUy6x9DC8wrrTIEI3
	sSaqZfNWCz2qJfi7yMgHa5YFH5cEkcqwYua6vLe45WIM0ze9rgvCCS7ZStdHT7TfRCw9NBNrXAo
	LQ9mD5PK2KYaZ2oIAExTW8L44LqmUkm8+bVPKrwo4YecNpX8S7pEcrx6VurXFPiy1YX691zV5nD
	sijm+wyqAgRWpNbMpYujtHbJISyTvsM7SJLWATpOFFpIKFpe95fDqBsQaGDBxkl5SRframaTe5P
	z2KhhQpXRCTzdeWNwDwSosd3pWlTFQCG7PJz5XHE4PPrgEj/4XloN9fUtHuja/XRGZxqTTwMcnF
	pygywaZ+eoeqD/A8Hk5x+8oYNf
X-Google-Smtp-Source: AGHT+IFlzsudHAIxUbF3d9k5TBWY8zUqb3RirQ/wOsrjbntDRjbfjMsD2j/0ZFEZEcTWL9AWUFx/Eg==
X-Received: by 2002:a17:902:f708:b0:27e:ef27:1e52 with SMTP id d9443c01a7336-28e9a6aa8ddmr160679545ad.35.1759816755990;
        Mon, 06 Oct 2025 22:59:15 -0700 (PDT)
Received: from [192.168.68.62] (104-12-136-65.lightspeed.irvnca.sbcglobal.net. [104.12.136.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d135cdcsm151111185ad.59.2025.10.06.22.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 22:59:15 -0700 (PDT)
Message-ID: <7476a26d-c629-49a4-ab47-eaffda482782@gmail.com>
Date: Mon, 6 Oct 2025 22:59:14 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] arm64: dts: rk3399-pinephone-pro: Add
 light/proximity sensor support
To: Diederik de Haas <didi.debian@cknow.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Ondrej Jirman <megi@xff.cz>, Martijn Braam <martijn@brixit.nl>,
 =?UTF-8?Q?Kamil_Trzci=C5=84ski?= <ayufan@ayufan.eu>
References: <20250929-ppp_light_accel_mag_vol-down-v4-0-6598f22d3451@gmail.com>
 <20250929-ppp_light_accel_mag_vol-down-v4-1-6598f22d3451@gmail.com>
 <DD5714TDL1NA.26WS3YF7EMZ5I@cknow.org>
Content-Language: en-US
From: Rudraksha Gupta <guptarud@gmail.com>
In-Reply-To: <DD5714TDL1NA.26WS3YF7EMZ5I@cknow.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Diederik,

>> +	stk3311 {
>> +		stk3311_int: stk3311-int {
>> +			rockchip,pins = <4 RK_PD3 RK_FUNC_GPIO &pcfg_input_pull_up>;
> On page 11 and 17 of PPP schematic V1.0-20211127 I see LIGHT_INT_L as
> identifier so it's best to use that identifier here, thus
> ``light_int_l: light-int-l {``
> and update the pinctrl-0 reference accordingly.
Thanks! Since this is a simple change, I will wait for more comments in 
this patch series (would like comments on the mount matrices for the 
accelerometer and the magnetometer). I will put this change in v5 if I 
send one.


Thanks,

Rudraksha


