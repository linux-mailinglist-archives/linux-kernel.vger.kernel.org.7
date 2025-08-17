Return-Path: <linux-kernel+bounces-772412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B095B2924F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 10:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F238819665DA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 08:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86409220F2C;
	Sun, 17 Aug 2025 08:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="SiZIK5pL"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF9A21D3CA
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 08:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755420156; cv=none; b=OXK76i+z+tKdhRL0XTS4UgU+nAd2OErS0ipPync7gDimZoUU717KlI6puy3RnOP/oqS6ast+HJLHvviLmwm/I7raCchJ1eNcQF/hSTIUpjZ28z4ZN4SGBTBzur/RSItEF2s183/5rmzHue2Lqo2zWHEvlWprqKxYJlIR60KYwis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755420156; c=relaxed/simple;
	bh=fBnf8WeAF0dOSwSjhG5XgLZ6fmTgeSi3O4YkmGSc76c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X0+/CVWOOH4cGIwtHWM5tzYNT+PTSMR6BQD64IQEnr9ehlAa3VuAdlnFfWdCctVgEKWYtWXO3e649EG6ZHxcAbWVGtfboBB7J2N7d59yCRdPlUQiJ23fWxvm44p4D8SJGIPSjdQ/jllgZScLLY5AG1/o1uQkaBDYEE+qq1HWSFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=SiZIK5pL; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so2735440b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 01:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1755420154; x=1756024954; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sfkmu36UsEhyXB4ryL2gMWCuVzsfK6S+k6i65pf0ysE=;
        b=SiZIK5pL890Y0nAYrpzUl/LXSjurKr0TjYOLlteczYFelQn8uxwsof+riCnTJP2fVK
         zxNUIt5gypSoslh/btFHlHq7oA2HJuV1uXZpzI/0jTGRFXG+pBvaxccRHtLHrXtNj+pp
         uB/byKpPHRNJ7sX51Ygx+bDcmLBxtUnn5bTZbPZWV2r4PmpL4m+J9gzKhaM4G5Vh2Dqj
         Wulc62RM/VBCjDFpwgc420ZtHFGjLMikNCPgNyXGl46PY/csQE2G8FmTSEHr5TkFlg+1
         5GONkl5ESo6cF//QAvSUnFNNvoW7TbB2VkhCz2Do+DPHWy3kAWaaUCmk0FTRHgIQrqr+
         PG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755420154; x=1756024954;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sfkmu36UsEhyXB4ryL2gMWCuVzsfK6S+k6i65pf0ysE=;
        b=UDsb5PdBRx0hfxl5yMNYTwCrTmN8p7yY59rrR7wwl8XHIAyKh/vWevxwSSTGq3NNAk
         w/SidoX5wEQjUIB5XXHsXejS/6DFFb1Hgym7kkIYL7ll4Yr90F8BoqgTINUReF6rXY0c
         k2Ywc97OCDld7UkdoVm4xjOezTnKI/23LqcuLpCOMoLpTk86+zkGAvlQzlfsMX33e6Dy
         GIKshT+DTODgSt8k/sFwIf7go8RZBnEJQPN+8Bt6GlnsJvKtT7OD4pZdbiyKd2yQMjko
         cBPqRhxFsR/kaG95MuOSij0sDpjNaY9xUAnlsmRTS0iLuJnTTtwJD5F3W71/nCO8zK7G
         jI8A==
X-Forwarded-Encrypted: i=1; AJvYcCX+I4X9ZTOhJMSLSFwZVFzOoaV9IbsqrI5w9SoYhDuegNgrRQuXBeW+xVRB3juWP98Mfh5PcJRdOaH+sZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVuav6E4fBER+Yz1XTm2zvvQlaUfKCVmaBFwrBGdCwWGAOl4jm
	0Bk+0wsYNy8fgB7YoEcu1wXAFLbaRHHcJDh+2H0LPP3idWy5gQoUiXI+sEHy/AY2Bw==
X-Gm-Gg: ASbGncsdU5ODtUVD9JQentCkVz+tgsLNap5ibnNGaIgkz4TjVJ3zUQfWgM9XbIrqhFG
	KKhloxlPBOArtwqCFSZ4ezgI6pn4B1BbkOw3QwXN9X0xj0QO3HkN4B9VE5IiNqbnwSquMqticB1
	eVi3ufh27B11IiH8ODByRKpdzaHR3h8H8rre8qsdXSoZEgHyV8kENoL2Gk/40JZlE9pu2g9hDbQ
	UyzV/dohU3JKY/eZvjdUeRfsZ5jyZduuJ8ai9gZ3Ubx1+aWfSRmd0FFY+vFSafnDFrc9D0nbJjf
	E3MGKRnP3w3ZiDMODbS+CUChon/VXEK4fx25+TGg9PfgT5XHxrd9IwIM96AF7EBLvGdWXWsDqPu
	N8jDoPUC4vsLABy18I/x9A6Jh8w/ELGpJDv38amQ9OK4ydr2+J0pzSVOf1LlPSTwdW1fpMNxF7L
	k=
X-Google-Smtp-Source: AGHT+IEj5yKW7F8ws4E5YLdOfdAEX6KIo50dsAXx+hxN+8hXkqsDFHeQl00YGG+6keeJrWj42pTIZQ==
X-Received: by 2002:a05:6a00:4a0b:b0:76b:fdac:d884 with SMTP id d2e1a72fcca58-76e321f6064mr12072837b3a.3.1755420154608;
        Sun, 17 Aug 2025 01:42:34 -0700 (PDT)
Received: from ?IPV6:2401:4900:8898:f586:e00d:52f9:31de:96d4? ([2401:4900:8898:f586:e00d:52f9:31de:96d4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e45566937sm4719641b3a.70.2025.08.17.01.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 01:42:34 -0700 (PDT)
Message-ID: <1884651f-5192-4fd4-9d94-ed755ea89570@beagleboard.org>
Date: Sun, 17 Aug 2025 14:12:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] dt-bindings: Add support for export-symbols node
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Herve Codina <herve.codina@bootlin.com>,
 David Gibson <david@gibson.dropbear.id.au>, Rob Herring <robh@kernel.org>
Cc: Andrew Davis <afd@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
 devicetree-compiler@vger.kernel.org, linux-kernel@vger.kernel.org,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20250430125154.195498-1-herve.codina@bootlin.com>
 <20250430125154.195498-2-herve.codina@bootlin.com>
 <0770a47e-fd2f-4b6f-9a9a-b0d539ace30c@kernel.org>
 <20250528185740.4bf91bef@bootlin.com>
 <49e1e1fc-412d-4334-8337-16e352a34788@kernel.org>
 <20250618113232.6d237208@bootlin.com>
 <ed6beb97-12f1-4d71-b4dc-b34d4d611b81@beagleboard.org>
 <3ff4b3f9-cc8d-4044-b2eb-33010d8951c0@kernel.org>
 <3889e19e-7f1e-4306-9e11-77a61432b402@beagleboard.org>
 <f3184805-3617-4b46-be23-70cebcf27207@kernel.org>
Content-Language: en-US
From: Ayush Singh <ayush@beagleboard.org>
In-Reply-To: <f3184805-3617-4b46-be23-70cebcf27207@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/17/25 13:52, Krzysztof Kozlowski wrote:

> On 17/08/2025 10:18, Ayush Singh wrote:
>>>>> Hardware:
>>>>>      i2c0 from SoC --------- connector 1, I2C A signals
>>>>>      i2c1 from SoC --------- connector 1, I2C B signals
>>>>>
>>>>>      connector1 {
>>>>>          export-symbols {
>>>>> 	  i2c_a = <&i2c0>;
>>>>> 	  i2c_b = <&i2c1>;
>>>>>          };
>>>>>      };
>>>>>
>>>>> In order to avoid the coding style issue, this could be replace
>>>>> with:
>>>>>     connector1 {
>>>>>          export-symbols {
>>>>> 	  symbol-names = "i2c_a", "i2c_b";
>>>>> 	  symbols = <&i2c0>, <&i2c1>;
>>>>>          };
>>>>>      };
>>>>>
>>>>> Krzysztof, Rob, do you think this could be accepted ?
>>>>>
>>>>> Ayush, David, do you thing this could be easily implemented in fdtoverlay ?
>>>>>
>>>>> Best regards,
>>>>> Hervé
>>>>>
>>>> Well, it is possible.
>>>>
>>>> However, on connectors like pb2 header, there will be 50-100 export
>>>> symbols. So it will start becoming difficult to maintain.
>>> And the first syntax solves this how? I don't see the practical difference.
>>
>> Well, I was more worried about matching which phandle belongs to which
>> symbol easily. Let us assume that 2 symbols will be in each line (after
>> accounting for the indention and 80 char limit) and we have 70 symbols,
>> so 35 lines. To check which phandle belongs to the 2nd symbol on line
>> 25th line of  symbol-names, well, you would at the best case need to
>> have something like relative line numbers in your editor. Then you know
>> that the 35th line from the current one is where you need to look.
>>
>> In the current syntax, the symbol name and phandle are on the same line.
>> So well, easy to see which symbols refers to which phandle.
> OK, that's valid point. Any ideas how to solve it without introducing
> underscores for properties?
>
> Best regards,
> Krzysztof


Well, we can modify `get_phandle_from_symbols_node` to allow matching 
`*_*` to `*-*`. And we can do the same in devicetree easily enough. Not 
sure if implicit loose matching like that are the best idea.

Zephyr does something similar for compatible strings. It pretty much 
replaces the all non alphanumeric characters with `_` in compatible 
string match. Although that is more to do with the limitation they are 
working with, i.e. the devicetree being converted to static headers 
instead of being runtime thing.

Best Regards,

Ayush Singh


