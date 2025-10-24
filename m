Return-Path: <linux-kernel+bounces-868924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFD0C06820
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1432B401A76
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D2F31D366;
	Fri, 24 Oct 2025 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAqER0eQ"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F8F2DE6FC
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312488; cv=none; b=F/TiPonNahmKQQvlG4byRVl1w7W/b2NXoaDvCWYg3MNz0l8IE/SV6sUSNg/02VpU9SfQ+BxJ/0nfHscve1Z83eIwD8G9pykVXicL2zE/14AlByncoSxUD5AC00QcS/D97R1spOAXiw5/qg0C7uZ34xP1CGLTYdXqn0m4ZtzCok0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312488; c=relaxed/simple;
	bh=ceFA0S2W42fXX2lT+NelVq5KuhyNa5f8RI5F9G5tVFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTzlugRwTWyHIibCG4GtUvn6IM2DRgRBMZS15sf2fyFo0l2zkf96cNOPH98F4nYKJfTx7wIsZjiMPBFAC9K3il82l04YXIdJgfrs/dFibcKecBeBtwjhd1u8nXN1VRDqWKxH3KSrGXCR7sLG+dUSf84mlIAIrZjdivAy83tLbIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAqER0eQ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7833765433cso2673489b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761312487; x=1761917287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6L1uxdzkk8srkrwCsNr6wv7lTER2UD4Th5fojH+wrQ=;
        b=BAqER0eQQWFVaHOUZzsW8DDUuh9UqSwzUcuvtgH1peALRb65Pnjdg+HHJ3iIFsYjKf
         mvNU8BCGI14IIzx3XYn9PUJGdDfn61V1agd/Y7fm1tCaoAP17vMco7HK0o+TiA0m9pyX
         KzIDF+fXx/WBDNy2eOM50unEGWdup2jSurq3MVNhr1D2zTj74pxyAN3q4ptGUDRgipCV
         bX0kR7LNq6UUEYOzGJQiT0CL9j4texAWdgXK/PZwsK6TzYcmrE83VZtqbQWxXvsGDIzs
         5wNueDNTNIdv1FH6yAFvGpT+MVSvjwfhoFAsiQTZbOlBV18G1Lky68sXFNpVUhWsUlQ1
         PsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761312487; x=1761917287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6L1uxdzkk8srkrwCsNr6wv7lTER2UD4Th5fojH+wrQ=;
        b=okoN9Gu/EaG/oLlZndVoDd1M3ICvK7Z0U2jsQ2dM+rCqfBxukDZEUkQT/AAHNLWTN3
         mkXe+HzruIbxuujWeWhPJqefJxy8JTZU4TamVfqATwYO5Zlw+Pnueb0FHyXuKLlr5zSI
         l+mGT/HmTGb5eJON2D/NVDjb3Sm5IoJXAXvjZ26cNtJ0O6300m5yvaXWOeaDtdbT8T7V
         sH3EUPUAl6h6SvgkZdU0st7lhwHZEcSDL09Uo+/qSrwonqtU0fleRRvAjz5Mjj9YFpAd
         T9vkia5YlqttgPHHn7pErWT+30TlFvkiuwfZoDrqgK48d0xSp8XmXq+QPy4y/uwZNBbw
         r2Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXczypM8enKIUmXcyIVKAxjnkSK7haCt2kAHrvLZmFbeI/osKJmdvJLOlHBkWhemSfneZ0BCjOyfwjJnbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YykBk/7CpPrY9i+SIIlJa+pS+co1iZFm+qZz/Rx2ZajIjmRKRIC
	M8e0Pi21vmkTT71XKYmuVuOIOGFAsUpX86iHLDjcVWNz8sB1fvaJGylDDekQHvBhffbSsjTYllh
	e7NoEkDkOo88fD5FQzfxeHXBpTcdgl+M=
X-Gm-Gg: ASbGncse/LeqWBW/T5EuqYcQUYM58cWS6FXqYNEIDX4A3wFGm4aYfOwrr6XAG1pd9aA
	yC97OKakQnhjdg3t6sQvr6zymNo6U7D3u55sTDyJTbE4mer1+BVJOTEHCVyGlrZexh4K/+So4T5
	IMPoIFniDaAZtFqbupXmfI3tKody3pGeEHopNP3uvx5JUENvMSj1xrwJylboBF4xQA0TK36Jd06
	J0bocfboOnhpNVu9HfHGepdacA4dMq1dPaemb2ZO67X0FWaHvNt5gDXLzXF9H7IK1PNmzULdg==
X-Google-Smtp-Source: AGHT+IFfagfElQ7VdeIYoTX5r/N8GfzjgZaicvl/ggnv/QdNBInCxKV3LHrMSWqa99+jjqRtmBXA4QpAKlh7s02X1SA=
X-Received: by 2002:a05:6a21:4d17:b0:334:a9f2:558c with SMTP id
 adf61e73a8af0-334a9f255cemr34734939637.5.1761312486566; Fri, 24 Oct 2025
 06:28:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023191807.74006-2-stefan.wiehler@nokia.com>
 <20251023235259.4179388-1-kuniyu@google.com> <CAAVpQUBxfpYHaSxS8o8SAecT27YtrNhcVY9O=rSYFr3GshF0_Q@mail.gmail.com>
 <cf5df107-1056-48b1-aec5-f70043a9c31c@nokia.com>
In-Reply-To: <cf5df107-1056-48b1-aec5-f70043a9c31c@nokia.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 24 Oct 2025 09:27:53 -0400
X-Gm-Features: AWmQ_bmzAtPUqRUiN6VayanzPbUW_j_uagCykSjOy1z20QJwUstuknXDIPdDLR8
Message-ID: <CADvbK_ddE0oUPXijkFJbWF6tFTq5TntpFMzDWH+uV_kc+KB7VA@mail.gmail.com>
Subject: Re: [PATCH net] sctp: Hold RCU read lock while iterating over address list
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 4:51=E2=80=AFAM Stefan Wiehler <stefan.wiehler@noki=
a.com> wrote:
>
> > Or if lock_sock() is enough, we should use the plain
> > list_for_each_entry(), or list_for_each_entry_rcu() with
> > lockdep_sock_is_held() as the 4th arg.
>
> Right, I've already hinted in the commit comment that lock_sock() might b=
e
> enough, but I'm not sure about it...
>
> @Xin Long, as you're the author and have already acked, I suppose we actu=
ally
> need to hold the RCU read lock?
Yes, there's a path not holding sock lock:

  sctp_diag_dump() -> sctp_for_each_endpoint() -> sctp_ep_dump()

Kuniyuki is right about the TOCTOU issue, we do need a check there:

                if (!--addrcnt)
                        break;

BTW, there is another addrcnt thing in inet_assoc_attr_size(), I think you
can fix it in another patch, like moving nlmsg_new(inet_assoc_attr_size(ass=
oc))
under the lock_sock() in sctp_sock_dump_one() and delete _rcu?

Thanks.

