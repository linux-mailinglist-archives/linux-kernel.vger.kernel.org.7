Return-Path: <linux-kernel+bounces-880535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AC6C25FA5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2437D350FFE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEFA2EE5FE;
	Fri, 31 Oct 2025 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yqJzMQ5p"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE25925B1D2
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926450; cv=none; b=ZorinQul559+9pm0DWnkcVFLv7o3FVE6Fsren8EhBPcWzXzMsbsUX7F5PaqpT7dowsvEgq8s854fp+w+iA53p+T7jZe4IbHbi5FSozf8d+iksjFxQZJTSpHvqc/HPQmHLBj2W9Yij+dZvCgRHT5pyZrUVzHKrhFbPU5SmrAlEyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926450; c=relaxed/simple;
	bh=pCxxPdDRRh3UApWWmLEtUpMj39l3HSJgue1L/1cpiZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ugn+YpJHIuMY6cMLRFZLnJ+XVfdTsgGu1seIqPUTcdTPJ7PozPK7pwJ4niL8sB5sZITU2UXGW951mrTN+ooHo46a0k851VzFnfQLiP1C0GsZsu6geMwWUZdK6sqI6kUcdym6yVqnC05UuwMqhfykQj2frUHOZFcfuTgWCRuQ2UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yqJzMQ5p; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4e89c433c00so26398031cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761926446; x=1762531246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cPv+ZtYOpvyN6A/TpJiIitA+nx9zRwd9fZ+xiLGis4=;
        b=yqJzMQ5p9RiUpywJ0FO2ETcjs18XM6jGmmhu0cW+M+2khzuGCKt9J++6gY2aCRdxIN
         zEQYJtSkym8IP1WEWhVgUYyqb+m6CMZwYCZIz4fllxlxezodpdUSTGI6rdQqj6QQxy3y
         Gs+7DPO0Nx6J1/dUE9MxJZz6vJ34WolMgFnIa044tKPWnoh60j7K73+05JwM8CTj/bpF
         6XtgMOu7Ps/yiS5N7Cm9APOrVJoaMwQEhOqNucBaS0boKUvwqCqnoBe5JVvcf7G6Ysvg
         xc/9FjwuflIpjPMiuYLS86lppy/4A/EdORSAkLOOimDjZYu87VnFw12MJw/xb6zceNyd
         tPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761926446; x=1762531246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3cPv+ZtYOpvyN6A/TpJiIitA+nx9zRwd9fZ+xiLGis4=;
        b=s/naE1h0GjZABNQ72TSVtG8+IkBIgosSq0wCnLDWQ6cObsopVQvjP/v9HftQcSRHhq
         dpX/IGJ6s0gRC4kZQp0WUKVPabVw+lxn6VbK7jWL5hQkwni1T0gUc5hO7P5bgg6mPZp6
         22rTjctdUNDvRNiSgQ6gixe/tcL1hCeQFJsWCtFpp9mHviKmZj7V/GVwHsdWEVP3euo/
         5o2eAA+rQ8gqQc6+Dn1NaIyW7C5LReRuic9FPexO1BWX7dW3XmEHZK2xw5QRXwHNYchy
         364/TF9H+9nvTdmzNuDmPkR4ogxfqH0GMvFSQDBvRtrlehyiznJxB50K/gfmc5x5Yy3G
         p4nA==
X-Forwarded-Encrypted: i=1; AJvYcCV9Q/+KcODGAdIlVuZYKfIPbD4+CcTdah+AtEMOWUnLqU519fUvkicv2JEX2lxyyDiEU9HpPiIYNfYOHng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx59uWU1F9CY5yU8hO3z1IGqHtTZ8eToseon47f/nHlPT8VO/+W
	T0jqp2yFIaumCyKTl/gTuo2YaCQwci7N7gxtls6m+9wGFeq4zsMlmdJlpBAzKyOBu5RpsZiTNuB
	9JHWyVDaVEEURWPeS799QYK3QWlVQI+dwaFBfiXVX
X-Gm-Gg: ASbGnctXeJWqqdEYpGrYz2nFxQPpGiyGTaV4PRNZpoh5b36kxcFYxgFY5hoBkDLm7xK
	Rno6t+DtaNragEa1haTNzVHfvES+w7ubwiGPJPock3cX6Ii039n5w82SzaGC99yIES7g9icxNiv
	K2xwHLmXnc9Kqsmgq1+znzkcqCTyhFLGy7+5l+EOszKBgivvCJILB+HlR9Ddn4TMghFmJMpCpfS
	wYeSVfxHG6GftPQTBHCv7PBEq40FaFRYQ0NvqT1L2AvvU1OogwrhhSk4/IBhx9BuSFgovmP
X-Google-Smtp-Source: AGHT+IFWOxlYT6RROrC0JqhyyRzS7DEYivxqHmPal0KULKcHFPVPb9C0vr6xBTr/mKr8HS58MN9kbrg+/ylb+srL4tM=
X-Received: by 2002:ac8:57c4:0:b0:4ec:f18f:45c6 with SMTP id
 d75a77b69052e-4ed310a1e26mr50863161cf.77.1761926444802; Fri, 31 Oct 2025
 09:00:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iJL3upMfHB+DsuS8Ux06fM36dbHeaU5xof5-T+Fe80tFg@mail.gmail.com>
 <20251031155558.449699-1-vnranganath.20@gmail.com>
In-Reply-To: <20251031155558.449699-1-vnranganath.20@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 Oct 2025 09:00:33 -0700
X-Gm-Features: AWmQ_bkpaSxI7pA44n96ILn6YD1i4lVymclN0quiJdYMHQzlo2P0Be9LJuGGDM4
Message-ID: <CANn89iKrhc8VYJRW+bRZ8AzaXsdq4Gem8PgFR9d7b-CVrjDr7g@mail.gmail.com>
Subject: Re: [PATCH] net: sched: act_ife: initialize struct tc_ife to fix
 KMSAN kernel-infoleak
To: Ranganath V N <vnranganath.20@gmail.com>
Cc: davem@davemloft.net, david.hunter.linux@gmail.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, khalid@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	skhan@linuxfoundation.org, 
	syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 8:56=E2=80=AFAM Ranganath V N <vnranganath.20@gmail=
.com> wrote:
>
> >> Fix a KMSAN kernel-infoleak detected  by the syzbot .
> >>
> >> [net?] KMSAN: kernel-infoleak in __skb_datagram_iter
> >>
> >> In tcf_ife_dump(), the variable 'opt' was partially initialized using =
a
> >> designatied initializer. While the padding bytes are reamined
> >> uninitialized. nla_put() copies the entire structure into a
> >> netlink message, these uninitialized bytes leaked to userspace.
> >>
> >> Initialize the structure with memset before assigning its fields
> >> to ensure all members and padding are cleared prior to beign copied.
> >>
> >> This change silences the KMSAN report and prevents potential informati=
on
> >> leaks from the kernel memory.
> >>
> >> This fix has been tested and validated by syzbot. This patch closes th=
e
> >> bug reported at the following syzkaller link and ensures no infoleak.
> >>
> >> Reported-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
> >> Closes: https://syzkaller.appspot.com/bug?extid=3D0c85cae3350b7d486aee
> >> Tested-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
> >> Fixes: ef6980b6becb ("introduce IFE action")
> >> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
> >> ---
> >> Fix a KMSAN kernel-infoleak detected  by the syzbot .
> >>
> >> [net?] KMSAN: kernel-infoleak in __skb_datagram_iter
> >>
> >> In tcf_ife_dump(), the variable 'opt' was partially initialized using =
a
> >> designatied initializer. While the padding bytes are reamined
> >> uninitialized. nla_put() copies the entire structure into a
> >> netlink message, these uninitialized bytes leaked to userspace.
> >>
> >> Initialize the structure with memset before assigning its fields
> >> to ensure all members and padding are cleared prior to beign copied.
> >> ---
> >>  net/sched/act_ife.c | 13 ++++++++-----
> >>  1 file changed, 8 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
> >> index 107c6d83dc5c..608ef6cc2224 100644
> >> --- a/net/sched/act_ife.c
> >> +++ b/net/sched/act_ife.c
> >> @@ -644,13 +644,16 @@ static int tcf_ife_dump(struct sk_buff *skb, str=
uct tc_action *a, int bind,
> >>         unsigned char *b =3D skb_tail_pointer(skb);
> >>         struct tcf_ife_info *ife =3D to_ife(a);
> >>         struct tcf_ife_params *p;
> >> -       struct tc_ife opt =3D {
> >> -               .index =3D ife->tcf_index,
> >> -               .refcnt =3D refcount_read(&ife->tcf_refcnt) - ref,
> >> -               .bindcnt =3D atomic_read(&ife->tcf_bindcnt) - bind,
> >> -       };
> >> +       struct tc_ife opt;
> >>         struct tcf_t t;
> >>
> >> +       memset(&opt, 0, sizeof(opt));
> >> +       memset(&t, 0, sizeof(t));
> >
> >Why is the second memset() needed ? Please do not add unrelated changes.
> >
> >Also I would also fix tcf_connmark_dump()
>
> Hi Eric,
> Do you want me fix tcf_connmark_dump() in this patch or new?

Send a series of two patches, thank you.

