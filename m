Return-Path: <linux-kernel+bounces-874570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1283C16998
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5E2F43566C3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B8134F47C;
	Tue, 28 Oct 2025 19:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="huIY+8IS"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332F934BA49
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761679494; cv=none; b=OVsnI4YU44FjtpB8PMWgOQ2gQ4iJStAw/yEsuP9fdwN9c6epfN9ha89iQC+YIfT6FI47aEeNXBCP/kWhHSc9WE997/bGLYWt47eQGEeVOtvrZHhRxhkzR93esDkoYhErctULkoy/nBU2MHoLIuZs9wHFUzQvxW7ZtZiem177jhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761679494; c=relaxed/simple;
	bh=YOYUi7F/Hythc5A0zuG6/J5WGc9v5JfX+zO66GNLWY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mlo2o4JdSxvcvAXz7wYKC6EgTvEoSN9MNKvBljrCJJITl2fzvBIHM8KdovERDe0zVKk92kkcPnWqn4/qNUBeS5vZnTFyyDLHILJff+fbCMOrz0AAFcIG3b6s5lwByhVwkZUE6vIpAEZnK4PkxLLVBSkcW5RipXeBEJMcJiLpMSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=huIY+8IS; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-94359aa7f60so415703039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761679491; x=1762284291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lqnf9jST7x/NcmXslhQQGVDr5TfMAmtc49PlrfRjlHI=;
        b=huIY+8ISk4MuXmEBTyxPOVCt4ybIQWqPK50G4+y55z0IBIsCGw7EWMorKa9+c3Ad8A
         GIbrkvIZUJGg1xg5syuRrbkACLKy11QlM05+LtNXxWx/7j3epgrMaXbrK8rAVJ41IArw
         Ik+Q4cimZApbHqx8gJdnCC0M7l6irtucl3sr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761679491; x=1762284291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lqnf9jST7x/NcmXslhQQGVDr5TfMAmtc49PlrfRjlHI=;
        b=t9ERIlMrDkJirI6k8pPKcO0WyWPWUwb+HeWXeRn8P1ryJjroc/yvGxgMe1NnvFvXxD
         jzon4H8TYnM3twNGZx8pKk5MLNIw3FsI1faaI5VBeW95N7D3sASMKxN+7lnLZZ2XOit3
         vjdKY8H2rQRY3yReL4EAvJWcH1k+KHihB1Zpxidrb6etTIF7apK3hW2f0ZR2oatSbGqF
         BaQyFf/IEXj3y/R7Cb4ed5g/SrN2xx0ZOICY2HUjhfpN93YmyDzv5N5dxLTMu2vMInRN
         A1cDdM1K3GhlhqXOFXlnnp0zBs1PA9iGrvFjpT+DfAB7Q1D9BWCBDF4h0RFLaGk0dTn+
         x+6w==
X-Forwarded-Encrypted: i=1; AJvYcCV0gS3fiFfPtyN81HVd/AhZMdUeCjlhbskOUqg0egGrj/M36obr/dabFAab1tMtPG5EduoG8VavpxU2RW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8iq4AVDazBJkYEuO3LPFTjRvEDxyfUTp0ZekyWKWV1YJxrd24
	w1/3YNE0dzGC20gxrpXwgRDoHmakTSb2P4BBPUU/Yj+jtweCBA8+piDgfIZiKFOxEn4=
X-Gm-Gg: ASbGncsGaQadD5SonTLu9guMkf71NoTo/n6gtdrciP3REMNNzjysEet9gvRcoKvkfDi
	Kjl8tmOPyZ4ksWFWrx0yAG/Nf6xtNq33MDaUPyfv0bbzOHzkGsfHYHwh2Rhct+H5QfzEH1Wfzj8
	D57uwfPGBYx5wX0B5w6spleZ7O5cL882k3qvjS8vuNR7plKNIdnCKoV0d9M/SF5TtbtA6ISa76X
	GBDpMcRZcT89IM3vHQEExFGu1/lPNwmz8w7tCAP9Q7udjEp5KmkloSXiMKULkfeDnk1wPxXu8oH
	9Ng5F+xwlTjtTe4lXU2hzXRy35ey/VTqf3k5AgZbd3G8UZmtPxQmS+fFasReKg5ZvzjhuHn0qgw
	AZypYXR4qOlrRQP2dy3TXOvCgxrdiF5SmVg+fnkVD8yFiFt2S58CAsjHl3q9Q4liM+wpQydypse
	RiJGSY21gJRJQo
X-Google-Smtp-Source: AGHT+IHJRAuHzK+xQWLlPVLuJq+hr1sweTNjUYhc4Dc2I5aDW71o9ZnEGmf8KK1Q7LnIfXad4QIGZA==
X-Received: by 2002:a05:6e02:348a:b0:427:a3ef:5701 with SMTP id e9e14a558f8ab-432f8fad698mr6072985ab.14.1761679491258;
        Tue, 28 Oct 2025 12:24:51 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-431f68747b2sm46442155ab.17.2025.10.28.12.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 12:24:50 -0700 (PDT)
Message-ID: <ac5ddf39-d8e6-4655-829f-708547bd0fdf@linuxfoundation.org>
Date: Tue, 28 Oct 2025 13:24:49 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/117] 6.12.56-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251027183453.919157109@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251027183453.919157109@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 12:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.56 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.56-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

