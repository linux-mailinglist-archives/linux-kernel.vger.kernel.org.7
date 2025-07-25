Return-Path: <linux-kernel+bounces-745149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C1BB115B2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 03:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6414C1C832EE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 01:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B071CF5C6;
	Fri, 25 Jul 2025 01:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JEOqWbvE"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C00F1C84C6
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 01:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753406402; cv=none; b=TcbhS/0TrVm8QbFznKKa/qH+GfrzF1wuBPf2XJR1SPFjdPu4gYpXtEQr7OnuJ3UrEeXgdyixT5Vny/U8/h9noa1ykLHB7WhmwzFJrWx8aFVsNbyT96KWSk3u8o40QXqHUyBwjZ9sRaHl0YqeGSdJG/FgczbVBhMMvtGfEz68QZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753406402; c=relaxed/simple;
	bh=KMp+aBJeXGXdSSkn8gWIZscNhYbFENCCJ2WhFi4gnmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tamWpuBKcRDeImzSQCkm1o54vSBEVgdrI2TIOVx0Xs67v7rJSCCMm1bNbkmQ9Q+5vGRhwVFJsp4xNh6lso5jH0qUIVa+LeJxvi1LzSvVHxaIA5v9fLT45I7n9hnWvjer7oLdOo42gGaOG/Iqs540kb9ku4I8gDVL+C+gpFHbOvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JEOqWbvE; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-87c11fd5364so66253739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 18:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753406400; x=1754011200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XK/gYnhz8WxypxaXzlzjFNaBe5jgICo9avyYr9Xjlc8=;
        b=JEOqWbvEaFXt8g6lmKWc9KkS8Fevfm3rp2dycADwy+MtfF6q+BPWgQ34kGGP48OJwS
         VF8LE0tJNFA2/iaWNKSZetk9tRTPcK/3Z8Iihn6D9O2n6zY710qlDkg+NAWG5QMEj0av
         7klwojsWYjELC5IhAUDPeAggv8/8phU/8JUWnDwBcXaSRKlGXFy0y0Wf1lvQmMkj9hps
         4//gguQrVb+mMfaNdhI+0dNWI7G8vA/OG5DFspuhuSwp5auHcFoFuyA0ZTQrMt0+n8lA
         BQ1pgIZxCWcKKFVeNA4Csi/pFkKrk/n/zJ/hgHf/X3rTp16xlzUnRGdrIdXSvYAGErZ1
         zRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753406400; x=1754011200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XK/gYnhz8WxypxaXzlzjFNaBe5jgICo9avyYr9Xjlc8=;
        b=fJlR6hXs7Tq4JN8Iscv6AtfdQxxklGk32ug0IkGDV3VGzN4GIXFgwXbou+ZGzTTrVy
         EAjStY8AY63pqctcebeSkiRw5TPxQv/utRPTvvDeGCZUAgSzZV7pfI92+GrGEI3fMKUe
         JaszyJIzYOfejI4/Q8uT7YHly8Dwud2g7m9VNQuV2tRbL9ejMSjAO0HcHwIV8PI1gdMk
         4ywBM/nt4tJigBp2wYG9AvjxwoMndLzDdY8CvBoPjbCWlHAIBQifLKXkQEkGDXZ8kk3V
         bRT2ECNb1BkbgkGh79KerYXKeIfzUCyQPojetAyBVBdywaBnTHSikZCrv4r6ke0BBNPw
         v1dg==
X-Forwarded-Encrypted: i=1; AJvYcCWVxrvRMQPISAqJfQMoC02qUQBKSXeiLp23DoB9TSxKVWlYZBXqBlacK6ej89aZNDDblbGKQvQBdWGfmtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYevjbcQ502krttodkF1UiuJmCEb8X2b65ptPbanAByfcQXbbH
	t7FlK0qnDkWGbAYcQqXdpIt8ahRWM6qinTr7J/3NosSosABlzWYzLdqFVrU4KMA+hA==
X-Gm-Gg: ASbGncvljMFKqeBSS5p0mrA23kNXwcsq/v/CiAACOVQGiYMp48+zkRBYZEgZX5UrR5H
	o590WADSWk0mrKXL+tNqGa35BPWsViki+ULo2npfS0wzZcrOge1F3cpyAJNV8Pq4+m281TSi9Xj
	iaPor4IeJUijveK6TxVD64+bkxhuK2YSSnIGS3MDFiAntmdaCtPVbNU0qffi6E7DY1uQUC6iURf
	qIB4YtejyaWy68Jl6stduLNlh2b2Foa1/688QUTkpPX1KiVnBFYzzPcFyOM2gVm3+UuT9Bbms+6
	qofycHbazSqt0rVeuRb7kjTL6BrnU35bZIFc02fptFD3oNh497piTRs5uFYVJZab0tnSlDQAiRj
	njEe5nX7tt5SnmFpiZ1i1MMITBrIXQ0m3gVeaZRtZcUnuhuPMiOC/QMz7Dwk1Y/jzacc=
X-Google-Smtp-Source: AGHT+IEmFccKRhDDkZ+Zb03HqYIMkjVZNy7vREse+9ncUz0sanXGTB21Co/1U2q+QuC2Ff0zX/sN0g==
X-Received: by 2002:a05:6602:2cd5:b0:873:de29:612f with SMTP id ca18e2360f4ac-87c64f89e6cmr1623090439f.3.1753406399396;
        Thu, 24 Jul 2025 18:19:59 -0700 (PDT)
Received: from google.com (39.173.198.104.bc.googleusercontent.com. [104.198.173.39])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-87e201992fasm28737439f.28.2025.07.24.18.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 18:19:58 -0700 (PDT)
Date: Thu, 24 Jul 2025 18:19:53 -0700
From: Justin Stitt <justinstitt@google.com>
To: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>, 
	Christopher Covington <cov@codeaurora.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] KVM: arm64: silence -Wuninitialized-const-pointer
 warning
Message-ID: <xcwmzitmc5igc3eplgr2uwviitdfmtdknth4a5zpaldamw7png@o22wb4ze3czd>
References: <20250724-b4-clidr-unint-const-ptr-v1-1-67c4d620b6b6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724-b4-clidr-unint-const-ptr-v1-1-67c4d620b6b6@google.com>

On Thu, Jul 24, 2025 at 06:15:28PM -0700, Justin Stitt wrote:
> A new warning in Clang 22 [1] complains that @clidr passed to
> get_clidr_el1() is an uninitialized const pointer. get_clidr_el1()
> doesn't really care since it casts away the const-ness anyways.
> 
> Silence the warning by initializing the struct.

For posterity's sake, here's the warning message which I meant to
include in the patch:

../arch/arm64/kvm/sys_regs.c:2978:23: warning: variable 'clidr' is uninitialized when passed as a const pointer argument here [-Wuninitialized-const-pointer]
 2978 |         get_clidr_el1(NULL, &clidr); /* Ugly... */

> 
> This patch won't apply to anything past v6.1 as this code section was
> reworked in Commit 7af0c2534f4c ("KVM: arm64: Normalize cache configuration").
> 
> Cc: stable@vger.kernel.org
> Fixes: 7c8c5e6a9101e ("arm64: KVM: system register handling")
> Link: https://github.com/llvm/llvm-project/commit/00dacf8c22f065cb52efb14cd091d441f19b319e [1]
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  arch/arm64/kvm/sys_regs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index f4a7c5abcbca..d7ebd7387221 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -2948,7 +2948,7 @@ int kvm_sys_reg_table_init(void)
>  {
>  	bool valid = true;
>  	unsigned int i;
> -	struct sys_reg_desc clidr;
> +	struct sys_reg_desc clidr = {0};
>  
>  	/* Make sure tables are unique and in order. */
>  	valid &= check_sysreg_table(sys_reg_descs, ARRAY_SIZE(sys_reg_descs), false);
> 
> ---
> base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
> change-id: 20250724-b4-clidr-unint-const-ptr-7edb960bc3bd
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

