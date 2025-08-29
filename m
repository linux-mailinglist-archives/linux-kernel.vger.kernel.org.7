Return-Path: <linux-kernel+bounces-792437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D745BB3C3E2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 22:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 325E8188DE3E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 20:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0E534572B;
	Fri, 29 Aug 2025 20:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lqaWeNsQ"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A01248F62
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 20:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756500271; cv=none; b=F6TJ4gxS/L8ewQ6HNaJTswYhdYWywjFxExXFlbM83fpM73duSPIdZ7VDV5JQMNN8kTcQnSq4CSuwZOfaY+KIXIp341ldbdFeQCk3d7Detnz8Xebi9cFvznf0nFGTZ+HA8OHFvbIT5fzi2+uBPjEwAwf2Uekyeh8rQNVearkPqm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756500271; c=relaxed/simple;
	bh=gEVirROcO7ri25qt0Gj19iTHUCoKldxdnqRiAEyjD4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G0+zWUCFvgy4vAdTtSs22XEA4Cl6uhF8J6hS/zJqGSeSKAbJfqs6Os6UBi+nt4ZCxHi3WTOIjTl3RRiIFTmccod4AISAd+q9l+xeUN6qgCkFv2xK3XWHIw8lMQTGJANmYmwaMW+EmOTqW30iYNQx/Zrec/cubeZf7iqN155OJ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lqaWeNsQ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24936b6f29bso11225ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 13:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756500269; x=1757105069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2q9phwNdrBTTHrc7DTMMS0l8waI+fDO2xGwQQOv6Ao=;
        b=lqaWeNsQaVALmFQhWLSLJAid/ksSjQ9YY1SwKRqP16Yo2uvx2QMdqhPW4I/KFjc5RP
         +nsIf21zmzwfemM6Sle+lAckJ0oOkz96vqFSSpN4QZ7eAh0/izziJKPV9jovIGKnTbot
         CYqIKTksl8QwyI0pgZZUxRAkMflQfKecuMj4SUtI9faL77tMOZ+0cF4zwv+4vWgRPP58
         TRL4i0RokMR3INhtZQtmtQ+rCbJ13Z1KvkH4KqbXSaldjcRLYCjPt/nDlTY1Le6mClBy
         3OflPuI74904aoHAa+4Vg5wA9aOwaBjWhqMQ9Ea9yZKvSs+wlnLLEQ9696Lmc+kkC8ws
         jxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756500269; x=1757105069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2q9phwNdrBTTHrc7DTMMS0l8waI+fDO2xGwQQOv6Ao=;
        b=ac+8IKZ/Rv5oprOSGo795g3Sy9R8Y7CoywrLTCByfsTj13owZ+lKhjRg5w5f70uAEb
         JhGmRZt8UrXVQAmn2sb15bxyul+OMbw7qo+ow5jT9xOdn+6ED/KmItepllBvsRWn7Ofn
         o4eGK6WkE1VRXe/AtjRbfqplkcc/3HUmz6f5CC6ADFnj3nLfwozEY9o3g34ZxfU2uAbO
         x7Iqn3bfDAU6HsYpuEGVTvi4j1sTNtdXQ0hJYJv/knrTqDYdbpfnSkeBqUKMrRNRKCPh
         TptQpNNDXzrp3NAiUfv8vfaxsfxNONfVpKif/FOBVYCpO0lYxi+R1XWpQJhEnEniYsdB
         0zgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ1RsJ9VkpNqLpdIpPM0Ad+GawjRtxDqwxT8+UuQSJkQxBbWPGGZJLgZgSEuZY/n5VdVHmPQ63xwEmw8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmOO2evFTnrWhBDZWEg9G5+fDZjvrEY9+zWnJPgsivUIscEF1+
	11AlmzsGKljQU+ptmFckHZY3AwZw0lt4EhM2+xvm7M+DhND2rWzfnHiuq2ygNiJwT67lp9k8sVN
	L4vOjJzwqX3/+6qOWy9EJYLuWNtMB1wnwccjA+Wyn
X-Gm-Gg: ASbGncuLEb0Qm5PaEFkytVF9O/KpPpRm4i0lMAoZqHSfCdMcwYcknRJD+Hmg2kDkxj8
	8abylv5dx1Li/dHotP1HYTp9aYxZhuBCQl896LPSMWs1K54bGtxIxW75GHC4VHVHXGt886n4Nwv
	o+jPqjsz7lR6fdwCmpWz6XdqNe38eWNsAMeKZMnRHm/lLRlbxXe6Gq1cq9teKsJtzBuhsHrQs7F
	1W0XMJgTN4WQGsdmy+XYnHjEbYQ49XJJKWlShrQ8C18RHt5kZF5+i/MvYL/+eL1PFIpfZhc2KPu
	zL26aDl7v/U=
X-Google-Smtp-Source: AGHT+IF7k5lVtyim7FCdwKqIzS5FoMCKjb2sruw0NCU2My2KQyK5XacP05klsD3NAciNeqowwygvolVtflHAMPwPYZI=
X-Received: by 2002:a17:903:2307:b0:240:5c75:4d29 with SMTP id
 d9443c01a7336-2493e35ff71mr1048425ad.0.1756500269098; Fri, 29 Aug 2025
 13:44:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829183159.2223948-1-max.kellermann@ionos.com> <20250829183159.2223948-2-max.kellermann@ionos.com>
In-Reply-To: <20250829183159.2223948-2-max.kellermann@ionos.com>
From: Yuanchu Xie <yuanchu@google.com>
Date: Fri, 29 Aug 2025 15:44:12 -0500
X-Gm-Features: Ac12FXyYeG72ntDgrzYOawZxMxaNyzRltRlGWQdp6qpO4b3XGq1I9z-x_Z4E9jA
Message-ID: <CAJj2-QHVC0QW_4X95LLAnM=1g6apH==-OXZu65SVeBj0tSUcBg@mail.gmail.com>
Subject: Re: [PATCH 01/12] mm/shmem: add `const` to lots of pointer parameters
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com, 
	willy@infradead.org, hughd@google.com, mhocko@suse.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 1:32=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> For improved const-correctness.
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Yuanchu Xie <yuanchu@google.com>

> ...
>-bool shmem_mapping(struct address_space *mapping)
>+bool shmem_mapping(const struct address_space *mapping)
>{
>       return mapping->a_ops =3D=3D &shmem_aops;
>}
>EXPORT_SYMBOL_GPL(shmem_mapping);
The exported symbol is being changed, but this doesn't seem like it
would break anything.

Appreciate the work. On a side note, Andrew previously mentioned[1]
making the actual parameter value const (which is different from
adding the const qualifier to the pointer). Longer function
readability would benefit from that, but it's IMO infeasible to do so
everywhere.

[1] https://lore.kernel.org/lkml/20250827144832.87d2f1692fe61325628710f4@li=
nux-foundation.org/#r
Yuanchu

