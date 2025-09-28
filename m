Return-Path: <linux-kernel+bounces-835265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFF6BA69EE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 09:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C9E1899688
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 07:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3771DE2C2;
	Sun, 28 Sep 2025 07:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TA8veX4E"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E68020F067
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 07:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759044117; cv=none; b=N+WxDFuDNtcMTD7LC1S16nQGiasQ5hafLAzLQMFKjKWfgjtWABrjGAzkkdPZNxwrcGkDK/p45d6OJGO5khZk7z/HER/HYjOpauCLGixKc90Hx2XYFbKzCWViJQL7fsng7Jgk6VzuneJf9xiVe+NRYEybo+UGSC9nazWyBMshpIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759044117; c=relaxed/simple;
	bh=8bb2fYU+sILA0jTusZElfBQ+h6vrV3jXs7+C7Osrmsg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=WRZgy/3kZVY140D+1VYcsHDKkOJKFx0CVdIX+xE0W+1M+RRJiR1dzgR32rVwy7+z9eXz4tgdEmUozHj1YKlGI2M8ggJC/48EXua+t9Xri9+whN0a4FeBFIMRxuP4lW3YrpXhg4mCoj3vWwGDtvsjICBh+6Jd1RcdrM19rMVNqRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TA8veX4E; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b555b0fb839so2592893a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 00:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759044115; x=1759648915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XpCiF6Q0gC4mzPzTArafcdqc2RzxvEFa6IwQZvqDTak=;
        b=TA8veX4Eu4BQcIPgio3WsVXutvC07W8RQZ5gvlCwN784FAeSltCyi0qPUspslAlsNa
         8/bLB8pRyjvPSOwyLv8LdKiEGVOG27wSFldnV4Gb1s+SapUtOacaOzojgaISffD4BmZC
         OkvQ23yndxPKbCtnLNwe80soqPDfveHmTdsp6IceR4i3NZr2gKApl6JtZ1YhqrZbSZDl
         7jdYSTRvtRptHi+g8sMnKFIeSb5+Emu4SzUZn1NLqDBp8xME+ASPvkUk7Nkl2OA64MaV
         kDk3mtt89s1tw3QnW4twlTlCjlep9ND/QRNsAsImP69BpKtTmEjrRpIbr+a6+bpPvDXE
         vI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759044115; x=1759648915;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XpCiF6Q0gC4mzPzTArafcdqc2RzxvEFa6IwQZvqDTak=;
        b=qaQ/4q01C4wMKtElq0VTM+mWOHcY996XZeEoN3n9faKkHnoelURjLiDUki9IuIUor9
         kLsk1vMT0SVPc8Ep7nnxS4doSZMIAjJsZkq0xoJu7Qf0jJgaYyV8XlgaVsskoXfcKark
         qupL3o3ETT519LEZbTGdCup93E4ocoFHvKGGt2Va04QaiOmkHdIsz+yMVD+fPECw0bMk
         vWGsY72BAlB3UDeI5hesFo792peU5b2uOoBVu6MV2Vjvpihnikikz6zFRVU244xxpNoP
         j1Ru4wjvyEMTxcsyeUzlsFhUAhGDJuDgbtsN6MnuqsIIby95VJ60MO6zSFXIAU20bjEQ
         8VMw==
X-Forwarded-Encrypted: i=1; AJvYcCWWFS8wMUM3BSMuf+kLu4yniEenNTxiQD9dUa0h+bV9XgemtDSJvoSsEFDPOtgoNbwdvUM+7Ue0wen058I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHooN1jKD1uQWzw9kBfrGN566LjI1o+lunQlObyIDPgARgoKi4
	DvqRUeTb5jg8y+ry9O2CxJefmIoLBa0LOBEVXZyuBcsMshrS3tSaoEHTe1l1A05T
X-Gm-Gg: ASbGncsJpEaLlLSIRLz6glehkKRAGN5EzSxAyE+LLHY9LyRj3n9vvZ7svkVzqyBu9Tq
	xQF8Stro/DbqgZoFqot0yXSDbrQFZ8QdBGxeCEtzqNJ9Q6Z+AT8jgrfDWw1WfO9ILAt8Z1tZYi2
	vHWhbyLO6/HkWJ+7si3KMe9qFAHtAYRs61P5a0e7knhTjHWYCvfdPtel9xQ8n4XsOPTQKGhPHID
	Bat8ev7vTQakrTmDa/D8qXm/irKWLN+cZdrXnZd53GeSKtwPo78GHTpsSQzWxboTwoFkZmRaSSn
	B92NCm49SMv4aRCHL23PBRXn0NK9xNL/BBz2StIDNXTBKXelabqz2x0h+7LrnlR+w/XmKVFauhG
	bg6Mvmq/LufMfinCqLOublg1tcK47l2se1p1HTY0RWZqT
X-Google-Smtp-Source: AGHT+IE3K6cxGebPaghMoOfjVtkomma3llpeCyRrBR+ZzlA+2a2lY9/p7YTkmGSjAkY89QdS5pSR+g==
X-Received: by 2002:a17:903:13ce:b0:275:c2f:1b41 with SMTP id d9443c01a7336-27ed4ada760mr117341425ad.53.1759044115399;
        Sun, 28 Sep 2025 00:21:55 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2804:18:936:cd7e:b4da:5f35:3f64:9397])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ab64c7sm96076225ad.130.2025.09.28.00.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 00:21:54 -0700 (PDT)
Date: Sun, 28 Sep 2025 04:21:51 -0300
From: =?ISO-8859-1?Q?Eric_Gon=E7alves?= <ghatto404@gmail.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
CC: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_arm64=3A_dts=3A_qcom=3A_sm825?=
 =?US-ASCII?Q?0-samsung-common=3A_correct_reserved_pins?=
User-Agent: Thunderbird for Android
In-Reply-To: <oi6hdvxqcble4qikfngpqc43glf6nwl24oh2ukdqwautbt4jui@geuzqecdqgsv>
References: <20250928044533.34798-1-ghatto404@gmail.com> <oi6hdvxqcble4qikfngpqc43glf6nwl24oh2ukdqwautbt4jui@geuzqecdqgsv>
Message-ID: <E0197AFC-D605-449B-BAA5-AEA0F6C52413@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On September 28, 2025 3:11:16 AM GMT-03:00, Dmitry Baryshkov <dmitry=2Ebar=
yshkov@oss=2Equalcomm=2Ecom> wrote:
>On Sun, Sep 28, 2025 at 04:45:33AM +0000, Eric Gon=C3=A7alves wrote:
>> The S20 series has additional reserved pins for the fingerprint sensor,
>> GPIO 20-23=2E Correct it by adding them into gpio-reserved-ranges=2E
>>=20
>> Fixes: 6657fe9e9f23 ("arm64: dts: qcom: add initial support for Samsung=
 Galaxy S20 FE")
>> Signed-off-by: Eric Gon=C3=A7alves <ghatto404@gmail=2Ecom>
>> ---
>> Changes in v2:
>> - Fixed the formatting of the <40 4> line
>> - Added Fixes tag
>> ---
>>  arch/arm64/boot/dts/qcom/sm8250-samsung-common=2Edtsi | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/arch/arm64/boot/dts/qcom/sm8250-samsung-common=2Edtsi b/ar=
ch/arm64/boot/dts/qcom/sm8250-samsung-common=2Edtsi
>> index 96662bf9e527=2E=2Ea87e3d23e3e2 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8250-samsung-common=2Edtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8250-samsung-common=2Edtsi
>> @@ -159,7 +159,8 @@ &pon_resin {
>>  };
>> =20
>>  &tlmm {
>> -	gpio-reserved-ranges =3D <40 4>; /* I2C (Unused) */
>> +	gpio-reserved-ranges =3D <20 4>, /* SPI (fingerprint scanner) */
>> +					       <40 4>, /* Unused */
>
>This is still not aligned to the opening angle bracket=2E Could you pleas=
e
>recheck your setup?
Yeah, sorry, I had it set to 4 spaces still - I sent a v3=2E
>
>>  };
>> =20
>>  &usb_1 {
>> --=20
>> 2=2E51=2E0
>>=20
>

