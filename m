Return-Path: <linux-kernel+bounces-874815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5591FC17273
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45A6B4E3F48
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7614A355818;
	Tue, 28 Oct 2025 22:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="GJ+TnnpW"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484A02DC331
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 22:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761689525; cv=none; b=QOYu23RotYupMd4eNjnbIRvUN/WmoV7ReNutkoFYXfWoEnoFflCvVIaCMZrtjhcCST3DIIXbDlZm5ErJxAMB5ldbQTHajRR8XfxfN5Cx4QWK4W5VHGqZuvzE8O8lZJrMW88nZITxOZe1GzkD0wRvnraVX//lCPDv0MGp9wdDddA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761689525; c=relaxed/simple;
	bh=Qx1dpR4Z5VFWuR4pe3KjnkMHzfKUXq4FOnh7HstojfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j6dSr0HrFFtsSigoOfCtSwRp+4HcUDOFph9THJ9TJr+lbF6dREyjcICjbCMaVNMVwND+KG3E7qJA6v6Q7m4T/oo+M5zn51wKIB8DrTve87ah82EL870kkwHcnvYSSDWu3pNdMyLvbhV8xpmxeg+9fPkC+Wt5eTK9/7UXTUVFaQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=GJ+TnnpW; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-89e7a7e0256so522888085a.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1761689523; x=1762294323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yxf4SgMlhljxRfzO4HwJ4G6Vr60VuBp1eH0raIEYlEY=;
        b=GJ+TnnpWJECo8on8a0EzEyNI8kQM3p9yFbaa7njuGNHSdMpZWESbpQeHkImzi4MUCl
         gGflV8QZ5KziWsONsxqgiExYx+U64FQf5Ja4R7uVrTEbUIY5dHM+069MUl/696YdkMFc
         7GFQFrmekKKjAvNR/Ax3TW/+xM6clTxslehW4KHiiF3lWozd4rwcGp+WW5vjqLEZZA9b
         hJmsh09tpTERCvIWl61/lBu28EQPPOG3ABOA/gKfuvN5PhSM0iKadJo61d/p2U7A+6UH
         by9+msMeV9ekPFFqsqifJZ2o0NIRCzv0UcLkLLqdXXrIN7pRTNXhpiiAkgIkOlCK/RBY
         X9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761689523; x=1762294323;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yxf4SgMlhljxRfzO4HwJ4G6Vr60VuBp1eH0raIEYlEY=;
        b=CzCp88UNe2Z86OrXypfSHKONRRSaBK2LIZqWuEJzgVNOaRT/SpyxGhZti0xJV3HAWL
         5i5nW5UtEi1xGKSiQF9HIhuimrGs3C3Gv3BnTPmlPY0GAkLTCLh8N0rzQKdoqxr3uBU0
         FnjBtZu70AYxGVILLP5xwyst87PjjzmWw9j+fwuEK3TdK8z8/M6t1rA5itz2LSoAR5pe
         vAYuTaSV7zK5+U1I+DE6vpLVOk5SHe4aOCqMEvzObBUhJgMSaK2uHDAAG9dweTwZ+sFz
         F9/ycayuJhfgaqgq7HbGwGpBsdin5uvHNz4WTf5bITxHY/JcpZz7auhdm3UgTrvL1ki0
         LkHg==
X-Forwarded-Encrypted: i=1; AJvYcCUdHjnkel95GIzVAP1Uw4+B8TgwyUpjiOwA1liP6ORDPeM+8FJ0oRcbDzRKUzm4va6u5c0qbYCSj5OqRyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV1P+8Pmcqjfwc1AwelDrD2y7qcNhqZz0gnsvwoxoznAYILoLF
	/Aki6qxVD8LXRkIfpFbHUqR2DwrOo7IGZ+TKF9IK2pPMt1wgpRxzakVl6+eENLugmRE=
X-Gm-Gg: ASbGncu2Phl2g7IXnNkdU7yYJI+SALsk7LRA3rkJhEADt2uLTNYVwj0AKWaurf/c8YD
	WZ8FNhFohOh1rjndi4WLXzT3jd3cRieBslU0P+gpN7NKa5fon7GeIktou+ynr1RhVt2y0hoV5Cv
	J6P5Tn8rHVR0LMBgQHHD6jtr9+dbqWZoy6w+UZkVRff87g/wc13ZW5KdPiF4IJc3zMyE6fXEkb+
	xDyKH4sG39qj0MiZfP/O/+X0g4GjR6Io0ej9iaBj7GGh8oaa/Fu1tDtSjRa1U3YODmHLLYgHJxX
	O1VIt7/eO9Jlel+7t9Tl3DeWNB8f6Mg8M9SSWFN0RdU2+w25a4mTpH2qfAJANdj0ZI2zva5C4PR
	n0yRdsK0oQloX3YPmb1iCxjF6HUZ7l7prrbOksCZN8wyGU3Ysl+zFq2qPdp7F60VTKQuGhIXS/D
	h/Y4zIdohwK4xY/g==
X-Google-Smtp-Source: AGHT+IEuxLZFeeurzwWASjRayjwc5R+HDg5nYPnfTfXlcqnJxlxd958na83WIBclidyoi5t/YfRt3g==
X-Received: by 2002:a05:620a:45a7:b0:8a1:c120:4620 with SMTP id af79cd13be357-8a8eab66367mr103423285a.45.1761689523165;
        Tue, 28 Oct 2025 15:12:03 -0700 (PDT)
Received: from [10.10.13.73] ([76.76.25.10])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f251b8a24sm892468585a.25.2025.10.28.15.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 15:12:02 -0700 (PDT)
Message-ID: <2242a1ea-d6bd-4593-a884-3c28d8037e1b@sladewatkins.com>
Date: Tue, 28 Oct 2025 18:12:01 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/117] 6.12.56-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20251027183453.919157109@linuxfoundation.org>
Content-Language: en-US
From: Slade Watkins <sr@sladewatkins.com>
In-Reply-To: <20251027183453.919157109@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 2:35 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.56 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.

6.12.56-rc1 built and run on x86_64 test system with no errors or
regressions:
Tested-by: Slade Watkins <sr@sladewatkins.com>

Thanks,
Slade

