Return-Path: <linux-kernel+bounces-892345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7BBC44E58
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 05:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DA810345DA1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 04:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D074B1F03D2;
	Mon, 10 Nov 2025 04:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0W9gDAN"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A107519258E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762747772; cv=none; b=ZlQCDmsfNqSF7qlDSNYqWn8OMbCF7Rp6KoJhBCS78So4Q9BRB5eMQWMaubhH6j+yXSUwKQQ1gNtRsO6HCZ3dkz+/iMJJpZ0dAeOhOsCglhBOio/Op5+V3q5FDLOic5dhotTQAXmlyk16hgeiYQVIArWncZWZN7Zf27CLe0vGu4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762747772; c=relaxed/simple;
	bh=46Rx9SH5Rg5ic0QhzQO0dJwcUa3MieM2TeYL67V48Mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JKv+D7krHcgHXF0uMsa7/AbwE+H5Me5t/iLnLmFLSz33htL7WjWpsud7Z+fYR4lMSkzAnwdu1qkFX6hn38lR5AeuoBUzRLGWcaUr92xYgcfWMZfhzx5A6d/I2NlZuXKQ9i2MqvoYSvo0qkITbyTAkghYXqD4xZAi2cMIxWiY9EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0W9gDAN; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-87c13813464so34342036d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 20:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762747769; x=1763352569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltcm4ut0cjEoZACABj5B2s8q/LEh3AYG+rnK0SDg4bE=;
        b=J0W9gDANbLdY5IUFihEdYIxJC0QdCsU3nzZUoXvpAa5BtjHBt4FoBpr6gqoKz1K216
         62XEPp6xqRK7EWl5VTgqewgRL0RSHTF7H/CbyTmkttaekC6q921igsyeyoHIgCeNTQXx
         GWREyTjgnixSNJ1On0T2uWjnYvtdaliNPGIwJmAaJN0iQFiO+NbzqFrBgHNJVk4t4qVz
         1fCJ22AeddY5NUWQEHus5kg/9g2i44omTluop21m6ZOj+siuHc65sNLmLiatoj/t0+6C
         AJrrLrfqV3Lf0muu1ZJB9y7Uq4nm2TzDSjU4L2limuO/6xj8WbtqHjcpemNmZXz11IsM
         x4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762747769; x=1763352569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ltcm4ut0cjEoZACABj5B2s8q/LEh3AYG+rnK0SDg4bE=;
        b=vADZjDJQtnYq8AF5WWD9foqEqYF9g/Y3zKEicH2k+Y/V2qAXFYIAxoGNVoA7aMgX/a
         IiWoBSgqUa1F9arwRa9mNEvLGhhC7ucyFFD3CnLpZcFJvdvzNoA8wQGClA8IMA17s3So
         Uo3+aW184K9pGAd7kMZuQV8bDFVbw6EK3XwuPp8Nlt6u1TF3D7LGL8czB6EWpIHnW7K5
         E+6DxbSxhzKUlmDWbGdHO07o8oFYB1dvs9KjDuzDNnJUR3RnCqcUIcy7ylKcfCzM+Fdw
         LR/kgBK+gvEHHstXXhj85UgqcKDBdXcnOqXxfxnVlnmoj9h/J5Dc2xahWw3I2g8p3Tfe
         F2ng==
X-Forwarded-Encrypted: i=1; AJvYcCWOXo+eOYeRD/fUrWBBE7JGd8nmg7XdD9zPIkWp3gmqbCTFhE2b6DUlv/hCo4nDYuNOJ3FlCyZjajeMkxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6HNIM0FfqGOWKitxpU0gNEH5Xj4BQX+LlwdlaUgSLTDt7Vp39
	zo3nEHshnc1bCVPtj/ve70eT6NbwTlO+upMKNQQmYEj5mXI+p8Zc12pqRvX8q4uztkiWDH5L2z0
	4JJ0Qv40E/zQ8t+JEv9jzg3LQlGDCNCg=
X-Gm-Gg: ASbGncsWclgdumPJOczWqC5q1zS9OyZXPTx2yDHfucvR3l4YFfXKt7eVvDrTvxFKyt7
	mqDpelSs6e+V9k7s4xIotYxg7EodyBRYIdT2tqruIAZpjQZHvJVImeyeSEU1mMHgX9d4nLPHwx8
	0s99tI1zSijqglqwyKKmJ1dWNF/+Zb3JSqPGnFEEgiEgLAJv51eaF3t38krW4T2DRvx/FzgZSOQ
	erYP8+wYY/irmnkmfrgeDZJV45ZdQtZgVw2sYopxh46pG9K6a/HaVKfqg1ePJyIi67cfEtC
X-Google-Smtp-Source: AGHT+IEu/+PqWKYFVu3MILcudIOKPNzngOwgqlgcOCHPyH7yf1IAu3CiU6BGlA6JCr+VHsh4nUIYgZECQd42xwiDIJs=
X-Received: by 2002:a05:6214:c4c:b0:87c:22eb:36b9 with SMTP id
 6a1803df08f44-882385cf3aamr112107456d6.9.1762747769542; Sun, 09 Nov 2025
 20:09:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110012608.764-1-zhangjiao2@cmss.chinamobile.com>
In-Reply-To: <20251110012608.764-1-zhangjiao2@cmss.chinamobile.com>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Mon, 10 Nov 2025 12:09:18 +0800
X-Gm-Features: AWmQ_bmPvXWToy9_08z4uAB46L6duJRuKqex6NrNCPFAdzCdCba9kJm2ri7AEsg
Message-ID: <CAJhGHyDtHpJrV5L16XaGkeQAGe1=sPFRvrfN3=AfEDf=6RFniQ@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Remove unused assert_rcu_or_wq_mutex_or_pool_mutex
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Nov 10, 2025 at 9:26=E2=80=AFAM zhangjiao2
<zhangjiao2@cmss.chinamobile.com> wrote:
>
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
>
> assert_rcu_or_wq_mutex_or_pool_mutex is never referenced in the code.
> Just remove it.
>
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>  kernel/workqueue.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index c6b79b3675c3..a86889d8218b 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -539,12 +539,6 @@ static void show_one_worker_pool(struct worker_pool =
*pool);
>                          !lockdep_is_held(&wq_pool_mutex),              \
>                          "RCU or wq_pool_mutex should be held")
>
> -#define assert_rcu_or_wq_mutex_or_pool_mutex(wq)                       \
> -       RCU_LOCKDEP_WARN(!rcu_read_lock_any_held() &&                   \
> -                        !lockdep_is_held(&wq->mutex) &&                \
> -                        !lockdep_is_held(&wq_pool_mutex),              \
> -                        "RCU, wq->mutex or wq_pool_mutex should be held"=
)
> -



Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

Thanks
Lai

