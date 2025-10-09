Return-Path: <linux-kernel+bounces-846278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1962BC7765
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 07:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54C91891565
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 05:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EF3AD4B;
	Thu,  9 Oct 2025 05:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me-ssier-org.20230601.gappssmtp.com header.i=@me-ssier-org.20230601.gappssmtp.com header.b="grFunmPV"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55CE221FBB
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 05:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759989054; cv=none; b=Te+H8wBmbwqxFoGraD8OvbkVvRrgHRxvySkefZ1fURnh9m57SkOjso+BrluDvxVw9g/4zbjKjOoxhkVvzpBKNwCshqZc74oW9PLz8J/dryxkYpo5yoWfshFbL65hxVwPQaVpniN5cmBUsWPZHWadQE+//fHlWA9G3R2mVqdbflY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759989054; c=relaxed/simple;
	bh=CRcGoM/pdmgvjzc/HLi5jOX3AiGRO3dzVYqKflx3hZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u6gr1MX+EWSCUClZkTESJCXwGiqpRMKq9hSbqvx3sM9mZe1GnS6DeFEzTuNfU6nEKVhkw4y0IF6cdUtEq6g/8WODuJk3S2HlkGgQlavrudk3yYa+/RYlc2baHWTpXHmIANbU79XTwNCduxjwxKLrWW9CNEm2KYQKW+GY5ApmOcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=me.ssier.org; spf=pass smtp.mailfrom=me.ssier.org; dkim=pass (2048-bit key) header.d=me-ssier-org.20230601.gappssmtp.com header.i=@me-ssier-org.20230601.gappssmtp.com header.b=grFunmPV; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=me.ssier.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.ssier.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-87db3aa478fso48063685a.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 22:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=me-ssier-org.20230601.gappssmtp.com; s=20230601; t=1759989050; x=1760593850; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W/oPt2UM/yRSup/UV3LslStLtsSul+rezNIMA7ALhsY=;
        b=grFunmPVQaUBhYHE5+rccqwp8qgK+YMX513QU/fj+vri+LReQY6Q4coqnOdlI+KR3C
         Dycz+S2IKaRGgM1Zmno5ScOSFOj6+V9Gu4GrgQT7MUqOd7KjCSlf89fios5RctSOQ1uJ
         /1DZlUjtBpo/tU98A4S/LEFVNFIFUIDgpbHsMMuLngrnxiUBpOWIKrkrbsyyItWICx2b
         jyUYhTsq1fisTobSHx7xndI7vFj/TNfEFd8x/sn6J+4UvKzNbUDW9BN22tc1t6+C51E7
         buyejUYk9sW/ePk1q6071vm045BFFmw/rb1GlEXiuPRQjnJnldDLyzHaov4PBIfmIcNe
         daFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759989050; x=1760593850;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W/oPt2UM/yRSup/UV3LslStLtsSul+rezNIMA7ALhsY=;
        b=HEF0qinyjwANfRtBYjrlN3zQcsPt5v2E9Sq0D8F8DRdOKhKdLgaB8y7YpFSNPUd3OL
         4VE/4AKO9gDM0GASro+XtyNEjIWKtZP7/ygJeuj64M9En6saQ8LA3tkpMC6FqZesXv1k
         p8uA6H82FUQex0WqTRGwK5U1IFKVSMjolRWPtSeBX04gBFmUYd1WMfAc2ykTYPZNZkSw
         0PCmv3o6/vecABpuJIYgaZnjEGMTVeuNIfXY9HYpQqlceQ4oueqmSgf+TnNoVejKsye/
         x05TDW//aiZ6O1qzXRAaDfPhQTm1e3OpMvhYnRJzBfyGj2EOr0h8MKTWaYGxCnmg47Xn
         MLrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVhoOeWdu0S6y13oV3CtTWVAYS3wbkSrKWod3FZpe//RLfBMs1HeKaoWuL4q/PNFhokFXXSnrHyHPWaFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWLXy6O02fjJHn73eRVCIx9A6V0e/VpLlaRw4VZefsQB1Nz4xn
	iOOfQ/gArKNA2QvgNdvT2HvS75gZ6hWWm3CO5O+V/6H5i0+tZJ7P5XH44LyGj1UuWVo=
X-Gm-Gg: ASbGnctrwe9rGDNO2QP+VKMt1hj9Q2wj8cLaxJoxyBDMNvq/8SJiX+fHWwmYHYqHTrx
	xv273qFtIUwD4xAUzLo0MKYQ4Q38egHGAbvtGqQr4Tta/jNHUan1spvh4KEyQf9Y2vfzpRr8D1X
	HGG0NW6TeNg2FAxJxC3U2t4NFjYagjSLqJZiO4FydIdLOSwUzja7dyUdCrscpis4JfVxjVsBZdN
	akf3NS8N0ryjoEaOVtpH7z2Znz0lfWakgbTAYQabNUPDjlQvgAVqh6CvqTdpUi9eaN303/woXh9
	z09GhyDRlY3mFPaKaTz9CyRABRQORjL3r5sAetLmbqAOcIO9hD4XcpmRsbsFDa5EyH4fT2QFfOd
	n9rp380kL0ud209C1glidVR0TlxyZBcFtibvq3hH66mgG0RMXw/xG9ijg6euFdx79WIM6fIECD3
	zKPF7KQQ91ZWCaQW/QVuDg2XwCspgmBkWgGg==
X-Google-Smtp-Source: AGHT+IFCznXbDVprhXyGUQz2c8H3d7UxKBtr6+yolyAKzCcIf8tTzXD2m9VShCCqzveYlA1zyjZR+A==
X-Received: by 2002:a05:620a:1a0e:b0:868:5fe7:8d92 with SMTP id af79cd13be357-88350983f36mr1024873685a.31.1759989050419;
        Wed, 08 Oct 2025 22:50:50 -0700 (PDT)
Received: from [192.168.2.8] (bras-base-stggpq3702w-grc-09-74-14-126-215.dsl.bell.ca. [74.14.126.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8849f2e00d8sm136229585a.1.2025.10.08.22.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 22:50:49 -0700 (PDT)
Message-ID: <1d60b78e-136f-4051-8296-245d111ca49f@me.ssier.org>
Date: Thu, 9 Oct 2025 01:50:47 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ARM: dts: qcom: msm8974pro-htc-m8: add touchscreen
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Luca Weiss <luca@lucaweiss.eu>, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251007-m8-dts-additions-v1-0-53d7ab3594e7@me.ssier.org>
 <20251007-m8-dts-additions-v1-4-53d7ab3594e7@me.ssier.org>
 <5a9a2ed9-9e95-4bb0-b5b9-e4e0edcfa8d8@oss.qualcomm.com>
From: Alexandre Messier <alex@me.ssier.org>
In-Reply-To: <5a9a2ed9-9e95-4bb0-b5b9-e4e0edcfa8d8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-10-07 06:04, Konrad Dybcio wrote:
> On 10/7/25 7:55 AM, Alexandre Messier via B4 Relay wrote:
>> From: Alexandre Messier <alex@me.ssier.org>
>>
>> Add the touchscreen device node for the HTC One (M8).
>>
>> Signed-off-by: Alexandre Messier <alex@me.ssier.org>
>> ---
>>  arch/arm/boot/dts/qcom/qcom-msm8974pro-htc-m8.dts | 36 +++++++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-htc-m8.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-htc-m8.dts
>> index 36eb42f0f3d9..040a256f9465 100644
>> --- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-htc-m8.dts
>> +++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-htc-m8.dts
>> @@ -65,6 +65,35 @@ vreg_vph_pwr: vreg-vph-pwr {
>>  	};
>>  };
>>  
>> +&blsp1_i2c2 {
>> +	clock-frequency = <384000>;
> 
> This is not a valid I2C frequency
> 
> You're looking for 100/400/1000 kHz

Hello Konrad,

This frequency value is used in the vendor kernel [1], hence why I used it.

I did a test at 400 kHz, and the I2C devices (touchscreen here, and NFC in the
other patch) are still detected, with basic functions still working.

Let me know if I should still update to use 400 kHz. I would prefer to keep
the value from the vendor kernel (and in that case, I will update the commit
message to add that information).

Thanks

Alex

[1] https://github.com/LineageOS/android_kernel_htc_msm8974/blob/lineage-18.1/arch/arm/boot/dts/msm8974.dtsi#L970

> 
> Konrad
> 
> 


