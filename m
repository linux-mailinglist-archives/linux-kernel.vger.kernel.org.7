Return-Path: <linux-kernel+bounces-895502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C30C4E1CA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E7C1898306
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211E0342508;
	Tue, 11 Nov 2025 13:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="sXqvJ2hd"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4C134027B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762867819; cv=none; b=WKxGD0wD3Vwsgv+5pMK8/qD2iCwIIECZkzOnWrle+4ZT1gMkt8CH5E4bb5xYvYc9k6qfhWn5prPBwN3cGr2FuB7EuyJXTZAmWLaMW446Y1USWoKxDg1uVfJw6Jg7jFBUyAkxrtXMQPFUSoLOPTSQIw2Qbh7Mck4Yk4VfgZyU7OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762867819; c=relaxed/simple;
	bh=qDZL6MdNd/KZflfycs2sNvxaMjuSrNaIyMnm/7WrZ8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O8cOo+GWgunwVp3s0d3yrO463A+QYJJ6O1zzywMhZJFjT84UM4ScrdtdBmeV3bB8rLqTo607Kz/+W5FNM8WPI03JV9d+cKb2c6E0Qs0VkCY5YBPMUBDRiZLGECjeatiJ0yMVN5eWFQCvP6mC666ZiTRb0XPhgxZNSvgtj9hI81o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=sXqvJ2hd; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-43380a6fe8cso20417705ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 05:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1762867817; x=1763472617; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4YO/KwJ4FC8gmOpZBF6DOQfsCk0MQT6p2iYft282HbI=;
        b=sXqvJ2hdrrY4jGEbqz4H7pAMGZpIG8Q1EOPl1L+3s2EBVzVVx+5Vw/Unoz28OT6VSn
         RhpPcdLepdmDQBSBbFAfC2plpIJJ+rcO6wgY52EsLblSGwxwRiyFH6gfnprzx1wrLHDq
         az0RslmwxYFc/e+oHS91IJjpAto7nlPBpIBhekhLsbvfqWfDXqAJhkb2Ggmnzr9iCE8k
         aSX/9TtLdUHM8H0bwzMtmJvDi0/gIUU+IqH4Vg2Sfr4Y6vLZtQtRIPsxclZwESH0oIbG
         gWWflJS0ToRjiVUb43HRuFEeeKZ/1hM8oh63w+JR/a5Tpsz3dG23GItK9VsX6gjZDkGi
         mYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762867817; x=1763472617;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4YO/KwJ4FC8gmOpZBF6DOQfsCk0MQT6p2iYft282HbI=;
        b=TIBPWL1F/QgyXbXt5+yc5hiMT/biK39iYuNSavS1diTdMiX0nXGwVvhYZ842f1ZX0N
         Q1F7FqQi+06tEri5yQEdwOxHbgIPqAVDFN5nA7fT/tqTGk9GALyY2r4IqEVPS2OnLkJQ
         WROIila7D1RSnciIEezhhRWwXM+9viTaLcAKou1J6oXbbI2ogXum5kS8FB1X+PP7Rw8A
         dweoMGVet/BlgEYy4/TOzxkaquAzvhqEQpuFxDiWynCaiWWd9pGgFFbGfghHZvetzthI
         UUEdtotKAMgllDR4mhZ7c5xEkCXUfauTDe+aKXB6KfsWJnotpJH+Oc/vuxphCFRkbea0
         /PrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJs9lcR474X1NgJLjZZS+VpnL12FcM617s8rgXAjOYI2JPAyBEWC4/5NXlTKcyMj0ADEqGesB0ScfAv20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzilht2BGdaoShYvhTkk4jBMWHrwLzU0jcnuLB43SbSUvf1mYWx
	jchQ2rWDf4YfkZI7o5n3bBbtN8RGS+gwpwpZE9OHcpuJbh0SwyfhbPuAo+A3gNvzSbo=
X-Gm-Gg: ASbGncsMB+c29isFcxM9EBXznurDm1PPsVneWABAQudEjRTQexh0Lz5L2/nJnxD3Hli
	aMwtljEyjnj7ShSu17pxSZoSaUQlioYgWOHh2aJ8LNv+Oy/ya7pCaYtYThkRt68lcneWlPlzQ8a
	ZWQdYmq9qushlFXGDeLcFDDyZ0UyNO94VyqT0SbUYCHZSXo+NKhuQnQdVzLnKycnrgqqAu0nk5q
	u5xbtL75eVLFcV/pWlxu/dvqrizheJW91n0AeBma+bJ7Ditpoy/vkem2Wf2qzwIdxSw/kB7DvUQ
	LVvDQA1e/1yY+8YXhxaQBZkINUotnJi5xzxDAyWiHN4ft3ybnv6XGacOzUIgKy3xAiIil4mFNKc
	qDwv22f6NhRbkH9Z390vUESat980GTVJpqsLxAKW0uIRh43aBNpqvg22FmkuNGzP+8rxVZC74TD
	h/VYO90FBKLNRcSuu8nhOmvo5QpA==
X-Google-Smtp-Source: AGHT+IGW7t5Sia4TYMC2RP3zk+pxpMo/Yir0L3mxaMYdOdYqoFxgBtNrF98A/H3TNDJQ3xWRjsTrXA==
X-Received: by 2002:a05:6e02:12e7:b0:434:720d:1c2a with SMTP id e9e14a558f8ab-434720d1e3cmr5300985ab.20.1762867816968;
        Tue, 11 Nov 2025 05:30:16 -0800 (PST)
Received: from [192.168.5.95] ([174.97.1.113])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b746923a66sm6246780173.35.2025.11.11.05.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 05:30:16 -0800 (PST)
Message-ID: <f6bd6612-b0ea-46ee-8807-bce12c040b5f@sladewatkins.com>
Date: Tue, 11 Nov 2025 08:30:15 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/562] 6.12.58-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251111012348.571643096@linuxfoundation.org>
Content-Language: en-US
From: Slade Watkins <sr@sladewatkins.com>
In-Reply-To: <20251111012348.571643096@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/10/2025 8:24 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.58 release.
> There are 562 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 13 Nov 2025 01:22:51 +0000.
> Anything received after that time might be too late.

6.12.58-rc2 built and run on x86_64 test system with no errors or 
regressions:

Tested-by: Slade Watkins <sr@sladewatkins.com>

Thanks,
Slade

