Return-Path: <linux-kernel+bounces-786323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCCCB3586F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEFBD17B353
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE89A303CBE;
	Tue, 26 Aug 2025 09:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="F/KVRZrM"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9617302752
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756199500; cv=none; b=SJ3/IGWAXxRUwrESPhG1iP8XVvglR317JiAlw3n99zSrLgEhFidos1KEa8LZbp0mecH/o3EhUPag7pEKTNw7BoDT40PvF4178nrvdVz1lp9aXjcbJGYoyeAyGa9Cy0EmGuStv+48el15t2Pgdf6iPlta1t2RI3vAZYKoHblNZvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756199500; c=relaxed/simple;
	bh=oUvDJknltmsHE5kgS2L1KW2dhWMzUcSQlAHCv0I9Kjc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GJ+1ckkzLNKL2XKafDvitrNu4I3Ezb+H02pAOYWF/jBtPd9tKLGpm2KnaeFtQYDnR9mpUnm3JlTStfayvoSJusahwgQmIRO8Rbvp1d6or1yfm7LWGBiu9kV1Gmudt5Nvp2WrlBOcKTKtAhltg2FMEtK8roai5O8BbE0pLUBGEwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=F/KVRZrM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45a1b004954so42091645e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756199494; x=1756804294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSGgiA7okXMSZ3FGPGzhv/sQluxvM/Gr3n+FFVx6Zrk=;
        b=F/KVRZrMHG3qI2k5+wSKxz5kmtxtIVRjTQlzLtokJLSKUVnXNhaFlhfUGf0T+w7EOs
         Jx9BOS++tu7wXl+ca7ZPKFJ8iT11olkcNnJVmhfM01Go9Z3BIh3bawlMVT6ILq8QjnKk
         NpT4figuvWk2/DUyuHkKkmqlQS+YCyA0qV4CYaCpVSTa2oUULlBhI2Jrr0T3HsdgmNU2
         /ASVvC0RPGIuv7RoVN0XLXiiv7oLROTHSuS+xt2dkcie17El3wsuz/xejYq7p73cu58P
         iiWH7v05l9doBgYlWOBBNeWtJRBoxONp3/3DOVx4FrjQxJPusSM91OcGCDjm3mMtMHjn
         BBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756199494; x=1756804294;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kSGgiA7okXMSZ3FGPGzhv/sQluxvM/Gr3n+FFVx6Zrk=;
        b=un462c6OFXq/nBo93kr6A5mc+aMNP+p0Kj4PihehCAh0g7ICNEsSIyHKmN0ENB8Csc
         0ndPKCmNWjFW+ZVPt9XCQcOcte2/KeSiZ9bZ1q4u60Xs8xl1d9J66NYY3WdDNwOAZ1BN
         R2ya5nxavppMys/QNSwDr9N8+wq0Myozi3KBcJKCLmiDbhVvj2cbA/IJMyc9c5GsdXKC
         lRWsHPzeHi9nAecttIefcLBLlmrm9UR/3KDSlBh5tImDIzBoJDSv2eMkyVte1FsnhDsw
         n72eeNZCVMwoXgfX4q2+C8SE7iLRMKqn93B2Gw2MBSMLMRzwCDiCLa3qmOgnmU+skQb3
         ZkIA==
X-Forwarded-Encrypted: i=1; AJvYcCVCFcdlGJU/93FWYRfIp+d44tmNm84Mzt2Unw9sF/iuBBBjdFhdHcTwws9J8b5l3M/eW8t+O/Cd1fPUllE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx40ZCMcHp1HqPxd3uaFoxd0227jiKlKTufKlKMuvYXAbrDDdl6
	ZHiaDOLpFOTjT6/Q0xTspffnJUGcxAiZ/Ui0SKt0ro0Y7D5k8SULu/TotI7lWRHSbMw=
X-Gm-Gg: ASbGnct8gGcY/WhO3g6LuKC4USSU0JLOWeBWTOf0Tf6piEDi16XstxMmfmCobn85ikC
	nnNeofPO81hkZWuhi+XcbX/7y6NeExb2pBn7C0H8qjEXiwyBVFdywChOSMoQ7PHNH3UuMu3rjI3
	OGtqTVkkzD8STNTTR0u89RDsf7Cd2VGWQE5jNM7BHK0pdIOxJzb9VNAHgGhhSdqHnu2qmlKobHk
	RtlyKtt4LYyezsrt0rjRz2m8uXI388zQOAqJkIiwCJKBnn0xpJH6c9EYBkFq1INBfmDxQtlFOU2
	wKA1H/JDfrEpvnmGBEk6vvOS6pvKX31zGgzwDC9fY9JPr/Kt/lryLSoFxJrGY+3iYB+oayUv5T3
	CP/WJVfRT4sVVZTin0KpM4pLAa2WgUJk=
X-Google-Smtp-Source: AGHT+IFtBWXrOWyVTOM6kOSvzOnSizJ26W7d5kPzjQBIk8HokgLiwvROTQt35HufZ0kQxPuRV/tMwg==
X-Received: by 2002:a05:6000:400f:b0:3c8:eead:3d2f with SMTP id ffacd0b85a97d-3c8eead4359mr5090468f8f.41.1756199493485;
        Tue, 26 Aug 2025 02:11:33 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:46d7:73a6:7b7:2201])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cad431ea49sm4204236f8f.42.2025.08.26.02.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 02:11:32 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Chuan Liu <chuan.liu@amlogic.com>
Cc: Da Xue <da@libre.computer>,  Neil Armstrong <neil.armstrong@linaro.org>,
  Michael Turquette <mturquette@baylibre.com>,  Stephen Boyd
 <sboyd@kernel.org>,  Kevin Hilman <khilman@baylibre.com>,  Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,  Jian Hu
 <jian.hu@amlogic.com>,  linux-amlogic@lists.infradead.org,
  linux-clk@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: meson-g12a: fix bit range for fixed sys and
 hifi pll
In-Reply-To: <c0e8cf9a-b5c7-4369-8b6a-c4f80a6bc398@amlogic.com> (Chuan Liu's
	message of "Tue, 26 Aug 2025 15:59:32 +0800")
References: <20250822002203.1979235-1-da@libre.computer>
	<c0e8cf9a-b5c7-4369-8b6a-c4f80a6bc398@amlogic.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 26 Aug 2025 11:11:32 +0200
Message-ID: <1jy0r64fcr.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue 26 Aug 2025 at 15:59, Chuan Liu <chuan.liu@amlogic.com> wrote:

> Hi Da:
>
> =C2=A0 =C2=A0=C2=A0Thanks for your feedback.=C2=A0but this patch is wrong.
>
>
> On 8/22/2025 8:22 AM, Da Xue wrote:
>> [ EXTERNAL EMAIL ]
>>
>> The bit range 17:0 does not match the datasheet for A311D / S905D3.
>> Change the bit range to 18:0 for FIX and HIFI PLLs to match datasheet.
>
>
> The upper 2 bits (bit18, bit17) of the frac were deprecated long ago.

deprecated ? that is really confusing

That seems to imply that it does have an effect but you are choosing not
to use it. Please clarify.

> The actual effective bit field for frac is bit[16:0]. However, the
> corresponding datasheet has not been updated. I will provide feedback
> and update the datasheet accordingly.
>

What about bit 17 and 18 then ? does it have any effect at all ?

>
>>
>> The frac field is missing for sys pll so add that as well.
>
>
> PLLs with frac support are used in scenarios requiring a wide range
> of output frequencies (e.g., audio/video applications).
>
> Since sys_pll is dedicated to clocking the CPU and does not require
> such frequency versatility, it does not support fractional frequency
> multiplication.

You are mixing "HW support" and "usage choice" here.

What I read is :
* Da says the SYS PLL does have HW support for the frac parameter
* Amlogic does not see the point of using it since the CPU does not
  require fine tuning of the rate.

Is that correct ? or is the HW just no present ?

>
>
>>
>> Patched:
>>
>> + sudo cat /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq \
>> /sys/devices/system/cpu/cpufreq/policy2/cpuinfo_cur_freq
>> 996999
>> 500000
>> + sudo cat /sys/kernel/debug/meson-clk-msr/measure_summary
>> + grep -i '\(sys_\|hifi_\|fixed_\)pll'
>>   hifi_pll                      0    +/-1562Hz
>>   sys_pll_div16                 0    +/-1562Hz
>>   sys_pll_cpub_div16            0    +/-1562Hz
>> + sudo cat /sys/kernel/debug/clk/clk_summary
>> + grep -i '\(sys_\|hifi_\|fixed_\)pll'
>>      hifi_pll_dco                     0       0        0        0
>>         hifi_pll                      0       0        0        0
>>      sys_pll_dco                      1       1        0        39999999=
85
>>         sys_pll                       0       0        0        499999999
>>            sys_pll_div16_en           0       0        0        499999999
>>               sys_pll_div16           0       0        0        31249999
>>      fixed_pll_dco                    1       1        1        39879999=
85
>>         fixed_pll                     3       3        1        19939999=
93
>>
>> Unpatch:
>>
>> + sudo cat /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq \
>> /sys/devices/system/cpu/cpufreq/policy2/cpuinfo_cur_freq
>> 1000000
>> 500000
>> + sudo cat /sys/kernel/debug/meson-clk-msr/measure_summary
>> + grep -i '\(sys_\|hifi_\|fixed_\)pll'
>>   hifi_pll                      0    +/-1562Hz
>>   sys_pll_div16                 0    +/-1562Hz
>>   sys_pll_cpub_div16            0    +/-1562Hz
>> + sudo cat /sys/kernel/debug/clk/clk_summary
>> + grep -i '\(sys_\|hifi_\|fixed_\)pll'
>>      hifi_pll_dco                     0       0        0        0
>>         hifi_pll                      0       0        0        0
>>      sys_pll_dco                      1       1        0        48000000=
00
>>         sys_pll                       0       0        0        12000000=
00
>>            sys_pll_div16_en           0       0        0        12000000=
00
>>               sys_pll_div16           0       0        0        75000000
>>      fixed_pll_dco                    1       1        1        39999999=
39
>>         fixed_pll                     3       3        1        19999999=
70
>>
>> Fixes: 085a4ea93d54 ("clk: meson: g12a: add peripheral clock controller")
>> Signed-off-by: Da Xue <da@libre.computer>
>> ---
>>   drivers/clk/meson/g12a.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
>> index 66f0e817e416..f78cca619ca5 100644
>> --- a/drivers/clk/meson/g12a.c
>> +++ b/drivers/clk/meson/g12a.c
>> @@ -157,7 +157,7 @@ static struct clk_regmap g12a_fixed_pll_dco =3D {
>>                  .frac =3D {
>>                          .reg_off =3D HHI_FIX_PLL_CNTL1,
>>                          .shift   =3D 0,
>> -                       .width   =3D 17,
>> +                       .width   =3D 19,
>>                  },
>>                  .l =3D {
>>                          .reg_off =3D HHI_FIX_PLL_CNTL0,
>> @@ -223,6 +223,11 @@ static struct clk_regmap g12a_sys_pll_dco =3D {
>>                          .shift   =3D 10,
>>                          .width   =3D 5,
>>                  },
>> +               .frac =3D {
>> +                       .reg_off =3D HHI_SYS_PLL_CNTL1,
>> +                       .shift   =3D 0,
>> +                       .width   =3D 19,
>> +               },
>>                  .l =3D {
>>                          .reg_off =3D HHI_SYS_PLL_CNTL0,
>>                          .shift   =3D 31,
>> @@ -1901,7 +1906,7 @@ static struct clk_regmap g12a_hifi_pll_dco =3D {
>>                  .frac =3D {
>>                          .reg_off =3D HHI_HIFI_PLL_CNTL1,
>>                          .shift   =3D 0,
>> -                       .width   =3D 17,
>> +                       .width   =3D 19,
>>                  },
>>                  .l =3D {
>>                          .reg_off =3D HHI_HIFI_PLL_CNTL0,
>> --
>> 2.47.2
>>
>>
>> _______________________________________________
>> linux-amlogic mailing list
>> linux-amlogic@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-amlogic

--=20
Jerome

