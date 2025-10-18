Return-Path: <linux-kernel+bounces-858962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9EDBEC59C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 04:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D2A19A83F3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 02:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7DB24A05D;
	Sat, 18 Oct 2025 02:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gOOOjBIU"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AAF248F77
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 02:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760755389; cv=none; b=bnj0FgfdH4oJGq9u/nAB8q3U7mCeBgH7/hUgsljD3JO5kdoTK+d5fcYzxl6L2w/fV2Uibb0jmO1DWwNb5WdAME76xfCSae4iZLmrbDf8HbrYNKms6yCp8BTIct71U9g1J9tXsioj+KvvNNghgn9kZ8bBnbMRnx9Tmsq+qRZv7H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760755389; c=relaxed/simple;
	bh=+b2DvE7xTQ+YplYhEJssLncHPzlO3qrdo1+/WrFFXQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vEnlYg074BKCSnc9SJsGxgAMCar7eZpKVn0uMt4J5PEuYEGFH0c8K0Yz8bPkmbCSfYtxyTz4Jq2jQt5XnnAnG+/VGxVPwL7q68VTWq2BNqe4GPqNO0WIgunaigV5Jwu+ePzSqBZDfpsCVZO+nZ+H8Wv5fsW5oHEbxBwrztTs5ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=gOOOjBIU; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4710683a644so23363075e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 19:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1760755385; x=1761360185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KedOym6ANAjmntB6MdnT69wUxSKMRmT+YO6XJ5I6B+A=;
        b=gOOOjBIUkUvo1jjrvQixoM7SbqU7Brmhj41vhBGQ+h0ES/WIdLtKTScDalZ5c+M1tR
         gaAwrCLrMeIAlzpizY4Y7C2sI8pKQ84pDnHocv6wE/bB0kdKVZRxa7Iuiky22lFdhaaz
         ZTLK62LWDSbjqfnIHYWiFtSoxJQ2BzEDASGwAL71i7NkKBgDS58GRU7JpcWgWjvr4aoo
         k5ife4MRT6BPjs/hn9WwzCxjp89w4hZGE5j0ok/4PtlrMegT69Z+4bDUX3KxreMXmgJp
         SbPHe1n8J+AIj/XuiTYKrWX+MUKQuz0qhQsoYxyAObOfvl1dD3t0nHXhJGxq7sgCZito
         RFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760755385; x=1761360185;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KedOym6ANAjmntB6MdnT69wUxSKMRmT+YO6XJ5I6B+A=;
        b=lpBcRRKIOZEyOrOM9JEEuk88mRMU+6hWBzUJaZDClpwsLNK1QM6+UnYLucpuVfwVQ2
         j9i2juVNktKNcXohRjSsSzXyzbk18qUmwksvQmX4kjTUV7kUmtK8ULyYjf+tF7P6iq4J
         FqZLa+DDTbttzq6XYkrecQ2XQFTHlFLveDPo42QtiWq7b4J1HhHprLI4EoEiZKOfyZt1
         y93MiyYZdyVxRaMwzH/WNKDsXVrdS7cJ6yqSf0RxJz7VkCVjAjReGRxBlP2A2C7DX/E+
         ATgnVTAXCAnZ3fsyoGQ+0yCGgLfgAJlsDMqOxEpFyhJm+68D8DuK06jRfJ8641Kyhgsw
         29WQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXkyOWO4BK+EPnGbb9iFzQxP5jpnRHxKetkiG0s3Ji38bkUF+ibv67BwCLTDfK9dJMxR0kH56m9bxLdWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgJMages7ezLxjrChSOXJ1S821ncx34QqG9EUaBCEeGBCGUfxw
	vsvqO3I+jKoAf0D61e5ePvwE6+1z6FBpZ4rJNIvQnwfy//HMEamWh2Q=
X-Gm-Gg: ASbGncuXsFAnoynTBANQTWpsqUhfgPOqdJu6CdsDMjw7rU41RDO1hryPUQbh0/OPzgD
	tZIYzGLbRqFRYwE+hfPUmZWAdlUaMiJNgJnFZ6W+kyMGgWcXCX2PfJlHzwpitBAl5YKRm7Sj+VD
	X8CUMInlokmz/P9Puc/ZOa/TnYI+OOrMH2jaXc+L/3nVNX4n8oKntxYoKYaY6YQ1oZnVYFeYnMH
	g/tV/qdS3Q1P51UAECQA63akjHCFJu8pFqsZebeqg8vIKABDmHMY89VCqj/2IwCC7tjfVW/Iv+k
	ix0p/ACe0W49IH5IYAGsXmRAYZFl14bwr+BXJ4/V5gEKakz7w0SDU6Vx9N6Tmdb4YxMaFqrnmvW
	LhuN8lgqKQ81nwJts5LwpGi3m9/879XsYlEcZWzxlEMrPxeoU4ypyauAVMJ6I2VrOgjiGPc1h3x
	/TIQqsXF/qBeVUswoKfKmNoU1EL1OCaDG4H7Qzs1OYhBrmVlE9PX98
X-Google-Smtp-Source: AGHT+IHJCQEarLyt9R2soYu4NGJRlr1qtMl+VxBgaRp4vpWrXNohBal3V0rIJ/WL73KWrYBnM8te3g==
X-Received: by 2002:a05:600c:190f:b0:46e:3b58:1b40 with SMTP id 5b1f17b1804b1-4711721a479mr46610845e9.4.1760755384377;
        Fri, 17 Oct 2025 19:43:04 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b488a.dip0.t-ipconnect.de. [91.43.72.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4715257d916sm21954375e9.4.2025.10.17.19.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 19:43:04 -0700 (PDT)
Message-ID: <8cc5cdfa-e25a-492f-a75d-38fa14961ebd@googlemail.com>
Date: Sat, 18 Oct 2025 04:43:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/201] 6.6.113-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251017145134.710337454@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251017145134.710337454@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.10.2025 um 16:51 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.113 release.
> There are 201 patches in this series, all will be posted as a response
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

