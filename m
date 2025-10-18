Return-Path: <linux-kernel+bounces-858985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 849B0BEC69C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 05:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABDD84E4EA7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 03:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A1027C842;
	Sat, 18 Oct 2025 03:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="TLNBHNiu"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D89263C91
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 03:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760759630; cv=none; b=Yr/BO6Dm6x4D+Unl1XGtkQegg+MUWrE69Sz1bGn3au+srGd16klZl2Q/6Sy7Ih6J78SPlMxcQXA1FHvPnO1RQ9O3KQrTPIWxImoYTl0ES3Tsa66ymVx2kdTX5iIf6YCwAToY5BRGf4qLcgl2zoWEAzTuz9EstbC417rSGES4c04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760759630; c=relaxed/simple;
	bh=uHFmmTjt0vc02+wTfwAteN3orrvhT+UgW5yCHpFvPBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sjozRqEkfIDOZYIZrSiLF1f8twR7ddJIJCW/MyDlEgU04GXVMdyHtA4fIL7ruw5jinkrrIUrgnO8Z9rVaegauZ4hmLQIhMCqaNt05yW2ikjRl2KzLXePCKZaWiapvJSLEGQZEisXli3EfhDBF/zaSXukbJhfjVQYLk7s72c3KUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=TLNBHNiu; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ee130237a8so1665904f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 20:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1760759625; x=1761364425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jL0abL7hS1wNxZfx8D6u2myeTv5rkFlq4vfgdvw8ndQ=;
        b=TLNBHNiuDzl6ihDx3oDoD3+FgWz3OTYecNKL/7eRZmU8p5e872G9S1K2I2bDP3eozK
         rWAPHCLBXGS7qsMshxRa6YSqTQCWwlFQ4qxkFgCGQRVWAofJYVTj4cjQm4dgv8/WG26O
         ddFmbD1j/dKQ2HGCoIjChZwe2vaR+LTIDJJRz3jHe08AkWdRNjuzPtuatlEuZatE+OAV
         jz/QVvOw2X73brhPQoBm5Nkjlo0jKppzlLMwWciye3onbDZDNXJxRkQMv71fCzJ2gtc3
         XdCvf9JhI3A2AIWmv0tWFhknaju7EPV5k/xtGwqXpHhINL2ikRk9eMzhzyf5Hqsor63s
         i+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760759625; x=1761364425;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jL0abL7hS1wNxZfx8D6u2myeTv5rkFlq4vfgdvw8ndQ=;
        b=FPiwQ9mcSFy2nQBVUJEavhKhWM0aGw3AbncjJzJ1IOM34iuVdFw3usR4HgsuhN0N00
         TioCowK80+DZmqa06fxaa5elULskgsXU4CpFVeJPdI0wIhdSPEVTYYhmUtBBfWuyeNA3
         sOiu1VQdh344+yCp/TFdvKLbOoL9KA10lECY4g93TYVYqT3Q+olf1+WFhZ2ogWOj6org
         3qjRvyB0IM8LlZ2bHjvXIylhrlbWLQkLliqhZP35cwC7LeN4T4OlZaiNshmjSHEZhFM1
         1FWBR2iyj/YdBX2WhwLF/XU4Gjjbk2YTuBSUkT/LdIvXvNRw3lotWfZsM5ftApBAxJa/
         1c9w==
X-Forwarded-Encrypted: i=1; AJvYcCUgeo/PeGLPu4WQYyoVapRTtLFPYRKvxD2TcWaGbt22kb+pE2hDbs2KHACtJMuyc2NnNgyrzbM2AG/gxkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSUBwihlfhShxHFdKqy3hhJu83YY+EVU0wvZbkjI9cwmDzJsAm
	tQvNYLGv6CHbqOQZ2WGb7fSN+DQvr3ExkjWLkI+XPimSW7t9LrzmcCw=
X-Gm-Gg: ASbGncuUKffVeyWIzeqA+8xOhx5+xBO02vZzYivJEHmyvZTF3PmJ9JLYHGWjP8l8qLE
	DUOnmed5L+hLGmf7BAeECH1b71RPIepeBIt2Q2FyYdEV1HRXyaZ2AyQFQlwM6lrrimbpGM7D96z
	OEhj5M34bJJrS77GO5LbCGNTeY8c+yUxxJSnWrqNbrWpsfEc06UlRfDJXpImrCgFzq2etTo/v8V
	kjcTzbAY6AJ3wiYoBI5Km9V1RLfj/IrdX3i35pWVip4l+Wmd86O0coUGbLllXX3BTg9nCv/HC9a
	67EpAubS2aQt5C0UjnaxCgHaeqITUiCzGn5BGgH1NOd1yhUHqFn5mKEU5l3qCorNIMhAauo+T7e
	M8dc4Camvezf4D5ofoHmU+Av8KcUMwDTJZZTPZbAPKOpkBk/BD7BPHqXNk1pSxBwoqdEFAw3fWU
	cR4U92GgHVRMP1pfRyCpS+N4+T2jLzxEDzdc16/lmt9k3FsMHJlTZ5
X-Google-Smtp-Source: AGHT+IG9plhdnHlXZGdT4B+VnjYq+D5C7vfXaHBjqJVVvO96WoRNs1XSe58bAVVYKHVYV0Bzp6AaKg==
X-Received: by 2002:a05:6000:24c9:b0:426:d549:5861 with SMTP id ffacd0b85a97d-42704e029bcmr4428076f8f.42.1760759624746;
        Fri, 17 Oct 2025 20:53:44 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b488a.dip0.t-ipconnect.de. [91.43.72.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce06bsm2417213f8f.45.2025.10.17.20.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 20:53:44 -0700 (PDT)
Message-ID: <54f0ab53-309f-4210-98eb-629cfbbab471@googlemail.com>
Date: Sat, 18 Oct 2025 05:53:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.17 000/371] 6.17.4-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251017145201.780251198@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.10.2025 um 16:49 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.17.4 release.
> There are 371 patches in this series, all will be posted as a response
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

