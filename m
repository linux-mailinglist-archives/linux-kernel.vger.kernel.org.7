Return-Path: <linux-kernel+bounces-893136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBE4C469BE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9E053B89A4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEB830E82E;
	Mon, 10 Nov 2025 12:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3OhgrvC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="O57r6J++"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89CA309F00
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762777855; cv=none; b=TuBzjDqgfZhov6aUjGzAiDDxuaEIoPl55TgicAhhVnEJ2lIUzPfBLiIcl8g5zPkoeU/2WDpi0F1ppnRel9YPSCYpc72dHyaSu+44wA2WsceJBEApBa/XkdG7wb1ePGzJyjiT3gKH/h2pS7ZxLvpKw3d7o+DPm/A8ZbChB/rTa3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762777855; c=relaxed/simple;
	bh=W8R70bvJHJO7FmVx6tTMUO4eH6oa0bt18eDgp+HCOB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=myPNES1nB7uwk2dQs53SiQVx69NNIVGjA9gqmXEwgxNJbyU9MfEm0MKz3PDNTCq+VVOMINSUEGTP7WOEP2EbUMpiPYNMc/iMqeD9wADJDIQ6tzPrXq4pLNo25ZzCT1AlrEEHYs+Tyn4wD3BSU4XNYuM8fy/o7n7ryjxg0QH67SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X3OhgrvC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=O57r6J++; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762777852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZzwD8CAgHHIN7QER1FgOYrseElyIf9KwDMPjRpoiRw=;
	b=X3OhgrvCwka9WRXqvRSr4kEqBPZIjKVIFu9C4O5g/IPB35YnGtmdLzYSmmvureXEoxz+O1
	gfdjcm+m4QaANq/tUWK3to//PlZ1IRazTSTSwBY2aEc9Vv8qQZOyzJRXZm5Kx0siTybNF6
	phYw8NUQHxKT4hzEC/vrHorIOmp1PBE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-donkMl0dOUyv9YAEQoNQNA-1; Mon, 10 Nov 2025 07:30:51 -0500
X-MC-Unique: donkMl0dOUyv9YAEQoNQNA-1
X-Mimecast-MFC-AGG-ID: donkMl0dOUyv9YAEQoNQNA_1762777850
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b72a95dc6d9so298992466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762777850; x=1763382650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZzwD8CAgHHIN7QER1FgOYrseElyIf9KwDMPjRpoiRw=;
        b=O57r6J++2ilbpBCTDPRXoh03nGZq8zxrSKrxsQBHvfc1CB02HuKXjAI+UybAo/YeGm
         ZB6xtC0gJFWmC1BNvlrB2NROypiSiSAAJ2elG1uhCig9ZNVYqkFczGj+uX2mLIzaRLFA
         5VQw1fWBjqTE9gOGpsDl+ELJSP/gA4DC/emo7WQUju3nUi9eirXTwyHEvS6NlCvcf3+n
         tXqt8OVC+d3hNO/8svfzU8BoCUCbMeHCIHmEsiJbvBMUTOmo8PVwVDQUP7uUAW1yEHEC
         SE/xtQsHlrwzUJRceDYiBqukzrCT4BpXs0SIm7CVZXUj+4gh6EvH98EpR+ghuOmh3wHU
         vLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762777850; x=1763382650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cZzwD8CAgHHIN7QER1FgOYrseElyIf9KwDMPjRpoiRw=;
        b=b0V5m9xgSoxoT0xZXBGzfK//Fml+MXi1kPx5WeoPyCgXlSMhHO62OmEBhe0YxXNblZ
         7hd1Y12+GdNcPVtZXSUAN00K4W0YTzuWm61LpVkRDj/KTXT/x6DhqWw0SUBF60YpVQJs
         mf6YpBcSzhTh6HE6UD7XWElZrfZ4IASxvrkA/A+xRF33N/n9kOYdsXD6QwK0R8JWeHc6
         z9fmyw8+PmCfXxD3RoOGSxfUhB+n32bL2kLZSoE0c2mCkH+iTcibu1kxChtoxMRk85ax
         g8DU5QibSgWChyamFdww9Z2xEvJA2vjvw82OCAfQXc3BFbmormCLKOFWk3UPwWwXs8gU
         IaKg==
X-Forwarded-Encrypted: i=1; AJvYcCX2+/UDF8KvcepRh4EeeKMqgI7NpYe0fBMla4AsbfDgS+GuXRta6BCCVedyHjmM3r2bM2m5ttkr3Gm2FVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw0hmfccfhLwkiFtgJiPA1iNOBQTrgjKLSK/CkIGpFZnTRqX6E
	oM4aZzhmdj0OjkqvIiNzDhLYIwBVb2gYUpNfghmhYEt0YaQZR2pRKrQjFZTmdEnUiZUO7JGpJCc
	jEibpiJ1KqldFBJBFwKnCC47qMzs3eXKp4KBYpsgr7oRc8Hq6nFAx3EYpCK23/B1Xih5F+BkpAZ
	3JBzxAoiq8MEvzqdicfrp9x6bNsWadnMFtCZJAByuR
X-Gm-Gg: ASbGncuzGoOqFIkUZPs3QWaIcbcLyjmTw8JtS0HCh3p/x/nGPKC/HNphl8hf4K9VPQi
	4y5Fu+dZQ1YGfIwwfIVKIgf21PP7OUC2378ZGZ3qSx4IAW8BqXLKa5oEXWuJ7OjH+Al9yKVSZ2c
	G1x4qHT9zakp8e2dPkdtQUXISm4j0eRiDEOkzlm9q5uC5Q6bt8i//iwlSNdNJ9gNfDD/WwYdUCb
	nb68gRt+lik0Xf9
X-Received: by 2002:a17:907:6ea2:b0:b71:df18:9fd6 with SMTP id a640c23a62f3a-b72e04e2f9fmr796238466b.50.1762777850314;
        Mon, 10 Nov 2025 04:30:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFW79YXbAPd7W8RNSghkp1pkzH62zBSAQuhhn9/CPDDGq4jrM89brzjtSfduo2ZuurNAnWCmxoqBt5xe4Hhbow=
X-Received: by 2002:a17:907:6ea2:b0:b71:df18:9fd6 with SMTP id
 a640c23a62f3a-b72e04e2f9fmr796233966b.50.1762777849827; Mon, 10 Nov 2025
 04:30:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b44ec08fbb011bc73ad2760676e0bbfda2ca9585.1762434837.git.rrobaina@redhat.com>
 <a396108e2b9f19f0c453a44c8e7be873@paul-moore.com>
In-Reply-To: <a396108e2b9f19f0c453a44c8e7be873@paul-moore.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Mon, 10 Nov 2025 09:30:38 -0300
X-Gm-Features: AWmQ_bkxQQWcfjx8r_dF3delGcKOWNjcP730Sx0eYw6APmUwazLTOE5cgyXbh34
Message-ID: <CAABTaaCgFUUNAcrPM5FdskoACcp833kfpM7xv0JNZ0+ZxG+v_g@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] audit: include source and destination ports to NETFILTER_PKT
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, eparis@redhat.com, 
	fw@strlen.de, pablo@netfilter.org, kadlec@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 7:46=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Nov  6, 2025 Ricardo Robaina <rrobaina@redhat.com> wrote:
> >
> > NETFILTER_PKT records show both source and destination
> > addresses, in addition to the associated networking protocol.
> > However, it lacks the ports information, which is often
> > valuable for troubleshooting.
> >
> > This patch adds both source and destination port numbers,
> > 'sport' and 'dport' respectively, to TCP, UDP, UDP-Lite and
> > SCTP-related NETFILTER_PKT records.
> >
> >  $ TESTS=3D"netfilter_pkt" make -e test &> /dev/null
> >  $ ausearch -i -ts recent |grep NETFILTER_PKT
> >  type=3DNETFILTER_PKT ... proto=3Dicmp
> >  type=3DNETFILTER_PKT ... proto=3Dipv6-icmp
> >  type=3DNETFILTER_PKT ... proto=3Dudp sport=3D46333 dport=3D42424
> >  type=3DNETFILTER_PKT ... proto=3Dudp sport=3D35953 dport=3D42424
> >  type=3DNETFILTER_PKT ... proto=3Dtcp sport=3D50314 dport=3D42424
> >  type=3DNETFILTER_PKT ... proto=3Dtcp sport=3D57346 dport=3D42424
> >
> > Link: https://github.com/linux-audit/audit-kernel/issues/162
> >
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > Acked-by: Florian Westphal <fw@strlen.de>
> > ---
> >  kernel/audit.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 79 insertions(+), 4 deletions(-)
>
> This looks fine to me, although it may change a bit based on the
> discussion around patch 1/2.  However, two things I wanted to comment
> on in this patch:
>
> - Please try to stick to an 80 char line width for audit code.  There are
> obvious exceptions like printf-esque strings, etc. but the
> skb_header_pointer() calls in this patch could be easily split into
> multiple lines, each under 80 chars.
>

Thanks for the feedback! I'll make sure to follow this guideline from now o=
n.

> - This isn't a general comment, but in this particular case it would be
> nice to move the protocol header variables into their associated switch
> case (see what I did in patch 1/2).
>

Nice, thanks for the tip! I wasn't sure which style to use, so I
decided to use the classic one. However, I do prefer having the
protocol header variables within their associated switch case, too.

> --
> paul-moore.com
>


