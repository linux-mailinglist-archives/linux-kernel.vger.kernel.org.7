Return-Path: <linux-kernel+bounces-877972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF7BC1F786
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7309E4E1EBA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30B634F27B;
	Thu, 30 Oct 2025 10:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="STmAOGFg"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547423164B5;
	Thu, 30 Oct 2025 10:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819158; cv=none; b=iWQLGia/Z5Kpr7B0EF+9Q+dkr0v5wdgny/+bY6BwIMR7KkUNuM/EDm6HcQ8ub4O9yxawbgfdvN3UOujb3K1j8N5xpybryqjT2SYfGdGg/EWQx1weTgjjAczH0RCjSOGKSWlIYZmBGwAIqon2uESiSvG1U/KgiPfiAP2ajlYNldQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819158; c=relaxed/simple;
	bh=dhe5hWEbSj3mybgx0Wmylls/KBMzTCWsABawFCUZ38M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MhUd0a1MXyOrbsNI0CFM26/DghHNrJdqmfDV6JTRk2FpxERFCx6bIjiNhRgC3BI/3SsqS+5HuDbi9y3EW2W680ilgPhMWR72+rhakv8nUwPpRU0+UeyYDisQEhkEYiLmiXwwlzNUrxnxTCHoK2KlObblU5UwBoa5j93dXm+nLeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=STmAOGFg; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OZ4N9TczEkaWQXX9FpGdKspSCW0r/hMNwWOBLZCuSrs=;
  b=STmAOGFg523OPd9WWo7cjqFjVPZcRPz4YC/+Vp2bGwXlazF9SCG5VVOS
   ObaF0NosRzBAOYxYEyEQF8Cl80ejq51i3uZZSHz7+g0nTYN/rNhzTYaGd
   +mbqCp6aWhvgxv66pMHPqVA8Rn4popEtb/41B98qPPIf16+V7nZ2w1FB5
   0=;
X-CSE-ConnectionGUID: b6XOW0K3QAumCM59nBlBQw==
X-CSE-MsgGUID: EdasjcjUSZaDJxmSMsgotQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.19,266,1754949600"; 
   d="scan'208";a="246827816"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 11:12:33 +0100
Date: Thu, 30 Oct 2025 11:12:33 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>, 
    kernel-janitors@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>
Subject: Re: [cocci] [RFC] Increasing usage of direct pointer assignments
 from memcpy() calls with SmPL?
In-Reply-To: <62441255-45fc-4edb-a8e5-c208b36ca2c2@web.de>
Message-ID: <53e91f9f-bfe5-5c57-157c-fc456bd430ca@inria.fr>
References: <ddc8654a-9505-451f-87ad-075bfa646381@web.de> <e54a6e57-6bde-f489-f06f-fed9537688df@inria.fr> <62441255-45fc-4edb-a8e5-c208b36ca2c2@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1019221123-1761819153=:3629"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1019221123-1761819153=:3629
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 30 Oct 2025, Markus Elfring wrote:

> >> It can be determined then from the generated diff file that mentioned
> >> implementation details can be transformed in 304 source files at the moment.
> >> Thus I became curious if it would be supported to adjust any places there
> >> according to (Linux) coding style preferences.
> >
> > If you have a concern, you have to say what it is.
>
> I expressed something for further development considerations.
> The source code analysis result can be interpreted in some directions.
>
>
> >                                                     It doesn't seem it is
> > about the running time,
>
> Not directly in this case.
>
>
> >                         so why do you include that information?
>
> Further software users can compare such a measurement with other observations.
>
>
> > I should not have to repeat your experiment to figure out what you are
> > asking about.
>
> You can recognise recurring development challenges, can't you?
>
> * Change resistance
>
> * Varying coding style preferences
>
> * Code improvement possibilities
>
> * Development resources
>
> * Pretty-printing issues
>
>
> Another test result representation for your convenience:
> https://elixir.bootlin.com/linux/v6.18-rc3/source/arch/arm64/kvm/arm.c#L2554-L2726
>
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time /usr/bin/spatch --max-width 100 --no-loops …/Projekte/Coccinelle/janitor/use_memcpy_assignment.cocci arch/arm64/kvm/arm.c
> …
> @@ -2600,8 +2600,8 @@ static int __init init_hyp_mode(void)
>                         goto out_err;
>                 }
>
> -               page_addr = page_address(page);
> -               memcpy(page_addr, CHOOSE_NVHE_SYM(__per_cpu_start), nvhe_percpu_size());
> +               page_addr =
> +               memcpy(page_address(page), CHOOSE_NVHE_SYM(__per_cpu_start), nvhe_percpu_size());
>                 kvm_nvhe_sym(kvm_arm_hyp_percpu_base)[cpu] = (unsigned long)page_addr;

This is all I wanted.  The rest is complete noise.

I think you would get a more satisfactory result by just removing all of
the code and adding it back. Then Coccinelle would take charge of laying
out the whole thing.

thanks,
julia

>         }
>
>
> real    0m0,606s
> user    0m0,576s
> sys     0m0,030s
>
>
>
> Another SmPL script example might become helpful.
>
> @replacement2@
> expression object, size, source, target;
> @@
>  target =
> -         object; memcpy(target, source, size)
> +         memcpy(object, source, size)
>  ;
>
>
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time /usr/bin/spatch --max-width 100 --no-loops …/Projekte/Coccinelle/janitor/use_memcpy_assignment2.cocci arch/arm64/kvm/arm.c
> …
> @@ -2600,8 +2600,8 @@ static int __init init_hyp_mode(void)
>                         goto out_err;
>                 }
>
> -               page_addr = page_address(page);
> -               memcpy(page_addr, CHOOSE_NVHE_SYM(__per_cpu_start), nvhe_percpu_size());
> +               page_addr =memcpy(page_address(page), CHOOSE_NVHE_SYM(__per_cpu_start),
> +                                 nvhe_percpu_size());
>                 kvm_nvhe_sym(kvm_arm_hyp_percpu_base)[cpu] = (unsigned long)page_addr;
>         }
>
>
> real    0m0,626s
> user    0m0,588s
> sys     0m0,037s
>
>
> Regards,
> Markus
>
--8323329-1019221123-1761819153=:3629--

