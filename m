Return-Path: <linux-kernel+bounces-872615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E9AC11943
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD9DF1A22D9D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB4B2F691A;
	Mon, 27 Oct 2025 21:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgsjh3NI"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E452E5B32
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 21:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761601870; cv=none; b=NiJZXhbwcTm5toqg+YEj15GQsDu1HWfr2g0S6fWbQ4bHYOVuyX9mF1+HMomEkk+NOd/9rXcZ7Zgpm0ElE4TSgjJG6x96zzWY7lKxYYeWdwOrvWO4xi/dsqB5RAN/oog/08JGPirGmaDFd8sb/B7gSFHnxEQGK5/a+SLWD8SqrU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761601870; c=relaxed/simple;
	bh=Ihe7iMGeY3MaWfpghNgRKj16o/BXEhA4IQIEAteLWFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZyyCNRFgASglBpgcvnEQnkYM9UdqeJEoWDIOpvbLGG3bKIMPWPA4Yox+NiMXsBmdEoNq/bVeQFzuRQP76x7LUjlCySBG1rXHoht0x+sc7KDbPtSZEwqAFj4fueMCx3w/tR4DRhjWczES1OiNyXpRLxT+W+LbcmIlrNazphH4e2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgsjh3NI; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4eba5b415b8so12278581cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761601867; x=1762206667; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tVNnHyP2kvRHu0KNHL4DYJenS905nS8x/EseI8qNXgs=;
        b=bgsjh3NIyR030PiLYEN81FIMGaxlPGfN12h3DyeetUAZ+RJIVRjOkIZBj7egYEY3Mq
         sPnkgim+WdGZ8aooe4UOBGQ4PMGsq9RLnu6bbZm7GPfSz/u8SJ6TiZ3gaPymnMYw5/j4
         OEGCDXmNmpwGecWfFkHhPqzE7kK2EFHxdECqdnlKmDp2p5bwUP6ZbVWIW2SguiY1wB4r
         Or6XVHSUexeUbbsieqq9Tjx9WpKxX3Ji/jkQ6sBBrcw04JONRR75K6m7EBTzdGdXi8kN
         WTPh6socvih2t9lvdnS93IeofkcBP0l6ckVqKRsS82yLk8Nx/SwegS3A/KSwveMafa3J
         MJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761601867; x=1762206667;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tVNnHyP2kvRHu0KNHL4DYJenS905nS8x/EseI8qNXgs=;
        b=HOg+PwKShHyQZ051xdx2fGFqK5bq76G/mfCH4mc9rs54xbMjLt32LBjDCYCoNbQfbC
         2tFJ6Y8+jipieY2gJBuvOl8vw023VGsj7pzJL0T1P4kyItLtNCaK0axBe7anOhuiiXAJ
         nA+IEx9UQ1NmrMcluzRw4rHTzf13liRQtJNAgfH6GlRYTpR/xAR1xfZF0l6LXfNjGxb3
         N7lJfQsJzwJBztofCedUJ/Ua+Pzp3f/57eqhh4QRydgP2cphcT0letyczN8bXLHjOjK/
         KtPm9yIdwn3qMA1XJuvXIOxqNT5YplzswEbuQdp1dnHg1cFx6hQ7MmiXSGrnqB7xl3+F
         1VXg==
X-Forwarded-Encrypted: i=1; AJvYcCWg22LJ3jALlHLJ0Gr/1vq8nUMEMNI/jK0ZyIO91uGjLPkZb3kaf0IrmhcWtt8baQ0FZW0afDwn68wI9Ps=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK4bq/UNQkXej7rlB3jNndnX9vt5ykPEtO76VUyNVySMLVsXH5
	nwFSdUju5WA7HBuCK1NSHFJtSKsIERhC/71RmG2riO8ty6YRurOPwpjd
X-Gm-Gg: ASbGncs5SDkdGDSANzV/4efVbKHteS4Fz6ZSOFBIcRg+il8kcTo881xqImu/8C8YwcC
	X73BKxnZHHcpk1jXzib+tptAs2XDhl8lib465OBulLUMGr765goDwtwlJriDE4ugZr83slHTxip
	pQoMebNihK5RhG36lxbIN94AT7YFBBJpE16vOehc/i6qdFDPlfRdkd4omwMD8r2mpx3LcViEZYF
	KoiXVbmYKUJCy5FQUy0rg8vf7OoMt6VScewnufCGGxdySf1T6BGf4cYSy9mQm95avJop8nccWZt
	bxdxWQBCUT/OeOgX2GdBpL6ml83NZoFA13MdKHG1QS3tUx1nvMZVqsNCK87N2TdJOj3LYThsUai
	/Yc/Q0uJiGKW4+TUbyFwjueiQOm0tDlp0b+kNwafV16IR/YktlT8LG0dN0a4Jm8TNm/geg3Ru8d
	O3DLpyByvtGmtW26upIlXLCDn6ZIo=
X-Google-Smtp-Source: AGHT+IH9Cj1acWdK8g+zx9f3zGo9gHf7/2+ldMTysUUzxIINsdMd7G/Ku9++UeRXutjL0OKbUCJtlQ==
X-Received: by 2002:ac8:6f0f:0:b0:4ec:f0f8:22f6 with SMTP id d75a77b69052e-4ed074da1ccmr25283401cf.19.1761601867150;
        Mon, 27 Oct 2025 14:51:07 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc48f7323sm63559206d6.29.2025.10.27.14.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 14:51:05 -0700 (PDT)
Message-ID: <939799e1-615f-4246-869b-03ca162bc49f@gmail.com>
Date: Mon, 27 Oct 2025 14:51:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 000/184] 6.17.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251027183514.934710872@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251027183514.934710872@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 11:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.6 release.
> There are 184 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
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

