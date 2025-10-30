Return-Path: <linux-kernel+bounces-878327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2FBC204BA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DBF1463A62
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA552475CF;
	Thu, 30 Oct 2025 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="ds0HgokC"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582DA1D5CD1;
	Thu, 30 Oct 2025 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761831533; cv=none; b=iNeyKeE7ANixo+QLMVuCLDG2OgdD1xeaOA+klBP4UKt7eJLr9SaknT3yoLwb0B8eul/JkZxBDSbdpnk78Hq7wN6AILU6zNyQI1gSX0/czcGMeJ+gdTqa71KvZ6/tWFawglZ66SK/hKoLWfADS5Qq4Xc4PDtPtpn4SWvxelsbaus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761831533; c=relaxed/simple;
	bh=mGQztEN4S0/G6ld3AnwbjjruYNq/oG+QRisOk6Khj4s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=K1c9Hctd3aRdXeqx01viawqUciYqL0gF+MqkebpGyXVZWuwBjQLHSimDd+sHSHtk7hIwTCV2aqZ3cAMR8hsmvlfxIhk+HhVfBcEUBhlQSZMZjSjjQ3Xq4YZwnWaWYF2myT0OaZfNmMop2z9Vj+OYXBTpvpj+M+sRS8B9ruBs5s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=ds0HgokC; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+9GCbyx0nM5jk0KxizZbCcB0mtfNvPzaCv7oLfJtX+4=;
  b=ds0HgokCCDoDNlvWPIfPEeuATpkKsCozTlFlALg91YSlAxw6Scunw9jb
   lmE0o+UviiFrrbcti9BgNG9ckY7t/TBDwxu90W9gJxJ4iTni4bh0tOjqo
   tFn7doJjgXI3FZ43z2m2sXvrKWVoAkKInrWdEMN7GrnVIwfPNHjc25jjN
   0=;
X-CSE-ConnectionGUID: 7cxw7crpQmi9x+ULw5pwKg==
X-CSE-MsgGUID: H4kwkNjnS0K6wtUy73fXGw==
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.19,266,1754949600"; 
   d="scan'208";a="129502388"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 14:38:49 +0100
Date: Thu, 30 Oct 2025 14:38:47 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>, 
    kernel-janitors@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>
Subject: Re: [cocci] [RFC] Increasing usage of direct pointer assignments
 from memcpy() calls with SmPL?
In-Reply-To: <abda1fe0-af59-4fa9-a1ec-efda0f63b3f1@web.de>
Message-ID: <75a9224f-8c8a-da15-3ad7-f49fe3c36cf@inria.fr>
References: <ddc8654a-9505-451f-87ad-075bfa646381@web.de> <e54a6e57-6bde-f489-f06f-fed9537688df@inria.fr> <60f881dc-979d-486b-95be-6b31e85d4041@web.de> <aa99eded-be51-af3b-414-7c3bbaddea4a@inria.fr> <abda1fe0-af59-4fa9-a1ec-efda0f63b3f1@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1183597951-1761831528=:11598"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1183597951-1761831528=:11598
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 30 Oct 2025, Markus Elfring wrote:

> >> I “accidentally” tried also the following SmPL script variants out.
> >>
> >> A)
> >> @replacement3@
> >> expression object, size, source, target;
> >> @@
> >>  target =
> >> -object; memcpy(target, source, size)
> >> +object; memcpy(object, source, size)
> >>  ;
> >>
> >> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time /usr/bin/spatch --max-width 100 --no-loops …/Projekte/Coccinelle/janitor/use_memcpy_assignment3.cocci arch/arm64/kvm/arm.c
> >> …
> >> @@ -2600,8 +2600,8 @@ static int __init init_hyp_mode(void)
> >>                         goto out_err;
> >>                 }
> >>
> >> -               page_addr = page_address(page);
> >> -               memcpy(page_addr, CHOOSE_NVHE_SYM(__per_cpu_start), nvhe_percpu_size());
> >> +               page_addr =memcpy(page_address(page), CHOOSE_NVHE_SYM(__per_cpu_start),
> >> +                                 nvhe_percpu_size());page_address(page);
> >>                 kvm_nvhe_sym(kvm_arm_hyp_percpu_base)[cpu] = (unsigned long)page_addr;
> >>         }
> …>> B)
> >> @replacement4@
> >> expression object, size, source, target;
> >> @@
> >> -target = object; memcpy(target, source, size)
> >> +target = object; memcpy(object, source, size)
> >>  ;
> >>
> >> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time /usr/bin/spatch --max-width 100 --no-loops …/Projekte/Coccinelle/janitor/use_memcpy_assignment4.cocci arch/arm64/kvm/arm.c
> >> …
> >> @@ -2600,8 +2600,8 @@ static int __init init_hyp_mode(void)
> >>                         goto out_err;
> >>                 }
> >>
> >> +               memcpy(page_address(page), CHOOSE_NVHE_SYM(__per_cpu_start), nvhe_percpu_size());
> >>                 page_addr = page_address(page);
> >> -               memcpy(page_addr, CHOOSE_NVHE_SYM(__per_cpu_start), nvhe_percpu_size());
> >>                 kvm_nvhe_sym(kvm_arm_hyp_percpu_base)[cpu] = (unsigned long)page_addr;
> >>         }
> >
> > Not sure what is the point of all this.  Try:
> …
>
> Would you like to acknowledge that undesirable difference displays were generated anyhow
> for these test cases?

Sure.

>
>
> >> Would you like to reconsider implementation details accordingly?
>
> Are we looking for corresponding software improvements?

If time permits.

julia
--8323329-1183597951-1761831528=:11598--

