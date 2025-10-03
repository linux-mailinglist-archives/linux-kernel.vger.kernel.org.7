Return-Path: <linux-kernel+bounces-841578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB2CBB7B81
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 19:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E214A3673
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 17:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6DF2DA76B;
	Fri,  3 Oct 2025 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iinc0ouK"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6272D9797
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 17:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759512300; cv=none; b=RGY9pi6EVIVbEJKMHBg01ex4GwjkX4kL+mCMLpDOn5c39N6Lc8DN1HyOrpZ+uHcsXku9RB+q3Nqd2sOiRSrgU+SSNhpJdzyepSt67e9BCM/cqAmgH+CpXUaZkbhetogFovDUhKFxq+mgCM06iD6piE+Tji1+VUt2FwFbSk/msX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759512300; c=relaxed/simple;
	bh=iXwlO5Byr5+3tTepzQQtGjhw1VcFYQ4q42yDdyS+KS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MV3KZ/02ltCQMAMzama02oYugjAs1bcNXraY//HF2K8qblKarV54HJUqiW0DokZ/c33pGiyfn1lj0SbKqj77BrVV3p3lK/KXIFM44+ZJi+BZGgwuVDlj9cscDi7vuTNfe4epnoMvh48UXECydMkO83XI1ip//pImhegPegNZPQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iinc0ouK; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b6271ea3a6fso1113822a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 10:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759512298; x=1760117098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wf2RDIzbc1/UWl5V5JoHRJgluyXqCVUIWccG9q/hEz4=;
        b=iinc0ouKmwqWNVpXoFrlETFXiDT1WSGDhApQ4EW3A76LiRLA4B47bC+sXCKpfx5v30
         XBdTlVEWAk8OvK2rMzjS+TtHfo3W8ty9acd/H5FlxEzf3EYvmwnZe6TnHNCf6ELL8sN4
         bSbYTOxM11NjuBLofwZU1olO1QF3DvQeMqLTWRAPpUVZT/mDN24a+QvPfdvASCAgKxEU
         YxEh2nYFNgXRLSzIOkAPMvsCcWd+a62uGEDyzNk1DnOS11h016cRGdTmsxkEKFXr4Mw0
         bfK2YIIYlV5wqp4LEdrdTdTb8uoFaSZUgaC27JZZXGOfjKvYlb+ljpLlFBFsFWMOxXGY
         iyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759512298; x=1760117098;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wf2RDIzbc1/UWl5V5JoHRJgluyXqCVUIWccG9q/hEz4=;
        b=AgrVeJqBoRUxPwybxt6izPU57AKroHQXD9T5Dr778zuVmK2t524wfEhrRUTFTMhSvH
         1AlICthLdWroYr945Uk+FbhFj5Bd68DW1ZSJc+mVsbCMhfrqeccPkTOv7ByAjB4nrJ5j
         3vUNGH3YWPc7kkNCLcF7CWukPG0V2RzIOHwQj63K1jZ13vNkh7eaXT0l5zYQZ6lATkxm
         fg7BDCSkrTPzQz8n8Pa8Fx7U8kU3LBd3rspeBHtTgro4ZBVa0OkZ5mzsIR+VdNoTJRr/
         tEzLR+34dWSHMoGs1xyZUcvEMY4gbnRPtydoIefjm9GVu6ESZQSNyRhy6CGcrLYw3/jm
         ZvcA==
X-Forwarded-Encrypted: i=1; AJvYcCWKAMOwRilK2V3fFrM027WbIUJ7O0HyCjArQFwO+i4C35syM7/Wa11oEgt9uQpRr9K432DaG9cUj2d8oHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2RHNGa+Z6LAfjEJOuBzMSgXn54ha7SmtI5Gnkwpf4uuV3g2PY
	ifMg/sw4yiTnKqxufOnsWDshV4h8nuAoIOCwYXOH9uGzdoIGqIwDVK33
X-Gm-Gg: ASbGncurefr7qbmp4SWBst8bqi7DTrwPPIRfsPSnr8lCdFOAsC9knxS4wtIW6qjsJQD
	e0QSf65IUFoM6Iph81IMwE6/GEQqSoLjPx2KR0Fw/EQPrLk85pKEXTnYKQNXSuF/+ciF92y2fuA
	VCfbl97fdvUPzibr9Ah7N5GMLCVNxCDJLhDDyTCh90wGBQA2WbkU+bW/i4DaPgMB7jnOkd8C/nT
	GOrOi6Eg8oZqBhnKs982AUZHNFueXT7lCBNOKSVurforvUK11xcg2DS/xQV/mwEJ83V1lrGqiLG
	VbJx/wCKGiNWp2mQxmroUzCg9ylwF6an/pbn0gcodqU/odO1acAnFTxwTu7H8AwBYRjsqrMPEEu
	iXjczteAlS3Ufqpb26mZbtuqbu5Vcr0HrUoJh7N7A/MQPfmzI+CEsmqm74ItpNoiFfmmDtfZbeX
	iUUMZJewSjXRNw
X-Google-Smtp-Source: AGHT+IGu6R6uprgvErpatUKHGJI87mCfkt2tz7OgEQQ/oXHjPJDBYboLI8mkRgU9mYx/YaDsb8dkcw==
X-Received: by 2002:a17:902:f78a:b0:263:7b6e:8da0 with SMTP id d9443c01a7336-28e9a56660emr46576815ad.15.1759512298071;
        Fri, 03 Oct 2025 10:24:58 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6e9d00csm8751892a91.6.2025.10.03.10.24.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 10:24:57 -0700 (PDT)
Message-ID: <cce588f0-e358-4786-bcdb-a39904d1ab3f@gmail.com>
Date: Fri, 3 Oct 2025 10:24:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/10] 6.12.51-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251003160338.463688162@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251003160338.463688162@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/3/2025 9:05 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.51 release.
> There are 10 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 05 Oct 2025 16:02:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.51-rc1.gz
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


