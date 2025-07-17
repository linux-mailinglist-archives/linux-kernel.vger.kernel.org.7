Return-Path: <linux-kernel+bounces-734491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CE3B0826B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 03:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D69A3BBF75
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 01:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F825207669;
	Thu, 17 Jul 2025 01:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fK4fS5IX"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058EB1D7995;
	Thu, 17 Jul 2025 01:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752715836; cv=none; b=ZXC+ex/Om1AlfNLdwb3ihY9sNPhtqacujeM+8VjHqnCmsv+Kc0KdxZ2ZV0WVBItKbGuaM+297/RQcYF6OKzZzxIfO6RVD35faeJvGm6Rg1n7dMv+uY3brxI8DdvlJ3gLbC+VOCfVJonk8iJIFKXGRGHGyM/9ZmGu6DZ2IF0AJVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752715836; c=relaxed/simple;
	bh=xxq+bLx8oBvWf0zCW0l7z4Np+L2IwbPY6BnTJKs7HPs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Ul5SXqQg7nXKUpcMfO4Pq9bZeA7Qk97nZl9dVmDGdf2DigqnBGFYBE/yVB5jZqxC6dYX3NdvFmhp6kZ1xJQf93yALigNFrVQUil4VqeclqDq0vqNpGA+U5Bbyv+jV9pi6qZvMQ0bwshQ2x1mHsBqaEsQ9uSpQCvCnDXBL+bOn+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fK4fS5IX; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-748e378ba4fso635437b3a.1;
        Wed, 16 Jul 2025 18:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752715834; x=1753320634; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=qPmpgXNnEQLHmW5acfNZvE4mUsgXW3Lp4HupE45yIXM=;
        b=fK4fS5IXnTGEATCBdkNDg2Y1TgE+SyhD6BaHvm13+EKYHmvfFt9NLNeTLEDSmxsms1
         ccMx8IGirU8apXhRH1Btm948hMo0IOOU8728e82ZZHF97LWsKMZP0QRElz4W6eeSuU2Q
         tl9mZvyvB/uhAecziK3mOWsYuS6BFoQFMafTK/qE7zb96dx5ESR6oQR6ln3ssDykjpO9
         op34eaJ+TDP4Plno4rteLPIAUfw49ioDchyYxVtCsGHATwdBKeMMvCaJYQbBRRhgD2KC
         XlgZ+ay/KwI7pR5d6+wv4NwuxIH6b708zIDDbtbN2MRGfjus3uNCrIq7iq0qUX/mF5Hi
         fplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752715834; x=1753320634;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qPmpgXNnEQLHmW5acfNZvE4mUsgXW3Lp4HupE45yIXM=;
        b=GwKSrZgc1anm9UqSjbmp3Jq2iAZ7kCp1qTYmXsleeQhamKUdgNwp4SzkqYOqQrfZTG
         YNjK9RDdnf0AkrzOKPvfH9wMta9fcoPi81RbYpqeKsDmpHawAVl0IUoKQwTRdc6t2dPK
         J/YA2bVSlHnk+DzR6EdBXap+nGHtJCI3k2OeD1t5GM3PNeycOM13krnnIL+tFFfj/jTL
         CCzLkIHSwxZhNZQjUWSs6kLCOmStQejSwD+9B4BQGWXYF7HYlKdb9LGZdnBbrsyzzO4j
         jDo9FHd3VHv1biGVVpho7K3459Vlgl2+DaU4t0mYl6Zy6Yf6cv8hUbMoKjbk+iUs+uqE
         zaGg==
X-Forwarded-Encrypted: i=1; AJvYcCU0YhZcD144ZWrt04aLS/q2FvD8sDCwDv7T4H7OWudbx6XpnSQit35KTcszgZP2R4YTU5IcHD8uCGDi@vger.kernel.org, AJvYcCWvnxI4NSMmchb5WUBr6SX+m6R9z3DSE+/BdYWUAxAVf8xFH93+kbVAy06TPeqTwtbdpdgCJx+AjUknLsY3@vger.kernel.org, AJvYcCXRPK2rU0NEG0q+izrFSh3pADlg3pMfTbatLmKvCoafzhusb9PVF6vxvEGpyBy0uO2iy0FC7wXVnY1IamU=@vger.kernel.org, AJvYcCXo2NF837GFL9I4yyD7a1mZ0HcT7ZjJBeOqXw9amUSfyIDuiEUSgKShYbC710wlRFAfDxbjHG04R4xa@vger.kernel.org
X-Gm-Message-State: AOJu0YxjEwMabPkS+ZRAH9nGz63ADGQwqCa+dP95lraCbqyfSz+FJFP3
	QCA7+FDwWZSQP+BYFFfJOttzy2Ygh9kkfYNtLQ8xjE2pQNlbYIbbNSjanz3HCQ==
X-Gm-Gg: ASbGncsex7ZSJD5y6c8DLmScKEa2gBiEfQ4tqYxRnnv6tWa/U9GkFbLx7kjLLJWomWT
	GBGP71QZXlb+Ip242Vb7x4FpiFTkDT2TBtdv7p88RNYGs+6CTc37kCZI0OoUpKjc42C0Map0igp
	HPO9bJzG8ifMQTrFHLDwXMUDrIQad6lwLRzEgHqPyaZ3CbUGpzSX7Gj8SL3ZIqzaOuiOdahbX/T
	UsACEHmIc4xIfnZNuVYrsveWIoIMqc9QC0jFpnLIPpb0ruvFYNyZsnBKsv2m2+u7aecw4YwlUM0
	RpRiHNfyOIHdBbwh7ilgzQ/S8jD5s39b628V4YJ050EaHSYf6nL512wrmtKqVbxuZ+mahR6i4WC
	syYnQZeYJk9qfVUX4jkCJblTZcbqm4vT7E+0mg5KCFxGC1mGl/ihr+1u5VsjKsWhukskNinY=
X-Google-Smtp-Source: AGHT+IEkaXxrt2/zVu1LT/Uoo/slorr472pye93Bq+hi0Km8yxTslJ/6PTUbcqAoDtWVZfd5h4446g==
X-Received: by 2002:a05:6a00:18a7:b0:748:fcfa:8be2 with SMTP id d2e1a72fcca58-75848c188b1mr1499382b3a.2.1752715834122;
        Wed, 16 Jul 2025 18:30:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd5a7csm14375535b3a.28.2025.07.16.18.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 18:30:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <eeca688d-e429-4752-844b-031ce6b8e982@roeck-us.net>
Date: Wed, 16 Jul 2025 18:30:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] drivers: hwmon: add EMC2101 driver
From: Guenter Roeck <linux@roeck-us.net>
To: =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
 jdelvare@suse.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 corbet@lwn.net, linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250709164829.3072944-1-noltari@gmail.com>
 <20250709164829.3072944-4-noltari@gmail.com>
 <e02cda3e-799f-42bc-8651-108a258b3d85@roeck-us.net>
Content-Language: en-US
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <e02cda3e-799f-42bc-8651-108a258b3d85@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/16/25 09:05, Guenter Roeck wrote:
> On 7/9/25 09:48, Álvaro Fernández Rojas wrote:
>> The Microchip EMC2101 is a SMBus 2.0 fan controller with temperature
>> monitoring.
>> It supports up to 1 fan, 1 internal temperature sensor, 1 external
>> temperature sensor and an 8 entry look up table to create a
>> programmable temperature response.
>>
>> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> 
> This looks very much like a clone of LM63. Why does it warrant a new driver ?
> 

I had another look at the two chips. EMC2101 is indeed - with a few exceptions -
almost identical to LM63. There are minor differences; for example, EMC2101 does
not (or not officially) support temperature offset registers. That does not
warrant a separate driver.

Please add support for EMC2101 to the lm63 driver. If you like, feel free
to "modernize" the lm63 driver to use the with_info API and/or to use regmap,
but a separate driver for what is essentially the same chip is not acceptable.

Thanks,
Guenter


