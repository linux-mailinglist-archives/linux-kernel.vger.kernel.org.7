Return-Path: <linux-kernel+bounces-774179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31407B2AF90
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E222A0C1F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70264204F8C;
	Mon, 18 Aug 2025 17:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="MiilwakU"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496DF2773C7
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 17:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755538686; cv=none; b=nHqVB1GrEIpvRtvHH2xGPQgFLi8FtMevcJ6WEYxR57YchEOj+m7PN5Nt23C3ppEm5wfS8ezR3qMfA4Tt1NjNGWzL6JsUcckvZgjTzumtE+ZAZn1OX1Og+vp94Zuh/FxKdYRZmDc7/5hS3TL0GjlZvyh9pTqd1rDRoveeBfW5t5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755538686; c=relaxed/simple;
	bh=KpndLTPj+1ibla1979UwuPwKaedBmG3tKximGyaNpgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J3iZy3N6VO5RlsHiXxqpyZlqkECcUjpZ1NUjiRfVb4Edn+Vjmno/Xzj5CqI8aqwS/oisHggP6u0Vsf3vIPk+vKO2aMq0NG9bU16B1fiSWlrf3RNmW6YpnJrOHJGOf/0pq/STHx3JMi695057j6a/R18FoiCPt3UmeTS4vBW5ODY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=MiilwakU; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e2ea887f6so3295846b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 10:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1755538684; x=1756143484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/vks8XXxfstdatM1G//bwUHh/WZjAyNbpmzcLDcM9lM=;
        b=MiilwakUfDxFTtpD/aA9IKsbbN+wG/vZZXwg25r1lcdmunKnIRo4C0DPpKP2A/4BuY
         CJrsJBucXBzK7dtHrN43GBJlYJhAzzoLNbfZY/6QXbqnJ1WcjIg1iYJIQPhpN/qmXF5V
         h+1K5HpnPzjc8uhE3k8BoOtywE58ii83thgyB1vI4TufTZCp/IpfXlQRWOKomaiuSTuB
         FXjjgoP3RgsouUKH9awECzQ15ithq7uiA7eS1F/B9lgaGcNkfQ0Se2w9dDRbVfeIIEVs
         ih8mkxoa+qkkQ5JxFzGbewrKkaLAtq52NSseGlp2Y7sOqq4JkhRhi2pa+uGTJjCrL+RE
         QPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755538684; x=1756143484;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vks8XXxfstdatM1G//bwUHh/WZjAyNbpmzcLDcM9lM=;
        b=C8CFATsmViswwYa3ajkHvf6CTHimalF5rEBWZ0RvF0+OxVJHlJfCIE1s4FOzdgBRke
         OnK/o0cOu5cnmG31pKxcpTGzWcx3rcpzKhagHAYmtLDxHkYPJPaznusQeZqW3gvW/yvt
         RJaY/VeTYaTKylkqfBIpYA1QBPrXySwCxrmjn6VohKGFG9HbVZoyEOuKMwtmFlyKhJRb
         96HD85UrOyX88QuzACgsAKjxApSr4irPsSAKvArgFN47LzIH7TRIxa+loVETRgq8kp23
         sxCbuHqDzigVwuvL6zNCxxYcyjGzG13UozbsTxUw4WNTZ4MSnOEhnuYgwMfJxb54r5jc
         qWIA==
X-Forwarded-Encrypted: i=1; AJvYcCWXQz48HZG2ifu/fXLbOC/ahNkmKrk+1k0v3UjFOp7UpjnzPSGOitetR8t8da909Rypad8okJvj31JNjh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK6gIZUwjyzfJDDV7zw37TWyfAqnTaI2PxqTbP+ibNfXYr7gub
	tSqSLH5jKi4E7JJIPK+OFD/6KtbJQMqWV+i9ohctzDenf899AFez+aOL6VFZKFpvoQ==
X-Gm-Gg: ASbGnctaiBzb2eCUu/VAJpl5+GP5QXHIhmo+2TbFlorb2LfcehT8ghKE955NX5oN8Vl
	J6iknOxgsWZ+ISRPfAVczNN63X2XaN1zZBGCG/1tXqyA1MQ2I20FAtcTJqshjxrkTyTb9eaetFp
	8pkDBDj9oncXEORsl6bDnEEGDPfNNKQ8sXq/p3AYPuF037ZsMUrtSYbcmXyyVXS8Q9hlMaGak3c
	2ymQftLoH3X2AJ51zswCt3LSbT9937L+c67W+YsMaq9vxaVNVhATaapRFVLyyQl5my0WYQfjMay
	anHxt+80ByATwcuqyOtmtjuNhtJUZsiV+Hwy854QrBpRaYtI8LMuMj4mNtggOcWv2oZ3WVYXyT5
	MarZ/0UHewkFxtLpxJ604IVl2S2LjyWQgvQk5KgCa1oktrs1MVMvYnyRQjRbrjPwejWTO9DIxDq
	5MBdVTBRncmQ==
X-Google-Smtp-Source: AGHT+IGt2rzHm2c0yWIZfG5qpn8ST+FNzx/C4GRx6g1QL0yfMmPxs4J/lKbLdTxxP/1fn9fDEgJ/Dw==
X-Received: by 2002:a05:6a20:7fa0:b0:240:16ef:ec16 with SMTP id adf61e73a8af0-240d3039127mr20868377637.46.1755538684535;
        Mon, 18 Aug 2025 10:38:04 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f3e:5044:d00f:fc7a:cce6:b4df? ([2401:4900:1f3e:5044:d00f:fc7a:cce6:b4df])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7f0b4e6esm32440b3a.78.2025.08.18.10.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 10:38:04 -0700 (PDT)
Message-ID: <ef7720ae-bada-4133-a685-d277cd4aa7e6@beagleboard.org>
Date: Mon, 18 Aug 2025 23:07:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] dt-bindings: Add support for export-symbols node
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Herve Codina <herve.codina@bootlin.com>,
 David Gibson <david@gibson.dropbear.id.au>, Andrew Davis <afd@ti.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
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
 <1884651f-5192-4fd4-9d94-ed755ea89570@beagleboard.org>
 <CAL_JsqLSB=6FduyOE_JNRdy=Uf6dLOcHV-O4qa8psjCobJPaAQ@mail.gmail.com>
Content-Language: en-US
From: Ayush Singh <ayush@beagleboard.org>
In-Reply-To: <CAL_JsqLSB=6FduyOE_JNRdy=Uf6dLOcHV-O4qa8psjCobJPaAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/18/25 22:35, Rob Herring wrote:
> On Sun, Aug 17, 2025 at 3:42 AM Ayush Singh <ayush@beagleboard.org> wrote:
>> On 8/17/25 13:52, Krzysztof Kozlowski wrote:
>>
>>> On 17/08/2025 10:18, Ayush Singh wrote:
>>>>>>> Hardware:
>>>>>>>       i2c0 from SoC --------- connector 1, I2C A signals
>>>>>>>       i2c1 from SoC --------- connector 1, I2C B signals
>>>>>>>
>>>>>>>       connector1 {
>>>>>>>           export-symbols {
>>>>>>>      i2c_a = <&i2c0>;
>>>>>>>      i2c_b = <&i2c1>;
>>>>>>>           };
>>>>>>>       };
>>>>>>>
>>>>>>> In order to avoid the coding style issue, this could be replace
>>>>>>> with:
>>>>>>>      connector1 {
>>>>>>>           export-symbols {
>>>>>>>      symbol-names = "i2c_a", "i2c_b";
>>>>>>>      symbols = <&i2c0>, <&i2c1>;
>>>>>>>           };
>>>>>>>       };
>>>>>>>
>>>>>>> Krzysztof, Rob, do you think this could be accepted ?
>>>>>>>
>>>>>>> Ayush, David, do you thing this could be easily implemented in fdtoverlay ?
>>>>>>>
>>>>>>> Best regards,
>>>>>>> Hervé
>>>>>>>
>>>>>> Well, it is possible.
>>>>>>
>>>>>> However, on connectors like pb2 header, there will be 50-100 export
>>>>>> symbols. So it will start becoming difficult to maintain.
>>>>> And the first syntax solves this how? I don't see the practical difference.
>>>> Well, I was more worried about matching which phandle belongs to which
>>>> symbol easily. Let us assume that 2 symbols will be in each line (after
>>>> accounting for the indention and 80 char limit) and we have 70 symbols,
>>>> so 35 lines. To check which phandle belongs to the 2nd symbol on line
>>>> 25th line of  symbol-names, well, you would at the best case need to
>>>> have something like relative line numbers in your editor. Then you know
>>>> that the 35th line from the current one is where you need to look.
>>>>
>>>> In the current syntax, the symbol name and phandle are on the same line.
>>>> So well, easy to see which symbols refers to which phandle.
>>> OK, that's valid point. Any ideas how to solve it without introducing
>>> underscores for properties?
>>>
>>> Best regards,
>>> Krzysztof
>>
>> Well, we can modify `get_phandle_from_symbols_node` to allow matching
>> `*_*` to `*-*`. And we can do the same in devicetree easily enough. Not
>> sure if implicit loose matching like that are the best idea.
>>
>> Zephyr does something similar for compatible strings. It pretty much
>> replaces the all non alphanumeric characters with `_` in compatible
>> string match. Although that is more to do with the limitation they are
>> working with, i.e. the devicetree being converted to static headers
>> instead of being runtime thing.
> This is just going from bad to worse... If there's a real need to use
> underscores, then use underscores. But that's all beside the point. I
> didn't like v1 and nothing has changed in v2 to change that.
>
> This looks like continuing down the path of working around DTB format
> limitations like DT overlays originally did (which both David (IIRC)
> and I think was a mistake). But now instead of somewhat hidden,
> generated data, you're adding manually written/maintained data. I
> don't have any suggestion currently how to avoid that other than we
> need to rev the DTB format which no one really wants to hear. Maybe
> there's some other solution, but I don't have one ATM.
>
> Rob

Well, if anyone decides to do a v2 of DTB, I would love to help in any 
way I can.


Best Regards,

Ayush Singh


