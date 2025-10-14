Return-Path: <linux-kernel+bounces-853502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7379BDBD58
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFA8C19A023D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 23:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD4829E0E5;
	Tue, 14 Oct 2025 23:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9v1wdd/"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF792226CEB
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 23:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760485991; cv=none; b=thXWvKq77WHycWhsjOkbm6tK/M7dwTuJxDdjtr/RlDnTGGNcHSrLXCTItk9dmCSSd4qdrPWasOVfgd/GnZ/ey6E2aGbXDWLbPOx/lPCHU2dHHYeN8KIppZxWDKwH8t7eAcQkoFjK/kYJ+p3QBKVLkb9Dvjcy3twdkxkaXdioUMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760485991; c=relaxed/simple;
	bh=bXKfCGcteRtbKltdpijmFSV2FYgT1rZYsZg4DPoKs9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oc5Nrz/S5gXmNft3YO+9Au0ZYRsTgROkUDThXeiCkZyj3noKViEe9/T7n/7zXTaaWjv3+M3KoB2GLBK0kjCR3BBeHZZt1um9/fTFWbM4FrPQ0oVX9anjF/DTP0dIMZxIl+nBpsGNhrupuKsebxnZQ0HBERo9uXR4rBOG7vYv41Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9v1wdd/; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-855733c47baso1148102585a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760485988; x=1761090788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ob1OnhaB8yNlYIjqAs5ylAnnzR5hzBaZ/c2ZonR81NM=;
        b=S9v1wdd/ePeDtEfa4oeVpu3KqemiEFbezKvOp9/AyWl/4W9t4rSbipmRr704/SrVcN
         YydXYZUyh9yrTalwdyfjcdjEl4AOzQKBr/y8RgL+sJEqZhlMOHNRNYRY1hp6kMTJslif
         SWd4eiyjITCY1xQq4FK+3W05sm49vWbJv2HiqK5B7eqSBK9cyQqfrWABgoTuJww0uEPJ
         mAG/QHqzcUfkWa1KeT1GnsZcuXAlRZSBWz63i6f9QsGelNmucMQO5GuneCt9riwEIuBw
         tnrNb95rXPoX29DJmEb0sDRn3zF+n8pxAA7kwaK33ZGYAuy954S57PnJuvHskSujopMg
         47nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760485988; x=1761090788;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ob1OnhaB8yNlYIjqAs5ylAnnzR5hzBaZ/c2ZonR81NM=;
        b=Ws/yGtZIkUXN4DBNtgsP3BemFM4QWYd+d3kg0WfIZzkgm+ywLAfu8kpG0riU+LwhPF
         /+Lih/a50VUppHZepu7fdupaBwlC4+zlx5cDORKEki/o2R8UueUXcSJCJgEfTKlJloCH
         ZhEEJPxO6qf8Uh+lX5GqEtjG0/Qg6pRLSlwTcvuktILj1bmHCzFkkI/FEWcGNuBuwx0i
         Uvy93+DMd2IrYHZaYUz5o7MgMwOkwAtFclIXXhyTuYKwYbv9gRYJZVM1h45Yi4O3X9g3
         w+W0euNZQioq0nB7LZZINM6jFpE5Zp/YHOpI/+LdcZTnPQTZlMBqqFaQQFG75pK//x/e
         8ncQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbqXMQaz/l7/BJwKprGGY+qV0oMdRo3PLspGb3p/DG4cZLFDY0JbO6GNvtAbNdOd2B8ue17iKP8sBwu9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW3JfpexvHzPn9wr9f5GTqufntBIbHvxrV5O3Jt0CzhwoJ8ltN
	0uIaEHyqjb5DH0D4baPPiFJ76OLwu/KCRdDBqZW+HQFipFhDM7UCs8zQ
X-Gm-Gg: ASbGnctKUrG4ZSFkQnKlnxKuxusRbo4qvLefF6fa+axEp6wgKplcu5jWAAkcp3UUDuQ
	Cv4WdOYIK0gWTaYLd3dk6LtqRBR9AiY/Oc2KFLrHr+asoU5g49m0uyjJ0KUt3qw6AGtPbT8tHwv
	rk0aOny7NmcfJphEOTmexRKzbDpq4uBm1Hx3yMEO8WFbKJVGqPFZcoWd+0jVN4KOAbjWx03xgEb
	pqCjTWw6u7HraLhV5M+2WlIg1HPpCKS02BEY3m2MEYaPhWzZn6iQdaC8thS6F1Y0xwAnZKLgMhE
	LalQi9XN2h0AFDN9+Q4fIpX+0BYH7dzHtEB/Neap5iAR7W8vm9OjO7LI9qCDNEFm+kD3CzitFRO
	8lDEJfJxNyyukg+UuS93o/u3F0UTzMVHYMZ1y/0p0FbwLKViuHzK3C8ikPsyDqdC0t0AS
X-Google-Smtp-Source: AGHT+IHqzXmUGwko+aYtEh2ILwYIMC3c/wyMbPVlj1R55EMnuDNxOjiiifOG9dp6+prvXd8kQnjCfQ==
X-Received: by 2002:a05:620a:44c1:b0:85d:3c32:c404 with SMTP id af79cd13be357-88353464330mr3229717785a.85.1760485988310;
        Tue, 14 Oct 2025 16:53:08 -0700 (PDT)
Received: from [192.168.0.155] ([170.10.253.128])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-884a2273e9dsm1286214585a.47.2025.10.14.16.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 16:53:07 -0700 (PDT)
Message-ID: <451b7aaf-86d0-4a0d-9578-b76c3a7886d5@gmail.com>
Date: Tue, 14 Oct 2025 19:53:05 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: greybus: documentation: replace strncpy() with
 strscpy_pad()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: gregkh@linuxfoundation.org, johan@kernel.org, elder@kernel.org,
 schopin@ubuntu.com, me@abhy.me, greybus-dev@lists.linaro.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20251014134148.2597178-1-vivek.balachandhar@gmail.com>
 <aO5VvrKTswmfO-n9@stanley.mountain>
 <8918310c-d0aa-4e02-b9d4-9aac98b0a48f@gmail.com>
 <aO5a9izAISpCDJrc@stanley.mountain>
 <8f550b4e-2b7e-4266-be92-bb724265949f@gmail.com>
 <aO6EyUVO9EOYfzV4@stanley.mountain>
Content-Language: en-CA
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
In-Reply-To: <aO6EyUVO9EOYfzV4@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Dan,

Thanks for clarifying. That makes sense — since the struct starts
zeroed and the last byte remains untouched, the current code is
already safe. I’ll drop this patch.

Appreciate the quick guidance.

Best
Vivek

On 2025-10-14 1:13 p.m., Dan Carpenter wrote:
> On Tue, Oct 14, 2025 at 12:10:50PM -0400, Vivek BalachandharTN wrote:
>> Hi Dan,
>>
>> Thanks again—confirmed the structs are zero-initialized before the copy.
>>
>> Would a minimal fix that guarantees NUL-termination be acceptable, e.g.:
>>
>> strncpy((char *)&intf_load.firmware_tag, firmware_tag,
>>          GB_FIRMWARE_U_TAG_MAX_SIZE - 1);
>> ((char *)&intf_load.firmware_tag)[GB_FIRMWARE_U_TAG_MAX_SIZE - 1] = '\0';
>>
>> I can respin as v2 with the same change applied to the other two
>> firmware_tag
>> fields.
> Sorry, I should have explained this at the start...  The struct is
> initialized to zero.  The strncpy() copies at most
> "GB_FIRMWARE_U_TAG_MAX_SIZE - 1" characters, meaning we never copy
> anything to the last character which stays as zero.
>
> regards,
> dan carpenter
>

