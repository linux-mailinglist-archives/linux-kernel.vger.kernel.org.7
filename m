Return-Path: <linux-kernel+bounces-850166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5565BD21F5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA8BF1899361
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA082F9DA2;
	Mon, 13 Oct 2025 08:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ApqmZdBr"
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D567A2F7459
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760344994; cv=none; b=QYlCeOYFz1DyjtCik1LgYtNkm4WvVxhH9nHy6eNTrqmp3rLbaaASMSOY1zMlsVV22xQ5+NvHXXhJThC31M6NsRc2tTGALc44waprtT5Wm5x2o2zV+i2SAHDrek1UYfL0Y3TiD6TJWKOudtU9fsTuIWrcfXs/QViXCLXFYI7izPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760344994; c=relaxed/simple;
	bh=UooLLT2+k2eSFbtbDCcP/1aILrtCbHtbgr4qP1OaIew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XaU/GqRafqDTbjnxbbdOKNmwASMnOyMyFBVcAp/JgtDFDSONeN7f0uQC0Rhq4MarH3HRnGglk8TRqJ1U8f3RAjLTn68VqmrbbVVYvCKwqRiR5dsYQdV/4BSd0JWgyrrerhPuJjSHV/dtQv8QEiMuJ54nbScaOpfuDJPpoAfrU7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ApqmZdBr; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-633c1b740c5so3873826d50.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760344990; x=1760949790; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UooLLT2+k2eSFbtbDCcP/1aILrtCbHtbgr4qP1OaIew=;
        b=ApqmZdBrRMCqYFFLJ0nrf8XJTELhODe5nsTYeB2MzZxdemt0RMqMPpgdeHIfRuuiFp
         6/AROojcie2DpRiqK/1Ik1JFJ+9uzoNpRZwTP2t1oV3lCbo67mIWtJ7+p6Lwvm7kIFK8
         PEPwujPeBlagz2lZx8AH0BABJMn/zY//EXqKf0iig5mALHl33H1cvdFcGM5h946Tzk+a
         z9PdpPA0Jg5AeofiaqEFWehBNy3wVnqwIE2ht7adlYOaZz6ASFsMM6CMm5kabwH/hIlg
         nr/9UCi92g1coxQhtLocxnmXvYOwDdKvzldZh/deZLQSWtzNPg3sXbOI5jsCTA+nBLge
         ooxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760344990; x=1760949790;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UooLLT2+k2eSFbtbDCcP/1aILrtCbHtbgr4qP1OaIew=;
        b=PWOqSuq+E4A4n1MOPahFAYf9JmaRoMLtvraO7uInjzFrJGwYRTTQuurOR522Pql5Q2
         0wHp9WlY4VwuNq/ZbNc6D1dVMEs81l2K8H47kgu1J9bYuxi5UGq1zN39c+9KYo55ydlR
         6MUVNYOx8+vy+uN+Dmz6w+rIjMWuTlEF8WLxKIwzYxAYOQMd+HKB4FbDHEcFCA8R/dAO
         oEg9YZzIPTKDAmPDMgon/662K9Yh+UAJ373mL+cWJ0THIprMjARXAhqSTKxDUmUpyGGE
         hkmdHGM8U2dQ/B1oM8SiNjvYZ6sD0TmsFXXvyrpz4Wrtqjp7mq9ZRSvNf2gfY1vaDjhd
         wSiw==
X-Forwarded-Encrypted: i=1; AJvYcCUdbBcJMTty6XbMHMoLQOmSrJQjdU9eYjtsKHL1xf0PGc8O6ajsdxjsSpf1O27dloozRjAYMTEnw42gzK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YysqF//m/37P8wHM7c6nCdnozbGeKxVUJmRRMAZEfDdfcymUK8H
	xVd+O1y6ZdM8of1RkCwQSnd+ytwksz/vcpRSalmhjUGPmKcc1wteya8THhOybAfj9opbjeaivCB
	EsR99k0HRnNDaMxOJ9DVMs+uDbPQxrnOmUOQdTL2Zww==
X-Gm-Gg: ASbGncsxnMwNGYh28cMzmyh6AYlcN0eP0ZEjVaNR/Ru/TP7msJFMXgAxH3Uj2OzdNdC
	CYdoNbgnbvxYs4+JMshgAEr8N2GTc4eRK0qQS7ZSjuRrsZM/nysau5EvtR3vTMOUVkCoVpOn2nh
	uo+JtpwRxkGWclhi4yDuRV6Am2CQFHkBxA1gkWFopPSqUzOyvuGT5AO43S/SV4hexy04SPxVH4V
	FcoupK3d0ZOO5tZQZdP7J90NKxHq1WPfzkM+KTWBw==
X-Google-Smtp-Source: AGHT+IE7uecq6exgG9yMGFshaWnygPzsY94kaUydCSOH4t9VdYDMHhDCY7COXeGCW6oHpXyDu6o1jQTLE+lL7DHhfJY=
X-Received: by 2002:a05:690e:1518:b0:63c:f5a6:f2de with SMTP id
 956f58d0204a3-63cf5a709e0mr7250059d50.64.1760344989651; Mon, 13 Oct 2025
 01:43:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008201955.3919537-1-salil.mehta@opnsrc.net> <86v7koxk1z.wl-maz@kernel.org>
In-Reply-To: <86v7koxk1z.wl-maz@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Oct 2025 09:42:58 +0100
X-Gm-Features: AS18NWBOHqaPdVaNAQm6HnqE3sDpKzQQpa3lWt1IHGAjwjcmIhabHOei0Ckzxt4
Message-ID: <CAFEAcA8=yhQ-ygoA-fqxzwg69OkdW2nBM0O9X3Lmww4eXuVMWA@mail.gmail.com>
Subject: Re: [RFC PATCH] KVM: arm64: vgic-v3: Cache ICC_CTLR_EL1 and allow
 lockless read when ready
To: Marc Zyngier <maz@kernel.org>
Cc: salil.mehta@opnsrc.net, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, salil.mehta@huawei.com, 
	jonathan.cameron@huawei.com, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, james.morse@arm.com, sudeep.holla@arm.com, 
	lpieralisi@kernel.org, jean-philippe@linaro.org, tglx@linutronix.de, 
	oliver.upton@linux.dev, richard.henderson@linaro.org, andrew.jones@linux.dev, 
	mst@redhat.com, david@redhat.com, philmd@linaro.org, ardb@kernel.org, 
	borntraeger@linux.ibm.com, alex.bennee@linaro.org, gustavo.romero@linaro.org, 
	npiggin@gmail.com, linux@armlinux.org.uk, karl.heubaum@oracle.com, 
	miguel.luis@oracle.com, darren@os.amperecomputing.com, 
	ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com, 
	gankulkarni@os.amperecomputing.com, wangyanan55@huawei.com, 
	wangzhou1@hisilicon.com, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Oct 2025 at 14:48, Marc Zyngier <maz@kernel.org> wrote:
>
> On Wed, 08 Oct 2025 21:19:55 +0100,
> salil.mehta@opnsrc.net wrote:
> >
> > From: Salil Mehta <salil.mehta@huawei.com>
> >
> > [A rough illustration of the problem and the probable solution]
> >
> > Userspace reads of ICC_CTLR_EL1 via KVM device attributes currently takes a slow
> > path that may acquire all vCPU locks. Under workloads that exercise userspace
> > PSCI CPU_ON flows or frequent vCPU resets, this can cause vCPU lock contention
> > in KVM and, in the worst cases, -EBUSY returns to userspace.
> >
> > When PSCI CPU_ON and CPU_OFF calls are handled entirely in KVM, these operations
> > are executed under KVM vCPU locks in the host kernel (EL1) and appear atomic to
> > other vCPU threads. In this context, system register accesses are serialized
> > under KVM vCPU locks, ensuring atomicity with respect to other vCPUs. After
> > SMCCC filtering was introduced, PSCI CPU_ON and CPU_OFF calls can now exit to
> > userspace (QEMU). During the handling of PSCI CPU_ON call in userspace, a
> > cpu_reset() is exerted which reads ICC_CTLR_EL1 through KVM device attribute
> > IOCTLs. To avoid transient inconsistency and -EBUSY errors, QEMU is forced to
> > pause all vCPUs before issuing these IOCTLs.
>
> I'm going to repeat in public what I already said in private.
>
> Why does QEMU need to know this? I don't see how this is related to
> PSCI, and outside of save/restore, there is no reason why QEMU should
> poke at this. If QEMU needs fixing, please fix QEMU.

I don't know the background here, but generally speaking,
when we do a CPU reset that includes writing all the CPU state
of the "this is freshly reset from userspace's point of view" vcpu
back to the kernel. More generally, userspace should be able to
read and write sysregs for a vcpu any time it likes, and not
arbitrarily get back -EBUSY. What does the kernel expect
userspace to do with an errno like that?

-- PMM

