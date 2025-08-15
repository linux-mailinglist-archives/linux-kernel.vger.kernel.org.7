Return-Path: <linux-kernel+bounces-769864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC5AB27496
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03A907A3DEA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 01:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2520115C15F;
	Fri, 15 Aug 2025 01:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G7pjIIP7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AFF23CE
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755220084; cv=none; b=RL/NybTejmcmCnFx5GQ1rh8MASxV9Ib+tta+pG5vY/WH+v5BXbf07no6BlFfO2Utcrs98eWuANT8CekjSf9UiZ3myqD5I/sCbDLpG3xCp1NcDoZrttnl5Fe2sQyM4oUsVest8rVdkcwohTpjXZFuJX0W/JFBl5TkCkx9BH3YVaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755220084; c=relaxed/simple;
	bh=A9xsVum7dE9cWbv/MJuU42/Tx4JVGra8ML3nMEneZOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4sBPArm0s54n033qrexX8wb3Y5lQJlVJ6B5oEIhP0MWJIMWQZJENKHWtHmrhIb7BQW0WAUch3OSWr9tXDxUp8CQBahxucb6U66g4tEtCE/+pFKoY4WU06tEZzL/AHujvvg6x9lHwOfrofS4Vk5Z8pJheCYR5GaoJSthyvufTmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G7pjIIP7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755220081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A9xsVum7dE9cWbv/MJuU42/Tx4JVGra8ML3nMEneZOM=;
	b=G7pjIIP7E6vhP4AwYcKm1lKtsZbto+p1PYwGssiReIqHnXwnzcIVkbJAoo4xPwuOr5kb3b
	Q0qfsVAlORXfCMsHSVhip24weuVbGFV3ESaNSslH6gRbctUNIS0WrxSPm7dtEicZN2oloE
	IYMHxEuh37BICh0vy5RJzcWcii0Wf2Q=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-NlV_MLynOEmTe_5vfcnE4A-1; Thu, 14 Aug 2025 21:07:59 -0400
X-MC-Unique: NlV_MLynOEmTe_5vfcnE4A-1
X-Mimecast-MFC-AGG-ID: NlV_MLynOEmTe_5vfcnE4A_1755220079
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32326bf571bso2674426a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 18:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755220079; x=1755824879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9xsVum7dE9cWbv/MJuU42/Tx4JVGra8ML3nMEneZOM=;
        b=te22mMI1MgxPt1wdG/Px90x2+0WRBODWhg9gN7sQsxxqkT218qszOY2wSMn3867MKv
         1u3WuMd0/bP/TA1NasP/sVHwafuGwTLKqKNhT/qehQlurRR4a6+15QLShS75wqp1JZEO
         a5ExpY4NqsOIQKTqNgrS8dz1rx9Nhl/iQbDPqQVyRJfAoeOQOkK+J8Xi0vpDuQjlqdOu
         EnK4AnFeqMT738/MeeblowQ263FYczAh9VXKSuFwosO2dpOOrVl5OesU7HfQXiIhhyfx
         k5vYIryHdRNyGup1lTNN0xszmjPR/UTRQWn6aUNp8KcZnS9uUC7YQVkByTWqiyW8BH6B
         q+gA==
X-Forwarded-Encrypted: i=1; AJvYcCWAXbRDRgpA1v2XTBNZuwZ38GYXjNwgoKro7wfkrO/SmPKZqOaKthfBy1upB49a5Y00/QhMU0n2lDqAGQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9AjdwfV6bxVQqIEqpHgcZJuqCvP13G78HyEqobcRjS2jXGy8M
	vwAQhQQXcY5ROpiOGeSa83sP6xSlo+sOlzDdmZVJhR6AIt8VyaTCJDReSi29orpK5K+UPBikix4
	Maz6cV5e+92oZz9aKJbUIs++r2qpV1+qOw3NisJfcHjwfkw7vnol3CYpMifcwLKbgejqd5ANySs
	1paNfMjcn7yIq0MmuY0r/3z2h72/AXkBNh/FDlW4RW
X-Gm-Gg: ASbGncvrEXVF3VlbSRl/OJDEXNlDcO/C8d5MOfVjSwkDCt1OpVtjWLbcPfL1m/21/UT
	8VFsyaPrKSJ/b4luJ2EerI1HJwgar/V+jaenCbR7o6VuAh67MVxEJfm1lcaohOBffjXsmN8F+3S
	2rQeOsxXZ6RACKamaN4ztxoQ==
X-Received: by 2002:a17:90b:3c10:b0:311:9c1f:8516 with SMTP id 98e67ed59e1d1-32341e213b1mr438747a91.15.1755220078797;
        Thu, 14 Aug 2025 18:07:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFftEd7ZpwZlhPeUYgWI8U5PeEZpBHT/0Rw+KUFajkX3bgGwgq+MWu5X1o7e1+IYTjAp76m3/T46kYaLuJcso=
X-Received: by 2002:a17:90b:3c10:b0:311:9c1f:8516 with SMTP id
 98e67ed59e1d1-32341e213b1mr438714a91.15.1755220078289; Thu, 14 Aug 2025
 18:07:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250814054321epcas5p1dd83614241a15c78645e7f08d5e959c3@epcas5p1.samsung.com>
 <CACGkMEs+RCx=9kun2KwMutmN4oEkxzW4KDNW=gwXNZD=gpetrg@mail.gmail.com> <20250814054333.1313117-1-junnan01.wu@samsung.com>
In-Reply-To: <20250814054333.1313117-1-junnan01.wu@samsung.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 15 Aug 2025 09:07:46 +0800
X-Gm-Features: Ac12FXyMnzmmCYkHkvMnS0G6q-NfxdLkSUe4o0bafIE3pCtKzUtrQtDJ_G_v9cU
Message-ID: <CACGkMEv2wMm_tb+mbgMFA2M2ZimVr1OBKre3nrYrBDVPpqVoiw@mail.gmail.com>
Subject: Re: [PATCH net] virtio_net: adjust the execution order of function
 `virtnet_close` during freeze
To: Junnan Wu <junnan01.wu@samsung.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	eperezma@redhat.com, kuba@kernel.org, lei19.wang@samsung.com, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, q1.huang@samsung.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com, ying123.xu@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 2:44=E2=80=AFPM Junnan Wu <junnan01.wu@samsung.com>=
 wrote:
>
> On Thu, 14 Aug 2025 12:01:18 +0800 Jason Wang wrote:
> > On Thu, Aug 14, 2025 at 10:36=E2=80=AFAM Junnan Wu <junnan01.wu@samsung=
.com> wrote:
> > >
> > > On Wed, 13 Aug 2025 17:23:07 -0700 Jakub Kicinski wrote:
> > > > Sounds like a fix people may want to backport. Could you repost wit=
h
> > > > an appropriate Fixes tag added, pointing to the earliest commit whe=
re
> > > > the problem can be observed?
> > >
> > > This issue is caused by commit "7b0411ef4aa69c9256d6a2c289d0a2b320414=
633"
> > > After this patch, during `virtnet_poll`, function `virtnet_poll_clean=
tx`
> > > will be invoked, which will wakeup tx queue and clear queue state.
> > > If you agree with it, I will repost with this Fixes tag later.
> > >
> > > Fixes: 7b0411ef4aa6 ("virtio-net: clean tx descriptors from rx napi")
> >
> > Could you please explain why it is specific to RX NAPI but not TX?
> >
> > Thanks
>
> This issue appears in suspend flow, if a TCP connection in host VM is sti=
ll
> sending packet before driver suspend is completed, it will tigger RX napi=
 schedule,
> Finally "use after free" happens when tcp ack timer is up.
>
> And in suspend flow, the action to send packet is already stopped in gues=
t VM,
> therefore TX napi will not be scheduled.

I basically mean who guarantees the TX NAPI is not scheduled?

Thanks

>


