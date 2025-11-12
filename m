Return-Path: <linux-kernel+bounces-897013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 459FBC51C55
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA43D1896F05
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8223C30ACFA;
	Wed, 12 Nov 2025 10:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="AdMfaWN0"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923C1308F17
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762944649; cv=none; b=aB1j6u66EqPuFnZiTZ3vxeIYRlQwPQbDpzbbV5BxWZKFrK18jIZZz3A3YgPAYbEOm0T64C63xXpCCDnQWvwdOA4yZoqkZfNce5Cnx/DO+KshK8vndZMhfHG9wt2xFfCxr6JaWUEXqmHqLwj1IVV/b6oZEUlC4bWGUpJ8qKVUFxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762944649; c=relaxed/simple;
	bh=5Z/Sel55XGLWWt0Or4aaEmOg0nRkE2Q24yyei396xO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qs90oj5UnLwFuRm1ASjUoL/EAaAgRb31AlUnT/nKAWlqcmpfSKxNuGUVbFjFWlDHaBrLVwXPxygFMyJcyFkh5V2W66dHxEy8CeaSXv6kS1KBbpMLhvjZI8VZzRX9z3cWi45CZzx/Nh5p74lJ5ZFrSzddD6MkXgoGrBmvi5GfdyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=AdMfaWN0; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3438231df5fso807622a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 02:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1762944648; x=1763549448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDt+PkPIFcOkoVGyNRXMinYtQG6IfGLG4Ne73L8xsnI=;
        b=AdMfaWN0ZjdHij6ofGKOD8OBBKiPKyuvvgTfm3jsNmNTvQ4qb4qXIBBBanbRne34hI
         NT99UrkWhkdIwSdY+953owV57Rb1Mm0Br7tNtIok59OCrB6xsxsI6zRHPvv9JT8n0YME
         XHgpG9gfl6o0D8oghrQaRVKq0SaCzejGX0pTxxJky5VO29pBf4O/vOwoLvhvLAXkBVDp
         e19cbbnw+3Byp0HAeJcTSzKLPK6sYfiy35FT0cGmIuOC5Jzj7WCooirEQ/vv6VfDM1jC
         RqCSE8fDES84x3Y4GPmzzrDgIZpgBqvkwMeyiBcX4zCsUxNrMAQVCszaGP+E9knx0pyp
         m1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762944648; x=1763549448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eDt+PkPIFcOkoVGyNRXMinYtQG6IfGLG4Ne73L8xsnI=;
        b=IUFqHHn5eMfAe9Ydc9bKYLbBPFrqHE4mzeXltjL3lqZyxJHkHcjItvOog3qnMndxfT
         XzxvnhSa42En4PrcXAhGB+pKfxOQ3HgOx/onl1l7Q03uf2TF2oNEB+29BMDCSGxt+nZ5
         vPAi/iSNDIljYY8SVoq1iYIGGjH41orGJZDJrQ2p94Mo9BAmPPTH2GGzgQFqP+6a/viI
         4tcikJ/z6wp7ZNWi0bfuk/cyMGGzEKffrFL0qfLPcIOagwpQU5dNlIk4cRqQH/0n8lcH
         r6t/O2vjO57ywrk4CV1tN1Zv//ZDwEDA14yZaGDMzvyoT5zCEnon0+MCzh/7CUjKdAhs
         BV4w==
X-Forwarded-Encrypted: i=1; AJvYcCW9Cu0XmeiX6dNohk0/sFnRjuOw2UobrwgB95r/ev9/hrcfhqbj7XcXB5pBzxaY84oeUuL+/5Vzq2fUQqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy79dyhEYS3W6r688o9R6Y5vYWhGyB6eIGvNkygztAkxYX+saci
	HNACpPMZBOlBJV8+d0fi+Gtm0Kg9aKKlWtxOCPD+QBTHQo7uvKqPa0X2K5urkv9iGzDsszPprst
	9G8VL0jAO8tIXFXA+ysRHLCUcaZHow+BLASTUy5vd
X-Gm-Gg: ASbGnctwwRKTD8eHRLtU4xXhEdM8sb7zTTWddJTYHHYaYQqnb86qKkOKOLVD1jF2Bo0
	pRsYedsOakx7DVG/0YLlQmQuW7Wo/UjUKelIF3MmTIKV90VNf+4FgK4CmJRQErIVB+gn+20mFnv
	XVv9xrx+YOrVSc0aYiDD1I8mxZ7d3BC+GMVsiXNEkjoTZf/t64ssll4MQu+Ny5tg+CKaUKJqrG0
	9oXf1PusM+1pccvTKp5Lzy+MhFw7RvobTjjPZqRUxxyWjW+ywTvYW9vlFpg8njVVvN0
X-Google-Smtp-Source: AGHT+IFd1GAEDD22DSqeZAERmGI0Yy3shnOdbYrZoI4SJAFw9T2NTCYWO4NIIVgty2SrgCXz2TzubvGJOTr/RLGjLss=
X-Received: by 2002:a17:90b:3e8d:b0:339:ec9c:b275 with SMTP id
 98e67ed59e1d1-343dde10f3emr3441534a91.6.1762944647817; Wed, 12 Nov 2025
 02:50:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112072709.73755-1-nichen@iscas.ac.cn>
In-Reply-To: <20251112072709.73755-1-nichen@iscas.ac.cn>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 12 Nov 2025 05:50:36 -0500
X-Gm-Features: AWmQ_bnhAIJldRZySXFM6YMLqOMoeHsLxRw20K50W9oAJgt68RFCpe5Bg9f-mmQ
Message-ID: <CAM0EoMnQqNwkdUec0tX4cznZk8teiPRx9iBv5Ff-MeSDASj-zQ@mail.gmail.com>
Subject: Re: [PATCH] net/sched: act_ife: convert comma to semicolon
To: Chen Ni <nichen@iscas.ac.cn>
Cc: xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 2:28=E2=80=AFAM Chen Ni <nichen@iscas.ac.cn> wrote:
>
> Replace comma between expressions with semicolons.
>
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it is seems best to use ';'
> unless ',' is intended.
>

IIRC, Simon brought this up in the review as well...

> Found by inspection.
> No functional change intended.
> Compile tested only.
>
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
>  net/sched/act_ife.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
> index 7c6975632fc2..1dfdda6c2d4c 100644
> --- a/net/sched/act_ife.c
> +++ b/net/sched/act_ife.c
> @@ -649,9 +649,9 @@ static int tcf_ife_dump(struct sk_buff *skb, struct t=
c_action *a, int bind,
>
>         memset(&opt, 0, sizeof(opt));
>
> -       opt.index =3D ife->tcf_index,
> -       opt.refcnt =3D refcount_read(&ife->tcf_refcnt) - ref,
> -       opt.bindcnt =3D atomic_read(&ife->tcf_bindcnt) - bind,
> +       opt.index =3D ife->tcf_index;
> +       opt.refcnt =3D refcount_read(&ife->tcf_refcnt) - ref;
> +       opt.bindcnt =3D atomic_read(&ife->tcf_bindcnt) - bind;
>
>         spin_lock_bh(&ife->tcf_lock);
>         opt.action =3D ife->tcf_action;
> --
> 2.25.1
>

