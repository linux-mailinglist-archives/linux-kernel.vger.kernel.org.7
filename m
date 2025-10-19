Return-Path: <linux-kernel+bounces-859729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 654AEBEE701
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 16:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7445420D46
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 14:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E542EB5A4;
	Sun, 19 Oct 2025 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkzaMCYJ"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5977B2EAB7A
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760883884; cv=none; b=gn1IQDPtQvQ35oZFEqzixAWYTXXbARCjWU6a403ULSCGrKD8HdoPCFRP5TsRXtWDW89bu//2rrukv5RuRm8LIr5p0gWiJfYEBEYvt9SxICfGR/Azyxx+kFv+teWi6437UhZdccLQiK6pV7RvjXFJ5hgT4YO4x8WxsQL4NINXIJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760883884; c=relaxed/simple;
	bh=UBQ3CI2i/Vqkyp+P3nK/BsPqKNSMijENxAcB6e9vYzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n8WVMlCxRZ00MgVpghwFK2Ydb/QI2q4XaHcUTJhqAL3MswuqOCRFkKUROc4i2KVtbLUyiPXaZb1VUu2inv/RAW19thNeogkwpdXgwR9AGJ3zxvxh+2B5iS3lGRfXmGOkcqdS3Z467tjynsoN27z/Qv99FckLOhpcI5o0AYI0e2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkzaMCYJ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5818de29d15so4225957e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 07:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760883880; x=1761488680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Rk93k1ljwyghSN33Atl9hvNPZmj6zeAwyQjoSPxOYU=;
        b=dkzaMCYJ7ykWAh7f5a0/7HfC1AWJ55LZAq99M1IqhKOY2u+OI2tN+Op0w99GNPhC2b
         ky6PjFGrMTHI8sDYu7egnFgOX9VRWCjJix7L47Q0F/YaGZvo/drHryjsuR3QLMk6Uf+g
         iud7kC8UatVGjq43T6G6EMZUwhS5JJdB8oFp6tcyqNxTqBjv1mvd4uYVKCQmbeOwJNUE
         K3pZpA1hDdwL5W630R9Qe1fos2Z6QcyQE59xzWLfgpkNRvYsC9DZzXzE7Cbybj827o6/
         LYA9GOUTxdMgtLHIjFFXP2y87e61M0+AdTEBm9eaV3n/2gEsCExcT6kyrzCddiPQpR12
         qpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760883880; x=1761488680;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Rk93k1ljwyghSN33Atl9hvNPZmj6zeAwyQjoSPxOYU=;
        b=N4ekGobH1S5IHSXWMpDwKoEEfYAKFKtaWempqfBlz4UXefOjfq5vTAE+3UHmpCPdXE
         2pp6M46kuBpvyZvsck+ij9ddlJG1LCzp4zgm+Rdcf2bsh2d3vAQPc9JE8CzwKuoqypLZ
         1AnMCYPWl/6oCgIBL9WyaK6O/GzPd6GaQJQNbThj7FyS5JmqI3WP+1Hy1lBEp0tBOcgF
         KyJDtXHtuSrlr0l7fDWjah6GWhgaXwuORUdS9OzhFyDrefgdUrPV70hyrGCbnwQoFK5Y
         HL/Du0FpqaIl2ixWYhTuOzqmUoonMPhr+hZmQEe+eEJZthmLS+W+Q4Xu4W6jGPA2w7n4
         +enQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpbGZ+Fpwd+gj/CT5TgWKBAqp0IdHk+bQ2HJBUosRXWQVq89XqG5Dv5rvZgT1lZb+7j6cvfMphmyEtho0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFga8+a3tnvTvbfNenbZXRwov6qXMcGM+R1USvbN7D8gbri3Jl
	gsn5xSw7iejftgebFXMe6wIpp1/bVM+enCdN2yEm7X1JM0T+p10h20J6
X-Gm-Gg: ASbGncujX15kj46dG3obOGB5ufdTXDH8lOK8fqSu9BzMj4H8RMhjmmO2csL7Oy5BcYR
	UsAaCNvhLdyg66ECgWNmiZm48lpf91a+gprZ8S0hBda8qZQDCM0/onmPNl553Ccz+Qg2nwjI1mC
	KkIapHJ7UdGvLirV5f/IJMRL1/JeA0cuyb/+vA7aeoyyzg6jeGJqGC+RnyUQdKcCrTGs/xkTd1O
	fZ6m3jSRhwJjMBQuoAs+WtcyP2JVqGEORcMAKCNVY0FiD+DIDRdDTgdixLtrEh/tOrgg/Op6AzB
	6Nn79TYnEdvuXFI2CYiQHsHSKbHGjqk6/2PBrZ4Ns8O7kuJr/h5Rl1bVTVPF3VGHIVjDOzcEAfz
	dr6VF31+pwE2Oz1yTNnxuV7pyRUjlQH1rX6u0WgI2CHZiZN/ptS6GC7DI551IBIWlB4Z31J4Fw3
	vhFCY/7u5Aj32k
X-Google-Smtp-Source: AGHT+IH2ftzTuRheyla/6S9FsuGwyDIul5Lq8UOJqEvJlweJ2mNm9Rk7iuIHqgSTe76z8e1m61a0kA==
X-Received: by 2002:a05:6512:1188:b0:580:dda2:5318 with SMTP id 2adb3069b0e04-591d8533db7mr3421013e87.8.1760883880143;
        Sun, 19 Oct 2025 07:24:40 -0700 (PDT)
Received: from [192.168.0.131] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591deec0944sm1591331e87.36.2025.10.19.07.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 07:24:39 -0700 (PDT)
Message-ID: <3df51774-9774-40e6-ae65-7621bdce0f91@gmail.com>
Date: Sun, 19 Oct 2025 16:24:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] leds: Add a virtual LED driver for groups of
To: Jonathan Brophy <professorjonny98@gmail.com>, lee Jones <lee@kernel.org>,
 Pavel Machek <pavel@kernel.org>,
 Jonathan Brophy <professor_jonny@hotmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Radoslav Tsvetkov <rtsvetkov@gradotech.eu>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org
References: <20251019092331.49531-1-professorjonny98@gmail.com>
Content-Language: en-US
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
In-Reply-To: <20251019092331.49531-1-professorjonny98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 10/19/25 11:23, Jonathan Brophy wrote:
> From: Jonathan Brophy <professor_jonny@hotmail.com>
> 
> Introduce a new driver that implements virtual LED groups,
> aggregating multiple monochromatic LEDs into virtual groups and providing
> priority-based control for concurrent state management.

Aren't you trying to reinvent LED trigger mechanism?

-- 
Best regards,
Jacek Anaszewski


