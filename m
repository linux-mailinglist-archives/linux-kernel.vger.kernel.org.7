Return-Path: <linux-kernel+bounces-858837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5AEBEBF8A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 01:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA60A1AE17BA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 23:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58CD2DAFA3;
	Fri, 17 Oct 2025 23:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fd1jNIt0"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BAB261595
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 23:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760742290; cv=none; b=innAdSgSdHIgplwLuBYjaGUArQpKZOCFUiQALgSgwTd2V1RtYoI3395YaAgA2rQLDa5mjUX9QscSsS/s7jy8QaCq9ooV7nXyaf1Pa8RJfPZqDvpkXOaOqefLD5jU1KiP4nPsW78EIuWIMrIoiCFpy06jWe5yy48fATHaqGVTvKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760742290; c=relaxed/simple;
	bh=34t2guKeP6RRMMYoEjTZ6QMeXJWGLVnlKOiJfockngw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nH3IJLEHIQhlpzNQILb2ID5xjaI0GGFGHVWNLutU04gV1pmq9OL8byfun7mSG5UW5STBnBoo4ssMBJaJ5kx2K3kLzq6/ncWesf4237CgoS6ORtbdRY+6bjxpY+U/QbrVEkMew0IP7cSRU623psYwLxa9TkraQcIaJog0Nuu9sA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fd1jNIt0; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-88fca7a60cfso407795685a.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760742284; x=1761347084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oYy8526wfT6JSdIqvj3HrQ0icx4SEndY8ccI3Hg2clg=;
        b=Fd1jNIt092xCDSBYBHONum3D25Pc2QtV5P+1YreAM3ymTkE9kUDKirL7Bd7ZQVyJEG
         qmzhVpH67qSBZz6cC0G9ErCvwcxZ3o36zL1YfrIHGO+DXBat1ANFDqs4/Sy0XY4JuoYZ
         X48xt1VVvIa1S0uTtryp+m9pjCdRXYLcaElHFC5Go2OSVJrP8jahSK2bmOgkWn+zroOB
         voqH7UvbNz4kARA/EMWkUyYnbJbsNMzXn+yPV94EHywG+NplncvE8Di3oR5FtJ1GyQVD
         kA7ZbsN1aVGmLNCFJBsx6XQprShEVVVavbppeet05TlHZQJeSfuHohrXMEhfHLbFCWru
         WitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760742284; x=1761347084;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oYy8526wfT6JSdIqvj3HrQ0icx4SEndY8ccI3Hg2clg=;
        b=pVQOU1M9iwj4Pvgy1DGn2Yq7AQAKjnEbxgvpQLK1Cl1PnPu55/AXXpPKWKqR3Z37XF
         triYdmWCFIq/sPd41IQ9NyLYhNtXo6PKbt9pCQmSottHNhZphX6HfdrBMJnST48pYLpi
         qoIQEisEuzWq/evul5xg4wJYMngKNeqXGc9hKhUDs7WmVd94yCl8jzzIYkvqlMdmPV42
         XgxnMPChJqntMVTeO941FLfBZ0bhOYkm/eoU12qh9mZf0Qm9AbofJ/mgyL5ePEoipI3l
         VXSh2vfEgVLB00CuakDaUuXXlsD8gf6gGvGDw42LLsK7ERsnA826FmkaELrSGPnSXvj7
         uimg==
X-Forwarded-Encrypted: i=1; AJvYcCUV85YbDGBK+7ovz0Gr+/7XIKGJ9ahFP+bMo5Gg9Uil+za74KUCys+668phkU/P4QBZIR0tnCDltHD0r0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9TT3SXxb0DRRiQdO6fpioA7YbqQ6ia8mt0vpvd0nUGghw22Do
	2NzTouv4k89NoQ11zmvqvDa96fRAoiAcRwhi43fmUEDzeLixs7DQFjxC6eZe+rmi
X-Gm-Gg: ASbGncvPQauwNKG5iB63bDRLq9iASAMHy13wyENAXuXTIdLqXPALrDUS35X/By3YItK
	zY7e3PT+JgtjZsUt3pAYOiiiYqpHvv01GeovmX7fxEFOs2ZJmMBQXLvXCgz0/4a5tJVxLZWy8iE
	98MmxQCkeoaBdR+rHHfK/PCJlfNpudWdoSm5Gl1lKoR6hqC3HIzlSP99bG+KyPIFDUd+mpNjxfb
	s+p8UZOnBlb+Rkofcu2FquCwWDXd5mc8qeHoBBdPZawg9iuCj8ssFaiKAAtsrMb/DvfNTVKV5nE
	lgkqtwg4faJ/gxim9Wzy0upzt6IojzFtGIK7BQ8g/Lm2FZE6Vbp9F3Venf4I9fRR4CDADePMedo
	UhRnBg5Wk1fuhL0XbjHsfuSZ2JbmzVSuItUlUFFDuK46ZTqNkmsqXEWQx1Oa0LjjqgdrcClD60j
	/fDihlQwMhhT2HQIAh851Qyu9keug=
X-Google-Smtp-Source: AGHT+IGu5TpaguVbSh7DB4qrTllZFZhmQoXm1v7312k72abIPidk51MwdQlGrQgSmL1IeFVKXdneeg==
X-Received: by 2002:ac8:574d:0:b0:4c7:9b85:f6d4 with SMTP id d75a77b69052e-4e89d262ec3mr79164521cf.22.1760742284484;
        Fri, 17 Oct 2025 16:04:44 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87cf52209cesm6626376d6.23.2025.10.17.16.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 16:04:43 -0700 (PDT)
Message-ID: <acbbf30b-44cd-4f31-a979-dc576585c65b@gmail.com>
Date: Fri, 17 Oct 2025 16:04:38 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/276] 5.15.195-rc1 review
From: Florian Fainelli <f.fainelli@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Ali Saidi <alisaidi@amazon.com>
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251017145142.382145055@linuxfoundation.org>
 <c1b098d5-3499-4e24-aff9-6e5a293b4b1b@gmail.com>
Content-Language: en-US, fr-FR
In-Reply-To: <c1b098d5-3499-4e24-aff9-6e5a293b4b1b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

+Ali,

On 10/17/25 15:57, Florian Fainelli wrote:
> On 10/17/25 07:51, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 5.15.195 release.
>> There are 276 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Sun, 19 Oct 2025 14:50:59 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>     https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/ 
>> patch-5.15.195-rc1.gz
>> or in the git tree and branch at:
>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable- 
>> rc.git linux-5.15.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
> 
> perf fails to build on ARM, ARM64 and MIPS with:
> 
> In file included from util/arm-spe.c:37:
> /local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/ 
> include/../../arch/arm64/include/asm/cputype.h:198:10: fatal error: asm/ 
> sysreg.h: No such file or directory
>    198 | #include <asm/sysreg.h>
>        |          ^~~~~~~~~~~~~~
> compilation terminated.
> 
> I was not able to run a bisection but will attempt to do that later 
> during the weekend.

That is due to commit 07b49160816a936be7c1e0af869097223e75d547
Author: Ali Saidi <alisaidi@amazon.com>
Date:   Thu Aug 11 14:24:39 2022 +0800

     perf arm-spe: Use SPE data source for neoverse cores

and this hunk specifically:

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 569e1b8ad0ab..7b16898af4e7 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -34,6 +34,7 @@
  #include "arm-spe-decoder/arm-spe-decoder.h"
  #include "arm-spe-decoder/arm-spe-pkt-decoder.h"

+#include "../../arch/arm64/include/asm/cputype.h"
  #define MAX_TIMESTAMP (~0ULL)

There is a dependency on this upstream commit:

commit 1314376d495f2d79cc58753ff3034ccc503c43c9
Author: Ali Saidi <alisaidi@amazon.com>
Date:   Thu Mar 24 18:33:20 2022 +0000

     tools arm64: Import cputype.h


for tools/arch/arm64/include/asm/cputype.h to be present.
-- 
Florian

