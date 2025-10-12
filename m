Return-Path: <linux-kernel+bounces-849381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EF7BCFF92
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 08:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8654D3BED49
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 06:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321C3212F89;
	Sun, 12 Oct 2025 06:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me-ssier-org.20230601.gappssmtp.com header.i=@me-ssier-org.20230601.gappssmtp.com header.b="O2LUySFq"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62151FBEA8
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 06:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760249015; cv=none; b=iGqQI9RZaU6SwA6U5aYoRg7QbC46f4pQPDFpCeLWG6muZ3ribfvGn9qM4m1OiCGb4klwd9O/9JhF6D1IwdM10eCUj1+pbxLPh3CwcluAanSSgAUo8NgmXLVVlF22HmhUbtZeIut6XUVKsHQfOgcI6gjMPVK2aCf3FO5grNRWHU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760249015; c=relaxed/simple;
	bh=EL2sXnkVXyc4/0xhj1/c7GTQHDex3rg+30WyKQzgLNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VvnOBAQe1b7gUrH7Fmv+nrecn1YIMkZPnWEl7aVz4p6GF4wHRC/KF7XIVYYEBlL1jKVQo9A9oEmFUYCNwr/97F54x/NYPyxT/Usn5egQJVqn0C+DrtmgzhiOMMRBvE8FwFPTpn1aYSZSlERgwaMRA6KvM66+UsDM1jmoEKlZGr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=me.ssier.org; spf=pass smtp.mailfrom=me.ssier.org; dkim=pass (2048-bit key) header.d=me-ssier-org.20230601.gappssmtp.com header.i=@me-ssier-org.20230601.gappssmtp.com header.b=O2LUySFq; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=me.ssier.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.ssier.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-875d55217a5so425612085a.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 23:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=me-ssier-org.20230601.gappssmtp.com; s=20230601; t=1760249012; x=1760853812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fRm9xjoa7nma870h/XmiqTo0QL4WR8G5o5uredUdibo=;
        b=O2LUySFqouNdvHjJuev1tGTrotwEqB2FM52NnvKpwZ6XuDTMrirUL8VemA4BtRa3UZ
         HjUIVvCcA+rZVR5e93uqw4WFpvO/WhLFlNFbQWd3LdOHK1ehR92kbVOBvvnsQOKeK1QI
         wNKjDHZtfppO6UqnETgyX9rXYzUffSyPYeoJGkCOa/pC70LgGQwVXyv6cG5lWuG7Qkov
         u6cXsK1Tzs7E8+vcGLSjSmbK1tmhuNKwbgV9t11XVD+tcS3EQrT34K7AOkCyiQDUXBJt
         zOltcv2XA98rbL8Osu8TY154AbHz51yUKalc/SYWIyIYUF02CAxZcyODwbIkiybJowMb
         JKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760249012; x=1760853812;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fRm9xjoa7nma870h/XmiqTo0QL4WR8G5o5uredUdibo=;
        b=B5btXed37J0qd6uQhXvRPk7GYlBxF3inqn24ylaZcMAeOL+zBYSUVF081rqq5p7AsS
         VKuPPJmpeTEEZlaGOMrHwMw+BvbfaOfLLzAY3/qOxK3f8hvu1739Zrl+mtm5IDScNznL
         fDwog/6sVEcd4KhQ/CTw0pGU2Ak6IkUhygXvUX6Yz3cIbtxFJAmk03MT4HmcK4PVkj+n
         qUjTfedmTtf1J1Z/q9CBt/bcxHxkd/Va5Zsh9hU8u3btkO7VhLQTpc5iJKZa2I17tB8u
         k9fHK+u0ZdBdndw745JLOmx7K9cpuOe9olI5lvnHP4AJO31xtG7Xv72zfqOW4qf/1wUQ
         j9mg==
X-Forwarded-Encrypted: i=1; AJvYcCX+VTYk0oDQtoCrekcAieZazmJ525IBvTXSXywTUDdQxK2ryk/C7PDiusw6D7InOTkCvKTJjtX0G+grzWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTpYMncPG18r1lAKUFhKUhbizf6ey6cDceJYcloA96uCTjTMGL
	SaDsMPtX8EqnprniVbkyCqBrMrH1iBJhGl+PSgrtDobJlpUrYca2jkniXlgo4BlIIRI=
X-Gm-Gg: ASbGnctZgTVjIPYER1ai3Hcw+OfvdRHfioUC2GiVrJ2drQxqM7+hsSURnrWqMAXReVR
	ZOpSyELppR9KzTA3/6IYSX6su4+1rxq5iVPwgrxrhwA2orzri0BlsRs/roqpYZvgVBI4wfHfPez
	juQCAKjaCxyrNZdsQDU5qXah+CL54fBzVacr9kYJDRjLF+tia523cLiuI174Lte+0Lj+IUT+3bU
	NxuOwJ5NpasUEYJ8XbsSdtSqkxtRe9GgMgnzR8KsgYVLyxeNs59HDFogJOtnUFwxCmdbriUnjve
	8am31dKuSOu/blbWuZH4WiZru7rLlcTyB+INNJne7Vaas7wOKuySZTmVmCA5RyAsU54lpLXXC2L
	v7WYu+r7dMGi6KUt3rb9u/29TwrMchNNgWMiSWhP9ZOPzgOnvlCr8qK7Qf4GmtGGf3wODS2qt4l
	Yhx8ZFL9MFztvWd3BVAU2NDB/LF6teuadSJ2WG0VY=
X-Google-Smtp-Source: AGHT+IGLhoJnin+O4om4Te+bAwuwm/6HPtCKLHtCftsCB9hZmh2J7RkjVHXeDb2T0HUlNqxwL0iT8Q==
X-Received: by 2002:a05:620a:44d0:b0:863:b78e:d159 with SMTP id af79cd13be357-88354ea751amr2282466585a.51.1760249011609;
        Sat, 11 Oct 2025 23:03:31 -0700 (PDT)
Received: from [192.168.2.8] (bras-base-stggpq3702w-grc-09-74-14-126-215.dsl.bell.ca. [74.14.126.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-884a1ca3defsm730315685a.38.2025.10.11.23.03.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Oct 2025 23:03:31 -0700 (PDT)
Message-ID: <fef52764-3092-4375-b9c7-793d85adc102@me.ssier.org>
Date: Sun, 12 Oct 2025 02:03:30 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ARM: dts: qcom: msm8974pro-htc-m8: add status LEDs
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Luca Weiss <luca@lucaweiss.eu>, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251007-m8-dts-additions-v1-0-53d7ab3594e7@me.ssier.org>
 <20251007-m8-dts-additions-v1-1-53d7ab3594e7@me.ssier.org>
 <6c791f05-70e7-49c9-a3ce-50fb82b0c894@oss.qualcomm.com>
Content-Language: en-US
From: Alexandre Messier <alex@me.ssier.org>
In-Reply-To: <6c791f05-70e7-49c9-a3ce-50fb82b0c894@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-10-07 06:03, Konrad Dybcio wrote:
> On 10/7/25 7:55 AM, Alexandre Messier via B4 Relay wrote:
>> From: Alexandre Messier <alex@me.ssier.org>
>>
>> Add support for the notification LEDs on the HTC One M8.
>>
>> Two LEDs are available, one amber and one green.
> 
> Do they form a single notification led, or are they supposed
> to act separately?

Good point, I had to check the phone user manual to confirm. Indeed, it is
referred to as a one logical notification LED. It also mentions the color can
be either green or orange, it does not mention using the combined color of
the two LEDs.

So I would say they are supposed to act separately.

Hope this answers your question, and let me know if more details are needed.

BTW: I will be sending a V2 to update the color name, since the user
manual says the color is orange, not amber.


> 
> Konrad
> 


