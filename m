Return-Path: <linux-kernel+bounces-735170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBFBB08BB8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F21421A67AE5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA6D29ACC6;
	Thu, 17 Jul 2025 11:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ugzp4CCh"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79288299A93
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752751695; cv=none; b=TCRAErB/deJuOC0FrvZhfY9CAnfbtl/wyw5h6uw8KAxP5L90of+GOaoZ7SUqfnw0Zes29HUQ5OKOhZBPu9xlnPnkd4D0iQ5Uz8e9Hv/T0cEJ/9vVnyU1X4izmF4ZVdCDlL2LiHuevqiiRk4aefTZh6IfgS1Q8M9Uwim0H0m8QyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752751695; c=relaxed/simple;
	bh=vPsus7n+ZehouuNJIhJaopxKH86tOGKiwPcKPd0ygOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GDmhCwOa1iGG/0nmVEKtd9M6SYi6HyysEBJjjNcvgaq6M3Jaoz50YM8xPo2bF3y1pnCyiIdeEcJ9ECor3zpf0jjX/n7K9tXdp3Rb4QSbOp3p/mU8SAnUq2MatdFBLUwXSd3kzVWisPSpaKaHziY3i9/6a8VAxKRXerHmoPFX51k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ugzp4CCh; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4561607166aso6329345e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 04:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752751692; x=1753356492; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l4EyBkCfQk118hwy23YpMyJEobctr2YH/JMj7abcP1o=;
        b=Ugzp4CChlld0bsXq1K3L0t8+UdgvAUk/ojf7/B0Hl2xQOcOcL5uAOZZGuhwPxyHn1E
         vZVPC8jhdpVZm2mIW/vlGEglM+wi6cczcxFFTfPVPsB7ihsN7wSFk4xw0ndVRi33/vO+
         loXpFEsNOGNHxgIXOfhSZlTAnFpD5gvwcugw+huxGlzKIfqIR2Q2CZSzGY1slmNdsMxj
         z0keptv8RvVcuJE1trKnJ9UMTv1fjWXuFc2Cym3WaO1o4Bx1BRm216gMNWlVli1QXb9v
         cfQB9lffuWMFfoYBxc4qAEm16iBh1jFIOardQVq15oejckLMQkXDGQtBxJNoGBVb46G2
         R+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752751692; x=1753356492;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l4EyBkCfQk118hwy23YpMyJEobctr2YH/JMj7abcP1o=;
        b=i4yF6rt9xRycnUfebrD9TeKn5SZQNDIFwkLEqjftsEWCQ0IUL3Nr24IYCnFm+5aAyw
         w5KOcl1YhYRrRfjdjbCq9KRXnCST06nIz0gevb0xORboIuY0V5Ic+U3ApE6MS1cfwPc6
         NBCrAuTh0lH1Q5mOCXCjyLKvyaVKkJH8ekd5Ep8szDa3dUVOgUV2VyBk4339uHUtxN/M
         knnOBNmthIC2rJZewHuh9Wl/ox0oMJFDWatfUFBUTCv0KoNANUBkCkVqftl/Z8d0jim6
         j4xTZzcfFYR4NZeIbJxZhXp5qLJOeRubTNhyVES8DiGFz09q+qvwcdQnrrkZPecw++iA
         nVHg==
X-Forwarded-Encrypted: i=1; AJvYcCUXjR3MYK5SWhqOti7SS+Zcju/b2v+j8KqwlUYEChuL/SCd0iUxlf/8Ml3B2OgySAYzXchceu+QGREGL34=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpEjiuSIckpfwwDWbuJkP78NVAMqcDsJn8htiDvDZlWY7ryhNd
	Mm1vxpo1NtIrFGqiOjvYWNBYJdI2cN5tXMk0I9sRx7+nhJY5pJFALAS+2I6vgap63VE=
X-Gm-Gg: ASbGncvoUdEU2WNCxkWExg3Y4CORshDD2u/pruXyDQXpqzbjMCt0tH+2mMdmEj2da+s
	IEqUS3Kol5kyefkVvHaglS4JsBUWeKcp6S9mq0oFYNQ5XqnFptStd5XKMaffLnU5YBzssfePrbc
	81aYoqJ8P8yCFAI9+UKXWQwBJc1Q7Wey0ELx62dW+tJHUGI7lk+qkcTwvwGp9sZUlrR/R/17dvP
	xur7EEphZ+V91dUQAZFfqH/RlB3xefvmsbCykAJr43nvl4HV0t+lXgO2lHTTPvOtTIEMODVYKK+
	EGqAA5cRYafrWmCELDrrabzJ8O3LnbIoJ1OZ2YDHOc0cJIYGx5F+EOZu2Q0kWXSD8K2gaHQ1IY7
	FRghgL1U6ah/xLhfUwjV/lUPRHfCIYou3c06Garu56q6jQSSi8gB7Ghp5P7W/TglzvA==
X-Google-Smtp-Source: AGHT+IEEj/81mVMNXoPOUWUO7P/YkTI7YWJCQoKZ+jwcD015HAkVi+WItslIOuhDgRa9wqEhexgbsA==
X-Received: by 2002:a05:600c:3545:b0:456:1a69:94fa with SMTP id 5b1f17b1804b1-4562e03e75cmr63822605e9.13.1752751691688;
        Thu, 17 Jul 2025 04:28:11 -0700 (PDT)
Received: from ?IPV6:2001:a61:1347:1201:4432:54ab:26c1:9ebc? ([2001:a61:1347:1201:4432:54ab:26c1:9ebc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45634f82f29sm19552955e9.23.2025.07.17.04.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 04:28:11 -0700 (PDT)
Message-ID: <c9d07302-37f0-4f0d-8669-094aa6fc2450@suse.com>
Date: Thu, 17 Jul 2025 13:28:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: USB cdc-acm driver: break and command
To: "H. Peter Anvin" <hpa@zytor.com>, Oliver Neukum <oneukum@suse.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org, Jiri Slaby <jirislaby@kernel.org>,
 linux-serial@vger.kernel.org
References: <ce54ae11-72bb-4ac7-980b-c1cbc798a209@zytor.com>
 <fa20ab91-5ebf-427d-b938-31ea6fb945cf@suse.com>
 <83B89F79-D28B-4F2C-87EA-F5078BD7ED17@zytor.com>
 <2c807a7e-d55d-4670-9a86-e3fcaa3e52ba@suse.com>
 <f979468c-434a-43e9-8c50-8e92188abc11@zytor.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <f979468c-434a-43e9-8c50-8e92188abc11@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.07.25 19:49, H. Peter Anvin wrote:
> On 2025-07-16 09:17, Oliver Neukum wrote:

>> Understood. It still seems dirty to me. If you want to send strings to a
>> device
>> the proper way is to use a device node and write().
>>   
> 
> There is definitely something to be said for that; or at least a file
> descriptor.  We do have cases in the kernel -- notably opening the pts
> corresponding to a ptmx file descriptor -- that do that sort of
> "auxiliary open" kind of thing.
> 
> The big question is how that interacts with the rest of the ACM driver,
> as well as all the lifetime issues you mentioned elsewhere.

It would seem to me that CDC already has something very similar in form
of CDC-WDM. If acm_probe() can call tty_port_register_device(), it can also
register a secondary character device. Or are you worried about how to tell
user space which devices belong together?

	Regards
		Oliver


