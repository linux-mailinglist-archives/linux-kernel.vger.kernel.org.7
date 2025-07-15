Return-Path: <linux-kernel+bounces-731674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A35BB05812
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEECA3BF7C9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B52E2D8773;
	Tue, 15 Jul 2025 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtec.com header.i=@qtec.com header.b="FNbo36DP"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92D01D9A70
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 10:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752576210; cv=none; b=dQwkzDRc8Z5eCeHcwMdxSYVj4QRDZm2IVHKHdk+uiIvLwficNinUzD90g9f4JQerjZBIwq8yplTeXiBu1VC6Tol966Kg1+9FCpXzQCn0rHFYSyi/JtJyu9bZ7MyBVzo1fydaBzyAFmfMkl7wAnggoJ5OnNFkVHjWYK4Dbm03W7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752576210; c=relaxed/simple;
	bh=56NSMvnKKJQ7lDFzQs7vNIBcLPhb5FHqygnjryoFTQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lGPLETVctZPqOgRDRkrxUCyLy4/dz98lSCyjsm2k9os279GVzKauvUG56B0+l3WfbEqBdFSBeZrNz32qZRHfWcbW0+D9YrBXlD2viMjn5H987v+BUrGMv1SImW7TqorVCo+9ZFvxm34nayyK7gZ2PGs+VaMCX/eP6hPa2VtfqGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtec.com; spf=pass smtp.mailfrom=qtec.com; dkim=pass (2048-bit key) header.d=qtec.com header.i=@qtec.com header.b=FNbo36DP; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtec.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-531b4407cfbso2171583e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 03:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qtec.com; s=google; t=1752576207; x=1753181007; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jinrh9lrUEI9oP/K9YZbjkzFAwQHaDK22aiCMwvNLvE=;
        b=FNbo36DPIPSTLYjtSyITZiPX2ux3q35r34wKKMgtMu3t0XP4HRb7M1RyXPW385iUM8
         VqtRJpab8DNwDFHoEs/WUa6F2k9Wj6WwlUra9JzCR20RNnv2B2ACfLizfvpRqTgWJ/kW
         PTyRLbDOGBsebBVryQBk8oTYlvIRhq1eM8fXi7cF115/b7eHhZNZ2mEfz81VgGK3XaJ3
         qFDFVNj64SudvRfsQvSeKx563hdUV0THwSTEj9hgPvtGNKlH1SzvA8EJO9eK9tDUutlc
         v0Jm7pw82ecU7t4LsOpIiX/nYIdMIAL1oYqIuRhxJGRwyLsUwqfaIPSQc2pgxeTmdmDO
         gSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752576207; x=1753181007;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jinrh9lrUEI9oP/K9YZbjkzFAwQHaDK22aiCMwvNLvE=;
        b=RS2EVfeJM/K8uArcGJbOr3Q3MjQLXP/xh1upz5MhKcx6FHVHxSwVj95kJP3e8GRvp8
         bFGULU3FT6Q68lpo/NsXugRbQo9v6XIkID6JjtxpyTgYI87WYeMO0DQavwns/4yeB8bC
         HAJjnJcp2sWAyvdUsmjGrGDEwGZ+Ssc8w++1zXzBB77ANGl30swqBMBO1uHJM2HrI79+
         fP4gjbZ39nZrop4zmmHdMDT3hAEqDll+DhhRpTCOXnfobEWNf5bUBxbrIwx5htpH2qqq
         40JQJikFzYtDh8VIUXBa7UIpfLK4OKBtdysEbTtw3JdkekZQFNeua2WXH7cSsZeCDkM8
         ghbQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6n8Ktz64LA8wz8Yzi4gx2bF1NnnJdMIIfVH1I0KWwk2Aeqcj0GxGrq1/airejXzid65N85NE5iqbLHVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypns6UPIafF3++lDEYog6C3Tq4Ur6wXSJfh4hYll/bapFunDBU
	oNxSnyaBPXMMTpaR+qgFOBgPR4cprX8E2hEgBZ2LVMGfyGWHJS9KsqStEgZx6Yg3DhbX7fWtz8j
	dz/1gNN3aafJFJJ6ZkgHmaAEh5uXEfSP5gEBOc6bVxQ==
X-Gm-Gg: ASbGncugt5czHP3XGdub7dfMC3T3KB8LdAubJyg2aeArrpp1Lx91UcCRx5CdI5nBiVb
	+clESV4cKdJd238IG0XKof44arI0Lygsbl9uCS0IX2xTYQXbfruRDUbj9jC4y/RxmB0QD/5VFFZ
	PItNY1CtX3lXu9v1zSIMtfGQh+fKoMMr2HyCFLIj5plJwKQnj+Fu/6J0CFoTmTuvKrmY9viGZPH
	XnSqg==
X-Google-Smtp-Source: AGHT+IE6wEwLG2iscN6gkx0xYTHNGr2J35y1IB016poByLQ/6Zb4m/3NuN1Xs87IAIZLj0V1lGTl6eKOu6hJK98nmUw=
X-Received: by 2002:a05:6122:468c:b0:518:6286:87a4 with SMTP id
 71dfb90a1353d-535f470d42fmr10371788e0c.4.1752576207474; Tue, 15 Jul 2025
 03:43:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJDH93s25fD+iaPJ1By=HFOs_M4Hc8LawPDy3n_-VFy04X4N5w@mail.gmail.com>
 <20241219112125.GAZ2QBteug3I1Sb46q@fat_crate.local> <20241219164408.GA1454146@yaz-khff2.amd.com>
 <CAJDH93vm0buJn5vZEz9k9GRC3Kr6H7=0MSJpFtdpy_dSsUMDCQ@mail.gmail.com>
 <Z78uOaPESGXWN46M@gmail.com> <CAJDH93uE+foFfRAXVJ48-PYvEUsbpEu_-BVoG-5HsDG66yY7AQ@mail.gmail.com>
 <20250621145015.v7vrlckn6jqtfnb3@pali>
In-Reply-To: <20250621145015.v7vrlckn6jqtfnb3@pali>
From: Rostyslav Khudolii <ros@qtec.com>
Date: Tue, 15 Jul 2025 12:43:16 +0200
X-Gm-Features: Ac12FXwrM0hudYT1gpsjlNr37WqavqVM6O9H4kuS5lrXXokjtyQkni4XfPlvseQ
Message-ID: <CAJDH93vTBkk7a5D0nOgNfBEjGfMhKbFnUWaQ1r6NDLqm0j3kOA@mail.gmail.com>
Subject: Re: PCI IO ECS access is no longer possible for AMD family 17h
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>, 
	Borislav Petkov <bp@alien8.de>, =?UTF-8?B?RmlsaXAgxaB0xJtkcm9uc2vDvQ==?= <p@regnarg.cz>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> Yes, I would like to get access to ECS via CF8/CFC direct IO for
> debugging purposes, even though MMCFG is enabled and used.
>
> If you can send me a simple patch or any sample / idea how to do it,
> I would be very happy. I was not able to figure out how to enable ECS
> over CF8/CFC.
>

Hi Pali,
I'm sorry for the late reply.

If I understand your request correctly, all you need to do  is patch
the pci_enable_pci_io_ecs() function to use
the different register to set EnableCF8ExtCfg: D18F4x044.

Regards,
Ros

