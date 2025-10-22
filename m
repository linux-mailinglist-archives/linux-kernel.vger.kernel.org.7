Return-Path: <linux-kernel+bounces-864029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF628BF9C30
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 48B50352B3D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 02:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F002B199EAD;
	Wed, 22 Oct 2025 02:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNHvrVWV"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF54A322A
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761101211; cv=none; b=fqrzCFP8sOf33yYEivOwWmaNL8Nh7U1BodMqph3rT19/Rt09UsW4BeoWt5oUvZmNWnet5B8C/bdZcfX6vT05w6wPrcArF5ZuTpCpld50Kxf9azE+oweoKG3venPO3taxD4mbSp7dLqXkqOvw0GPVCFfQaSCJCHtOjYnBbbk8Ed0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761101211; c=relaxed/simple;
	bh=a3CCCdrTWUxuRUJBdeeFVwrJgfSwekbmeg/24eUtngo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zs/XwIyplCJYrHgjAN13nsofvuFtya4bLhWh/viYUF47o6yAUuDbTnOlZLWgkQMB8l2Id2MZG3n80SUVmvWWumkFEgSRCMuDoFZNa2AlE+URvmi0DZw1BhP67SmXYlLJcawa3dVDjK4L2HQ+kwuS9Kng/pKA0X2+C73POPadbOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNHvrVWV; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-793021f348fso5652761b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 19:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761101209; x=1761706009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PYNRDrO3CybgYbzGCrw9HtMshXI77N9IrEDAL18hksY=;
        b=VNHvrVWVCV5RfrahILjFm3ADTKr57l5GSCeXAOupQgxEgrfDYwH5iPe9xNlz6FU7SY
         gVgIu2/DbRk9Ue1roCpdeuT1ehZoiapNtOAtJPVLO3fvPfH2beQ7Og4JcB62LQfTYz8g
         al/zpncVIRh96frwh8OYAZYdmvvBEXGdYiGM+Cu2at2wjnTSiJyC4Cd57J1yvdoM3AJZ
         vN3GeaDyUivRPRfXDkFWyP0Gm6Ga8AvqLtExfEu+bZ0LN0zxBfQLLrWnuMwDeHiB0O17
         DOgaPBSNOrzgXJV82znacwmLK5eG/sh/bsNqDUMv/tJJTDIZOz87kSId9KnABkiF4ITM
         hSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761101209; x=1761706009;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYNRDrO3CybgYbzGCrw9HtMshXI77N9IrEDAL18hksY=;
        b=VgSbMtt4kUnlVgHe59j/qy9+KKhn9Ua7nJxTyopJLxzcMFIdMTOAEJAazhwEVhNIDS
         vameK+z4ClhgO1O8CjSY1cUROIHtXBPfVA+3nSis/Zjv17IP09aeMhP/ALgs4mDx7gz2
         vVARX1NAL/TXhWTDSZZmvatG8DeOnk+nU2OA7F7EsI/0xHvKZ3IAJ4+xLBrSsA5YFBSF
         hOyQsfsmJL4mQ62THlwmfBxJZH802NEZSoC83OXI6s7QixCNTSSvlulF23t7VBfC8yDn
         4RrDNU4R2kboFSu7N87wtXhmaOMOlMXYk445QMY5nY3dnT0z9omMMsRspEaFI2CZyzKu
         SqkA==
X-Forwarded-Encrypted: i=1; AJvYcCVWWfODEpRquzKe5r0Lsi+vtCrfkBDZmjpUre7eWm1U1GRvTj5KgmeOCkWCL4tqu8PHWxCz5vrPUlHdgWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxaPNUNt2Wjq/Rya+XW3z45w+z4s/+zm+ib5okjzaJDi1by8la
	BWXDIkoh2eofcYvzNzMrUeoKkyufcTcrwOrIMDbBDXvQJNGc6B7hclKO
X-Gm-Gg: ASbGncuTSUoU09lpj/vl0mAynuSWyQu2z/RIC++yfURRnJf1mUpM2MONHu6aOTEEReX
	qrzoBc/PXN75DTIYqBDw06FeNsmZ8auOMtuo6i409BrO3jBPza3Un98BITJOXWao9goTLQrg0zC
	498vsXOR+c1gPpbHbrPJa7JVpZB2N51TBJyGdRiMxfg1ni618rPxah3L1oTLpE7O5vW272T7TqG
	JGsbdIfbUm0LwtWxY7EUlyz/ChkJM4wLav9NO+RdWN+gB0B6hHz+RKFx+YIq0tSYtx1N/ltq4QG
	+pZdAYxPd4jVu0HB3ymTY8yocSfeqNwu0CO4ssDUKFi1qJkgLRZgQcE+KcnfLY0J4176WyV0hlD
	vr3Os9IWSIYvSiBdsRO8TDG5gmVY6if094l9Vjv5j2/9Tm4pgWVJfpNQNSc7LOQGzZOkJWricU2
	8ShpRA72KwkISTDGH5E3TftPAYav7Kncq/gekKxhAteA==
X-Google-Smtp-Source: AGHT+IHmTFutYfiBPfh6pKIFfa8WG/r+Q1etaUgtanp0pzTongAxTZzvK9UpNwlCGbPLH2M8H69kng==
X-Received: by 2002:a05:6a00:4614:b0:78c:984b:7a92 with SMTP id d2e1a72fcca58-7a220a859eemr23541047b3a.12.1761101209199;
        Tue, 21 Oct 2025 19:46:49 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff15c89sm13232037b3a.1.2025.10.21.19.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 19:46:48 -0700 (PDT)
Message-ID: <0f508e49-f916-4219-8743-0ee7ed12fc23@gmail.com>
Date: Tue, 21 Oct 2025 19:46:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/105] 6.6.114-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251021195021.492915002@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251021195021.492915002@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/21/2025 12:50 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.114 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 23 Oct 2025 19:49:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.114-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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


