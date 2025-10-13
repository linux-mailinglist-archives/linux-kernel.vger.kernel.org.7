Return-Path: <linux-kernel+bounces-851030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4FFBD5551
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2BB75018D1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F3428D83E;
	Mon, 13 Oct 2025 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzyzXFKJ"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6955F271A71
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760373438; cv=none; b=mC9DQw8F8h22nRSXKR6Fkx3oswAIp6nfgVddF2HOkljzzdqnFHcoViNopBO7S1lyG0CQe5sLhrmX2IW5wt/CFLn498QnXCQw8sEmIL7cAFxoO4IsqimcgV/RllY87a4v/I9t2WuzO2XKVhdroB0cY29aYCRBIZxmukxXv3Ae7lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760373438; c=relaxed/simple;
	bh=b2r2ZnqDhlcE3hJzionks9xsPMpBi1PVSIuwbR3WWhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jpJNXiET9Gv2JqDL/jL2b3tnlDRkX/xHPZdRYBiWZPB/hsmrq3u2PsUq5PcofpD7RfWz/NpgiKjYpvCdmTjT5mBIfaLGmu44DPmdY+ZIKfYgKExQq11jdJIC6tSzID1PeWDAKog3rczDUx57PkETSGeED1Mpi8CWoWnetR/II+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzyzXFKJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2897522a1dfso41382975ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760373437; x=1760978237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JEa7pR/fO5GSfmUiWOWkXWJ8/pJjtXIzKlc2WrRjppw=;
        b=mzyzXFKJCQIIL9bbPK0giPHsCZXAuvf/SETa10SzgXnV2xs6apXMpmSFU49oGhd97+
         ikU2Qib07N2EZzQ9FmjZru4n+3XPFKWKtn/GCWVnfyQGap3sa+aG+9CGRcThYce5I3hd
         ACdmxTS5l3R69geQtVY2NedGjK+6dujl6suwe49qLupseBl93TgvCeX56GV+yNdxs0mt
         8aByqGfMWqf4rJxEhVdCFvtWw+rV+VWo9YK3eMysoSvepctMOMc9MT5FeNxF55b/wGS5
         IvtH/R8ETLfBcHyY2AtVNW4aXTWBJtErdBPwnwWtpaquDIX8I6wCg/x3n9Gn0JenPkXr
         iZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760373437; x=1760978237;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JEa7pR/fO5GSfmUiWOWkXWJ8/pJjtXIzKlc2WrRjppw=;
        b=wiIJpciTEGb7MmJxr7Bns37e7Pv1xG7AvPY9yFtMs5taxP3UuYam/fQlmmpJ05+dRj
         Vlb//S6+lN1IwF0L64eR8/zUWYy3lnHahmOnFJnxX6MpYXJobqmBFva3Qi0EPoK44e0d
         WKLzVX7RQ8/9Qxf1YgkWQKH7jr6CbfuAHGXEyL4zIGc4EJnMKtvm5tLGLnMRm5hdYY0V
         tzzlJeNkzqhThdlddBvs0D9zrEElqIef5ByYuhR7uhPlblCOGHy8epbHl6RkP9u6mk8c
         C1TbXRr06QXPfZCoE8j4vuuf5W31xX18zriNEGhi2gEtmPcMDeNQiLus9263HFF7U31e
         LPxg==
X-Forwarded-Encrypted: i=1; AJvYcCXIlxcCG9hoO/n2ZEkgSBdC6r3ekJGGuI7rWmfVm7CTJHyJrtZj8sm7OJf2XwKmYSTarVu3pSFDm6n4rFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLKwEK79OmD4KaVtx5tuvoMeo8MdfhIMmHW1v39e01475c2Nqa
	pVYn9xX7VDP2VfpbzW7zfYGhHv08nb1seCACnok4SwsyTjeD8nGnSpEuppJXu5GY
X-Gm-Gg: ASbGncuira3NjBPNLnCAogzMy4b4YLLfQSKsPlPyvQ7Op9y/Y5VCWmi7rdikY0np4S8
	vR+nsYfwaCGr2xhqnz46B/IHNIATuKVdRvdusnzcpzqfTIr+fdj3uNlZr+Uv2m4qGPLcDF8pOiF
	gLAeCJLXrnSzOcaHDrqXT0ipm5zU+lbMow9lV9orv1JTe7ATD5AA83Ft12b6QHZIMxSMHSXSj26
	aUIr7A3vuXK4tGKUppMXwiHM+sS3maES4NJZjvGRrN8Qae6qHD8bVX2xwHgG0tVBVV2zY0wXD0U
	3lPukmojF4JogV73q9aBsH+tZQMDH8Qe0o+7KEMkAlC/ygE1AL7doa1AQ1KFVTFCoaHuehn29rY
	yQ1iOw/kqZLK/NIU5hHA0c636+zRmK/8h51FmdbfjwdbWmHYM+1SFZe1dkDizLCaVeNXPcBOU1E
	0gvhY=
X-Google-Smtp-Source: AGHT+IH1KJHETTMsM9csfcmWcjkeu7/hQCwuY0V59wcP2JtmCwROl3hskQGQ1gm8DOn8sGQGlisYCQ==
X-Received: by 2002:a17:902:cf03:b0:273:daa6:cdf9 with SMTP id d9443c01a7336-2902723ba36mr241690505ad.22.1760373436572;
        Mon, 13 Oct 2025 09:37:16 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f95bd3sm139048795ad.119.2025.10.13.09.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 09:37:15 -0700 (PDT)
Message-ID: <0b2ca7be-22aa-47d1-959a-a6aec4c3dc5c@gmail.com>
Date: Mon, 13 Oct 2025 09:37:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/196] 6.1.156-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251013144314.549284796@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251013144314.549284796@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 07:42, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.156 release.
> There are 196 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Oct 2025 14:42:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.156-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

