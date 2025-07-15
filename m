Return-Path: <linux-kernel+bounces-732158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3D3B062E7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A73F4A0159
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF755231C9F;
	Tue, 15 Jul 2025 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="INCUKD2R"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635412264DC
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593162; cv=none; b=XJ70oXNBczDg/TRvc10qERjZ8w9zMEGOOO/d5y2gl+lg3x4lc2IAUAO1GzFH9aakZjnAmOcXWYIdl9L7/5r+xC2+xp8aLw4fjLOwYf5B/Y4BHYWG4VS1Mw5UxQAGGPy5RBRex4/qanJwjElPtlB8qLnbRmrP+fMfDBO4pS2aKs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593162; c=relaxed/simple;
	bh=xomn5vf15i0z+t9ioTU3UzRFpGuVxbhdf3uhcQIlnKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JSK1yg5Uw8wm8jtpZxndHy3n6BfUls2Lk7iYo5KOhEQghFaO3n44Qw8RcTdJhJagDzfet8Kx3WTD+2gY+YLN/Nbg5oDaBfH4kprYRs3qHq39ND7y+U8rzgHjZ/aECXOrxRkTtV0/Q4sidr/KphBg7IsaxtBTKPO3oSZok85lO9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=INCUKD2R; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-32b4a0915b1so9250411fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752593158; x=1753197958; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eB2l8LirDQ3/3m1OWxvQpzeiYtShAHkpkyBAu7GfeKM=;
        b=INCUKD2Rum6bpZZroqjDiQqKUyo8UjiuohCG+3ffjJrc7jcz5oOHLF3QMEjOBibaP9
         CwBtP6LPc0fGwU/DcbGNxkRrdI4SqAXxhdpJcqZIazglFamVfYuaP4V0knnFx9CObU3L
         ekLhZSuwbAeJ9GCk8/ky2PW28ZUXf8kLuS3OxJe4sT2Xn2FU7al9A4dgEN+QKfO/Nv29
         qHyBT/WqI5jvmzRd07+SQuIYAE/RJ5/iJaNQDZPbO38x0BdTgylNrfQ5Boci6nD3gEC1
         tY8PW+SJdYIVQpuzOcrvv8mnsr27wb2CH14iMGb1WMqeMSi/h49HGV6mMzfFrbKjP6bj
         q9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752593158; x=1753197958;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eB2l8LirDQ3/3m1OWxvQpzeiYtShAHkpkyBAu7GfeKM=;
        b=SrM0QXFHGkAo+aLMY7qRJwZWwtN5R+tdF1A4yMgIVxX5A73XUR1rxAeBmpm9Ki13Nb
         doC7yvy0dpRL4r/PjBcfLK44qL6jt2IPTD/ZEttbAv63g+pAOgTleQUyxQuCfzEwRK/x
         XguoRLo0SQScGBlyltx8a3IdntlkAlq3L0khg6W2yYIada7Y/oq+smqdCa5unfziOYkO
         Vn49P6VPh5yMt6ceQP7KiP+TJ9k63LSwuVIOiapeh1r3pXn+qbTMIVdTwJ7SWvLWNYdy
         Ary6jj7nyrMOROsO4RiM/gKIzw33hfdAFpyHblDbFsN9pYZCYCNXrgoBvxBWLY5UXyrv
         SksA==
X-Forwarded-Encrypted: i=1; AJvYcCVMuxoSIyGpm/VsYG7mi7KY0cPAS9gNu8X4N8sRx2APvtiSfhs5+HqXeDz+an9MFMyF0UhiUv8zBSFD4PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8u+7JRGHvVCpLnc6oVNr2+R3NAcP2eZNCIa/Ii1TyUyvfsGoN
	MGrkxHTHpIKSIRNHDCDMMyMZjb60rx8r00+zcg5upWK5gBJCkEQDIleyl92Glps/WIg=
X-Gm-Gg: ASbGnctuPbFVd2mgBX8tOcWxfkzbMdt5HwdFd3l6ge1w6W0C81PP//s8M6Cs3YZmwHK
	Ru6YzF7JRnkOuvew5e9XgoBV+fC1BO/FoXzR60X8q+jexzbJ70vmtwl9dEd80HocP6S+1UK82Ps
	G9nSOXV9tPjNF2u0NGtpr440j10OWAgRN9NJN7XE4vautK2Sha8q0/QXkelIXvTAtB4wbiYcUfc
	HqYq2Pj7XHBwx3soDoJLPzVQMINTuhVQHX0OD5ioUw7Oew2CQyOshFYAXSjojkeP+lWuUIQrUXE
	4Tv2uweQ8OjvYQAsPsgyOgLpOCYaT+HLWx8tCaz5X17t6q/ETUxtuoP3b9IruxGI+3OqDicwoKk
	wu4AH/tiFGjYMdobr8BnkvnqOW8/ADo1AeY1CcJJt0nQ60YWk0L2yFZ6u+sW5KFDBeOQduIsDJc
	bC
X-Google-Smtp-Source: AGHT+IF3dqduT8P/WO27MvTE1kRxqSG27mj6p5eykY25Cj569ar5Hr43W9KJDXWVN/vPeuVB83X8RQ==
X-Received: by 2002:a2e:b8d6:0:b0:32a:89bb:f8d9 with SMTP id 38308e7fff4ca-330873bdd0fmr2972821fa.6.1752593158292;
        Tue, 15 Jul 2025 08:25:58 -0700 (PDT)
Received: from [192.168.1.100] (88-112-128-43.elisa-laajakaista.fi. [88.112.128.43])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fa2913ca3sm19146791fa.18.2025.07.15.08.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 08:25:57 -0700 (PDT)
Message-ID: <a58f2e68-41fa-4bed-9282-deb5e5435f4f@linaro.org>
Date: Tue, 15 Jul 2025 18:25:55 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/15] Add dt-bindings and dtsi changes for CAMSS on
 x1e80100 silicon
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bryan O'Donoghue <bod.linux@nxsw.ie>, Bjorn Andersson
 <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250711-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v7-0-0bc5da82f526@linaro.org>
 <9361e954-e2c9-41c6-be4c-12b0e4f367f5@linaro.org>
 <ae0a309f-7e52-4d3c-8f26-989f22da5b07@linaro.org>
 <GbVC82h7wSXQsAJh8XybKorKYy9wupjQLndjf_uYNXOZnk1UqS_tT4Yg9gzf8X3Kn55Mt5bXfcFrHtyMoFZ4-A==@protonmail.internalid>
 <a4ebdf5c-8d4f-4994-afd9-22c8d889fe97@linaro.org>
 <4281887a-e7c0-43bc-9e72-96f0e432c58f@nxsw.ie>
 <f753f088-474b-41bb-82d3-6684bea2f87e@linaro.org>
 <85c1a702-1a3a-4145-8f2b-240d61d6e72a@linaro.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <85c1a702-1a3a-4145-8f2b-240d61d6e72a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 16:22, Bryan O'Donoghue wrote:
> On 15/07/2025 14:08, Vladimir Zapolskiy wrote:
>>>> It's quite easy, sensors are not connected to CSIDs. Moreover data flows
>>>> from any sensor can be processed on any CSID, there is no static
>>>> hardware
>>>> links, which are attempted to be introduced.
>>>
>>> This statement is not correct.
>>
>> Please elaborate, what statement above is not correct?
> 
> "static hardware links, which are attempted to be introduced"
> 
> No such static hardware link is being attempted to be introduced, that
> statement is incorrect or a misunderstanding of the intention.
> 
>>
>>> The port@ in CAMSS pertains to the camss-csiphy device not to the
>>> camss-csid device, so there is no hard link to any specific CSID in the
>>> dts scheme here.
>>
>> And here it's just a confirmation that my statement above is correct,
>> so please be consistent, and especially in any kind of accusations like
>> you've just given above.
> 
> Sorry Vlad I don't see much basis litigating this further.
> 
> I've been very clear, I think we should have standalone CSIPHYs, there's
> no reason to bury them inside of the CAMSS block - see CCI.

I've never insisted on embedded CSIPHY device tree nodes under CAMSS
device tree node, and I don't argue with it, it's kind of a red herring.

Can you please write this comment on the relevant series discussion?

https://lore.kernel.org/all/bed8c29c-1365-4005-aac7-1635a28295bf@linaro.org/

> There's a clear way to do endpoints established from sensor to consumer,
> there's no reason to give that data to the above CSIPHY driver, it has
> no "use case" for it.

Please don't ignore a different opinion shared by Konrad or me:

https://lore.kernel.org/linux-media/427548c0-b0e3-4462-a15e-bd7843f00c7f@oss.qualcomm.com/

It's unclear why this particular device tree properties are going to be
added into some different device tree node. Since somebody made an effort
to spot and discuss it, please share your brought effort as well.

Unfortunately your series does not look technically correct due to the
given reason, there should be a mitigation, and the defence in form of
"it's been done always this (presumably wrong) way and shall be continued
to be done this (presumably wrong) way" is barely acceptable.

> Its unfortunate we've done parallel work but, I'd ask you at this point

Reaching this point was not a coincidence, unfortunately.

> to rebase your multiple sensor work on the proposed CSIPHY series here
> and for drivers/phy.
> 

Please note that the technical discussion of this series has just started,
so there is little sense to rebase anything else on top of incomplete work.

The practice of "don't look, don't see" shall not be normalized among
Linux kernel maintainers.

-- 
Best wishes,
Vladimir

