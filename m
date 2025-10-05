Return-Path: <linux-kernel+bounces-842282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF31CBB9682
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 15:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 00EF83456A2
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 13:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3729B274B48;
	Sun,  5 Oct 2025 13:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cBhNDEyO"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0870B1D7E42
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759669487; cv=none; b=jfYUje0HvlM9vFvQR+S2wrbseEKa37mby7HrxJSrE9PJJQZFXlv6k2wOVhiWCuxBeiDQUCAEpo1H/WKuTO5VYOGkvr2tBkXNr6ttzW94aHYQICUFJsXLHCuRdQ1BeO2vRPnShclCQY4f1DerIwmjPZ2yt0U7P3gZb/FXKNR/fzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759669487; c=relaxed/simple;
	bh=IBM0gXe2yx+GuSNwZdH9eUDPRt/hJimlr6GRydvgk7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IUtbBrD7QsdqzK1KQ8yudwNv+cK/r75aJeDAmVmUg5E8G8pEDNHSWKZ9fBu4xwoA6hVrTNJSfg96xCkKmVGuU4k5iRiwu2iYsI24RR9OsY53LLt7Z/TwobxIjYXZGJBZZNKao/gsalwBrZr3prpOpNqaEWdCyYAo4DmFkrpdNao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cBhNDEyO; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4da3019b6b6so37792761cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 06:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759669485; x=1760274285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+RJQKjQrFkOXYT+itRREJcbwRQ3We70gB/GA7XkcNY=;
        b=cBhNDEyOta2wB1P//4V3618rwYnhuTb0R4QwvgJncTEoyw4PKmT+swBJxGyLIjq3WC
         jqRw7wGH9qMKUDD5VLguzgxGhD8LuTLrogmSfw42yItX8zdaUPEaUtoE1bZf9EUWbewL
         pUcVpAMA85v9BzN30r+hYvY9WJLTl28IZ+TB2Vpm2nLTZLpkm0M/2e33D7/cS4Ct9eHL
         OkbU/31e5zceaIXsT+48QJ/rbRwYboUrXi2F5MJR6EeNOC/Uxb7wakHiFto+qzp3oXk0
         T+gg4mW3xBSrZvPGdp69uGFzMyQNFc0Cjf3TFsNxx5XUo7lAbMffYj+Wm0GHuNUmHEYE
         R7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759669485; x=1760274285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+RJQKjQrFkOXYT+itRREJcbwRQ3We70gB/GA7XkcNY=;
        b=Ip5p6DZu/QWiwVgVTZIzoAhjAHP67zzN4kcQxMvWUnK1A95/1u1IBbycxiTnNSHj94
         7Jg/WAoFpZHqH5+zIbT40FKpJiZSt848ZtFGrqke7gim/S706XfDnsGvDIz2YHERQhJ7
         La2+dt2a+rYWFtBOuqPx8uvkKxYWplS0KJV+8EIurV4Liyiq1RRHRQqPEmCyRFV0FsaL
         Pq36sz40ZkYnIok192x9QfYEcilt2SlxNpe2Ik3M57avuRCFU+fSowZQ1TxlrjRK09aa
         pUoaWmy2W3VisU3KJHavFXa0MxW3JJUXONQgU7CLlQUVPqzRO2F3QDSCZD479i6MHqrI
         z3FA==
X-Forwarded-Encrypted: i=1; AJvYcCXQvkLPSY2u7/TNA7fyA7bWlsqAxdVh+GAXwMef7QHIkQcx8subpJ+D+XuYE4f+d+J7l/MVFYEWk1diDZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxywDzw6nGYb2bf6J4Y/pTi/myCt6CY2rb3UDBPI5t82DQGCiVq
	mh2n4NhPbKqEBseUJj7k3Ga6ors7UIcCFGBqdtv15/3nuU1aua6NJE4pvv5WkvAAkYfCOGf+Itp
	FAFg2s/RteNGSlZwke/m5JSnjZOGCUGdZbZyfdlpQ
X-Gm-Gg: ASbGncu8O/VwFg3ur2psjECtsp8DMLCAjboNckKPuu7inUKTZHUj3TOU09wFCA1muya
	TxDIbGIf2f+rgohLwzo93tAny6LbJd1S3uduzNQb+vcx5uC8ASjLyY1Is3T+AOpV1HV+aju3pKV
	y2TzDFzCATgRQX/sS1VMLmXX1RjluEy84XjIM39Id+4OwAjYgUL7kNonZk85u1KaR1NTW8YR8cW
	hQs9A4UdLrfNKS10zTz/saG/7TML5dfdfWb8mLhPhDe2BQk
X-Google-Smtp-Source: AGHT+IGPsbMcZU+vFeo9ZAmXgvwpBCCrndDdbMORhec+3i6dz7273LfwEIxnyR+I3xhjhE1r1jbPhGJsmb1RmGw5LpA=
X-Received: by 2002:a05:622a:1885:b0:4b7:90e2:40df with SMTP id
 d75a77b69052e-4e576a44e99mr114292601cf.1.1759669484326; Sun, 05 Oct 2025
 06:04:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251005122626.26988-1-wangfushuai@baidu.com>
In-Reply-To: <20251005122626.26988-1-wangfushuai@baidu.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 5 Oct 2025 06:04:31 -0700
X-Gm-Features: AS18NWAzrupW0HYnpOxSwBwRSmRYD-ffu1xxO0-ekzBqui4Dt-9D_s306e6ZH0E
Message-ID: <CANn89iJs+Y7Ge2sbAOQSsuE6O1GbxuHbNrFxBO0fq1C3HOfxPA@mail.gmail.com>
Subject: Re: [PATCH] wireguard: allowedips: Use kfree_rcu() instead of call_rcu()
To: Fushuai Wang <wangfushuai@baidu.com>
Cc: Jason@zx2c4.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, wireguard@lists.zx2c4.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 5, 2025 at 5:26=E2=80=AFAM Fushuai Wang <wangfushuai@baidu.com>=
 wrote:
>
> Replace call_rcu() + kmem_cache_free() with kfree_rcu() to simplify
> the code and reduce function size.
>
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>

Hmm... have you compiled this patch ?

I think  all compilers would complain loudly.

> ---
>  drivers/net/wireguard/allowedips.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/wireguard/allowedips.c b/drivers/net/wireguard/a=
llowedips.c
> index 09f7fcd7da78..506f7cf0d7cf 100644
> --- a/drivers/net/wireguard/allowedips.c
> +++ b/drivers/net/wireguard/allowedips.c
> @@ -48,11 +48,6 @@ static void push_rcu(struct allowedips_node **stack,
>         }
>  }
>
> -static void node_free_rcu(struct rcu_head *rcu)
> -{
> -       kmem_cache_free(node_cache, container_of(rcu, struct allowedips_n=
ode, rcu));
> -}
> -
>  static void root_free_rcu(struct rcu_head *rcu)
>  {
>         struct allowedips_node *node, *stack[MAX_ALLOWEDIPS_DEPTH] =3D {
> @@ -271,13 +266,13 @@ static void remove_node(struct allowedips_node *nod=
e, struct mutex *lock)
>         if (free_parent)
>                 child =3D rcu_dereference_protected(parent->bit[!(node->p=
arent_bit_packed & 1)],
>                                                   lockdep_is_held(lock));
> -       call_rcu(&node->rcu, node_free_rcu);
> +       kfree_rcu(&node, rcu);

kfree_rcu(node, rcu);

>         if (!free_parent)
>                 return;
>         if (child)
>                 child->parent_bit_packed =3D parent->parent_bit_packed;
>         *(struct allowedips_node **)(parent->parent_bit_packed & ~3UL) =
=3D child;
> -       call_rcu(&parent->rcu, node_free_rcu);
> +       kfree_rcu(&parent, rcu);

kfree_rcu(parent, rcu);

>  }
>
>  static int remove(struct allowedips_node __rcu **trie, u8 bits, const u8=
 *key,
> --
> 2.36.1
>

