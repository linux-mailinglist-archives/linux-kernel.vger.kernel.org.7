Return-Path: <linux-kernel+bounces-896127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C28C4FB3D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2528F3B9159
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D6A33D6EC;
	Tue, 11 Nov 2025 20:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="hOyDctzW"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036C333D6E0
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 20:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762892953; cv=none; b=X82MVf2QVnPTNO+ivRcAoZ+/MhEOgbCXvelqQRmzXEd+yjpBJGC/btIlKbK391LgfVfywjbEZbVNWAwsnY0ci98JR8zq4uq8kfFE7mhUGwr+MYJPwxWb3wZ1IK40BRTt+j7QWJ8K14dFCGnrao17SPZs/0G+S9S256haG8JW2Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762892953; c=relaxed/simple;
	bh=92npXFVKjrhpisCLYsnug9Rxp1dITx02Uvrz+rVkX3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTL8SBVYFg6nfRDEIXJBVn6elEmBdcEL3TZjBoSoXbdO4WvZqFXCO68Dz8ds9lRqEIUapWmQ+iBy9qIj6sC6u6KABiDK+/IrgCF7abMExfjud14SGJ6/O+pw6i0zYobj0hWk6c1roU1nHlhQ66i68r7xQnwikLnXqELpM4Q12tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=hOyDctzW; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29599f08202so1208825ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1762892950; x=1763497750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Lm0cyy6GpKPtLwlPwfKtxbxoiOSXYguyMaReC5kh3A=;
        b=hOyDctzWMiHvsab4Pyl7zPenUOlvPSoM6Uv1j93BiHep4oTEgKXEknCOqYqnKncVxX
         7Ghmr9lvHTHKZ6TCXviEdQtuCQPUxx4NXPhnMX5xNfOu20RGO00HStsmGieRtR8pR1G2
         jtxQjwaHqV6YHVksC86xOKuEkPYB/FGIp+3Nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762892950; x=1763497750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8Lm0cyy6GpKPtLwlPwfKtxbxoiOSXYguyMaReC5kh3A=;
        b=NVD0Ikx2QlpsmCYCIDY0Azm/+rfFbbAHM6CDM9RCvMoWfuNtbsj18WyAvxga4/cTZu
         k5nIpGHA7crpZXsaRWdADtOa9Mret70CiE71Tft6IkSV6NeQL68XCiNegoTiL/6FEmW0
         glyP/Yo4xAZ1JLwktpRWYdHGubnGQzd1uRlSeZpu8ptV9PpmGbnhFqaLuX01p5j0p+J1
         wJ3euiDRs3n6uEq2VyxdUTWsziKrs8QK79euygBW9cQ4ULAFaR34NzRERumYGBLlMPhY
         AvfLD16PkDMIEPTbMIY0TcNBsmmr/sXeyXHSHxTv9T3yipTbYR26ZeUPwcFA6+GWbCVf
         Z/Gg==
X-Forwarded-Encrypted: i=1; AJvYcCUmOtj/aswPEPGV0RzySbuHzOXF1kX20jDlhOchb0lR2kM5fiAyDtzdwU33xstM6Az2tCFL+Riqq7z9Y08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+hoF0OBCMaA4w2LoMkGO1g8h74tW9+V4rJCpPr5sDwIIJBqsz
	kVBR4AU/61dBke4cSLkBbvT14FHUU8rdBYAjt3fB0sVfOBGqxE0qfA9bgwy0dXBtpQ==
X-Gm-Gg: ASbGncuBdY3Y8+JmfDNs3G8ZZePaLw7NgrKATu1re/KxcLwdTBj56ex3xRQX0HSWfXZ
	Xk+fEbmi+3C00VAQ0gNujAQk3iHBOdavgiNHRqiM3oC4CvonKENQ411UHdeRDXXnhW8Rp32mw1l
	n1v0XEHgZ+OEWDnNHVlJ0RAu6bYC12TPWL/ftLhqyQBKP/nj/P1xmbjnNuJpGV5Ev4IT0SDaBOi
	g1d9zarrFlAhRdq/bG1QdPUEJexAvcUlfJubmQBsl3BDZqfUSxZ8/f63bl/vjmyz6kONTjHAov4
	949C3QWUxu+DDHTK5xCz8Ege2lI/Etn83v7aRXVUIpSHUZfPVOhlpaBLuDNMLfTTlR4O1uC3VjC
	bAHQwUT80EI6pwgySwJ8lwUeclCi96p0NFsKuYa1nOt4H5zVKSuFT3X6V3R0lB5klBrWJqrOrIP
	h85pJsTjKf2Skh7o2z7PvsCB7MFNKrSBPR
X-Google-Smtp-Source: AGHT+IFgpJ7ieLN3D+n9X4Ct/IqCjfaNVQEHkLLAGtviQqbMsn3doADs7khGezuYpaPY6qofXBLTlw==
X-Received: by 2002:a17:903:2ac3:b0:295:39d9:8971 with SMTP id d9443c01a7336-2984ed3410fmr8163715ad.1.1762892950309;
        Tue, 11 Nov 2025 12:29:10 -0800 (PST)
Received: from fedora64.linuxtx.org ([216.147.123.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dcc9f6csm6044815ad.75.2025.11.11.12.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 12:29:09 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 11 Nov 2025 13:29:07 -0700
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.17 000/849] 6.17.8-rc1 review
Message-ID: <aROckxa8DMdqBx0b@fedora64.linuxtx.org>
References: <20251111004536.460310036@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>

On Tue, Nov 11, 2025 at 09:32:50AM +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.8 release.
> There are 849 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 13 Nov 2025 00:43:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Verified if you drop
[PATCH 6.17 145/849] bpftool: Add CET-aware symbol matching for x86_64 architectures
or add 70f32a10ad423fd19e22e71d05d0968e61316278 everything builds and
runs.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

