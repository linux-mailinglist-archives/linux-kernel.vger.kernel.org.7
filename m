Return-Path: <linux-kernel+bounces-858897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 965EFBEC2AE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 02:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CA5F4EAB8E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 00:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277D126ACC;
	Sat, 18 Oct 2025 00:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QsB4M/qa"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026A5A92E
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 00:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760747154; cv=none; b=rwmgYpxRm9iilIMNOlFlPCNNAjRtEGUhWUbh7Bz7IMRWw706PtCbQapmCV6SwehQmivB5jHBTnSU+jSejjteVMJbfkyfb9O8Uzz/Mgcf1q2WqIsOPP04p4/k1atN/vM6UFSkysRlROxHB8Ro4MbULgip/NaGWr8EhGEVKI3R3CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760747154; c=relaxed/simple;
	bh=wYDlpw74Z3cyAlrGrGpo5UDCI9NbA92k8W5CCOz2vbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YPJI1JWaF9gpHhdmcgkbzsS0f4AoZ27v5XQCQkTf0LK1qTV23eew1WKlu5Hl0llenWWsvt4sxrNRkw+b8Wl2fZ0f5tJFW8332Ha3cg/ceH8Di+Ni2+EAUY7orCMeQ6g23URk+YMXrUtt1GwEZXefwUSvAIZ/2eAwxtailbbX1WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QsB4M/qa; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-430cd27de3eso3430415ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760747152; x=1761351952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ii45rQqKjwtGH5Psho54TOQP3QBwhKcT/rt69FEd2QU=;
        b=QsB4M/qaHts4WwWne9J3ekuorZ+Ledj6XCr85ZIOf+3bvq4BsuPhY5oy3HjV7Vz4yA
         0V/OW2qpJWrhdbAyIpPH5YxNix6+Ahn5ESvaJ9oFJ3DpvTStXYK4vNvYcsJFBqwRhmwb
         QIuBd1idfp9syS19PwAskCj4xr33z8/xOgWdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760747152; x=1761351952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ii45rQqKjwtGH5Psho54TOQP3QBwhKcT/rt69FEd2QU=;
        b=W/rKkddbuhvxic9ZKlkbSX++sBjSo66MU5ANC7C6xTxXcULZZO0k35NgfBzjNLc5F5
         hc+3UfVy06haKU/JM8TSM9/jtDOaBltbVyZNErdGQcKTWif6Csb/oJUHYTBgtuCfZMFP
         lgm3EhFBA5UbvCIk8s55NYU1vkEUaYItVQ4YYDKHHS46RE0FyX06CCmj78DfxBSJHc/g
         Jy+DdveUvL2oLaE3XIM6c0ku6pHYJyvSappFjr+h56GzDfEtp/Jc9GtJ7P8/t8h6gOaV
         QptWNLn7EeEwt6W6bJD0RtsE8pMTvr2gQ54oTJoHHgj2XqafSCjRUw2liWUzOHYjNcbR
         NNew==
X-Forwarded-Encrypted: i=1; AJvYcCWqA7FYjaGvdJi8NJlHZC7P4Qzx6UySSx1IPXc1pLSF+pywnvgGyWZ6lNIEe18eJPWjU7H7v11InRI2a9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqehmNTWjFRikEb3lLbUMlxLJg7FBo+3Wwe/H55mv2/lk/CbUL
	T4+j+6n6xxedcdlTfPndENsqSl0CROtHARkrQEnUcPG3g4iaON2zdlhJlu62AMEgXo4OfhVd4eO
	BSep7
X-Gm-Gg: ASbGncuVA5j1AfXfvVeGdRQDeddz56wgQMwvH1YN+Ubz4L0wr4gAi+bpxbRoyNXnKBj
	iE4ZKUnEkKf7IfqU6hda/AdFLVr7NC7efYl00T2PK6MZcDL3EIMApTRrutMxQj9ojj6Q8GJbRql
	A5icmf0oFJwBcxR0kMUk16cNwM8Wd/qkay+pJn5yudk78gmmTiPbELDA9lk4HGckIhhPw2Serqd
	a8rekv8QHKIeuF2V1cZtBnefB7og1KpBXE/2+Fvibx0eQkXg1NbkCFvTNC1IVuD9glcItnz0MwL
	BdG/U7YSyFSMy2DG/UshmvIVtcc0GszsGlScKN3l4+pXwU6Hk5C65pwDB+0FZ0IfEzYquQa396Y
	XWpZ4fIK7Pv+6vXsMn2cFsh81XZlkl70aKSEXY+LQMCTAEzrLPYHTviMWxmFSbi6UT2zethTGLa
	HfJqxVgnL/xJn+6ciZRGiGIS8=
X-Google-Smtp-Source: AGHT+IGo2Se2kxunEF/SZg2Y4xCxWJXIASoIB5WJpf6wAy+KaI73tMOnfXy92b899FQW/8z6rJQpuA==
X-Received: by 2002:a05:6e02:156c:b0:430:af13:accc with SMTP id e9e14a558f8ab-430c5208df1mr78329755ab.7.1760747151996;
        Fri, 17 Oct 2025 17:25:51 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a95fed66sm413846173.1.2025.10.17.17.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 17:25:51 -0700 (PDT)
Message-ID: <3c6f1571-8e24-4d03-aaee-5852fc9fd943@linuxfoundation.org>
Date: Fri, 17 Oct 2025 18:25:50 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/201] 6.6.113-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251017145134.710337454@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251017145134.710337454@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/25 08:51, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.113 release.
> There are 201 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 19 Oct 2025 14:50:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.113-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

