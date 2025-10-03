Return-Path: <linux-kernel+bounces-841463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AE9BB763C
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 17:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599A54A099A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 15:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA0F286409;
	Fri,  3 Oct 2025 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SiyIKWnk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E8A13AD05
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 15:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759506609; cv=none; b=uLJCKiUo/l33SS9pMwbVAGIqAu5CZ0wkAUWXujR8Y1UmfL/SvAJ8bWMB6E1wKUmeLKrkKsVH7SAGRATPbBsHumzlQQ+hUzFMpo3IPf2pumI5WcFCnsKY3BENb8ONJZFmyFDyzhjCOX6CdgDrSnAdKy43dl4xeaGzJ9wA2R2iPYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759506609; c=relaxed/simple;
	bh=cV4TfhjfXE8EZJJvSGDkC4PmL6N/Ry039fRuL7w1R3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dEuEoxeGr/fogKk17V4a/poI98Eb6ApMSbGyWNwkK1kyfg79MPTQpReY5nuY2CnmJy9WCn3YpFJKsZZsyQI+EEkS+5fdkMxbDBBo5s+g3uoVfa/zQXIa3bdnUp+96i9kjouSzh3UVIuYNhBO+zhomPlUOzK71kHIzEm5jcBxBIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SiyIKWnk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759506606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DRL3Z5NJj2AWqt87ZoAsmf1WQMvEr1DYK6sJkkHR1qU=;
	b=SiyIKWnkJ8qGmlmRU+cMJxG/1WwgFpaM1gMabrMGg2Hp9GdDyEeC1fzXbFKyugc9OPkxlC
	doeALQIKn0au5OwN3U2l0zWhM2C8zLnDDjYiWOCiqfBoIdxMQzpprg6Uy6vu3tMXY9yF1c
	suzWOekcGx0Wvytqn0Pi0rwmiFNjHQo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-3gKdCqG7NriLVmfTek1Pbg-1; Fri, 03 Oct 2025 11:50:05 -0400
X-MC-Unique: 3gKdCqG7NriLVmfTek1Pbg-1
X-Mimecast-MFC-AGG-ID: 3gKdCqG7NriLVmfTek1Pbg_1759506604
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6341958f08fso2294819a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 08:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759506604; x=1760111404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRL3Z5NJj2AWqt87ZoAsmf1WQMvEr1DYK6sJkkHR1qU=;
        b=GVFFH3WiPnb3wfG+ojuV/2rhksArVGf15Fb0pPuScFO1mqLUz60AYMz92iwezo9BAl
         8N4JCShIl/c38C9CatP9FdtbF2XZOTCcuN/8TBCissGu6DGoX7O7lNoQK6jLW2ngSO28
         i9byI1FRNlcFTf0dikpkSkBjSjJjKfo07GG21S4T9AWIoijieMH4PG2nWH6CmYXcigVs
         0aOf5Ai7PqAlC6x5GedQh06SRmJ475CzV/y0VRjXnyiRpWDyTGbM8mRLYELitHstA5JA
         wxZek7PtnCMrtO74Ap1HfX1gknFt/n/cmy2+Ff2g0P/Irc6hm99BKKfFcbmWZHX/FSSu
         mb/g==
X-Forwarded-Encrypted: i=1; AJvYcCWAQfJ3KHN3TlDNqlTOalWlTwsbR1TKjxrlZ1tMdPwrvmWR/yf0EmYnMq0/4zZJ3e400pzZCSsyxikUH0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxicVvtENVy0IqiLfGwR5Dt7MI9+3+pLF6hmubz2c0+ootBIXYq
	xhhJ/fNEHWNvdm5+LoNlSLGr2ACc7T3LGJ94cnW+cK7Sgw2kORS7qvbPQKmL+YoPmDNBy7J7M83
	JXvJPITxOsEOSerDbPmA1+6JLR7+WAyFRl/4hdIAVvMvE1YVby3XSopNm/9Au2OyOb71vTaKZ/T
	ZtRpk0r8VHLUYTahzc6qtt1ivmqz/TmovjM9t3vhGw
X-Gm-Gg: ASbGncvkfXFOCBGNDcgUOephKOmfj8gU8j+mTr+0TzsA4aC6xeu76BP6VQHDcGXt15s
	5rI/AHwlr0oOXfvEVAZMAHRS/UlYfH8x14R6Lj+9O150u9Q41Nj/wTFkowX0r3zeVeCrX/0+j42
	xTYS8X4/QLwBcEwOL/zIhq1Ux6vA==
X-Received: by 2002:a17:906:d54c:b0:b46:1db9:cb7c with SMTP id a640c23a62f3a-b49c3b38fc8mr436746066b.33.1759506604013;
        Fri, 03 Oct 2025 08:50:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhZyo4NySLQ8dZ1plBM7hOuO911cT7xWWqx2+yPoLtaUq12wc7irIpkBk7V80lok5R6XJSUNU7lQqWR2wYlF0=
X-Received: by 2002:a17:906:d54c:b0:b46:1db9:cb7c with SMTP id
 a640c23a62f3a-b49c3b38fc8mr436744366b.33.1759506603604; Fri, 03 Oct 2025
 08:50:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904165919.3362000-1-rrobaina@redhat.com>
In-Reply-To: <20250904165919.3362000-1-rrobaina@redhat.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Fri, 3 Oct 2025 12:49:52 -0300
X-Gm-Features: AS18NWBJitDTF82Vmv81vD7vu2njzwSCKkuzcARL_Hjf5Hwb5MQGIwiZeEOSg2U
Message-ID: <CAABTaaB7SxWZUH+VxyOwZWBi6uPERg-qkMosFA=MTst5Rbc6kw@mail.gmail.com>
Subject: Re: [PATCH v1] audit: merge loops in __audit_inode_child()
To: audit@vger.kernel.org, linux-kernel@vger.kernel.org, paul@paul-moore.com
Cc: eparis@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 1:59=E2=80=AFPM Ricardo Robaina <rrobaina@redhat.com=
> wrote:
>
> Whenever there's audit context, __audit_inode_child() gets called
> numerous times, which can lead to high latency in scenarios that
> create too many sysfs/debugfs entries at once, for instance, upon
> device_add_disk() invocation.
>
>    # uname -r
>    6.17.0-rc3+
>
>    # auditctl -a always,exit -F path=3D/tmp -k foo
>    # time insmod loop max_loop=3D1000
>    real 0m42.753s
>    user 0m0.000s
>    sys  0m42.494s
>
>    # perf record -a insmod loop max_loop=3D1000
>    # perf report --stdio |grep __audit_inode_child
>    37.95%  insmod  [kernel.kallsyms]  [k] __audit_inode_child
>
> __audit_inode_child() searches for both the parent and the child
> in two different loops that iterate over the same list. This
> process can be optimized by merging these into a single loop,
> without changing the function behavior or affecting the code's
> readability.
>
> This patch merges the two loops that walk through the list
> context->names_list into a single loop. This optimization resulted
> in around 54% performance enhancement for the benchmark.
>
>    # uname -r
>    6.17.0-rc3+-enhanced
>
>    # auditctl -a always,exit -F path=3D/tmp -k foo
>    # time insmod loop max_loop=3D1000
>    real 0m19.388s
>    user 0m0.000s
>    sys  0m19.149s
>
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
>  kernel/auditsc.c | 40 ++++++++++++++++++----------------------
>  1 file changed, 18 insertions(+), 22 deletions(-)
>
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index eb98cd6fe91f..7abfb68687fb 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2437,44 +2437,40 @@ void __audit_inode_child(struct inode *parent,
>         if (inode)
>                 handle_one(inode);
>
> -       /* look for a parent entry first */
>         list_for_each_entry(n, &context->names_list, list) {
> -               if (!n->name ||
> -                   (n->type !=3D AUDIT_TYPE_PARENT &&
> -                    n->type !=3D AUDIT_TYPE_UNKNOWN))
> +               /* can only match entries that have a name */
> +               if (!n->name)
>                         continue;
>
> -               if (n->ino =3D=3D parent->i_ino && n->dev =3D=3D parent->=
i_sb->s_dev &&
> -                   !audit_compare_dname_path(dname,
> -                                             n->name->name, n->name_len)=
) {
> +               /* look for a parent entry first */
> +               if (!found_parent &&
> +                   (n->type =3D=3D AUDIT_TYPE_PARENT || n->type =3D=3D A=
UDIT_TYPE_UNKNOWN) &&
> +                   (n->ino =3D=3D parent->i_ino && n->dev =3D=3D parent-=
>i_sb->s_dev &&
> +                    !audit_compare_dname_path(dname, n->name->name, n->n=
ame_len))) {
>                         if (n->type =3D=3D AUDIT_TYPE_UNKNOWN)
>                                 n->type =3D AUDIT_TYPE_PARENT;
>                         found_parent =3D n;
> -                       break;
>                 }
> -       }
>
> -       cond_resched();
> -
> -       /* is there a matching child entry? */
> -       list_for_each_entry(n, &context->names_list, list) {
> -               /* can only match entries that have a name */
> -               if (!n->name ||
> -                   (n->type !=3D type && n->type !=3D AUDIT_TYPE_UNKNOWN=
))
> -                       continue;
> -
> -               if (!strcmp(dname->name, n->name->name) ||
> -                   !audit_compare_dname_path(dname, n->name->name,
> +               /* is there a matching child entry? */
> +               if (!found_child &&
> +                   (n->type =3D=3D type || n->type =3D=3D AUDIT_TYPE_UNK=
NOWN) &&
> +                   (!strcmp(dname->name, n->name->name) ||
> +                    !audit_compare_dname_path(dname, n->name->name,
>                                                 found_parent ?
>                                                 found_parent->name_len :
> -                                               AUDIT_NAME_FULL)) {
> +                                               AUDIT_NAME_FULL))) {
>                         if (n->type =3D=3D AUDIT_TYPE_UNKNOWN)
>                                 n->type =3D type;
>                         found_child =3D n;
> -                       break;
>                 }
> +
> +               if (found_parent && found_child)
> +                       break;
>         }
>
> +       cond_resched();
> +
>         if (!found_parent) {
>                 /* create a new, "anonymous" parent record */
>                 n =3D audit_alloc_name(context, AUDIT_TYPE_PARENT);
> --
> 2.51.0
>
Hi Paul,

I=E2=80=99m curious if you have any thoughts on this one.
Please disregard this email if it=E2=80=99s already in your to-do list. It=
=E2=80=99s
not my intention to rush you in any way.


