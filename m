Return-Path: <linux-kernel+bounces-842181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B93BB92AA
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 01:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84DC43AA973
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 23:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653C224728F;
	Sat,  4 Oct 2025 23:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="aqo1KiFP"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462023594B
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 23:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759620927; cv=none; b=Y3C5MxqzPGAXjHNV4U77Y3TmBbfN13sPhzHA0zdZ5hD+JJQX1CotXRbSNkEcQlEHJeUogDafGrWcqY58Hk8jjOCwo71tXbrSW4MqBFPvtRAHtxsUS7ttNOJK4NIzwQCZdmhEV4TxysaAYjPMa7Bd33V5sB7SYOpYYZ6EaJpR09k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759620927; c=relaxed/simple;
	bh=I0RuDAZnK67fDIvuvo7+j5OVjOlB6bei3TOSvnVvfzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n+29jA14YVVWvuPvP7v2eOqrUSBAGgp2aDLSUjhOPOWSAfEVbjtt+7clX/Sy5uN3SBaxxiGAqtgjU3sSh0CdcCrUgWDztqdz5LVhB8VXFU1WYz+HrIXCQ6akM4RPHhMkUTg4WvqHuCzulSq2wkEBmwBf4qhP7/nAKElsbHnVNzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=aqo1KiFP; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e3a50bc0fso28791945e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 16:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1759620925; x=1760225725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DC/L4mdd1OngyUYeW9NdFnDzBjfqJNLL3d9hdta1f0E=;
        b=aqo1KiFP+mtl1v6qmy0Pcv3Khkd7ksvrAL2vzQxamMe6iiWo4QBGt3LVB0ETrYzezw
         uyLXvDBP+YFOVKV+ahqIvyB3pWES84/iV7kCcVV94rnz0qyubRSEBPoeOSe4g+1YycFv
         pyXSnCtlosKyPoXtjxPYr1GdQryS6mNFPXx3S7RMORVeLyGcaigWnPk7NWkd5j7WDZN3
         nv8VKBKmLBVu1PGLx9gIMUjk8fcpYj1Xm9CF4TUisH/dqFTFAg1j0b/+yyqINI4YrRrI
         1vIxjDPN6YrA/z9oK+iaJFDPW1uUdF1ZDsDuT10XS37XsPt43+BoIFlA3b/q67LlF5Wr
         tnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759620925; x=1760225725;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC/L4mdd1OngyUYeW9NdFnDzBjfqJNLL3d9hdta1f0E=;
        b=CfzJB708qERSb+UgkzDfE/1Zg7wnfxplsXvHz+fQnrm/qDr1sxXgdhGpNNxk1zWh6W
         xwRJHAhCzuh7gdZlNY273BL6V+X0lcWpW6kltSGAf++gqpcjFpe7Br6zkbqu/JGU3aye
         wLSvM7pC8gopbWiz8rb5MCcaPyDFkROavkjs7AT6O7yub5xzAiRuEIUuWbS6Auz+LOOo
         qBs8vhbdq+TCB/k+fZfVG67g79VO16ixl9ReV5hezy1VgceHyFDOrwwiIqvtzxULgq+1
         AiUO0OWDs9JUWaYVTrhMaMEr+2P3NXON/4e7ipZSiPsgvx9gFyC5QP0xNrgeZalds+Gk
         31rQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWzxWw7wiZXFTKgpxTLn669HYyecyKMRIkrby6OqcvFL6ybQNRT5hk85pneavq7RUtdu3wFnhGRPe3EAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWS0JRZvrEXHfxsqKkxf7VWszosQkiEo6eGTaLyfdgfZq32SO6
	IE65Bj/QAVC+ZefhPtODVv8Cln//4Xj6MRuNkd7F3wWVwTZ3p9wNo+I=
X-Gm-Gg: ASbGnctmAm+gNgceIiRwZXZfynU81AQet33Rw4tqiCz4Uz4waolAlJppnh5nNmw9DCy
	N5YFAry2BLIM8P2hXB6lvIuAvPq3QUAqbIdWfHf9uSUFjkBR70Drlq2GwBC0fYa9OSbKJ0T5OyM
	M4mdM5TkF3zrWFyuMiVVg05kLnlBqOSLPp0cv6KfSr4yFRt/uOQ9jN01xfVpKkpi9AfE7U4S2Gy
	iWDzVhDxg7096cIytW2R8oFDMZwP3A0sX4yOIlvjKqHt1xK7q23ZoDMN96HHzUmymdjKh+S6Fw+
	C7MADEfisPjX4lnJrQ0jhzApKRLs15/rm85YgY3XUpJbHzfkV2B1PK6BIEYaR5ubjJ6R3OEQDL8
	nJxXZu/MtnWOb6L+0a9TVOlL0zlbc/jgIbUljigGAlNr4/abrncYEffNWcKjmx6x0i5ln8bmTTU
	kOg8Lal8ZaWvLbqlalZXGIs24uKmrIOmTy1A==
X-Google-Smtp-Source: AGHT+IEO4DcW8huE1gnQomQOCKiIhr0rA1gJSe5KrVyDYKI02dHKwC1UD1xOFCCF7g3I/MKtVb+GRQ==
X-Received: by 2002:a05:600d:438b:b0:46e:74bb:6f6 with SMTP id 5b1f17b1804b1-46e74bb091bmr25477395e9.22.1759620924472;
        Sat, 04 Oct 2025 16:35:24 -0700 (PDT)
Received: from [192.168.1.3] (p5b2acd24.dip0.t-ipconnect.de. [91.42.205.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a029a0sm186407985e9.13.2025.10.04.16.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Oct 2025 16:35:24 -0700 (PDT)
Message-ID: <74e63350-4ec9-4396-9a00-4e257f987dd7@googlemail.com>
Date: Sun, 5 Oct 2025 01:35:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.17 00/15] 6.17.1-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251003160359.831046052@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251003160359.831046052@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 03.10.2025 um 18:05 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.17.1 release.
> There are 15 patches in this series, all will be posted as a response
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

