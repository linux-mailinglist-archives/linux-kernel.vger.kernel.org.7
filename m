Return-Path: <linux-kernel+bounces-741664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF9FB0E76E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 02:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D63456649A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 00:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E462AD2C;
	Wed, 23 Jul 2025 00:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rA3QxaUB"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692081C27
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 00:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753228915; cv=none; b=mGUG+DLcdkWCi3c0hG2JJ/0mmAFnrhAMihIFe+r3zV8zF0VKx2sJNPqH0wvVPk+VYYDpdIuve9YsKZx9Azy7881QPecRr2uFJLYYTEZq/K5ffxNxU5jHr+gY01hOd5A/eeCZ7wj+8zq6r1YWJ3Xx7TTsEe4R2QuqIzQo0xudf0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753228915; c=relaxed/simple;
	bh=gPi51dK3oE0zdSbMxyoTJ2j+Kp9ZEpvTgPvxtE9gInE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UqU965OVgbLEU39zf8S5x0Y35KuXLV2e8cOb3VBaZpcV1W2CdrW66+AYW46raPYFwxTPuMkrBQXBAJe/ScqYHZ5kOFS9GdVxKahNWrry5gmoQRHw4WX1neZOdHzEidD9wiwRV8/Data3JqCiAf+g+06xZlw/k+2Hde9rDi80iy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rA3QxaUB; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-235a3dd4f0dso37458005ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 17:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753228913; x=1753833713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmW+kJOfooutx6wMAE2aHCnhV2kwpGozAvb4QhsmOeU=;
        b=rA3QxaUBvtcdG+wsrKD7uW0ONPYlrinlYCepMW+ftu1pXvhZMNqOVJoGdkhi6R5X+i
         f8bTrod5tiQrnhstd/R0765F4Oo9qda09NmHMOUmWj3qF3mqokRI8A2D9O4EUDoNU6TZ
         5gSvKUQdOS/ntIkvtQ+3ESKgHQ+XTFX3Hqllf+KgAZRZHlpDOa8lFNxtEfOPkDIzoxwC
         RahPwB9VkCMRGyW/KQ1RYs0rWzUz+9w+fED4KLhh9WsFv+aY21qOkM2n8lXjV8hQ6o0D
         COU1SF/YsIc5eF+nh5YP5xQ9MZoUubyDCQdQV0sgRWcIrERoWCoTcEB5Sd503LQ+jPEU
         0VUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753228913; x=1753833713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmW+kJOfooutx6wMAE2aHCnhV2kwpGozAvb4QhsmOeU=;
        b=nabhJ+k5JZ4x7UV71L1jbPzZH4/ah4QzloiLCRzkFQPO8NPyOqk6XK4UzPEkF6wyYt
         KKY95dZZycDgurNY1Df5sxiGYnjUIjw7lnWwJyzasmQ1aUMhjbV8pYoKo4vNOkvKeEvi
         /RH51lHfqHP6RiuLaJJwc3M95q0oNE/ecetFTIWdidX8Z6NIKGcoWEfN5cSEcoUCOIaV
         pdKvoKgJmITFVT0BGWNilJ+yzPyLa4XB67DFDj+neL31WqEViPVVtexj0HHNGAi18VXf
         VSFB6HRzsV7P30e5jKXLM/85jaQyhXoopMfrhserXwTQjXHrSOHGctx9e5k+at/BnKFD
         BLeA==
X-Forwarded-Encrypted: i=1; AJvYcCUlcXWu1iurbJHwTzm0Bh6UzZ7UoJ3a0raQw7UwWps/dFVhen0X9jbDmVigHXVeo/VIbnXr6Oe2WGiBD5g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0RYQylOg0wdtEwCkRUToNIwk9uNOPBTBnw8ClTndywTA2TgV5
	n1McP9Y1PKdajPfXtx6NhmktX4gnGCw0L0aibHjxeVW6X9mhpLFMoVcXvUqVabUPqZbDFiPVd6d
	l1pDeYEn1rc2oOwW19gKfvcrfWaI9S1y4UUBa+wtI
X-Gm-Gg: ASbGncvcmK4fA6Wvdyrj/880Snqk4o6+ajXDnV+g+ocujjI0wXP3ZTj4063/hGoWkL0
	/YuIgQbl6X2OGhhZUIhA5M5MJuumtkU3+iNko9+Fs7hq6k7Hghf35pUPV9o05Oh+FwdAaJsTWa9
	Bu5GB4cSm30xvOPtj27/d1TmQQEbQjFg20HnxKfYK45StT8YxxJtY6B076HfjeGC7x8b/LgzBFU
	cKFNbcZeHv8U0kNcCYB6BuBww7LexE8YcYC9w==
X-Google-Smtp-Source: AGHT+IEqqHZkTue9jUT8aBgzW9HXFM4b9QYOnzU5SiGbcOMqJT4zItAuhvKX5pr1J1z8bXy8wQZzWEwQMYnEb1hq4s4=
X-Received: by 2002:a17:902:c946:b0:235:779:ede5 with SMTP id
 d9443c01a7336-23f981df84emr10431745ad.40.1753228913257; Tue, 22 Jul 2025
 17:01:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1753228248-20865-1-git-send-email-haiyangz@linux.microsoft.com> <1753228248-20865-2-git-send-email-haiyangz@linux.microsoft.com>
In-Reply-To: <1753228248-20865-2-git-send-email-haiyangz@linux.microsoft.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 22 Jul 2025 17:01:41 -0700
X-Gm-Features: Ac12FXwOFltqpWqcJyOPdTDnWUTF9s30pio1HgtXH8zT888WCdTjkN8V30YF4KI
Message-ID: <CAAVpQUBuyfnv4BBxnOvheEb7JVnokTEiea5Yp4UZdX=5CuWVHg@mail.gmail.com>
Subject: Re: [PATCH net, 1/2] net: core: Fix missing init of llist_node in setup_net()
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, 
	haiyangz@microsoft.com, kys@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, andrew+netdev@lunn.ch, sd@queasysnail.net, 
	viro@zeniv.linux.org.uk, chuck.lever@oracle.com, neil@brown.name, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	davem@davemloft.net, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 4:51=E2=80=AFPM Haiyang Zhang
<haiyangz@linux.microsoft.com> wrote:
>
> From: Haiyang Zhang <haiyangz@microsoft.com>
>
> Add init_llist_node for lock-less list nodes in struct net in
> setup_net(), so we can test if a node is on a list or not.
>
> Cc: stable@vger.kernel.org
> Fixes: d6b3358a2813 ("llist: add interface to check if a node is on a lis=
t.")

No Fixes tag is needed because we didn't have a need to
test if net is queued for destruction.


> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  net/core/net_namespace.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index ae54f26709ca..2a821849558f 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -434,6 +434,9 @@ static __net_init int setup_net(struct net *net)
>         LIST_HEAD(net_exit_list);
>         int error =3D 0;
>
> +       init_llist_node(&net->defer_free_list);
> +       init_llist_node(&net->cleanup_list);
> +
>         preempt_disable();
>         net->net_cookie =3D gen_cookie_next(&net_cookie);
>         preempt_enable();
> --
> 2.34.1
>

