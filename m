Return-Path: <linux-kernel+bounces-824112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E2FB8825F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44EE15207C8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70B42D0274;
	Fri, 19 Sep 2025 07:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SLqTpl8P"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3676A2D0615
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758266751; cv=none; b=l/eYg+2qr1pl9Wxw6WWHCBBM6a6r5M0vJm/JFe0f++NLnR3BR43lWn8AJTnAj1xdlXx9pMZWNIpH09c6njJ0Xf0ov3ReQJDv+j3x5mQ3mLQ6YfqoNz5BFwHz/Wwtneu6WEhT6BJAILAaJF2Zg3/KpskRElvrZM/3X/le5igaNx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758266751; c=relaxed/simple;
	bh=zkVkIoUOl03T+4kpYux31FAUF2pWUEphOE/XLbf//wU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HCrEHDRedvDy+AHswwjysKzpvQYrvLry//5AUPpsBeEsStDG63qSQfdsEVmA18U0RiMXt+iJGiBj54TOHABer5y3W/ukqib3dCra5yhZ11QLzspOqYJkq/JJ9+ZDC0frHH8rnLoLgV3iK+WiKQb6kcurSTjFfADJU8F8BPJDf0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SLqTpl8P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758266747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6bM94/nnEI8nwvokemjQlvg6Nu4kwWN6AkIyeAjLPwg=;
	b=SLqTpl8PZ5Obw38PQe4Roo5NfFT7ET+y5FMAOIjQr9qAqgLz2DJsnHG4L3m7ZAWGw1qzpf
	UHwEOdq8J7o56OIkMN0LBZ+CqthE2kJnvr9ZMqiIU78iqUW4GHXoHMkkmk0W+4uGhhUI6t
	KOwObpwdxrcKEFEndUmThJbIE8W9zKM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-KUE3QosqPziYd0MZ3b0J5Q-1; Fri, 19 Sep 2025 03:25:45 -0400
X-MC-Unique: KUE3QosqPziYd0MZ3b0J5Q-1
X-Mimecast-MFC-AGG-ID: KUE3QosqPziYd0MZ3b0J5Q_1758266744
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-329c76f70cbso1558064a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758266744; x=1758871544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6bM94/nnEI8nwvokemjQlvg6Nu4kwWN6AkIyeAjLPwg=;
        b=NFySNb0nqU6UwuXLo5qA/ah5YKuSCuOQmcoqNliMK1fVcwr4qa7bkgg5B3W+CmQ0Uv
         qxr5oEOSvEsW/uz0Uz38CwnE/rPa/03INHBDkMv+++KPBqa+UsCA3PhL1KEuwcI8OH0S
         9yA4abDElb8pRI1Q6P7hMCyPp4eSmSb2Pgyenj09CAoauW/yXIfjrwXwn7WNW0IaPbc3
         KYYZYMT0zLsshd8d/tzFewe2fWLpDUAOxazrjgF0S5YhYBo1EWoyFkODOwacfwDfliel
         cOHdf9725iomJhPexjBhyPyKJhUZb8YCXKwDSHsxfrSvxI1lPr7uSLAnGKd5J+coSU1K
         Bt2w==
X-Forwarded-Encrypted: i=1; AJvYcCX2U6A4jghER1qCc4jVCxZ1NqN39e/rXNHzFf5Tmi0Tzwcqwehzy50aiveEfwPjb7fILMvVXX8crPb+/Ts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4QeWSeFimXFuB6rPKRqB97+hPZpyZiQOB5kSPcJnMyZlhWusU
	HnjthwZTgC9ElriyWij9KnRu0hOa75+2vXAIM/KcHk5bKB8OcPUI6tvJoM9+x9SKm14mSgshztV
	YbP+4pnm6gI2VrYTPq7BkX+o+Ul8M/ewZXolSFY2aek6GbC7rG4Q1x9O4twUBFPVUTuKyZFhFG4
	yz6Hzh9OzO6ICjYEkxBoCWARcHJJFk37oQv7RVSnms
X-Gm-Gg: ASbGnctmv8k9eHdDsEH9lGjHo1AGzZK5S+vvDt8mSGnm06wxRpwGNo29a+hEXoHrYL9
	wYI1SzGkfM/PK2rESbonhut4D4rtY3BRlR2MY0c0qC9tMnKFF3CVHYQmYU26C3H8pbZ75qA6A6I
	nyoZvc4YrxMwb+sfvL1/MOvQ==
X-Received: by 2002:a17:90b:4d:b0:321:9366:5865 with SMTP id 98e67ed59e1d1-3309838e07dmr3146557a91.33.1758266744226;
        Fri, 19 Sep 2025 00:25:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHioX/aUb/kf3X7YbtUfx1ZTiAhYMo4GyJt6XgUNBRLxjMQjBMLN0ziU1pYTAvo5cwkJNciXxXsSL6B3HEhWEE=
X-Received: by 2002:a17:90b:4d:b0:321:9366:5865 with SMTP id
 98e67ed59e1d1-3309838e07dmr3146523a91.33.1758266743790; Fri, 19 Sep 2025
 00:25:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917063045.2042-1-jasowang@redhat.com> <20250918105037-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250918105037-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 19 Sep 2025 15:25:32 +0800
X-Gm-Features: AS18NWCuouHf_lzYXemPvsvzosa6Qbb26dhl00LIb1AvW_Yc0kDUxptSh5xarsQ
Message-ID: <CACGkMEsUb0sXqt8yRwnNfhgmqWKm1nkMNYfgxSgz-5CtE3CSUA@mail.gmail.com>
Subject: Re: [PATCH vhost 1/3] vhost-net: unbreak busy polling
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: eperezma@redhat.com, jonah.palmer@oracle.com, kuba@kernel.org, 
	jon@nutanix.com, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 10:52=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Wed, Sep 17, 2025 at 02:30:43PM +0800, Jason Wang wrote:
> > Commit 67a873df0c41 ("vhost: basic in order support") pass the number
> > of used elem to vhost_net_rx_peek_head_len() to make sure it can
> > signal the used correctly before trying to do busy polling. But it
> > forgets to clear the count, this would cause the count run out of sync
> > with handle_rx() and break the busy polling.
> >
> > Fixing this by passing the pointer of the count and clearing it after
> > the signaling the used.
> >
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > Cc: stable@vger.kernel.org
> > Fixes: 67a873df0c41 ("vhost: basic in order support")
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> I queued this but no promises this gets into this release - depending
> on whether there is another rc or no. I had the console revert which
> I wanted in this release and don't want it to be held up.
>

I see.

> for the future, I expect either a cover letter explaining
> what unites the patchset, or just separate patches.

Ok.

Thanks

>
> > ---
> >  drivers/vhost/net.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > index c6508fe0d5c8..16e39f3ab956 100644
> > --- a/drivers/vhost/net.c
> > +++ b/drivers/vhost/net.c
> > @@ -1014,7 +1014,7 @@ static int peek_head_len(struct vhost_net_virtque=
ue *rvq, struct sock *sk)
> >  }
> >
> >  static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct so=
ck *sk,
> > -                                   bool *busyloop_intr, unsigned int c=
ount)
> > +                                   bool *busyloop_intr, unsigned int *=
count)
> >  {
> >       struct vhost_net_virtqueue *rnvq =3D &net->vqs[VHOST_NET_VQ_RX];
> >       struct vhost_net_virtqueue *tnvq =3D &net->vqs[VHOST_NET_VQ_TX];
> > @@ -1024,7 +1024,8 @@ static int vhost_net_rx_peek_head_len(struct vhos=
t_net *net, struct sock *sk,
> >
> >       if (!len && rvq->busyloop_timeout) {
> >               /* Flush batched heads first */
> > -             vhost_net_signal_used(rnvq, count);
> > +             vhost_net_signal_used(rnvq, *count);
> > +             *count =3D 0;
> >               /* Both tx vq and rx socket were polled here */
> >               vhost_net_busy_poll(net, rvq, tvq, busyloop_intr, true);
> >
> > @@ -1180,7 +1181,7 @@ static void handle_rx(struct vhost_net *net)
> >
> >       do {
> >               sock_len =3D vhost_net_rx_peek_head_len(net, sock->sk,
> > -                                                   &busyloop_intr, cou=
nt);
> > +                                                   &busyloop_intr, &co=
unt);
> >               if (!sock_len)
> >                       break;
> >               sock_len +=3D sock_hlen;
> > --
> > 2.34.1
>


