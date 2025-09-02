Return-Path: <linux-kernel+bounces-796152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E46B3FC98
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 956921B2531E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E5D2ECD2A;
	Tue,  2 Sep 2025 10:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C0KEy/eN"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9001A2773CD
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 10:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809268; cv=none; b=SVSKBvamwzL50iBPebRtn/623NW915yaGBd2uR6lO+JNNiMk3vBGhRa1F9TleOxg2urma00/w1iMcsz4NpYz175g2RCOG5GNFr4ZlEdLhahy6e1oQeqXoJCeIUZh+Fl3CG46a6DYmkZka0Gqi3S7mrkIpSYfplIu/Z4ZEQjIQH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809268; c=relaxed/simple;
	bh=ksKfuvry9Q8QwT2U//387S6v929FOlH9sf2/vRxqYGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=teNKg4KqmWYlNpYSDTJEMQg+tCyN9ZHgsv+NIEsb/geNP344FyLJwGtaYCI2WeShroO9DZIUkWEAqvJcEcPjcyu1Aqm7PXIQWBs2fGlzhptC+z+wMIfzTdoPaVniMT+8fC7tkgWWkIybH6MNv5A02CxJITGFHkeU4Yf8S6biMfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C0KEy/eN; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e87061a6d5so518597285a.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 03:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756809265; x=1757414065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksKfuvry9Q8QwT2U//387S6v929FOlH9sf2/vRxqYGk=;
        b=C0KEy/eNM7d8v4RrpWCK349Y90MQx+9SSYm0xj/251EISvC/C/PqwtUmJ2kbcFo1A3
         0n3tBL+5V4IM5mgkC6D6Nmdxgnu1Mfr9mupvZuCiIKx7qB1orTwevc+t66cYdifGazy8
         ttDJUEbyCjwp0brpW6L+MbJkB3UuTs7XYSYVueFD1+qhV21vLatvTuGG5RlYHtY67NDv
         K1T+N2pO9QNJjuDXL98hJ4HdG+j4txHSXTy85iIXG3Q16eOIwaDb0Ny366HO0xq+BW/n
         GdW3kPfVHFum5eP95gLY8kgT+ZAekmyV5uu5CGE1+st0u2WebFPdnD2vUQkDgC2oeRA/
         uXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756809265; x=1757414065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ksKfuvry9Q8QwT2U//387S6v929FOlH9sf2/vRxqYGk=;
        b=l+6sEyv0Ry7bsz2GP6mzRBgQ4VpYjHW0aIWSZcDm34361atn04qtJTps6qCpgB37XQ
         2dXmp/+CHvFidwfEAb3GtXKWJcDzqG1wrwjCAa7uLq6gXk52d/d93eQBr6kHjqYXe7h/
         frZvi8CofRuOnBvdMsU4a4VD35B4fUmDlKW8qo9wYJ67MyMrxKEePh8+KHQ9yxULoOpc
         TJsabbdj6hu8bN/5XPFJA0nwfgQ5FmrHhfmAyAfUqqR4wMk0ARZ+1aUpyP7r5vRm/mYF
         fkwOONWvR3j7bOVZ0qCxTBQmwSzc+x3PgAE3VM/lwCSzswKsrOHnUpA25Cc4xnlFnyJC
         1I+A==
X-Forwarded-Encrypted: i=1; AJvYcCUrpv8UJ7ir3lgJJnQUm1AXkBptOJ4L5u2WK2i9tCc6O/NCmY7VVOzyOj+FPdoeeSSmzBe0FpP1aKI5SjM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5T7WyZyMupKQrdsuenOrUKxbtP9qg7P8aq3a6ayF4pD5aIooA
	5Xjc4hhwS/4e6qushdIcLAQ/6zAeQtlF2tzSyECnFtbesc5L8loVzwHWR89WA/1szZcCzUhqNCt
	4vALwlEHA0pN4PgDktpULOXDOlzXxcr2L3KXVgBbg
X-Gm-Gg: ASbGncsF2rpRrz0ng7DDjb0zX8hUlmmt/3sY8axiB4tos/UrZqgyXDLfMfbGlP3Tf5e
	s0RAR9fXFJIi6HetIM807oAVV7a8v2nXEIRZNqFr9hfsDxIAV18uNVpFCHokS9AmLFQMdFNXP7U
	BylX24fzH6SP58iI95kJXu+eKGbOH2F9DTdjkue1CiX7T2IB75ngpurXQ2uWziv2aBcRB2dYkgg
	R6YHLCt4ummTw==
X-Google-Smtp-Source: AGHT+IF0huP++mAEHLfphnSoFP0AEq1V5WxRxmoNX667z3TJEO6664A+/TyLy4omMr/TIFDGJ3I7B0/hi7xlvtH41c0=
X-Received: by 2002:a05:620a:1913:b0:806:9c53:d6ce with SMTP id
 af79cd13be357-8069c53e30amr231115885a.23.1756809264929; Tue, 02 Sep 2025
 03:34:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829030456.489405-1-lange_tang@163.com> <20250901132330.589f4ac5@kernel.org>
 <2e29147c.8583.19909a12fa2.Coremail.lange_tang@163.com>
In-Reply-To: <2e29147c.8583.19909a12fa2.Coremail.lange_tang@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Sep 2025 03:34:14 -0700
X-Gm-Features: Ac12FXyz-evLL-Tx30iKAQXL9Kn7W8NW5G--uOtEcIX2qCuyKL5n--v1MtTIsLI
Message-ID: <CANn89i+S0hD9FPNYatQz-Mn1PJ5WKfgpJ2T=LOgiA2+kA2K6vw@mail.gmail.com>
Subject: Re: Re: [PATCH] net: remove local_bh_enable during busy poll
To: Lange Tang <lange_tang@163.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tang Longjun <tanglongjun@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 1:53=E2=80=AFAM Lange Tang <lange_tang@163.com> wrot=
e:
>
> Thanks for your reply!
>
> I've done some testing, pps=3D350000=EF=BC=8Cnet.core.busy_read=3D50.

We can not let __napi_busy_loop() run for thousands of usec while blocking =
BH,
if net.core.busy_read=3D5000

To me, your patch is a no go.

Something is wrong in virtqueue_napi_complete() I think.


>
> Before apply this patch: unhandled =E2=89=88 6400/s
> After apply this patch: unhandled < 10/s
>
> As you said, the driver needs to discern spurious interrupts in above des=
cribing situation, which I strongly agree with. and I also think that it's =
necessary to remove local_bh_enable during busy polling, as it causes inter=
rupts to be enabled during the busy poll.
>
> I think fix this issue requires two patches, in addition to this patch, a=
nother patch is needed from the driver side to discern spurious interrupts.
>
>
>
>
>
>
> At 2025-09-02 04:23:30, "Jakub Kicinski" <kuba@kernel.org> wrote:
> >On Fri, 29 Aug 2025 11:04:56 +0800 Longjun Tang wrote:
> >> When CONFIG_NET_RX_BUSY_POLL=3D=3DY and net.core.busy_read > 0,
> >> the __napi_busy_loop function calls napi_poll to perform busy polling,
> >> such as in the case of virtio_net's virnet_poll. If interrupts are ena=
bled
> >> during the busy polling process, it is possible that data has already =
been
> >> received and that last_used_idx is updated before the interrupt is han=
dled.
> >> This can lead to the vring_interrupt returning IRQ_NONE in response to=
 the
> >> interrupt because used_idx =3D=3D last_used_idx, which is considered a=
 spurious
> >> interrupt.Once certain conditions are met, this interrupt can be disab=
led.
> >
> >I'm not sure this patch completely fixes the issue you're describing.
> >It just makes it less likely to happen. Really, it feels like the onus
> >for fixing this is on the driver that can't discern its own IRQ sources.
> >--
> >pw-bot: cr

