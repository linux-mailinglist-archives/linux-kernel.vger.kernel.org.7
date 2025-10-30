Return-Path: <linux-kernel+bounces-878210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D82C2008C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38CC6425AEA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998D420B80D;
	Thu, 30 Oct 2025 12:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="MTlJW8I0"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3D8AD5A;
	Thu, 30 Oct 2025 12:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761827514; cv=none; b=iucr8G43y3Bt3UGFurUa4C5c+zopc4OCFK4r5TQUsuq/7QSSemJEEavrmy/AELFastlmOPvl9qKh/QOb5eAf4TvwMBiM1DWnlRTv2lZ/+AG0hWkyN0wMPaN6aotQv2lMjej2BDQkpbxndWYhu4nVEPQwqw6Yl5TAl4xIDmN+EUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761827514; c=relaxed/simple;
	bh=rIMv9CB+t8OdAAD03jfWkW04cN3YceusNZxWpLy9Ol8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Fau+n1dcbZtf45wiWAwdxkHSCmgD+5l5PHdUwJ0YhoAaVR3k9tKuQcsPHj5u0rLyDMsERMripKUCXYHMhGl5qOmaSsI0uidbedVSPG5ZT4v8KSOicVWoMTI0M0Ci8CkoiKHVGarnv3aRAZNO6pzUGL34agKami0NK/ics64JVN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=MTlJW8I0; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=40ecY0U9Xo+6IKV4rUw0adOO0P61BYlJqCroRoMWneM=;
  b=MTlJW8I0ODjFo79UiGZmY5uf1x+SUtqmsTH4R9eflHzxmMxgQ0UgWNYx
   zOm8hZv/WZ/IXYWL5hXeRa1Ad5tm04qDt9NRzZGnG6UkXGPvnCDay4YRj
   gU1X12Y6OOjW0m5bBjwZg0AYo6+OZMbU9So6MSpK3hia9/psIrMEz5ErJ
   U=;
X-CSE-ConnectionGUID: +seXBmm7Th+ESK2tzrllMg==
X-CSE-MsgGUID: jw7W0DflTi+GhrOvNeeePg==
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.19,266,1754949600"; 
   d="scan'208";a="129496016"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 13:31:50 +0100
Date: Thu, 30 Oct 2025 13:31:49 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>, 
    kernel-janitors@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>
Subject: Re: [cocci] [RFC] Increasing usage of direct pointer assignments
 from memcpy() calls with SmPL?
In-Reply-To: <60f881dc-979d-486b-95be-6b31e85d4041@web.de>
Message-ID: <aa99eded-be51-af3b-414-7c3bbaddea4a@inria.fr>
References: <ddc8654a-9505-451f-87ad-075bfa646381@web.de> <e54a6e57-6bde-f489-f06f-fed9537688df@inria.fr> <60f881dc-979d-486b-95be-6b31e85d4041@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-937884858-1761827509=:11598"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-937884858-1761827509=:11598
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 30 Oct 2025, Markus Elfring wrote:

> > If you have a concern, you have to say what it is.  It doesn't seem it is
> > about the running time, so why do you include that information?
>
> How will remaining open issues be resolved?
>
>
> > I should not have to repeat your experiment
>
> It would be nice if further software users would occasionally reproduce
> presented data processing possibilities.
>
>
> >                                             to figure out what you are
> > asking about.
>
> I “accidentally” tried also the following SmPL script variants out.
>
> A)
> @replacement3@
> expression object, size, source, target;
> @@
>  target =
> -object; memcpy(target, source, size)
> +object; memcpy(object, source, size)
>  ;
>
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time /usr/bin/spatch --max-width 100 --no-loops …/Projekte/Coccinelle/janitor/use_memcpy_assignment3.cocci arch/arm64/kvm/arm.c
> …
> @@ -2600,8 +2600,8 @@ static int __init init_hyp_mode(void)
>                         goto out_err;
>                 }
>
> -               page_addr = page_address(page);
> -               memcpy(page_addr, CHOOSE_NVHE_SYM(__per_cpu_start), nvhe_percpu_size());
> +               page_addr =memcpy(page_address(page), CHOOSE_NVHE_SYM(__per_cpu_start),
> +                                 nvhe_percpu_size());page_address(page);
>                 kvm_nvhe_sym(kvm_arm_hyp_percpu_base)[cpu] = (unsigned long)page_addr;
>         }
>
>
> real    0m0,578s
> user    0m0,524s
> sys     0m0,047s
>
>
>
> B)
> @replacement4@
> expression object, size, source, target;
> @@
> -target = object; memcpy(target, source, size)
> +target = object; memcpy(object, source, size)
>  ;
>
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time /usr/bin/spatch --max-width 100 --no-loops …/Projekte/Coccinelle/janitor/use_memcpy_assignment4.cocci arch/arm64/kvm/arm.c
> …
> @@ -2600,8 +2600,8 @@ static int __init init_hyp_mode(void)
>                         goto out_err;
>                 }
>
> +               memcpy(page_address(page), CHOOSE_NVHE_SYM(__per_cpu_start), nvhe_percpu_size());
>                 page_addr = page_address(page);
> -               memcpy(page_addr, CHOOSE_NVHE_SYM(__per_cpu_start), nvhe_percpu_size());
>                 kvm_nvhe_sym(kvm_arm_hyp_percpu_base)[cpu] = (unsigned long)page_addr;
>         }

Not sure what is the point of all this.  Try:

- target = object; memcpy(target, source, size);
+ target = memcpy(target, source, size);

Then it will add newlines in the argument of memcpy if needed to stay in a
reasonable number of columns.

julia

>
>
> real    0m0,565s
> user    0m0,533s
> sys     0m0,032s
>
>
>
> Would you like to reconsider implementation details accordingly?
>
> Regards,
> Markus
>
--8323329-937884858-1761827509=:11598--

