Return-Path: <linux-kernel+bounces-864914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7967BFBD7D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6470218C2D8F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F31233F8BD;
	Wed, 22 Oct 2025 12:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="AOsjwj61"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560C434321A
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761136088; cv=none; b=iP5uXFmQLpATeTJPp1SPwDwbSLgmyBSTradWNFCN+EEsaBtkgkfmYr0nToXK7JUJhh77c3qYo4UMeJtM7s3103ti2ylcBNtprAdse1Qk6KdqZCTyFMya3DdAUYStR8c/Q1PxVeAA5VXw8fJUTZihhhnXn2znKbAx+IuUeLcJs70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761136088; c=relaxed/simple;
	bh=Iejn0pWjNdBJA/skFH2+V/JvIaDlDJ3P1ZCkLVxJQvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ExtWyG5YOM1eIatjXBNlIcZ3J7yd6CV/EciU7ek/f3dpuqCpKdJ7tiSiMEhwotmtAuf6PnoyLxOlPEulu5IgMnEU4ob7TIivrhkwRVp0dPKf3+TxTZEIlt8so1AEDyz3Ijuqp1QoDqCfHSDojJnzTTS2o5p4tR0Vx3O/otloR1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=AOsjwj61; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42701aa714aso4102605f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761136083; x=1761740883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WFbuSQX+6YT+HVJbPcsJSl2m1jB0KH5oX7eFGxAFFNQ=;
        b=AOsjwj61kMGZzbmE1tQnMGq5K/0JJ982cQIQI9j41XGJLYVjYXbL4SyedjwvK4pja5
         GCp3K2vN3S6bo3lkHsvcYgm4UzeHqpIc9+p7TX5WzAZw16ue37frIp8cwa+olGG24DWz
         ZGKoScaQi96uYIa786DqMlV2YoSqSPcz6Qt5/yFXaYO0QZ7O+upi82fJtLVveA+0PMAE
         Qhj9DdrDG2tHoBtVuxd3KjBfXCV1nedA+6hnCS8CpWNdYmlTwK1KjQBANCL5uiN8wudB
         CqyJOvA8JlqVUEkQwzoUgo0zceRFaZa90zvYAdqc7zdomid7VU9xsNkN3ifVU1LE8Q6X
         SHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761136083; x=1761740883;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WFbuSQX+6YT+HVJbPcsJSl2m1jB0KH5oX7eFGxAFFNQ=;
        b=vWaev9qPFSJb6HSsvSXqUCKnwk3LoA+hLJ38kxEDOAbPahyRaOOV3/ckfmI2prqA7r
         AGle4G7KZCfNeUFjvrrC++BJmfyItj4XvVolXIIX23qNYi45zucfKMJM2yarqn3VPjYg
         +usi1xlDAceU25dNWkpmTnWwtp+yDU1DD1342IPhq07E26q8l1/qmMFh+1ICEA0FCJII
         IX2pvcnXVmO4oKdn2mOzcnzsTKnJE3KZUVonxt02wrgHMlsLKmyPZmwJjdm1dj15CnFi
         hTIUFDZ/utZw9WYUNfnIh+tZnVwTzfc+05l0URJIRIicmAFZd2rfSvZMKZDPDt7a4o+Q
         CkBw==
X-Forwarded-Encrypted: i=1; AJvYcCWBgv5JyR/CC/mvFqJSe4b5vYIRe9Lwik9I71mNT8yMSZkVDN8I1KsjNDsO4mLgg+1Ti6J7pHv153LCQxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhitL6VlkI9k8oT5rFHzpHffH07R61Z0+4a7x4DA38iFxT2l8c
	InEOfObPuhvebfKmIz5/qATfqhYbv8XYfI5+uiRA7buFBjT7aJOEkDg=
X-Gm-Gg: ASbGnctClE4FZvbTvNpx3WuJP5PxzdzY42MuiREHjRlH1EJ6yZ9IT7Ghxfcy4x6cmOJ
	pcsL20RWG+jzqmdMIsIZ6ynt0SN0iXf3LkEtyELlil4CqKwOtV98pSFoc/P055iczICsRi92vDS
	fnnd0oLKDLw8GopR0rzaViRJnRFQItJqpFK5M8aWtVCFx3ZK3WN6gFLejjFF8CfvmkxbaF3la9t
	lfUWipi4vS5E8JP/IjVYBiPjKWy2Xo5CsYh/W63oBQSuyuZTkcTetmDUccRACzEn+QgNa4LHyGs
	p+GS6hspcFbGWr45R8s5QzBYe03uG80SfCexOvGnFDURCvxYP0gRkwkYCszYefRLEIt7I0tRahp
	SuKXQp02BdfHrPcTYdvUBbUoXvsELwP593Sw7aWrzixiZVDjGm7fnkhfdFq0tR4/NmHLDCIp/OX
	bclwNtibsX2HWaVf9xAdvj4/cyliJPGE/1ZwwZw73LKqU/5w8/sl83q+Z9F15JVA==
X-Google-Smtp-Source: AGHT+IFzalpz4I7N4GW5iAQvE1IHT4hcwYoMkH4rdlEMLAfJYgGKj+R8HqkyYQFmUVrdcF3vsI9GFg==
X-Received: by 2002:a05:6000:220c:b0:426:fd63:bbc0 with SMTP id ffacd0b85a97d-42704d786c2mr16326022f8f.27.1761136083310;
        Wed, 22 Oct 2025 05:28:03 -0700 (PDT)
Received: from [192.168.1.3] (p5b057850.dip0.t-ipconnect.de. [91.5.120.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce3aesm25354082f8f.48.2025.10.22.05.28.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 05:28:02 -0700 (PDT)
Message-ID: <7965a547-2267-4f09-af62-0b81a2d8dae7@googlemail.com>
Date: Wed, 22 Oct 2025 14:28:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.17 000/160] 6.17.5-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251022053328.623411246@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251022053328.623411246@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 22.10.2025 um 07:34 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.17.5 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No more screen problems, no dmesg oddities or 
regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


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

