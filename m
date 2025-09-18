Return-Path: <linux-kernel+bounces-821942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01742B82A99
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 04:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AACE43B165B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1976D1F582A;
	Thu, 18 Sep 2025 02:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Qqk+obC9"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09C6207A09
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758163042; cv=none; b=PprNSNDXLxhWJmp7L2S4lDOrAw/T5Gfv+GW8jcBPBrGLFfhlb8eBpVjYkVKKgCdjxBWyW17Zi22dI2DE6rWIOBjyS+00ThIQmit6f8E/zM3fmTkw7x0E8TJFA1EEPRQ+ModOr9Tm789rGX7VNsBXtlhat1Dj+QnWaRY+Xv2ymi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758163042; c=relaxed/simple;
	bh=/RmeVzKahHtJo2SWCXkMHvjzkXNAmF+g49TikYNX4e0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MzYJ/cCNz5cKh9e71oCU57EXd/LqWOFZZ0GPxu/qvuBACQbrOHMyfrXknkugemXQz/05yZP+ji7PKTu7qfHgyWS49OxxblO/q4MTcbvBvk4vB3OvgHHfo9BLg4wIM/liyMc7bvxpEOeEa6hNwZVv+4KHYmHcfZST8/++jxZhiSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Qqk+obC9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45f2f7ae386so2840075e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1758163039; x=1758767839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fjmfvrARMUerFTF/Av0OXp1QJYcVrIvm8qLnxUg6tnU=;
        b=Qqk+obC9lavET/uOebLQ0S9F0XgctGJrj4XtMn2rQSDjgkSHnJaeDA2MqLzOvwqkp5
         A5xvn+RoH3XUL3wiPgaezzXhr5v3tG8MhdUztJND7sa28tdCl+ytdG6jc51WVcOyYCwM
         bfXgivNKcFw9LqRpoz9k/O3zCMVLE8KDFda2FupqmX4oNSowFOddnNxpNfXxg1pVnejJ
         5+/yaNvYBuPkS1CIAerI7qSIrpWz0qetZYBKD3VEiMKg8NKHF5LYzI8Ab1cvJRZOm334
         oCLrvJu6m/Cc8d7llmquPU6yyaxZYhEdIGyZT5z8I9cDvDq7kr9LjhznZ1blVEhHMri+
         fwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758163039; x=1758767839;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fjmfvrARMUerFTF/Av0OXp1QJYcVrIvm8qLnxUg6tnU=;
        b=HxyrzHSQ1TSw42ghrqzOtsZo/ZT9tr6wf1UrDdns0JgUbJ355L8ozMmIS0JN/claGS
         wq8yOsQdqOG+j0/PoZaYGCLqM1e804ydfo8K6Gnw3fICps09Oa6klrYlZY14iwf5Spv9
         Km3jYym80U/Lsvo0Vh0oYSRRr6IzH7J8Bp87gFaN8+8qtMYxMR1gAmdxRVKGO14hrmq3
         Ikk920T4KTt7AOICWkuUyaebWw61SLGjy63QGdhlspIDnQXyzvyEcvjL+D8v7vABw31x
         Sk63A4d+noRUec6YxfzyoIkuUWhcha5UjkXnPALepA1tyJd1/tZ4N74h/b+RnpWEXeeq
         ik9w==
X-Forwarded-Encrypted: i=1; AJvYcCVY94zscQnfD1tYesOcP/139P+yTI8syWCaLqy0hALyPZDti3xAjzrNPyAfYz0WyrDvnVNJdghAdDr3Qc0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1w4EdXA+bIrh9EvWxZbSU64oBKEK0XQBOPtvTwNFGi8EbX6Oc
	LG9jU0C7gPvMdWH2AyWTXEwrVQ79JQ6aW6k5P6ZrlH8ykCSbNdMDrs0=
X-Gm-Gg: ASbGncsXn0ZeytVnxERJ/b10okpym2LaJa6tmRroA/VbyHUQelRBB3PzwnJQhCTRsD1
	5BiSXYx1aoaJXEo+pOC2DJyGRdPcFA9r7PuigtN3kmZ+5+zeu4mN5mKvGk1KZtv40V77065IqGY
	+obdu/KIsdWsmjdxrrZEAzCyjlJPPqloyESOjblcBVR79Ys4KxRq4AJ54Dnwr1hX/OcHONJpJm4
	oLIXH/bXgz9OQML4VyVUQkF4A9AMLbSKxQfzBdFQiHKS4w7ioul81dddTLvzGeNaaWgwY2KH61C
	zqkxZctS7mbyTH5iWGN965CzhqRbRvqxFoZQUm3rjG7JSoV5xFoBihvhE3rSWcB3/fKhfEc1k1k
	52VGZq7k0fOIehNVpDb7t1ThJmqKl8JMS+0e623/UpLAlOEe5qR9cl3UOgz2faRBv3ug5Da+jq4
	EhEf5y7kHvcSvLke/gAA==
X-Google-Smtp-Source: AGHT+IGn6j1aWgeloupj38mFaiQ67C35ZVmcCQIAnn87KrIGpYLIopHIpRfJigBwx5QOkKjktWdsDA==
X-Received: by 2002:a05:600c:4686:b0:45f:27de:cd22 with SMTP id 5b1f17b1804b1-46206099d94mr45865045e9.17.1758163038940;
        Wed, 17 Sep 2025 19:37:18 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b40d8.dip0.t-ipconnect.de. [91.43.64.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f64ad30csm19916375e9.23.2025.09.17.19.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 19:37:18 -0700 (PDT)
Message-ID: <4ec95f82-da65-4764-9a06-b2de6f06ec00@googlemail.com>
Date: Thu, 18 Sep 2025 04:37:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.16 000/189] 6.16.8-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250917123351.839989757@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250917123351.839989757@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.09.2025 um 14:31 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.16.8 release.
> There are 189 patches in this series, all will be posted as a response
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

