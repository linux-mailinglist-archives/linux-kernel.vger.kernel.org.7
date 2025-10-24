Return-Path: <linux-kernel+bounces-869099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 788E1C06F33
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E81134E4D62
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC23331B818;
	Fri, 24 Oct 2025 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XFXlYyHf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929DC3254A4
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761319465; cv=none; b=QZDm+VJ3IuCO21pmMC57tpGO5pmIzHnhKgUQJcnxcMPNg5HrsZEBEHoJYQoVR6mUGb5xaAf5HeYSAqvJTwNqFhqk8ai7iTeqLy3FD7lzq/XEUzTZBb/YywB07S+HdCS6EgnS7V/Ucx0vn74apk6k83V5SDBWq0yILpObqWjRIxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761319465; c=relaxed/simple;
	bh=RFBb1ducyZwO23CYy8BcygiUt4yFTz1ipFbiPyTgMEY=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GELsp194xYc/xTCeac3j29DN68UYCoHFjFYw9Q6gdPEH5EDnl4/LlswJ/B4oM+/0J16/33BSzEq3qLXNcnkJHZZfAB+YESUC9J7AeZ0bqHRqkQEFHt5WWNlV6qv/H3tQFzOr3BmAiFB+tNmuowIPS3NnYn9roNKLnSoW0z0uT08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XFXlYyHf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761319462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FjVtib7t/WgzNVC0k9PykbycfoQ/zLvJjOdXIaNlM/s=;
	b=XFXlYyHfr9I6PlexNvDjkY7IHrJd2k9nT7ntmgqoHDSpu0wWp2ptq8htUU3I9Jl+uq1mUW
	rl+ehdwR/nQfBsNHC6yFC9ufMzaq55NJWHbNsvvSdVe6EJnaVD8D+drIV5SJjpEozyGXUj
	hgOYvuBPqjo/lKoNmTZlcPbJgfnp+p0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-3QOkjmfGOFud-KdC6nnAlA-1; Fri, 24 Oct 2025 11:24:19 -0400
X-MC-Unique: 3QOkjmfGOFud-KdC6nnAlA-1
X-Mimecast-MFC-AGG-ID: 3QOkjmfGOFud-KdC6nnAlA_1761319457
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b6d77165ce3so47674566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761319457; x=1761924257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FjVtib7t/WgzNVC0k9PykbycfoQ/zLvJjOdXIaNlM/s=;
        b=u1vqnZbCXHZR5Jk60o6krGwEyvgWZ8I4B8oNl0M2+Uz+uLYMO2BGyrU0m/Ghd8xu9l
         hEqsHjqQ2b2lXNQQgGWkGiKLUxXDOtRvjCMR9scsP//F5FeJuLyc0eBx9TG7W+Rw//jH
         aDpOnB7q7ULuUYRhSXDFs3d0PiK+cgOfJOsgtueIaXNJaLx5MvrWef58HRbabVtNPmQX
         ndZMPfZvBr6dVVCkYSpDI9d/5/GLjUp8olPo3LZpDwQwGBySyZ+3BfN8MlyhakL/7Ci3
         EVvwvR3vcl98y0xKRmej1vEibXXDgij6cz25QplDYHmgqQieC07ZpQ8r6xqfZsFpWu6q
         uLuw==
X-Forwarded-Encrypted: i=1; AJvYcCW1PA8h8GBhdP+Orpmr1H2QY08YC5ocFdqguSP0Z7HuiMyq34AJd11hEtOZ6cbsMlAHX50cbfBIdBQVZTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjBFkv+dxmSdYX8G0sJMiY4YEfENfNVU2U+UvSum1KCyChlAEf
	/DLz3ArxONo/lyX9Fl7oxMsME2F+6seEiUMg9f+sjikPVA7IQZ8jIAETb3xIaIRMjiPwDW/PmBj
	tW+Hv3OFMO2GwfXVZXZIzr2kib1PXzJ1BHF4YXp4ZWaJQvtxSr6mBnMd0xw2VUDjh5lCvBaRJ36
	9HVcWH1hLPhnMAVDFaErJ7DXmJonyWjv9baQ7ljLje
X-Gm-Gg: ASbGncuy5LCO73wLP6+FMLgnXONqt3sGL73jt/yd3DRlZxZal/w7FE11MGtgE6/IO8x
	GlZrUVd+ta+ZSIPVGIv1jTBX+Cv8ofZ3ZeYmLVPWVQiDWvSiOppxP+ueYmMvDvi389upV76JicU
	fdEiSzIQoRj9FR2GKn1RtIkJjkICVJUyk7KehlOc63DHg53/w2gx+CUB3ESw==
X-Received: by 2002:a17:907:7292:b0:b3e:babd:f257 with SMTP id a640c23a62f3a-b6d6fe03099mr279746966b.10.1761319456784;
        Fri, 24 Oct 2025 08:24:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/1ENWH3VC+l9pWoQNswSFZweiRo5vHBqsbXq0WIXySOxK5QJg70VLzxTuBj7dpz23P2JHauaIVZDe+QfaWr4=
X-Received: by 2002:a17:907:7292:b0:b3e:babd:f257 with SMTP id
 a640c23a62f3a-b6d6fe03099mr279744366b.10.1761319456350; Fri, 24 Oct 2025
 08:24:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Oct 2025 10:24:15 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Oct 2025 10:24:15 -0500
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20251023083450.1215111-1-amorenoz@redhat.com> <874irofkjv.fsf@toke.dk>
 <CANn89iL+=shdsPdkdQb=Sb1=FDn+uGsu_JXD+449=KHMabV1cQ@mail.gmail.com> <43916b1a-e6bb-407d-852c-eaa3c4652d03@6wind.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <43916b1a-e6bb-407d-852c-eaa3c4652d03@6wind.com>
Date: Fri, 24 Oct 2025 10:24:15 -0500
X-Gm-Features: AS18NWA_JFz0bPULjVUiBeCR-fKqrq5C4Hq6djhFLc1mXpmYLvOBfVJgEZn6gaY
Message-ID: <CAG=2xmOv+u=GDUt-TsJbZzOcExLWmPpSueP3CEvn3YXX5u22Rg@mail.gmail.com>
Subject: Re: [PATCH net-next] rtnetlink: honor RTEXT_FILTER_SKIP_STATS in IFLA_STATS
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: Eric Dumazet <edumazet@google.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Stanislav Fomichev <sdf@fomichev.me>, Xiao Liang <shaw.leon@gmail.com>, 
	Cong Wang <cong.wang@bytedance.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 04:59:26PM +0200, Nicolas Dichtel wrote:
>
>
> Le 24/10/2025 =C3=A0 16:35, Eric Dumazet a =C3=A9crit=C2=A0:
> > On Fri, Oct 24, 2025 at 7:20=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgense=
n <toke@redhat.com> wrote:
> >>
> >> Adrian Moreno <amorenoz@redhat.com> writes:
> >>
> >>> Gathering interface statistics can be a relatively expensive operatio=
n
> >>> on certain systems as it requires iterating over all the cpus.
> >>>
> >>> RTEXT_FILTER_SKIP_STATS was first introduced [1] to skip AF_INET6
> >>> statistics from interface dumps and it was then extended [2] to
> >>> also exclude IFLA_VF_INFO.
> >>>
> >>> The semantics of the flag does not seem to be limited to AF_INET
> >>> or VF statistics and having a way to query the interface status
> >>> (e.g: carrier, address) without retrieving its statistics seems
> >>> reasonable. So this patch extends the use RTEXT_FILTER_SKIP_STATS
> >>> to also affect IFLA_STATS.
> >>>
> >>> [1] https://lore.kernel.org/all/20150911204848.GC9687@oracle.com/
> >>> [2] https://lore.kernel.org/all/20230611105108.122586-1-gal@nvidia.co=
m/
> >>>
> >>> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> >>> ---
> >>>  net/core/rtnetlink.c | 3 ++-
> >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> >>> index 8040ff7c356e..88d52157ef1c 100644
> >>> --- a/net/core/rtnetlink.c
> >>> +++ b/net/core/rtnetlink.c
> >>> @@ -2123,7 +2123,8 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb=
,
> >>>       if (rtnl_phys_switch_id_fill(skb, dev))
> >>>               goto nla_put_failure;
> >>>
> >>> -     if (rtnl_fill_stats(skb, dev))
> >>> +     if (~ext_filter_mask & RTEXT_FILTER_SKIP_STATS &&
> >>> +         rtnl_fill_stats(skb, dev))
> >>
> >> Nit: I find this:
> >>
> >>         if (!(ext_filter_mask & RTEXT_FILTER_SKIP_STATS) &&
> >>             rtnl_fill_stats(skb, dev))
> >>
> >> more readable. It's a logical operation, so the bitwise negation is le=
ss
> >> clear IMO.
> >>
> >
> > Same for me. I guess it is copy/pasted from line 1162 (in rtnl_vfinfo_s=
ize())
> I agree. I didn't point it out because there are several occurrences in t=
his
> file (line 1599 / rtnl_fill_vfinfo()).
>

I glanced through this file and assumed it was the agreed style but
looking at other flags, RTEXT_FILTER_SKIP_STATS seems to be the
exception.

I'll change it, and also send another patch changing the style of the
other ocurrances.

Thanks.
Adri=C3=A1n


