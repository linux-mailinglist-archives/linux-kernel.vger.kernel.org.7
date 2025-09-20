Return-Path: <linux-kernel+bounces-825525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF14FB8C08E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 08:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99EF46215A8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 06:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFECE223DD6;
	Sat, 20 Sep 2025 06:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hag0sJYP"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84631F3FEC
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 06:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758349297; cv=none; b=rgQ/s6BxJMqZOjk2d+uh58VqLlvl81BMWlniyN9pHQqKhDiFdTI2kR4T48sc7mZk8ptfj/ItCc6QvYRyxJh3jjujnFKR/gbnbFkNXFtF2CqOLLpr5tvb0vMTPSExo1ODWGcktaZA/MS9PGEccgiO1vJ2vv07KJ8EA9FKCvfy1G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758349297; c=relaxed/simple;
	bh=2CS7puWReal692Afu/64ZmVU6Duki90EiB37CO+lLJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YrYMGckfWJQdx4RzoH/hR44xuPG4mPyhzEYCyXc2nzdT9NSaeTdc8SAN7lDVMjMdHv1yn69pexcg2766dWP4CcenuqwDSj3q19TXLiWFTbCQ0W8vMdQAxYaLB9TggXwZ9ly5qqifnWLZG9TdX+fVtVhth/I70yhv44kW7cIhKtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hag0sJYP; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77ddfe29cccso1685226b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 23:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758349295; x=1758954095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cIvPS4JbRoaIqIYD1oAUKVTexrUyLyhHhsTO9zcUnAI=;
        b=Hag0sJYPpfTuN2OmpH5nNjDTCQd46YHuCl+s3IQ6MgvbO3ZgDVCWhCJlPUUsdDuq23
         AcOfiXofZwbx50gySiZIf6NYOyk7+xTImP0lvq2NRK3CVkjoYaiAoMBNS3rFnuUa9IIF
         aO7EpsefpZG3XXVGYkn7RrXFHWYeD5OI7r+0w2eodlE5GK1xGiKQ6eETNimcfrNr6F2/
         IXrx/EWNzCOzIeLxoCOfsXCDzmOUwawTlWZNxp7zSIvrQlN6Wc5aaIOL6vnE0o3Y3X5v
         36kHsPVCenVqY+Oddxuix/lsYdrxyQ9ANOXF2GGPmmKj7Z+nXH30kyOuiw0D2sLlm53j
         Hk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758349295; x=1758954095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cIvPS4JbRoaIqIYD1oAUKVTexrUyLyhHhsTO9zcUnAI=;
        b=veGyl5X3n/WIEh6tdEL4c2FvYDf4MthKTcgqwEplbuHKeSvZ0F685q96QARvVcR2wG
         F8VYLGdQ0+URe2dDTH4uYOnnK5Fdku1iCAHEuRnijk3Gtp8VJv4gOYe98s0P1hHGbp5C
         tS8j3BOCktJ7MvP8ZmGmGI8/wzUwt21QVz945OgINdbXQoZLD0U7NBOExlb/rkrUz1Ot
         UoklmeaDwe7rdCZtNDVXdf0W4XPr7LEPlKviTulkTrw5QHOXaG79cFpQzVCAIPtqqpzb
         HEEDuRpbxNsYYMPDAQyIEvWF0AC+YZ1CrD411Q3DntxwvYPKySlbBYHF5yNtJoy8ML/S
         yT1w==
X-Forwarded-Encrypted: i=1; AJvYcCW3OOZWci6q/snj+PmD7iFeTda7oa9FQfOSuZT99bXx7FV8zG/K/laoJ30XvXVr1VLl4zniqD6fSf13CEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBnsXqX0AJ0E4YppZpIV+JHbyPhs8syYYZ7XiZej7u2dHAVehP
	c3pFdBJG7ELmZ3WNAwaRu3y8qeQDI5oXUWn1kePouiS6/qu1KodTMKdR
X-Gm-Gg: ASbGncsWCVc7eEXUGCChOqm03VOpTWR8B+3YACHrRFruM0MDj5uBOuQ5dhb8eojGQ0q
	ApPFuiMA6QtJOZu7X7vDurJaC44gW7dyg9lQ1ZAzNncTIUJc8ACW/aiMOE3i/aiSaFeHFXYDU29
	qWPviu8rO/W8up3vcuR9T5mT3AUtG0rvgQmpwuqfCoFJTWpkSRy3he1NXLmcj3kLNrJcQb6t3ih
	cgPIVtiH/gTcdBXZrSWGBfaNYHr+cQPS3LAf5iCFWt3fD2/B7nOsgifEBqcbA1ttxxNW73Q3x+5
	av6A3xXjY7CVIfnZjK+b5WPPt6nEMlHIqKugD/ZZEk/bzN6TDGDWCOV4sZQtDX1zzhvCZInHC47
	dGt2MbKmP8dcPo98OaiukuC9jRn6vPTNSNYQB7mbjQwV3XZAYKRJfcnqVmPo=
X-Google-Smtp-Source: AGHT+IHGElTkmUUaEf0dyfyafF631v013uwqxUws1ECPfB3/tiTo1tIEbGI9id9D93IB5vks4u+lfw==
X-Received: by 2002:aa7:88cc:0:b0:77c:64d8:3afd with SMTP id d2e1a72fcca58-77e4ecbcb3fmr6469774b3a.28.1758349295059;
        Fri, 19 Sep 2025 23:21:35 -0700 (PDT)
Received: from [192.168.1.7] ([223.181.113.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77e20bf07c4sm4550315b3a.70.2025.09.19.23.21.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 23:21:34 -0700 (PDT)
Message-ID: <7cddfccc-864d-4fa8-812f-8c273fe1a626@gmail.com>
Date: Sat, 20 Sep 2025 11:51:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm: dts: ti: omap: Drop unnecessary or unused
 properties
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Barker <paul.barker@sancloud.com>,
 Marc Murphy <marc.murphy@sancloud.com>, Tony Lindgren <tony@atomide.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org
References: <20250908-ti-sdhci-omap-v2-0-72927890482f@gmail.com>
 <20250908-ti-sdhci-omap-v2-1-72927890482f@gmail.com>
 <20250909-uptight-fluorescent-markhor-4639db@kuoka>
 <501a4e0a-2d6e-4a57-9006-91413bd2ebb4@gmail.com>
 <20250914222348.GA2080538-robh@kernel.org>
Content-Language: en-US
From: Charan Pedumuru <charan.pedumuru@gmail.com>
In-Reply-To: <20250914222348.GA2080538-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15-09-2025 03:53, Rob Herring wrote:
> On Sun, Sep 14, 2025 at 12:19:15AM +0530, Charan Pedumuru wrote:
>>
>>
>> On 09-09-2025 12:50, Krzysztof Kozlowski wrote:
>>> On Mon, Sep 08, 2025 at 04:17:12PM +0000, Charan Pedumuru wrote:
>>>> Remove unnecessary properties like ti,needs-special-reset,
>>>> ti,needs-special-hs-handling and cap-mmc-dual-data-rate from the DTS
>>>> files as there is no user of them.
>>>
>>> No user? That's not true:
>>>
>>> git grep ti,needs-special-reset
>>
>> Should I remove ti,needs-special-reset property for the compatibles 
>> "ti,am335-sdhci" and "ti,am437-sdhci" instead of removing for all mmc 
>> nodes? ti,needs-special-hs-handling and cap-mmc-dual-data-rate were 
>> defined for board specific, so these two properties should be defined 
>> in the YAML file to resolve dtb_check errors or can I remove those 
>> properties for those boards too?
> 
> If those 2 compatibles don't use the omap_hsmmc driver then, yes I think 
> you can remove the properties from those nodes. Otherwise, shrug. Ask 
> the TI folks if you can't figure it out.

Those compatibles use sdhci-omap driver not omap_hsmmc driver, then I will remove those properties for the nodes with those compatibles. For the properties which are board specific, I won't remove them.

> 
> Rob

-- 
Best Regards,
Charan.


