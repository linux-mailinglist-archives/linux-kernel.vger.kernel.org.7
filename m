Return-Path: <linux-kernel+bounces-890867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 608D5C413E6
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 19:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8618A3AE7AA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 18:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC13338F20;
	Fri,  7 Nov 2025 18:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLUnu4ZV"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A942C1583
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 18:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762539223; cv=none; b=M61P3M+rlJ6zJaMtjbIdGnKmRoH9Cfg3wBfXbVD1LzaM/Z/0TWt07FeWovSqpnxaeF4sFFSJxtJU+jsNeHyGoadjA16sFywqrZNtgVi3v7zI0bv3gGPZmBYpeDUP36mnvVM1P0MSqgElirUxSEQSVxO2pJCOYRqG2XHwxnomQho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762539223; c=relaxed/simple;
	bh=9sh+7gKZnu+G9v/dh397O3r/GNLHc2HTT/eEqyQCuKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fLXpMnNxg7Ldy9yzHFe9yEjqjK2+xvlQ5zaHV1JNlgzfjGOlbfVCFBENBA5rvEpWSheDfcZkg0WbeSWDN/jmq9CGgoJK5atQ6GTTshrfhBOWHj4xvZgBFA/TYkekh6MPZLoZILD4YwSjf5M0VrkP9EmAcTsUVFVXjR60kBEtel0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLUnu4ZV; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ba507fe592dso676919a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 10:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762539222; x=1763144022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycx0Q+pL77eWatZeqNGTS924eNL4q/k8Nowo0Bt2oYw=;
        b=mLUnu4ZVoeQfGOofF+XyUCndP+C61xEy1u2DWZuMHQtkW4VwMtSuU8EfjiqMgTVSlK
         BjL8TSDdvbxdWxXSNp0wDKSJUAIT/hQl8iX8k1qTDTiHOXZu0tXZTVdX0NjV/ijWplGL
         gD0vUqXKUSpGoy/Ncvg53NhZDcwH/ZNS+osuOMqUa+/5ltce7OZFINObgB6KgxrU2+ar
         16ka1JvFWWQsn0IBE6LP6CxjmdfUk+pn7cHC2QD0L9JjI6S9T1nvFYQHHZSq3xB5xC1m
         aObqs/kojCl3mFNSB1/G612JCNkyvLb7OovNDrBD9gLVrjn3fQTRLgtCmTUbrlqDRUpo
         E3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762539222; x=1763144022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ycx0Q+pL77eWatZeqNGTS924eNL4q/k8Nowo0Bt2oYw=;
        b=J11yM63Yot372QmSXVrhlVU22OGgjDuvKlOeKj8vkYNdhoY53TT8B/s7VQrHWaRU1E
         xKfTg+H30gXPqfMQksB2Tx6mrkBieVc+hIJKKpWeaT15MB8xBCKXGLRO3bJdG4CIXjaq
         DGel1bvKcpSaqnlGJt5sx8UxvcZTkJgEIMCAxFF/egxl89pu2WG5a+HUOdoi19LTYwT7
         MTzf/SinlXpW8FNmpu7lDzmcN2JEukvUJiKvel39A8b8UiIvZ/x+9eF840teikYxcD5i
         FXNB+VYgWagV6Op8nI3et1RCZ0Rmq70euXaus+MgWHYPOg/p4tQvQV9UyDQAulnbfU0r
         ietg==
X-Forwarded-Encrypted: i=1; AJvYcCVGnKxeDnpTfaaPCKUJlfO/Qn6kOhBliw5FmhY7lrNwfJJsMIvIJu8FxdmXwoOag0L/YiiFjydRtjpqfjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQo5njq1BmOeBywklJr8x+zgEHpheUfvnV2SUzLgut/mXuKLdu
	ZODor7FCF5mYSJinxI9hnMAubxkb3/y4lBgfEXscoQktrRN3vx0v0bcutzd04a6j/7xjSKINZGr
	G6pCX6CIHAQbhUq/j+s2PlRz+AULSaOE=
X-Gm-Gg: ASbGncth5fr9T7EckA5ZWHrETTO3tx9eU2t0sXOvltbBYD05FBubSmzW+jznIbTGgJt
	vdbZ9MCNYf0oqvsfW0rYh3KQCek0LBnnq0PbXl2jShPiXiwW7U/DhU1HhV8re+gf8OwrnhneV/G
	3K7Hx/RxzjUP/sBpGNkiSYa+aJaYYL06n7Fz/v4Vm/OTZ4GQrM1x9ML0oTOcCpzXTsiOyY2j3EC
	mUd5pEjNs9adcHgZVk5Gu235S+s3aKvbWJ1YiGqWvdVlg0ayml9YFZqaqPJ
X-Google-Smtp-Source: AGHT+IFFUFeKNH7UjQgWxAMlS+k/djxBAsHPA9H+ubZBXi3ipyMUElpaci6boohgp6n9bbHug0ab1/fv2/9Hl1zSYE0=
X-Received: by 2002:a17:902:d485:b0:295:7b8c:6622 with SMTP id
 d9443c01a7336-297e5412e9emr643855ad.11.1762539221759; Fri, 07 Nov 2025
 10:13:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107041002.2091584-1-kriish.sharma2006@gmail.com> <20251107153733.GA1859178@ziepe.ca>
In-Reply-To: <20251107153733.GA1859178@ziepe.ca>
From: Kriish Sharma <kriish.sharma2006@gmail.com>
Date: Fri, 7 Nov 2025 23:43:30 +0530
X-Gm-Features: AWmQ_bkYmNN1Ow00_1J_Au4KiZUVKCYmWRJkOuHhbjGjJ9ysQoELaf0ZI9PBhdY
Message-ID: <CAL4kbRMM=dt_PUUjJKwE5QJVLTJONGBSntg_b0vDbbgxpBoiDg@mail.gmail.com>
Subject: Re: [PATCH] RDMA/core: Fix uninitialized gid in ib_nl_process_good_ip_rsep()
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>, Vlad Dumitrescu <vdumitrescu@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Edward Srouji <edwards@nvidia.com>, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jason,

Thanks for the insight. I=E2=80=99ll dig deeper into the handling inside
ib_nl_is_good_ip_resp() and follow up with an updated analysis or
patch.

Regards,
Kriish

On Fri, Nov 7, 2025 at 9:07=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Fri, Nov 07, 2025 at 04:10:02AM +0000, Kriish Sharma wrote:
> > KMSAN reported a use of uninitialized memory in hex_byte_pack()
> > via ip6_string() when printing %pI6 from ib_nl_handle_ip_res_resp().
> > If the LS_NLA_TYPE_DGID attribute is missing, 'gid' remains
> > uninitialized before being used in pr_info(), leading to a
> > KMSAN uninit-value report.
> >
> > Reported-by: syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D938fcd548c303fe33c1a
> > Fixes: ae43f8286730 ("IB/core: Add IP to GID netlink offload")
> > Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
> > ---
> >  drivers/infiniband/core/addr.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/a=
ddr.c
> > index 61596cda2b65..4c602fcae12f 100644
> > --- a/drivers/infiniband/core/addr.c
> > +++ b/drivers/infiniband/core/addr.c
> > @@ -99,7 +99,7 @@ static inline bool ib_nl_is_good_ip_resp(const struct=
 nlmsghdr *nlh)
> >  static void ib_nl_process_good_ip_rsep(const struct nlmsghdr *nlh)
> >  {
> >       const struct nlattr *head, *curr;
> > -     union ib_gid gid;
> > +     union ib_gid gid =3D {};
> >       struct addr_req *req;
> >       int len, rem;
> >       int found =3D 0;
>
> This doesn't seem right.
>
> We have this as the only caller:
>
>         if (ib_nl_is_good_ip_resp(nlh))
>                 ib_nl_process_good_ip_rsep(nlh);
>
> And ib_nl_is_good_ip_resp() does:
>
>         ret =3D nla_parse_deprecated(tb, LS_NLA_TYPE_MAX - 1, nlmsg_data(=
nlh),
>                                    nlmsg_len(nlh), ib_nl_addr_policy,
>                                    NULL);
>
> static const struct nla_policy ib_nl_addr_policy[LS_NLA_TYPE_MAX] =3D {
>         [LS_NLA_TYPE_DGID] =3D {.type =3D NLA_BINARY,
>                 .len =3D sizeof(struct rdma_nla_ls_gid),
>                 .validation_type =3D NLA_VALIDATE_MIN,
>                 .min =3D sizeof(struct rdma_nla_ls_gid)},
> };
>
> So I expect the nla_parse_deprecated() to fail if this:
>
>         nla_for_each_attr(curr, head, len, rem) {
>                 if (curr->nla_type =3D=3D LS_NLA_TYPE_DGID)
>                         memcpy(&gid, nla_data(curr), nla_len(curr));
>         }
>
> Doesn't find a DGID.
>
> So how can gid be uninitialized?
>
> The fix to whatever this is should be in ib_nl_is_good_ip_resp().
>
> Jason

