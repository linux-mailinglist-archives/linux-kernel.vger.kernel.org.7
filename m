Return-Path: <linux-kernel+bounces-847431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 455B6BCACF6
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 22:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20F901892D63
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 20:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF725230BCC;
	Thu,  9 Oct 2025 20:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+SZ27Pv"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB2D238171
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 20:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760041876; cv=none; b=dqBgiPiSOIYh5gJvSwuLc0hRjcpwyE0eEIXl8tvQNogmhETN4GQ2TPIhJmpl5VJtIdDMLwVp6V9sKQ/Yaf3/sIBaNzPcG1OIqXkIOdUz3rdPE8F2jo52xD5CoK2Q35jA4oTaOoIhCRgWaL2IuwkRN5Ctcp81x1KfA8uqRTJutnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760041876; c=relaxed/simple;
	bh=kKLKNn2tHOgfWHamcCoi89YXs3sQAOM85uKuw1N3TgM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=SEA7YfDH6CTwcR1lykpMJo6m1P3S7m0CVnasQ7BUm9uJMGC2v5Y1sgV79pOzyIUsVnm/N1Ti8PDG2xed4zrwDUDDZY5qV69cKr6vt7s0ysisUGoVlbBHi1qvAPSoD6TAg+8yCAJXVccUKtGL8hDX4T5FKjO4QJy8e2QJ3Cqmp0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+SZ27Pv; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3322e63602eso1996238a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 13:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760041874; x=1760646674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DX75+oENqhUs+ksNL4UsS5KO7/l0mpfDo9ivlBwrN1k=;
        b=Z+SZ27PvJCsa9qx4/+RncT90dTdtf4cMQcEk80DrHfkESmUTbEbqlr9XMK8neXrt/k
         3sOXhV/9Rp+hHIDNtx1XUVa31I9JhMXESmKeI7stDy6xDHFZqqdoKjhubYF1GCJbTQEP
         drAirjLRkipqfzwGlwxo1qtZsZmgOulqCV8UP+3eJ1bQYJjSDwKim2fIAAYcshtiG/9h
         rG8FPHOrFmeETjkUstbAUmq4Hh9/DhXQYR9XcDppigxt9MKKbvc/GW0L1SBtZmoQ4Uo7
         jJoefe+MIR0ET8mK8IE+EEvB4Kj/+cm5PsvVEvrNwMXHRbxt503/qPtL+Q+0vEEdYcIX
         I8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760041874; x=1760646674;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DX75+oENqhUs+ksNL4UsS5KO7/l0mpfDo9ivlBwrN1k=;
        b=XQIXw/Z+h0hj/yHehk8IJLs9iGsVhMvcemrMk9aot6qLJmtGNd5GzhSPZZ21jmPamV
         0S59ulvaEC39b38Ma8OVClch8Gme0vHCBEo1S/GnA8AHoxmEisIjP290Ln3Lyh1e/Hi/
         4zRgIXCMgGqfupR5rXZnAb8SkOjXmlOW01kfWsBOoSptpOiTnWTrL4h7R9LmuP4jkn2K
         nXcki117RWywZPHN0OyKOxS8iJqUBexgS5OeDwAzHnqJkLhZ1CkDqnKBCdfXP4FzNBBo
         1nxij4zPWtYpySU0UzozyPiQcb8vN8tT8ljHW8IADIMbEXPj2bPmligqSwLe94lD4xLN
         sFiw==
X-Forwarded-Encrypted: i=1; AJvYcCVXty3HthjALstrzmj2qwUbqt7KKT91yGc1W+DkCwIDlsyvbFj9CtHuVB4buQoQ5uu7jiS7g2iZnm8XiHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0d2qYF/XFOZkU93qtccy2xmjTUKL+YaM0Hgq8/I1s6rlQzmgU
	Oc6pvPgCy4RRHHRl6hIq4VNltAwa8vUCo280rupzKjYFSxdbsxmGrs2g
X-Gm-Gg: ASbGnctIrjzuN6WlJwBXOi5qdYfrUvdgIWbINY7enpf+9weEGXL9efxrJ18tXq9jLIg
	6HKp7TyGCNrw1OdW32FTWIuSHjk+jCb+uhyQiliYIKF3WmI9aYht52x+hI3mWS7t8WZP7glGfIK
	LhOIkG0juUSv+De2LgB2UV4MNKcQLWw7/aNjxR0ypIsUNEAm4Nyg3oDSD6TNlZZ1zwyTJAVweTy
	KIE/WExJl70Bf/I1D8BYEST2wQIV9NFiBY4mPOXq2EpMktuop/DARGTAqVBl8uiwdI2FBjUIjRg
	C99IOrBJoAVIYLmfJ5X3j3J2p6mDtHYFwDte3Pe9QRRq9izO2Nn1sYxRYVRBjTHnGsKHYSZWTdm
	Z9zBou0QfoyU1xyH9jOBSVbUw6bw5+l5lzMGwEYXJ57dZsHWpHqPrbw==
X-Google-Smtp-Source: AGHT+IF/Q0CQMjtHkri0GZVA9mm1eBLAuN8edY7oQCLx6h26GN1IZ77hNerCbEluRboNwdvi8zL05A==
X-Received: by 2002:a17:90b:1c07:b0:335:2a21:69db with SMTP id 98e67ed59e1d1-33b51161d5emr11321510a91.10.1760041874006;
        Thu, 09 Oct 2025 13:31:14 -0700 (PDT)
Received: from ehlo.thunderbird.net ([177.9.216.59])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626bb775sm438259a91.15.2025.10.09.13.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 13:31:13 -0700 (PDT)
Date: Thu, 09 Oct 2025 17:31:09 -0300
From: =?ISO-8859-1?Q?Eric_Gon=E7alves?= <ghatto404@gmail.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] arm64: dts: qcom: r0q: enable max77705 PMIC
User-Agent: Thunderbird for Android
In-Reply-To: <823af9ee-df4e-40de-bf30-084442bb1d2c@oss.qualcomm.com>
References: <20250920014637.38175-1-ghatto404@gmail.com> <20250920014637.38175-4-ghatto404@gmail.com> <53b1a622-3afc-4fd9-98b1-3c166f563ad0@oss.qualcomm.com> <BB4E3024-F897-452B-9D3F-250ED2D52195@gmail.com> <823af9ee-df4e-40de-bf30-084442bb1d2c@oss.qualcomm.com>
Message-ID: <17433470-8B99-4910-AB3C-494C7C27BC29@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On October 8, 2025 5:34:00 AM GMT-03:00, Konrad Dybcio <konrad=2Edybcio@os=
s=2Equalcomm=2Ecom> wrote:
>On 9/26/25 4:19 AM, Eric Gon=C3=A7alves wrote:
>>=20
>>=20
>> On September 25, 2025 10:06:53 AM GMT-03:00, Konrad Dybcio <konrad=2Edy=
bcio@oss=2Equalcomm=2Ecom> wrote:
>>> On 9/20/25 3:46 AM, Eric Gon=C3=A7alves wrote:
>>>> The Samsung Galaxy S22 uses max77705 as its charger, fuelgauge and ha=
ptic
>>>> PMIC, enable the fuelgauge and charger for now=2E
>>>>
>>>> Signed-off-by: Eric Gon=C3=A7alves <ghatto404@gmail=2Ecom>
>>>> ---
>>>
>>> [=2E=2E=2E]
>>>
>>>> +&i2c5 {
>>>> +	status =3D "okay";
>>>> +
>>>> +	max77705_charger: charger@69 {
>>>> +	    compatible =3D "maxim,max77705-charger";
>>>> +	    reg =3D <0x69>;
>>>
>>> Please use tabs consistently
>> Sure
>>>
>>>> +	    monitored-battery =3D <&battery>;
>>>> +	    interrupt-parent =3D <&tlmm>;
>>>> +	    interrupts =3D <5 IRQ_TYPE_LEVEL_LOW>;
>>>
>>> interrupts-extended =3D <&tlmm 5 IRQ=2E=2E=2E>, here and below
>> why extended?
>>>
>>>> +	};
>>>> +
>>>> +	fuel-gauge@36 {
>>>> +		reg =3D <0x36>;
>>>
>>> sorting by unit address is welcome
>> Sure
>>>
>>>> +		compatible =3D "maxim,max77705-battery";
>>>> +		power-supplies =3D <&max77705_charger>;
>>>> +		interrupt-parent =3D <&tlmm>;
>>>> +		interrupts =3D <5 IRQ_TYPE_LEVEL_LOW>;
>>>> +	};
>>>
>>> These nodes should be children of "maxim,max77705"
>>> (see drivers/mfd/max77705=2Ec)
>> What do you mean by this? I looked at the driver,=20
>> should I add the pmic@66 node and put
>> the units inside of it? Because starqltechn doesn't do that and
>> places them outside=2E Also, by adding the
>> pmic@66
>> node it expects to have led/haptics nodes as well=2E
>
>Well, the chip comes as a single package, so this only makes sense
>and the bindings (mfd/maxim,max77705=2Eyaml) corroborate that=2E
>
>Just looking at the YAML, you should be able to omit the LED part
>if it's not connected anywhere
Well, looking at power/supply/maxim,max77705=2Eyaml shows
that this is how it's meant to be defined, (outside the
maxim,max77705 node), no?
>
>Konrad

