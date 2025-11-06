Return-Path: <linux-kernel+bounces-888570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2A9C3B2E5
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 680734FCCC0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5281232E6B6;
	Thu,  6 Nov 2025 13:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bgV11jk8"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F662E7F1E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762435051; cv=none; b=Tl2FSbyjERLMXsY3BsxIgViWpWzlBqAw5sFQwkQKFSNPBfArbqM4b0nZtHgyVYiujTjTB67wiz5zkpV3VcLAHtyg46reh96jOKJWGFYmKO/w2j2ss2wOnhaeUSPLjSKMMV/spYa4Gc2GSH6rkcnVE+0hYxI9hSNTwxKIBYglPI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762435051; c=relaxed/simple;
	bh=8xyayUNeX27WinogYM/STcDgXHhgPSZqFVuRAY979CU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SPqCAm/u66SXANK2Z8zHJ3+x57FiFPYu0HObFc9YRGJc8q0vqW2dhL/xYFnTN0DTFvfb7uqn4VeNvtQC/GyiS+07x6kWeH/fM9ksaIEnJuESIiJxk9d0tvRhs0IsxLR11+T2faUWYGfXkcQrVZvWnSi+jLnzoiT+aiyI6vtltxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bgV11jk8; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4e8a25d96ecso6699601cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762435049; x=1763039849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yKqqA00jwTc/irIUDNF5NewMs+/9jewFrwR1l5Pykk=;
        b=bgV11jk8QoNsIbL82roahyKlhtYwGQ3Qcrzog2usjpeA6WcdA6jXVATLPLyqHdWXng
         MYymRswIReG/mABBRLgtxA9mJUzY3au35c3b5N8gc/a+/JvXHK6Or0L8Cdlo8TB2+HRI
         2GzOQP4qirU80Vwvo9hVkdkL2YcRsqanDkikuv9z7XRBCsurV54xzIDmcfSbT3FMW2F4
         i3qP/WHPFQNrEmESWGMos6UVDEEpOkZLyp++MeHWM1EIRg+YhO2ZJd0kbWLRLJXt7wkU
         GXbFUymwBz1bFNySGLzXI64qktUf+r6fNr6dbRHSJXZWuYWNWeY6IkpEvt/Rw2nN1l5j
         VTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762435049; x=1763039849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9yKqqA00jwTc/irIUDNF5NewMs+/9jewFrwR1l5Pykk=;
        b=wmeWHcAIXcqOGTVqzV27u0yY1iDn5pvMrUECqOZ40hPl1/uTVHqvdwl8CD+ct3roI/
         WhzS4rWuzGIIKDw3Gdi2TKsOQQBScjwHGWL1na3F3qIfTqb5wCE62km+D8xqHeDiB7wa
         FJhndjhvzGn2Gf0YWpPGjtBh3XVEWq1OShnacCtOFr0npRqGj8XsLmeB/lIt6rgQexNQ
         j1GflY2ksXuVGf30hFoIMBIJJZ8HlcwJRWmzmkYDACGYspx83/5SJ7ThbknmJtthasEt
         cKutrP97Y3cGDK0KtEzXHc6wJbWKBEKKGFbSBncahmc2q1lCwcZ952ptZM9vx4001nul
         LMCA==
X-Forwarded-Encrypted: i=1; AJvYcCXX2V1w5n5ckiL/lWjD586W5WIKCvdwPAIZtxfOm+Xtko96MYlOMYWoB6pD9UaKMs81hUfo3e1TewBGZoU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0BTiBrFQDeqbIQ9G3hs38O32TSpLIyyEisjl57nslMCLzM2mH
	hVb1enp7qiZFFcS881KogxlE+A0Rieb/buINunW2+sAIVF75ivtOtoa8yC6MdYNLEjKfBFfIHsj
	oqTYz0GkDJwoy/agLS7eaCkGQccwGmQlZ4n0w1oj8gNI7jp2rGnyHaYxNqs8=
X-Gm-Gg: ASbGncvF+AobrUZrP+5p8FK/ifQgQJYsQL6p5RiL8YSf9n4pTJgsvceeGFbxgh4lIw5
	tZA5LG0Q/5uNV5YGqF303Fo4WU1x/NX0zEXgdhWJzCxcTutsHQZJfMTZ7HfaWe2wLCutBqQ7Ky9
	84QoME+LC8SHkrSd1N0rkltsFRZtSsOx+vDjYA3XrkqfJo11zibOA0NJz68bXvQx5E8Ve89OqE4
	y3FpC4NjngtqJgtbY0rLYru7JbVN07oPHvgTa5Axs8l5y7ynDpH6Yh3pz+44PxARR9sZNIpjHVO
	TTY9BA==
X-Google-Smtp-Source: AGHT+IHoVZY32WaUUPLhhY4TIgToxdwsHfeGByBPVatw4n/WThQoOgUxSF+0rV1ygA7KDRf83XJehc/SzmchYE2halI=
X-Received: by 2002:a05:622a:4a09:b0:4ed:5ed:2527 with SMTP id
 d75a77b69052e-4ed72330515mr88050901cf.3.1762435048365; Thu, 06 Nov 2025
 05:17:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029131235.GA3903@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20251031162611.2a981fdf@kernel.org> <82bcd959-571e-42ce-b341-cbfa19f9f86d@linux.microsoft.com>
 <20251105161754.4b9a1363@kernel.org> <bb692420-25f9-4d6e-a68b-dd83c8f4be10@linux.microsoft.com>
In-Reply-To: <bb692420-25f9-4d6e-a68b-dd83c8f4be10@linux.microsoft.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Nov 2025 05:17:17 -0800
X-Gm-Features: AWmQ_bkBBaZsd-rIT26BTjS7cW1vwvaDIkKAjz7m89rgLrJMPIY3CSG-aBEvnJU
Message-ID: <CANn89iJ8QKbwFfLUExJvB1SJCu7rVCw_drD3f=rOU84FNvaPZg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: mana: Handle SKB if TX SGEs exceed
 hardware limit
To: Aditya Garg <gargaditya@linux.microsoft.com>
Cc: Jakub Kicinski <kuba@kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, 
	wei.liu@kernel.org, decui@microsoft.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, pabeni@redhat.com, longli@microsoft.com, 
	kotaranov@microsoft.com, horms@kernel.org, shradhagupta@linux.microsoft.com, 
	ssengar@linux.microsoft.com, ernis@linux.microsoft.com, 
	dipayanroy@linux.microsoft.com, shirazsaleem@microsoft.com, 
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	gargaditya@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 5:01=E2=80=AFAM Aditya Garg
<gargaditya@linux.microsoft.com> wrote:
>
> On 06-11-2025 05:47, Jakub Kicinski wrote:
> > On Wed, 5 Nov 2025 22:10:23 +0530 Aditya Garg wrote:
> >>>>            if (err) {
> >>>>                    (void)skb_dequeue_tail(&txq->pending_skbs);
> >>>> +          mana_unmap_skb(skb, apc);
> >>>>                    netdev_warn(ndev, "Failed to post TX OOB: %d\n", =
err);
> >>>
> >>> You have a print right here and in the callee. This condition must
> >>> (almost) never happen in practice. It's likely fine to just drop
> >>> the packet.
> >>
> >> The logs placed in callee doesn't covers all the failure scenarios,
> >> hence I feel to have this log here with proper status. Maybe I can
> >> remove the log in the callee?
> >
> > I think my point was that since there are logs (per packet!) when the
> > condition is hit -- if it did in fact hit with any noticeable frequency
> > your users would have complained. So handling the condition gracefully
> > and returning BUSY is likely just unnecessary complexity in practice.
> >
>
> In this, we are returning tx_busy when the error reason is -ENOSPC, for
> all other errors, skb is dropped.
> Is it okay requeue only for -ENOSPC cases or should we drop the skb?

I would avoid NETDEV_TX_BUSY like the plague.
Most drivers get it wrong (including mana)
Documentation/networking/driver.rst

Please drop the packet.

>
> > The logs themselves I don't care all that much about. Sure, having two
> > lines for one error is a bit unclean.
> >
> >>> Either way -- this should be a separate patch.
> >>>
> >> Are you suggesting a separate patch altogether or two patch in the sam=
e
> >> series?
> >
> > The changes feel related enough to make them a series, but either way
> > is fine.
>
> Regards,
> Aditya
>

