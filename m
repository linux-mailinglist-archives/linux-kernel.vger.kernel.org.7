Return-Path: <linux-kernel+bounces-772552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45301B29404
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 18:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1731B28767
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 16:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4332BCF41;
	Sun, 17 Aug 2025 16:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlgiTvBD"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAAD2FF17F
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755446945; cv=none; b=T+BAnhMCIqWlasylkjPv9pUQw5tP8m9Aj2ndbC9yvVtl5MaFkeJpNTyFwOB6bErRChI5QOplhUMfd1liLD5my6cbf0RedaiaXxdimZNc0BMP4bsuRkxcOIIXNvgjuMI5GiHzzKuz9lRb98tsoGp4knXTqDNjmSft0ayP2MES32s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755446945; c=relaxed/simple;
	bh=iDSiEe6wILi2jJn6TShFRbf9W1nRzWd6JKm369YFRmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lem0oseaDxwUNgHgLnngq6h65N/MM2jN52nDfCTqF87qvH+6HShVTvpbIZWfhX6TgBHD9uP34lIsQgmfd7Y1U+sKXlCIDJgYRHYgZUspo6YTPNlL3Q7GQw7MFdJtL3o6MRJEv2dzzoOyG4vrMKwkEf8B4FAN4KzwqeXUiRGRv/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlgiTvBD; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb7322da8so582512166b.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 09:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755446942; x=1756051742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q+G9UWxNWXw9Jc5WN096/qtv2hWSeHEe3B+2hqE7HRI=;
        b=QlgiTvBDgEMN5ghhhlq+SYtD2UO7AtLURW19Ma+VBEJr6pIUo5XVYRxCT54shEqhGs
         tbeKCxeU7TiSXnq3nn5Sgq2DSiVYQVhwRV9h6iwGURWwE/+ubIPe/47pcYZp56rHb4qN
         6PoNKoLLWcKfLTsfO8Fw8llRBEJnLUsg2btuQiW80TcKJt1njNfBux8bt4yvjKfmHadT
         Njk6rl9wsH8pH6XBkwGoJI0f1fzD/IugKZyxI2c7vEB1zwjQL+TFJixsLtWataGZvddn
         7oNgfbjnAL5byODDA2uqwXMNoTBDMSBWztps4xdHRxO3KsueC8wH+y9vPB+GMMQLMVqG
         1jnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755446942; x=1756051742;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q+G9UWxNWXw9Jc5WN096/qtv2hWSeHEe3B+2hqE7HRI=;
        b=MGkOWNPuEmOdxBGkc6STFzlYn4NURwvIH8gTkqGcGscUKhCsISp6kjbLlYclaCD+cM
         55nDWjUD0bUrWwtDciYwrja15AvghogmUIYaOKST5UTx+oRvBx+emodzCnPdUrYLdWGL
         4LkvOakqxZtmv8uTuBY80mU494Yha2qb0CzpNKvGIRGIbnsBnobPCmAdKYTNbfRsCqqx
         iAKt0t9KduFWtZA7VFWOfiW7smM6Fl4SvVCHF30G/GAyFS7CfDpr8+mpTSiWzX9esbYC
         vs4AtzzJ0P28HuWorb3X4qyuy/gnxRVr5DCiiaeJ0CR++n/T+C5Y/TpUDChhWRAgo2NU
         UiZg==
X-Forwarded-Encrypted: i=1; AJvYcCWGEgK9qGLWiBHngiU+CnhI2VaDEPrwuVIJHdmevN9kIAHC9GjdqiBBQnjiL1qR8Cmyu+aCq4XVf604DZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBxNnLNa3f0vO5YUuaAgnBR8EKgJOIaFvsxXJIpy2Y/UN3RlAD
	DP8Dr+IevzxZevPdwUzW7AG+RNWKn6SVynPu3jlu329tKRR9MpVnCB5i
X-Gm-Gg: ASbGncvYjPZamQ9xlppkTQPpdBMey5X6Yw98ATFliozB/Au+kOyDsnZo7tC5nG5Ejj5
	AMKUeymwAxwWm++UG25F2phoXLDru3iu8DFQ1lT3TAVAkAsgEIw0ffsMKThzYf7wNI2AliRfEV4
	rSGBsU49lcmWHNmLwGxCTfAseO4IuSnCkXaidX7Fhd7GgbWTcUQYAvX2FxPoRQfs+RYC/yffSXs
	AKiO/51DXeIvuC3IdWApKGTRXeAUUYYmp4wFMGJyCDlbR9+kZHwTCY4Qy2ZcreBcwh2npGV3Bl2
	7XNIVUldoky1kobzmPfCGLwQEDYB3rwt04ebOgIBAxdbhqAlLAn5RdJ5SdXpm33HbM0QYMtACL5
	LmcC+GBdj3As9Wc3SNq/AXtul4WbNuasFwjY0YLNtrAJQk4cZjAD0WjElcNyPvdjZbmWw9iuXkT
	hRMWsA
X-Google-Smtp-Source: AGHT+IGBA6kIE+Ke0vR2EHxnerO4Yao5HMcwHc34uSpY3EBf6z7RGYryTQypTRoAC9RM7zO87q7yxA==
X-Received: by 2002:a17:907:9415:b0:af9:10c7:59b6 with SMTP id a640c23a62f3a-afcdc3793cbmr733316166b.32.1755446941365;
        Sun, 17 Aug 2025 09:09:01 -0700 (PDT)
Received: from ?IPV6:2a02:2f0e:c207:b600:978:f6fa:583e:b091? ([2a02:2f0e:c207:b600:978:f6fa:583e:b091])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce54021sm611310866b.10.2025.08.17.09.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 09:09:01 -0700 (PDT)
Message-ID: <2a7e9a24-38f8-4be5-a820-c19e4aeaac7f@gmail.com>
Date: Sun, 17 Aug 2025 19:08:59 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: axis-fifo: fix maximum TX packet length check
To: Greg KH <gregkh@linuxfoundation.org>
Cc: gshahrouzi@gmail.com, linux-kernel@vger.kernel.org
References: <20250802205943.958071-1-ovidiu.panait.oss@gmail.com>
 <2025081755-actress-flogging-4261@gregkh>
Content-Language: en-US
From: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
In-Reply-To: <2025081755-actress-flogging-4261@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/17/25 2:12 PM, Greg KH wrote:
> On Sat, Aug 02, 2025 at 11:59:43PM +0300, Ovidiu Panait wrote:
>> Since commit 2ca34b508774 ("staging: axis-fifo: Correct handling of
>> tx_fifo_depth for size validation"), write() operations with packets
>> larger than 'tx_fifo_depth - 4' words are no longer rejected with -EINVAL.
>>
>> Fortunately, the packets are not actually getting transmitted to hardware,
>> otherwise they would be raising a 'Transmit Packet Overrun Error'
>> interrupt, which requires a reset of the TX circuit to recover from.
>>
>> Instead, the request times out inside wait_event_interruptible_timeout()
>> and always returns -EAGAIN, since the wake up condition can never be true
>> for these packets. But still, they unnecessarily block other tasks from
>> writing to the FIFO and the EAGAIN return code signals userspace to retry
>> the write() call, even though it will always fail and time out.
>>
>> According to the AXI4-Stream FIFO reference manual (PG080), the maximum
>> valid packet length is 'tx_fifo_depth - 4' words, so attempting to send
>> larger packets is invalid and should not be happening in the first place:
>>
>>> The maximum packet that can be transmitted is limited by the size of
>>> the FIFO, which is (C_TX_FIFO_DEPTH–4)*(data interface width/8) bytes.
>>
>> Therefore, bring back the old behavior and outright reject packets larger
>> than 'tx_fifo_depth - 4' with -EINVAL. Add a comment to explain why the
>> check is necessary. The dev_err() message was removed to avoid cluttering
>> the dmesg log if an invalid packet is received from userspace.
>>
>> Fixes: 2ca34b508774 ("staging: axis-fifo: Correct handling of tx_fifo_depth for size validation")
>> Signed-off-by: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
> 
> Any specific reason you didn't cc: the staging list?  Or add cc: stable
> to this commit?
> 

It was a copy-paste error. I'll resend this with the cc: stable tag
included.

Thanks,
Ovidiu

> thanks,
> 
> greg k-h


