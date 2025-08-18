Return-Path: <linux-kernel+bounces-774595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64061B2B4C9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 660E05E8094
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 23:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B660271A71;
	Mon, 18 Aug 2025 23:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ALV5OOfJ"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418081482F2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 23:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755560033; cv=none; b=WDvmVUUqGHz61kmhp9/P5PmpG6dV/02DBYiHppGPG2dnH6H2FpMz4GiCjUDChLg3XjmmJYBtVcESkf4advXaqSCT3Uipu8ZdrrxJuGtG3Ox9DPRD8pLsb1V2V/wuLRU0tBh/ObiGMaIX2a1bLXlW58qEPPQoDI5iWIkXdR7OBkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755560033; c=relaxed/simple;
	bh=OoeYFB/BvC/0eRzNt4z96d91dntS57ys6UGlVQXsAGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aPD4rmNngZWloZaAWmdAgLuKRX6G7KJoYGi1ytQWwvMpqRSkmCxNPz/BUSa0aaxUVMpqXAZNaXOP0qXhRjnNFIAlq4M35jbBKVpK3TGJ0ehSXE4XhLiLcXaHS2h/ouoK7LldajH2rf+vTgcYtNGWZqS2vAhnKhu015+DgK5J1mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ALV5OOfJ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55cdfd57585so2063e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 16:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755560029; x=1756164829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ve2DzLaZnDqnbb7Kf6oBSozuJ15Yl3sv46ZZmhVCBOo=;
        b=ALV5OOfJwrWkFApNk++CdI5JqRT1SFNkuoBR4ninRxPJOMlvyDvldgDZNL1bbqIork
         rlf1DuToLYUSz1sgNPLqDkWrU80C86K1mbWu/MihZVc83F0TTUAeeUM05iVw156UhtCK
         GKMtpjJMyquMEjMu67PLzfHsZG7Fh5J5kdfUBg1HrTUKoNCN1L+fKoUpliwjRYiqFwa4
         DGitOVsWqb0+yWyFhs8SMvHAtBAeAfS5fyKff5dtjmgO6FhOTPcnw7RZQ+mxjh06bIJU
         DmZC4VKYXrhfIPowsfQLRUeDT4YfhOHEgjm6ujaesoUkK2hRfSwcODwGpyHyA4Asp0f8
         XdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755560029; x=1756164829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ve2DzLaZnDqnbb7Kf6oBSozuJ15Yl3sv46ZZmhVCBOo=;
        b=f7Q4v/aQFIaHdvS1CQgVw1T6a26qvb30fGWxs7B+LAIEc/5vbcOWQqzTgw693ckf1z
         xjvCvsD85QDo54dMylQrAGS/uG35v1L8ZABGWKzkEJ7ve1RZZ1nACKS44BSdYdAnEo8u
         zUabDNefAgt2ubVKMKv7PDMVOM11JyKVeb/Zfe5nNMFa8Kpz8xs7hajEodkIkuKzxkkF
         MaiMQE+cFUaFWeyxkpUrWGWqIKovmCkFl+ksm5k11EIKdgDDnu3EsahnJMC5our3By1m
         9ZpsaOuJge2XNvGBIW1L8NESPjRHdeN9/CTlItnfyhPXpPbEO98dRXpK0II8ucpcT+JC
         XCNA==
X-Forwarded-Encrypted: i=1; AJvYcCVI6VmV3izrps7VGPKVDhno5/Q8p2QdCXkDSp7tuKWCwVLh3sf+dV6Rj9HGWYEdRoDXoQJnY4345Wr5tIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwavojgdID3cC6gYShrY4fYPFlLVAPkafhitY8gNaIGBcxDItJh
	GbvxRzADP1MuMnizyBvLUJEXe6zJqULgKgHqrWfOORKob6CcwAH4dr7vlRAtglkYn+9c+9qhQPJ
	PkJ9UhtHHlKQ7a3NXA+Tns3Mizitbeg0hb1gYBQ/+
X-Gm-Gg: ASbGncsi+In3tVHA07wYmS5TF9DoxCmVX6Buk1kRp6vjz4BBtbTORmKpXLYsN2sGLsh
	nvBFU7rH9BLCN9uf78B+NK3gmteYpk6ciFXdIla68ppaUAlxZiIjt9JGmnIatd5YdmDTuvXNvzS
	QVvtq3SCkUr6s+zad4jHcWc7B1bCmEN25FHSSomao7PHfwvyQM9rdET5P45MZnzie6KUwNfGVkT
	4cuy1nMmjqcYj0yhOo61Mat1ioqaF3EAb4eCIxI+tl0Y8sOC9hul1g=
X-Google-Smtp-Source: AGHT+IFwQTCOO7naIVkzrh2yLXB0Ye5C7kP2H4rJJJq+y1I2xqZOOFQLhHsiWjrfXhQk7xhvimRErO3eSsYfBgTtoKg=
X-Received: by 2002:a05:6512:134d:b0:558:fd83:bac6 with SMTP id
 2adb3069b0e04-55e009c6000mr76627e87.4.1755560029185; Mon, 18 Aug 2025
 16:33:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755499375.git.asml.silence@gmail.com> <9b6b42be0d7fb60b12203fe4f0f762e882f0d798.1755499376.git.asml.silence@gmail.com>
In-Reply-To: <9b6b42be0d7fb60b12203fe4f0f762e882f0d798.1755499376.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 18 Aug 2025 16:33:35 -0700
X-Gm-Features: Ac12FXwfrqXSKcjrhl3FF7ja5U6Np0FPNPSAiVBM9uAKgBQErhZT7EQQpCxE7UU
Message-ID: <CAHS8izO76s61JY8SMwDar=76Ech0B_xprzc1KgSDEjaAvbdDfA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 01/23] net: page_pool: sanitise allocation order
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org, 
	davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk, 
	michael.chan@broadcom.com, dtatulea@nvidia.com, ap420073@gmail.com, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 6:56=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> We're going to give more control over rx buffer sizes to user space, and
> since we can't always rely on driver validation, let's sanitise it in
> page_pool_init() as well. Note that we only need to reject over
> MAX_PAGE_ORDER allocations for normal page pools, as current memory
> providers don't need to use the buddy allocator and must check the order
> on init.
>
> Suggested-by: Stanislav Fomichev <stfomichev@gmail.com>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

I think I noticed an unrelated bug in this code and we need this fix?

```
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 343a6cac21e3..ba70569bd4b0 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -287,8 +287,10 @@ static int page_pool_init(struct page_pool *pool,
        }

        if (pool->mp_ops) {
-               if (!pool->dma_map || !pool->dma_sync)
-                       return -EOPNOTSUPP;
+               if (!pool->dma_map || !pool->dma_sync) {
+                       err =3D -EOPNOTSUPP;
+                       goto free_ptr_ring;
+               }

                if (WARN_ON(!is_kernel_rodata((unsigned long)pool->mp_ops))=
) {
                        err =3D -EFAULT;
```

I'll send a separate fix.


--
Thanks,
Mina

