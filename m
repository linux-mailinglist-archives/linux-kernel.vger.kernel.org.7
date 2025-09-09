Return-Path: <linux-kernel+bounces-808883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D67ADB505CA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 925F33A50D6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCBD301487;
	Tue,  9 Sep 2025 19:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SxMxsdIA"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2552DAFBB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 19:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757444596; cv=none; b=VfNzwXCu9adrrInWqHPGBsRKwdAlw2klXtbWiBl88yfFOD3NpM8tX0FQQVFYeOcIBN0V4mcekrpX8iuEPwyorDC0e++VYuJDglMTy+q1u6oEK5pCW9PsIOsVYv63phxlvzEHeNBbGE7x6UgT0nM7Ouhth+YyTxUQ0lhGkE/9XtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757444596; c=relaxed/simple;
	bh=EjNAaxQUenuK7EaRLOLrG29w1k9jNgb4H9oETUyneSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqkFsN2ofkMwDmpPukXjze1BTvGDHhJGmK0eHVEA63Jy85cV3K0d680woUuDWFBiF8jF1CiYbXFMWYiJy+6SIG3d4bUOs7l1J9a5XfYaqJdn9GlSbXdIhJ1OndtS2aWYmpK60S3GiJB2yX6M4+STpoSMbrm9/U9+cbkfqWzsgHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SxMxsdIA; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45de54bfc36so13275e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 12:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757444593; x=1758049393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=833QCxEdhL0JSxB6O316FiCLruN7/IzPCiKaaovTmfQ=;
        b=SxMxsdIAziFLJ3nO58KARGnaHsBsUcDIzZs4D7gHk3DLYhU39nd5BcAQIoURV7i18V
         DWdSg8TfhekpUA46Bc6F733rCfUZBQidl43n7RY0mh8OVvMY1BysS5/kc/Cve/BHst9z
         IQQc+FaJQeLpSDgn8KWciq7uiGh16c140+s4a51NY3PCZ6U6bWsH3vYh4d1YvUCkoOQ1
         mjpMK9j+p7kQVZPDG4hsjdmgsabhtF3bn6L18XOS+fzYe+kwKYCiYdUnbj/tEjFIZLvQ
         TbX13csc1ZUwuoFmxZVpIaylBjeZScDsG+V+kQnmwN5k8pT8qCN1rVCr1xh59iiBYwkm
         jrxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757444593; x=1758049393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=833QCxEdhL0JSxB6O316FiCLruN7/IzPCiKaaovTmfQ=;
        b=eVnYYLiiwVWCduxyXcGy+IqEt/jQrPPYKQqoOK2m8vpOxudf/Gls6NBresFsbljQbS
         vPa9fATxCdbpNrEJIlVWXigCqbVlTYFclymXj8mB9oQy1p5ffCU8n5XbFM30mjLU2ZXy
         JL2XqWmB7yN9lJlhTcHxtz0fEHuMDF0pEUUo8S6O9N60ltEiiT17x8jE1fKzAGW3JRNr
         P2+p+6g/xHi0SPlraVVo4PKiyEZxtaBeCP61o+0doWCm5y9or5840bFuF3jJMT+FOxjf
         oLrTede6Fb7to3pqAruvCa53h0cUCSQNU3VEKsOTYr0I3uJiuZrayE97BgLM2yfhIUBT
         7EAg==
X-Forwarded-Encrypted: i=1; AJvYcCWfvQ/9UpVuBUOE8ZimMCt+GyrtNiEvv7CPhrOs3v0CxZuTnkpag8WqhyxPpwLGb0Y0HS7E4Wfg8qeb05M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6eRr6s8HQPYM86pfI8BMgxyLwpV+ZVSl7WKPtXsfL4itb+o1Y
	o08FBDa9EqQKCT/6AYiew7p2liWoK84fyuFCBz3pEo6fznuO4TqPEhSnD8+sefulDw==
X-Gm-Gg: ASbGncsoOT1CPOodOhAsej0U5Jat94KvLdjmsr+kjpGPbdwdRTwacy1pa3L9urrg5OW
	2tKTawuIIdySyEAJJR2QOBT+4TGPsO30A7mdWAf2UFojUQ9g0jh+yFuc12Sr0kOmauZUWFGO2nK
	81DnqWvEmcjpHBNK+x8A7tspaBJBFZrFVKmO/yHvF0GuHB19SqtxZrJ9wO2IxYK7YRE8doo1yj8
	t3eRBHZ2GwFRK/JNAUrHogI8hvsZME37m1xDimGZaNc+2V81xb2BGLpZQXCoxry8WvOOPzK7Hgg
	ST/IKP/XDWt3wLKYvEgKcIcuIYwedFI9AnHpIS+wNwwURyQo++neAG4PSKn2bYX79H3JUPGe7Ai
	ye3HLEYbbBOzwxbbEywOFuGEzGaHonw5syMTGEZEFbLaYQ5CFCPB+FIz/PGgRhvY7hzjME9nCnz
	4QTQ==
X-Google-Smtp-Source: AGHT+IF/7Gke/uEJRI8ZanBW5R1zgvfkJ5RRqnaXdfg0LKuZIsEThOsZZRdKhI2pCuXyyI5lT2W0qg==
X-Received: by 2002:a05:600c:5c3:b0:43d:409c:6142 with SMTP id 5b1f17b1804b1-45df73eb3a0mr156745e9.0.1757444590528;
        Tue, 09 Sep 2025 12:03:10 -0700 (PDT)
Received: from google.com (26.38.155.104.bc.googleusercontent.com. [104.155.38.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75223ea47sm3592410f8f.46.2025.09.09.12.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 12:03:05 -0700 (PDT)
Date: Tue, 9 Sep 2025 19:03:01 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, krzk@kernel.org,
	alim.akhtar@samsung.com,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Subject: Re: [PATCH] soc: samsung: exynos-pmu: Fix for CONFIG_DEBUG_PREEMPT
Message-ID: <aMB55Rhn9M_DvBab@google.com>
References: <20250905162446.88987-1-smostafa@google.com>
 <CADrjBPqH==y5KaN6oBnGJ8407gx31sGVEFqqNdz8NG_vPuNPYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADrjBPqH==y5KaN6oBnGJ8407gx31sGVEFqqNdz8NG_vPuNPYw@mail.gmail.com>

Hi Peter,

On Tue, Sep 09, 2025 at 12:14:51PM +0100, Peter Griffin wrote:
> Hi Mostafa,
> 
> Thanks for your patch and bug report, it's great to see more folks
> running upstream Pixel 6 :)
> 
> On Fri, 5 Sept 2025 at 17:25, Mostafa Saleh <smostafa@google.com> wrote:
> >
> > Booting the kernel on Pixel-6 with `CONFIG_DEBUG_PREEMPT` prints the
> > following WARN:
> >
> > [    0.784187][    T1] BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
> > [    0.784328][    T1] caller is debug_smp_processor_id+0x20/0x30
> > [    0.784433][    T1] CPU: 6 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.17.0-rc4-gd69eb204c255 #1 PREEMPT
> > [    0.784439][    T1] Hardware name: Oriole (DT)
> > [    0.784441][    T1] Call trace:
> > [    0.784443][    T1]  show_stack+0x34/0xa0 (C)
> > [    0.784453][    T1]  dump_stack_lvl+0x7c/0xb0
> > [    0.784460][    T1]  dump_stack+0x18/0x24
> > [    0.784464][    T1]  check_preemption_disabled+0xf8/0x100
> > [    0.784470][    T1]  debug_smp_processor_id+0x20/0x30
> > [    0.784476][    T1]  gs101_cpuhp_pmu_online+0x40/0x108
> > [    0.784483][    T1]  cpuhp_invoke_callback+0x188/0x2d8
> > [    0.784490][    T1]  cpuhp_issue_call+0xec/0x240
> > [    0.784494][    T1]  __cpuhp_setup_state_cpuslocked+0x140/0x2c0
> > [    0.784499][    T1]  __cpuhp_setup_state+0x58/0x88
> > [    0.784504][    T1]  exynos_pmu_probe+0x2a4/0x380
> > [    0.784508][    T1]  platform_probe+0x64/0xd0
> > [    0.784516][    T1]  really_probe+0xd0/0x3b0
> > [    0.784520][    T1]  __driver_probe_device+0x8c/0x170
> > [    0.784524][    T1]  driver_probe_device+0x44/0x140
> > [    0.784528][    T1]  __device_attach_driver+0xd8/0x180
> > [    0.784532][    T1]  bus_for_each_drv+0x90/0xf8
> > [    0.784536][    T1]  __device_attach+0xa8/0x1d0
> > [    0.784540][    T1]  device_initial_probe+0x1c/0x30
> > [    0.784544][    T1]  bus_probe_device+0xb4/0xc0
> > [    0.784547][    T1]  device_add+0x4d0/0x700
> > [    0.784550][    T1]  of_device_add+0x4c/0x78
> > [    0.784556][    T1]  of_platform_device_create_pdata+0x9c/0x148
> > [    0.784560][    T1]  of_platform_bus_create+0x1d0/0x370
> > [    0.784563][    T1]  of_platform_bus_create+0x234/0x370
> > [    0.784567][    T1]  of_platform_populate+0x84/0x178
> > [    0.784571][    T1]  of_platform_default_populate_init+0xf0/0x120
> > [    0.784579][    T1]  do_one_initcall+0x68/0x2d0
> > [    0.784585][    T1]  kernel_init_freeable+0x2d8/0x358
> > [    0.784589][    T1]  kernel_init+0x28/0x168
> > [    0.784595][    T1]  ret_from_fork+0x10/0x20
> >
> > As this value is only read once, it doesn't require to be stable, so
> > just use "raw_smp_processor_id" instead.
> 
> Can I ask what baseline you are running when you see this warning?
> 
> As this code got refactored recently in commit 78b72897a5c8 ("soc:
> samsung: exynos-pmu: Enable CPU Idle for gs101") which is present in
> linux-next but hasn't made its way to a proper release yet. After this
> patch smp_processor_id() is always called with a raw_spin_lock() held
> (so this warning shouldn't fire).
> 
> I just built next-20250909 locally to confirm, and with the above
> patch reverted I see the warning you mention. So in summary I think
> the issue has already been fixed by the above commit.

I am on commit

commit d69eb204c255c35abd9e8cb621484e8074c75eaa
Merge: 68f285e26478 9b2bfdbf43ad
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Sep 4 09:59:15 2025 -0700

    Merge tag 'net-6.17-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net


Which doesn't have the commit you mentioned as it is in the Maintainer's
tree, thanks for pointing that.

Thanks,
Mostafa

> 
> Thanks,
> 
> Peter

