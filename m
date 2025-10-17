Return-Path: <linux-kernel+bounces-858420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AA3BEAA28
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7471AA28B9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D38C296BC2;
	Fri, 17 Oct 2025 16:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="XmsHA4iR"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E705C287246
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717841; cv=none; b=NG9p9NOEb3YfyHsOBQeRPGykP6sBHcVL46tPvlOL+NHuZvr5sLu3Gb1nvLvLm9UKO4pUSKpNLN1Plc64vE98ARKson7f4vqbKOV9Xa58LE5s8jW99SHqWzIgxbxnKnIl3bnKTyKx52PjHFMXvPdt9z06imioy5Elzeeb6iX9epc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717841; c=relaxed/simple;
	bh=pPbWyGESoeFda9PL7qjMzI+KDFiJUk2WW07WgvOC0eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twCFdWsmKn+ZxxfO/XsTQrbaUJZHeaIR00va5pAlUgU6rO7S8t/6vQ4EpFZnMI2VxWCcUiVR1p0yBGHQT2ERMticoSNCk0rNnie8AfKh+V+/8dcf6rMO+I9NS3jS7hpQc6EhgUYHLv5D0T+eAVwYzO/1CWw7onAMRv1pdLrSPzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=XmsHA4iR; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-430cadec5deso5715335ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760717839; x=1761322639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SE59U9D9FBD2TsP2y/MjrBzEhIdNihINvSqWeLt6f7A=;
        b=XmsHA4iRMCoUXkqoAhZz91mStbZj7/xZ0iyoONrFgdOm+jKx2lxaEn9Bc9f0rGxOuf
         9TISpV5P6qO8uTPgf6zJCqv+r8fhg8OVHCKf6oJGNjc16iBIiZt11YPTbnFmz5Xe+5kK
         IXUHAFPnBwQ7CbtyhIULtonUKMoPq0CMgcCRSo2Kojsn+wp4m+bCSRXg7Hy0QftbjPHP
         RXvTCpWz5U0Xp2XxOlKCSMfgi9TQQIm4V9f2ItyBVPkqA00asRhSutVjKgSy4vVfcBDH
         nQyIKlJZDPZ1c8LrumBep6Im4uutjqMDVxG6UV0fOiRHzuXkaVCe0yTODZhTSn8kN1xX
         JMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760717839; x=1761322639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SE59U9D9FBD2TsP2y/MjrBzEhIdNihINvSqWeLt6f7A=;
        b=nNyqqODQghFO0UcYiFWncFmILHuGx9hkjtCbMoVAl8IkDPA8OB3odU+hsQroFFyjif
         IVwKobqGvCe08nflAu2WcJO/9IuimNvdlkQBA3t/naGFK8Jk3beokAPcR/jeN+Yp3S7O
         a49G3wYqZAmNOqdDDdJicC5HGrVuv6r8YoOHFojiKGrAtw2rK2OpSksZnUqUpMkwWSKt
         umkVVktjPX5ZwlBv12A7uceftnZK6qBnFQfvyyzROGDUhgKvDNJyFstHKHm3kHzA1BsV
         aY4ijmsDX4r6gvhax+vSatzPEqIsOBZhlanXSdCnu0nuuvOrT7hi8AZlKrLEFpFSh8/k
         +fhA==
X-Forwarded-Encrypted: i=1; AJvYcCUrAJZ4ayJpwk5RS7B3WYq31QMixAVbY+MMNdu5hnakCV4X/pa3S5AglndeHRDBkAQk0OoiLqQBW0NdNqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQPNnt8J6N+SPdp3bYhIqUuhv4o+10onOvbe0t//UMqTML3/Hn
	K1E0vk//rSO3omLS/O7tidEvtWbfW/cYffV1XzIVy9C/N3CDzZGB215DUGXEIjr/U0k=
X-Gm-Gg: ASbGnctbOfSP1q86hiMKbFh0u2uKzsggIVBGRzjRuXzlmDma7pXfwk9zCpff9do51+W
	BeLp43603a/vVxk5mTpnjl0oE2YeqcYVUG1/5e375ad2Z0zL+Q/NJxidbBA1RnhiXEhVUpFtGxW
	r6MUDy0Cwph2fqvTCmftP4SJx0XDEL0opp7I2o+UegQDbtIFELrPVVlr9a1DwY/EA+qFegmJeCt
	1toKgt3iIM+8JFid7BaeYGG8GcDKEPf2PeFp3nLc9Jopn40M11q2mqYyGADz+GYJvgqrPyLG/Tl
	fkl6HUVD0Q3cdwPLD4VA1uw/fI+V/RbNgmQeCxI0+aDQ2s+LwD0ZhYaFvLHxkj0xLXGnk5IGKXu
	43tbxax7S83RuPK+bOwgECf2zzDa1ZEA/DTxU0OMGLYZUUv3xfMMnZfTnAFD/o3R7/QBPvO5w2W
	8rsg==
X-Google-Smtp-Source: AGHT+IE/MHK6bGWFUML6lB8EABvgh/StOgVAz5yCP4m6sZL2slTHOrBxRy/hwICm8V+ly8yQelL67Q==
X-Received: by 2002:a05:6e02:b44:b0:430:ae1a:3375 with SMTP id e9e14a558f8ab-430c529df57mr60456845ab.26.1760717838760;
        Fri, 17 Oct 2025 09:17:18 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a979ab14sm8576173.65.2025.10.17.09.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:17:18 -0700 (PDT)
Date: Fri, 17 Oct 2025 11:17:17 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Atish Patra <atish.patra@linux.dev>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/4] RISC-V: KVM: Add separate source for forwarded SBI
 extensions
Message-ID: <20251017-68a09a4da911ec4eec058592@orel>
References: <20251017155925.361560-1-apatel@ventanamicro.com>
 <20251017155925.361560-3-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017155925.361560-3-apatel@ventanamicro.com>

On Fri, Oct 17, 2025 at 09:29:23PM +0530, Anup Patel wrote:
> Add a separate source vcpu_sbi_forward.c for SBI extensions
> which are entirely forwarded to KVM user-space.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/kvm/Makefile           |  1 +
>  arch/riscv/kvm/vcpu_sbi_base.c    | 12 ------------
>  arch/riscv/kvm/vcpu_sbi_forward.c | 27 +++++++++++++++++++++++++++
>  arch/riscv/kvm/vcpu_sbi_replace.c |  7 -------
>  4 files changed, 28 insertions(+), 19 deletions(-)
>  create mode 100644 arch/riscv/kvm/vcpu_sbi_forward.c
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

