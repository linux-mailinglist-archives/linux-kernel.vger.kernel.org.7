Return-Path: <linux-kernel+bounces-745510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 258ECB11AF9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C47E3AE09AB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B446E2D375A;
	Fri, 25 Jul 2025 09:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNIfGHBy"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FB92D0C70;
	Fri, 25 Jul 2025 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753436337; cv=none; b=eqUomdfNPLgi+AE2aMpQpVKSVVwMSdlNxaj7ss1cCML4J0Xg1QQQAiIYxCcfMFO522iekFrA/KncV86Q5/HmfjH0j9oM7IM+ABq5rxr4ixi2tZHgRxjxmJy55SvZpPgLdlHwPk8Y97E4fLKmJp/2dW/AuYLeg7fAPfC8MMRMvyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753436337; c=relaxed/simple;
	bh=Yc0XFDf3qSe3AqZgIuglG7npaEVqKZzPdZLjQIOBzpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RSOsn5+1OUVX20N+lK7LhA/SJWwO36G88MwFXik2Ynd2+jMMVpKnzOOKi7UYD8mYaCnv7kDk/Eki/fIHDrBEiS5gewWlM9ZtTxgGT9h+YdJgU+aM7zBBAE5TNEAC/6WyJr2BJ+scL9m9wXFATkz++a5LdVi0JeFrMswyQ8q4SvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNIfGHBy; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-235d6de331fso24039155ad.3;
        Fri, 25 Jul 2025 02:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753436335; x=1754041135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=FMktfMCGaGWkqp0yE2fWGVF3BIha65a2jGa4XtL8edQ=;
        b=WNIfGHBy+AdLJJe+HW+LdgCzyGj3EFGctC+dnFDjEvnTppC9tYzOjZ57wNgKtav9XJ
         TyiLeN0+++cpkMg3Qko8TyO8fzjQAiOxNUJPhpvFCkjZKFcMmEa3f/ItFnnB84+PRv3Y
         Ii+jYkA6s6CyAEQcXTthGRAFkVLa5i13uksQlArJ6KBXfturty6qYMEJTgs5/4oriddz
         PU8g0WXGEJ3kRzwFqxWZaPPfdLbQDOiQKWY/tU3XJbrtU8GGv0+zch6oHOy7P+hX5SSh
         Ump0UdPZRfKK0g6hjBzYj6HxONWn8CVZzMhihXU9Lin1yqMAGuM28hhfvfLZwBOrbMQI
         8eAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753436335; x=1754041135;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMktfMCGaGWkqp0yE2fWGVF3BIha65a2jGa4XtL8edQ=;
        b=oz71GhAwazomAlDVCtXtFb3la3FcaMX6VXGd/ugiBZbnurRO7ua9GxDAR+9AQZpIE3
         aM5K5h5QPtWtLlupCo80bfFCxHxx+3vu20H1ATpQS6dOoXDgS/ZHmd1rOUKHHDxsFJlr
         0jI1M/fWAN8D6KyXJmv99qpkEnyB1xMMHIlfsAVMFhsYrnxj9dYbD7W2egpQIoXS5XBA
         BM6IjftXNJdQCFw36tn9zH86WLoLLhNPS2v1lFsS/rH7L9gPQMhFKiR8PYYT37C727wE
         CCJjqn0W8ihpH4b7v1a43xlp9ADH95QxYXKc27XlOzm0LmTBn0U9a5hz3QNlzoAT21+o
         5s0g==
X-Forwarded-Encrypted: i=1; AJvYcCU8DUl9LUthw7bdpsu0eaSa+mkoiyoMWBdWqT+lt/Lba+6aFDDWTALGgL9qb1aYUZAUs15fpis00wwjG4I=@vger.kernel.org, AJvYcCUQ8L/qJG5sLmyEDE3/XzmdEqNGGEbcTu4QXZWxKBvF160BbpJau47cB4LrupJaiLBpeQhLi/10ND8g@vger.kernel.org, AJvYcCVdXaOx2dk0q+UGXYSS5SdEQ2bH3nBzn0lQbjY6dT1ZPqfGHVGAM6gxYVtpoQugLjBqoB5t9hMlP3M8Qdj4@vger.kernel.org, AJvYcCWwairrkHdzVZeAmjSBMPUaWYzxV9bm7Gcd0SFpTmHfbG6WnozH7dQLg6XhDSmPbt36kYoXIP5lnlQA@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1g0vgbb9wOHAK2lEM0Wm3inW1A6y6VRBCYdb+UxrvMDDKH+Yk
	tx33zUVyyKAIq5cyyO5/NPSPh9XbIPqGem/gDzY+Zet5QWyEBogI00Oo
X-Gm-Gg: ASbGncstjDA57GsLzS1L6fnXYpfKmnx7miVWtxfvABkmYjoeh/rYjolVj+1tQ/7glZB
	t/+0tWYCbRRXlJz84sJK4gmnt2oa/As0/HZ9IlufcEJHyXJu3LnftAACUAouzeNK9LVLJtFDeAK
	BmEPy/NnYZ2tlV/cVtOVJe4I9+cA5gvdhDYebzHIdVfIw0MVbDsYE7moBXloXP2C9rfmEMiUtOn
	FKQ8Sx+HxWYjYkiKmaYTB6KatVzTqgPn3js5KANlbb1c19SkXV+lfqw27SFbh5B0NIK8KSXnohv
	tDPki9dxl7H7wHGCtaTrK/LO2CHeuseG5OwqqD9kLME4p0QQMeiWnKJJUxoLkxggbFztpWds9Zh
	VcrwxfK5Gr6RX3KKi25vbLI8Zsvhuc76+jRu4Z6JkOgzZ7ctWqwOFxzxxwVlG6bBPwdlfSkw=
X-Google-Smtp-Source: AGHT+IFnjiXrcVdZCakm/Irao+W5ye2l4z5hjRFbq9Qyq3yhb+eGp4m1AUEa3bgySvj3aH84/h9/+w==
X-Received: by 2002:a17:903:2451:b0:235:f70:fd39 with SMTP id d9443c01a7336-23fb2fd7c27mr23080745ad.10.1753436334574;
        Fri, 25 Jul 2025 02:38:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa4901b99sm32830895ad.188.2025.07.25.02.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 02:38:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <cccad21e-7599-4643-9f39-94faf482041d@roeck-us.net>
Date: Fri, 25 Jul 2025 02:38:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] dt-bindings: hwmon: Add MPS mp2869,mp29608,mp29612
 and mp29816 series
To: Krzysztof Kozlowski <krzk@kernel.org>, wenswang@yeah.net
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 jdelvare@suse.com, corbet@lwn.net, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20250724091011.550761-1-wenswang@yeah.net>
 <20250724091306.551131-1-wenswang@yeah.net>
 <20250725-glistening-hamster-of-perspective-1dd0dc@kuoka>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250725-glistening-hamster-of-perspective-1dd0dc@kuoka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/25 00:21, Krzysztof Kozlowski wrote:
> On Thu, Jul 24, 2025 at 05:13:03PM +0800, wenswang@yeah.net wrote:
>> From: Wensheng Wang <wenswang@yeah.net>
>>
>> Add support for MPS mp2869/mp2869a,mp29608/mp29608a,mp29612/mp29612a and
>> mp29816/mp29816a/mp29816b/mp29816c controller
>>
>> Acked-by: Rob Herring (Arm) <robh@kernel.org>
>> Signed-off-by: Wensheng Wang <wenswang@yeah.net>
>> ---
>> V3 -> V4:
>>      1. split patches for MP2869,mp29608,mp29612,mp29816,mp29502
>>      2. add description for vender specific registers
>>
>> V2 -> V3:
>>      merge patches for MP2869,mp29608,mp29612,mp29816,mp29502
> 
> No one asked you to merge drivers. Look where comments appear.
> 
> So again: merge the bindings, it's a churn to add one trivial device
> after another.
> 

I think that is what they did in this version of the series. There are
two drivers for the various chips, one of them supporting multiple chips.
That makes sense if the supported chips are similar (and afaics that
is the case).

Guenter


