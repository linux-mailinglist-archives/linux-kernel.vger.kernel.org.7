Return-Path: <linux-kernel+bounces-890284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B11C3FB4A
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 015EE3BBED8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC28320CD3;
	Fri,  7 Nov 2025 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jUkZvzKt"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A8F307AC5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762514417; cv=none; b=D6Fsw6xa24lcav/wWFdBx+1FH8IM30tuRBS3ATbkTZoToPneNiYgkGQ+J4YlxNxaSP0ULmQLOTLKeqNY8ARRjQgFFwe6S9VoGHAa324BeWU82VtDlGsYroxkeeUK+QbwuOMZlc2D7gFX78ta104k4YflTs+KuyFpMVRBtWFfd9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762514417; c=relaxed/simple;
	bh=BRaK+VjCK1hNZi3/Bm25vdWhbCF3f4DmIMNp6ZePR/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pl6Gty86vVTYKjoZ36cxmSbtwxC/A8ausc5dNAV2QEz2Da3UFBsigzR9wKU7vJlWBj6of+opp8n1Sp8JN2YlGpmuoYGaBFnTuZ+FZAqwfisvN4Z+l8Jmun8K3Cq7kz6W0lswQqlpo8DfHAGiNkBrtAeImorKFLHiWEhhg/Chlqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jUkZvzKt; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ed861eb98cso7796161cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 03:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762514415; x=1763119215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCuntcHPB7jt7B/bSZdm9gqlzC6yu+GRicnaUIhJiE0=;
        b=jUkZvzKtLY+JSbhFO4QDQAGxkk4ytJCkr8KMyQ/klCNASqBvBpGxSiLm2fdHMiJCKO
         Ut+ahhOqbegytRzh+KR5nabbJRq2vR+cB3X73kbMFv+Q10e7un0CORbff6BDJdwk684P
         gWKx+ZSUDBI6680d7NmVMabEKpPAvNxb96FRI/I3EutuLavhEQGAMNeMGzydzluohZTG
         vxgnvW9dPj+MV0o+w14sN24hebsdyN2KRBmxOkxQAzZ/g+0EDS5GYnh9S4xbdunYctQe
         BC9KASBUx8/3VYjCTQ5AYZuc2ZDiaLAYBY5QIqvSBE4liwEqaOcQ/8lQvJMDx2EPOgST
         XAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762514415; x=1763119215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fCuntcHPB7jt7B/bSZdm9gqlzC6yu+GRicnaUIhJiE0=;
        b=a8hN86JwNVFASELsLJlmYpiOgawDNd1Qopb0vFqYv4IEIcIOMcFQlyu2VCh0GHa7xU
         ZvQ0Cla9jzbVrJNUoJt/wYF7Sc1sPeFjPSttv8LtPmKUGOuUJGgI0QMmTlgCdyhzOjSz
         qsJ3C1gs4KUf74Pp9BlVfig5oSGf4iPnr9yi1glVplDOg27GdAtRjVHVE+eSPuOTtrov
         jaHAn96Csbqm5RjwZ5j9aYP0eNsQ4Y5NjoFg/x3PilZv7iQFbFNKJmo9YZOU/EN2Z45x
         HWqOjHmtde+CCo3691yHtTZ4N28SeaOWUEaqbDxs4IIfmoOYAgXHqngRZXJOemRFpBbF
         rGGA==
X-Forwarded-Encrypted: i=1; AJvYcCUntp1ULzfm0D56lSEtWMktNVt3yyiwwKZt+fBfuky00vAo4avhe+u8cPMiNqlxrOexlhOQj35wUDi3eWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbSxwq8vY5jSncfHUdf2wPspPP9fCIln7D6Y/Vvbj+TrHkZYdY
	f4e4wiEWJaGBkiKEpcCnLojuuyAAlKVi3reBEcgFtpk3XOle6sM5Fwi+nWImkMO02hcBzIeeawl
	AbmWylNkGVxJmAwZo80CDKpwm+oSfRsOuRyL5fIdP
X-Gm-Gg: ASbGncuQcNyHbJeHVyJ8SOcMykHv2j4SKCBNf/rwVvwK4sKoxnV7sZUGkB4eVGh11fG
	t1DqUd+7ydGTPdwAzfZffDzOzZvKAefawn50YWA1FUjKmQcPhnb2HMLG3M2wMLlCeBf9E0M+E9Q
	mpBWKFqfet+3Qu/nT32srtOfgpl/HIuYrI/s+TS/Tjnha7F5dQWYF/iGzVRVpp2Tj5TU8jgP9PV
	Tj8/NLjD/1kv/W3B2rQPECxLVQr/fRqRRRQTzrBpOrHJmgkNnmrjwdnJFdz9XG0fDxdTFKi
X-Google-Smtp-Source: AGHT+IGC3fYMjryS9zADloir/gP2Yamma9UjG5JSmMf62xT/E/o9kWnU3HSHFswBMiaxi1WGy0axf3d/DY0sMx5XNcM=
X-Received: by 2002:ac8:5702:0:b0:4ec:f969:cabc with SMTP id
 d75a77b69052e-4ed9494e284mr28907961cf.10.1762514414438; Fri, 07 Nov 2025
 03:20:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107080117.15099-1-make24@iscas.ac.cn>
In-Reply-To: <20251107080117.15099-1-make24@iscas.ac.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Nov 2025 03:20:03 -0800
X-Gm-Features: AWmQ_bnEuaGnleUmw5tdQ2p6tHQd4r5RAkYYgVZBqY4gtBL8VHSKOH_-igWdJDQ
Message-ID: <CANn89iKswhYk4ASH0oG1YbvNsP9Yxuk4vSX5P45Tj_UY+s16VQ@mail.gmail.com>
Subject: Re: [PATCH] net: Fix error handling in netdev_register_kobject
To: Ma Ke <make24@iscas.ac.cn>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	sdf@fomichev.me, atenart@kernel.org, kuniyu@google.com, yajun.deng@linux.dev, 
	gregkh@suse.de, ebiederm@xmission.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 12:01=E2=80=AFAM Ma Ke <make24@iscas.ac.cn> wrote:
>
> After calling device_initialize(), the reference count of the device
> is set to 1. If device_add() fails or register_queue_kobjects() fails,
> the function returns without calling put_device() to release the
> initial reference, causing a memory leak of the device structure.
> Similarly, in netdev_unregister_kobject(), after calling device_del(),
> there is no call to put_device() to release the initial reference,
> leading to a memory leak. Add put_device() in the error paths of
> netdev_register_kobject() and after device_del() in
> netdev_unregister_kobject() to properly release the device references.
>
> Found by code review.
>
> Cc: stable@vger.kernel.org
> Fixes: a1b3f594dc5f ("net: Expose all network devices in a namespaces in =
sysfs")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  net/core/net-sysfs.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index ca878525ad7c..d3895f26a0c8 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -2327,6 +2327,7 @@ void netdev_unregister_kobject(struct net_device *n=
dev)
>         pm_runtime_set_memalloc_noio(dev, false);
>
>         device_del(dev);
> +       put_device(dev);

Please take a look at free_netdev()

>  }
>
>  /* Create sysfs entries for network device. */
> @@ -2357,7 +2358,7 @@ int netdev_register_kobject(struct net_device *ndev=
)
>
>         error =3D device_add(dev);
>         if (error)
> -               return error;
> +               goto out_put_device;
>
>         error =3D register_queue_kobjects(ndev);
>         if (error) {
> @@ -2367,6 +2368,10 @@ int netdev_register_kobject(struct net_device *nde=
v)
>
>         pm_runtime_set_memalloc_noio(dev, true);
>
> +       return 0;
> +
> +out_put_device:
> +       put_device(dev);
>         return error;

This seems bogus.

Was your report based on AI or some tooling ?

You would think that syzbot would have found an issue a long time ago...

