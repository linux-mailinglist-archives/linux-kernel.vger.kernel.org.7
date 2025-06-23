Return-Path: <linux-kernel+bounces-697668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CCCAE3715
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 09:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9BE0171A66
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 07:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825D11F8BBD;
	Mon, 23 Jun 2025 07:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VgwVTpFX"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982EA1F4295
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 07:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750664176; cv=none; b=rnai05/F3BK5LTCnCxeEHsP3T62L/FdLPQ9nT2jcNVCPQfSwAC7eK0A2eZB0EsZ900i5R7qJBQHI2z5oJ7KMBPL7esmVjkViRcRsudn2UHR2jNLEG2+Lh9adg33OIlhSqvBUX5VFu1TCc/NDB4y2jxU0Ll5WXfRhwwHbql0Uajc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750664176; c=relaxed/simple;
	bh=w+3qbmZ+/Fzih2MTelSdaDcNnHFx2K5wHnL/eTsCyys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GgGS2oz1tq3GGQVaMOR+h6jSkFoQYpmRp0PVJSHyQTCSkZxfE+EI1C4uSv+1dl1P5czKEchDCC0OmcqgYn0tgP85Dstuhb5+RLWr1c1Js/qpp7KZHwWrZKiWcEGfrpvKHQUNn3GCPAcGgm/64mwsVioEFRE2/d/LfeBuBh/bs6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VgwVTpFX; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a4e57d018cso587962f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 00:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750664173; x=1751268973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+3qbmZ+/Fzih2MTelSdaDcNnHFx2K5wHnL/eTsCyys=;
        b=VgwVTpFXYnXMmKkwwR1C+MvWG4pgWpxpA+TvvHS+kNX467zWiGKrYvfK+uPzPML6iq
         s8GaaSXCVWL5lh9F9ZrBW1iT9mjBH3SI6G1rwJ6So1ynwM6fplh6qrsdXr0xHSLWOVXt
         3Y3ah9TzdxsO9VaMexNtfS+/sKG4sCiCBUNyNIt84GHbs16zsbWAjPBvVPqOYeSuE+RU
         oZNH3KtuaYIodq8727OV3SuvfenfUCaOfU13/UAO2OKoUK/ffnxHIAFvnI7JMQZb2OmK
         obtnvtKu1THrGhrByu8iMgkkSR+RG3qi92D34exCFbQNICm92gC4mgpF6csVKx6M7VGo
         gWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750664173; x=1751268973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+3qbmZ+/Fzih2MTelSdaDcNnHFx2K5wHnL/eTsCyys=;
        b=ooz2bIDj8i4FPdPo1PD5HiJmU2aHk3PS5onArU059IPzcxz3B6K5oIraefPt7s9quz
         S4YSZLplCgZcsS+OuBCJSI7+vLYy/HFCVtmPPATdQ4uMgvkR1lBLPze/fg+4TVddq7CR
         fnRjuMhV19MiS9M9x46Fq40jH3bc09nEFwJ0l2uZnZKvtoWNO33LHGWcenIjFBu6Rw3h
         VgaF8dyEk3xgdC1L0ln5x4lYDTClH/PK+s9oujAYGputw0BlCv6L5LfJ1SledcWLsTVq
         NReYb/FFhaSUnxxlXRALZv0GSXiSVemcPmOjbjdGddf7bXOCLiA52sw8kKk2+P62NFBx
         2wAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjdBNbVe+jF1uQZTe4ihkj6Wt3lt954KPzELVB3fma7Jieh6lWNZS7pvZ7fifSakcJ6fnaaST+3JWaFLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfcZmRKas+VZIpIOnD8HxCIzi/X71vfQfWSOM+vDPaksoD3nkI
	7huaQqIYgwXOz8zYONIGD/KMI0a98iJ2AV4SJruHDgEqN4t8kb1bzpiDc3AWM5W5Q2A=
X-Gm-Gg: ASbGnctLqAU9cIoAzPYoCsuWDnE5qXVdeyjv3LGc95RSqWkVtFgeSpgzbaKQh0xB5w3
	uTBsknKGl8IzWkVC5FxbP3vmbYPTgFdXbJhDPXHBhPASiTniMtPch/C4H1GwYj6URW5Ov+8gJIl
	VBuHZS7xpuVMz6JMZoB5H2w7+68uC8im+CD1lmrxjqULvhtAOPw2hZ9ta8IkPLNZkFn2zJiWWpt
	Wugu3n+fGInwQUWvhYfq2Jmh6Ed+HCFVbDWWyg7WJ+XzOZNYWyJluNN7Cw6BhdtSA4tq7eo52tG
	tuXg6cxdMQs52i1kxg40oIDfi75p7LmVCsBiNn71ALV99Bcra/4Sm+EN2ULsZ+PiBs4oQm28nhM
	OEV0ihm1FBxO82oymwYh6JpLcPRjsKFQAifxB6cL63RwQR9p0o35gYC+xqAnbrvMxi+4=
X-Google-Smtp-Source: AGHT+IF8cAJKU0uDUbsIxPPaSCr7igCmeTXnBbWub3AL1j9L+jNBLIxdzW27wopPloNnbvH5RjVzEw==
X-Received: by 2002:a05:600c:4747:b0:441:b397:e324 with SMTP id 5b1f17b1804b1-453659ca904mr40838535e9.9.1750664172885;
        Mon, 23 Jun 2025 00:36:12 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535eac8e19sm134858005e9.21.2025.06.23.00.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 00:36:12 -0700 (PDT)
Date: Mon, 23 Jun 2025 09:36:04 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Neal Cardwell <ncardwell@google.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, "open list:NETWORKING [TCP]"
 <netdev@vger.kernel.org>, David Ahern <dsahern@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2 0/2] tcp_metrics: fix hanlding of route options
Message-ID: <20250623093604.01b74726@mordecai.tesarici.cz>
In-Reply-To: <CANn89iLrJiqu1SdjKfkOPcSktvmAUWR2rJWkiPdvzQn+MMAOPg@mail.gmail.com>
References: <20250620125644.1045603-1-ptesarik@suse.com>
	<CANn89iLrJiqu1SdjKfkOPcSktvmAUWR2rJWkiPdvzQn+MMAOPg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Jun 2025 06:24:23 -0700
Eric Dumazet <edumazet@google.com> wrote:

> On Fri, Jun 20, 2025 at 5:57=E2=80=AFAM Petr Tesarik <ptesarik@suse.com> =
wrote:
> >
> > I ran into a couple of issues while trying to tweak TCP congestion
> > avoidance to analyze a potential performance regression. It turns out
> > that overriding the parameters with ip-route(8) does not work as
> > expected and appears to be buggy. =20
>=20
> Hi Petr
>=20
> Could you add packetdrill tests as well ?

Glad to do that. But it will be my first time. ;-) Is there a tutorial?
I looked under Documentation/ and didn't see anything.

> Given this could accidentally break user setups, maybe net-next would be =
safer.

Yeah, you're right. Technically, it is a bugfix, but if it's been
broken for more than a decade without anyone complaining, it can't be
super-urgent.

> Some of us disable tcp_metrics, because metrics used one minute (or
> few seconds) in the past are not very helpful, and source of
> confusion.
>=20
> (/proc/sys/net/ipv4/tcp_no_metrics_save set to 1)

Yes, I know about that one. FWIW it didn't help at all in my case,
because then the value from the routing table was ALWAYS ignored...

Petr T

