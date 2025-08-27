Return-Path: <linux-kernel+bounces-787845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB71B37C23
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2815D1897E3B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 07:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7904C32145B;
	Wed, 27 Aug 2025 07:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XyVtX2Zd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4272C3261
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 07:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756280748; cv=none; b=RLSvKwG5LQ4IIACiMjtWOeQjsqc8jXzR2LrR1PT1pATlgjA1UgcK6Dyt2ZS8oBDh/+eHHZOFTl/CPsEh5D/BQsR/FwCy6EQG/xDoDfL+08xJGn32bXnL4DeVjImQ5NKO7bsSJ8iURJ/xhgHpqS+Y5mqYoUVlkFcCF6+gAi18nsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756280748; c=relaxed/simple;
	bh=m1P0jEmqMZWxkTnadh0YZTaGGpaW9MgNFj/scBIbOjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=usy82vVoZ4HV2rRy1eoRZUAgyUYels4ZsZyo9RjrDh3smw5mpANteZLcgdQjjztObvPmRNgQaz7eKXpGDxc8IyNtGD9bP57OLfgXSufWR4EuGjW/R18UYGBeiMVSf0Ijf18Gbc0jV6kExB+ns0N+yAfN98kFSCsyQgUtHb6+rGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XyVtX2Zd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756280745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y53iOSeYHWg2rhEwEqFZy9Ri7ZxF7SP7WMmqtTCcABE=;
	b=XyVtX2ZdWlj2puCoyqbLUr42679LzM5AA0j/V79aloCa2zObTPqLW9tL3ZgImIBdUYg7xw
	glctUypQ8cfmXiaYN/9buT2QLwprq+/k0UfYmCMx1Stdae/3fT+EtBt2/CMQjP5AV5d/9E
	SOCxHBwBEBIj5I4gL2IyJTxs7Bdzpj8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-KMiKvuEFOCOQaCYAIFhorw-1; Wed, 27 Aug 2025 03:45:44 -0400
X-MC-Unique: KMiKvuEFOCOQaCYAIFhorw-1
X-Mimecast-MFC-AGG-ID: KMiKvuEFOCOQaCYAIFhorw_1756280743
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-324e41e946eso11799079a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 00:45:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756280743; x=1756885543;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y53iOSeYHWg2rhEwEqFZy9Ri7ZxF7SP7WMmqtTCcABE=;
        b=jZXyX/IKEjXYE9Bs0mNP6XErLEtyJNOpkQsWr/Xv7tfWk8zDGyH2/AULzGkOxq6ooV
         5xXXKmXkroTv3HO4ezLP2h0oDBOoyfpPuHYoBFSTmO3L7bpp+Ta/6eakJdPzQc6glpwJ
         3QSjqav2MPX+HAtdW6oIgeK4gTrLLFP9NvrMWgflgPMUfG5YvEC6WQgwgY19vI801QC0
         1/oZVtxk5SIXvYdqqU9qlPqkHyYplNwR+if0tAfFDG7iC86C4TTvcjrb9R8sfRHBM4oQ
         UGPkEaorfO0zSfLQ6YRD+/WU86t+9gT0bWmz4cXCPxCpslApGUpvzO9ycC5R7aA6dhp1
         byyA==
X-Forwarded-Encrypted: i=1; AJvYcCWC1RZq3k1vWK/YymHRHa/D2YHqy6Q/5/OM0Yo5szqJ0UOO5EjlVi9Z7yJ1M0kEX8PVFmZZDR4ESPSl/+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3yfKjD/OeofPTaZZakismXK5ijuYvW/IEnilR/hDhcnuCINfD
	eSaOrmanokaXWTSHo585iJPHCH1Del1VvM7fIH/GuwIqDc2XgR4Djhhdf5aIwm3kCp79PAs+Maw
	QWYJCBW5ELOdpplalchMh9DZdpKKSVHVCtlUgbrulR/hAbQwrhGkCqhJiRghSObTiwk9BuFLLlc
	/geDiEqoBAh79kmUKmNhgwqUduS9PVEVZj49WbQrny
X-Gm-Gg: ASbGnctGj5PdWXxt6aTwkcVIvDpZWlEHq4Fiw4GSZ6x89WiCGwXMCj8xxNb6BdJ/rMk
	uB2PLJwY3lsr21Fvg9xrKeBN/iKEK22XDbJiuaqPmb1GT3AX83xDGZcn8bF+ynaFFlUM9dC1AvN
	EUU+pCusO0tHUjV6HL5lt8
X-Received: by 2002:a17:90b:3b43:b0:325:c492:1541 with SMTP id 98e67ed59e1d1-325c492175cmr10781699a91.28.1756280742877;
        Wed, 27 Aug 2025 00:45:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFL3QfOtkpTlqmDLyFPBToqiAGSTr07AvdWHQ5KB4MsCwD8hJyLgmML29/RVKHu2TWMxv7zu22lFBW97rccbXQ=
X-Received: by 2002:a17:90b:3b43:b0:325:c492:1541 with SMTP id
 98e67ed59e1d1-325c492175cmr10781671a91.28.1756280742428; Wed, 27 Aug 2025
 00:45:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812040115.502956-1-liaoyuanhong@vivo.com>
 <aJt91SSkBO486bg5@MacBook-Air.local> <a161ad99-8941-4213-95e3-86c5ef948215@vivo.com>
In-Reply-To: <a161ad99-8941-4213-95e3-86c5ef948215@vivo.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 27 Aug 2025 09:45:30 +0200
X-Gm-Features: Ac12FXyh6ecdn9TGNfNWZ5a4yYKMaOQgjIgTEY1tLxy6zfw-_ib0DMy_7VZaP-E
Message-ID: <CAGxU2F4f+Ks6hUNuqvfAJ_kLzjf4sy5CfLkzPJ=Whn7n67-Szw@mail.gmail.com>
Subject: Re: [PATCH] vsock/test: Remove redundant semicolons
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Joe Damato <joe@dama.to>, Paolo Abeni <pabeni@redhat.com>, 
	Konstantin Shkolnyy <kshk@linux.ibm.com>, 
	"open list:VM SOCKETS (AF_VSOCK)" <virtualization@lists.linux.dev>, 
	"open list:VM SOCKETS (AF_VSOCK)" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Aug 2025 at 08:57, Liao Yuanhong <liaoyuanhong@vivo.com> wrote:
>
> On 8/13/2025 1:45 AM, Joe Damato wrote:
>
> > [You don't often get email from joe@dama.to. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > On Tue, Aug 12, 2025 at 12:01:15PM +0800, Liao Yuanhong wrote:
> >> Remove unnecessary semicolons.
> >>
> >> Fixes: 86814d8ffd55f ("vsock/test: verify socket options after setting them")
> >> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> >> ---
> >>   tools/testing/vsock/util.c | 1 -
> >>   1 file changed, 1 deletion(-)
> >>
> >> diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
> >> index 7b861a8e997a..d843643ced6b 100644
> >> --- a/tools/testing/vsock/util.c
> >> +++ b/tools/testing/vsock/util.c
> >> @@ -756,7 +756,6 @@ void setsockopt_ull_check(int fd, int level, int optname,
> >>   fail:
> >>        fprintf(stderr, "%s  val %llu\n", errmsg, val);
> >>        exit(EXIT_FAILURE);
> >> -;
> >>   }
> > This isn't a fixes since it doesn't fix a bug; it's cleanup so I'd probably
> > target net-next and drop the fixes tag.
>
> Do you need me to resend the v2 version without the fixes tag?

Yes, please.

Also target net-next:
https://docs.kernel.org/process/maintainer-netdev.html#indicating-target-tree

Thanks,
Stefano

>
>
> Thanks,
>
> Liao
>


