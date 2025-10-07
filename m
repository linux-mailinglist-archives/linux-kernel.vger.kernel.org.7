Return-Path: <linux-kernel+bounces-844325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 093CABC1911
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 15:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8201A34E771
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 13:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3242E0B58;
	Tue,  7 Oct 2025 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAmR3STt"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C93A2E175C
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 13:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759845028; cv=none; b=qGqoCyzQg9y2MWJHk/QXF6XiYbfJan7I+/1JfcId144ZJPaZZ4R9C1GmbBoHuPqai7YsKMrxayKyuKKgvhjYm45XjNM8TCYLtVQIEX3NkRY+9tiUU0gAoFjN8O9Aq55jT5wOHa/7YXeX+Ji+5L62dM4d5ykVO+5X2G2Ai7JPI+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759845028; c=relaxed/simple;
	bh=J5f/gpGn13iUhHZhKgdm7VkvMERdlqXHZ2ggdyIgXpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GlMc53kQM4qTro+Sleo8gkM4cOWui+ibq281hzKCQv3UkiVQQMAxKGZfO19uV2mgvcZppVZXKmZLqDgrLKxI/hJ14nFoeWo/1szDraSFtzoz5oWavvnlNy8M+Z1dT0j8ofFIC3/vMZg8xny4M7NGLr8EPmS2kAVEVvp+S1qY8fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAmR3STt; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-28832ad6f64so71908605ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 06:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759845025; x=1760449825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=PU88MOj1iugDx7ISR3e7spa94+oBCAlA7CxJqDD0qGc=;
        b=ZAmR3STtHicxtccO3YK/ydMxdaT5ulg36/0Fu7ZbfYKz/EP6IPIoQrC4FLYJLM3OKv
         57mPbc1xT6YaSz1nRIbmXFBCnmyoIoKMej42twj/1yyctHTUGrnefJIDtHm0Kzc1RYZT
         +u0Iljtsia6sPn+215ndg88CR4q+1K+kB9CLvYntjFerjO8uTAG42AcaPukPWDzGkAcO
         fuNH4KrE1mpZK9dOeSUBFfg3zjkb9daUkbk9DzfXtpBX+V7PentXsRsaFH4cBN5dlPFf
         swQ+r/Y+lCmHZEBCiFrN/gEsv2aoRjVqt7tM3bwHkMqQx1TM7tTIEkq66fL7RqqqSZwz
         kleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759845025; x=1760449825;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PU88MOj1iugDx7ISR3e7spa94+oBCAlA7CxJqDD0qGc=;
        b=HNTkYCDD/DfSlVgOEYAtl45R5z32Ex2+ehab47EEv+u3YlhVGBfisZkMhLGu1RyPi7
         ni9tFFXmij9pfbdRBvwxHsSqVgdmJeM5Wq5ztNXH/SHK4Ky8bw9jN2d1vA0KaiTbBUmH
         K1tJyBotBypPnXfVeei4P3rS6BEqzUQJsb18lCi8nvyyv9QaevdKcoZMe3b1mjgbYVQP
         5ZRjZ0NnFbDOQVB5JQo4dk+TZNp1NfQHcIY7sWRY1DO8P3DVleITvgfccy5m3vueps5Z
         5h8k0HacXEQCkbfOxYyFsul3BnZA7e1dZJurTn4skm2Ky6hDo0I1b57jnFAJ+YspPVrl
         Ihnw==
X-Forwarded-Encrypted: i=1; AJvYcCUwKsO+diVtjnyKaeYESHO/K6lCnXLxlp0N8bDqebUM04gxhzn5M4SpuFQQvYCjMOocWzbAHzFp3roL7zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhLTNI6p4hr7DJdMKkL1AvhSUswc2dAlgVIphUohALqkfeRntK
	uV5nj/JSnD5CZTTgY0yTFYS9SIA/0Bc4+74/mAE4RfRjiC9Jw9/0Vy+g
X-Gm-Gg: ASbGncuQPoHnOrxEfHnrK628DTlmGvf5HieDKc85klmzqUPWhTjxBSfjP6fpJUDh5Za
	MjGpz9zRu9IYwM8RuOTYQuCLef/a2zeFHM4fNATpoNY3Qz/dWYj7OW31CRwira9uE3fYF5SddQJ
	zihPp0sxy7G07IupIv5uHFfP9y3W+QDXQ8tmJRAIMfJSvF0OtVnVRgvZxf32HivMuOyJYUUy41Z
	Y0JIwY47RSbNOnPvq9FJGkG6izu04WKD7bnrzy4tP0GDFnRhMeRgFX3lWGJpEt9kT0A6lRZYR0o
	lDS7SWUucl8oDhdmvFQ4FzLiZ1QKVG/t9gnC9X7qIs2JWP1L8at2xuPYP7DPol3/8x5JXJgE2vd
	P9WMgSVu3rQtIBVB7rxYNHVd2ItNGz0Bw0czr8P8kJ//DMDIHh1r+XqCPnfgxktmmwfC1iMdynm
	UCzhEiBqjKjmQ9r2pPhqs=
X-Google-Smtp-Source: AGHT+IECR+fLbT4nVOhBnG7BneTiTnCB8vIoTx8OkNflKGuhB3LN0I9D+BTXYVo1e8Sza85A6u/SbQ==
X-Received: by 2002:a17:903:b46:b0:264:f714:8dce with SMTP id d9443c01a7336-28e9a61aa78mr225602495ad.36.1759845025343;
        Tue, 07 Oct 2025 06:50:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1ee1basm166371225ad.128.2025.10.07.06.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 06:50:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e26d311e-a854-4892-8d75-69f7dc198231@roeck-us.net>
Date: Tue, 7 Oct 2025 06:50:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ipmi: Fix handling of messages with provided receive
 message pointer
To: corey@minyard.net
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Greg Thelen <gthelen@google.com>
References: <20251006201857.3433837-1-linux@roeck-us.net>
 <aOT9c1ULJolUHPSA@mail.minyard.net>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <aOT9c1ULJolUHPSA@mail.minyard.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/25 04:45, Corey Minyard wrote:
> On Mon, Oct 06, 2025 at 01:18:57PM -0700, Guenter Roeck wrote:
>> Prior to commit b52da4054ee0 ("ipmi: Rework user message limit handling"),
>> i_ipmi_request() used to increase the user reference counter if the receive
>> message is provided by the caller of IPMI API functions. This is no longer
>> the case. However, ipmi_free_recv_msg() is still called and decreases the
>> reference counter. This results in the reference counter reaching zero,
>> the user data pointer is released, and all kinds of interesting crashes are
>> seen.
>>
>> Fix the problem by increasing user reference counter if the receive message
>> has been provided by the caller.
> 
> Yes, the only interface that uses this that would matter is the watchdog
> timer, which my tests don't currently cover.  I guess I need to add some
> tests.
> 

Yes, that is the one that is crashing. Sorry, I should have mentioned that.

> Sorry, and thanks for the fix.  It's queued for next release.
> 

Thanks!

Guenter


