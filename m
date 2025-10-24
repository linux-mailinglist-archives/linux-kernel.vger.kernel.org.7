Return-Path: <linux-kernel+bounces-867975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD00C040B9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 97219354CAF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 01:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265081E1E00;
	Fri, 24 Oct 2025 01:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fmu6rQ2G"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1769D1DE3B5
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761270554; cv=none; b=aV58K41moyIcxNb2qsf3ufskgXIcI1vGrZ+h261OKL3NBQJs5p8/yF7C7U0sRTgkZ73bd0GTHgukoAof49QuB2fwbu6lM+ppqjwWQeHNiwvHQik3u4fwjhzUv7qHqvNZnbDpXfUy0YQbiW2GFwUDIUHTSW2PsZKBtZFHAMJFyyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761270554; c=relaxed/simple;
	bh=Yl3u9R8DqGEdSBgxABIdGTVu2hAd+PBgi0XIyNSnalU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mgRCBIdn+sSahD4PE9qWWDCv54/zDQR0ynowjP/SwGYt80e+BBKGyu85OLubXttnchf5Sk47dW2P0DyC1RCH9QBKiPOQv8fUpLLmx2qESVvDOauv0YGvBn4bN2/2t4EfG41JIGml/3Wvk/Ys+FKdkaD1pac3MC67NzdYa5H/c60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fmu6rQ2G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761270548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iaP1LO38e4/f4gjNwkOlGA5+LCuZXp5lWw5XIw2ivgU=;
	b=fmu6rQ2GbKY40pn1Zvl5I7WK95VtZL48Y2Hz6lsVvx/EKdb5PL7D3vhGsmcjvD41aBa5LZ
	Ewy2FLQ+Ek84EX9yJ1oN45EMwiDphglXUyGPGya32IKc2cwL8GIp3xGqwbFA3te4C4VT02
	gNpyrJnFB3xipGmF5yafi+cidEhsURQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-hcU1l2v0O6m-PEbEevz9Bw-1; Thu, 23 Oct 2025 21:49:05 -0400
X-MC-Unique: hcU1l2v0O6m-PEbEevz9Bw-1
X-Mimecast-MFC-AGG-ID: hcU1l2v0O6m-PEbEevz9Bw_1761270544
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-81a8065daf4so16214076d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761270544; x=1761875344;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iaP1LO38e4/f4gjNwkOlGA5+LCuZXp5lWw5XIw2ivgU=;
        b=clRGTqgoLezeqGWRoikV55K/00h7RXTJSTKPr2D3xjFeeMEuvKAtLGzf3IIoMoOB9t
         /UAs4PUHdf3Dvln2+B5KDeU6F7ppQaiM+nl748XZ0oHZQrvqHn/ZiEHs41RrK2cN6xTY
         wSKUlj4mD5EN20S6dXy87q6/7hi0T2DNAp/73uPnY9amFdRUQwIQ71h1MXO5qyA95q7K
         lnSiQON89OEjFK+AUSH6cwQTXvculC40QWFcP0ysteae13lP6Nq3Hc8vsAvrNK/b7sLU
         YUh9thlqvd1t0kxuKz3A5Y2g7ogyOziqkGzhKzyp4ZZyBSVzyKH5Y5L8+soMaSZ14CKE
         fOnA==
X-Forwarded-Encrypted: i=1; AJvYcCUU9VGXgwfAjASW9WzIfL9A15atT7G3xmtdov27EeIG3SACpPryudeM+l3LDDuIPNiQt85/1oD8jn/Svq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCJhvrcsbqVvXHiiRo8u1FhHiQFdJlZIZ/lHtgcet9iZ8HH+hF
	/0u3bV0F6hO8u0I+RORcRu6IXvqrYBYQac5K3ztZecAi5kew08ot+117oz+Z3yTtRDgJXGXkM5k
	CMYKmVUd5SUy5k3swE7nvTNFtTZh+5HDfEjffMKGeCKXijQujBoeXOOiWuZq6y7QD9g==
X-Gm-Gg: ASbGncsuNiikZ/TXqfcFQAGM4uMBt6c/5wlXSAcWJUUz6ieRDKfUD6Sx1+2gAbJ/1W7
	OxJroZ+G7o76MKWyaHG3etLj2cHXQUEUligM/9un0p2ipOFxUREBj+yAECmyiBaRiUxZ95D2Xsa
	Tbd1Io5SpZEWeGVpX78Ry/r0g37dEMiTgwVt1nZ67Kqm2/OOMyslhf3deEo/vA+dcF5mqR4UBFD
	vDvx7MUcYXjvt4jkcqdknkjUuy/JGTTwFim/5K7rSmss1DpTVy5UAevJI55ftSCQGzl75zNQmCo
	C2kn279aiW3nVSgxaEO5OfwVZ3QuDNBtEv9gcELLMdtQTNZA6P+FrR8k7a5dZvj4/xIiS/4WNz4
	RWzWyR52g4AH5v97HhqQKHyel5X61sbs=
X-Received: by 2002:ad4:5c44:0:b0:839:112c:1332 with SMTP id 6a1803df08f44-87c206398e4mr381179056d6.55.1761270544561;
        Thu, 23 Oct 2025 18:49:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkekBeKt/UBYBK9lMa4hj3CeOCtL78ldOAual+TkPrSzY56RttSscXLjrpnEwizYLA7MNPfQ==
X-Received: by 2002:ad4:5c44:0:b0:839:112c:1332 with SMTP id 6a1803df08f44-87c206398e4mr381178896d6.55.1761270544218;
        Thu, 23 Oct 2025 18:49:04 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fb5681868sm4474386d6.52.2025.10.23.18.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 18:49:03 -0700 (PDT)
Message-ID: <ecedb0d1f2d0e51c56e462adf75df47e8d593a8c.camel@redhat.com>
Subject: Re: [PATCH 3/4] rtla/timerlat: Add example for BPF action program
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,  Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, Luis
 Goncalves	 <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>,
 Wander Lairson Costa <wander@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>
Date: Thu, 23 Oct 2025 20:49:02 -0500
In-Reply-To: <CAP4=nvQGM_L3dpVpb36umrwZiCT+S4kGQOfENHBXRRNcy0MA8g@mail.gmail.com>
References: <20251017144650.663238-1-tglozar@redhat.com>
	 <20251017144650.663238-4-tglozar@redhat.com>
	 <c52490c9c2f682fd3c30d6f8a198be2ba408c4fe.camel@redhat.com>
	 <CAP4=nvT8VGpYrqQDztmB1WJPEb6JXvUuL201ksWq6eSV7kn-oA@mail.gmail.com>
	 <aa0bbfeec78bc90966e660af91eb39acccb77d73.camel@redhat.com>
	 <20251021130232.2ca75863@gandalf.local.home>
	 <321181e1e5060f0c68e0430d69e0e89688b08235.camel@redhat.com>
	 <CAP4=nvQGM_L3dpVpb36umrwZiCT+S4kGQOfENHBXRRNcy0MA8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-23 at 09:27 +0200, Tomas Glozar wrote:
> =C3=BAt 21. 10. 2025 v 19:32 odes=C3=ADlatel Crystal Wood <crwood@redhat.=
com> napsal:
> >=20
> > On Tue, 2025-10-21 at 13:02 -0400, Steven Rostedt wrote:
> > >=20
> > > Note, trace_array_printk() (which trace_array_init_printk()) only wor=
ks for
> > > instances and does not print into the top level trace buffer.
> >=20
> > Yes, it's for instances, such as the ones rtla creates.
> >=20
> > -Crystal
> >=20
>=20
> Right, it actually works with the trace instance, when set up properly:
[snip]
>  Saving trace to timerlat_trace.txt
>     timerlatu/0-47791   [000] ...22 863353.286497: bpf_trace_printk:
> Latency: 21282

OK, but as far as I can tell there's no way to get the non-BPF "stop
tracing hit" messages without adding a call to trace_array_init_printk()
into trace_osnoise.c.

-Crystal


