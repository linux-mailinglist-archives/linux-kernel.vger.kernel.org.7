Return-Path: <linux-kernel+bounces-851765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 330FCBD733A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83B2B4F77EE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88EB271446;
	Tue, 14 Oct 2025 03:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="eGEVymN4"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466EF3074AF
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760413229; cv=none; b=oA0kBA/yaIdht7Q9dS1zZQ2kZRciN46ciNF0QmYCoioHzEodZ/48L5m54v5fLTXrgtJsRwEPJAqgRJQ2jwQYWCKCHEzy2WsjoGWV6fNPR3jSKFMfrPIj2X2TuMdS4V3FvG1UuftY8P8s/Pb64+wpP9KIGxj7xxkFDVrcJksFkv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760413229; c=relaxed/simple;
	bh=VKGntvZN3GtJcSSMa1nguMCR6YJ0j+Sv/UrDmr5viNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kzr3OSUXyyA1hcf3+NsDX4eQxRdKz6ZGzPBqkGqz3Gv12kuaSSpBfKD01fN5HlenkInnGp8Qe4MWyE8fM+xICHaAsfQKuZ+OSnWHXnCGaWAGp593Bu82L560FAa7IlFloGXOZQt1CRi/GjJ39YOX6A/BmctwJzFZIFlT2jBNOFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=eGEVymN4; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b633b54d05dso3092628a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1760413224; x=1761018024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vQD13QPg4OYqU4LJRXtRf+THjzsxA+16HameJIJG8Y=;
        b=eGEVymN4DFYhGUygzqIgp5CRsQe6XCySVC3/wblEh2PXDlmtSvkZJF2QLPC2RiLrue
         dcp5y7C+FJuH5wbvlFE4YWWE/Do0LFGV+Crj/j+rrWrACNxp6cR3ZQtuZWHAX4fy1Wno
         n2xrTafR65jMy4A4jtEH18myICaDYindxvMwwMwy29BN8Z03sKLtlUw/7Xt9D/izrpQV
         aNKb+YzLtG+2FydlVCKjpHqdPAimCJ+Fd1uVu+/2vGAwILF43OV0EJoEY0Zn7MLbJaI6
         7nIdsiokH7r0sncORSPb3tTKNsm1sTRGgCDhkOvgnfhDf5jyNonxfSdsnXCRmQmq8wYI
         XP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760413224; x=1761018024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8vQD13QPg4OYqU4LJRXtRf+THjzsxA+16HameJIJG8Y=;
        b=njVFQX8hMU6qkH8jYDPXTDJ1Fj+jen5fwfljqXum8amtBHOIBit++8PXtul2l97ub+
         CcpVOCiCdxFpm64MBAOCkaW3CagWibdcQQUN0mIHFwt3NzR5i4yNNkf7yxcCITTrEDEO
         ktf3X8L3R+XwGzMpAEepO2R0fBeqFrE1gWmsFHClSKJKV1zkD/bcJC7z5l1a7o+mjx3U
         sEzjmMUcCOdZOe+lXK4UPyZaV5wVDcp5FT2EqGlFhglQEP79TF9cLSYlHYQq7IKVbFQG
         ABpjfCNxi4wq/0Eb7HydN60OzfbU97k7GP5mU5bPHQom6d+1T+tYneQS+b+Y3lGUUIyZ
         wfJw==
X-Forwarded-Encrypted: i=1; AJvYcCVpgNomZDVyu794QjCHxQ8GIZFUiGaF3uqzu97xXikVeH+l4wcmsP7qn6h/QxUBP8RvYLp+KKwpisYiIBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi8VzCPVLUqTpU4PeCL6xaOKN4Ag7KcclU99B6tW6g9j6xAIY8
	fmaaok5tLQqxOdMt/985x1+eFww6uAQp0CtOBMiXKUMqrRrHPi3E5RDAzZZvZclfIF4DDCLKTHG
	+/BmjuiihY7f50nSkc6FvLWKDMFlsGEG8txMudAu1kQ==
X-Gm-Gg: ASbGncsUYSVKoQfhVM0flA5JFKhwGLZaTnOS125U+MuKFI7sqmnQzI9CaTbeBOfRPRq
	lMt/tcPlMQSLZS0wZt8cXXJ5euFAHDV0gFani56kFYr6ebTQ5ec1xNja7gI4Fr0/WjKJygE20iC
	naTBHtd/93EFHiQ0DyreCjEJwxDCww8+oYZD7URrCaXaoxRgU8v8FrpgXd3aAZg6xwFSj4jkQba
	zpdr2nVY44keUMeoiXiBTI=
X-Google-Smtp-Source: AGHT+IGsxs2zB/o2HDMRrXG0CDlIO/I666LTqgKADPiE2fPpkCQ25Qw5JRCeUi5m+2HIo6aoKW6CFhEClCT8ijRr2z0=
X-Received: by 2002:a17:902:ef07:b0:288:5d07:8a8f with SMTP id
 d9443c01a7336-2902724dc52mr282297695ad.24.1760413224085; Mon, 13 Oct 2025
 20:40:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013144411.274874080@linuxfoundation.org>
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 14 Oct 2025 12:40:08 +0900
X-Gm-Features: AS18NWC2Fr-gWwcy9LStVOnnGEG1wp1A2vfCsJcVgNKnq4cVcnZwA7crRcv7UoQ
Message-ID: <CAKL4bV47oB56+6KG5btFQOqMtZUgzEhMibFScCSyduqiqaVQ-A@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/563] 6.17.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Tue, Oct 14, 2025 at 12:33=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.3 release.
> There are 563 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 15 Oct 2025 14:42:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.17.3-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.17.3-rc1rv-g99cf54e7bd2f
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU
Binutils) 2.45.0) #1 SMP PREEMPT_DYNAMIC Tue Oct 14 12:16:46 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

