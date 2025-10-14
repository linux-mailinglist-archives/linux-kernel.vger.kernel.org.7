Return-Path: <linux-kernel+bounces-853103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DD1BDAA5D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57DAF3ABF43
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C2F3019CF;
	Tue, 14 Oct 2025 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTeQcGcr"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FE319F48D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760459946; cv=none; b=G6FYzgEw1USH8T4NvXs/q+FBrfb/o0zIq8e1vZFi7/HEOAHLf1nEBd+++6vYcpL484yvzsFrJ7YAdy4Xb90A46EZbo5SadzKtVXeLuZpmiuCnHL0/G+W8vUDsBZIAjmkk7/oZ4REHkl+Ng3195rm2OY8mzjEmElNt/nJW64Jk98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760459946; c=relaxed/simple;
	bh=GUctfe8/rywZHQ44aiN5coIvFbwjYZq35QI2NNSAsj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LP8g+FD5FUJyl1KEQwYjPrrAjkOjyYiVWHixoRXPHzk2k68Xg+n0JsRGVO3xnNyNED+l1r5n7on77WNpQhsSD8csE+t/JwKEaRxTkV8NbqsaVQOsE4stbz8xPgrRF8mCnDxDAtO8rrz0Z40rkgexgNC7lQHsWEuMTItSVcTKD6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTeQcGcr; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-33082c95fd0so6839613a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760459944; x=1761064744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+Kw4a2cbpYi6EVcibNkVqQEvI9GFueOoA0ipAsI1iyI=;
        b=TTeQcGcrKdFKbrtq5MjlwFb1YYBFaj14MWVi3p9t515WGnNXWjFZDv8nuRyPBVLui9
         leVCDco6H4HkPz+jS7yVuVpamBw/SUW+4RADpiNKgANTNMSy4CBp3L/84dXs/vCOmQ9X
         /qfeXVEO9ev0I+MQk4PDDSZihFedY5bxRX2NIMJJmJFMzWAYb/Wai0WiCg3Sjg9SgKAY
         IMbz0SVGCc9Efa7+kmx5kPwRdieyo/HX5w0F/+laAL9gx9TRvYXpj0fUojWNJPRRYltQ
         5wsSfdxatIrSCDqoI7IRROMvYqEZSigd/wU7JU+/YpdcbDXjvgYriPuB2pQgn+T34hTG
         wK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760459944; x=1761064744;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Kw4a2cbpYi6EVcibNkVqQEvI9GFueOoA0ipAsI1iyI=;
        b=DtqM7LkO92wqT8eYpmcLP2/qDZX/suA0/JCCODBlSXlq0+W/E+6GRDZguGTsvHZy1D
         28Pmqe1Xxy1z6f4u9XWzuKWYSNqb5mCLJpK1SstMIG/U47unU4H8fLCuW5mX6qBuOUsq
         BXiYP3gPh274q5qAnNvJKI+mlSDi7UGSEszeV8kAnD8UeTlo+ob1F8bdeSbccidWwHhj
         atMIjb0vUGan70jw2LulM+yn29pYzITlPk2Emowj2Y6gxs0xYSKrw09W+77HoxR3ior3
         TT2c/qFRuMZtbS/pO1+G4mSlpGdtzlKiUhYc2AVoQxmnz+X2IGhrUB/rTKJgaA/JV7pf
         qm+A==
X-Forwarded-Encrypted: i=1; AJvYcCVO+0Cv5CmGVQpO4LT1uk+GtRItgNth1ib3OMwqXAR+/ONsnAWNhdxZPZRNqjqzQYuCe2vlkmmyX2/dZis=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr2MbR7SowFjm8C5OEpxr7PtoHlzRFceiUzK8+iF1lqNdeGjx3
	AUF28e7o5NSrKe+kb7FkvCNyXNuBVUr6HrMfpuY5zpDw2bbjzM7Uj7pw
X-Gm-Gg: ASbGncskRTYCA1FSaRErIm5JmOj5iSAgAaBQvaM+S9n9rKoEehbqt039LBN0Q6Tn3JS
	7PVOjXRcTifedOS95pRVWZtkdRfwA/Xtq77eFdxAVP0wNB9kiv9rrQDeD2gWV6DJvipqXEUBscj
	8diW2QEBPU9xAoLK/3o7JDdIHsPn3MmLdjCRE24HwO2fjmBOey4DIUKqa1gcOQJ6DjZnwhzmk/T
	T3r8vXbEii1YbZbo4bieghhbCjr6yInXn/zLi7QqSoYZgkMrUGwUGcnilY6URjRqv1pB2mUo84h
	NmRe+stSid6g5nlrOj3i8q3Epw2BO5NYEBQpxFYbV6rLt2s9BRjHtro5kh4xxAkjmu8CdfbR0ru
	k4dhEj5zW9ZKD8zC4yFEolOBm6aqA4tlFI9cIeml06kkk3PhsSQPQiwA3wvgeENBkNMj9Z6C3v8
	BA72CHiJq6P0N8FA==
X-Google-Smtp-Source: AGHT+IE7dkO7t7zYTrn/rcvOU6CyaOeoWX3R6oaYLqTk74O3/dlsNAXvmuhzWnV7MaYaIVUdZmkXFg==
X-Received: by 2002:a17:90b:3d12:b0:33b:6612:67e1 with SMTP id 98e67ed59e1d1-33b661271aemr20674579a91.29.1760459944049;
        Tue, 14 Oct 2025 09:39:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678df6a95esm12321716a12.36.2025.10.14.09.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 09:39:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7197bfc7-fef6-40b2-b3f3-182e9428dc12@roeck-us.net>
Date: Tue, 14 Oct 2025 09:39:02 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/13] ARM: dts: aspeed: facebook-fuji: Include
 facebook-fuji-data64.dts
To: Andrew Lunn <andrew@lunn.ch>
Cc: Tao Ren <rentao.bupt@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Tao Ren <taoren@meta.com>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
 <20250728055618.61616-12-rentao.bupt@gmail.com>
 <79ddc7b9-ef26-4959-9a16-aa4e006eb145@roeck-us.net> <aO2kLyxGlGt12sKD@fedora>
 <ea64d3c1-e517-4bd8-9a2e-56432f286347@lunn.ch>
 <4e099ead-e6df-4489-a775-1730bc852dcf@roeck-us.net>
 <f801a4cb-3d27-439c-82f2-d5ee5aa0d810@lunn.ch>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <f801a4cb-3d27-439c-82f2-d5ee5aa0d810@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/25 08:11, Andrew Lunn wrote:
>>> If it is already in mainline, i don't care too much if it is wrong. We
>>> don't want to cause regressions.
>>>
>>> I only object when adding new nodes which are wrong. If we keep adding
>>> broken nodes, there is no incentive to fix the broken driver to do the
>>
>> This wasn't adding an allegedly (sorry, it worked for me) broken node,
>> it was removing one that worked for me all along. Obviously I do not know
>> if it worked (or if it is even used) on real hardware, but it worked for
>> the fuji-bmc qemu emulation.
> 
> It probably does work on real hardware, because it is one of those
> "two wrongs makes a right" cases. So i see this as a regression. The
> node should not be removed. It should hopefully get corrected sometime
> in the future when somebody actually fixes the aspeed driver, and
> fixes both wrongs.

So you are trying to force the issue by disabling the Ethernet interface
on fuji-bmc until the problem in the driver (whatever it is) has been fixed ?
That just seems odd.

Never mind, this is not my hardware. I just used it for testing, after all.
Again, I already dropped network interface testing on that emulation,
so for me the issue is closed.

Guenter


