Return-Path: <linux-kernel+bounces-858982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF66BEC684
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 05:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BFC84EDE95
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 03:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EC024DCFD;
	Sat, 18 Oct 2025 03:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMcGH68m"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E382D1DFCB
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 03:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760758267; cv=none; b=cstLafnxJ11QPJ59eUVilMy4ScxcWks8gI6pZbx/qcPLEBOzDClsSYgR3PsOdb4aOZ2JOBJ+eBUwtsnG3XZYMKu6eN/8OIzM/4RZ3EnWzSeB89jnJut2hMGWPD78UvpwQ8uqJhscCBozpF2p3gRiCZq/xhFW4H85p63bYwauU/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760758267; c=relaxed/simple;
	bh=+10+GeTAtzffLGH8zcKVrCr0sCkofSw5csfm87HIomc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=giDnj90A0XHF97rj4Q2g0x9q9zhJJuQfV5RrmQBeRqxMKIIg3u7/xA+bj5B47p+Am7sjxaFefyKwEY6FZaW0xKJGba8YfyA7vB+XkCtyBqLV9EcDP3i+fMyo+qhtrpHIxl3/+sAjiIGscfJ3251ksRyUzK4eSD8N2v/xs7xy1Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMcGH68m; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33bc2178d6aso1545655a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 20:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760758264; x=1761363064; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v6vOeL0Ti9p0IbinEayIS2aVQiUiE4kHXsDaP64c+YY=;
        b=fMcGH68m1sJqGtwHQ+pYV+VsTY7UM8Dwby7tLA2VuZuCSoC0oSmurMprWz+5vuUtAY
         O9OYI0D3MbFsePEueWQ5+/nWIfZ5mYRBEsYEJvr5pRpJGoM7vtR5QsrvPe+33nWjultG
         hHqQjX4KO5M1x2l2TeXEF7WofQ7Ws3dS4tfBmp/1YbjGcbfb3Snw1+mxHNCv5Vusztab
         XX9FE428wXVWcRMw5F7uWBGeRY0Svuz1XTrzGmjILBSnZIprsMoWr3u3rZeqGI5m50xA
         5TdtLZClsRPTBGf4cyIxI23GKLmHS66uGzjJUxtanwEVTHVueMcbu0wWVn+FXPwZ57vB
         eeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760758264; x=1761363064;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v6vOeL0Ti9p0IbinEayIS2aVQiUiE4kHXsDaP64c+YY=;
        b=JSWWeIVRTqLxBal4+J4fBwgWlCH31TFmeAUIkqzcKhJvcjySu2sv9arjolzUDodCRp
         QGtyOT5IK9F6F/8RmOq/8droaQp160qkbcyrgBzsNc81+8Qiq3EmH7qd8mlK3GJVWvH1
         1B1jSxA+AtMeVAsvpIIvxP9Y4Db8TKoSj3pB0JTPcKs5oOqpya+3dgXK3y0WUn+lcK7F
         Y+Oj1FtphNid6QS6b0pSDZMrOBtP0WSNeKBMdRFIlq4wtk5JMwP5kXF+vRA3/HvLkrBH
         DZzNtvg9Sj7CS9ulpTcQSKqTmTrC+fopHNd9xuw7ZiLi3OGmv/iCs8U4NfZlGWT11AEO
         Ni+w==
X-Forwarded-Encrypted: i=1; AJvYcCXF9iaZ5nU+Y4V2/9+zEqxi2uWcn9S8DTJDUnQs5huEFx99Hd+vtomOVHfbYFOC0lt03HWfGgdxS+ivpQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYg0Roi2n+iO1lQxxwgbfHfOhgoNK2xKX6mBTolzCNkJ+53mvU
	j42Tu6vo37bGZn/uIFe38VRDVUVmBoYBwmDxi6/Z3+BbLhlbRbgvZVG/
X-Gm-Gg: ASbGncs4qXfnYPpoafOJS39NTQeHpTQ4Frs6fAPUAG64aXHpiKINkR2FXkfhmIR/MG7
	Jhozl0mrN5tAvD1j4Vf+sm2E5m3qYID3YHNv8wMZ2sN0gXPv+BdRssaDM5h8dm9/8TbNmW8ngDh
	5KKnSt0dIbKYHpKmxJHKK2oXX577tNg13XeOHkySUb3BG7RhXj4Bw2KUWJOvsRpuMuV5+DBdXnK
	bTdjY7FsNX3hBEYfqqE0qvLb9UP0pxNU+Dmg+uA/SjlKgx3pn2cnNhbWU9BL/2kC5AiNaAUSXtZ
	oDKrf8O3mC9qhdqn2xAQd7voqFZx2lGGUiL40fhT0gdmj1a0k7fIHIXAKxyNfi1LzMp1xOoUizq
	qLofsarXgxE9Zko7VcpSIGBCo9QUG+kO3h7fdIJJIb4nmGwsDPEyxVHOrzIvXj8Dc6Br5zJqZuM
	oddvHlPDpHjbW3mBuAaEYXKG6iI9W1QhES/rTUnxmHYt2ZW3PG+Hpg
X-Google-Smtp-Source: AGHT+IF2jhP8EBwcp7ssUhyFGBfyHgpvEdDxNhJAUMzEUUmdrL/VUU+PTz7bDljFsV81pHEH+14dIA==
X-Received: by 2002:a17:90b:498f:b0:33b:cfac:21d1 with SMTP id 98e67ed59e1d1-33bcfac21e6mr6838380a91.32.1760758264085;
        Fri, 17 Oct 2025 20:31:04 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bae113eb3sm3899336a91.2.2025.10.17.20.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 20:31:03 -0700 (PDT)
Message-ID: <201bd632-344c-4a89-8870-6cfd2f3bac13@gmail.com>
Date: Fri, 17 Oct 2025 20:31:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.12 000/277] 6.12.54-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251017145147.138822285@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20251017145147.138822285@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/25 07:50, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.54 release.
> There are 277 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 19 Oct 2025 14:50:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.54-rc1.gz
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

