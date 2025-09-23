Return-Path: <linux-kernel+bounces-828753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A07AB955CD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418BD18A57C0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCA52877E2;
	Tue, 23 Sep 2025 10:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dE0XSIOS"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C868013B797
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758621747; cv=none; b=t27wVIjEeDtLVavS8ZLcCojqgycuhDegwqKb1Nigx+EmduriwBPxv5foXrbpIl1dvd+k1knwRxqHVwMkqu4q932EnNXaFF2/dYu1eH0gzqQTD8bK75H9JdBmQwJvPlwSTyEWzxRfLFAFwGm04wYEYXwf4Y0tr4YpbP/BdTAnVp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758621747; c=relaxed/simple;
	bh=5FF8tPIDmyxIpM9wVSXDOOY0MC8zPSnYmryOXTAKfc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h+SDLig9VjZ+oG+nG7eWXwN490jA+4GXHyCxcv37OwP9TnqTycFGN94J7S1PSi6mtAb5Na19QXZWqgTSP/OeoaXY/ds8IPTHz0mZqrX2aadSC/j/d8EoghyElh06Rc28BDr/tXgJggVrbp24a43srJW0+qcQ5AlbtLBVstTyirw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=dE0XSIOS; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e24de89c1so150745e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1758621744; x=1759226544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NuxeQkFvuyAhGjszfWEO1n8yY4RqHJEB2By+oL3ZH3o=;
        b=dE0XSIOS46fPLhBUSsts70xEpIqWo+QBD2rA+zb/P2KciiyLSmj2YH1M7orOKeKGKS
         MQvxNFVv8iVjnZiFCFhAOUcT/zsADIzOzWOX6SHRP+oLYoekgBfDtVvt1vAgPSBeO1MB
         I2IzVpHnDeL2LMpBGrpuroFgHxFzpGS0ZFpt1xUhzKRddV4YW5TGQqhzA7cRXYuzj1sq
         5CHj2dC+Qd5QMbTWgBKIQ8tb+LKU1ILr628GbgGaJnnG5t+aaOxF3vJFfDyXqQ4b32+i
         udofikTaDTCCFlQ0tOioYlIRyO/XcMmoLvV+y82YvTqSC6DjASaq+6zjGQA4W+xS5btR
         vheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758621744; x=1759226544;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NuxeQkFvuyAhGjszfWEO1n8yY4RqHJEB2By+oL3ZH3o=;
        b=kag15xqaue/AxKixrftGcOVIT54kC8QwHNvkRef7hEWejbRWdKRaEHyPT8gAccGuzy
         Ng1H8GIAVwAt//FoJ5T2gLEHx7m5HdjEuzxLDn4/DIMeunkqwjADZGvjT1iwBvyJTH+l
         1/ROQ8Dal9u55Ec7fpxZsXF23oSJCy/J4dSNYSkSGtrgy7rfrzUrmZXy+bdq1dRae1+Z
         V89CHMv7/3UtD0Srfc2Cr1esx+bRvj2hI6XqUXS5KNcO8dpHHF6mCfpnKA0g7+72fwuC
         Q953KzOhaz0O+I/LmabLA5rLsd6h3hHPZtnV1S9aVRjlhF1m+kPJIghn0ZxHpT0A/lKp
         LxZw==
X-Forwarded-Encrypted: i=1; AJvYcCVwWtTrqR7ljhYtsm1xdT3gTyPUNc0WzR1YE7Cz8X6gaEeQsQDww9DeARXqlsnpWqcZs0eg8guL5tYXvfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxxkYCE3Y/206MWxrIGA9aGXd60H1uBr37235Qee+XRiXcwhPR
	USg8h+r77dPzJLQFqo8dzQCl0tzZ1GDj2geq7uYHtne9Htj9k9xg0cM=
X-Gm-Gg: ASbGncuvVJ3++R0W4OGGEuYtrnXkQmk0Yo2uwFPE/L/WdqjYsRxoCl1DGGKPajcWFsg
	JSayUG06uZ2tZfa/N2qcoPtDL5vgdceLLktBOl3Fnl1zLnNt1rvS9gYYNrhPAG5r/4Y5zfLlzB3
	Jq+9gQ4taOF1jGewAUpE9dV8orC+L3iRnjEHj1yOO9J10ELtYQhPbiiM0AhpovtjX5K2Jdj/kIo
	zUROM9p+e5jqucVR9vU1hBjpe2cjYvlQTDNnOAVSoKHfpyM+XMbaIrHOGDgnMQChehqiELKxqMu
	0cqx9+AQ/s3vj1WKowUMD8AoZgcWcK+TDG/ByL5ozALUFnK9Ud5sihZjXh+rlyyACKDIMFIrrED
	2oGthDaiUm/94rNzPfPBQQqP0o/Nwy10WeQg6oXKamrOdMSC5hXY3CqXKnWZK0m03gOiuzQPTf8
	lI0zaFkxMuK3A=
X-Google-Smtp-Source: AGHT+IHbIWkBOYmlyevzc/DOc2+b02FFIYKW4dQtg7oDiCppTekVOg8WoA5ZV55KSLWulnHDNB4qDw==
X-Received: by 2002:a05:600c:45d4:b0:45d:f897:fbe1 with SMTP id 5b1f17b1804b1-46e1dac6779mr17626225e9.32.1758621743929;
        Tue, 23 Sep 2025 03:02:23 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac1a7.dip0.t-ipconnect.de. [91.42.193.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f64ad359sm273067595e9.22.2025.09.23.03.02.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 03:02:23 -0700 (PDT)
Message-ID: <5820ed19-d753-402a-adb7-9d2026491edd@googlemail.com>
Date: Tue, 23 Sep 2025 12:02:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 00/61] 6.1.154-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250922192403.524848428@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250922192403.524848428@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 22.09.2025 um 21:28 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.154 release.
> There are 61 patches in this series, all will be posted as a response
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

