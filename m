Return-Path: <linux-kernel+bounces-813105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E89B540C1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 05:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72F145A6498
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 03:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B6B23497B;
	Fri, 12 Sep 2025 03:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIlixAeu"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19EF3597B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757646560; cv=none; b=YUvBMSbJEXCZunH8sL9FJ7PICShIUX0TJVnsUsG4Cuks+ASw04WX0wWfpiSdk/QB4DBmeL5kyEkzpgNax7x0bg93tKqKJmIHcNnAUnd0RH3jZr9EWRkrw9uBOrGIMoLrWr8yRJFx53J2Su5KBrMn71LlNatVd1FmGdOkRp7nois=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757646560; c=relaxed/simple;
	bh=yUI8GG7e0bDczXxnxpCR8zbI++EUhyVr0r5RE8qR0cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=khbO4khseo4QbmdM6mppdpEUiWpHEOl/ebEJCHGGA/U3/Pav+TZvmS+HhgarY37Pln746/FAherLZqCFNF1PFEOl2PCEpDAXYo6IB1x906RNXLpIZvRGDTkMBN+HindYPwjolRwJMXmzIoBnVX3XhcIMV8KNDIC/wSVoBKi3Hvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIlixAeu; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b523af71683so1184620a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 20:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757646557; x=1758251357; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4geV6ob0qK97VAn3WsxVaPTEAoOywPWCevip8ujLoJY=;
        b=SIlixAeu+drVEKEsaFUNQFZjUHEkqo248Dz361wmfBKrxlNg9sMVpCWfGDYkL1B6GX
         pLwxqibpe7TXiVvieAp8eCAS76LNRSbnkbS3tXmcicXlNl3XmU+xyV3ASBxXyXZsCUO4
         SQrC6rGaU98KsQuRkY8rQZSo4CVZ++3RJgquMzJAQMBcaJtGFAR64Rg99iIz+2IqMQn/
         XE2VG6x8HIfxyVSTFYhjCZEpRGPb9lG5cnGA8A5O1/e7+5qmj7np1mAqE1wV/Rs4bKx/
         ZV6B7eOuVNUsVS+dmh67xV9TI3wq69zyhPWC6S8y8Qqfc51dN6nh+Cgtg2QPjqfNqGa6
         ZlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757646557; x=1758251357;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4geV6ob0qK97VAn3WsxVaPTEAoOywPWCevip8ujLoJY=;
        b=HEY3Ta6kCVx9pJlHKya1GTs3UrggyEPnIkJGWDr1QISzRCTJqyJ8vPqu+FSCKRjvxY
         8RfQOWmHKrEZt5JR3lvuQluT0Enc1/TF9jRN+oK9fGr2KBwC6khXY2ximWUVqNtdRyN6
         K1hs7QwQtb5aM6PYudcLtwFsVYV0GM2CpAudcUmEUbNXKCF2e8zqzMp32lf7mOA24Gc0
         GW3Bmx+4QU7CyeASFbn45pkm/ri00Qc/+43FNr9ZQPkE7BlIUo+sWpk9GmFaPgxOJ+AN
         EotgQaJcjnyGa3CFXBSzBUhyVRyrIyObFB7Q5vXYpPOQYGQZG4dSpaVS5uXtEcnG8GR3
         MTTw==
X-Forwarded-Encrypted: i=1; AJvYcCVg+HYGE5RtYV6nsNPisA5mN+u3GORavzYl7bHHb26n8BZOV7VJlnz4dBkKFc5LDLJk8D8bEOm8dXsAZZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuI2n8zuVnjyAfmaNz2j9HQCBvBnXuepQNZO2B47OMXy/gC/op
	hxn5wNkrxo2G2JczYUt7ktpwvotRFB7ui69RUhG9z1ji8yA9dokjvlB9
X-Gm-Gg: ASbGnctpXhOb1eGg5q6RYyut9vQZdbOtsCpjLIkQwo38/CBmuYookvOce/rQvFJ38TA
	HI+ERri8YM4Z1/Ma5oCPf75RpWZL6ihflld4oAn8YCQHpc8ZpzERDXJdv/DAG6HJDtnVFJ9ZUMv
	I4rdPe7AS3M504SHp/gHbXQ3KHKp4cKvEDqmPWxI3tlFGhlCNp5BEony49oWHdBLHNAdhKpbrdR
	6aKnqXMaGCQOLjcPM7sxtSvhm82ZB+g1NjG297kH0aOaUv5q05OPoaQ1F4ptlV7UIjz1aPK1OEy
	eY+ovNIwxwGlFV4X01SsCQ8whYsemandIm9pTcSa5zBRr3u9rTpRlFnOKTUnx9BPyeRXO/aRGR7
	PUIxewM5ZbOt1ZVZC5en4nlnLvSSwcRJF+6qq4LRIagrPKSVTG1xuNbhtyL2QE21j
X-Google-Smtp-Source: AGHT+IEH+vFRZxmRvPbolGqsR10fXq1V0MB5GrQMkOUwmu9MOHsXS68HiXErC9Ttiqo9utBGOkT7QA==
X-Received: by 2002:a17:903:2c6:b0:24b:bbf2:4791 with SMTP id d9443c01a7336-25d2646f828mr19572755ad.39.1757646557076;
        Thu, 11 Sep 2025 20:09:17 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b305427sm32849755ad.138.2025.09.11.20.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 20:09:15 -0700 (PDT)
Message-ID: <3b1815e9-b17f-430f-b18b-641f99d9f093@gmail.com>
Date: Thu, 11 Sep 2025 20:09:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] dt-bindings: net: Drop duplicate
 brcm,bcm7445-switch-v4.0.txt
To: Jakub Kicinski <kuba@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250909142339.3219200-2-robh@kernel.org>
 <20250911184329.2992ad3a@kernel.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250911184329.2992ad3a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/11/2025 6:43 PM, Jakub Kicinski wrote:
> On Tue,  9 Sep 2025 09:23:38 -0500 Rob Herring (Arm) wrote:
>> The brcm,bcm7445-switch-v4.0.txt binding is already covered by
>> dsa/brcm,sf2.yaml. The listed deprecated properties aren't used anywhere
>> either.
>>
>> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


