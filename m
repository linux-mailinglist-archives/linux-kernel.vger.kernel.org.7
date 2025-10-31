Return-Path: <linux-kernel+bounces-880805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74582C269CF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 19:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1C3B4EB0BC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A471A29D28A;
	Fri, 31 Oct 2025 18:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTF7oqyE"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8883C2E5B32
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 18:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761935828; cv=none; b=MvA4Gx6nhMb60m+KQofgfyR9O4GXAkssZZzFH75WiENSelRnsG7IAvR5Kwp9qTFMhQaigiIS/3aKSEvzVcT9zIU5nGY1nJOD5ERVjtHLADjugW8zEu+64mJxeaBh8qtm5oubMLr1SUy+xjihHjIWM+E2jDtUg5OFsLABdl/6RkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761935828; c=relaxed/simple;
	bh=fq4ahmFZ7bpfJBQK18QsXF0TADYYnB2UkPabqpgqDBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eM7dQ/qEFM94ZRo9DbbALZiBOCJCjuHJvzZfTV2gNAnN5X3esRkEycqpND3XRhwdiJAbe6DOHQ1jMMqhsPsx0Vk6Ny0MLrzClGYyOhp/btkDpH6KGF4vOfGz0JdQZOAiGhihAsUKsXHo+zCaYggZKjuetb2XlEUYkmQ7iHbDaUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTF7oqyE; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-78125ed4052so3695810b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761935826; x=1762540626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbNh/oyHxx1gNKK10MMyuZ2NpBZZZZyF3csuO91peh4=;
        b=YTF7oqyEqPc3itBnrFXmD+01epFwqBlLFoX2rXFvCIIg5IwVcD+sP5JHG00cCjfBV5
         qwKsPZosNikjt3BVlkHYF+/Ed0ZtmxmS58DwITtgBHN0NqHL6owFMU+bNQahHPNsLz4E
         dh4wRooT2L7uxeEsvNfiy9SFjwjWWyEy/z4M0Slayv8mbxGiucXW4OHngRdanHxzh7Zd
         cRp8U3b/rhJLwg2zB8bi90U96c40adpOZbuypiz3lILZdMIGt3mqRXATUAgMXOWpy/XR
         XLg/O4jLOd+bX4zQEFyp5wgEueukzDwmS40mjQF/eXihMUvi1sa34IzV2t5bQq9/Vl4W
         ZERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761935826; x=1762540626;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZbNh/oyHxx1gNKK10MMyuZ2NpBZZZZyF3csuO91peh4=;
        b=OW/CwmZwG82fb3wsjq8FKtE/lnxagnwlXTj6ODylAEF4ciwJWkrRa91hmi99taR4D4
         vbwRPtUzI6xqeI5Dw0A5F8fmsF06sOJw0mNJgp5ImgBhY/FRTjVv+xmDIt03DBoQBWF1
         jRdLgiIDU05T3pH1AowOx3iHI/5IZ6pslUOlxEAwDeqdjCN/VJMF7x944ys/cQkP3zHn
         JGzdlBNo0erPvN4KqprrMi7sDMhCNe4rmhnDVd0lDkAQ0kfXO/+FwoVLpketWbfoUKGw
         yO55kvJvzOiTL6W+J+c+MjSVtB0TNXWW1wek7OoGBfIC2drsOva59I8aax/tFswwtlXo
         mLvw==
X-Forwarded-Encrypted: i=1; AJvYcCUsT9EIpydDQ7k1t9Vw7n6ZB58QJwXpBP0l0Pgjv1IxFMjSK1YItfgpprt7xaca5SUNtg09ExfALtVYC1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZMTw4s3kKouoFLxuvJ5X2dmxYEg7ZYCxvMuMGueI/WCYib2WM
	Ywkljyx92XEhncEZaxNvxWGhe60zzULVwOSfUpq8TOGT2fOlN7WuN2Wp
X-Gm-Gg: ASbGncvvdnN6siKouGGNE14J6HMtQ9V2yE/Fqr7WeiTCzd3YC3JTvd16oLrR50xyP3u
	wdyct7QmwOESpC7wq5+1jXX3Pcz/t1m3+cS4xFJFzbPsTBHFnVXVKfQXYD4Ih4fY24XvNUO3Osj
	bc3s365iDcuTEuiGg72Tg2O0i2u05SunY3uIlIj3kPPdJ7R5G4xlGQssHyzBMkchisPrnG6CUCn
	+zFIlrD2y+DVR9IBOFR8trYMo59GSRNqUSRyfcc+hfKeJLlf7FBap5zXqS2iTI/30uEcVOv6YGn
	eciv/fy4o5rdXu4TtYXNcanBYBEeXSD4BsrJfxnz3Gb4L/x4Aq3JLc3KxF+MXIgib7NzdJCWx4d
	TMAutZaoLCw/pp/EKpoYdCmYMhIkSOr3EwiqlS1v9kKt11L6vUr9mrjgVUCZtgLj7/TpR94sPCB
	JVkEJ4Asdco4Q6PO0lTYnNWv+3zrYOiXANROetC53mzuQI6A0C
X-Google-Smtp-Source: AGHT+IFxM9ZPDKP64KwLTzZY1mRUZoimrQ3Q3TbPQ32t3Aj7lwWBRV06PRS1CSCna8E66/pJLqw2Hw==
X-Received: by 2002:a05:6a20:7484:b0:33d:4e4b:7b3a with SMTP id adf61e73a8af0-348cb187fc4mr6900447637.25.1761935825528;
        Fri, 31 Oct 2025 11:37:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93be4f8cccsm2795935a12.30.2025.10.31.11.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 11:37:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a4245d73-365b-4dca-a2a6-685fb11c34c6@roeck-us.net>
Date: Fri, 31 Oct 2025 11:37:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Add support for ST TSC1641
 power monitor
To: Igor Reznichenko <igor@reznichenko.net>, krzk@kernel.org
Cc: conor+dt@kernel.org, corbet@lwn.net, david.hunter.linux@gmail.com,
 devicetree@vger.kernel.org, krzk+dt@kernel.org, linux-doc@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org,
 skhan@linuxfoundation.org
References: <35d41d46-5bc8-43af-a84d-6b118fff08e0@kernel.org>
 <20251031173029.904313-1-igor@reznichenko.net>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20251031173029.904313-1-igor@reznichenko.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/25 10:30, Igor Reznichenko wrote:
>>>> On 10/28/25 08:17, Igor Reznichenko wrote:
>>>>> Understood. The bit in question controls the alert pin polarity on the device side,
>>>>> independent of whether the pin is used as interrupt or not. I'll drop the property
>>>>> for now and revisit if there's a board that actually uses an inverter or needs to
>>>>> program the bit explicitly.
>>>>>
>>>>
>>>> This is kind of unusual. The requirement used to be that devicetree properties
>>>> shall be complete. "Only if there is a known use case" is a significant policy
>>>> change. Has the policy changed recently ?
>>>>
>>>> Thanks,
>>>> Guenter
>>>
>>> Rob, following up on Guenter's question above.
>>> I'm not sure whether it's better to drop the property as discussed earlier or keep
>>> it for binding completeness.
>>> Could you clarify what approach is preferred?
>>
>> Don't you have there possibility of interrupt (not only SMBus Alert)? At
>> least this is what I understood from previous talks.
> 
> Yes, the alert pin could be used as interrupt in principle.
> Datasheet calls it "Multi-functional digital alert pin".
> 

Maybe you could try adding an optional "interrupts" property.

Guenter


