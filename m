Return-Path: <linux-kernel+bounces-880998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9138EC2727D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 23:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6D83AEC14
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 22:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358C1314D02;
	Fri, 31 Oct 2025 22:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="hZjEPDaj"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ABB2BD580
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 22:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761951502; cv=none; b=ku88R2h+aw5Pen+IGry/AcWYgpIDEmY6agzIw7zHByNJKTvkrDteHKt4pQ2xie9zBGR6IxsyiMFnbyd4shWPy1WlLlLmLwkMBWPshHorODr27VxyGIjHIYlKJk+xx3dPZaChka5Rbs/nkPjR2LTXFkePRkcKyx0rWdqYsdVrN40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761951502; c=relaxed/simple;
	bh=cFcjY5xhnj0bHFmoZpuKhefy18W+dkPGLsfStYZg96A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U557Au1t9AoQrZCZRq/AEXP6ljnGC+En+BIvlFSqUoe+98SFZswsZgvIjniDV/SGsH+NcwRaWCjXMtWmFM0g3h/PqbsiEG2hfUkBpR9SiCazSOJDfF+WvDgDHga0WasUrbQDAtQl/rDmxO0R1inCaMCOKSkQYr40ivGmvXL+cpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=hZjEPDaj; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a26dab3a97so1927496b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 15:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1761951499; x=1762556299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rTbu2Y1n3nG2K1ZFxQ3ZdRVxmOMkuNF29G4mR+aamAE=;
        b=hZjEPDajpEUqbi1rIVdbnnZcrCdEV2al/Gki7dYAdWB20uc1D2g1D8p7SXMhceIeZ0
         Fe/1alz0L+KPLGPY7BtzRgrQM5aDNuVtBtrjEg/r4ndAD+QESg1HAfjbRm3ZGBzcYnw3
         VDgZHyso3db/42wKVM/ZQxxkt5fBwLIjQZmt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761951499; x=1762556299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTbu2Y1n3nG2K1ZFxQ3ZdRVxmOMkuNF29G4mR+aamAE=;
        b=YoQyGnG6Slm69J3tJvS3dP1tEz/Y4nDlgd1GcHf7qal2+65nhM85qoV2VgaNwOtXIN
         rhhibxqXQOjI7YowF43k93b7XhRah9d6tXjQJGV3k/aJQO2aqVMwS1RbI4yExNuPNm09
         NuP9o2cwSIqFa8P+VJ7k7QYRfT+Tu5yhFmJrHWsk9KC1r1IJa/xk7JUHqUAMK1fLatmy
         ArofqJhgxNw5j0RxJBlI5QC2qR9kTNSqgSMIvdxB80+p93OIPpq93eCa/uklNg9TYcih
         /LJcLPYG39y8ZB2GqpmW8bt6/5nJnUi7fMEkMfro4hl31bxFjioZMkKy3nte7oxtlRg2
         cvyA==
X-Forwarded-Encrypted: i=1; AJvYcCVnverdC1/Xk+Nmzuc0yWdYzHG3w8sKQoH+p38Vb9YC4TJK1z27/dfaelDItZNeXeOscTmLeKb3ad6JsyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH1H+mj7xJkzaHzwKTwmEN7YSRJiN66YSLu7+zRnuNlj5u8LLf
	DtycgNxLlg8iBBF5ggulwaRCKeJoVwdYFDOGBPRUQtMi1B2UWCWUMmgff57JEOx1cA==
X-Gm-Gg: ASbGncu36HVXEEef3AGRKSEh0URPEyE1WhZjbfF66+Ta+wKXCfCUmmTrnxrVS1cPxBF
	7Gv0/8ii7N+VzTyXkVYWxGyVm4UynvNNfdWqxo3aMKNY99+KUm8UyOpLoSJzoIoMTguvXqdvsMn
	bABd2dUC+HmK5Wd7qINCnqpgI7mLBYDHdHB1omxfN5BjF2rYvYmSSU8b1BoQmiFzIVvLei9CuBI
	UUXP56eA/x+22720lZPdWXTpkreOPGjLmsooJQU64kVH+SlvOMUHjx3NMLYhnopu4powdWvYoZn
	y4z167o62dG6f+3cdk9fs0E4nwgRtUT/YI1Z3cu3h2biP2ccZ/EnW7yhG0Tl/OOaYvtnWkcIC11
	UlEyGZV+whc0qDVSrDsC92d1mUKs8V8qKdTfeo2eN03bUQ15FgJhjhjnQt4bG3wWh30Zd1gTA7b
	RQ3G/Yw4c5cvV7P20cs4l/qQ==
X-Google-Smtp-Source: AGHT+IEdltx1Q3f4Um5OVUeI5/5FIMfij3hj5c6VggtsG02XE+ivNwh5P2yHEG2MIlLPxJE7tbWO3A==
X-Received: by 2002:a05:6a21:e098:b0:334:97dd:c5b4 with SMTP id adf61e73a8af0-348ca969008mr7483131637.27.1761951499275;
        Fri, 31 Oct 2025 15:58:19 -0700 (PDT)
Received: from fedora64.linuxtx.org ([216.147.121.149])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93b7e1afbesm3206235a12.8.2025.10.31.15.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 15:58:18 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Fri, 31 Oct 2025 16:58:16 -0600
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
Subject: Re: [PATCH 6.17 00/35] 6.17.7-rc1 review
Message-ID: <aQU_CBmRIwx4ZMek@fedora64.linuxtx.org>
References: <20251031140043.564670400@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031140043.564670400@linuxfoundation.org>

On Fri, Oct 31, 2025 at 03:01:08PM +0100, Greg Kroah-Hartman wrote:
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

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

