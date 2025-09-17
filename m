Return-Path: <linux-kernel+bounces-821804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C25B82531
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AE282A8844
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 23:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50E1283FF9;
	Wed, 17 Sep 2025 23:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="d4aj0Z1y"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A43127FB03
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 23:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758153215; cv=none; b=eC1J58jz8HsagL4NfvySFC9KZqF4AxLe0PWwPz4NvRso28wT5wRsqp8fmYszoCu3wi+83sta0LAi01IzLPLzqApBCbi2ZCzaXMes72/IpKTg5KuBG6KMgzJTRLjGX7toH7N/lf43S9y6EtO/yHedpNhMmfg8MsvTxVPEOI5pGoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758153215; c=relaxed/simple;
	bh=zHXhaxfq8txSsNL6FuywZq3TbSULGj8UT+faA8DSrqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fAFsx5D1GQamWAQyKm364YMszYaTGyxVfIU6teZhrvG6udOOJL7BRO6Mev/Uu1/zB/Hz26051I82hgjotqbawC5qOqgJUWewkYI8HzLfc4ltr0i3pGUVGd9p19ud6Tr/ix6+r/Jbcy4wI/L1zjYr7OfNZvzNSHxgtS1yju74AYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=d4aj0Z1y; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45dcfecdc0fso3462425e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1758153212; x=1758758012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fH3dCOcwPC522SUE8y5HpvFj5uDFCkjUJfHRR81NqUI=;
        b=d4aj0Z1yD4MZHeQz/0sXuQpRKfZ4jA8A0+ZtielwaXmtpTizWn8No+jhczTOzgBj2S
         F1Er8CHqZdSvKeV3fSPXhfKdR1w4UFklQ6qUGbM7lsM9o7odb2lPd902whKeIdvGpvD2
         qHvuWxrCVA/amHZmjwyf9Ns1GlW+X+DuD4oey5FRfxr9eGr7q6Ao+VaSQBtx3TPi8QhI
         wc4M/tLH6S1FK2iaPtxYHLVaGiaVCfLJ8//JMUm5UXoIJjskOHK9v7dmJtfxRAqlehdR
         3aupgWVC2JEbq9jvZanhuPWPJsT1fYlivdJQm16w0aNbwOLEPQcnf7NMb2prJeOSrwEP
         L0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758153212; x=1758758012;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fH3dCOcwPC522SUE8y5HpvFj5uDFCkjUJfHRR81NqUI=;
        b=PwxA7wcMtTg4SQjp/z1T6Ig3X8XHpA91uTaPN04rtFHiY3Ln8bv6EJEWlQ3p9gAMG2
         SzMsbYABYmCPTG6bf656FDL76nlxt9ZS4nPjFIAZk2yaLpcSU/m1I8Qh7oO4rn6CTYnT
         CtzuV1lCV77AvLjMaazT7BGtsI3ntt9wQ2KNHJVenJcYfZY/zVjc9mtSAfpEipKQ9PEU
         U/l4EDPQgr0WzeAH2Zq07wUx8u6douaSvPqr6xXNmXzVV6eWvMsnZ/mleCs7ywtkwWZV
         aN4mAe5Ecgtg/FSGX4jIJxakB8AJ+Uvt6EUYuB4vRgIql7z6/x+cAOFcSVEaeqjvL75L
         pGUw==
X-Forwarded-Encrypted: i=1; AJvYcCU0nMSzSTv2iGxFDfDD41ve27Fr1EuO58yVwevRIk0onpiCeOHMLOfHsLCdNaqRj9SReyUaTCY+vnHACzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Fh5OLb6Y83XmOv1yaWCJ2UER/sVY+5fbPDorZ701dxsuAU72
	QH2V4+U9T+eymn4olWziOh5+jRbSsGQq/eTKg5rbVZlRLmgr4knEU1M=
X-Gm-Gg: ASbGnct5uiE+T5gGlcJTCJDM0c/SRuxOFUaduGuBP7POAM5leXGl2E5Wvsz4nlT0swj
	CGdVDjO+D4YiPtBSlNxySVb49qyFGWdZ3MjAHNhSzda0ZHTyM30MZLkyk2Ec9zNpdUTEHwoKRDn
	chIxKYXlKD7iodLPSA/Z+XWByVy4XfTwWzsmfs/9mx+FeJHny/AvVoLkgZ2T4PXNNzsHXlsIDfR
	Ae56NFsc/aL03fwq1dvD+EDrZZY+HuMWcBEM4HHm/683HQuUzByGGnE8mmA0S6bwHg7OaAA9JQG
	bHLUzt8hQOx7XcMm25QrE6DTXPQVOobkhRx0ss+5I5G8tYqGaLf5hGLXaXgzaDulB3tPMJM5XWb
	7/D7IxOc6FQ0ntOWUAi0oAThbdym7QN1sAxFj8pQWmYzJOGn1zJKud3M0/JgplzO/dQdLdavIJi
	8wdJoClvjm+aPhwMJB2Q==
X-Google-Smtp-Source: AGHT+IGHl+QODOErTNJaVKR/wtb9/LJeotK+VcYJyj3xSaimjfMW6asZkiXk10lZ2ZIxdq/EFGb6JA==
X-Received: by 2002:a05:600c:3511:b0:458:a7b5:9f6c with SMTP id 5b1f17b1804b1-46202bf80d5mr37445935e9.11.1758153211721;
        Wed, 17 Sep 2025 16:53:31 -0700 (PDT)
Received: from [192.168.1.3] (p5b2aca14.dip0.t-ipconnect.de. [91.42.202.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613e849a41sm55028755e9.20.2025.09.17.16.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 16:53:31 -0700 (PDT)
Message-ID: <e5ec3508-6c54-4f52-80f9-1fc4b04755e0@googlemail.com>
Date: Thu, 18 Sep 2025 01:53:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 00/78] 6.1.153-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250917123329.576087662@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250917123329.576087662@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.09.2025 um 14:34 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.153 release.
> There are 78 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

