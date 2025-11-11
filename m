Return-Path: <linux-kernel+bounces-895243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F26BCC4D56A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EBDE1892C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404D7350A16;
	Tue, 11 Nov 2025 11:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QtmDRNlG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJ7bZ0kJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99B333DEE7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762859176; cv=none; b=ofj5ebtnnqrWlACp3KN8SpadtoW9BthsPFvOcdEtWKzQgXzFKmbCMB2JX05+kFD4cxyOynobebiVbohQcpis7Q36haNQtcac56RWZD+yw2QAooRrru0Wssefuii/pjxaWHtrf8v1RhB2M4FR94KOflTl11k/x/4OymmBgcmnfT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762859176; c=relaxed/simple;
	bh=wgdtMOgnIdauBeWDydYoY+O9WRpPfmsDE4Q2ko8WTUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sY8ppPNk0gbfOSadCU7aoQXwhICN0TmEQt18suZorpaK6hpFZHEbo8ttxr4PBRXvV321gnGt+IVLr9Pv9sQ4oH+miXjeSdqEJhzAUVgF6I1AYbsSBMDrZXbankfDR4hKpDNC3VtyjTpb7luNTKOOKKwXso0BL38hFU6IBZ2M7kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QtmDRNlG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EJ7bZ0kJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762859173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0GDbVFAUnTTBAQqYxAS+qt3Sk5mP5Wt8XB64j/zpUDE=;
	b=QtmDRNlGPZtCDYAC83oVNcwYLiCm6rDZyf0koeCW1XNOS/iufswkYhAVaQzWOiPBHFGMIG
	ENpEB6xkMBfzTH0AYRYGblaa5kSOFeJDIF+vCK6Xf2usTjaSXfDhIM31HFf+o6oUqrBR3f
	9Tiksmiino+VsmDwJyqDHYLUTf+cD5w=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-FemGY0K_MaqTCtdZ2P2RSQ-1; Tue, 11 Nov 2025 06:06:12 -0500
X-MC-Unique: FemGY0K_MaqTCtdZ2P2RSQ-1
X-Mimecast-MFC-AGG-ID: FemGY0K_MaqTCtdZ2P2RSQ_1762859171
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b6d7405e6a8so70413666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 03:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762859171; x=1763463971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GDbVFAUnTTBAQqYxAS+qt3Sk5mP5Wt8XB64j/zpUDE=;
        b=EJ7bZ0kJo2yATF1Ax0+Gv2vL9VgSZ9K5mJ1Qr5IYFkn1Druvc5tdiecGfeIsD+JPnD
         IA724Y4/VisadMlPGYmYermk5Dg5BLSH6eM0bjptnKEXDBeSd+TR6JgdyRzHqrv5C9nr
         /HtDh2naisPlhTkpnMeEpXKlxpvhGJpPTfYSASc3xM3+V6NwdvciQbRyfz5SQQKi3zBS
         onrfDlqjaSbsqvbtQu47/bOFYcKtalqYNhs1GbtE38AxGrOg14thKhJ9IAezQrtIGzEr
         9jYbzTn5XF0j2r/30Kl7fsgC2DYChGPfcdrLX7BaIhPyHQVEByLH/adJN5TCenl+Ppw+
         OwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762859171; x=1763463971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0GDbVFAUnTTBAQqYxAS+qt3Sk5mP5Wt8XB64j/zpUDE=;
        b=p4XLsWrzpoyE5C06tMM3vsaL8LN7koVX289DJAsBTPc3DzJcD8iRy/QaMv6/nZXGWd
         n+KWf1v5f4aw4EWfN+8G2mQIYwNStjY1JNCbZz5alYFdeEkNoARlbR01rHTPSNTbMiUg
         N7jHPj4jzOmIVbzxzVkAtCKy9HaLuBszkyobenU9DVaYX3QxGjxLMz9D8fW1NQ53z051
         DK0Hh84dt5HNjcf26PHPCiMWLStImu+QfaqqR3tY2cLci4vNFIeyalAodtDa5a4dSBgc
         i4d+ZAu10npDCRaRTM0L7Abbdm1qlV3xjeqm7FteRoFaLva33ATtlFLX6ikjWAs4l5iP
         2tyA==
X-Forwarded-Encrypted: i=1; AJvYcCXIISM9TcBE8EiVxyCsuB9XRjwPA7SVL4/Hiay7qQJr6kCFvxei517pZCFU+mdky433i2eq/OyfA4U4WOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4OL09JVF8rdOfvwqTCuSyeTaLqMdPH3XDdYjMcF21mM4sxg0M
	ma+qxPpxsO9JtSTqG+UhrFT68oNZbjbkfR20iZrWdB+6l5hwomN44sJr3AaUSn84kq3IaTRcDOl
	jNvs4GSP24SjzpA8HL6LUBlD8ARLmYJIbrfn+c+sG0ZThTmeHt4REbuw86xy3BZRDBhhXSLfz7n
	Az3uTWXIexAUP1633TqJYPBcrfNpky3RdWFri8miZEI7vCd6cdgvM=
X-Gm-Gg: ASbGnctYswab5VQehIrauGnyATTY4e3pOWDB1+ZH5DgQmM0WX3ZdgMWIwh6cNZEuHQG
	/YDHlY8DBhqhKlriE+pDCGgnNoEzeKBHp1VVlDtH10GHsv9bRBfUwAa0TkdnZw5lnSyxCQHmJE2
	1bsgD5S4IzvNnhYVfeynn29bAc0gx5d1QVGK+9aY519aeq9TrytB3GJ28Tx4ZRYGTr2A9GWW0bF
	h7MkZ4q/FpL6Wl5
X-Received: by 2002:a17:907:847:b0:b07:e258:4629 with SMTP id a640c23a62f3a-b731d592612mr365867966b.16.1762859170929;
        Tue, 11 Nov 2025 03:06:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH00joUcH98KIScPdspMz6C7WmzE6y9BjmZMzMPi9/1/g0CWswqBDBalNWaO//kifqVOVeSio6hNYd8TE3PJWo=
X-Received: by 2002:a17:907:847:b0:b07:e258:4629 with SMTP id
 a640c23a62f3a-b731d592612mr365865466b.16.1762859170594; Tue, 11 Nov 2025
 03:06:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <acd8109245882afd78cdf2805a2344c20fef1a08.1762434837.git.rrobaina@redhat.com>
 <e92df5b09f0907f78bb07467b38d2330@paul-moore.com> <CAABTaaCVsFOmouRZED_DTMPy_EimSAsercz=8A3RLTUYnpvf_A@mail.gmail.com>
 <aRHd_WFBcyiL1Ufe@strlen.de>
In-Reply-To: <aRHd_WFBcyiL1Ufe@strlen.de>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Tue, 11 Nov 2025 08:05:59 -0300
X-Gm-Features: AWmQ_bms7BujCKPIYEHexBScB1G6ShV9xg4dnReCgV_Fb1MzdZWI32KI09CCb4A
Message-ID: <CAABTaaA7XKVcV8GdmdkKLP+9gfKpv5f4oJupVXzR6KEaOFS9cQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] audit: add audit_log_packet_ip4 and
 audit_log_packet_ip6 helper functions
To: Florian Westphal <fw@strlen.de>
Cc: Paul Moore <paul@paul-moore.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, eparis@redhat.com, pablo@netfilter.org, 
	kadlec@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 9:43=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> Ricardo Robaina <rrobaina@redhat.com> wrote:
> > > +int audit_log_nft_skb(struct audit_buffer *ab,
> > > +                     struct sk_buff *skb, u8 nfproto)
> > Thanks for reviewing this patch, Paul.
> >
> > It makes sense to me. I'll work on a newer version addressing your sugg=
estions.
>
> Nit, but as you need to resend anyway, can you also make this
> 'const struct sk_buff *' ?
>
> Also, given this isn't nftables specific, I suggest
> audit_log_nf_skb, audit_log_netfilter_skb or some such instead.
>
> Thanks.
>

Sure!


