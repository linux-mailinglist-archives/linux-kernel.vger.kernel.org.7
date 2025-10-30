Return-Path: <linux-kernel+bounces-878015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B60C1F93B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4527B463CD0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077F334D936;
	Thu, 30 Oct 2025 10:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="oFGYhfCn"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B5334A3AB;
	Thu, 30 Oct 2025 10:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820326; cv=none; b=ArP4Oxx7JKNxRYQVj7iQBtuf6hLg6y6SKBp2bEbO5Tar5YcMAdMcVJZAxbP85lmGkixCh/GK295UxfFSnJg85ady7sNVKz024kFlI1sznLJPmGKF5300CR8TBx3Ll684Waf6YqGpr7ec3JBRfAS0UkLjHED1DEfWmWsr7zXii9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820326; c=relaxed/simple;
	bh=4TN3C7+FypWsuAQyY9vV9G46wSx98UAoidia/xMt7R8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RFDFhzcGFT+4NqVPrXHd1GC+N2BiaBPK97MwHxh5Saoqt7IJF4tjQoDjwSilwZO4tBK1X8xRn9+qUuWKO8hrFNf4kWQb8jr315UF4AGJU33+JBSylld0vqlBVx1Tuk8t6LgRXlIt/U1CkIu6QLHXxcUJOO/ocWFMQJGrH6fHtpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=oFGYhfCn; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=ZBM496W0H808A/sxrZpKWnijC/g2m+6y7yc2jQ+jtWM=;
  b=oFGYhfCntwSlqhl+lS4g0Y71grRFgna6mpTl3MOxvySgGzSonPIDQ5ty
   zyT9h+vbyWrCekWkAb05Mhaud+OtB6Fi7FR8UWul2PetI0BxEE3DTNWmZ
   yO2i4XK79wuhUyYrq2hKG4JRAK8z0wq25/WApCwyxuW1HAfrIgOpHpVJ0
   8=;
X-CSE-ConnectionGUID: ueWAXUFRRIO2UcyBAq2KIg==
X-CSE-MsgGUID: bOojJxBISzOfg1InzIRX9Q==
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.19,266,1754949600"; 
   d="scan'208";a="129484394"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 11:32:02 +0100
Date: Thu, 30 Oct 2025 11:32:01 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>, 
    kernel-janitors@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>
Subject: Re: [cocci] [RFC] Increasing usage of direct pointer assignments
 from memcpy() calls with SmPL?
In-Reply-To: <d227e982-d69d-45b7-9388-9082f86af69c@web.de>
Message-ID: <6faae122-fddb-34cb-68fc-5f4b62d7e16@inria.fr>
References: <ddc8654a-9505-451f-87ad-075bfa646381@web.de> <e54a6e57-6bde-f489-f06f-fed9537688df@inria.fr> <62441255-45fc-4edb-a8e5-c208b36ca2c2@web.de> <53e91f9f-bfe5-5c57-157c-fc456bd430ca@inria.fr> <d227e982-d69d-45b7-9388-9082f86af69c@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1271298350-1761820302=:11598"
Content-ID: <b3dd7bd5-3cfe-16ab-a8f8-cea6d32713b@inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1271298350-1761820302=:11598
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <fed1875-fe5-1bbc-81f1-eb68a9c7e35c@inria.fr>



On Thu, 30 Oct 2025, Markus Elfring wrote:

> …> I think you would get a more satisfactory result by just removing all of
> > the code and adding it back. Then Coccinelle would take charge of laying
> > out the whole thing.
> …
>
> See also once more:
>
> >> Another SmPL script example might become helpful.
> >>
> >> @replacement2@
> >> expression object, size, source, target;
> >> @@
> >>  target =
> >> -         object; memcpy(target, source, size)
> >> +         memcpy(object, source, size)
> >>  ;

I said to remove everything.  target = also.

julia

> >>
> >>
> >> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time /usr/bin/spatch --max-width 100 --no-loops …/Projekte/Coccinelle/janitor/use_memcpy_assignment2.cocci arch/arm64/kvm/arm.c
> …>> real    0m0,626s
> >> user    0m0,588s
> >> sys     0m0,037s
>
>
> Regards,
> Markus
>
--8323329-1271298350-1761820302=:11598--

