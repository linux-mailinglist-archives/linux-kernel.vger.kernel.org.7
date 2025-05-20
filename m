Return-Path: <linux-kernel+bounces-655176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF82BABD1F4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 10:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 789DA166D28
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 08:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC34262FD1;
	Tue, 20 May 2025 08:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GR4JVh7u"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAA725FA2E
	for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 08:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747729822; cv=none; b=PCsXQ766IdsbbFpiTHw9z42TT7Q2gxH/ayCEKGkzkhDksPCVEE5Kmh4L110SFr4IVEWTzRiRg8fVw3x57JeoDrAl+Vt5ju9vBqj0S89NVVlZesYPveLEjkEQqR/tOqLvImG+9/TCOM0nvXNY2IFHXmhY7xoTYsbXh/HHjlHbjk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747729822; c=relaxed/simple;
	bh=FBtZF9jVH1cLvcUutv6TgRxOQZAdeUAu1xny1x9NmUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C1OHAEXKEPteu9RnBOiByVczA6to6qZ6DbBbYTARCoNBWpOsmPoCZK+HYY4jR9M0HIMG9euLYyA2+A34vc/B7tj0B+QFQH/swHg57ziHJpKEt3Q6c+mmIDxPlshrwtZp2SUhv8rtncTPUmnF6KGP0lx9v8m9oZiYHtdfkYBDe9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GR4JVh7u; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-600454d4798so780667a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 01:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747729819; x=1748334619; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EbNeWxcAASYs4L2Op/2GYcpTSnZoXJiFN9U9PyXqbjU=;
        b=GR4JVh7u2N/7BNFX7EjbV4zpp3duAxLadd4lVhAwHTw5f93LXwYtV3eWjYaRaONjp/
         ihltobN85pSY7siHyovFcxaAmwEg87Gw05xUPiMT4hbFyT1R0naR/2aZOZWos48BKyZp
         obaymYfguVzE0f3MRwSIVZjhICE2qzAEXuu9K6Ws7oSUn4GkquHnM8+8sCWfwwxt1BSn
         xcj9QTOzgs/6kehH3p0gw/1kY1gTtY/pdBNvlCRfQyrj5zfwe8mssE6NjxkkRdqC4BhV
         j6z+IXCs++UzH5IRChj/qqDsTVy/yCKrhjB4Ol2p8CqSwAhPRgFtXqKCa57i5dT+pWSZ
         iuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747729819; x=1748334619;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EbNeWxcAASYs4L2Op/2GYcpTSnZoXJiFN9U9PyXqbjU=;
        b=rpRaK/ubZWfXUBGcKwswz3c7RXHgrDsvR9tJqG8ADWneKzKcnrH7pvrbA1Lg56zFvU
         kSzH+ia7DCKg5nKFp8nPCYFF8V7q3AUFd0K5nklUdILDIDf/9E2RQcjDsrQaaD0j//rR
         Bv5Z8lnH5TPy3kwJuBv759+W3Bu6K/dzWhcZSmI7bxUfdWTZLs9jke7nTb6P+3E451Go
         u3ZMsY9DVRNmhOiNl4KNx0lbEcA8i8EZl9Ck+92Dy3AaQm42blZNmcP9jLOaoZdF7E3Q
         rX/nlAatyMdGYw9Z/ak4hLPczWfD/jUseNOu/z5d9doLV/N6YK34myje3Mqlq8+PSt/p
         gR4w==
X-Forwarded-Encrypted: i=1; AJvYcCXCoVQ1YiP8zeYutZKNfZmABK/65bijg0ufYzeIfgyi3sCTK6Bl6Bw+vpw746eE2bNIv2muvkPzHQ+AWyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIUBqleKbbhnsYTFAsii3NGMUEmeHQfGB+v0u9hlmjXF0XVdMo
	OkfbLigqpGZGEWWzEInjSt4wLzK/zCYSL2YKoiW0drG1i7U3+8Az2DIi/6/8XMKx/hM=
X-Gm-Gg: ASbGncu7c/tz039M/X+KJTrbBf7/EjJ+WZut/jp7Ng4totqU5gZrQNYJt6h0CjZBcda
	Ug3Wd/LzqxvzktkxjeGOAy2YNk92ZlCf8DJW1Q+NtcnA5I4Nq7WBqpVkyDgR3BHmJ4BqEyWNpdH
	YNwQVcQksdPkZdLgHEFjarQLSdeFQoKUP5i4jpY9cvE2QYWMtNpdUF9YtvVjQPOJ9PHxQgjlKhx
	J6g4jEbFIC/PjlfDMjzpXWD9BiENRGTMx2eiTVjjdv5E9NwnEJR31cDbnvxBi8k60hmyniGpe2W
	KbuXlvCgkFnG60S4odAVWWw6nyHWXCTd2ts9HSyAejnVKD690IWQTonWnJ4UlU+Jehi3mpQ=
X-Google-Smtp-Source: AGHT+IGbTTAyNzM8t/l4OfMQpoZarteMKfq/B2ggr/f8oWCk3Z06e4bleQoHdLjJ70VB+ZvqZrxhtw==
X-Received: by 2002:a17:907:2713:b0:ad2:292d:6b9b with SMTP id a640c23a62f3a-ad52d50f06fmr496326966b.9.1747729818882;
        Tue, 20 May 2025 01:30:18 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d06b497sm690272366b.42.2025.05.20.01.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 01:30:18 -0700 (PDT)
Message-ID: <8a2f2269-d07f-42b2-ab6c-dcff30a1f431@linaro.org>
Date: Tue, 20 May 2025 10:30:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] media: qcom: camss: vfe: Stop spamming logs with
 version
To: Johan Hovold <johan@kernel.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250429180828.950219-4-krzysztof.kozlowski@linaro.org>
 <aBHQejn_ksLyyUm1@hovoldconsulting.com>
 <3e34ce09-1207-4dba-bff8-38c01cad9b78@linaro.org>
 <4d942a6c-cbff-41ac-af8b-12a1ff5181aa@linaro.org>
 <883eb54a-fcaf-443c-a4d7-e1278fd43f5a@linaro.org>
 <ea9f570c-b135-4a98-91ea-ceeb2f48a0e5@linaro.org>
 <aCw09Vci12txhYj-@hovoldconsulting.com>
 <190100e7-8a59-4cf3-8434-bcb6292cacb2@linaro.org>
 <aCw78CRda6VS6ost@hovoldconsulting.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <aCw78CRda6VS6ost@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/05/2025 10:23, Johan Hovold wrote:
> On Tue, May 20, 2025 at 10:02:32AM +0200, Krzysztof Kozlowski wrote:
>> On 20/05/2025 09:53, Johan Hovold wrote:
> 
>>> Spamming the logs as the driver currently does is clearly broken and
>>> should be fixed. Keeping a hw version dev_dbg() is generally perfectly
>>> fine, though.
> 
>> My main argument, expressed in the commit msg to which no one objected,
>> is that this debug is 100% useless: deducible from the compatible,
>> always known upfront, always the same.
> 
> To me that deduction does not seem straightforward, at least not without
> access to internal qualcomm docs, for example:
> 
> 	compatible = "qcom,sc8280xp-camss";
> 
>         qcom-camss ac5a000.camss: VFE:0 HW Version = 1.2.2
> 	qcom-camss ac5a000.camss: VFE:1 HW Version = 1.2.2
>         qcom-camss ac5a000.camss: VFE:2 HW Version = 1.2.2
>         qcom-camss ac5a000.camss: VFE:3 HW Version = 1.2.2
>         qcom-camss ac5a000.camss: VFE:4 HW Version = 1.3.0
>         qcom-camss ac5a000.camss: VFE:5 HW Version = 1.3.0
>         qcom-camss ac5a000.camss: VFE:6 HW Version = 1.3.0
>         qcom-camss ac5a000.camss: VFE:7 HW Version = 1.3.0
> 

I understand that deduction is not straightforward, but it is also a
fixed one, meaning it will be always sc8280xp -> (vFOO, vBAR), thus the
only usefulness of above is to map each compatible to pair of two HW
versions. This can be done via debugfs interface once and stored in
public docs. No need to do that mapping every time driver probes and my
patches drop nice chunk of code, including indirect function calls.

At least so far no one objected that same compatible maps to same pairs
of HW versions.

> Whether the hw version is actually useful to anyone debugging this
> driver I can't say, but keeping it printed *once* seems perfectly
> alright if someone wants to keep it (e.g. as we have a long history of
> working around hw bugs based on revision information like this).

Now if you claim that one needs access to qcom docs to deduce it, I
claim this version would be useful only to qcom people (or
qcom-NDA-access-to-HPG) folks.


Best regards,
Krzysztof

