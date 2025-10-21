Return-Path: <linux-kernel+bounces-862135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFCEBF481A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40F204E29C6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 03:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E2F2253B0;
	Tue, 21 Oct 2025 03:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bkEgq3vm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A5E15E5C2
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761017302; cv=none; b=ssqL0MlhKCzbvG4ctvjoi1kINhwepqvXcES5FhDcVDZgpsmybtJNIZ6IgzdfnmFNT51ntdU0HPo/9lHjkwEsLLiRMO+Z8U5e1SSFjrtcqGgBohcxBLfk0QC1VLQCChvxsO8ZP5TMweyTd3fmrdgz3cyiQIL9ZtRBX8yB6jUrJJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761017302; c=relaxed/simple;
	bh=HEGMvjk3kZR3n2oI48nE1ykXlS05o/X5C2tS0W5EHY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9JfUbnL9F5XRK+2h9l8HWwTD+e6sucP8Nm+c4lnE96Wdc70KQ/tZadOLoL5hsWVTkfmdiPb0kb0SDDnB7VvF18S64k+OLkQ4+TPjlKlxRzfOxOaFj6v47e3SoLZ0dRK/aQCyepGCBZ+vwSVsxCws1497r5rLmMhFGQCL/ZOSHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bkEgq3vm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761017299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZfZuOVwGtgd4PrNc5P78K81w85wdLxCgwPzZydRfAcg=;
	b=bkEgq3vmdaNKESiuNveNEPVu7zaOMCzgHy6zT9L1fdBVhrw+CRhqHdA68RLoPJ7vwa5NpV
	chwKs8PFIrqQIrpcJo8d2d7svyKswj3bwr7PPadfyjagtdG54S4wtALNsgkj4Y07YPc/I+
	3qp+ugeiHbiF/KPjCVhHKOIDHDS8MZ8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-3bs-Wsw-P6GiWc3e-qtZ2g-1; Mon, 20 Oct 2025 23:28:17 -0400
X-MC-Unique: 3bs-Wsw-P6GiWc3e-qtZ2g-1
X-Mimecast-MFC-AGG-ID: 3bs-Wsw-P6GiWc3e-qtZ2g_1761017296
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32eaa47c7c8so4032001a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761017296; x=1761622096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfZuOVwGtgd4PrNc5P78K81w85wdLxCgwPzZydRfAcg=;
        b=gEW1DCYxYUEGYQvO8ntaVdy6S2P7wkqtJimZ9x6jsLSsB17vMgxkWiqE0VnKz+8mXu
         uVKgX6FYfkai97wzXI6hBMFa3I22XFYhLIRczlVmNQnEA7yBffywNrao6NQYSGiCoRl7
         Ko/z8cSZ2R+m0tFr+H9zxL+oGzZl/z05fum0WJxRrXW0T6Ttg7BQMaSlXUkJfd68ihzX
         T9Kw55caG1c7SkChoSfMdHEwfgC0z0pkziRi5df0180/k9J10ktJcsgix55r7aJcDoMp
         kXuPjNC3F7GoCDa1VHOVUpl66JVDr7xGZ7ClLQiJjU7nDnDFKfBY0e5r92lyIO74qsBf
         FluA==
X-Forwarded-Encrypted: i=1; AJvYcCWaBRq9ndZwaXA+3uBl/Tk1GN88goR4eFCDufmXk8rsFcZBQBpSPjOOQWL15nyXYgYl814ek/7/PCXsP1U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ue1tx8m1/rEjLJX3Qig9B1YgIxhq0OUCho3rG4HtdOowHbvU
	QtLjSwBX5XcMWyCyiuFK2Sy0RY7Z9UMkYOTIwKtGCFNXD3LpMQ6ah/spzhD+4GuuNEt8kvC40Ub
	1nLlZQFvyrJP4ZBKT6mxSRhT2aiJv/tnh4hxrr610sM99dJZXyBK7dER+b/E6SuQeghE8iQhwmQ
	KvjAAvjE5f1Eq5TijtYUBMN1MgPO+qjXUinf0x/Qj/
X-Gm-Gg: ASbGnctQdBx5UU2FogTa3AvNYF/CkeQnouvCRBsqo64ejEZn4k/unPecU2IrkdLI4Fw
	E7/e7EALvJpNRucI70cKRHT3uZLep2BNbYeDaFfk0aTOt6dj8nCg3825muJpAhk/9DjLecVTtIm
	/wk0n5QI0+6+H7YlyR/bOGfaEKYoFMr6rR05+sQutFMAi4G2EXbgP/CZ1d
X-Received: by 2002:a17:90b:1343:b0:30a:4874:5397 with SMTP id 98e67ed59e1d1-33bcf87f454mr19765978a91.9.1761017296306;
        Mon, 20 Oct 2025 20:28:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLR5F1yTh6UvAM+yt/mmNnIaJmeG+kzrguiTm14i/ZpGaf9HFDzxjZ/spAYnGfgoj3YhSe9gJOhePaEh2MCTw=
X-Received: by 2002:a17:90b:1343:b0:30a:4874:5397 with SMTP id
 98e67ed59e1d1-33bcf87f454mr19765960a91.9.1761017295954; Mon, 20 Oct 2025
 20:28:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020071003.28834-1-jasowang@redhat.com> <20251020071003.28834-14-jasowang@redhat.com>
 <20251020063831-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251020063831-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Oct 2025 11:28:04 +0800
X-Gm-Features: AS18NWAm6h2gvngBbEyIE06hhxVZUe2ONMXwHHb5XhqRCO0vqhsDkT2dCpp_0OA
Message-ID: <CACGkMEt3OCWT635djnT8O97B7Be2Xi=2kjnMPb8u1U=_B1fKdQ@mail.gmail.com>
Subject: Re: [PATCH V8 13/19] virtio_ring: introduce virtqueue ops
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 6:41=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Oct 20, 2025 at 03:09:57PM +0800, Jason Wang wrote:
> > @@ -2782,7 +2874,8 @@ int virtqueue_resize(struct virtqueue *_vq, u32 n=
um,
> >       if (!num)
> >               return -EINVAL;
> >
> > -     if ((vq->packed_ring ? vq->packed.vring.num : vq->split.vring.num=
) =3D=3D num)
> > +     if ((virtqueue_is_packed(vq) ? vq->packed.vring.num :
> > +                                    vq->split.vring.num) =3D=3D num)
> >               return 0;
> >
> >       err =3D virtqueue_disable_and_recycle(_vq, recycle);
>
>
> This is exactly virtqueue_get_vring_size:
>

Yes, I've switched to use virtqueue_get_vring_size() here.

Thanks


