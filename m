Return-Path: <linux-kernel+bounces-827959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52491B9386E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D2CD442144
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24368287519;
	Mon, 22 Sep 2025 23:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLkXlpPy"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B79F3AC39
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 23:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758582065; cv=none; b=gF/ii25eSawEW1+vjzeEh9dS0Gg7Yg1YqHsifaSr4qB+2QXcBay8xkahldkK73MYDPBhJU8kuz5/A1Dmq1bBMKOoN6pE91D/wHD+82e4Sye4riTB+TeF1P5jCY8uedPOMilkEBcSEvvx4s8cTfBbesd4YTkabqt5pkcCcFDzMxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758582065; c=relaxed/simple;
	bh=YF49FiKprncqneMObMSuDBid7JTl9NN4qkiSsmutA+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qkzdbqUQ+lVrOqb2TJiKGQI0t/2+DAV1z/V4zDxj26iuVDJPCwsDH0NyH5tVBGcfxdytb1qsaiRl9FN2sQd6NbJaDSdVYospgWLUPkc8ouV//+h3RT5k+6ChXwPgl6ioUq8MbVZxkzIru9c2pMrxXRnplCnTkdyVv5EroW1S4hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLkXlpPy; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77ee6e252e5so3136910b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 16:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758582063; x=1759186863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eeNy2aiqf1BC85NqN+Fm2fdEOmzGU7K8Kz4tZyZLL3k=;
        b=VLkXlpPyWxvPBTPGlnB1zEnHeGSbXRQ2vST1aQwTkBMgAMO7oLZWqCdwwP+mlKq8Ap
         N+tNPB7JdT2Xr6jMCxkFOH8Rv00LUPo8TwF7RLoOeFV6+tQ9fNMra3eDK0E0oe5xcKRE
         ioib/hD3sW4/6lhXl3vZtUbZB0ysGN8X013vAQemSL19gHdk754bdZ22tctGgPaoVLLa
         +Yr6EZfyf8T5ylDmSCTOLM8p6OaezJ9+rUl2LAv+tuLW0QeTlkd8b/ZbZD7VPlPX7+qq
         pc6qIdF040gBBeoIZ/NBw43osNGYEjGZWJ+NImz4GoDHAybcWVehfJqRGj7odrmRJTwn
         jCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758582063; x=1759186863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eeNy2aiqf1BC85NqN+Fm2fdEOmzGU7K8Kz4tZyZLL3k=;
        b=Zh2F7t9DSnYqdKhJorPFvv7zusENQWVUIjNX6Qr2ScDb3YohPRYaCtdRPcTIIwaxRk
         YK3yVlMgGRpPLSXse6+SvbyEdijvmuoPIq5hCk1LiuWzah3LzQO13IuQPz1r3HT3EkzS
         3D/UK0BfFKBoaET2+mePaIUJskCRDlEs/W2oh8wNHJ+oDJ70MhxUXjY/ORSGvV7ONk60
         6Rh/Hyc4DdApM4mrIap380Yjyk/WkjeECVEWyxSTh0rTWYNCAKxDtOKKGrQSgtQPFNhY
         qBWsuNLRX56347M3bOSEjsA5/37YT9y4rbOf4hRQOoE+wvuYmEQfciIVWZWpYLLiLhSg
         iVhw==
X-Forwarded-Encrypted: i=1; AJvYcCXdsggl3L1x4NAQZ6gQCkZVtXpev03j/sC57s8n1GZNSiaODU2UKHrvxGxWq3bIEPOC+AxB1am2LITJtgU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8JoHc3fj+rGjaCQLn7uU1UpO9RR36RE1jgiaDDuFBQP9UFGIH
	zWvnKQQtPIyhhznMiX1s5yfe+zFXktjnQOwj1RBre7KBPmQz3w0umBD/
X-Gm-Gg: ASbGncsVZhBSY9iRg473DloBNIt3trwwm7qj2V39NEmO1YKI1xem3QZ8+1kPGMbeEtV
	5FvC2C7QSAEgD4HSWNBdVPojroEBSakF2gjdZrjgtFnBaKsqEAQrSPnUH3bq8gK/XOvD/Feyx0b
	y/AC+NoBIl+k5xnFQOraecz1eK9qkQ3T9dXtVYYkaL/J4z/JBxwQjXn/Zud1gaEs96rdySf7ajl
	/KrWjP2mjfKsjfeH1+f1jBzNrDruvp7RTGHjeJxektanRmzZncN3K/TEY/0X6FY8XOfYxV8mUNO
	MdfhZgRiysc3k6Xm72vkkNe0AbrdP/9O9If7JhAci0UkMv9SWAWN8uzA4Z8kRXqYTxMozcPn5pR
	IkN2NO/eFS/nihQ0b2Dq9sSe83kk9e4zzLvApPs7VVTEIXtEpHy6DZqob+HhvUPF/iudzxMlI0T
	/1pB9TyhlS
X-Google-Smtp-Source: AGHT+IEJUpXiZJYpDaJSVRMQpD6oGixikoujh15zTGcx9C53XnFLYqY6WqAGmtYFnuvTNfHs9MT4Lw==
X-Received: by 2002:a17:903:1d2:b0:267:c8d3:531 with SMTP id d9443c01a7336-27cc48a03e7mr6204565ad.25.1758582062572;
        Mon, 22 Sep 2025 16:01:02 -0700 (PDT)
Received: from [10.255.83.133] (2.newark-18rh15rt.nj.dial-access.att.net. [12.75.221.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-271353b8792sm80534825ad.123.2025.09.22.16.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 16:01:01 -0700 (PDT)
Message-ID: <b40b700e-6bff-44d6-9cbd-0a208889a40c@gmail.com>
Date: Mon, 22 Sep 2025 16:00:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/105] 6.12.49-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250922192408.913556629@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250922192408.913556629@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/22/2025 12:28 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.49 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 Sep 2025 19:23:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.49-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


