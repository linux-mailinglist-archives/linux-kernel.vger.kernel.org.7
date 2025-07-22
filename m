Return-Path: <linux-kernel+bounces-741597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19508B0E65C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 00:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3BA17E49A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 22:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B96289802;
	Tue, 22 Jul 2025 22:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KASwnnT1"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0522882AA
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 22:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753222821; cv=none; b=LMUWZ8U1ifB+wH2fO76R/5ZTHwza8k3xMjfwYE/Jt64oN7Bp/XmevtUPGwRrKPEkaUU4WTSBQ20U55nMF6BLPNTBgGWUMJ1dObkEJM47ztDjbJW4vtll2uZt81NE+xCYqAmWOWQFA66N84bHhCckmBU7yGr2BkqkQTp+NzrUJYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753222821; c=relaxed/simple;
	bh=KocGrJA2Ps6aJTENvIIuem9ofzkRJ4o80JKPBVLHtCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LFu76KsvU5YOgw82VS3wEhX0egXOFZ5hFT9ATGUyqhzuhVSqtKGT2FsN1ZJZ4+YDXtlLe9i5UHbqDHYJdn7JvUu9L24cBSyJY6anEMmu/LY+dPiZMDX3ZMJ+0AVIJhj9QgVRrCFe+3RryelnZBd2TNdeJgFhql6oSkv22F8yejs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KASwnnT1; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2357c61cda7so24405ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753222818; x=1753827618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUgAXknrynl1PVAEbmko9jsFy37xoKt232CbGC5xnSo=;
        b=KASwnnT1IM0bapm3dBB3dF81HbyN89veE00MpoJJ1OtroNdUXXJNGsBi64zmjp9V5F
         n7pRoAUpB9JIyIW5H561rHqf7vGcun47h3TWHAXxI1/Y6+ulYnkDKvb/cTz3a/HPzxu8
         ztUXgEUurG+RGd7KItrM3N8W0bkzekWWQCvy90jYqdrqAJf0GWg4XE48S61rwDJO9QvY
         pWjilfx+wPYllh12cIMMpOGIYGJuJLk9KJRAfp4ifIGH1GcsbiAPETOjpO56vefNt0Gj
         GCRfwpz523C4/1jCnCCcIAQPWisXUNBFI8cV4msd1RZm99kerwe7kokTUNJb6efKRShi
         SKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753222818; x=1753827618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUgAXknrynl1PVAEbmko9jsFy37xoKt232CbGC5xnSo=;
        b=oC9xyLJfOYQEkag1xlab004bH41OBWO3JI4wa9Yz2tmf15jolSNfsgvESr7in5XJOj
         Dn0flK2Dq/zc044q2GaTPIEZYjOItgR9GTAXMbntmzLbtNSxGKpFkJiL+CpiQNR4YF8+
         qRZo0rCAwG21lT0SHfKVp6UKVxNt+H5v5Rc5SGLJUp+Jx6fpivi8qvYEJj9KmVhf5i/N
         UMPOiQ3z8apXQ8PR+zD4LWxrjQNR8uC/4BuFamV094nARmeLQ4VA9qJ7UgIZXks2guGM
         x/ULbZ7EkypzgWxAxP+ikjQsrVr8VWqNvZUs4ZwcyVdweVcSpSJHzGJkHz8WY1st8IKs
         cMdA==
X-Forwarded-Encrypted: i=1; AJvYcCWZHxuh+fjaEKj/Ov1axzlU9nyaJZOZJSlKMxdc0dY+iVQWSSRuhgAnillz5PFm6N3ppgho2QpSaniyfj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVEaP7RSVM8QVKKxdDE+sqQZFJdxzjz1vTE4hKb80lZwWvaWIY
	C6c1P9D/DbKnVHIfcXMt9PlR6VY1v0251xWu3tp0vCIa9phHxRqn0VzotYx6toNfmaxEyWXE67T
	aXegJme+ZhgqYq1xBNMq7kx+EfomfFaKjAHBLZbC7
X-Gm-Gg: ASbGncvaboARoLrN8FSH8h2IJf17IgC7bywIAcytlefqrcXNrjAyCqszIBtlwVa6eZk
	0kTHQ4e/38EBDJZRTZsIiAOwT5hxhnrMYi8n40LMTISN9vtfKy+A1Jkg/N9UZFUcb6yGF7T7iuC
	hBfr57qq+QlbYz+/X8lOwcfieNQVVISHOzDVFc89iI2e4UoEARXlnQtp+8w0R6LGT9iupZdafv5
	UmHVY602Nu3VGmVoLMxASArLaC7Uf/p+6FR+sEj27PR4xBz
X-Google-Smtp-Source: AGHT+IEJT44DyruhFdmOQYM4W96ZZ3Rqdwh8/66PV5JlsG3oxzJ17BtYsAJ9a8lIS9JPty9YbWXGIDpfJrmGPSXLLK4=
X-Received: by 2002:a17:903:b4f:b0:234:bca7:2934 with SMTP id
 d9443c01a7336-23f9774a735mr1113195ad.6.1753222817810; Tue, 22 Jul 2025
 15:20:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721054903.39833-1-byungchul@sk.com> <77ee68c4-f265-4e55-9889-43ab08f26efd@gmail.com>
In-Reply-To: <77ee68c4-f265-4e55-9889-43ab08f26efd@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 22 Jul 2025 15:20:04 -0700
X-Gm-Features: Ac12FXzc1yuJwF_iFb86CzQvJ9VHTzSRxkDhmv6GFozlbXOI8GKQHpDpguZKYVU
Message-ID: <CAHS8izM6h1_qoPnWDHmPiiFj5e_mcJqQFTTLJT9dgBymJuk8rw@mail.gmail.com>
Subject: Re: [PATCH] mm, page_pool: introduce a new page type for page pool in
 page type
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel_team@skhynix.com, harry.yoo@oracle.com, 
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org, 
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com, 
	leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com, andrew+netdev@lunn.ch, 
	edumazet@google.com, pabeni@redhat.com, akpm@linux-foundation.org, 
	david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, 
	ilias.apalodimas@linaro.org, willy@infradead.org, brauner@kernel.org, 
	kas@kernel.org, yuzhao@google.com, usamaarif642@gmail.com, 
	baolin.wang@linux.alibaba.com, toke@redhat.com, bpf@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 4:11=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 7/21/25 06:49, Byungchul Park wrote:
> > Hi,
> >
> > I focused on converting the existing APIs accessing ->pp_magic field to
> > page type APIs.  However, yes.  Additional works would better be
> > considered on top like:
> >
> >     1. Adjust how to store and retrieve dma index.  Maybe network guys
> >        can work better on top.
> >
> >     2. Move the sanity check for page pool in mm/page_alloc.c to on fre=
e.
>
> Don't be in a hurry, I've got a branch, but as mentioned before,
> it'll be for-6.18. And there will also be more time for testing.
>
> > This work was inspired by the following link by Pavel:
>
> The idea came from David, let's add
>
> Suggested-by: David Hildenbrand <david@redhat.com>
>
> ...> -
> >   static inline bool netmem_is_pp(netmem_ref netmem)
> >   {
> > -     return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) =3D=3D PP_SI=
GNATURE;
> > +     if (netmem_is_net_iov(netmem))
>
> This needs to return false for tx niovs. Seems like all callers are
> gated on ->pp_recycle, so maybe it's fine, but we can at least
> check pp. Mina, you've been checking tx doesn't mix with rx, any
> opinion on that?
>
> Question to net maintainers, can a ->pp_recycle marked skb contain
> not page pool originated pages or a mix?
>

IIRC last I looked at the code ->pp_recycle technically means it could
be a mix. Technically it means "consider this netmem for pp recycling
when the skb is freed." and non-pp netmems don't get recycled to the
pp obviously, because napi_pp_put_page rejects recycling them.


--=20
Thanks,
Mina

