Return-Path: <linux-kernel+bounces-883385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA2BC2D4BD
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E22064228D9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9379331A579;
	Mon,  3 Nov 2025 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ahf2wRrU"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7913E31A562
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188652; cv=none; b=F4zjEnHI0o+EhPh8bnWlvrxa8VemZEz1Sw/xvGN5cqevZIJfghvB79tC1W7+tRC9GAZCN65bDK5br8vtJ5n8ZxIpslOuwku8i0icuiI87ZFCXPwpMut4jFWGSKJ09Pr1+nOvz0vZfUGTdk6l5wyC5Pm7TYThXeqhPkJrZLEM354=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188652; c=relaxed/simple;
	bh=r+grU7PC+G6N92zehaPAAv5rPvbu0LMva4wOUJ4SsF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oIpyM3LdgFgKndLaua/wB5nfEzI20DqjLkcC5FTsWzaI8ZVB8EhptpL4iP2vprLfj4FAT1s2GqYZSmuXoKBxApYUZ3QcxqkuATZztxEmEoZ7L6OxsF6mwwrZzsuvCGyOE+VqhbZp9lN4lZPPy6TKgaLbiX46Yf6o19Dfzm89+iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ahf2wRrU; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ecee585f23so29880041cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762188648; x=1762793448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dtnw78k2roy5z/99UbrJhP9TDpGnLB7iULXtjAYqrvo=;
        b=Ahf2wRrU0O9HDb+5EMSrNy0YqsswKVqP6erDFCz3XGA7ugtSxy9yK07Xbt3YNW98zo
         wfqLxY78QezcIvWMG79rzUBxFUa2fIsJ+to7FPuZahXv5PDsBPooK3sxblXX4REvz1hr
         +tFScsszP900QPGdQq+l83TW5z0LGMyXkV4gg+YnONCLXJmNIo/4jxXbBE7OrrwczOvX
         eSvxSQyALC4EfYuT0QJRbsnme1I+iAgpCtd2Nw7WajVwQu9l8MuqzGzCaipcV6IMQuWT
         bUQ4aUAIczAslULVYpmDrpBU8wNH3vsHeTiIavkVxfpj53NIzSrDSO5pm7u7/K4FkONx
         SGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762188648; x=1762793448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dtnw78k2roy5z/99UbrJhP9TDpGnLB7iULXtjAYqrvo=;
        b=kP6v2rdX6khFHgB0UhFAu91kq81onW3BfEvkRMzLTWfRMK0FzQQ9Wdz5dnqyN1HvNf
         C6fsVcmkrcuDKNlHY9HAkNniGRjfDNHovYL4D6A3NuFS9G7JqknaBsfVGz6kK/9OQ36e
         G/Zi3vgebYkghyPoG+QENnxoOx8l4hhmJ4ErdgSW69xpVjIJSpFhhkGlOTODAwQ8m8Li
         HZ2zLqUd498Z2WxZdnvOeFKgQ6nyQ+cQYb+NtUrXkG6vv1jncJoSwbs/XmnAybXApXsM
         xiTvBFUi4PFBjKyqIYsU2ZmbzoCy2cxQd/cD2Qdqanr6d/KxyY229c5E9QaTgTGSTHes
         Bfqg==
X-Forwarded-Encrypted: i=1; AJvYcCVRKUEthIJovhyDCce/x+dDBHl1Slko/iF7+z3SkSrT+zyngHdy8ac4Ieheg96xTYnv6xgjvtrs2J8grgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ29niQsLLf+Nz32Gll2YUeSbp1K10kklw5YyClnn36gDWdsvd
	nlgZ4+W0u16gzAk+ZmyFM0Fc9bxQ3dFCVA+tpHhhVsBmjfA/PsKHuIUJ
X-Gm-Gg: ASbGnctUtlmjWLDddSddZG9F1HoEXcLf49aUKCGSj0xlZKLcXNS9i6ULY/1G4imTT9k
	HxNlm0MJ5W2OEbKHjO/U5IMsXV9IRfrZQDIuyEg9GNVSgeRusoKxKo5XLBkRIaOAEWY0Qqy3g9v
	ilz02B77Spwf7xLXmYA2tJn+WUDgNfoCsCmOSXPS16StQwUHjdT6KogAnrZfU16bzptwzYm5ved
	FjkqDHi+ZhtccZaYscVHgEe2yL6ysn5ao8mT2SIFuF0uykA3I4FSosIxPyNEXtUzJpluTxuQc8q
	MEvN81gGMUP1GR1ck4FMQoM9hJkp0hAhLtIJSVCKqfmTavuRGwlk8xBHthzSEwOfWHoBrNjh7CX
	MdG3vtn/Vfij686P6iVeGycYepOry4U2iOmNNyp1cD7khVNoguBeb1jWFUjJuxUbeHuiqbRRBJ3
	jbVwH23rnhElDn0AMvAKU44TEEkGA=
X-Google-Smtp-Source: AGHT+IGaidtdD1Dp1nbq6fggrdpMGwWINS1Q04b+SNwTiL6KnHfGQj14i1rEtQip7/fmniLspjP4Ig==
X-Received: by 2002:ac8:5fd0:0:b0:4ed:2fde:d0b3 with SMTP id d75a77b69052e-4ed30d91bbbmr155504711cf.6.1762188648327;
        Mon, 03 Nov 2025 08:50:48 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed5fbdf2b1sm1644631cf.17.2025.11.03.08.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 08:50:45 -0800 (PST)
Message-ID: <65b0f959-7f5b-49ec-8e9a-3be884af0cbd@gmail.com>
Date: Mon, 3 Nov 2025 08:50:40 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 00/35] 6.17.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251031140043.564670400@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251031140043.564670400@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/25 07:01, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.7 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 02 Nov 2025 14:00:34 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.7-rc1.gz
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

