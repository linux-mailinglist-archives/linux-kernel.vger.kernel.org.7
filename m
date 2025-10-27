Return-Path: <linux-kernel+bounces-872566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CADC11764
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E580E4EC3A6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8915A2DCC1C;
	Mon, 27 Oct 2025 21:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liLxZiJ3"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E532D94BF
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 21:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761598896; cv=none; b=c5arQhHP57px1hrlaO+Koju8QtPsNMHOtR4ZVZXa+pT36UTG+FgRc3VqGLodU0SC1ELE3o0cFz5FP0Pu2jSgh9USQJCqlOlxlLQT0+eLTvx2sTx3UupvJ9dyOkwcAq398HZ/DdgSzXOJydr5Ntgnyorc5nAQBZVvljlo2ozIiGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761598896; c=relaxed/simple;
	bh=EZp5BK+kY9z9HMDQNMaQsFSUJ4La66FEV4x+BFlDz6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nxA8+YRMXgGh4mkZebHBy7PymoQUU+AwJY0fC1K53kjcKfXeJbUb2uuGfEWKO6s9mwHLtUvWBoLuaEgAYEp4JXcPMQ0lPR84nP4Jk1Hmnb1TAYPDfwAGwfmQRIp+2hHrgjl5DXPAqSiJBHCMiLjeZ6ygVcNRGGUCcyscxntd1qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=liLxZiJ3; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-78125ed4052so6139569b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761598895; x=1762203695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g8SoCD3YzmKQQpH3IErNvrdu6c+r9DLyIYwtyoko0YU=;
        b=liLxZiJ3Olpaa4ZhSGVYlY1gwc+jEydCml+XbHwohQdIU6mWhWpzNwxTEEs5tjpe/p
         qdQPCR6HoGWhynJQLEWXukerioNQaJL/XemVwwa7VXvu1trOPxlrU3LRTbsNjxmO0ViH
         lTI3PwEiVH7iuPxQuErzW/yBggpOjyH5z8eu3OZLuZrZEShea8XI6skoz43T7HRqS2pD
         6aW5y+qqVGq2A9M/p5GjNrLuSn/tASExAElx+DZMR9OhxwjbHA89iMJsqiFWWGTULSHo
         /7Z9Udj3pMvxOZJfNSxLjW4SEn5XPkSNVqNmbxt3N02gXDgaSxvuoKNEUiltqgspVmks
         VxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761598895; x=1762203695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g8SoCD3YzmKQQpH3IErNvrdu6c+r9DLyIYwtyoko0YU=;
        b=eSQFeXBjq8y1D/pYgngLuuuzbpHxuiMBU/VAfuXFFdPQ25NqC75ARJPPk2C257RJvS
         napEPn+d/K4UK37dYcXlgvYi4t43li8YcetYpegD6Lrj8aFmuA5tHDHTnZIwF8V191bc
         3Io1njhS0IucDkqcafdwLqHR/v0T7u6k7kCzzq83m/B8mbnpkyolUbSb5DlB5FnNkKpX
         66tyrntS5yI7rb1MDrvwUjXvKgATUHV47H4Ss++BuGGtpoXPcXHabORbEYsakeF9Z/CO
         TbxJa7PYRJemWgYG/HyF3t55W4k8CvEVK5rSSvmuBfOJGXAhPal596A2cOJWt/bKZEie
         cKnA==
X-Forwarded-Encrypted: i=1; AJvYcCV03A7QEfkpfFtvVrX3DzAc7xjTwyDJCUksWN7i5ksgT2QQVVR2g5BhFLGcEZRLK/Q+19iS0qWnig6WeeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW0h1Q0B/ioKKTplMJ1jaFklDkszfZV1DDlJfOHs+QCBWTGI+q
	bYUdXw2NShPANteGJlbgGElaMIMbd9DpZI3k3uIpJuSJKyffNakr5HjJ
X-Gm-Gg: ASbGncsfSvLMVZx2mtGiuwfH+ugRM3wsoxPkd72XpaURuUs4KS892HGMnW/FuGGr5K2
	qjwdYEfo+iSVB+fx0xEanKufOcq2VDY228rIUfR4HaCZhHgYz49/jiGQHeY34l0Nlvw/IM3e3bZ
	s3B9ewiu7oTU2FbKvp0T35jpU700qUniA+RaAO7umxR3K1hODXH7ZME/Aal3wjK1VYQLm8VwDVc
	59IEJQiLeB/DgNjLp0EUEVJGTIIpXFBKBSvGx8BeD9+IrGO/culYVoUE5rmO8CJ7Wx1vLxcSFL3
	VH8gp0NiQJz8M2bG8mgO75hlXSPtuwJx1kUVTe4jDm4gszk8WwFPp6YubkToOZjaOMuh96ZBU8Y
	t2arlHcCQN7oJUBJYb1qmsNqgKnMcjEjCdYIp3VwkxQG9kb698lIRj210PPlnZROm/pDnCNVcQY
	sKnsWvT/lyek71t/HjNebUwRjQtqw=
X-Google-Smtp-Source: AGHT+IHa2VYZJfjdEJOEY0c+qP4ZQxZk2QwgKpEDvKCAvVbLkScqmzDjwXnBYcxlrWLzuBDFczggxQ==
X-Received: by 2002:a17:903:2f85:b0:292:fc65:3579 with SMTP id d9443c01a7336-294cb38532amr14538255ad.17.1761598894570;
        Mon, 27 Oct 2025 14:01:34 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3433sm91739285ad.21.2025.10.27.14.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 14:01:33 -0700 (PDT)
Message-ID: <f3172b29-f4f2-4b95-b67d-cb6cbaeb3bbd@gmail.com>
Date: Mon, 27 Oct 2025 14:01:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/123] 5.15.196-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251027183446.381986645@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251027183446.381986645@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 11:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.196 release.
> There are 123 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.196-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

