Return-Path: <linux-kernel+bounces-859825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC5ABEEB1C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 20:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09D624E1838
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 18:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC87E1DE4F1;
	Sun, 19 Oct 2025 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUknOd7X"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66A4DDC5
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 18:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760896979; cv=none; b=KMk7WX+D83QL8i6KJW7C1Y3YA2PPxNvYCrUS6ehc7FFc4dpRYcdzAgDyXgCfiaUQikGzQFO3Ojm5kUfl9UjiUnIXbo3+8xipR5lDfpX4LxGEON1IglFWEvM7vD2Z5Si+JctBNitaK337hAoqiwHQSgHWH+wNx7rm3U5MVH9xAGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760896979; c=relaxed/simple;
	bh=ozSDolhQJbmAO0s86Z0yWay1zEiXGX3RFZK3utoLfb0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jFGTMOxYQhxwGt7rT0EawK+FLpNRE/hCaretjCGHxL/py66qP0eOrGAmGo0qeBMRuJ41QUXqM+rp2UORJcipEE8sWMwhoNTpp85fMvz++LSASsVksvlWJxNsXppIQ9Jo00dRUnbXk11dJaomUvM/brEgQXc7bDtFhU/HHlDdLEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUknOd7X; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27ee41e074dso42959295ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 11:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760896977; x=1761501777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1jrt0Ie8BNhXfzYDP08LLmDw/YXiUEA5EJwaGmcebmY=;
        b=BUknOd7XTxdZaeRCWEKWYNUGsP5lsprz/Zw5NWhEjR5AwOuSkPRFnn9ILeZKXypdbM
         BhW7lk/nPo/p+/xiOmq6l2ZPH2x8VV79qI8s6JdnwCZzpFRswnycX2MTi3w2cq0VhqO0
         x/QmU18cBHAwN9ksP5tcEQgJ/HBI+FIDS/tplCdAOFxM4JHcMNIHeyZzkJ2DSiylg5UD
         l+6C7bincyvBfDrCjkadt/a6BqI6+AQhXEWDFSz8NsO4SHU/UAvLzW2kP8xaOWluGSG8
         zjznJXXCF2qn2+5jy4TcHegUGbyM7ZdEqr2GBFVwz0SH+j4NiV4T25xkcmvFyqt8OcwV
         7XWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760896977; x=1761501777;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1jrt0Ie8BNhXfzYDP08LLmDw/YXiUEA5EJwaGmcebmY=;
        b=gf6qQvZSQeq9MPHVzQZf1NZJ5HCXcuuqwQ/eTBIAwgsNmzA68Ez2sdwOyBQ+ltvaXG
         lcbOSuC9vD1JVgtivyDEFK6wxsF/LL1Ix/Ru5tmUcyTPy35WElFHxwx9W1z7hoLbfC2l
         2saTbojL0joQlXKb1hdGQfYUKaMqFx5Q6mTRTLKGrdUJ/LiuA01SsOK+zgw5B9HxEs16
         /8zUhsh0XcDySBOs192ikBljZz75OD0W0i/CEPx52NFtompeNR4FWwr0THGgRi4xV7Wp
         PBAyoKnDLw4qgaZi7aVlv+M8dVI/QVyGjxXfY4LfUw9Siy2mxs7RBBN5C43vgwcbg6ei
         a/gQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS2f1TbibVzlbJFvdF8jVDBSp8WjkEslO6Zc9jtMX0mNs6UwAj+X9ZN1znVCzE8NjNJsLnvvWrVMQRdow=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbknfHeFqJuXl9g0VEb5maGr6eEWaV+s3Y5E/wlGf2KGJx5uIt
	h9V7cg+bkaYLNN1AVwDDlWxTCuin+fCHZo6t4h0MxQ/rhsxdp1VbIMfHca3B3MoFMnfPTe7C
X-Gm-Gg: ASbGncsoqfr5EgP8RfdsVFL6ceJ/hYZMiZo8rHcR1MOlmWpQ/U+ku+c9TevyqlqPPn4
	GBApmzcngyioSGLt60ky2yg1GzVVgJBve7x8m6tFNtaRAgjl+bUxzaQbT/o3DKKzjjcQ095og8l
	0zHelAGB6HW6O/XzbW00R0wzwyRt+ZaGdDEX50A3uFS7DMSGXA0laDiKXeSxd08SP6xuYK8iYfp
	OAZcQ4WX1r0o+yZevgbWbb2uqB5NNlfQmwi3gSapwdwuIY2sPiP8SX24CkI8FF5fNzRPJXPJFJe
	UdPxeG084rUAUjtFquGe6zF+bWjY/gw9cCTE3zJ3qdAHNP78oTBaugXwB2NvCufwnZUKUGk8OlJ
	IQbw+YvTc78oB0NtaIFBFglNQfExqKLA9ednY8U++fTqpk4NvZmAKGriUL2RXliR5dmkgaeRZJV
	IyGS6tcnpRDK0vMZGUmbiHDNHxDiOu1ZtV49Q=
X-Google-Smtp-Source: AGHT+IFFVOrJIsToyN6vZFiYBBVpU1/9unKfzO//ZkozLWMRDFrgw63b2i56h1Yz6kWx6og3vSaNSQ==
X-Received: by 2002:a17:902:cf0b:b0:246:7a43:3f66 with SMTP id d9443c01a7336-290c9c89336mr146423865ad.7.1760896976935;
        Sun, 19 Oct 2025 11:02:56 -0700 (PDT)
Received: from [192.168.21.161] ([50.236.66.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292a8c8e231sm4099675ad.36.2025.10.19.11.02.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 11:02:56 -0700 (PDT)
Message-ID: <eb655eb8-4f24-409d-9560-be980637ca66@gmail.com>
Date: Sun, 19 Oct 2025 15:02:54 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 1/2] dt-bindings: iio: adc: add max14001
From: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Kim Seer Paller <kimseer.paller@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>,
 Jonathan Santos <Jonathan.Santos@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>
References: <830368e5bc303faf04f542268acb95e99d0d1cde.1760502331.git.marilene.agarcia@gmail.com>
 <aPGeCMiLSB9-A7t_@debian-BULLSEYE-live-builder-AMD64>
 <8c1a533a-2c39-41a9-a007-f64cefe30e35@gmail.com>
Content-Language: en-US
In-Reply-To: <8c1a533a-2c39-41a9-a007-f64cefe30e35@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>> Co-developed-by: Kim Seer Paller <kimseer.paller@analog.com>
>>> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
>>> Signed-off-by: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
>>> ---
>> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
>>
>> Since you've dropped the ADC node label, I think you could have picked up
>> Conor's review tag from v12.
>>
>> If nothing else comes up, you won't need to send a v14 as Jonathan 
>> will probably
>> pick the latest tags when applying the patches.
>>
>> Cheers,
>> Marcelo
> 
> I agree, I forgot to pick up Conor's review tag. Sorry about that.
> Okay, thank you.
> 
> Best regards,
> Marilene


Hello maintainers,

Just checking, is there any other action I should take on my end
regarding this patch series?
Jonathan, I forgot to add the following tag in v13, so I was wondering
if you could please include it when applying the patch.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thank you so much for all your assistance.
Best regards,
Marilene

